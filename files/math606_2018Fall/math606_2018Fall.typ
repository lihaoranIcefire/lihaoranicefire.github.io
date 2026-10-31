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
#image("Pictures/Georg_Friedrich_Bernhard_Riemann.jpeg",width:50%)
#v(2cm)
Taught by Harry Tamvakis \
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
= Homeworks
<homeworks>
== Homework1
<homework1>
#statement("Problem")[
First not that #math.equation(block: true, numbering: none, $Lambda subset.eq Lambda' quad arrow.l.r.double quad vec(omega_1, omega_2) = A vec(omega'_1, omega'_2)\,A in upright(M)\(2\,bb(Z)\)$) Hence we have #math.equation(block: true, numbering: none, $Lambda = Lambda' quad arrow.l.r.double quad vec(omega_1, omega_2) = A vec(omega'_1, omega'_2)\,vec(omega'_1, omega'_2) = B vec(omega_1, omega_2)\,A\,B in upright(M)\(2\,bb(Z)\)$) Which is equivalent to $A in upright(G L)\(2\,bb(Z)\)$

]
#statement("Problem")[
Since $bb(C)$ is the universal cover of $bb(C)\/Lambda'$, $f compose pi : bb(C) arrow.r bb(C)\/Lambda'$ has a lift $F : bb(C) arrow.r bb(C)$, and locally we have $F = pi'\|_V^(- 1) compose f compose pi\|_U$, thus $F$ is holomorphic

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$bb(C)$]),
node((2,0),[$bb(C)$]),
node((1,1),[$bb(C)\/Lambda$]),
node((2,1),[$bb(C)\/Lambda'$]),
edge((1,0),(2,0),"->",[$F$]),
edge((1,0),(1,1),"->",[$pi$]),
edge((2,0),(2,1),"->",[$pi'$]),
edge((1,1),(2,1),"->",[$f$]))]
]
Fix $omega in Lambda$, since $pi\(z + omega\)= pi\(z\)$ for any $z in bb(C)$, we have $F\(z + omega\)- F\(z\)in Lambda'$, hence $F\(z + omega\)- F\(z\)$ is a continuous function of $z$ but $Lambda'$ is discrete, thus $F\(z + omega\)- F\(z\)equiv C_omega$, where $C_omega in Lambda'$ is a constant. Then $F'\(z + omega\)= F'\(z\)$ which shows $F' : bb(C) arrow.r bb(C)$ is doubly periodic function, thus induces $G : bb(C)\/Lambda arrow.r bb(C)$ with $F = G compose pi$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$bb(C)$]),
node((2,0),[$bb(C)$]),
node((1,1),[$bb(C)\/Lambda$]),
edge((1,0),(2,0),"->",[$F'$]),
edge((1,0),(1,1),"->",[$pi$]),
edge((1,1),(2,0),"->",[$G$]))]
]
Thus $G$ must be a constant, so is $F'$, therefore $F$ has the form $F\(z\)= alpha z + beta$. Then for any $omega in Lambda$, we have $F\(omega\)- F\(0\)= alpha omega in Lambda'$, thus $alpha Lambda subset Lambda'$ If $f$ is biholomorphic, then $pi' compose F = f compose pi arrow.r.double pi compose F^(- 1) = f^(- 1) compose pi'$, which implies ${mat(delim:#none, alpha Lambda subset Lambda'; alpha^(- 1) Lambda' subset Lambda) arrow.r.double alpha Lambda = Lambda'$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$bb(C)$]),
node((2,0),[$bb(C)$]),
node((1,1),[$bb(C)\/Lambda$]),
node((2,1),[$bb(C)\/Lambda'$]),
edge((1,0),(1,1),"->",[$pi$]),
edge((2,0),(1,0),"->",[$F^(- 1)$]),
edge((2,0),(2,1),"->",[$pi'$]),
edge((2,1),(1,1),"->",[$f^(- 1)$]))]
]
Conversely, if $alpha Lambda = Lambda'$, $pi compose F^(- 1)$ is doubly periodic and induce $f^(- 1)$, hence $f$ is biholomorphic

]
#statement("Problem")[
Suppose $Lambda = bb(Z) omega_1 + bb(Z) omega_2\,upright(I m) (omega_2 / omega_1) > 0$, define $Lambda' = bb(Z) + bb(Z) tau$, where $tau = omega_2 / omega_1$, we have $omega_1 Lambda' = Lambda$, thus $X$ and $X\(tau\)$ are biholomorphic.

$X\(tau\)$ and $X\(tau'\)$ are biholomorphic if and only if $vec(tau', 1) = alpha A vec(tau, 1)\,alpha in bb(C) - { 0 }\,A in upright(S L)\(2\,bb(Z)\)$ If $X\(tau\)$ and $X\(tau'\)$ are biholomorphic, then $bb(Z) + bb(Z) tau' = Lambda' = alpha Lambda = bb(Z) alpha + bb(Z) alpha tau$ for some $alpha in bb(C) - { 0 }$, thus $vec(tau', 1) = A vec(alpha tau, alpha) = alpha A vec(tau, 1)$, for some $A in upright(S L)\(2\,bb(Z)\)$, the other direction is easy

]
#statement("Problem")[
Assume it is not the case, then $exists delta > 0$ and $c in bb(C)$ such that $B\(c\,delta\)inter f\(X'\)= diameter$, then consider non-constant holomorphic function $frac(1, f - c) : X' arrow.r bb(C)$, then it is bounded since $lr(|frac(1, f - c)|) lt.eq delta^(- 1)$, by Riemann's removable singularity theorem, we can extend $frac(1, f - c)$ to a non-constant holomorphic function $g : X arrow.r bb(C)$, but since $X$ is compact, $g$ should be a constant, that is a contradiction

]
#statement("Problem")[
$f'\(z\)= 1 / 2 (1 - 1 / z^2)$ when $z eq.not 0$, thus $1\,- 1$ are branch points.

Consider the chart $\(P^1 - { 0 }\,phi\)$ with $phi\(z\)= 1 / z$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(C)$]),
node((1,0),[$bb(P)^1 - { 0 }$]),
node((1,1),[$bb(C)$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(1,1),"->"),
edge((1,0),(1,1),"->",[$phi$]))]
]
Thus $g\(z\)= phi compose f\(z\)= frac(z, 2\(z^2 + 1\))$, $g'\(z\)= frac(1 - z^2, 2\(z^2 + 1\))$, hence $0$ is not a branch point

]
#pagebreak(weak:true)
== Homework2
<homework2>
#statement("Problem")[
Using the exactness of #math.equation(block: true, numbering: none, $0 arrow.r bb(C) arrow.r.hook cal(O) arrow.r^d cal(O) arrow.r 0$) we have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r H^0\(Omega\,bb(C)\)arrow.r H^0\(Omega\,cal(O)\)arrow.r^d H^0\(Omega\,cal(O)\)arrow.r H^1\(Omega\,bb(C)\)arrow.r H^1\(Omega\,cal(O)\)$) but according to Mittag-Leffler's theorem, we know that $H^1\(Omega\,cal(O)\)= 0$, thus we have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r bb(C)\(Omega\)arrow.r cal(O)\(Omega\)arrow.r^d cal(O)\(Omega\)arrow.r H^1\(Omega\,bb(C)\)arrow.r 0$) Thus $dim upright(c o k e r) d = dim H^1\(Omega\,bb(C)\)$, also from this we know that $H^1\(Omega\,bb(C)\)= 0$ if $Omega$ is simply connected

#strong[\(i)]

For any $k gt.eq 0$, Take $Omega$ to be $bb(C) - { 1\,dots.h.c\,k }$, Consider covering #math.equation(block: true, numbering: none, $U_1 := bb(C) -\[1\,oo\)\,U_i := bb(C) -\(- oo\,i - 1\]-\[i\,oo\)\,dots.h.c\,U_(k + 1) := bb(C) -\(- oo\,k\]\,(forall 2 lt.eq i lt.eq k)$)Then ${ U_i }_(i = 1)^(k + 1)$ forms a Leray covering since $U_i$ is simply connected and $H^1\(U_i\,bb(C)\)= 0$, hence $H^1\(Omega\,bb(C)\)= H^1\(cal(U)\,bb(C)\)$

Notice that $U_i inter U_j = { upright(I m) z > 0 } union { upright(I m) z < 0 }\,i eq.not j$

For any $\(c_(i j)\)in Z^1\(cal(U)\,bb(C)\)$, according to cocycle relation, we only need to know ${ c_12\,c_23\,dots.h.c\,c_(k\,k + 1) }$, and each $c_(i\,i + 1)$ has two components, let's denote as $c_(i\,i + 1)^(+)\,c_(i\,i + 1)^(-) in bb(C)$, thus $Z^1\(cal(U)\,bb(C)\)tilde.equiv bb(C)^(2 k)$, on the other hand, for any $\(c_i\)in C^0\(cal(U)\,bb(C)\)$, $delta (\( c_i \)) =\(c_i - c_j\)$, thus $B^1\(cal(U)\,bb(C)\)$ is the subgroup of $Z^1\(cal(U)\,bb(C)\)$ consists of exactly elements with $c_(i\,i + 1)^(+) = c_(i\,i + 1)^(-)$, thus $Z^1\(cal(U)\,bb(C)\)tilde.equiv bb(C)^k$ and $H^1\(cal(U)\,bb(C)\)= Z^1\(cal(U)\,bb(C)\)\/B^1\(cal(U)\,bb(C)\)tilde.equiv bb(C)^k$, thus $dim H^1\(cal(U)\,bb(C)\)= k$

#strong[\(ii)]

Take $Omega$ to be $bb(C) - bb(Z)_(> 0)$, and consider covering#math.equation(block: true, numbering: none, $U_1 := bb(C) -\[1\,oo\)\,dots.h.c\,U_i := bb(C) -\(- oo\,i - 1\]-\[i\,oo\)\,dots.h.c\,(i gt.eq 2)$)Then ${ U_i }_(i = 1)^oo$ forms a Leray covering since $U_i$ is simply connected and $H^1\(U_i\,cal(C)\)= 0$, hence $H^1\(Omega\,cal(C)\)= H^1\(cal(U)\,cal(C)\)$

Notice that $U_i inter U_j = { upright(I m) z > 0 } union { upright(I m) z < 0 }\,i eq.not j$

For any $\(c_(i j)\)in Z^1\(cal(U)\,bb(C)\)$, according to cocycle relation, we only need to know ${ c_12\,dots.h.c\,c_(k\,k + 1)\,dots.h.c }$, and each $c_(i\,i + 1)$ has two components, let's denote as $c_(i\,i + 1)^(+)\,c_(i\,i + 1)^(-) in bb(C)$, on the other hand, for any $\(c_i\)in C^0\(cal(U)\,bb(C)\)$, $delta (\( c_i \)) =\(c_i - c_j\)$, thus $B^1\(cal(U)\,bb(C)\)$ is the subgroup of $Z^1\(cal(U)\,bb(C)\)$ consists of exactly elements with $c_(i\,i + 1)^(+) = c_(i\,i + 1)^(-)$, thus $H^1\(cal(U)\,bb(C)\)= Z^1\(cal(U)\,bb(C)\)\/B^1\(cal(U)\,bb(C)\)$ is of infinite dimension

]
#statement("Problem")[
#strong[\(a)]

Suppose $alpha_X\(f\)= 0\,f in H^0\(X\,cal(F)\)= cal(F)\(X\)$, then $alpha_x\(f\|_x\)= 0$, $f\|_x$ being the germ of $f$ at $x$, by the injectivity of $alpha$, we know that $f\|_x = 0 = 0\|_x$, thus $exists U_x in.rev x$ such that $f\|_(U_x) = 0$, and also $X = union.big_(x in X) U_x$, thus by the sheaf axiom, we know that $f = 0$, hence $alpha_X$ is injective

#strong[\(b)]

We know that $beta alpha = 0$, thus $(beta alpha)_x\(f\|_x\)= 0\,forall f in cal(F)\(X\)$, as argued above, we know that $f = 0$, thus $beta_X alpha_X = (beta alpha)_X = 0$

On the other hand, $forall g in ker beta_X$, $beta_X\(g\)= 0$, thus $beta_x\(g\|_x\)= 0$, $exists V_x in.rev x$ such that $beta_(V_x)\(g\)= 0$, also, $exists f_x in cal(F)\(U_x\)$ such that $alpha_(U_x)\(f_x\)= g\|_(U_x)$ where $x in U_x subset V_x$. Thus, for any $U_x inter U_y eq.not diameter$, then $alpha_(U_x inter U_y)\(f_x - f_y\)= 0$, but for the same reason we know that $alpha_(U_x inter U_y)$ is injective, thus $f_x = f_y$ on $U_x inter U_y$, by sheaf axiom, there exists $f in cal(F)\(X\)$ such that $f\|_(U_x) = f_x$, hence $g = alpha\(f\)$, therefore $upright(i m) alpha_X = ker beta_X$

#strong[\(c)]

$forall g in H^0\(X\,cal(G)\)\,forall cal(U)$, $beta_(U_i)\(g\|_(U_i)\)= beta_X\(g\)\|_(U_i)\,g - g\|_(U_i inter U_j) = 0 in ker beta_(U_i inter U_j) = upright(i m) alpha_(U_i inter U_j)$, and since $alpha_(U_i inter U_j)$ is injective, thus $delta compose beta_X\(g\)= 0$

On the other hand, $forall h in ker delta\,exists cal(U)\,exists g_i in cal(G)\(U_i\)$, such that $beta_(U_i)\(g_i\)= h\|_(U_i)$, and $g_i - g_j\|U_i inter U_j in ker beta_(U_i inter U_j) = upright(i m) alpha_(U_i inter U_j)$, $exists_1 f_(i j) in cal(F)\(U_i inter U_j\)$ with $alpha_(U_i inter U_j)\(f_(i j)\)= g_i - g_j\|U_i inter U_j$, then $exists cal(f_i) in cal(F)\(U_i\)$ such that $f_(i j) = f_i - f_j\|U_i inter U_j$, observe that on $U_i inter U_j$ #math.equation(block: true, numbering: none, $(alpha_(U_i) \( f_i \) - g_i) - (alpha_(U_j) \( f_j \) - g_j) & = (alpha_(U_i) \( f_i \) - alpha_(U_j) \( f_j \)) - (g_i - g_j)\
 & = alpha_(U_i inter U_j)\(f_i - f_j\)- (g_i - g_j)\
 & = 0$) Thus $exists g in cal(G)\(X\)$ such that $g\|_(U_i) = alpha_(U_i)\(f_i\)- g_i$, then we have $beta_(U_i)\(g\|_(U_i)\)= beta_(U_i)\(alpha_(U_i)\(f_i\)- g_i\)= beta_(U_i)\(g_i\)= h\|_(U_i)$, hence $beta_X\(g\)= h$, therefore $upright(i m) beta_X = ker delta$

]
#statement("Problem")[
#strong[\(a)]

Suppose $s_1\,s_2$ are nonzero meromorphic sections of $L$ over $X$, then there exists nonzero meromorphic function $f$ on $X$ such that $s_2 = f s_1$, if $f$ is constant, surely $upright(d i v)\(s_1\)= upright(d i v)\(s_2\)$, otherwise, $f : X arrow.r bb(P)^1$ would be a non-constant proper holomorphic mapping which has as many zeros as poles, thus $upright(d i v)\(f\)= 0$, therefore $upright(d i v)\(s_1\)= upright(d i v)\(f\)+ upright(d i v)\(s_2\)= upright(d i v)\(s_2\)$, thus $deg\(L\)$ is well-defined

#strong[\(b)]

Define $f_1\(z\)= z^k$ on $U_1$ and $f_2\(z\)= 1$ on $U_2$, then $f_1 = g_12 f_2$, thus $f_i$ defines a section $s$ of $L_k$ over $bb(P)^1$, hence $deg L_k = upright(d i v)\(s\)= k$

#strong[\(c)]

Define $f_1\(z\)= g_12\(z\)$ on $U_1$ and $f_2\(z\)= 1$ on $U_2$, then $f_1 = g_12 f_2$, thus $f_i$ defines a section $s$ of $L_k$ over $bb(P)^1$, since $g_12\(z\)eq.not 0$ is holomorphic on $U_1 inter U_2$, thus $f_1$ can only have zeros or poles at $0$, hence $deg L_k = upright(d i v)\(s\)= frac(1, 2 pi i) integral_(\|z\|= 1) frac(g'_12\(z\), g_12\(z\)) d z$ by argument principle

]
#statement("Problem")[
Suppose $L$ and $L^(*)$ both have non-trivial global holomorphic sections $s_1$ and $s_2$, let $D_1 := upright(d i v)\(S_1\)$, $D_2 := upright(d i v)\(S_2\)$, then $L tilde.equiv L\(D_1\)$, $L^(*) tilde.equiv L\(D_2\)tilde.equiv L\(- D_1\)$, which is equivalent to $D_1\,D_2 gt.eq 0$ and $D_1 + D_2 = upright(d i v)\(f\)$ for some meromorphic function $f$ on $X$. Since $0 lt.eq deg\(D_1 + D_2\)= deg upright(d i v)\(f\)= 0$, $D_1 + D_2 = 0$, hence $D_1 = - D_2 lt.eq 0 lt.eq D_1$, thus $D_1 = 0$, $L tilde.equiv cal(O)$ is trivial

Conversely, if $L$ is trivial, constant could be a global holomorphic section on both $L$ and $L^(*)$

]
#statement("Problem")[
There exists such a sequence.

Consider $K_n := { 0 } union { r e^(i theta) in bb(C)\|r in\[1 / n\,n\]\,theta in\[1 / n\,2 pi\]} subset bb(C)$ is a compact set, we can define a holomorphic function $f_n$ on a open neighborhood of $K_n$ such that $f\(0\)= 1$ and $f\|_(K_n\\{ 0 }) = 0$, then using Runge's approximation theorem, we can find a polynomial $Q_n$ such that $\|Q_n - f_n\|< 1 / n$ on $K_n$, then define $P_n = frac(Q_n, Q_n\(0\))$, we can easily verify that $P_n$ could be a desired sequence

]
#pagebreak(weak:true)
== Homework3
<homework3>
#statement("Problem")[
In the proof of finiteness theorem, we have $∥s∥_U lt.eq A ∥s∥_V$ \ where $A := max_(i\,j) sup_(x in U_i inter U_j) ∥g_(i j) \( x \)∥$, $forall s in H^0\(X\,L\)$ \ $forall s in H^0\(X\,L\)\,upright(o r d)_(a_i) s_i gt.eq l$, $∥s∥_U lt.eq A ∥s∥_V lt.eq 2^(- l) A ∥s∥_U$, thus #math.equation(block: true, numbering: none, $H^0\(X\,L\)arrow.r xor.big_(i = 1)^N bb(C) times.o (cal(O)_(a_i) \/ m_i^l)\,thin s mapsto xor.big_(i = 1)^N (s_i thin upright(m o d) thin z_i^l)$) is injective if $2^l > A$, thus $dim H^0\(X\,L\)lt.eq N l = : C$ \ But now we have $∥s∥_U lt.eq A^k ∥s∥_V$, $forall s in H^0\(X\,L\)$ \ since $\|s_i\(x\)\|=\|g_(i j)\(x\)^k s_j\(x\)\|lt.eq ∥g_(i j) \( x \)∥^k\|s_j\(x\)\|$ \ $forall s in H^0\(X\,L^k\)\,upright(o r d)_(a_i) s_i gt.eq k l$, $∥s∥_U lt.eq A ∥s∥_V lt.eq 2^(- k l) A ∥s∥_U$, thus #math.equation(block: true, numbering: none, $H^0\(X\,L^k\)arrow.r xor.big_(i = 1)^N bb(C) times.o (cal(O)_(a_i) \/ m_i^(k l))\,thin s mapsto xor.big_(i = 1)^N (s_i thin upright(m o d) thin z_i^(k l))$) is injective if $2^l > A arrow.r.double 2^(k l) > A^k$, thus $dim H^0\(X\,L^k\)lt.eq N k l = : C k$

]
#statement("Problem")[
Suppose there are more than $2 k$ fixed points of $sigma$, then consider $f - f compose sigma^(- 1) : X arrow.r bb(P)^1$ is holomorphic on $X\\{ a\,sigma^(- 1)\(a\)}$ with at least $2 k + 1$ zeros and with poles of order $k$ at $a\,sigma^(- 1)\(a\)$, but it should have as many poles as zeros which is a contradiction

]
#statement("Problem")[
The genus $g$ of $bb(P)^1$ is $0$

If $deg D < 0$, then $forall f in H^0\(bb(P)^1\,cal(O)_D\)subset.eq cal(M)\(bb(P)^1\)$, then $0 = deg upright(d i v)\(f\)gt.eq deg\(- D\)= - deg D > 0$ which is impossible, hence $dim H^0\(bb(P)^1\,cal(O)_D\)= 0$ and $dim H^1\(bb(P)^1\,cal(O)_D\)= - 1 - deg D$

If $deg D gt.eq 0$, since from the long exact sequence we already knew that $H^1\(bb(P)^1\,cal(O)'_D\)arrow.r H^0\(bb(P)^1\,cal(O)_D\)arrow.r 0$ is exact if $D' lt.eq D$, and we can always find a $D'$ such that $D' lt.eq D$ and $deg D' < 0$, then $0 = dim H^1\(bb(P)^1\,cal(O)'_D\)gt.eq dim H^1\(bb(P)^1\,cal(O)_D\)gt.eq 0$, thus $dim H^1\(bb(P)^1\,cal(O)_D\)= 0$ and $dim H^0\(bb(P)^1\,cal(O)_D\)= 1 + deg D$

Therefore, we have

#math.equation(block: true, numbering: none, $ & dim H^0\(bb(P)^1\,cal(O)_D\)= max (0 \, 1 + deg D)\
 & dim H^1\(bb(P)^1\,cal(O)_D\)= max (0 \, - 1 - deg D)$)

]
#statement("Problem")[
#align(center)[
#svg-drawing("<path d='M70 230L250 185' marker-end='url(#a)'/><path d='M250 185L295 50' marker-end='url(#a)'/><path d='M295 50L115 95' marker-end='url(#a)'/><path d='M115 95L70 230' marker-end='url(#a)'/><g fill='black' stroke='none' font-family='serif' font-size='14'><text x='50' y='249'>z₀</text><text x='154' y='220'>L₁</text><text x='283' y='120'>L₂</text><text x='200' y='62'>L₃</text><text x='67' y='165'>L₄</text><text x='165' y='140'>P(z₀)</text></g>", height: 275)
]
#strong[a.]

Since $f$ is elliptic, $integral_(L_1) f\(z\)d z = - integral_(L_3) f\(z\)d z\,integral_(L_2) f\(z\)d z = - integral_(L_4) f\(z\)d z$, thus $integral_(partial P\(z_0\)) f\(z\)d z = integral_(L_1) f\(z\)d z + integral_(L_2) f\(z\)d z + integral_(L_3) f\(z\)d z + integral_(L_4) f\(z\)d z = 0$

#strong[b.]

As the same reason in (a), we have $frac(1, 2 pi i) integral_(partial P\(z_0\)) frac(f'\(z\), f\(z\)) d z = 0$, by argument principle, we know in the interior of $P\(z_0\)$, there are as many zeros as poles, counted multiplicities

]
#statement("Problem")[
Consider $frac(1, 2 pi i) integral_(partial P\(z_0\)) frac(z f'\(z\), f\(z\)) d z = sum_(j = 1)^n\(z_j - w_j\)$

On the other hand, #math.equation(block: true, numbering: none, $ & - frac(1, 2 pi i) integral_(L_3) frac(z f'\(z\), f\(z\)) d z = frac(1, 2 pi i) integral_(L_1) frac(\(z + omega_2\)f'\(z\), f\(z\)) d z\
 & frac(1, 2 pi i) integral_(L_2) frac(z f'\(z\), f\(z\)) d z = - frac(1, 2 pi i) integral_(L_4) frac(\(z + omega_1\)f'\(z\), f\(z\)) d z$) Thus #math.equation(block: true, numbering: none, $frac(1, 2 pi i) integral_(partial P\(z_0\)) frac(z f'\(z\), f\(z\)) d z = frac(1, 2 pi i) (integral_(L_1) + integral_(L_2) + integral_(L_3) + integral_(L_4)) frac(z f'\(z\), f\(z\)) d z = - frac(omega_1, 2 pi i) integral_(L_4) frac(f'\(z\), f\(z\)) d z - frac(omega_2, 2 pi i) integral_(L_1) frac(f'\(z\), f\(z\)) d z$) Hence we only need to show $frac(1, 2 pi i) integral_(L_1) frac(f'\(z\), f\(z\)) d z\,frac(1, 2 pi i) integral_(L_4) frac(f'\(z\), f\(z\)) d z in bb(Z)$, but #math.equation(block: true, numbering: none, $frac(1, 2 pi i) integral_(L_1) frac(f'\(z\), f\(z\)) d z = frac(1, 2 pi i) integral_(L_1) frac(d\(f\(z\)\), f\(z\)) = frac(1, 2 pi i) integral_(f\(L_1\)) frac(d z, z) = k$) For some $k in bb(Z)$

]
#pagebreak(weak:true)
== Homework4
<homework4>
#statement("Problem")[
If $f equiv c$ is a constant, then $P\(x\,y\)= x - c$ is an irreducible polynomial such that $P\(f\,g\)= 0$, so we can assume $f\,g$ are not constants, Since $cal(M)\(X\)$ is a finite algebraic extension of $bb(C)\(f\)$, there exists rational functions $R_0\,dots.h.c\,R_n$ such that $R_0\(f\)+ R_1\(f\)g + dots.h.c + R_n\(f\)g^n = 0$, then after multiplying denominators, we get a polynomial $P\(x\,y\)in bb(C)\[x\,y\]$ such that $P\(f\,g\)= 0$, since $bb(C)\[x\,y\]$ is a UFD, $P = P_1 dots.h.c P_k$, where $P_i$ are prime hence irreducible, then $0 = P_1\(f\,g\)dots.h.c P_k\(f\,g\)in cal(M)\(X\)$ which is a field, thus $P_j\(f\,g\)= 0$ for some irreducible polynomial $P_j in bb(C)\[x\,y\]$

]
#statement("Problem")[
If $f$ is an elliptic function of order $n$, then $f\(z + omega\)= f\(z\)\,forall omega in Omega$, which implies $f'\(z + omega\)= f'\(z\)\,forall omega in Omega$, thus $f'$ is also elliptic, suppose $f$ has $\[P_1\]\,dots.h.c\,\[P_k\]$ as its poles with multiplicities $r_1\,dots.h.c\,r_k$, $sum r_i = n$, then $f'$ also has $\[P_1\]\,dots.h.c\,\[P_k\]$ as its poles with multiplicities $r_1 + 1\,dots.h.c\,r_k + 1$, $sum r_i = n + k = m$, since $1 lt.eq k lt.eq n$, $n + 1 lt.eq m lt.eq 2 n$

We can find an elliptic function $f$ of order $n$ which has $\[P_1\]\,dots.h.c\,\[P_(n - m)\]$ as its poles with multiplicities $1\,dots.h.c\,1\,2 n + 1 - m$, then we get $f'$ is another elliptic function which also has $\[P_1\]\,dots.h.c\,\[P_(n - m)\]$ as its poles with multiplicities $2\,dots.h.c\,2\,2 n + 2 - m$, thus $f'$ is of order $m$

]
#statement("Problem")[
$℘'\(z\)$ has a pole at $z = 0$ of order $3$ and $omega_1 / 2\,omega_2 / 2\,omega_3 / 2$ as simple roots, thus #math.equation(block: true, numbering: none, $℘'\(z\)= lambda frac(sigma (z - omega_1 / 2) sigma (z - omega_2 / 2) sigma (z - omega_3 / 2), sigma\(z\)^3)$) for some $lambda in bb(C)$, multiply by $z^3$ on both sides, and let $z arrow.r 0$, since $lim_(z arrow.r 0) frac(z, sigma\(z\)) = 1\,lim_(z arrow.r 0) z^3 ℘'\(z\)= - 2$, we have $- 2 = - lambda sigma (omega_1 / 2) sigma (omega_2 / 2) sigma (omega_3 / 2) arrow.r.double lambda frac(2, sigma (omega_1 / 2) sigma (omega_2 / 2) sigma (omega_3 / 2))$

Hence $℘'\(z\)= frac(2 sigma (z - omega_1 / 2) sigma (z - omega_2 / 2) sigma (z - omega_3 / 2), sigma (omega_1 / 2) sigma (omega_2 / 2) sigma (omega_3 / 2) sigma\(z\)^3)$

]
#statement("Problem")[
$\(i\)arrow.r.double\(i i\)$

$g_2 = 60 G_4\,g_3 = 140 G_6 in bb(R) arrow.r.double G_4\,G_6 in bb(R)$

Since #math.equation(block: true, numbering: none, $ & ℘\(z\)= 1 / z^2 + sum_(n = 2)^oo\(2 n - 1\)G_(2 n) z^(2 n - 2) = 1 / z^2 + 3 G_4 z^2 + 5 G_6 z^4 + 7 G_8 z^6 + 9 G_10 z^8 + dots.h.c\
 & ℘'\(z\)= - 2 / z^3 + sum_(n = 2)^oo\(2 n - 1\)\(2 n - 2\)G_(2 n) z^(2 n - 3) = - 2 / z^3 + 6 G_4 z + 20 G_6 z^3 + 42 G_8 z^5 + 72 G_10 z^7 + dots.h.c\
 & ℘''\(z\)= 6 / z^4 + sum_(n = 2)^oo\(2 n - 1\)\(2 n - 2\)\(2 n - 3\)G_(2 n) z^(2 n - 4) = 6 / z^4 + 6 G_4 + 60 G_6 z^2 + 210 G_8 z^4 + 504 G_10 z^6 + dots.h.c$) So we can conclude $℘''\(z\)- 6 ℘\(z\)^2 + 30 G_4 = z phi\(z\)$, where $phi\(z\)$ is a holomorphic elliptic function, hence $℘''\(z\)- 6 ℘\(z\)^2 + 30 G_4 = 0$, then the coefficients of $z^(2 n)\(n gt.eq 1\)$ would be $\(2 n + 1\)\(2 n + 2\)\(2 n + 3\)\(2 n + 4\)G_(2 n + 4) - 6\(2 n + 3\)G_(2 n + 4)$ minus terms only involving $G_4\,G_6\,dots.h.c\,G_(2 n + 2)$ and real numbers, thus by induction, we know $G_(2 n + 4) in bb(R)\(n gt.eq 1\)$

$\(i i\)arrow.r.double\(i i i\)$

Since $℘\(z\)= 1 / z^2 + sum_(n = 2)^oo\(2 n - 1\)G_(2 n) z^(2 n - 2)$, if $G_k in bb(R)\(k gt.eq 3\)$, then $℘\(macron(z)\)= overline(℘\(z\))$

$\(i i i\)arrow.r.double\(i v\)$

The poles of $overline(℘\(macron(z)\)) = ℘\(z\)$ are exactly $overline(Omega)$, thus $overline(Omega) = Omega$

$\(i v\)arrow.r.double\(i\)$

$g_2 = 60 G_4 = 60 sum_(omega in Omega^(*)) 1 / omega^4 = 60 sum_(omega in overline(Omega)^(*)) 1 / omega^4 = overline(g_2) arrow.r.double g_2 in bb(R)$, similarly, $g_6 in bb(R)$

]
#statement("Problem")[
If $Omega$ is real rectangular or real rhombic, $Omega$ is obviously a real lattice

Conversely, if $Omega$ is a real lattice, suppose $Omega = bb(Z) omega_1 + bb(Z) omega_2$, then there exists $omega in Omega\\\(bb(R) union i bb(R)\)$, otherwise, $omega_1 in bb(R)^(*)\,omega_2 in i bb(R)^(*)$ or $omega_2 in bb(R)^(*)\,omega_1 in i bb(R)^(*)$, since $omega_1\,omega_2$ are linear independent, but then $omega = omega_1 + omega_2 in Omega\\\(bb(R) union i bb(R)\)$ which is a contradiction

Since $omega in Omega\\\(bb(R) union i bb(R)\)$, $omega + overline(omega) in bb(R)^(*)\,omega - overline(omega) in i bb(R)^(*)$, thus $Omega inter bb(R)^(*) eq.not diameter\,Omega inter i bb(R)^(*) eq.not diameter$, let $eta_1 = min_(eta in Omega inter\(0\,oo\)) eta$, then $Omega inter bb(R) = bb(Z) eta_1$, otherwise $exists eta in bb(R)\\bb(Z) eta_1$, then $eta - ⌊eta / eta_1⌋ eta_1 in Omega inter\(0\,oo\)$ which is a contradiction

Similarly, $Omega inter i bb(R) = bb(Z) eta_2$ for some $eta_2 in i\(0\,oo\)$. If $Omega = bb(Z) eta_1 + bb(Z) eta_2$, then $Omega$ is real rectangular, if not, $exists gamma in Omega\\\(bb(R) union i bb(R)\)$, such that $\|gamma\|= min_(omega in Omega\\\(bb(R) union i bb(R)\))\|omega\|$, then $gamma + overline(gamma) = eta_1$ or $- eta_1$, otherwise $gamma + overline(gamma) = k eta_1$ for some $\|k\|gt.eq 2$

If $k = 2$, then $gamma - eta_1 = eta_1 - overline(gamma) = - overline(\(gamma - eta_1\)) arrow.r.double gamma - eta_1 in i bb(R) arrow.r.double gamma in bb(Z) eta_1 + bb(Z)\(gamma - eta_1\)subset.eq bb(Z) eta_1 + bb(Z) eta_2$

If $k > 2$, then $gamma - eta_1 in.not bb(R) union i bb(R)$ and $\|gamma - eta_1\|<\|gamma\|$, similarly for $k lt.eq - 2$, these are all contradictions

Similarly, we know that $gamma - overline(gamma) = eta_2$ or $- eta_2$

Now, for any $omega in Omega\\\(bb(R) union i bb(R)\)$, $omega + overline(omega) = k eta_1 = k\(gamma + overline(gamma)\)$ for some $k eq.not 0$, then $omega - k gamma = k overline(gamma) - overline(omega) = - overline(\(omega - k gamma\)) arrow.r.double omega - k gamma in i bb(R)$, if $omega eq.not k gamma$, then $omega - k gamma = l eta_2 = l\(gamma - overline(gamma)\)arrow.r.double omega in bb(Z) gamma + bb(Z) overline(gamma)$, therefore, we have $Omega = bb(Z) gamma + bb(Z) overline(gamma)$, $Omega$ is real rhombic

]
#statement("Problem")[
The number of connected components of $E_(bb(R))$ is one or two if $p\(x\)= 0$ has one real root and two nonreal conjugate complex roots or three distinct real roots correspondingly

Since $omega_1 / 2\,omega_2 / 2\,omega_3 / 2$ are simple roots of $℘'\(z\)$, the three simple roots of $p\(x\)$ are $℘ (omega_1 / 2)\,℘ (omega_2 / 2)\,℘ (omega_3 / 2)$, since $Omega$ is a real lattice, $G_k in bb(R)$ and $℘\(z\)= 1 / z^2 + sum_(n = 2)^oo\(2 n - 1\)G_(2 n) z^(2 n - 2)$

If $Omega$ is real rectangular, then $℘ (omega_1 / 2)\,℘ (omega_2 / 2)$ are both real, thus $E_(bb(R))$ has two connected components

If $Omega$ is real rhombic, then $℘ (omega_3 / 2)$ is real $℘ (omega_1 / 2) eq.not ℘ (omega_2 / 2)$ are nonreal conjugate, thus $E_(bb(R))$ has only one connected component

]
#pagebreak(weak:true)
== Homework5
<homework5>
#statement("Problem")[
$(e^(frac(2 pi k i, n)) \, 0)\,\(0 lt.eq k lt.eq n - 1\)$ are branch points with degree $n$, apply Riemann-Hurwitz formula, we have $2 g - 2 = n\(2 dot.op 0 - 2\)+ n\(n - 1\)$, thus $g = frac(\(n - 1\)\(n - 2\), 2)$

]
#statement("Problem")[
Need to check $0 arrow.r bb(C)_x arrow.r cal(M)_x arrow.r^(upright(d)) cal(N)_x arrow.r 0$ is exact

$bb(C)_x arrow.r cal(M)_x$ is injective is easy, if we write $sum_(nu = - k)^oo a_nu\(z - x\)^nu in cal(M)_x$, $upright(d) a_0 = 0$ and $upright(r e s)_x (sum_(nu = - k)^oo a_nu \( z - x \)^nu) = 0 arrow.r.double a_0 = 0$, thus $bb(C)_x arrow.r cal(M)_x arrow.r^(upright(d)) cal(N)_x$ is exact, also, since $upright(d)\(z - x\)^nu = nu\(z - x\)^(nu - 1)$, $cal(M)_x arrow.r^(upright(d)) cal(N)_x$ is surjective. Therefore, we have long exact sequence #math.equation(block: true, numbering: none, $0 arrow.r bb(C)\(X\)arrow.r cal(M)\(X\)arrow.r^(upright(d)) cal(N)\(X\)arrow.r H^1\(X\,bb(C)\)arrow.r H^1\(X\,cal(M)\)= 0$) Thus $H^1\(X\,bb(C)\)tilde.equiv cal(N)\(X\)\/upright(d) cal(M)\(X\)$

]
#statement("Problem")[

]
#statement("Problem")[
Define $D =\(2 g + 1\)P$, $L = L\(D\)$ is line bundle satisfies $deg L > 2 g$, using embedding theorem, choose a basis ${ s_0\,dots.h.c\,s_N }$ of $H^0\(X\,L\)$, such that $s_0 = s_D$, $phi_L : X arrow.r bb(P)^N$, by sending $x$ to $\[s_0\,dots.h.c\,s_N\]$, but since $s_D\(x\)eq.not 0$, $forall x eq.not P$, hence $phi_L : X\\{ P } arrow.r bb(C)^N$ by sending $x$ to $(s_1 / s_0 \, dots.h.c \, s_N / s_0)$ is also an embedding

]
#statement("Problem")[
Since $k^(n + 1) = union.sq.big_(alpha in k) alpha + k^n$, $\|k^(n + 1)\|=\|k\|\|k^n\|$, by induction and $\|k\|= q = p^r$, $\|k^n\|= q^n = p^(n r)$

On the other hand, since $P^n\(k\)= k^(n + 1) - { 0 } #scale(x: 120%, y: 120%)[$\/$] tilde.op$, #math.equation(block: true, numbering: none, $\|P^n\(k\)\|= frac(\|k^(n + 1)\|- 1, \|k^(*)\|) = frac(q^n - 1, q - 1) = frac(p^(n r) - 1, p^r - 1)$)

]
#statement("Problem")[
#strong[\(a)]

Consider all the picks of two different checkers in the same row, which essentially give picks of two different columns, the two columns given by these picks are all distinct, otherwise, four of the checkers will be centered on the vertices of a rectangle with sides parallel to the sides of the board, hence the number of picks is no more than the number of picks of two different columns. Therefore, we have #math.equation(block: true, numbering: none, $sum_(i = 1)^k frac(x_i\(x_i - 1\), 2) lt.eq frac(k\(k - 1\), 2)$) #strong[\(b)]

First let's state a fact: If $x_i gt.eq 0$, then #math.equation(block: true, numbering: none, $(sum_(i = 1)^n x_i)^2 = sum_(i\,j = 1)^n x_i x_j lt.eq sum_(i\,j = 1)^n (x_i^2 / 2 + x_j^2 / 2) = n (sum_(i = 1)^n x_i^2)$) Equality holds if and only if $x_i$ are the same

For any $k$ such that $k - 1 = q\(q - 1\)$ where $q gt.eq 1$ is some integer, if we let $q = p + 1$, then $k = 1 + p + p^2$

Use the fact above, we know that #math.equation(block: true, numbering: none, $frac(k\(k - 1\), 2) gt.eq sum_(i = 1)^k frac(x_i\(x_i - 1\), 2) = frac(sum_(i = 1)^k x_i^2, 2) - frac(sum_(i = 1)^k x_i, 2) gt.eq frac((sum_(i = 1)^k x_i)^2, 2 k) - frac(sum_(i = 1)^k x_i, 2) = frac(n^2, 2 k) - n / 2$) But, when $x_i = q = p + 1$, both of inequalities become equalities, thus $n = k\(p + 1\)$ is the maximum possible value for $n$

#strong[\(i)]

$k = 7 = 1 + 2 + 2^2 arrow.r.double p = 2 arrow.r.double n = 21$

#strong[\(ii)]

$k = 13 = 1 + 3 + 3^2 arrow.r.double p = 3 arrow.r.double n = 52$

]
#pagebreak(weak:true)
#pagebreak(weak:true)

#pagebreak()
#heading(numbering:none)[References]
#emph[Compact Riemann Surfaces] - R. Narasimhan

#emph[Lectures on Riemann Surfaces] - Otto Forster


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
