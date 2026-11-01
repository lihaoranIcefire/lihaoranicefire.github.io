#import "@preview/fletcher:0.5.8": diagram, node, edge

#let universe(body) = {
  set document(title: "My Mathematical Universe", author: "Haoran Li")
  set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1in), numbering: "1")
  set text(font: "New Computer Modern", size: 10pt, lang: "en")
  set par(justify: true)
  set heading(numbering: "1.1")
  set math.equation(numbering: none)
  show figure.where(kind: "statement"): set block(breakable: true)
  show figure.where(kind: "proof"): set block(breakable: true)
  show figure.where(kind: "aside"): set block(breakable: true)
  show heading.where(level: 1): item => {
    counter(figure.where(kind: "statement")).update(0)
    counter(math.equation).update(0)
    pagebreak(weak: true)
    item
  }
  show ref: item => context {
    let target = item.element
    if target != none and target.func() == figure and target.kind in ("statement", "proof", "aside") {
      let location = target.location()
      let chapter = counter(heading).at(location).first()
      let number = counter(figure.where(kind: "statement")).at(location).first()
      link(location, numbering("1.1", chapter, number))
    } else { item }
  }
  body
}

#let statement(name, title: none, body) = figure(
  align(left, block(width: 100%, breakable: true)[
    #context strong[
      #name #counter(heading).get().first().#counter(figure.where(kind: "statement")).display("1")
      #if title != none [(#title)]
    ]
    #body
  ]),
  kind: "statement", supplement: name,
  numbering: number => context numbering("1.1", counter(heading).get().first(), number),
  caption: none,
)
#let proof(title: "Proof", body) = figure(
  align(left, block(width: 100%, breakable: true)[_#title._ #body #h(1fr) $square$]),
  kind: "proof", supplement: [Proof], caption: none, numbering: "1",
)
#show figure.where(kind: "proof"): set block(breakable: true)
#let aside(name, title: none, body) = figure(
  align(left, block(width: 100%, breakable: true)[*#name#if title != none [ (#title)].* #body]),
  kind: "aside", supplement: name, caption: none, numbering: "1",
)
#show figure.where(kind: "aside"): set block(breakable: true)
#let numbered-equation(body) = math.equation(
  block: true,
  numbering: number => context numbering("1.1", counter(heading).get().first(), number),
  body,
)
#let display-equation(body) = layout(size => {
  let content = math.display(body)
  let width = measure(content).width
  let available = (size.width - 8pt) * 0.85
  if width > available {
    let ratio = available / width * 100%
    math.equation(block: true, numbering: none,
      box(scale(x: ratio, y: ratio, reflow: true, content)),
    )
  } else { math.equation(block: true, numbering: none, body) }
})
#let unresolved-reference(name) = text(fill: rgb("a33a32"))[\[Unresolved source reference: #name\]]
#let index-entry(term) = metadata((kind: "index-entry", term: term))
#let index-list() = context {
  let entries = query(metadata).filter(item => type(item.value) == dictionary and item.value.at("kind", default: none) == "index-entry")
  let terms = entries.map(item => item.value.term).dedup().sorted(key: lower)
  columns(2, gutter: 2em)[
    #for term in terms {
      let matches = entries.filter(item => item.value.term == term)
      let pages = matches.map(item => item.location().page()).dedup()
      let links = pages.map(page => link(matches.find(item => item.location().page() == page).location(), str(page)))
      par[#term #h(1fr) #links.join[, ]]
    }
  ]
}