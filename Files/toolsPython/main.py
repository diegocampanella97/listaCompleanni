#!/usr/bin/env python3
import os
import re
import time
import argparse
import logging
import requests
from deep_translator import GoogleTranslator

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler("page_title_translator.log"),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger("PageTitleTranslator")

def find_php_files_recursively(root_dir):
    """Recursively find all PHP files in a directory."""
    php_files = []
    for dirpath, _, filenames in os.walk(root_dir):
        for filename in filenames:
            if filename.endswith('.php'):
                php_files.append(os.path.join(dirpath, filename))
    return php_files

def translate_with_deep_translator(text):
    """Translate text from English to Italian using deep_translator."""
    # Extract content after $pageTitle = 
    pattern = r'(\$pageTitle\s*=\s*[\'"])(.+?)([\'"].*)'
    match = re.match(pattern, text.strip())
    
    if not match:
        logger.debug(f"No match found in: {text}")
        return text
    
    prefix = match.group(1)  # $pageTitle = '
    content_to_translate = match.group(2)  # actual content
    suffix = match.group(3)  # ' and anything after
    
    logger.info(f"Found content to translate: '{content_to_translate}'")
    
    try:
        # Retry logic for translation
        max_retries = 5
        retry_count = 0
        
        while retry_count < max_retries:
            try:
                # Translate from English to Italian
                translator = GoogleTranslator(source='en', target='it')
                translated_text = translator.translate(content_to_translate)
                
                if translated_text:
                    logger.info(f"Translated text: '{translated_text}'")
                    # Reconstruct the line with the translated content
                    return f"{prefix}{translated_text}{suffix}"
                else:
                    raise Exception("Empty translation result")
                    
            except Exception as e:
                retry_count += 1
                logger.warning(f"Translation attempt {retry_count} failed: {e}")
                if retry_count < max_retries:
                    wait_time = 2 ** retry_count  # Exponential backoff
                    logger.info(f"Waiting {wait_time} seconds before retrying...")
                    time.sleep(wait_time)
                else:
                    raise
    
    except Exception as e:
        logger.error(f"Error during translation: {e}")
        logger.error("Translation failed multiple times. Skipping this translation.")
        return text

def process_file(file_path):
    """Process a PHP file to find and translate lines starting with $pageTitle."""
    logger.info(f"Processing file: {file_path}")
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
        
        changes_made = False
        for i, line in enumerate(lines):
            stripped_line = line.strip()
            if stripped_line.startswith('$pageTitle'):
                logger.info(f"Found $pageTitle at line {i+1} in {file_path}")
                original_line = lines[i]
                lines[i] = translate_with_deep_translator(original_line)
                
                # Log the translation for verification
                if original_line != lines[i]:
                    logger.info(f"Line changed from: '{original_line.strip()}' to '{lines[i].strip()}'")
                    changes_made = True
                else:
                    logger.debug("No translation changes were made to this line")
        
        if changes_made:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.writelines(lines)
            logger.info(f"Translated $pageTitle in: {file_path}")
        else:
            logger.debug(f"No $pageTitle found or no changes needed in: {file_path}")
        
        return changes_made
            
    except Exception as e:
        logger.error(f"Error processing file {file_path}: {e}")
        return False

def check_connectivity():
    """Check if there's internet connectivity and translation service is accessible."""
    try:
        logger.info("Checking connectivity to Google services...")
        response = requests.get("https://translate.google.com", timeout=5)
        if response.status_code >= 200 and response.status_code < 300:
            logger.info("Successfully connected to translation service.")
            return True
        else:
            logger.warning(f"Connection returned status code: {response.status_code}")
            return False
    except requests.exceptions.RequestException as e:
        logger.error(f"Connectivity check failed: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Translate $pageTitle content from English to Italian in PHP files.')
    parser.add_argument('root_dir', help='Root directory to search for PHP files')
    parser.add_argument('--debug', action='store_true', help='Enable debug logging')
    parser.add_argument('--test', help='Test with a specific string instead of processing files', default=None)
    parser.add_argument('--check-connectivity', action='store_true', help='Check connectivity to translation service before starting')
    args = parser.parse_args()
    
    if args.debug:
        logger.setLevel(logging.DEBUG)
        logger.debug("Debug logging enabled")
    
    # Check connectivity if requested
    if args.check_connectivity and not check_connectivity():
        logger.error("Connection to translation service failed. Please check your internet connection and try again.")
        return
    
    # Test mode for quick verification
    if args.test:
        logger.info(f"Test mode with string: {args.test}")
        translated = translate_with_deep_translator(args.test)
        logger.info(f"Original: {args.test}")
        logger.info(f"Translated: {translated}")
        return
    
    if not os.path.isdir(args.root_dir):
        logger.error(f"{args.root_dir} is not a valid directory.")
        return
    
    logger.info(f"Starting translation process in directory: {args.root_dir}")
    php_files = find_php_files_recursively(args.root_dir)
    logger.info(f"Found {len(php_files)} PHP files to process.")
    
    translated_count = 0
    error_count = 0
    for file_path in php_files:
        try:
            if process_file(file_path):
                translated_count += 1
        except Exception as e:
            logger.error(f"Unhandled error processing file {file_path}: {e}")
            error_count += 1
    
    logger.info(f"Translation complete. Processed {len(php_files)} PHP files, translated $pageTitle in {translated_count} files. Errors: {error_count}")

if __name__ == "__main__":
    main()
