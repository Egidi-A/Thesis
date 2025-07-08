#import "../config/functions.typ": *
#import "../config/foreign-words.typ": foreign

= Il progetto di migrazione COBOL-Java <cap:progetto-migrazione>

Il progetto di #foreign("stage") proposto da Miriade si inserisce in un contesto tecnologico di particolare rilevanza per il settore #acronym("IT") contemporaneo: la modernizzazione dei sistemi #gls("legacy"). Durante il mio percorso, ho avuto l'opportunità di confrontarmi con una problematica comune a molte organizzazioni, in particolare nel settore bancario e assicurativo, dove i sistemi COBOL continuano a costituire l'impalcatura portante di infrastrutture critiche per il #foreign("business").

#define-term("legacy", "Sistemi informatici datati ma ancora in uso")
#define-acronym("COBOL", "Common Business-Oriented Language")
#define-term("mainframe", "Computer di grandi dimensioni per elaborazioni complesse")
#define-term("microservizi", "Architettura software basata su servizi indipendenti")

== Contesto di attualità <sec:contesto-attualita>

I sistemi legacy basati su #acronym("COBOL") rappresentano ancora oggi una parte significativa dell'infrastruttura informatica di molte organizzazioni, specialmente nel settore bancario, finanziario e assicurativo. Nonostante COBOL sia stato sviluppato negli anni '60, ha una presenza significativa nelle moderne architetture.

// Esempio di citazione: La persistenza di COBOL è documentata in numerosi studi @bmc2024state.

#ref-figure(<fig:interfaccia-cobol>) mostra un esempio tipico di interfaccia utente e codice COBOL, che evidenzia il contrasto netto con le moderne interfacce grafiche e paradigmi di programmazione attuali. Questa differenza visuale è solo la punta dell'iceberg delle sfide che comporta il mantenimento di questi sistemi in un ecosistema tecnologico in rapida evoluzione.

#numbered-figure(
  image("../images/COBOL-cli.png"),
  caption: "Interfaccia utente e codice COBOL tipici dei sistemi legacy",
) <fig:interfaccia-cobol>

La problematica della #foreign("legacy modernization") va ben oltre la semplice obsolescenza tecnologica. Durante il mio #foreign("stage"), attraverso l'analisi della letteratura e il confronto con i professionisti del settore, ho potuto identificare come i costi nascosti del mantenimento di questi sistemi includano:

- La crescente difficoltà nel reperire sviluppatori COBOL qualificati @cbtnuggets2024cobol
- L'integrazione sempre più complessa con tecnologie moderne @version1_2024
- I rischi operativi derivanti dall'utilizzo di piattaforme #foreign("hardware") e #foreign("software") che i #foreign("vendor") non supportano più attivamente @luxoft2023banking

Questi fattori si traducono in costi di manutenzione esponenzialmente crescenti e in una ridotta agilità nel rispondere alle esigenze di #foreign("business") in continua evoluzione.

I rischi associati al mantenimento di sistemi COBOL #foreign("legacy") nelle infrastrutture IT moderne sono molteplici e interconnessi:

- *Carenza di competenze*: La carenza di competenze specializzate crea una forte dipendenza da un #foreign("pool") sempre più ristretto di esperti, spesso prossimi al pensionamento @cbtnuggets2024cobol.
- *Documentazione inadeguata*: La documentazione inadeguata o assente di molti di questi sistemi, sviluppati decenni fa, rende ogni intervento di manutenzione un'operazione ad alto rischio @howtogeek2020cobol.
- *Incompatibilità tecnologica*: L'incompatibilità con le moderne pratiche di sviluppo come #foreign("DevOps"), #foreign("continuous integration") e #gls("microservizi") limita in modo significativo la capacità delle organizzazioni di innovare e competere efficacemente nel mercato digitale @cast2024cobol.

Come illustrato in #ref-figure(<fig:confronto-architetture>), il contrasto tra l'architettura monolitica tipica dei sistemi #foreign("mainframe") e l'architettura moderna a microservizi evidenzia le sfide architetturali della migrazione. Questa differenza strutturale comporta non solo una riprogettazione tecnica, ma anche un ripensamento completo dei processi operativi e delle modalità di sviluppo.

#numbered-figure(
  image("../images/monolitic and microsevices application.png", width: 80%),
  caption: "Confronto tra architettura monolitica dei mainframe e architettura moderna a microservizi",
) <fig:confronto-architetture>

La migrazione di questi sistemi verso tecnologie più moderne come Java rappresenta una sfida tecnica e una necessità strategica per garantire la continuità operativa e la competitività delle organizzazioni. Java, con il suo ecosistema maturo, la vasta #foreign("community") di sviluppatori e il supporto per paradigmi di programmazione moderni, si presenta come una delle destinazioni privilegiate per questi progetti di modernizzazione @newrelic2024java.

== Obiettivi e vincoli dello stage <sec:obiettivi-vincoli>

=== Obiettivi <sec:obiettivi>

Riporto le notazioni utilizzate in seguito per identificare gli obiettivi del progetto:

- *O* per i requisiti obbligatori, vincolanti in quanto obiettivo primario richiesto dal committente
- *D* per i requisiti desiderabili, non vincolanti o strettamente necessari, ma dal riconoscibile valore aggiunto
- *F* per i requisiti facoltativi, rappresentanti valore aggiunto non strettamente competitivo

Le sigle precedentemente indicate saranno seguite da una coppia sequenziale di numeri, identificativo del requisito:

==== *Requisiti obbligatori:*
- *O01*: Esplorazione approfondita di diverse strategie di migrazione, dalla conversione sintattica diretta all'utilizzo di tecnologie di intelligenza artificiale generativa
- *O02*: Sviluppo di strumenti specifici che automatizzino il più possibile il processo di conversione
- *O03*: Raggiungimento di conversione automatica del codice COBOL di almeno tre sezioni su quattro
- *O04*: Produzione di almeno un progetto COBOL
- *O05*: Migrazione completa di almeno uno dei progetti COBOL sviluppati nella fase iniziale dello stage
- *O06*: Fornitura di un'interfaccia (grafica o da linea di comando) per l'interazione con il sistema
- *O07*: Produzione di codice Java idiomatico e manutenibile che preservi la #foreign("business logic") originale
- *O08*: Generazione di documentazione #foreign("JavaDoc") professionale per il codice prodotto
- *O09*: Sviluppo di un prototipo funzionante del sistema di conversione
- *O10*: Creazione di un #foreign("README") esplicativo per permettere l'utilizzo del sistema

==== *Requisiti desiderabili:*
- *D01*: Raggiungimento di una copertura del 100% nella conversione automatica del codice prodotto autonomamente
- *D02*: Gestione efficace di costrutti COBOL complessi o non direttamente traducibili
- *D03*: Implementazione di meccanismi di ottimizzazione del codice Java generato

==== *Requisiti facoltativi:*
- *F01*: Integrazione con sistemi di analisi statica per la verifica della qualità del codice generato
- *F02*: Sviluppo di un sistema di #foreign("reporting") dettagliato sulle conversioni effettuate
- *F03*: Implementazione di funzionalità avanzate di #foreign("refactoring") del codice Java prodotto

=== Vincoli <sec:vincoli>

Il progetto si focalizzava sullo sviluppo di un sistema di migrazione automatica e questo aspetto caratterizzava le condizioni imposte per lo svolgimento del lavoro.

==== *Vincoli temporali:*
- Durata complessiva dello #foreign("stage"): 320 ore
- Periodo: dal 05 maggio al 27 giugno 2025
- Modalità di lavoro ibrida: 2 giorni a settimana in sede, 3 giorni in modalità telematica
- Orario lavorativo: 9:00 - 18:00

==== *Vincoli tecnologici:*
- Il sistema doveva essere sviluppato utilizzando tecnologie moderne e supportate
- Necessità di preservare integralmente la #foreign("business logic") contenuta nei programmi COBOL originali
- La soluzione doveva essere scalabile, capace di gestire progetti di diverse dimensioni
- Utilizzo strumenti di versionamento (#foreign("Git")) e di documentazione continua

#ref-figure(<fig:bitbucket-git>) mostra l'interfaccia di BitBucket utilizzata per il versionamento del progetto, evidenziando l'importanza attribuita alla tracciabilità e alla collaborazione nel processo di sviluppo.

#numbered-figure(
  rect(width: 100%, height: 150pt, fill: gray.lighten(80%))[
    _Immagine: utilizzo di BitBucket per versionamento (Git), produzione personale_
  ],
  caption: "Utilizzo di BitBucket per il versionamento del codice",
) <fig:bitbucket-git>

==== *Vincoli metodologici:*
- Adozione dei principi #foreign("Agile") con #foreign("sprint") settimanali e #foreign("stand-up") giornalieri per allineamento costante
- Revisioni settimanali degli obiettivi con adattamento del piano di lavoro

=== Pianificazione concordata <sec:pianificazione>

La pianificazione del progetto seguiva un approccio flessibile, con revisioni settimanali che permettevano di adattare il percorso in base ai progressi ottenuti. La distribuzione delle attività era inizialmente stata organizzata come segue:

==== *Prima fase - analisi e apprendimento COBOL (2 settimane - 80 ore):*
- Studio approfondito del linguaggio COBOL e delle sue peculiarità
- Analisi di sistemi COBOL
- Creazione di programmi COBOL di test con complessità crescente
- Implementazione dell'interfacciamento con #foreign("database") relazionali

==== *Seconda fase - sviluppo del sistema di migrazione (4 settimane - 160 ore):*
- Analisi dei #foreign("pattern") di traduzione COBOL-Java del codice prodotto in fase precedente
- Sviluppo di uno #foreign("script") o utilizzo di #foreign("tool") esistenti per automatizzare la traduzione del codice COBOL in Java equivalente
- Gestione della traduzione dei costrutti sintattici, logica di controllo e interazioni con il #foreign("database")
- Definizione della percentuale di automazione raggiungibile e la gestione di costrutti COBOL complessi o non direttamente traducibili

==== *Terza fase - #foreign("testing") e validazione (1 settimana - 40 ore):*
- #foreign("Test") funzionali sul codice Java generato
- Confronto comportamentale con le applicazioni COBOL originali

==== *Quarta fase - documentazione e consegna (1 settimana - 40 ore):*
- Documentazione completa del sistema sviluppato
- Preparazione del materiale di consegna
- Presentazione finale dei risultati

La rappresentazione temporale dettagliata della pianificazione è visualizzata in #ref-figure(<fig:gantt-pianificazione>), che mostra la distribuzione delle attività lungo l'arco temporale dello stage.

#numbered-figure(
  image("../images/diagrammaGantt.png"),
  caption: "Diagramma di Gantt della pianificazione del progetto",
) <fig:gantt-pianificazione>

== Valore strategico per l'azienda <sec:valore-strategico>

In base a quanto ho potuto osservare e comprendere durante il periodo di #foreign("stage"), la strategia di gestione del progetto di migrazione COBOL-Java dell'azienda ospitante persegue i seguenti obiettivi:

- *Innovazione tecnologica*: l'interesse dell'azienda non era limitato allo sviluppo di una soluzione tecnica specifica, ma si estendeva all'osservazione dell'approccio metodologico e del metodo di studio che una risorsa #foreign("junior") con formazione universitaria avrebbe applicato a un problema complesso di modernizzazione IT.

- *Creazione di competenze interne*: Il progetto permetteva di sviluppare #foreign("know-how") interno su una problematica di crescente rilevanza, preparando l'azienda a potenziali progetti futuri.

- *Esplorazione di tecnologie emergenti*: Il progetto era stato concepito per esplorare la possibile applicazione dell'intelligenza artificiale generativa a problemi di modernizzazione del #foreign("software"). Questo ambito, all'intersezione tra #acronym("AI") e #foreign("software engineering"), può rappresentare una frontiera tecnologica di forte attualità e di interesse per un'azienda che opera già attivamente nel campo dell'AI e dei #foreign("Large Language Models").

- *Sviluppo di #foreign("asset") riutilizzabili*: Sebbene il progetto fosse autoconclusivo, permetteva di ottenere risultati tangibili nel breve termine dello #foreign("stage"), ma con il potenziale di evolversi in soluzioni più ampie e commercializzabili.

== Obiettivi personali e aspettative <sec:obiettivi-personali>

La scelta di intraprendere questo #foreign("stage") presso Miriade è stata guidata da una combinazione di motivazioni tecniche e personali che si allineavano con il mio percorso formativo universitario. Tra le diverse opportunità di #foreign("stage") che avevo valutato, questo progetto si distingueva per due elementi fondamentali:

- *Libertà tecnologica*: La libertà concessami nell'esplorazione delle tecnologie da utilizzare rappresentava un'opportunità unica di sperimentazione e apprendimento.
- *Interesse per COBOL*: Il mio forte interesse nel scoprire di più sul linguaggio COBOL, un affascinante paradosso tecnologico che, nonostante la sua longeva età, continua a essere cruciale nello scenario bancario e assicurativo internazionale.

Il mio percorso di #foreign("stage") mirava principalmente all'acquisizione di competenze pratiche nel campo della modernizzazione di sistemi #foreign("legacy") e gestione progetti:

=== Obiettivi tecnici principali:
- Comprendere la struttura e la logica dei programmi COBOL attraverso lo sviluppo di applicazioni di test
- Esplorare approcci concreti alla migrazione del codice, sia deterministici che basati su AI
- Produrre un prototipo funzionante di sistema di conversione, anche se limitato

=== Competenze da sviluppare:
- Familiarità di base con il linguaggio COBOL e le sue peculiarità sintattiche
- Comprensione pratica delle sfide nella traduzione tra paradigmi di programmazione diversi
- Esperienza nell'utilizzo di tecnologie emergenti come l'AI generativa applicata al codice

=== Crescita professionale attesa:
- Sviluppare autonomia nella gestione di un progetto aziendale, dalla pianificazione all'implementazione
- Acquisire capacità di #foreign("problem solving") in contesti reali, con vincoli temporali e tecnologici definiti
- Migliorare le competenze comunicative attraverso l'interazione con il #foreign("team") e la presentazione dei progressi
- Apprendere metodologie di lavoro #foreign("Agile") applicate a progetti di ricerca e sviluppo
- Sviluppare pensiero critico nella valutazione di soluzioni tecnologiche alternative

#ref-figure(<fig:metodologia-agile>) rappresenta visivamente l'approccio metodologico Agile che ho appreso e applicato durante lo stage, evidenziando il ciclo iterativo di pianificazione, sviluppo, testing e revisione che ha caratterizzato il mio percorso formativo.

#numbered-figure(
  image("../images/agile.png", width: 80%),
  caption: "Rappresentazione della metodologia Agile applicata al progetto",
) <fig:metodologia-agile>