// appendix/glossary.typ - Glossario

#import "../config/functions.typ": glossary-list

= Glossario <glossary>

#context {
  let terms = glossary-list.get()
  let sorted-terms = terms.pairs().sorted(key: p => p.at(0))
  
  for (term, definition) in sorted-terms {
    [
      *#term*: #definition
      
    ]
  }
}

// Definizioni manuali di esempio (possono essere aggiunte anche qui)
#let glossary-entries = (
  "API": [
    in informatica con il termine Application Programming Interface (ing. interfaccia di programmazione di un'applicazione) si indicano regole e specifiche per la comunicazione tra software.
    Tali regole fungono da interfaccia tra i vari software e ne facilitano l'interazione, allo stesso modo in cui l'interfaccia utente facilita l'interazione tra uomo e computer.
  ],
  
  "Backend": [
    con il termine "backend" si intende la parte non visibile all'utente di un programma, che elabora e gestisce i dati generati dall'interfaccia grafica.
  ],
  
  "Black box": [
    con il termine "black box" si intende un dispositivo con riferimento alle sole caratteristiche esterne, in particolare alle funzioni di trasferimento tra grandezze di ingresso o di uscita, ignorando cioè del tutto la costituzione interna.
  ],
  
  "Business to business": [
    con il termine "business to business" (it. commercio interaziendale) si intende la tipologia di commercio elettronico che intercorre tra attori economici organizzati in forma d'impresa, quali per esempio le aziende manifatturiere, industriali e commerciali, attraverso siti web dedicati.
  ],
)

// Visualizza le entry manuali
#for (term, definition) in glossary-entries {
  [
    *#term* <#lower(term.replace(" ", "-"))>: #definition
    
  ]
}