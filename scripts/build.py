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
        """Aggiorna la lista di parole straniere nel file functions.typ"""
        functions_file = self.config_dir / "functions.typ"
        
        if not functions_file.exists():
            print(f"⚠️  File {functions_file} non trovato")
            return
            
        # Leggi il contenuto attuale
        with open(functions_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Genera la nuova lista di parole
        words_list = ', '.join(f'"{word}"' for word in sorted(self.foreign_words))
        
        # Pattern per trovare e sostituire la definizione di foreign-words
        pattern = r'#let foreign-words = \((.*?)\)'
        replacement = f'#let foreign-words = ({words_list})'
        
        # Sostituisci nel contenuto
        new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)
        
        # Scrivi il file aggiornato
        with open(functions_file, 'w', encoding='utf-8') as f:
            f.write(new_content)
            
        print(f"✅ Aggiornate {len(self.foreign_words)} parole straniere in functions.typ")
    
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


# INCLOMPLETO