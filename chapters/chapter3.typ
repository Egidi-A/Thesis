# Capitolo 3 - Sviluppo del progetto: dal parser tradizionale all'AI

Il presente capitolo documenta l'evoluzione del progetto di migrazione COBOL-Java durante il periodo di stage, illustrando il percorso che ha portato da un approccio tradizionale basato su parsing deterministico a una soluzione innovativa guidata dall'intelligenza artificiale. La narrazione segue un ordine cronologico per evidenziare come le sfide tecniche incontrate abbiano influenzato le decisioni progettuali e come l'adozione dell'AI abbia trasformato radicalmente tempi e risultati del progetto.

## 3.1 Setup iniziale e metodologia di lavoro

### 3.1.1 Implementazione della metodologia Agile

Il progetto ha adottato fin dall'inizio una metodologia Agile strutturata in sprint settimanali. Ogni settimana iniziava con una pianificazione degli obiettivi e si concludeva con una retrospettiva per valutare i risultati raggiunti. Gli stand-up giornalieri, condotti virtualmente attraverso la piattaforma aziendale, permettevano di sincronizzare il lavoro con il team e identificare tempestivamente eventuali impedimenti.

La scelta di sprint settimanali, anziché le classiche due settimane, si è rivelata particolarmente efficace per un progetto di ricerca e sviluppo come questo, dove la direzione poteva cambiare rapidamente in base ai risultati ottenuti. Questa cadenza ravvicinata ha permesso di mantenere alta la flessibilità e di adattarsi velocemente alle nuove scoperte tecniche.

### 3.1.2 Strumenti di sviluppo e ambiente tecnologico

L'ambiente di sviluppo è stato configurato durante la prima settimana con particolare attenzione all'integrazione di tutti gli strumenti necessari:

- **Ambiente COBOL**: gnuCOBOL come compilatore principale, integrato con DBeaver per la gestione database
- **Ambiente Java**: JDK 11 con Maven per la gestione delle dipendenze e il build system
- **Ambiente Python**: Python 3.7+ per gli script di automazione e l'integrazione con le API di AI
- **Docker**: per la containerizzazione dell'ambiente di sviluppo e test

Una sfida iniziale significativa è stata l'impossibilità di interfacciare DB2 con gnuCOBOL nell'ambiente Docker a causa di versioni deprecate e mancanza di librerie per SQL embedded. Questo ha richiesto un pivot verso PostgreSQL, dimostrando fin da subito la necessità di flessibilità nell'approccio tecnico.

### 3.1.3 Gestione del progetto attraverso Jira e Confluence

La gestione del progetto ha seguito i principi Agile utilizzando:

- **Jira** per il tracking delle attività, con user story strutturate secondo il formato "Come [ruolo], voglio [funzionalità], per [beneficio]"
- **Confluence** per la documentazione progressiva, organizzata in spazi dedicati per requisiti, design tecnico e lesson learned
- **BitBucket** per il versionamento del codice, con una strategia di branching che prevedeva feature branch per ogni sviluppo significativo

La documentazione è stata mantenuta aggiornata in tempo reale, seguendo il principio Agile di "working software over comprehensive documentation", ma riconoscendo l'importanza di catturare le decisioni chiave e le motivazioni tecniche per future reference.

## 3.2 Primo periodo: immersione nel mondo COBOL

### 3.2.1 Studio del linguaggio e creazione progetti test

Le prime settimane sono state dedicate all'apprendimento approfondito del linguaggio COBOL attraverso un approccio pratico. Invece di limitarmi allo studio teorico, ho sviluppato tre applicazioni complete di complessità crescente:

1. **Sistema di Gestione Conti Correnti Bancari** (Complessità Base)
   - Gestione apertura/chiusura conti
   - Operazioni di deposito e prelievo con validazioni
   - Calcolo del saldo e generazione estratti conto
   - Integrazione con database PostgreSQL tramite SQL embedded

2. **Sistema di Gestione Paghe e Stipendi** (Complessità Media)
   - Anagrafica dipendenti completa
   - Calcolo stipendio base con gestione straordinari
   - Gestione trattenute fiscali e contributi previdenziali
   - Generazione cedolini mensili

3. **Sistema di Gestione Magazzino e Inventario** (Complessità Media-Alta)
   - Gestione prodotti con codici a barre
   - Tracking movimentazioni e giacenze
   - Gestione ordini fornitori con riordino automatico
   - Report di inventario e analisi rotazione merci

Ogni applicazione è stata sviluppata seguendo le best practice COBOL, includendo:
- Strutturazione corretta delle divisioni (IDENTIFICATION, ENVIRONMENT, DATA, PROCEDURE)
- Gestione appropriata degli errori tramite SQLCA
- Implementazione di transazioni ACID per le operazioni critiche
- Documentazione inline estensiva

### 3.2.2 Interfacciamento con database PostgreSQL e DB2

L'integrazione con i database ha rappresentato una sfida tecnica significativa. Il codice COBOL utilizzava SQL embedded attraverso la sintassi EXEC SQL, richiedendo particolare attenzione a:

- Gestione delle variabili host con i due punti (:variable)
- Implementazione di cursori per risultati multipli
- Gestione del SQLCODE per il controllo errori
- Mapping tra tipi COBOL (PIC clauses) e tipi SQL

Un esempio significativo dal sistema bancario:

```cobol
EXEC SQL
    SELECT c.saldo, c.stato, cl.nome, cl.cognome
    INTO :WS-CON-SALDO, :WS-CON-STATO,
         :WS-CLI-NOME, :WS-CLI-COGNOME
    FROM CONTI c
    JOIN CLIENTI cl ON c.codice_cliente = cl.codice_cliente
    WHERE c.numero_conto = :WS-NUMERO-CONTO
END-EXEC
```

### 3.2.3 Mappatura dei pattern e analisi di traducibilità

L'analisi approfondita del codice prodotto ha permesso di identificare pattern ricorrenti nel COBOL e valutarne la traducibilità verso Java:

**Pattern direttamente traducibili:**
- Strutture dati COBOL → Classi Java con getter/setter
- PERFORM → Chiamate a metodi
- IF/ELSE → Strutture condizionali Java
- File I/O sequenziale → Java I/O streams

**Pattern che richiedono trasformazione:**
- GOTO → Refactoring con loop e condizioni strutturate
- REDEFINES → Union types o metodi di conversione
- Level 88 conditions → Enum o costanti booleane
- PICTURE clauses → Formattazione con DecimalFormat

**Elementi critici identificati:**
- La gestione precisa dei tipi numerici COBOL (COMP-3, packed decimal)
- Il comportamento specifico delle operazioni aritmetiche con ROUNDED
- La semantica particolare del MOVE statement con conversioni implicite

### 3.2.4 Valutazione delle soluzioni esistenti

La ricerca di soluzioni esistenti ha portato all'analisi di diversi approcci:

**Pipeline Architecture con parser open-source:**
- **ProLeap ANTLR4 parser**: Parser COBOL completo ma complessità elevata nell'estensione
- **Koopa parser**: Generazione di AST XML ma difficoltà nella trasformazione verso Java

L'analisi del Koopa parser ha rivelato la complessità di gestire l'AST COBOL:
```xml
<program>
  <identification-division>
    <program-id>GESTIONE-CONTI</program-id>
    <author>ANNALISA-EGIDI</author>
  </identification-division>
  <!-- Centinaia di nodi per un programma medio -->
</program>
```

**Soluzioni Enterprise:**
- **IBM WatsonX Code Assistant**: Promettente ma costi proibitivi per un progetto di stage
- **Micro Focus COBOL Analyzer**: Ottimo per analisi ma non per traduzione automatica

L'esplorazione di queste soluzioni ha evidenziato che mentre esistevano tool per l'analisi del COBOL, la traduzione automatica verso Java rimaneva un problema largamente irrisolto, specialmente per la preservazione della business logic.

## 3.3 Secondo periodo: sviluppo del parser tradizionale

### 3.3.1 Implementazione del parser Java

Basandomi sull'analisi dei pattern, ho iniziato lo sviluppo di un parser deterministico in Java. L'approccio prevedeva:

1. **Lexical Analysis**: Tokenizzazione del codice COBOL
2. **Syntactic Analysis**: Costruzione di un AST semplificato
3. **Semantic Analysis**: Comprensione del contesto e delle dipendenze
4. **Code Generation**: Produzione del codice Java equivalente

Il parser è stato implementato con successo per le divisioni IDENTIFICATION e ENVIRONMENT:

```java
public class COBOLParser {
    public IdentificationDivision parseIdentification(List<String> lines) {
        IdentificationDivision division = new IdentificationDivision();
        for (String line : lines) {
            if (line.contains("PROGRAM-ID")) {
                division.setProgramId(extractValue(line));
            } else if (line.contains("AUTHOR")) {
                division.setAuthor(extractValue(line));
            }
            // ... altri campi
        }
        return division;
    }
}
```

### 3.3.2 Sfide tecniche nella gestione della grammatica COBOL

Man mano che procedevo con l'implementazione, le complessità aumentavano esponenzialmente:

- **DATA DIVISION**: La gestione dei livelli gerarchici (01, 05, 10...) richiedeva una logica ricorsiva complessa
- **REDEFINES**: Necessitava di un sistema di type tracking sofisticato
- **PICTURE clauses**: Ogni formato richiedeva parsing e validazione specifici
- **PROCEDURE DIVISION**: La varietà di statement e la gestione del control flow risultavano overwhelming

Un esempio della complessità incontrata:

```java
// Tentativo di parsing di una struttura dati COBOL gerarchica
public DataStructure parseDataStructure(List<String> lines) {
    Stack<DataItem> itemStack = new Stack<>();
    Map<Integer, DataItem> levelMap = new HashMap<>();
    
    for (String line : lines) {
        int level = extractLevel(line);
        String name = extractName(line);
        String picture = extractPicture(line);
        
        // La logica diventava rapidamente ingestibile
        // per gestire tutti i casi edge del COBOL
    }
}
```

### 3.3.3 Analisi critica e limiti dell'approccio

Dopo tre settimane di sviluppo intensivo, è diventato evidente che l'approccio tradizionale presentava limitazioni insormontabili:

**Complessità temporale:**
- Stimato 3-4 mesi solo per un parser completo
- Altri 2-3 mesi per il generatore di codice affidabile
- Tempo totale incompatibile con la durata dello stage

**Limitazioni tecniche:**
- Difficoltà nel preservare la semantica business
- Impossibilità di gestire tutti i dialetti COBOL
- Manutenzione del parser estremamente onerosa

**Scalabilità:**
- Ogni nuovo pattern COBOL richiedeva modifiche estensive
- Il codice del parser stava diventando più complesso del COBOL stesso
- Test e validazione richiedevano effort sproporzionato

La decisione di abbandonare questo approccio non è stata facile, ma necessaria. Il feedback del tutor aziendale è stato illuminante: "L'aspettativa è che conduci investigazioni in prima persona confrontandoti su domande, criteri di ricerca e risultati." Questo mi ha spinto a cercare soluzioni alternative più innovative.

## 3.4 Terzo periodo: pivot verso l'intelligenza artificiale

### 3.4.1 La svolta: incontro con i colleghi e scoperta delle API

Il punto di svolta è avvenuto il 20 giugno durante una discussione informale con colleghi del team di Data Science. Stavano utilizzando le API di Gemini per task di NLP e hanno suggerito: "Perché non provi a usare un LLM per la traduzione del codice?"

Inizialmente ero scettica: come poteva un modello linguistico comprendere le complessità del COBOL? Tuttavia, un rapido proof of concept ha dimostrato il potenziale:

```python
# Primo test con Gemini
prompt = """
Traduci questo codice COBOL in Java:
IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO-WORLD.
PROCEDURE DIVISION.
    DISPLAY "Hello, World!".
    STOP RUN.
"""

response = model.generate_content(prompt)
# Output: un perfetto HelloWorld.java!
```

### 3.4.2 Valutazione delle API di AI generativa

Ho condotto una valutazione sistematica di diverse API:

**Google Gemini Pro:**
- Comprensione eccellente del contesto COBOL
- Capacità di preservare la business logic
- Output Java idiomatico e ben strutturato
- Gestione intelligente delle conversioni di tipo

**Vantaggi identificati:**
- Riduzione del tempo di sviluppo del 90%
- Gestione automatica dei casi edge
- Codice Java di qualità production-ready
- Documentazione automatica inclusa

### 3.4.3 Design del sistema AI-powered

Il nuovo sistema è stato progettato con un'architettura modulare:

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   Input Files   │────▶│ Translator_GenAI │────▶│   Java Output   │
│ (.cbl + .sql)   │     │    (Python)      │     │    (.java)      │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                               │
                               ▼
                        ┌──────────────────┐
                        │  Gemini AI API   │
                        │ (Prompt Engine)  │
                        └──────────────────┘
```

L'architettura prevedeva:
- **Input handler**: Gestione file COBOL e schema SQL
- **Prompt builder**: Costruzione prompt ottimizzati
- **Response processor**: Parsing e validazione output
- **Error handler**: Gestione retry e fallback

## 3.5 Quarto periodo: implementazione della soluzione AI-driven

### 3.5.1 Sviluppo del prompt engineering

Il cuore del sistema risiedeva nella qualità dei prompt. Ho sviluppato un template sofisticato che guidava l'AI attraverso il processo di traduzione:

```python
prompt = f"""
Sei un compilatore avanzato e un traduttore di codice sorgente da COBOL a Java.
Il tuo compito è analizzare il seguente codice sorgente COBOL e tradurlo in un 
singolo file Java moderno, completo, leggibile e compilabile.

**Codice Sorgente COBOL da Tradurre:**
```cobol
{cobol_code}
```

**Schema Database SQL fornito:**
```sql
{sql_schema}
```

**Istruzioni di Traduzione Dettagliate:**
1. **Mappatura delle Divisioni COBOL:**
   - IDENTIFICATION DIVISION → Commenti JavaDoc e annotazioni
   - ENVIRONMENT DIVISION → Configurazioni esterne (properties)
   - DATA DIVISION → Classi Java, variabili membro, costanti
   - PROCEDURE DIVISION → Metodi Java con logica equivalente

2. **Conversione Tipi di Dati:**
   - PIC X(n) → String con validazione lunghezza
   - PIC 9(n) → Integer o Long basato su dimensione
   - PIC 9(n)V9(m) → BigDecimal con precisione
   - COMP-3 → BigDecimal con gestione packed decimal

[... ulteriori istruzioni dettagliate ...]
"""
```

### 3.5.2 Ottimizzazione iterativa basata sui risultati

Il processo di ottimizzazione è stato iterativo:

**Iterazione 1**: Traduzione base funzionante ma codice Java non idiomatico
**Iterazione 2**: Aggiunta gestione eccezioni e pattern Java standard
**Iterazione 3**: Miglioramento gestione transazioni database
**Iterazione 4**: Aggiunta generazione JavaDoc automatica
**Iterazione 5**: Ottimizzazione performance e leggibilità

Ogni iterazione includeva:
- Test su tutti e tre i progetti COBOL di esempio
- Analisi del codice generato
- Identificazione pattern di errore
- Raffinamento del prompt

### 3.5.3 Gestione dei casi edge

I casi edge sono stati gestiti attraverso istruzioni specifiche nel prompt:

- **NULL handling**: Verifica esplicita per campi nullable dallo schema SQL
- **Transazioni annidate**: Gestione savepoint per rollback parziali
- **Type overflow**: Controlli per conversioni numeriche sicure
- **Character encoding**: Gestione corretta di EBCDIC vs ASCII

Esempio di gestione NULL avanzata generata:

```java
// Gestione NULL per campo opzionale
if (rs.wasNull()) {
    cliente.setEmail(null);
} else {
    String email = rs.getString("email");
    if (email != null && !email.trim().isEmpty()) {
        cliente.setEmail(email.trim());
    }
}
```

### 3.5.4 Implementazione del translator completo

Il translator finale (translator_GenAI.py) implementava:

```python
def translate_cobol_to_java_with_jdbc(cobol_code, sql_schema=None):
    """
    Usa Gemini per tradurre codice COBOL in Java con supporto JDBC.
    """
    generation_config = {
        "temperature": 0.1,  # Bassa per output deterministico
        "top_p": 0.9,
        "max_output_tokens": 25000,
    }
    
    model = genai.GenerativeModel(
        model_name="gemini-2.0-flash-exp",
        generation_config=generation_config,
    )
    
    prompt = build_translation_prompt(cobol_code, sql_schema)
    response = model.generate_content(prompt)
    
    return clean_and_validate_java(response.text)
```

### 3.5.5 Gestione di SQL embedded

Una delle sfide maggiori era la conversione di SQL embedded COBOL in JDBC. Il sistema gestiva:

**Da COBOL:**
```cobol
EXEC SQL
    UPDATE CONTI
    SET saldo = saldo + :WS-IMPORTO
    WHERE numero_conto = :WS-NUMERO-CONTO
END-EXEC
```

**A Java:**
```java
String updateSql = "UPDATE CONTI SET saldo = saldo + ? WHERE numero_conto = ?";
try (PreparedStatement pstmt = connection.prepareStatement(updateSql)) {
    pstmt.setBigDecimal(1, importo);
    pstmt.setString(2, numeroConto);
    int rowsAffected = pstmt.executeUpdate();
    
    if (rowsAffected == 0) {
        throw new SQLException("Conto non trovato: " + numeroConto);
    }
}
```

### 3.5.6 Preservazione della logica business

Il sistema eccelleva nel preservare la logica business complessa:

- **Calcoli finanziari**: Mantenimento della precisione decimale COBOL
- **Validazioni**: Conversione di level-88 in metodi di validazione
- **Flow control**: Trasformazione di GOTO in strutture moderne preservando la logica
- **Error handling**: Mappatura SQLCODE in eccezioni Java appropriate

### 3.5.7 Generazione automatica di progetti Maven

L'ultimo componente del sistema (java_to_jar.py) automatizzava la creazione di progetti Maven completi:

```python
def create_pom_file(project_dir, java_file, class_name):
    """Crea il file pom.xml usando Gemini"""
    # Gemini analizza imports e genera dependencies
    pom_content = analyze_java_with_gemini(java_content)
    
    # Genera struttura Maven standard
    setup_project_structure(project_name)
    
    # Configura build plugins
    configure_maven_plugins(pom_content)
    
    return pom_path
```

Il pom.xml generato includeva:
- Dipendenze PostgreSQL JDBC
- Plugin per creazione JAR eseguibili
- Configurazione per Java 11+
- Assembly plugin per JAR con dipendenze

## 3.6 Risultati raggiunti

### 3.6.1 Impatto dell'AI sui tempi di sviluppo

Il confronto tra i due approcci è stato drammatico:

**Approccio tradizionale (stimato):**
- Sviluppo parser: 3-4 mesi
- Testing e debug: 2 mesi
- Documentazione: 1 mese
- **Totale: 6-7 mesi**

**Approccio AI-driven (effettivo):**
- Studio e design: 3 giorni
- Implementazione: 4 giorni
- Testing e ottimizzazione: 3 giorni
- **Totale: 2 settimane**

La riduzione del 95% nei tempi di sviluppo ha permesso di completare il progetto nei tempi dello stage e con risultati superiori alle aspettative.

### 3.6.2 Analisi qualitativa dei risultati

Il codice Java prodotto dal sistema AI presentava caratteristiche di alta qualità:

**Leggibilità:**
- Nomi variabili e metodi in camelCase idiomatico
- Struttura delle classi logica e ben organizzata
- JavaDoc completo generato automaticamente

**Manutenibilità:**
- Separazione chiara delle responsabilità
- Gestione errori consistente
- Pattern standard Java applicati correttamente

**Esempio di codice generato:**

```java
/**
 * Sistema di Gestione Conti Correnti Bancari
 * Convertito da COBOL il 2025-06-23
 * 
 * @author ANNALISA-EGIDI
 * @version 1.0.0
 */
public class GestioneConti {
    private static final Logger logger = LoggerFactory.getLogger(GestioneConti.class);
    
    private Connection connection;
    private Scanner scanner;
    
    /**
     * Costruttore principale - inizializza connessione DB
     */
    public GestioneConti() {
        this.scanner = new Scanner(System.in);
        initializeDatabase();
    }
    
    /**
     * Effettua un deposito sul conto specificato
     * @param numeroConto Numero del conto
     * @param importo Importo da depositare
     * @throws SQLException in caso di errore database
     */
    public void deposito(String numeroConto, BigDecimal importo) 
            throws SQLException {
        validaImporto(importo);
        
        connection.setAutoCommit(false);
        try {
            // Verifica esistenza e stato conto
            verificaConto(numeroConto);
            
            // Aggiorna saldo
            String updateSql = "UPDATE CONTI SET saldo = saldo + ? " +
                              "WHERE numero_conto = ?";
            try (PreparedStatement pstmt = 
                    connection.prepareStatement(updateSql)) {
                pstmt.setBigDecimal(1, importo);
                pstmt.setString(2, numeroConto);
                pstmt.executeUpdate();
            }
            
            // Registra movimento
            registraMovimento(numeroConto, 'D', importo, 
                            "Deposito contanti");
            
            connection.commit();
            System.out.println("Deposito effettuato con successo");
            
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }
}
```

### 3.6.3 Documentazione professionale automatizzata

Il sistema generava automaticamente:

- **JavaDoc completo** per classi e metodi
- **README.md** con istruzioni di utilizzo
- **Commenti inline** per logica complessa
- **Mapping COBOL-Java** nei commenti per tracciabilità

### 3.6.4 Risultati quantitativi

I numeri finali del progetto:

**Progetti convertiti con successo:**
1. Sistema bancario: 560 linee COBOL → 892 linee Java
2. Sistema paghe: 1.250 linee COBOL → 1.780 linee Java  
3. Sistema magazzino: 1.850 linee COBOL → 2.420 linee Java

**Metriche di qualità:**
- 100% compilabilità del codice generato
- 95% dei test funzionali superati al primo tentativo
- 0 memory leak o connection leak identificati
- Conformità completa agli standard Java

**Performance:**
- Tempo medio di conversione: 15-30 secondi per progetto
- Tempo di generazione JAR: 45-60 secondi
- JAR eseguibili pronti per deployment immediato

## 3.7 Conclusioni del capitolo

Lo sviluppo del progetto ha dimostrato come l'intelligenza artificiale possa rivoluzionare l'approccio alla modernizzazione del software legacy. Il passaggio da un approccio tradizionale basato su parsing deterministico a uno guidato dall'AI non è stato solo una scelta tecnica, ma una vera trasformazione nel modo di affrontare il problema.

L'AI ha permesso di:
- Ridurre drasticamente i tempi di sviluppo
- Produrre codice di qualità superiore
- Gestire complessità altrimenti intrattabili
- Fornire una soluzione realmente utilizzabile in produzione

Questo progetto rappresenta un esempio concreto di come le tecnologie emergenti possano abilitare soluzioni prima impensabili, trasformando mesi di lavoro manuale in giorni di sviluppo assistito dall'intelligenza artificiale.