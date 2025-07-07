// preface/toc.typ - Indici (contenuti, figure, tabelle)

// Indice dei contenuti
#outline(
  title: "Indice",
  depth: 3,
  indent: 1em,
)

#pagebreak()

// Elenco delle figure
#outline(
  title: "Elenco delle figure",
  target: figure.where(kind: "Figura"),
)

#pagebreak()

// Elenco delle tabelle
#outline(
  title: "Elenco delle tabelle", 
  target: figure.where(kind: "Tabella"),
)

#pagebreak()

// Elenco dei codici (se necessario)
#outline(
  title: "Elenco dei listati",
  target: figure.where(kind: "Codice"),
)

#pagebreak()