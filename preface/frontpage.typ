// preface/frontpage.typ - Frontespizio della tesi

#import "../config/metadata.typ": *
#import "../config/styles.typ": frontpage-style

#show: frontpage-style

// Nome università
#text(size: 16pt, weight: "bold")[
  #university-name
]

#v(0.3cm)

// Dipartimento
#text(size: 14pt)[
  #department-name
]

#v(0.3cm)

// Corso di laurea
#text(size: 14pt)[
  #course-name
]

#v(1cm)
// Logo università (assumendo che ci sia un'immagine)
#image("../images/logo-unipd.png", width: 35%)
#v(1cm)

// Titolo della tesi
#text(size: 20pt, weight: "bold")[
  #thesis-title
]

#v(0.5cm)

// Tipo di documento
#text(size: 14pt)[
  Tesi di laurea
]

#v(2cm)

// Informazioni relatore e laureando
#grid(
  columns: (1fr, 1fr),
  gutter: 2cm,
  
  // Colonna sinistra - Relatore
  align(left)[
    #text(style: "italic")[Relatore] \
    #text(weight: "bold")[#thesis-relatore]
    
    #if thesis-correlatore != none [
      #v(1cm)
      #text(style: "italic")[Correlatore] \
      #text(weight: "bold")[#thesis-correlatore]
    ]
  ],
  
  // Colonna destra - Laureando
  align(right)[
    #text(style: "italic")[Laureando] \
    #text(weight: "bold")[#thesis-author] \
    #v(0.2cm)
    Matricola: #thesis-matricola
  ]
)

#v(2cm)

// Anno accademico
#line(length: 50%, stroke: 0.5pt)
#v(0.5cm)
#text(size: 12pt)[
  Anno Accademico #thesis-anno
]

#pagebreak()