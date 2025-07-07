// config/foreign-words.typ - Gestione automatica del corsivo per parole straniere

// Funzione per marcare una parola come straniera
#let foreign(word) = emph(word)

// Abbreviazioni comuni che vanno sempre in corsivo
#let sw = foreign("software")
#let hw = foreign("hardware")
#let fw = foreign("framework")
#let db = foreign("database")

// Macro per termini ricorrenti
#let webapp = foreign("web app")
#let frontend = foreign("frontend")
#let backend = foreign("backend")
#let fullstack = foreign("full-stack")

// Funzione più complessa per gestire il corsivo automatico
// Questa versione funziona meglio con Typst
#let with-foreign-words(body) = {
  // Definisci le regole per ogni parola
  // Definisci le regole per ogni parola
  show "words": foreign
  
  body
}