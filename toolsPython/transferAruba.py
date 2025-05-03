#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import ftplib
import argparse
import tarfile
import hashlib
import json
import tempfile
import time
from pathlib import Path
import logging
import shutil

# Configurazione logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)
logger = logging.getLogger('aruba_transfer')

# Costanti
CHUNK_SIZE = 8192  # 8KB per chunk per la ripresa dei trasferimenti
MANIFEST_FILE = '.transfer_manifest.json'

def parse_arguments():
    """Analizza gli argomenti della riga di comando."""
    parser = argparse.ArgumentParser(description='Trasferimento file su hosting Aruba via FTP')
    parser.add_argument('-H', '--host', required=True, help='Host FTP Aruba')
    parser.add_argument('-u', '--username', required=True, help='Nome utente FTP')
    parser.add_argument('-p', '--password', required=True, help='Password FTP')
    parser.add_argument('-l', '--local-dir', required=True, help='Directory locale da trasferire')
    parser.add_argument('-r', '--remote-dir', default='/', help='Directory remota di destinazione')
    parser.add_argument('-v', '--verbose', action='store_true', help='Output dettagliato')
    parser.add_argument('-c', '--compress', action='store_true', help='Comprime la directory in un file tar.gz')
    parser.add_argument('-a', '--archive-name', help='Nome del file archivio (default: nome della directory locale)')
    parser.add_argument('-R', '--resume', action='store_true', help='Abilita la ripresa dei trasferimenti interrotti')
    parser.add_argument('--clean', action='store_true', help='Rimuove i file temporanei dopo il trasferimento')
    parser.add_argument('--exclude-symlinks', action='store_true', help='Esclude i collegamenti simbolici')
    parser.add_argument('--exclude-dirs', help='Elenco di directory da escludere, separate da virgola')
    parser.add_argument('--laravel', action='store_true', help='Modalità Laravel: ottimizza per applicazioni Laravel')
    return parser.parse_args()

def connect_ftp(host, username, password):
    """Stabilisce una connessione FTP con il server Aruba."""
    try:
        ftp = ftplib.FTP(host)
        ftp.login(username, password)
        logger.info(f"Connesso al server FTP: {host}")
        return ftp
    except ftplib.all_errors as e:
        logger.error(f"Errore di connessione FTP: {str(e)}")
        sys.exit(1)

def upload_file(ftp, local_file, remote_file, resume=False):
    """Carica un singolo file sul server FTP con supporto per ripresa."""
    try:
        file_size = os.path.getsize(local_file)
        
        # Controlla se il file esiste già sul server remoto e può essere ripreso
        remote_size = 0
        if resume:
            try:
                remote_size = ftp.size(remote_file)
                if remote_size == file_size:
                    logger.info(f"File già esistente: {remote_file} (Dimensione: {file_size} bytes)")
                    return True
                
                logger.info(f"Ripresa del trasferimento: {local_file} -> {remote_file} da {remote_size}/{file_size} bytes")
            except ftplib.all_errors:
                # File non esiste, si procede con caricamento normale
                remote_size = 0
        
        # Apri il file in modalità binaria
        with open(local_file, 'rb') as f:
            if remote_size > 0:
                f.seek(remote_size)
                ftp.voidcmd(f'REST {remote_size}')
                
            # Esegue il trasferimento
            ftp.storbinary(f'STOR {remote_file}', f)
            
        logger.info(f"Caricato: {local_file} -> {remote_file} ({file_size} bytes)")
        return True
    except ftplib.all_errors as e:
        logger.error(f"Errore caricamento {local_file}: {str(e)}")
        return False
    except IOError as e:
        logger.error(f"Errore lettura file {local_file}: {str(e)}")
        return False

def ensure_remote_dir(ftp, remote_dir):
    """Assicura che la directory remota esista, creandola se necessario."""
    if remote_dir == '/' or not remote_dir:
        return True
    
    dirs = remote_dir.split('/')
    current_dir = ''
    
    for d in dirs:
        if not d:
            continue
        current_dir += '/' + d
        try:
            ftp.cwd(current_dir)
        except ftplib.all_errors:
            try:
                ftp.mkd(current_dir)
                logger.info(f"Creata directory remota: {current_dir}")
            except ftplib.all_errors as e:
                logger.error(f"Impossibile creare directory remota {current_dir}: {str(e)}")
                return False
    
    # Torna alla root
    ftp.cwd('/')
    return True

def create_archive(local_dir, archive_name=None, exclude_symlinks=True, exclude_dirs=None, laravel_mode=False):
    """Crea un archivio tar.gz della directory locale."""
    if not archive_name:
        archive_name = os.path.basename(os.path.normpath(local_dir))
    
    archive_path = os.path.join(tempfile.gettempdir(), f"{archive_name}.tar.gz")
    
    logger.info(f"Creazione archivio: {archive_path} dalla directory: {local_dir}")
    
    # Prepara la lista delle directory da escludere
    excluded_dirs = []
    if exclude_dirs:
        excluded_dirs = [d.strip() for d in exclude_dirs.split(',')]
    
    # Aggiungi esclusioni standard per Laravel
    if laravel_mode:
        default_laravel_excludes = ['node_modules', 'vendor/test', 'vendor/tests', 'storage/framework/cache', 'storage/logs']
        excluded_dirs.extend(default_laravel_excludes)
    
    try:
        with tarfile.open(archive_path, "w:gz") as tar:
            # Crea una lista dei file da aggiungere, escludendo i symlinks se richiesto
            for root, dirs, files in os.walk(local_dir):
                # Filtra le directory escluse
                dirs[:] = [d for d in dirs if d not in excluded_dirs and 
                          not any(os.path.join(os.path.relpath(root, local_dir), d).startswith(excluded) for excluded in excluded_dirs)]
                
                for file in files:
                    file_path = os.path.join(root, file)
                    # Salta i collegamenti simbolici se richiesto
                    if not (exclude_symlinks and os.path.islink(file_path)):
                        arcname = os.path.relpath(file_path, os.path.dirname(local_dir))
                        tar.add(file_path, arcname=arcname)
        
        logger.info(f"Archivio creato: {archive_path} ({os.path.getsize(archive_path)} bytes)")
        return archive_path
    except Exception as e:
        logger.error(f"Errore durante la creazione dell'archivio: {str(e)}")
        return None

def generate_manifest(local_dir):
    """Genera un manifesto dei file nella directory locale con hash per verifica."""
    manifest = {}
    
    for root, _, files in os.walk(local_dir):
        for file in files:
            local_file = os.path.join(root, file)
            rel_path = os.path.relpath(local_file, local_dir)
            
            try:
                file_hash = hash_file(local_file)
                file_size = os.path.getsize(local_file)
                manifest[rel_path] = {
                    'hash': file_hash,
                    'size': file_size,
                    'transferred': False
                }
            except Exception as e:
                logger.warning(f"Impossibile calcolare hash per {local_file}: {str(e)}")
    
    return manifest

def hash_file(file_path, algorithm='md5'):
    """Calcola l'hash di un file."""
    if algorithm.lower() == 'md5':
        hasher = hashlib.md5()
    elif algorithm.lower() == 'sha1':
        hasher = hashlib.sha1()
    elif algorithm.lower() == 'sha256':
        hasher = hashlib.sha256()
    else:
        hasher = hashlib.md5()
    
    with open(file_path, 'rb') as f:
        buf = f.read(CHUNK_SIZE)
        while buf:
            hasher.update(buf)
            buf = f.read(CHUNK_SIZE)
    return hasher.hexdigest()

def save_manifest(manifest, manifest_path):
    """Salva il manifesto su disco."""
    try:
        with open(manifest_path, 'w', encoding='utf-8') as f:
            json.dump(manifest, f, indent=2)
        return True
    except Exception as e:
        logger.error(f"Errore durante il salvataggio del manifesto: {str(e)}")
        return False

def load_manifest(manifest_path):
    """Carica il manifesto da disco."""
    try:
        if not os.path.exists(manifest_path):
            return {}
        
        with open(manifest_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        logger.error(f"Errore durante il caricamento del manifesto: {str(e)}")
        return {}

def upload_directory(ftp, local_dir, remote_dir, verbose=False, resume=False):
    """Carica ricorsivamente una directory sul server FTP con supporto per ripresa."""
    local_path = Path(local_dir)
    if not local_path.exists():
        logger.error(f"La directory locale {local_dir} non esiste")
        return False
    
    # Percorso del manifesto locale
    manifest_path = os.path.join(local_dir, MANIFEST_FILE)
    
    # Genera o carica il manifesto
    if resume and os.path.exists(manifest_path):
        logger.info(f"Caricamento manifesto esistente: {manifest_path}")
        manifest = load_manifest(manifest_path)
    else:
        logger.info(f"Generazione nuovo manifesto per: {local_dir}")
        manifest = generate_manifest(local_dir)
    
    total_files = len(manifest)
    uploaded_files = sum(1 for f in manifest.values() if f.get('transferred', False))
    remaining_files = total_files - uploaded_files
    
    logger.info(f"Totale file: {total_files}, già trasferiti: {uploaded_files}, rimanenti: {remaining_files}")
    
    # Assicurati che la directory remota esista
    if not ensure_remote_dir(ftp, remote_dir):
        return False
    
    # Trasferisci i file che non sono stati ancora trasferiti
    for rel_path, file_info in manifest.items():
        if file_info.get('transferred', False):
            if verbose:
                logger.info(f"Saltato (già trasferito): {rel_path}")
            continue
        
        local_file = os.path.join(local_dir, rel_path)
        remote_file = os.path.join(remote_dir, rel_path).replace('\\', '/')
        
        # Assicurati che la directory remota per questo file esista
        remote_file_dir = os.path.dirname(remote_file).replace('\\', '/')
        ensure_remote_dir(ftp, remote_file_dir)
        
        if verbose:
            logger.info(f"Caricamento: {local_file} -> {remote_file}")
        
        if upload_file(ftp, local_file, remote_file, resume):
            manifest[rel_path]['transferred'] = True
            uploaded_files += 1
            
            # Salva il manifesto dopo ogni trasferimento riuscito
            save_manifest(manifest, manifest_path)
    
    # Rimuovi il file manifesto alla fine
    if os.path.exists(manifest_path):
        os.remove(manifest_path)
    
    logger.info(f"Trasferimento completato: {uploaded_files}/{total_files} file caricati")
    return uploaded_files == total_files

def upload_archive(ftp, archive_path, remote_dir, verbose=False, resume=False):
    """Carica un archivio sul server FTP."""
    # Assicurati che la directory remota esista
    if not ensure_remote_dir(ftp, remote_dir):
        return False
    
    # Nome file remoto
    remote_file = os.path.join(remote_dir, os.path.basename(archive_path)).replace('\\', '/')
    
    if verbose:
        logger.info(f"Caricamento archivio: {archive_path} -> {remote_file}")
    
    # Carica l'archivio
    success = upload_file(ftp, archive_path, remote_file, resume)
    
    return success

def setup_laravel_storage(ftp, remote_dir):
    """Crea il link di storage per Laravel su server remoto."""
    try:
        # Crea un file PHP per eseguire l'operazione Artisan
        php_content = """<?php
// Script per creare manualmente il link storage
$target = __DIR__.'/../storage/app/public';
$link = __DIR__.'/storage';

if (file_exists($link)) {
    echo "Il link esiste già\\n";
    exit(0);
}

if (!file_exists($target)) {
    echo "La directory target non esiste\\n";
    exit(1);
}

mkdir($link);
echo "Link creato con successo\\n";
"""
        # Crea un file temporaneo
        temp_file = tempfile.NamedTemporaryFile(delete=False, suffix='.php')
        try:
            temp_file.write(php_content.encode('utf-8'))
            temp_file.close()
            
            # Carica il file nella directory pubblica di Laravel
            remote_file = os.path.join(remote_dir, 'public', 'storage_setup.php').replace('\\', '/')
            upload_file(ftp, temp_file.name, remote_file)
            
            logger.info(f"Script di setup storage Laravel caricato: {remote_file}")
            logger.info("IMPORTANTE: Esegui questo script via browser o SSH per completare il setup della cartella storage")
            logger.info(f"URL: https://tuodominio.it/storage_setup.php")
            
        finally:
            os.unlink(temp_file.name)
        
        return True
    except Exception as e:
        logger.error(f"Errore durante il setup Laravel storage: {str(e)}")
        return False

def main():
    """Funzione principale."""
    args = parse_arguments()
    
    if args.verbose:
        logger.setLevel(logging.DEBUG)
    
    start_time = time.time()
    
    # Connessione FTP
    ftp = connect_ftp(args.host, args.username, args.password)
    
    success = False
    archive_path = None
    
    try:
        if args.compress:
            # Trasferimento con compressione
            archive_name = args.archive_name or os.path.basename(os.path.normpath(args.local_dir))
            archive_path = create_archive(args.local_dir, archive_name, 
                                         exclude_symlinks=args.exclude_symlinks or args.laravel,
                                         exclude_dirs=args.exclude_dirs,
                                         laravel_mode=args.laravel)
            
            if archive_path:
                success = upload_archive(ftp, archive_path, args.remote_dir, args.verbose, args.resume)
            else:
                logger.error("Impossibile creare l'archivio")
                success = False
        else:
            # Trasferimento senza compressione
            success = upload_directory(ftp, args.local_dir, args.remote_dir, args.verbose, args.resume)
        
        # Setup Laravel se richiesto
        if args.laravel and success:
            setup_laravel_storage(ftp, args.remote_dir)
            
    finally:
        # Chiusura connessione
        try:
            ftp.quit()
        except:
            ftp.close()
        
        # Pulizia file temporanei
        if args.clean and archive_path and os.path.exists(archive_path):
            try:
                os.remove(archive_path)
                logger.info(f"Rimosso file temporaneo: {archive_path}")
            except Exception as e:
                logger.warning(f"Impossibile rimuovere il file temporaneo {archive_path}: {str(e)}")
    
    end_time = time.time()
    duration = end_time - start_time
    
    if success:
        logger.info(f"Trasferimento completato con successo in {duration:.2f} secondi")
        return 0
    else:
        logger.warning(f"Trasferimento completato con errori in {duration:.2f} secondi")
        return 1

if __name__ == "__main__":
    sys.exit(main()) 