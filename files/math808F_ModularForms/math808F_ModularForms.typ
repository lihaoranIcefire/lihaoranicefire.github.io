#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH808F - Modular Forms", author: "Haoran Li")
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

#let aside(name, title: none, body) = block(breakable: true)[*#name#if title != none [(#title)].* #body]
#let numbered-equation(body) = math.equation(block: true, numbering: "1", body)
#let svg-drawing(body, width: 85%, height: 160) = align(center, image(bytes("<svg xmlns='http://www.w3.org/2000/svg' width='440' height='" + str(height) + "' viewBox='0 0 440 " + str(height) + "'><defs><marker id='a' markerWidth='6' markerHeight='6' refX='5' refY='3' orient='auto'><path d='M0 0L6 3L0 6' fill='none' stroke='black'/></marker></defs><g fill='none' stroke='black' stroke-width='1.2'>" + body + "</g></svg>"), width: width))


#align(center)[
  #set par(justify: false)
  #v(1cm)
  #text(size: 22pt, weight: "bold")[MATH808F \ Modular Forms]
  #v(2cm)
  #image("Pictures/Langlands.jpg", width: 50%)
  #v(2cm)
  Taught by Jingren Chi \
  Notes taken by Haoran Li \
  2020 Fall
  #v(2cm)
  Department of Mathematics \
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()

= Overview

#statement("Definition")[
$G$ is a Lie group, $K lt.eq G$ is a closed subgroup, $X = G\/K$ is then a homogeneous space with transitive left $G$-action, $Gamma lt.eq G$ is a discrete subgroup. The so called #emph[automorphic functions]#index-entry("Automorphic functions") are $bb(C)$-valued functions $f$ on $X$ such that #numbered-equation($f\(gamma dot.op x\)= f\(x\)\,quad forall x in X\,gamma in Gamma$)#label("Automorphic function") Loosely speaking, #emph[automorphic forms]#index-entry("Automorphic forms") (for $Gamma$) on $X$ are automorphic functions that are also eigenfunctions for invariant differential operators on $X$ (+ some technical growth conditions when necessary)

]
#statement("Question")[
How to decompose automorphic functions into sums (or integrals) of automorphic forms

]
#statement("Example")[
$Gamma = bb(Z)$, $X = G = bb(R)$, automorphic functions are functions on $bb(R)\/bb(Z) = bb(T)$, automorphic forms are $e^(2 pi i n x)$, $n in bb(Z)$. Fourier analysis tells us $L^2\(bb(R)\/bb(Z)\)= hat(xor.big)_(n in bb(Z)) bb(C) e^(2 pi i n x)$

]
#statement("Example")[
$G = "SL"_2\(bb(R)\)$, $K = "SO"\(2\)$, $Gamma lt.eq "SL"_2\(bb(Z)\)$ is a finite index subgroup, $G\/K = cal(H) = { "Im" z > 0 }$ is the Poincaré upper half plane. $G$-invariant differential operators on $cal(H)$ are polynomials with constant coefficients of the hyperbolic Laplacian $Delta = - y^2 (frac(partial^2, partial x^2) + frac(partial^2, partial y^2))$, Examples of automorphic forms in this setting: Maass forms. $Gamma$ are sometimes called \"modular groups\", the corresponding automorphic forms on $cal(H)$ are called #emph[modular forms]#index-entry("Modular forms")

]
#aside("Note")[
$cal(H)$ has the structure of a complex manifold, it is natural to look for holomorphic automorphic forms

]
#statement("Example")[
#math.equation(block: true, numbering: none, $j\(z\)= q^(- 1) + 744 + 196884 q + 21493760 q^2 + dots.h.c$) Where $q = e^(2 pi i z)$, $z in cal(H)$, is invariant under $"SL"_2\(bb(Z)\)$, hence a modular form

]
#statement("Definition")[
$G$ induces a right action on $bb(C)\(X\)$ by $\(f dot.op g\)\(x\)= f\(g x\)$, #ref(label("Automorphic function"), supplement: none) becomes $f dot.op gamma = f$, $forall gamma in Gamma$. More generally, we can allow a nontrivial #emph[automorphy factor]#index-entry("Automorphy factor") $\(f dot.op_c g\)= c_g\(x\)f\(g x\)$, $forall g in G$, here $c_g : X arrow.r bb(C)^times$

]
#statement("Exercise")[
For the action to be well-defined, the family of functions $c_g$ must satisfy $c_(g_1 g_2)\(x\)= c_(g_2)\(x\)c_(g_1)\(g_2 x\)$, so called cocycle condition, $forall g_1\,g_2 in G$, $x in X$

]
#statement("Exercise")[
For $g = mat(delim: "[", a, b; c, d)$, denote $j\(g\,z\)= c z + d$, $G = "SL"\(2\,bb(R)\)$ acting on $cal(H)$ by $g dot.op z = frac(a z + b, c z + d)$. For $k in bb(Z)$, we consider the automorphy factor $c_g\(z\)=\(c z + d\)^(- k)$. Show $c_g$ satisfies the cocycle condition

]
#statement("Definition")[
Then we get an action $\(f dot.op_k g\)\(z\)=\(c z + d\)^(- k) f (frac(a z + b, c z + d))$, $z in cal(H)$. For a modular group $Gamma lt.eq "SL"_2\(bb(Z)\)$, holomorphic function $f$ on $cal(H)$ is called a #emph[holomorphic modular form] of #emph[weight] $k$ and #emph[level] $Gamma$ (one may also need to add some boundness condition) if $f dot.op_k gamma = f$, $forall gamma in Gamma$ which is equivalent to $f (frac(a z + b, c z + d)) =\(c z + d\)^k f\(z\)$

]
#statement("Remark")[
To unify these examples for $G = "SL"_2\(bb(R)\)$ to acts on $cal(H)$ and \"get rid of\" the automorphy factors, it is better to consider $Gamma without G$. The advantage is $Gamma without G$ has a large symmetry group coming from right multiplication of $G$, (whereas $Gamma without cal(H)$ does not have so many automorphisms). The invariant differential operators on $Gamma without cal(H)$ come from $Z\(frak(g)\)$, then center of the universal enveloping algebra of $"Lie"\(G\)$. The automorphic forms in the above examples all correspond to certain $C^oo$ functions on $Gamma without G$, their automorphy factors are determined by their behavior under right $K = "SO"\(2\,bb(R)\)$ action

]
#statement("Example")[
Classical Maass forms on $Gamma without cal(H)$ correspond to certain right $K$-invariant functions on $Gamma without G$. The basic problem of decomposing automorphic functions motivates the more refined problem of decomposiing the right regular representation of $G$ on $L^2\(Gamma without G\)$

]
#statement("Theorem")[
Assume $Gamma without G$ is compact (equivalently, $Gamma without cal(H)$ is compact. Modular groups which unfortunately do not satisfy this assumption, is one of the difficulty of the subject), then #math.equation(block: true, numbering: none, $L^2\(Gamma without G\) & = xor.big_pi pi times.o "Hom"_G\(pi\,L^2\(Gamma without G\)\)\
 & = xor.big_pi pi^(xor m_pi)$) $pi$ run over irreducible representations of $G$, $m_pi = dim "Hom"_G\(pi\,L^2\(Gamma without G\)\)< oo$. Each multiplicity space $"Hom"_G\(pi\,L^2\(Gamma without G\)\)$ can be identified with a space of certain automorphic forms (The automorphy factors, eigenvalues of Laplacian are determined by the $G$-representations $pi$)

]
#statement("Remark")[
In general we only assume that $Gamma without cal(H)$ has finite volume, then we still have a decomposition of a subspae of $L^2\(Gamma without G\)$ (the discrete spectrum) whose orthogonal complement (the continuous spectrum) can be analyzed using theory of Eisenstein series. This is not the end of the story! Now comes the (arguably) more interesting part: when $Gamma lt.eq G$ is arithmetic (e.g. modular groups, groups coming from indefinite quaternion algebras over $bb(Q)$), then we can decompse each multiplicity space $"Hom"_G\(pi\,L^2\(Gamma without G\)\)$ further under the action of a big algebra on $L^2\(Gamma without G\)$ commuting with the right regular $G$-representation, this is the so-called \"Hecke algebra\". Where does this extra symmetry come from? Let $N_G\(Gamma\)= { g in G\|g Gamma g^(- 1) = Gamma }$ be the normarlizer, then $N_G\(Gamma\)$ acts on $Gamma without G$ by left multiplication (so obviously commute with right $G$-action). This action factors through the quotient group $Gamma without N_G\(Gamma\)$ and also induces automorphisms of $Gamma without cal(H)$. Thus we ge4t an action of $Gamma without N_G\(Gamma\)$ on $L^2\(Gamma without G\)$ that commutes with right $G$-regular representations. So $Gamma without N_G\(Gamma\)$ acts on the multiplicity spaces $"Hom"_G\(pi\,L^2\(Gamma without G\)\)$ and decompose it further. The group $Gamma without N_G\(Gamma\)$ is small (finite if $Gamma without G$ is compact, not sure if only finite volume), so the resulting decomposition is not so interesting. However, the action of $Gamma without N_G\(Gamma\)$ on $Gamma without cal(H)$ (and $Gamma without G$) can be extended to certain correspondences on $Gamma without cal(H)$ (and $Gamma without G$)

]
#statement("Definition")[
Two discrete subgroups $Gamma_1\,Gamma_2$ of $G$ are #emph[commensurable], denoted $Gamma_1 approx Gamma_2$, if their intersection $Gamma_1 inter Gamma_2$ has fintie index in both of them. For $Gamma lt.eq G$, let $tilde(Gamma) = { g in G\|g Gamma g^(- 1) = Gamma }$ be the #emph[commensurator] of $Gamma$ (this generalizes normalizer), elements in $tilde(Gamma)$ define correspondences on $Gamma without cal(H)$ (and $Gamma without G$), which induces action of the convolution algebra $bb(C)\[Gamma without tilde(Gamma)\/Gamma\]$ on $L^2\(Gamma without G\)$, and also on the cohomology of $Gamma without cal(H)$. For modular groups $Gamma$, we have $tilde(Gamma) = "SL"_2\(bb(Q)\)$ which is large. For non-arithmetic groups $Gamma$, $tilde(Gamma)\/Gamma$ is finite (This dichotomy between arithmetic and non-arithmetic cofinte volume subgroups follows from a general result of Margulis)

]
#statement("Remark")[
We will be mainly interested in congruence subgroups of $"SL"_2\(bb(Z)\)$, i.e. subgroups that contain $Gamma\(N\)= ker\("SL"_2\(bb(Z)\)arrow.r "SL"_2\(bb(Z)\/N bb(Z)\)\)$. In particular, such groups are modular, hence arithmetic. For each congruence subgroup $Gamma lt.eq "SL"_2\(bb(Z)\)$, we have $G$ and $H_Gamma = bb(C)\[Gamma without tilde(Gamma)\/Gamma\]$ left and right acting on $L^2\(Gamma without G\)$, $tilde(Gamma) = "SL"_2\(bb(Q)\)$. Put all these together (for the various congruence subgroups), $G = "SL"_2\(bb(R)\)$ and $lim_arrow.l_Gamma H_Gamma = C_c^oo\("SL"_2\(bb(A)_f\)\)$ left and right act on $lim_arrow.r_Gamma L^2\(Gamma without G\)= L^2\("SL"_2\(bb(Q)\)without "SL"_2\(bb(A)\)\)$ ($lim_arrow.l_Gamma Gamma without G = "SL"_2\(bb(Q)\)without "SL"_2\(bb(A)\)$), decompose $L^2\("SL"_2\(bb(Q)\)without "SL"_2\(bb(A)\)\)$ into $"SL"_2\(bb(A)\)$ representations, the irreducible summands are $L^2$-automorphic representations (Actually, we'll work with $"GL"_2$ instead, which is technically simpler). For (nice) irreducible representaion $pi$ of $"GL"_2\(bb(A)\)$, Jacquet-Langlands associate an Euler prduct $L\(s\,pi\)= product_p L_p\(s\,pi\)$, (at least formally, may have convergence issues). This is done using tensor product theorem, which says roughly $pi = times.o.big_p pi_p$ (restricted tensor product), $pi_p$ is the irreducible representation of $"GL"_2\(bb(Q)_p\)$, $L_p\(s\,pi\)$ is defined using only the factor $pi_p$. Whether $pi$ occurs in decomposition of $L^2\("GL"_2\(bb(Q)\)dot.op Z\(bb(A)\)\)without "GL"_2\(bb(A)\)\)$ can be determinded by analytic properties of $L\(s\,pi\)$. This is basically the converse theorem. If $pi$ occurs as a direct summand, then $dim "Hom"_("GL"_2\(bb(A)\))\(pi\,L^2\("GL"_2\(bb(Q)\)dot.op Z\(bb(A)\)\)without "GL"_2\(bb(A)\)\)\)= 1$ (Multiplicity one theorem)

]

#pagebreak()

= Upper half plane

#statement("Definition")[
We adopt the following notations

- $cal(H) = cal(H)^(+) = { "Im"\(z\)> 0 }$ is the upper half plane

- $cal(H)^(-) = { "Im"\(z\)< 0 }$ is lower half plane

- $cal(H)^plus.minus = cal(H)^(+) union cal(H)^(-)$

- $bb(P)^1\(bb(C)\)= {\[z_0\,z_1\]}$ is the complex projective line

- $bb(C) P^1$ is the Riemann sphere $bb(C) union { oo }$, $bb(R) P^1 = bb(R) union { oo }$

- $bb(D)$ is the unit disc

]
#statement("Remark")[
- $"PSL"_2\(bb(R)\)= "SL"_2\(bb(R)\)\/Z = "GL"_2^(+)\(bb(R)\)\/Z lt.eq "GL"_2\(bb(R)\)\/Z = "PGL"_2\(bb(R)\)$ is a subgroup of index $2$, $"PGL"_2\(bb(R)\)$ has two connected components, $"PSL"_2\(bb(R)\)$ is its identity component

- $"PSL"_2\(bb(C)\)= "SL"_2\(bb(C)\)\/Z = "GL"_2\(bb(C)\)\/Z = "PGL"_2\(bb(C)\)$

]
#statement("Definition")[
Consider #math.equation(block: true, numbering: none, $bb(C)^2 - { 0 } arrow.r bb(C) P^1\,quad mat(delim: "[", z_0; z_1) mapsto z_0 / z_1$) then the action of $"GL"_2\(bb(C)\)$ on $bb(C)^2 - { 0 }$ by matrix multiplication #math.equation(block: true, numbering: none, $mat(delim: "[", a, b; c, d) mat(delim: "[", z_0; z_1) = mat(delim: "[", a z_0 + b z_1; c z_0 + d z_1)$) induces an action on $bb(P)^1\(bb(C)\)tilde.equiv bb(C) P^1$ by #emph[fractional linear transformation] #math.equation(block: true, numbering: none, $mat(delim: "[", a, b; c, d) z = frac(a z + b, c z + d)$) Since scalar matrices act trivially, this induces an action of $"PGL"_2\(bb(C)\)$ on $bb(C) P^1$

]
#statement("Fact")[
+ Under this action, $"PGL"_2\(bb(C)\)$ is identified with the holomorphic automorphism group of $bb(C) P^1$, also the algebraic automorphism group of $bb(P)^1\(bb(C)\)$

+ For any three distinct points $z_1\,z_2\,z_3 in bb(C) P^1$, there exists a unique $g in "PGL"_2\(bb(C)\)$ such that $g z_1 = 0$, $g z_2 = 1$, $g z_3 = oo$. So any non-scalar matrix has at most two fixed points on $bb(C) P^1$

]
#statement("Lemma")[
+ $"PSL"_2\(bb(R)\)$ has three orbits on $bb(C) P^1$: $cal(H)\,cal(H)^(-)\,bb(R) P^1$

+ $"PGL"_2\(bb(R)\)$ has two orbits on $bb(C) P^1$: $cal(H)^plus.minus\,bb(R) P^1$

+ $"PSL"_2\(bb(R)\)$ is the group of holomorphic automorphisms of $cal(H)$

]
#proof(title: "Proof")[
If $g = mat(delim: "[", a, b; c, d) in "GL"_2\(bb(R)\)$, then #math.equation(block: true, numbering: none, $"Im"\(g z\)= "Im" frac(\(a z + b\)\(c macron(z) + d\), \|c z + d\|^2) = "Im" frac(a c\|z\|^2 + a d z + b c macron(z) + b d, \|c z + d\|^2) = frac(\(a d - b c\)"Im" z, \|c z + d\|^2) = frac(det\(g\), \|c z + d\|^2) "Im" z$) So $"PSL"_2\(bb(R)\)$ preserves $cal(H)\,cal(H)^(-)\,bb(R P)^1$. While $mat(delim: "[", 1, 0; 0, - 1) in "PGL"_2\(bb(R)\)$ interchanges $cal(H)$, $cal(H)^(-)$. $"PSL"_2\(bb(R)\)$ acts transitively on $cal(H)$ since for any $\(x\,y\)in cal(H)$ #math.equation(block: true, numbering: none, $mat(delim: "[", y^(1 / 2), x y^(- 1 / 2); 0, y^(- 1 / 2)) dot.op i = x + y i$) For 3. first use Cayley transformation $mat(delim: "[", 1, - i; 1, i)$ which induces an isomorphism $cal(H) arrow.r bb(D)$, then use Schwartz lemma to determine $"Aut"\(bb(D)\)$, and then translate back to $cal(H)$

]
#statement("Exercise")[
The stabilizer of $i$ in $"SL"_2\(bb(R)\)$ is #math.equation(block: true, numbering: none, $"SO"_2\(bb(R)\)= {mat(delim: "[", cos theta, sin theta; - sin theta, cos theta) mid(bar.v) theta in bb(R)}$) So the stabilier of $i$ in $"PSL"_2\(bb(R)\)$ is $"SO"_2\(bb(R)\)\/{ plus.minus I } tilde.equiv "PSO"_2\(bb(R)\)$. And therefore $cal(H) tilde.equiv "SL"_2\(bb(R)\)\/"SO"_2\(bb(R)\)tilde.equiv "PSL"_2\(bb(R)\)\/"PSO"_2\(bb(R)\)$ is a homogeneous space

]
#statement("Exercise")[
For $g in "SL"_2\(bb(R)\)$ #math.equation(block: true, numbering: none, $g^(*) d z = d\(g z\)= d (frac(a z + b, c z + d)) = frac(d z, \(c z + d\)^2)$) So we have #math.equation(block: true, numbering: none, $g^(*)\(d x^2 + d y^2\)= g^(*)\(d z d macron(z)\)= frac(d z d macron(z), \(c z + d\)^2\(c macron(z) + d\)^2) =\|c z + d\|^(- 4)\(d x^2 + d y^2\)$) Hence #math.equation(block: true, numbering: none, $g^(*)\(y^(- 2)\(d x^2 + d y^2\)\)=\(y compose g\)^2 g^(*)\(d x^2 + d y^2\)= "Im"\(g z\)^(- 2)\|c z + d\|^(- 4)\(d x^2 + d y^2\)= y^(- 2)\(d x^2 + d y^2\)$)

]
#statement("Definition")[
Define the #emph[hyperbolic metric] on $cal(H)$ to be $frac(d x^2 + d y^2, y^2)$. Then $cal(H)$ becomes a model of hyperbolic plane: a two dimensional simply connected Riemannian manifold with constant Gaussian curvature $- 1$

]
#statement("Proposition")[
$"PSL"_2\(bb(R)\)= "Isom"^(+)\(cal(H)\)$, the group of orientation preserving isometries. The group of isometries $"Isom"\(cal(H)\)$ is genenrated by $"Isom"^(+)\(cal(H)\)$ and reflection $z mapsto - macron(z)$

]
#proof(title: "Proof")[
We have already seen $"PSL"_2\(bb(R)\)= "Hol"\(cal(H)\)$, the group of holomorphic automorphisms and $"PSL"_2\(bb(R)\)lt.eq "Isom"^(+)\(cal(H)\)$, but $"Isom"^(+)\(cal(H)\)lt.eq "Hol"\(cal(H)\)$ since orientation preserving conformal maps are holomorphic

]
#statement("Fact")[
The geodesics on $cal(H)$ are semi-circles othogonal to the real axis and half-lines orthogonal to the real axis, see \[Miyake, Lemma 1.4.1\]

#align(center)[
#svg-drawing("<path d='M20 140H420M220 140V20M300 140A80 80 0 0 0 140 140M380 140A120 120 0 0 0 140 140'/>")
]
The hyperbolic metric induces a volume form $d mu = frac(d x and d y, y^2)$, and the hyperbolic Laplace operator $Delta = - y^(- 2) (frac(partial^2, partial x^2) + frac(partial^2, partial y^2))$

]
#statement("Exercise")[
$d mu\,Delta$ are invariant under $"PSL"_2\(bb(R)\)$ action (since the action preserves the metric)

]
#statement("Theorem", title: [Classification of motions])[
$g = mat(delim: "[", a, b; c, d) in "SL"_2\(bb(R)\)$ and $g eq.not plus.minus I$, then $g$ has one or two fixed points on $bb(C P)^1$

]
#proof(title: "Proof")[
+ $c = 0$

  + $a = d = plus.minus 1$, so $b eq.not 0$, $g$ is a translation on $bb(C P)^1$, $oo$ is the only fixed point

  + $a eq.not d$, $g$ is a linear function on $bb(C P)^1$, $oo\,frac(b, d - a) in bb(R)$ are the two fixed points

+ $c eq.not 0$, then $oo mapsto a / c$ is not fixed #math.equation(block: true, numbering: none, $frac(a z + b, c z + d) = z arrow.r.double z = frac(\(a - d\)plus.minus sqrt(\(a + d\)^2 - 4), 2 c)$)

  + $\|a + d\|= 2$, the only one fixed point is $frac(a - d, 2 c) in bb(R)$

  + $\|a + d\|> 2$, there are two fixed points

  + $\|a + d\|< 2$, there are two fixed points in $cal(H)\,cal(H)^(-)$ and are conjugate of each other

In summary, there are three kinds of non-identity fractional linear transformation

+ Parabolic: When $\|"tr" g\|= 2$, only one fixed point, which is on $bb(R P)^1$

+ Hyperbolic: When $\|"tr" g\|> 2$, two fixed points, both in $bb(R P)^1$

+ Elliptic: When $\|"tr" g\|< 2$, two fixed points, one in $cal(H)$, the other one in $cal(H)^(-)$

]
#statement("Example")[
Translation $mat(delim: "[", 1, b; 0, 1) : z mapsto z + b$ is a parabolic motion. In general, parabolic elements move points along #emph[horocycles]#index-entry("Horocycle"), i.e. horiontal lines or circles tangent to the $x$-axis

#align(center)[
#svg-drawing("<path d='M20 145H420M170 150V10' marker-end='url(#a)'/><path d='M20 30H110M110 30H200M200 30H290' marker-end='url(#a)'/><path d='M290 30H420'/><path d='M170 145A55 55 0 0 1 170 35A55 55 0 0 1 170 145'/><path d='M115 90A55 55 0 0 1 170 35M225 90A55 55 0 0 1 170 145' marker-end='url(#a)'/>")
]
One can view horocycles as circles in $bb(C P)^1 = S^2$ that are tangent to $bb(R P)^1 = S^1$. $"PSL"_2\(bb(R)\)$ action takes horocycles to horocycles and acts transitiviely on the set of horocycles. For any horizontal horocycle (say $"Im" z = 1$), its stabilizer is $U = {mat(delim: "[", 1, *; 0, 1)}$, identified with its image in $"PSL"_2\(bb(R)\)$. Hence the set of horocycles can be identified with $"PSL"_2\(bb(R)\)\/U tilde.equiv\(bb(R)^2 - { 0 }\)\/{ plus.minus I }$ (note that $S L_2\(bb(R)\)\/U tilde.equiv bb(R)^2 - { 0 }$)

]
#statement("Example")[
$g = mat(delim: "[", a, 0; 0, a^(- 1)) : z mapsto a^2 z$ is a hyperbolic motion, fixing $0\,oo$. In general, hyperbolic element moves points along #emph[hypercycles]#index-entry("Hypercycle"), i.e. intersections of circles in $bb(C P)^1$ passing through the fixed points on $bb(R P)^1$ with $cal(H)$

#align(center)[
#svg-drawing("<path d='M20 145H420M70 145Q220 90 370 145M70 145Q220 35 370 145M70 145Q220 -20 370 145'/><path d='M170 100L185 97M170 54L185 51' marker-end='url(#a)'/><g fill='black' stroke='none' font-family='serif' font-size='13'><text x='40' y='158'>repelling</text><text x='340' y='158'>attracting</text><text x='402' y='138'>RP¹</text></g>")
]
]
#statement("Example")[
$g = mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)$ is a elliptic motion, moving points along circles with #emph[hyperbolic center] $i$, fixes $i$, induces counter-clockwise rotation of angle $2 theta$ on the tangent space at $i$

#align(center)[
#svg-drawing("<path d='M20 175H420M220 185V10' marker-end='url(#a)'/><circle cx='220' cy='125' r='30'/><circle cx='220' cy='110' r='53.33'/><circle cx='220' cy='95' r='75'/><circle cx='220' cy='135' r='1.5' fill='black'/><path d='M250 125L249 119M273 110L272 104M295 95L294 89' marker-end='url(#a)'/><text x='226' y='135' fill='black' stroke='none' font-family='serif' font-size='14'>i</text>", height: 200)
]
]
#statement("Remark")[
Elliptic motions may have finite order ($theta = pi / n\,n in bb(Z)$), parabolic and hyperbolic motions have infinite orders

]

#pagebreak()

= Actions of Lie groups and discrete subgroups

#statement("Lemma")[
Suppose topological group $G$ continuously acts on a topological space $X$

+ If $X$ is $T_1$, then the stabilizer $G_x$ of $x$ is closed. The set of orbits $G without X$ is equipped with the quotient topology

+ The quotient map $pi : X arrow.r G without X$ is open. Moreover, if $X$ is second countable, then so is $G without X$

+ If $H subset.eq G$ is a closed subgroup, then $G\/H$ is Hausdorff

]
#proof(title: "Proof")[
+ Consider the group action and the second projection map $G times X arrow.r X$, then $G_x$ is the intersection of preimages of the closed subset ${ x }$

+ If $U subset.eq X$ is open, then $pi^(- 1)\(pi\(U\)\)= union.big_(x in U) G x$ is a union of open subsets, hence also open. A countable basis will be mapped to a countable basis of $G without X$ by $pi$

+ ${ 0 }$ is closed, and the topology is translational invariant

]
#statement("Theorem")[
Suppose $X$ is locally compact Hausdorff, $G$ is second countable, locally compact and acting transitively on $X$. Then for any $x in X$, the orbit map $G\/G_x arrow.r X$, $g G_x mapsto g x$ is a homeomorphism

]
#proof(title: "Proof")[
Consider the following diagram, we know $phi.alt$ is bijective and continuous, it suffices to show that $phi.alt$ is open($arrow.l.r.double psi$ is open)

#align(center)[
#align(center)[#diagram(node((0,0), $G$), node((0,1), $G slash G_x$), node((1,1), $X$), edge((0,0),(0,1),"->",$pi$), edge((0,0),(1,1),"->",$psi$), edge((0,1),(1,1),"->",$phi$))]
]
Since $G$ is second countable, there exists a dense subset ${ g_i } subset.eq G$, Suppose $U subset.eq G$ is open, we need to show $U x$ is open. Fix $g in U$, consider map $G times G arrow.r G$, $\(a\,b\)mapsto g a b$, there exists a compact neighborhood $K$ of 1 such that $K^(- 1) = K$, $g K^2 subset.eq U$. Denote $W_n = g_n K x$, if $W_n^compose eq.not diameter$, then $\(K x\)^compose eq.not diameter$, for $g x in U x$, $g x in\(g K^(- 1) K x\)^compose =\(g K^2 x\)^compose subset.eq\(U x\)^compose$. Hence it suffice to show that $W_n^compose$ is nonempty for some $n$, which is guaranteed by Baire category theorem: Locally compact Hausdorff spaces are Baire spaces, suppose $W_n^compose = diameter$, then $W_n^c$ will be dense, so $inter.big W_n^c =\(union.big W_n\)^c = X^c = diameter$ is a contradiction

]
#statement("Theorem")[
+ Let $G$ be a Lie group and $H subset.eq G$ a closed subgroup. Then there exists a unique smooth manifold structure on $G\/H$ such that the quotient map $G arrow.r G\/H$ is a $C^oo$ submersion

+ Let $G$ be a Lie group acting transitively on a smooth manifold $M$. Then for any $x in M$, then map $G\/G_x arrow.r M$ is a diffeomorphism

]
#proof(title: "Proof")[
Warner: Foundations of differentiable manifolds and Lie groups, Thm 3.58, 3.62

]
#statement("Example")[
Orbit map at $i in cal(H)$ induces diffeomorphisms #math.equation(block: true, numbering: none, $"SL"_2\(bb(R)\)\/"SO"_2\(bb(R)\)arrow.r^tilde.equiv cal(H)\,quad "PSL"_2\(bb(R)\)\/"PSO"_2\(bb(R)\)arrow.r^tilde.equiv cal(H)$)

]
#statement("Definition")[
A subgroup $Gamma subset.eq G$ is a #emph[discrete] if the induced topology is discrete

]
#statement("Lemma")[
A discrete subgroup $Gamma$ of a Hausdorff topological group $G$ is closed

]
#proof(title: "Proof")[
Since $Gamma$ is discrete, there exists an open neighborhood $U in.rev 1$ such that $U inter Gamma = { 1 }$, there exists an open neighborhood $V in.rev 1$ such that $V^(- 1) V subset.eq U$, suppose $g$ is in the closure of $Gamma$, then $V^(- 1) g inter Gamma$ is not empty, assume $alpha\,beta in V^(- 1) g inter Gamma$, then $alpha beta^(- 1) in V^(- 1) V inter Gamma subset.eq U inter Gamma = { 1 }$, thus $alpha = beta$, i.e. $V^(- 1) g inter Gamma = { alpha }$. If $g eq.not alpha$, then there exists an open neighborhood $g in W subset.eq V^(- 1) g$ which doesn't contain $alpha$ since $G$ is Hausdorff, but this contradicts the fact that $g$ is in the closure of $Gamma$, thus $g = alpha in Gamma$

]
#statement("Lemma")[
If $K subset.eq G$ is a compact subgroup of a locally compact Hausdorff group, then $G arrow.r^pi G\/K$ is proper

]#label("G locally compact group, K compact subgroup, G->G/K is proper")
#proof(title: "Proof")[
Cover $G$ with open subsets $V_i$ with compact closure. For any $A subset.eq G\/K$ compact, thus closed, $A subset.eq union.big_i pi\(V_i\)$ by finitely may open sets, then closed set $pi^(- 1)\(A\)subset.eq union.big_i overline(V_i) K$ which is compact, so is $pi^(- 1)\(A\)$

]
#statement("Definition")[
A group $Gamma$ is acting continuously on a topological space $X$. We say it acts #emph[properly(proper discontinuously)] if for any compact subsets $A\,B subset.eq X$ #math.equation(block: true, numbering: none, $\#{ gamma in Gamma\|gamma A inter B eq.not diameter } < oo$)

]
#aside("Note")[
This implies that the stabilizers are finite

]
#statement("Proposition")[
$K subset.eq G$ is a compact subgroup of a locally compact Hausdorff group. For any subgroup $Gamma subset.eq G$, the following are equivalent

+ $Gamma$ is discrete

+ $Gamma$ acts properly on $G\/K$ on the left

]
#proof(title: "Proof")[
$1 arrow.r.double 2$: Suppose $A\,B subset.eq G\/K$ are compact, by Lemma #ref(label("G locally compact group, K compact subgroup, G->G/K is proper"), supplement: none), $C = pi^(- 1)\(A\)$, $D = pi^(- 1)\(B\)$ are also compact, so is $D C^(- 1)$, then #math.equation(block: true, numbering: none, ${ g in Gamma\|gamma A inter B eq.not diameter } subset.eq { g in Gamma\|gamma C inter D eq.not diameter } = Gamma inter D C^(- 1)$) is discrete and compact, hence finite \ $2 arrow.r.double 1$: Let $V$ be a neighborhood of $1$ with $overline(V)$ compact, then #math.equation(block: true, numbering: none, $Gamma inter V subset.eq Gamma inter pi^(- 1)\(pi\(V\)\)= { g in Gamma\|pi\(g\)inter pi\(V\)eq.not diameter } subset.eq { g in Gamma\|g pi\(1\)inter pi\(overline(V)\)eq.not diameter }$) should be finite, by shrinking $V$, we get $Gamma inter V = { 1 }$, i.e. $Gamma$ is discrete

]
#statement("Example")[
$"SL"_2\(bb(Z)\)$ and its finite index subgroups are discrete in $"SL"_2\(bb(R)\)$ since $"SL"_2\(bb(Z)\)= M_2\(bb(Z)\)inter "SL"_2\(bb(R)\)$

]
#statement("Example")[
$"SL"_2\(bb(Q)\)$ is not discrete in $"SL"_2\(bb(R)\)$ since the stabilizer of $i in cal(H)$ in $"SL"_2\(bb(Q)\)$ is #math.equation(block: true, numbering: none, $"SO"_2\(bb(Q)\)arrow.r^(upright("Stereographic projection")) bb(Q) P^1\,quad mat(delim: "[", a, b; - b, a) mapsto frac(a, 1 - b)$) which are in 1 to 1 correspondence with $bb(P)^1\(bb(Q)\)$ which is infinite, so $"SL"_2\(bb(Q)\)$ does not act properly on $cal(H)$

]
#statement("Remark")[
A discrete group $Gamma$ acts properly on $X$ $arrow.l.r.double$ the map $Gamma times X arrow.r X times X$, $\(g\,x\)mapsto\(x\,g x\)$ is proper

]
#statement("Proposition")[
$K subset.eq G$ is a compact subgroup of a locally compact Hausdorff group. $Gamma subset.eq G$ is a discrete subgroup. Then $forall z in G\/K$, there exists a neighborhood $U$ of $z$ such that #math.equation(block: true, numbering: none, ${ g in Gamma\|g\(U\)inter U eq.not diameter } = { g in Gamma\|g z = z }$) And $Gamma without G\/K$ is Hausdorff

]
#proof(title: "Proof")[
Shimura, proposition 7.1.8

]
#statement("Example")[
If $Gamma subset.eq "SL"_2\(bb(R)\)$ is a discrete subgroup, then $Gamma without cal(H)$ is Hausdorff, second countable

]

#pagebreak()

= Quotients of upper half plane

#statement("Definition")[
When $z in bb(C) P^1$ is a fixed point of an elliptic/parabolic/hyperbolic element in $Gamma$, we say $z$ is an elliptic/parabolic/hyperbolic point of $Gamma$

]
== The case of $Gamma = "SL"_2\(bb(Z)\)$
<the-case-of-gammasl_2mathbb-z>
#statement("Exercise")[
$"SL"_2\(bb(Z)\)$ is generated by $T = mat(delim: "[", 1, 1; 0, 1)$ and $S = mat(delim: "[", 0, - 1; 1, 0)$, the same is true for $"PSL"_2\(bb(Z)\)$

]
#proof(title: "Proof")[
Use Euclid's algorithm we can make any matrix upper triangular, $S^2 = - I_2$, $T^n = mat(delim: "[", 1, n; #none, 1)$

]
#statement("Theorem")[
Let $cal(D) = {z in cal(H) \| \| z \| gt.eq 1 \, \| "Re" \( z \) \| lt.eq 1 / 2}$, $rho = e^(i pi / 3)$

#align(center)[
#svg-drawing("<path d='M65 35V112.369A55 55 0 0 1 120 112.369V35Z' fill='#ddd' stroke='none'/><circle cx='92.5' cy='160' r='55' stroke-dasharray='3 3'/><path d='M20 160H165M92.5 225V15' marker-end='url(#a)'/><path d='M65 112.369V35M120 112.369V35M92.5 105A55 55 0 0 0 65 112.369M92.5 105A55 55 0 0 1 120 112.369' marker-end='url(#a)'/><circle cx='365' cy='100' r='70'/><path d='M365 81.244L365 118.756A140 140 0 0 1 435 100A140 140 0 0 1 365 81.244Z' fill='#ddd'/><path d='M195 110H270' marker-end='url(#a)'/><g fill='black' stroke='none' font-family='serif' font-size='12'><text x='45' y='107'>ρ²</text><text x='120' y='107'>ρ = exp(iπ/3)</text><text x='88' y='12'>∞</text><text x='184' y='75'>Cayley transform</text><text x='190' y='94'>(z - i)/(z + i)</text></g>", height: 230)
#box(image("Pictures/FundamentalDomainOfUpperHalfPlane.PNG", width: 65.0%, alt: "image"))

]
+ For any $z in cal(H)$, there exists $gamma z in cal(D)$

+ If $z\,z' in cal(D)$, $z eq.not z'$ are in the same $Gamma$ orbit, then either $"Re"\(z\)= plus.minus 1 / 2$, $z = z' plus.minus 1$ or $\|z\|= 1$, $z' = - 1 / z$

+ The stabilizer of $z in cal(D)$ in $overline(Gamma) = "PSL"_2\(bb(Z)\)$ is #math.equation(block: true, numbering: none, $overline(Gamma)_z = cases(chevron.l S chevron.r quad upright("order 2")\,z = i, chevron.l T S chevron.r quad upright("order 3")\,z = rho = e^(pi i\/3), chevron.l S T chevron.r quad upright("order 3")\,z = rho^2 = e^(2 pi i\/3), { 1 } quad upright("order 1")\,upright("otherwise"))$)

+ $Gamma without cal(H) tilde.equiv bb(C)$ as Riemann surfaces

]
#proof(title: "Proof")[
$Gamma without cal(H) tilde.equiv cal(D)\/tilde.op tilde.equiv bb(C)$ is a homeomorphism. Need to pay attention to elliptic points $rho tilde.op rho^2$, $i$, near $i$, $cal(H) arrow.r Gamma without cal(H)$ looks like $z mapsto z^2$, near $rho$ or $rho^2$, $cal(H) arrow.r Gamma without cal(H)$ looks like $z mapsto z^3$, $arrow.r.double$ locally around the elliptic points $i\,rho\,rho^2$, $Gamma without cal(H)$ is homeomorphic to the quotient of unit disc by finite order rotation automorphisms. The quotients are still unit discs and have natural complex structure \ Around non-elliptic points, $Gamma without cal(H)$ is homeomorphic to a neighborhood in $cal(H)$ and inherits complex structure. This way we get a complex structure on $Gamma without cal(H)$. Since it is homeomorphic to $bb(C)$, uniformization theorem $arrow.r.double$ isomorphic to either $bb(C)$ or $bb(D)$ as a complex manifold. There are no non-constant bounded $Gamma$-invariant holomorphic function on $cal(H)$, so $Gamma without cal(H)$ is not isomorphic to $bb(D)$. Thus $Gamma without cal(H) tilde.equiv bb(C)$ as Riemann surfaces

]
#statement("Definition")[
$Gamma lt.eq "SL"_2\(bb(R)\)$ is a discrete subgroup. A connected subspace $cal(F) subset.eq cal(H)$ is a #emph[fundamental domain]#index-entry("Fundamental domain") for $Gamma$ if

+ $cal(H) = union.big_(gamma in Gamma) gamma cal(F)$

+ $cal(F) = overline(cal(F)^compose)$

+ $gamma cal(F)^compose inter cal(F)^compose = diameter$, $forall gamma in Gamma - { plus.minus I }$

$cal(F)$ for $Gamma$ is #emph[locally finite] if for any compact $K subset.eq cal(H)$, ${ gamma in Gamma\|K inter gamma cal(F) eq.not diameter }$ is finite. It is #emph[convex] if $forall z\,w in cal(F)$, the (hyperbolic) geodesic segment joining $z\,w$ lies in $cal(F)$

]
Define an equivalence relation on $cal(F)$ by $z tilde.op w$ if $exists gamma in Gamma$ such that $gamma z = w$, note that $tilde.op$ is only nontrivial on the boundary $partial cal(F)$, we have natural map $cal(F)\/tilde.op arrow.r^theta Gamma without cal(H)$

#statement("Proposition")[
$theta$ is continuous, bijective. It is a homeomorphism iff $cal(F)$ is locally finite

]
#proof(title: "Beardon: The geometry of discrete groups, 9.2.2,9.2.4")[

]
One can construct nice fundamental domains as follows: choose $z_0 in cal(H)$ non-elliptic point for $Gamma$, for any $gamma in Gamma - Z_Gamma$, denote #math.equation(block: true, numbering: none, $cal(F)_gamma & = { z in cal(H)\|d\(z\,z_0\)lt.eq d\(z\,gamma z_0\)}\
U_gamma & = { z in cal(H)\|d\(z\,z_0\)< d\(z\,gamma z_0\)}\
C_gamma & = { z in cal(H)\|d\(z\,z_0\)= d\(z\,gamma z_0\)}$) Let $cal(F)\(z_0\)= inter.big_(gamma in Gamma - Z_Gamma) cal(F)_gamma$, $U\(z_0\)= inter.big_(gamma in Gamma - Z_Gamma) U_gamma$

#statement("Proposition")[
$cal(F)\(z_0\)$ is a locally finite convex fundamental domain for $Gamma$, $U\(z_0\)$ is the interior of $cal(F)\(z_0\)$

]
#proof(title: "Miyake §1.6")[

]
The boundary of $cal(F) = cal(F)\(z_0\)$ consists of geodesic segments of the form $L_gamma = cal(F) inter gamma cal(F) subset.eq C_gamma$, see \[Miyake 1.6.2\] for the inclusion. Some $L_gamma$ may have infinite length, in that case it extends to some point on $bb(R) union { oo }$, called #emph[ends] of $cal(F)$. Two kinds of ends:

#align(center)[
#svg-drawing("<path d='M20 140H420M140 140A80 80 0 0 0 60 60M300 140A80 80 0 0 1 380 60'/><g fill='black' stroke='none' font-family='serif' font-size='14'><text x='215' y='80'>F</text><text x='190' y='156'>open ends</text></g>")
]
#align(center)[
#svg-drawing("<path d='M20 140H420M220 140A80 80 0 0 0 140 60M220 140A80 80 0 0 1 300 60'/><g fill='black' stroke='none' font-family='serif' font-size='14'><text x='215' y='80'>F</text><text x='200' y='156'>cusps</text></g>")
]
#statement("Theorem")[
$Gamma lt.eq "SL"_2\(bb(R)\)$ is a discrete subgroup, $z_0 in cal(H)$ is a non-elliptic point of $Gamma$, $cal(F) = cal(F)\(z_0\)$ as above. The following are equivalent

+ $cal(F)$ has finitely many sides and all ends on $bb(R) union { oo }$ are cusps

+ $"Vol"\(cal(F)\)$ is finite

]
#aside("Note")[
The sides of $cal(F)$ are the segments $L_gamma$ of nonzero length

]
#proof(title: "Proof")[
\1.$arrow.r.double$2.: Follows from Lemma #ref(label("Lemma from Gauss-Bonet"), supplement: none) \ 2.$arrow.r.double$1.: Finiteness follows from Lemma #ref(label("Lemma from Gauss-Bonet"), supplement: none). If there are open ends, then there will be infinitely many geodesic triangles in $F$ with vertices on $bb(R) P^1$, each such triangle has area $pi$ by Lemma #ref(label("Lemma from Gauss-Bonet"), supplement: none), so $"Vol"\(F\)= oo$ which is a contradiction

#align(center)[
#svg-drawing("<path d='M20 140H420M140 140A80 80 0 0 0 60 60M300 140A80 80 0 0 1 380 60M300 140A80 80 0 0 0 140 140M220 140A40 40 0 0 0 140 140M220 140A40 40 0 0 1 300 140'/>")
]

]
#statement("Lemma")[
Let $P$ be a polygon on $bb(C) P^1$ whose sides consists of $N$ geodesics. Let $alpha_1\,dots.h.c\,alpha_N$ be the interior angle at each vertex (we allow the vertex to be on $bb(R) union { oo }$), so the angle at such a vertex is 0), then $"Vol"\(P\)=\(N - 2\)pi - sum_(i = 1)^N alpha_i$. In particular, if $N = 3$ and all 3 vertices are all on $bb(R) union { oo }$, then $"Vol"\(P\)= pi$

]#label("Lemma from Gauss-Bonet")
#proof(title: "Proof")[
If all vertices are in $cal(H)$, Gauss-Bonnet says #math.equation(block: true, numbering: none, $integral_P k d mu + sum_(i = 1)^N\(pi - alpha_i\)= 2 pi chi\(P\)$) In this particular setting, $k equiv - 1$ is the constant curvature, $chi\(P\)= 1$ is the Euler characteristic. If there are cusps, truncate and take limit

]
#statement("Theorem")[
Let $Gamma$, $z_0$, $cal(F) = cal(F)\(z_0\)$ be as above. Suppose $"Vol"\(cal(F)\)< oo$, then

+ Each of the (finitely many) cusps is a parabolic point for $Gamma$, and not a hyperbolic point. Its stabilizer in $overline(Gamma)$ is isomorphic to $bb(Z)$

+ There are finitely many elliptic points in $cal(F)$, all lying on $partial cal(F)$

+ Each $Gamma$-orbit of parabolic points of $Gamma$ contains at least one cusp of $cal(F)$

]
#proof(title: "Proof")[
+ + A cusp cannot be a hyperbolic point: Suppose not, then we may assume the cusp is at 0 and $exists gamma = mat(delim: "[", a, 0; 0, a^(- 1)) in Gamma - { plus.minus I }$. Then $gamma$ fixes the geodesic $\(0\,1 oo\)$ and acts by fixes the geodesic $\(0\,i oo\)$ and acts by translation by a fixed hyperbolic distance on $\(0\,i oo\)$. Then any point on $\(0\,i oo\)$ can be moved to fixed segment $S$ on $\(0\,i oo\)$ by applying some power of $gamma$. Let $z$ be an interior of $cal(F)$. Then the geodesic from $z$ to 0 lie in the interior of $cal(F)$, choose a sequence of points $z_n$ converging to 0 on this geodesic. Then we can find a sequence $w_n$ on $\(0\,i oo\)$ such that $d\(z_n\,w_n\)arrow.r 0$ as $n arrow.r oo$. Apply some power of $gamma$ to each $w_n$ to move them in $S$, then $z_n$ will be moved to accumulate near $S$ because $gamma$ is an isometry. This contradicts local finiteness

  + Any cusp is a parabolic point ($arrow.r.double$ stabilizer in $overline(Gamma)$ isomorphic to $bb(Z)$). Observation: If $cal(F)$ and $gamma\(cal(F)\)$ have a common cusp $S$, then $gamma^(- 1)\(S\)$ is also a cusp of $cal(F)$. $forall$ cusp $S$ of $F$, there are infinitely many $gamma in Gamma$ such that $S$ is also a cusp of $gamma\(cal(F)\)$. If stabilizer of $s$ in $Gamma$ is trivial, then there would be infinitely many cusps of $F$ by the above observation. This contradicts Theorem #strong[??]. So stabilizer of $S$ in $overline(Gamma)$ is nontrivial and by 1a), $S$ is a parabolic point

+ Elliptic points cannot lie in $cal(F)^compose$ since $gamma\(cal(F)^compose\)inter cal(F)^compose = diameter$ for any non-scalar $gamma in Gamma$. They are either a vertex of $cal(F)$ or mid-point of a side, hence finitely many

+ Assertion on parabolic points of $Gamma$ will be proved later. It essentially boils down to Hausdorffness of the compactification of $Gamma without cal(H) tilde.equiv cal(F)\/tilde.op$ by adding cusps

]
#statement("Remark")[
In fact part 3. suggests how to define compactification of $Gamma without cal(H)$ without using any specific fundamental domain

]
== Compactifying $Gamma without cal(H)$
<compactifying-gammabackslashmathcal-h>
Fix $Gamma lt.eq "SL"_2\(bb(R)\)$ discrete subgroup. Let $P_Gamma$ be the set of parabolic points of $Gamma$ on $bb(R) union { oo }$\($P_Gamma = diameter$ if no parabolic points). Let $cal(H)^(*) = cal(H)_Gamma^(*) = cal(H) union P_Gamma$.

#strong[Goal] is to put a topology on $cal(H)^(*)$, show that when $"Vol"\(Gamma without cal(H)\)< oo$, $Gamma without cal(H)^(*)$ is a nice compactification of $Gamma without cal(H)$ and can be identified with a quotient of $cal(F)^(*) = cal(F) union { upright("cusps of ") cal(F) }$ where $cal(F)$ is a fundamental domain for $Gamma$ as above \ For $l > 0$, let $U_oo\(l\)= { z in cal(H)\|"Im" z > l }$ and $U_oo^(*)\(l\)= U_oo\(l\)union { oo }$, for $t in bb(R)$, let $U_t\(l\)= sigma U_oo\(l\)$, $U_t^(*)\(l\)= sigma U_oo^(*)\(l\)= U_t\(l\)union { t }$, where $sigma in "PSL"_2\(bb(R)\)$ is chosen so that $sigma oo = t$. The boundaries of $U_t\(l\)$ are horocycles at $t in bb(R) union { oo }$. Define a topology on $cal(H)^(*)$ so that $cal(H)$ is an open subset, and $U_t^(*)\(l\)$ form a system of neighborhoods of $t in bb(R) union { oo }$, then $cal(H)^(*)$ is a second countable(since $Gamma$ and hence $P_Gamma$ is countable and Hausdorff), but not locally compact. $Gamma$ acts continuously on $cal(H)^(*)$, but not properly: stabilizes at $t in P_Gamma$ are isomorphic to $bb(Z)$, infinite

#statement("Example")[
When $Gamma = "SL"_2\(bb(Z)\)$, $P_Gamma = bb(Q) union { oo }$. $Gamma$ acts transitively on $P_Gamma$ (an easy check, also follows from Theorem #strong[??] and Theorem #strong[??], noticing that the standard fundamental domain for $"SL"_2\(bb(Z)\)$ has only one cusp $oo$). $overline(Gamma)_oo = ⟨mat(delim: "[", 1, 1; 0, 1)⟩$, $U_oo^(*)\(l\)\/overline(Gamma)_oo$ is homeomorphic to an open disc

]
#statement("Lemma")[
For any $t in P_Gamma$, $overline(Gamma)_t tilde.equiv bb(Z)$ and a generator has the form $sigma mat(delim: "[", 1, h; 0, 1) sigma^(- 1)$ where $h > 0$, $sigma in "SL"_2\(bb(R)\)$, $sigma oo = t$

]
#proof(title: "Proof")[
We may assume $t = oo$, then #math.equation(block: true, numbering: none, $Gamma subset.eq {plus.minus mat(delim: "[", *, *; 0, *)}$) Since $oo in P_Gamma$, $exists x > 0$ such that $mat(delim: "[", 1, x; 0, 1) in Gamma_oo dot.op { plus.minus 1 }$. If $exists mat(delim: "[", a, 0; 0, a^(- 1)) in Gamma_oo$, may assume $\|a\|lt.eq 1$, then #math.equation(block: true, numbering: none, $mat(delim: "[", a, 0; 0, a^(- 1))^n mat(delim: "[", 1, x; 0, 1) mat(delim: "[", a, 0; 0, a^(- 1))^(- n) = mat(delim: "[", 1, a^(2 n) x; 0, 1) in Gamma$) $Gamma$ is discrete $arrow.r.double$ $a = plus.minus 1$. $arrow.r.double overline(Gamma)_oo$ is a discrete subgroup of ${mat(delim: "[", 1, *; 0, 1)} tilde.equiv bb(R) arrow.r.double overline(Gamma)_oo tilde.equiv bb(Z)$

]
#statement("Lemma")[
Suppose $mat(delim: "[", 1, h; 0, 1) in overline(Gamma)$ for some $h eq.not 0$, let $gamma = mat(delim: "[", a, b; c, d) in Gamma$. If $\|h c\|< 1$, then $c = 0$

]
#proof(title: "Miyake 1.7.3")[
Define inductively $gamma_n in Gamma dot.op { plus.minus 1 }$, $gamma_0 = gamma$, $gamma_(n + 1) = gamma_n mat(delim: "[", 1, h; 0, 1) gamma_n^(- 1)$, $\|h c\|< 1$ implies $gamma_n arrow.r^(n arrow.r oo) mat(delim: "[", 1, h; 0, 1)$. $Gamma$ discrete $arrow.r.double c = 0$

]
#statement("Lemma")[
For any compact subset $K subset.eq cal(H)$, for any $s in P_Gamma$, $exists l > 0$ such that $K inter gamma U_s\(l\)= diameter$, $forall gamma in Gamma$ (Or equivalently, $gamma\(K\)inter U_s\(l\)= diameter$, $forall gamma in Gamma$)

]
#proof(title: "Proof")[
Let $sigma in "SL"_2\(bb(R)\)$ with $sigma oo = s$, since $K$ is compact, $exists 0 < l_1 < l_2$ such that #math.equation(block: true, numbering: none, $sigma^(- 1)\(K\)subset.eq { z in cal(H)\|l_1 < "Im"\(z\)< l_2 }$) Since $s$ is a parabolic point, $exists h eq.not 0$ scuh that $mat(delim: "[", 1, h; 0, 1) in sigma^(- 1) Gamma dot.op { plus.minus 1 } sigma$. Let $l = max { h^2\/l_1\,l_2 }$. Let $gamma in Gamma$ and denote $delta = sigma^(- 1) gamma sigma = mat(delim: "[", a, b; c, d)$. If $c = 0$, then $delta U_oo\(l\)inter sigma^(- 1) K = U_oo\(l\)inter sigma^(- 1) K = diameter$. If $c eq.not 0$, then by Lemma #strong[??], $\|h c\|gt.eq 1$ $arrow.r.double z in U_oo\(l\)$ #math.equation(block: true, numbering: none, $"Im"\(delta z\)= frac("Im" z, \|c z + d\|^2) lt.eq frac(1, c^2 "Im" z) < frac(1, c^2 l) lt.eq h^2 / l lt.eq l_1$) $arrow.r.double delta U_oo\(l\)inter sigma^(- 1) K = diameter$. Thus $gamma U_s\(l\)inter K = gamma sigma U_oo\(l\)inter K = sigma\(delta U_oo\(l\)inter sigma^(- 1) K\)= diameter$

]
#statement("Lemma")[
Let $s\,t in P_Gamma$, then $forall l > 0$, $exists l' > 0$ such that $forall gamma in Gamma$, if $gamma s eq.not t$, then $gamma U_s\(l\)inter U_t\(l'\)= diameter$

]
#proof(title: "Proof")[
Let $sigma in "SL"_2\(bb(R)\)$ with $sigma oo = s$, since $s in P_Gamma$, $exists h eq.not 0$ such that #math.equation(block: true, numbering: none, $delta = sigma mat(delim: "[", 1, h; 0, 1) sigma^(- 1) in Gamma_s dot.op { plus.minus 1 } subset.eq Gamma dot.op { plus.minus 1 }$) Let $K = { z in cal(H)\|"Im" z = l\,0 lt.eq "Re" z lt.eq\|h\|}$, by Lemma #strong[??], $exists l' > 0$ such that $gamma sigma\(K\)inter U_t\(l'\)= diameter$, $forall gamma in Gamma$. Let $gamma in Gamma$ with $gamma s = t$. Suppose $gamma U_s\(l\)inter U_t\(l'\)eq.not diameter$, then $gamma\(partial U_s\(l\)- { s }\)inter U_t\(l'\)eq.not diameter$ since $gamma s eq.not t$. $arrow.r.double$ for some $n in bb(Z)$, $gamma delta^n sigma\(K\)inter U_t\(l'\)eq.not diameter$ is a contradiction

]
#statement("Corollary")[
$forall s in P_Gamma$, $exists C > 0$ such that $overline(Gamma) without U_s^(*)\(l\)arrow.r Gamma without cal(H)^(*)$ is an open embedding for any $l > C$

]
#proof(title: "Proof")[
Take $s = t$ in Lemma #strong[??], we see that for $l > > 0$, ${ gamma in overline(Gamma)\|gamma U_s\(l\)inter U_s\(l\)eq.not diameter } = overline(Gamma)_s$

]
#statement("Corollary")[
$Gamma without cal(H)^(*)$ is locally compact Hausdorff

]
#proof(title: "Proof")[
Corollary #strong[??] $arrow.r.double$ locally compact since $overline(Gamma)_s without overline(U_s^(*)\(l\))$ is compact. (Exercise: check this and also check that $overline(U_s^(*)\(l\))$ is not compact). From previous note, $Gamma without cal(H)$ is Hausdorff, the rest follows from Lemma #strong[??] and Lemma #strong[??]

]
Finally we can finish the proof of Theorem #strong[??] 3. Suppose $s in P_Gamma$ and the orbit $Gamma s$ does not contain any cusp of $F$. Fix a neighborhood $U = U_s^(*)\(l\)$ of $s$. The hypothesis $"Vol"\(F\)< oo$ implies that $F$ has only finitely many cusps: ${ s_1\,dots.h.c\,s_n }$ (by Theorem #strong[??]). By Lemma #strong[??], there exist neighborhoods $U_i$ of $s_i$ such that $gamma U inter U_i = diameter$, $forall gamma in Gamma$, $forall 1 lt.eq i lt.eq n$. By Lemma #strong[??], we can shrink $U$ so that it does not intersect the compact set $K = cal(F) - union.big_(i = 1)^n U_i$. Then $gamma U inter F = diameter$, $forall gamma in Gamma$, contradicting the definition of fundamental domain. Thus $Gamma s$ contains some cusps of $F$

#statement("Remark")[
Suppose $"Vol"\(cal(F)\)< oo$. Let $cal(F)^(*)$ be the closure of $cal(F)$ in $cal(H) union bb(R) union { oo }$, then $cal(F)^(*) = cal(F) union { upright("cusps") }$ and $cal(F)^(*)\/tilde.op$ is homeomorphic to $Gamma without cal(H)^(*)$

]
#statement("Definition", title: [Riemann surface structure on $Gamma without cal(H)^(*)$])[
$forall z in cal(H)^(*) = cal(H) union P_Gamma$, let $U_z$ be an open neighborhood of $z$ such that ${ gamma in Gamma\|gamma U_z inter U_z eq.not diameter } = Gamma_z$. Existence of $U_z$ follows from Proposition #strong[??] in previous note, when $z in cal(H)$, and Lemma #strong[??] (or corollary #strong[??]) when $z in P_Gamma$. Then $Gamma_z without U_z arrow.r Gamma without cal(H)^(*)$ is an open embedding for any $z in cal(H)^(*)$. We use ${ Gamma_z\/U_z\,phi.alt_z }_(z in cal(H)^(*))$ as coordinate charts, $phi.alt_z$ is to be defined

+ If $z in cal(H)$ is a non-elliptic point, then $overline(Gamma)_z = { 1 }$, let $phi.alt_z : Gamma_z without U_z arrow.r U_z$ be the natural homeomorphism

+ If $z in cal(H)$ is elliptic, then $overline(Gamma)_z$ is a cyclic group of order $n > 1$. Let $lambda : cal(H) arrow.r bb(D)$ be an isomorphism of complex manifold such that $lambda\(z\)= 0$. By Schwarz lemma, $lambda overline(Gamma)_z lambda^(- 1)$ is the group generated by $frac(2 pi, n)$ rotation. Define $phi.alt_z : Gamma_z without U_z arrow.r bb(C)$ by $phi.alt_z\(w\)= lambda\(w\)^n$

  #align(center)[
  #align(center)[#diagram(node((0,0),$U_z$),node((1,0),$cal(H)$),node((2,0),$bb(D)$),node((0,1),$Gamma_z slash U_z$),node((2,1),$bb(D)$),edge((0,0),(1,0),"hook->"),edge((1,0),(2,0),"->",$lambda$),edge((0,0),(0,1),"->"),edge((2,0),(2,1),"->",$u mapsto u^n$),edge((0,1),(2,1),"->",$phi_z$))]
  ]

+ If $s in P_Gamma$ is parabolic, then by Lemma #strong[??], #math.equation(block: true, numbering: none, $sigma^(- 1) overline(Gamma)_s sigma = ⟨mat(delim: "[", 1, h; 0, 1)⟩ tilde.equiv bb(Z)$)Where $h > 0$, here $sigma in "SL"_2\(bb(R)\)$, $sigma oo = s$, define $phi.alt_s\(w\)= exp\(frac(2 pi i, h) sigma^(- 1)\(w\)\)$

  #align(center)[
  #align(center)[#diagram(node((0,0),$U_s$),node((1,0),$cal(H) union {infinity}$),node((0,1),$Gamma_s slash U_s$),node((1,1),$bb(D)$),edge((0,0),(1,0),"->",$sigma^(-1)$),edge((0,0),(0,1),"->"),edge((1,0),(1,1),"->",$exp(frac(2pi i,h) z)$),edge((0,1),(1,1),"->",$phi_s$))]
  ]

]
Let's write $X\(Gamma\)= Gamma without cal(H)^(*)$, $Y\(Gamma\)= Gamma without cal(H)$. Riemann surfaces with complex structures defined above. $X\(Gamma\)- Y\(Gamma\)$ is a discrete set of cusps of $X\(Gamma\)$

#statement("Theorem", title: [Siegel])[
$X\(Gamma\)$ is compact $arrow.l.r.double$ $Y\(Gamma\)$ has finite volume

]
#proof(title: "Proof")[
$arrow.r.double :$ $X\(Gamma\)$ compact $arrow.r.double$ finitely many cusps, a neighborhood of each cusp has finite volume #math.equation(block: true, numbering: none, $integral_l^oo integral_0^h frac(d x d y, y^2) = h integral_l^oo frac(d y, y^2) < oo$) $arrow.l.double :$ Let $cal(F)$ be the fundamental domain as in Theorem #strong[??], then $"Vol"\(cal(F)\)= "Vol"\(Y\(Gamma\)\)< oo$ $arrow.r.double$ $X\(Gamma\)approx cal(F)^(*)\/tilde.op$ is compact by Theorem #strong[??]. Here $cal(F)^(*) = cal(F) union { upright("cusps") }$ is viewed as a closed subset of $bb(C P)^1$, hence compact

]

#pagebreak()

= Holomorphic modular forms

$Gamma lt.eq "SL"_2\(bb(R)\)$ is a discrete subgroup such that $"Vol"\(Gamma without cal(H)\)< oo$. For $g = mat(delim: "[", a, b; c, d) in "GL"_2\(bb(R)\)^(+)$, let $j\(g\,z\)= c z + d$. For a function $f$ on $cal(H)$, $k in bb(Z)$, define #math.equation(block: true, numbering: none, $\(f dot.op_k g\)\(z\)= det\(g\)^(k / 2) j\(g\,z\)^(- k) f\(g z\)$) Suppose $f$ is holomorphic on $cal(H)$ and $f dot.op_k gamma = f$, $forall gamma in Gamma$. Let $t = sigma oo in P_Gamma$, $sigma in "SL"_2\(bb(R)\)$\(parabolic point), then $sigma^(- 1) Gamma_t sigma inter mat(delim: "[", 1, *; 0, 1) = mat(delim: "[", 1, h bb(Z); 0, 1)$, for some $h > 0$, $arrow.r.double f dot.op_k sigma inter mat(delim: "[", 1, h; 0, 1) sigma^(- 1) = f arrow.r.double\(f dot.op_k sigma\)dot.op_k mat(delim: "[", 1, h; 0, 1) = f dot.op_k sigma$ $arrow.r.double\(f dot.op_k sigma\)\(z + h\)=\(f dot.op_k sigma\)\(z\)$. The Fourier expansion is #math.equation(block: true, numbering: none, $f dot.op_k sigma = sum_(n in bb(Z)) a_n e^(frac(2 pi i n z, h))$)

#statement("Definition")[
$f$ is meromorphic/holomorphic/vanishes at $t in P_Gamma$ if $a_n = 0\,forall n < < 0\/n < 0\/n lt.eq 0$

]
#statement("Definition")[
A holomorphic function $f$ on $cal(H)$ is a holomorphic/meromorphic modular form of weight $k$ and level $Gamma$ if it satisfies

+ $f dot.op_k gamma = f\,forall gamma in Gamma$

+ $f$ is holomorphic/meromorphic at all $t in P_Gamma$

It is a cusp form if furthermore it vanishes at all $t in P_Gamma$. Let $A_k\(Gamma\)$ denote the set of meromorphic forms of weight $k$, level $Gamma$, $M_k\(Gamma\)$ denote the set of holomorphic forms of weight $k$, level $Gamma$, $S_k\(Gamma\)$ denote the set of cusp forms of weight $k$, level $Gamma$

]
#statement("Remark")[
Since $f dot.op_k mat(delim: "[", - 1, 0; 0, - 1) =\(- 1\)^k f$, if $- I in Gamma$, then for any odd $k$, $A_k\(Gamma\)= 0$. $A_0\(Gamma\)$ is the field of rational functions on $X\(Gamma\)= Gamma without cal(H)^(*)$, $M_0\(Gamma\)= bb(C)$ #math.equation(block: true, numbering: none, $A\(Gamma\)= xor.big_(k in bb(Z)) A_k\(Gamma\)supset.eq M\(Gamma\)= xor.big_(k in bb(Z)) M_k\(Gamma\)$) are graded rings, $S\(Gamma\)= xor.big_(k in bb(Z)) S_k\(Gamma\)$ is a graded ideal in $M\(Gamma\)$

]
#statement("Example")[
Let $Gamma = "SL"_2\(bb(Z)\)= chevron.l T\,S chevron.r$, $T = mat(delim: "[", 1, 1; 0, 1)$, $S = mat(delim: "[", 0, - 1; 1, 0)$, then condition is equivalent to $f\(z + 1\)= f\(z\)$, $f\(- 1 / z\)= z^k f\(z\)$. Using this, one can show that #emph[Ramanujan's function] #math.equation(block: true, numbering: none, $Delta\(z\)= q product_(n = 1)^oo\(1 - q^n\)^24\,q = e^(2 pi i z)$) is a cusp form of weight 12, level $Gamma = "SL"_2\(bb(Z)\)$. See \[Bump §1.3\] for details

]
#statement("Definition", title: [Holomorphic Eisenstein series])[
$k > 2$ is an even integer #math.equation(block: true, numbering: none, $E_k\(z\)= 1 / 2 sum_(m\,n in bb(Z)\
\(m\,n\)eq.not\(0\,0\))\(m z + n\)^(- k) = zeta\(k\)G_k\(z\)\,z in cal(H)$) where #math.equation(block: true, numbering: none, $G_k\(z\)= 1 / 2 sum_(c\,d in bb(Z)\
\(c\,d\)= 1)\(c z + d\)^(- k) = sum_(gamma in Gamma_oo without Gamma) j\(gamma\,z\)^(- k)$) Use $j\(gamma_1 gamma_2\,z\)= j\(gamma_1\,gamma_2 z\)j\(gamma_2\,z\)$ to deduce $G_k dot.op_k gamma = G_k\,forall gamma in Gamma$ \ Generalizing this construction: Suppose $forall gamma in Gamma$, we have a function $phi.alt_gamma\(z\)$ on $cal(H)$ satisfying

+ $phi.alt_(delta gamma)\(z\)= phi.alt_delta\(gamma z\)j\(gamma\,z\)^(- k)\,forall gamma\,delta in Gamma$, $z in cal(H)$

+ $phi.alt_(u gamma) = phi.alt_gamma$, $forall gamma in Gamma\,u in Gamma_oo$

Consider the formal sum $Phi\(z\)= sum_(delta in Gamma_oo without Gamma) phi.alt_delta\(z\)$, then $Phi dot.op_k gamma = Phi\,forall gamma in Gamma$ if the sum converges absolutely. Take $phi.alt_gamma\(z\)= j\(gamma\,z\)^(- k)$, get $G_k$ as above. Take $phi.alt_gamma\(z\)= j\(gamma\,z\)^(- k) e^(2 pi i m gamma z)\,m in bb(Z)_(gt.eq 0)$, get Poincaré series $P_m\(z\)= sum_(gamma in Gamma_oo without Gamma) j\(gamma\,z\)^(- k) e^(2 pi i m gamma z)$, absolutely converges when $k > 2$ is even. When $m > 0$, $P_m$ is a cusp form of weight $k$, level $"SL"_2\(bb(Z)\)$. $P_0\(z\)= G_k\(z\)$ is not cusp form. Fourier expansion #math.equation(block: true, numbering: none, $E_k\(z\)= zeta\(k\)+ frac(\(2 pi\)^k\(- 1\)^(k / 2), \(k - 1\)!) sum sigma_(k - 1)\(n\)q^n$) where $sigma_r\(n\)= sum_(d\|n) d^r\,q = e^(2 pi i n z)$ \ Method:

+ Direct computation: $f\(z\)= sum_(n in bb(Z)) a_n q^n\,q = e^(2 pi i z)$, then #math.equation(block: true, numbering: none, $a_n = integral_0^1 f\(x + i y\)e^(- 2 pi i n\(x + i y\)) d x$) explicit formula for Fourier coefficients of $P_m\(z\)$

+ Faster trick for $E_k\(z\)$: (see \[Shimura §2.2\]) use the identity #math.equation(block: true, numbering: none, $pi cot\(pi z\)= z^(- 1) + sum_(m = 1)^oo (frac(1, z + m) - frac(1, z - m))$)

]
#statement("Fact")[
$S_k\("SL"_2\(bb(Z)\)\)$ is spanned by ${ P_m\(z\)\,m in bb(Z)_(> 0) }$ when $k > 2$, later we will see $S_k\(Gamma\)$ is finite dimensional

]
Define $j\(z\)= frac(G_4\(z\)^3, Delta\(z\))\,forall z in cal(H)$. Then $j in A_0\("SL"_2\(bb(Z)\)\)$ induces isomorphism $j : "SL"_2\(bb(Z)\)without cal(H)^(*) arrow.r bb(C P)^1$, thus $A_0\("SL"_2\(bb(Z)\)\)= bb(C)\(j\)$. Fourier expansion #math.equation(block: true, numbering: none, $j\(z\)= q^(- 1) + 744 + 196884 q + 21493760 q^2 + dots.h.c$) Clearly $M_k\("SL"_2\(bb(Z)\)\)= bb(C)\[G_4\,G_6\]$ as a graded ring, e.g. $Delta = 1 / 1728\(G_4^3 - G_6^2\)$, see \[Bump 1.3.3, 1.3.4\] for simple proof

#statement("Lemma")[
Let $f in A_k\(Gamma\)$, then $f in S_k\(Gamma\)arrow.l.r.double f\(z\)"Im"\(z\)^(k / 2)$ is bounded on $cal(H)$

]#label("f is a cusp form iff f(z)Im(z)^k/2 is bounded on H")
#proof(title: "Proof")[
Let $t = sigma oo in P_Gamma$, $sigma = mat(delim: "[", a, b; c, d) in "SL"_2\(bb(R)\)$, Fourier expansion at $t$, $\(f dot.op_k sigma\)\(z\)= sum_n a_n e^(2 pi i n z\/h)$ #math.equation(block: true, numbering: none, $\|f\(sigma z\)"Im"\(sigma z\)^(k / 2)\|=\|\(c z + d\)^k\(f dot.op_k sigma\)\(z\)\|c z + d\|^(- k) "Im"\(z\)^(k / 2)\|=\|sum_n a_n e^(2 pi i n z\/h)\|"Im"\(z\)^(k / 2)$) Bounded when $"Im"\(z\)arrow.r oo arrow.l.r.double a_n = 0\,forall n lt.eq 0$

]
Suppose $f_1\,f_2 in M_k\(Gamma\)$, at least one in $S_k\(Gamma\)$, then $f_1 f_2 in S_(2 k)\(Gamma\)$, so $f_1 f_2 "Im"\(z\)^k$ is bounded by Lemma #ref(label("f is a cusp form iff f(z)Im(z)^k/2 is bounded on H"), supplement: none). Also $f_1\(gamma z\)overline(f_2\(gamma z\)) "Im"\(gamma z\)^k = f_1\(z\)overline(f_2\(z\)) "Im"\(z\)^k\,forall gamma in Gamma$. So we have a well-defined integral #math.equation(block: true, numbering: none, $\(f_1\,f_2\)= integral_(Gamma without cal(H)) f_1\(z\)overline(f_2\(z\)) "Im"\(z\)^k frac(d x d y, y^2)$) Which is called Peterson inner product

#statement("Exercise")[
$\(f\,E_k\)= 0$, $forall f in S_k\("SL"_2\(bb(Z)\)\)$, for $k > 2$ is even

]
In particular, $forall f in S_k\(Gamma\)$, the function $tilde(f)\(z\)= f\(z\)"Im"\(z\)^(k / 2)$ satisfies $\|tilde(f)\(gamma z\)\|=\|tilde(f)\(z\)\|$, $forall gamma in Gamma$ and $integral_(Gamma without cal(H))\|tilde(f)\(z\)\|^2 d mu < oo$. $tilde(f)\(z\)$ is almost in $L^2\(Gamma without cal(H)\)$ but not quite, since $tilde(f)\(gamma z\)= e\(gamma\,z\)^k tilde(f)\(z\)$, $forall gamma in Gamma$ where $e\(gamma\,z\)= frac(j\(gamma\,z\), \|j\(gamma\,z\)\|)$. $tilde(f)$ is an example of a Maass (cusp) form of weight $k$, in particular, it is eigenfunction of $Delta_k = - y^2 (frac(partial^2, partial x^2) + frac(partial^2, partial y^2)) + i k y frac(partial, partial x)$, $f$ is holomorphic $arrow.l.r.double$ $L_k tilde(f) = 0$, where $L_k = -\(z - macron(z)\)frac(partial, partial macron(z)) - k / 2$ is the Maass lowering operator. To better understand these, consider $Gamma without "GL"_2\(bb(R)\)^(+)$ instead of $Gamma without cal(H)$. Let $g = mat(delim: "[", a, b; c, d) in "GL"_2\(bb(R)\)^(+)$ with $g i = z$, $e\(gamma\,z\)= e\(gamma\,g i\)= frac(e\(gamma g\,i\), e\(g\,i\))$. Define $phi.alt_f\(g\)= tilde(f)\(g i\)e\(g\,i\)^(- k) = f\(g i\)det\(g\)^(k / 2) j\(g\,i\)^(- k) = f\(frac(a i + b, c i + d)\)\(a d - b c\)^(k / 2)\(c i + d\)^(- k)$. Recall $f in S_k\(Gamma\)$, then we get

+ $phi.alt_f\(gamma g\)= phi.alt_f\(g\)\,forall gamma in Gamma$

+ $phi.alt_f (g mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)) = e^(i k theta) phi.alt_f\(g\)\,forall theta$

+ $integral_(Gamma without cal(H))\|tilde(f)\(z\)\|^2 d mu < oo arrow.r.double phi.alt_f in L^2\(Gamma without "GL"_2\(bb(R)\)^(+)\/Z^(+)\)= L^2\(Gamma without "SL"_2\(bb(R)\)\)$, here $Z^(+) = {mat(delim: "[", lambda, 0; 0, lambda) mid(bar.v) lambda > 0}$, $"GL"_2\(bb(R)\)^(+)\/Z^(+) = "SL"_2\(bb(R)\)$

Haar measure on $"GL"_2\(bb(R)\)^(+)$: Each element in $"GL"_2\(bb(R)\)^(+)$ can be written uniquely as #math.equation(block: true, numbering: none, $g = lambda mat(delim: "[", 1, x; 0, 1) mat(delim: "[", y^(1 / 2), 0; 0, y^(- 1 / 2)) mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)$) Here $lambda > 0$, $y > 0$, $x in bb(R)$, $theta in\[0\,2 pi\)$, this is the #emph[Iwasawa decomposition] $"SL"_2\(bb(R)\)= N A K$, $d g = frac(d lambda, lambda) frac(d x d y, y^2) d theta$ \ $phi.alt_f in C^oo\(Gamma without "GL"_2\(bb(R)\)^(+)\)$ is a eigenfunction of $Z\(frak(g l)_2\)$\(inducing $Delta_k$), annihilated by certain nilpotent element in $frak(g l)_2$\(inducing $L_k$) \ $f$ is a cusp form $arrow.l.r.double$ $integral_(U inter Gamma without U) phi.alt_f\(U g\)d u = 0\,forall g$, for all unipotent subgroup $U subset.eq "SL"_2\(bb(R)\)$ such that $U inter Gamma = { 1 }$


#pagebreak()

= Automorphic forms on $"GL"\(2\,bb(R)\)$

#statement("Definition")[
For this section, we use the following notation:

- $G = "GL"_2\(bb(R)\)^(+)$, $G_1 = "SL"_2\(bb(R)\)supset.eq K = "SO"_2\(bb(R)\)$

- $frak(g) = "Lie"\(G\)= frak(g l)_2\(bb(R)\)$, $frak(g)_(bb(C)) = frak(g l)_2\(bb(C)\)$, $Z_G tilde.equiv bb(R)^times$ is the center of $G$, $Z_G^(+) tilde.equiv bb(R)_(> 0)$ is the identity component. A standard basis for $frak(g)$ is #math.equation(block: true, numbering: none, $Z = mat(delim: "[", 1, 0; 0, 1)\,H = mat(delim: "[", 1, 0; 0, - 1) E = mat(delim: "[", 0, 1; 0, 0)\,F = mat(delim: "[", 0, 0; 1, 0)$) Their relations are $\[H\,E\]= 2 E$, $\[H\,F\]= - 2 F$, $\[E\,F\]= H$. $"Lie"\(K\)= frak(s o)_2\(bb(R)\)= bb(R)\(E - F\)$

- Representation $G arrow.r "End"_(bb(C))\(C^oo\(G\)\)$ is induced by the right regular representation on $G$ #math.equation(block: true, numbering: none, $\(g f\)\(x\)= f\(x g\)\,forall g\,x in G\,f in C^oo\(G\)$) This gives a representation of $frak(g)_(bb(C)) arrow.r "End"_(bb(C))\(C^oo\(G\)\)$ #math.equation(block: true, numbering: none, $\(X f\)\(g\)= frac(d, d t) f\(g e^(t X)\)\,forall X in frak(g)$) The universal enveloping algebra $U\(frak(g)_(bb(C))\)$ can be identified with left-invariant differential operators on $G$, $Z_(frak(g))$ is the center of $U\(frak(g)_(bb(C))\)$, which can be identified with bi-invariant differential operators on $G$

- The Harish-Chandra isomorphism says that $Z_(frak(g)) tilde.equiv bb(C)\[Z\,Delta\]$, where $Delta = - 1 / 4\(H^2 + 2 E F + 2 F E\)$ is the casimir element. In particular, $Z_(frak(g))$ induces $G$-invariant differential operators on $cal(H) = G_1\/K$, $Delta$ induces $- y^2 (frac(partial^2, partial x^2) + frac(partial^2, partial y^2))$

]
#statement("Definition")[
If $f in C^oo\(G\)$, $omega : Z_G arrow.r bb(C)^times$ be a unitary character, then

- $f$ is $Z_(frak(g))$-finite if $Z_(frak(g)) f$ is finite dimensional

- $f$ is (right) $K$-finite if $K f$ is finite dimensional

- Define $C^oo\(G\,omega\)= { f in C^oo\(G\)\|f\(z g\)= omega\(z\)f\(g\)\,forall z in Z_G\,g in G }$

]
#statement("Theorem")[
If $P$ is an elliptic operator with analytic coefficients, then solutions to $P f = 0$ in $L_(upright("loc"))^1$ are real analytic

]
#statement("Lemma")[
If $f in C^oo\(G\)$ is $Z_(frak(g))$-finite and $K$-finite, then $f$ is real analytic

]#label("f is Z_g finite and K finite, then f is real analytic")
#proof(title: "Proof")[
We may assume $f$ is an eigenfunction of $K$ and $Z_(frak(g))$ finite(for the general case, just take linear combination). Then $P\(tilde(Delta)\)f = 0$ for some polynomial $P$ with constant coefficient, where #math.equation(block: true, numbering: none, $tilde(Delta) & = - 1 / 4\(H^2 + 2 E F + 2 F E + Z^2\)\
 & = underbrace(- 1 / 4\(H^2 + 2 E^2 + 2 F^2 + Z^2\), upright("elliptic differential operator")) + underbrace(1 / 2\(E - F\)^2, upright("scalar on ") f)$)

]
#statement("Remark")[
Lemma #ref(label("f is Z_g finite and K finite, then f is real analytic"), supplement: none) is true under weaker assumption that $f$ is locally integrable

]
#statement("Definition")[
Let $Gamma lt.eq G_1$ be a discrete subgroup with $"Vol"\(Gamma without G_1\)< oo$\($arrow.l.r.double "Vol"\(Gamma without cal(H)\)< oo$). Let $chi : Gamma arrow.r bb(C)^times$, $omega : Z_G arrow.r bb(C)^times$ be unitary characters that agree on $Z_Gamma = Gamma inter Z_G$. An automrophic form on $G$ with character $chi\,omega$ is a function $phi.alt in C^oo\(G\,omega\)$ satisfying

+ $phi.alt\(gamma g\)= chi\(gamma\)phi.alt\(g\)\,forall gamma in Gamma\,g in G$

+ $phi.alt$ is (right) $K$-finite

+ $phi.alt$ is $Z_(frak(g))$-finite

+ $phi.alt$ is of moderarte growth, meaning $exists C\,N > 0$ such that $\|phi.alt\(g\)\|< C parallel g parallel^N\,forall g in G$, $parallel g parallel$ is the Euclidean norm of $\(g\,det g^(- 1)\)in M_2\(bb(R)\)xor bb(R) tilde.equiv bb(R)^5$

Denote $cal(A)\(Gamma without G\,chi\,omega\)$ the space of such functions

]
#statement("Definition")[
$phi.alt in cal(A)\(Gamma without G\,chi\,omega\)$ is a #emph[cusp form] if for any $g in G$ and for any unipotent subgroup $U subset.eq G$ with $U inter Gamma eq.not { 1 }$,$integral_(U inter Gamma without U) phi.alt\(u g\)d u = 0$. Deonte $cal(A)_0\(Gamma without G\,chi\,omega\)$ the space of cusp forms

]
#statement("Example")[
$phi.alt_f\(g\)= f\(g i\)det\(g\)^(k / 2) j\(g\,i\)^(- k)\,forall g in G$

#align(center)[
#align(center)[#diagram(node((0,0),$M_k(Gamma)$),node((1,0),$cal(A)(Gamma without G slash Z_G^+)$),node((0,1),$S_k(Gamma)$),node((1,1),$cal(A)_0(Gamma without G slash Z_G^+)$),edge((0,0),(1,0),"hook->"),edge((0,1),(1,1),"hook->"),edge((0,1),(0,0),"hook->"),edge((1,1),(1,0),"hook->"))]
]
]
#statement("Remark")[
Since $g$ commutes with $Z_(frak(g))$ for any $g in G$, $Z_(frak(g))$-finite condition is preserved under $g$, condition 1,4 are also preserved. But condition 3 may not be preserved in general: If $f$ is $K$-finite, then $g f$ is $g K g^(- 1)$-finite. At least we get a representation of $K$ on $cal(A)\,cal(A)_0$, so they split as direct sum of $K$-eigenspaces (weight spaces)

]
#statement("Theorem")[
$cal(A)\(Gamma without G\,chi\,omega\)$ and $cal(A)_0\(Gamma without G\,chi\,omega\)$ are stable under the action of $U\(frak(g)_(bb(C))\)$ (induced from the right regular representation on $C^oo\(G\)$)

]
#proof(title: "Proof")[
Easy to see: automorphy, $Z_(frak(g))$-finite, cuspidal conditions are preserved by $frak(g)$, $K$-finiteness is also note hard. The tricky part is $frak(g)$ preserves growth condition (even the exponent $N$) \ $frak(g)$ preserves $K$-finiteness: Consider another basis of $frak(s l)_2\(bb(C)\)$, $W = C^(- 1) H C = mat(delim: "[", 0, - i; i, 0)$, $R = C^(- 1) E C$, $L = C^(- 1) F C$, here $C = mat(delim: "[", 1, - i; 1, i)$ is the Cayley transform. Then $"Lie"\(K\)_(bb(C)) = bb(C) dot.op W$. If $phi.alt in C^oo\(G\)$ has weight $m$, i.e. #math.equation(block: true, numbering: none, $phi.alt (g mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)) = e^(i m theta) phi.alt\(g\)\,forall g in G$) Then $W phi.alt = m phi.alt$ since $mat(delim: "[", cos theta, sin theta; - sin theta, cos theta) = e^(i theta W)$. Since $\[W\,R\]= 2 R$, $\[W\,L\]= - 2 L$, we see that $R$ raises weight by $2$, $L$ lowers weight by $2$. So $K$-finiteness is preserved by $frak(g)$ \ $frak(g)$ preserves growth condition: By Harish-Chandra theorem #ref(label("Harish-Chandra theorem"), supplement: none), $exists alpha in C_c^oo\(G\)$ such that $phi.alt = phi.alt * alpha$ where $\(phi.alt * alpha\)\(g\)= integral_G phi.alt\(x\)alpha\(x^(- 1) g\)d x$. Then $forall X in frak(g)$, $X phi.alt = X\(phi.alt * alpha\)= phi.alt *\(X alpha\)$ satisfies growth condition with same exponent as $phi.alt$

]
#statement("Theorem", title: [Harish-Chandra])[
Let $f in C^oo\(G\)$ be $Z_(frak(g))$-finite and $K$-finite. Let $U$ be a neighborhood of $1$ in $G$. Then $exists alpha in I_c^oo\(G\)$ with support in $U$ such that $f = f * alpha$. Here #math.equation(block: true, numbering: none, $I_c^oo\(G\)= { alpha in C_c^oo\(G\)\,alpha\(k x k^(- 1)\)= alpha\(x\)\,forall k in K\,x in G }$)

]#label("Harish-Chandra theorem")
Recall: Frechet topology on $C^oo\(G\)$: $X subset.eq G$ compact subset, $N in bb(Z)_(gt.eq 0)$. Semi-norm #math.equation(block: true, numbering: none, $parallel f parallel_(X\,N) = max {\|D f\(x\)\|\|D in U\(frak(g)_(bb(C))\)upright(" of order") lt.eq N\,x in X }$) A neighborhood base at $0$: ${ f in C^oo\(G\)\|parallel f parallel_(X\,N) < epsilon.alt }$. In this topology, $f_n arrow.r f$ if $forall D in U\(frak(g)_(bb(C))\)$, $D f_n arrow.r D f$ uniformly on any compact subset of $G$

#proof(title: "Proof")[
Use Proposition #ref(label("f Z_g finite, K finite, decompose U(g_C)f"), supplement: none)

]
#statement("Definition")[
A $\(frak(g)\,K\)$-module is a $bb(C)$ vector space $V$ with a representation of $frak(g)_(bb(C))$ and $K$ such that

+ Every $v in V$ is $K$-finite

+ $forall X in "Lie"\(K\)$, $frac(d, d t)\|_(t = 0)\(e^(t X) v\)= X v$, $forall v in V$

+ $forall X in frak(g)\,k in K\,v in V$, $k\(X v\)=\("ad"\(k\)X\)\(k v\)=\(k X k^(- 1)\)\(k v\)$

Denote #math.equation(block: true, numbering: none, $V\(n\)= { v in V\,k v = chi_n\(k\)v\,forall k in K }$) Where $chi_n (mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)) = e^(i n theta)$, $forall theta in bb(R)$. A $\(frak(g)\,K\)$-module $V$ is #emph[admissible] if $dim V\(n\)< oo\,forall n in bb(Z)$

]#label("(g,k)-modules")
#statement("Remark")[
\1. $arrow.l.r.double$ $V = xor.big_(n in bb(Z)) V\(n\)$ $arrow.l.r.double$ $V$ is a the direct sum of finite dimensional $K$-invariant subspaces (Zorn's Lemma $arrow.r.double$ $V\(n\)$ has a basis consisting of $K$-eigenvectors) \ 1. $arrow.r.double$ $t mapsto e^(t X) dot.op v$ is differentiable $forall X in "Lie"\(K\)$, $v in V$, so 2. makes sense \ Proposition #ref(label("f Z_g finite, K finite, decompose U(g_C)f"), supplement: none) $arrow.r.double$ $U\(frak(g)_(bb(C))\)f$ is an admissible $\(frak(g)\,K\)$-module for any $K$-finite, $Z_(frak(g))$-finite $f in C^oo\(G\)$

]
#statement("Proposition")[
Let $f in C^oo\(G\)$ be $Z_(frak(g))$-finite and $K$-finite. Let $V$ be the closure of $U\(frak(g)_(bb(C))\)dot.op f$ in $C^oo\(G\)$. Then $V$ is (right) $G$-invariant. Moreover, each $K$-weight space $V\(n\)$ of $V$ is finite dimensional and $U\(frak(g)_(bb(C))\)dot.op f = xor.big_(n in bb(Z)) V\(n\)$

]#label("f Z_g finite, K finite, decompose U(g_C)f")
#proof(title: "Proof")[
Let $V_0 = U\(frak(g)_(bb(C))\)f$, so $V = overline(V_0)$ \ Step 1: Show that $V$ is $G$-stable \ Let $tilde(V) subset.eq C^oo\(G\)$ be the smallest closed $G$-invariant subspace containing $V_0$. Then $V subset.eq tilde(V)$. Suppose $V eq.not tilde(V)$. Then $exists$ continuous nonzero linear functional $lambda$ on $tilde(V)$ such that $lambda\(V\)= 0$ by Hahn-Banach. Consider function $phi.alt\(g\)= lambda\(r_g f\)$. Easy to check: $f$ is $Z_(frak(g))$-finite, $K$-finite $arrow.r.double$ same for $phi.alt$. By Lemma #ref(label("f is Z_g finite and K finite, then f is real analytic"), supplement: none), $phi.alt$ is analytic. On the other hand, $forall D in U\(frak(g)_(bb(C))\)$, $D phi.alt = lambda\(D f\)= 0$ since $D f in V_0 arrow.r.double phi.alt = 0 arrow.r.double lambda$ vanish on the dense subspace $G dot.op f$ in $tilde(V) arrow.r.double lambda = 0$, contradiction \ Step 2: Let $V_0\(n\)= { v in V\|W v = n v } = V_0 inter V\(n\)$, we claim that $V_0 = xor.big_(n in bb(Z)) V\(n\)$. $forall n$, consider the projector $E_n : C^oo\(G\)arrow.r C^oo\(G\)$ #math.equation(block: true, numbering: none, $\(E_n phi.alt\)\(g\)= integral_K phi.alt\(g k^(- 1)\)chi_n\(k\)d k\,"Vol"\(K\,d k\)= 1$) $E_n$ is continuous, identity on $V\(n\)$, $E_n V = V\(n\)$, need to show $E_n V_0 subset.eq V_0$. $forall v in V_0$, $v = sum_(n = - M)^M E_n v$, fix $m in\[- M\,M\]$, let $P$ be a polynomial such that $P\(m\)= 1$ and $P\(n\)= 0$ for any $n in\[- M\,M\]\,n eq.not m$, then #math.equation(block: true, numbering: none, $V_0 in.rev P\(W\)v = sum_(n = - M)^M P\(n\)E_n v = E_m v arrow.r.double E_m v in V_0\(m\)$) Thus $V_0\(n\)= E_n V$, so it is dense in $V\(n\)= E_n V$ and $V_0 = xor.big V_0\(n\)$ \ Step 3: Remains to show $dim V_0\(n\)< oo$ (Then by density, $V_0\(n\)= V\(n\)$ and hence $V_0 = xor V\(n\)$). $f = sum_(n = - M)^M E_n f$, $Z_(frak(g)) E_n f = E_n Z_(frak(g)) f$ is finite dimensional $forall n arrow.r.double E_n f$ is $Z_(frak(g))$-finite $forall - M lt.eq n lt.eq M$. So we may assume $f in V\(n_0\)$ for some $n_0 in bb(Z)$. By PBW, ${ R^a L^b W^c }_(a\,b\,c gt.eq 0)$ form a $bb(C)$-basis of $U\(frak(g)_(bb(C))\)$ \ Recall #math.equation(block: true, numbering: none, $- 4 Delta = W^2 + 2 W + 4 L R = W^2 - 2 W + 4 R L arrow.r.double U\(frak(g)_(bb(C))\)= sum_(i > 0) R^i A + sum_(i gt.eq 0) L^i A$) Where $A$ is the subalgebra generated by $Z_(frak(g))$ and $W$. Let ${ f_1\,dots.h.c\,f_r } subset.eq V\(n_0\)$ be a basis of $Z_(frak(g)) f$, then #math.equation(block: true, numbering: none, $V_0 & = sum_(alpha = 1)^r (sum_(i > 0) bb(C) R^i f_alpha + sum_(i gt.eq 0) bb(C) L^i f_alpha)\
arrow.r.double V_0\(n\) & = sum_(alpha = 1)^r (sum_(i > 0) bb(C) R^(frac(n - n_0, 2)) f_alpha + sum_(i gt.eq 0) bb(C) L^(frac(n - n_0, 2)) f_alpha)$) is of finite dimensional

]
Summary: if $f in C^oo\(G\)$ is $Z_(frak(g))$ finite and $K$-finite, we have

+ $\(U frak(g)_(bb(C)) f\)$ is an admissible $\(frak(g)\,K\)$-module

+ If $f$ has moderate growth with exponent $N > 0$, then the same is true for $D f$, $forall D in U frak(g)_(bb(C))$

In particular, $cal(A)_0\(Gamma without G\,chi\,omega\)subset.eq cal(A)\(Gamma without G\,chi\,omega\)$ are $\(frak(g)\,K\)$-modules \ The $\(frak(g)\,K\)$-module structure on $cal(A)\(Gamma without G\,chi\,omega\)$ is complicated: $Z_(frak(g))$ does not act semi-simply if $Gamma$ has cusps. Simpler on $cal(A)_0\(Gamma without G\,chi\,omega\)$, decompose into direct sum of irreducible admissible $\(frak(g)\,K\)$-modules with finite multiplicity. We will prove this by $L^2$ theory

#statement("Lemma", title: [Schur])[
$Z_(frak(g))$ acts by a character on any irreducible admissible $\(frak(g)\,K\)$-module (infinitesimal character)

]#label("Schur's lemma")
#proof(title: "Proof")[
Let $n in bb(Z)$ with $V\(n\)eq.not 0$. $Z_(frak(g))$ commutes with $K$ action by 3. in Definition #ref(label("(g,k)-modules"), supplement: none). Admissible $arrow.r.double dim V\(n\)< oo$ $arrow.r.double$ $Z_(frak(g))$ acts by a character $eta : Z_(frak(g)) arrow.r bb(C)$ on $V\(n\)$. $U frak(g)_(bb(C)) V\(n\)$ is $K$-stable by 3. Irreducible $arrow.r.double$ $V = U\(frak(g)_(bb(C))\)V\(n\)arrow.r.double Z_(frak(g))$ acts by $eta$ on $V$

]
#statement("Theorem", title: [Harish-Chandra])[
Let $J subset.eq Z_(frak(g))$ be an ideal of finite codimension. Then $cal(A)\(Gamma without G\,chi\,omega\)\[J\]$ (subspace annihilated by $J$) is an admissible $\(frak(g)\,K\)$-module. We will only prove the special case for $cal(A)_0$

]#label("Another theorem of Harish-Chandra")

#pagebreak()

= Growth conditions and fundamental estimates

Reference: \[Borel, Automorphic forms on $"SL"_2\(bb(R)\)$\]

$N = {mat(delim: "[", 1, *; 0, 1)} subset.eq B = {mat(delim: "[", *, *; 0, *)} subset.eq G = "GL"_2\(bb(R)\)^(+) supset.eq G_1 = "SL"_2\(bb(R)\)supset.eq K = "SO"\(2\)$, $A = {mat(delim: "[", *, 0; 0, *)}$, $B = N A$, Iwasawa decomposition: $G = N A K$. $Gamma lt.eq G_1$ is a discrete subgroup, $"Vol"\(Gamma without G_1\)< oo$. $alpha$ is a obvious map $"GL"_2\(bb(R)\)arrow.r bb(C P)^1$

#statement("Definition", title: [Siegel set])[
For $a = mat(delim: "[", a_1, 0; 0, a_2) in A$, $alpha\(a\)= a_1 / a_2 = Im\(a dot.op i\)$, $forall t > 0$, let $A_t = { a in A\|alpha\(a\)> t }$. Suppose $oo in P_Gamma$ is a cusp of $Gamma$, then $Gamma inter N = ⟨mat(delim: "[", 1, h; 0, 1)⟩ tilde.equiv bb(Z)$, for some $h > 0$. Siegel sets at $oo$ are of the form $S_t = Omega A_t K$, $t > 0$, $Omega subset.eq N$ is a compact subset containing an interval of length $h$. In general, for a cusp $s = sigma oo$, Siegel sets at $s$ are $S_t = sigma Omega A_t sigma^(- 1) K$

#align(center)[
#box(image("Pictures/Siegel_set.PNG", width: 65.0%, alt: "image"))

]
Let $Gamma without P_Gamma = { s_1\,dots.h.c\,s_n }$, One can find Siegel sets $S_i$ at each cusp $s_i$ and a compact mod center set $C subset.eq G$ suc that $C union union.big_(i = 1)^n S_i$ is a fundamental domain for $Gamma without G$

]
#statement("Definition", title: [Growth conditions])[
Suppose $oo in P_Gamma$, a function $phi.alt : Gamma without G arrow.r bb(C)$ has moderate growth at $oo$ if $exists$ Siegel set $S_t = Omega A_t K$ and $lambda in bb(R)$ such that $phi.alt\(g\)< < Im\(g dot.op i\)^lambda$, $forall g in S_t$. If this holds for all $lambda in bb(R)$, we say $phi.alt$ has rapid decay at $oo$. In general, for a cusp $s = sigma oo in P_Gamma$, we say $phi.alt$ has moderate growth/repid decay at $s$ if the function $phi.alt_sigma\(g\)= phi.alt\(sigma g\)$ is so at $oo in P_(sigma^(- 1) Gamma sigma)$

]
#statement("Proposition")[
$phi.alt$ has moderate growth at all cusps of $Gamma arrow.l.r.double phi.alt$ has moderate growth on $G$\(as defined last time), see \[Borel-5.11\]

]#label("phi moderate growth at all cusps <=> phi moderate growth on G")
#statement("Definition")[
$omega : Z_G arrow.r bb(C)^times$ is a unitary character, define #math.equation(block: true, numbering: none, $L^2\(Gamma without G\,omega\)= {f : Gamma without G arrow.r bb(C) \| f \( z g \) = omega \( z \) f \( g \) \, forall z in Z_G \, parallel f parallel_2 = integral_(Gamma without G\/Z_G) \| f \|^2 < oo}$)

]
#statement("Proposition")[
Suppose $oo in P_Gamma$, let $phi.alt in C_c\(G\)$, $t > 0$, then $\|f * phi.alt\(g\)\|< <_phi.alt Im\(g i\)parallel f parallel_2$, $forall g in N A_t K$, $f in L^2\(Gamma without G\,omega\)$

]#label("|f*phi(g)|<<_phi Im(gi)|f|_2")
#proof(title: "Proof")[
Let $C subset.eq G$ be a compact subset such that $C^(- 1) = "Supp" phi.alt$, then #math.equation(block: true, numbering: none, $\|f * phi.alt\(g\)\|=\|integral_G f\(g x\)phi.alt\(x^(- 1)\)d x\|lt.eq parallel phi.alt parallel_oo integral_(g C)\|f\|$) Let $g in lambda mat(delim: "[", 1, x; 0, 1) mat(delim: "[", y^(1 / 2), 0; 0, y^(- 1 / 2)) K$, $y = Im\(g i\)> t$. Let $C_N subset.eq N$, $C_A subset A$ closed intervals such that $K C subset.eq C_N C_A K$ Then $g C subset.eq lambda mat(delim: "[", 1, x; 1, 1) y^(- 1 / 2) mat(delim: "[", y, 0; 0, 1) C_N C_A K = lambda y^(- 1 / 2) mat(delim: "[", 1, x; 1, 1)\(a d mat(delim: "[", y, 0; 0, 1) C_N\)mat(delim: "[", y, ; 0, 1) C_A K$. $a d mat(delim: "[", y, ; 0, 1) C_N$ scales $C_N$ by $y$, Need about $O\(g\)$ fundemantal domains to cover $g C$, $integral_(g C)\|f\|< < y integral_C\|f\|< < y parallel f parallel_1 < < y parallel f parallel_2$

Constant term: Suppose $oo in P_Gamma$, Let $Gamma_N = Gamma inter N = ⟨mat(delim: "[", 1, h; 0, 1)⟩ tilde.equiv bb(Z)$, Let $phi.alt$ be a left $Gamma_N$ invariant function on $G$ #math.equation(block: true, numbering: none, $phi.alt_B\(g\)= integral_(Gamma_N without N) phi.alt\(n g\)d n$) Then $phi.alt_B : N without G arrow.r bb(C)$. For other cusps corresponding to conjugates $U subset.eq P$ of $N subset.eq B$, similarly, define $phi.alt_P : U without G arrow.r bb(C)$

]
Fundamental estimate \[Borel-7.4\]

#statement("Lemma")[
Let $f in C^oo\(G\)$ be left $Gamma_N$ invariant, assume $oo in P_Gamma$, let $X_1\,dots.h.c\,X_4 in frak(g)$ be an $bb(R)$ basis, then $exists c > 0$ independent of $f$ #math.equation(block: true, numbering: none, $\|f\(g\)- f_B\(g\)\|lt.eq c\|Im\(g i\)\|^(- 1) sum_(j = 1)^4\|X_j f\|_B\(g\)\,forall g in G$)

]#label("Lemma for fundamental estimate")
#statement("Corollary")[
Any cusp form $phi.alt in cal(A)_0\(Gamma without G\,chi\,omega\)$ has rapid decay at all cusps. In particular, $\|phi.alt\|$ is bounded on $G$ and $phi.alt in L^2\(Gamma without G\,chi\,omega\)$

]#label("A_0 subseteq L^2")
#proof(title: "Proof")[
Reduce to show rapid decay at $oo in P_Gamma$, by assumption and Proposition #ref(label("phi moderate growth at all cusps <=> phi moderate growth on G"), supplement: none), $phi.alt\(g\)< < Im\(g i\)^lambda$ near $oo$ for some exponent $lambda in bb(R)$. Theorem #ref(label("Harish-Chandra theorem"), supplement: none) $arrow.r.double$ $D phi.alt\(g\)< < Im\(g i\)^lambda$ near $oo$, $forall D in U\(frak(g)_(bb(C))\)$, same bound for $\|D phi.alt\|_B$. Take $D = X_j$ in Lemma #ref(label("Lemma for fundamental estimate"), supplement: none), recall $phi.alt_B = 0$, get $phi.alt\(g\)< < Im\(g i\)^(lambda - 1) arrow.r.double$ same for $D phi.alt$ and $\|D phi.alt\|_B$ Repeatedly apply Lemma #ref(label("Lemma for fundamental estimate"), supplement: none) and Theorem #ref(label("Harish-Chandra theorem"), supplement: none), we get #math.equation(block: true, numbering: none, $phi.alt\(g\)< < Im\(g i\)^(lambda - 2)\,dots.h.c Im\(g i\)^(lambda - m)\,forall m > 0$) near $oo$, thus rapid decay

]
#statement("Definition", title: [$L^2$ cusp forms])[
$L_0^2\(Gamma without G\,chi\,omega\)$ is the set of $phi.alt in L^2\(Gamma without G\,chi\,omega\)$ such that for almost every $g$\(except for a measure zero set) and any unipotent $U subset.eq G$ with $Gamma inter U eq.not { 1 }$ $integral_(Gamma inter U without U) phi.alt\(u g\)d u = 0$

]
#statement("Corollary")[
Let $phi.alt in C_c^oo\(G\)$, then $exists c > 0$ such that forall $f in L_0^2\(Gamma without G\,chi\,omega\)$, $\|\(f * phi.alt\)\(g\)\|lt.eq c parallel f parallel_2$, for all $g in G$. Moreover, $f * phi.alt$ is rapidly decreasing near cusps

]#label("f in L_0^2, |f*g(g)|<=c|f|_2")
#proof(title: "Proof")[
Suffices to prove this near all cusps, reduce to $oo in P_Gamma$, by Proposition #ref(label("|f*phi(g)|<<_phi Im(gi)|f|_2"), supplement: none), $\|f * phi.alt\(g\)\|< < Im\(g i\)parallel f parallel_2$ for $g$ near $oo$ #math.equation(block: true, numbering: none, $\|D\(f * phi.alt\)\(g\)\|=\|f * D phi.alt\(g\)\|< < Im\(g i\)parallel f parallel_2\,forall D in U\(frak(g)_(bb(C))\)$) Same for $\|D\(f * phi.alt\)\(g\)\|_B$. By assumption $\(f * phi.alt\)_B = f_B * phi.alt = 0$. Apply Lemma #ref(label("Lemma for fundamental estimate"), supplement: none) repeatedly $arrow.r.double f * phi.alt$ decrease rapidly at $oo$

]
#proof(title: "proof of lemma ")[
Fix $g in G$, let #math.equation(block: true, numbering: none, $phi.alt\(t\)= f\(g\)- f (mat(delim: "[", 1, t; 0, 1) g)$) then $phi.alt in C^oo\(bb(R)\)$, $phi.alt\(0\)= 0$, $integral_0^1 phi.alt d t = f\(g\)- f_B\(g\)$, $\|phi.alt\(t\)\|lt.eq integral_0^1\|phi.alt'\|d s$, $\|f\(g\)- f_B\(g\)\|lt.eq integral_0^1\|phi.alt\|d t lt.eq integral_0^1\|phi.alt'\|d t$ Write $g = lambda mat(delim: "[", 1, x; 0, 1) mat(delim: "[", y^(1 / 2), 0; 0, y^(- 1 / 2)) k$, $k in K$ #math.equation(block: true, numbering: none, $mat(delim: "[", 1, t + h; 0, 1) g & = mat(delim: "[", 1, t; 0, 1) g g^(- 1) mat(delim: "[", 1, h; 0, 1) g\
 & = mat(delim: "[", 1, t; 0, 1) g k^(- 1) mat(delim: "[", 1, h\/y; 0, 1) k\
 & = mat(delim: "[", 1, t; 0, 1) g exp\(h "ad"\(k\)^(- 1)\(y^(- 1) E\)\)$) $E = mat(delim: "[", 0, 1; 0, 0)$. Write $"ad"\(k\)^(- 1) E = sum_(j = 1)^4 a_j\(k\)X_j$, $a_j : K arrow.r bb(R)$ are continuous and bounded #math.equation(block: true, numbering: none, $\|phi.alt'\(t\)\| & = lr(|y^(- 1) sum_(j = 1)^4 a_j \( k \) \( X_j f \) (mat(delim: "[", 1, t; 0, 1) g)|)\
 & lt.eq c y^(- 1) sum_(j = 1)^4 lr(|X_j f (mat(delim: "[", 1, t; 0, 1) g)|)$) $c = max_(j\,k)\|a_j\(k\)\|$ is independent of $f$ #math.equation(block: true, numbering: none, $\|f\(g\)- f_B\(g\)\|lt.eq integral_0^1\|phi.alt'\(t\)\|d t lt.eq c y^(- 1) sum_(j = 1)^4\|X_f\|_B\(g\)$)

]

#pagebreak()

= Cuspidal spectrum

$chi : Gamma arrow.r bb(C)^times$, $omega : Z_G arrow.r bb(C)^times$ are unitary charaterss that agree on $Z_Gamma = Gamma inter Z_G$

#statement("Proposition")[
$L_0^2\(Gamma without G\,chi\,omega\)$ is closed in $L^2\(Gamma without G\,chi\,omega\)$ \[Borel, 8.2\]

]
#proof(title: "Proof")[
Suppose $oo in P_Gamma$, $forall phi.alt in C_c^oo\(N without G\)$, let #math.equation(block: true, numbering: none, $lambda_(B\,phi.alt)\(f\)= integral_(Gamma_N without G) f\(x\)phi.alt\(x\)d x$) Then #math.equation(block: true, numbering: none, $lambda_(B\,phi.alt)\(f\)= integral_(N without G) phi.alt\(x\)(integral_(Gamma_N without) f \( n x \) d x) d x = integral_(N without G) phi.alt\(x\)f_B\(x\)d x$) $f_B = 0 arrow.l.r.double lambda_(B\,phi.alt)\(f\)= 0$, $forall phi.alt$ $arrow.r.double$ $L_0^2 = inter.big_(P\,phi.alt) ker lambda_(P\,phi.alt)$, it suffices to show $lambda_(P\,phi.alt)$ is continuous. $exists$ compact set $E subset.eq G$ such that $"Supp"\(phi.alt\)subset.eq Gamma_N E arrow.r.double\|lambda_(P\,phi.alt)\|lt.eq parallel phi.alt parallel_oo integral_E\|f\|< < parallel f parallel_2$

]
So $L_0^2\(Gamma without G\,chi\,omega\)$ is a Hilbert space. Corollary #ref(label("A_0 subseteq L^2"), supplement: none) $arrow.r.double$ $cal(A)_0\(Gamma without G\,chi\,omega\)subset.eq L_0^2\(Gamma without G\,chi\,omega\)$

#statement("Definition", title: [convolution operator])[
$phi.alt in C_c^oo\(G\)$, $f in L^2\(Gamma without G\,chi\,omega\)$, $\(r_phi.alt f\)\(g\)= integral_G f\(g h\)phi.alt\(h\)d h = f * phi.alt^or$, $phi.alt^or\(x\)= phi.alt\(x^(- 1)\)$. $r_phi.alt f in C^oo inter L^2$. If $f in L_0^2$, then $r_phi.alt f in C^oo inter L_0^2$ since #math.equation(block: true, numbering: none, $integral_(Gamma inter U without U)\(r_phi.alt f\)\(u g\)d u = integral_G integral_(Gamma inter U without inter U) f\(u g h\)phi.alt\(h\)d u d h = integral_G f_B\(g h\)phi.alt\(h\)d h = 0$) So $r_phi.alt$ preserves the subspace $L_0^2$, moreover, Corollary #ref(label("f in L_0^2, |f*g(g)|<=c|f|_2"), supplement: none) $arrow.r.double$ $r_phi.alt f$ has rapid decay at all cusps if $f in L_0^2$

]
Recall: $L$ is a bounded linear operator on Hilbert space $H$

+ $L$ is #emph[compact] if maps bounded sets to precompact sets. $L$ is compact $arrow.l.r.double$ $L$ is the limit of finite rank operators

+ $L$ is #emph[Hilbert-Schmidt] if $H$ is separable and for any orthonormal basis ${ e_i }$, $sum\(L e_i . L e_i\)$ is finite. Hilbert-Schmidt operators are compact

+ $L$ is self-adjoint if $\(L v\,w\)=\(v\,L w\)\,forall v\,w in H$

#statement("Proposition")[
For any $phi.alt in C_c^oo\(G\)$, $r_phi.alt : L_0^2 arrow.r L_0^2$ is a Hilbert-Schmidt operator, hence a compact operator

]#label("r_phi:L_0^2->L_0^2 is Hilbert-Schmidt")
#proof(title: "Borel 9.5")[
, Corollary #ref(label("f in L_0^2, |f*g(g)|<=c|f|_2"), supplement: none), $\|\(r_phi.alt f\)\(x\)\|lt.eq c parallel f parallel_2\,forall x in G$, $f mapsto r_phi.alt f$ is a continuous linear functional on $L_0^2$ #math.equation(block: true, numbering: none, $r_phi.alt f\(x\)=\(f\,K_x\)= integral_(Gamma without G\/Z_G) f\(y\)overline(K_x\(y\)) d y$) for some $K_x in L_0^2$, $\(K_x\,K_x\)= r_phi.alt K_x\(x\)lt.eq c parallel K_x parallel_2$, thus $parallel K_x parallel_2 lt.eq c$. Let $K\(x\,y\)= overline(K_x\(y\))$, then $\|K\(x\,y\)\|in L^2\(Gamma without G\/Z_G times Gamma without G\/Z_G\)$ and $arrow.r.double$ $r_phi.alt$ is Hilbert-Schmidt \[Bump Theorem 2.3.2\]

]
#statement("Remark")[
Combined with Dixmier-Malliavin theorem (any $phi.alt in C_c^oo\(G\)$ is a finite linear combination of convolutions $alpha * beta$, $alpha\,beta in C_c^oo\(G\)$), one deduce that $r_phi.alt$ is of trace class on $L_0^2$, so $"Tr"\(r_phi.alt\)= integral K\(x\,x\)d x < oo$. However, its kernel $K\(x\,y\)$ is not explicit in general. When $Gamma without cal(H)$ is compact, $L_0^2 = L^2$ and $K\(x\,y\)$ coincides with the explicit naive kernel (see \[Bump prop 2.3.1\]) #math.equation(block: true, numbering: none, $K^(upright("naive"))\(x\,y\)= integral_(Z_G) sum_(gamma in Gamma) chi\(gamma\)phi.alt\(x^(- 1) gamma y u\)omega\(u\)d u$) Then $"Tr"\(r_phi.alt\)= integral_(Gamma without G\/Z_G) K^(upright("naive"))\(x\,x\)d x =$ explicit expression involving conjugacy classes of $Gamma$. In general, when there are cusps, the naive kernel is not $L^2$, so $r_phi.alt$ is not compact on $L^2$, $r_phi.alt\|_(L_0^2)$ suffices for the purpose of spectral decomposition of $L_0^2$. To get formula for $"Tr"\(r_phi.alt\|L_0^2\)$, need to truncate the explicit naive kernel. As comparison, nonzero convolution operators on $L^2\(bb(R)\)$ are never compact. $L^2\(bb(R)\)$ does not have irreducible subrepresentations of $bb(R)$, but decompose into direct integrals of $bb(R)$-irreducible representations

]
#statement("Theorem")[
Let $T$ be a compact self-adjoint operator on a separable Hilbert space $H$, then $H$ has an orthonomral basis ${ phi.alt_i }$ consisting of eigenvectors of $T$, $T phi.alt_i = lambda_i phi.alt_i$. If $dim H = oo$, then $lambda_i arrow.r 0$. In particular, if $lambda eq.not 0$ is an eigenvalue of $T$, then the $lambda$-eigentsapce is finite dimensional. See \[Bump Theorem 2.3.1\]

]#label("Theorem on compact operators on Hilbert spaces")
#statement("Lemma")[
$phi.alt in C_c^oo\(G\)$

+ If $phi.alt\(g\)= overline(r\(g^(- 1)\))$, $forall g in G$, then $r_phi.alt$ is self-adjoint

+ If $phi.alt\(k_theta g\)= e^(i m theta) phi.alt\(g\)$, then $r_phi.alt\(L^2\)subset.eq C^oo\(\,m\)= { f in C^oo\|f\(g k_theta\)= e^(i m theta) f\(g\)}$

]
#proof(title: "Proof")[

]
#statement("Definition")[
A representation of $G$ on a Hilbert space $H$ is a homomorphism $rho : G arrow.r "End"\(H\)$ such that $G times H arrow.r H$ is continuous $rho$ is irreducible if there is no nonzero proper #underline[closed] $G$-invariant subspace of $H$ #math.equation(block: true, numbering: none, $H\(m\)= { v in H\|rho\(k\)v = chi_m\(k\)v\,forall k in K }$) Stone-Weierstrass $arrow.r.double H = hat(xor.big_(m in bb(Z))) H\(m\)$, see \[Bump Exercise 2.1.5\] $rho$ is admissible if $dim H\(m\)< oo\,forall m in bb(Z)$. $phi.alt in C_c\(G\)$, $rho\(phi.alt\)v = integral_G phi.alt\(g\)rho\(g\)v d g$, $forall v in H$, this is the unique element in $H$ such that #math.equation(block: true, numbering: none, $\(rho\(phi.alt\)v\,w\)= integral_G phi.alt\(g\)\(rho\(g\)\,w\)d g$) If $phi.alt\(g\)= overline(phi.alt\(g^(- 1)\))$, then $rho\(phi.alt\)$ is self-adjoint

]
#statement("Lemma")[
$rho$ is a unitary representation of $G$ on a Hilbert space $H$, let $0 eq.not v in H$, $epsilon.alt > 0$, then $exists phi.alt in C_c^oo\(G\)$ such that $rho\(phi.alt\)$ is self-adjoint and $\|rho\(phi.alt\)v - v\|< epsilon.alt$. In particular, if $\|v\|> epsilon.alt$, this implies $rho\(phi.alt\)v eq.not 0$. Moreover, if $v in H\(m\)$, we may choose $phi.alt in C_c^oo\(K without G\/K\,m\)$, i.e. $phi.alt\(k_theta g\)= phi.alt\(g k_theta\)= e^(- i m theta) phi.alt\(g\)$, $forall g in G\,theta in bb(R)$. If $dim H\(m\)< oo$, then $exists phi.alt in C_c^oo\(K without G\/K\,m\)$ such that $rho\(phi.alt\)v = v$

]#label("rho(phi)v=v")
#proof(title: "Bump Lemma 2.3.2")[
. Use continuity of the map $G arrow.r H$, $g mapsto rho\(g\)v$ to find $phi.alt$, replace $phi.alt$ by $phi.alt\(g\)+ overline(phi.alt\(g^(- 1)\))$ to make it self-adjoint. Suppose $v in H\(m\)$. May assume $phi.alt$ is $K$-conjugation invariant by averaging over $K$. Let #math.equation(block: true, numbering: none, $tilde(phi.alt)\(g\)= integral_0^(2 pi) e^(i m theta) phi.alt\(k_theta g\)frac(d theta, 2 pi)$) $phi.alt$ is self-adjoint, $K$-conjugation invariant $arrow.r.double$ $tilde(phi.alt) in C_c^oo\(K without G\/K\,m\)$ is self-adjoint and $rho\(tilde(phi.alt)\)v = rho\(phi.alt\)v$. Have shown $v in overline(rho\(C_c^oo\(K without G\/K\,m\)\)dot.op v)$. If $dim H\(m\)< oo$, then deduce $v in rho\(C_c^oo\(K without G\/K\,m\)\)dot.op v$

]
#statement("Theorem")[
The right regular representation of $g$ on $L_0^2$ decompose into Hilbert space direact sum of irreducible representations of $G$

]
#proof(title: "Proof")[
By Zorn's lemma, suffice to show that for any closed $G$ invariant subspace $0 eq.not H lt.eq L_0^2$, $H$ contains an irreducible subrepresentation of $G$. Let $0 eq.not f in H$, $exists phi.alt in C_c^oo\(G\)$ such that $r_phi.alt$ is self-adjoint and $r_phi.alt f eq.not 0$, by Proposition #ref(label("r_phi:L_0^2->L_0^2 is Hilbert-Schmidt"), supplement: none), $r_phi.alt$ is compact, by Theorem #ref(label("Theorem on compact operators on Hilbert spaces"), supplement: none), $r_phi.alt$ has a nonzero eigenvaule $alpha$ with finite dim eigenspace $L lt.eq H$. Let $L_0$ be a minimal element of the set #math.equation(block: true, numbering: none, ${ 0 eq.not L inter W\|W lt.eq H upright(" closed ") G upright(" invaraint") }$) $V = inter.big_(W lt.eq H\,W inter L = L_0) W$, show $V$ is irreducible. Supoose $V = V_1 xor V_2$, $0 eq.not f_0 in L_0 subset.eq V$, write $f_0 = f_1 + f_2$, supose $f_1 eq.not 0$ #math.equation(block: true, numbering: none, $\(r_phi.alt f_1 - lambda f_1\)+\(r_phi.alt f_2 - lambda f_2\)=\(r_phi.alt f_0 - lambda f_0\)= 0$) Thus $r_phi.alt f_1 = lambda f_i$, $0 eq.not f_1 in L inter V_1 lt.eq L_0$, by the minimality of $L_0$, $L inter V_1 = V_0$, $V_1 = V$ by the definition of $V$

]
Next analyze structure of irreducible representations in $L_0^2$. $forall m in bb(Z)$, let $E_m = chi_m\(k\)^(- 1) d k$, $chi (mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)) = e^(i m theta)$, $d k = frac(d theta, 2 pi)$ is the Haar measure on $K$ \ For any representation of $G$ on Hilbert space $H$, $E_m v = integral_K chi_m\(k\)^(- 1) k dot.op v d k$. $E_m\(H\)= H\(m\)$ is the idempotent projection to $H\(m\)$. $forall phi.alt in C_c^oo\(G\)$, #math.equation(block: true, numbering: none, $phi.alt * E_m\(g\)= integral_K phi.alt\(g k\)chi_m\(k\)d k$) #math.equation(block: true, numbering: none, $E_m * phi.alt\(g\)= integral_K chi_m\(k\)phi.alt\(k g\)d k$) Hence $E_m * C_c^oo\(G\)* E_m = C_c^oo\(K without G\/K\,m\)= { phi.alt in C_c^oo\(G\)\,phi.alt\(k g\)= phi.alt\(g k\)= chi_m\(k\)^(- 1) phi.alt\(g\)}$

#statement("Lemma")[
The convolution algebra $C_c^oo\(K without G\/K\,m\)$ is commutative

]#label("C_c^infty(K G /K,m) is commutative")
#proof(title: "Proof")[
\(Gelfond trick): Consider involution $iota : mat(delim: "[", a, b; c, d) mapsto mat(delim: "[", a, - c; - b, d)$, then $iota$ acts as identity on $K\,A$. Gauss decomposition: $G = K A K arrow.r.double$ $iota$ acts by identity on $C_c^oo\(K without G\/K\,m\)arrow.r.double phi.alt_1 * phi.alt_2 = iota\(phi.alt_1 * phi.alt_2\)= iota\(phi.alt_2\)* iota\(phi.alt_1\)= phi.alt_2 * phi.alt_1$

]
#statement("Proposition")[
Let $H subset.eq L_0^2\(Gamma without G\,chi\,omega\)$ be an irreducible $G$-subrepresentation, then $dim H\(m\)lt.eq 1$, $forall m in bb(Z)$. In particular, $H$ is admissible

]#label("H<=L_0^2 irreducible, then dim H(m)<=1")
#proof(title: "Proof")[
Suppose $0 eq.not v in H\(m\)$. By Lemma #ref(label("rho(phi)v=v"), supplement: none), $exists phi.alt in C_c^oo\(K without G\/K\,m\)$ self-adjoint, $r_phi.alt\(v\)eq.not 0$. Moreover, $r_phi.alt$ is compact by Proposition #ref(label("r_phi:L_0^2->L_0^2 is Hilbert-Schmidt"), supplement: none). So by Theorem #ref(label("Theorem on compact operators on Hilbert spaces"), supplement: none), $r_phi.alt$ has an eigenspace $V subset.eq H\(m\)$ with eigenvalue $lambda > 0$, $V eq.not 0$ and $dim V < oo$. Since $C_c^oo\(K without G\/K\,m\)$ is commutative by Lemma #ref(label("C_c^infty(K G /K,m) is commutative"), supplement: none), $exists$ one dimension subspace $L lt.eq V$ preserved by $C_c^oo\(K without G\/K\,m\)$. If $L eq.not H\(m\)$, let $w in H\(m\)$ be orthogonal to $L$, $W = overline(C_c^oo\(G\)w)$, $W$ is $G$-invariant closed subspace of $H$ (easy to see). $forall phi.alt in C_c^oo\(G\)$, $v in L$, we have #math.equation(block: true, numbering: none, $chevron.l r_phi.alt w\,v chevron.r = chevron.l r_phi.alt w\,E_m v chevron.r = chevron.l w\,r_(tilde(phi.alt) * E_m) v chevron.r = chevron.l w\,r_(E_m * tilde(phi.alt) * E_m) v chevron.r$) where $tilde(phi.alt)\(g\)= overline(phi.alt\(g^(- 1)\))$ and we used that

+ $v\,w in H\(m\)$

+ $E_m$ is self-adjoint

+ $r_(tilde(phi.alt))$ is the adjoint of $r_phi.alt$

Since $E_m tilde(phi.alt) * E_m in C_c^oo\(K without G\/K\,m\)$, $r_(E_m * tilde(phi.alt) * E_m)\(v\)in L$ $arrow.r.double chevron.l r_phi.alt w\,v chevron.r = 0$ $arrow.r.double W perp L$ $arrow.r.double 0 eq.not W lt.eq H$ is a proper subrepresentation, contradiction. Hene $L = H\(m\)$ and $dim H\(m\)= 1$

]
Denote $H_(upright(f i n)) = xor.big_(m in bb(Z)) H\(m\)$, the space of $K$-finite vectors. $H_(upright(f i n))$ is dense in $H$ by Stone-Weierstrass

#statement("Theorem")[
Let $0 eq.not H subset.eq L_0^2\(Gamma without G\,chi\,omega\)$ be an irreducible $G$-representation. Then $H_(upright(f i n))$ is an irreducible admissible $\(frak(g)\,K\)$-submodule of $cal(A)_0\(Gamma without G\,chi\,omega\)$. Moreover, the multiplicity space $"Hom"_G\(H\,L_0^2\)$ is finite dimensional

]
#proof(title: "Proof")[
Let $0 eq.not f in H\(m\)$, then $dim H\(m\)= 1$ by Proposition #ref(label("H<=L_0^2 irreducible, then dim H(m)<=1"), supplement: none). By Lemma #ref(label("rho(phi)v=v"), supplement: none), $exists phi.alt in C_c^oo\(K without G\/K\,m\)$ such that $r_phi.alt f = f$ $arrow.r.double f in C^oo\(Gamma without G\,chi\,omega\)inter H\(m\)$ has moderate growth by Proposition #ref(label("phi moderate growth at all cusps <=> phi moderate growth on G"), supplement: none) and Corollary #ref(label("f in L_0^2, |f*g(g)|<=c|f|_2"), supplement: none). So #math.equation(block: true, numbering: none, $H_(upright(f i n)) = xor.big_(m in bb(Z)) H\(m\)subset.eq C^oo\(Gamma without\,chi\,omega\)$) In particular, $H_(upright(f i n))$ is a $\(frak(g)\,K\)$-module. It is irreducible since $H$ is irreducible $G$-representation. By Lemma #ref(label("Schur's lemma"), supplement: none), $Z_(frak(g))$ acts as scalar on $H_(upright(f i n)) arrow.r.double H_(upright(f i n)) subset.eq cal(A)_0\(Gamma without G\,chi\,omega\)$. $forall T in "Hom"_G\(H\,L_0^2\)$, $r_phi.alt T f = T r_phi.alt f = T f arrow.r.double T f$ lies in 1-eigenspace of the compact operator $r_phi.alt$, by Theorem #ref(label("Theorem on compact operators on Hilbert spaces"), supplement: none), this eigenspace is finite dimensional. Since $H$ is irreducible, $T$ is determined by $T f$, we get $dim "Hom"_G\(H\,L_0^2\)< oo$

]
#statement("Lemma")[
For all irreducible $G$ subrepresentation $0 eq.not H subset.eq L_0^2\(Gamma without G\,chi\,omega\)$, we have $"Hom"_G\(H\,L_0^2\)= "Hom"_(\(frak(g)\,K\))\(H_(upright(f i n))\,cal(A)_0\)$

]
#proof(title: "Proof")[
Let $0 eq.not T in "Hom"_(\(frak(g)\,K\))\(H_(upright(f i n))\,cal(A)_0\)$, Lemma #ref(label("Schur's lemma"), supplement: none) $arrow.r.double\(T v\,T w\)= c\(v\,w\)$ for some $c > 0$ $arrow.r.double$ $T$ can be extended to a bounded linear operator $tilde(T) : H arrow.r L_0^2\(Gamma without\,chi\,omega\)$. Remains to show $tilde(T)$ is $G$ equivariant. Suffices to show $forall v in H_(upright(f i n))$, $f in L_0^2$, $\(tilde(T) g v\,f\)=\(r_g tilde(T) v\,f\)$. Both sides are $Z_(frak(g))$-finite, $K$-finite functions on $G$. By Lemma #ref(label("f is Z_g finite and K finite, then f is real analytic"), supplement: none), they are analytic. Their derivatives agree since $T$ is $U frak(g)_(bb(C))$ equivariant. They agree at $g = 1$ $arrow.r.double$ they agree on $G$ since $G$ is connected

]
In particular, if $H_1\,H_2$ are irreducible summands of $L_0^2$ and $H_(1\,upright(f i n)) tilde.equiv H_(2\,upright(f i n))$ as $\(frak(g)\,K\)$-module, then $H_1 tilde.equiv H_2$ (This is true for any irreducible unitary representation of $G$)

#statement("Corollary")[
$cal(A)_0\(Gamma without G\,chi\,omega\)$ decomposes into direct sum of irreducible admissible (unitary) $\(frak(g)\,K\)$-modules with finite multiplicities. Each irreducible summand has the form $H_(upright(f i n))$ for some irreducible $G$ subrepresentation $H subset.eq L_0^2\(Gamma without G\,chi\,omega\)$ and $dim "Hom"_(frak(g)\,K)\(H_(upright(f i n))\,cal(A)_0\)= dim_G\(H\,L_0^2\)< oo$

]#label("A_0 decomposes into direct sum of irreducible admissible (g,K) modules with finite multiplicities")
#statement("Fact")[
There are finitely many non-isomorphic irreducible $\(frak(g)\,K\)$-module with given infinitesimal and central character

]
Granting this, we get

#statement("Corollary")[
Let $I subset.eq Z_(frak(g))$ be an ideal of finite codimension. Then $cal(A)_0\(Gamma without G\,chi\,omega\)\[I\]$ is admissible. (This proves the special case of Theorem #ref(label("Another theorem of Harish-Chandra"), supplement: none))

]
Summary: #math.equation(block: true, numbering: none, $xor.big_H xor.big_(m in bb(Z)) H\(m\)= cal(A)_0\(Gamma without G\,chi\,omega\)subset.eq_(upright("dense")) L_0^2\(Gamma without G\,chi\,omega\)= hat(xor.big)_(0 eq.not H lt.eq L_0^2 upright(" irreducible ") G upright(" rep")) hat(xor.big) H\(m\)$) Thus first sum in $cal(A)_0$ is algebraic by $Z_(frak(g))$-finiteness, the finiteness of multiplicities and the fact stated above


#pagebreak()

= Representations of $"GL"\(2\,bb(R)\)$

In this section, we adopt the following notation:

- $G = "GL"_2\(bb(R)\)^(+)$, $K = "SO"\(2\)$, $frak(g) = frak(g l)_2\(bb(R)\)$, ${ W\,R\,L\,Z }$ is a basis for $frak(g)_(bb(C))$

- $V$ is an irreducible admissible $\(frak(g)\,K\)$-module, then recall we have #math.equation(block: true, numbering: none, $V = xor.big_(m in bb(Z)) V\(m\)\,quad V\(m\)= { v in V\|W v = m v } = { v in V\|k v = chi_m\(k\)v\,forall k in K }$) $Sigma = { m in bb(Z)\|V\(m\)eq.not 0 }$ is the set of $K$-types

Recall

+ $Delta = - 1 / 4\(W^2 + 2 R L + 2 L R\)= - L R - W / 2\(1 + W / 2\)= - R L + W / 2\(1 - W / 2\)$

+ $R V\(m\)subset.eq V\(m + 2\)$, $L V\(m\)subset.eq V\(m - 2\)$

+ $U frak(g)_(bb(C)) = xor.big_(i > 0) R^i A xor xor.big_(i gt.eq 0) L^i A$, $A$ is the subalgebra generated by $W$ and $Z_(frak(g)) = bb(C)\[Z\,Delta\]$

We deduce

+ $forall 0 eq.not x in V\(m\)$, $V = bb(C) x xor xor.big_(n > 0) bb(C) R^n x xor xor.big_(n > 0) bb(C) L^n x$

+ $dim V\(m\)lt.eq 1$, $Sigma$ has same parity

+ Let $lambda$ be the eigenvalue of $Delta$ on $V$, then $forall x in V\(m\)$, $L R x =\(- lambda - m / 2\(1 + m / 2\)\)x$, $R L x =\(- lambda + m / 2\(1 - m / 2\)\)x$. If $x eq.not 0\,R x = 0$, then $lambda = - m / 2\(1 + m / 2\)$, If $x eq.not 0\,L x = 0$, then $lambda = m / 2\(1 - m / 2\)$

+ Suppose $lambda = n / 2\(1 - n / 2\)$, $n in bb(Z)$, $0 eq.not x in V\(m\)$. If $R x = 0$, then $n / 2\(1 - n / 2\)= - m / 2\(1 + m / 2\)$ $arrow.r.double$ $m = - n$ or $m = n - 2$ If $L x = 0$, then $n / 2\(1 - n / 2\)= m / 2\(1 - m / 2\)$ $arrow.r.double$ $m = n$ or $m = 2 - n$

Consequence: irreducible admissible $\(g\,K\)$ moduels are uniquely determined by infinitesimal character and $K$-types \[Bump, Thm2.5.1,2.5.2\]

Classification: Fix eigenvalue $lambda$ of $Delta$, $mu$ of $Z$, parity $epsilon.alt in { 0\,1 }$

+ If $lambda in.not { n / 2\(1 - n / 2\)\|n equiv epsilon.alt #h(0.444em) mod med 2 }$, then $Sigma = epsilon.alt + 2 bb(Z)$

+ If $lambda = n / 2\(1 - n / 2\)$ for $n in bb(Z)_(n gt.eq 1)$, $n equiv epsilon.alt #h(0.444em) mod med 2$. Then there are 3 possibilities: $Sigma^(+)\(n\)= n + 2 bb(Z)_(gt.eq 0)$, $Sigma^(-)\(n\)= - n - 2 bb(Z)_(gt.eq 0)$, $Sigma^0\(n\)= { n - 2\,dots.h.c\,2 - n }$

Parabolic induction: $B = N A subset.eq G$ standard Borel, $chi : A arrow.r bb(C)^times$ be a quasi-character(a group homomorphism), also viewed as $B arrow.r bb(C)^times$ #math.equation(block: true, numbering: none, $"Ind"_B^G\(chi\)= { f in C^oo\(G\)\|f\(b g\)= chi\(b\)f\(g\)\)\,forall b in B\,g in G }$) inner product $chevron.l f_1\,f_2 chevron.r = integral_K f_1\(k\)overline(f_2\(k\)) d k$. Let $H_chi$ be the Hilbert space completion of $"Ind"_B^G chi$, this a representation of $G$ induced by right regular action on $C^oo\(G\)$. (Have to check $chevron.l r_g f\,r_g f chevron.r lt.eq c chevron.l f\,f chevron.r$, $forall f in "Ind"_B^G chi$, so $r_g$ is a bounded operator on $H_chi$). We have a $G$-equivariant map #math.equation(block: true, numbering: none, $"Ind"_B^G chi_1 times "Ind"_B^G chi_2 & arrow.r "Ind"_B^G chi_1 chi_2\
\(f_1\,f_2\) & mapsto f_1 f_2$) Let $delta : A arrow.r bb(C)^times$, $delta (mat(delim: "[", a_1, 0; 0, a_2)) = a_1 / a_2$, there exists a nonzero $G$-equivariant bounded linear functional #math.equation(block: true, numbering: none, $"Ind"_B^G delta arrow.r bb(C)\,f mapsto integral_K f\(k\)d k$) Inducing $G$-equivariant pairing $"Ind"_B^G chi delta^(1 / 2) times "Ind"_B^G chi^(- 1) delta^(1 / 2) arrow.r bb(C)$

#statement("Definition")[
normalized induction $i_B^G chi = "Ind"_B^G chi delta^(1 / 2)$. So $i_B^G chi$ is unitary with $G$-invariant product. When $chi$ is unitary, $chi^(- 1) = macron(chi)$, so $i_B^G chi$ is unitary with $G$-invariant inner product $chevron.l f_1\,f_2 chevron.r = integral_K f_1\(k\)accent(f_2\(k\), ‾) d k$

]
If $s_1\,s_2 in bb(C)$, $epsilon.alt in { 0\,1 }$, and $chi$ is defined by $chi (mat(delim: "[", a_1, 0; 0, a_2)) =\|a_1\|^(s_1)\|a_2\|^(s_2) "sgn"\(a_1\)^epsilon.alt$, recall $a_1 a_2 > 0$, deonte $H^oo\(s_1\,s_2\,epsilon.alt\)= i_B^G chi$, $H\(s_1\,s_2\,epsilon.alt\)$ its Hilbert space completion. Denote $s = 1 / 2\(s_1 - s_2 + 1\)$. Note $forall f in H^oo\(s_1\,s_2\,epsilon.alt\)$, $f\(- g\)=\(- 1\)^epsilon.alt f\(g\)$. $forall m in epsilon.alt + 2 bb(Z)$, there is a unique $f_m in H^oo\(s_1\,s_2\,epsilon.alt\)$ such that #math.equation(block: true, numbering: none, $f_m (u mat(delim: "[", 1, x; 0, 1) mat(delim: "[", y^(1 / 2), 0; 0, y^(- 1 / 2)) mat(delim: "[", cos theta, sin theta; - sin theta, cos theta)) = u^(s_1 + s_2) y^s e^(i m theta)$) $H\(s_1\,s_2\,epsilon.alt\)_(upright(f i n)) = xor.big_(m + in epsilon.alt + 2 bb(Z)) bb(C) f_m$, $\(frak(g)\,K\)$-modules of $H\(s_1\,s_2\,epsilon.alt\)$ \ Use formulas in HW1, one calculates #math.equation(block: true, numbering: none, $W f_m = m dot.op f_m\,R f_m =\(s + m / 2\)f_(m + 2)\,L f_m =\(s - m / 2\)f_(m - 2)$) #math.equation(block: true, numbering: none, $Delta f_m = lambda f_m\,Z f_m = mu f_m$) where $lambda = s\(1 - s\)$, $mu = s_1 + s_2$, $s = 1 / 2\(s_1 - s_2 + 1\)$ \ From this we get

+ If $s in.not epsilon.alt / 2 + bb(Z)$, then $H\(s_1\,s_2\,epsilon.alt\)$ is irreducible. Denote its $\(frak(g)\,K\)$-module by $P_mu\(lambda\,epsilon.alt\)$, principal series

+ If $s = n / 2$, $n in epsilon.alt + 2 bb(Z)$, $n gt.eq 1$, then $H\(s_1\,s_2\,epsilon.alt\)$ has two irreducible subrepresentations #math.equation(block: true, numbering: none, $H_(+) = hat(xor.big_(m gt.eq n)) bb(C) f_m\,H_(-) = hat(xor.big_(m lt.eq - n)) bb(C) f_m$) denote these $\(frak(g)\,K\)$-modules by $D_mu^(+)\(n\)$, $D_mu^(-)\(n\)$, and the set of $K$-types are $Sigma^(+)\(n\)= n + 2 bb(Z)_(gt.eq 0)$, $Sigma^(-)\(n\)= - n - 2 bb(Z)_(gt.eq 0)$. The quotient $H\/H^(+) xor H^(-)$ is a finite dimensional $G$ representation (0 if $n = 1$) with $K$-types $Sigma^0\(n\)= { m in n + 2 bb(Z)\|2 - n lt.eq m lt.eq n - 2 }$

+ If $s = 1 - n / 2$, $n in epsilon.alt + 2 bb(Z)$, $n > 1$, then $H\(s_1\,s_2\,epsilon.alt\)$ has a finite dimensional irreducible subrepresentation $H^0 = xor.big_(2 - n lt.eq m lt.eq n - 2\,m equiv n #h(0.444em) mod med 2) bb(C) f_m$ with set of $K$-type $Sigma^0\(n\)$. $H\/H^0 = H^(+) xor H^(-)$ with $\(frak(g)\,K\)$-module $D_mu^(+)\(n\)xor D_mu^(-)\(n\)$

$D_mu^plus.minus\(n\)\,n gt.eq 2$ are called #emph[discrete series]. The limit of discrete series $D_mu^plus.minus\(1\)\,D_mu^plus.minus\(2\)$ are called #emph[Steinberg representations] #math.equation(block: true, numbering: none, $\("Ind"_B^G 1\)_(upright(f i n))\/bb(C) tilde.equiv D^(+)\(2\)xor D^(-)\(2\)$) where $mu = 0$ \ Irreducible unitary representations

+ Unitary principal series: $P_mu\(lambda\,epsilon.alt\)= H\(s_1\,s_2\,epsilon.alt\)$, $s_1\,s_2 in i bb(R)$, $s = 1 / 2\(s_1 - s_2 + 1\)in 1 / 2 + i bb(R)$, $mu = s_1 + s_2 in i bb(R)$, $lambda = s\(1 - s\)in\[1 / 4\,+ oo\)$, $epsilon.alt in { 0\,1 }$. And if $s = 1 / 2$, we require $epsilon.alt = 0$

+ Complementary series: $P_mu\(lambda\,0\)$, $mu in i bb(R)$, $0 < lambda < 1 / 4$, $s in\(0\,1\)$

+ Discrete series: $D_mu^plus.minus\(n\)$, $n in bb(Z)_(gt.eq 2)$, $mu in i bb(R)$, $lambda = n / 2\(1 - n / 2\)$

+ Limit of discrete series: $D_mu^plus.minus\(1\)$, $n in bb(Z)_(gt.eq 2)$, $mu in i bb(R)$, $s = 1 / 2$, $lambda = 1 / 4$, unitary since $D_mu^(+)\(1\)xor D_mu^(-)\(1\)tilde.equiv H\(mu / 2\,mu / 2\,1\)$

+ One dimensional representations: $g mapsto\(det g\)^(mu / 2)$, $mu in i bb(R)$

Among these, 1,3,4 are tempered. 3 is square integrable. Recall tempered/square integrable means one (equivalently any) nonzero matrix coefficient belong to $L^(2 + epsilon.alt)\(G\/Z_G\,omega\)$, $forall epsilon.alt > 0$/$L^2\(G\/Z_G\,omega\)$, $omega$ is an unitary central character. In particular, discrete series are subrepresentations of right regular $G$ representation on $L^2\(G\/Z_G\,omega\)$ \ Alternative realization of $H\(s_1\,s_2\,epsilon.alt\)$ (restricted to $"SL"_2\(bb(R)\)= G_1$). Recall $N without "SL"_2\(bb(R)\)tilde.equiv bb(R)^2\\{\(0\,0\)}$, $N dot.op mat(delim: "[", a, b; c, d) mapsto\(c\,d\)$ #math.equation(block: true, numbering: none, $H^oo\(s_1\,s_2\,epsilon.alt\)tilde.equiv { f in C^oo\(bb(R)^2 - {\(0\,0\)}\)\|f\(lambda x_1\,lambda x_2\)= "sgn"\(lambda\)^epsilon.alt\|lambda\|^(- 2 s) f\(x_1\,x_2\)}$) $G_1$ action on RHS: $\(g dots.h.c f\)\(x_1\,x_2\)= f\(\(x_1\,x_2\)g\)$, inner product #math.equation(block: true, numbering: none, $chevron.l f_1\,f_2 chevron.r = frac(1, 2 pi) integral_1^(2 pi) f_1 overline(f_2)\(- sin theta\,cos theta\)d theta$) Suppose $- 2 s = n in bb(Z)_(gt.eq 0)$, $epsilon.alt equiv n #h(0.444em) mod med 2$, then get #math.equation(block: true, numbering: none, $H_n^oo = { { f in C^oo\(bb(R)^2 - {\(0\,0\)}\)\|f\(lambda x_1\,lambda x_2\)= lambda^n f\(x_1\,x_2\)}$) With completion $H_n$, a representation of $G_1 = "SL"_2\(bb(R)\)$. Let #math.equation(block: true, numbering: none, $f_(m\,n)\(x_1\,x_2\)=\(x_1 + i x_2\)^(frac(m + n, 2))\(x_1 - i x_2\)^(frac(n - m, 2))\,forall m in n + 2 bb(Z)$) $H_n^(upright(f i n)) = xor.big_(m in n + 2 bb(Z)) bb(C) f_(m\,n)$ space of $K$-finite vectors in $H_n$ \ Let $U_(+) = bb(C P)^1\\{ - i } subset.eq cal(H)$, $U_(-) = bb(C P)^1\\{ i } subset.eq cal(H)^(-)$, $U = U_(+) inter U_(-) supset.eq bb(R P)^1$, then

#math.equation(block: true, numbering: none, $0 arrow.r Gamma\(bb(C P)^1\,cal(O)\(n\)\)arrow.r Gamma\(U\,cal(O)\(n\)\)arrow.r H_({ plus.minus i })^1\(bb(C P)^1\,cal(O)\(n\)\)arrow.r H^1\(bb(C P)^1\,cal(O)\(n\)\)= 0$) $Gamma\(bb(C P)^1\,O\(n\)\)= xor.big_(- n lt.eq m lt.eq n\,m equiv n #h(0.444em) mod med 2) bb(C) f_(m\,n)$, finite dimensional representations of $G_1$, $Gamma\(U\,O\(n\)\)= H_n^(upright(f i n))$, $H_({ plus.minus i })^1\(bb(C P)^1\,cal(O)\(n\)\)= D^(+)\(n + 2\)xor D^(-)\(n + 2\)$, $D^(+)\(n + 2\)= H_({ i })^1\(bb(C P)^1\,cal(O)\(n\)\)= xor.big_(m gt.eq n + 2\,m equiv n #h(0.444em) mod med 2) bb(C) f_(m\,n)$, $D^(-)\(n + 2\)= H_({ - i })^1\(bb(C P)^1\,cal(O)\(n\)\)= xor.big_(m lt.eq - n - 2\,m equiv n #h(0.444em) mod med 2) bb(C) f_(m\,n)$. All these are $\(frak(s l)_2\,K\)$-modules \ Now consider the case of $H_(- n)$, $n in bb(Z)_(> 0)$, $epsilon.alt equiv n #h(0.444em) mod med 2$, $H_(- n)^(upright(f i n))$ has basis $f_(m\,- n)$. Cech sequence for $O\(- n\)$: #math.equation(block: true, numbering: none, $0 = Gamma\(bb(C P)^1\,O\(- n\)\)arrow.r Gamma\(U_(+)\,O\(- n\)\)xor Gamma\(U_(-)\,O\(- n\)\)arrow.r Gamma\(U\,O\(- n\)\)arrow.r H^1\(bb(C P)^1\,O\(- n\)\)arrow.r 0$) #math.equation(block: true, numbering: none, $Gamma\(U_(+)\,O\(- n\)\)= xor.big_(m lt.eq - n\,m equiv n #h(0.444em) mod med 2) bb(C) f_(m\,- n) = D^(-)\(n\)arrow.r Gamma\(U\,O\(- n\)\)= H_n^(upright(f i n))$) #math.equation(block: true, numbering: none, $Gamma\(U_(-)\,O\(- n\)\)= xor.big_(m gt.eq n\,m equiv n #h(0.444em) mod med 2) bb(C) f_(m\,- n) = D^(+)\(n\)arrow.r Gamma\(U\,O\(- n\)\)= H_n^(upright(f i n))$) By Serre duality #math.equation(block: true, numbering: none, $H^1\(bb(C P)^1\,O\(- n\)\)tilde.equiv H^0\(bb(C P)^1\,O\(n - 2\)\)^or = xor.big_(2 - n lt.eq m lt.eq n - 2\,m equiv n #h(0.444em) mod med 2) bb(C) f_(m\,- n)$) Which is $0$ if $n = 1$ \ Using this description, get embedding #math.equation(block: true, numbering: none, $D^(-)\(n\)arrow.r L_(upright(h o l))^2\(cal(H)\,n\)= {f upright(" holomorphic on ") cal(H) mid(bar.v) integral_(cal(H)) \| f \( z \) \|^2 \( Im z \)^k frac(d x d y, y^2) < oo}$) $f_(m\,- n) mapsto\(z + i\)^(frac(m - n, 2))\(z - i\)^(frac(- m - n, 2))$ $L_(upright(h o l))^2\(cal(H)\,n\)$ is a unitary representation of $G_1 = "SL"_2\(bb(R)\)$, $\(g dot.op f\)\(z\)=\(f\|_n g^t\)\(z\)= j\(g^t\,z\)^n f\(g^t\,z\)$ Isometric embedding $L_(upright(h o l))^2\(cal(H)\,n\)arrow.r L^2\(G_1\)$, $f mapsto phi.alt_f$, $phi.alt_f\(g\)= f\(g^t i\)j\(g^t\,i\)^(- n)$

The case of $tilde(G) = "GL"_2\(bb(R)\)$, $tilde(K) = O\(2\)= K union.sq K eta$, $eta = mat(delim: "[", - 1, 0; 0, 1)$, $"ad"\(eta\)\(k\)= k^(- 1)$, $forall k in K$, $eta^2 = 1$, $"ad"\(eta\)\(W\)= - W$, $"ad"\(eta\)\(R\)= L$, $"ad"\(eta\)\(L\)= R$. Let $rho$ be a representation of $G$, define another $G$-representation $eta\(rho\)$ by $eta\(rho\)\(g\)= rho\("ad"\(eta\)g\)$, then $"Ind"_G^(tilde(G)) rho tilde.equiv rho xor eta\(rho\)$

Suppose $rho$ is irreducible, the following are equivalent

+ $rho$ extends to an irreducible representation of $tilde(G)$

+ $"Ind"_G^(tilde(G)) rho$ is reducible $tilde(G)$ representation

+ $rho tilde.equiv eta\(rho\)$ as $G$ representation

e.g. $"Ind"_G^(tilde(G)) upright(t r i v) tilde.equiv upright(t r i v) xor "sgn"$ as $tilde(G)$ representations

If these are satisfied, then there are 2 isomorphic classes of $tilde(G)$ representation that extends $rho$: $tilde(rho)$ and $tilde(rho) times.o "sgn"$ \ If the irreducible representation $rho$ does not extend to $tilde(G)$ representation, then $"Ind"_G^(tilde(G)) rho tilde.equiv\("Ind"_G^(tilde(G)) rho\)times.o "sgn"$ is an irreducible representation of $tilde(G)$ that restricts to the $G$ representation $rho xor eta\(rho\)$ \ Note: An explicit $tilde(G)$ isomorphism #math.equation(block: true, numbering: none, $iota : "Ind"_G^(tilde(G)) rho & arrow.r^tilde.equiv\("Ind"_G^(tilde(G)) rho\)times.o "sgn"\
\(f : tilde(G) arrow.r V\) & mapsto iota f\(g\)= cases(f\(g\)quad upright("if ") g in G, - f\(g\)quad upright("if ") g in eta G)$) Conversely, let $sigma$ be an irreducible representation of $tilde(G)$. If $sigma\|_G$ is irreducible, then $sigma tilde.equiv sigma times.o "sgn"$. If $sigma\|_G$ is reducible, then $sigma tilde.equiv sigma times.o "sgn"$ and $sigma\|_G tilde.equiv rho xor eta\(rho\)$ for some irreducible representation $rho$ of $G$

#statement("Example")[
Irreducible representations of $tilde(K)$: triv, sgn, $"Ind"_K^(tilde(K)) chi_m$, $0 eq.not m in bb(Z)$. For $tilde(G) = "GL"_2\(bb(R)\)$, the principal series $P_mu\(lambda\,epsilon.alt\)$ and finite dimensional representations of $G$ has 2 non-isomorphic extensions to $tilde(G)$ representation and $\(frak(g)\,K\)$-modules

]
$D_mu^plus.minus\(n\)$, $\(n gt.eq 1\)$ cannot be extended to $\(frak(g)\,tilde(K)\)$-module, or $tilde(G)$ representation, $D_mu^(+)\(n\)xor D_mu^(-)\(n\)$ are irreducible $\(frak(g)\,tilde(K)\)$-modules, irreducible $tilde(G)$ representations. Note that $D_mu^(-)\(n\)= eta\(D_mu^(+)\(n\)\)$

#statement("Remark")[
$eta$ acts on $K$-types by negation, so $K$-type of $\(frak(g)\,tilde(K)\)$ modules are symmetric under negation

]
Duality theorem of G-G-PS: $Gamma subset.eq G$ is discrete subgroup, $"Vol"\(Gamma without cal(H)\)< oo$, $- i in Gamma$, $chi : Gamma arrow.r bb(C)^times$, $omega : Z_G arrow.r bb(C)^times$ such that $chi\(- 1\)= omega\(- 1\)$, $omega\(a\)= a^mu$, $forall a in Z_G^(+)$ (positive numbers), where $mu in i bb(R)$

+ $forall n in bb(Z)_(gt.eq 1)$ such that $chi\(- 1\)=\(- 1\)^n$, we have canonical isomorphism #math.equation(block: true, numbering: none, $S_n\(Gamma\,chi\)= "Hom"_(\(frak(g)\,K\))\(D_mu^(+)\(n\)\,cal(A)_0\(Gamma without G\,chi\,omega\)\)= "Hom"_G\(D_mu^(+)\(n\)\,cal(L)_0^2\(Gamma without G\,chi\,omega\)\)$) Recall #math.equation(block: true, numbering: none, $S_n\(Gamma\,chi\)= { f : cal(H) arrow.r bb(C) upright(" holomorphic, cuspidal ") f\|_n gamma = chi\(gamma\)f\,forall gamma in Gamma }$) The map sends $f$ to the $\(frak(g)\,K\)$ module generated by #math.equation(block: true, numbering: none, $phi.alt_f\(g\)= f\(g i\)det\(g\)^(1 / 2) j\(g\,i\)^(- n) omega\(det\(g\)^(1 / 2)\)\,forall g in G$) Conversely, let $phi.alt in cal(A)_0\(Gamma without G\,chi\,omega\)$ be the image of a nonzero lowest weight vector in $D_mu^(+)\(n\)$, $forall z = g i in cal(H)\,g in G$, define #math.equation(block: true, numbering: none, $f_phi.alt\(z\)= phi.alt\(g\)j\(g\,i\)^n det\(g\)^(- 1 / 2) omega\(det\(g\)^(- 1 / 2)\)$) $phi.alt$ has weight $n$, $f_phi.alt$ is well-defined and $f_phi.alt\|_n gamma = chi\(gamma\)f_phi.alt$. $L phi.alt = 0 arrow.l.r.double f_phi.alt$ is holomorphic

+ $forall n in bb(Z)_(gt.eq 1)$ such that $chi\(- 1\)=\(- 1\)^n$ #math.equation(block: true, numbering: none, $S_n\(Gamma\,chi\)^(upright(a n t i)) = "Hom"_(\(frak(g)\,K\))\(D_mu^(-)\(n\)\,cal(A)_0\(Gamma without G\,chi\,omega\)\)= "Hom"_G\(D_mu^(-)\(n\)\,cal(L)_0^2\(Gamma without G\,chi\,omega\)\)$) Use action of $eta$ on $L_0^2$ and $cal(A)_0$ $\(eta phi.alt\)\(g\)= phi.alt\("ad"\(eta\)g\)$. Composition #math.equation(block: true, numbering: none, $D_mu^(-)\(n\)arrow.r L_0^2\(Gamma without G\,chi\,omega\)arrow.r^eta L_0^2\(Gamma without G\,chi\,omega\)$) defines a $G$-equivariant embedding #math.equation(block: true, numbering: none, $D_mu^(+)\(n\)tilde.equiv eta D_mu^(-)\(n\)arrow.r L_0^2\(Gamma without G\,chi\,omega\)$) $forall f in S_k\(Gamma\,chi\)$, let $eta\(f\)\(z\)= f\(- macron(z)\)$, then $eta\(f\)in S_k\(Gamma\,chi\)^(upright(a n t i))$

  #align(center)[
  #align(center)[#diagram(node((0,0),$S_k(Gamma,chi)$),node((1,0),$cal(A)_0(Gamma without G,chi,omega)$),node((0,1),$S_k(Gamma,chi)^upright("anti")$),node((1,1),$cal(A)_0(Gamma without G,chi,omega)$),node((0,2),$f$),node((1,2),$phi_f$),edge((0,0),(1,0),"hook->"),edge((0,0),(0,1),"->",$eta, approx.eq$),edge((1,0),(1,1),"->",$eta, approx.eq$),edge((0,1),(1,1),"hook->"),edge((0,2),(1,2),"|->"))]
  ]

+ Consider $P_mu\(lambda\,epsilon.alt\)$, $lambda = s\(1 - s\)$ unitary principal series ($s in 1 / 2 + i bb(R)$) or complementary series ($s in\(0\,1\)\,epsilon.alt = 0$) #math.equation(block: true, numbering: none, $"Hom"_(\(frak(g)\,K\))\(P_mu\(lambda\,epsilon.alt\)\,cal(A)_0\(Gamma without\,chi\,omega\)\)= W_s\(Gamma\,chi\)\,upright(" \"Maass wave forms\"")$) #math.equation(block: true, numbering: none, $W_s\(Gamma\,chi\)= { f : cal(H) arrow.r bb(C) upright(" real analytic, cuspidal ") f\(gamma dot.op z\)= chi\(gamma\)f\(z\)\,- y^2\(frac(partial^2, partial x^2) + frac(partial^2, partial y^2)\)f = s\(1 - s\)f }$) By Corollary #ref(label("A_0 decomposes into direct sum of irreducible admissible (g,K) modules with finite multiplicities"), supplement: none), the spaces $S_n\(Gamma\,chi\)$, $W_s\(Gamma\,chi\)$ are finite dimensional

#aside("Note")[
If $s in 1 / 2 + i bb(R)$, then $lambda in\[1 / 4\,+ oo\)$ \ If $s in\(0\,1\)$, then $lambda in\(0\,1 / 4\)$ "exceptional eigenvalues"

]
#statement("Conjecture", title: [Selberg])[
If $Gamma$ is a congruence subgroup of $S L_2\(bb(Z)\)$, then $Delta$ has no exceptional eigenvalues on $L_0^2\(Gamma without cal(H)\,chi\)$, equivalently, all summands of $L_0^2\(Gamma without G\,chi\,omega\)$ are tempered (complementary series do not occur). Not true if $Gamma$ is non-congruence subgroup of $"SL"_2\(bb(Z)\)$

]

#pagebreak()

= Hecke operators

Recall: #math.equation(block: true, numbering: none, $L_0^2\(Gamma without G\,chi\,omega\)= hat(xor.big) H times.o "Hom"_G\(H\,L_0^2\)$) Here $H$ are irreducible representations of $G$. Want to decompose further. Need operators on $L_0^2$ commuting with right regular $G$ representations. Natural source: left regular $G$ action #math.equation(block: true, numbering: none, $forall g in G\,""^g Gamma without G arrow.r^(g^(- 1)) Gamma without G\,""^g Gamma x mapsto Gamma g^(- 1) x$) Here $""^g Gamma = g Gamma g^(- 1)$ #math.equation(block: true, numbering: none, $l_g : bb(C)\(Gamma without G\) & arrow.r^tilde.equiv bb(C)\(""^g Gamma without G\)\
phi.alt & mapsto\(l_g phi.alt\)\(x\)= phi.alt\(g^(- 1) x\)$) Also for $L_0^2\,L^2\,cal(A)_0\,cal(A)\,C^oo$. In particular, get an action of $N_G\(Gamma\)$ commuting with right regular reperesentation Observation: if $Gamma' lt.eq Gamma$ of finite index, we have map #math.equation(block: true, numbering: none, $"Tr" : bb(C)\(Gamma' without G\) & arrow.r bb(C)\(Gamma without G\)\
phi.alt & mapsto\("Tr" phi.alt\)\(x\)= sum_(gamma in Gamma'\\Gamma) phi.alt\(gamma x\)$) Recall: commensurator $tilde(Gamma) = { g in G\|Gamma approx ""^g Gamma }$, recall that $Gamma_1 approx Gamma_2 arrow.l.r.double Gamma_1 inter Gamma_2$ has finite index in both $Gamma_1$ and $Gamma_2$

#math.equation(block: true, numbering: none, $Gamma\(n\)= {gamma in "SL"_2 \( bb(Z) \) mid(bar.v) gamma equiv mat(delim: "[", 1, 0; 0, 1) #h(0.444em) mod med n}$) is of finite index to $"SL"_2\(bb(Z)\)$

#statement("Example")[
$Gamma lt.eq "SL"_2\(bb(R)\)$ is a discrete subgroup such that $Gamma approx "SL"_2\(bb(Z)\)$, then the commensurator $tilde(Gamma)$ is $cases("SL"_2\(bb(Q)\)upright(" in ") "SL"_2\(bb(R)\), bb(R)^times "GL"_2\(bb(Q)\)^(+) upright(" in ") "GL"_2\(bb(R)\)^(+), bb(R)^times "GL"_2\(bb(Q)\)upright(" in ") "GL"_2\(bb(R)\))$

]
#proof(title: "Proof")[
It suffices to consider $"GL"_2\(bb(R)\)$ case. If $Gamma_1 approx Gamma_2$, then $tilde(Gamma)_1 = tilde(Gamma)_2$, so we assume $Gamma = "SL"_2\(bb(Z)\)$. Let $g in bb(R)^times "GL"_2\(bb(Q)\)$, up to scaling in $bb(R)^times$, we may assume $g in M_2\(bb(Z)\)inter G L_2\(bb(R)\)$, let $m = det g in bb(Z) - { 0 }$, so $m g^(- 1) in M_2\(bb(Z)\)$. Note that for any $gamma in Gamma\(m\)$, $g^(- 1) gamma g = m^(- 1)\(m g^(- 1)\)gamma g in Gamma$ since $\(m g^(- 1)\)gamma g equiv m g^(- 1) g equiv 0 #h(0.444em) mod med m arrow.r.double ""^(g^(- 1)) Gamma inter Gamma supset.eq Gamma\(m\)arrow.r.double bb(R)^times "GL"_2\(bb(Q)\)subset.eq tilde(Gamma)$. Conversely, take $beta = mat(delim: "[", a, b; c, d) in tilde(Gamma)$, then $beta^T in tilde(Gamma)$ as well. Recall $P_Gamma = bb(Q) union { oo }$, $beta P_Gamma = P_(beta Gamma beta^(- 1)) = P_Gamma$ since $Gamma approx beta Gamma beta^(- 1)$. Similarly, $beta^T P_Gamma = P_Gamma$. Then one easily deduce $beta in bb(R)^times "GL"_2\(bb(Q)\)$

]
#statement("Definition")[
$forall g in tilde(Gamma)$, define $T_g$ as the composition #math.equation(block: true, numbering: none, $bb(C)\(Gamma without G\)arrow.r^(l_g) bb(C)\(""^g Gamma without G\)arrow.r^("res") bb(C)\(Gamma inter ""^g Gamma without G\)arrow.r^("Tr") bb(C)\(Gamma without G\)$) Hecke correspondence:

#align(center)[
#align(center)[#diagram(node((1,0),$(Gamma inter lr({}^g Gamma)) without G$),node((0,1),$Gamma without G$),node((2,1),$Gamma without G$),edge((1,0),(0,1),"->",$accent(p,arrow.l) = g^(-1)$),edge((1,0),(2,1),"->",$vec(p)$),edge((2,1),(0,1),"->",[multivalued],stroke:(dash:"dashed")))]
]
induces Hecke operator $T_g = arrow(p)_(!) p^arrow.l^(*)$. Here $arrow(p)$ is the natural projection, $arrow(p)_(!)$ is the trace map along $arrow(p)$ Concretely, $forall phi.alt in bb(C)\(Gamma without G\)$ #math.equation(block: true, numbering: none, $\(T_g phi.alt\)\(x\)= sum_(gamma in Gamma inter ""^g Gamma\\Gamma) phi.alt\(g^(- 1) gamma x\)= sum_(delta in Gamma g Gamma\/Gamma) phi.alt\(delta^(- 1) x\)$) #math.equation(block: true, numbering: none, $Gamma inter ""^g Gamma without Gamma & arrow.r^tilde.equiv Gamma without Gamma g^(- 1) Gamma arrow.r_tilde.equiv^(upright("inverse")) Gamma g Gamma\/Gamma\
Gamma inter ""^g Gamma gamma & mapsto Gamma g^(- 1) gamma = Gamma delta^(- 1) mapsto gamma^(- 1) g Gamma = delta Gamma$) In particular, $T_g$ only depends on $Gamma g Gamma$, also denote $\[Gamma g Gamma\]phi.alt = T_g phi.alt$

]
#statement("Remark")[
If $Gamma$ is non-arithmetic, then $tilde(Gamma)\/bb(R)^times Gamma$ is finite

]
== Abstract Hecke algebras
<abstract-hecke-algebras>
Let $G$ be the ambient group(e.g. $"GL"_2\(bb(R)\)$, $"GL"_2\(bb(R)\)^(+)$, $"SL"_2\(bb(R)\)$), $Omega subset.eq G$ be a submonoid, $cal(X) eq.not diameter$ be a family of mutually commensurable subgroups of $G$ such that $forall Gamma in cal(X)$, $Gamma subset.eq Omega subset.eq tilde(Gamma)$. $M$ is a $bb(C)$ vector space with a representation of $Omega$

#statement("Example")[
$G = "GL"_2\(bb(R)\)$, $cal(X) = { upright("congruence subgroups of ") "GL"_2\(bb(Z)\)}$, $Omega = M_2\(bb(Z)\)inter G$, $M = lim_arrow.r_(Gamma in cal(X)) C^oo\(Gamma without G\)$ has a representation of $Omega$ via left regular action $l_delta : C^oo\(Gamma without G\)arrow.r C^oo\(^delta Gamma without G\)$. Since $""^delta Gamma = delta Gamma delta^(- 1) in cal(X)$, $forall delta in Omega$, get an action $l_delta : M arrow.r M$. Moreover, $forall Gamma in cal(X)$, $M^Gamma = C^oo\(Gamma without G\)$ has action of Hecke operators

]
#statement("Definition")[
For any $Gamma_1\,Gamma_2 in cal(X)$, define #math.equation(block: true, numbering: none, $cal(H)\(Gamma_1 without Omega\/Gamma_2\)= {f : Omega arrow.r bb(C) mid(bar.v) upright(" left ") Gamma_1 upright("-invariant, right ") Gamma_2 upright("-invariant and ") Gamma_1 without "Supp" f\/Gamma_2 upright(" is finite")}$) $cal(H)\(Omega\/\/Gamma\)= cal(H)\(Gamma without Omega\/Gamma\)$ is the #emph[Hecke algebra]. Any $f in cal(H)\(Gamma_1 without Omega\/Gamma_2\)$ defines a linear map $M^(Gamma_2) arrow.r^f M^(Gamma_1)$ #math.equation(block: true, numbering: none, $forall m in M^(Gamma_2)\,f dot.op m = sum_(delta in Omega\/Gamma_2) f\(delta\)delta m in M^(Gamma_1)$) Convolution: $forall Gamma_1\,Gamma_2\,Gamma_3 in cal(X)$, $phi.alt in cal(H)\(Gamma_1 without Omega\/Gamma_2\)$, $psi in cal(H)\(Gamma_2 without Omega\/Gamma_3\)$ #math.equation(block: true, numbering: none, $phi.alt * psi\(x\)sum_(h in Omega without Gamma_2) phi.alt\(h\)psi\(h^(- 1) x\)= sum_(delta in Gamma_2 without Omega) phi.alt\(x delta^(- 1)\)psi\(delta\)in cal(H)\(Gamma_1 without Omega\/Gamma_3\)\,forall x in Omega$) Both sums are finite and equal

Check

- Associativity

- $forall Gamma in cal(X)$, $cal(H)\(Omega\/\/Gamma\)$ is a $bb(C)$ algebra with unit $1_Gamma$

- $forall m in M^(Gamma_3)$, $phi.alt\(psi m\)=\(phi.alt * psi\)m in M^(Gamma_1)$

In particular, $M^Gamma$ is a left $cal(H)\(Omega\/\/Gamma\)$ module

Structure constants: $cal(H)\(Gamma_1 without Omega\/Gamma_2\)$ has a $bb(C)$ basis consisting of $\[Gamma_1 alpha Gamma_2\]= 1_(Gamma_1 alpha Gamma_2)$ #math.equation(block: true, numbering: none, $* : cal(H)\(Gamma_1 without Omega\/Gamma_2\)times cal(H)\(Gamma_2 without Omega\/Gamma_3\) & arrow.r cal(H)\(Gamma_1 without Omega\/Gamma_3\)\
\(\[Gamma_1 alpha Gamma_2\]\,\[Gamma_2 beta Gamma_3\]\) & mapsto sum_(gamma in Gamma_1 without Omega\/Gamma_3) C_(alpha beta)^gamma\[Gamma_1 gamma Gamma_3\]$) Then the structure constant is #math.equation(block: true, numbering: none, $C_(alpha beta)^gamma & =\(\[Gamma_1 alpha Gamma_2\]*\[Gamma_2 beta Gamma_3\]\)\(gamma\)\
 & = sum_(h in Gamma_2 without Omega) 1_(Gamma_1 alpha Gamma_2)\(gamma h^(- 1)\)1_(Gamma_2 beta Gamma_3)\(h\)\
 & = sum_(b in B) 1_(Gamma_1 alpha Gamma_2)\(gamma b^(- 1)\)\
 & = sum_(\(a\,b\)in A times B) 1_(Gamma_1 a)\(gamma b^(- 1)\)=\#{\(a\,b\)in A times B\|Gamma_1 gamma = Gamma_1 a b }$)

]
Special case: suppose $alpha Gamma alpha^(- 1) = Gamma$, then $Gamma alpha gamma = Gamma alpha = alpha Gamma$ #math.equation(block: true, numbering: none, $C_(alpha beta)^gamma = { b in B\|Gamma gamma = Gamma alpha b } = cases(1 quad upright(" if ") gamma in Gamma alpha beta Gamma, 0 quad upright(" else"))$) So $\[Gamma alpha Gamma\]*\[Gamma beta Gamma\]=\[Gamma alpha beta Gamma\]$. In particular, $bb(C)\[N_G\(Gamma\)\/Gamma\]$ is a subalgebra of $cal(H)\(tilde(Gamma)\/\/Gamma\)$

#statement("Lemma")[
Suppose there exists an anti-involution $tau : Omega arrow.r Omega$ such that $tau\(Gamma alpha Gamma\)= Gamma alpha Gamma$, $forall alpha in Omega$. Then $cal(H)\(Omega\/\/Gamma\)$ is commutative

]#label("Hecke operators, Lemma 1")
#proof(title: "Proof")[
Use $tau\(phi.alt * psi\)= tau\(psi\)* tau\(phi.alt\)$

]
Now let $G = "GL"_2\(bb(R)\)^(+)$ and suppose $Gamma in cal(X)$, $Gamma$ is discrete in $G$ and $"Vol"\(Gamma without cal(H)\)< oo$, fix $omega : Z_G arrow.r bb(C)^times$ be a unitary character. Normalize inner product on $L^2\(Gamma without G\,omega\)$ by #math.equation(block: true, numbering: none, $\(phi.alt_1\,phi.alt_2\)= frac(1, "Vol"\(Gamma without G\/Z_G^(+)\)) integral_(Gamma without G\/Z_G^(+)) phi.alt_1\(g\)overline(phi.alt_2\(g\)) d g$) This induces inner product on $M = union.big_(Gamma in cal(X)) L^2\(Gamma without G\,omega\)$

#statement("Lemma")[
#math.equation(block: true, numbering: none, $\(\[Gamma g Gamma\]phi.alt_1\,phi.alt_2\)=\(phi.alt_1\,\[Gamma g^(- 1) Gamma\]phi.alt_2\)$)

]#label("Heck operators Lemma 2")
#statement("Example")[
Let $Gamma = "SL"_2\(bb(Z)\)$, $Omega = M_2\(bb(Z)\)inter "GL"_2\(bb(R)\)^(+)$. By elementary divisor theorem #math.equation(block: true, numbering: none, $Omega = union.sq.big_(\(lambda_1\,lambda_2\)in Lambda_(+)) Gamma mat(delim: "[", lambda_1, ; #none, lambda_2) Gamma$) Where #math.equation(block: true, numbering: none, $Lambda_(+) = { lambda =\(lambda_1\,lambda_2\)in bb(Z)_(gt.eq 1)^2\,lambda_2\|lambda_1 } arrow.l.r^(1 - 1) Gamma without Omega\/Gamma$) $forall lambda =\(lambda_1\,lambda_2\)in Lambda_(+)$, let $Q_lambda = bb(Z)\/lambda_1 bb(Z) times.o bb(Z)\/lambda_2 bb(Z)$. Denote #math.equation(block: true, numbering: none, $Gamma_lambda = Gamma mat(delim: "[", lambda_1, ; #none, lambda_2) Gamma\,T_lambda = 1_(Gamma_lambda)$) Recall the bijection #math.equation(block: true, numbering: none, $"GL"_2\(bb(Q)\)^(+)\/Gamma & arrow.r^tilde.equiv { L lt.eq bb(Q)^2 upright(" lattice") }\
g & mapsto g L_0\,L_0 = bb(Z)^2 lt.eq bb(Q)^2$) This induces $Gamma_lambda\/Gamma arrow.r^tilde.equiv { L lt.eq L_0 upright(" sublattice")\|L_0\/L tilde.equiv Q_lambda }$. Recall the structure constant $C_(lambda mu)^nu$, $forall lambda\,mu\,nu in Lambda_(+) = Gamma without Omega Gamma$ #math.equation(block: true, numbering: none, $T_lambda * T_mu = sum_(nu in Lambda_(+)) C_(lambda mu)^nu T_nu$) in $cal(H)\(Omega\/\/Gamma\)$

]
#statement("Lemma")[
#math.equation(block: true, numbering: none, $C_(lambda mu)^nu =\#{ A lt.eq A_nu upright(" subgroup")\|A tilde.equiv Q_mu\,Q_nu\/A tilde.equiv Q_lambda }$)

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, ${\( g_1 \, g_2 \) in Gamma_lambda \/ Gamma times Gamma_lambda \/ Gamma mid(bar.v) g_1 g_2 Gamma = mat(delim: "[", nu_1, ; #none, nu_2) Gamma} & arrow.r { A lt.eq A_nu upright(" subgroup")\|A tilde.equiv Q_mu\,Q_nu\/A tilde.equiv Q_lambda }\
\(g_1\,g_2\) & mapsto frac(g_1 L_0, nu_1 bb(Z) xor nu_2 bb(Z))$) Check this is a bijection

]
So $C_(lambda mu)^nu$ is related to $"Ext"^1\(Q_lambda\,Q_mu\)$. In particular, if $\(lambda_1\,mu_1\)= 1$, there is no nontrivial extension, $T_lambda * T_mu = T_(lambda mu)$ #math.equation(block: true, numbering: none, $forall n in bb(Z)_(gt.eq 1)\,T_(\(n\,n\)) * T_lambda = T_lambda * T_(n\,n) = T_(n lambda)\,forall lambda in Lambda_(+)$) Since only one possible extension with (at most) 2 generators. By Lemma #ref(label("Hecke operators, Lemma 1"), supplement: none), $cal(H)\(Omega\/\/Gamma\)$ is commutative (use transpose). Denote $T_p = T_(\(p\,1\))$, $R_p = T_(\(p\,p\))$

#statement("Lemma")[
#math.equation(block: true, numbering: none, $T_p * T_(\(p^n\,1\)) = T_(\(p^n\,1\)) * T_p = cases(T_(\(p^(n + 1)\,1\)) + p T_(\(p^n\,p\)) quad n > 1, T_(\(p^(n + 1)\,1\)) +\(p + 1\)T_(\(p^n\,p\)) quad n = 1)$)

]#label("Hecke operators Lemma 4")
#proof(title: "Proof")[
Note that $T_(\(p^n\,1\)) * T_p = a T_(\(p^(n + 1)\,1\)) + b T_(\(p^n\,p\))$. Possible extensions of $bb(Z)\/p^n bb(Z)$ by $bb(Z)\/p bb(Z)$ are

+ Split extension $bb(Z)\/p^n bb(Z) xor bb(Z)\/p bb(Z)$ #math.equation(block: true, numbering: none, ${A lt.eq bb(Z) \/ p^(n + 1) bb(Z) mid(bar.v) A tilde.equiv bb(Z) \/ p bb(Z) \, frac(bb(Z)\/p^(n + 1) bb(Z), A) tilde.equiv bb(Z) \/ p^n bb(Z)} = p^n bb(Z)\/p^(n + 1) bb(Z) arrow.r.double a = 1$)

+ Non split extension $bb(Z)\/p^(n + 1) bb(Z)$. If $A lt.eq bb(Z)\/p^n bb(Z) xor bb(Z)\/p bb(Z)$, $A tilde.equiv bb(Z) p bb(Z)$, with quotient $tilde.equiv bb(Z)\/p^n bb(Z)$, when $n = 1$, $p + 1$ such subgroups (lies in $bb(F)_p^2$), when $n > 1$, $A$ is generated by a nonzero $p$-torsion element $\(x\,y\)in bb(Z)\/p bb(Z) xor p^(n - 1) bb(Z)\/p^n bb(Z)$, need $y eq.not 0$, so $p$ choices

]
Consequently, $cal(H)\(Omega\/\/Gamma\)= times.o_p cal(H)_p$, $cal(H)_p tilde.equiv bb(C)\[T_p\,R_p\]$. To see there are no algebraic relation between $T_p\,R_p$, show inductively that $T_p^n - T_(\(p^n\,1\)) in R_p dot.op cal(H)_p$

#statement("Remark")[
Let $Omega_p = M_2\(bb(Z)_p\)inter "GL"_2\(bb(Q)_p\)$, then #math.equation(block: true, numbering: none, $bb(C)\[T_p\,R_p\]= cal(H)_p tilde.equiv cal(H)\(Omega_p\/\/"GL"_2\(bb(Z)_p\)\)subset.eq cal(H)\("GL"_2\(bb(Q)_p\)\/\/"GL"_2\(bb(Z)_p\)\)tilde.equiv bb(C)\[T_p\,R_p^(plus.minus 1)\]$) #math.equation(block: true, numbering: none, $cal(H)\("GL"_2\(bb(Q)\)^(+)\/\/"SL"_2\(bb(Z)\)\)= cal(H)\("GL"_2\(bb(Q)\)\/\/"GL"_2\(bb(Z)\)\)tilde.equiv times.o_p cal(H)\("GL"_2\(bb(Q)_p\)\/\/"GL"_2\(bb(Z)_p\)\)tilde.equiv times.o_p bb(C)\[T_p\,R_p^(plus.minus 1)\]$)

]
Formal Dirichlet series: $forall m in bb(Z)_(gt.eq 1)$, define #math.equation(block: true, numbering: none, $T_m = sum_(lambda in Lambda_(+)\,lambda_1 lambda_2 = m) T_(\(lambda_1\,lambda_2\)) in cal(H)\(Omega\/\/Gamma\)$) $D\(s\)= sum_(m = 1)^oo T_m m^(- s) arrow.r.double D\(s\)= product_p\(sum_(n = 0)^oo T_(p^n) p^(- n s)\)$. Let $f_p\(x\)= sum T_(p^n) X^n in cal(H)_p\[\[X\]\]$

#statement("Proposition")[
$f_p\(x\)=\(1 - T_p X + P R_p X^2\)^(- 1)$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $f_p\(X\)= sum_(n_1 gt.eq n_2 gt.eq 0) T_(\(p^(n_1)\,p^(n_2)\)) X^(n_1 + n_2) = sum_(n = 0)^oo sum_(m = 0)^oo R_p^m T_(\(p^n\,1\)) X^(n + 2 m)$) Use Lemma #ref(label("Hecke operators Lemma 4"), supplement: none), we have #math.equation(block: true, numbering: none, $T_p X f_p\(X\) & = sum_(m = 0)^oo R_p^m T_p X^(2 m + 1) + sum_(m = 0)^oo R_p^m\(T_(\(p^2\,1\)) +\(p + 1\)R_p\)X^(2 m + 2) + sum_(n = 2)^oo sum_(m = 0)^oo R_p^m (T_(\(p^(n + 1)\,1\)+ p R_p T_(\(p^(n - 1)\,1\)))) X^(n + 2 m + 1)\
 & = f_p\(X\)- 1 + p sum_(m = 1)^oo R_p^m X^(2 m) + p R_p X^2 (f_p \( X \) - sum_(m = 0)^oo R_p^m X^(2 m))\
 & = f_p\(X\)\(1 + p R_p X^2\)- 1$) Hence #math.equation(block: true, numbering: none, $D\(s\)= product_p f_p\(p^(- s)\)= product_p frac(1, 1 - T_p p^(- s) + R_p p^(1 - 2 s))$)

]
Action on modular forms: $k gt.eq 2$ is an even integer, $Gamma = "SL"_2\(bb(Z)\)$

#align(center)[
#align(center)[#diagram(node((0,0),$M_k(Gamma)$),node((1,0),$cal(A)(Gamma without G slash Z_G^+)$),node((0,1),$S_k(Gamma)$),node((1,1),$cal(A)_0(Gamma without G slash Z_G^+)$),node((0,2),$f$),node((1,2),$phi_f(g)=f(g i) j(g,i)^(-i) det(g)^(k/2)$),edge((0,0),(1,0),"hook->"),edge((0,1),(1,1),"hook->"),edge((0,1),(0,0),"hook->"),edge((1,1),(1,0),"hook->"),edge((0,2),(1,2),"|->"))]
]
$cal(H)\(Omega\/\/Gamma\)$ action on RHS induces action on $M_k\(Gamma\)$, $S_k\(Gamma\)$

#statement("Proposition")[
Let $S_n = { g in M_2\(bb(Z)\)\|det g = n }$, $forall n in bb(Z)_(gt.eq 1)$, then #math.equation(block: true, numbering: none, $S_n\/Gamma = union.sq.big_(a d = n\,d gt.eq 1\,0 lt.eq b < a) mat(delim: "[", a, b; 0, d) Gamma$) #math.equation(block: true, numbering: none, $\(S_n\/Gamma\)^(- 1) = union.sq.big_(a d = n\,a gt.eq 1\,0 lt.eq b < d) Gamma mat(delim: "[", a, b; 0, d) n^(- 1)$)

]
#proof(title: "Proof")[
Let $e_1\,e_2$ be the standard basis of $L_0 = bb(Z)^2$ #math.equation(block: true, numbering: none, $S_n\/Gamma & arrow.r^tilde.equiv { L lt.eq L_0 upright(" sublattice of index ") n }\
g & mapsto g L_0$) Fix such a lattice $L$. Let $a =\|A_1\|$, $d =\|A_2\|$, then $a d = n$. Let $v_1 = a e_1 in L$, $exists v_2 in L$ such that $v_2 equiv d e_2 #h(0.444em) mod med bb(Z) e_1$. Write $v_2 = b e_1 + d e_2$, $b in bb(Z)$ is unique mod $a$. Then $v_1\,v_2$ form a $bb(Z)$-basis of $L$ and $L = mat(delim: "[", a, b; 0, d) L_0$

]
#statement("Corollary")[
$forall f in M_k\(Gamma\)$, $T_n\(f\)= n^(k / 2) sum_(a gt.eq 1\,a d = n\,0 lt.eq b < d) d^(- k) f\(frac(a z + b, d)\)$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $T_n = sum_(lambda in Lambda_(+)\,lambda_1 lambda_2 = n) T_(\(lambda_1\,lambda_2\)) = 1_(Gamma without\/S_n Gamma)$) #math.equation(block: true, numbering: none, $arrow.r.double\(T_n phi.alt_f\)\(g\)= sum_(delta in S_n\/Gamma) phi.alt_f\(delta^(- 1) g\)= sum_(a gt.eq 1\,a d = n\,0 lt.eq b < d) phi.alt_f (mat(delim: "[", a, b; 0, d) g)$) $phi.alt_f$ is invariant under scalar matrix $n^(- 1)$. Translate the formula to $f$

]
#statement("Definition", title: [a common normalization of $T_n$])[
$T_n^(\(k\)) = n^(k / 2 - 1) T_n$. Then $forall f in M_k\(Gamma\)$ #math.equation(block: true, numbering: none, $T_n^(\(k\)) f = n^(k - 1) sum_(a gt.eq 1\,a d = n\,0 lt.eq b < d) d^(- k) f\(frac(a z + b, d)\)$) For a prime $p$ #math.equation(block: true, numbering: none, $T_p^(\(k\)) f = 1 / p sum_(b = 0)^(p - 1) f\(frac(z + b, p)\)+ p^(k - 1) f\(p z\)= p^(k / 2 - 1) T_p f$)

]
Fourier coefficients: Let $f\(z\)= sum_(n = 0)^oo a_n\(f\)e^(2 pi i n z)$, $z in cal(H)$

#statement("Corollary")[
#math.equation(block: true, numbering: none, $a_n\(T_n^(\(k\)) f\)= sum_(d\|\(m\,n\)\,d gt.eq 1) d^(k - 1) a_(m n\/d^2)\(f\)\,forall m in bb(Z)_(gt.eq 0)\,n in bb(Z)_(gt.eq 1)$) In particular, $a_1\(T_n^(\(k\)) f\)= a_n\(f\)$, $a_0\(T_n^(\(k\)) f\)= sigma_(k - 1)\(n\)$

]
Recall: $M_k\(Gamma\)= S_k\(Gamma\)xor bb(C) E_k$. From Lemma #ref(label("Heck operators Lemma 2"), supplement: none) one deduce that $T_n$ is self-adjoint for Peterson inner product. In particular, it preserves $bb(C) E_k$. $S_k\(Gamma\)$ has a basis consisting of Hecke eigen-forms. i.e. simultaneous eigen-functions of $T_n$, $forall n in bb(Z)_(gt.eq 1)$

#statement("Corollary")[
Suppose $T_n^(\(k\)) = lambda_n f$, $forall lambda_n in bb(C)\,forall n in bb(Z)_(gt.eq 1)$, then $a_n\(f\)= lambda_n a_1\(f\)$. In particular if $a_1\(f\)= 0$, then $f = 0$. A normalized eigen-form is a Hecke eigen-form $f$ such that $a_1\(f\)= 1$

]
#statement("Corollary")[
If $f$ is normalized eigen-form, then $T_n^(\(k\)) f = a_n\(f\)f$. If $f_1\,f_2$ are normalized eigen-form with same eigenvalues for all $T_n$, then $f_1 = f_2$

]
Thus $S_k\(Gamma\)= "Hom"_(\(frak(g)\,K\))\(D_k^(+)\,cal(A)_0\(Gamma without G\/Z_G^(+)\)\)$ is decomposed into eigenspaces of $cal(H)\(Omega\/\/Gamma\)$, each with multiplicity 1


#pagebreak()

= Hecke algebras for congruence subgroups

In this section we use the following notations: $G = "GL"_2\(bb(R)\)^(+)$, for $N in bb(Z)_(gt.eq 2)$, define #math.equation(block: true, numbering: none, $Gamma\(N\)= {g in "SL"_2 \( bb(Z) \) mid(bar.v) g equiv mat(delim: "[", 1, 0; 0, 1) #h(0.444em) mod med N} upright(" principal congruence subgroup")$) #math.equation(block: true, numbering: none, $Gamma_0\(N\)= {mat(delim: "[", a, b; c, d) in "SL"_2 \( bb(Z) \) mid(bar.v) c equiv 0 #h(0.444em) mod med N}$) #math.equation(block: true, numbering: none, $Gamma_1\(N\)= {g in "SL"_2 \( bb(Z) \) mid(bar.v) g equiv mat(delim: "[", 1, *; 0, 1) #h(0.444em) mod med N}$) When $N = 1$, define $Gamma\(1\)= Gamma_0\(1\)= Gamma_1\(1\)= "SL"_2\(bb(Z)\)$

#statement("Definition")[
$Gamma lt.eq "SL"_2\(bb(Z)\)$ is a #emph[congruence subgroup] if $exists N in bb(Z)_(gt.eq 1)$ such that $Gamma supset.eq Gamma\(N\)$

]
Since $"SL"_2\(bb(Z)\)$ is generated by unipotent groups, the reduction map $"SL"_2\(bb(Z)\)arrow.r "SL"_2\(bb(Z)\/N bb(Z)\)$ is surjective $forall N in bb(Z)_(gt.eq 1)$. In particular, $Gamma_0\(N\)\/Gamma_1\(N\)tilde.equiv\(bb(Z)\/N bb(Z)\)^times$, $mat(delim: "[", a, b; c, d) mapsto d #h(0.444em) mod med N$

#statement("Lemma")[
#math.equation(block: true, numbering: none, $\|"SL"_2\(bb(Z)\)\/Gamma\(N\)\|=\|"SL"_2\(bb(Z)\/N bb(Z)\)\|= N^3 product_(p\|N) (1 - 1 / p^2)$) #math.equation(block: true, numbering: none, $\|"SL"_2\(bb(Z)\)\/Gamma_0\(N\)\|= N product_(p\|N) (1 + 1 / p)$) #math.equation(block: true, numbering: none, $\|Gamma_0\(N\)\/Gamma_1\(N\)\|=\|\(bb(Z)\/n bb(Z)\)^times\|$)

]
Let $cal(C) = { upright("congruence modular groups") }$, ${ Gamma\(N\)}_(N gt.eq 1)$ forms a cofinal subset. $forall Gamma\,Gamma' in cal(C)$, $forall g in G$ such that $""^g Gamma = g Gamma g^(- 1) supset.eq Gamma'$ induces

#align(center)[
#align(center)[#diagram(node((0,0),$M_k(Gamma)$),node((1,0),$M_k(Gamma')$),node((0,1),$S_k(Gamma)$),node((1,1),$S_k(Gamma')$),edge((0,0),(1,0),"->",$l_g$),edge((0,1),(1,1),"->"),edge((0,1),(0,0),"hook->"),edge((1,1),(1,0),"hook->"))]
$ l_g: f mapsto f dot_k g^(-1) $
]
Denote $cal(A)\(Gamma\)= cal(A)\(Gamma without G\/Z_G^(+)\)$, $cal(A)_0\(Gamma\)= cal(A)_0\(Gamma without G\/Z_G^(+)\)$. Then

#align(center)[
#align(center)[#diagram(node((0,0),$cal(A)(Gamma)$),node((1,0),$cal(A)(Gamma')$),node((0,1),$cal(A)_0(Gamma)$),node((1,1),$cal(A)_0(Gamma')$),edge((0,0),(1,0),"->",$l_g$),edge((0,1),(1,1),"->"),edge((0,1),(0,0),"hook->"),edge((1,1),(1,0),"hook->"))]
$ l_g: phi mapsto (l_g phi)(x)=phi(g^(-1) x) $
]
Let $M_k = lim_arrow.l_(Gamma in cal(C)) M_k\(Gamma\)$, similarly $S_k\,cal(A)\,cal(A)_0$. These are representations of $"GL"_2\(bb(Q)\)^(+)$ under left regular action. The natural embedding

#align(center)[
#align(center)[#diagram(node((0,0),$M_k$),node((1,0),$cal(A)$),node((0,1),$S_k$),node((1,1),$cal(A)_0$),edge((0,0),(1,0),"hook->"),edge((0,1),(1,1),"hook->"),edge((0,1),(0,0),"hook->"),edge((1,1),(1,0),"hook->"))]
]
is $"GL"_2\(bb(Q)\)^(+)$ equivariant, and induces isomorphism

#align(center)[
#align(center)[#diagram(node((0,0),$M_k$),node((1,0),$upright("Hom")_((frak(g),K))(D^+(k),cal(A))$),node((0,1),$S_k$),node((1,1),$upright("Hom")_((frak(g),K))(D^+(k),cal(A)_0)$),edge((0,0),(1,0),"->",$approx.eq$),edge((0,1),(1,1),"->",$approx.eq$),edge((0,1),(0,0),"hook->"),edge((1,1),(1,0),"hook->"))]
]
#aside("Note")[
#math.equation(block: true, numbering: none, $mat(delim: "[", 1, 0; 0, N)^(- 1) Gamma\(N\)mat(delim: "[", 1, 0; 0, N) supset.eq Gamma_1\(N^2\)\,forall N in bb(Z)_(gt.eq 1)$)

]
So ${ Gamma_1\(N\)}_(N gt.eq 1)$ is a cofinal subset of $cal(C)$ and $M_k = union.big_(N gt.eq 1) M_k\(Gamma_1\(N\)\)$, $S_k = union.big_(N gt.eq 1) S_k\(Gamma_1\(N\)\)$. $forall$ character $chi :\(bb(Z)\/n bb(Z)\)^times arrow.r bb(C)^times$, viewed as a character $Gamma_0\(N\)arrow.r bb(C)^times$, $mat(delim: "[", a, b; c, d) mapsto chi\(d #h(0.444em) mod med N\)$. Let #math.equation(block: true, numbering: none, $M_k\(Gamma_0\(N\)\,chi\)= { f in M_k\(Gamma_1\(N\)\)\|f\|_k gamma = chi\(gamma\)f\,forall gamma in Gamma_0\(N\)}$) Then #math.equation(block: true, numbering: none, $M_k\(Gamma_1\(N\)\)= xor.big_chi M_k\(Gamma_0\(N\)\,chi\)$) #math.equation(block: true, numbering: none, $S_k\(Gamma_1\(N\)\)= xor.big_chi S_k\(Gamma_0\(N\)\,chi\)$) $forall Gamma in cal(C)$, $cal(H)\("GL"_2\(bb(Q)\)^(+)\/\/Gamma\)$ acts on $M_k^Gamma = M_k\(Gamma\)$ and $S_k\(Gamma\)$, this algebra is non-commutative in general, we will study a large enough commutative subalgebra, when $Gamma = Gamma_1\(N\)$ (Recall: $cal(H)\("GL"_2\(bb(Q)\)^(+)\/\/"SL"_2\(bb(Z)\)\)= times.o_p bb(C)\[T_p\,R_p^(plus.minus 1)\]$ is commutative). Define the following submonoids of $"GL"_2\(bb(Q)\)^(+)$ #math.equation(block: true, numbering: none, $Omega_0\(N\)= {mat(delim: "[", a, b; c, d) in M_2 \( bb(Z) \) inter "GL"_2 \( bb(Q) \)^(+) mid(bar.v) \( d \, N \) = 1 \, N \| c} supset.eq Gamma_0\(N\)$) #math.equation(block: true, numbering: none, $Omega_1\(N\)= {mat(delim: "[", a, b; c, d) in Omega_0 \( N \) mid(bar.v) d equiv 1 #h(0.444em) mod med N} supset.eq Gamma_1\(N\)$) $cal(H)_0\(N\)= cal(H)\(Omega_0\(N\)\/\/Gamma_0\(N\)\)$, $cal(H)_1\(N\)= cal(H)\(Omega_1\(N\)\/\/Gamma_1\(N\)\)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(3mm,10mm),node((0,0),$cal(H)_1(N)$),node((1,0),$scr(H)(Omega_0(N) slash slash Gamma_1(N))$),node((2,0),$scr(H)(Omega_1(N) slash slash Gamma_0(N))$),node((3,0),$bb(C)[Omega_1(N) slash Gamma_0(N)]$),node((1,1),$cal(H)_0(N)$),edge((0,0),(1,0),"hook->"),edge((0,0),(1,1),"->",$approx.eq$),edge((1,0),(1,1),"->",$upright("Avg")$,bend:15deg),edge((1,1),(1,0),"hook->",bend:15deg),edge((2,0),(1,0),"hook->"),edge((2,0),(3,0),"->",$approx.eq$))]
]
$"Avg"\(phi.alt\)= e_0\(N\)* phi.alt * e_0\(N\)$, $e_0\(N\)= frac(1, \|\(bb(Z)\/n bb(Z)\)^times\|) 1_(Gamma_0\(N\)\/Gamma_1\(N\))$. The involution $mat(delim: "[", a, b; N c, d) mapsto mat(delim: "[", a, c; N b, d)$ on $Omega_0\(N\)$ and $Omega_1\(N\)$ implies that $cal(H)_0\(N\)$, $cal(H)_1\(N\)$ are commutative

#statement("Lemma")[
Let $Lambda_(+)\(N\)= {\(l\,m\)in bb(Z)_(gt.eq 1)^2\|m\|l\,\(m\,N\)= 1 }$, then #math.equation(block: true, numbering: none, $Omega_0\(N\)= union.sq.big_(\(l\,m\)in Lambda_(+)\(N\)) Gamma_0\(N\)mat(delim: "[", l, 0; 0, m) Gamma_0\(N\)$)

]
#proof(title: "Proof")[

]
#statement("Lemma")[
$forall lambda\,mu in Lambda_(+)\(N\)$, $1_lambda * 1_mu = sum_(nu in Lambda_(+)\(N\)) c_(lambda mu)^nu 1_nu$ in $cal(H)_0\(N\)$, where #math.equation(block: true, numbering: none, $c_(lambda mu)^nu =\#{ A subset.eq Q_nu upright(" subgroup")\|A tilde.equiv Q_mu\,Q_nu\/A tilde.equiv Q_lambda }$) same structure constants as in $frak(s l)_2\(bb(Z)\)$ case

]
#proof(title: "Proof")[

]

#pagebreak()

= Automorphic forms on $G L_2\(bb(A)\)$

In this section we adopt the following notation:

- $G = "GL"_2$ is the group scheme over $bb(Z)$. $Z tilde.equiv bb(G)_m$ is the center of $G$, $K = "SO"_2$, $G_oo = G_(bb(R))$, $K_oo = K_(bb(R))$

- The ring of finite adeles over $bb(Q)$ is #math.equation(block: true, numbering: none, $bb(A)_f = {\( x_2 \, x_3 \, dots.h.c \) in product_(p upright(" primes")) bb(Q)_p mid(bar.v) x_p in bb(Z)_p upright(" for all but finite many primes ") p}$) The multiplicative group of finite ideles over $bb(Q)$ is #math.equation(block: true, numbering: none, $bb(I)_f = bb(A)_f^times = {\( x_2 \, x_3 \, dots.h.c \) in product_(p upright(" primes")) bb(Q)_p^times mid(bar.v) x_p in bb(Z)_p^times upright(" for all but finite many primes ") p}$) If we write $bb(Q)_oo = bb(R)$. The ring of adeles over $bb(Q)$ is #math.equation(block: true, numbering: none, $bb(A) = {\( x_oo \, x_2 \, x_3 \, dots.h.c \) in times product_(v upright(" places")) bb(Q)_v mid(bar.v) x_p in bb(Z)_p upright(" for all but finite many primes ") p}$) The multiplicative group of ideles over $bb(Q)$ is #math.equation(block: true, numbering: none, $bb(I) = bb(A)^times = {\( x_oo \, x_2 \, x_3 \, dots.h.c \) in product_(v upright(" places")) bb(Q)_v^times mid(bar.v) x_p in bb(Z)_p^times upright(" for all but finite many primes ") p}$) $bb(A)_f$ and $bb(A)_f^times$ naturally embed into $bb(A)\,bb(A)^times$

- $cal(C) = { upright("congruence modular groups") }$ #math.equation(block: true, numbering: none, $cal(A) = lim_arrow.r_(Gamma in cal(C)) cal(A)\(Gamma\\G_(bb(R))^(+)\)supset.eq cal(A)_0 = lim_arrow.r_(Gamma in cal(C)) cal(A)_0\(Gamma\\G_(bb(R))^(+)\)$) Both $cal(A)$ and $cal(A)_0$ are

  + $\(frak(g)\,K\)$-modules: induced by right action of $G_(bb(R))^(+)$

  + $G_(bb(Q))^(+)$ representations: induced by left action of $G_(bb(Q))^(+)$

  $forall phi.alt in cal(A)$, stabilizer of $phi.alt$ in $G_(bb(Q))^(+)$ contains some $Gamma in cal(C)$. This fact implies that $G_(bb(Q))^(+)$ representation on $cal(A)$ and $cal(A)_0$ can be actually extended to $overline(G_(bb(Q))^(+))$, the completion of $G_(bb(Q))^(+)$ with respect to the topology in which $cal(C)$ forms a neighborhood basis of 1. A more concrete description is #math.equation(block: true, numbering: none, $overline(G_(bb(Q))^(+)) & = {\(g_n\)_(n = 1)^oo\|forall N in bb(Z)_(gt.eq 1)\,exists n_0 > 0\,upright("such that ") forall m gt.eq n gt.eq n_0\,g_m in g_n dot.op Gamma\(N\)}\/tilde.op$) $\(g_n\)_(n = 1)^oo tilde.op\(h_n\)_(n = 1)^oo$ if $forall N in bb(Z)_(gt.eq 1)$, $forall n_0 > 0$ such that $forall n gt.eq n_0$, $g_n in h_n Gamma\(N\)$

#statement("Lemma")[
$overline(G_(bb(Q))^(+)) = { g in "GL"_2\(bb(A)_f\)\|det g in bb(Q)_(> 0) }$

]
#proof(title: "Proof")[
Let $\(g_n\)_(gt.eq 1) in overline(G_(bb(Q))^(+))$. Then $exists m_0 > 0$ such that $forall n gt.eq m_0$, $g_n in 1 / D M_2\(bb(Z)\)$, $det g_n = alpha$, for some $D in bb(Z)_(gt.eq 1)$, $alpha in bb(Q)_(> 0)$. Then $forall N in bb(Z)_(gt.eq 1)$, $exists n_0 > 0$ such that $forall m gt.eq n gt.eq n_0$, $g_m in g_n Gamma\(N\)subset.eq g_n + g_n M_2\(N bb(Z)\)$ $arrow.r.double$ $g_m - g_n in 1 / D M_2\(N bb(Z)\)$ $arrow.r.double$ $\(g_n\)_(n gt.eq 1) in 1 / D M_2\(hat(bb(Z))\)subset.eq M_2\(bb(A)_f\)$, $det\(g_n\)_(n gt.eq 1) = alpha in bb(Q)_(> 0)$. This proves \"$subset.eq$\". The reverse inclusion follows form strong approximation, i.e. $"SL"_2\(bb(Q)\)$ is dense in $"SL"_2\(bb(A)_f\)$

]
$forall N in bb(Z)_(gt.eq 1)$. Let $K_N = { g in G_(hat(bb(Z)))\|g equiv 1 #h(0.444em) mod med N hat(bb(Z)) }$. Then ${ K_N inter overline(G_(bb(Q))^(+)) }_(gt.eq 1)$ is a neighborhood basis of $1$ in $overline(G_(bb(Q))^(+))$ and $K_N inter G_(bb(Q))^(+) = Gamma\(N\)$. Note $det\(K_N\)= cases(1 + N hat(bb(Z)) quad\,upright("if ") N gt.eq 2, hat(bb(Z))^times quad\,upright("if ") N = 1)$. Consider the space $cal(A)\(G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)\)$ satisfying:

+ $phi.alt\(gamma g_oo\,gamma g_f\)= phi.alt\(g_oo\,g_f\)$, $forall gamma in G_(bb(Q))^(+)$, $g_oo in G_(bb(R))^(+)$, $g_f in overline(G_(bb(Q))^(+))$

+ $phi.alt$ is $C^oo$, $Z_(frak(g))$-finite, right $K_(bb(R))$-finite, moderate growth on $G_(bb(R))^(+)$

+ $phi.alt$ is locally constant on $overline(G_(bb(Q))^(+))$ factor (this implies $phi.alt$ is also left $K_N$, invariant for some $N' in bb(Z)_(gt.eq 1)$). Then $cal(A)\(G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)\)$ is a $\(frak(g)\,K_(bb(R))\)$-module and $overline(G_(bb(Q))^(+))$ module, both induced by right multiplication action: $forall x in overline(G_(bb(Q))^(+))$, $\(r_x phi.alt\)\(g_oo\,g_f\)= phi.alt\(g_oo\,g_f x\)$. Let $cal(A)_0\(G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)\)$ be the subspace of functions that are cuspidal on $G_(bb(R))^(+)$

#statement("Lemma")[
$cal(A)_0\(G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)\)tilde.equiv cal(A)$ as $\(frak(g)\,K_(bb(R))\)times overline(G_(bb(Q))^(+))$ module (same for $cal(A)_0$)

]
#proof(title: "Proof")[
Let $phi.alt in cal(A)\(Gamma\(N\)\\G_(bb(R))^(+)\)$. The action of $g_f in overline(G_(bb(Q))^(+))$ is given as follows: choose $delta in G_(bb(Q))^(+)$ such that $g_f in delta dot.op K_N$. Then $\(g_f dot.op phi.alt\)\(g_oo\)= phi.alt\(delta^(- 1) g_oo\)$. In particular, $phi.alt$ is $K_N$ invariant. $forall\(g_oo\,g_f\)in G_(bb(R))^(+) times overline(G_(bb(Q))^(+))$, let $tilde(phi.alt)\(g_oo\,g_f\)=\(g_f dot.op phi.alt\)\(g_oo\)$. Then $tilde(phi.alt) in cal(A)\(G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)\)$. Conversely, any such $tilde(phi.alt)$ is right $K_N$ invariant for some $N in bb(Z)_(gt.eq 1)$. Define $phi.alt\(g_oo\)= tilde(phi.alt)\(g_oo\,1\)$. Then $forall gamma in Gamma\(N\)= K_N inter G_(bb(Q))^(+)$ #math.equation(block: true, numbering: none, $phi.alt\(gamma g_oo\)= tilde(phi.alt)\(gamma g_oo\,1\)= tilde(phi.alt)\(g_oo\,gamma^(- 1)\)= tilde(phi.alt)\(g_oo\,1\)= phi.alt\(g_oo\)$) So $phi.alt in cal(A)\(Gamma\(N\)\\G_(bb(R))^(+)\)$

]
#statement("Remark")[
Let $K subset.eq G_(hat(bb(Z)))$ be compact open subgroup and $Gamma = K inter G_(bb(Q))^(+)$. Then $Gamma in cal(C)$ and $Gamma\\G_(bb(R))^(+) tilde.equiv G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\/K inter overline(G_(bb(Q))^(+))\)$. $K inter overline(G_(bb(Q))^(+)) = overline(Gamma) = upright("closure of ") Gamma$ in $overline(G_(bb(Q))^(+))$. Since $overline(G_(bb(Q))^(+)) = lim_arrow.l_(Gamma in cal(C)) overline(G_(bb(Q))^(+))\/overline(Gamma)$ by completeness, we have #math.equation(block: true, numbering: none, $lim_arrow.l_(Gamma in cal(C)) Gamma\\G_(bb(R))^(+) tilde.equiv G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)tilde.equiv "SL"_2\(bb(Q)\)\\"SL"_2\(bb(A)\)dot.op Z_(bb(R))^(+)$) This is a fiber bundle over $\["SL"_2\(hat(bb(Z))\)times Z_(bb(R))^(+) K_(bb(R))\]tilde.equiv "SL"_2\(hat(bb(Z))\)times bb(C)^times$. Since $G_(bb(R))^(+)$ is connected, each $Gamma\\G_(bb(R))^(+)$ is connected. So $G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)$ is connected by definition of inverse limit topology

]
Automorphic space $\[G\]= G_(bb(Q))\\G_(bb(A))$ \ Consider the composition $\[G\]= G_(bb(Q))\\G_(bb(A)) arrow.r^det bb(Q)^times\\bb(A) times tilde.equiv bb(R)_(> 0) times hat(bb(Z))^times arrow.r^(upright(p r o j e c t i o n)) hat(bb(Z))^times$, fiber over 1 is $G_(bb(Q))^(+)\\\(G_(bb(R))^(+) times overline(G_(bb(Q))^(+))\)$. Get topological manifold structure on $\[G\]$ such that $pi_0\(\[G\]\)= pi_0\(bb(Q)^times\\bb(A)^times\)= hat(bb(Z))^times$ and each connected component is isomorphic to a fiber bundle over $\["SL"_2\(bb(Z)\)\\cal(H)\]$ with fiber $"SL"_2\(hat(bb(Z))\)times bb(C)^times$. Also note: $"SL"_2\(bb(Q)\)\\"SL"_2\(bb(A)\)= lim_arrow.l_(Gamma in cal(C)) Gamma\\"SL"_2\(bb(R)\)$ is connected and a fiber bundle over $\["SL"_2\(bb(Z)\)\\cal(H)\]$ with fiber $"SL"_2\(hat(bb(Z))\)times "SO"\(2\)$


#pagebreak()

= Automorphic representations on $G L_2\(bb(A)\)$



#pagebreak()

= Representations of $"GL"_2$ over $p$-adic fields

Notation: $F$ is a non-archimedean local field, $cal(O)$ is the ring of integers. $pi.alt$ is a uniformizer, $beta =\(pi.alt\)$ is a maximal ideal of $cal(O)$, residue field is $bb(F)_q$. So $F$ is a finite extension of $bb(Q)_p$ or $bb(F)_p\(\(t\)\)$. $forall x in F$, $\|x\|= q^(- "Vol"\(x\))$

#statement("Fact", title: [Harish-Chandra])[
Any irreducible smooth $G$-representation is admissible. So irreducible smooth $arrow.l.r.double$ irreducible admissible

]
#statement("Definition")[
Contragredient representation

]
#statement("Lemma")[
$\(pi\,V\)$ is an irreducible admissible $G$-representation

+ If $dim V < oo$, then there exists a quasi-character $chi$ such that $pi\(g\)= chi\(det g\)$

+ If $dim V = oo$, there is no non-zero vector fixed by $N$

]
#proof(title: "Proof")[

]
Parabolic induction

#statement("Definition")[
Modules quasi-character $delta : B arrow.r bb(C)^times$, $delta mat(delim: "[", a_1, b; 0, a_2) =\|a_1 / a_2\|$. For a pair of quasi-charactes $chi_1\,chi_2$ veiwed as a quasi-character $chi mat(delim: "[", a_1, b; 0, a_2) = chi_1\(a_1\)chi_2\(a_2\)$. $B\(chi_1\,chi_2\)$ is an admissible $G$-representation Define $Lambda_x :$

]
#statement("Lemma")[
$Lambda_x$ is surjective

]
#statement("Corollary")[
There exists $G$-invariant non degenerate pairing #math.equation(block: true, numbering: none, $$) This induces $quad$

]
#statement("Theorem")[
If $chi_1 chi_2^(- 1) eq.not 1 dot.op 1^plus.minus$, then $cal(B)\(chi_1\,chi_2\)$ is irreducible. If $chi_1 chi_2^(- 1) eq.not 1 dot.op 1^(- 1)$, then $cal(B)\(chi_1\,chi_2\)$ has a unique 1-dimensional $G$-invariant subspace with irreducible quotient. If $chi_1 chi_2^(- 1) eq.not 1 dot.op 1$, then $cal(B)\(chi_1\,chi_2\)$ has a unique irreducible $G$-invariant subspace with 1-dimensional quotient

]
#statement("Definition")[
Principle series #math.equation(block: true, numbering: none, $pi\(chi_1\,chi_2\)= cases(upright("not specified in source"))$) Special representations (or Steinberg representations)

]
#statement("Theorem")[
Each irreducible admissible repesentation of $G$ is iso to one of

+ $pi\(chi_1\,chi_2\)$

+ $sigma\(chi_1\,chi_2\)$

+ supercuspidal representations

Among these, we have $pi\(chi_1\,chi_2\)tilde.equiv pi\(chi_2\,chi_1\)$, $sigma\(chi_1\,chi_2\)tilde.equiv sigma\(chi_2\,chi_1\)$ and no other isomorphisms

]
#statement("Remark")[

]
Unramified representations

#statement("Definition")[

]

#pagebreak()

= Global Whittaker model and multiplicity one



#pagebreak()

= L-functions of modular forms

#statement("Definition")[
For $f in S_k\(Gamma_0\(N\)\,chi\)$ with Fourier expansion $f\(z\)= sum_(n = 1)^oo a_n q^n$, $q = e^(2 pi i z)$. Define a Dirichlet seires $L\(s\,f\)= sum_(n = 1)^oo a_n / n^s$

]
#statement("Lemma")[
$\|a_n\|< < n^(k / 2)$, $forall n gt.eq 1$. Hence $L\(s\,f\)$ converges when $Re\(s\)> k / 2 + 1$

]
#proof(title: "Proof")[
$forall n gt.eq 1$, $y in bb(R)_(> 0)$, $a_n e^(- 2 pi i n y) = integral_0^1 f\(x + i y\)e^(- 2 pi i n y) d x$. Recall that $f\(x + i y\)y^(k / 2)$ is bounded on $cal(H)$ (More generally, any $phi.alt in cal(A)_0\(Gamma\\G_(bb(R))^(+)\)$ is bounded). Take $y = 1 / n$, we get $\|a_n\|lt.eq e^(2 pi) integral_0^1\|f\(x + i / n\)\|d x < < n^(k / 2)$

]
#statement("Definition")[

]

#pagebreak()

= Abelian L-functions



#pagebreak()

= Automorphic L-functions of $"GL"_2$



#pagebreak()
#heading(numbering: none)[References]

Fred Diamond and Jerry Shurman. _A First Course in Modular Forms._

#pagebreak()
#heading(numbering: none)[Index]
#index-list()
