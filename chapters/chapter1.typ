// chapters/chapter1.typ - Capitolo 1

#import "../config/functions.typ": *

= Contesto di svolgimento delle attività <cap:contesto>

Questo capitolo introduce #gls("Trizeta"), azienda ospitante del tirocinio, e fornisce informazioni relative al settore in cui essa opera (quindi anche ai beni e servizi offerti), al suo rapporto con l'introduzione di novità / con il miglioramento di processi e strumenti già in uso ed ai processi in essa utilizzati.

Le informazioni riportate di seguito sono frutto di osservazioni personali, dialoghi avuti nel corso del tirocinio e ricerche svolte in totale autonomia.

== Introduzione all'azienda ospitante <sec:intro-azienda>

#define-term("Trizeta", "Software house specializzata nella consulenza e nello sviluppo di prodotti per aziende")
#define-acronym("IT", "Information Technology")

Trizeta è una #gls("software house"), ovvero un'azienda che si occupa dello sviluppo e della commercializzazione di software, specializzata nella consulenza e nello sviluppo di prodotti per aziende che desiderano l'automazione (totale o parziale) delle proprie attività industriali (compresa la gestione del magazzino); essa consente inoltre alle aziende clienti di gestire le proprie risorse digitali multimediali (i cosiddetti #gls("digital assets")).

#numbered-figure(
  // Qui andrebbe l'immagine dell'interfaccia
  rect(width: 100%, height: 200pt, fill: gray.lighten(80%))[
    Interfaccia di un gestionale Trizeta
  ],
  caption: "Interfaccia di un gestionale Trizeta",
) <fig:interfaccia-trizeta>

L'azienda è ubicata a Monselice (Padova) e dispone all'incirca di una decina di dipendenti #acronym("IT") (informatici) tra loro eterogenei per anni di esperienza nel settore informatico, età anagrafica, e #gls("stack tecnologico") abitualmente utilizzato (tecnologie utilizzate e ambito di utilizzo delle stesse).

Recentemente Trizeta è entrata a far parte di SYS-DAT Group: è un gruppo di aziende specializzate nello sviluppo e manutenzione di prodotti software rivolti ad aziende appartenenti a vari settori quali il settore moda (settore di origine di SYS-DAT, azienda fondatrice del gruppo) ed il settore alimentare.

== Prodotti e servizi <sec:prodotti>

Come già indicato nella @sec:intro-azienda, Trizeta intrattiene relazioni commerciali esclusivamente di tipo B2B#footnote[Business to business]: questa visione si riflette inevitabilmente sui prodotti offerti e sull'insieme dei requisiti utente soddisfatti dai prodotti commercializzati.

Di seguito, un breve elenco di software che ho potuto visionare personalmente e, relativamente all'ultima voce in lista, studiare ai fini di comprendere meglio le finalità dello stage e la visione dell'azienda:

#define-acronym("WMS", "Warehouse Management System")
#define-acronym("ERP", "Enterprise Resource Planning")

- *ADeWMS*: è un #acronym("WMS") (gestionale relativo al contenuto e alle attività di magazzino) in grado di integrarsi con software #acronym("ERP") (gestionale per tutti i processi aziendali) e gestire ordini commerciali, consegne e relativa documentazione;

#numbered-figure(
  rect(width: 100%, height: 150pt, fill: gray.lighten(80%))[
    Attività gestite da un software WMS
  ],
  caption: "Funzionalità di un software WMS",
) <fig:wms>

#define-acronym("DAM", "Digital Asset Management")

- *P4NDOR4*: è un #acronym("DAM") (gestionale per digital assets, risorse digitali, aziendali) con possibilità di richiedere delle risorse direttamente a Trizeta;

#define-acronym("MES", "Manufacturing Execution System")

- *ADeMES*: è un #acronym("MES") (software di gestione delle attività produttive aziendali) di particolare interesse in quanto direttamente coinvolto ai fini del tirocinio.

== Processi interni <sec:processi>

Il team aziendale utilizza un modello di ciclo di vita del software detto #gls("agile"), ovvero ha una visione orientata all'ottimizzazione del flusso di lavoro (evitando tempi morti e uso di risorse senza ottenere valore in cambio), e consentire una risposta rapida alle variazioni delle esigenze del cliente anche in stadi avanzati dello sviluppo.

=== Gestione di progetto

In relazione alla gestione di progetto, ho potuto assistere (direttamente o indirettamente) alle seguenti attività:

- *Definizione degli obiettivi e delle risorse*: la definizione degli obiettivi e delle risorse di progetto avviene dopo dialogo diretto con le industrie clienti coinvolte nel progetto: in questa occasione si cerca di analizzare a fondo i risultati desiderati e le modalità di raggiungimento degli stessi;

- *Pianificazione*: la pianificazione delle attività avviene a partire dalla definizione degli obiettivi e delle risorse di progetto (previo dialogo, come precedentemente indicato) basandosi su esperienze pregresse e sulla disponibilità di capitale umano e risorse economiche;

- *Comunicazione con gli stakeholders*#footnote[Portatori d'interesse]: la comunicazione con i "portatori d'interesse" (coloro i quali hanno interesse nella buona riuscita del progetto) avviene tramite colloquio (preferibilmente in presenza, online in caso di necessità) ed è fondamentale per dare prova di avanzamento tangibile nei modi e tempi indicati o, in caso contrario, motivare eventuali discrepanze tra la pianificazione e la realtà.