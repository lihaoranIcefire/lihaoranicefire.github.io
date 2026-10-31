#set document(title: "MATH868C - Several Complex Variables", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(font: "New Computer Modern", size: 10pt, lang: "en")
#set par(justify: true)
#set heading(numbering: "1.1")
#set math.equation(numbering: none)
#let numbered-equation(body) = math.equation(
  block: true,
  numbering: number => context numbering("(1.1)", counter(heading).get().first(), number),
  body,
)

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
  if target != none and (target.func() == figure or target.func() == math.equation) {
    let location = target.location()
    let equation = target.func() == math.equation
    let target-counter = if equation { counter(math.equation) } else { counter(figure.where(kind: "statement")) }
    link(location, numbering(
      if equation { "(1.1)" } else { "1.1" },
      counter(heading).at(location).first(),
      target-counter.at(location).first(),
    ))
  } else {
    it
  }
}
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "statement")).update(0)
  counter(math.equation).update(0)
  it
}
#let proof(title: "Proof", body) = block(width: 100%, breakable: true)[
  _#title._ #body #h(1fr) $square$
]
#let aside(name, title: none, body) = block(width: 100%, breakable: true)[
  _#name#if title != none [ (#title)]._ #body
]
#let index-entry(term) = metadata((kind: "index-entry", term: term))
#let index-list() = context {
  let entries = query(metadata).filter(it => it.value.kind == "index-entry")
  let terms = entries.map(it => it.value.term).dedup().sorted(key: lower)
  columns(2, gutter: 2em)[
    #for term in terms {
      let matches = entries.filter(it => it.value.term == term)
      let pages = matches.map(it => it.location().page()).dedup()
      let links = pages.map(page => {
        let entry = matches.find(it => it.location().page() == page)
        link(entry.location(), str(page))
      })
      par[#term #h(1fr) #links.join[, ]]
    }
  ]
}
#let removable-singularity-diagram() = box(width: 64mm, height: 68mm)[
  #place(top + left, dx: 2mm, dy: 2mm, circle(radius: 30mm, stroke: 0.6pt))
  #place(top + left, dx: 29mm, dy: 29mm, circle(radius: 3mm, stroke: 0.6pt))
  #place(top + left, dx: 41mm, dy: 17mm, circle(radius: 3mm, stroke: 0.6pt))
  #place(top + left, dx: 31.85mm, dy: 31.85mm, circle(radius: 0.15mm, fill: black))
  #place(top + left, dx: 43.85mm, dy: 19.85mm, circle(radius: 0.15mm, fill: black))
  #place(top + left, dx: 30mm, dy: 36mm, $z_0$)
  #place(top + left, dx: 43mm, dy: 24mm, $w$)
]
#let complex-linear-diagram() = math.equation(block: true, numbering: none, $
  mat(delim: #none, column-gap: #1.5em, row-gap: #0.7em,
    V, arrow.r^T, W;
    arrow.b_rho, , arrow.b_rho;
    V^(1,0), arrow.r^(tilde(T)), W^(1,0);
  )
$)

#align(center)[
  #set par(justify: false)
  #v(1cm)
  #text(size: 22pt, weight: "bold", hyphenate: false)[MATH868C \ Several Complex Variables]
  #v(2cm)
  #image("Pictures/Kodaira_Kunihiko.jpg", width: 50%)
  #v(2cm)
  Taught by Richard A. Wentworth \
  Notes taken by Haoran Li \
  2020 Fall
  #v(2cm)
  Department of Mathematics \
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()


= Review

#statement("Definition")[
$C^1$ function $f : Omega arrow.r bb(C)$ is #emph[holomorphic] if $macron(partial) f = 0$. Denote the set of all holomorphic functions on $Omega$ as $A \( Omega \)$

]
#statement("Lemma")[
If $f$ is holomorphic, then $integral_(partial Omega) f d z = 0$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $integral_(partial Omega) f d z = integral_Omega d \( f d z \) = integral_Omega macron(partial) f and d z = 0$)

]
#statement("Theorem", title: [Poincaré-Lelong formula])[
Since $Delta = partial_x^2 + partial_y^2 = 4 partial_z partial_(macron(z)) = 4 partial_(macron(z)) partial_z$, $d z and d macron(z) = - 2 i d x and d y = - 2 i d mu$. In the distributional sense, $- frac(log r, 2 pi) = - frac(1, 4 pi) log \( x^2 + y^2 \)$ is the fundamental solution of Laplacian equation in dimension $2$, i.e. $Delta log \( x^2 + y^2 \) = 4 pi delta$, we have #math.equation(block: true, numbering: none, $Delta log \| z \|^2 d z and d macron(z) = 4 pi delta d z and d macron(z) arrow.l.r.double macron(partial) partial log \| z \|^2 = 2 pi i delta d x and d y$)

]#label("Poincare-Lelong formula")
#aside("Note")[
$partial log \| z \|^2 = partial log \( z \) + partial log \( macron(z) \) = frac(d z, z)$ is integrable around $0$

]
#proof(title: "Proof")[
We prove a slightly general result. For any $phi.alt in C_c^oo \( Omega \)$, by definition we have #math.equation(block: true, numbering: none, $integral.double_Omega phi.alt macron(partial) partial log \| z - w \|^2 & = - integral.double_Omega macron(partial) phi.alt and partial log \| z - w \|^2\
 & = - lim_(epsilon.alt arrow.r 0) integral.double_(\| z - w \| gt.eq epsilon.alt) macron(partial) phi.alt and partial log \| z - w \|^2\
 & = - lim_(epsilon.alt arrow.r 0) integral.double_(\| z - w \| gt.eq epsilon.alt) d (phi.alt partial log \| z - w \|^2)\
 & = lim_(epsilon.alt arrow.r 0) integral.cont_(\| z - w \| = epsilon.alt) phi.alt partial log \| z - w \|^2\
 & = lim_(epsilon.alt arrow.r 0) integral.cont_(\| z - w \| = epsilon.alt) frac(phi.alt, z - w) d z\
 & = 2 pi i phi.alt \( w \)$)

]
#statement("Theorem", title: [Cauchy's formula])[
If $f in C^1 \( overline(Omega) \)$, then #math.equation(block: true, numbering: none, $f \( w \) = frac(1, 2 pi i) integral.double_Omega frac(partial_(macron(z)) f d z and d macron(z), z - w) + frac(1, 2 pi i) integral_(partial Omega) frac(f, z - w) d z$)

]#label("Cauchy's formula")
#proof(title: "Proof")[
By Poincaré-Lelong formula #ref(label("Poincare-Lelong formula"), supplement: none), we have #math.equation(block: true, numbering: none, $f \( w \) & = frac(1, 2 pi i) integral.double_Omega f macron(partial) partial log \| z - w \|^2\
 & = - frac(1, 2 pi i) integral.double_Omega macron(partial) f and partial log \| z - w \|^2 + frac(1, 2 pi i) integral_(partial Omega) f partial log \| z - w \|^2\
 & = frac(1, 2 pi i) integral.double_Omega frac(partial_(macron(z)) f d z and d macron(z), z - w) + frac(1, 2 pi i) integral_(partial Omega) frac(f, z - w) d z$)

]
#statement("Corollary")[
If $f in C^1 \( overline(Omega) \) inter A \( Omega \)$, then by Cauchy's formula #ref(label("Cauchy's formula"), supplement: none), we know #math.equation(block: true, numbering: none, $f \( w \) = frac(1, 2 pi i) integral_(partial Omega) frac(f \( z \), z - w) d z$) Which is $C^oo$ in $w$ #math.equation(block: true, numbering: none, $f^(\( n \)) \( w \) = frac(n !, 2 pi i) integral_(partial Omega) frac(f \( z \), \( z - w \)^(n + 1)) d z$)

]
#statement("Corollary", title: [Cauchy's estimate])[
For $K subset.eq Omega$ compact, there are constants $C_n$ such that for any $f in A \( Omega \)$ #math.equation(block: true, numbering: none, $sup_(z in K) \| f^(\( n \)) \( z \) \| lt.eq C_n parallel f parallel_(L^1 \( Omega \))$)

]#label("Cauchy's estimate")
#proof(title: "Proof")[
Consider a bump function $chi$ with $"supp" chi subset.eq Omega$ and $chi equiv 1$ on $K$, then for any $w in K$ #math.equation(block: true, numbering: none, $f \( w \) & = frac(1, 2 pi i) integral.double_Omega frac(partial_(macron(z)) \( chi f \) d z and d macron(z), z - w) + frac(1, 2 pi i) integral_(partial Omega) frac(chi f, z - w) d z\
 & = frac(1, 2 pi i) integral.double_Omega frac(\( partial_(macron(z)) chi \) f d z and d macron(z), z - w)\
 & = frac(1, 2 pi i) integral.double_(Omega \\ K) frac(\( partial_(macron(z)) chi \) f d z and d macron(z), z - w)$) $frac(partial_(macron(z)) chi, z - w)$ can be bounded on $Omega \\ K$

]
#statement("Corollary")[
$A \( Omega \) subset.eq C \( Omega \)$ is closed, thus a Fréchet space

]
#proof(title: "Proof")[
Suppose ${ f_j } subset.eq A \( Omega \)$ converges to $f$ in $C \( Omega \)$, but since #math.equation(block: true, numbering: none, $f_j \( w \) = frac(1, 2 pi i) integral_(partial Omega) frac(f_j \( z \), z - w) d z$) $f \( w \) = frac(1, 2 pi i) integral_(partial Omega) frac(f \( z \), z - w) d z$ which implies $macron(partial) f = 0$

]
#statement("Theorem", title: [Montel's theorem])[
Suppose ${ f_i } subset.eq A \( Omega \)$ are uniformly bounded on each compact subset, then there is a subsequence $f_(i_k)$ uniformly converges on compact subsets

]#label("Montel's theorem")
#proof(title: "Proof")[
For $K subset.eq Omega$ compact, by Cauchy's estimate #ref(label("Cauchy's estimate"), supplement: none), $f_j$ are Lipschitz with the same $C_k$, by Ascoli-Arzela theorem, $f_j$ are equicontinuous, thus have convergent subsequence, and then use diagonal argument by exhaust $Omega$ with compact subsets $K$

]
#statement("Theorem", title: [Riemann extension theorem])[
$E subset.eq Omega$ is a discrete subset, $f in A \( Omega \\ E \)$, and $f$ is bounded around each point in $E$, then $f$ can be extended to a unique $tilde(f) in A \( Omega \)$

]#label("Riemann extension theorem")
#proof(title: "Proof")[
For $z_0 in E$, suppose such $tilde(f)$ exists, then by Cauchy's formula #ref(label("Cauchy's formula"), supplement: none), for any $w in D \( z_0 \, r \)$ #math.equation(block: true, numbering: none, $tilde(f) \( w \) = frac(1, 2 pi i) integral_(partial D \( z_0 \, r \)) frac(f \( z \), z - w) d z$) Thus we just take this as a definition, then #math.equation(block: true, numbering: none, $tilde(f) \( w \) - f \( w \) & = frac(1, 2 pi i) integral_(partial D \( z_0 \, r \)) frac(f \( z \), z - w) d z - frac(1, 2 pi i) integral_(partial D \( w \, epsilon.alt \)) frac(f \( z \), z - w) d z\
 & = frac(1, 2 pi i) integral_(partial D \( z_0 \, epsilon.alt \)) frac(f \( z \), z - w) d z$) Which can be show to arbitrarily small as $epsilon.alt arrow.r 0$

#align(center)[
#removable-singularity-diagram()
]

]
#statement("Theorem")[
If $alpha = g \( z \) d macron(z)$ is a smooth $\( 0 \, 1 \)$-form on $Omega$, then there exists $u in C^oo \( Omega \)$ such that $macron(partial) u = alpha$

]#label("d bar theorem")
#proof(title: "Proof")[
suppose such a $u$ exists, then by Cauchy's formula #ref(label("Cauchy's formula"), supplement: none) #math.equation(block: true, numbering: none, $u \( w \) = frac(1, 2 pi i) integral.double_Omega frac(g \( z \) d z and d macron(z), z - w) + frac(1, 2 pi i) integral_(partial Omega) frac(u \( z \), z - w) d z$) Since $macron(partial) integral_(partial Omega) frac(u \( z \), z - w) d z = 0$. This motivates us to first assume $alpha$ has compact support, and define #math.equation(block: true, numbering: none, $u \( w \) = frac(1, 2 pi i) integral.double_Omega frac(g \( z \) d z and d macron(z), z - w)$) Then #math.equation(block: true, numbering: none, $u \( w + zeta \) = frac(1, 2 pi i) integral.double_Omega frac(g \( z \) d z and d macron(z), \( z - zeta \) - w) = frac(1, 2 pi i) integral.double_Omega frac(g \( z + zeta \) d z and d macron(z), z - w)$) Hence #math.equation(block: true, numbering: none, $partial_(macron(w)) u \( w \) & = frac(1, 2 pi i) integral.double_Omega frac(partial_(macron(z)) g \( z \) d z and d macron(z), z - w)\
 & = frac(1, 2 pi i) integral.double_Omega partial log \| z - w \|^2 and macron(partial) g\
 & = g \( w \)$) Therefore $macron(partial) u = alpha$. In general, consider a compact exhaustion $Omega = union.big_i K_i$, where $hat(K)_i = K_i$, $K_i subset subset K_(i + 1)^compose$, ensured by Corollary #ref(label("Compact exhaustion of a domain"), supplement: none), let $chi_i$ be a cutoff function such that $chi_i equiv 1$ on $K_i$ and $"supp" chi_i subset.eq K_(i + 1)^compose$, then there exists $f_i$ such that $macron(partial) f_i = chi_i alpha$, by Runge's theorem #ref(label("Runge's theorem"), supplement: none), there exists $h_i in cal(O) \( K_i \)$ such that $parallel f_(i + 1) - f_i - h_i parallel_(K_i) < 1 / 2^i$. Now define #math.equation(block: true, numbering: none, $u_N = f_1 + sum_(k = 1)^N \( f_(k + 1) - f_k - h_k \) = f_(N + 1) - sum_(k = 1)^N h_N$) Converges uniformly on compact subsets to $u$, and $partial u_N = alpha$ on $K_i$ for any $i lt.eq N$

]

#pagebreak()

= Runge's theorem

#statement("Definition")[
$K subset.eq Omega$ is compact, define #math.equation(block: true, numbering: none, $cal(O) \( K \) = { f \|_K : f upright(" is holomorphic in a neighborhood of ") K }$) Then for we have restriction map $rho : cal(O) \( Omega \) arrow.r cal(O) \( K \)$, let $parallel f parallel_K = max_(z in K) \| f \( z \) \|$ to be the $L^oo$ norm

]
#statement("Theorem", title: [Runge's theorem])[
The following are equivalent

+ The image of $rho$ is dense

+ No connected component of $Omega \\ K$ is relatively compact in $Omega$

+ If $xi in Omega \\ K$, then there exists $f in cal(O) \( Omega \)$ such that $\| f \( xi \) \| > parallel f parallel_K$

]#label("Runge's theorem")
#statement("Definition")[
For $K subset.eq Omega$ compact, the #emph[holomorphic convex hull]#index-entry("Holomorphic convex hull") of $K$ relative to $Omega$ is #math.equation(block: true, numbering: none, $hat(K) = hat(K)_Omega = { z in Omega : \| f \( z \) \| lt.eq parallel f parallel_K \, forall f in cal(O) \( Omega \) }$) Clearly $K subset.eq hat(K)$

]
#statement("Proposition")[
+ $hat(K)$ is compact

+ $parallel f parallel_(hat(K)) = parallel f parallel_K$ for all $f in cal(O) \( Omega \)$

+ $hat(hat(K)) = hat(K)$

+ If $xi in Omega \\ hat(K)$, then there exists $f in cal(O) \( Omega \)$ such that $\| f \( xi \) \| > parallel f parallel_K$

]
#proof(title: "Proof")[
+ $hat(K)$ is bounded by considering $f = z$. Suppose $z_i in hat(K)$ converges to $xi$, if $xi in Omega^c$, then $f = frac(1, z - xi)$ will be unbounded on $hat(K)$, thus $xi in Omega$, but then for any $f in cal(O) \( Omega \)$, $\| f \( xi \) \| = lim_(i arrow.r oo) \| f \( z_i \) \| lt.eq parallel f parallel_K$, thus $xi in hat(K)$

+ By definition, $parallel f parallel_(hat(K)) lt.eq parallel f parallel_K$, $forall f in cal(O) \( Omega \)$, and $parallel f parallel_K lt.eq parallel f parallel_(hat(K))$, $forall f in cal(O) \( Omega \)$ is obvious

+ $hat(hat(K)) = { z in Omega : \| f \( z \) \| lt.eq parallel f parallel_(hat(K)) = parallel f parallel_K \, forall f in cal(O) \( Omega \) } = hat(K)$

+ By definition

]
#statement("Example")[
$K$ is the unit circle. If $Omega$ is the anulus ${1 / 2 < \| z \| < 2}$, then $hat(K) = K$. If $Omega$ is the disc ${ \| z \| < 2 }$, then $hat(K) = { \| z \| < 1 }$ is the unit disc. Just consider $f = z$ and $f = 1 / z$

]
#statement("Corollary")[
Any domain $Omega$ has an exhaustion by compact sets $hat(K_i) = K_i$ such that #math.equation(block: true, numbering: none, $K_i subset subset K_(i + 1)^compose subset K_(i + 1) subset subset Omega$)

]#label("Compact exhaustion of a domain")
#statement("Theorem")[
$cal(U) = { U_i }$ is an open cover of $Omega$, then $H^1 \( cal(U) \, cal(O) \) = 0$

]#label("Vanishing theorem")
#proof(title: "Proof")[
Let ${ phi.alt_i }$ be a partion of unity. For any cocycle ${ g_(i j) } in Z^1 \( cal(U) \, cal(O) \)$, consider $h_i = sum_j phi.alt_j g_(i j)$, then #math.equation(block: true, numbering: none, $h_i - h_j & = sum_k phi.alt_k g_(i k) - sum_k phi.alt_k g_(j k)\
 & = sum_k phi.alt_k \( g_(i k) - g_(j k) \)\
 & = sum_k phi.alt_k g_(i j)\
 & = g_(i j)$) Hence $macron(partial) h_i - macron(partial) h_j = 0$, ${ macron(partial) h_i }$ define a well-defined smooth $\( 0 \, 1 \)$ form. By Theorem #ref(label("d bar theorem"), supplement: none), there exist a holomorphic fuction $u$ such that $macron(partial) u = macron(partial) h_i$, define $f_i = h_i - u$, then $macron(partial) f_i = 0$, i.e. ${ f_i }$'s are holomorphic, and $g_(i j) = f_i - f_j$. In other words, ${ g_(i j) }$ is the image of ${ f_i } in C^1 \( cal(U) \, cal(O) \)$ under the coboundary map

]
#statement("Theorem", title: [Mittag-Leffler theorem])[
$Omega subset.eq bb(C)$ is an open set, $E subset.eq Omega$ is a discrete subset, then there exists a meromorphic function $f$ with prescribed principal parts on $E$

]
#proof(title: "Proof")[
There exists and open cover $cal(U) = { U_i }$ and $f_i in cal(M) \( U_i \)$ with the prescribed principal parts round each point of $E$, then $f_i - f_j in cal(O) \( U_i inter U_j \)$ is a coycle, by Theorem #ref(label("Vanishing theorem"), supplement: none), there exist holomorphic functions ${ g_i }$ such that $f_i - f_j = g_i - g_j$ on $U_i inter U_j$, then $f_i - g_i = f_j - g_j$ defines a global meromorphic function $f$ such that $f - f_i = - g_i$ on $U_i$ which is holomorphic

]
#statement("Theorem", title: [Weierstrass theorem])[
$E subset.eq Omega$ is discrete, then

+ There is $f in cal(M) \( Omega \)$ with arbitrary orders precisely at $E$

+ Any $f in cal(M) \( Omega \)$ can be written as $f = g \/ h$ for $g \, h in cal(O) \( Omega \)$

]#label("Weierstrass theorem")
#proof(title: "Proof")[
+ First take care of poles, and then multiply by $a_k \( z - z_k \)^(r_k)$ for each zero $z_k$, that converges

+

]
#statement("Definition")[
Open subset $Omega subset.eq bb(C)^n$ is called a #emph[domain of holomorphy]#index-entry("Domain of holomorphy") if for any $p in overline(Omega) \\ Omega$, there is no holomorphic function $g$ defined on an open set $U in.rev p$ with $g = f$ on $U inter Omega$

]
#statement("Theorem")[
For any proper open subset $Omega subset.eq bb(C)$ is a domain of holomorphic

]
#proof(title: "Proof")[
Suppose $p in partial Omega$, $p in U$ is a neighborhood, $g in cal(O) \( U \)$ such that $f = g$ on $Omega inter U$, then there exists ${ xi_n }$ discrete and converging to $p$. By Weierstrass theorem #ref(label("Weierstrass theorem"), supplement: none), there exists $f in cal(O) \( Omega \)$ having exactly ${ xi_i }$ as zeros, but then $g$ has to be identically zero, so is $f$ which is a contradiction

]

#pagebreak()

= Subharmonic functions

#statement("Definition")[
$Omega subset.eq bb(C)$ is a domain. $u : Omega arrow.r bb(R) union { - oo }$ is #emph[upper semicontinuous]#index-entry("Upper semicontinuous") if for $y in bb(R)$ the set ${ u < y }$ is open

]
#statement("Definition")[
An upper semicontinuous function $u$ is #emph[subharmonic]#index-entry("Subharmonic function") if is not identitcally $- oo$, and for each $U subset subset Omega$ and harmonic function $h$ on $overline(U)$ with $u lt.eq h$ on $partial U$, we have $u lt.eq h$ for all $z in U$

]
#statement("Example")[
If $u in C^2 \( Omega \)$ and $Delta u gt.eq 0$, then $u$ is subharmonic

]
#statement("Theorem")[
+ If ${ u_i }$ are subharmonic and $u = sup u_i$ is finite and upper semicontinuous, then $u$ is subharmonic

+ If $u_i gt.eq u_(i + 1)$ are subharmonic, then $u = lim u_i$ is subharmonic

]
#proof(title: "Proof")[
+ By definition

+ ${ u < y } = union.big { u_i < y }$ is open, hence $u$ is upper semicontinuous. Suppose $u lt.eq h$ on $partial U$ for some $U subset subset Omega$ and harmonic function $h$. For any $epsilon.alt > 0$, consider #math.equation(block: true, numbering: none, $F_i = { x in partial U \| u_i \( x \) gt.eq h \( x \) + epsilon.alt }$) are compact, thus $inter.big F_i = diameter$ implies that a finite intersection is empty, hence $u lt.eq h + epsilon.alt$

]
#statement("Fact")[
If $u$ is subharmonic on $Omega$, then $u in L_(upright(l o c))^1 \( Omega \)$

]
#statement("Theorem")[
Subharmonic function $u$ satisfies the sub-mean value property #numbered-equation($u \( z \) lt.eq frac(1, 2 pi) integral_0^(2 pi) u \( z + r e^(i theta) \) d theta$)#label("Sub-mean value property") For almost all $r$ sufficiently small

]
#proof(title: "Proof")[
$u$ is integrable on circle of radius $r$ about $z$ for sufficiently small $r$, we can find continuous functions $h_n gt.eq u_n$ on the circle such that $h_n arrow.r u$ in $L^1$, extend $h_n$ to harmonic functions, then #math.equation(block: true, numbering: none, $u \( z \) lt.eq h_n \( z \) = frac(1, 2 pi) integral_0^(2 pi) h_n \( z + r e^(i theta) \) d theta arrow.r frac(1, 2 pi) integral_0^(2 pi) u \( z + r e^(i theta) \) d theta$)

]
#statement("Proposition")[
Subharminoc functions satisfies $Delta u gt.eq 0$ in the weak sense #math.equation(block: true, numbering: none, $integral_Omega u Delta phi.alt gt.eq 0 \, forall phi.alt in C_c^oo \( Omega \) \, phi.alt gt.eq 0$)

]
#proof(title: "Proof")[
Multiply $phi.alt$ on both sides of #ref(label("Sub-mean value property"), supplement: none) and integrate over $Omega$ we get #math.equation(block: true, numbering: none, $integral_Omega 2 pi u \( z \) phi.alt \( z \) d mu & lt.eq integral_Omega phi.alt \( z \) integral_0^(2 pi) u \( z + r e^(i theta) \) d theta d mu\
 & = integral_Omega u \( z \) integral_0^(2 pi) phi.alt \( z - r e^(i theta) \) d theta d mu$) Then we get #math.equation(block: true, numbering: none, $0 & lt.eq integral_Omega u \( z \) integral_0^(2 pi) phi.alt \( z - r e^(i theta) \) - phi.alt \( z \) d theta d mu\
 & = integral_Omega u \( z \) integral_0^(2 pi) - partial_z phi.alt \( z \) r e^(i theta) - partial_(macron(z)) phi.alt \( z \) r e^(- i theta) + partial_z^2 phi.alt \( z \) r^2 e^(2 i theta) + partial_(macron(z))^2 phi.alt \( z \) r^2 e^(- 2 i theta) + 2 partial_z partial_(macron(z)) phi.alt \( z \) r^2 + O \( r^3 \) d theta d mu\
 & = integral_Omega u \( z \) integral_0^(2 pi) 1 / 2 Delta phi.alt \( z \) r^2 + O \( r^3 \) d theta d mu$) Divide $r^2 / 2$ and let $r arrow.r 0$

]
#statement("Proposition")[
Subharmonicity is a local property, i.e. suppose $u$ is upper semicontinuous on $Omega$, and locally subharmonic, then $u$ is subharmonic on $Omega$

]
#proof(title: "Proof")[
Suppose $h$ is harmonic, $U subset subset Omega$, $u lt.eq h$ on $partial Omega$, consider $v = u - h$, assume $sup_U v = M > 0$, then by the upper semicontinuity, we know that $F = { v = M }$ is compact in $U$, there exists $z_0 in partial F$ obtains the least distance from $partial U$, then for any small $r > 0$, $F$ will miss an arc of positive measure if $partial B \( z_0 \, r \)$, hence #math.equation(block: true, numbering: none, $frac(1, 2 pi) v \( z_0 + r e^(i theta) \) d theta < M$) But this contradicts sub-mean value property

]
#statement("Example")[
If $f_1 \, dots.h.c \, f_k in cal(O) \( Omega \)$, not all zero, then $u = log \( \| f_1 \|^2 + dots.h.c + \| f_k \|^2 \)$ is subharmonic since $log \| f \|$ is harmonic and $Delta u gt.eq 0$

]

#pagebreak()

= Almost complex structure

#statement("Definition")[
$V$ is a real vector space, an #emph[almost complex structure]#index-entry("Almost complex structure") is an endomorphism $J : V arrow.r V$ such that $J^2 = - I$. Let $V^(1 \, 0) xor V^(0 \, 1) = V_(bb(C))$ be the $plus.minus i$ eigenspaces of $J$

]
#statement("Proposition")[
We can find basis such that $V tilde.equiv bb(R)^(2 n)$ such that $J = mat(delim: "(", 0, - I; I, 0)$. For local coordinate $\( x_i \, y_i \)$ of a complex manifold, ${frac(partial, partial x_i) \, frac(partial, partial y_i)}$ is such a basis, $frac(partial, partial z_i) \, frac(partial, partial macron(z)_i)$ are the $plus.minus i$ eigenvectors. This motivates the definition of a real isomorphism $rho : V arrow.r V^(1 \, 0)$, $v mapsto 1 / 2 \( v - i J v \)$, then $rho J = i rho$. Suppose $V \, W$ both have almost complex structures, given an $bb(R)$-linear map $T : V arrow.r W$, let $tilde(T) : V^(1 \, 0) arrow.r W^(1 \, 0)$ be given by the commutative diagram

#align(center)[
#complex-linear-diagram()
]
$tilde(T)$ is complex linear if $T J = J T arrow.l.r.double tilde(T) i = i tilde(T)$. Alternatively, extend $T$ to a map $V_(bb(C)) arrow.r W_(bb(C))$, and this conditions is exactly that this extension preserves $\( 1 \, 0 \)$ and $\( 0 \, 1 \)$ subspaces

]
#statement("Lemma", title: [Osgood's lemma])[
If $f : Omega arrow.r bb(C)$ is continuous and holomorphic in each variable, then it is analytic

]
#proof(title: "Proof")[
Iterate Cauchy's formula and use Fubini's theorem to write #math.equation(block: true, numbering: none, $f \( z \) = (frac(1, 2 pi i))^n integral_(w_i in Delta \( z_i \, r_i \)) frac(f \( w \) d w, \( w_1 - z_1 \) dots.h.c \( w_n - z_n \))$) Then #math.equation(block: true, numbering: none, $frac(1, \( w_1 - z_1 \) dots.h.c \( w_n - z_n \)) = sum_I frac(\( z - xi \)^I, \( w - xi \)^I)$) Then a convergent power series expression follows, with #math.equation(block: true, numbering: none, $c_I (frac(1, 2 pi i))^n integral_(w in Delta \( z \, r \)) frac(f \( w \) d w, \( w_1 - z_1 \)^(i_1 + 1) dots.h.c \( w_n - z_n \)^(i_n + 1))$) The #emph[total order] of an analytic function $f$ at $xi$ is the smallest value of $\| I \|$ for which $c_I eq.not 0$

]
#statement("Definition")[
A set $E subset.eq Omega$ is called #emph[thin] if for every $xi in E$ there is a polydisk $Delta \( xi \, r \) subset subset Omega$ and $g in A \( Delta \( xi \, r \) \)$ such that $E inter Delta \( xi \, r \) subset.eq Z \( g \)$. Note that for $n = 1$, this is equivalent to discrete

]
#statement("Theorem", title: [Riemann extension theorem])[
If $f in A \( Omega \\ E \)$ where $E$ is a thin set, and $f$ is locally bounded on $Omega$, then there exists $tilde(f) in A \( Omega \)$ such that $tilde(f) = f$ on the complement of $E$

]
#proof(title: "Proof")[
Let $k$ be the total order of $g$ at $xi$. By an application of Rouché's theorem (and after modifying $r$ and a change of variables), we can assume that for each $z_1 \, dots.h.c \, z_(n - 1)$ the function $z_n mapsto g \( z_1 \, dots.h.c \, z_(n - 1) \, z_n \)$ has exactly $k$ zeros and none on the boundary

]
In higher dimensions, to solve $macron(partial)$ equation, there must be a #emph[integrability condition]. Indeed, if we can solve the equation, then $0 = macron(partial)^2 u = macron(partial) alpha$, i.e. we require $alpha$ to be $macron(partial)$ closed

#statement("Proposition")[
Let $n gt.eq 2$. If $alpha$ is a smooth compactly supported $\( 0 \, 1 \)$ form on $bb(C)^n$ with $macron(partial) alpha = 0$, then there is a $u in C_c^oo$, with $macron(partial) u = alpha$

]
#proof(title: "Proof")[

]
#statement("Corollary", title: [Hartogs theorem])[
Let $K subset.eq Omega$ be compact with $Omega \\ K$ connected. If $f in A \( Omega \\ K \)$, there exists $tilde(f) in A \( Omega \)$ that is equal to $f$ on the complement of $K$

]
#proof(title: "Proof")[
Let $phi.alt in C_c^oo \( Omega \)$ be $equiv 1$ in a neighborhood of $K$, let $alpha = macron(partial) \( \( 1 - phi.alt \) f \)$. Then $alpha$ is $macron(partial)$-closed and compactly supported. Hence, there is $u in C_c^oo \( bb(C)^n \)$ with $macron(partial) u = alpha$. Then let $tilde(f) = \( 1 - phi.alt \) f - u$, $tilde(f) in A \( Omega \)$, since $u$ is compactly supported, $tilde(f) = f$ on $Omega \\ K$

]
#aside("Note")[
The assumption that $Omega \\ K$ is connected is necessary. For example, let $K subset.eq B \( 0 \, 1 \) = { \| z \| < 1 }$ be the set where $\| z \| = 1 / 2$, and take #math.equation(block: true, numbering: none, $f \( z \) = cases(delim: "{", z_n & upright("if ") 1 \/ 2 < \| z \| < 1, 0 & upright("if ") \| z \| < 1 \/ 2)$) Then there is no holomorphic extension to $B \( 0 \, 1 \)$

]
#statement("Proposition")[
If $alpha$ is a smooth $macron(partial)$-closed $\( 0 \, 1 \)$ form on a polydisk $Delta = Delta \( 0 \, r \)$, then $alpha = macron(partial) u$ for some $u in C^oo \( Delta \)$

]
#proof(title: "Proof")[
Just like in the one variable case, exhaust $Delta$ by nested closed polydiscs $K_i$. Use cut-off functions to find $u_i$, $macron(partial) u_i$ in a neighborhood of $K_i$. Then $u_(i + 1) - u_i$ is holomorphic in a neighborhood of $K_i$. Now by the power series expansion, there is a polynomial $p_i$ such that $parallel u_(i + 1) - u_i - p_i parallel_(K_i) < 2^(- i)$. The rest follows as in the proof of the one variable case

]
#aside("Note")[
We heavily used the geometric properties of the polydisc

]
#statement("Corollary", title: [Cousin theorem])[
$cal(U) = { u_i }$ is an open cover of polydisc $Delta$, then $H^1 \( Delta \, cal(U) \) = 0$

]
#statement("Theorem")[
If $alpha in C_(\( p \, q \))^oo \( Delta \)$, $q gt.eq 1$, $macron(partial) alpha = 0$. Then $alpha = macron(partial) u$ for some $u in C_(\( p \, q - 1 \))^oo \( Delta \)$

]
#statement("Remark")[
This states that the Dolbeault cohomology groups $H_(macron(partial))^(p \, q) \( Delta \) = 0$

]
#proof(title: "Proof")[
Induct on $k = 1 \, dots.h.c \, n$, the smallest integer such that $alpha$ only involves $d macron(z)_1 \, dots.h.c \, d macron(z)_k$. If $k = 1$, then $q = 1$ and we have already proven the result. Suppose the result is true for $k - 1$. Write $alpha = omega and d macron(z)_k + beta$, where $omega$ and $beta$ only involve $d macron(z)_1 \, dots.h.c \, d macron(z)_(k - 1)$. We have $0 = macron(partial) alpha = macron(partial) omega and d macron(z)_k + macron(partial) beta$. This implies both $omega \, beta$ are holomorphic in the variables $z_(k + 1) \, dots.h.c \, z_n$. Apply the one variable solution to find $mu$, $macron(partial) mu = omega and d macron(z)_k + sigma$, here $sigma$ only involves $d macron(z)_1 \, dots.h.c \, d macron(z)_(k - 1)$. Now $alpha - macron(partial) u = beta - sigma$ is $macron(partial)$-closed. By induction, we can write $beta - sigma = macron(partial) v$, and so we set $u = v + mu$

]
#statement("Example")[
Let $Omega subset.eq bb(C)^2$ be a domain. For $xi in Omega$, let $Omega^(*) = Omega \\ { xi }$. Then $H_(macron(partial))^(0 \, 1) \( Omega^(*) \) eq.not { 0 }$

]
#proof(title: "Proof")[
Without loss of generality assume $xi = \( 0 \, 0 \)$. Consider the $\( 0 \, 1 \)$-form #math.equation(block: true, numbering: none, $omega = 1 / r^4 \( - macron(z)_2 d macron(z)_1 + macron(z)_1 d macron(z)_2 \) = macron(partial) (frac(macron(z)_2, z_1 r^2))$) Clearly, $omega$ is smooth on $Omega^(*)$, and $macron(partial) omega = 0$. Suppose $omega = macron(partial) u$ for $u in C^oo \( Omega^(*) \)$. Then $f \( z_1 \, z_2 \) = z_1 u - macron(z)_2 / r^2$ is holomorphic on $Omega^(*) \\ { z_1 = 0 }$, and it is locally bounded on $Omega^(*)$. By Riemann extension, it is holomorphic on $Omega^(*)$. By Hartogs, it extends to $Omega$. But for $z_2 eq.not 0$ we clearly have $f \( 0 \, z_2 \) = - 1 / z_2$, contradiction

]
#statement("Proposition")[
$K subset.eq Omega$ is compact

+ $hat(K)_Omega$ is closed in $Omega$

+ $hat(K)_Omega$ is not necessarily closed in $bb(C)^n$. E.g. if $n gt.eq 2$, let $Omega = bb(B)^n \\ { 0 }$, $K = { \| z \| = 1 \/ 2 }$. Then by Hartogs' theorem, $hat(K)_Omega = bb(B)_(1 \/ 2)^n \\ { 0 }$

+ $hat(K)_Omega subset.eq cal(C) \( K \)$, the closed convex hull of $K$. In particular, $hat(K)_Omega$ is bounded

]
#proof(title: "Proof")[
Let $w in.not cal(C) \( K \)$, $z_0 in cal(C) \( K \)$ minimizes distance to $w$, let $xi in \( bb(C)^n \)^(*)$ define a supporting hyperplane for $cal(C) \( K \)$ so that $cal(C) \( K \) subset.eq "Re" chevron.l xi \, z chevron.r lt.eq 0$ and $"Re" chevron.l xi \, w chevron.r gt.eq 0$. Let $f \( z \) = exp chevron.l xi \, z chevron.r$, $\| f \( z \) \| = exp "Re" chevron.l xi \, z chevron.r$ which violates the definition, so $w in.not hat(K)_Omega$

]
#statement("Definition")[
A domain $Omega subset.eq bb(C)^n$ is #emph[holomorphically convex]#index-entry("holomorphically convex") if for every compact $K subset.eq Omega$, $hat(K)_Omega$ is compact. If $Omega$ is convex, then it is holomorphically convex. If $n = 1$, all domains are holomorphically convex. The previous counter-example shows this is not true if $n gt.eq 2$

]
#statement("Proposition")[
$Omega subset.eq bb(C)^n$ is holomorphically convex $arrow.l.r.double$ every discrete, infinite set ${ z_j } subset.eq Omega$ there is $f in A \( Omega \)$ with $\| f \( z_j \) \|$ unbounded

]
#proof(title: "Proof")[
$arrow.l.double$: If $hat(K)_Omega$ is not compact there is a discrete infinite subset ${ z_j } subset.eq hat(K)$. But then $\| f \( z_j \) \| lt.eq parallel f parallel_K$, $forall j \, f in A \( Omega \)$. This contradicts the existence of $f in A \( Omega \)$ where $\| f \( z_j \) \|$ is unbounded

#align(center)[
#box(image("Pictures/Holomorphic_convexity.PNG", width: 100.0%))

]
$arrow.r.double$: Exhaust $Omega$ by nested compact sets $K_j$, $hat(K)_j = K_j$. We may assume $z_j in K_(j + 1) \\ K_j$. We can find $f_j in A \( Omega \)$ such that $f_j \( z_j \) = 1$, $parallel f_j parallel_(K_j) < 1$, by taking power, $parallel f_j parallel_(K_j)$ can actually be arbitrarily small. Let $g_j in A \( Omega \)$ be such that $g_j \( z_j \) = 1$, $g_j \( z_j \) = 0$ for $i < j$. Now define $lambda_j$ by #math.equation(block: true, numbering: none, $lambda_j = j - sum_(i = 1)^(j - 1) lambda_i g_i f_i \( z_j \)$) Assume $parallel lambda_j g_j f_j parallel_(K_j) < 2^(- j)$. Now let $f \( z \) = sum_(i = 1)^oo lambda_i g_i f_i \( z \)$. This converges uniformly on compact sets, and so $f in A \( Omega \)$. Finally #math.equation(block: true, numbering: none, $f \( z_j \) = sum_(i = 1)^j lambda_i g_i f_i \( z_j \) = lambda_j g_j f_j \( z_j \) + sum_(i = 1)^(j - 1) lambda_i g_i f_i \( z_j \) = j$)

]
#statement("Definition")[
$Omega subset.eq bb(C)^n$ is called a #emph[domain of holomorphy] if there is $f in A \( Omega \)$ such that for any $p in overline(Omega) \\ Omega$ and any $Omega'$ about $p$, there is no $g in A \( Omega' \)$ such that $g = f$ on $Omega' inter Omega$

]
#statement("Theorem")[
$Omega subset.eq bb(C)^n$ is holomorphically convex $arrow.l.r.double$ it is a domain of holomorphy

]
#statement("Corollary")[
A convex domain in $bb(C)^n$ is a domain of holomorphy

]
#proof(title: "Proof")[
$arrow.r.double$ is similar to the one variable case. $arrow.l.double$ is a theorem of Oka (this will be generalized) \
$arrow.r.double$: Fix a polydisc $Delta$ about the origin. For $xi in Omega$, let $Delta_xi = xi + r Delta$, where $r$ is the supremum such that $xi + r Delta subset.eq Omega$. Let $E subset.eq Omega$ be countable dense. Let ${ xi_j }$ be a sequence containing every point of $E$ infinitely may times. Write $Omega = union.big K_j$. Since $hat(K)_j subset subset Omega$, $exists z_j in Delta_(xi_j)$ with $z_j in.not hat(K)_j$. Choose $f_j in A \( Omega \)$, $f_j \( z_j \) = 1$, $parallel f_j parallel_(K_j) < 2^(- j)$. Set $f \( z \) = product \( 1 - f_j \)^j$. Then $f$ converges uniformly on compact sets, so $f in A \( Omega \)$. Now $f$ has zeros of order $gt.eq j$ at $z_j$. Any continuation of $f$ would have a zero of infinite order \
$arrow.r.double$: Let $d \( z \) = sup_(Delta \( z \, r \) subset.eq Omega) r$, $d \( K \) = inf_(z in K) d \( z \)$. Claim $d \( hat(K) \) = d \( K \) > 0$. This will imply $hat(K) subset subset Omega$. Let $f in A \( Omega \)$ so that the radius of convergence at $z$ is $d \( z \)$, let $delta < d \( K \)$, $K_delta = union.big_(w in K) overline(Delta \( w \, delta \))$. By Cauchy estimates: $parallel D^I f parallel_K lt.eq frac(I !, delta^(\| I \|)) parallel f parallel_(K_delta)$. But $D^I f in A \( Omega \)$, so for $z in hat(K)$, $\| D^I f \( z \) \| lt.eq parallel D^I f parallel_K lt.eq frac(I !, delta^(\| I \|)) parallel f parallel_(K_delta)$. This implies that the radius of convergence at $z in hat(K)$ is at least $delta$, i.e. $d \( z \) gt.eq delta$, and so $d \( hat(K) \) gt.eq d \( K \)$. Since $K subset.eq hat(K)$, the other inequality is trivial

]
#statement("Proposition")[
If ${ Omega_alpha }_(alpha in I)$ are domains of holomorphy in $bb(C)^n$, then the interior $Omega$ of $inter.big_(alpha in I) Omega_alpha$ is also a domain of holomorphy

]
#proof(title: "Proof")[
$K subset.eq Omega$ is compact. For each $alpha in I$, $K subset.eq Omega subset.eq Omega_alpha$, which implies $hat(K)_Omega subset.eq hat(K)_(Omega_alpha)$. This implies $d_(Omega_alpha) \( hat(K)_(Omega_alpha) \) lt.eq d_(Omega_alpha) \( hat(K)_Omega \)$, for all $alpha$. Since $Omega_alpha$ is holomorphically convex, $d_(Omega_alpha) \( hat(K)_(Omega_alpha) \) = d_(Omega_alpha) \( K \)$. Hence $d_Omega \( K \) lt.eq d_(Omega_alpha) \( K \) lt.eq d_(Omega_alpha) \( hat(K)_Omega \)$. Finally, this implies $d_Omega \( K \) lt.eq d_Omega \( hat(K)_Omega \)$. As before, we conclude that $d_Omega \( K \) = d \( hat(K)_Omega \)$, and so $hat(K)_Omega$ is compact, so $Omega$ is holomorphically convex

]
#aside("Claim")[
Suppose $Omega$ is a domain of holomorphy. Let $f_1 \, dots.h.c \, f_N in A \( Omega \)$, and define #math.equation(block: true, numbering: none, $Omega_c = { z in Omega \| \| f_j \( z \) \| < c \, j = 1 \, dots.h.c \, N }$) Then $Omega_c$ is also a domain of holomorphy

]
#proof(title: "Proof")[
Let $K subset.eq Omega_c$. Let $z in hat(K)_Omega$. Then in particular, for any $j = 1 \, dots.h.c \, N$, $\| f_j \( z \) \| lt.eq parallel f_j parallel_K < c$. So $z in Omega_c$. Now $hat(K)_(Omega_c) subset.eq hat(K)_Omega subset.eq Omega$ and so $hat(K)_(Omega_c)$ is compact

]
#aside("Claim")[
Let $u : Omega subset.eq bb(C)^n arrow.r bb(C)^m$ be holomorphic, with $Omega$ a domain of holomorphy. If $Omega' subset.eq bb(C)^m$ is a domain of holomorphy, then so is $tilde(Omega) = u^(- 1) \( Omega' \)$

]
#proof(title: "Proof")[
Let $K subset.eq tilde(Omega) subset.eq Omega$ be compact. Since $hat(K)_(tilde(Omega)) subset.eq hat(K)_Omega subset.eq Omega$, it suffices to show $hat(K)_(tilde(Omega))$ is closed in $Omega$. Let $z_j arrow.r z in Omega$, $z_j hat(K)_(tilde(Omega))$. Notice that $u \( hat(K)_(tilde(Omega)) \) subset.eq accent(u \( K \), ̂)_(Omega')$. Hence $u \( z \) in Omega'$, and so $z in tilde(Omega)$

]
#statement("Lemma")[
Let $Omega subset.eq bb(C)^n$ be a domain of holomorphy, and $K subset.eq Omega$. Suppose $f in A \( Omega \)$ is such that $\| f \( z \) \| lt.eq d \( z \)$ for all $z in K$, then $\| f \( xi \) \| lt.eq d \( xi \)$ for all $xi in hat(K)_Omega$

]
#proof(title: "Proof")[
We first claim that if $u in A \( Omega \)$, then the power series expansion of $u$ at $xi in hat(K)_Omega$ converges on $Delta \( xi \, \| f \( xi \) \| \)$. This will prove the Lemma, because we can take $u$ to be teh function with no analytic continuation beyond $Omega$ \
Proof of the claim: Let $0 < delta < 1$, as before, the Cauchy estimates provide for some constant $M$ that #math.equation(block: true, numbering: none, $\| D^I u \( z \) \| frac(\( delta \| f \( z \) \| \)^(\| I \|), I !) lt.eq M \, forall z in K$) Now $D^I u \( z \) f \( z \)^(\| I \|) in A \( Omega \)$, so the same estimate holds on $hat(K)_Omega$. This means the radius of convergence at $xi in hat(K)_Omega$ is a t least $delta \| f \( xi \) \|$. Since $delta$ was arbitrary, this proves the claim

]
Fundamental consequence: Let $D subset subset Omega$ be a 1-dimensional disc

+ Suppose $f$ is a polynomial in one variable such that $- log d \( z \) lt.eq "Re" f \( z \)$, for $z in partial D$

+ Let $f$ be the restriction of $F in A \( Omega \)$. Then $\| e^(- F \( z \)) \| lt.eq d \( z \)$, $z in partial D$

+ By the maximum principle, $D subset.eq accent(partial D_Omega, ̂)$

+ From the Lemma, we have $\| e^(- F \( z \)) \| lt.eq d \( z \)$, $z in partial D$

+ This in turn implies $- log d \( z \) lt.eq "Re" f$ on $D$

Approximating harmonic functions by polynomials, we conclude that $u = - log d$ is subharmonic on any complex line in $Omega$


#pagebreak()

= Hartogs theorem

#statement("Theorem")[

]

#pagebreak()

= Pseudoconvexity

#statement("Definition")[
An upper semicontinuous function $phi.alt : Omega subset.eq bb(C)^n arrow.r \[ - oo \, oo \)$ is #emph[plurisubharmonic]#index-entry("Plurisubharmonic") if the restriction of $phi.alt$ to every complex line $L inter Omega$, $L tilde.equiv bb(C)$, is subharmonic. Let $P \( Omega \)$ be the set of plurisubharmonic (psh) functions on $Omega$

]
#statement("Proposition")[
$phi.alt in C^2 \( Omega \)$ is psh $arrow.l.r.double$ for all $xi in bb(C)^n$ and all $z in Omega$, the complex Hessian is positive semidefinite #math.equation(block: true, numbering: none, $sum_(i \, j = 1)^n frac(partial^2 phi.alt, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j gt.eq 0$) $phi.alt$ is strictly psh if $>$ holds for every $xi eq.not 0$

]
#statement("Remark")[
A real $\( 1 \, 1 \)$ form on $Omega$ can be written as #math.equation(block: true, numbering: none, $omega \( z \) = i sum_(i \, j = 1)^n g_(i macron(j)) \( z \) d z_i and d macron(z)_j$) where $g_(i macron(j))$ is a Hermitian matrix. We say that $omega gt.eq 0$\(resp. $omega > 0$) if $\( g_(i macron(j)) \( z \) \)$ is positive semidefinite(resp. positive definite) for every $z in Omega$. This means that for each $xi in bb(C)^n$, $xi eq.not 0$ #math.equation(block: true, numbering: none, $sum_(i \, j = 1)^n g_(i macron(j)) \( z \) xi_i macron(xi)_j gt.eq 0 \( upright("resp. ") omega > 0 \)$) In the case $omega > 0$, $g_(i macron(j))$ defines a Hermitian metric on $Omega$, and $omega$ is its associate Kähler form

]
#proof(title: "Proof")[
A line $dotless.j : L arrow.r.hook bb(C)^n$ is given by a choice $xi eq.not 0$ in $bb(C)^n$, so that $dotless.j \( tau \) = z_0 + tau xi$, then #math.equation(block: true, numbering: none, $dotless.j^(*) \( d z_i \) = xi_i d tau \, dotless.j^(*) \( d macron(z)_i \) = macron(xi)_i d macron(tau)$) #math.equation(block: true, numbering: none, $dotless.j^(*) \( i partial macron(partial) phi.alt \) & = (sum_(i \, j = 1)^n frac(partial^2 phi.alt, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j) i d tau and d macron(tau)\
 & = (sum_(i \, j = 1)^n frac(partial^2 phi.alt, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j) 2 d mu$) On the other hand #math.equation(block: true, numbering: none, $dotless.j^(*) \( i partial macron(partial) phi.alt \) = i partial_z macron(partial)_z \( phi.alt compose dotless.j \) = Delta \( phi.alt compose dotless.j \) 2 d mu$)

]
#statement("Definition")[
A domain $Omega subset.eq bb(C)^n$ is #emph[pseudoconvex]#index-entry("Pseudoconvex") if there exists a continuous psh exhaustion function $phi.alt$, i.e. #math.equation(block: true, numbering: none, $Omega_c = { z in Omega \| phi.alt \( z \) < c } subset subset Omega$) For every $c in bb(R)$

]
#statement("Fact", title: [Richberg])[
If $Omega$ is pseudoconvex, there is a $C^oo$ strictly psh exhaustion function on $Omega$ (see Demailly's book)

]
#statement("Theorem")[
$Omega subset.eq Omega$ is a domain of holomorphy iff it is pseudoconvex

]
#proof(title: "Proof")[
Recall $d \( z \) = sup_(Delta \( z \, r \) subset.eq Omega) r$. $arrow.r.double$: We have shown that $- log d \( z \)$ is psh. It is also continuous. We claim that $u \( z \) = \| z \|^2 - log d \( z \)$ does the job Closedness: If $z_i arrow.r w in overline(Omega) \\ Omega$, then $d \( z_i \) arrow.r 0$, so $u$ diverges Boundedness: Fix any $w in overline(Omega) \\ Omega$, then #math.equation(block: true, numbering: none, $d \( z \) lt.eq \| z - w \| lt.eq \| z \| + \| w \|$) so for $\| z \|$ large #math.equation(block: true, numbering: none, $log d \( z \) lt.eq 2 log \| z \| lt.eq 1 / 2 \| z \|$) This means a bound on $u$ implies a bound on $\| z \|$

]
#statement("Example")[
+ Geometrically convex sets are pseudoconvex(e.g. balls and polydisks)

+ If ${ Omega_alpha }$ are pseudoconvex, then the interior $Omega$ of $inter.big Omega_alpha$ is pseudoconvex

+ Annuli or punctured domains are not pseudoconvex

+ Let $Omega subset.eq bb(C)^n$ be pseudoconvex, $f_1 \, dots.h.c \, f_k in A \( Omega \)$, then $tilde(Omega) = Omega \\ V \( f_1 \) union dots.h.c union V \( f_k \)$ is pseudoconvex. Indeed, if $phi.alt$ is the psh exhaustion function on $Omega$, take $tilde(phi.alt) = phi.alt - log \| f_1 \| - dots.h.c - log \| f_k \|$ on $tilde(Omega)$

]
#statement("Proposition")[
Suppose $Omega subset.eq bb(C)^n$ is pseudoconvex. Then $- log d \( z \)$ is psh

]
#proof(title: "Proof")[
$D subset subset Omega$ is a disc, $f$ on $D$, $F in A \( Omega \)$ restricts to $f$, suppose $- log d \( z \) lt.eq "Re" f \( z \)$, $z in partial D$, or equivalently $d \( z \) gt.eq \| e^(- f \( z \)) \|$, $z in partial D$. We want to show this holds in $D$. Fix $w in Delta \( 0 \, 1 \)$. Let #math.equation(block: true, numbering: none, $K = { z + lambda w e^(- f \( z \)) \| z in partial D \, 0 lt.eq lambda lt.eq 1 }$) Then $K subset.eq Omega$ #math.equation(block: true, numbering: none, $Lambda = { lambda in \[ 0 \, 1 \] \| z + lambda' w e^(- f \( z \)) in Omega \, forall z in D \, 0 lt.eq lambda' lt.eq lambda }$) Notice that $Lambda eq.not diameter$, since $0 in Lambda$. We want show that $Lambda = \[ 0 \, 1 \]$. $Lambda$ is clearly open. Suppose $lambda_i arrow.tr c$, $lambda_i in Lambda$, let $phi.alt$ be a continuous psh exhasution function on $Omega$, then for each $j$, $z in D$, $phi.alt \( z + lambda_j w e^(- f \( z \)) \) lt.eq sup_K phi.alt$, but since this is a compact set, $c in Lambda$

]
Pseudoconvexity is a property of the boundary of $Omega$

#statement("Proposition")[
$Omega subset.eq bb(C)^n$. Suppose that for every $xi in overline(Omega)$ there is an open set $xi in U$ such that $U inter Omega$ is pseudoconvex. Then $Omega$ is a pseudoconex

]
#proof(title: "Proof")[
Let $xi in partial Omega$, set $tilde(Omega) = U inter Omega$. For $z$ sufficiently close to $xi$, $d \( z \) = d_Omega \( z \) = d_(tilde(Omega)) \( z \)$, so $- log d \( z \)$ is psh in a neighborhood of $partial Omega$\(say, $Omega \\ F$ for smote closed $F$).Find a smooth proper psh function $psi$ on $bb(C)^n$ such that $phi.alt \( z \) > - log d \( z \)$ for $z in F$. Now let $phi.alt \( z \) = max { psi \( z \) \, - log d \( z \) }$. Then $phi.alt$ is a continuous psh exhaustion function

]
#statement("Definition")[
$Omega subset.eq bb(C)^n$ have a $C^2$ boundary. In a neighborhood $U$ of $z_0 in partial Omega$ we can find a $C^2$ defining function $rho : U arrow.r bb(R)$, i.e. #math.equation(block: true, numbering: none, $Omega inter U = { z in U \| rho \( z \) < 0 } \, nabla rho eq.not 0 upright(" on ") partial Omega inter U$) The #emph[Levi form]#index-entry("Levi form") $L_(z_0)$ at the point $z_0$ is the quadratic form $"Hess" \( rho \)$ restricted to $V_(z_0) = T_(z_0) partial Omega inter J \( T_(z_0) partial Omega \)$. Alternatively, let $xi in bb(C)^n$ satisfy $sum_(i = 1)^n frac(partial rho, partial z_i) xi_i = 0$. Then we define #math.equation(block: true, numbering: none, $L \( xi \) = sum_(i \, j = 1)^n frac(partial^2 rho, partial z_j partial macron(z)_j) \( z_0 \) xi_i macron(xi)_j$) Here, if $xi$ is the vector corresponding to $v$ then $L \( v \) = L \( xi \)$

]
#statement("Lemma")[
Let $z \, w in Omega$, $xi in Delta \( 0 \, r \)$ such that $z = w + xi$. Then $d \( z \) gt.eq d \( w \) - r$

]#label("d(z)>=d(w)-r")
#proof(title: "Proof")[
Let $eta$ be in some polydisk about $0$, such that $z + eta in partial Omega$, and $d \( z \) = max \| eta_i \|$. Then $w + xi + eta in partial Omega$. This implies #math.equation(block: true, numbering: none, $d \( w \) lt.eq max_j \| \( xi + eta \)_j \| lt.eq max_j \| xi_j \| + max_j \| eta_j \| lt.eq r + d \( z \)$)

]
#statement("Proposition")[
$Omega$ is pseudoconvex $arrow.l.r.double$ the Levi form is everywhere positive semidefinite on $partial Omega$

]
#proof(title: "Proof")[
$arrow.r.double$: $rho \( z \) = cases(delim: "{", - d_Omega \( z \) & z in Omega, 0 & z in partial Omega, - d_(overline(Omega)^c) \( z \) & z in overline(Omega)^c)$, then $rho$ is $C^2$. The function $phi.alt = - log d$ is $C^2$ and psh #math.equation(block: true, numbering: none, $frac(partial^2 phi.alt, partial z_i partial macron(z)_j) = - frac(1, d \( z \)) frac(partial^2 d, partial z_i partial macron(z)_j) + frac(1, d \( z \)^2) frac(partial d \( z \), partial z_i) frac(partial d \( z \), partial macron(z)_i)$) So for $z in Omega$ #math.equation(block: true, numbering: none, $0 lt.eq sum_(i \, j = 1)^n frac(partial^2 phi.alt, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j = sum_(i \, j = 1)^n frac(1, d \( z \)) frac(partial^2 d, partial z_i partial macron(z)_j)$) Now let $z arrow.r partial Omega$ \
$arrow.l.double$: Suppose $c = frac(partial^2, partial tau partial macron(tau)) log d \( z_0 + tau w_0 \) > 0$. $log d \( z_0 + tau w_0 \) = log d \( z_0 \) + "Re" \( A tau + B tau^2 \) + c \| tau \|^2 + o \( \| tau \|^2 \)$. Choose $xi_0 in partial Delta \( 0 \, d \( z_0 \) \)$ such that $z_0 + xi_0 in partial Omega$, $max_i \| xi_(0 \, i) \| = d \( z_0 \)$. Let $z \( tau \) = z_0 + tau w_0 + xi_0 exp \( A tau + B tau^2 \)$. By Lemma #ref(label("d(z)>=d(w)-r"), supplement: none) #math.equation(block: true, numbering: none, $d \( z \( tau \) \) & gt.eq d \( z_0 + tau w_0 \) - d \( z_0 \) \| exp \( A tau + B tau^2 \) \|\
 & gt.eq \| exp \( A tau + B tau^2 \) \| \( e^(c \| tau \|^2 \/ 2) - 1 \)$) Now $d \( z \( 0 \) \) = 0$. The inequalitity implies #math.equation(block: true, numbering: none, $frac(partial, partial tau) d \( z \( tau \) \)\|_(tau = 0) = 0 \, frac(partial^2, partial tau partial macron(tau)) d \( z \( tau \) \)\|_(tau = 0) > 0$) In other words #math.equation(block: true, numbering: none, $sum_(i = 1)^n frac(partial rho, partial z_i) z'_i \( 0 \) = 0 \, sum_(i \, j = 1)^n frac(partial^2 rho, partial z_i partial macron(z)_j) z'_i \( 0 \) macron(z)'_j \( 0 \) < 0$) This contradicts $L_(z \( 0 \)) gt.eq 0$

]

#pagebreak()

= Hörmander's $L^2$ estimate

#statement("Definition")[
$H_1 \, H_2$ are complex Hilbert space, $T : H_1 arrow.r H_2$ is an #emph[unbounded operator], if it is a linear map defined on some linear subspace $D \( T \) lt.eq H_1$ called the domain of $T$. $T$ is #emph[densely defined] if $D \( T \)$ is dense in $H_1$. $T$ is #emph[closed] if the graph $"Gr" \( T \) = { \( x \, T x \) in H_2 times H_2 \| x in D \( T \) }$ is closed. $T$ has #emph[closed range] if $R \( T \) = { T x in H_2 \| x in D \( T \) }$ is closed in $H_2$. Write $N \( T \) = ker T$

]
#statement("Definition")[
$T : H_1 arrow.r H_2$ is a densely defined unbounded operator, its adjoint $T^(*) : H_2 arrow.r H_1$ is defined as an unbounded operator as follows

- $D \( T^(*) \)$ consists of $y in H_2$ such that the funcitonal $chevron.l T \( - \) \, y chevron.r : D \( T \) arrow.r bb(C)$ is continuous

- By the Hahn-Banach theorem, $chevron.l T \( - \) \, y chevron.r$ extends to a linear functional on $H_1$

- By the Riesz representation theorem and denseness, there is a vector $T^(*) y in H_1$ such that $chevron.l T x \, y chevron.r = chevron.l x \, T^(*) y chevron.r$

]
#statement("Proposition")[
If $T$ is densely defined, then $T^(*)$ is closed

]
#proof(title: "Proof")[
Let $y_j in D \( T^(*) \)$, $y_j arrow.r y$, and $x_j = T^(*) y_j arrow.r x$. We need to show $y in D \( T^(*) \)$ and $x = T^(*) y$. Fix $u in D \( T \)$. Then #math.equation(block: true, numbering: none, $\| u \| \| x \| gt.eq chevron.l u \, x chevron.r = lim_j chevron.l u \, x_j chevron.r = lim_j chevron.l u \, T^(*) y_j chevron.r = lim_j chevron.l T u \, y_j chevron.r = chevron.l T u \, y chevron.r$) So the map $u mapsto chevron.l T u \, y chevron.r$ is bounded on $D \( T \)$ by $\| x \|$. This implies $y in D \( T^(*) \)$ and $x = T^(*) y$

]
#statement("Fact")[
If $T \, T^(*)$ are densely defined then $T$ is closed, and $\( T^(*) \)^(*) = T$

]
#statement("Lemma")[
If $T$ is closed and densely defined, then $"Gr" \( T^(*) \) = "Gr" \( - T \)^perp$ in $H_1 times H_2$

]#label("Gr(T*)=Gr(-T)^perp")
#proof(title: "Proof")[
We have inclusion $subset.eq$ since #math.equation(block: true, numbering: none, $chevron.l \( T^(*) y \, y \) \, \( x \, - T x \) chevron.r = chevron.l T^(*) y \, x chevron.r - chevron.l y \, T x chevron.r = 0$) Now if $chevron.l \( x \, y \) \, \( u \, - T u \) chevron.r = chevron.l x \, u chevron.r - chevron.l y \, T u chevron.r = 0$ for all $u in D \( T \)$, then $u mapsto chevron.l T u \, y chevron.r = chevron.l u \, x chevron.r$ is bounded on $D \( T \)$, so $y in D \( T^(*) \)$, and $x = T^(*) y$

]
#statement("Theorem")[
If $T$ is closed and densely defined, then so is $T^(*)$. Moreover, $N \( T^(*) \) = R \( T \)^perp$ and $N \( T \) = overline(R \( T^(*) \)^perp)$

]
#aside("Note")[
$\( V^perp \)^perp = overline(V)$

]
#proof(title: "Proof")[
By Lemma #ref(label("Gr(T*)=Gr(-T)^perp"), supplement: none), any $\( u \, v \) in H_1 times H_2$ can be written as #math.equation(block: true, numbering: none, $\( u \, v \) = \( x \, - T x \) + \( T^(*) y \, y \) \, x in D \( T \) \, y in D \( T^(*) \)$) Taking $u = 0$, then $v = y + T T^(*) y$. This implies $chevron.l v \, y chevron.r = \| y \|^2 + \| T^(*) y \|^2$. If $v in D \( T^(*) \)^perp$, then $y = 0$, and so $v = 0$. Hence $D \( T^(*) \)$ must be dense. $N \( T^(*) \) = R \( T \)^perp$ follows form $chevron.l T x \, y chevron.r = chevron.l x \, T^(*) y chevron.r$

]
#statement("Proposition")[
Let $T : H_1 arrow.r H_2$ be closed and densely defined. The following are equivalent

+ $R \( T \)$ is closed

+ $exists C$ such that $\| x \| lt.eq C \| T x \|$ for all $x in D \( T \) inter R \( T^(*) \)$

+ $R \( T^(*) \)$ is closed

+ $exists C$ such that $\| y \| lt.eq C \| T^(*) y \|$ for all $y in D \( T^(*) \) inter R \( T \)$

]#label("T closed, densely defined, equivalent conditions for R(T) closed")
#proof(title: "Proof")[
\2.$arrow.r.double$1.: Suppose $T x_j arrow.r y$, then $x_j$ converges, say to $x$, $\( x_j \, T x_j \) arrow.r \( x \, y \)$ \
To show 1.$arrow.r.double$2., recall $N \( T \) = R \( T^(*) \)^perp$. Hence $T$ is continuous and 1-1 from $D \( T \) inter R \( T^(*) \)$ onto the closed subspace $R \( T \)$. Hence the inverse is continuous by the closed graph theorem. This proves 2. \
\3.$arrow.l.r.double$4. \
\2.$arrow.r.double$4.: #math.equation(block: true, numbering: none, $\| chevron.l T x \, y chevron.r \| = \| chevron.l x \, T^(*) y chevron.r \| lt.eq \| x \| \| T^(*) y \| lt.eq C \| T x \| \| T^(*) y \|$) So $\| chevron.l z \, y chevron.r \| lt.eq C \| T^(*) y \| \| z \|$ for $z in R \( T \)$, $y in D \( T^(*) \)$

]
#statement("Definition")[
Now consider densely defined closed unbounded operators $H_1 arrow.r^T H_2 arrow.r^S H_3$ satisfying $S compose T = 0$. The #emph[harmonic elements] are #math.equation(block: true, numbering: none, $cal(H)_2 = N \( S \) inter N \( T^(*) \)$) there is an orthogonal decomposition $H_2 = cal(H)_2 xor \( N \( S \) inter N \( T^(*) \) \)^perp = cal(H)_2 xor overline(R \( T \)) xor overline(R \( S^(*) \))$, so $N \( S \) = cal(H)_2 xor overline(R \( T \))$

]
#statement("Theorem")[
There is $C > 0$ such that for all $y in D \( S \) inter D \( T^(*) \)$ #numbered-equation($\| y \| lt.eq C \( \| S y \| + \| T^(*) y \| \)$)#label("basic estimate") i.e. the #emph[basic estimate] holds$arrow.l.r.double cal(H)_2 = 0$ and $R \( T \) \, R \( S^(*) \)$ are closed

]
#proof(title: "Proof")[
$arrow.r.double$: If $y in cal(H)_2$, then $\| y \| lt.eq C \( \| S y \| + \| T^(*) y \| \) = 0$, hence $cal(H)_2 = 0$. If $y in R \( T \) inter D \( T^(*) \)$, then $y in N \( S \)$ and $\| y \| lt.eq C \| T^(*) y \|$, by Proposition #ref(label("T closed, densely defined, equivalent conditions for R(T) closed"), supplement: none), $R \( T \)$ is closed, similarly, $R \( S^(*) \)$ is closed $arrow.l.double$: $H_2 = R \( T \) xor R \( S^(*) \)$ and $y in D \( S \) inter D \( T^(*) \)$, write $y = y_1 + y_2$, $y_1 in R \( T \) inter D \( T^(*) \)$, $y_2 in R \( S^(*) \) inter D \( S \)$. Apply the previous estimates and the triangle inequality #math.equation(block: true, numbering: none, $\| y \| lt.eq \| y_1 \| + \| y_2 \| lt.eq C_1 \| T^(*) y \| + C_2 \| S y \| lt.eq C \( \| S y \| + \| T^(*) y \| \)$)

]
$cal(D)_(\( p \, q \)) \( Omega \) subset.eq L_(\( p \, q \))^2 \( Omega \)$ be the smooth $\( p \, q \)$-forms with compact support in $Omega$. Consider the unbounded operator $macron(partial) : L_(\( p \, q \))^2 \( Omega \) arrow.r L_(\( p \, q + 1 \))^2 \( Omega \)$ with domain $D \( macron(partial) \) = { u in L_(\( p \, q \))^2 \( Omega \) \| macron(partial) u in L_(\( p \, q + 1 \))^2 \( Omega \) }$, the derivative is in the sense of distributions $chevron.l macron(partial) u \, alpha chevron.r_(L^2) = chevron.l u \, macron(partial)^(*) alpha chevron.r_(L^2)$ for $alpha in cal(D)_(\( p \, q + 1 \)) \( Omega \)$. $macron(partial)^(*)$ is called the #emph[formal adjoint] of $macron(partial)$. Then $macron(partial) u in L^2$ if there is a constant $C > 0$ such that $\| chevron.l u \, macron(partial)^(*) alpha chevron.r \| lt.eq C parallel alpha parallel_(L^2)$. In this case, the Hahn-Banach and Riesz representation theorem, $chevron.l u \, macron(partial)^(*) alpha chevron.r = chevron.l v \, alpha chevron.r$

#statement("Proposition")[
$macron(partial) : L_(\( p \, q \))^2 \( Omega \) arrow.r L_(\( p \, q + 1 \))^2 \( Omega \)$ is a closed operator

]
#proof(title: "Proof")[
$u_i arrow.r u$ in $L^2$, $u_i in D \( macron(partial) \)$, $macron(partial) u_i arrow.r alpha$. Let $beta in cal(D)_(\( p \, q + 1 \)) \( Omega \)$, then #math.equation(block: true, numbering: none, $chevron.l u \, macron(partial)^(*) beta chevron.r = lim_(i arrow.r oo) chevron.l u_i \, macron(partial)^(*) beta chevron.r = lim_(i arrow.r oo) chevron.l macron(partial) u_i \, beta chevron.r = chevron.l alpha \, beta chevron.r$) So the map $beta mapsto chevron.l u \, macron(partial)^(*) beta chevron.r$ is bounded and $macron(partial) u = alpha$, thus $macron(partial)$ is closed

]
#statement("Example")[
Consider $T = i frac(d, d x)$ on $L^2 \( \[ 0 \, 1 \] \)$, with $D \( T \)$ consisting of $f \, f' in L^2$. One can show $f in D \( T \)$ is (absolutely) continuous on $\[ 0 \, 1 \]$. By integration by parts #math.equation(block: true, numbering: none, $f mapsto chevron.l T f \, g chevron.r = chevron.l f \, T g chevron.r + i \( f \( 1 \) macron(g) \( 1 \) - f \( 0 \) macron(g) \( 0 \) \)$) This is not continuous with respect to the $L^2$ topology on $f$, unless $g \( 0 \) = g \( 1 \) = 0$. Thus $T^(*)$ is the same operator $T$, but with a different domain of definition

]
The problem is that while compactly supported functions are dense in $L^2$ topology, they are not dense in the $L_1^2$ topology, i.e. the graph norm $parallel u parallel + parallel macron(partial) u parallel$

Methods to fix this

+ Hömander uses a clever choice of (three) weights to prove the basic estimate

+ If $Omega$ has sufficiently nice boundary, define boundary conditions (the $macron(partial)$-Neumann problem)

+ Change the geometry of $Omega$ to carry a complete Kähler metric

We will follow the last option (Demially, Gaffney)

#statement("Lemma")[
$\( M \, g \)$ is a Riemannian manifold, the following are equivalent

+ $\( M \, g \)$ is complete (Hopf-Rinow theorem)

+ $exists$ compact exhaustion function $psi$ with $\| d psi \|_g lt.eq 1$

+ $exists$ compact exhaustion $K_i subset.eq K_(i + 1)^compose$, and $0 lt.eq psi_i$ supported in $K_(i + 1)$, $equiv 1$ on $K_i$, such that $\| d psi_i \|_g lt.eq 2^(- i)$

]#label("Equivalent conditions of completeness and compact exhaustion")
#proof(title: "Proof")[
\1.$arrow.r.double$2.: Fix $x_0 in M$, Let $psi_0 \( x \) = 1 / 2 d \( x_0 \, x \)$. Smooth $phi.alt_0$ to $psi$ with $\| phi.alt - phi.alt_0 \| < 1$, by convolution with some $g in C^oo$, compactly supported near $0$ and $integral g = 1$ 2.$arrow.r.double$3.: Choose a smooth function $rho : bb(R) arrow.r \[ 0 \, 1 \]$ with $rho \( t \) = cases(delim: "{", 1 & t lt.eq 1, 0 & t gt.eq 2)$ and $\| rho' \( t \) \| lt.eq 2$. Then let $K_i = { psi \( x \) lt.eq 2^(i + 1) }$, $psi_i \( x \) = rho \( 2^(- i - 1) psi \( x \) \)$ 3.$arrow.r.double$2.: Set $psi = sum 2^i \( 1 - psi_i \)$ 2.$arrow.r.double$1.: $\| psi \( x \) - psi \( y \) \| lt.eq d \( x \, y \)$, ${ x_i }$ is a Cauchy sequence, then ${ x_i }$ lies in the set ${ psi lt.eq C }$ for some $C$. Since this is compact, the sequence converges, so $\( M \, g \)$ is complete

]
#statement("Corollary")[
Let $Omega$ have a complete Riemannian metric $omega$. Then $cal(D)_(\( p \, q \)) \( Omega \)$ is dense in graph norm of $macron(partial)$

]
#proof(title: "Proof")[
Set $u_i = u phi.alt_i$ as in Lemma #ref(label("Equivalent conditions of completeness and compact exhaustion"), supplement: none), 3. Then $u_i arrow.r u$ in $L^2$, and $macron(partial) u_i = macron(partial) u psi_i + u macron(partial) psi_i arrow.r macron(partial) u$ in $L^2$. Now choose $v_i in cal(D)_(\( p \, q \)) \( Omega \)$ so that $parallel v_i - u_i parallel_(L_1^2) = parallel v_i - u_i parallel_(L^2) + parallel macron(partial) v_i - macron(partial) u_i parallel_(L^2) lt.eq 1 \/ i$, the result follows

]
#statement("Corollary")[
$\( Omega \, omega \)$ is complete, $macron(partial)^(*)$ with domain #math.equation(block: true, numbering: none, $D \( macron(partial)^(*) \) = {alpha in L_(\( p \, q + 1 \))^2 \( Omega \) mid(bar.v) macron(partial)^(*) alpha in L_(\( p \, q \))^2 \( Omega \)}$) is the adjoint of $T^(*)$ of $T = macron(partial)$

]
#proof(title: "Proof")[
$D \( T^(*) \) subset.eq D \( macron(partial)^(*) \)$. Let $u in cal(D)_(\( p \, q \)) \( Omega \) subset.eq D \( T \)$. If $alpha in D \( T^(*) \)$, then there is a constant $C > 0$ such that $\| chevron.l macron(partial) u \, alpha chevron.r \| lt.eq C \| u \|$. But then by definition, $\| chevron.l u \, macron(partial)^(*) alpha chevron.r \| lt.eq C \| u \|$. Since $cal(D)_(\( p \, q \)) \( Omega \)$ is dense in $L^2$, this implies $macron(partial)^(*) alpha in L^2$ \
$D \( macron(partial)^(*) \) subset.eq D \( T^(*) \)$. If $macron(partial)^(*) alpha in L^2$, there is a constant $C > 0$ such that $\| chevron.l u \, macron(partial)^(*) alpha chevron.r \| lt.eq C \| u \|$. Fix $u in D \( T \)$. Let $u_i in cal(D)_(\( p \, q \)) \( Omega \)$ so that $u_i arrow.r u$ and $macron(partial) u_i arrow.r macron(partial) u$ in $L^2$. Then since $chevron.l u_i \, macron(partial)^(*) alpha chevron.r = chevron.l macron(partial) u_i \, alpha chevron.r$, we have $\| chevron.l macron(partial) u \, alpha chevron.r \| lt.eq C \| u \|$, and so $alpha in D \( T^(*) \)$

]

#pagebreak()

= Kähler metrics

#statement("Definition")[
$Omega subset.eq bb(C)^n$. A #emph[hermitian metric] on $Omega$ is a positive definite hermitian valued smooth function $g = \( g_(i macron(j)) \)$. The #emph[Kähler form]#index-entry("Kähler form") associated to $g$ is $omega = i sum_(i \, j = 1)^n g_(i macron(j)) d z_i and d macron(z)_j$, note that $macron(omega) = omega$. We assume that $g$ is tensorial, in the sense that $omega$ is a well-defined $\( 1 \, 1 \)$-form on $Omega$, $g_(i macron(j)) = ⟨frac(partial, partial z_i) \, frac(partial, partial macron(z)_j)⟩$. This gives a pointwise hermitian inner product on $\( 1 \, 0 \)$-forms: $alpha = alpha_i d z_i$, $beta = beta_j d z_j$ #math.equation(block: true, numbering: none, $chevron.l alpha \, beta chevron.r = sum_(i \, j = 1)^n alpha_i overline(beta_j) g^(i macron(j))$) $\( g^(i macron(j)) \)$ is the inverse matrix of $\( g_(i j) \)$. Extend this to $\( p \, 0 \)$-forms by #math.equation(block: true, numbering: none, $chevron.l alpha_1 and dots.h.c and alpha_p \, beta_1 and dots.h.c beta_p chevron.r = det chevron.l alpha_i \, beta_j chevron.r$) Extend this to $\( p \, q \)$-forms by taking the product of this. This gives a complex anti-linear isometry #math.equation(block: true, numbering: none, $overline(*) : Lambda^(p \, q) arrow.r Lambda^(n - p \, n - q) \, alpha and overline(*) beta = chevron.l alpha \, beta chevron.r frac(omega^n, n !)$) $frac(omega^n, n !)$ is the volume form. Inducing $L^2$ inner products #math.equation(block: true, numbering: none, $chevron.l alpha \, beta chevron.r = integral_Omega alpha and overline(*) beta$) Define the #emph[Lefschetz operator]#index-entry("Lefschetz operator") #math.equation(block: true, numbering: none, $L : Lambda^(p \, q) arrow.r Lambda^(p + 1 \, q + 1) \, alpha mapsto omega and alpha$) Let $Lambda = L^(*)$. Note that $L^n \( 1 \) = omega^n$, $Lambda^(n \, n) tilde.equiv bb(C)$

]
#statement("Example")[
If $F$ is of type $\( 1 \, 1 \)$, write $F = sum_(i \, j) F_(i macron(j)) d z_i and d macron(z)_j$. Then $Lambda F = sum_(i \, j) F_(i macron(j)) g^(i macron(j))$. If $alpha$ is of type $\( 1 \, 0 \)$ #math.equation(block: true, numbering: none, $i alpha and macron(alpha) and frac(omega^(n - 1), \( n - 1 \) !) = \| alpha \|^2 frac(omega^n, n !)$)

]
#statement("Definition")[
A hermitian metric is called Kähler if $d omega = 0$ ($omega$ is closed), equivalently, $frac(partial g_(j macron(k)), partial z_i) = frac(partial g_(i macron(k)), partial z_j)$

]
#statement("Proposition")[
$omega$ is Kähler iff about any point there are coordinates such that $g$ is euclidean to order two

]
#proof(title: "Proof")[
We may always choose local coordinate so that $g_(i macron(j)) \( 0 \) = delta_(i j)$, $g_(i macron(j)) = delta_(i j) + A_(i macron(j))^k z_k + B_(i macron(j))^(macron(k)) macron(z)_k + O \( \| z \|^2 \)$. The Kähler condition implies: $A_(i macron(j))^k = A_(k macron(j))^i$. The fact that $g_(i macron(j))$ is hermitian implies $B_(i macron(j))^(macron(k)) = overline(A_(j macron(i))^k)$. Define $w_m = z_m + 1 / 2 A_(j macron(m))^i z_i z_j$, then $frac(partial w_m, partial z_j) = delta_(m i) + A_(j macron(m))^i z_i$. Now $tilde(g)_(m macron(n)) frac(partial w_m, partial z_i) overline(frac(partial w_m, partial z_i)) = g_(i macron(j))$. This implies #math.equation(block: true, numbering: none, $g_(i macron(j)) \( z \) & = delta_(i j) + A_(i macron(j))^k z_k + B_(i macron(j))^(macron(k)) macron(z)_k + O \( \| z \|^2 \)\
 & = tilde(g)_(i macron(j)) + tilde(g)_(m macron(j)) A_(i macron(m))^k z_k + tilde(g)_(i macron(k)) overline(A_(j macron(n))^k z_k) + O \( \| z \|^2 \)$)

]
#statement("Proposition", title: [Kähler identities])[
$\( Omega \, omega \)$ has a Kähler metric. Then the formal $L^2$ adjoints are given by $macron(partial)^(*) = - i \[ Lambda \, partial \] \, partial^(*) = i \[ Lambda \, macron(partial) \]$

]
#proof(title: "Proof")[
It suffices to prove these for the euclidean metric. Then is a direct computation

]
#statement("Example")[
$Omega subset.eq bb(C)$, $Lambda \( i d z and d macron(z) \) = 1$, $f in cal(D)_(\( 0 \, 0 \)) \( Omega \)$, $beta in cal(D)_(\( 0 \, 1 \)) \( Omega \)$, $beta = beta \( z \) d macron(z)$. Then #math.equation(block: true, numbering: none, $chevron.l macron(partial) f \, beta chevron.r & = integral_Omega partial_(macron(z)) f overline(beta \( z \)) i d z and d macron(z)\
 & = - integral_Omega f overline(partial z beta \( z \)) i d z and d macron(z)\
 & = integral_Omega f overline(i partial beta)\
 & = integral_Omega f overline(Lambda \( i partial beta \) i d z and d macron(z))\
 & = - integral_Omega f overline(Lambda \( i partial beta \)) i d z and d macron(z)\
 & = chevron.l f \, - i Lambda partial beta chevron.r\
 & = chevron.l f \, macron(partial)^(*) beta chevron.r$)

]

#pagebreak()

= Solving $macron(partial)$ equation

#statement("Theorem")[
If $Omega subset.eq bb(C)^n$ is pseudoconnvex, then there is a complete Kähler metric on $Omega$

]
#proof(title: "Proof")[
From Richberg's lemma, there is a smooth strictly plurisubharmonic exhaustion function $psi$ on $Omega$. By adding a constant, we can assume $psi > 0$. Let $omega_0$ denote the euclidean Kähler form on $Omega$, and consider: $omega = omega_0 + i partial macron(partial) psi^2$, $i partial macron(partial) psi^2$ is semi-positive definite #math.equation(block: true, numbering: none, $omega = omega_0 + i partial psi and macron(partial) psi + i psi partial macron(partial) psi gt.eq omega_0 + i partial psi and macron(partial) psi$) #math.equation(block: true, numbering: none, $omega^n gt.eq omega_0 and omega^(n - 1) + i partial psi and macron(partial) psi and omega^(n - 1) gt.eq i partial psi and macron(partial) psi and omega^(n - 1)$) #math.equation(block: true, numbering: none, $frac(omega^n, n !) gt.eq 2 / n i partial psi and macron(partial) psi and frac(omega^(n - 1), \( n - 1 \) !) = 2 / n \| partial psi \|_omega^2 frac(omega^n, n !)$) So $\| d psi \|_omega = sqrt(2) \| partial psi \|_omega lt.eq C$. Completeness follows from Lemma #ref(label("Equivalent conditions of completeness and compact exhaustion"), supplement: none)

]
#statement("Definition")[
Let $d mu = omega^n \/ n !$ be a Kähler metric on $Omega$, $phi.alt in C^0 \( Omega \)$ be an exhaustion function. Define $L_(\( p \, q \))^2 \( Omega \, phi.alt \)$ to be the completion of smooth $\( p \, q \)$-forms with respect to the norm #math.equation(block: true, numbering: none, $parallel alpha parallel_phi.alt^2 = integral_Omega \| alpha \|_omega^2 e^(- phi.alt) d mu$)

]
The same density theorems apply as for unweighted spaces

For compactly supported $alpha$ #math.equation(block: true, numbering: none, $integral_Omega chevron.l macron(partial) u \, alpha chevron.r e^(- phi.alt) d mu = integral_Omega chevron.l u \, e^phi.alt macron(partial)^(*) \( e^(- phi.alt) alpha \) chevron.r e^(- phi.alt) d mu$) The new adjoint is $- i \[ Lambda \, partial_phi.alt \]$, $partial_phi.alt = e^phi.alt partial e^(- phi.alt) = partial - partial phi.alt$. Moreover #math.equation(block: true, numbering: none, $integral_Omega chevron.l partial_phi.alt u \, alpha chevron.r e^(- phi.alt) d mu = integral_Omega chevron.l partial \( e^(- phi.alt) u \) \, alpha chevron.r d mu = integral_Omega chevron.l u \, macron(partial)^(*) alpha chevron.r e^(- phi.alt) d mu$) So $partial_phi.alt^(*) = i \[ Lambda \, macron(partial) \]$

#statement("Definition")[
The Laplacian is $Delta = d^(*) d + d d^(*)$. The Dolbeault laplacians are #math.equation(block: true, numbering: none, $square.stroked_(macron(partial)) = macron(partial)^(*) macron(partial) + macron(partial) macron(partial)^(*) \, square.stroked_partial = partial_phi.alt^(*) partial_phi.alt + partial_phi.alt partial_phi.alt^(*)$) The curvature is the pure imaginary $\( 1 \, 1 \)$ form #math.equation(block: true, numbering: none, $F_phi.alt = macron(partial) partial_phi.alt + partial_phi.alt macron(partial) = partial macron(partial) phi.alt$)

]
#statement("Lemma")[
$square.stroked_(macron(partial)) - square.stroked_partial = \[ i F_phi.alt \, Lambda \]$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $macron(partial)^(*) macron(partial) = - i \[ Lambda \, partial_phi.alt \] macron(partial) = - i Lambda partial_phi.alt macron(partial) + i partial_phi.alt Lambda macron(partial)$) #math.equation(block: true, numbering: none, $macron(partial) macron(partial)^(*) = macron(partial) \( - i \[ Lambda \, partial_phi.alt \] \) = - i macron(partial) Lambda partial_phi.alt + i macron(partial) partial_phi.alt Lambda$) #math.equation(block: true, numbering: none, $- partial_phi.alt^(*) partial_phi.alt = - i \[ Lambda \, macron(partial) \] partial_phi.alt = - i Lambda macron(partial) partial_phi.alt + i macron(partial) Lambda partial_phi.alt$) #math.equation(block: true, numbering: none, $- partial_phi.alt partial_phi.alt^(*) = - partial_phi.alt \( i \[ Lambda \, macron(partial) \] \) = - i partial_phi.alt Lambda macron(partial) + i partial_phi.alt macron(partial) Lambda$)

]
#statement("Corollary")[
For $alpha in D \( macron(partial) \) inter D \( macron(partial)^(*) \)$ #math.equation(block: true, numbering: none, $parallel macron(partial) alpha parallel^2 + parallel macron(partial)^(*) alpha parallel^2 gt.eq chevron.l \[ i F_phi.alt \, Lambda \] alpha \, alpha chevron.r$)

]
#proof(title: "Proof")[
$chevron.l partial_phi.alt alpha \, alpha chevron.r gt.eq 0$ can be throw away, and $chevron.l square.stroked_(macron(partial)) alpha \, alpha chevron.r$ give the left hand side by integration by parts

]
#statement("Lemma")[
Write $i F_phi.alt = f_(i macron(j)) d z_i and d macron(z)_j$. If there is $C_0 > 0$ such that $sum f_(i macron(j)) \( z \) xi_i macron(xi)_j gt.eq C_0 \| xi \|^2$ for all $xi in bb(C)^n$ and all $z in Omega$, then there is $C_1 > 0$ such that #math.equation(block: true, numbering: none, $chevron.l \[ i F_phi.alt \, Lambda \] alpha \, alpha chevron.r gt.eq C_1 parallel alpha parallel^2$) for all $alpha in L_(\( n \, q \))^2 \( Omega \, omega \) \, q gt.eq 1$

]
Note that $\[ i F_phi.alt \, Lambda \] = 0$ on $\( n \, 0 \)$ forms. In particular, the condition that $q gt.eq 1$ is necessary. The applications of theis result extends to $\( p \, q \)$ froms, $q gt.eq 1$. We will only prove a couple of special cases. For the general result see Demailly

#statement("Example")[
Consider an $\( n \, 1 \)$ form $alpha$. Let $theta_i$ denote an orthonormal frame for $T^(1 \, 0) Omega$. Write $omega = i sum_j theta_j and macron(theta)_j$, and #math.equation(block: true, numbering: none, $alpha = i sum_(i = 1)^n alpha_i \( z \) theta_1 and dots.h.c and theta_n and macron(theta)_i$) Write $i F_phi.alt = sum f_(i macron(j)) theta_i and macron(theta)_j$

]
Write $sum_(i \, j) frac(partial^2 phi.alt_0, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j gt.eq m \( z \) \| xi \|^2$, where $m$ is a continuous function, $m \( z \) > 0$ for all $z in Omega$. We will replace a given $phi.alt_0$ with $phi.alt = chi compose phi.alt_0$, for an appropriate increasing convex function $chi$

Set $M \( t \) = \( min_(phi.alt_0 \( z \) gt.eq t) m \( z \) \)^(- 1)$. Then $M \( t \)$ is a positive, continuous, increasing function of $t$. Note that $M \( phi.alt_0 \( z \) \) m \( z \) gt.eq 1$

#aside("Claim")[
We can find a smooth $tilde(M) gt.eq M$ that is increasing

]
Assuming the claim, set $chi \( t \) = integral^t tilde(M) \( tau \) d tau$. Then $chi$ is convex, and $chi' \( t \) gt.eq M \( t \)$. Set $phi.alt = chi compose phi.alt_0$. Then $phi.alt$ is psh exhaustion function, and #math.equation(block: true, numbering: none, $sum_(i \, j) frac(partial^2 phi.alt, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j gt.eq sum_(i \, j) chi' compose phi.alt_0 frac(partial^2 phi.alt_0, partial z_i partial macron(z)_j) \( z \) xi_i macron(xi)_j gt.eq M \( phi.alt_0 \( z \) \) m \( z \) \| xi \|^2 gt.eq \| xi \|^2$)

#proof(title: "Proof of claim")[
This is probably obvious, by here is one idea: Let $psi : bb(R) arrow.r bb(R)$ be smooth with compact support in $\( - 1 \, 1 \)$, $0 lt.eq psi lt.eq 1$ and $integral_(bb(R)) psi = 1$. Set #math.equation(block: true, numbering: none, $tilde(M) \( t \) = integral_(bb(R)) M \( s \) psi \( s - t - 1 \) d s = integral_(bb(R)) M \( tau + t + 1 \) psi \( tau \) d tau$) The first equality proves that $tilde(M)$ is smooth. By the second equality #math.equation(block: true, numbering: none, $tilde(M) \( t \) gt.eq integral_(bb(R)) M \( t \) psi \( tau \) d tau = M \( t \)$) Also by the second equality, for $delta > 0$ #math.equation(block: true, numbering: none, $tilde(M) \( t + delta \) - M \( t \) = integral_(bb(R)) \( M \( tau + t + 1 \) - M \( tau + t + 1 \) \) psi \( tau \) d tau gt.eq 0$) So $tilde(M)$ is increasing

]
Summary: $Omega subset.eq bb(C)^n$ pseudoconvex, $omega$ complete. For an $\( n \, q \)$ form $alpha$, $q gt.eq 1$, and $alpha in D \( macron(partial) \) inter D \( macron(partial)^(*) \)$, we have proved the basic estimate #math.equation(block: true, numbering: none, $parallel macron(partial) alpha parallel_phi.alt + parallel macron(partial)^(*) alpha parallel_phi.alt gt.eq C parallel alpha parallel_phi.alt$) This implies that $macron(partial)$ has closed range and that the harmonics $cal(H)^(n \, q) = { 0 }$, i.e. $ker macron(partial) = "im" macron(partial)$

#statement("Theorem")[
If $alpha in L_(\( n \, q \))^2 \( Omega \, phi.alt \)$, $q gt.eq 1$, and $macron(partial) alpha = 0$, then there is $u in L_(\( n \, q - 1 \))^2 \( Omega \, phi.alt \)$ such that $macron(partial) u = alpha$. Moreover, $parallel u parallel lt.eq C parallel alpha parallel$

]
#aside("Note")[
In applications, having the estimate on the norms is crucial. Notice that $parallel parallel$ depends on the Kähler metric $omega$ and the weight $phi.alt$. We can get rid of the dependence on $omega$, i.e. prove the same result for the euclidean metric, by taking a limit of solutions for metrics $omega_epsilon.alt = omega_0 + epsilon.alt omega$ as $epsilon.alt arrow.r 0$ (see Demailly). On the other hand, $phi.alt$ is necessary. Optimizing the choice of $phi.alt$ is an important issue we will skip for now. Finally, the result holds more generally for $\( p \, q \)$ forms: $and.big^p T^(*) Omega tilde.equiv and.big^(n - p) T Omega times.o and.big T^(*) Omega$, so trivializing $and.big^(n - p) T Omega$ reduces the problem to this case. More importantly. This is not exactly what we want, since we are trying to solve $macron(partial)$ for all smooth $alpha$, not just those that are integrable. Let $L_(\( p \, q \))^2 \( Omega \, "loc" \)$ denote the $\( p \, q \)$ forms that are locally $L^2$. Notice that here the metric $omega$ and weight $phi.alt$ are irrelevant

]
#statement("Theorem")[
If $alpha in L_(\( p \, q \))^2 \( Omega \, "loc" \)$, $q gt.eq 1$, and $macron(partial) alpha = 0$, then there is $u in L_(\( p \, q - 1 \))^2 \( Omega \, "loc" \)$ such that $macron(partial) u = alpha$

]
#proof(title: "Proof")[
The idea is to find some weight $tilde(phi.alt)$ such that $alpha in L_(\( p \, q \))^2 \( Omega \, tilde(phi.alt) \)$, and then apply the previous result. We again choose the form $tilde(phi.alt) = chi compose phi.alt$, where $chi$ is increasing and convex. To do this, let $K_i = { z in Omega \| phi.alt \( z \) lt.eq i }$, and let $ell_i = parallel alpha parallel_(L^2 \( K_i \))^2$. Now choose $chi$ so that $e^(- chi \( i \)) \( ell_(i + 1) - ell_i \) lt.eq 2^(- i)$, then #math.equation(block: true, numbering: none, $integral_(K_(i + 1) \\ K_i) \| alpha \|^2 e^(- tilde(phi.alt)) d mu lt.eq e^(- chi \( i \)) integral_(K_(i + 1) \\ K_i) \| alpha \|^2 d mu lt.eq e^(- chi \( i \)) \( ell_(i + 1) - ell_i \) lt.eq 2^(- i)$) Hence #math.equation(block: true, numbering: none, $integral_Omega \| alpha \|^2 e^(- tilde(phi.alt)) d mu = sum_i integral_(K_(i + 1) \\ K_i) \| alpha \|^2 e^(- tilde(phi.alt)) d mu lt.eq sum_i 2^(- i) < oo$)

]
Elliptic regularity: The result applies, in particular, to the case where $alpha$ is smooth. However, the theorem just concludes that the solution $macron(partial) u = alpha$ is locally in $L^2$. We want to improve this

#statement("Theorem")[
If $alpha$ is a smooth $\( p \, q \)$-form on $Omega$, $q gt.eq 1$, with $macron(partial) alpha = 0$, then there is a smooth $\( p \, q - 1 \)$-form on $Omega$ such that $macron(partial) u = alpha$

]
#proof(title: "Proof")[
First consider the case $q = 1$, i.e. $u$ is a function. We know that $partial^(*) partial = macron(partial)^(*) macron(partial)$, so $parallel partial u parallel lt.eq parallel macron(partial) u parallel$. In particular, if $alpha in L^2 \( Omega \, "loc" \)$, then $u$ is in $L_1^2 \( Omega \, "loc" \)$ (one distributional derivative in $L^2$). Now differentiate the equation $macron(partial) u = alpha$ $k$ times to conclude that $u in L_k^2 \( Omega \, "loc" \)$ for arbitrary $k$. On the other hand, the Sobolev embedding theorem implies $L_k^2 arrow.r.hook C^j$ for $k gt.eq n + j$. Hence, if $alpha$ is smooth, so is $u$ \
If $q gt.eq 2$, then we have #math.equation(block: true, numbering: none, $L_(\( p \, q - 1 \))^2 \( Omega \, phi.alt \) = R \( macron(partial) \) xor R \( macron(partial)^(*) \)$) Moreover, $N \( macron(partial) \)^perp = R \( macron(partial)^(*) \)$. Hence, $u$ may be taken to be in the range of $macron(partial)^(*)$. Since $\( macron(partial)^(*) \)^2 = 0$, we have $square.stroked_(macron(partial)) u = macron(partial)^(*) macron(partial) u = macron(partial)^(*) alpha$. Let $Delta = d d^(*) + d^(*) d$ be the ordinary or de Rham Laplacian. Then in standard basis and euclidean metric, $Delta$ acts on the coefficients of $\( p \, q \)$-forms

]
#aside("Claim")[
$Delta = 2 square.stroked_(macron(partial))$

]
#proof(title: "Proof")[
Write $d = partial + macron(partial)$, $d^(*) = partial^(*) + macron(partial)^(*)$, then #math.equation(block: true, numbering: none, $Delta = square.stroked_(macron(partial)) + square.stroked_partial + macron(partial) partial^(*) + partial^(*) macron(partial) + partial macron(partial)^(*) + macron(partial)^(*) partial$) But the cross terms vanish: e.g. since $macron(partial)^2 = 0$ #math.equation(block: true, numbering: none, $macron(partial) partial^(*) = i macron(partial) \[ Lambda \, macron(partial) \] = i macron(partial) Lambda macron(partial)$) #math.equation(block: true, numbering: none, $partial^(*) macron(partial) = i \[ Lambda \, macron(partial) \] macron(partial) = - i macron(partial) Lambda macron(partial)$) The result now follows, since $square.stroked_partial = square.stroked_(macron(partial))$

]
It follows that if $alpha in L_1^2 \( Omega \, "loc" \)$, then $Delta u = 2 macron(partial)^(*) alpha$ is in $L^2 \( Omega \, "loc" \)$. We now appeal to the following interior estimate: if $U subset subset U' subset subset Omega$, then there is a constant $C > 0$ such that #math.equation(block: true, numbering: none, $parallel u parallel_(L_(k + 1)^2 \( U \)) lt.eq C (parallel parallel_(L_k^2 \( U' \)) + parallel Delta u parallel_(L_k^2 \( U' \)))$) for all smooth $\( p \, q \)$-forms. By "bootstrapping" the equation, we conclude that if $macron(partial) u = alpha$, $macron(partial)^(*) u = 0$, for $alpha$ smooth, then $u$ is in $L_k^2 \( Omega \, "loc" \)$ for any $k$, and hence is smooth by Sobolev embedding

#statement("Theorem")[
If $Omega subset.eq bb(C)^n$ is pseudoconvex, then $H_(upright(d R))^k \( Omega \) = 0$ for $k > n$

]
#statement("Remark")[
This is sharp, i.e. it is possible that $H_(upright(d R))^n \( Omega \) = 0$. For example $A_i = { 1 / 2 < \| z_i \| < 2 }$, $Omega = A_1 times dots.h.c times A_n$, let $Y = S^1 times dots.h.c times S^1 subset Omega$, and #math.equation(block: true, numbering: none, $beta = frac(d z_1 and dots.h.c and d z_n, z_1 dots.h.c z_n)$) Then $d beta = macron(partial) beta = 0$, and #math.equation(block: true, numbering: none, $integral_Y beta = integral_(\| z_1 \| = 1) frac(d z_1, z_1) dots.h.c integral_(\| z_n \| = 1) frac(d z_n, z_n) = \( 2 pi i \)^n$) Hence $0 eq.not \[ beta \] in H_(upright(d R))^n \( Omega \)$

]
#aside("Claim")[
Suppose $beta$ is a $k$-form such that $d beta$ is of type $\( k + 1 \, 0 \)$. Then $beta$ is cohomologous to a $\( k \, 0 \)$-form

]
#proof(title: "Proof")[
Write $beta = sum_(q = 0)^l beta_(\( k - q \, q \))$. Proof by induction on $l$. The case $l = 0$ is trivial. Assume $l gt.eq 1$ and that the result holds for $l - 1$. We have #math.equation(block: true, numbering: none, $d beta = partial beta + macron(partial) beta = sum_(q = 0)^l partial beta_(\( k - q \, q \)) + macron(partial) beta_(\( k - q \, q \))$) Thus $macron(partial) beta_(\( k - l \, l \)) = 0$, $beta_(\( k - l \, l \)) = macron(partial) u$, for a smooth $\( k - l \, l - 1 \)$ form $u$. Let $tilde(beta) = beta - d u$. Then $tilde(beta) = sum_(q = 0)^(l - 1) tilde(beta)_(\( k - q \, q \))$, $d beta = d tilde(beta)$,

]
#statement("Remark")[
Another proof use Morse theory: $phi.alt$ is a $C^oo$ psh exhaustion function, Morse function on $Omega$. The complex Hessian $frac(partial^2, partial z_j partial macron(z)_j) phi.alt > 0$ bound the number of negative eigenvalues of the real Hessian \
Lefschetz hyperplane theorem:

]
Solution to the Levi problem

#statement("Theorem")[
$Omega subset.eq bb(C)^n$ is a domain of holomorphy iff it is pseudoconvex. We have already proved $arrow.r.double$, by showing that $- log d \( z \)$ is a psh exhaustion function. We also showed that being a domain of holomorphy is equivalent to being holomorphically convex

]
#statement("Theorem")[
If we can solve $macron(partial)$ on $Omega subset.eq bb(C)^n$, then it is a domain of holomorphy

]
#proof(title: "Proof")[
Let $tilde(alpha) in C_(\( p \, q \))^oo \( tilde(Omega) \)$, $q gt.eq 1$, and $macron(partial) tilde(alpha) = 0$. Set $beta = z_n^(- 1) macron(partial) phi.alt and pi^(*) tilde(alpha)$. Then $beta in C_(\( p \, q + 1 \))^oo \( Omega \)$. Moreover, $macron(partial) beta = 0$. By the hypothesis of the theorem, there is $u in C_(\( p \, q \))^oo \( Omega \)$ such that $macron(partial) u = beta$. Consider $alpha = phi.alt pi^(*) tilde(alpha) - z_n u$. Then $macron(partial) alpha = 0$. Hence, there is $v in C_(\( p \, q - 1 \))^oo \( Omega \)$ such that $macron(partial) v = alpha$. Finally, since $z_n$ vanishes and $phi.alt equiv 1$ on $j \( tilde(Omega) \)$ This proves the claim. By the induction hypothesis, $tilde(Omega)$ is a domain of holomorphy. Hence, there is $tilde(f) in A \( tilde(Omega) \)$ that blows up at $xi$. As in the first part of the argument above, there is $u in C^oo \( Omega \)$ such that $f = phi.alt pi^(*) tilde(f) - z_n u in A \( Omega \)$, and $j^(*) f = tilde(f)$. Hence, $f$ blows up at $xi$

]

#pagebreak()

= Proper mapping theorems

#statement("Theorem", title: [Remmert theorem])[
If $f : X arrow.r Y$ is proper and $V subset.eq X$ is an analytic subvariety of $X$, then $f \( V \) subset.eq Y$ is an analytic subvariety of $Y$

]
#statement("Theorem", title: [Remmert-Stein theorem])[
$V subset.eq X$ is an analytic subvariety, $W subset.eq X \\ V$ is an irreducible analytic subvariety. If $dim V < dim W$, then the $overline(W) subset.eq X$ is an irreducible analytic subvariety

]
#statement("Remark")[
The assumption on dimension is necessary. For example, take the graph in $bb(C)^2 subset.eq bb(C P)^2$ of an entire function $f$. Suppose $f$ has essential singularity at infinity

]
#statement("Corollary")[
$X$ is an analytic space, $V$ is an analytic subvariety, $W subset.eq X \\ V$ is an analytic subvariety. If $dim V$ is less than the dimension of any irreducible components of $W$, then $overline(W) subset.eq X$ is an analytic subvariety

]
#statement("Theorem", title: [Chow's theorem])[
$V subset.eq bb(C P)^n$ is an analytic subvariety, then $V$ is a projective algebraic variety

]
#statement("Remark")[
$X$ is a Kahler manifold. $X$ is a Moisezon manifold(meaning the algebraic of dimension of $X = dim X$). A theorem of Moisezon says Kahler + Moisezon $arrow.r.double$ projective. There is an equivalence between Hodge manifolds(Kahler manifolds with integral Kahler class) and projective algberaic manifolds

]
#statement("Corollary")[
Every compact Riemann surface is an algebraic curve A holomorphic map between nonsingular projective algebraic varieties is a morphism of varieties Every memomorphic function on $bb(C P)^n$ is rational

]
#statement("Definition")[
$phi.alt : X arrow.r Y$ is holomorphic. $cal(E) arrow.r X$, $cal(F) arrow.r Y$ are sheaves of $cal(O)_X$, $cal(O)_Y$ modules. The sheaf $phi.alt^(- 1) cal(F)$ has presheaf is intuitively $phi.alt^(- 1) cal(F) \( U \) = cal(F) \( phi.alt \( U \) \)$. Alternatively, the espace étalé $X times_Y cal(F)$, at the level of stalks, $\( phi.alt^(- 1) cal(F) \)_p = cal(F)_(phi.alt \( p \))$. By composition with $phi.alt$ defines a sheaf map $phi.alt^(- 1) cal(O)_Y arrow.r cal(O)_X$, making $cal(O)_X \, cal(E)$ into $phi.alt^(- 1) cal(O)_Y$ modules #math.equation(block: true, numbering: none, $phi.alt^(*) cal(F) = cal(O)_X times.o_(phi.alt^(- 1) cal(O)_Y) phi.alt^(- 1) cal(F)$) There are canonical maps $phi.alt^(*) \( phi.alt_(*) cal(E) \) arrow.r cal(E)$, $cal(F) arrow.r phi.alt_(*) \( phi.alt^(*) cal(F) \)$ through #math.equation(block: true, numbering: none, $cal(E) \( phi.alt \( phi.alt^(- 1) \( U \) \) \) arrow.r cal(E) \( U \) \, cal(F) \( U \) arrow.r cal(F) \( phi.alt^(- 1) \( phi.alt \( U \) \) \)$) More generally, there is a canonical bijection $"Hom"_(cal(O)_X) \( phi.alt^(*) cal(F) \, cal(E) \) arrow.l.r "Hom"_(cal(O)_Y) \( cal(F) \, phi.alt_(*) cal(E) \)$

]
#statement("Fact")[
$phi.alt_(*)$ is left exact. $phi.alt^(*)$ is right exact. $phi.alt^(*) cal(O)_Y = cal(O)_X$. If $cal(F)$ is coherent, then $phi.alt^(*) cal(F)$ is coherent. $phi.alt_(*) cal(E)$ is not necessarily coherent even if $cal(E)$ is. For example, let $phi.alt : bb(C) arrow.r bb(C)^(*)$ be the exponential map, then $phi.alt_(*) cal(O)_(bb(C))$ is infinitely generated

]
#statement("Theorem", title: [Grauert-Remmert, Direct image theorem])[
$phi.alt : X arrow.r Y$ is finite, $cal(E) arrow.r X$ is coherent, then $phi.alt_(*) cal(E)$ is coherent. Moreover, $phi.alt_(*)$ is right exact

]
#statement("Example")[
$X = bb(C)^2 \\ { 0 }$, $Y = bb(C)$, $phi.alt \( z_1 \, z_2 \) = z_1$. Let $D = { \( 0 \, z_2 \) in X } tilde.equiv bb(C)^(*)$. $phi.alt \( D \) = { 0 }$, let $cal(I)_D$ be the ideal sheaf, $cal(O)_X arrow.r cal(O)_X \/ cal(I)_D arrow.r 0$, let $f = 1 \/ z_2$ is holomorphic on $D$, but is not in the image of $phi.alt_(*) cal(O)_X arrow.r phi.alt_(*) \( cal(O)_X \/ cal(I)_D \)$ by Hartogs's theorem. Thus $phi.alt_(*)$ is not right exact

]
#statement("Example")[
$X = { 0 }$, $Y = bb(C)$, $phi.alt$ is the inclusion. Consider injection $0 arrow.r cal(O)_Y arrow.r^(times z) cal(O)_Y$. The induced map $phi.alt^(*) cal(O)_Y arrow.r phi.alt^(*) cal(O)_Y$ is zero, hence $phi.alt^(*)$ is not left exact

]
$R^i phi.alt_(*) cal(E) \( V \) = H^i \( phi.alt^(- 1) \( V \) \, cal(E) \)$

Problem: $cal(E) arrow.r X$ is coherent, $R^i phi.alt_(*) cal(E) arrow.r Y$ might not be coherent

#statement("Theorem", title: [Grauert's proper coherence theorem])[
$X \, Y$ are complex spaces. $phi.alt : X arrow.r Y$ is proper, $cal(E) arrow.r X$ is coherent, then $R^i phi.alt_(*) cal(E) arrow.r Y$ is coherent for all $i$

]
#aside("Note")[
If $Y$ is a point, then $X$ is compact, this gives the Cartan-Serre theorem

]

#pagebreak()

= Stein manifolds

#statement("Definition")[
Let $M$ be a manifold. An almost complex structure on $M$ is an endomorphism $J : T M arrow.r T M$ with $J^2 = - I$. This imipliesd that $M$ has even real dimension $2 n$. Let $T^(1 \, 0) M xor T^(0 \, 1) M = T_(bb(C)) M = T M times.o bb(C)$ be the $plus.minus i$ eigenbundles of $J$. There is a real isomorphism $rho : T M arrow.r T^(1 \, 0) M$ such that $rho J = i rho$. We say that $J$ is integrable if $T^(1 \, 0) M$ is involutive (Frobenius theorem) #math.equation(block: true, numbering: none, $\[ T^(1 \, 0) M \, T^(1 \, 0) M \] subset.eq T^(1 \, 0) M$)

]
Let $J_0$ denote the standard almost complex structure on $bb(R)^(2 n)$. Then $J$ is integrable if about every pint there is a coordinate chart $\( U \, phi.alt \)$, $phi.alt : U arrow.r bb(R)^(2 n)$ such that $phi.alt_(*) J = J_0 phi.alt_(*)$. In this case, a local frame for $T^(1 \, 0) M$ on $U$ is given by the complex vector fields $frac(partial, partial z_1) \, dots.h.c \, frac(partial, partial z_n)$

#statement("Definition")[
A $2 n$ dimensional manifold $M$ is a complex manifold if it admits an atlas ${ \( U_alpha \, phi.alt_alpha \) }$ where the transition functions $phi.alt_beta compose phi.alt_alpha^(- 1)$ are biholomorphisms

]
#aside("Note")[
A manifold may admit inequivalent complex structures. A complex manifold has an integrable associated almost complex structure by pulling back $J_0$

]
#statement("Theorem", title: [Newlander-Nirenberg])[
An almost complex manifold is integrable iff it admits a complex manifold structure

]
#statement("Definition")[
A Hermitian metric on $E$ is a smooth Hermitian inner product on the fiber of $E arrow.r M$. We denote this $h$ or $chevron.l \, chevron.r$. If ${ s_i }_(i = 1)^r$ is a holomorphic frame, we write $h_(i macron(j)) = chevron.l s_i \, s_j chevron.r$. A connection on $E$ is a linear map $d_A : Omega^0 \( M \, E \) arrow.r Omega^1 \( M \, E \)$ satisfying the Leibniz rule: $d_A \( f s \) = d f times.o s + f d_A s$. We say $d_A$ is compatible with a holomorphic structure on $E$ if $macron(partial)_A = \( d_A \)^(0 \, 1) = macron(partial)_E$. We say $d_A$ is unitary if for any sections $s_1 \, s_2$ #math.equation(block: true, numbering: none, $d chevron.l s_1 \, s_2 chevron.r = chevron.l d_A s_1 \, s_2 chevron.r + chevron.l s_1 \, d_A s_2 chevron.r$)

]
#statement("Proposition")[
A Hermitian, holomorphic bundle admits a unique compatible, unitary connection. This is called the Chern connection

]
#proof(title: "Proof")[
$d_A = partial_A + macron(partial)_E$ is determined by the equation #math.equation(block: true, numbering: none, $partial chevron.l s_1 \, s_2 chevron.r = chevron.l partial_A s_1 \, s_2 chevron.r + chevron.l s_1 \, macron(partial)_A s_2 chevron.r$) In a holomorphic frame $s_i$, $partial_A s_i = d_A s_i = omega_i^j s_j$, where $omega_i^j = h^(j macron(k)) frac(partial h_(j macron(k)), partial z_j)$. Or, $omega = h^(- 1) partial h$

]
#statement("Definition")[
The curvature of a connection $A$ is $F_A = d_A^2$. This is an endomorphism-valued 2-form, i.e. $F_A in Omega^2 \( M \, "End" E \)$. $macron(partial)_E$ is integrable iff $macron(partial)_A^2 = F_A^(0 \, 2) = 0$. If $A$ is in addition unitary, then we have that $F_A$ is of type $\( 1 \, 1 \)$. In holomorphic local frame, $F_A = macron(partial) \( h^(- 1) partial h \)$. In particular, if $E$ is a line bundle, then $F_A = macron(partial) partial log h$. In general, if we modify the metric on $E$ by $e^(- phi.alt)$, then $omega_phi.alt = omega - partial phi.alt$ and $F_(\( macron(partial)_E \, h e^(- phi.alt) \)) = F_(\( macron(partial)_E \, h \)) + partial macron(partial) phi.alt$

]
#statement("Definition")[
$\( macron(partial)_E \, h \)$ is (strictly) Nakano positive if the Hermitian form $i F_(\( macron(partial)_E \, h \))$ is positive definite, i.e. there is $C > 0$ such that for each $xi in \( T X \)^(1 \, 0) times.o E$ #math.equation(block: true, numbering: none, $sum_(i \, j = 1)^n chevron.l F_(i macron(j)) xi^i \, xi^j chevron.r gt.eq C \| xi \|^2$) Where #math.equation(block: true, numbering: none, $F_(\( macron(partial)_E \, h \)) = sum F_(i macron(j)) d z_i and d macron(z)_j$) A holomorphic line bundle $cal(L) arrow.r X$ is positie if it admits a Nakano positive Hermitian metric. If $phi.alt$ is smooth and strictly plurisubharmonic, then by replacing $phi.alt$ by $chi compose phi.alt$ for a suitable positive convex function, we can arrange for $F_(\( macron(partial)_E \, h e^(- phi.alt) \))$ to be Nakano positive

]
#statement("Theorem")[
$X$ is a complex manifold, and there is a smooth strictly plurisubharmonic exhaustion function on $X$. Let $cal(E) arrow.r X$ be a holomorphic vector bundle. Then for every $alpha in Omega^(p \, q) \( X \, E \) \, q gt.eq 1$ with $macron(partial)_E alpha = 0$, there is $u in Omega^(p \, q - 1) \( X \, E \)$ such that $macron(partial)_E u = alpha$

]
If $phi.alt$ is the psh function, then $omega = i partial macron(partial) phi.alt^2$ is a complete Kähler metric on $X$. The Kähler identities are still valid for the Chern connection #math.equation(block: true, numbering: none, $macron(partial)_A^(*) - i \[ Lambda \, partial_A \] \, partial_A^(*) = i \[ Lambda \, macron(partial)_A \]$)

#statement("Theorem", title: [Holomorphic approximation])[
$cal(E) arrow.r X$ as above, $K_0 = { z in M \| phi.alt \( z \) lt.eq 0 }$. Then any holomorphic section of $cal(E)$ defined in a neighborhood of $K_0$ can be uniformly approximated by elements of $H^0 \( M \, cal(E) \)$

]
#proof(title: "Proof")[
Let $u in H^0 \( U \, cal(E) \)$ for $K_0 subset.eq U$. For any $epsilon.alt > 0$ we need to find $tilde(u) in H^0 \( X \, cal(E) \)$ such that $parallel tilde(u) - u parallel_(K_0) < epsilon.alt$

#aside("Claim")[
It suffices to show that if $v in L^2 \( K \, E \)$ such that $chevron.l u \, v chevron.r_(L^2 \( K \)) = 0$ for all $u in H^0 \( X \, cal(E) \)$, then $chevron.l u \, v chevron.r_(L^2 \( K \)) = 0$ for all $u in H^0 \( U \, cal(E) \)$

]
#proof(title: "Proof of claim")[
Let $r : H^0 \( X \, cal(E) \) arrow.r L^2 \( K \, E \)$ be the restriction map. Suppose $u in H^0 \( U \, cal(E) \)$ cannot be approximated on $K$. Define a linear map #math.equation(block: true, numbering: none, $T : "Span" { "im" r \, u } subset.eq L^2 \( K \, E \) arrow.r bb(C)$) #math.equation(block: true, numbering: none, $T \( u \) = 1 \, T \|_("im" r) = 0 upright(" and extending linearly")$) Then $T$ is continuous, and so by the Hahn-Banach theorem $T$ extends to a bounded operator on $L^2 \( K \, E \)$. But then by the Riesz representation theorem there is $v in L^2 \( K \, E \)$ such that $T \( dot.op \) = chevron.l dot.op \, v chevron.r$. This would contradict the conclusion of the claim. By composing with a convex function we find smooth psh functions $phi.alt_m$ such that $phi.alt_m = phi.alt$ on $K_0$ and $phi.alt_m arrow.r + oo$ on $X \\ K_0$. By the closed range property (with weight $phi.alt_m$): #math.equation(block: true, numbering: none, $L^2 \( X \, E \, phi.alt_m \) = H^0 \( X \, cal(E) \) xor R \( \( macron(partial)_E \)^(* m) \)$) Extend $v e^phi.alt$ by zero to all of $X$. By the main theorem we can solbe $\( macron(partial)_E \)^(* m) alpha_m = v e^phi.alt$. Moreover, we have estimates #math.equation(block: true, numbering: none, $parallel alpha_m parallel_(L^2 \( phi.alt_m \)) lt.eq C parallel v e^phi.alt parallel_(L^2 \( phi.alt_m \)) lt.eq C parallel v e^phi.alt parallel_(L^2 \( phi.alt \))$) Let $beta_m = e^(- \( phi.alt_m - phi.alt \)) alpha_m$. Then $\( macron(partial)_E \)^(*) beta_m = v e^phi.alt$, and #math.equation(block: true, numbering: none, $parallel beta_m parallel_(L^2 \( phi.alt \)) lt.eq parallel alpha_m parallel_(L^2 \( phi.alt_m \)) lt.eq parallel v e^phi.alt parallel_(L^2 \( phi.alt \))$) Let $beta_m arrow.r beta$ weakly in $L^2 \( phi.alt \)$. Then $beta equiv 0$ outside $K_0$. Use #math.equation(block: true, numbering: none, $\| beta_m \|^2 e^(- phi.alt) = e^(phi.alt_m - phi.alt) \| alpha_m \|^2 e^(- phi.alt_m)$) Moreover, $\( macron(partial)_E \)^(*) beta = v e^phi.alt$ in the sense of distributions. Now by integration by parts: if $u in H^0 \( U \, cal(E) \)$, then #math.equation(block: true, numbering: none, $chevron.l u \, v chevron.r_(L^2 \( K_0 \)) & = chevron.l u \, \( macron(partial)_E \)^(*) beta chevron.r_(L^2 \( K_0 \, phi.alt \))\
 & = chevron.l u \, \( macron(partial)_E \)^(*) beta chevron.r_(L^2 \( U \, phi.alt \))\
 & = chevron.l macron(partial)_E u \, beta chevron.r_(L^2 \( U \, phi.alt \))\
 & = 0$)

]

]
#statement("Definition")[
An $n$-dimensional complex manifold $X$ is a #emph[Stein manifold]#index-entry("Stein manifold") if

+ $X$ is holomorphically convex

+ $A \( X \)$ separates points, i.e. for $z_1 eq.not z_2 in X$, $exists f in A \( X \)$ such that $f \( z_1 \) eq.not f \( z_2 \)$

+ For each $z_0 in X$ there are $f_1 \, dots.h.c \, f_n in A \( X \)$ that give a coordinate system in a neighborhood of $z$, i.e. $d_(z_0) f_1 \, dots.h.c \, d_(z_0) f_n$ are linearly independent

]
#aside("Note")[
This is vacuous if $X$ is a domain in $bb(C)^n$, just take coordinate functions

]
#statement("Theorem")[
$X$ is a Stein iff there exists a smooth strictly psh exhaustion function on $X$

]
#proof(title: "Proof")[

]
#statement("Example")[
+ A domain of holomorphy in $bb(C)^n$ is Stein

+ A properly embedded complex submanifold is Stein iff it can be properly embedded in a Stein manifold

+ A positive dimensional Stein manifold is necessarily noncompact

+ If $X = 1$ (Riemann surfaces), then $X$ is Stein iff it is noncompact

+ Let $X$ be a compact and $cal(L) arrow.r X$ a positive line bundle. Suppose $0 eq.not s in H^0 \( X \, cal(L) \)$ with zero set $Z \( s \)$. Then $X_s = X \\ Z \( s \)$ is Stein

]
#proof(title: "Proof")[
+ This will follow from the existence of a strongly psh exhaustion function

+ Follows by considering $k times k$ minors of $D F$

+ This follows because holomorphic functions on compact (connected) $X$ are constant by the maximum principle

+ \($arrow.l.double$) is a theorem of Behnke-Stein

+ $phi.alt = - log \| s \|^2$ is a psh exhaustion function on $X_s$

]
#statement("Proposition")[
Let $X$ be a Stein manifold, and $hat(K) subset.eq U$. Then there is a smooth psh exhaustion function $phi.alt$ negative on $K$ and positive on $U^c$

]
#proof(title: "Proof")[

]
#statement("Lemma")[
Suppose $X$ admits a stricly psh exhaustion function $phi.alt$, given $z_0 in X$ there is $U_0$ and $u_0 in A \( U_0 \)$ such that $u_0 \( z_0 \) = 0$ and $"Re" u_0 \( z \) < phi.alt \( z \) - phi.alt \( z_0 \)$ for $z eq.not z_0$ in $U_0$

]
#proof(title: "Proof")[
Fix local coordinates where $z_0 = 0$. By Taylor expansion #math.equation(block: true, numbering: none, $phi.alt \( z \) = phi.alt \( 0 \) + "Re" P \( z \) + sum quad / quad \( 0 \) z_i macron(z)_j + O \( \| z \|^3 \)$) Where $P \( z \)$ is a polynomial of degree $lt.eq 2$, $P \( 0 \) = 0$. Now use the fact that teh hessian term is bounded below by $C \| z \|^2$

]
#statement("Theorem")[
Let $X$ be an $n$-dimensional Stein manifold. Then there is a proper embedding of $X$ in $bb(C)^(2 n + 1)$

]

#pagebreak()

= Oka's theorem

Cousin problems: Let $X$ be a complex manifold, ${ U_alpha }$ a locally finite open covering of $X$ \
I. Given ${ m_alpha }$ locally meromorphic functions such that $m_alpha - m_beta in A \( U_alpha inter U_beta \)$, find a global meromorphic function $m$ on $X$ such that $m - m_alpha$ is holomorphic on each $U_alpha$ \
II. Given ${ m_alpha }$ locally meromorphic functions, $m_alpha equiv.not 0$, such that $m_alpha m_beta^(- 1) in A \( U_alpha inter U_beta \)$, find a global meromorphic function $m$ on $X$ such that $m m_alpha^(- 1)$ and $m^(- 1) m_alpha$ are holomorphic on each $U_alpha$ \
These generalize the Mittag-Leffler and Weierstrass theorems in one dimension

Solutio to Cousin I for Stein manifold Set $u_(alpha beta) = m_alpha - m_beta$. Then ${ u_(alpha beta) }$ is a 1-cocucle of holoomorphic funtions. It suffices to find $u_alpha in A \( U_alpha \)$ such that $u_(alpha beta) = u_alpha - u_beta$. For then $m_alpha - u_alpha$ is a well-defined global meromorphic funtion. Let ${ psi_alpha }$ be a partition of unity. Set $h_alpha = sum_beta u_(alpha beta) psi_beta$. Then $u_(alpha beta) = h_alpha - h_beta$. ${ macron(partial) h_alpha }$ defines a global $\( 0 \, 1 \)$-form on $X$. Since $X$ is Stein, we can find a function $v$ so that $macron(partial) v = macron(partial) h_alpha$, i.e. $v - h_alpha$ is holomorphic on each $U_alpha$. Set $u_alpha = h_alpha - v$

#statement("Definition")[
Given $xi in bb(C)^n$, let $cal(O)_xi$ denote the ring of germs of holomorhic functions at $xi$. $cal(O)_xi$ is a commutative algebra over $bb(C)$ and $tilde.equiv$ the ring of convergent power series at $xi$. Clearly, $cal(O)_0^(\( n \))$ is an integral domain. Its function field $cal(M)_0$ is the field of germs of meromorphic functions at $0$. $cal(O)_0$ is a local ring with residue field $bb(C)$, the unique maximal ideal $frak(m)_0$ consists of germs of functions vanishing at $0$

]
#statement("Definition")[
$p in O_0^(\( n - 1 \)) \[ z_n \]$ is called a Weierstass polynomial if it is representaed by a funciton ofthe form #math.equation(block: true, numbering: none, $p \( w \, z_n \) = z_n^k + a_1 \( w \) z_n^(k - 1) + dots.h.c + a_k \( w \)$) where $a_i in frak(m)_0^(\( n - 1 \))$

]
#statement("Theorem", title: [Weierstrass preparation theorem])[
Suppose $f$ is regular of order $k$ in $z_n$, i.e. $f \( 0 \, z_n \)$ has a zero of order $k$ at $z_n = 0$ (In general, we can rotate). Then there exists a unique Weierstrass polynomial $p$ such that $f = u p$ for a unit $u$

]
#proof(title: "Proof")[
By Rouché's theorem, on a small neighborhood of $0 in bb(C)^n$, $z_n mapsto f \( w \, z_n \)$ has $k$-zeros $xi_1 \( w \) \, dots.h.c \, xi_k \( w \)$, counting multiplicity. By the residue theorem, for each $r = 1 \, 2 \, dots.h.c$ and fixed $w$ #math.equation(block: true, numbering: none, $sum_(j = 1)^k xi_j \( w \)^r = frac(1, 2 pi i) integral_(\| xi \| = delta) zeta^r frac(f' \( w \, zeta \), f \( w \, zeta \)) d zeta$) From this, the elementary symmetric polynomials in the $xi_j \( w \)$ are holomorphic in $w$. Hence #math.equation(block: true, numbering: none, $p \( w \, z_n \) = product_(j = 1)^k \( z_n - xi_j \( w \) \)$) is a Weierstrass polynomial. Now let $u = f \/ p$. This is holomorphic by the Riemann extension theorem

]
#statement("Theorem", title: [Weierstrass division theorem])[
Let $p in cal(O)_0^(\( n - 1 \)) \[ z_n \]$ be a Weierstrass polynomial of degree $k$. Then any $f in cal(O)_0^(\( n \))$ can be written uniquely as $f = g p + r$, where $r in cal(O)_0^(\( n - 1 \)) \[ z_n \]$ is a polynomial of degree $< k$. If $f in cal(O)_0^(\( n - 1 \)) \[ z_n \]$, then so is $g$

]
#proof(title: "Proof")[

]
#statement("Lemma")[
A Weierstrass polynomial $h in cal(O)_0^(n - 1) \[ z_n \]$ is reducible over $cal(O)_0^(\( n \))$ iff it is reducible over $cal(O)_0^(n - 1) \[ z_n \]$. In this case, all factors are Weierstrass polynomials, modulo units

]
#proof(title: "Proof")[

]
#statement("Theorem")[
$cal(O)_0^(\( n \))$ is a UFD

]
#proof(title: "Proof")[

]
#statement("Theorem", title: [Oka])[
$cal(O)_0^(\( n \))$ is a Noetherian local ring

]
#proof(title: "Proof")[
By Hilbert basis theorem, $cal(O)_0^(\( n - 1 \)) \[ z_n \]$ is Noetherian by induction. Let $frak(a) subset.eq cal(O)^(\( n \)_0)$ be an ideal, and assume $g in frak(a)$ is a regular in $z_n$. Up to units, we may assume it is a Weierstrass polynoimal Let $g_1 \, dots.h.c \, g_m$ generate $frak(a) inter cal(O)_0^(\( n - 1 \)) \[ z_n \]$. We claim the $g \, g_1 \, dots.h.c \, g_m$ generate $frak(a)$. Let $f in frak(a)$. By WD write $f =$

]
We will be interested in $cal(O)_0$ modules $cal(E)_0$

Since $cal(O)_0$ is Noetherian, a finitely generated module is finitely presented, i.e. there is an exact sequence (This is actually called #emph[syzygy]#index-entry("Syzygy")) #math.equation(block: true, numbering: none, $cal(O)_0^(xor s) arrow.r cal(O)_0^(xor r) arrow.r cal(E)_0 arrow.r 0$) $cal(O)_0^(xor s)$ are the finitely many relations

Let $Omega subset.eq bb(C)^n$ be a domain, and $F^1 \, dots.h.c \, F^r in A \( Omega \)^(xor p)$. For $xi in Omega$, let $cal(E)_xi$ be the $cal(O)_xi$ module generated by $F_xi^1 \, dots.h.c \, F_xi^r$. Let $cal(R)_xi$ be the $cal(O)_xi$ module of relations #math.equation(block: true, numbering: none, $cal(R)_xi = { }$) Since $cal(O)_xi$ is Noetherian, $cal(R)_xi$ is finitely generated submodule of $cal(O)_xi^(xor r)$ for every $xi in Omega$ Question: Can we find finitely many functions

We now rephrase Oka's theorem

#statement("Theorem")[
Given, then for each there is an open set and such that #math.equation(block: true, numbering: none, $\( cal(O)_U^(\( n \)) \)^(xor r) arrow.r^lambda \( cal(O)_U^(\( n \)) \)^(xor p) arrow.r^mu \( cal(O)_U^(\( n \)) \)^(xor q)$) is exact on $U$, here $r$ might depend on the choice of $xi_0$

]
Let $cal(O)_(0 \, d)^(\( n - 1 \)) \[ z_n \]$ denote the polynomials of degree at most $d$. This is a finitely generated $cal(O)_0^(\( n - 1 \))$ submodule of $cal(O)_0^(\( n - 1 \)) \[ z_n \]$

First assume $q = 1$

#statement("Lemma")[
Suppose $lambda \, mu$ have entries in $cal(O)_0^(\( n - 1 \)) \[ z_n \]$ of degree $l$ and $m$, respectively. Assume that one of the entries of $mu$ is regular in $z_n$. Then we have a sequence #numbered-equation($\( cal(O)_(0 \, d - l)^(\( n - 1 \)) \[ z_n \] \)^(xor r) arrow.r^lambda \( cal(O)_(0 \, d)^(\( n - 1 \)) \[ z_n \] \)^(xor p) arrow.r^mu \( cal(O)_(0 \, d - l)^(\( n - 1 \)) \[ z_n \] \)$)#label("Lemma for oka's theorem 1") as well as #numbered-equation($quad$)#label("Lemma for oka's theorem 2") If $d gt.eq m$ and is an exact suquence of modules, then is an exact sequence of modules

]
#proof(title: "Proof")[
Assume $mu =$

]
Consequence of Oka's theorem: coherent analytic sheaves on $X$ form an abelian category. This is not true for holomorphic vector bundles

#statement("Proposition")[
If $phi.alt : cal(E) arrow.r cal(F)$ is a homomorphism between coherent analytic sheaves, then $ker phi.alt$ and $"coker" phi.alt$ are coherent

]
#statement("Proposition")[
Suppose we have a short exact sequence of analytic sheaves #math.equation(block: true, numbering: none, $0 arrow.r cal(S) arrow.r cal(E) arrow.r cal(Q) arrow.r 0$) If any two of the three sheaves are coherent, then so is the third

]

#pagebreak()

= Cartan theorems

#statement("Theorem")[
$K subset.eq X$ compact with $hat(K) = K$. For all coherent sheaves $cal(E)$ defined on a nbd of $K$

+ There exist sections of $cal(E)$ on a nbd $U$ of $K$ that generate $cal(E)_z$ for every $z in U$

+ and if $sigma$ is any other section of $cal(E)$ on $U$, then $sigma = sum f_i sigma_i$ for some $f_i in A \( U \)$

In terms of exact sequences, there exists on $U$ an exact sequence $O arrow.r E arrow.r 0$ and the induced map is exact

]
#statement("Lemma")[
$hat(K) = K$ as above, $f in A \( X \)$. Suppose property holds for $K_a = { z in K \| "Re" \( f \( z \) \) = a }$ for all $z in bb(R)$. Then it holds for $K$

]
#proof(title: "Proof")[
Define $K_(a \, b) = { z in K \| a lt.eq "Re" \( f \( z \) \) lt.eq b }$, then $hat(K)_(a \, b) = K_(a \, b)$. Indeed, this condition is equivalent to saying $\| e^(f \( z \)) \| lt.eq e^b$, and $\| e^(- f \( z \)) \| lt.eq e^(- a)$. Suppose $z in hat(K)_(a \, b)$. If $z in K$, then $\| e^(f \( z \)) \| lt.eq parallel e^(f \( z \)) parallel_(K_(a \, b)) lt.eq e^b$, $\| e^(- f \( z \)) \| lt.eq parallel e^(- f \( z \)) parallel_(K_(a \, b)) lt.eq e^(- a)$. If $z in.not K = hat(K)$, there is $g in A \( X \)$ such that $\| g \( z \) \| gt.eq parallel g parallel_K gt.eq parallel g parallel_(K_(a \, b))$, $z in.not hat(K)_(a \, b)$. Suppose $beta = sup$. If $beta = + oo$, then we are done. If not, by hypothesis we can find a nbd $U_1$ of $K_(beta \, beta)$ and sections $phi.alt_1 \, dots.h.c \, phi.alt_p$ generating $cal(E)$ on $U_1$. Choose $alpha < beta < b$ such that $K_(a \, b) subset.eq U_1$. We can find nbd $U_2$ of $K_(- oo \, a)$ and sections $psi_1 \, dots.h.c \, psi_q$ generating $cal(E)$ on $U_2$. Regard $phi.alt \, psi$ as column vectors, shrinking the sets if necessary, we may assume there are matrix valued holomorphic functions $A_1 \, A_2$ such that $psi = A_1 phi.alt$ and $phi.alt = A_2 psi$. In other words #math.equation(block: true, numbering: none, $mat(delim: "[", phi.alt; 0) = mat(delim: "[", 1, 0; - A_1, 1) mat(delim: "[", 1, A_2; 0, 1) mat(delim: "[", 0; psi)$) We wnat to find vectors $f_1 \, f_2$ of dimension $p + q$ such that #math.equation(block: true, numbering: none, $f_1 dot.op mat(delim: "[", phi.alt; 0) = f_2 dot.op mat(delim: "[", 0; psi)$) on the intersection $U_1 inter U_2$. Let #math.equation(block: true, numbering: none, $c_21 = c_12^(- 1) = mat(delim: "[", 1, ; A_2^T, 1) mat(delim: "[", 1, - A_1^T; #none, 1)$) Then $f_i$ satisfy $f_2 = c_21 f_1$. We may view ${ f_1 \, f_2 }$ as a section of rank $p + q$ holomorphic vector bundle over $U_1 inter U_2$ with transition function $c_12$. We may also suppose that $U_1 inter U_2$ is Stein. Since we have already show that global sections of vector bundles exist, we can find such a pair and this leads to a contradiction

]
#statement("Theorem", title: [Cartan Theorem A])[
Let $cal(E) arrow.r X$ be a coherent analytic sheaf on a Stein manifold. Then for every $z in X$, $cal(E)_z$ is generated by the germs of global sections $Gamma \( X \, cal(E) \)$

]
#statement("Theorem", title: [Cartan Theorem B])[
Let $cal(E) arrow.r X$ be a coherent analytic sheaf on a Stein manifold. Then $H^q \( X \, cal(E) \) = { 0 }$ for all $q gt.eq 1$

]
#statement("Remark")[
For locally free sheaves, $H^q \( X \, cal(E) \) tilde.equiv H_(macron(partial))^(0 \, q) \( X \, E \)$, and we have proven this result using the solution to the $macron(partial)$ equation

]
#statement("Definition")[
$cal(E) arrow.r X$ is called a #emph[fine sheaf]#index-entry("Fine sheaf") if it admits a partition of unity for every locally finite cover

]
#statement("Proposition")[
Suppose #math.equation(block: true, numbering: none, $0 arrow.r Gamma \( X \, cal(S) \) arrow.r Gamma \( X \, cal(E) \) arrow.r Gamma \( X \, cal(Q) \)$) is exact. If $cal(S)$ is a fine sheaf, then is $Gamma \( X \, cal(E) \) arrow.r Gamma \( X \, cal(Q) \)$ surjective

]
#statement("Definition")[
Cohomology is a funtor #math.equation(block: true, numbering: none, $H^bullet : { upright("sheaves on ") X } arrow.r { upright("abelian groups") }$) satisfying axioms

+ $H^0 \( X \, cal(E) \) = Gamma \( X \, cal(E) \)$

+ If $cal(E)$ is a fine sheaf, then $H^p \( X \, cal(E) \) = 0$ for $p gt.eq 1$

+ If $0 arrow.r cal(S) arrow.r cal(E) arrow.r cal(Q) arrow.r 0$ is a short exact sequence, then we have long exact sequence

]
#statement("Proposition")[
Let $cal(E) arrow.r X$ be a sheaf with a fine resolution, i.e. a long exact sequence #math.equation(block: true, numbering: none, $0 arrow.r cal(E) arrow.r cal(A)^0 arrow.r^(d_0) cal(A)^1 arrow.r^(d_1) dots.h.c$) Then #math.equation(block: true, numbering: none, $H^p \( X \, cal(E) \) = frac(ker \( cal(A)^p \( X \) arrow.r^(d_p) cal(A)^(p + 1) \( X \) \), "im" \( cal(A)^(p - 1) \( X \) arrow.r^(d_(p - 1)) cal(A)^p \( X \) \))$)

]
#statement("Theorem")[
Let $X$ be a complex manifold, and suppose that $H^1 \( X \, cal(E) \) = 0$ for every coherent analytic sheaf $cal(E) arrow.r X$. Then $X$ is Stein

]
#proof(title: "Proof")[
$A \( X \)$ separates points: Let $cal(I)_(x \, y)$ be the sheaf of germs of holomorphic functions vanishing at $x$ and $y$. This is a coherent sheaf. From the exact sequence #math.equation(block: true, numbering: none, $0 arrow.r cal(I)_(x \, y) arrow.r cal(O)_X arrow.r cal(O)_X \/ cal(I)_(x \, y) arrow.r 0$) We have by the assumption #math.equation(block: true, numbering: none, $H^0 \( X \, cal(O)_X \) arrow.r H^0 \( X \, cal(O)_X \/ cal(I)_(x \, y) \) tilde.equiv cal(C)^(xor 2) arrow.r H^1 \( X \, cal(I)_(x \, y) \) = 0$) Hence there is $f in A \( X \)$ such that $f \( x \) = 1$ and $f \( y \) = 0$ \
$A \( X \)$ gives local coordinates: Let $z_1 \, dots.h.c \, z_n$ be local coordinates at $x$, then the germs of these generate $cal(I)_x \/ cal(I)_x^2$. we have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r cal(I)_x^2 arrow.r cal(I)_x arrow.r cal(I)_x \/ cal(I)_x^2 arrow.r 0$) From the vanishing of $H^1 \( X \, cal(I)_x^2 \)$, we may find functions $f_1 \, dots.h.c \, f_n in A \( X \)$, vanishing at $x$, $f_i = z_i$ modulo \
$X$ is holomorphically convex: ${ x_i }$ is a discrete sequence, $cal(I)_({ x_i })$ is coherent. From the vanishing of $H^1 \( X \, cal(O)_X \/ cal(I)_({ x_i }) \)$, there is $f in A \( X \)$ such that $f \( x_i \) = i$

]
#statement("Remark")[
Notice the similarity with the proof of the Kodaira embedding theorem

]
#statement("Theorem", title: [Cartan-Serre theorem])[
$X$ is a compact complex manifold. Then for any coherent sheaf $cal(E) arrow.r X$, the cohomology groups $H^p \( X \, cal(E) \)$ are finite dimensional

]
#proof(title: "Proof")[
Recall the Frechet space structure we have on sections of coherent sheaves. Coherent sheaves satisfy the Montel property: if $U subset subset V$, then the restriction map $H^0 \( V \, cal(E) \) arrow.r H^0 \( U \, cal(E) \)$ is a compact operator. Now choose finite Stein open coverings ${ U_i } \, { V_i }$, $V_i subset subset V_i$ such that #math.equation(block: true, numbering: none, $H^p \( cal(U) \, cal(E) \) = H^p \( cal(V) \, cal(E) \) = H^p \( X \, cal(E) \)$) Then by the finiteness of the cover, the restriction map #math.equation(block: true, numbering: none, $rho : C^p \( cal(V) . cal(E) \) arrow.r C^p \( cal(U) \, cal(E) \)$) is compact. The coboundary map $delta$ is clearly continuous, so $Z^p = ker delta$ is a closed subspace, hence a Frechet space. Now define #math.equation(block: true, numbering: none, $u : Z^p \( cal(U) \, cal(E) \) xor C^(p - 1) \( cal(U) \, cal(E) \) arrow.r Z^p \( cal(U) \, cal(E) \)$) by $u \( phi.alt \, psi \) = rho \( phi.alt \) + delta psi$. Then $u$ is surjective. Apply Theorem #ref(label("Schwartz theorem"), supplement: none) to $T = u$ and $S = - rho$

]
#statement("Theorem", title: [Laurent Schwartz])[
Let $E \, F$ be Frechet spaces with $T : E arrow.r F$ is surjective and $S : E arrow.r F$ compact. Then $T + S$ has closed range and $F \/ "im" \( T + S \)$ is finite dimensional

]#label("Schwartz theorem")
#statement("Definition")[
$X$ is a complex manifold. A subset $V subset.eq X$ is called an #emph[analytic subvariety]#index-entry("analytic subvariety") of $X$ is for every point $x in X$ there is neighborhood $U$ of $x$ and $f_1 \, dots.h.c \, f_l in A \( U \)$ such that $V inter U = Z \( f_1 \, dots.h.c \, f_l \)$, the common zero locus of $f_i$'s

]
It follows that $V subset.eq X$ is closed. A complex submanifold of codimension $l$ is an analytic subvariety

The ideal sheaf $cal(I)_V$ is coherent by Oka's theorem. $cal(O)_V = cal(O)_X \/ cal(I)_V$

Fact: The maximum principle holds for holomorphic functions on subvarieties

Consequence: The only compact subvarieties of a Stein manifold are finite collections of points


#pagebreak()
#heading(numbering: none)[References]

#emph[An Introduction to Complex Analysis in Several Variables] - Lars Hörmander

#pagebreak()
#heading(numbering: none)[Index]
#index-list()
