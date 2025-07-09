#import "../config/functions.typ": *
#import "../config/foreign-words.typ": foreign

#define-acronym("AI", "Artificial Intelligence")
#define-term("legacy", "Sistemi informatici datati ma ancora in uso")
#define-term("parser", "Analizzatore sintattico")
#define-term("parsing", "Analisi sintattica")
#define-term("pipeline", "Sequenza di elaborazioni")
#define-term("API", "Application Programming Interface")
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

= Sviluppo del progetto: dal #foreign("parser") tradizionale all'#acronym("AI") <cap:sviluppo-progetto>

Qui introdurrò brevemente il contenuto delle sezioni sottostanti seguendo il flusso cronologico del progetto.

== #foreign("Setup") iniziale e metodologia di lavoro
In questa sezione descriverò l'implementazione della metodologia #foreign("Agile") con #foreign("sprint") settimanali e #foreign("stand-up") giornalieri, illustrerò gli strumenti di sviluppo e l'ambiente tecnologico utilizzato, analizzerò la gestione del progetto attraverso #foreign("Jira") e #foreign("Confluence"), l'uso di #foreign("Git") e #foreign("BitBucket") per il versionamento con documentazione progressiva.

== Primo periodo: immersione nel mondo #foreign("COBOL")
In questa sezione descriverò il processo di apprendimento del linguaggio #foreign("legacy"), l'analisi delle sue caratteristiche, l'analisi delle soluzioni esistenti sul mercato.

=== Studio del linguaggio e creazione progetti test
In questa sottosezione descriverò lo studio della sintassi e semantica #foreign("COBOL"), illustrerò la creazione di applicazioni #foreign("test") con complessità crescente e analizzerò l'interfacciamento con database #foreign("PostgreSQL") e #foreign("DB2").

=== Mappatura dei #foreign("pattern") e analisi di traducibilità
In questa sottosezione presenterò i #foreign("pattern") #foreign("COBOL") identificati, l'analisi del grado di migrabilità verso #foreign("Java"), e le strategie individuate per gestire le incompatibilità strutturali.

=== Valutazione delle soluzioni esistenti
In questa sottosezione valuterò la #foreign("Pipeline Architecture") tramite #foreign("parser") #foreign("open-source") (#foreign("ProLeap parser") in #foreign("GitHub")) e analizzerò soluzioni #foreign("enterprise") come #foreign("IBM WatsonX") per migrazione #acronym("AI")-assistita.

== Secondo periodo: sviluppo del #foreign("parser") tradizionale
In questa sezione descriverò l'approccio iniziale basato su #foreign("parsing") deterministico e le criticità emerse.

=== Implementazione del #foreign("parser") Java
In questa sottosezione descriverò lo sviluppo del #foreign("parser") per le divisioni #foreign("IDENTIFICATION") e #foreign("ENVIRONMENT"), le sfide tecniche affrontate nella gestione della grammatica #foreign("COBOL"), e i primi risultati ottenuti.

=== Analisi critica e limiti dell'approccio
In questa sottosezione analizzerò la complessità crescente per #foreign("DATA") e #foreign("PROCEDURE DIVISION") e la limitata scalabilità, la stima dei tempi incompatibile con i vincoli dello #foreign("stage"), e la decisione di esplorare approcci alternativi.

== Terzo periodo: #foreign("pivot") verso l'intelligenza artificiale
In questa sezione descriverò la svolta strategica verso l'utilizzo dell'#acronym("AI") generativa.

=== Valutazione delle #foreign("API") di #acronym("AI") generativa
In questa sottosezione descriverò il passaggio da #foreign("pipeline") deterministica a sistema #acronym("AI")-#foreign("powered").

=== #foreign("Design") del sistema #acronym("AI")-#foreign("powered")
In questa sottosezione descriverò l'architettura del nuovo sistema basato su #acronym("AI"), il passaggio da #foreign("pipeline") deterministica a sistema generativo, e la progettazione del flusso di conversione.

== Quarto periodo: implementazione della soluzione #acronym("AI")-#foreign("driven")
In questa sezione descriverò lo sviluppo completo del sistema di migrazione basato su #acronym("AI").

=== Sviluppo del #foreign("prompt engineering")
In questa sottosezione illustrerò la creazione di #foreign("prompt") specifici per la conversione COBOL-Java, l'ottimizzazione iterativa basata sui risultati, e la gestione dei casi #foreign("edge").

=== Implementazione del #foreign("translator") completo
In questa sottosezione descriverò lo sviluppo del sistema di conversione #foreign("end-to-end"), la gestione di #foreign("SQL embedded") e la preservazione della logica #foreign("business") originale.

=== Generazione automatica di progetti #foreign("Maven")
In questa sottosezione analizzerò la creazione automatica della struttura del progetto Java, la configurazione delle dipendenze e del #foreign("build system"), e la generazione della documentazione #foreign("JavaDoc").

== Risultati raggiunti
=== Impatto dell'#acronym("AI") sui tempi di sviluppo
In questa sottosezione quantificherò la riduzione importanti dei tempi rispetto all'approccio tradizionale, illustrerò il passaggio da mesi a giorni nel processo di conversione e analizzerò i risultati impossibili senza #acronym("AI").

=== Analisi qualitativa dei risultati
In questa sottosezione descriverò il sistema completo di conversione COBOL-Java funzionante, analizzerò il codice Java idiomatico e manutenibile prodotto e illustrerò la documentazione professionale automatizzata.

=== Risultati quantitativi
In questa sottosezione presenterò i dati concreti: tre progetti convertiti con successo, vasta copertura delle funzionalità e oltre 2000 linee di codice Java di qualità #foreign("production-ready").

#numbered-figure(
  image("../images/Atlassian-Bitbucket.png"),
  caption: "Utilizzo di BitBucket per il versionamento del codice",
  source: "https://bitbucket.org"
) <fig:bitbucket-git>

/*
#ref-figure(<fig:bitbucket-git>)#footnote("Fonte: https://bitbucket.org") mostra l'interfaccia che BitBucket mette a disposizione per il versionamento di progetti, evidenzia l'importanza attribuita dall'azienda alla tracciabilità e alla collaborazione nel processo di sviluppo.
*/