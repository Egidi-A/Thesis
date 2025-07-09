#import "../config/functions.typ": *

#align(center)[
  = Glossario <glossary>
]

// Termini definiti automaticamente nei capitoli
#context {
  let terms = glossary-list.get()
  if terms.len() > 0 {
    let sorted-terms = terms.pairs().sorted(key: p => p.at(0))
    
    for (term, definition) in sorted-terms [
      #strong(term): #definition #linebreak()
    ]
  }
}
