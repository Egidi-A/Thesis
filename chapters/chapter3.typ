#import "../config/functions.typ": *
#import "../config/foreign-words.typ": foreign

= Sviluppo del progetto: dal #foreign("parser") tradizionale all'AI <cap:sviluppo-progetto>

Qui introdurrò brevemente il contenuto delle sezioni sottostanti seguendo il flusso cronologico del progetto.

== #foreign("Setup") iniziale e metodologia di lavoro
In questa sezione descriverò l'implementazione della metodologia #foreign("Agile") con #foreign("sprint") settimanali e #foreign("stand-up") giornalieri, illustrerò gli strumenti di sviluppo e l'ambiente tecnologico utilizzato, analizzerò la gestione del progetto attraverso #foreign("Jira") e #foreign("Confluence"), l'uso di #foreign("Git") e #foreign("BitBucket") per il versionamento con documentazione progressiva.

== Primo periodo: immersione nel mondo COBOL
In questa sezione descriverò il processo di apprendimento del linguaggio legacy, l'analisi delle sue caratteristiche, l’analisi delle soluzioni esistenti sul mercato.

=== Studio del linguaggio e creazione progetti test
In questa sottosezione descriverò lo studio della sintassi e semantica COBOL, illustrerò la creazione di applicazioni test con complessità crescente e analizzerò l'interfacciamento con database PostgreSQL e DB2.

=== Mappatura dei pattern e analisi di traducibilità
In questa sottosezione presenterò i pattern COBOL identificati, l'analisi del grado di migrabilità verso Java, e le strategie individuate per gestire le incompatibilità strutturali.

=== Valutazione delle soluzioni esistenti
In questa sottosezione valuterò la Pipeline Architecture tramite parser open-source (ProLeap parser in GitHub) e analizzerò soluzioni enterprise come IBM WatsonX per migrazione AI-assistita.

== Secondo periodo: sviluppo del parser tradizionale
In questa sezione descriverò l'approccio iniziale basato su parsing deterministico e le criticità emerse.

=== Implementazione del parser Java
In questa sottosezione descriverò lo sviluppo del parser per le divisioni IDENTIFICATION e ENVIRONMENT, le sfide tecniche affrontate nella gestione della grammatica COBOL, e i primi risultati ottenuti.

=== Analisi critica e limiti dell'approccio
In questa sottosezione analizzerò la complessità crescente per DATA e PROCEDURE DIVISION e la limitata scalabilità, la stima dei tempi incompatibile con i vincoli dello stage, e la decisione di esplorare approcci alternativi.

== Terzo periodo: pivot verso l'intelligenza artificiale
In questa sezione descriverò la svolta strategica verso l'utilizzo dell'AI generativa.

=== Valutazione delle API di AI generativa
In questa sottosezione descriverò il passaggio da pipeline deterministica a sistema AI-powered.

=== Design del sistema AI-powered
In questa sottosezione descriverò l'architettura del nuovo sistema basato su AI, il passaggio da pipeline deterministica a sistema generativo, e la progettazione del flusso di conversione.

== Quarto periodo: implementazione della soluzione AI-driven
In questa sezione descriverò lo sviluppo completo del sistema di migrazione basato su AI.

== Sviluppo del prompt engineering
In questa sottosezione illustrerò la creazione di prompt specifici per la conversione COBOL-Java, l'ottimizzazione iterativa basata sui risultati, e la gestione dei casi edge.

=== Implementazione del translator completo
In questa sottosezione descriverò lo sviluppo del sistema di conversione end-to-end, la gestione di SQL embedded e la preservazione della logica business originale.

=== Generazione automatica di progetti Maven
In questa sottosezione analizzerò la creazione automatica della struttura del progetto Java, la configurazione delle dipendenze e del build system, e la generazione della documentazione JavaDoc.

== Risultati raggiunti
3.6.1 Impatto dell'AI sui tempi di sviluppo
In questa sottosezione quantificherò la riduzione importanti dei tempi rispetto all'approccio tradizionale, illustrerò il passaggio da mesi a giorni nel processo di conversione e analizzerò i risultati impossibili senza AI.

=== Analisi qualitativa dei risultati
In questa sottosezione descriverò il sistema completo di conversione COBOL-Java funzionante, analizzerò il codice Java idiomatico e manutenibile prodotto e illustrerò la documentazione professionale automatizzata.

=== Risultati quantitativi
In questa sottosezione presenterò i dati concreti: tre progetti convertiti con successo, vasta copertura delle funzionalità e oltre 2000 linee di codice Java di qualità production-ready.