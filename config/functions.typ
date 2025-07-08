// config/functions.typ - Funzioni helper per la tesi

// Funzione per figure numerate
#let numbered-figure(
  content,
  caption: none,
  kind: "Figura",
  supplement: "Figura",
) = {
  figure(
    content,
    caption: caption,
    kind: kind,
    supplement: supplement,
  )
}

// Funzione per tabelle numerate
#let numbered-table(
  content,
  caption: none,
  columns: auto,
  rows: auto,
) = {
  figure(
    table(columns: columns, rows: rows, content),
    caption: caption,
    kind: "Tabella",
    supplement: "Tabella",
  )
}

// Funzione per equazioni numerate
#let numbered-equation(content) = {
  math.equation(
    block: true,
    numbering: "1",
    content
  )
}

// Funzione per riferimenti incrociati
#let ref-figure(label) = {
  link(label)[#ref(label)]
}

#let ref-table(label) = {
  link(label)[Tabella #ref(label)]
}

#let ref-chapter(label) = {
  link(label)[Capitolo #ref(label)]
}

#let ref-section(label) = {
  link(label)[Sezione #ref(label)]
}

// Funzione per acronimi
#let acronym-list = state("acronyms", (:))

#let define-acronym(short, long) = {
  acronym-list.update(acronyms => {
    acronyms.insert(short, long)
    acronyms
  })
}

#let acronym(short) = context {
  let acronyms = acronym-list.get()
  let is-first = state("acronym-first-" + short, true)
  
  if is-first.get() {
    is-first.update(false)
    [#acronyms.at(short, default: short) (#short)]
  } else {
    short
  }
}

// Funzione per termini del glossario
#let glossary-list = state("glossary", (:))

#let define-term(term, definition) = {
  glossary-list.update(terms => {
    terms.insert(term, definition)
    terms
  })
}

#let gls(term) = {
  text(style: "italic")[#term]
}

// Funzione per note a margine
#let margin-note(content) = {
  place(right + top, dx: 1.5cm, dy: -0.5em)[
    #text(size: 9pt, fill: gray)[#content]
  ]
}

// Funzione per codice sorgente con highlighting
#let source-code(
  content,
  lang: "text",
  caption: none,
  label: none,
) = {
  let fig = figure(
    raw(content, lang: lang, block: true),
    caption: caption,
    kind: "Codice",
    supplement: "Listato",
  ) 
  if label != none {
    [#fig #label]
  } else {
    fig
  }
}