#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH730 - Fundamental Concepts of Topology", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH730 - Fundamental Concepts of Topology]
#v(2cm)
#image("Pictures/Henri_Poincare.png",width:50%)
#v(2cm)
Taught by Sarah Yeakel \
Notes taken by Haoran Li \
2018 Fall
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= General topology
<general-topology>
#statement("Example")[
$bb(R)\/bb(Q)$ is not Hausdorff

]
#statement("Proposition")[
If $Y$ is discrete, then $X$ is connected if every continuous function $f : X arrow.r Y$ is a constant

]
#statement("Proposition")[
$X$ is compact, $Y$ is Hausdorff, any continuous function $f : X arrow.r Y$ is closed. In particular, if $f$ is bijective, then $f$ is a homeomorphism

]
#statement("Fact")[
$X$ is Hausdorff and locally compact iff $X$ is homeomorhphic to an open subset of a compact Hausdorff space $Y$ through one point compactification #math.equation(block: true, numbering: none, $"Hom"\(X times A\,Y\)tilde.equiv "Hom"\(X\,"Hom"\(A\,Y\)\)$) as a set. However as topological spaces $"Hom"\(X times A\,Y\)arrow.r "Hom"\(X\,"Hom"\(A\,Y\)\)$ is not surjective. Consider $X = "Hom"\(A\,Y\)$

]
#aside("Note")[
Here $"Hom"\(A\,Y\)$ is endowed with compact-open topology

]
#statement("Theorem")[
$A$ is locally compact and Hausdorff, then $f : X times A arrow.r Y$ is continuous iff $f : X arrow.r "Hom"\(A\,Y\)$ is continuous. Furthermore, if $X$ is also locally compact and Hausdorff, then #math.equation(block: true, numbering: none, $"Hom"\(X times A\,Y\)tilde.equiv "Hom"\(X\,"Hom"\(A\,Y\)\)$) as topological spaces

]
#statement("Proposition")[
If $g : A arrow.r Y$ is injective, then $iota_X : X arrow.r X union_A Y$ is also injective. If $f : A arrow.r Y$ is surjective, then $iota_Y : X arrow.r Y union_A Y$ is also surjective, moreover, if $f$ is a homeomorphism, so is $iota_Y$

]
#proof(title: "Proof")[
Proof of homeomorphism: Show that $Y$ satisfies the universal property of the pushout

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$Y$]),
node((0,1),[$X$]),
node((1,1),[$Y$]),
node((2,2),[$T$]),
edge((0,0),(1,0),"->",[$g$]),
edge((0,0),(0,1),"->",[$f$]),
edge((1,0),(1,1),"="),
edge((1,0),(2,2),"->",[$phi_2$],bend:15deg),
edge((0,1),(1,1),"->",[$g f$]),
edge((0,1),(2,2),"->",[$phi_1$],bend:-15deg),
edge((1,1),(2,2),"->",[$Phi$],stroke:(dash:"dashed")))]
]
$forall phi_1\,phi_2$ such that $phi_1 f = phi_2 g$, $Phi g f^(- 1) = phi_1$, thus $Phi = phi_2$

]
#statement("Definition", title: [CW complexes])[
For $x\,y in X$, define $phi : S^0 arrow.r X$ with $phi\(- 1\)= x$, $phi\(1\)= y$, Write $X union_phi D^1$ for pushout

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S^0$]),
node((1,0),[$X$]),
node((0,1),[$D^1$]),
node((1,1),[$X union_phi D^1$]),
edge((0,0),(1,0),"->",[$phi$]),
edge((0,0),(0,1),"hook->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->",[$iota$]))]
]
The image $iota\("Int"\(D^1\)\)$ is called a $1$-cell, denoted $e^1$

In general, we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S^(n - 1)$]),
node((1,0),[$X$]),
node((0,1),[$D^n$]),
node((1,1),[$X union_phi D^n$]),
edge((0,0),(1,0),"->",[$phi$]),
edge((0,0),(0,1),"hook->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->",[$iota$]))]
]
The image $iota\("Int"\(D^n\)\)$ is called an $n$-cell, denoted $e^n$. Attaching cells does not disturb the interiors of the cells

A CW complex is built up in the following way

+ Starting with a discrete set $X_0$, the set of $0$-cells or the $0$-skeleton

+ Given $\(n - 1\)$-skeleton $X_(n - 1)$, then $n$-skeleton $X_n$ is obtained by attaching $n$-cells to $X_(n - 1)$, that is

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$union.sq.big_(alpha in A_n) S_alpha^(n - 1)$]),
  node((1,0),[$X_(n - 1)$]),
  node((0,1),[$union.sq.big_(alpha in A_n) D_alpha^n$]),
  node((1,1),[$X_n$]),
  edge((0,0),(0,1),"hook->"),
  edge((0,0),(1,0),"->",[$phi.alt_alpha$]),
  edge((1,0),(1,1),"hook->"),
  edge((0,1),(1,1),"->",[$Phi_alpha$]))]
  ]

+ The space $X$ is the union of $X_n$'s, topologized by weak topology

The third condition ensures $X_n arrow.r.hook X$ is continuous. As a set, $X$ is the disjoint union of $Phi_alpha\("Int"\(D^n\)\)$, $Phi_alpha : D^n arrow.r X_n arrow.r X$ are called characteristic maps, CW complexes are determined by characteristic maps

]
#statement("Definition")[
$G$ is a discrete group. $Y times G arrow.r Y$ is a continuous action, then $q : Y arrow.r Y\/G$ is continuous, the action is #emph[properly discontinuous]#index-entry("Properly discontinuous group action") if $forall y in Y$, $exists U$ neighborhood such that $U inter U g = diameter\,forall g eq.not 1$, this implies that the action is free, then $q$ is a covering map, furthermore, $p : Y\/H arrow.r Y\/G$ is a covering map for $H lt.eq G$

]
#statement("Fact")[
A finite group which acts freely on a Hausdorff space $Y$ is properly discontinuous

]
#statement("Theorem", title: [Monodromy])[
Let $tilde(gamma)_x$ be the lift of $gamma$ against $p$ starting at $x$ #math.equation(block: true, numbering: none, $pi_1\(B\,b_0\)times F & arrow.r F\
\(\[gamma\]\,x\) & mapsto tilde(gamma)_x\(1\)$) specifies a transitive left action of $pi_1\(B\,b_0\)$ on $F$, called the monodromy action

]
#proof(title: "Proof")[
Let $c_(b_0)$ be the constant loop, which is the identity element, by transitivity, path-connectedness and orbit-stabilizer theorem, $F tilde.equiv G\/G_(x_0)$

]
#statement("Proposition")[
The stabilizer of $x in F$ under the monodromy action isthe subgroup $p_(*)\(pi_1\(E\,x\)\)lt.eq pi_1\(B\,b_0\)$

]
#statement("Corollary")[
$pi_1\(B\,b_0\)\/p_(*)\(pi_1\(E\,x\)\)arrow.r F$ is an isomorphism

]
#statement("Proposition")[
$phi : E_1 arrow.r E_2$ induce map on fibers $F_1 arrow.r F_2$ is $pi_1\(B\,b_0\)$ equivariant, i.e. $\[gamma\]dot.op phi\(x\)= tilde(gamma)_(phi\(x\))\(1\)= phi\(tilde(gamma)_x\)\(1\)= phi\(tilde(gamma)_x\(1\)\)= phi\(\[gamma\]dot.op x\)$

]
#statement("Proposition")[
$H\,K lt.eq G$, every $G$ equivariant map $phi : G\/H arrow.r G\/K$ is of the form $g H mapsto g gamma K$ for some $gamma in G$ such that $gamma H gamma^(- 1) lt.eq K$, in short, $H$ is subconjugate to $K$

]
#proof(title: "Proof")[
An equivariant map is determined by the value at one element, suppose $e H mapsto gamma K$, for some $gamma in G$. then $g H mapsto g gamma K$ which is well-defined should have $g h H = g H$, $g h gamma H = h gamma H$, so we need $gamma^(- 1) h gamma in K arrow.r.double gamma^(- 1) H gamma lt.eq K$

]
#statement("Corollary")[
An equivariant map $phi : G\/H arrow.r G\/K$ exists iff $H$ is subconjugate ot $K$. The two orbits are isomorphic as $G$-sets iff $H$ is conjugate to $K$

]
#statement("Theorem")[
There is a bijection of sets #math.equation(block: true, numbering: none, $"Hom"_B\(E_1\,E_2\)tilde.equiv "Hom"_(pi_1\(B\,b_0\))\(F_1\,F_2\)$)

]
#statement("Corollary")[
#math.equation(block: true, numbering: none, $"Aut"_B\(E\)tilde.equiv "Hom"_G\(G\/H\,G\/H\)tilde.equiv N_G\(H\)\/H = W_G\(H\)$) here $H = p_(*)\(pi_1\(E\)\)$

]
#proof(title: "Proof")[
There exists a surjective homomorhpism $N_G\(H\)arrow.r "Hom"_G\(G\/H\,G\/H\)$, $gamma mapsto g h mapsto g gamma H$, thus $e H mapsto gamma H arrow.r.double gamma in H$, thus $"Hom"_G\(G\/H\,G\/H\)tilde.equiv N_G\(H\)\/H$

]
#statement("Proposition")[
$X$ is the universal cover of $B$, $"Aut"_B\(X\)arrow.r F$, $phi mapsto phi\(x\)$, $x in q^(- 1)\(b\)$ is a bijection as sets

]
#pagebreak(weak:true)
= Homeworks
<homeworks>
== Homework1
<homework1>
#strong[\1.]

Suppse $tau$ is a topology on $X$ with exactly 7 elements. Since $cal(P)\(X\)$ has exactly 8 elements, and $diameter\,X in tau$. Thus, without loss of generality, we could assume either $tau = cal(P)\(X\)- { 3 }$ or $tau = cal(P)\(X\)- { 2\,3 }$

Case I: $tau = cal(P)\(X\)- { 3 }$

${ 1\,3 }\,{ 2\,3 } in tau$ which implies ${ 3 } = { 1\,3 } inter { 2\,3 } in tau$, that is a contradiction.

Case II: $tau = cal(P)\(X\)- { 2\,3 }$

${ 2 }\,{ 3 } in tau$ which implies ${ 2\,3 } = { 2 } union { 3 } in tau$, that is also a contradiction.

Therefore, it isn't a topology on $X$ with exactly 7 elements.

#strong[\2.]

Suppose ${ U_alpha }_(alpha in A)$ is an open cover of $f\(X\)$, then ${ f^(- 1)\(U_alpha\)}_(alpha in A)$ is an open cover of $X$ since $f$ is continuous, $X$ has a finite subcover ${ f^(- 1)\(U_(alpha_1)\)\,dots.h.c\,f^(- 1)\(U_(alpha_n)\)}$ since $X$ is compact, hence $f\(X\)$ also has a finite subcover ${ U_(alpha_1)\,dots.h.c\,U_(alpha_n) }$, thus $f\(X\)$ is also compact.

#strong[\3.]

Consider the following commutative diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$D^n$]),
node((2,0),[$bb(R)^(n + 1)$]),
node((1,1),[$D^n\/S^(n - 1)$]),
node((2,1),[$S^n$]),
edge((1,0),(2,0),"->",[$h$]),
edge((1,0),(1,1),"->",[$q$]),
edge((1,0),(2,1),"->",[$g$]),
edge((1,1),(2,1),"->",[$f$]),
edge((2,1),(2,0),"hook->",[$j$]))]
]
Where $h$ is given explicitly by #math.equation(block: true, numbering: none, $h\(x\)= (cos (pi \| x \|) \, frac(x, \|x\|) sin (pi \| x \|))$) $h$ is continuous, so is $g$ since $h = j g$, so is $f$ since $g = f q$. Since $D^n$ is compact, so is $D^n\/S^(n - 1) = q\(D^n\)$, since $S^n$ is Hausdorff and $f$ is bijective, thus $f$ is a homeomorphism. Therefore, $D^n\/S^(n - 1) tilde.equiv S^n$

#strong[\4.]

The pushout of

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(R) - { 0 }$]),
node((1,0),[$bb(R)$]),
node((0,1),[$bb(R)$]),
node((1,1),[$X$]),
edge((0,0),(1,0),"hook->"),
edge((0,0),(0,1),"hook->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->"))]
]
is not Hausdorff.

Consider the two origins $O_1$ and $O_2$ of X, then any two neighborhoods of them would intersect, thus $X$ cannot be Hausdorff.

#strong[\5.]

Pushout $X union_A Y$ is constructed by $X union.sq Y\/tilde.op$, where $tilde.op$ is the equivalence relationship generated by binary relationship $f\(a\)tilde.op g\(a\)$, hence $forall x eq.not x' in X$, suppose $iota_X\(x\)= iota_X\(x'\)$, then $x = f\(a_1\)tilde.op g\(a_1\)= g\(a_2\)tilde.op dots.h.c tilde.op f\(a_n\)= x'$, however, since g is injective, $a_1 = a_2$, thus $x = x'$, which is a contradiction. Therefore, $iota_X$ is injective.

#strong[\6.]

Consider the trivial topology on $bb(R)$, then a neighborhood of any point can only be $bb(R)$ itself, thus it is not Hausdorff.

#strong[\7.]

#strong[\(a)]

$forall epsilon.alt > 0$, let $delta = min (1 \, frac(epsilon.alt, 1 +\|x_0\|+\|y_0\|))$, then $forall\(x\,y\)in\(x_0 - delta\,x_0 + delta\)times\(y_0 - delta\,y_0 + delta\)$, $\|x y - x_0 y_0\|lt.eq\|x\|\|\(y - y_0\)\|+\|\(x - x_0\)\|\|y_0\|lt.eq\(\|x_0\|+ delta\)delta + delta\|y_0\|= delta\(delta +\|x_0\|+\|y_0\|\)lt.eq delta\(1 +\|x_0\|+\|y_0\|\)< epsilon.alt$, hence $f$ is continuous.

#strong[\(b)]

Consider $x_0 = y_0 = - 1$, then $\(0\,oo\)$ is a neighborhood of $x_0 y_0$, however, any neighborhood $\(a\,oo\)times\(b\,oo\)$ of $\(x_0\,y_0\)$ with $a < - 1\,b < - 1$, we have $f\(0\,0\)= 0 in.not\(0\,oo\)$, therefore, $f$ isn't continuous.

#pagebreak(weak:true)
== Homework2
<homework2>
#strong[Hatcher 0.10.]

Suppose $X$ is contractible, ${ * }$ is the one point space, $exists phi : X arrow.r { * }\,psi : { * } arrow.r X$ such that $psi compose phi tilde.eq upright(i d)_X$, thus for any map $f : X arrow.r Y$ and arbitrary space $Y$ we have $f = f compose upright(i d)_X tilde.eq f compose psi phi$ where $psi phi$ is constant map, hence $f$ is nullhomotopic. Conversely, suppose for any map $f : X arrow.r Y$ and arbitrary space $Y$, $f$ is nullhomotopic. Take $Y$ to be $X$, and $f$ to be $upright(i d)_X$, then $upright(i d)_X tilde.eq c_(x_0)$ where $x_0 in X$ and $c_(x_0)$ is the constant map, define $phi : X arrow.r { * }$ by $phi\(x\)= *$ for any $x in X$, and define $psi : { * } arrow.r X$ by $psi\(*\)= x_0$, then $psi compose phi = c_(x_0) tilde.eq upright(i d)_X$ and $psi compose phi = upright(i d)_({ * })$, hence $X$ is contractible. Similarly, suppose $X$ is contractible, ${ * }$ is the one point space, $exists phi : Y arrow.r { * }\,psi : { * } arrow.r Y$ such that $psi compose phi tilde.eq upright(i d)_Y$, thus for any map $f : Y arrow.r X$ and arbitrary space $Y$ we have $f = f compose upright(i d)_Y tilde.eq f compose psi phi$ where $psi phi$ is constant map, hence $f$ is nullhomotopic. Conversely, suppose for any map $f : Y arrow.r X$ and arbitrary space $Y$, $f$ is nullhomotopic. Take $Y$ to be $X$, and $f$ to be $upright(i d)_X$, then $upright(i d)_X tilde.eq c_(x_0)$ where $x_0 in X$ and $c_(x_0)$ is the constant map, define $phi : X arrow.r { * }$ by $phi\(x\)= *$ for any $x in X$, and define $psi : { * } arrow.r X$ by $psi\(*\)= x_0$, then $psi compose phi = c_(x_0) tilde.eq upright(i d)_X$ and $psi compose phi = upright(i d)_({ * })$, hence $X$ is contractible.

#strong[Hatcher 0.14.]

Since $f gt.eq 1$, $1 gt.eq 2 - f = v - e arrow.r.double e gt.eq v - 1$, hence we can construct as follows, where $x_1\,dots.h.c\,x_v$ are 0-cells, and $l_1\,dots.h.c\,l_e$ are 1-cells, which divide $bb(S)^2$ into $f$ 2-cells, and this give $bb(S)^2$ a CW complex structure as we wanted.

#align(center)[
#svg-drawing("<ellipse cx='220' cy='90' rx='180' ry='80'/><path d='M100 60H200M240 60H340M100 60Q220 145 340 60M100 60Q220 195 340 60'/><g fill='black' stroke='none' font-family='serif' font-size='13'><circle cx='100' cy='60' r='2'/><circle cx='160' cy='60' r='2'/><circle cx='280' cy='60' r='2'/><circle cx='340' cy='60' r='2'/><text x='85' y='78'>x₁</text><text x='153' y='78'>x₂</text><text x='265' y='78'>xᵥ₋₁</text><text x='337' y='78'>xᵥ</text><text x='125' y='55'>l₁</text><text x='180' y='55'>l₂</text><text x='212' y='63'>⋯</text><text x='250' y='55'>lᵥ₋₂</text><text x='305' y='55'>lᵥ₋₁</text><text x='213' y='96'>lᵥ</text><text x='218' y='128'>⋮</text><text x='213' y='145'>lₑ</text></g>")
]
#strong[Hatcher 1.1.1]

Since $g_0 tilde.eq g_1$, there exists continuous map $H : I times I arrow.r X$, such that $H\(s\,0\)= g_0\(s\)\,H\(s\,1\)= g_1\(s\)$, then $overline(H)\(s\,t\):= H\(1 - s\,t\)$ is so a continuous map from $I times I$ to $X$ with $overline(H)\(s\,0\)= overline(g_0)\(s\)\,overline(H)\(s\,1\)= overline(g_1)\(s\)$, thus $overline(g_0) tilde.eq overline(g_1)$, hence $f_0 = f_0 dot.op g_0 dot.op overline(g_0) tilde.eq f_1 dot.op g_1 dot.op overline(g_1) = f_1$

#strong[\1.]

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(S)^(n - 1)$]),
node((1,0),[$bb(R)^n\\{ 0 }$]),
node((2,0),[$bb(S)^(n - 1)$]),
edge((0,0),(1,0),"hook->",[$i$]),
edge((1,0),(2,0),"->",[$pi$]))]
]
Where $i$ is inclusion map and $pi$ is given by $pi\(x\)= frac(x, \|x\|)$, then $pi compose i = upright(i d)_(bb(S)^(n - 1))$, and $i compose pi tilde.eq upright(i d)_(bb(R)^n\\{ 0 })$ by homotopy $H : bb(R)^n\\{ 0 } times I arrow.r bb(R)^n\\{ 0 }\,\(x\,t\)mapsto t x +\(1 - t\)frac(x, \|x\|)$, which demonstrate $bb(S)^(n - 1) tilde.eq bb(R)^n\\{ 0 }$

#strong[\2.]

$H : bb(S)^n\\N times I arrow.r bb(S)^n\\N$, given by #math.equation(block: true, numbering: none, $H\(x\,t\)= (frac(x, \|x\|) sqrt(1 - (t x_(n + 1) - \( 1 - t \))^2) \, t x_(n + 1) - \( 1 - t \))$) Where $N$ is north pole. $H$ is a homotopy between $upright(i d)_(bb(S)^n\\N)$ and $c_N$, where $c_N$ is the constant map that maps $bb(S)^n\\N$ to $N$, thus $upright(i d)_(bb(S)^n\\N) tilde.eq c_N$. Since $phi.alt$ is continuous but not surjective, we can assume $N in.not phi.alt\(bb(S)^n\)$, then $phi.alt tilde.eq upright(i d)_(bb(S)^n\\N) compose phi.alt tilde.eq c_N compose phi.alt$, hence $phi.alt$ is nullhomotopic.

#strong[\3.]

If $n$ is odd, then $n + 1$ is even, then we could define $H : bb(S)^n times I arrow.r bb(S)^n$ by rotating the first two coordinates while fix the rest, written explictly #math.equation(block: true, numbering: none, $H\(x_1\,x_2\,dots.h.c\,x_(n + 1)\)= (x_1 cos pi t - x_2 sin pi t \, x_1 sin pi t + x_2 cos pi t \, dots.h.c \, x_(n + 1))$) The remaining coordinates are of even number, thus we could could repeat this process $frac(n + 1, 2)$ times, and compose all these homotopy, thus shows that $a tilde.eq upright(i d)_(bb(S)^n)$

#strong[\4.]

Reflexivity: Suppose $f : X arrow.r Y$, then $f tilde.eq^H f\,upright(r e l) thin Z$, where $H\(x\,t\)= f\(x\)$

Symmetry: Suppose $f\,g : X arrow.r Y$, and $f tilde.eq^H g\,upright(r e l) thin Z$, then $g tilde.eq^(H') f\,upright(r e l) thin Z$ where $H'\(x\,t\)= H\(x\,1 - t\)$

Transitivity: Suppose $f\,g\,h : X arrow.r Y$, and $f tilde.eq^F g\,upright(r e l) thin Z$, $g tilde.eq^G h\,upright(r e l) thin Z$, then $f tilde.eq^H h\,upright(r e l) thin Z$, where#math.equation(block: true, numbering: none, $H\(x\,t\)= {F (x \, 2 t)\,t in [0 \, 1 / 2]\
G (x \, 2 t - 1)\,t in [1 / 2 \, 1]$) Therefore, homotopy relative a given subspace $Z subset X$ is an equivalence relation on the set of maps from $X$ to $Y$

#pagebreak(weak:true)
== Homework3
<homework3>
#strong[Hatcher 1.1.6.]

If $X$ is path-connected, for any $\[u\]in\[S^1\,X\]$, $u$ is a representative of $\[u\]$, denote $x_1 := u\(0\)$, then there is a path $gamma$ connecting $x_0$ and $x_1$ with $gamma\(0\)= x_0$ and $gamma\(1\)= x_1$, then $\[gamma dot.op u dot.op overline(gamma)\]in pi_1\(X\,x_0\)$, define $H : S^1 times I arrow.r X$ where #math.equation(block: true, numbering: none, $H\(s\,t\)= {gamma (t + 3 s \( 1 - t \))\,thin s in\[0\,1 / 3\]\
u\(3 s - 1\)\,thin s in\[1 / 3\,2 / 3\]\
gamma (t + 3 \( 1 - s \) \( 1 - t \))\,thin s in\[2 / 3\,1\]$) Then $H$ is a homotopy between $gamma dot.op u dot.op overline(gamma) tilde.eq H\(s\,0\)tilde.eq H\(s\,1\)tilde.eq u$, thus $gamma dot.op u dot.op overline(gamma)$ is also a representative of $\[u\]$, thus $Phi$ is surjective.

If $\[f\]$ and $\[g\]$ are conjugate in $pi_1\(X\,x_0\)$, assume $gamma dot.op g dot.op overline(gamma) tilde.eq f$ for some $gamma in pi_1\(X\,x_0\)$ with some path homotopy $H$, then $Phi\(\[f\]\)= Phi\(\[gamma dot.op g dot.op overline(gamma)\]\)= Phi\(\[g\]\)$, the second equality holds using the same construction above.

Conversely, suppose $Phi\(\[f\]\)= Phi\(\[g\]\)$, then there is a homotopy $H$ between $f$ and $g$, let $gamma\(t\)= H\(0\,t\)$, then $F : I times I arrow.r X$ #math.equation(block: true, numbering: none, $F\(s\,t\)= {gamma (3 s t)\,thin s in\[0\,1 / 3\]\
H (3 s - 1 \, t)\,thin s in\[1 / 3\,2 / 3\]\
gamma (3 \( 1 - s \) t)\,thin s in\[2 / 3\,1\]$) shows that $gamma dot.op g dot.op overline(gamma) tilde.eq f$, thus $f$ and $g$ are conjugate

#strong[Hatcher 1.1.12.]

Suppose $f in pi_1\(S^1\)$ is a generator, and a homomorphism $alpha : pi_1\(S^1\)arrow.r pi_1\(S^1\)$ with $alpha\(f\)= f^n$, then define $phi : S^1 arrow.r S^1$ as $phi.alt\(e^(2 pi upright(i) theta)\)= e^(2 pi upright(i) n theta)$, then we would have $phi_(*) = alpha$

#strong[\1.]

Define $Psi : pi_1\(X\,x_0\)times pi_1\(Y\,y_0\)arrow.r pi_1 (X times Y \, \( x_0 \, y_0 \))$, $Psi\(\[f\]\,\[g\]\)=\[\(f\,g\)\]$, to check $Psi$ is well-defined, suppose $f' tilde.eq f\,g' tilde.eq g$, and $F\,G$ are homotopies between $f'\,f$ and $g'\,g$ respectively, then $\(F\,G\)$ is a homotopy between $\(f'\,g'\)$ and $\(f\,g\)$, also, $Psi (\( \[ f_1 \] \, \[ g_1 \] \) \( \[ f_2 \] \, \[ g_2 \] \)) = Psi (\[ f_1 f_2 \, g_1 g_2 \]) =\[\(f_1 f_2\)\,\(g_1 g_2\)\]=\[\(f_1\,g_1\)\]\[\(f_2\,g_2\)\]$, thus $Psi$ is a homomorphism, similarly, define $Phi : pi_1 (X times Y \, \( x_0 \, y_0 \)) arrow.r pi_1\(X\,x_0\)times pi_1\(Y\,y_0\)\,Phi\[\(h^1\,h^2\)\]=\(\[h^1\]\,\[h^2\]\)$ for $h =\(h^1\,h^2\)$, to check $Psi$ is well-defined, suppose $h' tilde.eq h$ by $H$, then $h^(1') tilde.eq h^1\,h^(2') tilde.eq h^2$by $H^1\,H^2$, also, $Phi\(h_1 h_2\)= Phi (\[ h_1^1 \, h_1^2 \] \[ h_2^1 \, h_2^2 \]) = Phi (\[ h_1^1 h_1^2 \, h_2^1 h_2^2 \]) =\[h_1^1 h_1^2\,h_2^1 h_2^2\]=\[h_1^1\,h_1^2\]\[h_2^1\,h_2^2\]= Phi\(h_1\)Phi\(h_2\)$, thus $Phi$ is a homomorphism, $Psi compose Phi = 1\,Phi compose Psi = bb(1)$, hence $Psi$ is bijective thus an isomorphism.

#strong[\2.]

Since $r compose i = upright(i d)_A$, $r_(*) i_(*) = bb(1)_(*)$, thus $i_(*)$ is injectivce.

#strong[\3.]

By problem 1 we have $pi_1\(D^2 times S^1\)tilde.equiv bb(Z)$ and $pi_1\(S^1 times S^1\)tilde.equiv bb(Z) times bb(Z)$, there is no injective map from $pi_1\(S^1 times S^1\)$ to $pi_1\(D^2 times S^1\)$, since if there is such a injective homomorphism, we would have $\(1\,0\)mapsto n\,\(0\,1\)mapsto m$ with $n eq.not m$, but then $\(- m\,n\)mapsto 0$ which has the same image as $\(0\,0\)$, but $\(- m\,n\)eq.not\(0\,0\)$, thus we have reached a contradiction, then by problem 2 we know that there is no such retraction.

#pagebreak(weak:true)
== Homework4
<homework4>
#strong[Hatcher 1.3.1.]

$forall x in A subset X\,exists U in.rev x$ is a neighborhood of $x$ such that $U$ is evenly covered by $p^(- 1)\(U\)union.sq.big U_alpha$, $phi.alt_alpha := p\|_(U_alpha) : U_alpha arrow.r U$ is a homeomorphism with $psi_alpha$ as its inverse. Then $U inter A in.rev x$ is a neighborhood of $x$ in $A$ such that $p^(- 1)\(U inter A\)= p^(- 1)\(U\)inter p^(- 1)\(A\)= (union.sq.big_alpha U_alpha) inter tilde(A) = union.sq.big_alpha (U_alpha inter tilde(A))$, and $phi.alt_alpha\|_(U_alpha inter tilde(A)) = p\|_(U_alpha inter tilde(A)) : U_alpha inter tilde(A) arrow.r U inter A$ is a homeomorphism with $psi_alpha\|_(U inter A)$ as its inverse. Hence, $p : tilde(A) arrow.r A$ is a covering space

#strong[\1.]

#strong[a)]

#strong[Lemma:] A finite CW complex is Hausdorff and compact.

We prove by induction, assume $X$ is a finite CW complex and it is Hausdorff and compact, using $phi.alt : S^(n - 1) arrow.r X$ to attach $D^n$ to $X$, the resulting adjunction space $X union_phi.alt D^n = X union.sq.big D^n\/tilde.op$, since $X union.sq.big D^n$ is compact, so is $X union_phi.alt D^n$, for $x eq.not y in X union_phi.alt D^n$, $iota_X$ is injective by homework 1, thus $iota_X^(- 1)\(x\)eq.not iota_X^(- 1)\(y\)$ thus have disjoint neighborhoods in $X$, also, $iota_(D^n)^(- 1)\(x\)\,iota_(D^n)^(- 1)\(y\)$ are disjoint compact set in $D^n$,but $D^n$ is a metric space, thus they have disjoint neighborhoods in $D^n$, hence $x\,y$ has disjoint neighborhood in $X union_phi.alt D^n$, therefore $X union_phi.alt D^n$ is Hausdorff

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S^n$]),
node((1,0),[$D^n$]),
node((0,1),[$X$]),
node((1,1),[$X union_phi.alt D^n$]),
edge((0,0),(1,0),"hook->",[$i$]),
edge((0,0),(0,1),"->",[$phi.alt$]),
edge((1,0),(1,1),"->",[$iota_(D^n)$]),
edge((0,1),(1,1),"hook->",[$iota_X$]))]
]
#strong[Proposition:] Let $X = X^n$ be a finite CW complex, $x_0$ is a $0$-cell, then the map $pi_1\(X^(n - 1)\,x_0\)arrow.r pi_1\(X^n\,x_0\)$ induced by inclusion is surjective where $n gt.eq 2$

There are finitely many $n$-cells, say $D_1^n\,dots.h.c\,D_m^n$, denote their origin as $O_1\,dots.h.c\,O_m$, let $U_1 := D_1^n\\partial D_1^n\,dots.h.c\,U_m := D_m^n\\partial D_m^n\,U_(m + 1) := X\\{ O_1\,dots.h.c\,O_m }$ is an open cover of $X$, $X^(n - 1)$ would be a deformation retraction of $U_(m + 1)$, since $X^(n - 1)\,D_1^n\\{ O_1 }\,dots.h.c\,D_m^n\\{ O_m }$ is a close cover of $U_(m + 1)$, $X^(n - 1)$ is closed because it is compact and $X^n$ is Hausdorff, using pasting lemma, define the homotopy $F : U_(m + 1) times I arrow.r U_(m + 1)$ by #math.equation(block: true, numbering: none, $F\(x\,t\) & = x\,thin forall x in X^(n - 1)\
F\(x\,t\) & =\(1 - t\)x + t frac(x, \|x\|)\,thin forall x in D_i^n\\{ O_i }$) Hence for any loop $gamma in pi_1\(X^n\,x_0\)$, using Lebesgue's number lemma, we can divide the time into intervals $\[s_j\,s_(j + 1)\]$ so that each interval live inside one of $U_i$'s, then the ones that are not contained in $U_(m + 1)$ must be contained in some $U_i\,i lt.eq m$ and went through $O_i$, thus by wiggle it a little we can make $gamma$ contained in $U_(m + 1)$, then compose with the deformation retract, we know that $gamma$ is homotopic to an element in $pi_1\(X^(n - 1)\,x_0\)$

This would imply $pi_1\(X^1\,x_0\)arrow.r dots.h.c arrow.r pi_1\(X^n\,x_0\)$ is surjective

#strong[Remark:] As it came to me afterwards, I could just define $F : X^(n - 1) union.sq.big_(i = 1)^m D_i^n times I arrow.r X^(n - 1) union.sq.big_(i = 1)^m D_i^n$ by #math.equation(block: true, numbering: none, $F\(x\,t\) & = x\,thin forall x in X^(n - 1)\
F\(x\,t\) & =\(1 - t\)x + t frac(x, \|x\|)\,thin forall x in D_i^n\\{ O_i }$) Then $F$ could be factor through the quotient space $X times I$, thus induce $G : X times I arrow.r X^(n - 1) union.sq.big_(i = 1)^m D_i^n arrow.r X times I$ is a homotopy for the deformation retract

#strong[b)]

$S^1 or S^n$ could be given a CW complex structure as below with one $0$-cell, one $1$-cell and one $n$-cell

#align(center)[
#svg-drawing("<circle cx='280' cy='90' r='60'/><path d='M220 90A60 18 0 0 1 340 90' stroke-dasharray='4 3'/><path d='M220 90A60 18 0 0 0 340 90'/><ellipse cx='160' cy='90' rx='60' ry='18'/><circle cx='220' cy='90' r='2' fill='black'/>")
]
Thus by a), $bb(Z) tilde.equiv pi_1\(S^1\)arrow.r^phi pi_1\(S^1 or S^n\)$ is surjective, then $pi_1\(S^1 or S^n\)tilde.equiv pi_1\(S^1\)\/ker phi$, then $p : X arrow.r S^1 or S^n$ is a covering map, let $H subset X$ be the helix which is $p^(- 1)\(S^1\)$, thus by Hatcher 1.3.1. we know $p\|_H : H arrow.r S^1$ is a covering map, suppose $ker phi eq.not 0$, then $exists gamma$ such that $0 eq.not\[gamma\]in pi_1\(S^1\,x_0\)$ but $0 =\[gamma\]in pi_1\(S^1 or S^n\,x_0\)$, suppose $tilde(gamma)$ is a path from $A$ to $B$,such that $p\(tilde(gamma)\)= gamma$, then $tilde(gamma)$ is a lift of $gamma$ under either $p\|_H$ or $p$, by the uniqueness of homotopy lifting, we know that $A eq.not B$, but for the same reason, $\[gamma\]eq.not 0$ in $pi_1\(S^1 or S^n\)$ which is a contradiction, thus $ker phi = 0$ and hence $pi_1\(S^1 or S^n\)tilde.equiv bb(Z)$

#align(center)[
#svg-drawing("<path d='" + sampled-path(t => (220 + 11 * (-3 + 3 * calc.cos(t * 1rad)), 200 - 11 * (4 + 3 * calc.pi + 0.5 * t + 1.2 * calc.sin(t * 1rad))), start: -0.3 * calc.pi) + "'/><path d='" + sampled-path(t => (220 + 11 * (-3 + 3 * calc.cos(t * 1rad)), 200 - 11 * (4 + 0.5 * t + 1.2 * calc.sin(t * 1rad))), stop: 2.3 * calc.pi) + "'/><path d='" + sampled-path(t => (220 + 11 * (-3 + 3 * calc.cos(t * 1rad)), 200 - 13.2 * calc.sin(t * 1rad))) + "'/><circle cx='231' cy='156' r='11'/><circle cx='231' cy='121.442' r='11'/><circle cx='231' cy='52.327' r='11'/><circle cx='231' cy='200' r='11'/><path d='M220 156A11 3.3 0 0 1 242 156M220 121.442A11 3.3 0 0 1 242 121.442M220 52.327A11 3.3 0 0 1 242 52.327M220 200A11 3.3 0 0 1 242 200' stroke-dasharray='2 2'/><path d='M220 156A11 3.3 0 0 0 242 156M220 121.442A11 3.3 0 0 0 242 121.442M220 52.327A11 3.3 0 0 0 242 52.327M220 200A11 3.3 0 0 0 242 200'/><path d='M220 167V189' marker-end='url(#a)'/><g fill='black' stroke='none' font-family='serif' font-size='12'><circle cx='220' cy='156' r='2'/><circle cx='220' cy='52.327' r='2'/><circle cx='220' cy='200' r='2'/><circle cx='187' cy='136' r='1.5'/><circle cx='187' cy='129' r='1.5'/><circle cx='187' cy='122' r='1.5'/><text x='208' y='157'>A</text><text x='208' y='53'>B</text><text x='204' y='201'>x₀</text><text x='225' y='177'>p</text></g>", height: 230)
]
#strong[\2.]

Let $p : bb(R) arrow.r S^1\,t mapsto upright(e)^(2 pi i t)$ be a covering map, and $e_1 : I arrow.r S^1\,t mapsto upright(e)^(2 pi i t)$ be the generator of $pi_1\(S^1\,1\)$, by homotopy lift we can find $F$ is a lift of $f\(e_1\)$, and $1 eq.not n := deg\(f\)= F\(1\)- F\(0\)in bb(Z)$. Define $G\(t\):= F\(t\)- t$, then $G\(0\)= F\(0\)\,G\(1\)= F\(1\)- 1$, thus $\|G\(0\)- G\(1\)\|=\|F\(1\)- F\(0\)- 1\|gt.eq lr(|\| F \( 1 \) - F \( 0 \) \| - 1|) gt.eq 1$, since $G$ is continuous, $exists t in I$ such that $F\(t\)- t = G\(t\)in bb(Z)$, thus $f (e_1 \( t \)) = p compose F\(t\)= p\(t\)= upright(e)^(2 pi i t) = e_1\(t\)$, thus $f$ has a fixed point

#strong[\3.]

It is easy to show that $g : Y arrow.r Y\,y mapsto y g$ is a homeomorphism, denote the quotient map as $q$, then for any $q\(y\)in Y\/G$, since $G$ is a properly discontinuous action on $Y$, there exists a open neighborhood $U$ of $y$ such that $U inter U g = diameter$, thus $q^(- 1)\(q\(U\)\)= union.sq.big_(g in G) U g$ which is open, so is $q\(U\)$, and also $q\|_(U g)$ is continuous, injective and surjective, for any open set in $U g$ which would have the form $U g inter V g =\(U inter V\)g$ where $V$ is open in $Y$, $q\|_(U g)\(\(U inter V\)g\)= U inter V$ is open, thus $q\|_(U g)$ is also open, hence a homeomorphism. Therefore $q$ is indeed a covering map

#pagebreak(weak:true)
== Homework5
<homework5>
#strong[Hatcher 1.3.2.]

$forall\(x_1\,x_2\)in X_1 times X_2$, $exists U_1\,U_2$ are open neighborhoods of $x_1\,x_2$, such that $p_1^(- 1)\(U_1\)= union.sq.big_alpha U_(1 alpha)$, $p_1\|_(U_(1 alpha))$ is a homeomorphism and $p_2^(- 1)\(U_2\)= union.sq.big_beta U_(2 beta)$, $p_1\|_(U_(2 beta))$ is a homeomorphism, then $U_1 times U_2$ is an open neighborhood of $\(x_1\,x_2\)$, such that $\(p_1 times p_2\)^(- 1)\(U_1 times U_2\)= p_1^(- 1)\(U_1\)times p_2^(- 1)\(U_2\)= union.sq.big_(alpha\,beta) U_(1 alpha) times U_(2 beta)$ and $\(p_1 times p_2\)\|_(U_(1 alpha) times U_(2 beta)) = p_1\|_(U_(1 alpha)) times p_2\|_(U_(2 beta))$ is a homeomorphism

#strong[Hatcher 0.11.]

#math.equation(block: true, numbering: none, $bb(1) tilde.eq h f tilde.eq h f g f tilde.eq g f$) #strong[Hatcher 1.3.8.]

Assume $p : X arrow.r Y$ and $q : Y arrow.r X$ are the covering maps, and $phi : X arrow.r Y$ and $psi : Y arrow.r X$ satisfying $psi phi tilde.eq upright(i d)_X\,phi psi tilde.eq upright(i d)_Y$, Since $tilde(X)$ and $tilde(Y)$ is simply connected, thus $exists tilde(phi) : tilde(X) arrow.r tilde(Y)$ and $exists tilde(psi) : tilde(Y) arrow.r tilde(X)$ are lifts of $phi p$ and $psi q$, then $p tilde(psi) tilde(phi) = psi q tilde(phi) = psi phi p$, thus $tilde(psi) tilde(phi)$ is a lift of $psi phi p$, suppose $psi phi tilde.eq^H upright(i d)_X$, then by homotopy lifting property, we have $tilde(H)$, where $tilde(H)\(x\,0\)= tilde(psi) tilde(phi)$, $tilde(H)\(x\,1\)$ is the lift of $upright(i d)_X p = p$, pick $x_0 in tilde(X)$, $tilde(H)\(x_0\,1\)in p^(- 1)\(x_0\)$ might not be $x_0$, but $exists Phi : tilde(X) arrow.r tilde(X)$ sending $tilde(H)\(x_0\,1\)$ to $x_0$ which is a lift of $p$, then $Phi tilde(H)\(x\,1\)$ is a lift of $p$ sending $x_0$ to $x_0$, by uniqueness, we have $Phi tilde(H)\(x\,1\)= upright(i d)_(tilde(X))$, also, $tilde(H)\(x\,1\)Phi = upright(i d)_(tilde(X))$, thus $tilde(psi) tilde(phi) tilde.eq tilde(H)\(x\,1\)$ is a homotopy equivalence, $upright(i d)_(tilde(X)) = Phi tilde(H)\(x\,1\)tilde.eq (Phi tilde(psi)) tilde(phi)$, similarly, $exists Psi : tilde(Y) arrow.r tilde(Y)$, such that $upright(i d)_(tilde(Y)) tilde.eq tilde(phi) (tilde(psi) Psi)$, by Hatcher 0.11, we have $tilde(X) tilde.eq^(tilde(phi)) tilde(Y)$

#strong[\1.]

There exists an open neighborhood $U$ of $x$ such that $p_1^(- 1)\(U\)= union.sq.big_alpha U_alpha$, $p_1\|_(U_alpha)$ is a homeomorphism, and $p_2^(- 1)\(U\)= union.sq.big_beta V_beta$, $p_2\|_(U_beta)$ is a homeomorphism, assume there is a lift $tilde(p)_1$, fix $U_alpha$ then $tilde(p)_1\(U_alpha\)subset p_2^(- 1)\(U\)$ is connected, thus $tilde(p)_1\(U_alpha\)subset V_beta$ for some $beta$, but since $p_2 (tilde(p)_1 \( U_alpha \)) = U$, $tilde(p)_1\(U_alpha\)= V_beta$, since $p_1\|_(U_alpha)\,p_2\|_(V_beta)$ are homeomorphisms, so is $tilde(p)_1\|_(U_alpha) = (p_2 \|_(V_beta))^(- 1) compose p_1\|_(U_alpha)$, thus $tilde(p)_1$ is a covering map

#strong[\2.]

#strong[Case I: $n = 1$]

Since $bb(R P) tilde.equiv S^1$, $pi_1\(bb(R P)\,\[x_0\]\)tilde.equiv bb(Z)$

#strong[Case II: $n gt.eq 2$]

For any $gamma in pi_1\(bb(R P)^n\,\[x_0\]\)$, it can be lifts up to $tilde(gamma)$ which starts at $x_0$ and ends at $x_0$ or $- x_0$, since $pi_1\(S^n\,x_0\)= 0$, thus $tilde(gamma)$ has only two different choice up to homotopy, ending at $x_0$ or $- x_0$, thus $gamma$ also has only to different choice, thus $\|pi_1\(bb(R P)^n\,\[x_0\]\)\|= 1 arrow.r.double pi_1\(bb(R P)^n\,\[x_0\]\)= bb(Z)\/2 bb(Z)$

#strong[\3.]

#strong[Case I: $n = 1$]

The statement is false. Consider $bb(R P) tilde.equiv S^1 arrow.r^(upright(i d)) S^1$

#strong[Case II: $n gt.eq 2$]

The statement is true. since $bb(R P) arrow.r^f S^1$ would induce a injective group homomorphism $bb(Z)\/2 bb(Z) tilde.equiv pi_1\(bb(R P)^n\)arrow.r^(f_(*)) pi_1\(S^1\)tilde.equiv bb(Z)$, hence $f_(*)\(pi_1\(bb(R P)\)\)= { 0 }$, thus there exists a lift $bb(R P) arrow.r^(tilde(f)) bb(R)$, then $tilde(f) tilde.eq c$ by a linear homotopy, so $f tilde.eq c$

#strong[\4.]

Assume $pi : X arrow.r T$ is the covering map, $T = I^2\/tilde.op$ is the torus, where $\(x\,0\)tilde.op\(x\,1\)\,\(0\,y\)tilde.op\(1\,y\)$

#strong[Case I: $X tilde.eq { * }$]

$X = bb(R)^2$, $pi\(x\,y\)= [\( x \, y \) - \( floor.l x floor.r \, floor.l y floor.r \)]$

#strong[Case II: $X tilde.eq S^1$]

$X = I times bb(R)\/tilde.op$, where $\(0\,y\)tilde.op\(1\,y\)$, $pi\[\(x\,y\)\]= [\( x \, y \) - \( floor.l x floor.r \, floor.l y floor.r \)]$

#strong[Case III: $X tilde.eq S^1 times S^1$]

$X = 2 I times 2 I\/tilde.op$, where $\(x\,0\)tilde.op\(x\,2\)\,\(0\,y\)tilde.op\(2\,y\)$, $pi\[\(x\,y\)\]= [\( x \, y \) - \( floor.l x floor.r \, floor.l y floor.r \)]$

#pagebreak(weak:true)
== Homework6
<homework6>
#strong[Hatcher 1.3.22.]

Since $G_1\,G_2$ acts proper discontinuously on $X_1\,X_2$, thus, $forall x_1 in X_1\,x_2 in X_2$, there exist neighborhoods $U_1 in.rev x_1\,U_2 in.rev x_2$, such that $g_1 U_1 inter U_1 = diameter\,g_2 U_2 inter U_2 = diameter\,forall g_1 in G_1\,g_2 in G_2$, thus $\(g_1\,g_2\)\(U_1\,U_2\)inter\(U_1\,U_2\)=\(g_1 U_1\,g_2 U_2\)inter\(U_1\,U_2\)=\(g_1 U_1 inter U_1\,g_2 U_2 inter U_2\)= diameter\,forall\(g_1\,g_2\)in G_1 times G_2$, hence $G_1 times G_2$ acts proper discontinuously on $X_1 times X_2$

Define $phi : X_1\/G_1 times X_2\/G_2 arrow.r\(X_1 times X_2\)\/\(G_1 times G_2\)\,thin\(\[x_1\]\,\[x_2\]\)mapsto\[\(x_1\,x_2\)\]$ which is well-defined, since $\[x_1\]=\[y_1\]\,\[x_2\]=\[y_2\]arrow.r.double y_1 = g_1 dot.op x_1\,y_2 = g_2 dot.op x_2 arrow.r.double\(y_1\,y_2\)=\(g_1\,g_2\)dot.op\(x_1\,x_2\)arrow.r.double\[\(y_1\,y_2\)\]=\[\(x_1\,x_2\)\]$

Similarly, there is a well-defined map $psi :\(X_1 times X_2\)\/\(G_1 times G_2\)arrow.r X_1\/G_1 times X_2\/G_2\,thin\[\(x_1\,x_2\)\]mapsto\(\[x_1\]\,\[x_2\]\)$

As defined above, since $phi\(\[U_1\]times\[U_2\]\)=\[U_1 times U_2\]in.rev\[\(x_1\,x_2\)\]$, we know $phi$ is continuous, similarly, $psi$ is also continuous, and since $phi compose psi = bb(1)\,psi compose phi = bb(1)$, $X_1\/G_1 times X_2\/G_2$ and $\(X_1 times X_2\)\/\(G_1 times G_2\)$ are homeomorphic

#strong[\1.]

$Gamma\(E v\(dot.op\)\): A u t\(X\)arrow.r pi_1\(B\,b\)$ is an isomorphism

#strong[\(a)]

The main reason is that $pi_1\(S^1 times S^1\)tilde.equiv bb(Z) times bb(Z)$ is abelian

Let $alpha\,beta in pi_1\(S^1 times S^1\)$ be two generators and $phi.alt_1\,phi.alt_2 in A u t\(X\)$ such that $Gamma\(E v\(phi.alt_1\)\)= alpha\,Gamma\(E v\(phi.alt_2\)\)= beta$

Since any element in $pi_1\(B\,b\)$ can be written uniquely as $gamma = alpha^n star.op beta^m$, then $Gamma\(E v\(phi.alt_1^n dot.op phi.alt_2^m\)\)= Gamma\(E v\(phi.alt_1\)\)^n star.op Gamma\(E v\(phi.alt_2\)\)^m = gamma$, $forall x in F$, we have $x dot.op gamma =\(alpha^n star.op beta^m\)dot.op x =\(beta^m star.op alpha^n\)dot.op x$, and $x dot.op gamma = x dot.op\(phi.alt_1^n dot.op phi.alt_2^m\)= phi.alt_2^m\(phi.alt_1^n\(x\)\)$, they coincide

#strong[\(b)]

The main reason is that $pi_1\(S^1 or S^1\)tilde.equiv bb(Z) * bb(Z)$ is not abelian

Let $alpha\,beta in pi_1\(S^1 or S^1\)$ be two generators and $phi.alt_1\,phi.alt_2 in A u t\(X\)$ such that $Gamma\(E v\(phi.alt_1\)\)= alpha\,Gamma\(E v\(phi.alt_2\)\)= beta$

Then we have $alpha star.op beta eq.not beta star.op alpha$, consider $\(alpha star.op beta\)dot.op x eq.not\(beta star.op alpha\)dot.op x = phi.alt_2\(phi.alt_1\(x\)\)= x dot.op\(phi.alt_1 dot.op phi.alt_2\)$, hence these two actions don't coincide

#strong[\2.]

Suppose $phi.alt : E arrow.r E$ is a covering homomorphism, $forall x in E$, let $b = p\(x\)$ and $U$ be a evenly covered path connected neighborhood of $b$, let $p^(- 1)\(U\)= union.sq.big_(i = 1)^n V_i$, $x in V_j$, then $phi.alt\(V_j\)subset.eq p^(- 1)\(U\)$, since $V_j tilde.equiv U$ is connected, so is $phi.alt\(V_j\)$, thus $phi.alt\(V_j\)subset.eq V_k$ for some $k$, but then $phi.alt\|_(V_j) = p\|_(V_k)^(- 1) compose p\|_(V_k)$, thus $phi.alt\(V_j\)= V_k$ and $phi.alt$ is a local homeomorphism, For any $y in F := p^(- 1)\(b\)$, there is a path $alpha$ from $phi.alt\(x\)$ to $y$, let $beta$ be the lift of $p compose alpha$ starting at $x$ against $p$, then $phi.alt compose beta$ will be the lift of $p compose alpha$ starting at $phi.alt\(x\)$ which is just $alpha$, thus $phi.alt\(beta\(1\)\)= y$, $phi.alt$ is surjective, since $p$ is finitely sheeted, $phi.alt$ is bijective, hence $phi.alt$ is a homeomorphism

#strong[\3.]

#strong[Lemma:] $H lt.eq G$ is a subgroup satisfies $H lt.eq g^(- 1) H g\,forall g in G$, then $H$ is a normal subgroup

#strong[Proof:] $H lt.eq g^(- 1) H\(g^(- 1)\)^(- 1) = g^(- 1) H g$, thus $g H g^(- 1) lt.eq H$, hence $H = g^(- 1) H g\,forall g in G$

Suppose $p_(*)\(pi_1\(E\,x\)\)lt.eq pi_1\(B\,b\)$ is a normal subgroup, $forall x' in F$, assume $tilde(gamma)$ is a path from $x$ to $x'$, $gamma = p\(tilde(gamma)\)$, then $p_(*)\(pi_1\(E\,x\)\)=\[gamma\]p_(*)\(pi_1\(E\,x\)\)\[gamma\]^(- 1) = p_(*)\(pi_1\(E\,x'\)\)$, hence there is a lift $phi$ of $p$ against $p$, with $phi\(x\)= x'$, thus $phi$ is a deck transformation

Conversely, $forall\[gamma\]in pi_1\(B\,b\)$, there is a lift $tilde(gamma)$ starting at $x$, let $tilde(gamma)\(1\)= x'$, since there is a deck transformation $phi$ with $phi\(x\)= x'$

Thus $p_(*)\(pi_1\(E\,x\)\)lt.eq p_(*)\(pi_1\(E\,x'\)\)=\[gamma\]p_(*)\(pi_1\(E\,x\)\)\[gamma\]^(- 1)$, by lemma we know $p_(*)\(pi_1\(E\,x\)\)lt.eq pi_1\(B\,b\)$ is a normal subgroup

#pagebreak(weak:true)
== Homework7
<homework7>
#strong[Hatcher 1.3.10.]

Using the homotopy lifting property and its uniqueness we get all connected $2$-sheeted coverings up to isomorphisms are

#v(2cm)
#align(center)[
#svg-drawing("<path d='M100 90C150 10 290 10 340 90M100 90C150 170 290 170 340 90M340 90C290 45 150 45 100 90M340 90C290 135 150 135 100 90'/><path d='M210 30H230' marker-end='url(#a)'/><path d='M210 150H230' marker-end='url(#a)'/><path d='M230 63H210' marker-end='url(#a)'/><path d='M230 117H210' marker-end='url(#a)'/><g fill='black' stroke='none' font-family='serif' font-size='13'><text x='215' y='24'>a</text><text x='215' y='164'>b</text><text x='215' y='80'>a</text><text x='215' y='109'>b</text></g>")
#svg-drawing("<path d='M120 90Q220 35 320 90M120 90Q220 145 320 90'/><circle cx='95' cy='90' r='25'/><circle cx='345' cy='90' r='25'/><path d='M210 64H230' marker-end='url(#a)'/><path d='M210 117H230' marker-end='url(#a)'/><path d='M95 65H100' marker-end='url(#a)'/><path d='M345 115H340' marker-end='url(#a)'/><g fill='black' stroke='none' font-family='serif' font-size='13'><text x='215' y='56'>a</text><text x='215' y='134'>a</text><text x='62' y='93'>b</text><text x='374' y='93'>b</text></g>")
]
And all connected $3$-sheeted coverings up to isomorphisms are

#v(3cm)
#strong[Hatcher 1.3.12.]

Consider normal covering

#v(3cm)
Then $p_(*)\(pi_1\(E\,e\)\)lt.eq pi_1\(B\,b\)$ is a normal subgroup, $a^2\,b^2\,\(a b\)^4 in p_(*)\(pi_1\(E\,e\)\)$, and any element in $pi_1\(E\,e\)$ could be written as a product of $a^2\,b^2\,\(a b\)^4$, thus $p_(*)\(pi_1\(E\,e\)\)$ is contained in the normal subgroup generated by $a^2\,b^2\,\(a b\)^4$, hence they are the same

#strong[Hatcher 1.3.29.]

$p_1 : Y arrow.r Y\/G_1\,thin y mapsto G_1 y\,thin p_2 : Y arrow.r Y\/G_2\,thin y mapsto G_2 y$ are both quotient and covering maps

If $G_2 = g G_1 g^(- 1)$ are conjugate subgroups, for some $g in upright(H o m e o)\(Y\)$, define $overline(g) : Y\/G_1 arrow.r Y\/G_2\,thin G_1 y mapsto G_2 g y$, it is well-defined since $overline(g)\(G_1 g y\)= G_2 g g_1 y = G_2 g_2 g y = G_2 g y$ for some $g_2 in G_2$ such that $g g_1 g^(- 1) = g_2$

Since, thus the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$Y$]),
node((2,0),[$Y$]),
node((1,1),[$Y\/G_1$]),
node((2,1),[$Y\/G_2$]),
edge((1,0),(2,0),"->",[$g$]),
edge((1,0),(1,1),"->",[$p_1$]),
edge((1,0),(2,1),"->",[$p_2 g$]),
edge((2,0),(2,1),"->",[$p_2$]),
edge((1,1),(2,1),"->",[$overline(g)$]))]
]
Also, $p_2 g$ is continuous and $p_1$ is a quotient map, hence $overline(g)$ is continunous

Similarly, define $overline(g)^(- 1) : Y\/G_2 arrow.r Y\/G_1\,thin G_2 y mapsto G_1 g^(- 1) y$ is also continuous, then $overline(g)\,overline(g)^(- 1)$ are inverses of each other, hence $overline(g) : Y\/G_1 arrow.r Y\/G_2$ is a homeomorphism

Conversely, suppose $phi : Y\/G_1 arrow.r Y\/G_2$ is a homeomorphism, let $psi = phi^(- 1)$, Since $Y$ is path connected, locally path connected, simply connected, choose some $y_1\,y_2 in Y$, such that $phi\(G_1 y\)= G_2 y$, then there exists a lift of $phi p_1$ against $p_2$, $Phi : Y arrow.r Y$ such that the following diagram commutes with $Phi\(y_1\)= y_2$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$Y$]),
node((2,0),[$Y$]),
node((1,1),[$Y\/G_1$]),
node((2,1),[$Y\/G_2$]),
edge((1,0),(2,0),"->",[$Phi$]),
edge((1,0),(1,1),"->",[$p_1$]),
edge((2,0),(2,1),"->",[$p_2$]),
edge((1,1),(2,1),"->",[$phi$]))]
]
Similarly, $exists Psi : Y arrow.r Y$ such that the following diagram commutes with $Psi\(y_2\)= y_1$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$Y$]),
node((2,0),[$Y$]),
node((1,1),[$Y\/G_1$]),
node((2,1),[$Y\/G_2$]),
edge((1,0),(1,1),"->",[$p_1$]),
edge((2,0),(1,0),"->",[$Psi$]),
edge((2,0),(2,1),"->",[$p_2$]),
edge((2,1),(1,1),"->",[$psi$]))]
]
Then $Psi Phi : Y arrow.r Y$ is a deck transformation sending $y_1$ to $y_1$, thus $Psi Phi = bb(1)$, similarly, $Phi Psi = bb(1)$, hence $Phi in upright(H o m e o)\(Y\)\,Psi = Phi^(- 1)$, we need to show $Phi G_1 Phi^(- 1) = G_2$

$forall y in Y\,thin G_2 Phi g_1 Phi^(- 1) y = p_2 Phi g_1 Phi^(- 1) y = phi p_1 g_1 Phi^(- 1) y = phi G_1 g_1 Phi^(- 1) y = phi G_1 Phi^(- 1) y = phi p_1 Phi^(- 1) y = p_2 Phi Phi^(- 1) y = p_2 y = G_2 y$ which implies $Phi g_1 Phi^(- 1)$ is a deck transformation of $p_2 : Y arrow.r Y\/G_2$, hence $Phi g_1 Phi^(- 1) in G_2 arrow.r.double Phi G_1 Phi^(- 1) lt.eq G_2$, similarly, $Psi G_2 Psi^(- 1) lt.eq G_1 arrow.r.double G_2 lt.eq Phi G_1 Phi^(- 1)$, thus $G_2 = Phi G_1 Phi^(- 1)$

#strong[\1.]

Suppose $E_1 arrow.r^(p_1) B\,thin E_2 arrow.r^(p_2) B$ are any two simply connected covers, $b = p_1\(e_1\)= p_2\(e_2\)$ for some $e_1 in E_1\,e_2 in E_2$, then $exists Phi : E_1 arrow.r E_2$ with $Phi\(e_1\)= e_2$ and $exists Psi : E_2 arrow.r E_1$ with $Phi\(e_2\)= e_1$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$E_1$]),
node((2,0),[$E_2$]),
node((3,0),[$E_1$]),
node((1,1),[$B$]),
node((2,1),[$B$]),
node((3,1),[$B$]),
edge((1,0),(2,0),"->",[$Phi$]),
edge((1,0),(1,1),"->",[$p_1$]),
edge((2,0),(3,0),"->",[$Psi$]),
edge((2,0),(2,1),"->",[$p_2$]),
edge((3,0),(3,1),"->",[$p_1$]))]
]
Thus $Psi Phi : E_1 arrow.r E_1$ sends $e_1$ to $e_1$, by the uniqueness of liftings, $Psi Phi = bb(1)$, similarly, $Phi Psi = bb(1)$, hence $E_1 arrow.r^Phi E_2$ is a homeomorphism

#strong[\2.]

Denote the set of $G$-equivariant maps $G\/H arrow.r Y$ as $Y$

Define $phi : Y arrow.r X^H$, by $phi\(f\)= f\(H\)$, since $f$ is $G$-equivariant, $h f\(H\)= f\(h H\)= f\(H\)$, thus $f\(H\)in X^H$ and also define $psi : X^H arrow.r Y$ by $psi\(x\)= f$ where $f\(g H\)= g x$ is a $G$-equivariant map, it is obvious that $phi psi = psi phi = bb(1)$, we only need to show both $phi$ and $psi$ are continuous

Let $X^(G\/H)$ be the set of continuous functions from $G\/H$ to $X$, ${ U union X^H\|U upright(" open in ") X }$ are the open sets of $X^H$, and $inter.big_(i = 1)^n {f in X^(G\/H) \|f \( g_i \( H \) \) in U_(g_i H)}$ form a basis for $X^(G\/H)$, where $U_(g_i H)$ is just some open set in $X$ with $g_i H$ as its index

Thus #math.equation(block: true, numbering: none, $inter.big_(i = 1)^n {f in X^(G\/H) \|f \( g_i \( H \) \) in U_(g_i H)} inter.big Y & = inter.big_(i = 1)^n {f in Y \|g_i f \( H \) in U_(g_i H)}\
 & = inter.big_(i = 1)^n {f in Y \|f \( H \) in g_i^(- 1) U_(g_i H) inter X^H}$) Form a basis for $Y$, Since #math.equation(block: true, numbering: none, $phi ({f in Y \|f \( H \) in U inter X^H}) subset.eq U inter X^H$) And #math.equation(block: true, numbering: none, $psi (inter.big_(i = 1)^n g_i^(- 1) U_(g_i H) inter.big X^H) subset.eq inter.big_(i = 1)^n {f in Y \|f \( H \) in g_i^(- 1) U_(g_i H) inter X^H}$) $phi$ and $psi$ are both continuous

#strong[\3.]

Let $X = bb(R) times I$ which is simply connected, define group action $bb(Z) times X arrow.r X$ by $\(n\,\(x\,t\)\)mapsto f^n\(x\,t\)$, then $p : X arrow.r X\/bb(Z)$ is a universal cover

#strong[\(a)]

Since isomorphism classes of covering spaces are in one to one correspondence to conjugacy classes of subgroups, all path connected covering spaces of the Mobius band up to a covering isomorphism are $p_n : X\/n bb(Z) arrow.r X\/bb(Z)\,n bb(Z)\(x\,t\)mapsto bb(Z)\(x\,t\)$, where $n = 0\,1\,2 dots.h.c$ , thus $p_n_(*)\(X\/n bb(Z)\)= n bb(Z)$

#strong[\(b)]

Since $m\|n arrow.l.r.double p_m_(*)\(X\/m bb(Z)\)= m bb(Z) lt.eq n bb(Z) = p_n_(*)\(X\/n bb(Z)\)$, hence all homomorphisms between these covering spaces are $phi_(n\,m) : X\/n bb(Z) arrow.r X\/m bb(Z)\,n bb(Z)\(x\,t\)mapsto m bb(Z)\(x\,t\)$

#pagebreak(weak:true)
== Homework8
<homework8>
#strong[Hatcher 1.2.3.]

Assume this finite set of points are $S = { p_1\,dots.h.c\,p_n }$, let $U_i = bb(R)^n\\{ p_i }$, then $U_i tilde.equiv S^n$ is simply connected, $U_i inter U_j$ is path connected and ${ U_i }$ forms an open cover for $bb(R)^n\\S$, by Van-Kampen's theorem, $* pi_1\(U_i\)arrow.r pi_1\(bb(R)^n\\S\)$ is surjective, hence $pi_1\(bb(R)^n\\S\)= 0$

#strong[Hatcher 1.2.8.]

Could imagine put a torus $T_1$ exactly on top of the other $T_2$, then they overlap on a circle $C$, $C$ has a neighborhood $W$ which is open and can be deformation retract to $C$, let $U_1 = T_1 union W\,U_2 = T_2 union W$, then $U_1$ is homotopic to $T_1$, $U_2$ is homotopic to $T_2$, $U_1 inter U_2 = W$ is homotopic to $C$, by Van-Kampen's theorem, the resulting space $X$ has fundamental group #math.equation(block: true, numbering: none, $pi_1\(X\) & = frac(F\(a\,b\)\/chevron.l a b a^(- 1) b^(- 1) chevron.r * F\(c\,d\)\/chevron.l c d c^(- 1) d^(- 1) chevron.r, chevron.l a c^(- 1) chevron.r)\
 & = F\(a\,b\,c\,d\)\/chevron.l a b a^(- 1) b^(- 1)\,c d c^(- 1) d^(- 1)\,a c^(- 1) chevron.r\
 & = F\(a\,b\,d\)\/chevron.l a b a^(- 1) b^(- 1)\,a d a^(- 1) d^(- 1) chevron.r\
 & = F\(b\,d\)times chevron.l a chevron.r\
 & tilde.equiv F_2 times bb(Z)$) Which isn't surprising since $X =\(S^1 or S^1\)times S^1$, $pi_1\(X\)= F_2 times bb(Z)$

#strong[Hatcher 1.2.21.]

Let $q : X times Y times I arrow.r X * Y$ be the quotient map

First, assume $Y$ is path connected, consider $U = q (X times Y times \[ 0 \, 2 / 3 \))\,V = q (X times Y times \( 1 / 3 \, 1 \])$which form an open cover for $X * Y$, $X times Y times\[0\,2 / 3\)$ deformation retracts to $q\(X times Y times { 0 }\)tilde.equiv X$, $X times Y times\(1 / 3\,1\]$ deformation retracts to $q\(X times Y times { 1 }\)tilde.equiv Y$, $U inter V = X times Y times\(1 / 3\,2 / 3\)$ is path connected and deformation retracts to $q\(X times Y times { 1 / 2 }\)tilde.equiv X times Y$, thus we have $pi_1\(U\)= pi_1\(X\)\,pi_1\(V\)= pi_1\(Y\)$ and $i_U_(*)\(pi_1\(U inter V\)\)= pi_1\(X\)\,i_V_(*)\(pi_1\(U inter V\)\)= pi_1\(Y\)$, where $i_U : U inter V arrow.r U\,i_V : U inter V arrow.r V$ are inclusion maps, by Van-Kampen's theorem, we get $pi_1\(X * Y\)= 0$

In general, consider ${ Y_i }$ to be the path connected components of $Y$, let $Z = q (X times Y times \[ 0 \, 1 / 2 \))\,U_i =\(X times Y_i times I\)union Z$, ${ U_i }$ forms an open cover of $X * Y$, and $U_i inter U_j = Z$ deformation retracts to $q\(X times Y times { 0 }\)tilde.equiv X$, which is path connected, by Van-Kampen's theorem, $* pi_1\(x times Y_i times I\)tilde.equiv * pi_1\(U_i\)arrow.r pi_1\(X * Y\)$ is surjective, hence $pi_1\(X * Y\)= 0$

#strong[\1.]

$X$ could be given the following CW structure: 2 0-cells, 3 1-cells and 2 2-cells

#v(1.5cm)
Let $X^1$ be the 1-skeleton of $X$, then by attaching these two cells on $X^1$, we have $pi_1\(X\)= pi_1\(X^1\)\/chevron.l c a^(- 1) chevron.r tilde.equiv bb(Z)$

#strong[\2.]

Suppose $M$ has $alpha_n$ $n$-cells, and $N$ has $beta_n$ $n$-cells, then $M times N$ also has a CW structure with $gamma_n = sum_(k + l = n) alpha_k beta_l$ $n$-cells, thus #math.equation(block: true, numbering: none, $chi\(M times N\) & = sum_(n gt.eq 0)\(- 1\)^n gamma_n\
 & = sum_(n gt.eq 0) sum_(k + l = n)\(- 1\)^(k + l) alpha_k beta_l\
 & = (sum_(k gt.eq 0) \( - 1 \)^k alpha_k) (sum_(l gt.eq 0) \( - 1 \)^l beta_l)\
 & = chi\(M\)chi\(N\)$) #strong[\3.]

For a connected graph $X$, assuming it has $v$ 0-cells and $e$ 1-cells, find a maximal tree $T$ of $X$, then we have $chi\(X\)+ n = v -\(e - n\)= chi\(T\)= 1 arrow.r.double n = 1 - chi\(X\)$ where $n$ is the number of generators of free group $pi_1\(X\)$

Let $X$ be $n$ copies of $S^1$ wedge at a point, then $G = pi_1\(X\)$ is a free group on $n$ generators, for a subgroup $H lt.eq G$ of index $k$, we could find a covering $p : E arrow.r X$ with $p_(*)\(pi_1\(E\)\)= H$, then $E$ is also a connected graph with $k v$ 0-cells and $k e$ 1-cells, thus we have the number of generators of free group $H$ is $1 - chi\(E\)= 1 -\(k v - k e\)= 1 - k chi\(X\)= 1 - k\(1 - n\)= 1 - k + n k$

#pagebreak(weak:true)
== Homework9
<homework9>
#strong[\1.]

#v(13cm)
Thus the standard form is $e j e^(- 1) j^(- 1) i h i^(- 1) h^(- 1)$ which is $M_2$

#strong[\2.]

#strong[\(a)]

$F : G arrow.r upright(S e t)$ is a functor, then $F\(*\)= S$ is a set, $F\(g\): S arrow.r S$ is a map, also, $F\(e\)= upright(i d)_S\,F\(g h\)= F\(g\)F\(h\)$, thus $F$ is precisely a group action and vice versa

#strong[\(b)]

$F : G arrow.r upright(V e c)$ is a functor, then $F\(*\)= V$ is a $K$-vector space, $F\(g\): V arrow.r V$ is a linear transformation, also, $F\(e\)= upright(i d)_V\,F\(g h\)= F\(g\)F\(h\)$, thus $F$ is precisely a group representation and vice versa

#strong[\(c)]

Define $F : upright(S e t) arrow.r upright(G r o u p)$ by sending set $S$ to the free group $F\(S\)$ generated by $S$, sending map $sigma : S arrow.r T$ to $F\(sigma\): F\(S\)arrow.r F\(T\)$ by sending the corresponding generators, $F\(upright(i d)_S\)= upright(i d)_(F\(S\))\,F\(mu sigma\)= F\(mu\)F\(sigma\)$, thus $F$ is a functor

#strong[\(d)]

If $F : bb(P)\({ 0\,1 }\)arrow.r upright(T o p)$ is a functor, denote $F\(diameter\)= A\,F\({ 0 }\)= X\,F\({ 1 }\)= Y\,F\({ 0\,1 }\)= Z$ and $F\(diameter arrow.r { 0 }\)= f\,F\(diameter arrow.r { 1 }\)= g\,F\({ 0 } arrow.r { 0\,1 }\)= alpha\,F\({ 1 } arrow.r { 0\,1 }\)= beta$,$F\(diameter arrow.r { 0\,1 }\)= alpha dot.op f = beta dot.op g$, then the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A$]),
node((2,0),[$X$]),
node((1,1),[$Y$]),
node((2,1),[$Z$]),
edge((1,0),(2,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$g$]),
edge((2,0),(2,1),"->",[$alpha$]),
edge((1,1),(2,1),"->",[$beta$]))]
]
This induce a pushout

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A$]),
node((2,0),[$X$]),
node((1,1),[$Y$]),
node((2,1),[$X inter_A Y$]),
node((3,2),[$Z$]),
edge((1,0),(2,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$g$]),
edge((2,0),(2,1),"->",[$iota_X$]),
edge((2,0),(3,2),"->",[$alpha$],bend:15deg),
edge((1,1),(2,1),"->",[$iota_Y$]),
edge((1,1),(3,2),"->",[$beta$],bend:-15deg),
edge((2,1),(3,2),"->",[$h$]))]
]
#strong[\3.]

#strong[\(a)]

Define composition as $\(f'\,g'\)compose\(f\,g\)=\(f' compose f\,g' compose g\)$ then it is associative

#math.equation(block: true, numbering: none, $ & \(f''\,g''\)compose\[\(f'\,g'\)compose\(f\,g\)\]=\(f''\,g''\)compose\(f' compose f\,g' compose g\)=\(f'' compose\(f' compose f\)\,g' compose\(g' compose g\)\)\
 & =\(\(f'' compose f'\)compose f\,\(g' compose'\)compose g\)=\(f'' compose f'\,g'' compose g\)compose\(f\,g\)=\[\(f''\,g''\)compose\(f'\,g'\)\]compose\(f\,g\)$) For any object $\(C\,D\)$ in $cal(C) times cal(D)$, we have identity $\(1_C\,1_D\):\(C\,D\)arrow.r\(C\,D\)$, then $forall\(f\,g\):\(C\,D\)arrow.r\(C'\,D'\)$, $\(f'\,g'\):\(C'\,D'\)arrow.r\(C\,D\)$, we have #math.equation(block: true, numbering: none, $\(f\,g\)compose\(1_c\,1_D\)=\(f compose 1_C\,g compose 1_D\)=\(f\,g\)\,\(1_C\,1_D\)compose\(f'\,g'\)=\(1_C compose f'\,1_D compose g'\)=\(f'\,g'\)$) Therefore, $cal(C) times cal(D)$ is indeed a category

#strong[\(b)]

The group operation $F : G times G arrow.r G\,F\(g_1\,g_2\)= g_1 g_2$ won't be a functor, if so, then $g_1 g_2 g'_1 g'_2 = F\(g_1 g_2\)F\(g'_1 g'_2\)= F\[\(g_1\,g_2\)\(g'_1\,g'_2\)\]= F\(g_1 g'_1\,g_2 g'_2\)= g_1 g'_1 g_2 g'_2 arrow.r.double g_2 g'_1 = g'_1 g_2$ so that $g'_1$ and $g_2$ are commutative which is not true in general

#strong[\4.]

~$h$ induces $\[h\(x\,dot.op\)\]=\[h_x\]: h_0\(x\)arrow.r h_1\(x\)$, such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$h_0\(x\)$]),
node((2,0),[$h_1\(x\)$]),
node((1,1),[$h_0\(x'\)$]),
node((2,1),[$h_1\(x'\)$]),
edge((1,0),(2,0),"->",[$\[h_x\]$]),
edge((1,0),(1,1),"->",[$\[h_0 compose gamma\]$]),
edge((2,0),(2,1),"->",[$\[h_1 compose gamma\]$]),
edge((1,1),(2,1),"->",[$\[h_(x')\]$]))]
]
Where $\[gamma\]in pi_1\(X\,x\,x'\)$, thus $h$ induces a natural transformation between the induced functors $\(h_0\)_(*)$ and $\(h_1\)_(*)$ #strong[\5.]

#strong[\(a)]

Reflexivity: $h_n = 0$ is a chain homotopy between $f$ and $f$ since $h_(n - 1) partial_n^C + partial_(n + 1)^D h_n = 0 = f_n - f_n$

Symmetry: If $h_n$ is a homotopy between $f$ and $g$, then $- h_n$ is a chain homotopy between $g$ and $f$ since $- h_(n - 1) partial_n^C - partial_(n + 1)^D h_n = 0 = -\(g_n - f_n\)= f_n - g_n$

Transitivity: If $alpha_n$ is a chain homotopy between $f$ and $g$, $beta_n$ is a chain homotopy between $g$ and $h$, then #math.equation(block: true, numbering: none, $h_n - f_n & =\(h_n - g_n\)+\(g_n - f_n\)\
 & =\(beta_(n - 1) partial_n^C + partial_(n + 1)^D beta_n\)+\(alpha_(n - 1) partial_n^C + partial_(n + 1)^D alpha_n\)\
 & =\(beta_(n - 1) + alpha_(n - 1)\)partial_n^C + partial_(n + 1)^D\(beta_n + alpha_n\)$) Thus $beta_n + alpha_n$ is a chain homotopy between $f$ and $h$

#strong[\(b)]

#math.equation(block: true, numbering: none, $partial^2 vec(c_0, c_1, c_2) & = partial vec(partial\(c_0\)+\(- 1\)^n c_2, partial\(c_1\)+\(- 1\)^(n + 1) c_2, partial\(c_2\))\
 & = vec(partial (partial \( c_0 \) + \( - 1 \)^n c_2) +\(- 1\)^(n - 1) partial\(c_2\), partial (partial \( c_1 \) + \( - 1 \)^(n + 1) c_2) +\(- 1\)^n partial\(c_2\), partial^2\(c_2\))\
 & = vec(partial^2\(c_0\)+\(- 1\)^n partial\(c_2\)+\(- 1\)^(n - 1) partial\(c_2\), partial^2\(c_1\)+\(- 1\)^(n + 1) partial\(c_2\)+\(- 1\)^n partial\(c_2\), partial^2\(c_2\))\
 & = vec(0, 0, 0)$) #strong[\(c)]

Define $iota_0\(c\)= vec(c, 0, 0)\,iota_1\(c\)= vec(0, c, 0)$, then #math.equation(block: true, numbering: none, $partial iota_0\(c\)= partial vec(c, 0, 0) = vec(partial\(c\), 0, 0) = iota_0 partial\(c\)$) #math.equation(block: true, numbering: none, $partial iota_1\(c\)= partial vec(0, c, 0) = vec(0, partial\(c\), 0) = iota_1 partial\(c\)$) #strong[\(d)]

Define $xi_n : C_n arrow.r\(C_(*) times.o D_(*)\)_(n + 1)$ by $xi_n\(c\)= vec(0, 0, \(- 1\)^n c)$, then #math.equation(block: true, numbering: none, $\(partial xi_n + xi_(n - 1) partial\)\(c\) & = partial vec(0, 0, \(- 1\)^n c) + vec(0, 0, \(- 1\)^(n - 1) partial\(c\))\
 & = partial vec(\(- 1\)^(n + 1)\(- 1\)^n c, \(- 1\)^(n + 2)\(- 1\)^n c, \(- 1\)^n partial\(c\)) + vec(0, 0, \(- 1\)^(n - 1) partial\(c\))\
 & = vec(- c, c, 0)$) Thus #math.equation(block: true, numbering: none, $(partial \( h xi_n \) + \( h xi_(n - 1) \) partial)\(c\) & = h\(partial xi_n + xi_(n - 1) partial\)\(c\)\
 & = h vec(- c, c, 0) = h vec(0, c, 0) - h vec(c, 0, 0)\
 & = h compose iota_1\(c\)- h compose iota_0\(c\)$) Thus $h xi$ is the corresponding chain homotopy between $h compose iota_0$ and $h compose iota_1$

#pagebreak(weak:true)
== Homework10
<homework10>
#strong[Hatcher 2.1.11.]

Suppose $r : X arrow.r A$ is a retraction, $i : A arrow.r X$ is the inclusion, then $r compose i = upright(i d)_A$, $i_(*)\[sum n_alpha sigma_alpha^n\]=\[sum n_alpha i compose sigma_alpha^n\]$, if $\[sum n_alpha i compose sigma_alpha^n\]= 0$, $sum n_alpha i compose sigma_alpha^n = partial (sum n_beta tau_beta^(n + 1))$ where $tau_beta^(n + 1) : Delta^(n + 1) arrow.r X$ ~par Then we have $sum n_alpha sigma_alpha^n = r (sum n_alpha i compose sigma_alpha^n) = r (partial (sum n_beta tau_beta^(n + 1))) = partial (sum n_beta r compose tau_beta^(n + 1))$, $r compose tau_beta^(n + 1) : Delta^(n + 1) arrow.r A$

Hence $\[sum n_alpha sigma_alpha^n\]= 0$, $i_(*)$ is injective

#strong[Hatcher 2.1.30.]

If $alpha : A arrow.r B$ is an isomorphism, so is $alpha^(- 1) : B arrow.r A$, then we can write the remaining map as a composition of the others, so it is also an isomorphism

#strong[\1.]

Suppose $h_n$ is a chain homotopy between $f_n$ and $g_n$, then $g_n - f_n = partial_(n + 1)^D h_n + h_(n - 1) partial_n^C$

$forall\[f_n\(c\)\]in H_n\(f\)$, where $c in ker partial_n^C$, $g_n\(c\)= f_n\(c\)+ partial_(n + 1)^D h_n\(c\)+ h_(n - 1) partial_n^C\(c\)= f_n\(c\)+ partial_(n + 1)^D h_n\(c\)$, since $partial_(n + 1)^D h_n\(c\)in partial_(n + 1)^D\(D_(n + 1)\)$, $\[f_n\(c\)\]=\[g_n\(c\)\]in H_n\(g\)$, $H_n\(f\)subset.eq H_n\(g\)$, similarly, $H_n\(g\)subset.eq H_n\(f\)$, thus $H_n\(f\)= H_n\(g\)$

#strong[\2.]

$\(a\)arrow.r.double\(b\):$ Since the sequence is split exact, the following diagram commutes

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((3,0),[$B$]),
node((1,1),[$0$]),
node((2,1),[$A$]),
node((4,1),[$C$]),
node((5,1),[$0$]),
node((3,2),[$A xor C$]),
edge((3,0),(3,2),"->",[$phi$]),
edge((3,0),(4,1),"->",[$p$]),
edge((1,1),(2,1),"->"),
edge((2,1),(3,0),"->",[$i$]),
edge((2,1),(3,2),"->",[$iota_A$]),
edge((4,1),(5,1),"->"),
edge((3,2),(4,1),"->",[$pi$]))]
]
Where $pi$ is the projection, $iota_A$ is the inclusion

Define $s = phi^(- 1) iota_C$, where $iota_C : C arrow.r A xor C$ is the inclusion, then $p compose s = p compose phi^(- 1) compose iota_C = pi compose phi^(- 1) compose phi compose iota_C = pi compose iota_C = upright(i d)_C$

$\(b\)arrow.r.double\(c\):$ $forall b in B$, let $b_1 = b - s compose p\(c\)$, then $p\(b_1\)= p\(b\)- p compose s compose p\(b\)= p\(b\)- p\(b\)= 0$, $arrow.r.double b in ker p = upright(i m) i$, since $i$ is injective, $exists_1 a in A$, such that $i\(a\)= b$, define $a := r\(b\)$, then we have $r compose i\(a\)= a\,forall a in A$, hence $r compose i = upright(i d)_A$

$\(c\)arrow.r.double\(a\):$ $forall b in B$, define $phi : B arrow.r A xor C\,b mapsto\(r\(b\)\,p\(b\)\)$, $forall a in A\,a = r compose i\(a\)in r\(B\)$, also $C = p\(B\)$, thus $A xor C subset.eq phi\(B\)$, $phi$ is surjective

On the other hand, if $phi\(b\)= 0$, then $r\(b\)= p\(b\)= 0$, $exists a in A$ such that $i\(a\)= b$, but then $a = r compose i\(a\)= r\(b\)= 0 arrow.r.double b = i\(a\)= 0$, hence $phi$ is also injective, $phi$ is an isomorphism

$forall b in B\,pi compose phi\(b\)= pi\(r\(b\)\,p\(b\)\)= p\(b\)$, $forall a in A\,phi compose i\(a\)=\(r compose i\(a\)\,p compose i\(a\)\)=\(a\,0\)= iota_A\(a\)$, thus the diagram above commutes

#strong[\3.]

If $C = 0$, then $A arrow.r B$ is obviously surjective and $D arrow.r E$ is obviously injective

Conversely, since $A arrow.r^alpha B arrow.r^beta C arrow.r^gamma D arrow.r^xi E$ is exact, if $alpha$ is surjective, $xi$ is injective, $forall c in C$, we have #math.equation(block: true, numbering: none, $xi compose gamma\(c\)= 0 & arrow.r.double gamma\(c\)= 0\
 & arrow.r.double exists b in B\,upright("such that ") beta\(b\)= c\
 & arrow.r.double exists a in A\,upright("such that ") alpha\(a\)= b\
 & arrow.r.double c = beta compose alpha\(a\)= 0$) Hence $C = 0$

#strong[\4.]

Define $epsilon : C_0\(X\)arrow.r bb(Z)$ by sending $sum n_alpha sigma_alpha^0$ to $sum n_alpha$

$forall sigma : Delta^1 arrow.r X$, $epsilon\(partial sigma\)= epsilon (sigma \| \[ v_1 \] - sigma \| \[ v_0 \]) = 1 - 1 = 0$, thus $epsilon compose partial = 0$

Also, $forall sum n_alpha sigma_alpha^0 in C_0\(X\)$, if $epsilon\(sum n_alpha sigma_alpha^0\)= sum n_alpha = 0$, then there are same number of $sigma_alpha^0$'s with coefficients $1$ and coefficients $- 1$, and for each pair, there is a path$: Delta^1 arrow.r X$ from the one with coefficient $- 1$ to the one with coefficient $1$, then the sum of these paths $xi in C_1\(X\)$, and $partial xi = sum n_alpha sigma_alpha^0$, hence $C_1\(X\)arrow.r^partial C_0 X arrow.r^epsilon bb(Z) arrow.r 0$ is exact, $H_0\(X\)= C_0\(X\)\/upright(i m) partial = C_0\(X\)\/ker epsilon tilde.equiv bb(Z)$

#pagebreak(weak:true)
== Homework11
<homework11>
#strong[Hatcher 2.1.20.]

Let $q : X times I arrow.r S X tilde.equiv X times I\/X times { 0 } union X times { 1 }$ is the quotient map, define $U = q (X times \[ 0 \, 2 / 3 \))$, $V = q (X times \( 1 / 3 \, 0 \])$ are both contractible, and $U inter V = q (X times \( 1 / 3 \, 2 / 3 \)) tilde.equiv X$

Apply Mayer-Vietoris theorem we have #math.equation(block: true, numbering: none, $H_(n + 1)\(U\)xor H_(n + 1)\(V\)arrow.r H_(n + 1)\(S X\)arrow.r H_n\(U inter V\)arrow.r H_n\(U\)xor H_n\(V\)quad\(n gt.eq 1\)$) is exact, thus #math.equation(block: true, numbering: none, $0 arrow.r H_(n + 1)\(S X\)arrow.r H_n\(X\)arrow.r 0 quad\(n gt.eq 1\)$) is exact, hence $H^tilde.op_(n + 1)\(S X\)tilde.equiv H^tilde.op_n\(X\)quad\(n gt.eq 1\)$

Also #math.equation(block: true, numbering: none, $H_1\(U\)xor H_1\(V\)arrow.r H_1\(S X\)arrow.r H_0\(U inter V\)arrow.r H_0\(U\)xor H_0\(V\)arrow.r H_0\(S X\)arrow.r 0$) is exact and $S X$ is path connected, thus

#math.equation(block: true, numbering: none, $0 arrow.r H_1\(S X\)arrow.r H_0\(X\)arrow.r bb(Z) xor bb(Z) arrow.r bb(Z) arrow.r 0$) is exact

Since $bb(Z) xor bb(Z) arrow.r bb(Z)$ is surjective and $bb(Z) xor bb(Z)$ is free, $upright(I m) (H_0 \( X \) arrow.r bb(Z) xor bb(Z)) = upright(K e r) (bb(Z) xor bb(Z) arrow.r bb(Z)) tilde.equiv bb(Z)$, thus

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$H_1\(S X\)$]),
node((2,0),[$H_0\(X\)$]),
node((3,0),[$bb(Z)$]),
node((4,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$alpha$]),
edge((2,0),(3,0),"->",[$beta$],shift:2pt),
edge((3,0),(4,0),"->"),
edge((3,0),(2,0),"->",[$gamma$],shift:2pt))]
]
is exact, since $bb(Z)$ is free, $exists gamma : bb(Z) arrow.r H_0\(X\)$ such that $beta compose gamma = upright(i d)_(bb(Z))$, hence by splitting lemma, $H_0\(X\)tilde.equiv H^tilde.op_0\(X\)xor bb(Z)$, on the other hand, $H_0\(X\)tilde.equiv H^tilde.op_0 xor bb(Z)$ , thus $H^tilde.op_1\(S X\)tilde.equiv H^tilde.op_0\(X\)$, $H^tilde.op_0\(S X\)= 0 = H^tilde.op_(- 1)\(X\)$ and $H^tilde.op_(n + 1)\(S X\)tilde.equiv H^tilde.op_n\(X\)quad\(n < - 1\)$ is trivial

More generally, let $q : X times I arrow.r C X tilde.equiv X times I\/X times { 1 }$ be the quotient map, $Y = union.sq.big_(i = 1)^m C X #scale(x: 180%, y: 180%)[$\/$] tilde.op$ with their bases identified, define $U = union.sq.big_(i = 1)^(m - 1) q (X times \[ 0 \, 1 \)) #scale(x: 180%, y: 180%)[$\/$] tilde.op tilde.eq { * }$, $V = C X union.sq.big union.sq.big_(i = 1)^(m - 1) q (X times \( 1 / 2 \, 1 \]) #scale(x: 180%, y: 180%)[$\/$] tilde.op tilde.eq union.sq.big_(i = 1)^(m - 1) { * }$

Apply Mayer-Vietoris theorem we have #math.equation(block: true, numbering: none, $H_(n + 1)\(U\)xor H_(n + 1)\(V\)arrow.r H_(n + 1)\(Y\)arrow.r H_n\(U inter V\)arrow.r H_n\(U\)xor H_n\(V\)quad\(n gt.eq 1\)$) is exact, thus #math.equation(block: true, numbering: none, $0 arrow.r H_(n + 1)\(Y\)arrow.r xor.big_(i = 1)^(m - 1) H_n\(X\)arrow.r 0 quad\(n gt.eq 1\)$) is exact, hence $H_(n + 1)\(Y\)tilde.equiv xor.big_(i = 1)^(m - 1) H_n\(X\)quad\(n gt.eq 1\)$

Also #math.equation(block: true, numbering: none, $H_1\(U\)xor H_1\(V\)arrow.r H_1\(Y\)arrow.r H_0\(U inter V\)arrow.r H_0\(U\)xor H_0\(V\)arrow.r H_0\(Y\)arrow.r 0$) is exact and $Y$ is path connected, thus #math.equation(block: true, numbering: none, $0 arrow.r H_1\(Y\)arrow.r xor.big_(i = 1)^(m - 1) H_0\(X\)arrow.r bb(Z)^(m - 1) xor bb(Z) = bb(Z)^m arrow.r bb(Z) arrow.r 0$) is exact, since $bb(Z)^m$ is free #math.equation(block: true, numbering: none, $0 arrow.r H_1\(Y\)arrow.r xor.big_(i = 1)^(m - 1) H_0\(X\)arrow.r bb(Z)^(m - 1) arrow.r 0$) is exact

Since $bb(Z)^(m - 1)$ is free, by splitting lemma, $xor.big_(i = 1)^(m - 1) H_0\(X\)tilde.equiv H_0\(Y\)xor bb(Z)^(m - 1)$, on the other hand, $xor.big_(i = 1)^(m - 1) H_0\(X\)tilde.equiv xor.big_(i = 1)^(m - 1) (H^tilde.op_0 \( X \) xor bb(Z)) tilde.equiv (xor.big_(i = 1)^(m - 1) H^tilde.op_0 \( X \)) xor.big bb(Z)^(m - 1)$, thus $H^tilde.op_1\(Y\)tilde.equiv xor.big_(i = 1)^(m - 1) H^tilde.op_0\(X\)$

$H^tilde.op_0\(Y\)= 0 = xor.big_(i = 1)^(m - 1) H^tilde.op_(- 1)\(X\)$, and $H^tilde.op_(n + 1)\(Y\)tilde.equiv xor.big_(i = 1)^(m - 1) H^tilde.op_n\(X\)quad\(n < - 1\)$ is trivial

#strong[Hatcher 2.1.21.]

Let $q : X times I arrow.r S X$ still be the quotient map, define $U = q (X times \[ 0 \, 2 / 3 \))$, $V = q (X times \( 1 / 3 \, 0 \])$, $v = q (X times { 0 })$, $v = q (X times { 1 })$, then define #math.equation(block: true, numbering: none, $s\(sigma\)=\[v_0\,dots.h.c\,v_n\,v\]-\[v_0\,dots.h.c\,v_n\,w\]$) Where $sigma =\[v_0\,dots.h.c\,v_n\]$, and $\[v_i\,v\]$ be the segment from $v_i$ to $v$ along $v_i times [0 \, 1 / 2]$, $\[v_i\,w\]$ be the segment from $v_i$ to $w$ along $v_i times [1 / 2 \, 1]$

#math.equation(block: true, numbering: none, $partial s\[v_0\,dots.h.c\,v_(n + 1)\] & = partial (\[ v_0 \, dots.h.c \, v \] - \[ v_0 \, dots.h.c \, w \])\
 & = sum_(k = 0)^(n + 1)\(- 1\)^k (\[ v_0 \, dots.h.c \, hat(v)_k \, dots.h.c \, v \] - \[ v_0 \, dots.h.c \, hat(v)_k \, dots.h.c \, w \])$) #math.equation(block: true, numbering: none, $s partial\[v_0\,dots.h.c\,v_(n + 1)\] & = s (sum_(k = 0)^(n + 1) \( - 1 \)^k \[ v_0 \, dots.h.c \, hat(v)_k dots.h.c \, v_(n + 1) \])\
 & = sum_(k = 0)^(n + 1)\(- 1\)^k (\[ v_0 \, dots.h.c \, hat(v)_k \, dots.h.c \, v \] - \[ v_0 \, dots.h.c \, hat(v)_k \, dots.h.c \, w \])$) Thus $partial s = s partial$, hence $s$ is a chain map which could induce a homomorphism from $tilde(H)_n\(X\)$ to $tilde(H)_(n + 1)\(S X\)$

Suppose $sum n_i sigma_i in Z_n\(X\)$, namely

#math.equation(block: true, numbering: none, $0 = partial (sum n_i sigma_i) = partial (sum n_i \[ v_0^i \, dots.h.c \, v_n^i \]) = sum n_i sum_(k = 0)^n\(- 1\)^k\[v_0^i\,dots.h.c\,hat(v)_k^i\,dots.h.c\,v_n^i\]$) Then

#math.equation(block: true, numbering: none, $s (sum n_i sigma_i) = sum n_i (\[ v_0^i \, dots.h.c \, v \] - \[ v_0^i \, dots.h.c \, w \]) = (sum n_i \[ v_0^i \, dots.h.c \, v \] - sum n_i \[ v_0^i \, dots.h.c \, w \])$) But $\(j_U - j_V\)(sum n_i \[ v_0^i \, dots.h.c \, v \]) xor.big (sum n_i \[ v_0^i \, dots.h.c \, v \]) = s (sum n_i sigma_i)$, also

#math.equation(block: true, numbering: none, $\(i_U xor i_V\)(\( - 1 \)^(n + 1) sum n_i sigma_i) & = (\( - 1 \)^(n + 1) sum n_i sigma_i) xor.big (\( - 1 \)^(n + 1) sum n_i sigma_i)\
 & = partial (sum n_i sum_(k = 0)^n \( - 1 \)^k \[ v_0^i \, dots.h.c \, hat(v)_k^i \, dots.h.c \, v \] + sum n_i \[ v_0^i \, dots.h.c \, v \]) xor.big\
 & thin quad partial (sum n_i sum_(k = 0)^n \( - 1 \)^k \[ v_0^i \, dots.h.c \, hat(v)_k^i \, dots.h.c \, w \] + sum n_i \[ v_0^i \, dots.h.c \, w \])\
 & = partial (sum n_i \[ v_0^i \, dots.h.c \, v \]) xor.big partial (sum n_i \[ v_0^i \, dots.h.c \, w \])$) Therefore $delta s =\(- 1\)^(n + 1) upright(i d)$, since $delta$ is an isomorphism, $s$ also induce an isomorphism

#strong[\1.]

Let $U$ be a small neighborhood of the left $S^1$, $V$ be a small neighborhood of the right $S^1$, $U\,V tilde.eq S^1$, $U inter V tilde.eq { * }$

Apply Mayer-Vietoris theorem, we have

#math.equation(block: true, numbering: none, $H_(n + 1)\(U\)xor H_(n + 1)\(V\)arrow.r H_(n + 1)\(S^1 or S^1\)arrow.r H_n\(U inter V\)quad\(n gt.eq 1\)$) is exact, thus $0 arrow.r H_(n + 1)\(S^1 or S^1\)arrow.r 0 quad\(n gt.eq 1\)$ is exact, hence $H_k\(S^1 or S^1\)= 0 quad\(k gt.eq 2\)$ Since $S^1 or S^1$ is path connected, $H_0\(S^1 or S^1\)= bb(Z)$ and #math.equation(block: true, numbering: none, $H_1\(U inter V\)arrow.r H_1\(U\)xor H_1\(V\)arrow.r H_1\(S^1 or S^1\)arrow.r H_0\(U inter V\)arrow.r H_0\(U\)xor H_0\(V\)arrow.r H_0\(S^1 or S^1\)arrow.r 0$) is exact, thus #math.equation(block: true, numbering: none, $0 arrow.r bb(Z) xor bb(Z) arrow.r H_1\(S^1 or S^1\)arrow.r bb(Z) arrow.r bb(Z) xor bb(Z) arrow.r bb(Z) arrow.r 0$) hence $0 arrow.r bb(Z) xor bb(Z) arrow.r H_1\(S^1 or S^1\)arrow.r 0$ is exact, $H_1\(S^1 or S^1\)tilde.equiv bb(Z) xor bb(Z)$

#strong[\2.]

Let $U$ be a small neighborhood of $A$, $V$ be the interior of the $n$-cell $Delta^n$, then $V$ is contractible, $U tilde.eq A$, $U inter V tilde.eq S^(n - 1)$

Apply Mayer-Vietoris theorem, we have

~#math.equation(block: true, numbering: none, $H_n\(U inter V\)arrow.r H_n\(U\)xor H_n\(V\)arrow.r H_n\(X\)arrow.r H_(n - 1)\(U inter V\)arrow.r H_(n - 1)\(U\)xor H_(n - 1)\(V\)arrow.r H_(n - 1)\(X\)arrow.r H_(n - 2)\(U inter V\)$) is exact, thus #math.equation(block: true, numbering: none, $H_n\(S^(n - 1)\)arrow.r H_n\(A\)xor H_n\(*\)arrow.r H_n\(X\)arrow.r H_(n - 1)\(S^(n - 1)\)arrow.r H_(n - 1)\(A\)xor H_(n - 1)\(*\)arrow.r H_(n - 1)\(X\)arrow.r H_(n - 2)\(S^(n - 1)\)$) is exact

#strong[\(a)]

If $n > 2$ #math.equation(block: true, numbering: none, $0 arrow.r H_n\(A\)arrow.r H_n\(X\)arrow.r bb(Z) arrow.r H_(n - 1)\(A\)arrow.r H_(n - 1)\(X\)arrow.r 0$) is exact

#strong[\(b)]

If $k gt.eq 1\,k eq.not n\,n - 1$, then $0 arrow.r H_k\(A\)arrow.r H_k\(X\)arrow.r 0$ is exact, thus $H_k\(A\)tilde.equiv H_k\(X\)$

#strong[\3.]

If $f$ is not surjective, without loss of generality, assume $upright(I m) f subset S^n\\{ N }$, where $N$ is the north pole, then $f tilde.eq c$, $H_n f = H_n c = 0$ which is a contradiction, hence $f$ is surjective

#pagebreak(weak:true)
== Homework12
<homework12>
#strong[Hatcher 2.1.17.]

#strong[\(a)]

Assume $A = { a_1\,dots.h.c\,a_n }$, $forall\[xi_0\]in C_0\(S^2\,A\)$, $xi_0 = sum n_k v_0^k$ is a sum of points on $S^2\\A$, then we can find paths from $a_1$ to $v_0^k$ contained in $S^2\\A$, then define $xi_1 = sum n_k\[a_1\,v_0^k\]in C_1\(S^2\)$, $partial\[xi_1\]=\[xi_0\]$, hence $partial C_1\(S^2\,A\)= C_0\(S^2\,A\)$, $H_0\(S^2\,A\)= 0$, similarly we have $H_0\(S^1 or S^1\,A\)= 0$

#math.equation(block: true, numbering: none, $H_1\(S^2\)arrow.r H_1\(S^2\,A\)arrow.r H_0\(A\)arrow.r H_0\(S^2\)arrow.r H_0\(S^2\,A\)$) #math.equation(block: true, numbering: none, $H_1\(A\)arrow.r H_1\(S^1 or S^1\)arrow.r H_1\(S^1 or S^1\,A\)arrow.r H_0\(A\)arrow.r H_0\(S^1 or S^1\)arrow.r H_0\(S^1 or S^1\,A\)$) are exact, thus #math.equation(block: true, numbering: none, $0 arrow.r H_1\(S^2\,A\)arrow.r bb(Z)^n arrow.r bb(Z) arrow.r 0$) #math.equation(block: true, numbering: none, $0 arrow.r bb(Z)^2 arrow.r H_1\(S^1 or S^1\,A\)arrow.r bb(Z)^n arrow.r bb(Z) arrow.r 0$) are exact, hence $H_1\(S^2\,A\)tilde.equiv bb(Z)^(n - 1)$, $H_1\(S^1 or S^1\,A\)tilde.equiv bb(Z)^(n + 1)$ #math.equation(block: true, numbering: none, $0 = H_2\(A\)arrow.r H_2\(S^2\)arrow.r H_2\(S^2\,A\)arrow.r H_1\(A\)= 0$) #math.equation(block: true, numbering: none, $0 = H_2\(A\)arrow.r H_2\(S^1 or S^1\)arrow.r H_2\(S^1 or S^1\,A\)arrow.r H_1\(A\)= 0$) are exact, hence $H_2\(S^2\,A\)tilde.equiv H_2\(S^2\)tilde.equiv bb(Z)$, $H_2\(S^1 or S^1\,A\)tilde.equiv H_2\(S^1 or S^1\)tilde.equiv bb(Z)$ #math.equation(block: true, numbering: none, $0 = H_k\(S^2\)arrow.r H_k\(S^2\,A\)arrow.r H_(k - 1)\(A\)= 0$) #math.equation(block: true, numbering: none, $0 = H_k\(S^1 or S^1\)arrow.r H_k\(S^1 or S^1\,A\)arrow.r H_(k - 1)\(A\)= 0$) are exact, hence $H_k\(S^2\,A\)= 0$, $H_k\(S^1 or S^1\,A\)= 0$, where $k gt.eq 3$

#strong[\(b)]

Both $\(X\,A\)$ and $\(X\,B\)$ are good pairs, it is easy to give $X\/A$ and $X\/B$ CW complex structures, $X\/A$ consists of one $0$-cell, four $1$-cells and two $2$-cells, $X\/B$ consists of two $0$-cells, five $1$-cells and two $2$-cells, then we can use cellular homology to get singular homology, the exact sequence for cellular homology are the following

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)^2$]),
node((2,0),[$bb(Z)^4$]),
node((3,0),[$bb(Z)$]),
node((4,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$0$]),
edge((2,0),(3,0),"->",[$0$]),
edge((3,0),(4,0),"->"))]
]
#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)^2$]),
node((2,0),[$bb(Z)^5$]),
node((5,0),[$bb(Z)^2$]),
node((6,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$mat(delim: "(", 0, 0; 0, 0; 0, 0; 0, 0; 1, 1)$]),
edge((2,0),(5,0),"->",[$mat(delim: "(", 0, 0, 1, - 1, 0; 0, 0, - 1, 1, 0)$]),
edge((5,0),(6,0),"->"))]
]
Which give us $H_n\(X\,A\)tilde.equiv tilde(H)_n\(X\/A\)= cases(bb(Z)^4\,thin n = 1, bb(Z)\,thin thin thin n = 2, 0\,thin thin thin thin upright("else"))$ and $H_n\(X\,B\)tilde.equiv tilde(H)_n\(X\/B\)= cases(bb(Z)^3\,thin n = 1, bb(Z)\,thin thin thin n = 2, 0\,thin thin thin thin upright("else"))$

#strong[Hatcher 2.1.22.]

#strong[\(a)]

$H_i\(X\)= H_i\(X^n\)= 0\,forall i > n$

$0 = H_n\(X^(n - 1)\)arrow.r H_n\(X^n\)arrow.r H_n\(X^n\,X^(n - 1)\)$ is exact and $H_n\(X^n\,X^(n - 1)\)$ is free, so is $H_n\(X^n\)$

#strong[\(b)]

$X^(n - 1) = X^(n - 2)$, thus $0 = H_n\(X^(n - 1)\)arrow.r H_n\(X^n\)arrow.r H_n\(X^n\,X^(n - 1)\)arrow.r H_(n - 1)\(X^(n - 1)\)= H_(n - 1)\(X^(n - 2)\)= 0$ is exact implies $H_n\(X^n\)tilde.equiv H_n\(X^n\,X^(n - 1)\)tilde.equiv xor.big bb(Z) { e^n }$

#strong[\(c)]

Similarly as in (a), $H_(n - 1)\(X^(n - 1)\)$ is also free, Then exact sequence $H_n\(X^(n - 1)\)arrow.r H_n\(X^n\)arrow.r H_n\(X^n\,X^(n - 1)\)arrow.r H_(n - 1)\(X^(n - 1)\)$ implies $0 arrow.r H_n\(X^n\)arrow.r bb(Z)^k arrow.r bb(Z)^m arrow.r 0$ is exact for some $m lt.eq k$, hence $H_n\(X^n\)tilde.equiv bb(Z)^(k - m)$

#strong[Hatcher 2.1.27.]

#strong[\(a)]

$exists g : Y arrow.r X$, $h : B arrow.r A$ such that $f g tilde.eq bb(1) tilde.eq g f$, $f h tilde.eq bb(1) tilde.eq h f$, then we have $f_(*) : H_n\(X\)arrow.r H_n\(Y\)$, $f_(*) : H_n\(A\)arrow.r H_n\(B\)$ are isomorphisms, hence $f_(*)$ is an isomorphism by five lemma

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H_n\(A\)$]),
node((1,0),[$H_n\(X\)$]),
node((2,0),[$H_n\(X\,A\)$]),
node((3,0),[$H_(n - 1)\(A\)$]),
node((4,0),[$H_(n - 1)\(X\)$]),
node((0,1),[$H_n\(B\)$]),
node((1,1),[$H_n\(Y\)$]),
node((2,1),[$H_n\(Y\,B\)$]),
node((3,1),[$H_(n - 1)\(B\)$]),
node((4,1),[$H_(n - 1)\(Y\)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->",[$f_(*)$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->",[$f_(*)$]),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$f_(*)$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->",[$f_(*)$]),
edge((4,0),(4,1),"->",[$f_(*)$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
#strong[\(b)]

Suppose $g :\(Y\,B\)arrow.r\(X\,A\)$ such that $f g tilde.eq^phi bb(1)_Y$, $g f tilde.eq^psi bb(1)_X$, $f\|_A g\|_B tilde.eq^(phi\|_(B times I)) bb(1)_B$, $g\|_A f\|_B tilde.eq^(psi\|_(A times I)) bb(1)_A$

Thus we have $f\|_(macron(A)) : macron(A) arrow.r macron(B)$, $g\|_(macron(B)) : macron(B) arrow.r macron(A)$, $phi\|_(macron(B) times I) : macron(B) times I arrow.r macron(B)$, $psi\|_(macron(A) times I) : macron(A) times I arrow.r macron(A)$ such that $f\|_(macron(A)) g\|_(macron(B)) tilde.eq^(phi\|_(macron(B) times I)) bb(1)_(macron(B))$, $g\|_(macron(A)) f\|_(macron(B)) tilde.eq^(psi\|_(macron(A) times I)) bb(1)_(macron(A))$

Hence $f_(*) : H_n\(X\,macron(A)\)arrow.r H_n\(Y\,macron(B)\)$ is also an isomorphism, in this case it is impossible since $H_n\(X\,macron(A)\)= H_n\(D^n\,S^(\[) n - 1\]\)tilde.equiv tilde(H)_n\(D^n\/S^(n - 1)\)tilde.equiv tilde(H)_n\(S^n\)= bb(Z)^n$, but $H_n\(X\,macron(B)\)= H_n\(D^n\,D^n\)= tilde(H)_n\(D^n\/D^n\)= 0$ which is a contradiction

#strong[Hatcher 2.1.29.]

$S^1 or S^1 or S^2$ has a CW complex structure, one $0$-cell, two $1$-cells, 1 $2$-cell, then we get an exact sequence #math.equation(block: true, numbering: none, $H_3\(X^3\,X^2\)arrow.r H_2\(X^2\,X^1\)arrow.r H_1\(X^1\,X^0\)arrow.r H_0\(X^0\)arrow.r 0$) Which gives

#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)$]),
node((2,0),[$bb(Z)^2$]),
node((3,0),[$bb(Z)$]),
node((4,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$0$]),
edge((2,0),(3,0),"->",[$0$]),
edge((3,0),(4,0),"->"))]
On the other hand, $bb(R)^2$ is a universal cover of $S^1 times S^1$, and attach to each vertex of the caylay graph which is a universal cover of $S^1 or S^1$ a $S^2$, call this $Gamma$, then $Gamma$ is a universal cover of $S^1 or S^1 or S^2$, but $H_2\(bb(R)^2\)= 0 eq.not H_2\(Gamma\)$

#strong[\2.]

#strong[\(a)]

Simply use Hatcher 2.1.27, we know that $j$ induces an isomorphism

#strong[\(b)]

Let $r : V arrow.r A$ be the retraction and $i : A arrow.r V$ be inclusion, then $exists h : V times I arrow.r V$ such that $r i = bb(1)_A$, $i r tilde.eq^h bb(1)_V$, then $tilde(r) : V\/A arrow.r A\/A$ is also a retraction, $tilde(i) : A\/A arrow.r V\/A$ is also an inclusion, $h$ also induces $tilde(h) : V\/A times I arrow.r V\/A$, $tilde(r) tilde(i) = bb(1)_(A\/A)$, $tilde(i) tilde(r) tilde.eq^(tilde(h)) bb(1)_(V\/A)$, thus $tilde(r)$ is also a deformation retraction

#strong[\(c)]

Directly check that the following diagram is commutative

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$\(X\,A\)$]),
node((1,0),[$\(X\,V\)$]),
node((0,1),[$\(X\/A\,A\/A\)$]),
node((1,1),[$\(X\/A\,V\/A\)$]),
edge((0,0),(1,0),"->",[$j$]),
edge((0,0),(0,1),"->",[$p$]),
edge((1,0),(1,1),"->",[$q$]),
edge((0,1),(1,1),"->",[$g$]))]
]
Similarly as in (a), $g_(*)$ and $j_(*)$ are isomorphisms, so is $q_(*)$ by 1(c), hence $p_(*)$ is also an isomorphism

#pagebreak(weak:true)
#pagebreak(weak:true)
#pagebreak(weak:true)
#pagebreak(weak:true)
= new
<new>
Wirthinger presentaiton

cup product

Cellular cross product: $X\,Y$ CW complexes, $X times Y$ is also a CW complex with characteristic maps $phi.alt_alpha times psi_beta$

diagonal approximation

Poincare duality

$H_k\(M\,partial M\)tilde.equiv H^(n - k)\(M\)$, $H_k\(M\)tilde.equiv H^(n - k)\(M\,partial M\)$

Define map $C_k arrow.r c^(n - k)$, taking $sigma$ to 1, but not

D is a chain map up to sign, so fine for Z/2, and the sign works exactly when M is orientable

#statement("Theorem", title: [Freedman's theorem])[
Closed, simply connected, oriented 4-manifold up to homeomorphism to symmetric, bilinear, non-degenerate form up to basis change is surjective, and at most 2 to 1 Moreover, if one consider only smooth manifolds, this map is 1 to 1, but no longer surjective In other words, smooth, simply connected, closed, oriented 4-manifolds are characterized by their cup product pairing

]
#statement("Theorem", title: [\"The half lives, half dies\" theorem])[
$M$ compact manifold of dimension $2 n + 1$ with boundary of dimension $2 n$. Then $"rank" H_n\(partial M\)$ is even and $1 / 2 "rank" H_n\(partial M\)= "rank"\(i_(*) : H_n\(partial M\)arrow.r H_n\(M\)\)= "rank"\(i^(*) : H^n\(M\)arrow.r H_n\(partial M\)\)$

]
#statement("Theorem")[
The homotopy group functor preserves products. If $X = product X_alpha$, then $pi_n\(X\)= product_alpha pi_n\(X_alpha\)$

]
#statement("Example")[
Since $I^0 times I arrow.r bb(R)$, $\(s\,t\)mapsto t\/s$, $\(I^0\,I\)$ doesn't have the HEP

]
#statement("Lemma", title: [Compression lemma])[
$A subset.eq X\,B subset.eq Y$ are CW complexes, for each $k$-cell $sigma in X - A$, if $pi_k\(Y\,B\)= 0$, any map $f :\(X\,A\)arrow.r\(Y\,B\)$ is homotopic to a map with image in $B$

]
#statement("Theorem", title: [Whitehead theorem])[
$X\,Y$ are CW complexes, if $f : X arrow.r Y$ induces isomorphism on each $pi_n$, then $f$ is a homotopy

]
#proof(title: "Proof")[
Replace $f : X arrow.r Y$ by the mapping cylinder $f : X arrow.r M_f$, and then apply compression lemma

]
$S^k arrow.r S^n$ can be homotopied to a smooth map, which is locally linear, thus can miss a point

#statement("Lemma", title: [Extension lemma])[
$f : X arrow.r Y$ such that $f\|_(S^k) arrow.r Y$ is null homotopic, then $f$ can be extended to $X union e^k arrow.r Y$

]
#statement("Theorem", title: [CW approximation])[
Assume

]
#statement("Theorem")[
An $n$-connected CW model for $X$ is an $n$-connected CW complex $Z$ and a map $f : Z arrow.r X$ such that $f_(*) : pi_n\(Z\)arrow.r pi_n\(X\)$ are isomorphisms for $k > n$. Such a model always exists and is unique up to isomorphism

]
#statement("Theorem")[
If $A subset.eq X$ is a CW complex, An $n$-connected CW model for $\(X\,A\)$ is an $n$-connected CW pair $\(Z\,A\)$ and $f :\(Z\,A\)arrow.r\(X\,A\)$, such that $f\|_A = i d$, and $pi_i\(Z\,A\)arrow.r pi_i\(X\,A\)$ are iso for $i > n$. Such exists and unique up to iso

]
#statement("Theorem")[
For arbitrary $\(X\,A\)$, there exists an $n$-connected CW model unique up to iso

]
#proof(title: "Proof")[
Let $Z_0$ be a CW approximation of $A$, $\(Z\,Z_0\)$ be an n-connected CW model for $\(M\,Z_0\)$, M mapping cylider of $Z_0 arrow.r A arrow.r X$, then $\(M\,Z_0\)$ is an n-connected CW approximation for $\(X\,A\)$, then by LES and five lemma

]
#statement("Theorem")[
$n$-connected CW models is functorial, i.e. For any $n$-connected model $\(Z\,A\)$ of $\(X\,A\)$ and $n'$-connected model $\(Z'\,A'\)$ of $\(X'\,A'\)$, and $g :\(X\,A\)arrow.r\(X'\,A'\)$, there is a unique $h :\(Z\,A\)arrow.r\(Z'\,A'\)$ making the diagram commute

]
Postnikov tower: Construction: Fix $n$, the idea is to kill all higher homotopy groups by attaching cells, then by extension lemma, $X arrow.r.hook X_n$ extend to a map $X_(n + 1) arrow.r X_n$

Excision fails for homotopy groups $pi_4\(S^3 and S^3\)= pi_4\(S^3 times S^3\)= Z_2 times Z_2$. $S^3\/S^2 = S^3 and S^3$ $Z_2 = pi_(upright("?"))$

#statement("Theorem")[
C connected, (A,C) m connected, $\(B\,C\)$ n connected, $pi_i\(A\,C\)arrow.r pi_i\(X\,B\)$ is an iso if $i < m + n$ and surjective if $i = m + n$

]
#statement("Theorem", title: [Freudenthal's suspension theorem])[

]
Ring structure for stable homotopy: $f : S^(i + k) arrow.r S^k$, $g : S^(j + k) arrow.r S^k$, get $S^(i + j + k) arrow.r S^k$

If $G$ acts properly discontinuously on a contractible CW complex $X$, then $X\/G$ is a $K\(G\,1\)$

Application of Hurewicz theorem in 3 manifold topology: M is a closed, oriented, simply connected 3 manifold. then $pi_1 = 0$, $H_1 =\[pi_1\,pi_i\]= 0$, $H^1 = 0$. By Poincare $pi_1 = H_2 = H^1 = 0$, $pi_3 = H_3 = Z$. Poincare conjecture says M homeomorphic to S^3

#statement("Example")[
If $pi_1\(A\)$ is non trivial, Hurewicz theorem may fail, $\(S^2 or S^1\,S^1\)$ has different $pi_2$, $H_2$

]
#statement("Example", title: [representalbe functor for G bundles])[
Top be the category of top spaces up to homotopy equivalence, G top group, $F : upright(T o p) arrow.r upright(S e t s)$, $X mapsto G$-bundles over $X$, the BG is a representable functor

]
Omega spectra

#statement("Definition")[
An $Omega$-spectrum is a sequence of $K_n$ of CW complexes with weak homotopy equivalences $K_n arrow.r Omega K_(n + 1)$

]
#statement("Remark")[
The loop space of a CW complex is again a CW complex

]
#statement("Theorem")[
$h^n\(X\)= chevron.l X\,K_n chevron.r$ defines base pointed cohomology theory of CW complexes

]
#statement("Example", title: [Eilenberg-MacLane specturm])[

]
#statement("Example", title: [Complex K theory])[
Let $U = union.big U\(n\)$, one can show that there is a weak homotopy equivalence $U arrow.r Omega^2 U$, hence one get a spectrum by setting $K_i = cases(Omega U quad i upright(" even"), U quad i upright(" odd"))$. The complex cohomology theory is periodic(Bott periodicity). $h^0\(X\)= K_0\(X\)$ is the Grothendieck group. $h^1\(X\)= < X\,U > = < X\,Omega^2 U > = < Sigma X\,Omega U > = K_0\(Sigma X\)$

]
#statement("Example", title: [Real K theory])[
$O arrow.r Omega^8 O$ is a weak homotopy equivalence

]
#statement("Definition")[
A spectrum is a sequence $K_n$ with maps $Sigma K_n arrow.r K_(n + 1)$

]
#statement("Example", title: [Sphere spectrum])[
$K_n = S^n$, $S K_n tilde.equiv S^(n + 1)$. More generally, fix $Y$, can define $K_n = Sigma^n Y$

]
#statement("Theorem")[
$h_i\(X\)= lim_arrow.r pi_(i + n)\(X and K_n\)$, $pi_(i + n)\(X and K_n\)arrow.r^S pi_(i + n + 1)\(Sigma\(X and K_n\)\)= pi_(i + n + 1)\(X and Sigma K_n\)arrow.r pi_(i + n + 1)\(X and K_(n + 1)\)$ is a reduced base pointed homology theory

]
#proof(title: "Proof")[
Use Puppe sequence again, note that $pi_(i + n)\(Sigma A and K_n\)= pi_(i + n)\(Sigma\(A and K_n\)\)= pi_(i + n)\(A and Sigma K_n\)$

]
#statement("Theorem")[
Any homology theory with $H_(*)\(X\)= lim_arrow.r_p H_(*)\(X^p\)$ is induced by a spectrum

]
#statement("Example", title: [Stable homotopy groups])[
$pi_(i + n)\(X and S^n\)= pi_(i + n)\(S^n X\)$

]
#statement("Definition")[
A cohomology operation is a natural transformation $H^n\(-\;G\)arrow.r H^n\(-\;G\)$

]
#statement("Example", title: [Power operation on $H^1\(-\;bb(Z)\)$])[

]
spectral sequences

$F_p C_(*)\(X\)= C_(*)\(X^p\)$, $E_(p\,q)^0 = C_(p + q)\(X^p\,X^(p - 1)\)= C_(p + q)\(X^p\)\/C_(p + q)\(X^(p - 1)\)$, $E_(p\,q)^1 = H_(p + q)\(C_(*)\(X^p\,X^(p - 1)\)\)= H_(p + q)\(X^p\,X^(p - 1)\)$


#pagebreak()
#heading(numbering:none)[References]
#emph[Algebraic Topology] - Allen Hatcher

#emph[A Concise Course in Algebraic Topology] - Peter May


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
