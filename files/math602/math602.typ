#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH602 - Homological algebra", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH602 - Homological algebra]
#v(2cm)
#image(read("Pictures/Henri_Cartan.png",encoding:none),format:"jpg",width:50%)
#v(2cm)
Taught by Patrick Bronsnan \
Notes taken by Haoran Li \
2020 Spring
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Review of category theory
<review-of-category-theory>
== Categories - 1/27/2020
<categories---1272020>
#statement("Definition")[
A #strong[category]#index-entry("Categroy") $cal(C)$ consists of $upright(O b) cal(C)$ class of #strong[objects]#index-entry("Object") and $upright(H o m) cal(C)$ class of #strong[morphisms]#index-entry("Morphism"), for $f : A arrow.r B$, $g : B arrow.r C$, $exists g compose f : A arrow.r C$, the composition is associative $\(h compose g\)compose f = h compose\(g compose f\)$, $exists 1_A : A arrow.r A$ such that $1_A f = f\,forall f : B arrow.r A$ and $g 1_A = g\,forall g : A arrow.r B$\(thus $1_A$ is unique), we denote $H o m_(cal(C))\(A\,B\)$ to be all the morphisms from $A$ to $B$

]
#statement("Definition")[
Let $cal(C)$ be a category, $f : A arrow.r B$ is an #strong[isomorphism]#index-entry("Isomorphism") if there exists $g : B arrow.r A$ such that $g f = 1_A$, $f g = 1_B$

]
#statement("Example")[
Let $M$ be a monoid, we can view it as a category $cal(C)_M$, where $O b cal(C)_M = { * }$, $H o m_(cal(C)_M)\(*\,*\)= M$

]
#statement("Remark")[
Book recommandation: Abelian category - Fregd, it defines a category use only morphisms

]
#statement("Lemma")[
An isomorphism $f : X arrow.r Y$ has an unique inverse, denoted $f^(- 1)$

]
#proof(title: "Proof")[

]
#statement("Definition")[
A category $cal(C)$ is called a #strong[small category]#index-entry("Small category") if $O b cal(C)$ is a set

]
#statement("Definition")[
A category $cal(C)$ is called an #strong[essentially small category]#index-entry("Essentially small category") if $O b cal(C)\/tilde.op$ is a set, here $O b cal(C)\/tilde.op$ is the isomorphic classes of objects

]
#statement("Example")[
Let $k$ be a field, then the category of finite dimensional $k$ vector fields is not small but essentially small, two $k$ vector spaces are isomorphic iff they have the same dimension

]
#statement("Example")[
Let $R$ be a commutative ring, the category of $R$ modules, $R M o d$ is not essentially small

]
#statement("Definition")[
Let $P$ be a poset, we can view it as a category $cal(C)_P$, where $O b cal(C)_p = P$, $H o m_(cal(C)_P)\(x\,y\)= cases({ * }\,quad x lt.eq y, diameter\,quad upright("else"))$

]
#statement("Exercise")[
Suppose small category $cal(C)$ satisfies

$\|H o m\(x\,y\)\|lt.eq 1$

$x eq.not y arrow.r.double x tilde.nequiv y$

Then $cal(C)$ is poset

]
#proof(title: "Proof")[

]
#statement("Definition")[
A category is a #strong[groupoid]#index-entry("Groupoid") if every morphism is an isomorphism, thus a groupoid with only one object is a group

]
#pagebreak(weak:true)
== Functors - 1/29/2020
<functors---1292020>
#statement("Definition")[
$cal(C)\,cal(D)$ are categories, $F : cal(C) arrow.r cal(D)$ is a #strong[functor]#index-entry("Functor") if it is a mapping: $upright(O b) cal(C) arrow.r upright(O b) cal(D)$, $cal(C)\(A\,B\)arrow.r cal(D)\(F\(A\)\,F\(B\)\)$, $F\(1_A\)= 1_(F\(A\))$, given $f : A arrow.r B\,g : B arrow.r C$, $F\(g compose f\)= F\(g\)compose F\(f\): F\(A\)arrow.r F\(C\)$, this kind of functor is called #strong[covariant fucntor], if $upright(O b) cal(C) arrow.r upright(O b) cal(D)$, $cal(C)\(A\,B\)arrow.r cal(D)\(F\(B\)\,F\(A\)\)$, $F\(1_A\)= 1_(F\(A\))$, given $f : A arrow.r B\,g : B arrow.r C$, $F\(g compose f\)= F\(f\)compose F\(g\): F\(C\)arrow.r F\(A\)$, then this is called a #strong[contravariant functor]

The #strong[dual category]#index-entry("Dual category") of a category $cal(C)$ is denoted as $cal(C)^(o p)$ with the same objects but morphisms reversed, a contravariant functor is just a functor in the dual

]
#statement("Example")[
#strong[\(1):] Let $M\,N$ be monoids, a functor $F : cal(C)_M arrow.r cal(C)_N$ is just a homomorphism of monoids

#strong[\(2):] Let $M\,N$ be groups, a functor $F : cal(C)_M arrow.r cal(C)_N$ is just a homomorphism of groups

#strong[\(3):] Let $L\/F$ be a field extension, $- times.o L$ is a functor $V e c t_F arrow.r V e c t_L\,V mapsto V times.o_F L$, $phi.alt mapsto phi.alt times.o 1_L$

#strong[\(4):] Homology $H_(*)$ is a functor $T o p arrow.r A b g p$, $X mapsto H_(*)\(X\)$

#strong[\(5):] Cohomology $H^(*)$ is a contravariant functor $T o p arrow.r A b g p$, $X mapsto H^(*)\(X\)$

#strong[\(6):] Let $F i n A b g p$ be the category of finite abelian groups, then $D : F i n A b g p arrow.r F i n A b g p$, $X mapsto H o m\(X\,bb(Q)\/bb(Z)\)$ is a contravariant functor, or we could use $H o m\(X\,bb(C)^times\)$, this is called #strong[Pontrjagin duality]#index-entry("Pontrjagin duality")

#strong[\(7):] $D : V e c t_K arrow.r V e c t$, $V mapsto V^(*)$ is a contravariant functor

]
#aside("Notation")[
Suppose $f : X arrow.r Y$ is a morphism in category $cal(C)$, for $Z in o b cal(C)$, we define #math.equation(block: true, numbering: none, $f_(*) : H o m\(Z\,X\)arrow.r H o m\(Z\,Y\)\,quad g mapsto f g$) #math.equation(block: true, numbering: none, $f^(*) : H o m\(Y\,Z\)arrow.r H o m\(X\,Z\)\,quad g mapsto g f$)

]
#statement("Definition")[
A morphism $f : X arrow.r Y$ is called a monomorphism if $f_(*)$ is 1-1 for all $Z in o b cal(C)$

A morphism $f : X arrow.r Y$ is called a epimorphism if $f^(*)$ is 1-1 for all $Z in o b cal(C)$

]
#statement("Definition")[
In category $cal(C)$, an object $X$ is called an #strong[initial object]#index-entry("Initial object") if $H o m\(X\,Y\)$ consists of exactly one element for all $Y$, $X$ is called a #strong[final object]#index-entry("Final object") if $H o m\(Y\,X\)$ consists of exactly one element for all $Y$, $X$ is called a #strong[zero object]#index-entry("Zero object") if it is both initial and final

]
#statement("Example")[
#strong[\(1):] In the category of sets, $nothing$ is an initial object, ${ 1 }$ is a final object

#strong[\(2):] In the category of abelian groups, $0$ is a zero object

]
#statement("Definition")[
$F\,G : cal(C) arrow.r cal(D)$ are covariant functors, $eta_A : F\(A\)arrow.r G\(A\)$ is a family of morphisms such that the following diagram commutes for any $f : A arrow.r B$

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(A\)$]),
node((1,0),[$F\(B\)$]),
node((0,1),[$G\(A\)$]),
node((1,1),[$G\(B\)$]),
edge((0,0),(0,1),"->",[$eta_A$]),
edge((0,0),(1,0),"->",[$F\(f\)$]),
edge((1,0),(1,1),"->",[$eta_B$]),
edge((0,1),(1,1),"->",[$G\(f\)$]))]
For contravariant functors, we have the following commutative diagram for any $f : A arrow.r B$

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(B\)$]),
node((1,0),[$F\(A\)$]),
node((0,1),[$G\(B\)$]),
node((1,1),[$G\(A\)$]),
edge((0,0),(0,1),"->",[$eta_B$]),
edge((0,0),(1,0),"->",[$F\(f\)$]),
edge((1,0),(1,1),"->",[$eta_A$]),
edge((0,1),(1,1),"->",[$G\(f\)$]))]
$eta$ is called a #strong[natural transformation]#index-entry("Natural transformation")

If $eta_A$ are isomorphisms, then $eta$ is called a #strong[natural isomorphism], denoted $F tilde.equiv G$

]
#pagebreak(weak:true)
== Presheaves and Yoneda lemma - 1/31/2020
<presheaves-and-yoneda-lemma---1312020>
#statement("Definition")[
Suppose $cal(C)$, $cal(D)$ are categories, we can define the #strong[functor category]#index-entry("Functor category") $upright(F u n)\(cal(C)\,cal(D)\)= cal(D)^(cal(C))$ with objects functors from $cal(C)$ to $cal(D)$ and morphisms natural transformations

]
#statement("Remark")[
If $I$ is a small category, then $H o m_(cal(C)^I)\(F\,G\)$ is a set

]
#statement("Definition")[
we say categories $cal(C)\,cal(D)$ are #strong[isomorphic]#index-entry("Isomorphic category") if there are functors $F : cal(C) arrow.r cal(D)$ and $G : cal(D) arrow.r cal(C)$ such that $G compose F = 1_(cal(C))$, $F compose G = 1_(cal(D))$ and we say $cal(C)\,cal(D)$ are #strong[equivalent]#index-entry("Equivalent category") if $G compose F$ is naturally isomorphic to $1_(cal(C))$ and $F compose G$ is naturally isomorphic to $1_(cal(D))$

]
#statement("Example")[
Let $cal(C) = V e c t_K$ be te category of $K$ vector spaces, define functor $F : cal(C) arrow.r cal(C)$, $V mapsto V times.o_K K$ is an equivalence with inverse $G = 1_(cal(C))$, but this is not an isomorphism, since not every vector space is in the form of a tensor product

]
#statement("Definition")[
Suppose $cal(C)\,cal(D)$ are locally small categories, $F : cal(C) arrow.r cal(D)$ is a functor

$F$ is #strong[faithful]#index-entry("Faithful functor") if $H o m_(cal(C))\(X\,Y\)arrow.r H o m_(cal(D))\(F\(X\)\,F\(Y\)\)$ is injective for any $X\,Y$

$F$ is #strong[full]#index-entry("Full functor") if $H o m_(cal(C))\(X\,Y\)arrow.r H o m_(cal(D))\(F\(X\)\,F\(Y\)\)$ is surjective for any $X\,Y$

$F$ is #strong[fully faithful] if $H o m_(cal(C))\(X\,Y\)arrow.r H o m_(cal(D))\(F\(X\)\,F\(Y\)\)$ is bijective for any $X\,Y$

$F$ is #strong[essentially surjective]#index-entry("Essentially surjective") if $forall d in o b cal(D)$, $exists c in o b cal(C)$ such that $F c tilde.equiv d$

]
#statement("Lemma")[
In category $cal(C)$, if $phi.alt_X : X arrow.r X'$, $phi.alt_Y : Y arrow.r Y'$ are isomorphisms, then $H o m\(X\,Y\)$, $H o m\(X'\,Y'\)$ are in bijective correspondence

]#label("X1,X2 iso and Y1,Y2 iso implies Hom(X1,Y1),Hom(X2,Y2) iso")
#proof(title: "Proof")[
We can define maps $H o m\(X\,Y\)arrow.r H o m\(X'\,Y'\)$, $f mapsto phi.alt_Y f phi.alt_X^(- 1)$ and $H o m\(X'\,Y'\)arrow.r H o m\(X\,Y\)$, $f' mapsto phi.alt_Y^(- 1) f' phi.alt_X$ which are inverses to each other

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
node((0,1),[$X'$]),
node((1,1),[$Y'$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(0,1),"->",[$phi.alt_X$]),
edge((1,0),(1,1),"->",[$phi.alt_Y$]),
edge((0,1),(1,1),"->",[$f'$]))]
]

]
#statement("Theorem")[
A functor $F : cal(C) arrow.r cal(D)$ is an equivalence iff it is fully faithful and essentially surjective

]#label("A functor F is an equivalence iff it is fully faithful and essentially surjective")
#proof(title: "Proof")[
If $F$ is an equivalence, there exist functor $G : cal(D) arrow.r cal(C)$ and natural isomorphisms $eta : 1_(cal(C)) arrow.r G F$, $xi : 1_(cal(D)) arrow.r F G$, $forall d in cal(C)$, $xi_d : d = 1_(cal(D))\(d\)arrow.r F G\(d\)= F\(G d\)$ is an isomorphism, i.e. $F$ is essentially surjective, similarly, so is $G$

The composition of #math.equation(block: true, numbering: none, $H o m\(c\,c'\)arrow.r^F H o m\(F c\,F c'\)arrow.r^G H o m\(G F c\,G F c'\)\,quad f mapsto F f mapsto G F f$) Is the same as #math.equation(block: true, numbering: none, $H o m\(c\,c'\)arrow.r^eta H o m\(G F c\,G F c'\)\,quad f mapsto eta'_c f eta_c^(- 1)$) By Lemma #ref(label("X1,X2 iso and Y1,Y2 iso implies Hom(X1,Y1),Hom(X2,Y2) iso"), supplement: none), this is bijective, thus $H o m\(c\,c'\)arrow.r^F H o m\(F c\,F c'\)$ is injective, i.e. $F$ is faithful. Similarly, consider the composition #math.equation(block: true, numbering: none, $H o m\(F c\,F c'\)arrow.r^G H o m\(G F c\,G F c'\)arrow.r^F H o m\(F G F c\,F G F c'\)$) We know $H o m\(G F c\,G F c'\)arrow.r^F H o m\(F G F c\,F G F c'\)$ is surjective, but we also have the following diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m\(c\,c'\)$]),
node((1,0),[$H o m\(F c\,F c'\)$]),
node((0,1),[$H o m\(G F c\,G F c'\)$]),
node((1,1),[$H o m\(F G F c\,F G F c'\)$]),
edge((0,0),(1,0),"->",[$F$]),
edge((0,0),(0,1),"->",[$eta$]),
edge((1,0),(1,1),"->",[$xi$]),
edge((0,1),(1,1),"->",[$F$]))]
]
Since $eta\,xi$ are bijective, $H o m\(c\,c'\)arrow.r^F H o m\(F c\,F c'\)$ is surjective, i.e. $F$ is full

Conversely, suppose $F$ is fully faithful and essentially surjective, then for any $d in cal(D)$, there exists $c$ and an isomorphism $d arrow.r^(xi_d) F c$, denote this $c$ as $G d$, we can define a functor $G : cal(D) arrow.r cal(C)$, $d mapsto G d$\(Here we have used the axiom of choice), $d arrow.r^f d' mapsto c arrow.r^(G f) c'$ where $F G f = xi_d^(- 1) f xi_(d')$ since $F$ is fully faithful

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$d$]),
node((1,0),[$d'$]),
node((0,1),[$F G d$]),
node((1,1),[$F G d'$]),
node((0,2),[$G d$]),
node((1,2),[$G d'$]),
edge((0,0),(0,1),"->",[$xi_d$]),
edge((0,0),(1,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$xi_(d')$]),
edge((0,1),(1,1),"->",[$F G f$]),
edge((0,2),(0,1),"->",[$F$]),
edge((0,2),(1,2),"->",[$G f$]),
edge((1,2),(1,1),"->",[$F$]))]
]
$xi : 1_(cal(D)) arrow.r F G$ is a natural isomorphism

Since $F$ is fully faithful, there are unique $eta_c : c arrow.r G F c$, $F\(eta_c\)= xi_(F c)$

If $f\,g : c arrow.r c'$ such that $eta_(c') f = eta_(c') g$, then $xi_(F c') F f = xi_(F c') F g arrow.r.double F f = F g arrow.r.double f = g$

If $f\,g : c arrow.r c'$ such that $f eta_c = g eta_c$, then $F f xi_(F c) = F g xi_(F c) arrow.r.double F f = F g arrow.r.double f = g$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$c$]),
node((1,0),[$c'$]),
node((0,1),[$F c$]),
node((1,1),[$F c'$]),
node((0,2),[$G F c$]),
node((1,2),[$G F c'$]),
node((0,3),[$F G F c$]),
node((1,3),[$F G F c'$]),
edge((0,0),(0,1),"->"),
edge((0,0),(1,0),"->"),
edge((0,0),(0,2),"->",[$eta_c$],bend:-15deg),
edge((1,0),(1,1),"->"),
edge((1,0),(1,2),"->",[$eta_(c')$],bend:15deg),
edge((0,1),(0,2),"->",[$G$]),
edge((0,1),(1,1),"->"),
edge((0,1),(0,3),"->",[$xi_(F c)$],bend:-15deg),
edge((1,1),(1,2),"->",[$G$]),
edge((1,1),(1,3),"->",[$xi_(F c')$],bend:15deg),
edge((0,2),(0,3),"->",[$F$]),
edge((0,2),(1,2),"->"),
edge((1,2),(1,3),"->",[$F$]),
edge((0,3),(1,3),"->"))]
]
$eta : 1_(cal(C)) arrow.r G F$ is a natural isomorphism

]
#statement("Definition")[
$cal(D)^(cal(C)^(o p))$ is the category of #strong[presheaves]#index-entry("Presheaf"). Denote $cal(C)^or := S e t s^(cal(C)^(o p))$. In particular, if $X$ is a topological space, open subsets with inclusion form a category $cal(C)$, $P r e S h\(X\,cal(D)\)$ is the category of presheaves on $X$ with values in $cal(D)$

]
#statement("Lemma", title: [Yoneda lemma])[
#strong[Yoneda embedding]#index-entry("Yoneda embedding") $h : cal(C) arrow.r cal(C)^or$ defined as follows is a fully faithful functor

For $X in o b cal(C)$, $h\(X\)= H o m_(cal(C))\(-\,X\)$ is a contravariant functor $cal(C) arrow.r S e t s$:

For $Z in o b cal(C)$, $h\(X\)\(Z\)= H o m_(cal(C))\(Z\,X\)$, for $phi.alt : Z arrow.r W$, $h\(X\)\(phi.alt\)= phi.alt^(*) : h\(X\)\(W\)= H o m_(cal(C))\(W\,X\)arrow.r H o m_(cal(C))\(Z\,X\)= h\(X\)\(Z\)$, hence $h\(X\)$ is an object in $cal(C)^or$

For $psi : X arrow.r Y$, $h\(psi\)= psi_(*)$ is a natural transformation $h\(X\)arrow.r h\(Y\)$:

For $phi.alt : Z arrow.r W$, we have the commutative diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m_(cal(C))\(W\,X\)$]),
node((1,0),[$H o m_(cal(C))\(W\,Y\)$]),
node((0,1),[$H o m_(cal(C))\(Z\,X\)$]),
node((1,1),[$H o m_(cal(C))\(Z\,Y\)$]),
edge((0,0),(1,0),"->",[$psi_(*)$]),
edge((0,0),(0,1),"->",[$phi.alt_(*)$]),
edge((1,0),(1,1),"->",[$phi.alt_(*)$]),
edge((0,1),(1,1),"->",[$psi_(*)$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$h\(X\)\(W\)$]),
node((1,0),[$h\(Y\)\(W\)$]),
node((0,1),[$h\(X\)\(Z\)$]),
node((1,1),[$h\(X\)\(Z\)$]),
edge((0,0),(1,0),"->",[$h\(psi\)_W$]),
edge((0,0),(0,1),"->",[$h\(Y\)\(phi.alt\)$]),
edge((1,0),(1,1),"->",[$h\(Y\)\(phi.alt\)$]),
edge((0,1),(1,1),"->",[$h\(psi\)_Z$]))]
]
]#label("Yoneda lemma")
#proof(title: "Proof")[

]
#statement("Definition")[
A #strong[subcategory]#index-entry("Subcategory") $cal(D)$ of $cal(C)$ is a category with objects a subclass of $o b cal(C)$ and morphisms a subclass of $H o m cal(C)$, with the original composition

]
#statement("Example")[
The image of a functor is not necessarily a category

Consider the following categories $cal(C)$ and $cal(D)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$B$]),
node((2,0),[$C$]),
node((3,0),[$D$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(1,0),"->",[$1_A$]),
edge((1,0),(2,0),"->",[$1_B$]),
edge((2,0),(3,0),"->",[$g$]),
edge((2,0),(3,0),"->",[$1_C$]),
edge((3,0),(4,0),"->",[$1_D$]))]
]
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$E$]),
node((1,0),[$F$]),
node((2,0),[$G$]),
edge((0,0),(1,0),"->",[$h$]),
edge((0,0),(1,0),"->",[$1_E$]),
edge((0,0),(2,0),"->",[$i h$],bend:-15deg),
edge((1,0),(2,0),"->",[$1_F$]),
edge((1,0),(2,0),"->",[$i$]),
edge((2,0),(3,0),"->",[$1_G$]))]
]
Consider functor $F : cal(C) arrow.r cal(D)$, $F\(A\)= E$, $F\(B\)= F$, $F\(C\)= F$, $F\(D\)= G$, $F\(f\)= h$, $F\(g\)= i$

]
#statement("Theorem")[
A functor $F : cal(C) arrow.r cal(D)$ is fully faithful iff it induces an equivalence of categories from $cal(C)$ to a full subcategory of $cal(D)$

]
#proof(title: "Proof")[

]
#pagebreak(weak:true)
== Limits - 2/3/2020
<limits---232020>
#statement("Definition")[
A functor $F$ in $cal(C)^or$ is called #strong[representable]#index-entry("Representable functor") if there exists $X in o b cal(C)$ such that $h\(X\)tilde.equiv F$, here $h$ is the Yoneda embedding. In other words, there exists a natural isomorphism $H o m_(cal(C))\(Y\,X\)arrow.r F\(Y\)$, since $h$ is fully faithful, if $F tilde.equiv h\(X\)tilde.equiv h\(X'\)$, the natural isomorphism $h\(X\)tilde.equiv h\(X'\)$ comes from an isomorphism $phi.alt : X arrow.r X'$, hence $X$ is unique to isomorphism

]
#statement("Definition")[
Let $I$ be a small category, $cal(C)$ be a category, for any $X in o b cal(C)$, we can define the #strong[constant functor]#index-entry("Constant functor") $K_X : I arrow.r cal(C)$, $i mapsto X$, $i arrow.r^f j mapsto 1_X$, hence $K : cal(C) arrow.r cal(C)^I$, $X mapsto K_X$ is a functor, a natural transformation $f$ between constant functors $K_X arrow.r K_Y$ is just a morphism $f : X arrow.r Y$

]
#statement("Definition")[
Suppose $F : I arrow.r cal(C)$ is a functor, we get a presheaf $P$, $P\(X\)= H o m_(cal(C)^I)\(K_X\,F\)$

If $P$ is representable, i.e. $h\(L\)tilde.equiv P$, we write $L = lim_arrow.l F$ which is called the #strong[limit]#index-entry("Limit") of $F$

We also have a functor $F^(o p) : I^(o p) arrow.r cal(C)^(o p)$. The #strong[colimit]#index-entry("Colimit") is defined to be $lim_arrow.l F^(o p)$

]
#statement("Remark")[
Unravel $H o m_(cal(C)^I)\(K_X\,F\)= P\(X\)tilde.equiv H o m_(cal(C))\(X\,L\)$

If we take $X = L$, $1_X$ corresponds to a natural transformation $phi.alt : K_L arrow.r F$, i.e. $phi.alt_i : L arrow.r F\(i\)$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$F\(i\)$]),
node((1,1),[$F\(j\)$]),
edge((0,0),(1,0),"->",[$phi.alt_i$]),
edge((0,0),(1,1),"->",[$phi.alt_j$]),
edge((1,0),(1,1),"->",[$F\(i arrow.r j\)$]))]
]
Each natural transformation $psi : K_X arrow.r F$ corresponds to a unique morphism $hat(psi) : X arrow.r L$, due to naturality, the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((0,1),[$L$]),
node((1,1),[$F\(i\)$]),
edge((0,0),(0,1),"->",[$hat(psi)$]),
edge((0,0),(1,1),"->",[$psi_i$]),
edge((0,1),(1,1),"->",[$phi.alt_i$]))]
]
]
#statement("Definition")[
A category $I$ is called #strong[discrete]#index-entry("Discrete category") if all morphisms are just identities, it is clear that a discrete category is the same as a class of objects, and a functor $F : I arrow.r cal(C)$ is the same as giving $X_i = F\(i\)$

]
#statement("Example")[
Suppose $I$ is a discrete category, $F : I arrow.r cal(C)$ is a functor, we also get functor $F^(o p) : I^(o p) arrow.r cal(C)^(o p)$. The #strong[product]#index-entry("Product") is defined to be the limit $product_(i in I) X_i := lim_arrow.l F$, and the #strong[coproduct]#index-entry("Coproduct") is $lim_arrow.l F^(o p)$

]
#pagebreak(weak:true)
== Equalizers and fiber product - 2/5/2020
<equalizers-and-fiber-product---252020>
#statement("Definition")[
A category $cal(C)$ is #strong[complete]#index-entry("Complete category") if $cal(C)$ contains all limits, $cal(C)$ is #strong[cocomplete]#index-entry("Cocomplete category") if $cal(C)$ contains all colimits

]
#statement("Definition")[
Let $I$ be the category

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet$]),
node((1,0),[$bullet$]),
edge((0,0),(1,0),"->",shift:2pt),
edge((0,0),(1,0),"->",shift:-2pt))]
, a functor $F : I arrow.r cal(C)$ is just

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
edge((0,0),(1,0),"->",[$f$],shift:2pt),
edge((0,0),(1,0),"->",[$g$],shift:-2pt))]
, the limit is defined to be the #strong[equalizer]#index-entry("Equalizer"), the dual notion is called a #strong[coequalizer]#index-entry("Coequalizer")

]
#statement("Theorem")[
If a category $cal(C)$ contains all products and equalizers, then $cal(C)$ is complete

]
#proof(title: "Proof")[
The limit of $A arrow.r^f B$ is the same as the equaliser of

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A times B$]),
node((1,0),[$B$]),
edge((0,0),(1,0),"->",[$p_B$],shift:-2pt),
edge((0,0),(1,0),"->",[$f p_A$],shift:2pt))]
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$C$]),
node((1,1),[$A times B$]),
node((0,2),[$A$]),
node((2,2),[$B$]),
edge((1,0),(0,2),"->",[$g$]),
edge((1,0),(2,2),"->",[$h$]),
edge((1,0),(1,1),"->",stroke:(dash:"dashed")),
edge((1,1),(0,2),"->",[$p_A$]),
edge((1,1),(2,2),"->",[$p_B$]),
edge((0,2),(2,2),"->",[$f$]))]
]
Then by induction, we can find the limit of $A_i arrow.r lim_arrow.l_(j eq.not i) A_j$ which is $lim_arrow.l_i A_i$

]
#statement("Definition")[
Let $I$ be the category

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$bullet$]),
node((0,1),[$bullet$]),
node((1,1),[$bullet$]),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->"))]
, a functor $F : I arrow.r cal(C)$ is just

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$Y$]),
node((0,1),[$X$]),
node((1,1),[$Z$]),
edge((1,0),(1,1),"->",[$g$]),
edge((0,1),(1,1),"->",[$f$]))]
, the limit is defined to be the #strong[fiber product(pullback)]#index-entry("Fiber product")#index-entry("Pullback"), the dual notion is called a #strong[pushforward(pushout)]#index-entry("Pushforward")#index-entry("Pushout")

]
#statement("Definition")[
An $upright(bold(A b))$#strong[\-category]#index-entry("Ab-category") $cal(C)$ is a category such that $H o m_(cal(C))\(X\,Y\)$ are equipped with an abelian group structure, such that $f\(g + h\)= f g + f h$, $\(f + g\)h = f h + g h$

]
#statement("Remark")[
An $A b$-category is also called a #strong[preadditive category]#index-entry("Preadditive category")

$E n d_(cal(C))\(X\)$ is a ring, $A u t_(cal(C))\(X\)= E n d_(cal(C))\(X\)^times$ is a group

]
#pagebreak(weak:true)
== Abelian category - 2/7/2020
<abelian-category---272020>
#statement("Definition")[
The #strong[biproducts]#index-entry("Biproduct") $\(A_1 xor dots.h.c xor A_n\,p_1\,dots.h.c\,p_n\,i_1\,dots.h.c\,i_n\)$ of $A_1\,dots.h.c\,A_n$ is such that $\(A_1 xor dots.h.c xor A_n\,p_1\,dots.h.c\,p_n\)$ is the product of $A_1\,dots.h.c\,A_n$ and $\(A_1 xor dots.h.c xor A_n\,i_1\,dots.h.c\,i_n\)$ is the coproduct of $A_1\,dots.h.c\,A_n$

]
#statement("Lemma")[
Suppose $cal(A)$ is an $A b$ category, then for any $A_1\,dots.h.c\,A_n$, if the product $product A_i$ exists, then it is a biproduct, similarly, if the coproduct $product.co A_i$ exsits, then it is a biproduct

]
#proof(title: "Proof")[
Suppose $\(A times B\,p_A\,p_B\)$ is the product of $A\,B$, then we can define morphisms $i_A =\(1_A\,0\): A arrow.r A times B$, $i_B =\(0\,1_B\): B arrow.r A times B$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A$]),
node((0,1),[$A$]),
node((1,1),[$A times B$]),
node((2,1),[$B$]),
edge((1,0),(0,1),"->",[$1_A$]),
edge((1,0),(2,1),"->",[$0$]),
edge((1,0),(1,1),"->",[$i_A$],stroke:(dash:"dashed")),
edge((1,1),(0,1),"->",[$p_A$]),
edge((1,1),(2,1),"->",[$p_B$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$B$]),
node((0,1),[$A$]),
node((1,1),[$A times B$]),
node((2,1),[$B$]),
edge((1,0),(0,1),"->",[$0$]),
edge((1,0),(2,1),"->",[$1_B$]),
edge((1,0),(1,1),"->",[$i_B$],stroke:(dash:"dashed")),
edge((1,1),(0,1),"->",[$p_A$]),
edge((1,1),(2,1),"->",[$p_B$]))]
]
Thus $p_A i_A = 1_A$, $p_B i_A = 0$, $p_A i_B = 0$, $p_B i_B = 1_B$, also if we consider the following commutative diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A times B$]),
node((0,1),[$A$]),
node((1,1),[$A times B$]),
node((2,1),[$B$]),
edge((1,0),(0,1),"->",[$p_A$],bend:-15deg),
edge((1,0),(1,1),"->",[$i_A p_A + i_B p_B$],stroke:(dash:"dashed")),
edge((1,0),(2,1),"->",[$p_B$],bend:15deg),
edge((1,1),(0,1),"->",[$p_A$]),
edge((1,1),(2,1),"->",[$p_B$]))]
]
By the uniqueness of the induced map, $i_A p_A + i_B p_B = 1_(A times B)$, let's show that $\(A times B\,i_A\,i_B\)$ is the coproduct of $A\,B$, suppose $h : A times B arrow.r C$ is a morphism such that $h i_A = f$, $h i_B = g$, then $h = h\(i_A p_A + i_B p_B\)= h i_A p_A + h i_B p_B = f p_A + g p_B$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$C$]),
node((0,1),[$A$]),
node((1,1),[$A times B$]),
node((2,1),[$B$]),
edge((0,1),(1,0),"->",[$f$]),
edge((0,1),(1,1),"->",[$i_A$],shift:2pt),
edge((1,1),(1,0),"->",[$exists_1 h$],stroke:(dash:"dashed")),
edge((1,1),(0,1),"->",[$p_A$],shift:2pt),
edge((1,1),(2,1),"->",[$p_B$],shift:-2pt),
edge((2,1),(1,0),"->",[$g$]),
edge((2,1),(1,1),"->",[$i_B$],shift:-2pt))]
]

]
#statement("Definition")[
An #strong[additive category]#index-entry("Additive category") is an $A b$ category with all finite biproducts, including empty biproduct $0$, the zero object

]
#statement("Definition")[
An #strong[abelian category]#index-entry("Abelian category") $cal(A)$ is an additive category satisfying

#strong[\(AB1)] Every map has a kernel and a cokernel

#strong[\(AB2)] Every monomorphism is the kernel of its cokernel, every epimorphism is the cokernel of its kernel

]
#statement("Example")[
The category of free $bb(Z)$ modules(free abelian groups) is not an abelian category, $bb(Z) arrow.r^(times 2) bb(Z)$ has $0$ as its cokernel but this is not the kernel of $bb(Z) arrow.r 0$

]
#statement("Example", title: [A category with two different $A b$ structures])[
Consider rings $bb(Q)\[x\]$, $bb(Q)\[x\,y\]$ as abelian categories with a single object and morphisms being the elements, multiplication as composition, addition gives an abelian group structure

$bb(Q)\[x\]$, $bb(Q)\[x\,y\]$ as categories are isomorphic to its underlying monoids, since $bb(Q)\[x\]$, $bb(Q)\[x\,y\]$ are UFD's, and $bb(Q)\[x\]= { 0 } union.big bb(Q)^times times xor.big_f bb(N)$, $bb(Q)\[x\,y\]= { 0 } union.big bb(Q)^times times xor.big_g bb(N)$ , where $f\,g$ run over all irreducible polynomials of $bb(Q)\[x\]\\bb(Q)$ and $bb(Q)\[x\,y\]\\bb(Q)$ which are both countably many, thus as monoids they are both isomorphic to ${ 0 } union.big bb(Q)^times times xor.big_(i in bb(N)) bb(N)$, Where $0 compose 0 = 0$, $0 compose\(q\,\(i_0\,i_1\,dots.h.c\)\)=\(q\,\(i_0\,i_1\,dots.h.c\)\)compose 0 = 0$, $\(q\,\(i_0\,i_1\,dots.h.c\)\)compose\(q'\,\(i'_0\,i'_1\,dots.h.c\)\)=\(q q'\,\(i_0 + i'_0\,i_1 + i'_1\,dots.h.c\)\)$ with $\(1\,\(0\,0\,dots.h.c\)\)$ as the identity

but $bb(Q)\[x\]$, $bb(Q)\[x\,y\]$ are not isomorphic as rings

]
#statement("Remark")[
Being an abelian category is purely a property of a category

If all finite products and coproducts are biproducts, i.e. $X union.sq Y = X times Y$, with some other exactness properties, then the abelian group structure on $H o m\(X\,Y\)$ comes from this

See Freyd - Abelian category

]
#statement("Definition")[
Define the #strong[diagonal functor] $Delta : cal(C) arrow.r cal(C)^I$ mapping $A$ to the constant functor $K_A$

]
#pagebreak(weak:true)
== Adjunction - 2/10/2020
<adjunction---2102020>
#statement("Definition")[
Let $L : cal(D) arrow.r cal(C)$, $R : cal(C) arrow.r cal(D)$ be functors, and there is a natural isomorphism $Phi_(X\,Y)$, $X in cal(C)\,Y in cal(D)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m_(cal(C))\(L X\,Y\)$]),
node((1,0),[$H o m_(cal(D))\(X\,R Y\)$]),
node((0,1),[$H o m_(cal(C))\(L X'\,Y'\)$]),
node((1,1),[$H o m_(cal(D))\(X'\,R Y'\)$]),
edge((0,0),(1,0),"->",[$Phi_(X\,Y)$]),
edge((0,0),(0,1),"->",[$\(L f\,g\)$]),
edge((1,0),(1,1),"->",[$\(g\,R f\)$]),
edge((0,1),(1,1),"->",[$Phi_(X'\,Y')$]))]
]
Here $f : X' arrow.r X$, $g : Y arrow.r Y'$, $H o m_(cal(C))\(L f\,g\)\(h\)= h compose g compose L f$

We say $L$ is the #strong[left adjoint]#index-entry("Adjoint functors") of $R$ and $R$ is the #strong[right adjoint] of $L$

]
#statement("Example")[
Let $G : G r o u p arrow.r S e t$ be the forgetful functor, then the functor $F : S e t arrow.r G r o u p$, sending $S$ to $F\(S\)$ is the left adjoint of $G$

In the category of $R$-modules $M o d$, consider functor $F := - times.o B$ and functor $G := H o m\(B\,-\)$, then $F\,G$ are adjoint pairs, i.e. $H o m\(A times.o B\,C\)tilde.equiv H o m\(A\,H o m\(B\,C\)\)$

]
#statement("Theorem")[
Suppose $L : cal(A) arrow.r cal(B)$, $R : cal(B) arrow.r cal(A)$ are a pair of adjoint functors, then there exist natural transformations $eta : 1_(cal(A)) arrow.r R L$ and $epsilon : L R arrow.r 1_(cal(B))$ such that the right adjoint of $L X arrow.r^f Y$ is $X arrow.r^(R\(f\)eta_X) R Y$ and left adjoint of $g : X arrow.r R Y$ is $L X arrow.r^(epsilon_Y L\(g\)) Y$. Moreover, the following composites are identity, $L X arrow.r^(L\(eta_X\)) L R L X arrow.r^(epsilon_(L X)) L X$, $R Y arrow.r^(eta_(R Y)) R L R Y arrow.r^(R\(epsilon_Y\)) R Y$

]
#proof(title: "Proof")[

]
#statement("Theorem")[
Suppose $F\,G$ is an adjunction pair, then $F$ preserve colimits, $G$ preserve limits

]
#proof(title: "Proof")[
Suppose $Phi : I arrow.r cal(D)$ is a functor, $L = lim_arrow.l_(i in I) Phi\(i\)$ exists, applying $G$ to commutative diagram $L arrow.r^(phi_i) Phi\(i\)$, we get another commutative diagram $G L arrow.r^(G phi_i) G Phi\(i\)$. For any commutative diagram $X arrow.r^(psi_i) G Phi\(i\)$, by adjunction, we have a commutative diagram $F X arrow.r Phi\(i\)$, which induce a map $F X arrow.r L$, by adjunction again, we have $X arrow.r G L$

]
#statement("Definition")[
A functor $F : cal(C) arrow.r cal(D)$ is said to be #strong[left exact]#index-entry("Left exact") if $F$ preserve all finite limits, and #strong[right exact]#index-entry("Right exact") if $F$ preserve all finite colimits

]
#statement("Example")[
A left exact functor preserves all equalizers, and all kernels if the category is abelian, a right exact functor preserves all coequalizers, and all cokernels if the category is abelian, left adjoints are right exact, right adjoints are left exact, for example, $- times.o B$ is right exact and $H o m\(B\,-\)$ is left exact

]
#pagebreak(weak:true)
#pagebreak(weak:true)
= Chain complexes
<chain-complexes>
== Chain complexes - 2/12/2020
<chain-complexes---2122020>
#statement("Definition")[
Let $cal(A)$ be an abelian category, a ($bb(Z)$-graded) #strong[chain complex]#index-entry("Chain complex") $C_bullet$ is #math.equation(block: true, numbering: none, $dots.h.c arrow.r C_1 arrow.r^(partial_1) C_0 arrow.r^(partial_0) C_(- 1) arrow.r dots.h.c$) Such that $partial_n compose partial_(n + 1) = 0$, $partial_i$ are called #strong[boundary maps(differentials)]#index-entry("Boundary maps")

We can define chain maps, chain homotopy, boundaries, cycles, and homology groups, and we say the chain complex is exact if each homology groups is zero, the chain complexes form the #strong[category of chain complexes]#index-entry("Category of chain complexes") $C h_bullet cal(A)$

Similarly, we can also define cochain complex $C^bullet$ #math.equation(block: true, numbering: none, $dots.h.c arrow.r C^(- 1) arrow.r^(d^(- 1)) C^0 arrow.r^(d^0) C^1 arrow.r dots.h.c$) Such that $d^(n + 1) compose d^n = 0$, $d^i$ are called #strong[coboundary maps]#index-entry("Coboundary maps"), cochain complexes form the #strong[category of cochain complexes] $C h^bullet cal(A)$

]
#statement("Lemma")[
$phi.alt : C h^bullet cal(A) arrow.r C h_bullet cal(A)$, $\(phi.alt C_bullet\)^n = C_(- n)$, $phi.alt\(d^n\)= partial_n$

]
#proof(title: "Proof")[

]
#statement("Definition")[
Suppose $X_bullet$ is a chain complex, we can define #strong[cycles]#index-entry("Cycle") $Z_n\(X\):= ker\(X_n arrow.r^(partial_n) X_(n - 1)\)$, #strong[boundaries]#index-entry("Boundary") $B_n\(X\):= upright(i m)\(X_(n + 1) arrow.r^(partial_n) X_n\)$ and #strong[homology]#index-entry("Homology") $H_n\(X\):= upright(c o k e r)\(B_n arrow.r Z_n\)$, actually, $Z_n\,B_n\,H_n$ are functors $C h cal(A) arrow.r cal(A)$

]
#statement("Definition")[
$phi.alt : X_bullet arrow.r Y_bullet$ is called a #strong[quasi-isomorphism]#index-entry("Quasi-isomorphism") if $H_n\(phi.alt\): H_n X arrow.r H_n Y$ are isomorphisms

]
#statement("Example")[
Consider

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X_bullet :$]),
node((1,0),[$0$]),
node((2,0),[$bb(Z)$]),
node((3,0),[$bb(Z)$]),
node((4,0),[$0$]),
node((0,1),[$Y_bullet :$]),
node((1,1),[$0$]),
node((2,1),[$0$]),
node((3,1),[$bb(Z)\/5 bb(Z)$]),
node((4,1),[$0$]),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->",[$times 5$]),
edge((2,0),(2,1),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->",[$#h(0.444em) mod med 5$]),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
]
#statement("Definition")[
Pick $p in bb(Z)$, define the #strong[translation]#index-entry("Translation of a chain complex") of $X$ by $p$ is $X_bullet\[p\]$ where $\(X_bullet\[p\]\)_n = X_(p + n)$, differential $X_bullet\[p\]_n arrow.r X_bullet\[p\]_(n - 1)$ is given by $\(- 1\)^p partial$ The #strong[translation functor] $T : C h\(cal(A)\)arrow.r C h\(cal(A)\)$, $X mapsto X_bullet\[1\]$ is an auto morphism of $C h\(cal(A)\)$

]
#statement("Example")[
Suppose $X$ is a topological space, $R$ is a ring, $C_(*)^(upright(s i n g))\(X\)$ is the singular chain complex, $Sigma X$ is the suspension of $X$, we have the Freudenthal theorem $H^k\(Sigma X\)tilde.equiv H^(k - 1)\(X\)$ for $k > 0$

]
#statement("Definition")[
Pick $p in bb(Z)$, define the #strong[truncation]#index-entry("Truncation of a chain complex") of $X$ at $p$ is $tau_(gt.eq p) X$, where $\(tau_(gt.eq p) X\)_k = cases(0\,quad k < p, Z_p X\,quad k = p, X_k\,quad k > p)$, and define the cokernel of $tau_(gt.eq p) X arrow.r X$ to be $tau_(< p) X$. We get the #strong[truncation functors] $tau_(gt.eq p) X arrow.r X$ and $X arrow.r tau_(< p) X$ Moreover, $H_(*) : tau_(gt.eq p) X arrow.r X$ induce isomorphisms for $k gt.eq p$ and zero maps for $k < p$, $H_(*) : X arrow.r tau_(< p) X$ induce isomorphisms for $k < p$ and zero maps for $k gt.eq p$

]
#statement("Example")[
Consider $p = 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X_2$]),
node((1,0),[$X_1$]),
node((2,0),[$Z_0 X$]),
node((3,0),[$0$]),
node((4,0),[$0$]),
node((0,1),[$X_2$]),
node((1,1),[$X_1$]),
node((2,1),[$X_0$]),
node((3,1),[$X_(- 1)$]),
node((4,1),[$X_(- 2)$]),
node((0,2),[$0$]),
node((1,2),[$0$]),
node((2,2),[$X_0\/Z_0$]),
node((3,2),[$X_(- 1)$]),
node((4,2),[$X_(- 2)$]),
edge((0,0),(0,1),"="),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"="),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"hook->"),
edge((2,0),(3,0),"->"),
edge((3,0),(3,1),"->"),
edge((3,0),(4,0),"->"),
edge((4,0),(4,1),"->"),
edge((0,1),(1,1),"->"),
edge((0,1),(0,2),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->>"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"="),
edge((4,1),(4,2),"="),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((2,2),(3,2),"->"),
edge((3,2),(4,2),"->"))]
]
]
#pagebreak(weak:true)
== Arrow category - 2/14/2020
<arrow-category---2142020>
#statement("Definition")[
A chain complex of #strong[amplitude]#index-entry("Amplitude of a chain complex") $\[p\,q\]$ are chains of the following form

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$X_q$]),
node((2,0),[$dots.h.c$]),
node((3,0),[$X_p$]),
node((4,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$d$]),
edge((2,0),(3,0),"->",[$d$]),
edge((3,0),(4,0),"->"))]
]
Let $C h_(\[p\,q\]) cal(C)$ denote the full subcategory of $C h cal(C)$ consist of chain complexes of amplitude $\[p\,q\]$

]
#statement("Definition")[
Suppose $cal(C)$ is a category, we can define the #strong[arrow category]#index-entry("Arrow category") $A r cal(C)$, where the objects are morphisms in $cal(C)$, and $H o m\(X arrow.r^f Y\,Z arrow.r^g W\)$ consists of commutative diagrams

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
node((0,1),[$Z$]),
node((1,1),[$W$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(0,1),"->",[$u$]),
edge((1,0),(1,1),"->",[$v$]),
edge((0,1),(1,1),"->",[$g$]))]
]
Equivalently, $A r cal(C) = C h_(\[0\,1\]) cal(C)$

]
#statement("Lemma")[
Suppose $cal(A)$ is an abelian category, then $ker\,upright(c o k e r) : A r cal(A) arrow.r cal(A)$ are two functors given by the following diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$ker f$]),
node((1,0),[$X$]),
node((2,0),[$Y$]),
node((3,0),[$upright(c o k e r) f$]),
node((0,1),[$ker g$]),
node((1,1),[$Z$]),
node((2,1),[$W$]),
node((3,1),[$upright(c o k e r) g$]),
edge((0,0),(1,0),"hook->"),
edge((0,0),(0,1),"->",[$u_(*)$]),
edge((1,0),(2,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$u$]),
edge((2,0),(3,0),"->>"),
edge((2,0),(2,1),"->",[$v$]),
edge((3,0),(3,1),"->",[$v_(*)$]),
edge((0,1),(1,1),"hook->"),
edge((1,1),(2,1),"->",[$g$]),
edge((2,1),(3,1),"->>"))]
]
Let $F_1 : cal(A) arrow.r A r cal(A)$, $X mapsto 0 arrow.r X arrow.r 0$, where $X$ is of degree $1$, $F_0 : cal(A) arrow.r A r cal(A)$, $X mapsto 0 arrow.r X arrow.r 0$, where $X$ is of degree $0$. Then $ker$ is the right adjoint to $F_1$ and $upright(c o k e r)$ is the left adjoint to $F_0$

]
#proof(title: "Proof")[

]
#pagebreak(weak:true)
== Chain homotopy - 2/17/2020
<chain-homotopy---2172020>
#statement("Lemma", title: [Snake lemma])[
#index-entry("Snake lemma") Given the following commutative diagram with exact rows, then we have an exact sequence

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$ker a$]),
node((2,0),[$ker b$]),
node((3,0),[$ker c$]),
node((0,1),[$0$]),
node((1,1),[$A$]),
node((2,1),[$B$]),
node((3,1),[$C$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$A'$]),
node((2,2),[$B'$]),
node((3,2),[$C'$]),
node((4,2),[$0$]),
node((1,3),[$upright(c o k e r) a$]),
node((2,3),[$upright(c o k e r) b$]),
node((3,3),[$upright(c o k e r) c$]),
node((4,3),[$0$]),
edge((0,0),(1,0),"->",stroke:(dash:"dashed")),
edge((1,0),(2,0),"->",[$u_(*)$]),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->",[$v_(*)$]),
edge((2,0),(2,1),"->"),
edge((3,0),(1,3),"->",[$delta$],stroke:(dash:"dashed")),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->",stroke:(dash:"dashed")),
edge((1,1),(2,1),"->",[$u$]),
edge((1,1),(1,2),"->",[$a$]),
edge((2,1),(3,1),"->",[$v$]),
edge((2,1),(2,2),"->",[$b$]),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->",[$c$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$u'$]),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->",[$v'$]),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->",stroke:(dash:"dashed")),
edge((3,2),(3,3),"->"),
edge((1,3),(2,3),"->",[$u'_(*)$]),
edge((2,3),(3,3),"->",[$v'_(*)$]),
edge((3,3),(4,3),"->",stroke:(dash:"dashed")))]
]
]#label("Snake lemma")
#proof(title: "Proof")[

]
#statement("Lemma")[
$0 arrow.r A_bullet arrow.r B_bullet arrow.r C_bullet arrow.r 0$ is exact iff $0 arrow.r A_n arrow.r B_n arrow.r C_n arrow.r 0$ are exact

]
#proof(title: "Proof")[

]
#statement("Theorem")[
Suppose $0 arrow.r A_bullet arrow.r B_bullet arrow.r C_bullet arrow.r 0$ is exact, then we have $partial : H_n C arrow.r H_(n - 1) A$ yielding a long exact sequence #math.equation(block: true, numbering: none, $dots.h.c arrow.r H_n A arrow.r H_n B arrow.r H_n C arrow.r^partial H_(n - 1) A arrow.r H_(n - 1) B arrow.r H_(n - 1) C arrow.r dots.h.c$)

]
#proof(title: "Proof")[
Fisrtly, by Lemma #ref(label("Snake lemma"), supplement: none), we have

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$Z_n A$]),
node((2,0),[$Z_n B$]),
node((3,0),[$Z_n C$]),
node((0,1),[$0$]),
node((1,1),[$A_n$]),
node((2,1),[$B_n$]),
node((3,1),[$C_n$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$A_(n - 1)$]),
node((2,2),[$B_(n - 1)$]),
node((3,2),[$C_(n - 1)$]),
node((4,2),[$0$]),
node((1,3),[$A_n\/partial A_(n - 1)$]),
node((2,3),[$B_n\/partial B_(n - 1)$]),
node((3,3),[$C_n\/partial C_(n - 1)$]),
node((4,3),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((1,3),(2,3),"->"),
edge((2,3),(3,3),"->"),
edge((3,3),(4,3),"->"))]
]
Then apply Lemma #ref(label("Snake lemma"), supplement: none) again, we get

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$H_n A$]),
node((2,0),[$H_n B$]),
node((3,0),[$H_n C$]),
node((1,1),[$A_n\/partial A_(n + 1)$]),
node((2,1),[$B_n\/partial B_(n + 1)$]),
node((3,1),[$C_n\/partial C_(n + 1)$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$A_(n - 1)$]),
node((2,2),[$B_(n - 1)$]),
node((3,2),[$C_(n - 1)$]),
node((1,3),[$H_(n - 1) A$]),
node((2,3),[$H_(n - 1) B$]),
node((3,3),[$H_(n - 1) C$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((3,0),(1,3),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(3,3),"->"),
edge((1,3),(2,3),"->"),
edge((2,3),(3,3),"->"))]
]

]
#statement("Lemma", title: [Five lemma])[
If $b$ and $d$ are monic and $a$ is an epi, then $c$ is monic. Dually, if $b$ and $d$ are epis and $e$ is monic, then $c$ is an epi. In particular, if $a\,b\,d$ and $e$ are iso, then $c$ is also an iso

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A'$]),
node((1,0),[$B'$]),
node((2,0),[$C'$]),
node((3,0),[$D'$]),
node((4,0),[$E'$]),
node((0,1),[$A$]),
node((1,1),[$B$]),
node((2,1),[$C$]),
node((3,1),[$D$]),
node((4,1),[$E$]),
edge((0,0),(1,0),"->",[$u'$]),
edge((0,0),(0,1),"->",[$a$ \ $tilde.equiv$]),
edge((1,0),(2,0),"->",[$v'$]),
edge((1,0),(1,1),"->",[$b$ \ $tilde.equiv$]),
edge((2,0),(3,0),"->",[$w'$]),
edge((2,0),(2,1),"->",[$c$]),
edge((3,0),(4,0),"->",[$x'$]),
edge((3,0),(3,1),"->",[$d$ \ $tilde.equiv$]),
edge((4,0),(4,1),"->",[$e$ \ $tilde.equiv$]),
edge((0,1),(1,1),"->",[$u$]),
edge((1,1),(2,1),"->",[$v$]),
edge((2,1),(3,1),"->",[$w$]),
edge((3,1),(4,1),"->",[$x$]))]
]
]#label("Five lemma")
#statement("Definition")[
We can define a full subcategory $S\(cal(A)\)$ of short exact sequences, or equivalently just $C h_(\[0\,2\]) cal(A)$, and define a full subcategory $L\(cal(A)\)$ of long exact sequences

]
#statement("Lemma")[
$H$ gives a functor $S\(C h cal(A)\)arrow.r L\(cal(A)\)$, sending $0 arrow.r A_bullet arrow.r B_bullet arrow.r C_bullet arrow.r 0$ to its long exact sequence

]
#proof(title: "Proof")[

]
#statement("Definition")[
$cal(A)$ is an abelian category. $X_bullet\,Y_bullet in C h cal(A)$, define a complex $"Hom"_bullet\(X_bullet\,Y_bullet\)in C h cal(A) b$ as follows: for each $k in bb(Z)$, $"Hom"_k\(X_bullet\,Y_bullet\)= product_(n in bb(Z)) "Hom"\(X_n\,Y_(k + n)\)$, and $d\(f_n : X_n arrow.r Y_(n + k)\)_(n in bb(Z)) =\(g_n : X_n arrow.r Y_(n + k - 1)\)_(n in bb(Z))$ where $g_n = partial f_n -\(- 1\)^k f_(n - 1) partial$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X_(n + 1)$]),
node((1,0),[$X_n$]),
node((2,0),[$X_(n - 1)$]),
node((3,0),[$X_(n - 2)$]),
node((0,1),[$Y_(n + k + 1)$]),
node((1,1),[$Y_(n + k)$]),
node((2,1),[$Y_(n + k - 1)$]),
node((3,1),[$Y_(n + k - 2)$]),
edge((0,0),(0,1),"->",[$f$]),
edge((0,0),(1,0),"->",[$partial$]),
edge((0,0),(1,1),"->",[$g$]),
edge((1,0),(2,0),"->",[$partial$]),
edge((1,0),(1,1),"->",[$f_n$]),
edge((1,0),(2,1),"->",[$g_n$]),
edge((2,0),(3,0),"->",[$partial$]),
edge((2,0),(2,1),"->",[$f_(n - 1)$]),
edge((2,0),(3,1),"->",[$g$]),
edge((3,0),(3,1),"->",[$f$]),
edge((0,1),(1,1),"->",[$partial$]),
edge((1,1),(2,1),"->",[$partial$]),
edge((2,1),(3,1),"->",[$partial$]))]
]
$"Hom"_bullet\(X_bullet\,Y_bullet\)$ is a chain complex since for any $f in "Hom"_k\(X_bullet\,Y_bullet\)$ #math.equation(block: true, numbering: none, $d^2 f & = d\(partial f -\(- 1\)^k f partial\)\
 & = partial\(partial f -\(- 1\)^k f partial\)+\(- 1\)^(k - 1)\(partial f -\(- 1\)^k f partial\)partial\
 & = partial^2 f -\(- 1\)^k partial f partial +\(- 1\)^k partial f partial +\(- 1\)^k f partial^2\
 & = 0$) If $f in "Hom"_0\(X_bullet\,Y_bullet\)$, then $d f = partial f - f partial = 0 arrow.l.r.double f in "Hom"\(X_bullet\,Y_bullet\)$, i.e. $"Hom"\(X_bullet\,Y_bullet\)= Z_0\("Hom"_bullet\(X_bullet\,Y_bullet\)\)$, $f in B_0 "Hom"_bullet\(X_bullet\,Y_bullet\)arrow.l.r.double f - 0 = f = d s = partial s + s partial$. i.e. $f$ is chain homotopy equivalent to $0$. Therefore we define the #strong[chain homotopy]#index-entry("Chain homotopy") classes of morphisms from $X_bullet arrow.r Y_bullet$ to be $H_0\("Hom"\(X_bullet\,Y_bullet\)\)$

]
#pagebreak(weak:true)
== Chain homotopy category - 2/19/2020
<chain-homotopy-category---2192020>
#statement("Definition")[
Suppose $cal(A)$ is an abelian category, define $K\(cal(A)\)$ to be the #strong[homotopy category]#index-entry("Homotopy category") with $o b K\(cal(A)\)= o b C h\(cal(A)\)$, $H o m_(K\(cal(A)\))\(X_bullet\,Y_bullet\)= H_0\(H o m_bullet\(X_bullet\,Y_bullet\)\)$

]
#statement("Definition")[
Suppose $f : X_(*) arrow.r Y_(*)$ is chain map, then the #strong[mapping cone]#index-entry("Mapping cone") of $f$ is defined to be the object $C\(f\)$ in $C h\(cal(A)\)$ with $C\(f\)_n = X_(n - 1) xor Y_n$, $d_(C\(f\)) = mat(delim: "(", - d_X, 0; - f, d_Y)$, note that $d_(C\(f\))^2 = mat(delim: "(", - d_X, 0; - f, d_Y) mat(delim: "(", - d_X, 0; - f, d_Y) = mat(delim: "(", d_X^2, 0; f d_X - d_Y f, d_Y^2) = mat(delim: "(", 0, 0; 0, 0)$

]
#statement("Lemma")[
We have a short exact sequence

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((2,0),[$\(x\,y\)$]),
node((3,0),[$x$]),
node((0,1),[$0$]),
node((1,1),[$Y$]),
node((2,1),[$C\(f\)$]),
node((3,1),[$X\[- 1\]$]),
node((4,1),[$0$]),
node((1,2),[$y$]),
node((2,2),[$\(0\,y\)$]),
edge((2,0),(3,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"),
edge((1,2),(2,2),"->"))]
]
]
#statement("Remark")[
If $f : X_(*) arrow.r 0$ is the zero morphism, then $C\(f\)= X\[- 1\]$

]
#proof(title: "Proof")[

]
#statement("Corollary")[
$f : X_(*) arrow.r Y_(*)$ is a quasi-isomorphism $arrow.l.r.double$ $C\(f\)$ is exact

]
#pagebreak(weak:true)
== Freyd-Mitchell embedding - 2/21/2020
<freyd-mitchell-embedding---2212020>
#statement("Theorem")[
We have a homology functor $H_(*) : K\(cal(A)\)arrow.r cal(A)$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$C h\(cal(A)\)$]),
node((1,0),[$cal(A)$]),
node((0,1),[$K\(cal(A)\)$]),
edge((0,0),(1,0),"->",[$H_(*)$]),
edge((0,0),(0,1),"->"),
edge((0,1),(1,0),"->",[$H_(*)$]))]
]
]
#statement("Theorem", title: [Freyd-Mitchell embedding theorem])[
Suppose $cal(A)$ is a small abelian category, then there exists a ring $R$ and a fully faithful embedding $cal(A) arrow.r R$-$m o d$, i.e. $cal(A)$ embeds in $R$-$m o d$ as a full subcategory. Moreover, the embedding is an exact functor

]
#statement("Lemma")[
Suppose $cal(A)$ is an abelian category, $cal(C)$ is a subcategory, then

#strong[\(1)] $cal(C)$ is additive $arrow.l.r.double$ if $cal(C)$ is closed under direct sum, including $0$

#strong[\(2)] $cal(C)$ is abelian and $cal(C) arrow.r.hook cal(A)$ is exact $arrow.l.r.double$ $cal(C)$ is additive and contain kernels, cokernels

]
#proof(title: "Proof")[

]
#statement("Definition")[
Suppose $cal(A)\,cal(B)$ are abelian categories, a covariant homological $bold(delta)$ #strong[functor]#index-entry("\\delta functor") is a family of functors $T_n : cal(A) arrow.r cal(B)$ and for each short exact sequence $0 arrow.r A arrow.r^u B arrow.r^v C arrow.r 0$, a family of morphisms $delta_n : T_n C arrow.r T_(n - 1) A$ which induces a long exact sequence

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$dots.h.c arrow.r T_n\(A\)arrow.r^(u_n) T_n\(B\)arrow.r^(v_n) T_n\(C\)arrow.r^(delta_n) T_(n - 1)\(A\)arrow.r dots.h.c$]),
)]
]
And any chain map

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$A$]),
node((2,0),[$B$]),
node((3,0),[$C$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$A'$]),
node((2,1),[$B'$]),
node((3,1),[$C'$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
The following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$T_n\(C\)$]),
node((1,0),[$T_(n - 1)\(A\)$]),
node((0,1),[$T_n\(C'\)$]),
node((1,1),[$T_(n - 1)\(A'\)$]),
edge((0,0),(0,1),"->"),
edge((0,0),(1,0),"->",[$delta_n$]),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->",[$delta_n$]))]
]
Similarly, we can define covariant cohomological $delta$ functors

]
#statement("Example")[
$H_n : C h_bullet\(cal(A)\)arrow.r cal(A)$, $C_(*) mapsto H_n\(C\)$, $delta = partial$ is a homological $delta$ functor, $H^n : C h^bullet\(cal(A)\)arrow.r cal(A)$, $C^(*) mapsto H^n\(C\)$, $delta = d$ is a cohomological $delta$ functor

]
#statement("Example")[
Let $cal(A) b$ be the category of abelian groups, define functors $T_1 : cal(A) b arrow.r cal(A) b$, $A mapsto A_p$, where $A_p$ is $ker\(A arrow.r^(times p) A\)$ is the $p$ torsion of $A$, and $T_0 : cal(A) b arrow.r cal(A) b$, $A mapsto A\/p A$, where $A\/p A = upright(c o k e r)\(A arrow.r^(times p) A\)$. For a short exact sequence $0 arrow.r A arrow.r B arrow.r C arrow.r 0$, by Snake Lemma #ref(label("Snake lemma"), supplement: none), we have long exact sequence #math.equation(block: true, numbering: none, $0 arrow.r T_1 A arrow.r T_1 B arrow.r T_1 C arrow.r^(delta_1) T_0 A arrow.r T_0 B arrow.r T_0 C arrow.r 0$)

]
#statement("Definition")[
A morphism between delta functors ${ S_i }$, ${ T_i }$ is a sequence of natural transformations $eta_n : S_n arrow.r T_n$ commuting with $delta$, i.e.

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$dots.h.c$]),
node((1,0),[$S_n A$]),
node((2,0),[$S_n B$]),
node((3,0),[$S_n C$]),
node((4,0),[$S_(n - 1) A$]),
node((5,0),[$dots.h.c$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$T_n A$]),
node((2,1),[$T_n B$]),
node((3,1),[$T_n C$]),
node((4,1),[$T_(n - 1) A$]),
node((5,1),[$dots.h.c$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$S_n u$]),
edge((1,0),(1,1),"->",[$eta$]),
edge((2,0),(3,0),"->",[$S_n v$]),
edge((2,0),(2,1),"->",[$eta$]),
edge((3,0),(4,0),"->",[$delta_S$]),
edge((3,0),(3,1),"->",[$eta$]),
edge((4,0),(5,0),"->"),
edge((4,0),(4,1),"->",[$eta$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$T_n u$]),
edge((2,1),(3,1),"->",[$T_n v$]),
edge((3,1),(4,1),"->",[$delta_T$]),
edge((4,1),(5,1),"->"))]
]
Therefore we get a category of homological $delta$ functors

]
#statement("Definition")[
A $delta$ functor ${ T_n }$ is called #strong[universal]#index-entry("Universal \\delta functor") if for any $delta$ functor ${ S_n }$, given a natural transformation $eta_0 : S_0 arrow.r T_0$, this can be uniquely extended to $eta_n : S_n arrow.r T_n$ up to isomorphism, in other words, ${ T_n }$ is a final object in the category of homological $delta$ functors

]
#pagebreak(weak:true)
== Resolutions - 2/24/2020
<resolutions---2242020>
#statement("Definition")[
Suppose $cal(C)$ is an abelian category, $P$ is #strong[projective]#index-entry("Projective object") if functor $H o m\(P\,-\): cal(C) arrow.r S e t s$ sends epi to epi, or equivalently

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$P$]),
node((0,1),[$X$]),
node((1,1),[$Y$]),
edge((1,0),(1,1),"->",[$g$]),
edge((1,0),(0,1),"->",[$exists h$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->>",[$f$]))]
]
$I$ is #strong[injective]#index-entry("Injective object") if functor $H o m\(-\,Q\): cal(C) arrow.r S e t s$ sends mono to epi, or equivalently

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
node((0,1),[$Q$]),
edge((0,0),(1,0),"hook->",[$f$]),
edge((0,0),(0,1),"->",[$g$]),
edge((1,0),(0,1),"->",[$exists h$],stroke:(dash:"dashed")))]
]
]
#statement("Lemma")[
Coproduct of projective objects is projective, product of injective objects is injective

]#label("Coproduct of projetives is projective, product of injectives is injective")
#proof(title: "Proof")[
Suppose $I_alpha$ are injective, $A arrow.r.hook B$ is a monomorphism, we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m\(B\,product I_alpha\)$]),
node((1,0),[$H o m\(A\,product I_alpha\)$]),
node((0,1),[$product H o m\(B\,I_alpha\)$]),
node((1,1),[$product H o m\(A\,I_alpha\)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->"))]
]

]
#statement("Definition")[
$cal(C)$ has #strong[enough projectives] if for any $X$, there is an epi $P arrow.r X$ from a projective object, $cal(C)$ has #strong[enough injectives] if for any $X$, there is a mono $X arrow.r Q$ to an injective object

]
#statement("Lemma")[
Suppose $cal(A)$ is an abelian category, $H o m\(P\,-\)$, $H o m\(-\,I\)$ are left exact. We have

#align(center)[
$P$ is projective $arrow.l.r.double$ $H o m\(P\,-\)$ is right exact $arrow.l.r.double$ $H o m\(P\,-\)$ is exact

]
#align(center)[
$I$ is injective $arrow.l.r.double$ $H o m\(-\,I\)$ is right exact $arrow.l.r.double$ $H o m\(-\,I\)$ is exact

]
]
#proof(title: "Proof")[

]
#statement("Remark")[
It is obvious that $A arrow.r B arrow.r C arrow.r 0$ is exact iff $0 arrow.r H o m\(C\,D\)arrow.r H o m\(B\,D\)arrow.r H o m\(A\,D\)$ is exact for all $D$, $0 arrow.r A arrow.r B arrow.r C$ is exact iff $0 arrow.r H o m\(D\,A\)arrow.r H o m\(D\,B\)arrow.r H o m\(D\,C\)$ is exact for all $D$

]
#statement("Lemma")[
Functors between abelian categories $F : cal(A) arrow.r cal(B)$, $G : cal(B) arrow.r cal(A)$ is an adjoint pair. If $F$ is left exact, then $G$ preserves injectives. If $G$ is right exact, then $F$ preserves projectives

]#label("Left adjoint to exact functor preserves projectives")
#proof(title: "Proof")[
#align(center)[
$H o m_(cal(B))\(-\,G\(I\)\)$ is right exact $arrow.l.r.double$ $H o m_(cal(A))\(F\(-\)\,I\)= H o m_(cal(A))\(-\,I\)compose F$ is right exact

]
#align(center)[
$H o m_(cal(B))\(F\(P\)\,-\)$ is right exact $arrow.l.r.double$ $H o m_(cal(A))\(P\,G\(-\)\)= H o m_(cal(A))\(P\,-\)compose G$ is right exact

]

]
#statement("Lemma")[
An $R$ module $M$ is projective iff $M$ is a direct summand of a free module

]
#proof(title: "Proof")[

]
#statement("Definition")[
Exact sequence $C_bullet$ #strong[split]#index-entry("Split") at if there are $s_n : C_n arrow.r C_(n + 1)$ such that $partial_(n + 1) s_n partial_(n + 1) = partial_(n + 1)$

]
#statement("Lemma")[
Let $C$ be a chain complex, with boundaries $B_n$ and cycles $Z_n$ in $C_n$. $C$ splits if and only if there are $R$-module decompositions $C_n tilde.equiv Z_n xor B'_n$ and $Z_n tilde.equiv B_n xor H'_n$. $C$ is split exact iff $H'_n = 0$

]#label("Equivalent conditions for split and split exact")
#proof(title: "Proof")[
If $C_n tilde.equiv Z_n xor B'_n$ and $Z_n tilde.equiv B_n xor H'_n$, claim that any element in $B_n$ has a unique preimage in $B'_(n + 1)$: if $x\,y in B'_(n + 1)$ are such that $partial_(n + 1) x = partial_(n + 1) y$, then $partial_(n + 1)\(x - y\)= 0 arrow.r.double\(x - y\)in Z_(n + 1) inter B'_(n + 1) = 0 arrow.r.double x = y$

Hence we can define a unique bijective homomorphism $s_n : B_n arrow.r B'_(n + 1)$ sending elements to its preimage, then extend $s_n$ to $s_n : C_n arrow.r C_(n + 1)$ such that $s_n\(C_n\)= B'_(n + 1)$, $s_n\(H'_n xor B'_n\)= 0$, then $partial_(n + 1) s_n partial_(n + 1) = partial_(n + 1)$, i.e. $C$ split

If $C$ split, denote $B'_n = s_(n - 1) partial_n\(C_n\)$, $H'_n = ker partial_(n + 1) s_n inter Z_n$, we claim $C_n = Z_n xor B'_n$ and $Z_n = B_n xor H'_n$: For any $s_(n - 1) partial_n\(a_n\)in Z_n$, $0 = partial_n\(s_(n - 1) partial_n\(a_n\)\)= partial_n a_n arrow.r.double s_(n - 1) partial_n\(a_n\)= 0$. For $a_n in C_n$, $partial_n\(a_n - s_(n - 1) partial_n\(a_n\)\)= 0$. For any $partial_(n + 1) a_(n + 1) in ker partial_(n + 1) s_n$, $partial_(n + 1)\(a_(n + 1)\)= partial_(n + 1) s_n partial_(n + 1)\(a_(n + 1)\)= 0$. For any $a_n in Z_n$, $a_n - partial_(n + 1) s_n\(a_n\)in ker partial_(n + 1) s_n inter Z_n$

It is obvious that $C$ is exact $arrow.l.r.double$ $Z_n tilde.equiv B_n arrow.l.r.double H'_n = 0$

]
#statement("Lemma")[
$C_bullet$ split iff $1_C tilde.eq 0$

]#label("Splic iff nullhomotopic")
#proof(title: "Proof")[
Suppose the identity map on $C$ is null homotopic, then there exists $s_n : C_n arrow.r C_(n + 1)$ such that $1_(C_n) = s_(n - 1) partial_n + partial_(n + 1) s_n$, then $partial_n = partial_n s_(n - 1) partial_n$, i.e. $C$ split, for any $a_n in Z_n$, $a_n =\(s_(n - 1) partial_n + partial_(n + 1) s_n\)a_n = partial_(n + 1)\(s_n a_n\)in B_n$, i.e. $C$ is exact

Suppose $C$ split exact, according to exercise 1.4.2, $C_n tilde.equiv Z_n xor B'_n tilde.equiv B_n xor B'_n$ with $H'_n = 0$, then we can define $s_n : C_n arrow.r C_(n + 1)$ such that $s_n\(B_n\)= B'_(n + 1)$ bijective, $s_n\(H'_n xor B'_n\)= 0$, $partial_(n + 1) s_n partial_(n + 1) = partial_(n + 1)$, thus $B'_n = s_(n - 1)\(B_n\)= s_(n - 1) partial_n\(C_n\)$, $s_n s_(n - 1) partial_n\(C_n\)= s_n\(B'_n\)= 0$. Therefore for any element in $C_n$ which can be written as $partial_(n + 1) a_(n + 1) + s_(n - 1) partial_n a_n$, we have $\(s_(n - 1) partial_n + partial_(n + 1) s_n\)\(partial_(n + 1) a_(n + 1) + s_(n - 1) partial_n a_n\)= partial_(n + 1) a_(n + 1) + s_(n - 1) partial_n a_n$, i.e. $1_(C_n) = s_(n - 1) partial_n + partial_(n + 1) s_n$, the identity map on $C$ is nullhomotopic

]
#statement("Lemma")[
$P_bullet$ is a projective in $C h\(cal(A)\)$ iff $P_bullet$ is a split exact sequence of projectives. \[Hint: To see that $P$ must be split exact, consider the surjection from $c o n e\(upright(i d)_P\)$ to $P\[- 1\]$. To see that split exact complexes are projective objects, consider the special case $0 arrow.r P_1 tilde.equiv P_0 arrow.r 0$\]

]
#proof(title: "Proof")[
Consider chain complex $C$ with $C_n = P_n xor P_(n + 1)$ #math.equation(block: true, numbering: none, $dots.h.c arrow.r P_n xor P_(n + 1) arrow.r^(mat(delim: "(", partial, 0; 1, - partial)) P_(n - 1) xor P_n arrow.r dots.h.c$) and first coordinate projection

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$C$]),
node((1,0),[$P$]),
edge((0,0),(1,0),"->>"))]
which is a surjection, if $P$ is projective, then there exists $s$ such that

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$P$]),
node((0,1),[$C$]),
node((1,1),[$P$]),
edge((1,0),(0,1),"->",[$s$]),
edge((1,0),(1,1),"="),
edge((0,1),(1,1),"->>"))]
]
In order to make $s$ a chain map and the diagram commute, we must have $s : P_n arrow.r C_n$, $x arrow.r vec(x, s_n x)$ and #math.equation(block: true, numbering: none, $vec(partial_n x, s_(n - 1) partial_n x) = mat(delim: "(", partial_n, 0; 1, - partial_(n + 1)) vec(x, s_n x) = vec(partial_n x, x - partial_(n + 1) s_n x)$) Hence $s_(n - 1) partial_n + partial_(n + 1) s_n = 1$, by Lemma #ref(label("Splic iff nullhomotopic"), supplement: none), $P$ split exact

To prove $P_n$ are projectives, given

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$P_n$]),
node((0,1),[$B$]),
node((1,1),[$A$]),
edge((1,0),(1,1),"->",[$g_n$]),
edge((0,1),(1,1),"->>",[$f$]))]
]
consider the following commutative diagram with $g_(n + 1) = g_n partial_(n + 1)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$P_(n + 2)$]),
node((1,0),[$P_(n + 1)$]),
node((2,0),[$P_n$]),
node((3,0),[$P_(n - 1)$]),
node((0,1),[$0$]),
node((1,1),[$A$]),
node((2,1),[$A$]),
node((3,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$B$]),
node((2,2),[$B$]),
node((3,2),[$0$]),
edge((0,0),(1,0),"->",[$partial_(n + 2)$]),
edge((0,0),(0,1),"->"),
edge((1,0),(2,0),"->",[$partial_(n + 1)$]),
edge((1,0),(1,1),"->",[$g_(n + 1)$]),
edge((2,0),(3,0),"->",[$partial_n$]),
edge((2,0),(2,1),"->",[$g_n$]),
edge((2,0),(2,2),"->",[$h$],stroke:(dash:"dashed"),bend:15deg),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"="),
edge((2,1),(3,1),"->"),
edge((0,2),(1,2),"->"),
edge((0,2),(0,1),"->"),
edge((1,2),(1,1),"->>",[$f$]),
edge((1,2),(2,2),"="),
edge((2,2),(2,1),"->>",[$f$]),
edge((2,2),(3,2),"->"),
edge((3,2),(3,1),"->"))]
]
Since $P_bullet$ is projective, there exists $h : P_n arrow.r B$ such that $f h = g_n$

Conversely, suppose $P$ is a split exact sequence of projectives, by Lemma #ref(label("Equivalent conditions for split and split exact"), supplement: none), there exist bijection $s_n : Z_n = B_n arrow.r B'_(n + 1)$ and $P_n tilde.equiv B_n xor B'_n$, thus $P$ is the direct sum of $0 arrow.r B'_(n + 1) arrow.r B_n arrow.r 0$, and we know the coproducts and direct summands of projective modules are projective, it suffices to consider $0 arrow.r P_1 arrow.r^tilde.equiv P_0 arrow.r 0$. Since $psi_1$ is epi and $P_1$ is projective, there exists $P_1 arrow.r^(phi.alt_1) B_1$ such that $xi_1 = psi_1 phi.alt_1$, let $phi.alt_0 = b_1 phi.alt_1 p_1^(- 1)$, then $xi_0 = a_1 xi_1 p_1^(- 1) = a_1 psi_1 phi.alt_1 p_1^(- 1) = psi_0 b_1 phi.alt_1 p_1^(- 1) = psi_0 phi.alt_0$ and $b_0 phi.alt_0 = b_0 b_1 phi.alt_1 p_1^(- 1) = 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$P_1$]),
node((2,0),[$P_0$]),
node((3,0),[$0$]),
node((0,1),[$B_2$]),
node((1,1),[$B_1$]),
node((2,1),[$B_0$]),
node((3,1),[$B_(- 1)$]),
node((0,2),[$A_2$]),
node((1,2),[$A_1$]),
node((2,2),[$A_0$]),
node((3,2),[$A_(- 1)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->"),
edge((1,0),(2,0),"->",[$p_1$ \ $tilde.equiv$]),
edge((1,0),(1,1),"->",[$phi.alt_1$],stroke:(dash:"dashed")),
edge((1,0),(1,2),"->",[$xi_1$],bend:-15deg),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$phi.alt_0$],stroke:(dash:"dashed")),
edge((2,0),(2,2),"->",[$xi_0$],bend:15deg),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((0,1),(0,2),"->>",[$psi_2$]),
edge((1,1),(2,1),"->",[$b_1$]),
edge((1,1),(1,2),"->>",[$psi_1$]),
edge((2,1),(3,1),"->",[$b_0$]),
edge((2,1),(2,2),"->>",[$psi_0$]),
edge((3,1),(3,2),"->>",[$psi_(- 1)$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$a_1$]),
edge((2,2),(3,2),"->"))]
]

]
#statement("Definition")[
A #strong[left resolution]#index-entry("resolution") is morphism $P_bullet arrow.r^epsilon M$ in $C h_(gt.eq 0)\(cal(A)\)$, here $M$ means $0 arrow.r M arrow.r 0$ with $M$ at degree $0$, then $dots.h.c arrow.r P_2 arrow.r P_1 arrow.r P_0 arrow.r^epsilon M arrow.r 0$ is exact. A projective resolution is a left resolution with projectives, an injective resolution is a right resolution with injectives

]
#statement("Lemma")[
If $cal(A)$ has enough projectives, then for any $M$, there is a projective resolution $P_bullet arrow.r^epsilon M$

]
#proof(title: "Proof")[
First there exists exact sequence $0 arrow.r ker epsilon arrow.r^(i_0) P_0 arrow.r^epsilon M arrow.r 0$ where $P_0$ is a projective, then there exists another exact sequence $0 arrow.r ker i_0 arrow.r P_1 arrow.r ker epsilon arrow.r 0$ where $P_1$ is a projective, then we can splice them to get exact sequence $P_1 arrow.r P_0 arrow.r^epsilon M arrow.r 0$, inductively we get a projective resolution

]
#statement("Theorem", title: [Comparison theorem])[
Suppose $P_bullet arrow.r^epsilon M$ is a complex with $P_n$ projectives, $Q_bullet arrow.r^eta N$ is a left resolution, then for any $M arrow.r^f N$, it can be extend to chain map $f_bullet : P_bullet arrow.r Q_bullet$, and $f_bullet$ is unique up to homotopy

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$dots.h.c$]),
node((1,0),[$P_1$]),
node((2,0),[$P_0$]),
node((3,0),[$M$]),
node((4,0),[$0$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$Q_1$]),
node((2,1),[$Q_0$]),
node((3,1),[$N$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->",[$partial_2$]),
edge((1,0),(2,0),"->",[$partial_1$]),
edge((1,0),(1,1),"->",[$f_1$]),
edge((2,0),(3,0),"->",[$epsilon$]),
edge((2,0),(2,1),"->",[$f_0$]),
edge((3,0),(3,1),"->",[$f$]),
edge((3,0),(4,0),"->"),
edge((0,1),(1,1),"->",[$partial_2$]),
edge((1,1),(2,1),"->",[$partial_1$]),
edge((2,1),(3,1),"->",[$eta$]),
edge((3,1),(4,1),"->"))]
]
]#label("Comparison theorem")
#proof(title: "Proof")[
Since $P_0$ is projective, there exists $P_0 arrow.r^(f_0) Q_0$ such that $f epsilon = eta f_0$, then we have $eta f_0 partial_1 = f epsilon partial_1 = 0$, $f_0 partial_1 : P_1 arrow.r Z_0 Q$, and $Q_1 arrow.r^(partial_1) Z_0 Q$ is epi, we have $P_1 arrow.r^(f_1) Q_1$, inductively, we can extend $f$ to a chain map $f_bullet : P_bullet arrow.r Q_bullet$

Suppose $f = 0$, we need to show $f_bullet tilde.eq 0$, Write $P_(- 1) := M$, $Q_(- 1) := N$, $P_n = Q_n = 0\,forall n < - 1$, define $s_n : P_n arrow.r Q_(n + 1)\,forall n < 0$ to be zero. Since $eta f_0 = 0$, thus $f_0 : P_0 arrow.r Z_0 Q$, and $Q_1 arrow.r^(partial_1) Z_0 Q$ is epi, we get $P_0 arrow.r^(s_0) Q_1$ such that $f_0 = partial_1 s_0 = partial_1 s_0 + s_(- 1) partial_0$, then since $partial_1 f_1 = f_0 partial_1 = partial_1 s_0 partial_1 arrow.r.double f_1 - s_0 partial_1 : P_1 arrow.r Z_1 Q$, and $Q_2 arrow.r^(partial_2) Z_1 Q$ is epi, we get $s_1 : P_1 arrow.r Q_2$ such that $partial_2 s_1 = f_1 - s_0 partial_1$, inductively we construct a null homotopy $s_bullet$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$dots.h.c$]),
node((1,0),[$P_2$]),
node((2,0),[$P_1$]),
node((3,0),[$P_0$]),
node((4,0),[$M$]),
node((5,0),[$0$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$Q_2$]),
node((2,1),[$Q_1$]),
node((3,1),[$Q_0$]),
node((4,1),[$N$]),
node((5,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$partial_2$]),
edge((1,0),(1,1),"->",[$f_2$]),
edge((2,0),(3,0),"->",[$partial_1$]),
edge((2,0),(2,1),"->",[$f_1$]),
edge((2,0),(1,1),"->",[$s_1$]),
edge((3,0),(4,0),"->",[$epsilon$]),
edge((3,0),(3,1),"->",[$f_0$]),
edge((3,0),(2,1),"->",[$s_0$]),
edge((4,0),(4,1),"->",[$0$]),
edge((4,0),(5,0),"->"),
edge((4,0),(3,1),"->",[$0$]),
edge((5,0),(4,1),"->",[$0$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$partial_2$]),
edge((2,1),(3,1),"->",[$partial_1$]),
edge((3,1),(4,1),"->",[$eta$]),
edge((4,1),(5,1),"->"))]
]

]
#statement("Lemma", title: [Horseshoe lemma])[
Suppose $P_bullet arrow.r^epsilon M$, $Q_bullet arrow.r^eta N$ are projective resolutions, then any exact sequence $0 arrow.r M arrow.r^f A arrow.r^g N arrow.r 0$ can be extended into commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$0$]),
node((1,1),[$P_0$]),
node((2,1),[$P_1 xor Q_1$]),
node((3,1),[$Q_1$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$P_0$]),
node((2,2),[$P_0 xor Q_0$]),
node((3,2),[$Q_0$]),
node((4,2),[$0$]),
node((0,3),[$0$]),
node((1,3),[$M$]),
node((2,3),[$A$]),
node((3,3),[$N$]),
node((4,3),[$0$]),
node((1,4),[$0$]),
node((2,4),[$0$]),
node((3,4),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((0,3),(1,3),"->"),
edge((1,3),(2,3),"->",[$f$]),
edge((1,3),(1,4),"->"),
edge((2,3),(3,3),"->",[$g$]),
edge((2,3),(2,4),"->"),
edge((3,3),(4,3),"->"),
edge((3,3),(3,4),"->"))]
]
With $\(P xor Q\)_bullet$ being a projective resolution, every row and column are exact

]#label("Horseshoe lemma")
#proof(title: "Proof")[
Since $A arrow.r^g N$ is epi and $Q_0$ is projective, we get $Q_0 arrow.r^(s_0) A$ such that $g s_0 = partial_0$ which gives us $P_0 xor Q_0 arrow.r^(mat(delim: "(", f partial_0, s_0)) A$, by Lemma #ref(label("Snake lemma"), supplement: none), this is epi, and we get an exact sequence $0 arrow.r Z_0 P arrow.r ker i_0 arrow.r Z_0 Q arrow.r 0$, similarly, we can construct $Q_1 arrow.r^(s_1) ker i_0$, then $P_1 xor Q_1 arrow.r^(mat(delim: "(", iota_0 partial_0, s_1)) ker i_0$ is again epi by Lemma #ref(label("Snake lemma"), supplement: none), inductively, we can construct the commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$0$]),
node((1,1),[$P_1$]),
node((2,1),[$P_1 xor Q_1$]),
node((3,1),[$Q_1$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$Z_0 P$]),
node((2,2),[$ker i_0$]),
node((3,2),[$Z_0 Q$]),
node((4,2),[$0$]),
node((0,3),[$0$]),
node((1,3),[$P_0$]),
node((2,3),[$P_0 xor Q_0$]),
node((3,3),[$Q_0$]),
node((4,3),[$0$]),
node((0,4),[$0$]),
node((1,4),[$M$]),
node((2,4),[$A$]),
node((3,4),[$N$]),
node((4,4),[$0$]),
node((1,5),[$0$]),
node((2,5),[$0$]),
node((3,5),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(1,2),"->",[$partial_1$]),
edge((1,1),(2,1),"->"),
edge((2,1),(2,2),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(3,2),"->",[$partial_1$]),
edge((3,1),(4,1),"->"),
edge((3,1),(2,2),"->",[$s_1$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$iota_0$]),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((0,3),(1,3),"->"),
edge((1,3),(2,3),"->"),
edge((1,3),(1,4),"->",[$partial_0$]),
edge((2,3),(3,3),"->"),
edge((2,3),(2,4),"->",[$i_0$]),
edge((3,3),(4,3),"->"),
edge((3,3),(3,4),"->",[$partial_0$]),
edge((3,3),(2,4),"->",[$s_0$]),
edge((0,4),(1,4),"->"),
edge((1,4),(2,4),"->",[$f$]),
edge((1,4),(1,5),"->"),
edge((2,4),(3,4),"->",[$g$]),
edge((2,4),(2,5),"->"),
edge((3,4),(4,4),"->"),
edge((3,4),(3,5),"->"))]
]

]
#pagebreak(weak:true)
== Baer's criterion - 2/28/2020
<baers-criterion---2282020>
#statement("Theorem", title: [Baer's criterion])[
#index-entry("Baer’s criterion") A left $R$ module $E$ is injective in the category of left $R$ modules iff every left ideal homomorphism $phi.alt : I arrow.r E$ can be extended to a homomorphism $R arrow.r E$

]#label("Baer's criterion")
#proof(title: "Proof")[
If $E$ is injective, we can certainly extend $phi.alt : I arrow.r E$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$I$]),
node((1,0),[$R$]),
node((0,1),[$E$]),
edge((0,0),(1,0),"hook->"),
edge((0,0),(0,1),"->",[$phi.alt$]),
edge((1,0),(0,1),"->",stroke:(dash:"dashed")))]
]
Now suppose extension is always possible, $A arrow.r.hook B$ is a submodule, $alpha : A arrow.r E$ is a homomorphism, consider poset $Gamma := { A lt.eq C lt.eq B\,alpha_C : C arrow.r E }$, $\(C\,alpha_C\)lt.eq\(D\,alpha_D\)$ meaning $C lt.eq D$ and $alpha_D\|_C = alpha_C$, by Zorn's lemma, we can pick a maximal element $\(C\,alpha\)$, suppose $C lt.neq B$, there exists $b in B\\C$, consider $J = { r in R\|r b in C }$, we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$J$]),
node((1,0),[$C$]),
node((2,0),[$E$]),
node((1,1),[$R$]),
edge((0,0),(1,1),"hook->"),
edge((0,0),(1,0),"->",[$times b$]),
edge((1,0),(2,0),"->",[$alpha$]),
edge((1,1),(2,0),"->",[$f$],stroke:(dash:"dashed")))]
]
define $beta : C + chevron.l b chevron.r arrow.r E$, $c + r b mapsto alpha\(c\)+ f\(r\)$, contradicting the maximality

]
#statement("Definition")[
A left $R$ module $M$ is $r$ #strong[divisible]#index-entry("Divisible") if $M arrow.r^(times r) M$ is surjetive, $M$ is divisible if $M$ is $r$ divisible for any $0 eq.not r in R$

]
#statement("Corollary")[
Suppose $R$ is a PID, a left $R$ module $M$ is injective iff $M$ is divisible

]#label("Injective <=> Divisible")
#proof(title: "Proof")[
Suppose $M$ is injective, for any $0 eq.not r in R$, $R arrow.r^(times r) r R$ is an isomorphism since $R$ is a PID, by Theorem #ref(label("Baer's criterion"), supplement: none), we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$R$]),
node((1,0),[$r R$]),
node((2,0),[$R$]),
node((1,1),[$M$]),
edge((0,0),(1,0),"->",[$times r$]),
edge((0,0),(1,1),"->",[$m$]),
edge((1,0),(2,0),"hook->"),
edge((2,0),(1,1),"->",[$m'$],stroke:(dash:"dashed")))]
]
Here $R arrow.r^m M$, $1 mapsto m$, thus $m = r m'$

Suppose $M$ is divisible, since $R$ is a PID, for any homomorphism $r R arrow.r M$, $r mapsto m$, we have $m = r m'$ for some $m'$, giving the extension $R arrow.r M$, $1 mapsto m'$

]
#statement("Corollary")[
The category of abelian groups $cal(A) b$ has enough injectives

]
#proof(title: "Proof")[
By corollary #ref(label("Injective <=> Divisible"), supplement: none), $bb(Q)\/bb(Z)$ is injective since $bb(Q)\/bb(Z)$ is divisible

Suppose $M$ is an abelian group, define $I = product_f bb(Q)\/bb(Z)$ which is also injective due to Lemma #ref(label("Coproduct of projetives is projective, product of injectives is injective"), supplement: none), here $f$ runs over $H o m\(M\,bb(Q)\/bb(Z)\)$, thus we get $h : M arrow.r I$. Suppose $0 eq.not m in ker h$, then $f\(m\)= 0$ for any $f in H o m\(M\,bb(Q)\/bb(Z)\)$. Define $H = bb(Z) m$ which is isomorphism to $bb(Z)$ or $bb(Z)\/n bb(Z)$, then we can define $beta : H arrow.r bb(Q)\/bb(Z)$, $m mapsto 1 / n$, since $bb(Q)\/bb(Z)$ is a injective, we can extend to $alpha : M arrow.r bb(Q)\/bb(Z)$, but then $alpha\(m\)= beta\(m\)eq.not 0$ which is a contradiction

]
#statement("Theorem")[
Suppose $cal(A)\,cal(B)$ are abelian categories, $L : cal(A) arrow.r cal(B)$, $R : cal(B) arrow.r cal(A)$ are adjoint functors, $L$ is exact, $I in o b cal(B)$ is injective, then $R\(I\)$ is also injective

]
#proof(title: "Proof")[
For any monomorphism $A arrow.r.hook A'$, $L\(A\)arrow.r.hook L\(A'\)$ is also monic, we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m\(L\(A'\)\,I\)$]),
node((1,0),[$H o m\(L\(A\)\,I\)$]),
node((0,1),[$H o m\(A'\,R\(I\)\)$]),
node((1,1),[$H o m\(A\,R\(I\)\)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->"))]
]

]
#pagebreak(weak:true)
== Enough injectives in R-Mod - 3/2/2020
<enough-injectives-in-r-mod---322020>
#statement("Lemma")[
If $M$ is a left $R$ module, $A$ is an abelian group, then $H o m\(M\,A\)$ is a right $R$ module. Similarly, if $M$ is a ring $R$ module, then $H o m\(A\,M\)$ is a left $R$ module

]
#proof(title: "Proof")[
$\(f r\)\(m\)= f\(r m\)$, $\(f r s\)\(m\)= f\(r s m\)=\(f r\)\(s m\)=\(\(f r\)s\)\(m\)$

$\(r f\)\(m\)= f\(m r\)$, $\(r s f\)\(m\)= f\(m r s\)=\(s f\)\(r m\)=\(r\(s f\)\)\(m\)$

]
#statement("Proposition")[
If $M$ is a left $R$ module, $A$ is an abelian group, viewing $R$ as a right $R$ module, then the natural map $H o m_(cal(A) b)\(M\,A\)arrow.r H o m_(R upright("-") M o d)\(M\,H o m\(R\,A\)\)$ is an isomorphism. In other words, $H o m\(R\,-\)$ is the right adjoint to the forgetful functor $R$-$M o d arrow.r cal(A) b$, sending a right $R$ module to its underlying abelian group, the forgetfull is clearly an exact functor, thus $H o m\(R\,-\)$ maps injectives to injectives

]
#proof(title: "Proof")[

]
#statement("Corollary")[
$R$-$M o d$ has enough injectives

]
#proof(title: "Proof")[

]
#statement("Definition")[
Suppose $cal(A)\,cal(B)$ are abelian category, $F : cal(A) arrow.r cal(B)$ is an #strong[additive funtor]#index-entry("Additive funtor") if $F\(A xor B\)$ is naturally isomorphic to $F\(A\)xor F\(B\)$, and $F$ is #strong[additive], i.e. $F\(f + g\)= F\(f\)+ F\(g\)$, $f\,g in H o m\(A\,B\)$, here $f + g$ is given by the composition $A arrow.r^(vec(f, g)) B xor B arrow.r^nabla Y$, here $nabla$ is the #strong[codiagonal]

]
#statement("Example")[
$and.big^2 : upright(V e c t)_F arrow.r upright(V e c t)_F$ is exact but not additive

]
#pagebreak(weak:true)
== Universality of derived functors - 3/6/2020
<universality-of-derived-functors---362020>
#statement("Definition")[
The #strong[left derived functor]#index-entry("Derived functor") of $F$ is $L_i F\(A\)= H_i F\(P\)$, where $P arrow.r A$ is a projective resolution

]
#statement("Definition")[
$Y in o b cal(A)$ is $F$-#strong[acyclic]#index-entry("F-cyclic") if $L_i F\(Y\)= 0$ for all $i gt.eq 1$. Projectives are acyclic

]
#statement("Theorem")[
$F : cal(A) arrow.r cal(B)$ is right exact, $cal(A)$ has enough projectives, the #strong[left derived functor] $L_i F$ is a universal homological $delta$ functor

]
#proof(title: "Proof")[
Suppose $0 arrow.r X arrow.r Y arrow.r Z arrow.r 0$ is exact, $P_X\,P_Z$ are projective resolutions of $X\,Z$, then $\(P_Y\)_i =\(P_X\)_i xor\(P_Z\)_i$ is a projective resolution of $Y$ by Lemma #ref(label("Horseshoe lemma"), supplement: none), since $F\(P_Y\)_i = F\(P_Y\)_i xor F\(P_Z\)_i$, $0 arrow.r F\(P_X\)_i arrow.r F\(P_Y\)_i arrow.r F\(P_Z\)_i arrow.r 0$ split, by Lemma #ref(label("Snake lemma"), supplement: none), we have $dots.h.c arrow.r L_i F\(X\)arrow.r L_i F\(Y\)arrow.r L_i F\(Z\)arrow.r^delta L_(i - 1) F\(X\)arrow.r dots.h.c$, i.e. $L_i F$ is a homological $delta$ functor. Suppose $T_i$ is another homological $delta$ functor, $phi.alt_0 : T_0 arrow.r L_0 F$ is a natural transformation, since $cal(A)$ has enough projecives, there exists

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$P$]),
node((1,0),[$X$]),
edge((0,0),(1,0),"->>"))]
with $P$ projetive, let $K$ be the kernel, we have a short exact sequence $0 arrow.r K arrow.r P arrow.r X arrow.r 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$T_1 X$]),
node((2,0),[$T_0 K$]),
node((3,0),[$T_0 P$]),
node((4,0),[$T_0 X$]),
node((0,1),[$0$]),
node((1,1),[$L_1 F X$]),
node((2,1),[$L_0 F K$]),
node((3,1),[$L_0 F P$]),
node((4,1),[$L_0 F X$]),
node((5,1),[$0$]),
edge((1,0),(2,0),"->",[$delta$]),
edge((1,0),(1,1),"->",[$exists_1 phi.alt_1$],stroke:(dash:"dashed")),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$phi.alt_0$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->",[$phi.alt_0$]),
edge((4,0),(4,1),"->",[$phi.alt_0$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$delta$]),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"),
edge((4,1),(5,1),"->"))]
]
And then inductively for $i > 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$T_(i + 1) X$]),
node((2,0),[$T_i K$]),
node((0,1),[$0$]),
node((1,1),[$L_(i + 1) F X$]),
node((2,1),[$L_i F K$]),
node((3,1),[$0$]),
edge((1,0),(2,0),"->",[$delta$]),
edge((1,0),(1,1),"->",[$exists_1 phi.alt_(i + 1)$],stroke:(dash:"dashed")),
edge((2,0),(2,1),"->",[$phi.alt_i$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$delta$]),
edge((2,1),(3,1),"->"))]
]

]
#statement("Corollary")[
$F : cal(A) arrow.r cal(B)$ is left exact, $cal(A)$ has enough injectives, the #strong[right derived functor] $R^i F$ is a universal cohomological $delta$ functor

]
#statement("Example")[
$F_M : R$-$m o d arrow.r A b$, $N mapsto H o m_R\(M\,N\)$ is left exact, $R^i F_M\(N\)= E x t_R^i\(M\,N\)$

]
#pagebreak(weak:true)
== Filtered category - 3/9/2020
<filtered-category---392020>
#statement("Lemma")[
A left adjoint is a right exact functor, a right adjoint is a left exact functor

]
#proof(title: "Proof")[
Suppose $\(L\,R\)$ are adjoint pair of functors of abelian categories, $L : cal(A) arrow.r cal(B)$, $R : cal(B) arrow.r cal(A)$, $A arrow.r B arrow.r C arrow.r 0$ is exact, then $0 arrow.r H o m\(C\,R D\)arrow.r H o m\(B\,R D\)arrow.r H o m\(A\,R D\)$ is exact, $0 arrow.r H o m\(L C\,D\)arrow.r H o m\(L B\,D\)arrow.r H o m\(L A\,D\)$ is exact, thus $L A arrow.r L B arrow.r L C arrow.r 0$ is exact

]
#statement("Proposition")[
$I$ is small, $cal(C)$ is cocomplete, $K : cal(C) arrow.r cal(C)^I$, $X mapsto K_X$ is the right adjoint to $upright(c o l i m) : cal(C)^I arrow.r cal(C)$

]
#proof(title: "Proof")[

]
#statement("Corollary")[
$I\,J$ is small, $cal(C)\,cal(C)^I\,cal(C)^J$ are cocomplete, $F : I times J arrow.r cal(C)$ is a bifunctor, which give $F_I : I arrow.r cal(C)^J$, $F_J : J arrow.r cal(C)^I$, then $upright(c o l i m) F tilde.equiv upright(c o l i m) upright(c o l i m) F_I tilde.equiv upright(c o l i m) upright(c o l i m) F_J$

]
#proof(title: "Proof")[

]
#statement("Definition")[
$I$ is a #strong[filtered category]#index-entry("Filtered category") if for any $i\,j$, there exist $i arrow.r k arrow.l j$ and for any

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$i$]),
node((1,0),[$j$]),
edge((0,0),(1,0),"->",[$phi.alt$],shift:2pt),
edge((0,0),(1,0),"->",[$psi$],shift:-2pt))]
, there exists $j arrow.r^xi k$ coequalizes $phi.alt\,psi$, i.e. $xi phi.alt = xi psi$

Equivalently, for finitely many $i_alpha$, there exist $i_alpha arrow.r^(phi.alt_alpha) j$ and for finitely many $i arrow.r^(phi.alt_alpha) j$, there exists $j arrow.r^psi k$ coequalizes $phi.alt_alpha$

]
#statement("Lemma")[
$F : I arrow.r R$-$m o d$ is a functor, then $upright(c o l i m) F = xor.big_i F\(i\)\/E$, $E$ is generated by $F\(phi.alt\)\(a_i\)- a_i$, here $i arrow.r^phi.alt j$

]
#proof(title: "Proof")[
We have the following diagrams

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(i\)$]),
node((1,0),[$F\(j\)$]),
node((1,1),[$xor.big_i F\(i\)\/E$]),
edge((0,0),(1,0),"->",[$F\(phi.alt\)$]),
edge((0,0),(1,1),"->"),
edge((1,0),(1,1),"->"))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(i\)$]),
node((2,0),[$F\(j\)$]),
node((1,1),[$xor.big_i F\(i\)\/E$]),
node((1,2),[$M$]),
edge((0,0),(2,0),"->",[$F\(phi.alt\)$]),
edge((0,0),(1,1),"->"),
edge((0,0),(1,2),"->"),
edge((2,0),(1,1),"->"),
edge((2,0),(1,2),"->"),
edge((1,1),(1,2),"->",[$exists_1$],stroke:(dash:"dashed")))]
]

]
#statement("Lemma")[
Suppose $I$ is a filtered category, for finitely many $i arrow.r j$, there exist a $k$ and $i arrow.r k$, $j arrow.r k$ such that $i arrow.r k = i arrow.r j arrow.r k$

]#label("Finitely many morphisms in a filtered category can goes to a common end")
#proof(title: "Proof")[
Use induction

#strong[\(a)] For a single morphism $i arrow.r^phi.alt j$, there exist $i arrow.r^lambda k$, $j arrow.r^mu k$, then there exists $k arrow.r^psi j$ such that $psi lambda = psi mu phi.alt$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$i$]),
node((1,0),[$j$]),
node((2,0),[$k$]),
node((3,0),[$l$]),
edge((0,0),(1,0),"->",[$phi.alt$]),
edge((0,0),(2,0),"->",[$lambda$],bend:-15deg),
edge((1,0),(2,0),"->",[$mu$]),
edge((2,0),(3,0),"->",[$psi$]))]
]
#strong[\(b)] For $bullet arrow.r^(alpha_d) l$, $i arrow.r^phi.alt j$, by (a), there exist $i arrow.r^lambda k$, $j arrow.r^mu k$ such $lambda = mu phi.alt$, then there exist $l arrow.r^beta m$, $k arrow.r^gamma m$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet$]),
node((1,0),[$l$]),
node((2,0),[$m$]),
node((0,1),[$i$]),
node((1,1),[$j$]),
node((2,1),[$k$]),
edge((0,0),(1,0),"->",[$alpha_d$]),
edge((1,0),(2,0),"->",[$beta$]),
edge((0,1),(1,1),"->",[$phi.alt$]),
edge((0,1),(2,1),"->",[$lambda$],bend:-15deg),
edge((1,1),(2,1),"->",[$mu$]),
edge((2,1),(2,0),"->",[$gamma$]))]
]
#strong[\(c)] For $bullet arrow.r^(alpha_d) j$, $bullet arrow.r^beta i$, there exist $j arrow.r^lambda k$, $i arrow.r^mu k$, then there exists $k arrow.r^phi.alt l$ such that $phi.alt lambda alpha_d = phi.alt mu beta$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet$]),
node((1,0),[$j$]),
node((2,0),[$k$]),
node((3,0),[$l$]),
node((1,1),[$i$]),
edge((0,0),(1,0),"->",[$alpha_d$]),
edge((0,0),(1,1),"->",[$beta$]),
edge((1,0),(2,0),"->",[$lambda$]),
edge((2,0),(3,0),"->",[$phi.alt$]),
edge((1,1),(2,0),"->",[$mu$]))]
]
#strong[\(d)] For $bullet arrow.r^(alpha_d) j$, $i arrow.r^beta bullet$, there exists $j arrow.r^phi.alt k$ equalizes $alpha_d beta$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$i$]),
node((1,0),[$bullet$]),
node((2,0),[$j$]),
node((3,0),[$k$]),
edge((0,0),(1,0),"->",[$beta$]),
edge((1,0),(2,0),"->",[$alpha_d$]),
edge((2,0),(3,0),"->",[$phi.alt$]))]
]
#strong[\(e)] For $bullet arrow.r^(alpha_d) i$, $bullet arrow.r^beta bullet$, there exists $i arrow.r^phi.alt j$ equalizes $alpha_d beta$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet$]),
node((1,0),[$i$]),
node((2,0),[$j$]),
edge((0,0),(1,0),"->",[$alpha_d$]),
edge((0,0),(1,0),"->",[$beta$]),
edge((1,0),(2,0),"->",[$phi.alt$]))]
]

]
#statement("Lemma")[
Suppose $I$ is a filtered category, $F : I arrow.r R$-$m o d$ is a functor, then

#strong[\(a)] Every element of $upright(c o l i m) F$ lies in the image of some $F\(i\)arrow.r upright(c o l i m) F$

#strong[\(b)] $ker\(F\(i\)arrow.r upright(c o l i m) F\)= union.big_(i arrow.r^phi.alt j) ker F\(phi.alt\)$

]
#proof(title: "Proof")[
#strong[\(a)] Any element of $upright(c o l i m) F$ is a finite sum $sum a_i$, since $I$ is filtered, there exist $k$ and $i arrow.r^(phi.alt_i) k$

#strong[\(b)] $a_i in ker\(F\(i\)arrow.r upright(c o l i m) F\)$ can be written as finite sum $sum\(F\(phi.alt\)\(a_j\)- a_j\)$ with $j arrow.r^phi.alt k$, by Lemma #ref(label("Finitely many morphisms in a filtered category can goes to a common end"), supplement: none), there exist $j arrow.r^(psi_j) l$ such that for each $j arrow.r^phi.alt k$ we have $psi_j = psi_k phi.alt$, then $F\(psi_k\)F\(phi.alt\)= F\(psi_j\)$, hence #math.equation(block: true, numbering: none, $F\(psi_i\)\(a_i\) & = (sum F \( psi_j \))\(a_i\)\
 & = (sum F \( psi_j \)) (sum \( F \( phi.alt \) \( a_j \) - a_j \))\
 & = sum (F \( psi_k \) F \( phi.alt \) \( a_j \) - F \( psi_j \) a_j)\
 & = 0$) Therefore $a_i in ker F\(psi_i\)$

]
#statement("Definition")[
A #strong[sheaf]#index-entry("Sheaf") is a presheaf $F$ such that

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(U\)$]),
node((1,0),[$product_i F\(U_i\)$]),
node((2,0),[$product_(i\,j) F\(U_i inter U_j\)$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",shift:2pt),
edge((1,0),(2,0),"->",shift:-2pt))]
]
Is an equaliser. $S h\(X\)$ is the category of sheaves over $X$

]
#statement("Proposition")[
If $cal(D)$ is complete, then $cal(D)^(cal(C)^(o p))$ is complete, $\(lim F_i\)\(X\)= lim F_i\(C\)$. If $cal(D)$ is cocomplete, then $cal(D)^(cal(C)^(o p))$ is cocomplete, $\(upright(c o l i m) F_i\)\(X\)= upright(c o l i m) F_i\(X\)$

]
#proof(title: "Proof")[

]
#statement("Corollary")[
$P r e S h\(X\,R upright("-") m o d\)$, $S h\(X\,R upright("-") m o d\)$ are abelian categories

]
#statement("Theorem")[
Inclusion $S h\(X\,R upright("-") m o d\)arrow.r P r e S h\(X\,R upright("-") m o d\)$ is the right adjoint to the sheafification $P r e S h\(X\,R upright("-") m o d\)arrow.r S h\(X\,R upright("-") m o d\)$, hence inclusion is left exact, sheafification is actually exact

]
#proof(title: "Proof")[

]
#statement("Lemma")[
$0 arrow.r F arrow.r G arrow.r H arrow.r 0$ is exact iff $0 arrow.r F_x arrow.r G_x arrow.r H_x arrow.r 0$ is exact

]
#proof(title: "Proof")[

]
#statement("Example")[
$X = bb(C)\\{ 0 }$, $bb(Z)$ is the sheaf of locally integer constant functions, $cal(O)$ is the sheaf of holomorphic functions, $cal(O)^times$ is the sheaf of nonvanishing holomorphic functions, $0 arrow.r bb(Z) arrow.r.hook cal(O) arrow.r^exp cal(O)^times arrow.r 0$ is exact in $S h\(X\)$, but not in $P r e S h\(X\)$, since $z in cal(O)^times$ is not in $upright(i m)\(cal(O)\(X\)arrow.r^exp cal(O)^times\(X\)\)$

]
#pagebreak(weak:true)
== Hom cochain complex
<hom-cochain-complex>
#statement("Definition")[
$P$ is a chain complex with differentials $partial$, $I$ is a cochain complex with codifferentials $d$, we get a double complex $H o m\(P\,I\)= { H o m\(P_p\,I^q\)}$ with horizontal and vertical codifferentials $d'\,d''$ defined as $d''\(f\)= f partial$, $d'\(f\)=\(- 1\)^(p + q + 1) d f$. The #strong[Hom cochain complex]#index-entry("Hom cochain complex") is the product total complex $T o t^Pi\(H o m\(P\,I\)\)$

]
#pagebreak(weak:true)
== Group homology
<group-homology>
#statement("Definition")[
$R$ is a commutative ring, $M$ is right $R\[G\]$ module, $C_(*)\(G\)$ is the tuple complex, equivalently, $B_(*)\(G\)$ is the bar complex, $macron(B)_(*)\(G\)= B_(*)\(G\)times.o_(R\[G\]) R$, thus #math.equation(block: true, numbering: none, $M times.o_(R\[G\]) B_(*)\(G\)tilde.equiv M times.o_R R times.o_(R\[G\]) B_(*)\(G\)tilde.equiv M times.o_R macron(B)_(*)\(G\)$) Group homology with coefficients in $M$ is #math.equation(block: true, numbering: none, $H_k\(G\;M\) & = H_k\(M times.o_(R\[G\]) C_(*)\(G\)\)\
 & = H_k\(M times.o_(R\[G\]) B_(*)\(G\)\)\
 & = H_k\(M times.o_R macron(B)_(*)\(G\)\)\
 & = T o r_k^(R\[G\])\(M\,R\)$) The differential of $M times.o_(bb(Z)\[G\]) C_(*)\(G\)$ is given by #math.equation(block: true, numbering: none, $partial\(m times.o\[g_1\|dots.h.c\|g_n\]\) & = partial\(m times.o\(1\,g_1\,g_1 g_2\,dots.h.c\,g_1 dots.h.c g_n\)\)\
 & = m g_1 times.o\[g_2\|dots.h.c\|g_n\]+ sum_(i = 1)^(n - 1)\(- 1\)^i m times.o\[g_1\|dots.h.c\|g_i g_(i + 1)\|dots.h.c\|g_n\]\
 & quad +\(- 1\)^n m times.o\[g_1\|dots.h.c\|g_(n - 1)\]$) $H_0\(G\;M\)= M times.o_(R\[G\]) R = M_G$

]
#pagebreak(weak:true)
#pagebreak(weak:true)
= Spectral sequence
<spectral-sequence>
== Spectral sequence
<spectral-sequence-1>
#statement("Lemma")[
$E arrow.r^f E'$ is a morphism of spectral sequences, and $E_(p q)^r arrow.r^(f_(p q)^r) E' ""_(p q)^r$ are isomorphisms for any $p\,q$, then $E_(p q)^s arrow.r^(f_(p q)^s) E' ""_(p q)^s$ are isomorphisms for any $p\,q$, $s gt.eq r$

]
#proof(title: "Proof")[
By five lemma #ref(label("Five lemma"), supplement: none)

]
#statement("Definition")[
A spectral sequence $C$ is #strong[bounded]#index-entry("Bounded spectral sequence") if for all $n\,r$, all but finitely many $E_(p\,n - p)^r$ vanish

]
#statement("Definition")[
$H_(*) in cal(A)^(bb(Z))$, $bb(Z)$ is the discrete category, $F_p H_(*)$ is a filtration of $H_(*)$. $E$ #strong[weakly converge] to $H_(*)$ if $E_(p q)^oo tilde.equiv F_p H_(p + q)\/F_(p - 1) H_(p + q)$. If $F_p H_n$ are Hausdorff and exhaustive, then $E$ #strong[approaches] or #strong[abuts] $H_(*)$. If $F_p H_n$ are complete, then $E$ #strong[converges] to $H_(*)$

Bounded spectral sequence $E$ converge to $H_(*)$ if $F_p H_n$ are bounded, and $E_(p q)^oo = F_p H_(p + q)\/F_(p - 1) H_(p + q)$, denote $E_(p q)^r arrow.r.double H_(p + q)$

]
#pagebreak(weak:true)
== Spectral sequence of a filtered chain complex
<spectral-sequence-of-a-filtered-chain-complex>
#statement("Definition")[
$C$ is a chain complex, $dots.h.c subset.eq F_(p - 1) C subset.eq F_p C subset.eq F_(p + 1) C subset.eq dots.h.c$ is a filtration of chain complexes. $F C$ is #strong[exhaustive] if $union.big F_p C = C$. $F C$ is #strong[Hausdorff] if $inter.big F_p C = 0$. $hat(C) = lim_arrow.l C\/F_p C$ is the #strong[completion]. $F C$ is #strong[complete] if $hat(C) tilde.equiv C$, since $C arrow.r hat(C)$ has kernel $inter.big F_p C$, hence completeness implies Hausdorff. $F C$ is #strong[bounded below] if $forall n$, $F_p C_n = 0$ for $p$ small enough. $F C$ is #strong[bounded above] if $forall n$, $F_p C_n = C_n$ for $p$ big enough. $F C$ is #strong[bounded] if bounded below and above

$F_p H_n\(C\)= upright(i m)\(H_n\(F_p C\)arrow.r H_n\(C\)\)$

]
#statement("Definition")[
$F_n C$ is a filtered chain complex, $E_(p q)^0 = frac(F_p C_(p + q), F_(p - 1) C_(p + q))$ defines a spectral sequence

$E_(p q)^1$ #strong[converges] to $H_(*) C$ if $E_(p q)^1 = H_(p + q)\(F_p C\/F_(p - 1) C\)arrow.r.double H_(p + q) C$

]
#statement("Theorem")[
$A_p^r = {x in F_p C mid(bar.v) d x in F_(p - r) C}$, $Z_p^r = A_p^r + F_(p - 1) C$, $B_p^r = d A_(p + r - 1)^(r - 1) + F_(p - 1) C$, $A_p^r inter F_(p - 1) C = A_(p - 1)^(r - 1)$ #math.equation(block: true, numbering: none, $E_p^r & = Z_p^r / B_p^r = frac(A_p^r + F_(p - 1) C, d A_(p + r - 1)^(r - 1) + F_(p - 1) C) = frac(A_p^r + F_(p - 1) C, F_(p - 1) C) / frac(d A_(p + r - 1)^(r - 1) + F_(p - 1) C, F_(p - 1) C) = A_p^r / A_(p - 1)^(r - 1) / frac(d A_(p + r - 1)^(r - 1), d A_(p + r - 1)^(r - 1) inter F_(p - 1) C)\
 & = A_p^r / A_(p - 1)^(r - 1) / frac(d A_(p + r - 1)^(r - 1), d A_(p + r - 1)^(r - 1) inter A_(p - 1)^(r - 1)) = A_p^r / A_(p - 1)^(r - 1) / frac(d A_(p + r - 1)^(r - 1) + A_(p - 1)^(r - 1), A_(p - 1)^(r - 1)) = frac(A_p^r, d A_(p + r - 1)^(r - 1) + A_(p - 1)^(r - 1))$)

]
#statement("Lemma")[
$C$ and $hat(C)$ give the same spectral sequence

]
#statement("Theorem")[
If $F_(*) C$ is bounded, then $E_(p\,q)^1$ converges to $H_(*) C$

If $F_(*) C$ is bounded below and exhaustive, then $E_(p\,q)^1$ converges to $H_(*) C$, the convergence is natural

]
#statement("Theorem")[
$C$ is a complete filtration, then

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$lim_arrow.l ""^1 H_(n + 1)\(C\/F_p C\)$]),
node((2,0),[$H_n\(C\)$]),
node((3,0),[$H_n\(C\/F_p C\)$]),
node((4,0),[$0$]),
node((1,1),[$inter.big F_p H_n\(C\)$]),
node((3,1),[$lim_arrow.l H_n\(C\)\/F_p H_n\(C\)$]),
node((3,2),[$H_(*)\(C\)\/inter.big F_p H_n\(C\)$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"="),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"="),
edge((3,1),(3,2),"="))]
]
]
#statement("Lemma")[
$F_(*) C$ is Hausdorff and exhaustive, then

+ $A_(p q)^oo = ker\(F_p C_(p + q) arrow.r^d F_p C_(p + q - 1)\)$

+ $F_p H_(p + q)\(C\)tilde.equiv A^oo\/union.big d A_(p + r\,q - r + 1)^r$

+ The subgroup $e_(p q)^oo = A_(p q)^oo + B_(p q)^oo$ is isomorphic to $F_p H_(p + q)\(C\)\/F_(p - 1) H_(p + q)\(C\)$

]
#pagebreak(weak:true)
== Spectral sequence of a double complex
<spectral-sequence-of-a-double-complex>
#statement("Definition")[
$C_(p q)$ is a double complex. Filtration by columns $' F_n\(T o t\(C\)\)$ is the total complex of a truncation of $C$ with $C_(p q) = 0$ for $q > n$

#align(center)[
#align(center)[#grid(columns:(1em,1em,1em,1em,1em,1em),gutter:6pt,..range(30).map(index => if calc.rem(index,6) < 3 { $bullet$ } else { $0$ }))]
]
Filtration by rows $'' F_n\(T o t\(C\)\)$ is the total complex of a truncation of $C$ with $C_(p q) = 0$ for $p > n$

#align(center)[
#align(center)[#grid(columns:(1em,1em,1em,1em,1em),gutter:6pt,..range(30).map(index => if index < 15 { $0$ } else { $bullet$ }))]
]
We have #math.equation(block: true, numbering: none, $' E_(p q)^0 = C_(p q)\,' E_(p q)^1 = H_q\(C_(p *)\)\,' E_(p q)^2 = H_p^h H_q^v C$) #math.equation(block: true, numbering: none, $'' E_(p q)^0 = C_(q p)\,'' E_(p q)^1 = H_q\(C_(* p)\)\,' E_(p q)^2 = H_q^v H_p^h C$)

]
#pagebreak(weak:true)
== Hyperhomology
<hyperhomology>
#statement("Definition")[
$cal(A)$ is an abelian category with enough projectives, a #strong[Cartan-Eilenberg resolution]#index-entry("Cartan-Eilenberg resolution") $P_(* *)$ of chain complex $A_(*)$ is an upper half plane double complex consist of projectives and a augmentation $P_(* 0) arrow.r^epsilon A_(*)$ such that

+ If $A_p = 0$, then $P_(p\,*) = 0$

+ $B_p^h\(P\)arrow.r^(B_p\(epsilon\)) B_p\(A_(*)\)$, $H_p^h\(P\)arrow.r^(H_p\(epsilon\)) H_p\(A_(*)\)$ are projective resolutions

]
#statement("Lemma")[
Every chain complex $A_(*)$ has a Cartan-Eilenberg resolution, and $Z_p^h\(P\)arrow.r^(Z_p\(epsilon\)) Z_p\(A_(*)\)$, $P_(p *) arrow.r^(epsilon_p) A_p$ are projective resolutions

]
#statement("Lemma")[
$f : A arrow.r B$ is a chain map, $P arrow.r A$, $Q arrow.r B$ are Cartan-Eilenberg resolutions, there exists a double complex map $tilde(f) : P arrow.r Q$ over $f$

]
#statement("Definition")[
$f\,g : D arrow.r E$ are maps between double complexes, a chain homotopy from $f$ to $g$ consists of $s^h : D_(p q) arrow.r E_(p + 1\,q)$ and $s^v : D_(p q) arrow.r E_(p\,q + 1)$ satisfying #math.equation(block: true, numbering: none, $f - g =\(s^h d^h + d^h s^h\)=\(s^v d^v + d^v s^v\)$) #math.equation(block: true, numbering: none, $s^v d^h + d^h s^v = s^h d^v + d^v s^h = 0$) So that $s^h + s^v : T o t\(D\)_n arrow.r T o t\(E\)_(n + 1)$ is a chain homotopy between $T o t\(f\)\,T o t\(g\): T o t^xor\(D\)arrow.r T o t^xor\(E\)$

]
#statement("Lemma")[
$f\,g : A arrow.r B$ are chain homotopic, $P arrow.r A$, $Q arrow.r B$ are Cartan-Eilenberg resolutions, $tilde(f)\,tilde(g) : P arrow.r Q$ are over $f\,g$, then $tilde(f)\,tilde(g)$ are chain homotopic

Any two Cartan-Eilenberg resolutions of $P arrow.r A$, $Q arrow.r A$ are chain homotopic. $F$ is an additive functor, then $T o t^xor\(F\(P\)\)$, $T o t^xor\(F\(Q\)\)$ are chain homotopic

]#label("Chain homotopy between Cartna-Eilenberg resolutions")
#statement("Definition")[
$cal(A)\,cal(B)$ are abelian categories, $cal(A)$ has enough projectives, $F : cal(A) arrow.r cal(B)$ is an additive functor, $f : A arrow.r B$ is a chain map. Define $bb(L)_i F\(A\)= H_i\(T o t^xor\(F\(P\)\)\)$, by Lemma #ref(label("Chain homotopy between Cartna-Eilenberg resolutions"), supplement: none), $bb(L)_i F\(A\)$ is independent of the choice of $P$, $bb(L)_i F\(f\)= H_i\(T o t\(F\(f\)\)\)$. $bb(L)_i F : upright(bold(C h)) cal(A) arrow.r cal(B)$ is the left hyper-derived functor of $F$

]
#statement("Lemma")[
$0 arrow.r A arrow.r B arrow.r C arrow.r 0$ is a short exact sequence of bounded below chain complexes, then we have a long exact sequence #math.equation(block: true, numbering: none, $dots.h.c arrow.r bb(L)_(i + 1) F\(C\)arrow.r^delta bb(L)_i F\(A\)arrow.r bb(L)_i F\(B\)arrow.r bb(L)_i\(C\)arrow.r^delta dots.h.c$)

]
#statement("Proposition", title: [Hyperhomology spectral sequence])[
#index-entry("Hyperhomology spectral sequence") $L_p F\(H_q\(A\)\)arrow.r.double bb(L)_(p + q) F\(A\)$. If $A$ is bounded below, then $H_p\(L_q F\(A\)\)arrow.r.double bb(L)_(p + q) F\(A\)$

]#label("Hyperhomology spectral sequence")
#proof(title: "Proof")[
Consider the double complex $P$ of a Cartan-Eilenberg resolution $P arrow.r A$. Since $H_p^h\(P\)arrow.r H_p A$ is a projective resolution, we have #math.equation(block: true, numbering: none, $L_p F\(H_q\(A\)\)= H_p^v F\(H_q^h\(P\)\)= H_p^v H_q^h\(F\(P\)\)='' E_(p q)^2 arrow.r.double H_(p + q) F\(P\)= bb(L)_(p + q) F\(A\)$) If $A$ is bounded belwo, then #math.equation(block: true, numbering: none, $H_p\(L_q F\(A\)\)= H_p^h H_q^v\(F\(P\)\)=' E_(p q)^2 arrow.r.double H_(p + q) F\(P\)= bb(L)_(p + q) F\(A\)$)

]
#statement("Corollary")[
+ If $A$ is exact, then $bb(L)_i F\(A\)= 0$

+ If $f : A arrow.r B$ is a quasi-isomorphism, then $bb(L)_(*) F\(f\): bb(L)_(*) F\(A\)arrow.r bb(L)_(*) F\(B\)$ are isomorphisms

+ If $A$ is bounded below and $A_p$ are $F$ acyclic, then $bb(L)_p F\(A\)= H_p F\(A\)$

]
#statement("Theorem", title: [Grothendieck spectral sequence])[
#index-entry("Grothendieck spectral sequence") $cal(A)\,cal(B)$ have enough projectives, $F : cal(B) arrow.r cal(C)$, $G : cal(A) arrow.r cal(B)$ are right exact functors and $G$ sends projectives to $F$-acyclic objects, then #math.equation(block: true, numbering: none, $\(L_p F\)\(L_q G\)\(A\)arrow.r.double L_(p + q)\(F G\)\(A\)$)

]#label("Grothendieck spectral sequence")
#proof(title: "Proof")[
Suppose $P arrow.r A$ is a projective resolution, then by Proposition #ref(label("Hyperhomology spectral sequence"), supplement: none), we have #math.equation(block: true, numbering: none, $\(L_p F\)\(L_q G\)\(A\)tilde.equiv L_p F\(H_q G\(P\)\)arrow.r.double bb(L)_(p + q)\(F G\)\(A\)$) #math.equation(block: true, numbering: none, $H_p\(L_q F\(G\(P\)\)\)arrow.r.double bb(L)_(p + q)\(F G\)\(A\)$) Since $G\(A\)$ is $F$-acyclic, $' E_2^(p q) = 0$ for $q eq.not 0$ and #math.equation(block: true, numbering: none, $E_2^(p 0) = H_p\(F G\(P\)\)= L_p\(F G\)\(A\)tilde.equiv bb(L)_p\(F G\)\(A\)$)

]
#statement("Corollary", title: [Hochschild-Serre spectral sequence])[
#index-entry("Hochschild-Serre spectral sequence") $N lt.eq G$ is a normal subgroup, $A$ is a $bb(Z) G$ module, then #math.equation(block: true, numbering: none, $H_p\(G\/N\;H_q\(N\;A\)\)arrow.r.double H_(p + q)\(G\;A\)$)

]#label("Hochschild-Serre spectral sequence")
#proof(title: "Proof")[
Consider right exact functors #math.equation(block: true, numbering: none, $F = - times.o_(bb(Z)\[G\/N\]) bb(Z) : bb(Z)\[G\/N\]upright("-mod") arrow.r bb(Z) upright("-mod")$) #math.equation(block: true, numbering: none, $G = - times.o_(bb(Z)\[N\]) bb(Z) = - times.o_(bb(Z)\[G\]) bb(Z)\[G\/N\]: bb(Z)\[G\]upright("-mod") arrow.r bb(Z)\[G\/N\]upright("-mod")$) The left derived functors of $F G = - times.o_(bb(Z)\[G\]) bb(Z)$ is $L_(*)\(F G\)\(A\)= T o r_(*)^(bb(Z)\[G\])\(A\,bb(Z)\)= H_(*)\(G\;A\)$. For any $bb(Z)\[G\]$ module $A$ and $bb(Z)\[G\/N\]$ module $B$, we have natural isomorphism #math.equation(block: true, numbering: none, $H o m_(bb(Z)\[G\/N\])\(A times.o_(bb(Z)\[G\]) bb(Z)\[G\/N\]\,B\)tilde.equiv H o m_(bb(Z)\[G\])\(A\,B\)= H o m_(bb(Z)\[G\])\(A\,U\(B\)\)$) Hence $G$ is left adjoint to forgetful functor $U$ which is exact, by Lemma #ref(label("Left adjoint to exact functor preserves projectives"), supplement: none), $G$ preserves projectives which are exactly $F$-acyclic objects. Apply Theorem #ref(label("Grothendieck spectral sequence"), supplement: none) we have #math.equation(block: true, numbering: none, $H_p\(G\/N\;H_q\(N\;A\)\)=\(L_p F\)\(L_q G\)\(A\)arrow.r.double L_(p + q)\(F G\)\(A\)= H_(p + q)\(G\;A\)$)

]
#pagebreak(weak:true)
#pagebreak(weak:true)
= Homeworks
<homeworks>
== Homework1
<homework1>
#aside("Exercise", title:[A1.1])[
Show that $bb(Z) subset bb(Q)$ is epi in #strong[Rings]. Show that $bb(Q) subset bb(R)$ is epi in the category of Hausdorff topological spaces

]
#proof(title: "Proof")[
Suppose we have a commutative diagram of rings

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(Z)$]),
node((1,0),[$bb(Q)$]),
node((2,0),[$R$]),
edge((0,0),(1,0),"hook->",[$i$]),
edge((1,0),(2,0),"->",[$f$],shift:2pt),
edge((1,0),(2,0),"->",[$g$],shift:-2pt))]
]
Then $f\(n\)= g\(n\)\,forall n in bb(Z)$, hence #math.equation(block: true, numbering: none, $f (1 / n) = f (1 / n) g\(1\)= f (1 / n) g\(n\)g (1 / n) = f (1 / n) f\(n\)g (1 / n) = f\(1\)g (1 / n) = g (1 / n)$) Thus $f (m / n) = f\(m\)f (1 / n) = g\(m\)g (1 / n) = g (m / n) arrow.r.double f = g$

Therefore, $bb(Z) arrow.r.hook bb(Q)$ is an epimorphism

Suppose we have a commutative diagram of Hausdorff spaces

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(Q)$]),
node((1,0),[$bb(R)$]),
node((2,0),[$X$]),
edge((0,0),(1,0),"hook->",[$i$]),
edge((1,0),(2,0),"->",[$f$],shift:2pt),
edge((1,0),(2,0),"->",[$g$],shift:-2pt))]
]
Suppose $f eq.not g$, then there exists $r in bb(R)$ such that $x := f\(r\)eq.not g\(r\)= : y$. Since $X$ is Hausdorff, there are disjoint open neighborhoods $x in U$, $y in V$, then $r in W := f^(- 1)\(U\)inter g^(- 1)\(V\)$ is an open neighborhood of $r$. Since $bb(Q) arrow.r.hook bb(R)$ is dense, there exists $q in bb(Q) inter W$, we have $f\(q\)in U\,g\(q\)in V$, $f\(q\)= g\(q\)$ which is a contradiction, hence $f = g$. Therefore, $bb(Q) arrow.r.hook bb(R)$ is an epimorphism

]
#aside("Exercise", title:[A1.2])[
In #strong[Groups], show that monics are just injective set maps, and kernels are monics whose image is a normal subgroup

]
#proof(title: "Proof")[
Consider a commutative diagram of groups #figure([#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$K$]),
node((1,0),[$G$]),
node((2,0),[$H$]),
edge((0,0),(1,0),"->",[$g$],shift:2pt),
edge((0,0),(1,0),"->",[$h$],shift:-2pt),
edge((1,0),(2,0),"->",[$f$]))]],kind:"equation-diagram",supplement:[Equation],numbering:number => context numbering("1.1",counter(heading).get().first(),number),caption:none)#label("eq:1") Given $f$ is an injective map, if $f g = f h$, then $f\(g\(k\)\)= f\(h\(k\)\)arrow.r.double g\(k\)= h\(k\)$, thus $f$ is a monomorphism

Conversely, given $f$ is a monomorphism. Suppose $f$ is not an injective map, then $f\(g_1\)= f\(g_2\)$ for some $g_1 eq.not g_2 in G$, if we take $K$ in #ref(label("eq:1"), supplement: none) to be the infinite cyclic group $chevron.l x chevron.r$ generated by $x$ and $g\(x\)= g_1$, $h\(x\)= g_2$, then $g eq.not h$ but $f g = f h$ which is a contradiction. Therefore $f$ is an injective map

Given $i : K arrow.r.hook G$ is a monomorphism and $N := i\(K\)$ is a normal subgroup of $G$. $pi i = 0$ is the zero morphism where $pi : G arrow.r G\/N$ is the quotient homomorphism, suppose $i' : K' arrow.r G$ is a homomorphism such that $pi i' = 0$, then $i'\(K'\)subset.eq N = i\(K\)$, we can define $phi.alt : K' arrow.r K$, $k' mapsto i^(- 1) i'\(k'\)$, $phi.alt$ is a homomorphism since #math.equation(block: true, numbering: none, $i\(i^(- 1) i'\(k'_1\)i^(- 1) i'\(k'_2\)\)= i\(i^(- 1) i'\(k'_1\)\)i\(i^(- 1) i'\(k'_2\)\)= i'\(k'_1\)i'\(k'_2\)= i'\(k'_1 k'_2\)\
arrow.r.double phi.alt\(k'_1 k'_2\)= i^(- 1) i'\(k'_1 k'_2\)= i^(- 1) i'\(k'_1\)i^(- 1) i'\(k'_2\)= phi.alt\(k'_1\)phi.alt\(k'_2\)$)

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$K$]),
node((1,0),[$G$]),
node((2,0),[$G\/N$]),
node((0,1),[$K'$]),
edge((0,0),(1,0),"hook->",[$i$]),
edge((1,0),(2,0),"->",[$pi$],shift:2pt),
edge((1,0),(2,0),"->",[$0$],shift:-2pt),
edge((0,1),(1,0),"->",[$i'$]),
edge((0,1),(0,0),"->",[$phi.alt$],stroke:(dash:"dashed")))]
]
Conversely, given $i : K arrow.r.hook G$ is a kernel of $G arrow.r^pi H$. Suppose $f\,g : M arrow.r K$ such that $i f = i g$, then $pi i f = pi i g = 0$, by universal property, $f = g$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$M$]),
node((0,1),[$K$]),
node((1,1),[$G$]),
node((2,1),[$H$]),
node((0,2),[$M$]),
edge((0,0),(0,1),"->",[$g$]),
edge((0,0),(1,1),"->",[$i g$]),
edge((0,1),(1,1),"hook->",[$i$]),
edge((1,1),(2,1),"->",[$pi$],shift:2pt),
edge((1,1),(2,1),"->",[$0$],shift:-2pt),
edge((0,2),(1,1),"->",[$i f$]),
edge((0,2),(0,1),"->",[$f$]))]
]
Let $N$ be the kernel of $pi$, since $pi i = 0$, $i\(K\)subset.eq N$, on the other hand, by universal property, there is a homomorphism $phi.alt : N arrow.r K$ such that $i phi.alt = iota$, where $iota : N arrow.r.hook G$ is inclusion, thus $N = iota\(N\)= phi.alt i\(K\)subset.eq i\(K\)$. Therefore $i\(K\)= N$ is a normal subgroup

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$K$]),
node((1,0),[$G$]),
node((2,0),[$H$]),
node((0,1),[$N$]),
edge((0,0),(1,0),"hook->",[$i$]),
edge((1,0),(2,0),"->",[$pi$],shift:2pt),
edge((1,0),(2,0),"->",[$0$],shift:-2pt),
edge((0,1),(1,0),"->",[$iota$]),
edge((0,1),(0,0),"->",[$phi.alt$],stroke:(dash:"dashed")))]
]

]
#aside("Exercise", title:[A1.3])[
\(Pontrjagin duality) Show that the category $cal(C)$ of finite abelian groups is isomorphic to its opposite category $cal(C)^(o p)$, but that this fails for the category $cal(T)$ of torsion abelian groups. We will see in exercise 6.11.4 that $cal(T)^(o p)$ is the category of profinite abelian groups

]
#proof(title: "Proof")[
Make the use of the following facts #math.equation(block: true, numbering: none, $H o m\(bb(Z)\/n bb(Z)\,bb(Z)\/m bb(Z)\)tilde.equiv bb(Z)\/\(n\,m\)bb(Z)$) And #math.equation(block: true, numbering: none, $H o m (xor.big_(j = 1)^n bb(Z) \/ n_j bb(Z) \, xor.big_(i = 1)^m bb(Z) \/ m_i bb(Z)) tilde.equiv xor.big_(j = 1)^n xor.big_(i = 1)^m H o m (bb(Z) \/ n_j bb(Z) \, bb(Z) \/ m_i bb(Z))$) We could think of elements in $H o m (xor.big_(j = 1)^n bb(Z) \/ n_j bb(Z) \, xor.big_(i = 1)^m bb(Z) \/ m_i bb(Z))$ as $m times n$ matrices #math.equation(block: true, numbering: none, $mat(delim: "(", k_11, dots.h.c, k_(1 n); dots.v, dots.down, dots.v; k_(m 1), dots.h.c, k_(m n))$) With $k_(i j) in bb(Z)\/\(n_j\,m_i\)bb(Z)$, and composition can be thought of as matrix multiplication

The opposite category $cal(C)^(o p)$ can be thought of as a category with finite abelian groups as objects and homomorphism direction reversed as morphisms

Define $F : cal(C) arrow.r cal(C)^(o p)$, sending any object to itself and sending morphisms as follows #math.equation(block: true, numbering: none, $H o m (xor.big_(j = 1)^n bb(Z) \/ n_j bb(Z) \, xor.big_(i = 1)^m bb(Z) \/ m_i bb(Z)) arrow.r H o m_(cal(C)^(o p)) (xor.big_(j = 1)^n bb(Z) \/ n_j bb(Z) \, xor.big_(i = 1)^m bb(Z) \/ m_i bb(Z))$) #math.equation(block: true, numbering: none, $mat(delim: "(", k_11, dots.h.c, k_(1 n); dots.v, dots.down, dots.v; k_(m 1), dots.h.c, k_(m n)) mapsto mat(delim: "(", k_11, dots.h.c, k_(m 1); dots.v, dots.down, dots.v; k_(1 n), dots.h.c, k_(m n))^(o p)$) This is a functor since $F\(I\)= I^(o p)$, $F\(A B\)= (\( A B \)^T)^(o p) = (B^T A^T)^(o p) = (A^T)^(o p) (B^T)^(o p) = F\(A\)F\(B\)$

Similarly, define $G : cal(C)^(o p) arrow.r cal(C)$, $G\(X\)= X\,forall X in cal(C)^(o p)$, $G\(A^(o p)\)= A^T$, this is also a functor since $G\(I^(o p)\)= I$, $G\(A^(o p) B^(o p)\)= G (\( B A \)^(o p)) =\(B A\)^T = A^T B^T = G\(A\)G\(B\)$

Therefore $G F = 1_(cal(C))$, $F G = 1_(cal(C)^(o p))$, $cal(C)$ is isomorphic to $cal(C)^(o p)$

Now let's show $cal(T)$ is not equivalent to $cal(T)^(o p)$, suppose there are functors $F : cal(T) arrow.r cal(T)^(o p)$, $G : cal(T)^(o p) arrow.r cal(T)$ such that $G F tilde.equiv 1_(cal(T))$, $F G tilde.equiv 1_(cal(T)^(o p))$

#strong[Claim I:] If $f : A arrow.r B$ is a monomorphism in $cal(T)$, then $f$ is an injective map, otherwise $0 eq.not ker f arrow.r.hook^i A$ is a nonzero subgroup, but then $f i = f 0$ which is a contradiction

#strong[Claim II:] If $f : A arrow.r B$ is a surjective map in $cal(T)$, then $f$ is an epimorphism

#strong[Claim III:] Let $A b$ be the category of abelian groups, suppose $A_i in o b cal(T)$, the colimit of $A_1 arrow.r A_2 arrow.r dots.h.c$ in $A b$ is $xor A_i\/tilde.op$ which is also a torsion abelian group, it's clear that $xor A_i\/tilde.op$ also satisfies universal property for colimits in $cal(T)$, thus $xor A_i\/tilde.op$ is also the colimit in $cal(T)$, moreover, if $A_i eq.not 0$, $A_i arrow.r.hook A_j$ are monomorphisms thus injective, then $xor A_i\/tilde.op$ is not zero

#strong[Claim IV:] $0$ is obviously the zero object in $cal(T)$ thus unique up to isomorphism

#strong[Claim V:] The limit of $bb(Z)\/p^(n + 1) bb(Z) arrow.r^(#h(0.444em) mod med p^n) bb(Z)\/p^n bb(Z)$ in $cal(T)$ is $0$ since for any torsion abelian group $A$, if diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$dots.h.c$]),
node((1,0),[$bb(Z)\/p^n bb(Z)$]),
node((2,0),[$bb(Z)\/p^(n + 1) bb(Z)$]),
node((3,0),[$dots.h.c$]),
node((2,1),[$A$]),
edge((1,0),(0,0),"->"),
edge((2,0),(1,0),"->",[$#h(0.444em) mod med p^n$]),
edge((3,0),(2,0),"->"),
edge((2,1),(2,0),"->",[$f_(n + 1)$]),
edge((2,1),(1,0),"->",[$f_n$]))]
]
Commutes, suppose $0 eq.not a in A$ is of order $k$ such that $f_n\(a\)eq.not 0$, since $0 = f_m\(k a\)= k f_m\(a\)$ for any $m$, $k = p^l$ for some $l$, but $f_m\(a\)equiv f\(a\)#h(0.444em) mod med p^n$ for any $m gt.eq n$, thus $p^l f_(n + l)\(a\)= 0 arrow.r.double f_n\(a\)= 0$ which is a contradiction. Therefore $f_i = 0$, giving the unique zero morphism $A arrow.r^0 0$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$dots.h.c$]),
node((1,0),[$bb(Z)\/p^n bb(Z)$]),
node((2,0),[$bb(Z)\/p^(n + 1) bb(Z)$]),
node((3,0),[$dots.h.c$]),
node((2,1),[$0$]),
node((2,2),[$A$]),
edge((1,0),(0,0),"->"),
edge((2,0),(1,0),"->",[$#h(0.444em) mod med p^n$]),
edge((3,0),(2,0),"->"),
edge((2,1),(2,0),"->",[$0$]),
edge((2,1),(1,0),"->",[$0$]),
edge((2,2),(1,0),"->",[$f_n$],bend:15deg),
edge((2,2),(2,0),"->",[$f_(n + 1)$],bend:-15deg),
edge((2,2),(2,1),"->",[$0$],stroke:(dash:"dashed")))]
]
#strong[Claim VI:] $F$ is fully faithful, $F$ maps initial objects in $cal(T)$ to final objects in $cal(T)$ and maps final objects in $cal(T)$ to initial objects in $cal(T)$, $F\(0\)= 0$, similarly, $G\(0\)= 0$, thus $F\(A\)eq.not 0$ for any $A eq.not 0$, otherwise $A = G F\(A\)= 0$, $F$ maps epimorphisms in $cal(T)$ to monomorphisms in $cal(T)$, $F$ maps limits in $cal(T)$ to colimits in $cal(T)$

$bb(Z)\/p^(n + 1) bb(Z) arrow.r^(#h(0.444em) mod med p^n) bb(Z)\/p^n bb(Z)$ are surjective, $F$ map these to monomorphisms between nonzero objects with colimit $0$ which contradicts Claim III

Therefore, $cal(T)$ is not equivalent to $cal(T)^(o p)$

]
#aside("Exercise", title:[A1.4])[
Show that #math.equation(block: true, numbering: none, $H o m_(cal(C)) (A \, product C_i) tilde.equiv product_(i in I) H o m_(cal(C)) (A \, C_i)$) And that #math.equation(block: true, numbering: none, $H o m_(cal(C)) (product.co C_i \, A) tilde.equiv product_(i in I) H o m_(cal(C)) (C_i \, A)$)

]
#proof(title: "Proof")[
Given $phi.alt in H o m_(cal(C)) (A \, product C_i)$, compose with $p_i : product C_i arrow.r C_i$, we have $phi.alt_i := p_i phi.alt in H o m_(cal(C)) (A \, C_i)$. Conversely, given $phi.alt_i in H o m_(cal(C)) (A \, C_i)\,forall i in I$, by the universal property of product, there is a morphism $phi.alt in H o m_(cal(C)) (A \, product C_i)$ such that $phi.alt_i = p_i phi.alt$

Given $phi.alt in H o m_(cal(C)) (product.co C_i \, A)$, compose with $iota_i : C_i arrow.r product.co C_i$, we have $phi.alt_i := phi.alt iota_i in H o m_(cal(C)) (C_i \, A)$. Conversely, given $phi.alt_i in H o m_(cal(C)) (C_i \, A)\,forall i in I$, by the universal property of coproduct, there is a morphism $phi.alt in H o m_(cal(C)) (product.co C_i \, A)$ such that $phi.alt_i = phi.alt iota_i$

]
#aside("Exercise", title:[A4.1])[
Let $cal(A)$ be an #strong[Ab]-category and $f : B arrow.r C$ a morphism. Show that:

\1. $f$ is monic $arrow.l.r.double$ for every nonzero $e : A arrow.r B$, $f e eq.not 0$

\2. $f$ is an epi $arrow.l.r.double$ for every nonzero $g : C arrow.r D$, $g f eq.not 0$

]
#proof(title: "Proof")[
#strong[\1.] Given $f$ is a monomorphism. Suppose there is a nonzero $e : A arrow.r B$, such that $f e = 0$, since $f 0 = 0$, $e = 0$ which is a contradiction. Therefore, for every nonzero $e : A arrow.r B$, $f e eq.not 0$. Conversely, given for every nonzero $e : A arrow.r B$, $f e eq.not 0$. Suppose $e\,e' : A arrow.r B$ are homomorphisms such that $f e = f e'$, then $f\(e - e\)= 0 arrow.r.double e - e' = 0 arrow.r.double e = e'$. Therefore, $f$ is a monomorphism

#strong[\2.] Given $f$ is an epimorphism. Suppose there is a nonzero $g : C arrow.r D$, such that $g f = 0$, since $0 f = 0$, $g = 0$ which is a contradiction. Therefore, for every nonzero $g : C arrow.r D$, $g f eq.not 0$. Conversely, given for every nonzero $g : C arrow.r D$, $g f eq.not 0$. Suppose $g\,g' : C arrow.r D$ are homomorphisms such that $g f = g' f$, then $\(g - g'\)f = 0 arrow.r.double g - g' = 0 arrow.r.double g = g'$. Therefore, $f$ is an epimorphism

]
#pagebreak(weak:true)
== Homework2
<homework2>
#aside("Exercise", title:[A4.2])[
Show that $cal(A)^(o p)$ is an abelian category if $cal(A)$ is an abelian category

]
#proof(title: "Proof")[
$H o m_(cal(A)^(o p))\(X\,Y\)$ has an obvious abelian group structure with addition $f^(o p) + g^(o p) =\(f + g\)^(o p)$, $0^(o p)$ being the zero morphism, the inverse of $f^(o p)$ being $\(- f\)^(o p)$, $f^(o p)\(g^(o p) + h^(o p)\)= f^(o p) g^(o p) + f^(o p) h^(o p)$ and $\(g^(o p) + h^(o p)\)f^(o p) = g^(o p) g^(o p) + h^(o p) f^(o p)$. Thus $cal(A)^(o p)$ has an $A b$ structure

Since $cal(A)$ is an abelian category, $0$ is the zero object in $cal(A)^(o p)$, for any $A_1\,dots.h.c\,A_n in o b cal(A)^(o p)$, suppose $\(xor.big A_i\,pi_i\,iota_i\)$ is the biproduct in $cal(A)$, then $\(xor.big A_i\,iota_i^(o p)\,pi_i^(o p)\)$ is the biproduct in $cal(A)^(o p)$. Hence $cal(A)^(o p)$ is additive

Since $cal(A)$ is an abelian category, for any morphism $f^(o p) : A arrow.r B$ in $H o m_(cal(A)^(o p))\(A\,B\)$, suppose $\(ker f\,i\)$ is the kernel and $\(upright(c o k e r) f\,pi\)$ is the cokernel of $f : B arrow.r A$, then $\(ker f\,i^(o p)\)$ is the cokernel and $\(upright(c o k e r) f\,pi^(o p)\)$ is the kernel of $f^(o p)$. For any monomorphism $e^(o p) : A arrow.r B$ and any epimorphism $m^(o p) : A arrow.r B$, suppose $e$ is the cokernel of its kernel $i : C arrow.r B$, $m$ is the kernel of its cokernel $pi : A arrow.r D$, then $e^(o p)$ is the kernel of its cokernel $i^(o p) : B arrow.r C$, $m^(o p)$ is the cokernel of its kernel $pi^(o p) : D arrow.r A$. Hence $cal(A)^(o p)$ is an abelian category

]
#aside("Exercise", title:[A4.3])[
Given a category $I$ and an abelian category $cal(A)$, show that the functor category $cal(A)^I$ is also an abelian category and that the kernel of $eta : B arrow.r C$ is the functor $A$, $A\(i\)= ker\(eta_i\)$

]
#proof(title: "Proof")[
Suppose $eta\,xi in H o m_(cal(A)^I)\(B\,C\)$ are natural transformations, define addition $\(eta + xi\)_i = eta_i + xi_i$, then $0 = { 0_i }$ is the zero morphism, $- eta = { - eta_i }$ is the inverse of $eta$, $\(eta + xi\)mu = eta mu + xi mu$ and $eta\(xi + mu\)= eta xi + eta mu$. Thus $cal(A)^I$ has an $A b$ structure

Constant functor $K_0 in o b cal(A)^I\,$ $K_0\(B\)= 0$, $K\(f\)= 0$ is the zero object in $cal(A)^I$. For any functors $B\,C in o b cal(A)^I$, $\(B times C\,pi_B\,pi_C\)$ is the product, where $\(B times C\)\(i\)= B\(i\)times C\(i\)$, $\(pi_B\)_i = pi_(B\(i\))$, $\(pi_C\)_i = pi_(C\(i\))$. Hence $cal(A)^I$ is additive

Now let's show $A$ is the kernel of $eta : B arrow.r C$, note that morphism $A\(f\)$ is defined by the following commutative diagram because $eta_j B\(f\)iota_i = C\(f\)eta_i iota_i$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$ker eta_i$]),
node((1,0),[$B_i$]),
node((2,0),[$C_i$]),
node((0,1),[$ker eta_j$]),
node((1,1),[$B_j$]),
node((2,1),[$C_j$]),
edge((0,0),(1,0),"hook->",[$iota_i$]),
edge((0,0),(0,1),"->",[$exists_1 A\(f\)$],stroke:(dash:"dashed")),
edge((1,0),(2,0),"->",[$eta_i$]),
edge((1,0),(1,1),"->",[$B\(f\)$]),
edge((2,0),(2,1),"->",[$C\(f\)$]),
edge((0,1),(1,1),"hook->",[$iota_j$]),
edge((1,1),(2,1),"->",[$eta_j$]))]
]
Suppose $A' in o b cal(A)^I$ is another functor making the following diagram commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A'$]),
node((0,1),[$B$]),
node((1,1),[$C$]),
edge((0,0),(0,1),"->",[$xi$]),
edge((0,0),(1,1),"->",[$eta xi$]),
edge((0,1),(1,1),"->",[$eta$]))]
]
There are unique morphisms $mu_i$'s making the following diagram commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A'_i$]),
node((0,1),[$ker eta_i$]),
node((1,1),[$B_i$]),
node((2,1),[$C_i$]),
edge((1,0),(1,1),"->",[$xi_i$]),
edge((1,0),(2,1),"->",[$eta_i xi_i$]),
edge((1,0),(0,1),"->",[$exists_1 mu_i$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$eta_i$]))]
]
Which gives the unique natural transformation $mu : A' arrow.r A$ making the diagram commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A'$]),
node((0,1),[$A$]),
node((1,1),[$B$]),
node((2,1),[$C$]),
edge((1,0),(1,1),"->",[$xi$]),
edge((1,0),(2,1),"->",[$eta xi$]),
edge((1,0),(0,1),"->",[$exists_1 mu$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$eta$]))]
]
Hence $A$ is indeed the kernel of $eta : B arrow.r C$

Similarly, the cokernel of $eta : B arrow.r C$ would be functor $D$, $D\(i\)= upright(c o k e r)\(eta_i\)$, $D\(f\)$ is defined by the following commutative diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B_i$]),
node((1,0),[$C_i$]),
node((2,0),[$upright(c o k e r) eta_i$]),
node((0,1),[$B_j$]),
node((1,1),[$C_j$]),
node((2,1),[$upright(c o k e r) eta_j$]),
edge((0,0),(1,0),"->",[$eta_i$]),
edge((0,0),(0,1),"->",[$B\(f\)$]),
edge((1,0),(1,1),"->",[$C\(f\)$]),
edge((1,0),(2,0),"->>",[$pi_i$]),
edge((2,0),(2,1),"->",[$exists_1 D\(f\)$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->",[$eta_j$]),
edge((1,1),(2,1),"->>",[$pi_j$]))]
]
Similarly, it is easy to verify that every monomorphism is the kernel of its cokernel and every epimorphism is the cokernel of its kernel. Hence $cal(A)^I$ is an abelian category

]
#aside("Exercise", title:[A5.1])[
Show that an abelian category is complete iff it has all products

]
#proof(title: "Proof")[
Let $cal(A)$ be an abelian category, $I$ be a small category and $F : I arrow.r cal(A)$ be a functor and $cal(A)$ contains all products

For $j arrow.r^f k in H o m\(j\,k\)$, let $phi.alt_f$ be the composition $product_(i in o b I) F\(i\)arrow.r^(pi_j) F\(j\)arrow.r^(F\(f\)) F\(k\)$, $psi_f$ be the composition $product_(i in o b I) F\(i\)arrow.r^(pi_k) F\(k\)arrow.r^(1_(F\(k\))) F\(k\)$, they induce two maps #math.equation(block: true, numbering: none, $phi.alt\,psi : product_(i in o b I) F\(i\)arrow.r product_f F\(k\)$) Write $\(E\,iota\)$ as the equalizer of $phi.alt\,psi$, $iota_j$ as the composition $E arrow.r^iota product_(i in o b I) F\(i\)arrow.r^(pi_j) F\(j\)$, then #math.equation(block: true, numbering: none, $F\(f\)iota_j = F\(f\)pi_j iota = phi.alt_f iota = pi_f phi.alt iota = pi_f psi iota = psi_f iota = 1_(F\(k\)) pi_k iota = pi_k iota = iota_k$)

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$E$]),
node((1,1),[$product_i F\(i\)$]),
node((0,2),[$F\(j\)$]),
node((2,2),[$F\(k\)$]),
edge((1,0),(1,1),"->",[$iota$]),
edge((1,0),(0,2),"->",[$iota_j$],bend:-15deg),
edge((1,0),(2,2),"->",[$iota_k$],bend:15deg),
edge((1,1),(0,2),"->",[$pi_j$]),
edge((1,1),(2,2),"->",[$pi_k$]),
edge((0,2),(2,2),"->",[$F\(f\)$]))]
]
Let's show $\(E\,iota_j\)$ is the limit $lim_arrow.l F$

Given a commutative digram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A$]),
node((0,1),[$F\(j\)$]),
node((2,1),[$F\(k\)$]),
edge((1,0),(0,1),"->",[$alpha_j$]),
edge((1,0),(2,1),"->",[$alpha_k$]),
edge((0,1),(2,1),"->",[$F\(f\)$]))]
]
Which induce unique $eta : A arrow.r product_i F\(i\)$, $xi : A arrow.r product_f F\(k\)$ such that $pi_j eta = alpha_j$, $pi_f xi = alpha_k$, then we have a commutative diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((0,1),[$product_i F\(i\)$]),
node((1,1),[$product_f F\(k\)$]),
edge((0,0),(0,1),"->",[$eta$]),
edge((0,0),(1,1),"->",[$xi$]),
edge((0,1),(1,1),"->",[$phi.alt$],shift:2pt),
edge((0,1),(1,1),"->",[$psi$],shift:-2pt))]
]
Since #math.equation(block: true, numbering: none, $pi_f phi.alt eta = phi.alt_f eta = F\(f\)pi_j eta = F\(f\)alpha_j = alpha_k = pi_f xi arrow.r.double phi.alt eta = xi$) And #math.equation(block: true, numbering: none, $pi_f psi eta = psi_f eta = 1_(F\(k\)) pi_k eta = pi_k eta = alpha_k = pi_f xi arrow.r.double psi eta = xi$) Which induces unique $zeta : A arrow.r E$ such that $iota zeta = eta$, $iota_j zeta = pi_j iota zeta = pi_j eta = alpha_j$, suppose $zeta' : A arrow.r E$ is another map such that $iota_j zeta' = alpha_j$, then $iota_i zeta' = pi_i iota zeta' = alpha_j = pi_j eta arrow.r.double zeta' = eta arrow.r.double zeta' = zeta$

]
#aside("Exercise", title:[A6.1])[
Fix categories $I$ and $cal(A)$. When every functor $F : I arrow.r cal(A)$ has a limit, show that $lim : cal(A)^I arrow.r cal(A)$ is a functor. Show that the universal property of $lim F_i$ is nothing more than the assertion that $lim$ is right adjoint to $Delta$. Dually, show that the universal property of $upright(c o l i m) F_i$ is nothing more than the assertion that $upright(c o l i m) : cal(A)^I arrow.r cal(A)$ is the left adjoint to $Delta$

]
#proof(title: "Proof")[
Suppose $eta : F arrow.r G$ is a natural transformation, then we have morphisms $lim_arrow.l F arrow.r F\(i\)arrow.r^(eta_i) G\(i\)$ which induces uniquely a morphism $lim_arrow.l eta : lim_arrow.l F arrow.r lim_arrow.l G$, it is obvious that $lim_arrow.l\(1_F\)= 1_(lim_arrow.l F)$, $lim_arrow.l\(eta xi\)= lim_arrow.l\(eta\)lim_arrow.l\(xi\)$. Hence $lim_arrow.l : cal(A)^I arrow.r cal(A)$ is a functor

Suppose $eta in H o m_(cal(A)^I)\(Delta A\,F\)$ is a natural transformation, we have morphisms $eta_i : A arrow.r F\(i\)$, which induces uniquely a morphism $lim_arrow.l eta : A arrow.r lim_arrow.l F$, conversely, if we have a morphism $phi.alt : A arrow.r lim_arrow.l F$, then we have morphisms $eta_i : A arrow.r lim_arrow.l F arrow.r F\(i\)$, this gives a natural transformation $eta : Delta A arrow.r F$. Therefore $eta arrow.r lim_arrow.l eta$ is a bijective correspondence, this correspondence is natural since for any $B arrow.r^f A$ and $F arrow.r^xi G$ the following diagram commutes

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m_(cal(A)^I)\(Delta A\,F\)$]),
node((3,0),[$H o m_(cal(A))\(A\,lim_arrow.l F\)$]),
node((1,1),[$eta$]),
node((2,1),[$lim_arrow.l eta$]),
node((1,2),[$xi eta f$]),
node((2,2),[$lim_arrow.l xi lim_arrow.l eta f$]),
node((0,3),[$H o m_(cal(A)^I)\(Delta B\,G\)$]),
node((3,3),[$H o m_(cal(A))\(B\,lim_arrow.l G\)$]),
edge((0,0),(0,3),"->"),
edge((0,0),(3,0),"->"),
edge((3,0),(3,3),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((1,2),(2,2),"->"),
edge((0,3),(3,3),"->"))]
]
Hence $lim_arrow.l$ is the right adjoint of $Delta$, dually, it is easy to show $lim_arrow.r$ is the left adjoint of $Delta$

]
#aside("Exercise", title:[A6.2])[
Suppose given functor $L : cal(A) arrow.r cal(B)$, $R : cal(B) arrow.r cal(A)$ and natural transformations $eta : upright(i d)_(cal(A)) arrow.r.double R L$, $epsilon : L R arrow.r.double upright(i d)_(cal(B))$ such that the composites $L X arrow.r^(L\(eta_X\)) L R L X arrow.r^(epsilon_(L X)) L X$, $R Y arrow.r^(eta_(R Y)) R L R Y arrow.r^(R\(epsilon_Y\)) R Y$ are the identities. Show that $\(L\,R\)$ is an adjoint pair of functions

]
#proof(title: "Proof")[
We have a bijective correspondence between $H o m_(cal(B))\(L X\,Y\)$ and $H o m_(cal(A))\(X\,R Y\)$ giving by commutative diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$H o m_(cal(A))\(R L X\,R Y\)$]),
node((0,1),[$H o m_(cal(B))\(L X\,Y\)$]),
node((2,1),[$H o m_(cal(A))\(X\,R Y\)$]),
node((1,2),[$H o m_(cal(B))\(L X\,L R Y\)$]),
edge((1,0),(2,1),"->",[$eta_X^(*)$]),
edge((0,1),(1,0),"->",[$R$]),
edge((2,1),(1,2),"->",[$L$]),
edge((1,2),(0,1),"->",[$epsilon_(Y *)$]))]
]
Since #math.equation(block: true, numbering: none, $epsilon_Y compose L\(R\(f\)compose eta_X\)= epsilon_Y compose L R\(f\)compose L\(eta_X\)= f compose epsilon_(L X) compose L\(eta_X\)= f compose 1_(L X) = f$) #math.equation(block: true, numbering: none, $R\(epsilon_Y compose L\(g\)\)compose eta_X = R\(epsilon_Y\)compose R L\(g\)compose eta_X = R\(epsilon_Y\)compose eta_(R Y) compose g = 1_(R Y) compose g = g$) The bijective correspondence is natural by the following commutative diagram for any given $alpha : X' arrow.r X$, $beta : Y arrow.r Y'$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m_(cal(B))\(L X\,Y\)$]),
node((1,0),[$H o m_(cal(A))\(X\,R Y\)$]),
node((0,1),[$H o m_(cal(B))\(L X'\,Y'\)$]),
node((1,1),[$H o m_(cal(A))\(X'\,R Y'\)$]),
edge((0,0),(0,1),"->",[$beta_(*)\(L alpha\)^(*)$]),
edge((0,0),(1,0),"->",[$Phi_(X\,Y)$]),
edge((1,0),(1,1),"->",[$\(R beta\)_(*) alpha^(*)$]),
edge((0,1),(1,1),"->",[$Phi_(X'\,Y')$]))]
]
Since #math.equation(block: true, numbering: none, $R\(beta compose f compose L\(alpha\)compose eta_(X')\)= R\(beta\)compose R\(f\)compose R L\(alpha eta_(X')\)= R\(beta\)compose R\(f\)compose eta_X compose alpha$) Therefore $\(L\,R\)$ is an adjoint pair of functors

]
#aside("Exercise", title:[1.2.5])[
Given an elementary proof that $T o t\(C\)$ is acyclic whenever $C$ is a bounded double complex with exact rows(or exact columns). We will see later that this result follows from the Acyclic Assembly Lemma 2.7.3. It also follows from a spectral sequence argument(see Definition 5.6.2 and exercise 5.6.4)

]
#proof(title: "Proof")[
Without loss of generality, we may assume $C$ is bounded in the first quadrant and has exact rows, use $d'\,d''\,d$ to denote row, column and total differentials

$T o t\(C\)$ is exact for all $n < 0$ since $T o t\(C\)_n = 0$ for all $n < 0$. now suppose $n gt.eq 0$, $d (sum_(k = 0)^n x_(k\,n - k)) = 0$, i.e. $d' x_(k + 1\,n - k - 1) + d'' x_(k\,n - k) = 0$ for $0 lt.eq k < n$. Let $x_(0\,n + 1) = 0$, we can construct $x_(k\,n + 1 - k)$ for $k > 0$ inductively such that $d'' x_(k\,n - k + 1) + d' x_(k + 1\,n - k) = x_(k\,n - k)$ for $0 lt.eq k lt.eq n$ as follow:

For $k gt.eq - 1$ #math.equation(block: true, numbering: none, $d'\(x_(k + 1\,n - k - 1) - d'' x_(k + 1\,n - k)\) & = d' x_(k + 1\,n - k - 1) - d' d'' x_(k + 1\,n - k)\
 & = d' x_(k + 1\,n - k - 1) + d'' d' x_(k + 1\,n - k)\
 & = d' x_(k + 1\,n - k - 1) + d''\(d'' x_(k\,n - k + 1) + d' x_(k + 1\,n - k)\)\
 & = d' x_(k + 1\,n - k - 1) + d'' x_(k\,n - k)\
 & = 0$) By exactness of rows, there exists $x_(k + 2\,n - k - 1)$ such that #math.equation(block: true, numbering: none, $d' x_(k + 2\,n - k - 1) = x_(k + 1\,n - k - 1) - d'' x_(k + 1\,n - k) arrow.l.r.double d'' x_(k + 1\,n - k) + d' x_(k + 2\,n - k - 1) = x_(k + 1\,n - k - 1)$) Therefore #math.equation(block: true, numbering: none, $d (sum_(k = 0)^(n + 1) x_(k\,n + 1 - k)) & = sum_(k = 1)^(n + 1)\(d' x_(k\,n + 1 - k) + d'' x_(k\,n + 1 - k)\)\
 & = sum_(k = 1)^(n + 1)\(x_(k - 1\,n - k + 1) - d'' x_(k - 1\,n - k + 2) + d'' x_(k\,n + 1 - k)\)\
 & = sum_(k = 0)^n\(x_(k\,n - k) - d'' x_(k\,n - k + 1)\)+ sum_(k = 1)^(n + 1) d'' x_(k\,n + 1 - k)\
 & = sum_(k = 0)^n x_(k\,n - k)$)

]
#aside("Exercise", title:[1.2.7])[
If $C$ is a complex, show that there are exact sequences of complexes: #math.equation(block: true, numbering: none, $0 arrow.r Z\(C\)arrow.r C arrow.r^d B\(C\)\[- 1\]arrow.r 0$) #math.equation(block: true, numbering: none, $0 arrow.r H\(C\)arrow.r C\/B\(C\)arrow.r^d Z\(C\)\[- 1\]arrow.r H\(C\)\[- 1\]arrow.r 0$)

]
#proof(title: "Proof")[
Let $Z_i arrow.r.hook C_i$ be the kernel of $C_i arrow.r^partial C_(i - 1)$ and $C_i arrow.r B_(i - 1) = B\[- 1\]_i$ be the image of $C_i arrow.r^partial C_(i - 1)$, then $0 arrow.r Z_i arrow.r C_i arrow.r B_(i - 1) arrow.r 0$ are exact sequences, and we get a commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$0$]),
node((2,0),[$0$]),
node((3,0),[$0$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$Z_2$]),
node((2,1),[$Z_1$]),
node((3,1),[$Z_0$]),
node((4,1),[$dots.h.c$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$C_2$]),
node((2,2),[$C_1$]),
node((3,2),[$C_0$]),
node((4,2),[$dots.h.c$]),
node((0,3),[$dots.h.c$]),
node((1,3),[$B_1$]),
node((2,3),[$B_0$]),
node((3,3),[$B_(- 1)$]),
node((4,3),[$dots.h.c$]),
node((1,4),[$0$]),
node((2,4),[$0$]),
node((3,4),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$partial$]),
edge((1,1),(1,2),"hook->"),
edge((2,1),(3,1),"->",[$partial$]),
edge((2,1),(2,2),"hook->"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"hook->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$partial$]),
edge((1,2),(1,3),"->>",[$partial$]),
edge((2,2),(3,2),"->",[$partial$]),
edge((2,2),(2,3),"->>",[$partial$]),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->>",[$partial$]),
edge((0,3),(1,3),"->"),
edge((1,3),(2,3),"->",[$- partial$]),
edge((1,3),(1,4),"->"),
edge((2,3),(3,3),"->",[$- partial$]),
edge((2,3),(2,4),"->"),
edge((3,3),(4,3),"->"),
edge((3,3),(3,4),"->"))]
]
Hence we have an exact sequence of complexes #math.equation(block: true, numbering: none, $0 arrow.r Z\(C\)arrow.r C arrow.r^d B\(C\)\[- 1\]arrow.r 0$) Consider the following commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$B_i$]),
node((2,0),[$B_i$]),
node((3,0),[$Z_i$]),
node((4,0),[$B_(i - 1)$]),
node((1,1),[$Z_i$]),
node((2,1),[$C_i$]),
node((3,1),[$C_i$]),
node((4,1),[$Z_(i - 1)$]),
node((0,2),[$0$]),
node((1,2),[$Z_i\/B_i$]),
node((2,2),[$C_i\/B_i$]),
node((3,2),[$C_i\/Z_i$]),
node((4,2),[$Z_(i - 1)\/B_(i - 1)$]),
node((5,2),[$0$]),
edge((1,0),(1,1),"hook->"),
edge((1,0),(2,0),"="),
edge((2,0),(2,1),"hook->"),
edge((2,0),(3,0),"hook->"),
edge((3,0),(3,1),"hook->"),
edge((3,0),(4,0),"->",[$partial$]),
edge((4,0),(4,1),"hook->"),
edge((1,1),(1,2),"->>"),
edge((1,1),(2,1),"hook->"),
edge((2,1),(2,2),"->>"),
edge((2,1),(3,1),"="),
edge((3,1),(3,2),"->>"),
edge((3,1),(4,0),"->",[$partial$]),
edge((4,1),(4,2),"->>"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",stroke:(dash:"dashed")),
edge((2,2),(3,2),"->",stroke:(dash:"dashed")),
edge((3,2),(4,0),"->",stroke:(dash:"dashed")),
edge((4,2),(5,2),"->"))]
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$B_i$]),
node((2,0),[$B_i$]),
node((3,0),[$Z_i$]),
node((4,0),[$B_(i - 1)$]),
node((1,1),[$Z_i$]),
node((2,1),[$C_i$]),
node((3,1),[$C_i$]),
node((4,1),[$Z_(i - 1)$]),
node((0,2),[$0$]),
node((1,2),[$Z_i\/B_i$]),
node((2,2),[$C_i\/B_i$]),
node((3,2),[$C_i\/Z_i$]),
node((4,2),[$Z_(i - 1)\/B_(i - 1)$]),
node((5,2),[$0$]),
edge((1,0),(1,1),"hook->"),
edge((1,0),(2,0),"="),
edge((2,0),(2,1),"hook->"),
edge((2,0),(3,0),"hook->"),
edge((3,0),(3,1),"hook->"),
edge((3,0),(4,0),"->",[$partial$]),
edge((4,0),(4,1),"hook->"),
edge((1,1),(1,2),"->>"),
edge((1,1),(2,1),"hook->"),
edge((2,1),(2,2),"->>"),
edge((2,1),(3,1),"="),
edge((3,1),(3,2),"->>"),
edge((3,1),(4,0),"->",[$partial$]),
edge((4,1),(4,2),"->>"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",stroke:(dash:"dashed")),
edge((2,2),(3,2),"->",stroke:(dash:"dashed")),
edge((2,2),(4,1),"->",[$d$],stroke:(dash:"dashed"),bend:-15deg),
edge((3,2),(4,0),"->",stroke:(dash:"dashed")),
edge((4,2),(5,2),"->"))]
]
We get an exact sequence $0 arrow.r H_i arrow.r C_i\/B_i arrow.r^d Z_(i - 1) arrow.r H_(i - 1) arrow.r 0$, and thus an exact sequence of complexes #math.equation(block: true, numbering: none, $0 arrow.r H\(C\)arrow.r C\/B\(C\)arrow.r^d Z\(C\)\[- 1\]arrow.r H\(C\)\[- 1\]arrow.r 0$)

]
#aside("Exercise", title:[1.3.1])[
Let $0 arrow.r A arrow.r B arrow.r C arrow.r 0$ be a short exact sequence of complexes. Show that if two of the three complexes $A\,B\,C$ are exact, then so is the third

]
#proof(title: "Proof")[
Since we have a long exact sequence #math.equation(block: true, numbering: none, $dots.h.c arrow.r H_n A arrow.r H_n B arrow.r H_n C arrow.r^partial H_(n - 1) A arrow.r H_(n - 1) B arrow.r H_(n - 1) C arrow.r dots.h.c$) If either two of complexes of $A\,B\,C$ are exact, then their homologies vanish, thus the homologies of the third one also vanishes, i.e. the third complex is exact

]
#pagebreak(weak:true)
== Homework3
<homework3>
#aside("Exercise", title:[1.3.2])[
\($3 times 3$ lemma) Suppose given a commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$0$]),
node((2,0),[$0$]),
node((3,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$A$]),
node((2,1),[$B$]),
node((3,1),[$C$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$A'$]),
node((2,2),[$B'$]),
node((3,2),[$C'$]),
node((4,2),[$0$]),
node((0,3),[$0$]),
node((1,3),[$A''$]),
node((2,3),[$B''$]),
node((3,3),[$C''$]),
node((4,3),[$0$]),
node((1,4),[$0$]),
node((2,4),[$0$]),
node((3,4),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$u$]),
edge((1,1),(1,2),"->",[$a$]),
edge((2,1),(3,1),"->",[$v$]),
edge((2,1),(2,2),"->",[$b$]),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->",[$c$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$u'$]),
edge((1,2),(1,3),"->",[$a'$]),
edge((2,2),(3,2),"->",[$v'$]),
edge((2,2),(2,3),"->",[$b'$]),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->",[$c'$]),
edge((0,3),(1,3),"->"),
edge((1,3),(1,4),"->"),
edge((1,3),(2,3),"->",[$u''$]),
edge((2,3),(2,4),"->"),
edge((2,3),(3,3),"->",[$v''$]),
edge((3,3),(4,3),"->"),
edge((3,3),(3,4),"->"))]
]
In an abelian category, such that every column is exact. Show the following:

\1. If the bottom two rows are exact, so is the top row

\2. If the top two rows are exact, so is the bottom row

\3. If the top and bottom rows are exact, and the composite $A' arrow.r C'$ is zero, the middle row is also exact

Hint: Show the remaining row is a complex, and apply exercise 1.3.1

]
#proof(title: "Proof")[
\1. Since third column is exact, $C = ker c$, $c\(v u\)= v' b u =\(v' u'\)a = 0$, $A arrow.r^0 C' arrow.r C''$ must induce the unique map $A arrow.r C$ which is $0 = v u$, i.e. the first row is a complex

\2. Since first column is exact, $A'' = upright(c o k e r) a$, $\(v'' u''\)a' = v'' b' u' = c'\(v' u'\)= 0$, $A arrow.r A' arrow.r^0 C''$ must induce the unique map $A'' arrow.r C''$ which is $0 = v'' u''$, i.e. the third row is a complex

\3. If composite $A' arrow.r C'$ is zero, then the second row is a complex

Finally, apply exercise 1.3.1, two of three exact implies the remaining one is also exact

]
#aside("Exercise", title:[1.3.3])[
\($5$-Lemma) In any commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A'$]),
node((1,0),[$B'$]),
node((2,0),[$C'$]),
node((3,0),[$D'$]),
node((4,0),[$E'$]),
node((0,1),[$A$]),
node((1,1),[$B$]),
node((2,1),[$C$]),
node((3,1),[$D$]),
node((4,1),[$E$]),
edge((0,0),(1,0),"->",[$u'$]),
edge((0,0),(0,1),"->",[$a$ \ $tilde.equiv$]),
edge((1,0),(2,0),"->",[$v'$]),
edge((1,0),(1,1),"->",[$b$ \ $tilde.equiv$]),
edge((2,0),(3,0),"->",[$w'$]),
edge((2,0),(2,1),"->",[$c$]),
edge((3,0),(4,0),"->",[$x'$]),
edge((3,0),(3,1),"->",[$d$ \ $tilde.equiv$]),
edge((4,0),(4,1),"->",[$e$ \ $tilde.equiv$]),
edge((0,1),(1,1),"->",[$u$]),
edge((1,1),(2,1),"->",[$v$]),
edge((2,1),(3,1),"->",[$w$]),
edge((3,1),(4,1),"->",[$x$]))]
]
With exact rows in any abelian category, show that if $a\,b\,d$ and $e$ are isomorphisms, then $c$ is also an isomorphism. More precisely, show that if $b$ and $d$ are monic and $a$ is an epi, then $c$ is monic. Dually, show that if $b$ and $d$ are epis and $e$ is monic, then $c$ is an epi

]
#proof(title: "Proof")[
Since rows are exact, we can apply snake lemma on following commutative diagrams

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A'$]),
node((2,0),[$B'$]),
node((3,0),[$upright(i m) v' = ker w'$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$A$]),
node((2,1),[$B$]),
node((3,1),[$C$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->>"),
edge((2,0),(3,0),"->>"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((3,0),(4,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"))]
]
#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$C'$]),
node((2,0),[$D'$]),
node((3,0),[$E'$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$upright(c o k e r) v$]),
node((2,1),[$D$]),
node((3,1),[$E$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->>"),
edge((2,0),(2,1),"->>"),
edge((3,0),(3,1),"->"),
edge((3,0),(4,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"))]
]
Thus $upright(i m) v' = ker w' arrow.r C$ is monic, $C' arrow.r upright(i m) v = ker w$ is epi

Suppose $Y arrow.r^y C'$ satisfies $c y = 0$, then $0 = w c y = d\(w' y\)$, since $d$ is monic, $w' y = 0$ which induce $Y arrow.r^(y') ker w' = upright(i m) v'$, then $Y arrow.r^(y') ker w' arrow.r C$ is zero implies $y' = 0$ which in turn implies $y = 0$, i.e. $c$ is monic

Suppose $C arrow.r^z Z$ satisfies $z c = 0$, then $0 = z c v' =\(z v\)b$, since $b$ is epi, $z v = 0$ which induce $upright(c o k e r) v arrow.r^(z') Z$, then $C' arrow.r upright(c o k e r) v arrow.r^(z') C$ is zero implies $z' = 0$ which in turn implies $z = 0$, i.e. $c$ is epi

]
#aside("Exercise", title:[1.4.1])[
The previous example shows that even an acyclic chain complex of free $R$-modules need not to split exact

\1. Show that acyclic bounded below chain complexes of free $R$ modules are always split exact

\2. Show that an acyclic chain complex of finitely generated free abelian groups is always split exact, even when it is not bounded below

]
#proof(title: "Proof")[
\1. Suppose $dots.h.c arrow.r F_2 arrow.r^(partial_2) F_1 arrow.r^(partial_1) F_0 arrow.r 0$ is an acyclic chain complex of free $R$-modules, since $partial_1$ is surjective, we can define $s_0 : F_0 arrow.r F_1$ sending each generator of $F_0$ to a preimage, then $partial_1 s_0 partial_1 = partial_1$

Now let's construct $s_n : F_n arrow.r F_(n + 1)$ inductively that satisfying $partial_(n + 1) = partial_(n + 1) s_n partial_(n + 1)$

Suppose we have already constructed $s_(n - 1)$, we claim $F_n = partial_(n + 1)\(F_(n + 1)\)xor s_(n - 1) partial_n\(F_n\)$: if $partial_(n + 1)\(a_(n + 1)\)= s_(n - 1) partial_n\(a_n\)$, then $partial_n a_n = partial_n s_(n - 1) partial_n a_n = partial_n partial_(n + 1)\(a_(n + 1)\)= 0 arrow.r.double s_(n - 1) partial_n\(a_n\)= 0$. For any $a_n in F_n$, $partial_n\(a_n - s_(n - 1) partial_n\(a_1\)\)= 0 arrow.r.double a_n - s_(n - 1) partial_n\(a_n\)in ker partial_n = upright(i m) partial_(n + 1)$

Define $s_n : F_n arrow.r F_(n + 1)$, sending each generator of $F_n$ to a preimage of its direct sum part in $partial_(n + 1)\(F_(n + 1)\)$, then $partial_(n + 1) = partial_(n + 1) s_n partial_(n + 1)$

\2. In the case of finitely generated free abelian groups, subgroups $partial_n\(F_n\)$ are also finitely generated free abelian, we can define $s_(n - 1) : partial_n\(F_n\)arrow.r F_n$ by sending each generator of $partial_n\(F_n\)$ to a preimage, then $partial_n = partial_n s_(n - 1) partial_n$, similarly we have $F_n = partial_(n + 1)\(F_(n + 1)\)xor s_(n - 1) partial_n\(F_n\)$, thus $partial_(n + 1)\(F_(n + 1)\)$ is a direct summand of $F_n$, thus we can extend $s_n$ such that $s_n : F_n arrow.r F_(n + 1)$ with $s_n\(s_(n - 1) partial_n\(F_n\)\)= 0$, we still have $partial_(n + 1) = partial_(n + 1) s_n partial_(n + 1)$

]
#aside("Exercise", title:[1.4.2])[
Let $C$ be a chain complex, with boundaries $B_n$ and cycles $Z_n$ in $C_n$. Show that $C$ split if and only if there are $R$-module decompositions $C_n tilde.equiv Z_n xor B'_n$ and $Z_n tilde.equiv B_n xor H'_n$. Show that $C$ is split exact iff $H'_n = 0$

]
#proof(title: "Proof")[
If $C_n tilde.equiv Z_n xor B'_n$ and $Z_n tilde.equiv B_n xor H'_n$, claim that any element in $B_n$ has a unique preimage in $B'_(n + 1)$: if $x\,y in B'_(n + 1)$ are such that $partial_(n + 1) x = partial_(n + 1) y$, then $partial_(n + 1)\(x - y\)= 0 arrow.r.double\(x - y\)in Z_(n + 1) inter B'_(n + 1) = 0 arrow.r.double x = y$

Hence we can define a unique bijective homomorphism $s_n : B_n arrow.r B'_(n + 1)$ sending elements to its preimage, then extend $s_n$ to $s_n : C_n arrow.r C_(n + 1)$ such that $s_n\(C_n\)= B'_(n + 1)$, $s_n\(H'_n xor B'_n\)= 0$, then $partial_(n + 1) s_n partial_(n + 1) = partial_(n + 1)$, i.e. $C$ split

If $C$ split, denote $B'_n = s_(n - 1) partial_n\(C_n\)$, $H'_n = ker partial_(n + 1) s_n inter Z_n$, we claim $C_n = Z_n xor B'_n$ and $Z_n = B_n xor H'_n$: For any $s_(n - 1) partial_n\(a_n\)in Z_n$, $0 = partial_n\(s_(n - 1) partial_n\(a_n\)\)= partial_n a_n arrow.r.double s_(n - 1) partial_n\(a_n\)= 0$. For $a_n in C_n$, $partial_n\(a_n - s_(n - 1) partial_n\(a_n\)\)= 0$. For any $partial_(n + 1) a_(n + 1) in ker partial_(n + 1) s_n$, $partial_(n + 1)\(a_(n + 1)\)= partial_(n + 1) s_n partial_(n + 1)\(a_(n + 1)\)= 0$. For any $a_n in Z_n$, $a_n - partial_(n + 1) s_n\(a_n\)in ker partial_(n + 1) s_n inter Z_n$

It is obvious that $C$ is exact $arrow.l.r.double$ $Z_n tilde.equiv B_n arrow.l.r.double H'_n = 0$

]
#aside("Exercise", title:[1.4.3])[
Show that $C$ is a split exact chain complex if and only if the identity map on $C$ is null homotopic

]
#proof(title: "Proof")[
Suppose the identity map on $C$ is null homotopic, then there exists $s_n : C_n arrow.r C_(n + 1)$ such that $1_(C_n) = s_(n - 1) partial_n + partial_(n + 1) s_n$, then $partial_n = partial_n s_(n - 1) partial_n$, i.e. $C$ split, for any $a_n in Z_n$, $a_n =\(s_(n - 1) partial_n + partial_(n + 1) s_n\)a_n = partial_(n + 1)\(s_n a_n\)in B_n$, i.e. $C$ is exact

Suppose $C$ split exact, according to exercise 1.4.2, $C_n tilde.equiv Z_n xor B'_n tilde.equiv B_n xor B'_n$ with $H'_n = 0$, then we can define $s_n : C_n arrow.r C_(n + 1)$ such that $s_n\(B_n\)= B'_(n + 1)$ bijective, $s_n\(H'_n xor B'_n\)= 0$, $partial_(n + 1) s_n partial_(n + 1) = partial_(n + 1)$, thus $B'_n = s_(n - 1)\(B_n\)= s_(n - 1) partial_n\(C_n\)$, $s_n s_(n - 1) partial_n\(C_n\)= s_n\(B'_n\)= 0$. Therefore for any element in $C_n$ which can be written as $partial_(n + 1) a_(n + 1) + s_(n - 1) partial_n a_n$, we have $\(s_(n - 1) partial_n + partial_(n + 1) s_n\)\(partial_(n + 1) a_(n + 1) + s_(n - 1) partial_n a_n\)= partial_(n + 1) a_(n + 1) + s_(n - 1) partial_n a_n$, i.e. $1_(C_n) = s_(n - 1) partial_n + partial_(n + 1) s_n$, the identity map on $C$ is nullhomotopic

]
#aside("Exercise", title:[1.5.1])[
Let $c o n e\(C\)$ denote the mapping cone of the identity map $i d_C$ of $C$\; it has $C_(n - 1) xor C_n$ in degree $n$. Show that $c o n e\(C\)$ is split exact, with $s\(b\,c\)=\(- c\,0\)$ defining the splitting map

]
#proof(title: "Proof")[
Suppose $mat(delim: "(", - partial, ; - 1, partial) vec(b, c) = vec(- partial b, - b + partial c) = 0$ for some $\(b\,c\)in c o n e\(C\)_n = C_(n - 1) xor C_n$, then $b = partial c$, $mat(delim: "(", - partial, ; - 1, - partial) vec(- c, 0) = vec(partial c, c) = vec(b, c)$, i.e. $c o n e\(C\)$ is exact, also $mat(delim: "(", - partial, ; - 1, - partial) s_n\(b\,c\)=\(b\,c\)$, i.e. $c o n e\(C\)$ split

]
#aside("Exercise", title:[1.5.2])[
Let $f : C arrow.r D$ be a map of complexes. Show that $f$ is null homotopic if and only if $f$ extends to a map $\(- s\,f\): c o n e\(C\)arrow.r D$

]
#proof(title: "Proof")[
Suppose $\(- s_(n - 1)\,f_n\): c o n e\(C\)_n arrow.r D_n$ are maps, then $\(- s\,f\)$ is chain map iff #math.equation(block: true, numbering: none, $mat(delim: "(", - s_(n - 1), f_n) mat(delim: "(", - partial_n, ; - 1_(C_n), partial_(n + 1)) vec(a_n, a_(n + 1)) = partial_(n + 1) mat(delim: "(", - s_n, f_(n + 1)) vec(a_n, a_(n + 1))$) Which equivalent to #math.equation(block: true, numbering: none, $\(s_(n - 1) partial_n + partial_(n + 1) s_n - f_n\)a_n =\(partial_(n + 1) f_(n + 1) - f_n partial_(n + 1)\)a_(n + 1) = 0$) Which equivalent to $s_(n - 1) partial_n + partial_(n + 1) s_n = f_n$, i.e. $f$ is null homotopic

]
#aside("Exercise", title:[\1.])[
Let $X$ denote the chain complex #math.equation(block: true, numbering: none, $dots.h.c arrow.r 0 arrow.r 0 arrow.r bb(Q) arrow.r^(upright(i d)) bb(Q) arrow.r 0 arrow.r 0 arrow.r dots.h.c$) With $X_1 = X_0 = bb(Q)$ and all other $X_i = 0$. Consider it in the category $cal(C)_(*)\(upright(bold(V e c t))_(bb(Q))\)$ of complexes of $bb(Q)$-vector spaces

#strong[\(a)] Compute the complex $upright(H o m)_bullet\(X\,X\)$

#strong[\(b)] Compute the homology $H_(*)\(upright(H o m)_bullet\(X\,X\)\)$ of the above complex

#strong[\(c)] Show that $X$ is not isomorphic to $0$ in $cal(C)\(upright(bold(V e c t))_(bb(Q))\)$, but $X$ is isomorphic to $0$ in the homotopy category $cal(K)\(upright(bold(V e c t))_(bb(Q))\)$

]
#proof(title: "Proof")[
#strong[\(a)] It is obvious that $H o m_n\(X\,X\)= 0$ for $\|n\|gt.eq 2$, $H o m_0\(X\,X\)= bb(Q) xor bb(Q)$, $H o m_1\(X\,X\)= H o m_(- 1)\(X\,X\)= bb(Q)$, and differentials are

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$0$]),
node((2,0),[$bb(Q)$]),
node((3,0),[$bb(Q) xor bb(Q)$]),
node((4,0),[$bb(Q)$]),
node((5,0),[$0$]),
node((6,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->",[$vec(1, 1)$]),
edge((3,0),(4,0),"->",[$vec(1 thin - 1)$]),
edge((4,0),(5,0),"->"),
edge((5,0),(6,0),"->"))]
]
#strong[\(b)] According to (a), it is not hard to see this is an exact sequence, hence $H_n\(upright(H o m)_bullet\(X\,X\)\)= 0$ for all $n$

#strong[\(c)] $X$ is not isomorphic to $0$ in $cal(C)\(upright(bold(V e c t))_(bb(Q))\)$ since $bb(Q) arrow.r 0 arrow.r bb(Q)$ can never be $1_(bb(Q))$, but $X arrow.r 0$ and $0 arrow.r X$ are actually inverses to each other in $cal(K)\(upright(bold(V e c t))_(bb(Q))\)$, we only need to show $X arrow.r^(1_X) X$ is null homotopic which is true due to the following diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Q)$]),
node((2,0),[$bb(Q)$]),
node((3,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$bb(Q)$]),
node((2,1),[$bb(Q)$]),
node((3,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$1_(bb(Q))$]),
edge((1,0),(1,1),"->",[$1_(bb(Q))$]),
edge((1,0),(0,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$1_(bb(Q))$]),
edge((2,0),(1,1),"->",[$1_(bb(Q))$]),
edge((3,0),(2,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$1_(bb(Q))$]),
edge((2,1),(3,1),"->"))]
]
Note that $1_(bb(Q)) = 1_(bb(Q)) compose 1_(bb(Q)) + 0 compose 0$, $1_(bb(Q)) = 0 compose 0 + 1_(bb(Q)) compose 1_(bb(Q))$

]
#aside("Exercise", title:[\2.])[
Suppose $cal(A)$ is an abelian category. In class, I defined the category $upright(bold(A r))\(cal(A)\)$ to be the full subcategory of $cal(C)_(*)\(cal(A)\)$ consisting of complexes of amplitude $\[0\,1\]$. We can think of objects in $upright(bold(A r))\(cal(A)\)$ as morphisms $f : M arrow.r N$ in $cal(A)$

I defined functors $F_0\,F_1 : cal(A) arrow.r upright(bold(A r))\(cal(A)\)$ where $F_i\(M\)$ is the complex $X_(*)$ with $X_i = M$ and $X_j = 0$ for all $j eq.not i$ (and $F_i\(phi.alt\): F_i\(M\)arrow.r F_i\(N\)$ is the obvious morphism induced by $phi.alt$)

#strong[\(a)] In class, I claimed that $F_1 : cal(A) arrow.r upright(bold(A r))\(cal(A)\)$ is left adjoint to the functor $ker : upright(bold(A r))\(cal(A)\)arrow.r cal(A)$ taking a morphism $f : M arrow.r N$ to $ker f$. Prove this

#strong[\(b)] Prove similarly that $F_0$ is right adjoint to the functor $upright(c o k e r) : upright(bold(A r))\(cal(A)\)arrow.r cal(A)$

#strong[\(c)] Suppose

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$A$]),
node((2,0),[$B$]),
node((3,0),[$C$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$A'$]),
node((2,1),[$B'$]),
node((3,1),[$C'$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$u$]),
edge((1,0),(1,1),"->",[$a$]),
edge((2,0),(3,0),"->",[$v$]),
edge((2,0),(2,1),"->",[$b$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->",[$c$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$u'$]),
edge((2,1),(3,1),"->",[$v'$]),
edge((3,1),(4,1),"->"))]
]
Is a commutative diagram with exact rows. Using (a) and (b), show that #math.equation(block: true, numbering: none, $0 arrow.r ker a arrow.r ker b arrow.r ker c$) And #math.equation(block: true, numbering: none, $upright(c o k e r) a arrow.r upright(c o k e r) b arrow.r upright(c o k e r) c arrow.r 0$) Are exact. (Obviously, don't use the proof of the Snake Lemma sketched in class)

]
#proof(title: "Proof")[
#strong[\(a)] For any $M arrow.r^f N in upright(bold(A r))\(cal(A)\)$, $W in cal(A)$, there is clearly bijective map $H o m\(F_1\(W\)\,M arrow.r^f N\)arrow.r H o m\(W\,ker f\)$ and $H o m$ given by the following diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$W$]),
node((2,0),[$0$]),
node((0,1),[$ker f$]),
node((1,1),[$M$]),
node((2,1),[$N$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(0,1),"->",stroke:(dash:"dashed")),
edge((2,0),(2,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$f$]))]
]
This bijective correspondence is natural due to the universal property of kernel and the following diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((2,0),[$W$]),
node((4,0),[$0$]),
node((3,1),[$W'$]),
node((5,1),[$0$]),
node((0,2),[$ker f$]),
node((2,2),[$M$]),
node((4,2),[$N$]),
node((1,3),[$ker f'$]),
node((3,3),[$M'$]),
node((5,3),[$N'$]),
edge((2,0),(2,2),"->"),
edge((2,0),(4,0),"->"),
edge((2,0),(0,2),"->",stroke:(dash:"dashed")),
edge((4,0),(4,2),"->"),
edge((3,1),(3,3),"->",bend:15deg),
edge((3,1),(5,1),"->"),
edge((3,1),(2,0),"->",[$g$]),
edge((3,1),(1,3),"->",stroke:(dash:"dashed"),bend:-15deg),
edge((5,1),(5,3),"->"),
edge((5,1),(4,0),"->"),
edge((0,2),(2,2),"->"),
edge((0,2),(1,3),"->",stroke:(dash:"dashed")),
edge((2,2),(4,2),"->",[$f$]),
edge((2,2),(3,3),"->"),
edge((4,2),(5,3),"->"),
edge((1,3),(3,3),"->"),
edge((3,3),(5,3),"->",[$f'$]))]
]
#strong[\(b)] For any $M arrow.r^f N in upright(bold(A r))\(cal(A)\)$, $W in cal(A)$, there is clearly bijective map $H o m\(upright(c o k e r) f\,W\)arrow.r H o m\(M arrow.r^f N\,F_0\(W\)\)$ and $H o m$ given by the following diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$M$]),
node((1,0),[$N$]),
node((2,0),[$upright(c o k e r) f$]),
node((0,1),[$0$]),
node((1,1),[$W$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(0,1),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(2,0),"->>"),
edge((2,0),(1,1),"->",stroke:(dash:"dashed")),
edge((0,1),(1,1),"->"))]
]
This bijective correspondence is natural due to the universal property of cokernel and the following diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$M$]),
node((2,0),[$N$]),
node((4,0),[$upright(c o k e r) f$]),
node((1,1),[$M'$]),
node((3,1),[$N'$]),
node((5,1),[$upright(c o k e r) f'$]),
node((0,2),[$0$]),
node((2,2),[$W$]),
node((1,3),[$0$]),
node((3,3),[$W'$]),
edge((0,0),(2,0),"->",[$f$]),
edge((0,0),(0,2),"->"),
edge((2,0),(2,2),"->",bend:-15deg),
edge((2,0),(4,0),"->>"),
edge((4,0),(2,2),"->",stroke:(dash:"dashed"),bend:15deg),
edge((1,1),(3,1),"->",[$f'$]),
edge((1,1),(1,3),"->"),
edge((1,1),(0,0),"->"),
edge((3,1),(5,1),"->>"),
edge((3,1),(3,3),"->"),
edge((3,1),(2,0),"->"),
edge((5,1),(4,0),"->",stroke:(dash:"dashed")),
edge((5,1),(3,3),"->",stroke:(dash:"dashed")),
edge((0,2),(2,2),"->"),
edge((0,2),(1,3),"->"),
edge((2,2),(3,3),"->",[$g$]),
edge((1,3),(3,3),"->"))]
]
#strong[\(c)] By (a), we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$ker a$]),
node((2,0),[$ker b$]),
node((0,1),[$M$]),
node((1,1),[$A$]),
node((2,1),[$B$]),
node((0,2),[$0$]),
node((1,2),[$A'$]),
node((2,2),[$B'$]),
edge((1,0),(2,0),"->",[$u_(*)$]),
edge((1,0),(1,1),"->",[$i_a$]),
edge((2,0),(2,1),"->",[$i_b$]),
edge((0,1),(1,1),"->"),
edge((0,1),(0,2),"->"),
edge((0,1),(1,0),"->",[$f$]),
edge((1,1),(1,2),"->",[$a$]),
edge((1,1),(2,1),"->",[$u$]),
edge((2,1),(2,2),"->",[$b$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$u'$]))]
]
If $u_(*) f = 0$, then $0 = i_b u_(*) f = u i_a f$, since $u\,i_a$ are monic, $f = 0$, i.e. $ker a arrow.r^(u_(*)) ker b$ is monic

By universal property of kernel, we know $ker a arrow.r^(u_(*)) ker b arrow.r^(v_(*)) ker c$ is zero, consider $v_(*) f = 0$ which induce unique $M arrow.r A$ and then induce unique $M arrow.r ker a$, by universal property of kernel, we know $ker a$ is $ker v_(*)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$ker a$]),
node((2,0),[$ker b$]),
node((3,0),[$ker c$]),
node((0,1),[$M$]),
node((1,1),[$A$]),
node((2,1),[$B$]),
node((3,1),[$C$]),
node((0,2),[$0$]),
node((1,2),[$A'$]),
node((2,2),[$B'$]),
node((3,2),[$C'$]),
edge((1,0),(2,0),"->",[$u_(*)$]),
edge((1,0),(1,1),"->",[$i_a$]),
edge((2,0),(3,0),"->",[$v_(*)$]),
edge((2,0),(2,1),"->",[$i_b$]),
edge((3,0),(3,1),"->",[$i_c$]),
edge((0,1),(0,2),"->"),
edge((0,1),(2,0),"->",[$f$],bend:15deg),
edge((0,1),(1,1),"->"),
edge((0,1),(1,0),"->",stroke:(dash:"dashed")),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->",[$a$]),
edge((2,1),(3,1),"->>",[$v$]),
edge((3,1),(3,2),"->",[$b$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((2,2),(3,2),"->>",[$v'$]))]
]
Hence $0 arrow.r ker a arrow.r ker b arrow.r ker c$ is exact

By (b), we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$C$]),
node((2,0),[$0$]),
node((0,1),[$B'$]),
node((1,1),[$C'$]),
node((2,1),[$M$]),
node((0,2),[$upright(c o k e r) b$]),
node((1,2),[$upright(c o k e r) c$]),
edge((0,0),(1,0),"->>",[$v$]),
edge((0,0),(0,1),"->",[$b$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->",[$b$]),
edge((2,0),(2,1),"->"),
edge((0,1),(1,1),"->>",[$v'$]),
edge((0,1),(0,2),"->>",[$pi_b$]),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->>",[$pi_c$]),
edge((0,2),(1,2),"->",[$v' ""^(*)$]),
edge((1,2),(2,1),"->",[$f$]))]
]
If $f v' ""^(*) = 0$, then $0 = f v' ""^(*) pi_b = f pi_c v'$, since $v'\,pi_c$ are epi, $f = 0$, i.e. $upright(c o k e r) b arrow.r^(v' ""^(*)) upright(c o k e r) c$ is epi

By universal property cokernel, we know $upright(c o k e r) a arrow.r^(u' ""^(*)) upright(c o k e r) b arrow.r^(v' ""^(*)) upright(c o k e r) c$ is zero, consider $f v' ""^(*) = 0$ which induce unique $C' arrow.r M$ and then induce unique $upright(c o k e r) c arrow.r M$, by universal property of cokernel, we know $upright(c o k e r) c$ is $upright(c o k e r) u' ""^(*)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$B$]),
node((2,0),[$C$]),
node((3,0),[$0$]),
node((0,1),[$A'$]),
node((1,1),[$B'$]),
node((2,1),[$C'$]),
node((3,1),[$M$]),
node((0,2),[$upright(c o k e r) a$]),
node((1,2),[$upright(c o k e r) b$]),
node((2,2),[$upright(c o k e r) c$]),
edge((0,0),(1,0),"->",[$u$]),
edge((0,0),(0,1),"->",[$a$]),
edge((1,0),(2,0),"->>",[$v$]),
edge((1,0),(1,1),"->",[$b$]),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$b$]),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->",[$u'$]),
edge((0,1),(0,2),"->>",[$pi_a$]),
edge((1,1),(2,1),"->>",[$v'$]),
edge((1,1),(1,2),"->>",[$pi_b$]),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->>",[$pi_c$]),
edge((0,2),(1,2),"->",[$u' ""^(*)$]),
edge((1,2),(2,2),"->",[$v' ""^(*)$]),
edge((1,2),(3,1),"->",[$f$],bend:-15deg),
edge((2,2),(3,1),"->",stroke:(dash:"dashed")))]
]
Hence $upright(c o k e r) a arrow.r upright(c o k e r) b arrow.r upright(c o k e r) c arrow.r 0$ is exact

]
#pagebreak(weak:true)
== Homework4
<homework4>
#aside("Exercise", title:[2.1.2])[
If $F : cal(A) arrow.r cal(B)$ is an exact functor, show that $T_0 = F$ and $T_n = 0$ for $n eq.not 0$ defines a universal $delta$-functor(of both homological and cohomological type)

]
#proof(title: "Proof")[
Since $F$ is exact, for any short exact sequence $0 arrow.r A arrow.r^f B arrow.r^g C arrow.r 0$, we get another short exact sequence $0 arrow.r F\(A\)arrow.r F\(B\)arrow.r F\(C\)arrow.r 0$, we can view this as a long exact sequence with $delta = 0$, thus $T$ is both a homological and cohomological $delta$ functor

Suppose $S_n$ is another homological or cohomological $delta$ functor, $S_0 arrow.r^phi.alt F$, $S^0 arrow.r^psi F$, then we have

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S_1 C$]),
node((1,0),[$S_0 A$]),
node((2,0),[$S_0 B$]),
node((3,0),[$S_0 C$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$F A$]),
node((2,1),[$F B$]),
node((3,1),[$F C$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->",[$delta_1$]),
edge((0,0),(0,1),"->"),
edge((1,0),(2,0),"->",[$S_0 f$]),
edge((1,0),(1,1),"->",[$phi.alt$]),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$phi.alt$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$F f$]),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$F A$]),
node((2,0),[$F B$]),
node((3,0),[$F C$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$S^0 A$]),
node((2,1),[$S^0 B$]),
node((3,1),[$S^0 C$]),
node((4,1),[$S^1 A$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"->",[$psi$]),
edge((2,0),(3,0),"->",[$F g$]),
edge((3,0),(3,1),"->",[$psi$]),
edge((3,0),(4,0),"->"),
edge((4,0),(4,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->",[$S^0 g$]),
edge((3,1),(4,1),"->",[$delta^0$]))]
]
$0 = phi.alt S_0 f delta_1 = F f phi.alt delta_1$ and $F f$ is monic $arrow.r.double$ $phi.alt delta_1 = 0$. $0 = delta^0 S^0 g psi = delta^0 psi F g$ and $F g$ is epi $arrow.r.double$ $delta^0 psi = 0$. Thus $T$ is both a universal homological and cohomological $delta$ functor

]
#aside("Exercise", title:[2.2.1])[
Show that a chain complex $P$ is a projective object in $C h$ if and only if it is a split exact complex of projectives. Hint: To see that $P$ must be split exact, consider the surjection from $c o n e\(upright(i d)_P\)$ to $P\[- 1\]$. To see that split exact complexes are projective objects, consider the special case $0 arrow.r P_1 tilde.equiv P_0 arrow.r 0$

]
#proof(title: "Proof")[
Consider chain complex $C$ with $C_n = P_n xor P_(n + 1)$ #math.equation(block: true, numbering: none, $dots.h.c arrow.r P_n xor P_(n + 1) arrow.r^(mat(delim: "(", partial, 0; 1, - partial)) P_(n - 1) xor P_n arrow.r dots.h.c$) and first coordinate projection

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$C$]),
node((1,0),[$P$]),
edge((0,0),(1,0),"->>"))]
which is a surjection, if $P$ is projective, then there exists $s$ such that

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$P$]),
node((0,1),[$C$]),
node((1,1),[$P$]),
edge((1,0),(0,1),"->",[$s$]),
edge((1,0),(1,1),"="),
edge((0,1),(1,1),"->>"))]
]
In order to make $s$ a chain map and the diagram commute, we must have $s : P_n arrow.r C_n$, $x arrow.r vec(x, s_n x)$ and #math.equation(block: true, numbering: none, $vec(partial_n x, s_(n - 1) partial_n x) = mat(delim: "(", partial_n, 0; 1, - partial_(n + 1)) vec(x, s_n x) = vec(partial_n x, x - partial_(n + 1) s_n x)$) Hence $s_(n - 1) partial_n + partial_(n + 1) s_n = 1$, i.e. $1$ is null homotopic, by Exercise 1.4.3, $P$ split exact. To prove $P_n$ are projectives, given

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$P_n$]),
node((0,1),[$B$]),
node((1,1),[$A$]),
edge((1,0),(1,1),"->",[$g_n$]),
edge((0,1),(1,1),"->>",[$f$]))]
]
consider the following commutative diagram with $g_(n + 1) = g_n partial_(n + 1)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$P_(n + 2)$]),
node((1,0),[$P_(n + 1)$]),
node((2,0),[$P_n$]),
node((3,0),[$P_(n - 1)$]),
node((0,1),[$0$]),
node((1,1),[$A$]),
node((2,1),[$A$]),
node((3,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$B$]),
node((2,2),[$B$]),
node((3,2),[$0$]),
edge((0,0),(1,0),"->",[$partial_(n + 2)$]),
edge((0,0),(0,1),"->"),
edge((1,0),(2,0),"->",[$partial_(n + 1)$]),
edge((1,0),(1,1),"->",[$g_(n + 1)$]),
edge((2,0),(3,0),"->",[$partial_n$]),
edge((2,0),(2,1),"->",[$g_n$]),
edge((2,0),(2,2),"->",[$h$],stroke:(dash:"dashed"),bend:15deg),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"="),
edge((2,1),(3,1),"->"),
edge((0,2),(1,2),"->"),
edge((0,2),(0,1),"->"),
edge((1,2),(1,1),"->>",[$f$]),
edge((1,2),(2,2),"="),
edge((2,2),(2,1),"->>",[$f$]),
edge((2,2),(3,2),"->"),
edge((3,2),(3,1),"->"))]
]
Since $P_bullet$ is projective, there exists $h : P_n arrow.r B$ such that $f h = g_n$

Conversely, suppose $P$ is a split exact sequence of projectives, by Exercise 1.4.2, there exist bijection $s_n : Z_n = B_n arrow.r B'_(n + 1)$ and $P_n tilde.equiv B_n xor B'_n$, thus $P$ is the direct sum of $0 arrow.r B'_(n + 1) arrow.r B_n arrow.r 0$, and we know the coproducts of projectives are projective, it suffices to consider $0 arrow.r P_1 arrow.r^tilde.equiv P_0 arrow.r 0$. Since $psi_1$ is epi and $P_1$ is projective, there exists $P_1 arrow.r^(phi.alt_1) B_1$ such that $xi_1 = psi_1 phi.alt_1$, let $phi.alt_0 = b_1 phi.alt_1 p_1^(- 1)$, then $xi_0 = a_1 xi_1 p_1^(- 1) = a_1 psi_1 phi.alt_1 p_1^(- 1) = psi_0 b_1 phi.alt_1 p_1^(- 1) = psi_0 phi.alt_0$ and $b_0 phi.alt_0 = b_0 b_1 phi.alt_1 p_1^(- 1) = 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$P_1$]),
node((2,0),[$P_0$]),
node((3,0),[$0$]),
node((0,1),[$B_2$]),
node((1,1),[$B_1$]),
node((2,1),[$B_0$]),
node((3,1),[$B_(- 1)$]),
node((0,2),[$A_2$]),
node((1,2),[$A_1$]),
node((2,2),[$A_0$]),
node((3,2),[$A_(- 1)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->"),
edge((1,0),(2,0),"->",[$p_1$ \ $tilde.equiv$]),
edge((1,0),(1,1),"->",[$phi.alt_1$],stroke:(dash:"dashed")),
edge((1,0),(1,2),"->",[$xi_1$],bend:-15deg),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$phi.alt_0$],stroke:(dash:"dashed")),
edge((2,0),(2,2),"->",[$xi_0$],bend:15deg),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((0,1),(0,2),"->>",[$psi_2$]),
edge((1,1),(2,1),"->",[$b_1$]),
edge((1,1),(1,2),"->>",[$psi_1$]),
edge((2,1),(3,1),"->",[$b_0$]),
edge((2,1),(2,2),"->>",[$psi_0$]),
edge((3,1),(3,2),"->>",[$psi_(- 1)$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$a_1$]),
edge((2,2),(3,2),"->"))]
]

]
#aside("Exercise", title:[2.3.1])[
Let $R = bb(Z)\/m$. Use Baer's criterion to show that $R$ is an injective $R$-module. Then show that $bb(Z)\/d$ is not an injective $R$-module when $d divides m$ and some prime $p$ divides both $d$ and $m\/d$\.(The hypothesis ensures that $bb(Z)\/m eq.not bb(Z)\/d xor bb(Z)\/e$)

]
#proof(title: "Proof")[
Any ideal of $R$ is of the form $I = chevron.l d chevron.r$, $m = d e$, if $f : I arrow.r R$ is a homomorphism, then $m divides e f\(d\)arrow.r.double d divides f\(d\)$, thus we can extend $f : R arrow.r R$, $1 mapsto frac(f\(d\), d)$, $R$ is an injective $R$-module

If $m = d e$ but $bb(Z)\/m bb(Z) eq.not bb(Z)\/d bb(Z) xor bb(Z)\/e bb(Z)$, suppose $bb(Z)\/d bb(Z)$ is injective, then we would have

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)\/d bb(Z) tilde.equiv e bb(Z)\/m bb(Z)$]),
node((2,0),[$bb(Z)\/m bb(Z)$]),
node((3,0),[$bb(Z)\/m bb(Z)\/bb(Z)\/d bb(Z) tilde.equiv bb(Z)\/e bb(Z)$]),
node((4,0),[$0$]),
node((1,1),[$bb(Z)\/d bb(Z)$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"="),
edge((1,0),(2,0),"hook->",[$i$]),
edge((2,0),(1,1),"->",[$s$],stroke:(dash:"dashed")),
edge((2,0),(3,0),"->>"),
edge((3,0),(4,0),"->"))]
]
Then the exact sequence split, $bb(Z)\/m bb(Z) = bb(Z)\/d bb(Z) xor bb(Z)\/e bb(Z)$ which is a contradiction

]
#aside("Exercise", title:[2.4.2])[
\(Preserving derived functors) If $U : cal(B) arrow.r cal(C)$ is an exact functor, show that $U\(L_i F\)tilde.equiv L_i\(U F\)$

]
#statement("Remark")[
Forgetful functors such as $upright(m o d)$-$R arrow.r A b$ are often exact, and it is often easier to compute the derived functor of $U F$ due to the absence of cluttering restrictions

]
#proof(title: "Proof")[
For any chain complex $C$ and exact functor $U$, we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$U B_(n - 1)$]),
node((2,0),[$U Z_(n - 1)$]),
node((0,1),[$U C_(n + 1)$]),
node((1,1),[$U C_n$]),
node((2,1),[$U C_(n - 1)$]),
node((0,2),[$U B_n$]),
node((1,2),[$U Z_n$]),
node((2,2),[$U H_n$]),
edge((1,0),(2,0),"hook->"),
edge((2,0),(2,1),"hook->"),
edge((0,1),(0,2),"->>"),
edge((0,1),(1,1),"->"),
edge((1,1),(1,0),"->>"),
edge((1,1),(2,1),"->"),
edge((0,2),(1,2),"hook->"),
edge((1,2),(1,1),"hook->"),
edge((1,2),(2,2),"->>"))]
]
Then $U\(H_n C\)= upright(c o k e r)\(U B_n arrow.r F Z_n\)= H_n\(U C\)$ are naturally isomorphic, hence $U\(L_i F\(A\)\)= U\(H_i\(F\(P\)\)\)= H_i\(U F\(P\)\)= L_i\(U F\(P\)\)$ are naturally isomorphic

]
#aside("Exercise", title:[#strong[2.4.3]])[
\(Dimension shifting) If $0 arrow.r M arrow.r P arrow.r A arrow.r 0$ is exact with $P$ projective(or $F$-acyclic 2.4.3), show that $L_i F\(A\)tilde.equiv L_(i - 1) F\(M\)$ for $i gt.eq 2$ and that $L_1 F\(A\)$ is the kernel of $F\(M\)arrow.r F\(P\)$. More generally, show that if #math.equation(block: true, numbering: none, $0 arrow.r M_m arrow.r P_m arrow.r P_(m - 1) arrow.r dots.h.c arrow.r P_0 arrow.r A arrow.r 0$) is exact with the $P_i$ projective(or $F$-acyclic), then $L_i F\(A\)tilde.equiv L_(i - m - 1) F\(M_m\)$ for $i gt.eq m + 2$ and $L_(m + 1) F\(A\)$ is the kernel of $F\(M_m\)arrow.r F\(P_m\)$. Conclude that if $P arrow.r A$ is an $F$-acyclic resolution of $A$, then $L_i F\(A\)= H_i\(F\(P\)\)$

]
#statement("Remark")[
The object $M_m$, which obviously depends on the choices made, is called $m^(upright(t h))$ syzygy of $A$. The word \"syzygy\" comes from astronomy, where it was originally used to describe the alignment of the Sun, Earth, and Moon

]
#proof(title: "Proof")[
We have long exact sequence #math.equation(block: true, numbering: none, $L_i F\(P\)arrow.r L_i F\(A\)arrow.r L_(i - 1) F\(M\)arrow.r L_(i - 1) F\(P\)arrow.r dots.h.c arrow.r L_1 F\(P\)arrow.r L_1 F\(A\)arrow.r F\(M\)arrow.r F\(P\)$) Here $L_i F\(P\)= 0$ for $i eq.not 0$ since $P$ is $F$-acyclic, hence $L_i F\(A\)tilde.equiv L_(i - 1) F\(M\)$ for $i gt.eq 2$ and $L_1 F\(A\)$ is the kernel of $F\(M\)arrow.r F\(P\)$

Suppose $M_m = upright(i m)\(P_(m + 1) arrow.r P_m\)= ker\(P_m arrow.r P_(m - 1)\)$, $M_(- 1) = A$, we have

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((3,0),[$0$]),
node((4,0),[$0$]),
node((7,0),[$0$]),
node((8,0),[$0$]),
node((3,1),[$M_(m - 1)$]),
node((7,1),[$M_0$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$P_(m + 1)$]),
node((2,2),[$P_m$]),
node((3,2),[$P_(m - 1)$]),
node((4,2),[$dots.h.c$]),
node((5,2),[$P_2$]),
node((6,2),[$P_1$]),
node((7,2),[$P_0$]),
node((1,3),[$M_m$]),
node((3,3),[$M_(m - 2)$]),
node((5,3),[$M_1$]),
node((7,3),[$A$]),
node((0,4),[$0$]),
node((3,4),[$0$]),
node((4,4),[$0$]),
node((7,4),[$0$]),
edge((3,0),(3,1),"->"),
edge((7,0),(7,1),"->"),
edge((3,1),(3,2),"->"),
edge((3,1),(4,0),"->"),
edge((7,1),(7,2),"->"),
edge((7,1),(8,0),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(3,1),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((4,2),(5,2),"->"),
edge((5,2),(6,2),"->"),
edge((5,2),(5,3),"->"),
edge((6,2),(7,2),"->"),
edge((6,2),(7,1),"->"),
edge((7,2),(7,3),"->"),
edge((1,3),(2,2),"->"),
edge((3,3),(3,4),"->"),
edge((5,3),(6,2),"->"),
edge((7,3),(7,4),"->"),
edge((0,4),(1,3),"->"),
edge((4,4),(5,3),"->"))]
]
Then we can split this up into short exact sequences #math.equation(block: true, numbering: none, $0 arrow.r M_m arrow.r P_m arrow.r M_(m - 1) arrow.r 0$) Hence $L_i F\(M_(m - 1)\)tilde.equiv L_(i - 1) F\(M_m\)$ for $i gt.eq 2$ and $L_1 F\(M_(m - 1)\)$ is the kernel of $F\(M_m\)arrow.r F\(P_m\)$. This implies $L_i F\(A\)tilde.equiv L_(i - m - 1) F\(M_m\)$ for $i gt.eq m + 2$ and $L_(m + 1) F\(A\)$ is the kernel of $F\(M_m\)arrow.r F\(P_m\)$

Suppose $P arrow.r A$ is an $F$-acyclic resolution of $A$, $L_0 F\(A\)= F\(A\)= H_0\(F\(P\)\)$ is still true because $F$ is right exact. For $m gt.eq 1$, $F\(M_(m - 1)\)tilde.equiv upright(c o k e r)\(F\(M_m\)arrow.r F\(P_m\)\)= upright(c o k e r)\(F\(P_(m + 1)\)arrow.r F\(P_m\)\)$, hence $L_m F\(A\)tilde.equiv ker\(F\(M_(m - 1)\)arrow.r F\(P_(m - 1)\)\)= ker upright(c o k e r)\(F\(P_(m + 1)\)arrow.r F\(P_m\)\)= H_m\(F\(P\)\)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((3,0),[$0$]),
node((4,0),[$0$]),
node((3,1),[$F\(M_(m - 1)\)$]),
node((1,2),[$F\(P_(m + 1)\)$]),
node((2,2),[$F\(P_m\)$]),
node((3,2),[$F\(P_(m - 1)\)$]),
node((1,3),[$F\(M_m\)$]),
node((0,4),[$0$]),
node((1,4),[$0$]),
edge((3,0),(3,1),"->"),
edge((3,1),(3,2),"->"),
edge((3,1),(4,0),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(3,1),"->"),
edge((1,3),(2,2),"->"),
edge((1,3),(1,4),"->"),
edge((0,4),(1,3),"->"))]
]

]
#aside("Exercise", title:[2.4.4])[
Show that homology $H_(*) : C h_(gt.eq 0)\(cal(A)\)arrow.r cal(A)$ and cohomology $H^(*) : C h^(gt.eq 0)\(cal(A)\)arrow.r cal(A)$ are universal $delta$-functors. Hint: Copy the proof above, replacing $P$ by the mapping cone $c o n e\(A\)$ of exercise 1.5.1

]
#proof(title: "Proof")[
Suppose $T$ is a homological $delta$ functor, $phi.alt_0 : T_0 arrow.r H_0$ is given. From a short exact sequence $0 arrow.r A\[1\]arrow.r c o n e\(A\[1\]\)arrow.r A arrow.r 0$ we get a long exact sequence #math.equation(block: true, numbering: none, $dots.h.c arrow.r H_(n + 1)\(A\)arrow.r H_n\(A\[1\]\)arrow.r H_n\(c o n e\(A\[1\]\)\)arrow.r H_n\(A\)arrow.r H_(n - 1)\(A\[1\]\)arrow.r dots.h.c$) Since $H_n\(A\)= H_(n - 1)\(A\[1\]\)$, we have $H_n\(c o n e\(A\[1\]\)\)= 0$. $T_n$ induce a unique $T_(n + 1)$ as follows

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$T_(n + 1)\(A\)$]),
node((2,0),[$T_n\(A\[1\]\)$]),
node((3,0),[$T_n\(c o n e\(A\[1\]\)\)$]),
node((0,1),[$0$]),
node((1,1),[$H_(n + 1)\(A\)$]),
node((2,1),[$H_n\(A\[1\]\)$]),
node((3,1),[$0$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->",[$phi.alt_(n + 1)$],stroke:(dash:"dashed")),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$phi.alt_n$]),
edge((3,0),(3,1),"->",[$phi.alt_n$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"))]
]
Check $phi.alt_n$'s are natural transformations. For $f : A arrow.r B$, we have

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$A\[1\]$]),
node((2,0),[$c o n e\(A\[1\]\)$]),
node((3,0),[$A$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$B\[1\]$]),
node((2,1),[$c o n e\(B\[1\]\)$]),
node((3,1),[$B$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->",[$f\[1\]$]),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$c o n e\(f\[1\]\)$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->",[$f$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
Suppose $phi.alt_(n - 1) T_(n - 1)\(f\[- 1\]\)= H_(n - 1)\(f\[- 1\]\)phi.alt_(n - 1)$, $delta_n T_n\(f\)= T_(n - 1)\(f\[1\]\)delta_n$, $delta_n H_n\(f\)= H_(n - 1)\(f\[1\]\)delta_n$, $delta_n phi.alt_n = phi.alt_(n - 1) delta_n$, then $delta_n phi.alt_n T_n\(f\)= phi.alt_(n - 1) delta_n T_n\(f\)= phi.alt_(n - 1) T_(n - 1)\(f\[1\]\)delta_n = H_(n - 1)\(f\[1\]\)phi.alt_(n - 1) delta_n = H_(n - 1)\(f\[1\]\)delta_n phi.alt_n = delta_n H_n\(f\)phi.alt_n$, since $delta_n$ is an isomorphism, $phi.alt_n T_n\(f\)= H_n\(f\)phi.alt_n$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$T_(n - 1)\(A\[1\]\)$]),
node((3,0),[$T_(n - 1)\(B\[1\]\)$]),
node((1,1),[$T_n\(A\)$]),
node((2,1),[$T_n\(B\)$]),
node((1,2),[$H_n\(A\)$]),
node((2,2),[$H_n\(B\)$]),
node((0,3),[$H_(n - 1)\(A\[1\]\)$]),
node((3,3),[$H_(n - 1)\(B\[1\]\)$]),
edge((0,0),(0,3),"->",[$phi.alt_(n - 1)$]),
edge((0,0),(3,0),"->",[$T_(n - 1)\(f\[1\]\)$]),
edge((3,0),(3,3),"->",[$phi.alt_(n - 1)$]),
edge((1,1),(2,1),"->",[$T_n\(f\)$]),
edge((1,1),(1,2),"->",[$phi.alt_n$]),
edge((1,1),(0,0),"->",[$delta_n$]),
edge((2,1),(2,2),"->",[$phi.alt_n$]),
edge((2,1),(3,0),"->",[$delta_n$]),
edge((1,2),(2,2),"->",[$H_n\(f\)$]),
edge((1,2),(0,3),"->",[$delta_n$]),
edge((2,2),(3,3),"->",[$delta_n$]),
edge((0,3),(3,3),"->",[$H_(n - 1)\(f\[1\]\)$]))]
]
Check $phi.alt_n$'s commute with $delta_n$'s. For any $f : A\[1\]arrow.r C$, we can construct commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$A_(n + 1)$]),
node((2,0),[$A_n xor A_(n + 1)$]),
node((3,0),[$A_n$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$C_n$]),
node((2,1),[$C_n xor A_n$]),
node((3,1),[$A_n$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->",[$f_n$]),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"="),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
Since

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$T_n\(A\[1\]\)$]),
node((1,0),[$T_n\(c o n e\(A\)\)$]),
node((2,0),[$T_n\(A\)$]),
node((3,0),[$T_(n - 1)\(A\[1\]\)$]),
node((0,1),[$T_n\(C\)$]),
node((1,1),[$T_n\(C xor A\)$]),
node((2,1),[$T_n\(A\)$]),
node((3,1),[$T_(n - 1)\(C\)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->",[$T_n\(f\)$]),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->",[$delta_n$]),
edge((2,0),(2,1),"="),
edge((3,0),(3,1),"->",[$T_(n - 1)\(f\)$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->",[$delta_n$]))]
]
We have $T_(n - 1)\(f\)delta_n = delta_n$. Hence

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$T_n\(A\)$]),
node((1,0),[$T_(n - 1)\(A\[1\]\)$]),
node((2,0),[$T_(n - 1)\(C\)$]),
node((0,1),[$H_n\(A\)$]),
node((1,1),[$H_(n - 1)\(A\[1\]\)$]),
node((2,1),[$H_(n - 1)\(C\)$]),
edge((0,0),(1,0),"->",[$delta_n$]),
edge((0,0),(0,1),"->",[$phi.alt_n$]),
edge((1,0),(1,1),"->",[$phi.alt_(n - 1)$]),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"->",[$phi.alt_(n - 1)$]),
edge((0,1),(1,1),"->",[$delta_n$]),
edge((1,1),(2,1),"->"))]
]
Gives

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$T_n\(A\)$]),
node((1,0),[$T_(n - 1)\(C\)$]),
node((0,1),[$H_n\(A\)$]),
node((1,1),[$H_(n - 1)\(C\)$]),
edge((0,0),(1,0),"->",[$delta_n$]),
edge((0,0),(0,1),"->",[$phi.alt_n$]),
edge((1,0),(1,1),"->",[$phi.alt_(n - 1)$]),
edge((0,1),(1,1),"->",[$delta_n$]))]
]

]
#pagebreak(weak:true)
== Homework5
<homework5>
#aside("Exercise", title:[1.2.6])[
Gives examples of

\(1) a second quadrant double complex $C$ with exact columns such that $T o t^Pi\(C\)$ is acyclic but $T o t^xor\(C\)$ is not

\(2) a second quadrant double complex $C$ with exact rows such that $T o t^xor\(C\)$ is acyclic but $T o t^Pi\(C\)$ is not

\(3) a double complex(in the entire plane) for which every row and every column is exact, yet neither $T o t^Pi\(C\)$ nor $T o t^xor\(C\)$ is acyclic

]
#proof(title: "Proof")[
\(1) Consider the second quadrant double complex $C$ with $C_(- p\,p) = C_(- p\,p + 1) = bb(Z)$ for $p lt.eq 0$ and identity maps for all $bb(Z) arrow.r bb(Z)$, then $\(dots.h.c\,0\,1\)in T o t_0^xor\(C\)$ doesn't have a preimage in $T o t_1^xor\(C\)$, hence $T o t^xor\(C\)$ is not acyclic. On the other hand, $T o t_1^Pi\(C\)arrow.r T o t_0^Pi\(C\)$ is an isomorphism, hence $T o t^Pi\(C\)$ is acyclic

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$bb(Z)$]),
node((2,1),[$bb(Z)$]),
node((3,1),[$0$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$0$]),
node((2,2),[$bb(Z)$]),
node((3,2),[$bb(Z)$]),
node((0,3),[$dots.h.c$]),
node((1,3),[$0$]),
node((2,3),[$0$]),
node((3,3),[$bb(Z)$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((1,1),(0,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((2,1),(1,1),"->"),
edge((3,1),(3,2),"->"),
edge((3,1),(2,1),"->"),
edge((1,2),(0,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(1,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(2,2),"->"),
edge((3,2),(3,3),"->"),
edge((1,3),(0,3),"->"),
edge((2,3),(1,3),"->"),
edge((3,3),(2,3),"->"))]
]
\(2) Consider the second quadrant double complex $C$ with $C_(- p\,p) = C_(- p - 1\,p) = bb(Z)$ for $p lt.eq 0$ and identity maps for all $bb(Z) arrow.r bb(Z)$, then $\(dots.h.c\,- 1\,1\,- 1\,1\)in T o t_1^Pi\(C\)$ maps to $0 in T o t_0^Pi\(C\)$, hence $T o t^Pi\(C\)$ is not acyclic. On the other hand, $T o t_1^xor\(C\)arrow.r T o t_0^xor\(C\)$ is an isomorphism, hence $T o t^xor\(C\)$ is acyclic

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$bb(Z)$]),
node((2,1),[$0$]),
node((3,1),[$0$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$bb(Z)$]),
node((2,2),[$bb(Z)$]),
node((3,2),[$0$]),
node((0,3),[$dots.h.c$]),
node((1,3),[$0$]),
node((2,3),[$bb(Z)$]),
node((3,3),[$bb(Z)$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((1,1),(0,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((2,1),(1,1),"->"),
edge((3,1),(3,2),"->"),
edge((3,1),(2,1),"->"),
edge((1,2),(0,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(1,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(2,2),"->"),
edge((3,2),(3,3),"->"),
edge((1,3),(0,3),"->"),
edge((2,3),(1,3),"->"),
edge((3,3),(2,3),"->"))]
]
\(3) Consider the double complex $C$ with $C_(- p\,p) = C_(- p\,p + 1) = bb(Z)$ and identity maps for all $bb(Z) arrow.r bb(Z)$, then $\(dots.h.c\,0\,1\,0\,dots.h.c\)in T o t_0^xor\(C\)$ doesn't have a preimage in $T o t_1^xor\(C\)$, hence $T o t^xor\(C\)$ is not acyclic. On the other hand, $\(dots.h.c\,- 1\,1\,- 1\,1\,dots.h.c\)in T o t_1^Pi\(C\)$ maps to $0 in T o t_0^Pi\(C\)$ is an isomorphism, hence $T o t^Pi\(C\)$ is not acyclic

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$bb(Z)$]),
node((2,1),[$0$]),
node((3,1),[$0$]),
node((4,1),[$dots.h.c$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$bb(Z)$]),
node((2,2),[$bb(Z)$]),
node((3,2),[$0$]),
node((4,2),[$dots.h.c$]),
node((0,3),[$dots.h.c$]),
node((1,3),[$0$]),
node((2,3),[$bb(Z)$]),
node((3,3),[$bb(Z)$]),
node((4,3),[$dots.h.c$]),
node((1,4),[$dots.v$]),
node((2,4),[$dots.v$]),
node((3,4),[$dots.v$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((1,1),(0,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((2,1),(1,1),"->"),
edge((3,1),(3,2),"->"),
edge((3,1),(2,1),"->"),
edge((4,1),(3,1),"->"),
edge((1,2),(0,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(1,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(2,2),"->"),
edge((3,2),(3,3),"->"),
edge((4,2),(3,2),"->"),
edge((1,3),(0,3),"->"),
edge((1,3),(1,4),"->"),
edge((2,3),(1,3),"->"),
edge((2,3),(2,4),"->"),
edge((3,3),(2,3),"->"),
edge((3,3),(3,4),"->"),
edge((4,3),(3,3),"->"))]
]

]
#aside("Exercise", title:[2.7.1])[
Let $C$ be the periodic upper half-plane complex with $C_(p\,q) = bb(Z)\/4$ for all $p$ and $q gt.eq 0$, all differentials being multiplication by $2$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$$]),
node((2,0),[$$]),
node((3,0),[$$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$bb(Z)\/4$]),
node((2,1),[$bb(Z)\/4$]),
node((3,1),[$bb(Z)\/4$]),
node((4,1),[$dots.h.c$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$bb(Z)\/4$]),
node((2,2),[$bb(Z)\/4$]),
node((3,2),[$bb(Z)\/4$]),
node((4,2),[$dots.h.c$]),
edge((1,0),(1,1),"->",[$2$]),
edge((2,0),(2,1),"->",[$2$]),
edge((3,0),(3,1),"->",[$2$]),
edge((1,1),(0,1),"->",[$2$]),
edge((1,1),(1,2),"->",[$2$]),
edge((2,1),(1,1),"->",[$2$]),
edge((2,1),(2,2),"->",[$2$]),
edge((3,1),(2,1),"->",[$2$]),
edge((3,1),(3,2),"->",[$2$]),
edge((4,1),(3,1),"->",[$2$]),
edge((1,2),(0,2),"->",[$2$]),
edge((2,2),(1,2),"->",[$2$]),
edge((3,2),(2,2),"->",[$2$]),
edge((4,2),(3,2),"->",[$2$]))]
]
\1. Show that $H_0\(T o t^Pi\(C\)\)tilde.equiv bb(Z)\/2$ on the cycle $\(dots.h.c\,1\,1\,1\)in product C_(- p\,p)$ even though the rows of $C$ are exact. Hint: First show that the $0$-boundaries are $product 2 bb(Z)\/4$

\2. Show that $T o t^xor\(C\)$ is acyclic

\3. Now extend $C$ downward to form a doubly periodic plane double complex $D$ with $D_(p q) = bb(Z)\/4$ for all $p\,q in bb(Z)$. Show that $H_0\(T o t^Pi\(D\)\)$ maps onto $H_0\(T o t^Pi\(C\)\)tilde.equiv bb(Z)\/2$. Hence $T o t^Pi\(D\)$ is not acyclic, even though every row and column of $D$ is exact. Finally, show that $T o t^xor\(D\)$ is acyclic

]
#proof(title: "Proof")[
\1. It is obvious that $B_0\(T o t^Pi\(C\)\)subset.eq product 2 bb(Z)\/4$, for any $\(dots.h.c\,x_(- 2\,2)\,x_(- 1\,1)\,x_(0\,0)\)in product 2 bb(Z)\/4$, we can find $\(dots.h.c\,x_(- 2\,3)\,x_(- 1\,2)\,x_(0\,1)\,0\)$ inductively such that $2 x_(0\,1) = x_(0\,0)$, $2 x_(0\,1) + 2 x_(- 1\,2) = x_(- 1\,1)$, $2 x_(- 1\,2) + 2 x_(- 2\,3) = x_(- 2\,2)$, $dots.h.c$, hence $B_0\(T o t^Pi\(C\)\)= product 2 bb(Z)\/4$. Similarly, we can show any element in $T o t_0^Pi\(C\)$ that maps to $0$ has entries of the same parity, hence $H_0\(T o t^Pi\(C\)\)tilde.equiv bb(Z)\/2$ on the cycle $\(dots.h.c\,1\,1\,1\)in T o t_0^Pi\(C\)$

\2. Apply acyclic assembly lemma. $C$ is an upper half-plane complex with exact rows, thus $T o t^xor\(C\)$ is acyclic

As in 1. $B_0\(T o t^Pi\(C\)\)= xor.big 2 bb(Z)\/4$, any element in $T o t_0^xor\(C\)$ that maps to $0$ has entries of the same parity, thus $Z_0\(T o t^xor\(C\)\)= xor.big 2 bb(Z)\/4$, hence $T o t^xor\(C\)$ is acyclic

\3. We have an obvious map $D arrow.r C$. For any $\(dots.h.c\,x_(- 2\,2)\,x_(- 1\,1)\,x_(0\,0)\)in Z_0\(T o t^Pi\(C\)\)$, it comes from $\(dots.h.c\,x_(- 2\,2)\,x_(- 1\,1)\,x_(0\,0)\,x_(0\,0)\,x_(0\,0)\,dots.h.c\)in Z_0\(T o t^Pi\(D\)\)$, also, $B_0\(T o t^Pi\(D\)\)subset.eq product 2 bb(Z)\/4$ maps into $B_0\(T o t^Pi\(C\)\)= product 2 bb(Z)\/4$, thus $H_0\(T o t^Pi\(D\)\)$ maps onto $H_0\(T o t^Pi\(C\)\)tilde.equiv bb(Z)\/2$

As in 2. $B_0\(T o t^xor\(D\)\)= Z_0\(T o t^xor\(D\)\)= xor.big 2 bb(Z)\/4$, hence $T o t^xor\(D\)$ is acyclic

]
#aside("Exercise", title:[2.7.3])[
To see why $T o t^xor$ is used for the tensor product $P times.o_R Q$ of right and left $R$ module complexes, while $T o t^Pi$ is used for $H o m$, let $I$ be a cochain complex of abelian groups. Show that there is a natural isomorphism of double complexes: #math.equation(block: true, numbering: none, $H o m_(A b)\(T o t^xor\(P times.o_R Q\)\,I\)tilde.equiv H o m_R\(P\,T o t^Pi\(H o m_(A b)\(Q\,I\)\)\)$)

]
#proof(title: "Proof")[
Since #math.equation(block: true, numbering: none, $H o m (xor.big_(p + q = r) P_p times.o Q_q \, I^r) & tilde.equiv product_(p + q = r) H o m (P_p times.o Q_q \, I^r)\
 & tilde.equiv product_(p + q = r) H o m (P_p \, H o m \( Q_q \, I^r \))\
 & tilde.equiv H o m (P_p \, product_(p + q = r) H o m \( Q_q \, I^r \))\
$) is natural isomorphic. $H o m_(A b)\(T o t^xor\(P times.o_R Q\)\,I\)tilde.equiv H o m_R\(P\,T o t^Pi\(H o m_(A b)\(Q\,I\)\)\)$ is also natural isomorphic

]
#aside("Exercise", title:[3.1.2])[
Suppose that $T$ is a commutative domain with field of fractions $F$. Show that $T o r_1^R\(F\/R\,B\)$ is the torsion submodule ${ b in B :\(exists r eq.not 0\)r b = 0 }$ of $B$ for every $R$ module $B$

]
#proof(title: "Proof")[
Since localization is exact, $F$ is a flat $R$ module, tensoring the flat resolution $0 arrow.r R arrow.r F arrow.r F\/R arrow.r 0$ with $B$, we get $0 arrow.r B = R times.o B arrow.r F times.o B arrow.r F\/R times.o B arrow.r 0$, and $T o r_1^R\(F\/R\,B\)= ker\(B arrow.r F times.o B\)= T\(B\)$ is the torsion submodule of $B$

]
#aside("Exercise", title:[3.1.3])[
Show that $T o r_1^R\(R\/I\,R\/J\)tilde.equiv frac(I inter J, I J)$ for every right ideal $I$ and left ideal $J$ of $R$. In particular, $T o r_1\(R\/I\,R\/I\)tilde.equiv I\/I^2$ for every $2$ sided ideal $I$. Hint: Apply the snake lemma to

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$I J$]),
node((2,0),[$I$]),
node((3,0),[$I times.o R\/J$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$J$]),
node((2,1),[$R$]),
node((3,1),[$R times.o R\/J$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(3,1),"->"),
edge((3,0),(4,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
]
#proof(title: "Proof")[
Since $0 arrow.r I arrow.r R arrow.r R\/I arrow.r 0$ is exact, we have exact sequence #math.equation(block: true, numbering: none, $0 = T o r_1^R\(R\,R\/J\)arrow.r T_1^R\(R\/I\,R\/J\)arrow.r I times.o R\/J arrow.r R times.o R\/J$) Apply the snake lemma to

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$I J$]),
node((2,0),[$I$]),
node((3,0),[$I times.o R\/J$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$J$]),
node((2,1),[$R$]),
node((3,1),[$R times.o R\/J$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(3,1),"->"),
edge((3,0),(4,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
We get exact sequence #math.equation(block: true, numbering: none, $0 = ker\(I arrow.r R\)arrow.r ker\(I times.o R\/J arrow.r R times.o R\/J\)arrow.r upright(c o k e r)\(I J arrow.r J\)= J\/I J arrow.r upright(c o k e r)\(I arrow.r R\)= R\/J$) Hence #math.equation(block: true, numbering: none, $T o r_1^R\(R\/I\,R\/J\)tilde.equiv ker\(I times.o R\/J arrow.r R times.o R\/J\)= ker\(J\/I J arrow.r R\/I\)= frac(I inter J, I J)$)

]
#aside("Exercise", title:[3.2.1])[
Show that the following are equivalent for every left $R$ module $B$

\1. $B$ is flat

\2. $T o r_n^R\(A\,B\)= 0$ for all $n eq.not 0$ and all $A$

\3. $T o r_1^R\(A\,B\)= 0$ for all $A$

]
#proof(title: "Proof")[
2 $arrow.r.double$ 3: By definition

3 $arrow.r.double$ 1: For any short exact sequence $0 arrow.r K arrow.r F arrow.r A arrow.r 0$, we have $0 = T o r_1^R\(A\,B\)arrow.r K times.o B arrow.r F times.o B arrow.r A times.o B arrow.r 0$, hence $B$ is flat

1 $arrow.r.double$ 2: Since $B$ is flat, $- times.o B$ is exact, tensor any projective resolution of $A$ with $B$, $T o r_n^R\(A\,B\)$, $n eq.not 0$ which are the homologies are $0$

]
#aside("Exercise", title:[3.2.3])[
We saw in the last section that if $R = bb(Z)$\(or more generally, if $R$ is a principal ideal domain), a module $B$ is flat iff $B$ is torsion free. Here is an example of a torsion free ideal $I$ that is not a flat $R$ module. Let $k$ be a field and set $R = k\[x\,y\]$, $I =\(x\,y\)R$. Show that $k = R\/I$ has the projective resolution #math.equation(block: true, numbering: none, $0 arrow.r R arrow.r^(vec(- y, x)) R^2 arrow.r^(mat(delim: "(", x, y)) R arrow.r k arrow.r 0$) Then compute that $T o r_1^R\(I\,k\)tilde.equiv T o r_2^R\(k\,k\)tilde.equiv k$, showing that $I$ is not flat

]
#proof(title: "Proof")[
If $R = k\[x\,y\]$ is a UFD, $I =\(x\,y\)$ is a maximal ideal, then we have a projective resolution #math.equation(block: true, numbering: none, $0 arrow.r R arrow.r^(vec(- y, x)) R^2 arrow.r^(mat(delim: "(", x, y)) R arrow.r R\/I tilde.equiv k arrow.r 0$) For any $h in R$, $vec(- y h, x h) = 0 arrow.r.double h = 0$, hence $R arrow.r^(vec(- y, x)) R^2$ is injective. $mat(delim: "(", x, y) vec(- y, x) = 0$ and if $mat(delim: "(", x, y) vec(f, g) = x f + y g = 0$, then $x f = - y g arrow.r.double g = x h arrow.r.double f = - y h arrow.r.double vec(f, g) = h vec(- y, x)$. any element of $R$ is in $I$ iff it can be written as $x f + y g = mat(delim: "(", x, y) vec(f, g)$, hence $R^2 arrow.r R arrow.r k$ is exact. $R arrow.r k$ is obviously surjective

Tensoring $0 arrow.r I arrow.r R arrow.r k arrow.r 0$ with $k$ we get $0 = T o r_2^R\(R\,k\)arrow.r T o r_2^R\(k\,k\)arrow.r T o r_1^R\(I\,k\)arrow.r T o r_1^R\(R\,k\)= 0$. Tensoring the projective resolution with $k$ we get $0 arrow.r k arrow.r^0 k^2 arrow.r k arrow.r 0$, hence $T o r_2^R\(k\,k\)= ker\(k arrow.r^0 k^2\)tilde.equiv k$

]
#aside("Exercise", title:[3.2.4])[
Show that a sequence $A arrow.r B arrow.r C$ is exact iff its dual $C^(*) arrow.r B^(*) arrow.r A^(*)$ is exact

]
#proof(title: "Proof")[
Combine the fact that $H o m\(-\,R\)$ is a left exact contravariant functor and Lemma 3.2.5. we know $A arrow.r B arrow.r C$ is exact iff its dual $C^(*) arrow.r B^(*) arrow.r A^(*)$ is exact

]
#aside("Exercise", title:[3.3.1])[
Show that $E x t_(bb(Z))^1 (bb(Z) [1 / p] \, bb(Z)) tilde.equiv hat(bb(Z))_p\/bb(Z) tilde.equiv bb(Z)_(p^oo)$. This shows that $E x t_(bb(Z))^1\(-\,bb(Z)\)$ does not vanish on flat abelian groups

]
#proof(title: "Proof")[
Consider short exact sequence $0 arrow.r bb(Z) arrow.r bb(Z) [1 / p] arrow.r bb(Z)_(p^oo) arrow.r 0$, then we have exact sequence #math.equation(block: true, numbering: none, $bb(Z) tilde.equiv H o m\(bb(Z)\,bb(Z)\)arrow.r E x t_(bb(Z))^1\(bb(Z)_(p^oo)\,bb(Z)\)tilde.equiv\(bb(Z)_(p^oo)\)^(*) tilde.equiv hat(bb(Z))_p arrow.r E x t_(bb(Z))^1 (bb(Z) [1 / p] \, bb(Z)) arrow.r E x t_(bb(Z))^1\(bb(Z)\,bb(Z)\)= 0$) Hence $E x t_(bb(Z))^1 (bb(Z) [1 / p] \, bb(Z)) tilde.equiv hat(bb(Z))_p\/bb(Z) tilde.equiv bb(Z)_(p^oo)$

]
#aside("Exercise", title:[3.3.2])[
When $R = bb(Z)\/m$ and $B = bb(Z)\/p$ with $p divides m$, show that #math.equation(block: true, numbering: none, $0 arrow.r bb(Z)\/p arrow.r.hook^l bb(Z)\/m arrow.r^p bb(Z)\/m arrow.r^(m\/p) bb(Z)\/m arrow.r^p bb(Z)\/m arrow.r^(m\/p) dots.h.c$) is an infinite periodic injective resolution of $B$. Then compute the groups $E x t_(bb(Z)\/m)^n\(A\,bb(Z)\/p\)$ in terms of $A^(*) = H o m\(A\,bb(Z)\/m\)$. In particular, show that if $p^2 divides m$, then $E x t_(bb(Z)\/m)^n\(bb(Z)\/p\,bb(Z)\/p\)tilde.equiv bb(Z)\/p$ for all $n$

]
#proof(title: "Proof")[
For any ideal $k bb(Z)\/m$, $k divides m$, any map $k bb(Z)\/m arrow.r bb(Z)\/m$ must send $k$ to a multiple of $k$, thus can be extended to a map $bb(Z)\/m arrow.r bb(Z)\/m$, hence $bb(Z)\/m$ is an injective $bb(Z)\/m$ module. $bb(Z)\/p arrow.r bb(Z)\/m$ is obviously injective. If $m divides p k$, then $m / p divides k$, hence this is an injective resolution of $B$. Then we have $0 arrow.r A^(*) arrow.r^p A^(*) arrow.r^(m / p) dots.h.c$, hence $E x t_(bb(Z)\/m)^n\(A\,bb(Z)\/p\)= cases(H o m\(A\,bb(Z)\/p\)quad n = 0, frac(H o m\(A\,bb(Z)\/m / p\), p A^(*)) quad n upright(" odd"), frac(H o m\(A\,bb(Z)\/p\), m / p A^(*)) quad n > 0 upright(" even"))$

If $p^2 divides m$, then we would have $0 arrow.r\(bb(Z)\/p\)^(*) arrow.r^0\(bb(Z)\/p\)^(*) arrow.r^0 dots.h.c$, hence $E x t_(bb(Z)\/m)^n\(bb(Z)\/p\,bb(Z)\/p\)tilde.equiv\(bb(Z)\/p\)^(*) = H o m\(bb(Z)\/p\,bb(Z)\/m\)tilde.equiv bb(Z)\/p$

]
#pagebreak(weak:true)
== Homework6
<homework6>
#aside("Exercise", title:[3.4.1])[
Show that if $p$ is prime, there are exactly $p$ equivalence classes of extensions of $bb(Z)\/p$ by $bb(Z)\/p$ in $upright(bold(A b))$: the split extension and the extensions #math.equation(block: true, numbering: none, $0 arrow.r bb(Z)\/p arrow.r^p bb(Z)\/p^2 arrow.r^i bb(Z)\/p arrow.r 0 quad\(i = 1\,2\,dots.h.c\,p - 1\)$)

]
#proof(title: "Proof")[
Suppose $0 arrow.r bb(Z)\/p arrow.r A arrow.r bb(Z)\/p arrow.r 0$ is exact, then #math.equation(block: true, numbering: none, $frac(A, bb(Z)\/p) tilde.equiv bb(Z)\/p arrow.r.double\|A\|=\|bb(Z)\/p\|^2 = p^2 arrow.r.double A = bb(Z)\/p^2 upright(" or ") A = bb(Z)\/p times bb(Z)\/p$) If $A = bb(Z)\/p times bb(Z)\/p$, and $0 arrow.r bb(Z)\/p arrow.r^(vec(a, b)) bb(Z)\/p arrow.r^(mat(delim: "(", c, d)) bb(Z)\/p arrow.r 0$ is exact, then $vec(a, b)$, $vec(c, d)$ are perpendicular in $bb(F)_p^2$, thus $vec(c, d) = lambda vec(- b, a)$ for some $lambda in bb(F)_p^times$, and $vec(a, b)$ can be any nonzero vector in $bb(F)_p^2$. We have $lambda\(a v - b u\)= 1$ for some $u\,v$ such that

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)\/p$]),
node((2,0),[$bb(Z)\/p times bb(Z)\/p$]),
node((3,0),[$bb(Z)\/p$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$bb(Z)\/p$]),
node((2,1),[$bb(Z)\/p times bb(Z)\/p$]),
node((3,1),[$bb(Z)\/p$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"="),
edge((1,0),(2,0),"->",[$vec(1, 0)$]),
edge((2,0),(3,0),"->",[$mat(delim: "(", 0, 1)$]),
edge((2,0),(2,1),"->",[$mat(delim: "(", a, u; b, v)$ \ $tilde.equiv$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"="),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$vec(a, b)$]),
edge((2,1),(3,1),"->",[$mat(delim: "(", - lambda b, lambda a)$]),
edge((3,1),(4,1),"->"))]
]
If $A = bb(Z)\/p^2$, $0 arrow.r bb(Z)\/p arrow.r^p bb(Z)\/p^2 arrow.r^i bb(Z)\/p arrow.r 0$, $i = 1\,2\,dots.h.c\,p - 1$ are all the possible exact sequences. Suppose the following diagram commutes

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)\/p$]),
node((2,0),[$bb(Z)\/p^2$]),
node((3,0),[$bb(Z)\/p$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$bb(Z)\/p$]),
node((2,1),[$bb(Z)\/p^2$]),
node((3,1),[$bb(Z)\/p$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(2,0),"->",[$p$]),
edge((2,0),(2,1),"->",[$k$]),
edge((2,0),(3,0),"->",[$i$]),
edge((3,0),(3,1),"->"),
edge((3,0),(4,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$p$]),
edge((2,1),(3,1),"->",[$j$]),
edge((3,1),(4,1),"->"))]
]
$k p equiv p #h(0.444em) mod med p^2 arrow.l.r.double p\(k - 1\)equiv 0 #h(0.444em) mod med p^2 arrow.r.double k equiv 1 #h(0.444em) mod med p arrow.r.double j k equiv i #h(0.444em) mod med p$, thus $0 arrow.r bb(Z)\/p arrow.r^p bb(Z)\/p^2 arrow.r^i bb(Z)\/p arrow.r 0$, $i = 1\,2\,dots.h.c\,p - 1$ are nonequivalent

]
#aside("Exercise", title:[3.5.1])[
Let ${ A_i }$ be a tower in which the maps $A_(i + 1) arrow.r A_i$ are inclusions. We may regard $A = A_0$ as a topological group in which the sets $a + A_i\(a in A\,i gt.eq 0\)$ are open sets. Show that $lim_arrow.l A_i = inter.big A_i$ is zero iff $A$ is Hausdorff. Then show that $lim_arrow.l ""^1 A_i = 0$ iff $A$ is complete in the sense that every Cauchy sequence has a limit, not necessarily unique. Hint: Show that $A$ is Hausdorff and complete iff $A tilde.equiv lim_arrow.l\(A\/A_i\)$

]
#proof(title: "Proof")[
Consider $lim_arrow.l\(A\/A_i\)tilde.equiv {\( dots.h.c \, a_i \, dots.h.c \) in product A \/ A_i mid(bar.v) a_j equiv a_i #h(0.444em) mod med A_i \, forall j gt.eq i}$, $A arrow.r^phi.alt lim_arrow.l\(A\/A_i\)$, $a mapsto\(dots.h.c\,a #h(0.444em) mod med A_i\,dots.h.c\)$. Let's show $phi.alt$ is injective iff $A$ is Hausdorff, $phi.alt$ is surjective iff $A$ is complete

Note that $phi.alt$ is injective $arrow.l.r.double$ $lim_arrow.l A_i = inter.big A_i = 0$. If $inter.big A_i = 0$, then for any $a eq.not b in A$, $a - b in A_(i - 1)\\A_i$ for some $i$, then $a + A_i inter b + A_i = diameter$, otherwise $a + c = b + d$ for some $c\,d in A_i$, but then $a - b = d - c in A_i$ which is a contradiction, hence $A$ is Hausdorff. If $A$ is Hausdorff, for any $a eq.not 0$, $a in.not 0 + A_i = A_i$ for some $i$, thus $inter.big A_i = 0$

If $phi.alt$ is surjective, suppose ${ a_n }$ converges, then there is a subsequence ${ a_(n_i) }$ such that $a_(n_j) - a_(n_i) in A_i$ for any $j gt.eq i$, i.e. $\(dots.h.c\,a_(n_i)\,dots.h.c\)in lim_arrow.l\(A\/A_i\)$, then there exists $a in A$ such that $a equiv a_(n_i) #h(0.444em) mod med A_i$. If $A$ is complete, for any $\(dots.h.c\,a_i\,dots.h.c\)in lim_arrow.l\(A\/A_i\)$, ${ a_i }$ is a Cauchy sequence since $a_j - a_i in A_i$ for any $j gt.eq i$, there exists a limit $a in A$ such that $a - a_i in A_i$, thus $a$ is a preimage

Use snake lemma on the following commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((2,0),[$A$]),
node((3,0),[$lim_arrow.l\(A\/A_i\)$]),
node((0,1),[$0$]),
node((1,1),[$product A_i$]),
node((2,1),[$product A$]),
node((3,1),[$product A\/A_i$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$product A_i$]),
node((2,2),[$product A$]),
node((3,2),[$product A\/A_i$]),
node((4,2),[$0$]),
node((1,3),[$lim_arrow.l ""^1 A_i$]),
edge((2,0),(2,1),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(3,1),"->"),
edge((3,0),(1,3),"->",stroke:(dash:"dashed")),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((3,2),(4,2),"->"))]
]
Thus $lim_arrow.l ""^1 A_i = 0$ iff $phi.alt$ is surjective

]
#aside("Exercise", title:[3.5.2])[
Show that $lim_arrow.l ""^1 A_i = 0$ if ${ A_i }$ is a tower of finite abelian groups, or a tower of finite dimensional vector spaces over a field

]
#proof(title: "Proof")[
If ${ A_i }$ is a tower of finite abelian groups, or a tower of finite dimensional vector spaces over a field, then $A_i = 0$ for $i$ big enough, hence ${ A_i }$ satisfies trivial Mittag-Leffler condition, thus $lim_arrow.l ""^1 A_i = 0$

]
#aside("Exercise", title:[3.5.4])[
Let $C$ be a second quadrant double complex with exact rows, and let $B_(p q)^h$ be the image of $d^h : C_(p q) arrow.r C_(p - 1\,q)$. Show that $H_(p + q) T o t\(T_(- p) C\)tilde.equiv H_q\(B_(p *)^h\,d^v\)$. Then let $b = d^h\(a\)$ be an element of $B_(p q)^h$ representing a cycle $xi$ in $H_(p + q) T o t\(T_(- p) C\)$ and show that the image of $xi$ in $H_(p + q) T o t\(T_(- p - 1) C\)$ is represented by $d^v\(a\)in B_(p + 1\,q - 1)^h$. This provides an effective method for calculating $H_(*) T o t\(C\)$

]
#proof(title: "Proof")[
Since $d^v x_(p\,q) + d^h x_(p + 1\,q - 1) = 0 arrow.r.double d^v d^h x_(p\,q) = - d^h d^v x_(p\,q) =\(d^h\)^2 x_(p + 1\,q - 1) = 0$, $C_(p\,q) arrow.r B_(p\,q)^h$ defines a map $Z_(p + q) T o t\(T_(- p) C\)arrow.r^(phi.alt_q) Z_q\(B_(p *)^h\,d^v\)$. For any $d^v d^h x_(p\,q) = 0$, by diagram chasing, we can find element in $Z_(p + q) T o t\(T_(- p) C\)$ with $\(p\,q\)$ entry $x_(p\,q)$, thus $phi.alt_q$ is surjective. Again by some diagram chasing, we can show that $phi.alt_q^(- 1)\(B_q\(B_(p *)^h\,d^v\)\)= B_(p + q) T o t\(T_(- p) C\)$. Hence $H_(p + q) T o t\(T_(- p) C\)tilde.equiv H_q\(B_(p *)^h\,d^v\)$

Suppose an representative in of $xi$ in $Z_(p + q) T o t\(T_p C\)$ has $a$ in $\(p\,q\)$ entry and $c$ in $\(p + 1\,q - 1\)$ entry, then the image of $xi$ has a representative in $Z_(p + q) T o t\(T_(- p - 1) C\)$ having $c$ in $\(p + 1\,q - 1\)$ entry, thus the image of $xi$ in $H_(p + q) T o t\(T_(- p - 1) C\)$ is represented by $d^v\(a\)= - d^h\(c\)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$$]),
node((2,0),[$$]),
node((3,0),[$$]),
node((4,0),[$$]),
node((0,1),[$0$]),
node((1,1),[$B_(p\,2)^h$]),
node((2,1),[$C_(p\,2)$]),
node((3,1),[$C_(p + 1\,2)$]),
node((4,1),[$C_(p + 2\,2)$]),
node((5,1),[$$]),
node((0,2),[$0$]),
node((1,2),[$B_(p\,1)^h$]),
node((2,2),[$C_(p\,1)$]),
node((3,2),[$C_(p + 1\,1)$]),
node((4,2),[$C_(p + 2\,1)$]),
node((5,2),[$$]),
node((0,3),[$0$]),
node((1,3),[$B_(p\,0)^h$]),
node((2,3),[$C_(p\,0)$]),
node((3,3),[$C_(p + 1\,0)$]),
node((4,3),[$C_(p + 2\,0)$]),
node((5,3),[$$]),
node((1,4),[$0$]),
node((2,4),[$0$]),
node((3,4),[$0$]),
node((4,4),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((4,0),(4,1),"->"),
edge((1,1),(0,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((2,1),(1,1),"->"),
edge((3,1),(3,2),"->"),
edge((3,1),(2,1),"->"),
edge((4,1),(4,2),"->"),
edge((4,1),(3,1),"->"),
edge((5,1),(4,1),"->"),
edge((1,2),(0,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(2,3),"->"),
edge((2,2),(1,2),"->"),
edge((3,2),(3,3),"->"),
edge((3,2),(2,2),"->"),
edge((4,2),(4,3),"->"),
edge((4,2),(3,2),"->"),
edge((5,2),(4,2),"->"),
edge((1,3),(0,3),"->"),
edge((1,3),(1,4),"->"),
edge((2,3),(2,4),"->"),
edge((2,3),(1,3),"->"),
edge((3,3),(3,4),"->"),
edge((3,3),(2,3),"->"),
edge((4,3),(4,4),"->"),
edge((4,3),(3,3),"->"),
edge((5,3),(4,3),"->"))]
]

]
#aside("Exercise", title:[3.5.5])[
\(Pullback) Let $arrow.r arrow.l$ denote the poset ${ x\,y\,z }$, $x < z$ and $y < z$, so that $lim_(arrow.r arrow.l) A_i$ is the pullback of $A_x$ and $A_y$ over $A_z$. Show that $lim_(arrow.r arrow.l)^1 A_i$ is the cokernel of the difference map $A_x times A_y arrow.r A_z$ and that $lim_(arrow.r arrow.l)^n = 0$ for $n eq.not 0\,1$

]
#proof(title: "Proof")[
Consider the construction in Vista 3.5.12

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A_x$]),
node((1,0),[$A_z$]),
node((2,0),[$A_y$]),
edge((0,0),(1,0),"->",[$f$]),
edge((2,0),(1,0),"->",[$g$]))]
]
$C_0 = A_x times A_y times A_z$, $C_1 = A_z times A_z$, $C_n = 0$ for $n gt.eq 2$. $d^0 =\(p_x f\,p_y g\)$, $d^1 =\(p_z\,p_z\)$, where $p_x\,p_y\,p_z$ are projections of $A_x times A_y times A_z$ onto each factor, thus we have a cochain complex #math.equation(block: true, numbering: none, $0 arrow.r A_x times A_y times A_z arrow.r^(mat(delim: "(", f, 0, - 1; 0, g, - 1)) A_z times A_z arrow.r 0$) The image being $B_1 = {vec(f a - c, g b - c) mid(bar.v) \( a \, b \, c \) in A_x times A_y times A_z}$

Consider surjection $A_z times A_z arrow.r^(mat(delim: "(", 1, - 1)) A_z$, the preimage of $upright(i m) d = {f a - g b mid(bar.v) \( a \, b \) in A_x times A_y}$ which is the image of the difference map $A_x times A_y arrow.r^d A_z$ is precisely $B_1$. Hence $lim_(arrow.r arrow.l)^1 A_i = upright(c o k e r)\(C_0 arrow.r C_1\)tilde.equiv upright(c o k e r) d$

It is clear that $lim_(arrow.r arrow.l)^n = 0$ for $n eq.not 0\,1$

]
#aside("Exercise", title:[5.1.1])[
Suppose that the double complex $E$ consists solely of the two columns $p$ and $p - 1$. Fix $n$ and set $q = n - p$, so that an element of $H_n\(T\)$ is represented by an element $\(a\,b\)in E_(p - 1\,q + 1) times E_(p q)$. Show that we have calculated the homology of $T = T o t\(E\)$ up to extension in the sense that there is a short exact sequence #math.equation(block: true, numbering: none, $0 arrow.r E_(p - 1\,q + 1)^2 arrow.r H_(p + q)\(T\)arrow.r E_(p q)^2 arrow.r 0$)

]
#proof(title: "Proof")[
Consider $E_(p - 1\,q + 1)^1 arrow.r H_(p + q) T$ induced by $E_(p - 1\,q + 1) arrow.r.hook T_(p + q)$, if $macron(a) mapsto 0$ with $a in E_(p - 1\,q + 1)$ being a representative, then $a = d'' b + d' c$ for some $\(b\,c\)in E_(p - 1\,q + 2) times E_(p\,q + 1)$, thus $macron(a) in E_(p - 1\,q + 1)^1$ is the image of $macron(c) in E_(p\,q + 1)^1$, therefore $E_(p - 1\,q + 1)^2 = upright(c o k e r)\(E_(p - 1\,q + 1)^1 arrow.r H_(p + q) T\)$

Consider $H_(p + q) T arrow.r E_(p\,q)^1$ induced by $T_(p + q) arrow.r E_(p\,q)$, for any $\(a\,b\)in E_(p - 1\,q + 1) times E_(p\,q)$, $d' b + d'' a = 0$, thus $macron(b)$ maps to zero in $E_(p - 1\,q)^1$. On the other hand, if $macron(b) in E_(p\,q)^1$ mapsto zero in $E_(p - 1\,q)^1$, then $d' b = d'' a$, then $\(- a\,b\)$ is a preimage of $macron(b)$ under $Z_(p + q) T arrow.r E_(p\,q)^1$, therefore $E_(p\,q)^2 tilde.equiv ker\(H_(p + q) T arrow.r E_(p\,q)^1\)$

]
#aside("Exercise", title:[5.2.1])[
\(2 columns) Suppose that a spectral sequence converging to $H_(*)$ has $E_(p q)^2 = 0$ unless $p = 0\,1$. Show that there are exact sequences #math.equation(block: true, numbering: none, $0 arrow.r E_(0 n)^2 arrow.r H_n arrow.r E_(1\,n - 1)^2 arrow.r 0$)

]
#proof(title: "Proof")[
Since $E_(p\,q)^2 = 0$ unless $p = 0\,1$, $E_(p\,q)^2 = E_(p\,q)^oo$, $F_(- 1) H_n = 0$, $E_(0\,n)^2 = frac(F_0 H_n, F_(- 1) H_n) = F_0 H_n$, $E_(1\,n - 1)^2 = frac(F_1 H_n, F_0 H_n)$ and $F_1 H_n = H_n$, thus we have exact sequences #math.equation(block: true, numbering: none, $0 arrow.r E_(0 n)^2 arrow.r H_n arrow.r E_(1\,n - 1)^2 arrow.r 0$)

]
#aside("Exercise", title:[5.2.2])[
\(2 rows) Suppose that a spectral sequence converging to $H_(*)$ has $E_(p q)^2 = 0$ unless $q = 0\,1$. Show that there is a long exact sequence #math.equation(block: true, numbering: none, $dots.h.c H_(p + 1) arrow.r E_(p + 1\,0)^2 arrow.r^d E_(p - 1\,1)^2 arrow.r H_p arrow.r E_(p 0)^2 arrow.r^d E_(p - 2\,1)^2 arrow.r H_(p - 1) dots.h.c$)

]
#statement("Remark")[
If a spectral sequence is not bounded, everything is more complicated, and there is no uniform terminology in the literature. For exacmple, a filtration in \[CE\] is \"regular\" if for each $n$ there is an $N$ such that $H_n\(F_p C\)= 0$ for $p < N$, and all filtrations are exhaustive. In \[MacH\] exhaustive filtrations are called \"convergent above\". In \[EGA, $0_(upright("III"))$\(11.2)\] even the definition of spectral sequence is different, and \"regular\" spectral sequences are not only convergent but also bounded below. In what follows, we shall mostly follow the terminology of Bourbaki \[BX, p175\]

]
#proof(title: "Proof")[
Since $E_(p q)^2 = 0$ unless $q = 0\,1$, $E_(p\,q)^3 = E_(p\,q)^oo$, $E_(p\,0)^3 = frac(F_p H_p, F_(p - 1) H_p) = ker\(E_(p\,0)^2 arrow.r E_(p - 2\,1)^2\)$, $E_(p\,1)^3 = frac(F_p H_(p + 1), F_(p - 1) H_(p + 1)) = upright(c o k e r)\(E_(p + 2\,0)^2 arrow.r E_(p\,1)^2\)$, thus $F_(n - 2) H_n = 0$, $F_n H_n = H_n$, we have exact sequences #math.equation(block: true, numbering: none, $0 arrow.r upright(c o k e r)\(E_(p + 1\,0)^2 arrow.r E_(p - 1\,1)^2\)= frac(F_(p - 1) H_p, F_(p - 2) H_p) arrow.r H_p arrow.r frac(F_p H_p, F_(p - 1) H_p) = ker\(E_(p\,0)^2 arrow.r E_(p - 2\,1)^2\)arrow.r 0$) Splice these together we get #math.equation(block: true, numbering: none, $dots.h.c H_(p + 1) arrow.r E_(p + 1\,0)^2 arrow.r^d E_(p - 1\,1)^2 arrow.r H_p arrow.r E_(p 0)^2 arrow.r^d E_(p - 2\,1)^2 arrow.r H_(p - 1) dots.h.c$)

]
#pagebreak(weak:true)
== Homework7
<homework7>
#aside("Exercise", title:[5.3.2])[
If $n eq.not 0$, the complex projective $n$-space $bb(C) P^n$ is a simply connected manifold of dimension $2 n$. As such $H_p\(bb(C) P^n\)= 0$ for $p > 2 n$. Given that there is a fibration $S^1 arrow.r S^(2 n + 1) arrow.r bb(C) P^n$, show that for $0 lt.eq p lt.eq 2 n$ #math.equation(block: true, numbering: none, $H_p\(bb(C) P^n\)tilde.equiv cases(bb(Z) quad p upright(" even"), 0 quad p upright(" odd"))$)

]
#proof(title: "Proof")[
The $E^2$ page looks like

#align(center)[
#align(center)[#set text(size:7pt)
#box(stroke:0.5pt,inset:8pt)[#diagram(spacing:(5mm,9mm),
node((0,0),$H_0(bb(C) P^n)$),node((1,0),$H_1(bb(C) P^n)$),node((2,0),$H_2(bb(C) P^n)$),node((3,0),$H_3(bb(C) P^n)$),node((4,0),$H_4(bb(C) P^n)$),node((5,0),$H_5(bb(C) P^n)$),
node((0,1),$H_0(bb(C) P^n)$),node((1,1),$H_1(bb(C) P^n)$),node((2,1),$H_2(bb(C) P^n)$),node((3,1),$H_3(bb(C) P^n)$),node((4,1),$H_4(bb(C) P^n)$),node((5,1),$H_5(bb(C) P^n)$),
edge((2,1),(0,0),"->",stroke:red),edge((3,1),(1,0),"->",stroke:red),edge((4,1),(2,0),"->",stroke:red),edge((5,1),(3,0),"->",stroke:red))]]
]
Thus we have #math.equation(block: true, numbering: none, $E_(p 1)^oo = E_(p 1)^3 = upright(c o k e r)\(H_(p + 2)\(bb(C) P^n\)arrow.r H_p\(bb(C) P^n\)\)$) #math.equation(block: true, numbering: none, $E_(p 0)^oo = E_(p 0)^3 = cases(ker\(H_p\(bb(C) P^n\)arrow.r H_(p - 2)\(bb(C) P^n\)\)quad p gt.eq 2, 0 quad p = 0\,1)$) #math.equation(block: true, numbering: none, $xor.big_(p = 0)^k E_(p\,k - p)^3 = xor.big_(p = 0)^k E_(p\,k - p)^oo = H_k\(S^(2 n + 1)\)= cases(bb(Z) quad k = 0\,2 n + 1, 0 quad upright("otherwise"))$) Since $H_0\(bb(C) P^n\)= bb(Z)$ and $H_k\(S^(2 n + 1)\)= 0$ for $k = 2\,dots.h.c\,2 n$, we know $H_1\(bb(C) P^n\)= 0$ and $H_k\(bb(C) P^n\)arrow.r H_(k - 2)\(bb(C) P^n\)$ are isomorphisms for $k = 2\,dots.h.c\,2 n$, hence for $0 lt.eq p lt.eq 2 n$ #math.equation(block: true, numbering: none, $H_p\(bb(C) P^n\)tilde.equiv cases(bb(Z) quad p upright(" even"), 0 quad p upright(" odd"))$)

]
#aside("Exercise", title:[5.4.1])[
Recall that the completion $hat(C)$ is a filtered complex. Show that $C\/F_(p - k) C$ and $hat(C)\/F_(p - k) hat(C)$ are naturally isomorphic

]
#proof(title: "Proof")[
Fix $p$, we have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r F_p C\/F_(p - k) C arrow.r C\/F_(p - k) C arrow.r C\/F_p C arrow.r 0$) Since $F_p C\/F_(p - k) C$ satisfies Mittag-Leffler condition, take limit we get exact sequence #math.equation(block: true, numbering: none, $0 arrow.r F_p hat(C) arrow.r hat(C) arrow.r C\/F_p C arrow.r lim_arrow.l_k ""^1 F_p C\/F_(p - k) C = 0$) Thus $C\/F_p C$ is naturally isomorphic to the cokernel $hat(C)\/F_p hat(C)$

]
#aside("Exercise", title:[5.4.2])[
Show that the spectral sequences for $C$, $union.big F_p C$, and $C\/inter.big F_p C$ are all isomorphic

]
#proof(title: "Proof")[
The spectral sequence of $C$ and $union.big F_p C$ are isomorphic since they define the same $A_p^r = { c in F_p C\|d c in F_(p - r) C }$ thus the same $Z_p^r\,B_p^r\,E_p^r$

The spectral sequence of $C$ and $C\/inter.big F_p C$ are isomorphic since $lim_arrow.l_k frac(C\/inter.big F_p C, F_k C\/inter.big F_p C) tilde.equiv lim_arrow.l_k C\/F_k C$, i.e. they have the same completion

]
#aside("Exercise", title:[5.4.3])[
\(Shifting or Décalage) Given a filtration $F$ on a chain complex $C$, define two new filtrations $tilde(F)$ and $upright(D e c) F$ on $C$ by $tilde(F)_p C_n = F_(p - n) C_n$ and $\(upright(D e c) F\)_p C_n = { x in F_(p + n) C_n\|d x in F_(p + n - 1) C_(n - 1) }$. Show that the spectral sequences for these three filtrations are isomorphic after reindexing: $E_(p q)^r\(F\)tilde.equiv E_(2 p + q\,- p)^(r + 1)\(tilde(F)\)$ for $r gt.eq 0$, and $E_(p q)^r\(F\)tilde.equiv  E_(- q\,p + 2 q)^(r - 1)\(upright(D e c) F\)$ for $r gt.eq 2$

]
#proof(title: "Proof")[
$E_(p q)^r\(F\)tilde.equiv E_(2 p + q\,- p)^(r + 1)\(tilde(F)\)$ for $r gt.eq 0$ since #math.equation(block: true, numbering: none, $tilde(A)_(2 p + q\,- p)^(r + 1) = {x in tilde(F)_(2 p + q) C_(p + q) mid(bar.v) d x in tilde(F)_(2 p + q - r - 1) C_(p + q - 1)} = {x in F_p C_(p + q) mid(bar.v) d x in tilde(F)_(p - r) C_(p + q - 1)} = A_(p\,q)^r$) #math.equation(block: true, numbering: none, $\(upright(D e c) A\)_(- q\,p + 2 q)^(r - 1) & = {x in \( upright(D e c) F \)_(- q) C_(p + q) mid(bar.v) d x in \( upright(D e c) F \)_(- q - r + 1) C_(p + q - 1)}\
 & = {x in F_p C_(p + q) mid(bar.v) d x in F_(p - 1) C_(p + q - 1) \, d x in F_(p - r) C_(p + q - 1) \, 0 = d^2 x in F_(p - r - 1) C_(p + q - 2)}\
 & = {x in F_p C_(p + q) mid(bar.v) d x in F_(p - r) C_(p + q - 1)}\
 & = A_(p\,q)^r$)

]
#pagebreak(weak:true)
== Homework8
<homework8>
#aside("Exercise", title:[5.5.1])[
Give an example of a complete Hausdorff filtered complex $C$ such that the filtration on $H_0\(C\)$ is Hausdorff, that is, such that $inter.big F_p H_0\(C\)eq.not 0$

]
#proof(title: "Proof")[
Consider $bb(Z)_3 = lim_arrow.l_k bb(Z)\/3^k bb(Z)$ , $F_p C_n = cases(3^(- p) bb(Z)_3 quad p lt.eq 0, bb(Z)_3 quad p gt.eq 0)$ for $n = 0\,1$ #math.equation(block: true, numbering: none, $0 arrow.r bb(Z)_3 arrow.r^(times 2) bb(Z)_3 arrow.r 0$) is a complete Hausdorff filtered chain complex. However #math.equation(block: true, numbering: none, $F_p\(H_0 C\) & = upright(i m)\(H_0\(F_p C\)arrow.r H_p C\)\
 & = upright(i m) (frac(F_p C_0, B_p\(F_p C_0\)) arrow.r frac(C_0, B_0 C))\
 & = F_p C_0 + B_0 C\
 & = 3^(- p) bb(Z)_3 + 2 bb(Z)_3\
 & = bb(Z)_3 + 2 bb(Z)_3$) The last equality holds since $3^(- p)$ and $2$ are coprime, hence $inter.big F_p H_0\(C\)eq.not 0$

]
#aside("Exercise", title:[5.5.3])[
Suppose that the filtration on $C$ is Hausdorff and exhaustive. If for any $p + q = n$ we have $E_(p q)^r = 0$, show that $F_p H_n\(C\)= F_(p - 1) H_n\(C\)$. Conclude that $H_n\(C\)= inter.big F_p H_n\(C\)$, provided that every $E_(p q)^r$ with $p + q$ equalling $n$ vanishes

]
#proof(title: "Proof")[
Since $E_(p q)^r = 0$, $0 = E_(p q)^oo supset.eq e_(p q)^oo tilde.equiv F_p H_n\(C\)\/F_(p - 1) H_n\(C\)arrow.r.double F_p H_n\(C\)= F_(p - 1) H_n\(C\)$, then #math.equation(block: true, numbering: none, $dots.h.c subset.eq F_(p - 1) H_n\(C\)subset.eq F_p H_n\(C\)subset.eq dots.h.c subset.eq H_n\(C\)= union.big F_p H_n\(C\)$) implies $H_n\(C\)= F_p H_n\(C\)\,forall p$, hence $H_n\(C\)= inter.big F_p H_n\(C\)$

]
#aside("Exercise", title:[5.6.3])[
\(Base-change for $E x t$) Let $f : R arrow.r S$ be a ring map. Show that there is a first quadrant cohomology spectral sequence #math.equation(block: true, numbering: none, $E_2^(p\,q) = E x t_S^p\(A\,E x t_R^q\(S\,B\)\)arrow.r.double E x t_R^(p + q)\(A\,B\)$) For every $S$-module $A$ and every $R$-module $B$

]
#proof(title: "Proof")[
Let $P_(*) arrow.r A$ be an $S$-module projective resolution, $B arrow.r I^(*)$ be an $R$-module injective resolution, consider the first quadrant double complex $H o m_R\(P\,I\)$ and write $H_(*)\(H o m_R\(P\,I\)\)= H_(*)\(T o t^Pi\(H o m_R\(P\,I\)\)\)$. Since $H o m_R\(P_p\,-\)$ is an exact functor, the $p^(upright("th"))$ column of $H o m_R\(P\,I\)$ is a resolution of $H o m\(P_p\,B\)$. Therefore the first spectral sequence collapse at $' E^1 = H_q^v\(H o m\(P\,I\)\)$ to yield $H_(*)\(H o m_R\(P\,I\)\)tilde.equiv H_(*)\(H o m_R\(P\,B\)\)tilde.equiv E x t_R^(*)\(A\,B\)$. Therefore the second spectral sequence converges to $E x t_R^(*)\(A\,B\)$ and #math.equation(block: true, numbering: none, $'' E_(p q)^1 & = H_q\(H o m_R\(P\,I^p\)\)\
 & = H_q\(H o m_S\(P\,H o m_R\(S\,I^p\)\)\
 & = H o m_S\(P\,H_q\(H o m_R\(S\,I^p\)\)\)\
 & = H o m_S\(P\,E x t_R^q\(S\,B\)\)$) Hence $H_p\('' E_(p q)^1\)= E x t_S^p\(A\,E x t_R^q\(S\,B\)\)$

]
#aside("Exercise", title:[5.7.4])[
+ If $A$ is an object of $cal(A)$, considered as a chain complex concentrated in degree zero, show that $bb(L)_i F\(A\)$ is the ordinary derived functor $L_i F\(A\)$

+ Let $upright(bold(C h))_(gt.eq 0)\(cal(A)\)$ be a subcategory of complexes $A$ with $A_p = 0$ for $p < 0$. Show that the functors $bb(L)_i F$ restricted to $upright(bold(C h))_(gt.eq 0)\(cal(A)\)$ are the left derived functors of the right exact functor $H_0 F$

+ \(Dimension shifting) Show that $bb(L)_i F\(A\[n\]\)= bb(L)_(n + i) F\(A\)$ for all $n$. Here $A\[n\]$ is the translate of $A$ with $A\[n\]_i = A_(n + i)$

]
#proof(title: "Proof")[
+ Suppose $P arrow.r A$ is a projective resolution of $A$, then it can also be regared as a Cartan-Eilenberg resolution of $A$, then $bb(L)_i F\(A\)= H_i\(T o t^xor\(F\(P\)\)\)= H_i\(F\(P\)\)= L_i F\(A\)$

+ Use Grothendieck spectral sequence theorem 5.8.4, we have #math.equation(block: true, numbering: none, $\(L_p H_0\)\(L_q F\)\(A\)arrow.r.double L_(p + q)\(H_0 F\)\(A\)$) On the other hand, by proposition 5.7.6, we have #math.equation(block: true, numbering: none, $\(L_p H_0\)\(L_q F\)\(A\)= H_p\(L_q F\)\(A\)arrow.r.double bb(L)_(p + q) F\(A\)$) Therefore, $bb(L)_i F\(A\)tilde.equiv L_i\(H_0 F\)\(A\)$

+ Suppose $P arrow.r A$ is a Cartan-Eilenberg resolution of $A$, then $tilde(P) arrow.r A\[n\]$ with $tilde(P)_(i j) = P_(i + n\,j)$ is also a Cartan-Eilenberg resolution, and #math.equation(block: true, numbering: none, $bb(L)_i F\(A\[n\]\)= H_i\(T o t^xor\(F\(tilde(P)\)\)\)= H_(n + i)\(T o t^xor\(F\(P\)\)\)= bb(L)_(n + i) F\(A\)$)

]
#aside("Exercise", title:[5.7.6])[
Let $A$ be the mapping cone complex $0 arrow.r A_1 arrow.r^f A_0 arrow.r 0$ with only two nonzero rows. Show that there is a long exact sequence #math.equation(block: true, numbering: none, $dots.h.c arrow.r bb(L)_(i + 1) F\(A\)arrow.r L_i F\(A_1\)arrow.r^f L_i F\(A_0\)arrow.r bb(L)_i F\(A\)arrow.r L_(i - 1) F\(A_1\)arrow.r dots.h.c$)

]
#proof(title: "Proof")[
We have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r A_1 arrow.r A arrow.r A_0\[- 1\]arrow.r 0$) Thus we have long exact sequence #math.equation(block: true, numbering: none, $dots.h.c arrow.r bb(L)_(i + 1) F\(A\)arrow.r bb(L)_(i + 1) F\(A_0\[- 1\]\)= L_i F\(A_0\)arrow.r^f bb(L)_i F\(A_1\)= L_i F\(A_1\)arrow.r bb(L)_i F\(A\)arrow.r dots.h.c$)

]
#pagebreak(weak:true)
#pagebreak(weak:true)
#pagebreak(weak:true)

#pagebreak()
#heading(numbering:none)[References]
#emph[An introduction to homological algebra] - Charles Weibel


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
