#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH607 - Algebraic Geometry II", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(font: "New Computer Modern", size: 10pt, lang: "en")
#set par(justify: true)
#set heading(numbering: "1.1")
#set math.equation(numbering: none)
#show figure.where(kind: "statement"): set block(breakable: true)
#let statement(name, title: none, body) = figure(
  align(left, block(width: 100%, breakable: true)[
    #context strong[
      #name #counter(heading).get().first().#counter(figure.where(kind: "statement")).display("1")
      #if title != none [(#title)]
    ]
    #body
  ]),
  kind: "statement",
  supplement: name,
  numbering: number => context numbering("1.1", counter(heading).get().first(), number),
  caption: none,
)
#show ref: it => context {
  let target = it.element
  if target != none and target.func() == figure and target.kind == "statement" {
    let location = target.location()
    link(location, numbering("1.1", counter(heading).at(location).first(), counter(figure.where(kind: "statement")).at(location).first()))
  } else { it }
}
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "statement")).update(0)
  it
}
#let proof(title: "Proof", body) = block(width: 100%, breakable: true)[
  _#title._ #body #h(1fr) $square$
]
#let exercise(number, body) = block(width: 100%, breakable: true)[
  *Exercise #number.* #body
]
#let index-entry(term) = metadata((kind: "index-entry", term: term))
#let index-list() = context {
  let entries = query(metadata).filter(it => it.value.kind == "index-entry")
  let terms = entries.map(it => it.value.term).dedup().sorted(key: lower)
  columns(2, gutter: 2em)[
    #for term in terms {
      let matches = entries.filter(it => it.value.term == term)
      let pages = matches.map(it => it.location().page()).dedup()
      let links = pages.map(page => link(matches.find(it => it.location().page() == page).location(), str(page)))
      par[#term #h(1fr) #links.join[, ]]
    }
  ]
}

#let aside(name, title: none, body) = block(breakable: true)[*#name#if title != none [ (#title)].* #body]
#let numbered-equation(body) = math.equation(block: true, numbering: number => context numbering("1.1", counter(heading).get().first(), number), body)
#show heading.where(level: 1): it => { counter(math.equation).update(0); it }
#let svg-drawing(body, width: 85%, height: 180) = align(center, image(bytes("<svg xmlns='http://www.w3.org/2000/svg' width='440' height='" + str(height) + "' viewBox='0 0 440 " + str(height) + "'><defs><marker id='a' markerWidth='6' markerHeight='6' refX='5' refY='3' orient='auto'><path d='M0 0L6 3L0 6' fill='none' stroke='black'/></marker></defs><g fill='none' stroke='black' stroke-width='1.2'>" + body + "</g></svg>"), width: width))
#let sampled-path(fn, start: 0, stop: 2 * calc.pi, steps: 120) = range(steps + 1).map(index => { let point = fn(start + (stop - start) * index / steps); (if index == 0 { "M" } else { "L" }) + str(point.at(0)) + " " + str(point.at(1)) }).join(" ")


#align(center)[
#set par(justify:false)
#v(1cm)
#text(size:22pt,weight:"bold")[MATH607 - Algebraic Geometry II]
#v(2cm)
Notes taken by Haoran Li \

#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= HW 1 Solutions
<hw-1-solutions>
#statement("Problem")[
First we have a lemma: If $A$ is a Noetherian commutative ring, $frak(p)$ is a prime ideal, $M$ is a finitely generated module, and $M_(frak(p))$ is a free module over $A_(frak(p))$, then there exists $f in A - frak(p)$ such that $M_f$ is a free module over $A_f$

+ Suppose $frak(p) = x in V = "Spec" A$, where $A$ is Noetherian, $cal(F)\|_V = tilde(M)$, then $cal(F)_x = tilde(M)_(frak(p))$, $cal(O)_(X\,x) = A_(frak(p))$, apply lemma, we know that $x in U = "Spec" A_f$ for some $f in A - frak(p)$ such that $cal(F)\|_U tilde.equiv tilde(M)_f$ is free

+

+ Consider sheaf $cal(G) = "Hom"_(cal(O)_X)\(cal(F)\,cal(O)_X\)$. Define $cal(F) times.o_(cal(O)_X) cal(G) arrow.r cal(O)_X$, locally, it reads $M times.o_A "Hom"\(M\,A\)arrow.r A$, $m times.o_A f mapsto f\(m\)$. $M$ is a rank one free $A$ module, so this map is an isomorphism locally, hence an isomorphism of sheaves

]
#statement("Problem")[
+

+ If $cal(F)$ is locally free, then $phi.alt$ is locally constant

+

]
#statement("Problem")[
+ The normalization is given by $phi.alt : "Spec" k\[t\]= tilde(X) arrow.r X$, which is defined through $f : k\[x\,y\]\/\(y^2 - x^3\)arrow.r k\[t\]$, $x mapsto t^2\,y mapsto t^3$

+

]
#statement("Problem")[
+
+
+
+
+

]
#statement("Problem")[
+
+

]
#statement("Problem")[

]
#statement("Problem")[

]
+
+
+
+
+

#statement("Problem")[
Consider $k' = k\[t^(1 / p)\]$, , then over $k'$, $X$ is defined by $y^2 = x^p - t =\(x - t^(1 / p)\)^p$

]
#statement("Problem")[

]
#pagebreak(weak:true)
#pagebreak(weak:true)
= HW 2 Solutions
<hw-2-solutions>
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#pagebreak(weak:true)
= HW 3 Solutions
<hw-3-solutions>
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#statement("Problem")[
+

]
#pagebreak(weak:true)
= HW 4 Solutions
<hw-4-solutions>
#pagebreak(weak:true)
= HW 5 Solutions
<hw-5-solutions>

#pagebreak()
#heading(numbering:none)[References]


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
