#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH742 - Geometric analysis", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH742 - Geometric analysis]
#v(2cm)
#image("Pictures/Calabi_Yau.jpg",width:50%)
#v(2cm)
Taught by Tamás Darvas \
Notes taken by Haoran Li \
2020 Fall
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Introduction
<introduction>
#statement("Theorem")[
$D subset.eq bb(R)^n$ is open bounded with smooth boundary, $f in C^oo\(partial D\)$, then Dirichlet problem #math.equation(block: true, numbering: none, $cases(Delta u = 0 quad upright("in ") D, u = f quad upright("on ") partial D)$) has a unique solution $u in C^oo\(overline(D)\)$. In the case $D = B\(0\,r\)$, the solution is given by Poisson kernel #math.equation(block: true, numbering: none, $P\[f\]\(x\)= integral_(partial B\(0\,r\)) f\(xi\)frac(r^2 -\|x\|^2, r omega_(n - 1)\|x - xi\|^2) d sigma\(xi\)$) The uniqueness is guaranteed by integration by parts

]
#statement("Remark")[
Note that this always work as long as $partial D in C^oo$

]
#statement("Theorem")[
$M$ is a compact Riemannian manifold without boundary, $f in C^oo\(M\)$, if $Delta u = f$ on $M$, then integration by parts demands $0 = integral_M Delta u d x = integral_M f d x$, then $Delta u = f$ on $M$ has unique solution up to addting constants. Here $Delta = "Tr" nabla_(X\,Y)^2$ is the trace of Hessian, where $nabla_(X\,Y)^2 = nabla_X nabla_Y - nabla_Y X$

]
#statement("Theorem")[
$M$ is a smooth manifold, the #emph[de Rham complex]#index-entry("de Rham complex") is #math.equation(block: true, numbering: none, $0 arrow.r cal(C)^oo\(M\)arrow.r^d Omega^1\(M\)arrow.r^d Omega^2\(M\)arrow.r^d dots.h.c$) Define the cohomology to be #emph[de Rham cohomology] $H_(upright(d R))^k\(X\,bb(R)\)$, then #math.equation(block: true, numbering: none, $H_(upright(d R))^k\(X\,bb(R)\)tilde.equiv H_(upright(s i n g))^k\(X\,bb(R)\)= H^k\(X\,bb(R)\)$) Where $H^k\(X\,bb(R)\)$ is the sheaf cohomology which is not so surprising by sheaf theory

]
#statement("Theorem")[
$s in Omega^k\(X\)$, the solution set $S$ of $Delta s = 0$ has $dim S = dim H^k\(X\,bb(R)\)$. Actually $S arrow.r.hook H^k\(X\,bb(R)\)$ with an explicit map

]
#pagebreak(weak:true)
= Laplace-Beltrami operator
<laplace-beltrami-operator>
Demailly VI.3: Hamonic forms and Hodge theory

$\(M\,g\)$ is a Riemannian manifold, $dim M = m$, $\(E\,h\)arrow.r M$ is a $bb(C)$ vector bundle, $"rank" E = r$. $e_1\,dots.h.c\,e_r$ is an orthonormal basis of $E$, $e_1^(*)\,dots.h.c\,e_r^(*)$ is an orthonormal basis of $E^(*)$. $xi_1\,dots.h.c\,xi_m$ is an orthonormal basis of $T M$, $xi_1^(*)\,dots.h.c\,xi_m^(*)$ is an orthonormal basis of $T^(*) M$

#statement("Definition", title: [Hodge $*$ operator])[
The Riemannian volume form is $d V = xi_1^(*) and dots.h.c and xi_m^(*)$, $* : and.big^p T^(*) M arrow.r and.big^(m - p) T^(*) M$ is defined such that $u and * v = chevron.l u\,v chevron.r d V$

]
#statement("Theorem")[
$d : cal(E)\(M\,and.big^p T^(*) M\)arrow.r cal(E)\(M\,and.big^(p + 1) T^(*) M\)$ has a formal adjoint $d^(*) =\(- 1\)^(m p + 1) * d *$

]
#proof(title: "Proof")[

]
#statement("Definition", title: [Laplace-Beltrami operator])[
$Delta = d d^(*) + d^(*) d$ which is self-adjoint and semipositive definite

]
#statement("Example", title: [Laplace-Beltrami operator in Euclidean space])[

]
#pagebreak(weak:true)
#pagebreak(weak:true)

#pagebreak()
#heading(numbering:none)[References]
#emph[Differential Analysis On Complex Manifolds] - Raymond O. Wells


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
