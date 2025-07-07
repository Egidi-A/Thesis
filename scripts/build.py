#!/usr/bin/env python3
"""
Script di build per la tesi Typst
Automatizza varie operazioni di preprocessing e compilazione
"""

import os
import sys
import json
import toml
import re
import subprocess
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Set

class ThesisBuilder:
    def __init__(self):
        self.root_dir = Path(__file__).parent.parent
        self.config_dir = self.root_dir / "config"
        self.scripts_dir = self.root_dir / "scripts"
        
        # Carica configurazione parole straniere
        self.foreign_words = self.load_foreign_words()
        
    def load_foreign_words(self) -> Set[str]:
        """Carica la lista di parole straniere dal file TOML"""
        italics_file = self.scripts_dir / "italics.toml"
        if italics_file.exists():
            with open(italics_file, 'r', encoding='utf-8') as f:
                data = toml.load(f)
                words = set()
                for category in data.get('foreign_words', {}).values():
                    words.update(category)
                return words
        return set()
    
    def update_foreign_words_in_typst(self):
        """Aggiorna la lista di parole straniere nel file foreign-words.typ"""
        foreign_words_file = self.config_dir / "foreign-words.typ"
        
        if not foreign_words_file.exists():
            print(f"⚠️  File {foreign_words_file} non trovato")
            return
            
        # Leggi il contenuto attuale
        with open(foreign_words_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        # Trova l'inizio e la fine della funzione with-foreign-words
        start_idx = None
        end_idx = None
        
        for i, line in enumerate(lines):
            if "#let with-foreign-words(body)" in line:
                start_idx = i
            elif start_idx is not None and line.strip() == "body":
                end_idx = i
                break
        
        if start_idx is None or end_idx is None:
            print("⚠️  Non riesco a trovare la funzione with-foreign-words")
            return
        
        # Genera le nuove show rules
        new_rules = []
        new_rules.append("  // Definisci le regole per ogni parola\n")
        
        # Ordina le parole per categoria per una migliore organizzazione
        for word in sorted(self.foreign_words):
            new_rules.append(f'  show "{word}": foreign\n')
        
        new_rules.append("  \n")
        
        # Ricostruisci il file
        new_lines = lines[:start_idx+2] + new_rules + lines[end_idx:]
        
        # Scrivi il file aggiornato
        with open(foreign_words_file, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
            
        print(f"✅ Aggiornate {len(self.foreign_words)} parole straniere in foreign-words.typ")
    
    def process_images(self):
        """Processa e numera automaticamente le immagini"""
        images_dir = self.root_dir / "images"
        if not images_dir.exists():
            print("⚠️  Directory images non trovata")
            return
            
        # Crea un file di mapping per le immagini
        image_mapping = {}
        
        for i, img_file in enumerate(sorted(images_dir.glob("*"))):
            if img_file.suffix.lower() in ['.png', '.jpg', '.jpeg', '.svg', '.pdf']:
                image_id = f"img_{i+1:03d}"
                image_mapping[img_file.name] = {
                    "id": image_id,
                    "path": str(img_file.relative_to(self.root_dir)),
                    "caption": "",
                    "label": f"<fig:{img_file.stem}>"
                }
        
        # Salva il mapping
        mapping_file = images_dir / "image_mapping.json"
        with open(mapping_file, 'w', encoding='utf-8') as f:
            json.dump(image_mapping, f, indent=2, ensure_ascii=False)
            
        print(f"✅ Processate {len(image_mapping)} immagini")
    
    def check_references(self):
        """Controlla i riferimenti incrociati nel documento"""
        typ_files = list(self.root_dir.rglob("*.typ"))
        
        # Trova tutte le label definite
        labels = set()
        references = set()
        
        for typ_file in typ_files:
            with open(typ_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
                # Trova label (formato: <label:name>)
                labels.update(re.findall(r'<([^>]+)>', content))
                
                # Trova riferimenti (formato: @label:name o ref(label:name))
                references.update(re.findall(r'@([a-zA-Z0-9:_-]+)', content))
                references.update(re.findall(r'ref\(([^)]+)\)', content))
        
        # Trova riferimenti mancanti
        missing = references - labels
        if missing:
            print("⚠️  Riferimenti mancanti:")
            for ref in sorted(missing):
                print(f"   - {ref}")
        else:
            print("✅ Tutti i riferimenti sono validi")
    
    def generate_glossary_index(self):
        """Genera un indice del glossario dai file"""
        glossary_terms = {}
        
        # Cerca definizioni di termini in tutti i file
        typ_files = list(self.root_dir.rglob("*.typ"))
        
        for typ_file in typ_files:
            with open(typ_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
                # Trova define-term(term, definition)
                matches = re.findall(r'#define-term\("([^"]+)",\s*"([^"]+)"\)', content)
                for term, definition in matches:
                    glossary_terms[term] = definition
        
        # Salva l'indice del glossario
        glossary_file = self.config_dir / "glossary_index.json"
        with open(glossary_file, 'w', encoding='utf-8') as f:
            json.dump(glossary_terms, f, indent=2, ensure_ascii=False)
            
        print(f"✅ Trovati {len(glossary_terms)} termini nel glossario")
    
    def compile_thesis(self, watch=False):
        """Compila la tesi con Typst"""
        main_file = self.root_dir / "main.typ"
        output_file = self.root_dir / f"thesis_{datetime.now().strftime('%Y%m%d')}.pdf"
        
        if not main_file.exists():
            print(f"❌ File principale {main_file} non trovato")
            return
        
        # Costruisci il comando
        cmd = ["typst", "compile"]
        
        if watch:
            cmd.append("--watch")
            
        cmd.extend([str(main_file), str(output_file)])
        
        print(f"🔨 Compilazione tesi...")
        print(f"   Input: {main_file}")
        print(f"   Output: {output_file}")
        
        try:
            if watch:
                print("👀 Modalità watch attiva. Premi Ctrl+C per uscire.")
            
            result = subprocess.run(cmd, check=True)
            
            if not watch:
                print(f"✅ Tesi compilata con successo: {output_file}")
                print(f"📄 Dimensione file: {output_file.stat().st_size / 1024 / 1024:.2f} MB")
                
        except subprocess.CalledProcessError as e:
            print(f"❌ Errore durante la compilazione: {e}")
        except FileNotFoundError:
            print("❌ Comando 'typst' non trovato. Assicurati che Typst sia installato.")
            print("   Installazione: https://github.com/typst/typst")
    
    def validate_structure(self):
        """Valida la struttura del progetto"""
        required_dirs = ['config', 'preface', 'chapters', 'appendix', 'images', 'scripts']
        required_files = {
            'main.typ': self.root_dir,
            'metadata.typ': self.config_dir,
            'styles.typ': self.config_dir,
            'functions.typ': self.config_dir,
        }
        
        print("🔍 Validazione struttura progetto...")
        
        # Controlla directory
        for dir_name in required_dirs:
            dir_path = self.root_dir / dir_name
            if dir_path.exists():
                print(f"✅ Directory {dir_name}/ trovata")
            else:
                print(f"❌ Directory {dir_name}/ mancante")
                
        # Controlla file
        for file_name, parent_dir in required_files.items():
            file_path = parent_dir / file_name
            if file_path.exists():
                print(f"✅ File {file_name} trovato")
            else:
                print(f"❌ File {file_name} mancante in {parent_dir}")
    
    def create_backup(self):
        """Crea un backup del progetto"""
        from zipfile import ZipFile
        import shutil
        
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        backup_name = f"thesis_backup_{timestamp}.zip"
        backup_path = self.root_dir.parent / backup_name
        
        print(f"💾 Creazione backup: {backup_name}")
        
        with ZipFile(backup_path, 'w') as zipf:
            for file_path in self.root_dir.rglob('*'):
                if file_path.is_file() and not any(part.startswith('.') for part in file_path.parts):
                    arcname = file_path.relative_to(self.root_dir)
                    zipf.write(file_path, arcname)
                    
        print(f"✅ Backup creato: {backup_path}")
        print(f"   Dimensione: {backup_path.stat().st_size / 1024 / 1024:.2f} MB")
    
    def clean(self):
        """Pulisce i file temporanei"""
        patterns = ['*.aux', '*.log', '*.out', '*.toc', '*.synctex.gz', '*.fdb_latexmk', '*.fls']
        
        print("🧹 Pulizia file temporanei...")
        
        removed_count = 0
        for pattern in patterns:
            for file_path in self.root_dir.rglob(pattern):
                file_path.unlink()
                removed_count += 1
                
        print(f"✅ Rimossi {removed_count} file temporanei")
    
    def run(self, args):
        """Esegue il comando richiesto"""
        commands = {
            'build': lambda: self.compile_thesis(),
            'watch': lambda: self.compile_thesis(watch=True),
            'update-words': lambda: self.update_foreign_words_in_typst(),
            'process-images': lambda: self.process_images(),
            'check-refs': lambda: self.check_references(),
            'glossary': lambda: self.generate_glossary_index(),
            'validate': lambda: self.validate_structure(),
            'backup': lambda: self.create_backup(),
            'clean': lambda: self.clean(),
            'all': lambda: self.run_all(),
        }
        
        if not args:
            args = ['build']
            
        command = args[0]
        
        if command in commands:
            commands[command]()
        else:
            self.print_help()
    
    def run_all(self):
        """Esegue tutte le operazioni di preprocessing e poi compila"""
        print("🚀 Esecuzione completa build...")
        print("=" * 50)
        
        self.validate_structure()
        print("=" * 50)
        
        self.update_foreign_words_in_typst()
        print("=" * 50)
        
        self.process_images()
        print("=" * 50)
        
        self.generate_glossary_index()
        print("=" * 50)
        
        self.check_references()
        print("=" * 50)
        
        self.compile_thesis()
    
    def print_help(self):
        """Stampa l'help del comando"""
        help_text = """
📚 Thesis Builder - Script di build per tesi Typst

Uso: python build.py [comando]

Comandi disponibili:
  build          Compila la tesi (default)
  watch          Compila in modalità watch (ricompila automaticamente)
  update-words   Aggiorna la lista di parole straniere da italics.toml
  process-images Processa e numera le immagini
  check-refs     Controlla i riferimenti incrociati
  glossary       Genera l'indice del glossario
  validate       Valida la struttura del progetto
  backup         Crea un backup del progetto
  clean          Rimuove i file temporanei
  all            Esegue tutte le operazioni e compila
  
Esempi:
  python build.py                    # Compila la tesi
  python build.py watch              # Compila in modalità watch
  python build.py all                # Preprocessing completo e compilazione
  python build.py update-words       # Aggiorna solo le parole straniere
"""
        print(help_text)


if __name__ == "__main__":
    builder = ThesisBuilder()
    builder.run(sys.argv[1:])