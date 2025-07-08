// appendix/acronyms.typ - Lista degli acronimi

#import "../config/functions.typ": *

#align(center)[
    #unnumbered-heading[Lista degli acronimi] <acronyms>
]

// Definiti automaticamente nei capitoli
#context {
  let acronyms = acronym-list.get()
  if acronyms.len() > 0 {
    let sorted-acronyms = acronyms.pairs().sorted(key: p => p.at(0))
    
    for (short, long) in sorted-acronyms [
        #strong(short): #long
        #linebreak()
      ]
    
  }
}