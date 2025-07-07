# Template Tesi Typst - Università di Padova

Template per la scrittura di tesi di laurea in Typst, basato sullo stile dell'Università degli Studi di Padova.

## 📁 Struttura del Progetto

```
thesis-template/
├── main.typ                    # File principale
├── config/                     # Configurazioni
│   ├── metadata.typ           # Metadati tesi (titolo, autore, etc.)
│   ├── styles.typ             # Stili personalizzati
│   ├── functions.typ          # Funzioni helper
│   └── glossary.typ           # Definizioni glossario
├── preface/                   # Parte introduttiva
│   ├── frontpage.typ          # Frontespizio
│   ├── dedication.typ         # Dedica
│   ├── abstract.typ           # Sommario
│   ├── acknowledgments.typ    # Ringraziamenti
│   └── toc.typ               # Indici
├── chapters/                  # Capitoli
│   ├── chapter1.typ          
│   ├── chapter2.typ          
│   ├── chapter3.typ          
│   └── chapter4.typ          
├── appendix/                  # Appendici
│   ├── acronyms.typ          # Acronimi
│   ├── glossary.typ          # Glossario
│   └── bibliography.typ      # Bibliografia
├── images/                    # Immagini
├── scripts/                   # Script di automazione
│   ├── build.py              # Script di build
│   └── italics.toml          # Configurazione parole straniere
└── bibliography.bib          # Bibliografia BibTeX
```

## 🚀 Quick Start

### Prerequisiti

1. **Typst**: Installa Typst dal [sito ufficiale](https://github.com/typst/typst)
2. **Python 3.6+**: Per gli script di automazione
3. **Pacchetti Python**: `pip install toml`

### Configurazione Iniziale

1. Modifica `config/metadata.typ` con i tuoi dati:
   ```typ
   #let thesis-title = "Il Mio Titolo"
   #let thesis-author = "Nome Cognome"
   #let thesis-matricola = "1234567"
   ```

2. Compila la tesi:
   ```bash
   python scripts/build.py
   ```

## 🛠️ Funzionalità

### Automazione Parole Straniere

Le parole straniere vengono automaticamente messe in corsivo. Per aggiungere nuove parole:

1. Modifica `scripts/italics.toml`
2. Esegui: `python scripts/build.py update-words`

### Gestione Figure e Tabelle

Usa le funzioni helper per figure e tabelle numerate:

```typ
#numbered-figure(
  image("images/diagram.png", width: 80%),
  caption: "Descrizione della figura"
) <fig:label>

#numbered-table(
  caption: "Dati sperimentali",
  columns: 3,
  [Header 1], [Header 2], [Header 3],
  [Data 1], [Data 2], [Data 3],
)
```

### Glossario e Acronimi

Definisci termini e acronimi nei capitoli:

```typ
#define-term("API", "Application Programming Interface")
#define-acronym("HTTP", "HyperText Transfer Protocol")

// Uso nel testo
Il termine #gls("API") indica...
Il protocollo #acronym("HTTP") è...
```

### Riferimenti Incrociati

Usa le funzioni helper per riferimenti consistenti:

```typ
Come mostrato in #ref-figure(<fig:diagram>)...
Vedi #ref-chapter(<cap:intro>) per dettagli...
```

## 📋 Comandi Build Script

```bash
# Compila la tesi
python scripts/build.py build

# Modalità watch (ricompila automaticamente)
python scripts/build.py watch

# Preprocessing completo + compilazione
python scripts/build.py all

# Altri comandi
python scripts/build.py update-words    # Aggiorna parole straniere
python scripts/build.py process-images  # Processa immagini
python scripts/build.py check-refs      # Controlla riferimenti
python scripts/build.py validate        # Valida struttura
python scripts/build.py backup          # Crea backup
python scripts/build.py clean           # Pulisce file temporanei
```

## 📝 Convenzioni di Scrittura

### Stile Testo

- **Grassetto**: per termini importanti alla prima occorrenza
- *Corsivo*: automatico per parole straniere (configurabile)
- `Monospace`: per codice inline

### Citazioni e Note

```typ
// Citazione con nota
Secondo Smith#footnote[Smith, J. (2023). _Titolo_. Editore.]...

// Citazione bibliografica (se usi bibliography.bib)
Come dimostrato in @smith2023...
```

### Codice

```typ
#source-code(
  ```python
  def hello():
      print("Hello World")
  ```,
  lang: "python",
  caption: "Esempio di codice Python"
)
```

## 🎨 Personalizzazione

### Modificare gli Stili

Modifica `config/styles.typ` per personalizzare:
- Font e dimensioni
- Margini e spaziature
- Colori dei link
- Stili di codice

### Aggiungere Nuovi Capitoli

1. Crea `chapters/chapter5.typ`
2. Aggiungi in `main.typ`:
   ```typ
   #include "chapters/chapter5.typ"
   ```

## 📚 Best Practices

1. **Un file per capitolo**: Mantieni ogni capitolo in un file separato
2. **Label consistenti**: Usa prefissi (`fig:`, `tab:`, `sec:`, `cap:`)
3. **Backup regolari**: Usa `python scripts/build.py backup`
4. **Validazione**: Esegui periodicamente `python scripts/build.py validate`

## 🐛 Troubleshooting

### Errore "Typst non trovato"
Assicurati che Typst sia nel PATH o specifica il percorso completo.

### Riferimenti mancanti
Esegui `python scripts/build.py check-refs` per trovare riferimenti non definiti.

### Problemi di compilazione
Controlla la console per messaggi di errore specifici di Typst.

## 📄 Licenza

Questo template è rilasciato sotto licenza MIT. Sentiti libero di usarlo e modificarlo per le tue esigenze.

## 🤝 Contributi

Contributi e suggerimenti sono benvenuti! Apri una issue o una pull request su GitHub.