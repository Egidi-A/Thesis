#import "../config/functions.typ": *
#import "../config/foreign-words.typ": *
#import "../appendix/glossary.typ": *
#import "../appendix/acronyms.typ": *

#define-term("parser", "Analizzatore sintattico che interpreta la struttura del codice")
#define-acronym("AST", "Abstract Syntax Tree")
#define-acronym("ANTLR", "ANother Tool for Language Recognition")
#define-acronym("API", "Application Programming Interface")
#define-acronym("JDBC", "Java Database Connectivity")
#define-acronym("JSON", "JavaScript Object Notation")
#define-term("prompt engineering", "Tecnica di formulazione di istruzioni per modelli AI")
#define-acronym("LLM", "Large Language Model")
#define-term("token", "Unità base di testo processata dai modelli linguistici")
#define-term("backoff esponenziale", "Strategia di retry con attese progressivamente più lunghe")

= Sviluppo del progetto: dal parser tradizionale all'AI <cap:sviluppo-progetto>

Il percorso di sviluppo del progetto di migrazione COBOL-Java ha attraversato diverse fasi evolutive, caratterizzate da sfide tecnologiche e cambiamenti strategici che hanno profondamente trasformato l'approccio iniziale. Questo capitolo analizza cronologicamente le fasi del progetto, dall'immersione iniziale nel linguaggio COBOL fino all'implementazione di una soluzione basata sull'intelligenza artificiale generativa, evidenziando come la flessibilità metodologica e l'apertura all'innovazione abbiano costituito fattori determinanti per il successo del progetto.

== Setup iniziale e metodologia di lavoro <sec:setup-iniziale>

In questa sezione descriverò l'implementazione della metodologia #foreign("Agile") con #foreign("sprint") settimanali e #foreign("stand-up") giornalieri, illustrerò gli strumenti di sviluppo e l'ambiente tecnologico utilizzato, analizzerò la gestione del progetto attraverso Jira e Confluence, l'uso di Git e BitBucket per il versionamento con documentazione progressiva.

== Primo periodo: immersione nel mondo COBOL <sec:immersione-cobol>

Le prime due settimane del progetto sono state dedicate ad un'immersione completa nel linguaggio COBOL, dai paradigmi di programmazione moderni a cui ero abituata - con la loro enfasi su astrazione, modularità e riusabilità - a un approccio procedurale strutturato degli anni '60.

Questa fase di apprendimento intensivo si è rivelata fondamentale non solo per acquisire competenze tecniche, ma anche per comprendere la filosofia e il contesto storico che hanno plasmato COBOL e, di conseguenza, i sistemi legacy che ancora oggi sostengono infrastrutture critiche.

=== Studio del linguaggio e creazione progetti test <subsec:studio-linguaggio>

L'approccio allo studio del linguaggio COBOL ha combinato risorse storiche e moderne. I manuali tecnici IBM degli anni '80, sorprendentemente ancora attuali, sono stati integrati con tutorial online che tentavano di rendere COBOL accessibile ai programmatori moderni. Particolarmente preziosa si è rivelata la collaborazione con la programmatrice Luisa Biagi, analista COBOL con oltre trent'anni di esperienza, che ha fornito non solo conoscenze tecniche ma anche contesto pratico sull'utilizzo effettivo di COBOL in ambienti di produzione.

La struttura rigida del codice COBOL, articolata nelle quattro divisioni obbligatorie (Identification, Environment, Data e Procedure), rappresenta un paradigma radicalmente diverso rispetto ai linguaggi orientati agli oggetti. Tale struttura, lungi dall'essere un limite, riflette una filosofia progettuale volta a dare ordine e standardizzazione per una manutenibilità in progetti di grandi dimensioni sviluppati da team numerosi.

L'analisi delle singole divisioni ha rivelato aspetti significativi:

- La IDENTIFICATION DIVISION testimonia l'enfasi sulla documentazione incorporata nel codice, con campi dedicati per autore, data di installazione e osservazioni, riflettendo un'epoca in cui il codice sorgente costituiva spesso l'unica documentazione disponibile.
    Un esempio della divisione IDENTIFICATION DIVISION è mostrato in #ref-figure(<lst:identification-div>).
    #source-code(
      ```cobol
      IDENTIFICATION DIVISION.
      PROGRAM-ID. GESTIONE-CONTI.
      AUTHOR. ANNALISA EGIDI.
      INSTALLATION. MIRIADE SRL.
      DATE-WRITTEN. 2025-05-15.
      DATE-COMPILED. 2025-05-20.
      REMARKS. Sistema bancario per gestione conti correnti.
      ```,
      lang: "cobol",
      caption: "Esempio di IDENTIFICATION DIVISION con metadati"
    ) <lst:identification-div>

- La ENVIRONMENT DIVISION introduce esplicitamente considerazioni hardware e di sistema operativo nel codice sorgente. La necessità di specificare SOURCE-COMPUTER e OBJECT-COMPUTER evidenzia le sfide dell'era dei mainframe, dove la portabilità del software non poteva essere data per scontata.
    Un esempio della divisione ENVIRONMENT DIVISION è mostrato in #ref-figure(<lst:environment-div>).
    #source-code(
      ```cobol
      ENVIRONMENT DIVISION.
      CONFIGURATION SECTION.
      SOURCE-COMPUTER. IBM-3090.
      OBJECT-COMPUTER. IBM-3090.
      SPECIAL-NAMES.
          DECIMAL-POINT IS COMMA.
      ```,
      lang: "cobol",
      caption: "ENVIRONMENT DIVISION con specifiche hardware"
    ) <lst:environment-div>
- La sezione FILE-CONTROL, con la sua gestione esplicita dell'associazione tra file logici e fisici, richiede un cambio di mentalità significativo rispetto all'astrazione automatica fornita dai moderni sistemi operativi e strutture software.
  Un esempio della sezione FILE-CONTROL è mostrato in #ref-figure(<lst:file-control>).
  #source-code(
    ```cobol
    INPUT-OUTPUT SECTION.
    FILE-CONTROL.
        SELECT CONTI-FILE
            ASSIGN TO "CONTI.DAT"
            ORGANIZATION IS INDEXED
            ACCESS MODE IS RANDOM
            RECORD KEY IS CONTO-ID.
    ```,
    lang: "cobol",
    caption: "FILE-CONTROL con gestione esplicita dei file"
  ) <lst:file-control>
#linebreak()
Ho sviluppato, progressivamente, tre codici applicativi di complessità crescente:

- Il primo progetto, un sistema di gestione conti correnti bancari, implementa le operazioni fondamentali del banking: apertura conti, depositi, prelievi ed estratti conto. Questo sistema sfrutta la forza di COBOL nell'aritmetica decimale precisa per gestire saldi, fidi e transazioni finanziarie, interfacciandosi con un database PostgreSQL tramite SQL embedded per garantire l'integrità transazionale e la persistenza dei dati.

- Il secondo progetto, un sistema di gestione paghe e stipendi, aumenta significativamente la complessità introducendo calcoli multi-livello per IRPEF con scaglioni progressivi, trattenute previdenziali, detrazioni e addizionali. Il sistema gestisce presenze, straordinari e genera cedolini dettagliati, richiedendo la coordinazione tra molteplici tabelle correlate e l'implementazione di logiche di business complesse per il calcolo delle retribuzioni secondo la normativa fiscale italiana.

- Il terzo progetto, un sistema di gestione magazzino e inventario, rappresenta il culmine della complessità con funzionalità avanzate come la valorizzazione FIFO/LIFO/costo medio ponderato, gestione lotti, analisi ABC degli articoli, controllo scorte con punti di riordino automatici e gestione completa del ciclo ordini fornitori. Il sistema utilizza cursori SQL multipli, transazioni annidate e genera report sofisticati per l'inventario fisico e l'analisi del valore di magazzino, dimostrando la capacità di COBOL di gestire processi aziendali articolati con elevati volumi di dati.
#linebreak()
L'interfacciamento con database relazionali ha rappresentato una sfida particolare. Lavorando con PostgreSQL e DB2, ho approfondito le peculiarità dell'SQL embedded in COBOL. L'approccio differisce radicalmente dalle moderne #acronym("API") #acronym("JDBC"): il preprocessore COBOL-SQL analizza il codice sorgente, estrae le istruzioni SQL delimitate da EXEC SQL ... END-EXEC, e genera il codice COBOL appropriato per l'interazione con il database. La gestione delle variabili host e controllo esplicito degli errori attraverso SQLCODE e SQLSTATE implementa la richiesta del controllo esplicito del codice di ritorno dopo ogni operazione SQL, come illustrato nel #ref-figure(<lst:sqlcode-handling>). Inoltre, per ogni colonna del database è richiesta la corrispettiva variabile locale che funziona da ponte tra il programma e il database, queste variabili sono gestite attraverso la dichiarazione delle stesse nella WORKING-STORAGE SECTION e devono essere necessariamente compatibili per tipo e dimensione con la colonna del database corrispondente.

#source-code(
  ```cobol
  EXEC SQL
      SELECT SALDO INTO :WS-SALDO
      FROM CONTI
      WHERE ID_CLIENTE = :WS-ID-CLIENTE
  END-EXEC.
  
  EVALUATE SQLCODE
      WHEN 0      CONTINUE
      WHEN 100    DISPLAY "Cliente non trovato"
      WHEN OTHER  PERFORM ERRORE-DATABASE
  END-EVALUATE.
  ```,
  lang: "cobol",
  caption: "Gestione degli SQLCODE in COBOL"
) <lst:sqlcode-handling>

=== Mappatura dei pattern e analisi di traducibilità <subsec:mappatura-pattern>

Durante l'analisi dei pattern, ho classificato tre categorie principali:

- pattern con equivalenza diretta in Java
- pattern che richiedono trasformazioni con adattamento
- costrutti problematici senza equivalenti in java

==== Pattern di equivalenza diretta e costrutti base

La mappatura dei pattern COBOL verso Java segue corrispondenze consolidate che possono essere categorizzate come segue:

#figure(
  table(
    columns: (1fr, 1fr),
    align: (left, left),
    [*Tipo COBOL*], [*Tipo Java*],
    [PIC 9(n)], [int/long],
    [PIC X(n)], [String],
    [PIC 9(n)V9(n)], [BigDecimal],
    [PIC S9(n) COMP-3], [BigDecimal],
  ),
  caption: "Mappatura dei tipi di dati primitivi COBOL-Java",
  kind: "Tabella",
  supplement: "Tabella"
) <tab:tipi-primitivi>

#figure(
  table(
    columns: (1fr, 1fr),
    align: (left, left),
    [*Costrutto COBOL*], [*Equivalente Java*],
    [IF-THEN-ELSE], [if-else],
    [EVALUATE], [switch],
    [ADD/SUBTRACT], [Operatori aritmetici (+, -)],
    [MULTIPLY/DIVIDE], [Operatori aritmetici (\*, /)],
    [PERFORM UNTIL], [while loop],
    [PERFORM VARYING], [for loop],
    [PERFORM THRU], [Metodi con sequenza di chiamate],
  ),
  caption: "Mappatura delle strutture di controllo e operazioni",
  kind: "Tabella",
  supplement: "Tabella"
) <tab:strutture-controllo>

#figure(
  table(
    columns: (1fr, 2fr),
    align: (left, left),
    [*Struttura COBOL*], [*Trasformazione Java*],
    [01 level declaration], [Classe Java principale],
    [02-49 level numbers], [Campi della classe o inner classes],
    [Record gerarchici], [Classi Java annidate],
    [WORKING-STORAGE items], [Variabili di istanza private],
  ),
  caption: "Mappatura delle strutture dati gerarchiche",
  kind: "Tabella",
  supplement: "Tabella"
) <tab:strutture-dati>

Come evidenziato nelle tabelle #ref-table(<tab:tipi-primitivi>), #ref-table(<tab:strutture-controllo>) e #ref-table(<tab:strutture-dati>), questi pattern di equivalenza diretta coprono la maggior parte dei costrutti COBOL di base, permettendo una traduzione sistematica verso Java con particolare attenzione alla gestione della precisione numerica.
==== Trasformazioni complesse e pattern di adattamento

Costrutti di complessità intermedia necessitano di strategie di conversione più sofisticate che richiedono trasformazioni strutturali:

#figure(
  table(
    columns: (1fr, 2fr),
    align: (left, left),
    [*Costrutto COBOL*], [*Strategia di conversione Java*],
    [GOTO], [Ristrutturazione del flusso con pattern State/Strategy],
    [COPY statements], [Classi Java dedicate con import/package],
    [WORKING-STORAGE SECTION], [Classi di storage con variabili statiche o di istanza],
    [SECTION/PARAGRAPH], [Metodi Java organizzati gerarchicamente],
    [SQL embedded (EXEC SQL)], [JDBC con PreparedStatement e gestione transazioni],
    [REDEFINES], [Union types tramite ereditarietà o interfacce],
    [OCCURS DEPENDING ON], [Collections dinamiche (ArrayList, HashMap)],
  ),
  caption: "Pattern di trasformazione per costrutti complessi",
  kind: "Tabella",
  supplement: "Tabella"
) <tab:trasformazioni-complesse>

Come illustrato nella #ref-table(<tab:trasformazioni-complesse>), questi pattern richiedono un'analisi contestuale per determinare la strategia ottimale, mantenendo la leggibilità del codice e facilitando il debugging durante la fase di transizione.

==== Costrutti problematici e soluzioni architetturali

I costrutti senza equivalenti diretti rappresentano la sfida più significativa della migrazione, richiedendo riprogettazione completa:

#figure(
  table(
    columns: (1fr, 2fr),
    align: (left, left),
    [*Costrutto COBOL*], [*Soluzione architetturale Java*],
    [ALTER statement], [Pattern Strategy con selezione dinamica del comportamento],
    [UNSTRING], [String.split() con logica custom per overflow e contatori],
    [EXAMINE], [Pattern Matcher con espressioni regolari],
    [NEXT SENTENCE], [Controllo di flusso ristrutturato con flag booleani],
    [SORT/MERGE files], [Collections.sort() o Stream API con Comparator],
    [Report Writer], [Template engine (Jasper, Velocity) o generazione PDF],
    [Screen Section], [Framework GUI (Swing/JavaFX) o web UI],
  ),
  caption: "Soluzioni architetturali per costrutti senza equivalenti diretti",
  kind: "Tabella",
  supplement: "Tabella"
) <tab:costrutti-problematici>

La #ref-table(<tab:costrutti-problematici>) evidenzia come questi costrutti richiedano non solo una traduzione sintattica ma una completa reinterpretazione semantica nel contesto delle architetture Java moderne, spesso comportando l'introduzione di librerie esterne o framework specifici.

=== Valutazione delle soluzioni esistenti <subsec:valutazione-soluzioni>

==== Soluzioni open-source

L'analisi del ProLeap COBOL parser, in #ref-figure(<fig:proLeap>), uno dei progetti open-source più maturi nello spazio di GitHub, ha rivelato un'architettura solida basata su #acronym("ANTLR")4 con capacità complete di analisi sintattica. Tuttavia, il sistema si limitava alla generazione dell'#acronym("AST"), richiedendo l'implementazione separata della trasformazione AST COBOL → AST Java e della successiva generazione del codice. Ad ogni modo il ProLeap parser presentava una architettura modulare che permetteva l'estensione per nuovi costrutti.
#numbered-figure(
  image("../images/proleap.png",width: 80%),
  caption: "ProLeap COBOL parser",
) <fig:proLeap>
==== Soluzioni enterprise

Il panorama presentava soluzioni commerciali sofisticate con prezzi corrispondentemente elevati. Essendo soluzioni chiuse al pubblico ho avuto modo di testare tali soluzioni solo in modo limitato, quando prove gratuite o soluzioni demo lo permettevano.

In particolare, grazie alle soluzioni di prova per sviluppatori, ho potuto mettere mano a IBM WatsonX Code Assistant for Z, estensione mostrata in #ref-figure(<fig:watsonx>), che rappresenta attualmente lo stato dell'arte nell'applicazione dell'intelligenza artificiale alla modernizzazione legacy. La soluzione IBM non si limita alla traduzione sintattica ma tenta di comprendere il contesto aziendale del codice tramite l'interazione e interconnessione con l'intelligenza artificiale.
#numbered-figure(
  image("../images/watsonx.png",width: 80%),
  caption: "IBM WatsonX Code Assistant for Z",
  source: "https://www.community.ibm.com/",
) <fig:watsonx>
Durante la demo, la quale si presentava come chatbot integrato nell'IDE di riferimento (nel mio caso Visual Studio Code), una rappresentazione visiva in #ref-figure(<fig:watsonX-chat>), ho osservato come il sistema potesse riconoscere schemi di dominio, desse suggerimenti di modernizzazione architetturale (conversione a microservizi dove appropriato), generazione di test automatici basati sulla comprensione del comportamento atteso, e documentazione automatica che catturava l'intento aziendale tramite domande di contesto oltre che puramente tecniche.

La soluzione presentava barriere significative per un progetto di ricerca:

- costo proibitivo per licenze, anche di sviluppo
- natura proprietaria che impediva personalizzazione profonde
- requisiti di infrastruttura aziendale
- vincolo con l'ecosistema IBM

#numbered-figure(
  image("../images/watsonxChat.png",width: 40%),
  caption: "Chatbot di IBM WatsonX Code Assistant for Z",
  source: "https://community.ibm.com/",
) <fig:watsonX-chat>


Altre soluzioni enterprise che ho preso in analisi erano Micro Focus, Modern Systems e TSRI che risultavano però meno di valore per qualità-costo dei contenuti producibili, pertanto ho approfondito meno queste tecnologie.

Alla luce di tutte le ricerche, sia open-source che enterprise, ho potuto constatare un vuoto significativo sul tema nel mercato. Le soluzioni open-source, pur essendo accessibili, mancavano di sofisticazione e producevano risultati incompleti che richiedevano estese implementazioni e modifiche manuali. Le soluzioni aziendali, pur essendo potenti, erano inaccessibili per la maggior parte delle organizzazioni a causa dei costi#footnote[I costi delle soluzioni enterprise variano da €100.000 a €1.000.000 per licenza annuale, a seconda della dimensione del deployment].

Questo vuoto mi suggeriva un'opportunità per una soluzione che combinasse l'accessibilità dell'open-source con capacità più sofisticate di comprensione e trasformazione. La recente democratizzazione dell'AI generativa attraverso API accessibili apriva possibilità precedentemente riservate solo a fornitori e clienti con risorse massive.

Inoltre, l'analisi delle soluzioni esistenti mi ha fatto notare schemi comuni:

- le migrazioni che preservavano la logica di business erano le più richieste
- l'importanza della documentazione e della tracciabilità nel processo di migrazione
- la necessità di un approccio interattivo col personale umano per una validazione iterativa del codice prodotto
- il valore di preservare la conoscenza di dominio incorporata nel codice legacy

Queste riflessioni hanno formato significativamente gli approcci che avrei adottato nelle fasi successive del progetto, suggerendo che una soluzione efficace avrebbe dovuto combinare "automatizzazione intelligente" con comprensione semantica profonda, preservazione della logica aziendale con modernizzazione dell'implementazione e accessibilità.

== Secondo periodo: sviluppo del parser tradizionale <sec:parser-tradizionale>

Forte delle conoscenze acquisite sul linguaggio COBOL e dell'analisi delle soluzioni esistenti, ho intrapreso lo sviluppo dell'analizzatore sintattico basato su un approccio deterministico ibrido tradizionale che conciliasse l'utilizzo di tecnologie open-source, ProLeap, e l'implementazione autonomo di un sistema di traduzione dell'AST COBOL in un AST Java corrispondente e successivo passaggio a codice sorgente.

=== Implementazione del parser Java <subsec:implementazione-parser>

L'obiettivo era implementare un sistema modulare ed estensibile che potesse crescere incrementalmente man mano che nuovi costrutti COBOL venivano supportati.

L'architettura seguiva il classico modello di compilatore a pipeline, la sua raffigurazione sequenziale è mostrata in #ref-figure(<fig:parser-pipeline>):

+ Il *Lexer di ProLeap* gestiva la tokenizzazione del codice COBOL, affrontando le peculiarità del linguaggio come la sensibilità alla colonna (le colonne 1-6 riservate per numeri di linea, colonna 7 per indicatori speciali, colonne 8-72 per il codice effettivo), la gestione dei commenti e delle linee di continuazione

+ Il *Parser di ProLeap* costruiva l'albero sintattico astratto (#acronym("AST")) basandosi sulla grammatica COBOL definita in ANTLR4

+ Il *Traduttore custom* (da implementare) trasformava l'AST COBOL nell'AST Java corrispondente, gestendo le differenze semantiche tra i due linguaggi

+ Il *Generatore di codice* (da implementare) convertiva l'AST Java annotato in codice sorgente Java idiomatico
#numbered-figure(
  image("../images/fasiPipeline.png",width: 60%),
  caption: "Pipeline del parser COBOL → Java",
) <fig:parser-pipeline>

L'implementazione del traduttore custom e generatore di codice è proceduta in parallelo, per divisioni COBOL:

- *IDENTIFICATION DIVISION*, punto di partenza naturale per la sua semplicità strutturale e prevedibilità. Questa divisione, contenendo principalmente metadati senza impatto diretto sulla logica del programma, forniva contesto essenziale per la comprensione del sistema. 
  Ho sviluppato un analizzatore basato su pattern matching che estraeva sistematicamente le informazioni standard: PROGRAM-ID, AUTHOR, INSTALLATION, DATE-WRITTEN e REMARKS.
    La strategia di conversione per questa divisione prevedeva una trasformazione semanticamente ricca dei metadati:
    - Il PROGRAM-ID veniva convertito nel nome della classe Java principale, applicando le convenzioni di denominazione Java (trasformazione da KEBAB-CASE o UNDERSCORE_CASE a CamelCase)
    - Le informazioni di contesto (AUTHOR, INSTALLATION, DATE-WRITTEN) venivano preservate in un blocco JavaDoc strutturato in testa alla classe, mantenendo la completa tracciabilità con il programma originale e rispettando gli standard di documentazione Java
    #figure(
      {
        ```cobol
        IDENTIFICATION DIVISION.
        PROGRAM-ID. GESTIONE-CONTI.
        AUTHOR. ANNALISA EGIDI.
        DATE-WRITTEN. 2025-05-15.
        ```
        ```java
        /**
         * GESTIONE-CONTI
         * Author: ANNALISA EGIDI
         * Date Written: 2025-05-15
         * 
         * Converted from COBOL on: 2025-06-20
         */
        public class GestioneConti {
            // ...
        }
        ```
      },
      caption: "Trasformazione della IDENTIFICATION DIVISION in JavaDoc",
      kind: "Codice",
      supplement: "Listato"
    ) <lst:identification-transform>
- La *ENVIRONMENT DIVISION* ha presentato le prime sfide sostanziali. Questa divisione, che specifica l'ambiente di esecuzione del programma COBOL includendo informazioni su hardware, sistema operativo e mappatura dei file, riflette un'epoca in cui tali dettagli erano critici per l'esecuzione. Nel contesto moderno, molte di queste informazioni risultano obsolete o vengono gestite attraverso meccanismi completamente diversi.
  Ho sviluppato una strategia di conversione che preservava le informazioni semanticamente rilevanti mentre scartava quelle puramente storiche:
    - La CONFIGURATION SECTION, contenente SOURCE-COMPUTER e OBJECT-COMPUTER, veniva convertita in commenti documentativi strutturati, preservando l'informazione per riferimento storico senza impatto sul codice generato
    - Nella INPUT-OUTPUT SECTION, particolarmente la FILE-CONTROL, ogni dichiarazione di file in COBOL include non solo il nome logico del file ma anche dettagli critici sulla sua organizzazione (sequenziale, indicizzata, relativa), modalità di accesso (sequenziale, random, dinamica), e strategie di gestione degli errori.#linebreak()
      Ho implementato un sistema di mapping che traduceva le dichiarazioni COBOL in configurazioni Java moderne. Ad esempio, una dichiarazione COBOL come in #ref-figure(<lst:gestione-file-cobol>).
        #source-code(
          ```cobol
          SELECT CUSTOMER-FILE ASSIGN TO CUSTMAST.DAT
              ORGANIZATION IS INDEXED
              ACCESS MODE IS RANDOM
              RECORD KEY IS CUSTOMER-ID
          ```,
          lang: "cobol",
          caption: "Esempio di dichiarazione file COBOL"
        ) <lst:gestione-file-cobol>

          veniva trasformata in una configurazione che utilizzava classi di accesso ai file Java con appropriati livelli di astrazione, preservando la semantica COBOL (accesso indicizzato, chiave di record) mentre si integrava con le API Java moderne per I/O.

  - La *DATA DIVISION* ha rappresentato la sfida tecnica più significativa di questa fase. La complessità derivava dal sistema gerarchico di definizione dei dati in COBOL, che utilizza numeri di livello (01-49, 66, 77, 88) per definire strutture dati annidate con semantiche specifiche, un esempio è rappresentato in #ref-figure(<lst:movimento-bancario>). Ho implementato un analizzatore ricorsivo che costruiva una rappresentazione interna completa della gerarchia dei dati, gestendo:

    - I livelli 01 che definiscono record di primo livello
    - I livelli 02-49 che creano strutture gerarchiche
    - Il livello 66 per la ridefinizione di gruppi di campi
    - Il livello 77 per variabili indipendenti
    - Il livello 88 per valori condizionali (condition names)
    #source-code(
      ```cobol
      01 WS-MOVIMENTO.
        05 WS-DATA-MOV      PIC X(10).
        05 WS-TIPO-MOV      PIC X(1).
            88 DEPOSITO      VALUE 'D'.
            88 PRELIEVO      VALUE 'P'.
        05 WS-IMPORTO-MOV   PIC S9(7)V99 COMP-3.
      ```,
      lang: "cobol",
      caption: "Struttura dati COBOL per la gestione dei movimenti bancari"
    ) <lst:movimento-bancario>

    La conversione in strutture Java appropriate si è rivelata particolarmente complessa. Un approccio naïve di mappare ogni elemento di gruppo su una classe Java e ogni elemento elementare su un campo produceva codice eccessivamente verboso e non idiomatico. Ho quindi sperimentato due strategie complementari:

    - *Appiattimento selettivo*: per gerarchie semplici, i campi venivano appiattiti in una singola classe con nomi composti (es. CUSTOMER-NAME-FIRST diventava customerNameFirst)

    - *Preservazione gerarchica*: per strutture complesse o quando la gerarchia aveva significato semantico, utilizzavo classi Java annidate che riflettevano la struttura originale

    La gestione delle *PICTURE clauses* ha richiesto un'attenzione particolare. Queste clausole non definiscono solo tipo e dimensione dei dati, ma anche formattazione, gestione del segno, allineamento decimale e altre caratteristiche di presentazione. Ho sviluppato un mini-parser specializzato per le PICTURE clauses che le decompone in attributi gestibili:
      #figure(
        table(
          columns: (1fr, 1fr, 2fr),
          align: (left, left, left),
          [*PIC Clause*], [*Tipo Java*], [*Note di conversione*],
          [PIC 9(5)], [int], [Validazione del range 0-99999],
          [PIC X(30)], [String], [Lunghezza massima 30 caratteri],
          [PIC 9(7)V99], [BigDecimal], [Precisione 9 cifre, 2 decimali],
          [PIC S9(5) COMP-3], [BigDecimal], [Gestione speciale per packed decimal],
        ),
        caption: "Mappatura delle PICTURE clauses COBOL verso tipi Java",
        kind: "Tabella",
        supplement: "Tabella"
      ) <tab:picture-clauses>

=== Analisi critica e limiti dell'approccio <subsec:limiti-approccio>

Dopo tre settimane di sviluppo intensivo, dedicando la maggior parte del tempo all'implementazione e raffinamento dell'analizzatore, i limiti intrinseci dell'approccio tradizionale sono diventati evidenti. Quello che era iniziato come un esercizio accademico ambizioso ma fattibile si era trasformato in un progetto di complessità esponenzialmente crescente.

La PROCEDURE DIVISION, che contiene la logica applicativa vera e propria, ha rappresentato il punto di rottura: la complessità dei costrutti e delle loro interazioni suggeriva mesi aggiuntivi di sviluppo solo per una copertura parziale.

Il sistema che avevo sviluppato copriva circa il 25% dei costrutti presenti nei codici prodotti nel primo periodo ed una percentuale ancora meno soddisfacente rispetto ai costrutti necessari per gestire programmi del mondo reale.

Continuare l'esplorazione lineare suggeriva almeno altri 2-3 mesi di sviluppo solo per completare la copertura sintattica, ma la complessità non era lineare - ogni nuovo costrutto interagiva con quelli esistenti in modi che richiedevano ristrutturazione del codice esistente.

In una sessione di retrospettiva con la tutor aziendale, Arianna Bellino, abbiamo analizzato criticamente i risultati ottenuti e le prospettive future arrivando alla necessità di esplorazione di alternative più innovative.

== Terzo periodo: pivot verso l'intelligenza artificiale <sec:pivot-ai>

La necessità di identificare alternative metodologiche innovative, combinata con l'analisi delle soluzioni enterprise esistenti e le evidenze raccolte durante lo sviluppo del parser tradizionale, ha determinato l'adozione dell'intelligenza artificiale generativa come approccio risolutivo per il problema della migrazione COBOL-Java. L'evoluzione recente delle capacità dei modelli linguistici di grandi dimensioni (#acronym("LLM")) nel dominio della comprensione e generazione del codice ha aperto nuove prospettive per affrontare la complessità intrinseca della traduzione tra paradigmi di programmazione eterogenei.

=== Valutazione delle API di AI generativa <subsec:valutazione-api-ai>

L'organizzazione ospitante, Miriade, disponeva di accesso enterprise all'#acronym("API") di Google Gemini Pro, fattore che ha determinato la scelta tecnologica e permesso di focalizzare l'analisi sulle capacità specifiche del modello per il task di traduzione del codice.

Google Gemini Pro presentava caratteristiche tecniche particolarmente adatte al progetto di migrazione. Il modello, già dall'interazione via chat dal sito https://gemini.google.com/, con upload dei file da tradurre, dimostrava una comprensione sofisticata non solo della sintassi dei linguaggi di programmazione, ma anche della semantica sottostante. Questa comprensione contestuale si rivelava essenziale per produrre traduzioni che preservassero l'intento originale del codice mentre lo modernizzavano per l'ecosistema Java.

La valutazione delle prestazioni del modello ha comportato test sistematici su tre dimensioni principali:

+ *Consistenza delle traduzioni*: verifiche ripetute hanno confermato che input identici producevano output funzionalmente equivalenti #foreign("across") multiple sessioni, con variazioni minime limitate a scelte stilistiche non impattanti sulla logica.

+ *Gestione della complessità*: il modello dimostrava capacità di tradurre costrutti COBOL avanzati preservando la logica di business anche in presenza di pattern procedurali complessi e interdipendenze tra moduli.

+ *Qualità del codice prodotto*: l'output generato rispettava consistentemente gli standard Java moderni, producendo codice idiomatico che un developer Java considererebbe naturale e manutenibile.

Un aspetto cruciale nella valutazione riguardava la gestione dei limiti di token. I programmi COBOL enterprise possono essere estremamente verbosi, con sezioni di dichiarazione dati che occupano centinaia di righe. Gemini Pro offriva un limite di token sufficientemente elevato per gestire la maggior parte dei programmi senza necessità di segmentazione, caratteristica che semplificava notevolmente l'architettura del sistema eliminando la complessità della gestione di traduzioni parziali e successive riconciliazioni.

=== #foreign("Design") del sistema #foreign("AI-powered") <subsec:design-sistema-ai>
Il sistema è stato progettato seguendo tre principi architetturali fondamentali che ne guidano ogni aspetto implementativo:
- *Comprensione semantica olistica*: il sistema non si limita a mappare costrutti sintattici ma analizza il contesto aziendale del codice tramite richiesta di dettagli, interpreta l'intento oltre la forma superficiale, e preserva la logica di dominio durante la trasformazione. Questo approccio permette, ad esempio, di riconoscere che una serie di PERFORM statements in COBOL implementa un pattern di elaborazione batch e tradurlo in un design pattern Iterator in Java, mantenendo la semantica mentre si modernizza l'implementazione.
- *Integrazione contestuale*: COBOL raramente esiste in isolamento, essendo tipicamente integrato con sistemi di gestione dati attraverso SQL embedded o file system proprietari. Il design prevede l'analisi congiunta di codice e schema database, permettendo al sistema di comprendere le relazioni tra logica applicativa e struttura dei dati. Questa visione integrata produce codice Java che non solo traduce le operazioni COBOL ma ottimizza anche l'interazione con il database secondo pattern moderni come connection pooling e prepared statements.
- *Automazione end-to-end*: l'obiettivo di minimizzare l'intervento umano ha guidato la progettazione di un sistema che produce non solo codice tradotto ma progetti completi pronti per il deployment. Questo include la generazione automatica della struttura del progetto, la configurazione del build system, la risoluzione delle dipendenze, e la produzione di documentazione.

L'implementazione si articola in tre moduli principali, ciascuno con responsabilità ben definite ma interconnesse attraverso interfacce chiare:
- Il *modulo di traduzione* costituisce il cuore del sistema. La sua architettura interna gestisce la costruzione di prompt ottimizzati che codificano la conoscenza domain-specific necessaria per guidare il modello nella traduzione. Il modulo implementa meccanismi di gestione dell'interazione con l'API, includendo retry logic con #gls("backoff esponenziale") per gestire eventuali limitazioni di rate o errori transitori. La validazione dell'output avviene attraverso parsing del codice Java generato per assicurare completezza sintattica e presenza di tutti gli elementi strutturali attesi.
  La configurazione dei parametri generativi ha richiesto una fase di sperimentazione per identificare i valori di generazione ottimali:
  -  La temperatura è stata impostata a 0.1, valore estremamente basso che garantisce output deterministici e consistenti, essenziale per un processo di migrazione che richiede ripetibilità. 
  - Il parametro top-p, configurato a 0.9, e top-k, limitato a 20, sono stati calibrati per bilanciare la capacità del modello di esplorare soluzioni diverse mantenendo al contempo un controllo stretto sulla qualità e coerenza dell'output. 
  - Il limite di 20.000 token di output era sufficiente per i codici sviluppati nel primo periodo.
- Il *modulo di packaging* trasforma il codice Java raw in un progetto Maven completo. Il punto di forza del modulo risiede nella sua capacità di analizzare il codice generato per identificare automaticamente le dipendenze necessarie. Utilizzando nuovamente Gemini, il modulo esamina gli import statements e l'uso effettivo delle API per determinare non solo quali librerie sono necessarie ma anche le versioni appropriate basandosi su compatibilità e best practice correnti. La generazione del file pom.xml avviene dinamicamente, producendo configurazioni complete che includono sia le dipendenze che anche la configurazione appropriata dei plugin per compilazione, testing, e packaging.
- Il *modulo di orchestrazione* fornisce il layer di coordinamento che trasforma i componenti individuali in un sistema coeso. Implementa una pipeline di esecuzione che gestisce il flusso dei dati tra i moduli, monitora il progresso della conversione, e gestisce condizioni di errore con strategie di recovery appropriate. Il logging da terminale strutturato fornisce visibilità completa sul processo di conversione, essenziale per debugging e audit in contesti enterprise.
Una rappresentazione semplificata e schematica del sistema è mostrata in #ref-figure(<fig:architettura-sistema-ai>).
#numbered-figure(
  image("../images/flussopy.png",width: 100%),
  caption: "Rappresentazione schematica del sistema di migrazione AI-driven",
) <fig:architettura-sistema-ai>
Il flusso di elaborazione segue una sequenza logica che massimizza le probabilità di successo della conversione. La fase iniziale di acquisizione e validazione assicura che gli input siano completi e ben formati, prevenendo errori downstream. Segue una fase di pre-processamento dove il codice viene normalizzato e preparato per l'analisi, rimuovendo elementi non significativi, preservando struttura e commenti per la comprensione del contesto.

La fase di generazione del prompt rappresenta il momento critico dove la conoscenza sulla migrazione viene codificata in forma processabile dal modello. Il prompt non è una semplice richiesta ma una specifica dettagliata che include il ruolo del modello, il contesto della traduzione, esempi di pattern di trasformazione, e requisiti specifici per l'output. La costruzione del prompt sfrutta template parametrizzati che vengono istanziati con il codice specifico e lo schema database, assicurando consistenza mentre si adatta al contesto specifico.

L'elaborazione della risposta del modello richiede parsing e validazione. Il sistema deve estrarre il codice Java dalla risposta del modello, che può includere spiegazioni o metadati aggiuntivi, validare la completezza e correttezza sintattica del codice estratto, e prepararlo per le fasi successive di packaging assicurando che tutti gli elementi necessari siano presenti.

== Quarto periodo: implementazione della soluzione AI-driven <sec:implementazione-ai>

L'implementazione operativa del sistema di migrazione basato su intelligenza artificiale ha trasformato il design concettuale in una soluzione funzionale sorprendente, capace di gestire non solo la complessità del codice COBOL autoprodotto ma anche di eventuali necessità enterprise. Questo periodo è stato caratterizzato da un approccio iterativo dove ogni componente veniva sviluppato, testato sui programmi COBOL di esempio creati nella prima fase, e raffinato basandosi sui risultati ottenuti.

=== Sviluppo del prompt engineering <subsec:prompt-engineering>

Il #gls("prompt engineering") era l'elemento più critico per il successo della traduzione #foreign("AI-driven"). Il processo di sviluppo del prompt ha seguito una metodologia empirica basata su cicli di sperimentazione e raffinamento.

Il prompt doveva stabilire chiaramente il contesto operativo, definendo il modello come un compilatore capace di comprendere non solo sintassi ma semantica e intento aziendale. Questa definizione di ruolo si è dimostrata cruciale per orientare il comportamento del modello verso traduzioni che privilegiassero la preservazione della logica di business rispetto alla traduzione letterale.

Il corpo del prompt include sezioni strutturate che guidano il modello attraverso il processo di traduzione:
- La sezione di input fornisce il codice COBOL completo insieme allo schema SQL quando disponibile, permettendo al modello di comprendere il contesto completo dell'applicazione
- Le istruzioni di traduzione specificano come gestire costrutti specifici, fornendo mappature esplicite per tipi di dato, pattern di trasformazione per strutture di controllo, e linee guida per la gestione di costrutti senza equivalenti diretti in Java.

L'ottimizzazione iterativa del prompt ha richiesto analisi sistematica dei risultati di traduzione. Ogni fallimento o traduzione sub-ottimale forniva informazioni preziose su ambiguità o lacune nelle istruzioni. Pattern comuni di errore includevano:

- Gestione inadeguata delle transazioni database, inizialmente risolta aggiungendo istruzioni specifiche sulla struttura dei blocchi try-catch e la gestione del rollback

- Traduzione letterale di costrutti COBOL che produceva codice Java non idiomatico, affrontata attraverso esempi di pattern di trasformazione preferiti

- Perdita di informazioni sui tipi di dato durante la conversione, corretta specificando mappature esplicite e regole di inferenza

La gestione dei casi speciali ha richiesto particolare attenzione nella formulazione del prompt. Costrutti COBOL come REDEFINES, che permettono interpretazioni multiple della stessa area di memoria, non hanno equivalenti diretti in Java. Il prompt è stato evoluto per includere strategie specifiche di gestione, suggerendo l'uso di classi wrapper con metodi di conversione espliciti. Similarmente, la gestione delle tabelle COBOL con OCCURS DEPENDING ON ha richiesto istruzioni per la creazione di strutture dati dinamiche appropriate in Java, tipicamente ArrayList o array ridimensionabili.

Un aspetto innovativo dello sviluppo del prompt è stata l'inclusione di meta-istruzioni che guidano il processo di ragionamento del modello. Invece di fornire solo regole di traduzione meccaniche, il prompt incoraggia il modello a considerare, tramite analisi autonoma, l'intento del codice originale, e produrre soluzioni che un developer Java moderno considererebbe naturali. Questo approccio ha prodotto traduzioni significativamente migliori rispetto a prompt puramente prescrittivi.

=== Implementazione del translator completo <subsec:translator-completo>

Lo sviluppo del sistema di conversione end-to-end ha richiesto l'integrazione di tutti i componenti in un flusso operativo coerente. L'implementazione si è concentrata sulla creazione di un sistema capace di gestire la varietà e complessità del codice COBOL reale.

Il sistema analizza la gerarchia dei level numbers per costruire una rappresentazione interna della struttura dati. Questa analisi identifica:

- Record di primo livello (level 01) che diventano classi Java principali
- Strutture subordinate che vengono mappate a inner classes o campi semplici basandosi sulla complessità
- Elementi ripetuti (OCCURS) che richiedono array o collezioni
- Ridefinizioni (REDEFINES) che necessitano di gestione speciale attraverso union-like patterns

Il processo di generazione delle classi Java corrispondenti applica convenzioni di naming standard, trasformando nomi COBOL in stile KEBAB-CASE in camelCase Java, un sempio in #ref-figure(<lst:confronto-sintassi>). La generazione include automaticamente metodi getter e setter appropriati, costruttori per inizializzazione, e metodi utility per conversioni quando ritenuto necessario dal modello.
#figure(
  table(
    columns: 2,
    stroke: none,
    ```cobol
    MOVE WS-IMPORTO TO WS-SALDO
    ADD 100 TO WS-SALDO
    ```,
    ```java
    wsSaldo = wsImporto;
    wsSaldo = wsSaldo.add(new BigDecimal("100"));
    ```
  ),
  caption: "Confronto tra sintassi COBOL e Java per operazioni aritmetiche",
  kind: "Codice",
  supplement: "Listato"
) <lst:confronto-sintassi>

La traduzione dell'SQL embedded ha richiesto particolare attenzione alla preservazione della semantica transazionale. Il sistema identifica i blocchi EXEC SQL attraverso pattern matching, estrae gli statement SQL e le variabili host coinvolte, e genera codice JDBC equivalente. La generazione utilizza sempre PreparedStatement per prevenire SQL injection, implementa gestione appropriata delle connessioni con pattern try-with-resources, preserva la logica di gestione errori COBOL attraverso mappature SQLCODE appropriate, e mantiene la semantica transazionale con commit e rollback espliciti.

Un aspetto critico dell'implementazione riguarda la preservazione della logica di business durante la trasformazione. Il translator riconosce pattern comuni nel codice COBOL procedurale e li trasforma in equivalenti object-oriented appropriati: 
- I PERFORM statements vengono analizzati per determinare se rappresentano semplici chiamate di subroutine o pattern più complessi come iterazioni
- Le SECTION e PARAGRAPH della PROCEDURE DIVISION vengono trasformate in metodi Java, come illustrato nel'esempio #ref-figure(<lst:section-to-methods>), preservando la struttura logica mentre si adotta l'organizzazione object-oriented
#figure(
  {
    ```cobol
    PROCEDURE DIVISION.
    DISPLAY-MENU.
        DISPLAY "1. Apertura conto"
        DISPLAY "2. Deposito"
        DISPLAY "0. Esci".
    
    PROCESS-CHOICE.
        ACCEPT WS-SCELTA
        EVALUATE WS-SCELTA
            WHEN '1' PERFORM OPEN-ACCOUNT
            WHEN '2' PERFORM MAKE-DEPOSIT
        END-EVALUATE.
    ```
    ```java
    public class GestioneConti {
        private void displayMenu() {
            System.out.println("1. Apertura conto");
            System.out.println("2. Deposito");
            System.out.println("0. Esci");
        }
        
        private void processChoice() {
            String scelta = scanner.nextLine();
            switch (scelta) {
                case "1": openAccount(); break;
                case "2": makeDeposit(); break;
            }
        }
    }
    ```
  },
  caption: "Trasformazione di SECTION e PARAGRAPH COBOL in metodi Java",
  kind: "Codice",
  supplement: "Listato"
) <lst:section-to-methods>
Per quanto riguarda la gestione degli errori, COBOL spesso utilizza gestione degli errori implicita attraverso controlli di status code, mentre Java favorisce exception handling esplicito. Il translator aggiunge automaticamente blocchi try-catch appropriati dove necessario, preserva i codici di errore COBOL per compatibilità mentre aggiunge exception handling Java, implementa logging strutturato per facilitare debugging e manutenzione, e crea classi di eccezione custom quando pattern di errore specifici lo richiedono.

=== Generazione automatica di progetti Maven <subsec:generazione-maven>

La fase finale del processo di migrazione trasforma il codice Java generato in un progetto completo pronto per il deployment. Questa fase sfrutta nuovamente le capacità di Gemini per analizzare il codice e determinare tutti i requisiti di progetto.

L'analisi delle dipendenze inizia con l'esame degli import statements nel codice Java generato. Il sistema utilizza Gemini per comprendere non solo quali classi vengono importate ma come vengono utilizzate nel codice. Questa analisi contestuale permette di identificare le librerie necessarie con le versioni appropriate, determinare dipendenze transitive che potrebbero essere richieste, escludere dipendenze non necessarie che potrebbero essere state importate ma non utilizzate, e risolvere potenziali conflitti di versione basandosi su best practice correnti.

La struttura del progetto Maven viene generata seguendo le convenzioni standard. Il sistema crea automaticamente la gerarchia di directory appropriata, posiziona il codice sorgente nelle location corrette secondo il package structure, prepara directory per risorse, configurazioni, e test, e predispone la struttura per facilitare future estensioni e manutenzione.

La generazione del file pom.xml rappresenta un elemento critico del processo. Il sistema produce configurazioni complete che specificano:

- Coordinate del progetto (groupId, artifactId, version) derivate dal nome del programma COBOL originale
- Proprietà del progetto includendo versioni Java, encoding, e altre configurazioni standard
- Dipendenze identificate attraverso l'analisi del codice con versioni appropriate
- Configurazione dei plugin Maven per compilazione, testing, e packaging
- Profili per diversi ambienti di deployment quando identificati dal contesto

La configurazione dei plugin Maven riceve particolare attenzione per assicurare che il progetto possa essere costruito e deployato senza modifiche manuali:
- Il maven-compiler-plugin viene configurato con la versione Java appropriata basata sulle feature utilizzate nel codice
- Il maven-jar-plugin include configurazione per generare JAR eseguibili con manifest appropriato
- Il maven-assembly-plugin viene configurato per creare "fat JARs" che includono tutte le dipendenze, semplificando il deployment, come esemplificato nel #ref-figure(<lst:pom-generated>)
  #source-code(
    ```xml
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>postgresql</artifactId>
        <version>42.7.1</version>
    </dependency>
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <configuration>
            <source>11</source>
            <target>11</target>
        </configuration>
    </plugin>
    ```,
    lang: "xml",
    caption: "Estratto del pom.xml generato automaticamente"
  ) <lst:pom-generated>

Il processo di build automatizzato verifica la correttezza della configurazione attraverso l'invocazione di Maven per compilare il codice, risolvere e scaricare tutte le dipendenze, eseguire eventuali test di base generati, e produrre gli artifact finali. Qualsiasi errore in questa fase viene catturato e reportato con suggerimenti per la risoluzione.

La generazione della documentazione completa il processo. Il sistema preserva i commenti COBOL originali e li arricchisce con informazioni sulla migrazione. I commenti di intestazione dei programmi COBOL vengono trasformati in JavaDoc comprensivi che includono informazioni sull'origine COBOL, data e versione della migrazione, note su trasformazioni significative applicate, e riferimenti alla documentazione originale quando disponibile.

Il risultato finale del processo è un progetto Java completo, moderno, e immediatamente utilizzabile.

== Risultati raggiunti <sec:risultati-raggiunti>

=== Impatto dell'AI sui tempi di sviluppo <subsec:impatto-ai-tempi>
/*L'automazione end-to-end elimina la necessità di interventi manuali post-conversione, riducendo drasticamente i tempi e i costi della migrazione mentre assicura consistenza e qualità del risultato. Questo livello di automazione e intelligenza nella generazione di progetti completi dimostra il valore trasformativo dell'approccio AI-driven rispetto alle metodologie tradizionali di migrazione del codice legacy.*/

In questa sottosezione quantificherò la riduzione importante dei tempi rispetto all'approccio tradizionale, illustrerò il passaggio da mesi a giorni nel processo di conversione e analizzerò i risultati impossibili senza AI.

=== Analisi qualitativa dei risultati <subsec:analisi-qualitativa>

In questa sottosezione descriverò il sistema completo di conversione COBOL-Java funzionante, analizzerò il codice Java idiomatico e manutenibile prodotto e illustrerò la documentazione professionale automatizzata.

=== Risultati quantitativi <subsec:risultati-quantitativi>

In questa sottosezione presenterò i dati concreti: tre progetti convertiti con successo, vasta copertura delle funzionalità e oltre 2000 linee di codice Java di qualità production-ready.