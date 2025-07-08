// main.typ - File principale della tesi

// Importa configurazioni
#import "config/metadata.typ": *
#import "config/styles.typ": *
#import "config/functions.typ": *

#import "appendix/glossary.typ": *
#import "appendix/bibliography.typ": *
#import "appendix/acronyms.typ": *



// Imposta il documento
#set document(
  title: thesis-title,
  author: thesis-author,
)

// Applica stili globali
#show: apply-thesis-styles

// Frontespizio
#include "preface/frontpage.typ"

// Dedica
#include "preface/dedication.typ"

// Sommario
#include "preface/abstract.typ"

// Ringraziamenti
#include "preface/acknowledgments.typ"

// Indici
#include "preface/toc.typ"

// Capitoli
#set page(numbering: "1")
#counter(page).update(1)

#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/chapter4.typ"

// Appendici
#include "appendix/acronyms.typ"
#include "appendix/glossary.typ"
#include "appendix/bibliography.typ"