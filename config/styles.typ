// config/styles.typ - Stili personalizzati per la tesi

#import "functions.typ": *
#import "foreign-words.typ": with-foreign-words

// Funzione principale per applicare tutti gli stili
#let apply-thesis-styles(doc) = {
  // Impostazioni pagina
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 3cm,
      left: 3cm,
      right: 2.5cm,
    ),
    numbering: none, // Verrà impostato dopo
    header: none,    // Verrà personalizzato dopo
  )
  
  // Impostazioni testo base
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "it",
    hyphenate: true,
  )
  
  // Impostazioni paragrafo
  set par(
    justify: true,
    leading: 1.5em,
    first-line-indent: 1em,
  )
  
  // Stili per i titoli
  show heading.where(level: 1): set text(size: 18pt, weight: "bold")
  show heading.where(level: 1): set block(above: 2em, below: 1.5em)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  
  show heading.where(level: 2): set text(size: 16pt, weight: "bold")
  show heading.where(level: 2): set block(above: 1.5em, below: 1em)
  
  show heading.where(level: 3): set text(size: 14pt, weight: "bold")
  show heading.where(level: 3): set block(above: 1.2em, below: 0.8em)
  
  // Stili per elenchi
  set enum(indent: 1em, spacing: 0.8em)
  set list(indent: 1em, spacing: 0.8em)
  
  // Stili per figure e tabelle
  set figure(gap: 1em)
  show figure: it => {
    align(center)[
      #it.body
      #v(0.5em)
      #text(size: 10pt, style: "italic")[
        #it.caption
      ]
    ]
  }
  
  // Stili per tabelle
  set table(
    stroke: 0.5pt,
    align: center,
  )
  
  // Stili per codice
  show raw.where(block: true): it => {
    block(
      fill: rgb("#f5f5f5"),
      inset: 1em,
      radius: 0.3em,
      width: 100%,
      it
    )
  }
  
  show raw.where(block: false): it => {
    box(
      fill: rgb("#e8e8e8"),
      inset: (x: 0.3em, y: 0em),
      radius: 0.2em,
      it
    )
  }
  
  // Stili per link
  show link: it => {
    text(fill: rgb("#0066cc"), it)
  }
  
  // Stili per citazioni
  show quote: it => {
    pad(left: 2em, right: 2em)[
      text(style: "italic", it)
    ]
  }
  
  // Stili per note a piè di pagina
  set footnote(numbering: "1")
  show footnote.entry: it => {
    text(size: 10pt)[
      #super[#it.note]#h(0.2em)#it.note.body
    ]
  }
  
  // Applica il corsivo automatico alle parole straniere
  show: with-foreign-words
  
  doc
}

// Stile per il frontespizio
#let frontpage-style(content) = {
  set page(numbering: none, margin: 2cm)
  set text(size: 14pt)
  set align(center)
  content
}

// Stile per la dedica
#let dedication-style(content) = {
  set page(numbering: none)
  set align(center + horizon)
  text(style: "italic", content)
}

// Stile per i capitoli
#let chapter-style(title, content) = {
  heading(level: 1, numbering: "1.", title)
  content
}