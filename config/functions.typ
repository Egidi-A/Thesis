// config/functions.typ - Funzioni helper per la tesi

// Dizionario parole straniere da mettere in corsivo
#let foreign-words = (
  // Inglese
  "software", "hardware", "frontend", "backend", "framework",
  "web", "app", "application", "interface", "user", "experience",
  "design", "pattern", "test", "testing", "debug", "debugging",
  "repository", "commit", "push", "pull", "merge", "branch",
  "database", "query", "server", "client", "api", "rest",
  "javascript", "typescript", "angular", "react", "vue",
  "html", "css", "json", "xml", "http", "https",
  "agile", "scrum", "sprint", "backlog", "stakeholder",
  "business", "management", "system", "enterprise", "resource",
  "planning", "supply", "chain", "warehouse", "digital",
  "asset", "quality", "control", "manufacturing", "execution",
  
  // Latino
  "et al.", "i.e.", "e.g.", "vs.", "etc.",
)

// Funzione per applicare il corsivo alle parole straniere
#let auto-italic(content) = {
  show regex(foreign-words.join("|")): text.with(style: "italic")
  content
}

// Contatori personalizzati
#let figure-counter = counter("custom-figure")
#let table-counter = counter("custom-table")
#let equation-counter = counter("custom-equation")

// Funzione per figure numerate
#let numbered-figure(
  content,
  caption: none,
  kind: "Figura",
  supplement: "Figura",
) = {
  figure-counter.step()
  figure(
    content,
    caption: [#supplement #figure-counter.display(): #caption],
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
  table-counter.step()
  figure(
    table(columns: columns, rows: rows, content),
    caption: [Tabella #table-counter.display(): #caption],
    kind: "Tabella",
    supplement: "Tabella",
  )
}

// Funzione per equazioni numerate
#let numbered-equation(content) = {
  equation-counter.step()
  math.equation(
    block: true,
    numbering: n => [(#equation-counter.display())],
    content
  )
}

// Funzione per riferimenti incrociati
#let ref-figure(label) = {
  link(label)[Figura #ref(label)]
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
  link(<glossary>)[#text(style: "italic")[#term]]
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
  figure(
    raw(content, lang: lang, block: true),
    caption: caption,
    kind: "Codice",
    supplement: "Listato",
  ) 
  if label != none { label }
}