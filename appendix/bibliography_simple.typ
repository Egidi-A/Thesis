// appendix/bibliography_simple.typ - Bibliografia con citazioni semplici
#import "../config/functions.typ": *

#align(center)[
  #unnumbered-heading[Bibliografia] <bibliography>
]

// Importa e mostra la bibliografia dal file .bib
#bibliography("../bibliography.bib", title: none, style: "ieee")

// Note: Per citare nel testo usa @key (es. @bmc2024state)
// La bibliografia mostrerà automaticamente solo le fonti citate
