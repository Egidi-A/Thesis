#import "../config/functions.typ": *
#import "../config/foreign-words.typ": *
#import "../appendix/glossary.typ": *
#import "../appendix/acronyms.typ": *

= Il progetto di migrazione #foreign("COBOL-Java") <cap:progetto-migrazione>

Il progetto di #foreign("stage") proposto da Miriade si inserisce in un contesto tecnologico di particolare rilevanza per il settore #acronym("IT") contemporaneo: la modernizzazione dei sistemi #gls("legacy"). 
Durante il mio percorso, ho avuto l'opportunità di confrontarmi con una problematica comune a molte organizzazioni, in particolare nel settore bancario e assicurativo, dove i sistemi COBOL continuano a costituire l'impalcatura portante di infrastrutture critiche per il #foreign("business").

== Contesto di attualità <sec:contesto-attualita>

I sistemi legacy basati su #acronym("COBOL") rappresentano ancora oggi una parte significativa dell'infrastruttura informatica di molte organizzazioni, specialmente nel settore bancario, finanziario e assicurativo. Nonostante COBOL sia stato sviluppato negli anni '60, ha una presenza significativa nelle moderne architetture.

// Esempio di citazione: La persistenza di COBOL è documentata in numerosi studi @bmc2024state.

#ref-figure(<fig:interfaccia-cobol>) mostra un esempio tipico di interfaccia utente e codice COBOL, che evidenzia il contrasto netto con le moderne interfacce grafiche e paradigmi di programmazione attuali. Questa differenza visuale è solo la punta dell'iceberg delle sfide che comporta il mantenimento di questi sistemi in un ecosistema tecnologico in rapida evoluzione.

#numbered-figure(
  image("../images/COBOL-cli.png"),
  caption: "Interfaccia utente e codice COBOL tipici dei sistemi legacy",
  source: "https://overcast.blog",
) <fig:interfaccia-cobol>

La problematica della #foreign("legacy modernization") va ben oltre la semplice obsolescenza tecnologica. Durante il mio #foreign("stage"), attraverso l'analisi della letteratura e il confronto con i professionisti del settore, in particolare ho avuto modo di confrontarmi con la sig.ra Luisa Biagi, analista COBOL, ho potuto identificare come i costi nascosti del mantenimento di questi sistemi includano:

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
  image("../images/monolitic and microsevices application.png", width: 100%),
  caption: "Confronto tra architettura monolitica dei mainframe e architettura moderna a microservizi",
  source: "https://www.atlassian.com",
) <fig:confronto-architetture>

La migrazione di questi sistemi verso tecnologie più moderne come #foreign("Java") rappresenta una sfida tecnica e una necessità strategica per garantire la continuità operativa e la competitività delle organizzazioni. #foreign("Java"), con il suo ecosistema maturo, la vasta #foreign("community") di sviluppatori e il supporto per paradigmi di programmazione moderni, si presenta come una delle destinazioni privilegiate per questi progetti di modernizzazione.

== Obiettivi dello stage <sec:obiettivi>
Il macro-obiettivo era sviluppare un sistema prototipale di migrazione automatica da #acronym("COBOL") a #foreign("Java") che potesse dimostrare la fattibilità di automatizzare il processo di conversione, preservando la #foreign("business logic") originale e producendo codice #foreign("Java") idiomatico e manutenibile.
=== Obiettivi principali
- *Esplorazione tecnologica*: Investigare e valutare diverse strategie di migrazione, dalla conversione sintattica diretta basata su regole deterministiche fino all'utilizzo di tecnologie di intelligenza artificiale generativa, identificando vantaggi e limitazioni di ciascun approccio.
- *Automazione del processo*: Sviluppare strumenti e metodologie che potessero automatizzare il più possibile il processo di conversione, riducendo l'intervento manuale e i conseguenti rischi di errore umano nella traduzione.
- *Qualità del risultato*: Garantire che il codice Java prodotto rispettasse standard di qualità professionale, con particolare attenzione alla leggibilità, manutenibilità e conformità alle convenzioni Java moderne.
- *Accessibilità della soluzione*: Fornire un'interfaccia utente (grafica o da linea di comando) che rendesse il sistema utilizzabile anche da personale non specializzato nella migrazione di codice.
=== Obiettivi operativi
Per rendere concreti e misurabili gli obiettivi principali, sono stati definiti obiettivi operativi specifici, classificati secondo tre livelli di priorità:
#linebreak()
*Obbligatori*
- *OO01*: Sviluppare competenza nel linguaggio COBOL attraverso la produzione di almeno un progetto completo che includesse le quattro divisioni fondamentali (#foreign("Identification"), #foreign("Environment"), #foreign("Data") e #foreign("Procedure"))
- *OO02*: Esplorazione approfondita di diverse strategie di migrazione, dalla conversione sintattica diretta all'utilizzo di tecnologie di intelligenza artificiale generativa
- *OO03*: Implementare un sistema di conversione automatica che raggiungesse almeno il 75% di copertura delle divisioni
- *OO04*: Esplorare e documentare approcci distinti alla migrazione
- *OO05*: Completare la migrazione funzionante di almeno uno dei progetti COBOL sviluppati, validando l'equivalenza funzionale tra codice sorgente e risultato
- *OO06*: Produrre codice #foreign("Java") che rispettasse le convenzioni del linguaggio, includendo struttura dei #foreign("package"), nomenclatura standard e documentazione #foreign("JavaDoc")
- *OO07*: Fornire un'interfaccia utilizzabile (grafica o #acronym("CLI")) per l'esecuzione del sistema di conversione
- *OO08*: Creare documentazione utente completa, includendo un #foreign("README") dettagliato con istruzioni di installazione, configurazione e utilizzo
*Desiderabili*
- *OD01*: Raggiungimento di una copertura del 100% nella conversione automatica del codice prodotto autonomamente
- *OD02*: Gestione efficace di costrutti COBOL complessi o non direttamente traducibili
- *OD03*: Implementazione di meccanismi di ottimizzazione del codice Java generato
*Facoltativi*
- *OF01*: Integrazione con sistemi di analisi statica per la verifica della qualità del codice generato
- *OF02*: Implementare un sistema di #foreign("reporting") dettagliato che producesse metriche sulla conversione, incluse statistiche di copertura, costrutti non convertiti e interventi manuali necessari
- *OF03*: Implementazione di funzionalità avanzate di #foreign("refactoring") del codice Java prodotto

=== Metriche di successo
Per valutare oggettivamente il raggiungimento degli obiettivi, erano state definite le seguenti metriche:

- *Copertura di conversione*: Percentuale di linee di codice COBOL convertite automaticamente senza intervento manuale
- *Equivalenza funzionale*: Corrispondenza #foreign("interfaccia utente") COBOL originale e #foreign("Java") convertito
- *Qualità del codice*: Conformità agli standard #foreign("Java") verificata tramite strumenti di analisi statica
- *Tempo di conversione*: Riduzione del tempo necessario per la migrazione rispetto a un approccio completamente manuale
- *Usabilità*: Capacità di utilizzo del sistema da parte di utenti con conoscenze base di programmazione

== Vincoli <sec:vincoli>

Il progetto si focalizzava sullo sviluppo di un sistema di migrazione automatica e questo aspetto caratterizzava le condizioni imposte per lo svolgimento del lavoro.
#linebreak()
*Vincoli temporali*
- Durata complessiva dello #foreign("stage"): 320 ore
- Periodo: dal 05 maggio al 27 giugno 2025
- Modalità di lavoro ibrida: 2 giorni a settimana in sede, 3 giorni in modalità telematica
- Orario lavorativo: 9:00 - 18:00

*Vincoli tecnologici*
- Il sistema doveva essere sviluppato utilizzando tecnologie moderne e supportate
- Necessità di preservare integralmente la #foreign("business logic") contenuta nei programmi COBOL originali
- La soluzione doveva essere scalabile, capace di gestire progetti di diverse dimensioni
- Utilizzo strumenti di versionamento (#foreign("Git")) e di documentazione continua.
*Vincoli metodologici*
- Adozione dei principi #foreign("Agile") con #foreign("sprint") settimanali e #foreign("stand-up") giornalieri per allineamento costante
- Revisioni settimanali degli obiettivi con adattamento del piano di lavoro

== Pianificazione concordata <sec:pianificazione>

La pianificazione del progetto seguiva un approccio flessibile, con revisioni settimanali che permettevano di adattare il percorso in base ai progressi ottenuti. La distribuzione delle attività era inizialmente stata organizzata come segue:

*Prima fase - analisi e apprendimento COBOL (2 settimane - 80 ore)*

- Studio approfondito del linguaggio COBOL e delle sue peculiarità
- Analisi di sistemi COBOL
- Creazione di programmi COBOL di test con complessità crescente
- Implementazione dell'interfacciamento con #foreign("database") relazionali

*Seconda fase - sviluppo del sistema di migrazione (4 settimane - 160 ore)*

- Analisi dei #foreign("pattern") di traduzione COBOL-Java del codice prodotto in fase precedente
- Sviluppo di uno #foreign("script") o utilizzo di #foreign("tool") esistenti per automatizzare la traduzione del codice COBOL in Java equivalente
- Gestione della traduzione dei costrutti sintattici, logica di controllo e interazioni con il #foreign("database")
- Definizione della percentuale di automazione raggiungibile e la gestione di costrutti COBOL complessi o non direttamente traducibili

*Terza fase - #foreign("testing") e validazione (1 settimana - 40 ore)*

- #foreign("Test") funzionali sul codice Java generato
- Confronto comportamentale con le applicazioni COBOL originali

*Quarta fase - documentazione e consegna (1 settimana - 40 ore)*

- Documentazione completa del sistema sviluppato
- Preparazione del materiale di consegna
- Presentazione finale dei risultati

La rappresentazione temporale dettagliata della pianificazione è visualizzata in #ref-figure(<fig:gantt-pianificazione>), che mostra la distribuzione delle attività lungo l'arco temporale dello stage.

#numbered-figure(
  image("../images/diagrammaGantt.png"),
  caption: "Diagramma di Gantt della pianificazione del progetto",
) <fig:gantt-pianificazione>

== Valore strategico per l'azienda <sec:valore-strategico>

In base a quanto ho potuto osservare e comprendere durante il periodo di #foreign("stage"), la strategia di gestione del progetto di migrazione #foreign("COBOL-Java") dell'azienda ospitante persegue i seguenti obiettivi:

- *Innovazione tecnologica*: l'interesse dell'azienda non era limitato allo sviluppo di una soluzione tecnica specifica, ma si estendeva all'osservazione dell'approccio metodologico e del metodo di studio che una risorsa #foreign("junior") con formazione universitaria avrebbe applicato a un problema complesso di modernizzazione #foreign("IT").

- *Creazione di competenze interne*: Il progetto permetteva di sviluppare #foreign("know-how") interno su una problematica di crescente rilevanza, preparando l'azienda a potenziali progetti futuri.

- *Esplorazione di tecnologie emergenti*: Il progetto era stato concepito per esplorare la possibile applicazione dell'intelligenza artificiale generativa a problemi di modernizzazione del #foreign("software"). Questo ambito, all'intersezione tra #acronym("AI") e #foreign("software engineering"), può rappresentare una frontiera tecnologica di forte attualità e di interesse per un'azienda che opera già attivamente nel campo dell'AI e dei #foreign("Large Language Models").
#define-acronym("AI", "Artificial Intelligence")
- *Sviluppo di #foreign("asset") riutilizzabili*: Sebbene il progetto fosse autoconclusivo, permetteva di ottenere risultati tangibili nel breve termine dello #foreign("stage"), ma con il potenziale di evolversi in soluzioni più ampie e commercializzabili.

== Aspettative personali <sec:obiettivi-personali>

La scelta di intraprendere questo #foreign("stage") presso Miriade è stata guidata da una combinazione di motivazioni tecniche e personali che si allineavano con il mio percorso formativo universitario. Tra le diverse opportunità di #foreign("stage") che avevo valutato, questo progetto si distingueva per due elementi fondamentali:

- *Libertà tecnologica*: La libertà concessami nell'esplorazione delle tecnologie da utilizzare rappresentava un'opportunità unica di sperimentazione e apprendimento.
- *Interesse per COBOL*: Il mio forte interesse nel scoprire di più sul linguaggio COBOL, un affascinante paradosso tecnologico che, nonostante la sua longeva età, continua a essere cruciale nello scenario bancario e assicurativo internazionale.

Il mio percorso di #foreign("stage") mirava principalmente all'acquisizione di competenze pratiche nel campo della modernizzazione di sistemi #foreign("legacy") e gestione progetti:
#linebreak()
*Obiettivi tecnici*

- Comprendere la struttura e la logica dei programmi COBOL attraverso lo sviluppo di applicazioni di test
- Esplorare approcci concreti alla migrazione del codice, sia deterministici che basati su #foreign("AI")
- Produrre un prototipo funzionante di sistema di conversione, anche se limitato

*Competenze da sviluppare*

- Familiarità di base con il linguaggio COBOL e le sue peculiarità sintattiche
- Comprensione pratica delle sfide nella traduzione tra paradigmi di programmazione diversi
- Esperienza nell'utilizzo di tecnologie emergenti come l'#foreign("AI") generativa applicata al codice

*Crescita professionale attesa*

- Sviluppare autonomia nella gestione di un progetto aziendale, dalla pianificazione all'implementazione
- Acquisire capacità di #foreign("problem solving") in contesti reali, con vincoli temporali e tecnologici definiti
- Migliorare le competenze comunicative attraverso l'interazione con il #foreign("team") e la presentazione dei progressi
- Apprendere metodologie di lavoro #foreign("Agile") applicate a progetti di ricerca e sviluppo. #ref-figure(<fig:metodologia-agile>) rappresenta visivamente l'approccio metodologico Agile che ho appreso e applicato durante lo stage, evidenziando il ciclo iterativo di pianificazione, sviluppo, testing e revisione che ha caratterizzato il mio percorso formativo.

- Sviluppare pensiero critico nella valutazione di soluzioni tecnologiche alternative

#numbered-figure(
  image("../images/agile.png", width: 80%),
  caption: "Rappresentazione della metodologia Agile applicata al progetto",
  source: "https://indevlab.com",
) <fig:metodologia-agile>