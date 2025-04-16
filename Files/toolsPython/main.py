#!/usr/bin/env python3
import os
import re
import argparse
from openai import OpenAI

def find_files_recursively(root_dir):
    """Recursively find all files in a directory."""
    all_files = []
    for dirpath, _, filenames in os.walk(root_dir):
        for filename in filenames:
            all_files.append(os.path.join(dirpath, filename))
    return all_files

def translate_with_openai(text, api_key):
    """Translate text from English to Italian using OpenAI's GPT-4o."""
    # Extract content after $pageTitle = 
    match = re.match(r'\$pageTitle\s*=\s*[\'"](.+?)[\'"]', text)
    if not match:
        return text
    
    content_to_translate = match.group(1)
    
    client = OpenAI(api_key=api_key)
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": "You are a translator. Translate the following text from English to Italian."},
            {"role": "user", "content": content_to_translate}
        ]
    )
    
    translated_text = response.choices[0].message.content.strip()
    # Replace the original content with the translated content
    return text.replace(content_to_translate, translated_text)

def process_file(file_path, api_key):
    """Process a file to find and translate lines starting with $pageTitle."""
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
        
        changes_made = False
        for i, line in enumerate(lines):
            if line.strip().startswith('$pageTitle'):
                lines[i] = translate_with_openai(line, api_key)
                changes_made = True
        
        if changes_made:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.writelines(lines)
            print(f"Translated $pageTitle in: {file_path}")
        
        return changes_made
            
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Translate $pageTitle content from English to Italian.')
    parser.add_argument('root_dir', help='Root directory to search for files')
    parser.add_argument('--api-key', help='OpenAI API key', default=os.environ.get('OPENAI_API_KEY'))
    args = parser.parse_args()
    
    if not args.api_key:
        print("Error: OpenAI API key is required. Provide it via --api-key or set the OPENAI_API_KEY environment variable.")
        return
    
    if not os.path.isdir(args.root_dir):
        print(f"Error: {args.root_dir} is not a valid directory.")
        return
    
    files = find_files_recursively(args.root_dir)
    print(f"Found {len(files)} files to process.")
    
    translated_count = 0
    for file_path in files:
        if process_file(file_path, args.api_key):
            translated_count += 1
    
    print(f"Translation complete. Processed {len(files)} files, translated $pageTitle in {translated_count} files.")

if __name__ == "__main__":
    main()
