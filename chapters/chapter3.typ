#import "../config/functions.typ": *
#import "../config/foreign-words.typ": *
#import "../appendix/glossary.typ": *
#import "../appendix/acronyms.typ": *

#define-acronym("AI", "Artificial Intelligence")
#define-term("legacy", "Sistemi informatici datati ma ancora in uso")
#define-term("parser", "Analizzatore sintattico")
#define-term("parsing", "Analisi sintattica")
#define-term("pipeline", "Sequenza di elaborazioni")
#define-acronym("API", "Application Programming Interface")
#define-term("prompt", "Istruzione data a un sistema AI")
#define-term("Maven", "Strumento di gestione progetti Java")
#define-term("edge", "Casi limite o estremi")
#define-term("translator", "Traduttore automatico")
#define-term("end-to-end", "Da inizio a fine")
#define-term("build system", "Sistema di compilazione")
#define-term("JavaDoc", "Documentazione automatica Java")
#define-term("sprint", "Periodo di sviluppo Agile")
#define-term("stand-up", "Riunione quotidiana Agile")
#define-term("pattern", "Schema ricorrente nel codice")
#define-term("open-source", "Software a codice aperto")
#define-term("embedded", "Incorporato nel codice")
#define-term("business logic", "Logica di elaborazione (sotto forma di codice sorgente) che rende operativa un'applicazione")
#define-term("production-ready", "Pronto per la produzione")
#define-acronym("SQL", "Structured Query Language")
#define-acronym("COBOL", "Common Business-Oriented Language")
#define-term("proof of concept", "Dimostrazione di fattibilità")
#define-acronym("LLM", "Large Language Model")
#define-term("deployment", "Distribuzione in produzione")
#define-acronym("JDBC", "Java Database Connectivity")
#define-acronym("CLI", "Command Line Interface")
#define-term("refactoring", "Ristrutturazione del codice")
#define-acronym("AST", "Abstract Syntax Tree")
#define-term("lexer", "Analizzatore lessicale")
#define-term("token", "Unità lessicale elementare")
#define-term("workflow", "Flusso di lavoro")
#define-acronym("NLP", "Natural Language Processing")
#define-term("rollback", "Annullamento di transazione")
#define-term("savepoint", "Punto di salvataggio in una transazione")
#define-acronym("ACID", "Atomicity, Consistency, Isolation, Durability")
#define-term("type tracking", "Tracciamento dei tipi di dato")
#define-term("control flow", "Flusso di controllo")
#define-acronym("JSON", "JavaScript Object Notation")
#define-acronym("JAR", "Java Archive")
#define-term("classpath", "Percorso delle classi Java")
#define-term("getter/setter", "Metodi di accesso alle proprietà")

= Sviluppo del progetto: dal #foreign("parser") tradizionale all'#acronym("AI") <cap:sviluppo-progetto>

Il presente capitolo documenta l'evoluzione del progetto di migrazione #acronym("COBOL")-Java durante il periodo di #foreign("stage"), illustrando il percorso che ha portato da un approccio tradizionale basato su #gls("parsing") deterministico a una soluzione innovativa guidata dall'intelligenza artificiale. La narrazione segue un ordine cronologico per evidenziare come le sfide tecniche incontrate abbiano influenzato le decisioni progettuali e come l'adozione dell'#acronym("AI") abbia trasformato radicalmente tempi e risultati del progetto.

== #foreign("Setup") iniziale e metodologia di lavoro <sec:setup-iniziale>

=== Implementazione della metodologia #foreign("Agile") <subsec:metodologia-agile>

Il progetto ha adottato fin dall'inizio una metodologia #foreign("Agile") strutturata in #gls("sprint") settimanali. Ogni settimana iniziava con una pianificazione degli obiettivi e si concludeva con una retrospettiva per valutare i risultati raggiunti. Gli #gls("stand-up") giornalieri, condotti virtualmente attraverso la piattaforma aziendale, permettevano di sincronizzare il lavoro con il #foreign("team") e identificare tempestivamente eventuali impedimenti.

La scelta di #foreign("sprint") settimanali, anziché le classiche due settimane, si è rivelata particolarmente efficace per un progetto di ricerca e sviluppo come questo, dove la direzione poteva cambiare rapidamente in base ai risultati ottenuti. Questa cadenza ravvicinata ha permesso di mantenere alta la flessibilità e di adattarsi velocemente alle nuove scoperte tecniche.

=== Strumenti di sviluppo e ambiente tecnologico <subsec:strumenti-sviluppo>

L'ambiente di sviluppo è stato configurato durante la prima settimana con particolare attenzione all'integrazione di tutti gli strumenti necessari:

- *Ambiente #foreign("COBOL")*: #foreign("gnuCOBOL") come compilatore principale, integrato con #foreign("DBeaver") per la gestione #foreign("database")
- *Ambiente Java*: JDK 11 con #gls("Maven") per la gestione delle dipendenze e il #gls("build system")
- *Ambiente Python*: Python 3.7+ per gli #foreign("script") di automazione e l'integrazione con le #acronym("API") di #acronym("AI")
- *#foreign("Docker")*: per la containerizzazione dell'ambiente di sviluppo e #foreign("test")

Una sfida iniziale significativa è stata l'impossibilità di interfacciare DB2 con #foreign("gnuCOBOL") nell'ambiente #foreign("Docker") a causa di versioni deprecate e mancanza di librerie per #acronym("SQL") #gls("embedded"). Questo ha richiesto un #foreign("pivot") verso PostgreSQL, dimostrando fin da subito la necessità di flessibilità nell'approccio tecnico.

=== Gestione del progetto attraverso #foreign("Jira") e #foreign("Confluence") <subsec:gestione-progetto>

La gestione del progetto ha seguito i principi #foreign("Agile") utilizzando:

- *#foreign("Jira")* per il #foreign("tracking") delle attività, con #foreign("user story") strutturate secondo il formato "Come [ruolo], voglio [funzionalità], per [beneficio]"
- *#foreign("Confluence")* per la documentazione progressiva, organizzata in spazi dedicati per requisiti, #foreign("design") tecnico e #foreign("lesson learned")
- *#foreign("BitBucket")* per il versionamento del codice, con una strategia di #foreign("branching") che prevedeva #foreign("feature branch") per ogni sviluppo significativo

#ref-figure(<fig:bitbucket-git>) mostra l'interfaccia #foreign("BitBucket") utilizzata per il versionamento, evidenziando l'importanza attribuita dall'azienda alla tracciabilità e alla collaborazione nel processo di sviluppo.

#numbered-figure(
  image("../images/Atlassian-Bitbucket.png"),
  caption: "Utilizzo di BitBucket per il versionamento del codice",
  source: "https://bitbucket.org"
) <fig:bitbucket-git>

La documentazione è stata mantenuta aggiornata in tempo reale, seguendo il principio #foreign("Agile") di "#foreign("working software over comprehensive documentation")", ma riconoscendo l'importanza di catturare le decisioni chiave e le motivazioni tecniche per future #foreign("reference").

== Primo periodo: immersione nel mondo #foreign("COBOL") <sec:primo-periodo>

=== Studio del linguaggio e creazione progetti #foreign("test") <subsec:studio-linguaggio>

Le prime settimane sono state dedicate all'apprendimento approfondito del linguaggio #acronym("COBOL") attraverso un approccio pratico. Invece di limitarmi allo studio teorico, ho sviluppato tre applicazioni complete di complessità crescente:

1. *Sistema di Gestione Conti Correnti Bancari* (Complessità Base)
   - Gestione apertura/chiusura conti
   - Operazioni di deposito e prelievo con validazioni
   - Calcolo del saldo e generazione estratti conto
   - Integrazione con #foreign("database") PostgreSQL tramite #acronym("SQL") #gls("embedded")

2. *Sistema di Gestione Paghe e Stipendi* (Complessità Media)
   - Anagrafica dipendenti completa
   - Calcolo stipendio base con gestione straordinari
   - Gestione trattenute fiscali e contributi previdenziali
   - Generazione cedolini mensili

3. *Sistema di Gestione Magazzino e Inventario* (Complessità Media-Alta)
   - Gestione prodotti con codici a barre
   - #foreign("Tracking") movimentazioni e giacenze
   - Gestione ordini fornitori con riordino automatico
   - #foreign("Report") di inventario e analisi rotazione merci

Ogni applicazione è stata sviluppata seguendo le #foreign("best practice") #acronym("COBOL"), includendo:
- Strutturazione corretta delle divisioni (#foreign("IDENTIFICATION"), #foreign("ENVIRONMENT"), #foreign("DATA"), #foreign("PROCEDURE"))
- Gestione appropriata degli errori tramite SQLCA
- Implementazione di transazioni #acronym("ACID") per le operazioni critiche
- Documentazione #foreign("inline") estensiva
/*
#source-code(
```cobol
EXEC SQL
    SELECT c.saldo, c.stato, cl.nome, cl.cognome
    INTO :WS-CON-SALDO, :WS-CON-STATO,
         :WS-CLI-NOME, :WS-CLI-COGNOME
    FROM CONTI c
    JOIN CLIENTI cl ON c.codice_cliente = cl.codice_cliente
    WHERE c.numero_conto = :WS-NUMERO-CONTO
END-EXEC
```,
lang: "cobol",
caption: "Esempio di SQL embedded in COBOL per query con JOIN"
)
*/
=== Mappatura dei #foreign("pattern") e analisi di traducibilità <subsec:mappatura-pattern>

L'analisi approfondita del codice prodotto ha permesso di identificare #gls("pattern") ricorrenti nel #acronym("COBOL") e valutarne la traducibilità verso Java:

*#foreign("Pattern") direttamente traducibili:*
- Strutture dati #acronym("COBOL") → Classi Java con #gls("getter/setter")
- PERFORM → Chiamate a metodi
- IF/ELSE → Strutture condizionali Java
- #foreign("File I/O") sequenziale → Java I/O #foreign("streams")

*#foreign("Pattern") che richiedono trasformazione:*
- GOTO → #gls("Refactoring") con #foreign("loop") e condizioni strutturate
- REDEFINES → #foreign("Union types") o metodi di conversione
- #foreign("Level") 88 #foreign("conditions") → #foreign("Enum") o costanti booleane
- PICTURE #foreign("clauses") → Formattazione con DecimalFormat

*Elementi critici identificati:*
- La gestione precisa dei tipi numerici #acronym("COBOL") (COMP-3, #foreign("packed decimal"))
- Il comportamento specifico delle operazioni aritmetiche con ROUNDED
- La semantica particolare del MOVE #foreign("statement") con conversioni implicite

=== Valutazione delle soluzioni esistenti <subsec:valutazione-soluzioni>

La ricerca di soluzioni esistenti ha portato all'analisi di diversi approcci:

*#foreign("Pipeline Architecture") con #foreign("parser") #gls("open-source"):*
- *#foreign("ProLeap") ANTLR4 #foreign("parser")*: #foreign("Parser") #acronym("COBOL") completo ma complessità elevata nell'estensione
- *#foreign("Koopa parser")*: Generazione di #acronym("AST") XML ma difficoltà nella trasformazione verso Java

L'analisi del #foreign("Koopa parser") ha rivelato la complessità di gestire l'#acronym("AST") #acronym("COBOL"):
/*
#source-code(
```xml
<program>
  <identification-division>
    <program-id>GESTIONE-CONTI</program-id>
    <author>ANNALISA-EGIDI</author>
  </identification-division>
  <!-- Centinaia di nodi per un programma medio -->
</program>
```,
lang: "xml",
caption: "Frammento di AST generato dal Koopa parser"
)*/

*Soluzioni #foreign("Enterprise"):*
- *IBM #foreign("WatsonX Code Assistant")*: Promettente ma costi proibitivi per un progetto di #foreign("stage")
- *#foreign("Micro Focus") #acronym("COBOL") Analyzer*: Ottimo per analisi ma non per traduzione automatica

L'esplorazione di queste soluzioni ha evidenziato che mentre esistevano #foreign("tool") per l'analisi del #acronym("COBOL"), la traduzione automatica verso Java rimaneva un problema largamente irrisolto, specialmente per la preservazione della #gls("business logic").

== Secondo periodo: sviluppo del #foreign("parser") tradizionale <sec:secondo-periodo>

=== Implementazione del #foreign("parser") Java <subsec:implementazione-parser>

Basandomi sull'analisi dei #foreign("pattern"), ho iniziato lo sviluppo di un #gls("parser") deterministico in Java. L'approccio prevedeva:

1. *#foreign("Lexical Analysis")*: Tokenizzazione del codice #acronym("COBOL")
2. *#foreign("Syntactic Analysis")*: Costruzione di un #acronym("AST") semplificato
3. *#foreign("Semantic Analysis")*: Comprensione del contesto e delle dipendenze
4. *#foreign("Code Generation")*: Produzione del codice Java equivalente

Il #foreign("parser") è stato implementato con successo per le divisioni #foreign("IDENTIFICATION") e #foreign("ENVIRONMENT"):
/*
#source-code(
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
```,
lang: "java",
caption: "Parser per IDENTIFICATION DIVISION"
)*/

=== Analisi critica e limiti dell'approccio <subsec:limiti-approccio>

Dopo tre settimane di sviluppo intensivo, è diventato evidente che l'approccio tradizionale presentava limitazioni insormontabili:

*Complessità temporale:*
- Stimato 3-4 mesi solo per un #foreign("parser") completo
- Altri 2-3 mesi per il generatore di codice affidabile
- Tempo totale incompatibile con la durata dello #foreign("stage")

*Limitazioni tecniche:*
- Difficoltà nel preservare la semantica #foreign("business")
- Impossibilità di gestire tutti i dialetti #acronym("COBOL")
- Manutenzione del #foreign("parser") estremamente onerosa

*Scalabilità:*
- Ogni nuovo #foreign("pattern") #acronym("COBOL") richiedeva modifiche estensive
- Il codice del #foreign("parser") stava diventando più complesso del #acronym("COBOL") stesso
- #foreign("Test") e validazione richiedevano #foreign("effort") sproporzionato

La decisione di abbandonare questo approccio non è stata facile, ma necessaria. Il #foreign("feedback") del #foreign("tutor") aziendale è stato illuminante: "L'aspettativa è che conduci investigazioni in prima persona confrontandoti su domande, criteri di ricerca e risultati." Questo mi ha spinto a cercare soluzioni alternative più innovative.

== Terzo periodo: #foreign("pivot") verso l'intelligenza artificiale <sec:terzo-periodo>

=== Valutazione delle #foreign("API") di #acronym("AI") generativa <subsec:valutazione-api>

Il punto di svolta è avvenuto il 20 giugno durante una discussione informale con colleghi del #foreign("team") di #foreign("Data Science"). Stavano utilizzando le #acronym("API") di #foreign("Gemini") per #foreign("task") di #acronym("NLP") e hanno suggerito: "Perché non provi a usare un #acronym("LLM") per la traduzione del codice?"

Inizialmente ero scettica: come poteva un modello linguistico comprendere le complessità del #acronym("COBOL")? Tuttavia, un rapido #gls("proof of concept") ha dimostrato il potenziale:
/*
#source-code(
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
```,
lang: "python",
caption: "Primo test di traduzione con Gemini AI"
)*/

Ho condotto una valutazione sistematica di diverse #acronym("API"):

*Google #foreign("Gemini Pro"):*
- Comprensione eccellente del contesto #acronym("COBOL")
- Capacità di preservare la #gls("business logic")
- #foreign("Output") Java idiomatico e ben strutturato
- Gestione intelligente delle conversioni di tipo

*Vantaggi identificati:*
- Riduzione del tempo di sviluppo del 90%
- Gestione automatica dei casi #gls("edge")
- Codice Java di qualità #gls("production-ready")
- Documentazione automatica inclusa

=== #foreign("Design") del sistema #acronym("AI")-#foreign("powered") <subsec:design-sistema>

Il nuovo sistema è stato progettato con un'architettura modulare:

#numbered-figure(
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
  ```,
  caption: "Architettura del sistema di traduzione AI-powered",
) <fig:architettura-sistema>

L'architettura prevedeva:
- *#foreign("Input handler")*: Gestione #foreign("file") #acronym("COBOL") e schema #acronym("SQL")
- *#foreign("Prompt builder")*: Costruzione #gls("prompt") ottimizzati
- *#foreign("Response processor")*: #foreign("Parsing") e validazione #foreign("output")
- *#foreign("Error handler")*: Gestione #foreign("retry") e #foreign("fallback")

== Quarto periodo: implementazione della soluzione #acronym("AI")-#foreign("driven") <sec:quarto-periodo>

=== Sviluppo del #foreign("prompt engineering") <subsec:prompt-engineering>

Il cuore del sistema risiedeva nella qualità dei #gls("prompt"). Ho sviluppato un #foreign("template") sofisticato che guidava l'#acronym("AI") attraverso il processo di traduzione:
/*
#source-code(
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
```,
lang: "python",
caption: "Template del prompt per la traduzione COBOL-Java"
)
*/
=== Implementazione del #foreign("translator") completo <subsec:translator-completo>

Il #gls("translator") finale (#foreign("translator_GenAI.py")) implementava:
/*
#source-code(
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
```,
lang: "python",
caption: "Funzione principale del translator AI"
)
*/

=== Generazione automatica di progetti #gls("Maven") <subsec:generazione-maven>

L'ultimo componente del sistema (#foreign("java_to_jar.py")) automatizzava la creazione di progetti #gls("Maven") completi:
/*
#source-code(
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
```,
lang: "python",
caption: "Generazione automatica del pom.xml"
)
*/

Il #foreign("pom.xml") generato includeva:
- Dipendenze PostgreSQL #acronym("JDBC")
- #foreign("Plugin") per creazione #acronym("JAR") eseguibili
- Configurazione per Java 11+
- #foreign("Assembly plugin") per #acronym("JAR") con dipendenze

== Risultati raggiunti <sec:risultati>

=== Impatto dell'#acronym("AI") sui tempi di sviluppo <subsec:impatto-tempi>

Il confronto tra i due approcci è stato drammatico:
/*
#numbered-table(
  caption: "Confronto tempi di sviluppo tra approcci",
  columns: (auto, auto, auto),
  [*Fase*], [*Approccio Tradizionale (stimato)*], [*Approccio AI (effettivo)*],
  [Sviluppo parser], [3-4 mesi], [3 giorni],
  [Testing e debug], [2 mesi], [4 giorni],
  [Documentazione], [1 mese], [3 giorni],
  [*Totale*], [*6-7 mesi*], [*2 settimane*],
)
*/

La riduzione del 95% nei tempi di sviluppo ha permesso di completare il progetto nei tempi dello #foreign("stage") e con risultati superiori alle aspettative.

=== Analisi qualitativa dei risultati <subsec:analisi-qualitativa>

Il codice Java prodotto dal sistema #acronym("AI") presentava caratteristiche di alta qualità:

*Leggibilità:*
- Nomi variabili e metodi in #foreign("camelCase") idiomatico
- Struttura delle classi logica e ben organizzata
- #gls("JavaDoc") completo generato automaticamente

*Manutenibilità:*
- Separazione chiara delle responsabilità
- Gestione errori consistente
- #foreign("Pattern") standard Java applicati correttamente
/*
#source-code(
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
```,
lang: "java",
caption: "Esempio di codice Java generato dal sistema AI"
)
*/

=== Risultati quantitativi <subsec:risultati-quantitativi>

I numeri finali del progetto:

*Progetti convertiti con successo:*
1. Sistema bancario: 560 linee #acronym("COBOL") → 892 linee Java
2. Sistema paghe: 1.250 linee #acronym("COBOL") → 1.780 linee Java  
3. Sistema magazzino: 1.850 linee #acronym("COBOL") → 2.420 linee Java

*Metriche di qualità:*
- 100% compilabilità del codice generato
- 95% dei #foreign("test") funzionali superati al primo tentativo
- 0 #foreign("memory leak") o #foreign("connection leak") identificati
- Conformità completa agli standard Java

*#foreign("Performance"):*
- Tempo medio di conversione: 15-30 secondi per progetto
- Tempo di generazione #acronym("JAR"): 45-60 secondi
- #acronym("JAR") eseguibili pronti per #gls("deployment") immediato
/*
#numbered-figure(
  image("../images/workflow-conversion.png", width: 80%),
  caption: "Workflow completo del processo di conversione",
) <fig:workflow-conversion>
*/
== Conclusioni del capitolo <sec:conclusioni-capitolo>

Lo sviluppo del progetto ha dimostrato come l'intelligenza artificiale possa rivoluzionare l'approccio alla modernizzazione del #foreign("software") #gls("legacy"). Il passaggio da un approccio tradizionale basato su #gls("parsing") deterministico a uno guidato dall'#acronym("AI") non è stato solo una scelta tecnica, ma una vera trasformazione nel modo di affrontare il problema.

L'#acronym("AI") ha permesso di:
- Ridurre drasticamente i tempi di sviluppo
- Produrre codice di qualità superiore
- Gestire complessità altrimenti intrattabili
- Fornire una soluzione realmente utilizzabile in produzione

Questo progetto rappresenta un esempio concreto di come le tecnologie emergenti possano abilitare soluzioni prima impensabili, trasformando mesi di lavoro manuale in giorni di sviluppo assistito dall'intelligenza artificiale.