#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH606 - Algebraic Geometry I", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH606 - Algebraic Geometry I]
#v(2cm)
#image("Pictures/Weil.jpg",width:50%)
#v(2cm)
Taught by Amin Gholampour \
Notes taken by Haoran Li \
2019 Fall
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Affine varieties
<affine-varieties>
#statement("Definition")[
$W\,V$ are affine varieties, $phi.alt : W arrow.r V$ is a morphism

- $phi.alt$ is #emph[dominant]#index-entry("Dominant") if $phi.alt\(W\)$ is dense

- $phi.alt$ is #emph[quasi-finite]#index-entry("Quasi-finite") if $phi.alt^(- 1)\(q\)$ is finite for any $q in V$

- $phi.alt$ is #emph[finite]#index-entry("Finite") if $k\[W\]$ is a finite $k\[V\]$ algebra

]
#statement("Lemma")[
A finite morphism $phi.alt : W arrow.r V$ is quasi-finite

]
#proof(title: "Proof")[
Suppose $\(phi.alt^(*)\)^(- 1)\(m_p\)= m_q$, i.e. $p in phi.alt^(- 1)\(q\)$, then $phi.alt^(*)\(m_q\)= phi.alt^(*)\(phi.alt^(*)\)^(- 1)\(m_p\)subset.eq m_p$. Hence it suffices to prove that $B = k\[W\]\/phi.alt^(*)\(m_q\)$ has only finitely many maximal ideals. Since $phi.alt$ is finite, $k\[W\]$ is a finite $k\[V\]$ algebra, making $B$ a finite dimensional vector space over $k tilde.equiv k\[V\]\/m_q$. So $B$ has only finitely many maximal ideals (By Chinese remainder theorem, $B arrow.r B\/m_1 times dots.h.c times B\/m_s$ is surjective, thus $s lt.eq dim B < oo$)

]
#statement("Exercise")[
Consider hypersurface $H subset.eq bb(A)^(n + 1)$ is defined by $a_0\(t\)x^m + dots.h.c + a_m\(t\)= 0$, $phi.alt : H arrow.r bb(A)^n$ is the projection. $phi.alt$ is finite $arrow.l.r.double$ $a_0 eq.not 0$ is a constant. $phi.alt$ is quasi-finite $arrow.r.double$ $a_0\,dots.h.c\,a_m$ don't have common zeros

]
#statement("Lemma")[
$phi.alt : W arrow.r V$ is dominant $arrow.l.r.double$ $phi.alt^(*) : k\[W\]arrow.r k\[V\]$ is injective

]
#proof(title: "Proof")[
$f in ker phi^(*) arrow.l.r.double f compose phi = 0$, $upright(i m) phi$ dense $arrow.r.double f = 0$. Conversely, $overline(upright(i m) phi) subset.neq V arrow.r.double 0 eq.not f in I\(overline(upright(i m) phi)\)$

]
#statement("Proposition")[
If $W arrow.r^phi V$ is dominant and finite, then $phi$ is surjective

]
= Tangent space
<tangent-space>
Classically, ideal $I subset.eq k\[x_1\,dots.h.c\,x_n\]$ corresponds to an algebraic set $V\(I\)subset.eq bb(A)^n$, $p =\(a_1\,dots.h.c\,a_n\)in bb(A)^n$, then tangent space $T_p V$\(view as embedded in $bb(A)^n$) will just be #math.equation(block: true, numbering: none, ${\( y_1 \, dots.h.c \, y_n \) in bb(A)^n mid(bar.v) sum_(i = 1)^n \( y_i - a_i \) frac(partial f, partial x_i) \( p \) = 0 \, forall f in I}$)

#statement("Definition")[
$k\[epsilon.alt\]= k\[x\]\/\(x^2\)$ is a local $k$ algebra with maximal ideal $\(epsilon.alt\)$, $p in X\(k\)$, then $T_p V tilde.equiv "Hom"_("loc")\(cal(O)_(V\,p)\,k\[epsilon.alt\]\)$, i.e. $T_p X$ is the fiber over $p$ of $X\(k\[epsilon.alt\]\)arrow.r X\(k\)$ induced by $k\[epsilon.alt\]arrow.r k$, $epsilon.alt mapsto 0$, i.e. $alpha : A arrow.r k\[epsilon.alt\]$ such that $A arrow.r^alpha k\[epsilon.alt\]arrow.r k$ has kernel $p$\(which is a maximal ideal), i.e. $alpha^(- 1)\(\(epsilon.alt\)\)= p$. For $phi.alt : V arrow.r W$, $\(d phi.alt\)_p : "Hom"_("loc")\(cal(O)_(V\,p)\,k\[epsilon.alt\]\)arrow.r "Hom"_("loc")\(cal(O)_(W\,phi.alt\(p\))\,k\[epsilon.alt\]\)$ is induced by $cal(O)_(W\,phi.alt\(p\)) arrow.r cal(O)_(V\,p)$

]
#statement("Definition")[
$A$ is a $k$ algebra, $M$ is an $A$ module, a derivation is a $k$ linear map $A arrow.r M$ such that $D\(a b\)= a D\(b\)+ D\(a\)b$. Denote the $k$ vector space of derivations as $"Der"_k\(A\,M\)$

]
#statement("Example")[
$R$ is a local $k$ algebra with maximal ideal $m$ and $R\/m = k$, then $R tilde.equiv k xor m$ as a $k$ vector space since the exact sequence split

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$m$]),
node((2,0),[$R$]),
node((3,0),[$R\/m tilde.equiv k$]),
node((4,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(2,0),"->",bend:-15deg))]
]
Here $k arrow.r R$ maps 1 to 1, making $k arrow.r R arrow.r R\/m tilde.equiv k$ a $k$ linear isomorphism. Thus $d : R arrow.r m\/m^2$, $f mapsto f - f\(m\)#h(0.444em) mod med m^2$ is a $k$ derivation

]
#statement("Proposition")[
$\(R\,m\)$ is a local ring, there is a canonical isomorphism $"Hom"_("loc")\(R\,k\[epsilon.alt\]\)arrow.r "Der"_k\(R\,k\)arrow.r "Hom"_k\(m\/m^2\,k\)$

]
#proof(title: "Proof")[
Given a local homomorhpim $alpha : R arrow.r k\[epsilon.alt\]$, $alpha\(f\)= f\(m\)+ D_alpha\(f\)epsilon.alt$, here $D_alpha$ would be a derivation. Given a derivation $D$, $D$ vanishes on $k$ as well as $m^2$, thus induces a linear map $m\/m^2 arrow.r k$. Given a linear map $m\/m^2 arrow.r k$, define derivation $R arrow.r m\/m^2$, $f mapsto d f$

]
= New
<new>
#heading(level:4,numbering:none,outlined:false)[Gluing schemes in general]
Suppose ${ X_i }_(i in I)$ is a family of schemes. For any pair $\(i\,j\)$, let $V_(i j) subset.eq X_i$ be open subset(with induced scheme structure) and there are isomorphisms of schemes $V_(j i) arrow.r^(phi_(i j)) V_(j i)$ (with $V_(i i) = X_i$, $phi_(i i) = "id"$). For any triple $\(i\,j\,k\)$, $phi_(j i)\|_(V_(i j) inter V_(i k)) : V_(i j) inter V_(i k) arrow.r V_(j i) inter V_(j k)$ is an isomorphism of schemes and $phi_(i k) = phi_(i j) compose phi_(j k) : V_(k i) inter V_(k j) arrow.r V_(i k) inter V_(i j)$. Given all this, we first construct a topological space by gluing $X_i$'s along $V_(i j)$'s. Call the resulting space $X$. Then identify $X_i$ with an open subset of $X$. By the construction $V_(i j) inter V_(i k)$, $V_(j k) inter V_(j i)$, $V_(k i) inter V_(k j)$ are all identified with $X_i inter X_j inter X_k subset.eq X$. After these identifications ${ cal(O)_(X_i) }_(i in I)$ satisfy the gluing hypothesis for sheaves discussed before, therefore they glue to give a sheaf of rings on $X$ denoted by $cal(O)_X$. The locally ringed space $\(X\,cal(O)_X\)$ is a scheme, because each $x in X$ belongs to one of $X_i$'s, so has an affine open neighborhood

#statement("Example")[
Projective space $bb(P)_k^n$, $bb(P)_A^n$. The proj construction that will be discussed later gives an alternative construction of the projective space.

]
#statement("Definition")[
If there is a morphism of schemes $X arrow.r_()^phi S$ we say $X$ #emph[lies over] $S$, or $X$ is a #emph[scheme over] $S$, or $X$ is an $S$-scheme. $S$ is called the #emph[base scheme]. $phi$ is called the #emph[structure morphism]. If $S = "Spec" A$, the we say $X$ is a scheme over $A$ or is an $A$-scheme. E.g. $bb(P)_A^n$ is an $A$-scheme.

- If $X$ is an $A$ scheme then $cal(O)_X$ is a sheaf of $A$-algebras

- Any scheme can be regarded (uniquely) as a $bb(Z)$-scheme.

#statement("Definition")[
If $X\,Y$ are $S$-schemes then $u : X arrow.r Y$ is called a morophism of $S$-schemes or an $S$-morphism if

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
node((1,1),[$S$]),
edge((0,0),(1,0),"->",[$u$]),
edge((0,0),(1,1),"->",[$phi$]),
edge((1,0),(1,1),"->"))]
]
commutes. This means $forall s in S$ and $forall x$ over $s$ (i.e. $phi\(x\)= s$), $u\(x\)$ mus be over $s$.

]
- We can talk about the #emph[category of $S$-schemes]

]
- IF $f : S' arrow.r X$ is an $S$-morphism, the pair of morphisms $\(f\,1_(S')\)$ induces unique $S'$-morphism $S' arrow.r^(f') X_(S')$ by universal property of fiber product, we have $p_1 compose f' = 1_(S')$, $p_2 compose f' = f$. We say $f'$ is the #emph[graph morphism] of $f$

$suit.club$#h(1em)If $A$ is a local ring, then $T = "Spec" A$ has a unique closed point $t$ (corresponds to the maximal ideal of $A$). Any $A$-valued point of $X$ i.e. $T arrow.r^q X$ uniquely factors as $T arrow.r "Spec" cal(O)_(X\,phi\(t\)) arrow.r X$, where the second arrow is the natural morphism. (If $U = "Spec" B$ is open nbd of $phi\(t\)$ in $X$, we know $cal(O)_(X\,phi\(t\)) tilde.equiv B_(phi\(t\))$ and the natural homomrophsim $B arrow.r B_(phi\(t\))$ gives a morphism $"Spec" cal(O)_(X\,phi\(t\)) arrow.r U$ and composing with $U arrow.r.hook X$ get the 2nd arrow above. Easy to see this morphism does not depend on the choice of $U$. The image of the 2nd consists of the #emph[generalizations] of $phi\(t\)$ in $X$, i.e. these $x in X$ such that $phi\(t\)= overline({ x })$, 2nd arrow is a homeomorphism onto its image with the induced topology from $X$)

#proof(title: "Proof")[

]
#statement("Corollary")[
If $A$ is a local ring, $exists$ bijection $X\(A\)arrow.l.r$ local homomorphisms $cal(O)_(X\,x) arrow.r A$ for some $x in X$

]#label("10:11-04/16/2022")
#statement("Definition")[
$X$ any scheme. A #emph[geometric point] of $X$ is a $K$-valued point of $X$, $K$ is called the #emph[field of values] of this geometric field

]
$suit.club$#h(1em)By Corollary~#ref(label("10:11-04/16/2022"), supplement: none), to give a geometric point of $X$, it is equivalent to give an $x in X$ and a field extension $K supset.eq kappa\(x\)$. (A field $K$ is a local ring with the maximal ideal $\(0\)$, so to give $"Spec" K arrow.r X$ it is equivalent to give a local homomorphism $cal(O)_(X\,x) arrow.r^h K$. But then $ker h$ must be the maximal ideal and so $kappa\(x\)= frac(cal(O)_(X\,x), ker h) arrow.r.hook K$) $suit.club$#h(1em)If $X$ is a $K$-scheme then the set of $K$-valued points of $X$ are those $x in X$ such that $kappa\(x\)= K$. ($"Spec" K arrow.r X arrow.r "Spec" K$ must be identity)

#heading(level:4,numbering:none,outlined:false)[Fibers of Morphisms]
$f : X arrow.r Y$ morphism of schemes, $y in Y$, the #emph[scheme theoretic fiber of $f$ over $y$] is defined to be $"Spec" k\(y\)times_Y X$, The #emph[set theoretic fiber over $y$] is $f^(- 1)\(y\)subset.eq X$

$suit.club$#h(1em)$p_2 : "Spec" k\(y\)times_Y X arrow.r X$ is homeomorphism onto $f^(- 1)\(y\)$

#proof(title: "Proof")[
$forall x in f^(- 1)\(y\)$ there is a unique point in $"Spec" k\(y\)times_Y X$ mapping to $x$ under $p_2$

]
$suit.club$#h(1em)A #emph[geometric fiber] of $f : X arrow.r Y$ is the fiber over a geometric point $"Spec" K arrow.r Y$, i.e. $"Spec" K times_Y X$

#heading(level:4,numbering:none,outlined:false)[Subschemes and immersions]
$suit.club$#h(1em)$X$ scheme, $cal(J)$ is a quasi-coherent sheaf of ideals in $cal(O)_X$, let $Y := "supp"\(cal(O)_X / cal(J)\)$. Then $Y$ is a closed subset of $X$ and $\(Y\,cal(O)_Y\)$ is a scheme, $cal(O)_Y := i^(- 1)\(cal(O)_X / cal(J)\)$ where $i : Y arrow.r X$ is the inclusion.

#proof(title: "Proof")[

]
#statement("Definition")[
$\(Y\,cal(O)_Y\)$ is a #emph[subscheme] of $\(X\,cal(O)_X\)$ if $Y subset.eq X$ is locally closed and if $U = X -\(overline(Y) - Y\)$\(largest open subseteq of $X$ in which $Y$ is closed), then $Y = "supp" cal(O)_(X\|U) / cal(J)$ for some quasi-coherent sheaf of ideals in $cal(O)_(X\|U)$. In the case $U = X$ we say $Y$ is a #emph[closed subscheme] of $X$.

]
$suit.club$#h(1em)$exists$ bijection between closed subschemes of $X$ and quasi-coherent ideal sheaves of $cal(O)_X$

#proof(title: "Proof")[
This follows from the fact that if $cal(J)\,cal(J)'$ are tow quasi-coherent sheaves of ideals with the same support $Y$ and the restriction of $cal(O)_X\/cal(J)$, $cal(O)_X\/cal(J)'$ to $Y$ are the same, then $cal(J) = cal(J)'$ (follows from $I\,I' < A$ two ideals then $I = I' arrow.l.r.double A\/I = A\/I'$)

]
#statement("Remark")[
This bijection we should not the radical of ideals, because we are dealing with the #emph[scheme structures] rather than just the underlying topological space

]
#statement("Example")[
$X = bb(A)_(bb(C))^1 = "Spec" bb(C)\[x\]$, $cal(I)_k =\(x^k\)subset.eq bb(C)\[x\]$, $Y_k = "supp" X / cal(I)_k$ has a structure of a closed subscheme of $X$. $\(Y\,cal(O)_(Y_k)\)$ are all different schemes, but hte underlying topological spaces are all the same, i.e. a single point

]
#statement("Definition")[
We say a morphism $f : Y arrow.r X$ of schemes is an #emph[immersion(closed immersion, open immersion)] if it factors as $Y arrow.r^g Z arrow.r^i X$, when $g$ is an isomorphism and $Z$ is a subscheme (closed subcheme, open subscheme\[i.e. $Z subset.eq X$ open and $cal(O)_Z = cal(O)_X\|_Z$\]) of $X$

]
- A morphism $\(Y\,cal(O)_Y\)arrow.r^(\(phi\,theta\))\(X\,cal(O)_X\)$ is an open immersion iff $forall y in Y$, $theta_y^(\#) : cal(O)_(X\,phi\(y\)) arrow.r cal(O)_(Y\,y)$ is an isomorphism (here $theta^(\#) : phi^(- 1) cal(O)_X arrow.r cal(O)_Y$ is the adjoint of $theta : cal(O)_X arrow.r phi_(*) cal(O)_Y$), and $phi$ is homeomorphic onto an open subset of $X$.

  #proof(title: "Proof")[
  If $\(phi\,theta\)$ is an open immersion, then $theta^(\#)$ is an isomorphism ($phi^(- 1) cal(O)_X tilde.equiv cal(O)_X\|_(phi\(Y\))$), so $theta_y^(\#)$ is an isomorphism. Conversely, if all $theta_y^(\#)$ are isomorphisms, so is $theta^(\#)$, so again $phi^(- 1) cal(O)_X tilde.equiv cal(O)_X\|_(phi\(Y\))$

  ]

- With the same notation $\(phi\,theta\)$ is a (closed) immersion iff $forall y in Y$, $theta_y^(\#)$ is surjective and $phi$ is a homeomorphism onto (closed) locally closed subset of $X$.

  #proof(title: "Proof")[

  ]

- Immersions are examples of monomorphisms of schemes

- If $Y$ is a locally closed subset of a scheme $X$, there is a unique #emph[reduced scheme] structure on $Y$, making $Y$ a subscheme of $X$.

  #proof(title: "Proof")[
  If $X = "Spec" A$ and $Y$ is closed in $X$, let $I = inter_(p in Y) p = I\(Y\)$. It is a radical ideal and the largest ideal of $A$ such that $V\(I\)= Y$. In particular $A\/I$ is reduced and $"Spec" A\/I$ is the desired scheme structure on $Y$. In general, replace $X$ by $X -\(overline(Y) - Y\)$ so we can assume $Y subset.eq X$ is closed. Now for each open affine $U_i subset.eq X$, $Y_i = Y inter U_i$ is closed in $U_i$, so give it a reduced scheme structure as above. $forall i\,j$, the restriction of $cal(O)_(Y_i)$, $cal(O)_(Y_j)$ to $Y_i inter Y_j$ are isomorphic and these isomorphisms are compatible on triple intersections. To see this, one reduces to the case $U = "Spec" A$ and $V = "Spec" A_f$ for some $f in A$ and showing that the restriction $cal(O)_(Y inter U)$ (constructed before) to $Y inter V$ is isomorphic to $cal(O)_(Y inter V)$. This follows from this algebraic fact: If $I < A$ and $I = inter_(p in Y inter U) p$, then $I A_f = inter_(p in Y inter v) p$. Thus we can glue $cal(O)_(Y_i)$'s to get $cal(O)_Y o n$Y with desired property. Uniqueness follows from construction of $cal(O)_Y$in affine case

  ]

#heading(level:4,numbering:none,outlined:false)[Separatedness]
Recall schemes in general are $T_0$ spaces(Kolmogorov) and far from being $T_2$-space (Hausdorff). Many proofs in manifold theory use Hausdorff property. A topological space $X$ is Hausdorff $arrow.l.r.double$ the diagonal $Delta subset.eq X times X$ is closed. In scheme theory, doesn't give Hausdorff property (because the topology on $X times X$ is not the product topology). However it turns out imposing this diagonal condition will give us much nicer classes of schemes to work with (excluding examples such as the affine lines with two origins). As Grothendieck taught, many properties of schemes are more generally and canonically expressed as properties of morphism of schemes. Separatedness is an example as we weill see, with these motivations:

#statement("Definition")[
If $f : X arrow.r Y$ is a morphism of schemes, $\("id"_X\,"id"_X\)$ gives a morphism $delta : X arrow.r X times_Y X$ called #emph[diagonal morphism]. We will show $delta$ is an immersion, so its image is a subscheme of $X times_Y X$ denoted by $Delta_(X\/Y)$ or simply $Delta$ and called the #emph[diagonal] of $X$ over $Y$.

]
- $delta$ is an immersion.

  #proof(title: "Proof")[
  Cover $Y$ by open affine ${ V_i }$ and $X$ by open affine ${ U_(i j) }$ such that $f\(U_(i j)\)subset.eq V_i$. Then $U_(i j) times_(V_i) U_(i j)$ is an open affine in $X times_X$. ${ U_(i j) times_(V_i) U_(i j) }$ cover $Delta$ (but not necessarily $X times_Y X$) and $delta^(- 1)\(U_(i j) times_(V_i) U_(i j)\)= U_(i j)$. We are left to show $delta\|_(U_(i j)) : U_(i j) arrow.r U_(i j) times_(V_i) U_(i j)$ is a closed immersion. By construction, let $U_(i j) = "Spec" A$, $V_i = "Spec" B$, then $phi : A times.o_B A arrow.r A$, $a_1 times.o a_2 mapsto a_1 a_2$ is clearly surjective and so is the claim.

  ]

#statement("Definition")[
$f : X arrow.r Y$ is #emph[separated] if $delta$ is a closed immersion

]
- Morphism between affine schemes are separated.

- If $f : X arrow.r Y$ is a monomorphism, then $f$ is separated (In particular any immersion is separated)

  #proof(title: "Proof")[
  In this case $delta$ is an isomorphism ($arrow.r.double$ closed immersion). In fact we showed $X times_X X tilde.equiv X times Y X$ and $X times_X X tilde.equiv X$

  ]

- $bb(P)_A^n$ is separated as an $A$-scheme

  #proof(title: "Proof")[
  Cover $bb(P)_A^n times_A bb(P)_A^n$ by the open sets $U_i times_A U_j$. If $i = j$ as before can see $U_i arrow.r^delta U_i times_A U_j$ is a closed immersion. If $i eq.not j$ then $U_i times_A U_j tilde.equiv "Spec" A\[x_0 / x_i\,dots.h.c\,x_n / x_i\,y_0 / y_j\,dots.h.c\,y_n / y_0\]$. The restriction of $delta$ gives a morphism $U_i inter U_j arrow.r^delta U_i times_A U_j$ ($p_1 compose delta$, $p_2 compose delta$ are identities). The restriction is given by the ring homomorphism #math.equation(block: true, numbering: none, $A\[x_0 / x_i\,dots.h.c\,x_n / x_i\,y_0 / y_j\,dots.h.c\,y_n / y_0\]arrow.r A\[x_0 / x_i\,dots.h.c\,x_n / x_i\]_(x_j / x_i)\,x_k / x_i mapsto x_k / x_i\,y_k / y_i mapsto x_k / x_i\/x_j / x_i$) Which is evidently surjective and so $delta_(U_i inter U_j)$ is a closed immersion

  ]

#statement("Example")[
Affine line with two origins is not separated.

]
#heading(level:4,numbering:none,outlined:false)[More on base change]
- If $U subset.eq S$ is an open subscheme, then $X_U = U times_S X tilde.equiv f^(- 1)\(U\)$ is an open subscheme of $X$.

- If $V subset.eq S'$ is an open subscheme such that $g\(V\)subset.eq U$ under $g : S' arrow.r S$, then $V times_U f^(- 1)\(U\)= f_(S')^(- 1)\(V\)$

In both above two cases, there exists a natural morphism from RHS to both factors of the products in LHS. Then apply the universal property of fiber product

- The property of being a closed immersion (open immersion, immersion) is stable under base change.

  #proof(title: "Proof")[
  Suppose $f : X arrow.r S$ is a closed immersion, $g : S' arrow.r S$ ia a morphism, $forall s' in S'$, $exists$ open affine neighborhood $V$ of $s'$ and $U$ of $s = g\(s'\)$ such that $g\(V\)subset.eq U$. We know $f_(S')^(- 1)\(V\)tilde.equiv V times_U f^(- 1)\(U\)$, so by the following fact $f_(S')^(- 1)\(V\)arrow.r V$ is a closed immersion. Since we can cover $S'$ by open affines this shows $f_(S')$ is a closed immersion. \ The case of open immersion is immediate form what said in the previous case. \ By combining the stability of closed and open immersion the case of immersions also follows.

  ]

#statement("Fact")[
$phi : A arrow.r B$ surjective homomorphism of rings and $C$ any $A$-algebra, then $C tilde.equiv C times.o_A A arrow.r^(1 times.o phi) C times.o A_B$ is also surjective.

]
#statement("Example")[
If $Y_1\,Y_2$ are two closed subschemes of $X$, given by the quasicoherent ideal sheaves $cal(I)_1\,cal(I)_2$, then $Y_1 times_X Y_2$ is a closed subscheme of $X$ given by the ideal sheave $cal(I)_1 + cal(I)_2$, it is called the #emph[scheme theoretic intersection] of $Y_1\,Y_2$. \ e.g. $Y_1 = "Spec" bb(C)\[x\,y\]\/\(x\)$, $Y_2 = "Spec" bb(C)\[x\,y\]\/\(x - y^2\)$, then $Y_1 inter Y_2 = "Spec" bb(C)\[x\,y\]\/\(x\,y^2\)$ (which is a non-reduced point)

]
#statement("Definition")[
$f : X arrow.r Y$, $W subset.eq Y$ subscheme. $f^(- 1)\(W\):= X times_Y W$. By the previous item $f^(- 1)\(W\)$ is isomorphic to a subscheme of $X$ (inverse image of $W$). This notation (and name) is chosen because the first projection defines a homeomorphism onto the inverse image of $W$ under $f$ (To see this, one may reduce to the affine case: $X = "Spec" B$, $Y = "Spec" A$, $phi : A arrow.r B$, $W = V\(I\)$ for some $I lt.eq A$, Then the inverse image of $W$ is $V\(phi\(I\)\)tilde.equiv "Spec" B\/phi\(I\)tilde.equiv S p e c B times.o_A A\/I$)

]
#statement("Definition")[
We say a scheme $X$ is #emph[Noetherian(locally noetherian)] if $X$ has a finite open affine cover (open affine cover) ${ V_i = S p e c A_i }$ such that $A_i$ are noetherian

]
- If $X$ is locally noetherian, then $cal(O)_X$ is coherent. ($A_i$ noetherian $arrow.r.double$ $tilde(A_i)$ is coherent). Moreover, any quasi-coherent sub $cal(O)_X$-modules (in particular quasi-coherent ideal sheaves) and quotients $cal(O)_X$-modules of a coherent $cal(O)_X$-module $cal(F)$ are again coherent

#statement("Definition")[
$f : X arrow.r Y$ is of #emph[finite type] if $exists$ open affine covering ${ V_i = "Spec" A_i }$ of $Y$ such for each $i$, there is a finite open affine covering ${ U_(i j) = "Spec" B_(i j) }$ of $f^(- 1)\(V_i\)$ such that $B_(i j)$ is a finite type $A_i$-algebra. #emph[Locally finite type morphism] is defined by dropping \"finite\" from open affine covering of $f^(- 1)\(V_i\)$

]
#statement("Example")[
$bb(P)_A^n$ is finite type over $"Spec" A$

]
- A morphism $f : "Spec" B arrow.r "Spec" A$ is of finite type iff $B$ is finite type $A$-algebra.

- Suppose $X\,Y$ are two $S$-schemes and $Y$ is of finite type over $S$ and $x in X$, $y in Y$ are over a point $s in S$. If $\(psi\,theta\)\,\(psi'\,theta'\): X arrow.r Y$ are two $S$-morphism of schemes such that $psi\(x\)= y = psi'\(x\)$ and $theta_x^(\#) = theta' ""_x^(\#)$, then these two morphisms coincide in an open neighborhood of $x$.

  #proof(title: "Proof")[
  The assertion is local and so we can assume $S = "Spec" A$, $X = "Spec" B$, $Y = "Spec" C$ and the mrophisms are given by two $A$-algebra homomorphisms $phi\,phi' : C arrow.r B$ and think of $x\,y$ as prime ideals in $B\,C$ such that $phi^(- 1)\(x\)= y = phi' ""^(- 1)\(x\)$ with $phi_x = phi'_x : C_y arrow.r B_x$, and finally $C$ is a finite type $A$-algebra. Let $a_1\,dots.h.c\,a_n$ be generators of $C$ as $A$-algebra, and let $b_i = phi\(c_i\)$, $b'_i = phi\(c'_i\)$. By assumption $b_i\/1 = b'_i\/1$ in $B_x$, so $exists s_i in B - x$ such taht $s_i\(b_i - b'_i\)= 0$. Let $f = s_1 dots.h.c s_n in B - x$, then $b_i\/1 = b'_i\/1$ in $B_f$ and $iota compose phi = iota compose phi'$ ($iota : B arrow.r B_f$) means the two morphism of schemes agree on $D\(f\)$

  ]

- In the notation of previous item, suppose morever $S$ is locally noetherian, then for any local homomorphism $phi : cal(O)_(Y\,y) arrow.r cal(O)_(X\,x)$, $exists$ open neighborhood $U$ of $x$ and an $S$-morphism $\(psi\,theta\): U arrow.r Y$ such that $psi\(x\)= y$ and $theta_x^(\#) = phi$

#statement("Definition")[
A #emph[variety] is a reduced, separated and finite type over $k$

]
#statement("Definition")[
$X$ is #emph[affine over] $S$ if $exists$ open affine covering ${ S_i }$ of $S$ such that $f^(- 1)\(S_i\)$ with induced scheme structure from $X$ is affine for each $i$. We also say the morphism $f$ affine

]
#statement("Example")[
Closed immersions are affine morphisms

]
- $f : X arrow.r S$ is affine, then it is separated.

- $f : X arrow.r S$ affine and $U subset.eq S$ open, then $f^(- 1)\(U\)arrow.r^f U$ is affine. (The assertion is local, so reduce to $S = "Spec" A$, $X = "Spec" B$ and $f$ is given by homomorphism $phi : A arrow.r B$, and $U = D\(g\)$ for some $g in A$. But then $f^(- 1)\(U\)= D\(phi\(g\)\)$ is affine)

- If $f : X arrow.r S$ affine then for any quasi-coherent $cal(O)_X$-module $cal(F)$, $f_(*) cal(F)$ is quasi-coherent. (Reduce to $X\,S$ are affine)

- $S$ any scheme, $cal(B)$ quasi-coherent $cal(O)_S$-algebra. There is a $S$-scheme $X$ affine over $S$, unique up to isomorphism, such that $cal(A)\(X\)= cal(B)$.

  #proof(title: "Proof")[
  For any open affine $U subset.eq S$, let $X_U = "Spec" cal(B)\(U\)$. Since $cal(B)\(U\)$ is an $cal(O)_S\(U\)$-algebra, $X_U$ must be an $S$-scheme, and since $cal(B)$ is quasi-coherent, $cal(O)_(X_U)$ is identified with $cal(B)\|_U$

  ]

- $X$ is a scheme affine over scheme $S$. For any $S$-scheme $Y$ there is a bijection $"Hom"_S\(Y\,X\)arrow.l.r "Hom"_(cal(O)_S - upright("alg"))\(cal(A)\(X\)\,cal(A)\(Y\)\)$, $h mapsto cal(A)\(h\)$ (reduce to case when $X\,S$ are affine, then use the characterization of morphisms to affine schemes)

#statement("Definition")[
The $S$-scheme $X$ above is denoted by $X = "Spec" cal(B)$ and called the #emph[spectrum] of the $cal(O)_S$-algebra $cal(B)$.

]
Similarly we have

- $S$ any scheme, $cal(B)$ quasi-coherent $cal(O)_S$-algebra, $cal(M)$ quasi-coherent $cal(O)_S$ module that also has a structure of $cal(B)$ module, then $exists$ pair $\(X\,cal(F)\)$ of a scheme $X$ affine over $S$ and a quasi-coherent $cal(O)_X$ module $cal(F)$ such that $cal(A)\(X\)= cal(B)$ and $cal(A)\(cal(F)\)= cal(M)$. This pair is unique up to isomorphism. $cal(F)$ is also denoted as $tilde(cal(M))$, and is called the $cal(O)_X$-module associated to $cal(B)$-module $cal(M)$.

- Affine morphisms are stable under base change. (assertion can be reduced to the fiber product of affine schemes over an affine scheme is affine)

#heading(level:4,numbering:none,outlined:false)[Affine cones and vector bundles]
use examples of affine morphisms. If $X = "Spec" A$, $cal(E) = tilde(M)$ the $cal(O)_X$-module associated to an $A$-module $M$ then $"Sym"\(cal(E)\)tilde.equiv accent("Sym"\(M\), ̃)$ (this follows from $"Sym"\(M\)_f tilde.equiv "Sym"\(M_f\)\,forall f in A$). If $X$ is any scheme and $cal(E)$ a quasi-coherent $cal(O)_X$-module by what said above $"Sym"\(cal(E)\)$ is a quasi-coherent $cal(O)_X$-algebra.

#statement("Definition")[
$X$ any scheme, $cal(E)$ quasi-coherent $cal(O)_X$-module, $bb(V)\(cal(E)\):= "Spec" "Sym"\(cal(E)\)$ is called the #emph[affine cone] over $X$ associated to $cal(E)$.

]
- If $Y$ is any $X$-scheme, $exists$ bijections #math.equation(block: true, numbering: none, $"Hom"_X\(Y\,bb(V)\(cal(E)\)\)arrow.l.r "Hom"_(cal(O)_X - upright("alg"))\("Sym"\(cal(E)\)\,cal(A)\(Y\)\)arrow.l.r "Hom"_(cal(O)_X - upright("mod"))\(cal(E)\,cal(A)\(Y\)\)$) (First follows from the fact $bb(V)\(cal(E)\)$ is affine over $X$ and the second is the universal property of symmetric algebra). Now if $Y$ is an open subscheme of $X$, then any $X$-morphism $Y arrow.r bb(V)\(cal(E)\)$ is a $Y$-section of $p^(- 1)\(Y\)arrow.r Y$, where $p : bb(V)\(cal(E)\)arrow.r X$ is the structure morphism. So by the above fact $Y$-sections are in bijection with $"Hom"_(cal(O)_X)\(cal(E)\,j_(*) cal(O)_X\|_Y\)$ where $j : Y arrow.r.hook X$ is the inclusion. By adjunction this is the same as $"Hom"_(cal(O)_Y)\(cal(E)\,cal(O)_X\|_Y\)$. If $Y' subset.eq Y$ is a open, then clearly then restriction of $Y$-sections to $Y'$ is the result of restricting the corresponding $cal(O)_Y$-module homomorphism $cal(E)_Y arrow.r cal(O)_X\|_Y$ to $Y'$. This shows that

- The #emph[sheaf of germs of $X$-sections] of $bb(V)\(cal(E)\)$ is canonically identified with the dual $cal(E)^or$ of $cal(E)$. In particular the $0$-homomorphism $cal(E) arrow.r cal(O)_X$ corresponds to an $X$-section of $bb(V)\(cal(E)\)$ that is called the #emph[0-section].

- Now let $Y = "Spec" K arrow.r^f X$ corresponding to some $x in X$ and extension of fields $k\(x\)arrow.r K$. The geometric points $"Spec" K arrow.r bb(V)\(cal(E)\)$ with values in the extension $K\/k\(x\)$ have image in $p^(- 1)\(x\)$. The set of such points is called the #emph[geometric fiber over $x$ of $bb(V)\(cal(E)\)$ rational over $K$]

- If $cal(E)\,cal(F)$ are two quasi-coherent $cal(O)_X$-module, $bb(V)\(cal(E) xor cal(F)\)tilde.equiv bb(V)\(cal(E)\)times_X bb(V)\(cal(F)\)$ (follows from $"Sym"\(M xor N\)tilde.equiv "Sym"\(M\)times.o_A "Sym"\(N\)$)

- If $g : X' arrow.r X$ is such that $bb(V)\(g^(*)\(cal(E)\)\)tilde.equiv bb(V)\(cal(E)\)_(X')$ (follows from $"Sym"\(g^(*) cal(E)\)tilde.equiv g^(*) "Sym"\(cal(E)\)$)

#statement("Definition")[
If $cal(E)$ is locally free of rank $n$, $bb(V)\(cal(E)\)$ is called the #emph[vector bundle] associated to $cal(E)$. (Each fiber is a vector space of dimension $n$)

]
#aside("Note")[
If $cal(E)\|_U tilde.equiv cal(O)_X^n\|_U$ for some open affine $U = "Spec" A subset.eq X$, then $bb(V)\(cal(E)_U\)tilde.equiv "Spec" A\[x_1\,dots.h.c\,x_n\]tilde.equiv U times bb(A)_(bb(Z))^n$

]
#heading(level:4,numbering:none,outlined:false)[Proj construction]
$S = xor_(n gt.eq 0) S_n$ graded ring, $S_(+) = xor_(n > 0) S_n$, $M = xor_(n in bb(Z)) M_n$ graded $S$-module, $M_n$ is $S_0$-module formed by homogeneous elements of $M$ of degree $n$. Given $M\,S$ as above: $S^(\(d\)) = xor_(n gt.eq 0) S_(n d)\,\(d > 0\)$ is a graded ring. $M^(\(d\,k\)) = xor_(n in bb(Z)) M_(n d + k)\,\(d > 0\,0 lt.eq k lt.eq d - 1\)$ is a graded $S^(\(d\))$-module, $M^(\(d\)) = M^(\(d\,0\))$, define $M\(d\)$ to be the graded $S$-module with $M\(d\)_n = M_(d + n)$. In particular, $S\(d\)$ is a graded module. We say $M$ is #emph[free] (as a graded $S$-module) if it is a direct sum of $S$-modules $S\(d\)$ (with different $d$'s). We say $M$ admits #emph[finite presentation] (as graded $S$-module) if $exists$ sequence of $S$-modules $P arrow.r Q arrow.r M arrow.r 0$ with $P\,Q$ are free of finite rank and homomorphisms are all graded (i.e. have degree $0$, we say a homomorphism $u : M arrow.r N$ of graded $S$-modules have #emph[degree $k$] if $u\(M_j\)subset.eq N_(j + k)$. Denote by $"Hom"_S\(M\,N\)\(k\)$ the direct sum over $k$ of the spaces of all degree $k$ homomorphisms). If $M\,N$ are graded $S$-modules, first note that $M times.o_(bb(Z)) N$ is a graded $bb(Z)$-module($bb(Z) = bb(Z)_0$): $\(M times.o_(bb(Z)) N\)_k = xor_(m + n = k) M_m times.o_(bb(Z)) N_n$ so $M times.o_S N tilde.equiv\(M times.o_(bb(Z)) N\)\/P$ is also graded, where $P$ is a graded sub $bb(Z)$-module generated by all $\(x s\)times.o y - x times.o\(s y\)$ for $x in M\,y in N\,s in S$. Then following are easy to prove

- $M\(m\)times.o_S N\(n\)=\(M times.o_S N\)\(m + n\)$

- $"Hom"_S\(M\(m\)\,N\(n\)\)tilde.equiv "Hom"_S\(M\,N\)\(n - m\)$

- If $phi : S arrow.r S'$ is a homomorphism of #emph[graded rings]\(i.e. $phi\(S_n\)subset.eq S'_n$), then $S'$ gets a structure of a graded $S$-module

- If $S$ graded ring and $f in S_d$ for some $d > 0$, then $S_f$ is a graded: $\(S_f\)_n = { x\/f^k\|x in S_(n + k d)\,k gt.eq 0 }$. Its degree $0$ elements form a ring, most of time denoted by $S_(\(f\))$. Similarly if $M$ is a graded $S$-module generated by degree $0$ elements of $M_f$

#statement("Definition")[
$S$ graded ring, $"Proj"\(S\)= { P < S upright("homogeneous and prime")\|p supset.eq.not S_(+) }$, the #emph[homogeneous prime spectrum] of $S$. Note $"Proj" S subset.eq "Spec" S$. The closed subsets are ${ V_(+)\(E\)}_(E subset.eq S)$, where $V_(+)\(E\)= V\(E\)inter "Proj" S$. (So the topology is induced from $"Spec" S$) Note: $V_(+)\(0\)= "Proj" S$, $V_(+)\(S\)= V_(+)\(S_(+)\)= diameter$, $V_(+)\(union_i E_i\)= inter_i V_(+)\(E_i\)$, $V_(+)\(E E'\)= V_(+)\(E\)inter V_(+)\(E'\)$, $V_(+)\(E\)= V_(+)\(J\)$, $J$ is the homogeneous ideal generated by $E$

]
- If $J < S$ is a homogeneous ideal, $V_(+)\(J\)= V_(+)\(inter_(q gt.eq n)\(J inter S_1\)\)$, $forall n > 0$ (If $p in "Proj" S$ contains the elements of $J$ of degree $gt.eq 0$, since we know $exists f in S_d\,\(d > 0\)$, $f in.not p$, so $forall m gt.eq 0$ and $x in J inter S_m$, $f^r x in J inter S_(m + r d)$, so except for finitely many $r$, $f^r x in P inter S_(m + r d) arrow.r.double x in p inter S_m$)

- If $J < s$ is a homogeneous ideal, $V_(+)\(J\)= V_(+)\(sqrt(J) inter S_(+)\)$ (use previous item)

#heading(level:4,numbering:none,outlined:false)[Image of morphisms]
Suppose $f : X arrow.r Y$ is a morphism is a morphism of schemes such that $f_(*) cal(O)_X$ is quasi-coherent (e.g. this is the case if $f$ is quasi-compact and separate). Let $cal(K)$ be the kernel of the homomorphism $theta : cal(O)_Y arrow.r f_(*) cal(O)_X$. Then $cal(K)$ is a quasi-coherent ideal sheaf in $cal(O)_Y$. Let $Z$ be the closed subscheme of $Y$ defined by $cal(K)$. Then $Z$ is the smallest subscheme of $Y$ such that $f^(- 1)\(Z\)$ (scheme theoretic) is equal to $X$. To see the last claim, note that $theta$ factors as $theta : cal(O)_Y arrow.r cal(O)_Y\/cal(K) arrow.r^(theta') f_(*) cal(O)_X$, that induces (by adjoint property) $theta^(\#) : f^(- 1) cal(O)_Y arrow.r f^(- 1) cal(O)_Y\/f^(- 1) cal(K) arrow.r^(theta' ""^(\#)) cal(O)_X$ ($f^(- 1)$ is an exact functor). $forall x in X$, $theta_x^(\#)$ is a local homomorphism $arrow.r.double theta' ""_x^(\#)$ is a local homomorphism. This shows that $f$ factors as $f : X arrow.r^(f') Z arrow.r^j Y$, where $j$ is a closed immersion. Now we have Cartesian diagonal

#statement("Definition")[
$Z$ is called #emph[scheme theoretic image] of $f : X arrow.r Y$

]
$suit.club$#h(1em)As topological spaces $Z = overline(f\(X\))$. If $f$ is a immersion $f\(X\)$ is open in $Z$

#proof(title: "Proof")[
We know that $f_(*) cal(O)_X$ is a quasi-coherent

]
#heading(level:4,numbering:none,outlined:false)[Projective morphisms]
Suppose $X$ is a $Y$-scheme, the following are equivalent

+ $X$ is $Y$-isomorphic to a closed subscheme of $bb(P)\(cal(E)\)$ where $cal(E)$ is a quasi-coherent $cal(O)_Y$-module of finite type.

+ $exists$ quasi-coherent graded $cal(O)_Y$-algebra $cal(S)$ such that $cal(S)$ is of finite type and generates $cal(S)_1$ and $X$ is $Y$-isomorphism to $"Proj" cal(S)$

#proof(title: "Proof")[
$arrow.r.double$: Let $cal(I)$ be the graded quasi-coherent ideal sheaf of $"Sym"\(cal(E)\)$

]
#statement("Definition")[
$Y$ is complete and separated, $f : X arrow.r Y$ #emph[projective] if one the equivalent condition above is satisfied

]
#statement("Definition")[
$f : X arrow.r Y$ is proper if $f$ is separated, finite type and universally closed

]
$suit.club$#h(1em)Any closed immersion is proper

$suit.club$#h(1em)Composition of proper maps are again proper

#heading(level:4,numbering:none,outlined:false)[A nice application of properness]
Let $k$ be an algebraically closed field and $X$ is a connected reduced proper $k$-scheme, then $Gamma\(X\,cal(O)_X\)= k$

#proof(title: "Proof")[
Suppose $f in Gamma\(X\,cal(O)_X\)$. Using the bijection $"Hom"_k\(X\,bb(A)_k^1\)arrow.l.r "Hom"_k\(k\[x\]\,Gamma\(X\,cal(O)_X\)\)$, so $f$ corresponds to morphism $pi : X arrow.r bb(A)_k^1$, let $i : bb(A)_k^1 arrow.r bb(P)_k^1$ be an open immersion (recall construction of $bb(P)_k^1$). So we get a morphism $i compose pi : X arrow.r bb(P)_k^1$. Since $X$ is proper over $k$ and $bb(P)_k^1$ is separated over $k$, we find taht $i compose pi$ is proper, so in particular the image of $i compose pi$ is closed in $bb(P)_k^1$. Since $k = overline(k)$ the image is either $bb(P)_k^1$ or a single point ($X$ is a connected). But the image is contained in $bb(A)_k^1 subset.eq bb(P)_k^1$, so the scheme theoretically is a reduced point

]
#heading(level:4,numbering:none,outlined:false)[Dimensions]
If $X = "Spec" A$, $dim X = dim A = max_n p_0 subset.neq p_2 subset.neq dots.h.c subset.neq p_n$ is the Krull dimension

#statement("Example")[
$dim "Spec" k = 0$, $dim "Spec" bb(Z) = 1$, $dim bb(A)_(bb(Z))^1 = 2$

]
- $dim X$ is the supremum of lengths of chains of irreducible closed subsets of $X = "Spec" A$, which is $dim X$ as topological space

- If $A$ is an integral domain, finitely generated over a field $k$, then $dim A = "tr" . deg_k Q\(A\)$

#statement("Definition")[
Dimension of a scheme $X$ is its dimension as a topological space. If $Y subset.eq X$ is a irreducible subset, $"codim"\(Y\,X\)$ is defined to be the supremum of lengths of increasing closed subsets $overline(Y) = Y_0 subset.neq dots.h.c subset.neq Y_n$. e.g. If $p in "Spec" A$, then $"codim"\({ p }\,"Spec" A\)= "ht"\(p\)= dim A_p$

]
- If $X = Y union Z$, $Y\,Z subset.eq X$ closed, $dim X = max\(dim Y\,dim Z\)$

- If $Y subset.eq X$ irreducible and closed, $"codim"\(Y\,X\)= dim cal(O)_(X\,eta)$, $eta$ is the generic point of $Y$. And $"codim"\(Y\,X\)= 0 arrow.l.r.double Y$ is an irreducible component of $X$

- $A$ is a UFD, any irreducible closed subset $Y subset.eq "Spec" A$ of codimension 1 is of the form $V\(f\)$ for some $f in A$

  #proof(title: "Proof")[
  $exists$ height 1 prime $p subset.eq A$ such that $Y = V\(p\)$. Let $0 eq.not g in p$, and let $f$ be an irreducible factor of $g$ so $\(0\)subset.eq\(f\)subset.eq p$ is a chain of prime ideals. Since $"ht" p = 1 arrow.r.double p =\(f\)$

  ]

#statement("Example")[
In $"Spec" frac(k\[x\,y\,z\], \(z^2 - x y\))$, $V\(x\,z\)$ is of codimension 1 but not of the form $V\(f\)$

]
$suit.club$#h(1em)Suppose $X$ is a k-scheme locally of finite type and of pure dimension $d$\(i.e. each irreducible component of $X$ has dimension $d$). If $Y subset.eq X$ irreducible closed subset, then $"codim"\(Y\,X\)+ dim Y = d$

#proof(title: "Proof")[
Since $Y$ is irreducible it must be contained in one of the irreducible components of $X$. So we reduce to the case $X$ is an integral affine $k$-scheme. Also, by induction, we may reduce to proving that if $Z subset.neq X$ is a maximal, irreducible, closed subset, then $dim Z = d - 1$. By Noether normalization theorem~#ref(label("Noether normalization theorem"), supplement: none) $exists$ finite and surjective morphism $f : X arrow.r bb(A)_k^d$, let $Z'$ be the scheme theoretic image of $f$. Since $f$ is closed, as topological spaces $Z' = f\(Z\)$. $f\|_Z : Z arrow.r Z'$ is also a finite morphism and by going up theorem $dim Z = dim Z'$. If we show that $dim Z' = d - 1$ we are done. Since $dim Z' = dim Z < d$, we have to show $dim Z' < d - 1$ is impossible. Let $f in k\[x_1\,dots.h.c\,x_d\]$, then $\(f\)$ corresponds to a closed subscheme $H subset.eq bb(A)^d$ containing $Z'$. By Krull's Hauptidealsatz~#ref(label("Krull's principal ideal theorem"), supplement: none) each irreducible compnent of $H$ has dimension $d - 1$, so $Z'$ being irreducible is properly contained in an irreducible component $H_1 subset.eq H$. By going down theorem~#ref(label("Going down theorem"), supplement: none), $exists$ closed irreducible subset $V subset.eq X$ containing $Z$ contradicting its maximality.

]
#statement("Theorem", title: [Noether normalization theorem])[
$A$ is integral domain which is a finitely generated $k$-aglebra. If $"tr" . deg_k Q\(A\)= n$, $exists x_1\,dots.h.c\,x_n in A$ algebraically independent over $k$ such that $A$ is a finite extension of the polynomial subring $k\[x_1\,dots.h.c\,x_n\]$

]#label("Noether normalization theorem")
#statement("Theorem", title: [Krull's principal ideal theorem])[
$A$ Noetherian ring, $f in A$ is neither a unit nor a zero divisor. Then any minimal prime ideal containing $f$ has height 1

]#label("Krull's principal ideal theorem")
#statement("Theorem", title: [Going down theorem])[
$phi : B arrow.r.hook A$ finite ring extension, where $B$ integrally closed domain and $A$ is an integral domain. Given nested prime ideals $q subset.eq q' subset.eq B$ and a prime ideal $p' < A$ lying over $q'$, $exists$ prime $p < A$ contained in $p'$ and lying over $q$

]#label("Going down theorem")
#statement("Proposition")[
$A$ Noetherian integral domain. Then $A$ is a UFD $arrow.l.r.double$ all height 1 prime ideals are principal

]
#proof(title: "Proof")[

]
#statement("Theorem", title: [Krull's height theorem])[
$A$ Noetherian ring. $p < A$ minimal prime containing some given $f_1\,dots.h.c\,f_n in A$, then $"ht" p lt.eq n$. This means that if $Z$ is a irreducible component of $V\(f_1\,dots.h.c\,f_n\)subset.eq "Spec" A$, then $"codim"\(Z\,"Spec" A\)lt.eq n$

]#label("Krull's height theorem")
#statement("Lemma", title: [Algebraic Hartog's lemma])[
$A$ integrally closed noetherian domain, then #math.equation(block: true, numbering: none, $A = inter.big_(p < A\,"ht" p = 1) A_p$) (Hartog's lemma in several complex variables says that holomorphic functions defined away from a codimension 2 set can be extended over)

]#label("Algebraic Hartog's lemma")
#statement("Definition")[
A scheme $X$ is called #emph[normal] (resp. #emph[locally factorial, regular]) if for $x in X$, $cal(O)_(X\,x)$ is an integral domain integrally closed in its fraction field (resp. UFD, regular=Noetherian and $dim cal(O)_(X\,x) = dim_(k\(x\)) m_x / m_x^2$)

]
These properties of $X$ are #emph[stalk-local properties], os is reducedness. But integrality of $X$ is not stalk-local. e.g. $"Spec" k product.co "Spec" k$

$suit.club$#h(1em)regular $subset$ locally factorial $subset$ normal $subset$ reduced. This first inclusion is the deepest (Auslander-Buchbaum)

$suit.club$#h(1em)$X$ noetherian, integral, normal scheme, $Z$ closed subscheme, each of its irreducible components has codimension 2, then $Gamma\(X - Z\,cal(O)_X\)= Gamma\(X\,cal(O)_X\)$

#proof(title: "Proof")[
Let $U = "Spec" A subset.eq X$ be open affine. We know that $A$ integrally closed $arrow.l.r.double A_p$ integrally closed $forall p < A$ prime $arrow.l.r.double A_m$integrally closed $forall m < A$ maximal. We can apply lemma~#ref(label("Algebraic Hartog's lemma"), supplement: none), we know #math.equation(block: true, numbering: none, $Gamma\(U - Z\,cal(O)_X\)= inter.big_(p in U - Z\,"ht" p = 1) A_p supset.eq inter.big_(p in U\,"ht" p = 1) A_p = Gamma\(U\,cal(O)_X\)= A$) Cover $X$ by open affines ${ U_i }_(i in I)$, then #math.equation(block: true, numbering: none, $Gamma\(X - Z\,cal(O)_X\)= inter.big_(i in I) Gamma\(U_i - Z\,cal(O)_X\)= Gamma\(U_i\,cal(O)_X\)= Gamma\(cal(O)_X\)$)

]
#statement("Example")[
$Gamma\(bb(A)_k^2 - 0\,cal(O)_(bb(A)_k^2)\)= k\[x\,y\]= Gamma\(bb(A)_k^2\,cal(O)_(bb(A)_k^2)\)$

]
$suit.club$#h(1em)If $X$ is a local Noetherian scheme, $x in X$. If $dim cal(O)_(X\,x) = d$, then $exists g_1\,dots.h.c\,g_d in cal(O)_(X\,x)$ such that $V\(g_1\,dots.h.c\,g_d\)= { x }$ in $"Spec" cal(O)_(X\,x)$ ($arrow.r.double$ so $exists$ open neighborhood $U subset.eq X$ of $x$ and $f_1\,dots.h.c\,f_d in cal(O)_X\(U\)$ such that $V\(f_1\,dots.h.c\,f_d\)= overline({ x })$ in $U$). Such $g_1\,dots.h.c\,g_d$ are called a #emph[system of parameters] for $cal(O)_(X\,x)$

#proof(title: "Proof")[

]
$suit.club$#h(1em)$pi : X arrow.r Y$ is a morphism of locally Noetherian schemes and $x in X$, $y = pi\(x\)$. Then #math.equation(block: true, numbering: none, $"codim"\(x\,X\)lt.eq "codim"\(y\,Y\)+ "codim"\(x\,pi^(- 1)\(y\)\)$)

#proof(title: "Proof")[

]
#statement("Example")[
$pi : "Bl"_0\(bb(A)_k^2\)arrow.r bb(A)_k^2$. If $x in pi^(- 1)\(0\)$ is a closed point, then inequality is strict. If $x in.not pi^(- 1)\(0\)$ is a closed point, then we have equality

]
#statement("Definition")[
We say a scheme $X$ is #emph[regular in codimension 1] if $cal(O)_(X\,x)$ is regular for all $x in X$ with $"codim"\(x\,X\)$

]
#statement("Example")[
$X = "Spec" k\[x\,y\,z\]$ is regular in codimension 1 (but not in codimension 2)

]
#statement("Definition")[
A #emph[discrete valuation] over a field $K$ is a map $v : K^times arrow.r bb(Z)$ such that $v\(x y\)= v\(x\)+ v\(y\)$ and $v\(x + y\)gt.eq min\(v\(x\)\,v\(y\)\)$, define $v\(0\)= oo$. #emph[Discrete valuation ring(DVR)] corresponding to $v$ is a $R = { x in K\|v\(x gt.eq 0\)}$. It is a local ring with a unique prime ideal $m = { x in K\|v\(x > 0\)}$. Note that $v\(1\)= v\(1\)+ v\(1\)arrow.r.double v\(1\)= 0$ and $v\(x^(- 1)\)= - v\(x\)$, so either $x$ or $x^(- 1)$ is in $R$ $arrow.r.double K = "Frac"\(R\)$

]
#statement("Remark")[
If we use a totally ordered abelian group $G$ in the definition, we get a valuation

]
#statement("Proposition", title: [Atiyah-Macdonald, Prop 9.2])[
$R$ is a noetherian local domain of dimension 1 with maximal ideal $m$, then the following are equivalent

+ $A$ is a DVR

+ $A$ is integrally closed

+ $A$ is regular

+ $m$ is principle

]
#statement("Corollary")[
If $X$ is noetherian and normal, then it is regular in codimension 1

]
#statement("Definition", title: [Weil divisor])[

]
$suit.club$#h(1em)$Y subset.eq X$ is a prime divisor, $y in Y$ is the generic point, by assumption $cal(O)_(X\,y)$ is regular of dimension 1, so it induces a valuation $v_Y : K^times arrow.r bb(Z)$ where $K = Q\(cal(O)_(X\,y)\)= R\(X\)$ the field of rational functions on $X$

$suit.club$#h(1em)It follows form #emph[valuation criterion for separatedness] that a discrete valuation of $K$ uniquely determine a prime divisor If $x in X$

#statement("Definition")[
$f in K^times$, if $v_Y\(f\)> 0$ (resp. $< 0$) we say $f$ has a zero (resp. pole) of order $v_Y\(f\)$ (resp. $- v_Y\(f\)$) along $Y$

]
$suit.club$#h(1em)Given $f in K^times$, $v_Y\(f\)= 0$ for all but finitely many prime divisors $Y subset.eq X$

#statement("Definition")[
$f in K^times$, define divisor $\(f\):= sum_(Y subset.eq X upright(" prime divisor")) v_Y\(f\)Y$. $D in D i v\(X\)$ is called #emph[principal] if $D =\(f\)$ for some $f in K^times$

]
#statement("Example")[
A UFD $arrow.l.r.double "Cl"\("Spec" A\)= 0$ and $"Spec" A$ is normal. e.g. $"Cl"\(bb(A)_n^k\)= 0$

]
#statement("Example")[
A Dedekind domain (integrally closed noetherian domain of dimension 1), $"Cl"\("Spec" A\)$ is the same as the ideal class group of $A$. e.g. $A = bb(R)\[x\,y\]\/\(x^2 + y^2 - 1\)$ is a Dedekind domain which is not a UFD. (equivalently it is not a PID)

]
#heading(level:4,numbering:none,outlined:false)[Cartier divisors]
Recall the sheaf $cal(R)_X$ of rational functions

#statement("Definition")[
A #emph[Cartier divisor] on $X$ is a global section of $cal(R)_X^times\/cal(O)_X^times$. Such a global section can be described by an open covering ${ U_i }_(i in I)$ of $X$, and $forall i$, $f_i in Gamma\(U_i\,cal(R)_X^times\)$

]
#heading(level:4,numbering:none,outlined:false)[Derived functors in algebraic goemetry]
The categories that we will work with are all abelian categories: $mono("Ab")$ abelian groups, $mono("Mod")\(A\)$ $A$-modules. $mono("Ab")\(X\)$ sheaves of abelian groups on topological space $X$. $mono("Mod")\(X\)$ sheaves of $cal(O)_X$-modules on a ringed space $\(X\,cal(O)_X\)$, $mono("Qcoh")\(X\)$ quasi-coherent $cal(O)_X$-modules on a scheme $X$, $mono("Coh")\(X\)$ coherent $cal(O)_X$-modules on a noetherian scheme $X$

#statement("Example", title: [Examples of additive functors])[
Let $f : X arrow.r Y$ be a morphism of ringed spaces. $Gamma : mono("Ab")\(X\)arrow.r mono("Ab")$, left exact. $f_(*) : mono("Mod")\(X\)arrow.r mono("Mod")\(Y\)$ left exact, $f^(*) : mono("Mod")\(Y\)arrow.r mono("Mod")\(X\)$ right exact. $"Hom"_(cal(O)_X)\(cal(F)\,-\): mono("Mod")\(X\)arrow.r mono("Ab")$ left exact. $"Hom"_(cal(O)_X)\(-\,cal(F)\): mono("Mod")\(X\)arrow.r mono("Ab")$ left exact(contravariant). $cal(H) o m_(cal(O)_X)\(cal(F)\,-\): mono("Mod")\(X\)arrow.r mono("Mod")\(X\)$ left exact. $cal(H) o m_(cal(O)_X)\(-\,cal(F)\): mono("Mod")\(X\)arrow.r mono("Mod")\(X\)$ left exact(contravariant)

]
$suit.club$#h(1em)$\(X\,cal(O)_X\)$ is a ringed space, $mono("Mod")\(X\)$ has enough injectives

#proof(title: "Proof")[

]
#statement("Definition")[
$j : U arrow.r.hook X$ open and $cal(F) in mono("Ab")\(U\)$ or $mono("Mod")\(U\)$. Define $j_(!) cal(F)$ to be a sheaf on $X$ associated wot the presheaf $V mapsto cases(cal(F)\(V\)\,V subset.eq U, 0\,upright(" else"))$. It is called the sheaf obtained by #emph[extending $cal(F)$ by zero outside $U$], note $\(j_(!) cal(F)\)_x = cases(cal(F)_x\,x in U, 0\,x in.not U)$

]
$suit.club$#h(1em)If $cal(F)$ is a sheaf on $X$, there exists a SES $0 arrow.r j_(!)\(cal(F)_U\)arrow.r cal(F) arrow.r i_(*)\(cal(F)_Z\)arrow.r 0$, $forall U arrow.r.hook^j X$ open and $Z := X - U arrow.r.hook^i X$

$suit.club$#h(1em)$f : X arrow.r Y$ is a continuous map between topological spaces, $cal(F) in mono("Ab")\(X\)$, then $R^i f_(*) cal(F)$ is the sheaf associated to the presheaf $V mapsto H^i\(f^(- 1)\(V\)\,cal(F)\|_(f^(- 1)\(V\))\)$, $forall Y subset.eq Y$ open

#proof(title: "Proof")[
Denote the sheaf associated to this presheaf by $cal(H)^i\(X\,cal(F)\)$

]
#heading(level:4,numbering:none,outlined:false)[Preliminaries on Koszul complexes]
#heading(level:4,numbering:none,outlined:false)[Derivatives and differentials]
#statement("Definition")[
$A$ ring, $B$ is an $A$-algebra, $M$ is a $B$ module. An #emph[$A$-derivation] from $B$ to $M$ is a map $d : B arrow.r M$ such that $d\(b + b'\)= d b + d b'$, $d\(b b'\)= b\(d b'\)+\(d b\)b'$, $d a = 0$, $forall a in A\,b\,b' in B$, $"Der"_A\(B\,M\)$ denotes the set of all such derivations

]
#statement("Definition")[
Given $A$-algebra $B'$ and a square zero ideal $N < B'$ with $N^2 = 0$, let $B = B'\/N$\(then $N$ can also be viewed as a $B$-module). We say that $B'$ is an #emph[extension] at the $A$-algebra $B$ by the $B$-module $N$. The extension $B'$ is #emph[trivial] denoted by $B * N$ if $B' tilde.equiv B xor N$ as $B$-module with multiplication $\(b_1\,n_1\)\(b_2\,n_2\)=\(b_1 b_2\,b_1 n_2 + n_1 b_2\)$

]
$suit.club$#h(1em)Given a square zero extension $0 arrow.r N arrow.r B' arrow.r B arrow.r 0$ as above and an $A$-algebra $C$ with an $A$-algebra homomorphism $g : C arrow.r B$ such that there is a lift of $g$, $h : C arrow.r B'$, then there exists bijection between $"Der"_A\(C\,N\)$ and the set of lifts of $g$. (If $h' : C arrow.r B'$ is another lift, then $h - h' in "Der"_A\(C\,N\)$, and if $D in "Der"_A\(C\,N\)$, then $h + D$ is a lift of $g$)

$suit.club$#h(1em)The functor $"Der"_A\(B\,-\): upright("Mod") B arrow.r upright("Mod") B$ is representable, i.e. there exists $B$-module $Omega_(B\/A)$ such that $forall D in "Der"_A\(B\,M\)$, $exists ! B$-module homomorphism $f : Omega_(B\/A) arrow.r M$ such that $D = f compose d$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$Omega_(B\/A)$]),
node((1,1),[$M$]),
edge((0,0),(1,1),"->",[$D$]),
edge((0,0),(1,0),"->",[$d$]),
edge((1,0),(1,1),"->",[$f$]))]
]
#proof(title: "Proof")[

]
$suit.club$#h(1em)If $B$ is generated by ${ b_i }_(i in I)$ as an $A$-algebra, then $Omega_(B\/A)$ is generated as a $B$-module by ${ d b_i }_(i in I)$

#statement("Example")[
If $B = A\[x_1\,dots.h.c\,x_n\]$, then $Omega_(B\/A)$ is the free $B$-module with basis $d x_1\,dots.h.c\,d x_n$. ($d x_1\,dots.h.c\,d x_n$ are linearly independent by universal property and that there are $A$-derivations $D_i in "Der"_A\(B\,B\)$ defined by $D_i x_j = delta_(i j)$)

]
#heading(level:4,numbering:none,outlined:false)[Formal schemes]
$X$ Noetherian, $Y subset.eq X$ closed subscheme defined by quasi-coherent $cal(I) < cal(O)_X$. The #emph[formal completion] of $X$ along $Y$ is a ringed space $\(hat(X)\,cal(O)_(hat(X))\)$, where $hat(X) = Y$

#pagebreak(weak:true)
#pagebreak(weak:true)

#pagebreak()
#heading(numbering:none)[References]
#emph[Algebraic Geometry] - J.S. Milne


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
