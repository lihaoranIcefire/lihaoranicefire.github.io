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
#let overlapping-domains-diagram() = box(width: 76mm, height: 52mm)[
  #place(top + left, dx: 2mm, dy: 2mm, circle(radius: 24mm, stroke: 0.6pt))
  #place(top + left, dx: 26mm, dy: 2mm, circle(radius: 24mm, stroke: 0.6pt))
  #place(top + left, dx: 32mm, dy: 20mm, circle(radius: 6mm, stroke: 0.6pt))
  #place(top + left, dx: 11mm, dy: 24mm, $Omega$)
  #place(top + left, dx: 59mm, dy: 24mm, $Omega_2$)
  #place(top + left, dx: 35mm, dy: 24mm, $Omega_1$)
]
#let slit-domain-diagram() = box(width: 28mm, height: 28mm)[
  #place(top + left, dx: 2mm, dy: 2mm, circle(radius: 12mm, stroke: 0.6pt))
  #place(top + left, dx: 14mm, dy: 14mm, line(length: 12mm, stroke: 0.6pt))
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

#align(center)[
  #set par(justify: false)
  #v(1cm)
  #text(size: 22pt, weight: "bold", hyphenate: false)[MATH868C \ Several Complex Variables]
  #v(2cm)
  #image("Pictures/Lars_Hormander.jpg", width: 50%)
  #v(2cm)
  Taught by #text("Tam\u{e1}s Darvas") \
  Notes taken by Haoran Li \
  2018 Fall
  #v(2cm)
  Department of Mathematics \
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()


= Subharmonic functions

#statement("Definition")[
$Omega subset.eq bb(C)$ is an open set, $h in C^2 \( Omega \)$ is #emph[harmonic]#index-entry("Harmonic function") if $Delta h = frac(4 partial^2, partial z partial macron(z)) h = 0$, denote the set of harmonic functions $H \( Omega \)$

]
#statement("Definition")[
$u : Omega arrow.r \[ - oo \, + oo \)$ is subharmonic, denoted $u in S H \( Omega \)$ if

- $u$ is upper semi-continuous, i.e. ${ u < r }$ is open

- For any compact $K subset.eq Omega$, and $h in H \( "Int" K \) inter C \( K \)$ such that $u lt.eq h$ on $partial K$, then $u lt.eq h$ on $K$

]
#statement("Theorem")[
${ u_j } subset.eq S H \( Omega \)$, $v = sup_j u_j$. If $v$ is upper semi-continuous, then $v in S H \( Omega \)$, $u = inf_j u_j$ is upper semi-continuous generally doesn't imply $u in S H \( Omega \)$, but if ${ u_j }$ is decreasing, then $u in S H \( Omega \)$

]
#statement("Theorem")[
$u : Omega arrow.r \[ - oo \, + oo \)$ is upper semi-continuous. The following are equivalent

+ $u in S H \( Omega \)$

+ For any $overline(D) subset.eq Omega$, and any polynomial $f \( z \)$, if $u lt.eq "Re" f$ on $partial D$, then $u lt.eq "Re" f$

+ $Omega_delta = { z in Omega \| upright(d i s t) \( z \, partial Omega \) > delta } subset.eq Omega$, for $z in Omega_delta$ #math.equation(block: true, numbering: none, $2 pi u \( z \) integral_0^delta d mu \( r \) lt.eq integral_0^delta integral_0^(2 pi) u \( z + r e^(i theta) \) d theta d mu \( r \)$) here $d mu$ is any measure on $\[ 0 \, delta \]$, take $d mu \( r \) = r d r$, the average of the disk, take $d mu \( r \)$ to be Dirac measure, the average of the circle

]
#proof(title: "Proof")[
\1. $arrow.r.double$ 2. is by definition. 2. $arrow.r.double$ 3.

- If $p \( z \) = sum_(j = 0)^k a_j z^j$, then $2 pi "Re" p \( z \) integral_0^delta d mu \( r \) = integral_0^delta integral_0^(2 pi) "Re" p \( z + r e^(i theta) d theta d mu \( r \) \)$

- $phi in C \( partial D \( z \, r \) \)$, $r in \[ 0 \, delta \]$ such that $u lt.eq phi$ on $partial D \( z \, r \)$. Fourier: $exists p_k = sum_(j = 0)^l a_j^k z^j$ such that $phi lt.eq "Re" p_k lt.eq phi + 1 / k$ (Rudin). $u lt.eq "Re" p_k$ on $partial D \( z \, r \)$, by 2. $u \( z \) lt.eq "Re" p_k \( z \)$, then $2 pi u \( z \) lt.eq 2 pi "Re" p_k \( z \) = integral_0^(2 pi) "Re" p_k \( z + r e^(i theta) \) d theta arrow.r integral_0^(2 pi) phi \( z + r e^(i theta) \) d theta$ as $k arrow.r oo$

- $u : X arrow.r \[ - oo \, oo \)$ is upper semi-continuous and bounded above, ${ f_j } subset.eq C \( X \)$ such that $f_j arrow.br u$, then there exists ${ phi_j } subset.eq C \( partial D \( z \, r \) \)$ such that $phi_j arrow.br u$ on $partial D \( z \, r \)$, then $2 pi u \( z \) lt.eq integral_0^(2 pi) phi_j \( z + r e^(i theta) \) d theta arrow.r integral_0^(2 pi) u \( z + r e^(i theta) \) d theta$, integrate this over $\[ 0 \, delta \]$ of $d mu$

\3. $arrow.r.double$ 1. Assume 1. doesn't hold, $exists K subset.eq Omega$ compact, $h in C \( K \) inter H \( "Int" K \)$ such that $u lt.eq h$ on $partial K$ but $u \( z \) > h \( z \)$ for some $z in K$, define $F = { z in K \| u \( z \) = max_K \( u - h \) } eq.not diameter$ and closed, compact, thus $exists x in F$ such that $upright(d i s t) \( x \, partial K \)$ is a minimizer. For some $r$, an open part of $partial D \( z \, r \)$ lies outside $F$, $integral_0^(2 pi) \( u - h \) \( x + r e^(i theta) \) d theta < \( u - h \) \( x \)$ which is a contradiction

]
#statement("Corollary")[
$f in cal(O) \( Omega \) arrow.r.double log \| f \| in S H \( Omega \)$, if $f = 0$, $log \| f \| = - oo$

]
#proof(title: "Proof")[
$overline(D) subset.eq Omega$, $p = sum_(j = 0)^k a_j z^j$, if $log \| f \| lt.eq "Re" p$ on $partial D$, then $\| f \| lt.eq e^("Re" p) arrow.l.r.double \| f \| lt.eq \| e^p \|$ on $partial D arrow.r.double \| f / e^p \| lt.eq 1$ on $partial D arrow.r.double dots.h.c$

]
#statement("Corollary")[
$phi : bb(R) arrow.r bb(R)$ is convex and increasing, $u in S H \( Omega \)$, then $phi compose u in S H \( Omega \)$

]
#proof(title: "Proof")[
Sub-mean value inequality + Jensen inequality

]
#statement("Theorem")[
$u in S H \( Omega \)$ $u equiv.not - oo$ on a component of $Omega$, then $u in L_("loc")^1 \( Omega \)$. $Delta u gt.eq 0$ as a distribution, i.e. $integral_Omega u Delta v gt.eq 0$ $forall v in C_0^2 \( Omega \) \, v gt.eq 0$

]
#proof(title: "Proof")[
$r = upright(d i s t) \( "supp" v \, partial Omega \)$, $x in Omega_r$, $2 pi u \( x \) lt.eq integral_0^(2 pi) u \( x + delta e^(i theta) \) d theta$, $delta in \[ 0 \, r \]$. $2 pi integral_Omega u \( x \) v \( x \) d lambda lt.eq integral_Omega integral_0^(2 pi) u \( x + delta e^(i theta) \) v \( x \) d theta d lambda \( x \) arrow.r.double 0 lt.eq integral_Omega u \( x \) integral_0^(2 pi) u \( x + delta e^(i theta) \) frac(v \( x - delta e^() i theta \) - v \( x \), delta^2) d theta d lambda$ as $delta arrow.r 0$, $0 lt.eq integral_Omega u \( x \) 2 pi Delta v \( x \) d lambda$

]
#statement("Theorem", title: [Implicit function theorem])[
$\( w \, z \) = \( w_1 \, dots.h.c \, w_m \, z_1 \, dots.h.c \, z_n \)$, $f_j \( w \, z \)$ are analytic in a neighborhood of $\( w^0 \, z^0 \) in bb(C)^(m + n)$, suppose $f_j \( w^0 \, z^0 \) = 0$, $det \( frac(partial f_j, partial w_k) \) eq.not 0$ at $\( w^0 \, z^0 \)$, then $exists w \( z \)$ analytic in a neighborhood of $z^0$ with $w \( z^0 \) = w^0$, $F \( w \( z \) \, z \) = 0$

]

#pagebreak()

= Cauchy's formula

#statement("Definition")[
$D = D \( x_1 \, r_1 \) times dots.h.c times D \( x_n \, r_n \)$ is called a #emph[polydisc]#index-entry("Polydisc"). $partial_0 D = partial D_1 times dots.h.c times partial D_n subset.neq partial D$ is the #emph[distinguished boundary]#index-entry("Distinguished boundary") of $D$

]
#statement("Theorem")[
$u in C \( overline(D) \) inter cal(O) \( D \)$, then #math.equation(block: true, numbering: none, $u \( z \) = frac(1, \( 2 pi i \)^n) integral_(partial_0 D) frac(u \( xi_1 \, dots.h.c \, xi_n \), \( xi_1 - z_1 \) dots.h.c \( xi_n - z_n \)) d xi_1 dots.h.c d xi_n \, forall z in D$)

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $u \( z_1 \, dots.h.c \, z_(n - 1) \, z \) = frac(1, 2 pi i) integral_(partial D_n) frac(u \( z_1 \, dots.h.c \, z_(n - 1) \, xi \), xi_n - z_n) d xi$) $z_(n - 1) mapsto u \( z_1 \, dots.h.c \, z_(n - 2) \, z_(n - 1) \, z_n^k \) arrow.r.double z_(n - 1) mapsto u \( z_1 \, dots.h.c \, z_(n - 2) \, z_(n - 1) \, xi_n \)$ is uniform convergence

]
#statement("Theorem")[
$K subset.eq K$ is compact, $exists C_(K \, alpha) > 0$ such that #math.equation(block: true, numbering: none, $sup_K \| partial^alpha u \| lt.eq C_(K \, alpha) sup_K \| u \|$)

]
#proof(title: "Proof")[
If $K = D_1 times dots.h.c times D_n$, in general, cover $K$ with a finite number of polydisks

]
#statement("Corollary")[
${ u_k } subset.eq cal(O) \( Omega \)$

+ \(Montel) ${ u_k }$ uniformly bounded on every compact $K subset.eq Omega$, then $exists u in cal(O) \( Omega \)$, $k_j in bb(N)$ such that $u_(k_j) arrow.r.double u$ uniformly on compact subsets

+ If $u_j arrow.r.double u$, then $u in cal(O) \( Omega \)$

]
#proof(title: "Proof")[
+ ${ partial^alpha u_j }$ are equicontinuous(Arzela-Ascoli), ${ partial^alpha u_j }$ is relatively compact w.r.t. uniform convergence. To finish, exhaust $Omega$ by compact subsets, and take a diagonal process to assure relative compactness for all partial derivatives, Cauchy-Riemann conditions is satisfied for the limit

]
#statement("Theorem", title: [Cauchy's estimates])[
If $\| u \( z \) \| lt.eq M$ on $D$, $\| partial^j u \( 0 \) \| lt.eq M j_1 ! dots.h.c j_m ! 1 / r_1^(j_1) dots.h.c 1 / r_m^(j_m)$

]
#statement("Theorem", title: [Hartogs' theorem])[
$f : Omega arrow.r bb(C)^n$, $f$ is holomorphic in every variable separately, then $f in cal(O) \( Omega \)$

]
#statement("Example")[
$f(x, y) = cases(frac(x y, x^2 + y^2), 0)$, this can't be a counterexample in complex variables since $z_1^2 + z_2^2 = 0$ at points other than $\( 0 \, 0 \)$

]
#statement("Theorem", title: [Cauchy-Pompeiu formula])[
$f in C^1 \( overline(U) \)$, $integral_(partial U) f d z = integral_U d \( f d z \) = integral_U macron(partial) f and d z = integral_U frac(partial f, partial macron(z))$

]
#statement("Theorem")[
$f in C_0^oo \( bb(C) \)$, $frac(partial u, partial macron(z)) = f$ always has a solution $u in C^oo \( bb(C) \)$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $u \( z \) = frac(1, 2 pi i) integral_(bb(C)) frac(f \( xi \), xi - z) d xi and d macron(xi)$)

]
#statement("Theorem")[
$f = sum f_j d macron(z)_j$, $f_j in C_0^oo \( bb(C)^n \)$, $macron(partial) f = 0$, then there exists unique $u in C_0^oo \( bb(C)^n \)$ such that $macron(partial) u = f$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $u \( z \) = frac(1, 2 pi i) integral_(bb(C)) frac(1, tau - z_1) f_1 \( tau \, z - 2 \, dots.h.c \, z_n \) d tau and d macron(tau)$) #math.equation(block: true, numbering: none, $macron(partial) f = 0 arrow.l.r.double frac(partial f_j, partial macron(z)_k) = frac(partial f_k, partial macron(z)_j)$) Need to show $frac(partial u, partial macron(z)_k) = f_k$. $k = 1$, Cauchy-Pompeiu implies $frac(partial u, partial macron(z)_1) f_1 \( z_1 \, dots.h.c \, z_n \)$, $k > 1$, $frac(partial u, partial macron(z)_k) = frac(1, 2 pi i) integral_(bb(C)) 1 / tau frac(partial f_k, partial macron(z)_1) \( z_1 - tau \, z_2 \, dots.h.c \, z_n \) d tau and d macron(tau) = frac(1, 2 pi i) integral_(bb(C)) frac(1, tau - z_1) frac(partial f_k, partial macron(z)_1) \( z_1 - tau \, z_2 \, dots.h.c \, z_n \) d tau and d macron(tau)$ Why is $u$ compactly supported

]

#pagebreak()

= Hartogs phenomenon

#statement("Theorem", title: [Hartogs phenomenon])[
$Omega subset.eq bb(C)^n$ is open, $n > 1$, $K subset.eq Omega$ is compact, $f in cal(O) \( Omega \\ K \)$, then there exists $g in cal(O) \( Omega \)$ such that $f equiv g$ on $Omega \\ K$

]
#statement("Remark")[
Holomorphic functions with more than one variable don't have isolated poles. The zero set of a holomorphic function with more than one variable is not contained in a compact set

]
#proof(title: "Proof")[
$phi in C_0^oo \( Omega \)$ such that $phi equiv 1$ on a neighborhood of $K$, $v = macron(partial) \( 1 - phi \) f = - f macron(partial) phi in \( C_0^oo \)_(0 \, 1) \( bb(C)^n \)$, $macron(partial) v = macron(partial) \( - f macron(partial) phi \) = - f macron(partial) macron(partial) phi = 0 arrow.r.double exists_1 u in C_0^oo \( bb(C)^n \)$ such that $macron(partial) g = - f macron(partial) phi - macron(partial) u = 0 arrow.r.double g in cal(O) \( Omega \)$, on $partial Omega$, $1 - phi equiv 1$, $u equiv 0$, then use the identity theorem

]
#statement("Definition")[
$Omega$ is a domain of holomorphy if there exists $f in cal(O) \( Omega \)$ such that $f$ doesn't extend to $Omega'$ where $Omega ⫋ Omega' subset.eq bb(C)^n$

]
#statement("Question")[
Characterize the domains of holomorphy

]
Consider $f \( z \) = sum_(alpha gt.eq 0) a_alpha z^alpha$, $D$ is the domain of convergence satisfies

+ $D$ is #emph[polycircular], i.e. $z in D arrow.r.double \( e^(i theta_1) z_1 \, dots.h.c \, e^(i theta_n) z_n \) in D$

+ $D$ is #emph[log-convex], i.e. if $z^1 \, z^2 in D$, then $\( z^1 \)^beta \( z^2 \)^(1 - beta) in D$, $0 < beta < 1$, here $z^beta = \( z_1^beta \, dots.h.c \, z_n^beta \)$, note that $a^alpha b^(1 - alpha) lt.eq alpha a + \( 1 - alpha \) b$ is Young's inequality

#statement("Definition")[
$D$ is #emph[Reinhardt]#index-entry("Reinhardt") if $D$ is polycircular. $D$ is #emph[log-convex Reinhardt] if $D$ also satisfies

- $D^(*) = log \| D \| = { \( t_1 \, dots.h.c \, t_n \) in bb(R)^n \| \( e^(t_1) \, dots.h.c \, e^(t_n) \) in D }$ is a convex set of $bb(R)^n$ and $D^(*) + \( bb(R)_(-) \)^n subset.eq D^(*)$

If $D$ is Reinhardt, then $hat(D) = inter { tilde(D) upright(" Reinhardt and log convex, ") D subset.eq tilde(D) }$ is the log-convex cover of $D$

]
#statement("Theorem")[
If $0 in D subset.eq bb(C)^m$ is connected Reinhardt, $f in cal(O) \( D \)$, then there exists $g in cal(O) \( hat(D) \)$ such that $g \|_D = f$

]
#proof(title: "Proof")[
$f \( z \) = sum_(alpha gt.eq 0) a_alpha z^alpha$ in $D \( 0 \, delta \)^m$ extends to $D$, use the fact that the domain of absolute convergence of $sum_(alpha gt.eq 0) a_alpha z^alpha$ is a log convex Reinhardt domain containing $D$

]
#statement("Definition")[
Domain $Omega subset.eq bb(C)^n$ is a domain of holomorphy if there are no open sets $Omega_1$, $Omega_2$ such that

- $diameter eq.not Omega_1 subset.eq Omega_2 inter Omega$

  #align(center)[
  #overlapping-domains-diagram()
  ]

- For any $f in cal(O) \( Omega \)$, there exists $g in cal(O) \( Omega_2 \)$ such that $f \|_(Omega_1) = g \|_(Omega_1)$

]
#statement("Remark")[
Local property of $partial Omega$, to rule out anomalies from slit type domain

#align(center)[
#slit-domain-diagram()
]
]
#statement("Definition")[
$K subset.eq Omega$ is compact, its holomorphically convex hull is #math.equation(block: true, numbering: none, $hat(K)_Omega = {z in Omega mid(bar.v) \| f \( z \) \| lt.eq sup_K \| f \| \, forall f in cal(O) \( Omega \)}$)

]
#aside("Note")[
$K subset.eq hat(K)_Omega$

]
#statement("Remark")[
$hat(K)_Omega$ is contained in the convex hull of $K$

]
#proof(title: "Proof")[
Let $L \( bb(C)^n \)$ be the set of complex linear functionals of $bb(C)^n$, $L_(bb(R)) \( bb(C)^n \)$ be the set of real linear funcitonals of $bb(C)^n$, $"Re" L \( bb(C)^n \) = L_(bb(R)) \( bb(C)^n \)$ #math.equation(block: true, numbering: none, $"convex" \( K \) & =^(upright("Hahn-Banach")) { z in Omega \| Lambda \( z \) lt.eq sup_K Lambda \, Lambda in L_(bb(R)) \( bb(C)^n \) }\
 & = { z in Omega \| e^(Lambda \( z \)) lt.eq e^(sup_K Lambda \( z \)) \, Lambda in L_(bb(R)) \( bb(C)^n \) }\
 & = { z in Omega \| e^("Re" beta \( z \)) lt.eq e^(sup_K "Re" beta \( z \)) \, beta in L \( bb(C)^n \) }\
 & = { z in Omega \| \| e^(beta \( z \)) \| lt.eq sup_K \| e^beta \| \, beta in L \( bb(C)^n \) }$)

]
#statement("Remark")[
$K subset.eq Omega$ is compact and convex, then $accent(partial K_Omega, ̂) = K$. Maximal principle: $K subset.eq hat(K_Omega) = accent(partial K_Omega, ̂)$

]
#proof(title: "Proof")[
$accent(partial K_Omega, ̂) subset.eq "convex" \( partial K \) =^(upright("Milman-Kreim")) K$

]
#statement("Lemma")[
Let $D$ be a polydisk centered at $0 in bb(C)^n$, $Delta_Omega^D \( z \) = sup { r > 0 \, s . t . z + r D subset.eq Omega }$ is the \"weighted\" $L^oo$ distance of $z$ to $partial Omega$. $r = inf_(z in K) Delta_Omega^D \( z \) > 0$, $K subset.eq Omega$ is compact. Let $xi in hat(K)_Omega$, if $u in cal(O) \( Omega \)$, then the power series expansion of $u$ at $xi$ #math.equation(block: true, numbering: none, $f \( z \) = sum_alpha frac(1, alpha !) frac(partial^alpha u \( xi \), partial xi^alpha) \( z - xi \)^alpha$) is convergent for any $z in xi + r D$

]#label("Lemma 2.5.3")
#proof(title: "Proof")[
$sup_K u \( z \) lt.eq M$, then $\| frac(partial^alpha u \( z \), partial z^alpha) \| lt.eq frac(alpha ! M, \( r - epsilon.alt \)^(\| alpha \|))$ for any $z in K$, $arrow.r.double \| frac(partial^alpha u \( xi \), partial xi^alpha) \| lt.eq frac(alpha ! M, \( r - epsilon.alt \)^(\| alpha \|))$, then $\| u \( z \) \| = \| sum frac(1, alpha !) frac(partial^alpha u \( xi \), partial xi^alpha) \( z - xi \)^alpha \| lt.eq sum_alpha frac(M, \| r - epsilon.alt \|^alpha) \( z - xi \)^alpha arrow.r.double^(upright("Abel’s criterion"))$ absolutely convergent for $z in xi + \( r - epsilon.alt \) D$, then let $epsilon.alt arrow.br 0$

]
#statement("Definition")[
$Omega subset.eq bb(C)^n$ is holomorphically convex if for any $K subset.eq Omega$ compact, $hat(K)_Omega$ is also compact

]
#statement("Theorem")[
$Omega subset.eq bb(C)^n$ is open, the following are equivalent

+ $Omega$ is a domain of holomorphy

+ $K subset.eq Omega$ compact $arrow.r.double$ $hat(K)_Omega subset.eq Omega$ is compact, i.e. $K subset.eq Omega$ is holomophically compact

+ $exists f in cal(O) \( Omega \)$ such that doesn't extend over any point $in partial Omega$ holomorphically

]
#proof(title: "Proof")[
\(i)$arrow.r.double$\(ii): $r = inf_(z in K) Delta_Omega^D \( z \) > 0 arrow.r.double^(upright("Lemma") #h(0.2em) #ref(label("Lemma 2.5.3"), supplement: none)) hat(K)_Omega + r D subset.eq Omega$

\(iii)$arrow.r.double$\(i): Trivial

\(ii)$arrow.r.double$\(iii): Let $M$ be a dense, countable set in $Omega$. Let $xi \, dots.h.c \, xi_n \, dots.h.c$ be a sequence containing each element of $M$ infinitely many times. Let $K = K^1 subset.eq K^2 subset.eq dots.h.c subset.eq Omega$ is another compact exhaustion of $Omega$, by (ii), we have $hat(K)_Omega^1 subset.eq hat(K)_Omega^2 subset.eq dots.h.c subset.eq Omega$ is another compact exhaustion of $Omega$. $D_xi = xi + Delta_Omega^D \( xi \) D subset.eq Omega$. For any $xi_j$, $exists z_j in D_(xi_j)$ such that $z_j in hat(K)_Omega^j$ because it's compact. $exists f in cal(O) \( Omega \)$ such that
#math.equation(block: true, numbering: none, $
  cases(\| f_j(z_j) \| = 1, sup_(z in K_j) \| f_j(z) \| < 1 - epsilon.alt)
  arrow.r.double^(upright("manipulate power"))
  cases(f_j(z_j) = 1, sup_(z in K_j) \| f_j(z) \| < 1 / 2^j)
$)
$f \( z \) = product_(j = 1)^oo \( 1 - f_j \)^j$. Claim: $f in cal(O) \( Omega \)$. $z in Omega arrow.r.double z + epsilon.alt D subset.eq K_j$ for all $j gt.eq j_0$. $log product_(j gt.eq j_0) \( 1 - f_j \)^j = sum_(j gt.eq j_0) j log \( 1 - f_j \)$, thus $\| log \( 1 - f_j \( z \) \) \| lt.eq C \| f_j \( z \) \|$, then $sum_(j gt.eq j_0) j \| log \( 1 - f_j \) \| lt.eq sum_(j gt.eq j_0) j C \| f_j \| lt.eq C sum_(j gt.eq j_0) j / 2^j < oo$

]
#statement("Exercise")[
$f$ is not identically zero, but $f \( z_j \) = 0$, $frac(partial^alpha f, partial z^alpha) \( z_j \) = 0$, for all $\| alpha \| lt.eq j$. Assume $f$ extends across $partial Omega$, contradiction

]
#statement("Example")[
$Omega subset.eq bb(C)^n$ convex and open $arrow.r.double$ $Omega$ is a domain of holomorphy. Pf: Only need to show $K subset subset Omega arrow.r.double hat(K)_Omega subset subset Omega$. $hat(K)_Omega subset "convex" \( K \) subset.eq Omega arrow.r.double hat(K)_Omega$ is closed and bounded $arrow.r.double hat(K)_Omega$ is compact

Reinhardt domains: $0 in Omega$ is a connected Reinhardt domain, $Omega^(*) = { xi in bb(R)^n \| \( e^(xi_1) \, dots.h.c \, e^(xi_n) \) in Omega }$. $Omega$ is log convex $arrow.l.r.double$ $Omega^(*)$ is convex, and for any $xi in Omega^(*)$, $eta_j lt.eq xi_j arrow.r.double eta in Omega^(*)$

]
#statement("Theorem")[
$Omega$ is a Reinhardt domain, tthen the following are equivalent

+ $Omega$ is a domain of holomorphy

+ $Omega$ is log-convex

]
#proof(title: "Proof")[
\(i)$arrow.r.double$\(ii): $exists f in cal(O) \( Omega \)$ that does not extend through any boundary point $arrow.r.double$ power series expansion of $f$ at $0$ absolutely converges exactly on $D$ $arrow.r.double$ $D$ is log-convex

\(ii)$arrow.r.double$\(i): Take $K subset subset Omega$, $exists xi^j$ such that $K subset.eq union_(j = 1)^k D \( 0 \, xi_1^j \) times dots.h.c times D \( 0 \, xi_n^j \)$, $z in K arrow.r.double \| z_1 \|^(alpha_1) dots.h.c \| z_n \|^(alpha_n) lt.eq sup_(1 lt.eq j lt.eq k) \| xi_1^j \|^(alpha_1) dots.h.c \| xi_n^j \|^(alpha_n)$ which holds for $alpha in bb(Q)_(+)^n$, by density, it also holds for $alpha bb(R)_(+)^n$, thus also holds for $z in hat(K)_Omega$, assume that $z_1 \, dots.h.c \, z_j eq.not 0$, $z_(j + 1) = dots.h.c = z_n = 0$. Take $alpha = \( alpha_1 \, dots.h.c \, alpha_j \, 0 \, dots.h.c \, 0 \)$, $\| z_1 \|^(alpha_1) dots.h.c \| z_j \|^(alpha_j) lt.eq sup_(1 lt.eq l lt.eq k) \( alpha_1 log \| xi_1^l \| + dots.h.c + alpha_j log \| xi_j^l \| \)$. claim (HW): $\( log \| z_1 \| \, dots.h.c \, log \| z_j \| \)$ is in the convex hull of vectors $\( log eta_1 \, dots.h.c \, log eta_j \)$ such that $eta_j lt.eq xi_j^l$ for some $l in { 1 \, dots.h.c \, k }$

]
#statement("Lemma")[
$f in cal(O) \( Omega \)$ such that $\| f \( z \) \| lt.eq Delta_Omega^D \( z \) = sup { r > 0 \| z + r D subset.eq Omega }$, $z in K$, $xi in hat(K)_Omega$, $u in cal(O) \( Omega \)$, then the power series expansion of $u$ near $xi$ absolutely converges in $xi + \| f \( xi \) \| D$

]

#pagebreak()

= Plurisubharmonicity

#statement("Definition")[
$Omega subset.eq bb(C)^n$, $u : Omega arrow.r \[ - oo \, oo \)$ is plurishbharmonic if

+ $u$ is upper semi-continuous on $Omega$, $limsup_(z arrow.r z_0) u \( z \) lt.eq u \( z_0 \)$

+ $w in bb(C)^n$, $z in Omega$, then $tau mapsto u \( z + tau w \)$ is subharmonic, for all $tau in bb(C)$ such that $z + tau w in Omega$

]
#statement("Exercise")[
$f in cal(O) \( Omega \) arrow.r.double log \| f \| in P S H \( Omega \)$

]
#statement("Theorem")[
$u in C^2 \( Omega \)$, then $u in P S H \( Omega \)$ iff $z in Omega$, $D^2 u \( z \)$ is semi-positive definite $arrow.r.double$ Pseudo-convexity

]
#proof(title: "Proof")[
Restrict on one line, $frac(partial^2, partial tau partial macron(tau)) u gt.eq 0$

]
#statement("Theorem")[
$u in P S H \( Omega \)$, $phi in C_0^oo \( bb(C)^n \)$, $phi \( z \) = phi \( \| z \| \)$, $"supp" phi subset.eq overline(B \( 0 \, 1 \))$. $integral_(bb(C)^n) phi d lambda = 1$. $u_epsilon.alt \( z \) = 1 / epsilon.alt^(2 n) integral_(bb(C)) u \( z - eta \) phi \( eta / epsilon.alt \) d lambda \( eta \)$, $z in Omega_epsilon.alt = { z in Omega \| d \( z \, Omega^c \) > epsilon.alt }$, $u_epsilon.alt in P S H \( Omega_epsilon.alt \) inter C^oo \( Omega_epsilon.alt \)$, $forall z in Omega$, $u_epsilon.alt \( z \) arrow.br u \( z \)$ as $epsilon.alt arrow.br 0$

]
#statement("Proposition")[
$u_j in P S H$ decreasing, then $v \( x \) = lim_j u_j \( x \) in P S H$

]
#statement("Theorem")[
$Omega subset.eq bb(C)^n$, $Omega' subset.eq bb(C)^m$, $f : Omega arrow.r Omega'$ is holomorphic, $u in P S H \( Omega' \)$, then $u in P S H \( Omega \)$\(subharmonicity define on complex manifold)

]
#proof(title: "Proof")[
Check $u in P S H \( Omega' \) inter C^2 \( Omega' \)$, $frac(partial^2, partial z_j partial macron(z)_k) \( u compose f \( z \) \) = frac(partial^2 u, partial xi_p partial macron(xi)_q) frac(partial f_p, partial z_j) overline(frac(partial f_q, partial z_k)) = "Hess"_(bb(C)) \( u \) \( partial f \, macron(partial) f \) gt.eq 0$. $K subset.eq Omega$ is compact, $hat(K)_Omega^p = { z in Omega \| u \( z \) lt.eq sup_(y in K) u \( y \) \, forall u in P S H \( Omega \) } arrow.r.double hat(K)_Omega^p subset.eq hat(K)_Omega$ (PSH-hull). $Omega$ is pseudo-convex if $forall K subset.eq Omega$ compact, $hat(K)_Omega^p subset.eq Omega$ is also compact. $Omega$ convex $arrow.r.double$ $Omega$ pseudoconvex $arrow.r.double$ $Omega$ is holomorphically convex

]
#statement("Theorem")[
$Omega subset.eq bb(C)^n$ is open, the following are equivalent

+ $z mapsto - log delta \( z \, Omega^c \) in P S H \( Omega \)$

+ $exists u in P S H \( Omega \) inter C \( Omega \)$ such that $Omega_c^u = { z in Omega \| u \( z \) lt.eq c } subset.eq Omega$ compact

+ $K subset.eq Omega$ compact $arrow.r.double$ $hat(K)_Omega^p subset.eq Omega$ compact

]
#statement("Remark")[
If $u$ satisfies (ii), then ti is called a PSH exhaustion of $Omega$

]
#proof(title: "Proof")[
\(ii)$arrow.r.double$\(iii): $K subset.eq Omega$ compact, $sup_(y in K) u \( y \) = M < oo$, $hat(K)_Omega^p subset.eq { z in Omega \| u \( z \) lt.eq M } = Omega_M^u subset.eq^(upright("compact")) Omega$

\(i)$arrow.r.double$\(ii): $u \( z \) = - log delta \( z \, Omega^c \)$, check that $z mapsto delta \( z \, Omega^c \)$ is continuous, take $F \( tau \)$ to be a polynomial, such that $- log \( z + tau w \, Omega^c \) lt.eq "Re" F \( tau \)$ on $partial Omega$, then there exists polynomial $f$ such that $f \( z + tau w \) = F \( tau \)$, then $delta \( z + tau w \, Omega^c \) gt.eq \| e^(- f \( z + tau w \)) \|$ on $partial D$, by Theorem 2.5.4, Inequality holds on $accent(partial D, ̂) supset.eq Omega$

]
#statement("Theorem")[
$Omega subset.eq bb(C)^n$ is pseudoconvex, $K subset.eq Omega$ is compact, $z in hat(H_Omega^p)^c$ ($arrow.r.double hat(K_Omega^p) subset.eq Omega$ compact), then there exists $u in C^oo \( Omega \)$ such that

+ $u in P S H \( Omega \)$ and $i partial macron(partial) u > delta sum_(j = 1)^n d z_j and d macron(z)_j$

+ $Omega_c = { u lt.eq c } subset.eq Omega$ is compact for any $c in bb(R)$

+ $\| u \| < 0$ on $K$ and $u \( z \) > 0$

]
#statement("Remark")[
You can find $v in P S H \( Omega \) inter C \( Omega \)$ such that (b) and (c) holds for $v$ (to make $v$ smooth)

]
#proof(title: "Proof")[
$Omega_c { v < c }$, $v_j \( z \) = integral_(Omega_(j + 1)) v \( xi \) 1 / epsilon.alt^(2 n) phi \( frac(z - xi, epsilon.alt) \) d lambda \( xi \) + epsilon.alt \| z \|^2$, $epsilon.alt$ small enough such that $v_j in P S H \( Omega_j \)$. Pick smooth function $chi : bb(R) arrow.r bb(R)$ non-decreasing and convex, $chi \( t \) = 0$, $forall t lt.eq 0$, $chi \( t \) > 0$, $forall t > 0$, $chi' \( t \) > 0$, $forall t > 0$. Recall: $phi.alt in P S H arrow.r.double chi compose phi.alt in P S H$ (Section 1.6). $chi \( v_j \( z \) - j + 1 \) = 0$, $forall z in Omega_(j - 2)$, $u_k \( z \) = v_0 \( z \) + a_1 chi \( v_1 \( z \) \) + a_2 chi \( v_2 \( z \) - 1 \) + dots.h.c + a_k chi \( v_k \( z \) - j + 1 \)$, here $v_0 \( z \)$ is PSH in $Omega_(- 1)$, $a_1 chi \( v_1 \( z \) \)$ is PSH on $Omega_0$ provided $a_1$ is big enough, $dots.h.c$, thus $u_k arrow.r_(C^oo)^() u in C^oo \( Omega \) inter P S H \( Omega \)$

]
#statement("Example")[
$Omega_1 \, Omega_2$ pseudoconvex $arrow.r.double$ $Omega_1 inter Omega_2$ pseudoconvex

]
#proof(title: "Proof")[
$u_1 \, u_2$ are PSH exhaustions for $Omega_1 \, Omega_2$, $v = max \( u_1 \|_(Omega_1 inter Omega_2) \, u_2 \|_(Omega_1 inter Omega_2) \) in P S H \( Omega_1 inter Omega_2 \)$ is an exhaustion of $Omega_1 inter Omega_2$

]
#statement("Theorem")[
$Omega subset.eq bb(C)^n$ is open bounded, pseudoconvex. $forall z in macron(Omega)$, $exists B in.rev z$ open ball such that $Omega inter B$ is pseudoconvex (HW: Show that balls are pseudoconvex)

]
#proof(title: "Proof")[
$arrow.r.double$ is trivial. $arrow.l.double$: $partial Omega$ is compact, $exists tilde(B)_j subset subset B_j$ such that $delta \( y \, \( B_j inter Omega \)^c \) = delta \( y \, Omega^c \)$ for all $y in tilde(B)_j$, $B_j inter Omega$ pseudoconvex $arrow.r.double$ $- log delta \( z \, B_j^c \)$ is PSH, thus $- log \( z \, Omega^c \)$ is PSH on $tilde(B)_j$, finite cover $tilde(B)_1 \, dots.h.c \, tilde(B)_k$, $exists F subset.eq Omega$ closed such that $- log \( z \, Omega^c \) in P S H \( Omega \\ F \)$, $exists M > - log delta \( z \, Omega^c \)$ on $F$, $max \( - log delta \( z \, Omega^c \) \, M \) in P S H \( Omega \)$

]
#statement("Definition")[
A #emph[densely defined operator]#index-entry("Densely defined operator") on Hilbert spaces $H_1$ is $T : "Dom" T lt.eq H_1 arrow.r H_2$ linear, $"Dom" T$ dense in $H_1$, graph of $T$ is closed

]
#statement("Theorem")[
$H_1 arrow.r^T H_2 arrow.r^S H_3$, the following hold

- $H_2 = \( ker S inter ker T^(*) \) xor overline("im" T) xor overline("im" S^(*))$

- $ker S = \( ker S inter ker T^(*) \) xor overline("im" T)$

- If $parallel T^(*) x parallel_1^2 + parallel S x parallel_3^2 gt.eq C parallel x parallel_2^2$, $forall x in "Dom" S inter "Dom" T^(*) lt.eq H_2$. then $"im" T = ker S$, moreover, $forall v in ker S$, $exists u in T$, such that $T u = v$ with $parallel u parallel_1^2 lt.eq 1 / C parallel v parallel_2^2$

]

#pagebreak()

= Homeworks

== Homework 1

#statement("Problem")[
Let $\( X \, d \)$ be a metric space

+ Let $f_j : X arrow.r \[ - oo \, oo \)$ be a decreasing sequence of upper semi-continuous functions. Show that $f_j := lim f_j$ is also upper semi-continuous

+ Let $f : X arrow.r \[ - oo \, oo \)$ be an upper semi-continuous function such that $f \( x \) lt.eq M in bb(R)$ for all $x in X$. Show that there exist a decreasing sequence of continuous functions such that $f_j arrow.br f$ pointwise everywhere on $X$. \[Hint: Show that the functions $f_j \( x \) := sup_(y in X) \( f \( y \) - j d \( y \, x \) \)$ satisfy the requirements\]

]
#proof(title: "Solution")[
+ The infinimum of a family of upper semicontinuous functions is again upper semicontinuous

+ Consider $f_n \( x \) = sup_(y in X) (f \( y \) - n d \( y \, x \))$ which surely is monotone decreasing, for any fixed $x$, it is obvious $f \( x \) lt.eq f_n \( x \)$, suppose $lim_(n arrow.r oo) f_n \( x \) > f \( x \)$, then $exists y_n \, f \( y_n \) - n d \( y_n \, x \) - f \( x \) > eta$ for some $eta > 0$, hence $d \( y_n \, x \) < frac(f \( y_n \) - f \( x \) - eta, n) lt.eq frac(M - f \( x \) - eta, n)$, thus $lim_(n arrow.r oo) y_n = x$, since $f$ is semicontinuous, $exists delta > 0$, such that$f \( y \) < f \( x \) + eta \, forall y in B \( x \, delta \)$, thus $exists N$, such that $f \( y_n \) < f \( x \) + eta \, forall n > N$, but then $eta > f \( y_n \) - f \( x \) gt.eq f \( y_n \) - n d \( y_n \, x \) - f \( x \) > eta$ which is a contradiction. Therefore, $lim_(n arrow.r oo) f_n \( x \) = f \( x \)$. Next we will prove that $f_n$ is indeed continuous, since $f_n \( x \)$ could be seen as the supremum of a family of continuous functions in $x$ over the family ${ f \( y \) - n d \( y \, x \) }_(y in X)$, it is lower semicontinuous. To show that $f_n$ is also upper semicontinuous, we only need to show that, $forall x in { f_n < a } \, exists delta > 0$, such that $B \( x \, delta \) in { f_n < a }$. we have $f \( z \) - n d \( z \, y \) lt.eq f \( z \) - n d \( x \, z \) + n d \( y \, x \) lt.eq f_n \( x \) + n d \( y \, x \) < a arrow.r.double f_n \( y \) < a$, as long as $delta$ is small enough

]
#statement("Problem")[
Let $Omega subset bb(R)^n$ and $f in C^2 \( Omega \)$ a real valued. If $x in Omega$ show that #math.equation(block: true, numbering: none, $lim_(r arrow.r 0) frac(integral_(bb(S)^(n - 1)) f \( x + r xi \) d xi - f \( x \), r^2 mu \( bb(S)^(n - 1) \)) = 1 / n Delta f \( x \) := 1 / n sum_(j = 1)^n frac(partial^2, partial^2 x_i) f \( x \) \,$) where $d xi$ is the surface measure of the unit sphere $bb(S)^(n - 1) subset bb(R)^n$, and $mu \( bb(S)^(n - 1) \)$ is the surface area of the unit sphere. \[Hint: Use Taylor's formula and some linear algebra wisdom. Also, it was pointed out to me that the constant $1 / n$ may need to adjusted in front of $Delta f \( x \)$ on the right hand side. I leave it up to you to find the correct constant, which your precise calculations should naturally yield\]

]
#proof(title: "Solution")[
#math.equation(block: true, numbering: none, $integral_(bb(S)^(n - 1)) f \( x + r xi \) upright(d) xi - mu \( bb(S)^(n - 1) \) f \( x \) & = integral_(bb(S)^(n - 1)) (f \( x + r xi \) - f \( x \))\
 & = integral_(bb(S)^(n - 1)) (r xi^T D f \( x \) + r^2 / 2 xi^T D^2 f \( eta \) xi)\
 & = integral_(bb(S)^(n - 1)) r^2 / 2 xi^T D^2 f \( eta \) xi$) Where $eta = x + theta r xi \, 0 < theta < 1$ depends on $r xi$. Then we have

#math.equation(block: true, numbering: none, $lim_(r arrow.r 0) frac(integral_(bb(S)^(n - 1)) f \( x + r xi \) upright(d) xi - mu \( bb(S)^(n - 1) \) f \( x \), r^2 mu \( bb(S)^(n - 1) \)) & = frac(1, 2 mu \( bb(S)^(n - 1) \)) lim_(r arrow.r 0) integral_(bb(S)^(n - 1)) xi^T D^2 f \( eta \) xi\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(S)^(n - 1)) xi^T D^2 f \( x \) xi\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(S)^(n - 1)) xi^T P^T mat(delim: "(", frac(partial^2 f, partial x_1^2) \( x \), , ; #none, dots.down, ; #none, , frac(partial^2 f, partial x_n^2) \( x \)) P xi\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(S)^(n - 1)) zeta^T mat(delim: "(", frac(partial^2 f, partial x_1^2) \( x \), , ; #none, dots.down, ; #none, , frac(partial^2 f, partial x_n^2) \( x \)) zeta\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(S)^(n - 1)) frac(partial^2 f, partial x_1^2) \( x \) zeta_1^2 + dots.h.c + frac(partial^2 f, partial x_n^2) \( x \) zeta_n^2\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(S)^(n - 1)) V dot.op zeta\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(B)^n) upright(d i v) V\
 & = frac(1, 2 mu \( bb(S)^(n - 1) \)) integral_(bb(B)^n) Delta f \( x \)\
 & = frac(1, 2 n) Delta f \( x \)$) Where $P in O \( n \)$, $zeta := P xi$, $V = (frac(partial^2 f, partial x_1^2) \( x \) zeta_1 \, dots.h.c \, frac(partial^2 f, partial x_n^2) \( x \) zeta_n)^T$

]

#pagebreak()

== Homework 2

#statement("Problem", title: [Unique analytic continuation])[
Let $Omega subset bb(C)^n$ open and connected, and $f \, g in A \( Omega \)$. If $f = g$ on an open subset of $Omega$ show that $f = g$ everywhere on $Omega$

]
#statement("Problem")[
Show that the function $u in C_0^k \( bb(C)^n \)$ constructed in Theorem 2.3.1 is unique

]

#pagebreak()

== Homework 3

#statement("Problem")[
Let $Omega subset bb(C)^n$ be open and let $P$ be a polydisk, whose closure is contained in $Omega$. Show that $accent(partial_0 P, ̂)_Omega = overline(P)$, where $partial_0 P$ is the distinguished boundary of $P$

]
#statement("Problem")[
Argue precisely why the function $f$ constructed in the proof of Theorem 2.5.5 can not be identically zero!

]
#statement("Problem")[
$bb(C)^n$ can be viewed as a $2 n$-dimensional real vector space and an $n$-dimensional complex vector space. Show that any $bb(R)$-linear functional on $bb(C)^n$ is the real part of a $bb(C)$-linear functional on $bb(C)^n$

]

#pagebreak()

== Homework 4

#statement("Problem")[
Let $lambda := \( lambda_1 \, dots.h \, lambda_j \)$, $z := \( z_1 \, dots.h \, z_j \)$ and $xi := \( xi_1 \, dots.h \, xi_j \)$ be as in the proof of Corollary 2.5.8. Show that #math.equation(block: true, numbering: none, $sum_(i = 1)^j lambda_i log \| z_i \| lt.eq sup_(xi in k) sum_(i = 1)^j lambda_j log \| xi_i \| \, med forall lambda in bb(R)_(+)^n med med upright(" with ") med lambda_1 + dots.h + lambda_j = 1$) is equivalent with $\( log \| z_1 \| \, dots.h \, log \| z_j \| \)$ being in the convex hull of the set of all points $\( eta_1 \, dots.h \, eta_j \)$ such that $eta_i lt.eq log \| xi_i \|$ for $1 lt.eq i lt.eq j$. \[Hint: One direction is easy. For show that being in the convex hull implies the inequality use the fact that a closed convex set is always the intersection of half spaces\]

]
#statement("Problem")[
Let $delta$ as defined by Hörmander on page 37. Show that $z arrow.r delta \( z \, Omega^c \)$ is a continuous on $bb(C)^n$, where $Omega$ is an open subset of $bb(C)^n$

]

#pagebreak()

== Homework 5

#statement("Problem")[
In Theorem 1.1 of Chapter VIII.1 (Demailly's textbook): argue carefully that $T^(* *) = T$ and $K e r med T^perp = overline(I m med T^(*))$

]

#pagebreak()

== Homework 6

#statement("Problem")[
Given a Hermitian metric $h := sum_(j \, k) h_(j \, macron(k)) d z_j and overline(d z_k)$ on a complex manifold $Omega$, show that it is possible to define a Hermitian metric on the vector bundle of $\( p \, macron(q) \)$-forms on $Omega$

]

#pagebreak()
#heading(numbering: none)[References]

#emph[An Introduction to Complex Analysis in Several Variables] - Lars Hörmander

#emph[Complex Analytic and Differential Geometry] - Jean-Pierre Demailly

#pagebreak()
#heading(numbering: none)[Index]
#index-list()
