#let chapter(
title: "Chapter Title",
number: none,
authors: (),  // Parameter for authors (empty array by default)
overview: none, // New parameter for chapter overview
body
) = {
// Page setup
set page(
margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
numbering: "1",
number-align: center
)
// Typography
set text(
font: ("New Computer Modern"),
size: 12pt
)
// Basic heading styles
set heading(
numbering: "1."
)
// Style level 1 headings and create chapter title page
show heading.where(level: 1): it => {
// Only apply special styling to the first level 1 heading
if it == query(heading.where(level: 1)).first() {
pagebreak(weak: true)
  block(width: 100%, height: 100%)[
    // Title block at top
    #align(center)[
      #v(4em)
      #text(size: 24pt)[
        #if number != none [
          Chapter #number
          #v(0.5em)
        ]
        #text(weight: "bold",)[#it.body]
      ]
    ]
    
    // Overview section in the middle (if provided)
    #if overview != none [
      #align(left)[
        #v(2em)
        #block(width: 100%)[
          #text(size: 12pt, style: "normal",)[
            #overview
          ]
        ]
      ]
    ]

    // Authors block at bottom right
    #align(bottom + right)[
      #text(size: 12pt)[Contributors:]
      #text(size: 12pt, style: "italic",)[
        #v(0.5em)
        #authors.join(", ")
      ]
      #v(2em) // Add some bottom margin
    ]
  ]
  
  // Add page break after the title page
  pagebreak()
  
  // Return nothing for this heading as we've already displayed it
  []
} else {
  // For other level 1 headings, display them normally with some spacing
  v(2em)
  text(size: 18pt, weight: "bold")[#it.body]
  v(1em)
}
}
// Code block styling
show raw.where(block: true): it => {
block(
width: 100%,
fill: rgb(248, 248, 248),
stroke: 0.5pt + rgb(220, 220, 220),
radius: 3pt,
inset: 10pt,
it
)
}
// The main content
body
}