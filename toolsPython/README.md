# Script di Trasferimento FTP per Aruba

Questo script Python permette di trasferire file e cartelle su un hosting Aruba tramite protocollo FTP, con supporto per trasferimenti resilienti e compressione.

## Requisiti

- Python 3.6 o superiore
- Connessione Internet

## Installazione

Non è richiesta alcuna installazione particolare. Assicurarsi che Python sia installato sul sistema.

## Utilizzo

```bash
python transferAruba.py -H <host> -u <username> -p <password> -l <directory_locale> -r <directory_remota> [opzioni]
```

### Parametri

- `-H, --host`: Host FTP di Aruba (obbligatorio)
- `-u, --username`: Nome utente FTP (obbligatorio)
- `-p, --password`: Password FTP (obbligatorio)
- `-l, --local-dir`: Directory locale da trasferire (obbligatorio)
- `-r, --remote-dir`: Directory remota di destinazione (opzionale, default: '/')
- `-v, --verbose`: Mostra informazioni dettagliate durante il trasferimento
- `-c, --compress`: Comprime la directory in un singolo archivio tar.gz prima del trasferimento
- `-a, --archive-name`: Nome personalizzato per l'archivio (default: nome della directory locale)
- `-R, --resume`: Abilita la ripresa dei trasferimenti interrotti
- `--clean`: Rimuove i file temporanei dopo il trasferimento
- `--exclude-symlinks`: Esclude i collegamenti simbolici (importante per hosting condivisi)
- `--exclude-dirs`: Elenco di directory da escludere, separate da virgola
- `--laravel`: Modalità Laravel: ottimizza per applicazioni Laravel

## Funzionalità

### Trasferimento Resiliente

Il trasferimento resiliente consente di riprendere il trasferimento da dove si era interrotto in caso di problemi di connessione. Utilizza un file manifest per tenere traccia dei file già trasferiti e gestisce la ripresa dei singoli file parzialmente caricati.

### Compressione (tar.gz)

La modalità di compressione crea un unico archivio tar.gz della directory da trasferire, riducendo il numero di connessioni FTP necessarie e potenzialmente migliorando la velocità di trasferimento per cartelle con molti file piccoli.

### Supporto Laravel

La modalità Laravel è ottimizzata per il trasferimento di applicazioni Laravel su hosting condivisi:
- Esclude automaticamente i collegamenti simbolici problematici
- Esclude cartelle non necessarie in produzione (come node_modules)
- Carica uno script PHP per gestire il collegamento storage manualmente

## Esempi

### Trasferimento base di una cartella locale

```bash
python transferAruba.py -H ftp.tuodominio.it -u tuoutente -p tuapassword -l /percorso/locale/cartella
```

### Trasferimento con compressione

```bash
python transferAruba.py -H ftp.tuodominio.it -u tuoutente -p tuapassword -l /percorso/locale/cartella -c
```

### Trasferimento con ripresa automatica

```bash
python transferAruba.py -H ftp.tuodominio.it -u tuoutente -p tuapassword -l /percorso/locale/cartella -R
```

### Trasferimento completo (compressione + ripresa)

```bash
python transferAruba.py -H ftp.tuodominio.it -u tuoutente -p tuapassword -l /percorso/locale/cartella -c -R -v --clean
```

### Trasferimento di applicazione Laravel

```bash
python transferAruba.py -H ftp.tuodominio.it -u tuoutente -p tuapassword -l /percorso/app/laravel -r /www -c --laravel -v
```

### Esclusione di directory specifiche

```bash
python transferAruba.py -H ftp.tuodominio.it -u tuoutente -p tuapassword -l /percorso/locale/cartella -c --exclude-dirs="node_modules,vendor/tests,storage/logs"
```

## Note di Sicurezza

Attenzione: specificare la password direttamente nella linea di comando può rappresentare un rischio per la sicurezza, poiché potrebbe essere visualizzata nella cronologia dei comandi o nei log di sistema. 

Per un uso più sicuro, considera di:
1. Utilizzare variabili d'ambiente per le credenziali
2. Creare un file di configurazione protetto
3. Utilizzare un gestore di credenziali