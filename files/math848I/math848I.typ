#set document(title: "MATH848I - Exterior differential systems", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(size: 10pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => {
  counter("statement").update(0)
  counter(math.equation).update(0)
  it
}
#let statement(kind, title: none, tag: none, body) = {
  counter("statement").step()
  let item = figure(
    context block(above: 0.8em, below: 0.8em)[
      #strong[#kind #counter(heading).get().first().#counter("statement").get().first()#if title != none [ (#title)].] #body
    ],
    kind: "statement",
    supplement: kind,
    numbering: "1",
    caption: none,
  )
  if tag != none { [#item#label(tag)] } else { item }
}
#show figure.where(kind: "statement"): it => it.body
#show ref: it => context {
  let targets = query(it.target)
  if targets.len() > 0 {
    let target = targets.first()
    if target.func() == figure and target.kind == "statement" {
      link(target.location())[
        #counter(heading).at(target.location()).first().#counter("statement").at(target.location()).first()
      ]
    } else {
      it
    }
  } else {
    it
  }
}
#let proof(title: "Proof", body) = block(above: 0.6em, below: 0.6em)[
  #emph[#title.] #body #h(1fr) $square$
]
#let aside(kind, title: none, body) = block[
  #strong[#kind#if title != none [ (#title)].] #body
]
#let numbered-equation(body) = math.equation(
  block: true,
  numbering: n => context str(counter(heading).get().first()) + "." + str(n),
  body,
)
#let index-entry(term) = metadata(term)
#let index-list() = context {
  let entries = query(metadata).filter(entry => type(entry.value) == str)
  let terms = entries.map(entry => entry.value).dedup().sorted()
  columns(2, gutter: 2em)[
    #for term in terms {
      let matches = entries.filter(entry => entry.value == term)
      let pages = matches.map(entry => counter(page).at(entry.location()).first()).dedup()
      par[
        #term #h(1fr)
        #for (position, page-number) in pages.enumerate() {
          if position > 0 { [, ] }
          link(matches.find(entry => counter(page).at(entry.location()).first() == page-number).location(), str(page-number))
        }
      ]
    }
  ]
}

#align(center)[
  #v(1cm)
  #text(size: 23pt, weight: "bold")[MATH848I\ Exterior differential systems]
  #v(1.5cm)
  #image("Pictures/Elie_Cartan.jpg", width: 50%)
  #v(1.5cm)
  Taught by Karin Melnick\
  Notes taken by Haoran Li\
  2020 Spring
  #v(1.5cm)
  Department of Mathematics\
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()



= Introduction - 1/28/2020

#strong[Webpage:] www.math.umd.edu/~kmelnick/eds20.html

#strong[Book recommendation:]

#strong[\1.] T.A. Ivey and J.M. Landsberg: Cartan for Beginners: Differential Geometry via Moving Frames and Exterior Differential Systems (2nd ed.), AMS Graduate Studies in Mathematics 175, Providence, RI (2016)

#strong[\2.] R. Bryant, P. Griffiths, D. Grossman: Exterior Differential Systems and Euler-Lagrange Partial Differential Equations, Chicago Lectures in Mathematics, Chicago (2003)

#strong[\3.] R. Bryant, S.-S. Chern, R.B. Gardiner, H. Goldschmidt, P. Griffiths: Exterior Differential Systems, Springer (1990)

#strong[Note:] Einstein summation convention is regularly used

#statement("Definition")[
We say a PDE is #strong[overdetermined]#index-entry("Overdetermined") if there are more equations than unknowns

]
#statement("Example")[
Suppose $alpha$ is a $1$ form on $U subset.eq bb(R)^n$

Can we find $f$ on $U$ such that $d f = alpha$

In corrdinaties, $alpha = a_i d x^i$, $frac(partial f, partial x^i) = a^i$

In general, there is no solution, a necessary condition is $d alpha = d^2 f = 0$, i.e. $frac(partial a_i, partial x^j) = frac(partial a_j, partial x^i)$

]
#statement("Lemma", title: [Poincaré lemma])[
If $U subset.eq bb(R)^n$ is contractible, $d alpha = 0$ is also a sufficient condition, $f$ is determined up to constants $c_0 = f \( x_0 \) \, x_0 in U$

]
#statement("Example")[
Suppose $D subset.eq bb(R)^2$ is the disk, $g \, A : D arrow.r 2 times 2$ symmetric matrices with $g \( x \, y \)$ positive definite

Can we find $sigma : D arrow.r bb(R)^3$ such that $g$ is the induced metric on $D$, and $A$ is the second fundamental form, i.e. $g = d sigma dot.op d sigma$, $A = - d n dot.op d sigma$

In coordinates, $sigma = \( sigma^1 \, sigma^2 \, sigma^3 \)$, $g \( x \, y \) = mat(delim: "(", g_11 \( x \, y \), g_12 \( x \, y \); g_21 \( x \, y \), g_22 \( x \, y \))$, $A \( x \, y \) = mat(delim: "(", A_11 \( x \, y \), A_12 \( x \, y \); A_21 \( x \, y \), A_22 \( x \, y \))$

Write $frac(partial sigma^i, partial x) = sigma_1^i$, $frac(partial sigma^i, partial y) = sigma_2^i$, $n = frac(sigma_1 times sigma_2, parallel sigma_1 times sigma_2 parallel)$, $g_11 = \( sigma_1^i \)^2$, $g_12 = sigma_1^i sigma_2^i = g_21$, $g_22 = \( sigma_2^i \)^2$, $A_11 = n^i sigma_11^i$, $A_12 = n^i sigma_12^i = A_21$, $A_22 = n^i sigma_22^i$, there are $6$ equations in total

There exists a solution iff satisfying Gauss-Codazzi equations: #math.equation(block: true, numbering: none, $frac(partial A_11, partial y) - frac(partial A_12, partial x) = A_11 Gamma_12^1 + A_12 \( Gamma_12^2 - Gamma_11^1 \) - A_22 Gamma_11^2$) #math.equation(block: true, numbering: none, $frac(partial A_12, partial y) - frac(partial A_22, partial x) = A_11 Gamma_22^1 + A_12 \( Gamma_22^2 - Gamma_12^1 \) - A_22 Gamma_12^2$)

]
#statement("Example")[
Given $alpha = \( alpha^1 \( x \, y \, u \) \, alpha^2 \( x \, y \, u \) \)$, $\( x \, y \) in U subset.eq bb(R)^2$

Can we find $u : U arrow.r bb(R)$ such that #numbered-equation($frac(partial u, partial x) = alpha^1 \( x \, y \, u \)\
frac(partial u, partial y) = alpha^2 \( x \, y \, u \)$)#label("eq:1") Introduce variables $p \, q$ and $J^1 \( bb(R)^2 \, bb(R) \) = bb(R)^2 times bb(R) times bb(R)^2$\(1-Jet), define $theta = d u - p d x - q d y$, $Omega = d x and d y$

Suppose $Sigma subset.eq J^1 \( bb(R)^2 \, bb(R) \)$ is a surface such that $Omega \|_(T Sigma)$ never vanishes and $theta \|_(T Sigma)$ vanishes identically, then locally $Sigma$ is a graph($Omega \|_(T Sigma) eq.not 0$ is for nondegeneracy) $u = u \( x \, y \)$, $p = p \( x \, y \)$, $q = q \( x \, y \)$ with $d u = p d x + q d y$ on $T Sigma$, but $d u = u_x d x + u_y d y$ on $T Sigma$, thus $p = u_x \, q = u_y$ on $Sigma$

Now consider $M subset.eq J^1 \( bb(R)^2 \, bb(R) \)$ be the solution to $p = alpha^1 \( x \, y \, u \) \, q = alpha^2 \( x \, y \, u \)$ which is a $3$ manifold. Solution of #ref(label("eq:1"), supplement: none) correspondes to surfaces $Sigma subset.eq M$ on which $Omega eq.not 0 \, theta = 0$

A necessary condition for existence of such a surface $Sigma$ is $d theta = - d p and d x - d q and d y$ in $J^1 \( bb(R)^2 \, bb(R) \)$, suppose $j : M arrow.r.hook J^1 \( bb(R)^2 \, bb(R) \)$ is the inclusion, then #math.equation(block: true, numbering: none, $j^(*) d theta & = - \( alpha_x^1 d x + alpha_y^1 d y + alpha_u^1 d u \) and d x - \( alpha_x^2 d x + alpha_y^2 d y + alpha_u^2 d u \) and d y\
 & = \( alpha_y^1 - alpha_x^2 \) d x and d y - alpha_u^1 d u and d x - alpha_u^2 d u and d y$) On $Sigma$

Suppose $i : Sigma arrow.r.hook J^1 \( bb(R)^2 \, bb(R) \)$ is the inclusion, then #math.equation(block: true, numbering: none, $i^(*) d theta & = \( alpha_y^1 - alpha_x^2 \) i^(*) d Omega - alpha_u^1 \( alpha^1 d x + alpha^2 d y \) and d x - alpha_u^2 \( alpha^1 d x + alpha^2 d y \) and d y\
 & = \( alpha_y^1 - alpha_x^2 + alpha_u^1 alpha^2 - alpha_u^2 alpha^1 \) i^(*) d Omega$) Since $Omega eq.not 0$, $alpha_y^1 - alpha_x^2 + alpha_u^1 alpha^2 - alpha_u^2 alpha^1 = 0$ on $Sigma$

Consider the following possible cases:

#strong[Case I:] $alpha_y^1 - alpha_x^2 + alpha_u^1 alpha^2 - alpha_u^2 alpha^1 = 0$ on $M$

#strong[Case II:] $alpha_y^1 - alpha_x^2 + alpha_u^1 alpha^2 - alpha_u^2 alpha^1 = 0$ on $M$

For case I, Apply Theorem #ref(label("Frobenius theorem"), supplement: none), we know it is a sufficient condition since #math.equation(block: true, numbering: none, $d theta & = \( alpha_y^1 - alpha_x^2 + alpha_u^1 alpha^2 - alpha_u^2 alpha^1 \) d x and d y + alpha_u^1 theta and d x - alpha_u^2 theta and d y\
 & = \( alpha_u^2 d y - alpha_u^1 d x \) and theta$)

]

#pagebreak()

= Frobenius theorem - 1/30/2020

#statement("Definition")[
A $p$ dimension #strong[foliation]#index-entry("Foliation") of an $n$ dimensional manifold $M$ is decomposition of $M$ into disjoint connected submanifolds $M = union.sq.big_(alpha in A) N_alpha$ such that for each point $p in M$, there is a neighborhood of $p$ and a local chart $\( x^1 \, dots.h.c \, x^n \)$ such that each $N_alpha inter M$ is given by $x^(p + 1) = upright(c o n s t) \, dots.h.c \, x^n = upright(c o n s t)$

#align(center)[
#box(image("Pictures/Foliation.png"))

]
]
#statement("Definition")[
An #strong[integral submanifold]#index-entry("Integral submanifold") $N subset.eq M$ is a submanifold such that locally $T N = upright(S p a n) \( X_1 \, dots.h.c \, X_n \)$ where $X_i$ is a local basis, $1$-dimensional integral submanifolds are just #strong[integral curves]#index-entry("Integral curve")

]
#statement("Definition")[
Suppose $M$ is a smooth manifold of dimension $m$, an $n$-dimensional #strong[distribution]#index-entry("Distribution(Differential geometry)") over $M$ is #math.equation(block: true, numbering: none, $Delta = union.sq.big_p Delta_p subset.eq T M \, Delta_p lt.eq T_p M \, dim Delta_p = n$) Which is locally spanned by a local basis $X_1 \, dots.h.c \, X_n$

]
#statement("Remark")[
We can also define distributions on vector bundles

]
#statement("Definition")[
$Delta$ is #strong[involutive]#index-entry("Involutive distribution") if $\[ Delta \, Delta \] subset.eq Delta$, $Delta$ is #strong[integrable]#index-entry("Integrable distribution") if for any point $p in M$, there exists a integral submanifold $N in.rev p$ such that $T_p N = Delta_p$

]
#statement(tag: "Involutive distribution is integrable", "Lemma")[
If distribution $Delta$ is integrable, then it is involutive

]
#proof(title: "Proof")[
Since $Delta$ is integrable, for any $p in M$, there is a integral submanifold $N in.rev p$ such that $i_(*) : T_p N arrow.r.hook T_p M$ is injective with $i_(*) \( T_p N \) = Delta_p$. Suppose $X \, Y in Delta_p$, by the naturality of Lie bracket, $\[ X \, Y \] = i_(*) \[ i_(*)^(- 1) X \, i_(*)^(- 1) Y \] in Delta_p$

]
#statement("Example")[
Consider $D = chevron.l V \, W chevron.r$ is a two dimensional distribution over $bb(R)^3$, where $V = frac(partial, partial x) + y frac(partial, partial z)$, $W = frac(partial, partial y)$, but $\[ X \, Y \] = - frac(partial, partial z) in.not D$, thus $D$ is not involutive, by Lemma #ref(label("Involutive distribution is integrable"), supplement: none), $D$ is not integrable

]
#statement("Definition")[
An $n$-dimensional distribution $D$ over a $m$-dimensional smooth manifold $M$ is #strong[completely integrable]#index-entry("Completely integrable distribution") if for each point $p in M$, there is a local coordinate chart $\( U \, phi.alt \)$, such that $phi.alt : U arrow.r bb(R)^n times bb(R)^(m - n)$ with $phi.alt \( D \) subset.eq bb(R)^n$

#align(center)[
#box(image("Pictures/Completely_integrable.png"))

]
]
#statement(tag: "Lemma for Frobenius theorem", "Lemma")[
Suppose $M$ is an $m$ dimensional manifold, $D$ is an $n$-dimensional distribution around $p in M$, $\( U \, x \)$ with $x \( p \) = 0$ is a local coordinate chart, then $D$ has a local basis $X_1 \, dots.h.c \, X_n$ around $p$ such that such that #math.equation(block: true, numbering: none, $X_i = frac(partial, partial x^i) + sum_(j = n + 1)^m a_i^j frac(partial, partial x^j)$) Or in matrix form #math.equation(block: true, numbering: none, $vec(X_1, dots.v, X_n) = mat(delim: "(", 1, dots.h.c, 0, a_1^(n + 1), dots.h.c, a_1^m; dots.v, dots.down, dots.v, dots.v, dots.down, dots.v; 0, dots.h.c, 1, a_n^(n + 1), dots.h.c, a_n^m; #none) vec(frac(partial, partial x^1), dots.v, frac(partial, partial x^m))$)

]
#proof(title: "Proof")[
First pick a local basis $Y_1 \, dots.h.c \, Y_n$ around $p$, then we have $Y_i = sum_(j = 1)^m b_i^j frac(partial, partial x^j)$, or in matrix form #math.equation(block: true, numbering: none, $vec(Y_1, dots.v, Y_n) = mat(delim: "(", b_1^1, dots.h.c, b_1^m; dots.v, dots.down, dots.v; b_n^1, dots.h.c, b_n^m; #none) vec(frac(partial, partial x^1), dots.v, frac(partial, partial x^m))$) Since $Y_i$'s are linearly independent, $B$ is of full rank, reorder if needed, we can assume #math.equation(block: true, numbering: none, $tilde(B) = mat(delim: "(", b_1^1, dots.h.c, b_1^n; dots.v, dots.down, dots.v; b_n^1, dots.h.c, b_n^n; #none)$) Is invertible, we can thus define $mat(delim: "(", I, A) = tilde(B)^(- 1) B$, $X = tilde(B)^(- 1) Y$

]
#statement(tag: "Involutive distribution ensure the existence of commuting basis", "Corollary")[
Suppose $M$ is an $m$ dimensional manifold, $D$ is an $n$-dimensional involutive distribution around $p in M$, then $D$ has a local basis $X_1 \, dots.h.c \, X_n$ around $p$ such that such that $\[ X_i \, X_j \] = 0$. In other words, we can choose a local commuting basis

]
#proof(title: "Proof")[
Suppose $\( U \, x \)$ with $x \( p \) = 0$ is a local coordinate chart, by Lemma #ref(label("Lemma for Frobenius theorem"), supplement: none), $D$ has a local basis $X_1 \, dots.h.c \, X_n$ around $p$ such that such that #math.equation(block: true, numbering: none, $X_i = frac(partial, partial x^i) + sum_(j = n + 1)^m a_i^j frac(partial, partial x^j)$) Then #math.equation(block: true, numbering: none, $\[ X_i \, X_j \] & = [frac(partial, partial x^i) + sum_(k = n + 1)^m a_i^k frac(partial, partial x^k) \, frac(partial, partial x^j) + sum_(l = n + 1)^m a_j^l frac(partial, partial x^l)]\
 & = sum_(k = n + 1)^m [a_i^k frac(partial, partial x^k) \, frac(partial, partial x^j)] + sum_(l = n + 1)^m [frac(partial, partial x^i) \, a_j^l frac(partial, partial x^l)] + sum_(k \, l = n + 1)^m [a_i^k frac(partial, partial x^k) \, a_j^l frac(partial, partial x^l)]\
 & = sum_(k = n + 1)^m frac(partial a_i^k, partial x^j) frac(partial, partial x^k) + sum_(l = n + 1)^m frac(partial a_j^l, partial x^i) frac(partial, partial x^l) + sum_(k \, l = n + 1)^m (a_i^k frac(partial a_j^l, partial x^k) frac(partial, partial x^l) - a_j^l frac(partial a_i^k, partial x^l) frac(partial, partial x^k))$) Is in the span of ${frac(partial, partial x^(n + 1)) \, dots.h.c \, frac(partial, partial x^m)}$, on the other hand, since $D$ is involutive, $\[ X_i \, X_j \]$ is also in the span of ${ X_1 \, dots.h.c \, X_n }$, thus $\[ X_i \, X_j \] = 0$

]
#statement(tag: "Frobenius theorem", "Theorem", title: [Frobenius theorem])[
#index-entry("Frobenius theorem") If distribution $D$ is involutive, then it is completely integrable, alternatively, we could say that maximal integrable submanifolds form a foliation of $M$

]
#statement("Remark")[
Frobenius theorem can be thought of as a generalization of the existence theorem in ODE

]
#proof(title: "Proof")[
It suffices to show that for any $p in M$, there is a local coordinate chart $x : U arrow.r bb(R)^m$ such that locally $D$ is spanned by ${frac(partial, partial x^1) \, dots.h.c \, frac(partial, partial x^n)}$, then integrable submanifolds are just ${ x^1 \, dots.h.c \, x^(n - 1) upright(" are constants") }$, we prove this by induction on $n$

#strong[Base case:] If $n = 1$, $D$ is just a nonvanishing vector field $X_m$, for each $p in M$, let $X_1 \, dots.h.c \, X_m$ be a local basis for $T M$, define $gamma_i : \( - epsilon \, epsilon \)^i arrow.r M$ by $gamma_i \( x^1 \, dots.h.c \, x^i \) = phi.alt_(X_i)^(x^i) compose dots.h.c compose phi.alt_(X_1)^(x^1) \( p \)$, where $phi.alt_X^t$ is the flow along $X$. Then $gamma_m \( 0 \, dots.h.c \, x^i \, dots.h.c \, 0 \) = phi.alt_(X_i)^(x^i) \( p \)$, $\( gamma_m \)_(*) frac(partial, partial x^i)\|_(\( 0 \, dots.h.c \, 0 \)) = X_i \( p \)$ which are linearly independent, thus $gamma_m$ is invertible around origin, giving $x = gamma_m^(- 1)$ with $\( gamma_m \)_(*) frac(partial, partial x^m)\|_(\( x^1 \, dots.h.c \, x^m \)) = X_m \( gamma_m \( x^1 \, dots.h.c \, x^m \) \)$, i.e. $frac(partial, partial x^m) = X_m$

#strong[Induction step:] By Corollary #ref(label("Involutive distribution ensure the existence of commuting basis"), supplement: none), there exists local basis $X_1 \, dots.h.c \, X_n$ for $D$ such that $\[ X_i \, X_j \] = 0$, by induction hypothesis, there is a local chart $y$ such that $upright(S p a n) (X_1 \, dots.h.c \, X_(n - 1)) = upright(S p a n) (frac(partial, partial y^1) \, dots.h.c \, frac(partial, partial y^(n - 1)))$, write $X_n = sum_(i = 1)^m a^i frac(partial, partial y^i)$, then #math.equation(block: true, numbering: none, $[frac(partial, partial y^i) \, X_n] = sum_(j = 1)^m [frac(partial, partial y^i) \, a^j frac(partial, partial y^j)] = sum_(j = 1)^m frac(partial a^j, partial y^i) frac(partial, partial y^j)$) Since $D$ is involutive, $[frac(partial, partial y^i) \, X_n] in D$, which implies $frac(partial a^j, partial y^i) = 0 \, forall n + 1 lt.eq j lt.eq m$, let $Y := X_n - sum_(i = 1)^(n - 1) a^i frac(partial, partial y^i) = sum_(i = n)^m a^i frac(partial, partial y^i)$, then $upright(S p a n) (X_1 \, dots.h.c \, X_(n - 1) \, X_n) = upright(S p a n) (frac(partial, partial y^1) \, dots.h.c \, frac(partial, partial y^(n - 1)) \, Y)$

Now we restrict on the integral submanifold $N = { y^1 \, dots.h.c \, y^(n - 1) upright(" are constants") }$, $\( y^n \, dots.h.c \, y^m \)$ is a local coordinate chart on $N$, thus $Y in T N$ is a nonvanishing distribution, this is again the base case, there exists coordinates $\( x^n \, dots.h.c \, x^m \)$ such that $frac(partial, partial x^n) = Y$, let $x^i = y^i \, i < n$, then $x = \( x_1 \, dots.h.c \, x_m \)$ becomes a local coordinate chart such that $upright(S p a n) (X_1 \, dots.h.c \, X_(n - 1) \, X_n) = upright(S p a n) (frac(partial, partial y^1) \, dots.h.c \, frac(partial, partial y^(n - 1)) \, Y) = upright(S p a n) (frac(partial, partial x^1) \, dots.h.c \, frac(partial, partial x^(n - 1)) \, frac(partial, partial x^n))$

]
#statement("Definition")[
A #strong[differential ring]#index-entry("Differential ring") is a ring $R$ with one or more derivations, a #strong[derivation]#index-entry("Derivation") $d$ is a ring endomorphism satisfying Leibniz rule: $d \( r s \) = \( d r \) s + r \( d s \)$

A #strong[differential ideal]#index-entry("Differential ideal") is an ideal $I$ closed under $d$, i.e. $d I subset.eq I$

]
#statement("Example")[
Given differential forms $v^1 \, dots.h.c \, v^p in Omega^(*) \( M \)$, we can define the algebraic ideal #math.equation(block: true, numbering: none, $chevron.l v^1 \, dots.h.c \, v^p chevron.r_(upright(a l g)) = {sum_(i = 1)^p v^i and alpha_i \, alpha_i in Omega^(*) \( M \)}$) Which is closed under wedge product $and$, and the differential ideal #math.equation(block: true, numbering: none, $chevron.l v^1 \, dots.h.c \, v^p chevron.r_(upright(d i f f)) = {sum_(i = 1)^p \( v^i and alpha_i + d v^i and beta_i \) \, alpha_i \, beta_i in Omega^(*) \( M \)}$) Which is closed under wedge product $and$ and differential $d$

]
#statement(tag: "Lemma' for Frobenius theorem", "Lemma")[
Suppose $V$ is an $m$ dimensional vector space, $v^1 \, dots.h.c \, v^n in V^(*)$ are linearly independent iff $v^1 and dots.h.c and v^n eq.not 0$

Suppose $v^1 \, dots.h.c \, v^m$ is a basis of $V^(*)$, then $W := inter.big_(i = 1)^(m - n) ker v^i$ is an $n$ dimensional subspace, if $2$-form $omega in and.big^2 V$ vanishes on $W times W$, then $omega = sum_(i = 1)^(m - n) alpha_j^i and v^i$

]
#proof(title: "Proof")[
Remember $v^1 and dots.h.c and v^n$ is a linear functional on $overbrace(V times dots.h.c times V, n upright(" times"))$ given by #math.equation(block: true, numbering: none, $v^1 and dots.h.c and v^n \( x_1 \, dots.h.c \, x_n \) = sum_sigma \( - 1 \)^(s g n sigma) v^1 \( x_(sigma 1) \) dots.h.c v^n \( x_(sigma n) \) = det \( v^i \( x_j \) \)$) Assume $omega = sum_(i < j) c_(i j) v^i and v^j$, denote $nu = sum_(m - n < i < j) c_(i j) v^i and v^j$

]
#statement("Theorem")[
Given a smooth manifold $M$ of dimesion $m$, and $theta^1 \, dots.h.c \, theta^(n - m) in Omega^1 \( M \)$ such that

#strong[\(1)] $theta^1 \, dots.h.c \, theta^(n - m) in Omega^1 \( M \)$ are pointwise linearly independent

#strong[\(2)] $d theta^j = sum alpha_i^j and theta^i$ for some $alpha_i^j in Omega^1 \( M \)$

Then $forall p in M$, there exists a connected $n$ dimensional submanifold $N$ with $p in N$, such that $theta^i \|_(T N) equiv 0 \, forall 1 lt.eq i lt.eq n - m$

According to Lemma #ref(label("Lemma' for Frobenius theorem"), supplement: none), (1) $arrow.l.r.double$ $ker theta^j subset.eq T M$ is an $n$-dimension distribution $cal(D)$\(subbundle of $T M$), locally $cal(D) = s p a n { x_1 \, dots.h.c \, x_n } \, x_i in frak(X) \( M \)$. Since $d theta \( X \, Y \) = X \( theta \( Y \) \) - Y \( theta \( X \) \) - theta \( \[ X \, Y \] \)$, (2) $arrow.l.r.double$ $cal(D)$ is involutive, i.e. $\[ x_i \, x_j \] in cal(D)$, denote $I_(upright(a l g)) = chevron.l theta^1 \, dots.h.c \, theta^(m - n) chevron.r_(upright(a l g))$, $I_(upright(d i f f)) = chevron.l theta^1 \, dots.h.c \, theta^(n - m) chevron.r_(upright(d i f f))$, then (2) $arrow.l.r.double$ $I_(upright(a l g)) = I_(upright(d i f f))$

The result is actually stronger, $forall p in M$, there exists coordinates $\( y^1 \, dots.h.c \, y^m \)$ on a neighborhood of $p$ such that $chevron.l theta^1 \, dots.h.c \, theta^(n - m) chevron.r = chevron.l d y^1 \, dots.h.c \, d y^(m - n) chevron.r$, then the integral submanifolds are ${ y^1 \, dots.h.c \, y^(n - m) upright(" are constants") }$, giving a foliation of $M$

]
#proof(title: "Proof")[

]

#pagebreak()

= Maurer-Cartan formula - 2/4/2020

#statement("Example")[
$G L \( n \, bb(C) \) < G L \( 2 n \, bb(R) \)$ is a real Lie group, $G L \( n \, bb(C) \) = { g in G L \( 2 n \, bb(R) \) \| g J = J g$, where $J = mat(delim: "(", 0, - 1; 1, 0; #none, , 0, - 1; #none, , 1, 0; #none, , , , dots.down)$

]
#statement("Example")[
Given an inner product matrix $B$, $O \( B \) = { g^T B g = B }$ is a real Lie group, $O \( 2 \) = { g^T g = I }$ with $B = I$, $O \( 2 \) = S O \( 2 \) times.r ⟨mat(delim: "(", 0, 1; 1, 0)⟩$

]
#statement("Example")[
$upright(I s o m^(+)) \( bb(E)^n \) = { \( r \, t \) }$, $\( r \, t \) x = r x + t$, $\( I \, 0 \)$ is the identity, $\( r \, t \) \( r' \, t' \) = \( r r' \, r t' + t \)$, $\( r \, t \)^(- 1) = \( r^(- 1) \, - r t \)$ is a real Lie group, $upright(I s o m^(+)) \( bb(E)^n \) = {mat(delim: "(", 1, 0; t, r)} subset.eq G L \( n + 1 \, bb(R) \)$

]
#statement("Definition")[
Let $G$ be a Lie group, left multiplication by $g$, denoted by $L_g$ is an isomorphism, $L_g$ acts on $frak(X) \( G \)$ by pushforward, $\( L_(g *) X \)_h = \( d L_g \)_(g^(- 1) h) \( X_(g^(- 1) h) \)$, a vector field $X in frak(X) \( G \)$ is left invariant if $L_(g *) X = X$, let $frak(X)^G \( G \)$ denote all the left invariant vector fields, $frak(X)^G \( G \) tilde.equiv T_e G$ is the Lie algebra, $T_e \( G \) arrow.r frak(X)^G \( G \)$, $v mapsto X$ with $X_g = \( d L_g \)_e \( v \)$ is a Lie algebra isomorphism

]
#statement("Example")[
For $O \( B \)$, a curve $gamma \( s \)$ through $I$ should satisfy $gamma \( s \)^T B gamma \( s \) = B arrow.r.double gamma' \( 0 \)^T B + B gamma' \( 0 \) = 0$, $frak(o) \( B \) = { X in M_n \( bb(R) \) \| X^T = - X }$, $frak(o) \( 2 \) = {mat(delim: "(", 0, - theta; theta, 0)}$

]
#statement("Example")[
For $G = upright(I s o m^(+)) \( bb(E)^2 \)$, $frak(g) = {mat(delim: "(", 0, 0, 0; t_1, 0, - theta; t_2, theta, 0)}$

]
#statement("Definition")[
$Omega^n \( M \, V \) = Gamma \( T^n M times.o V \)$ are $upright(bold(V))$#strong[\-valued differential forms]#index-entry("V-valued differential forms")

If $V = frak(g)$ is a Lie algebra, we can also define the \"wedge\" product, for any $w \, v in Omega^1 \( M \, frak(g) \)$, $\[ w \, v \] \( X \, Y \) = \[ w \( X \) \, v \( Y \) \] - \[ w \( Y \) \, v \( X \) \]$, this is kind of like wedge product, with product replaced by $\[ \, \]$

]
#statement("Definition")[
Define #strong[Maurer-Cartan form]#index-entry("Maurer-Cartan form") $omega^G in Omega^1 \( G \, frak(g) \)$ to be $omega_g^G : T_e G arrow.r frak(g)$ such that $omega_g^G \( v \) = X$ where $X in frak(X)^G \( G \)$ with $X_g = v in T_g G$

]
#statement("Proposition")[
$omega^G$ is left invariant, i.e. $L_g^(*) omega^G = omega^G$

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $\( L_g^(*) omega^G \)_h \( v \) & = omega_(g h)^G \( \( d L_g \)_h \( v \) \)\
 & = omega_(g h)^G \( \( d L_g \)_h \( X_h \) \)\
 & = omega_(g h)^G \( \( L_(g *) X \)_(g h) \)\
 & = omega_(g h)^G \( X_(g h) \)\
 & = X$) Here $X in frak(g)$ such that $X_h = v$, i.e. $omega_h^G \( v \) = X$

]
#statement("Proposition")[
$d omega^G + 1 / 2 \[ omega^G \, omega^G \] = 0$

]
#proof(title: "Proof")[
First suppose $X \, Y in frak(g)$, then $omega_g^G \( \[ X \, Y \] \) = Z in frak(g)$ with $Z_g = \[ X \, Y \]_g$, by definition, $Z = \[ X \, Y \]$

In general, let $X = f^i Z_i$, $Y = g^j Z_j$ with $Z_i in frak(g)$ being a basis, then #math.equation(block: true, numbering: none, $omega^G \( \[ X \, Y \] \) & = omega^G \( f^i Z_i \( g^j \) Z_j - g^j Z_j \( f^i \) Z_i + f^i g^j \[ Z_i \, Z_j \] \)\
 & = \( f^i Z_i \( g^j \) - g^i Z_i \( f^j \) \) omega^G \( Z_j \) + f^i g^j omega^G \( \[ Z_i \, Z_j \] \)\
 & = \( f^i Z_i \( g^j \) - g^i Z_i \( f^j \) \) Z_j + f^i g^j \[ Z_i \, Z_j \]\
 & = X \( omega^G \( Y \) \) - Y \( omega^G \( X \) \) + \[ omega^G \( X \) \, omega^G \( Y \) \]$)

]
#statement("Theorem")[
Given a smooth manifold $M$ and $omega in Omega^1 \( M \, frak(g) \)$, if $d omega + 1 / 2 \[ omega \, omega \] = 0$, then for any $p in M$, there exists a neighborhood $U$ and $f : U arrow.r G$ such that $f^(*) omega^G \|_U = omega \|_U$, and $f$ is unique up to a composition with $L_g$ for some $g$

]

#pagebreak()

= Fundamental theorem of Maurer-Cartan form - 2/6/2020

#strong[Reference:] Section 1.6 of I+L

#statement("Lemma")[
If $G$ is a matrix group, $g = \( g_j^i \) : U arrow.r G$ is a local parametrization, then $omega^G = g^(- 1) d g = \( g_j^i \)^(- 1) d g_j^k$\(matrix multiplication)

]
#statement("Example")[
Suppose $G = upright(I s o m^(+)) \( bb(R)^2 \) tilde.equiv bb(R)^2 times.r S O \( 2 \)$, $g = mat(delim: "(", 1, 0, 0; t_1, cos theta, - sin theta; t_2, sin theta, cos theta; #none)$, $g^(- 1) = mat(delim: "(", 1, 0, 0; *, cos theta, sin theta; *, - sin theta, cos theta; #none)$, $d g = mat(delim: "(", 0, 0, 0; d t_1, - sin theta d theta, - cos theta d theta; d t_2, cos theta d theta, - sin theta d theta; #none)$, $g^(- 1) d g = mat(delim: "(", 0, 0, 0; *, 0, - d theta; *, d theta, 0; #none) in bb(R)^2 times.r frak(s o) \( 2 \) = frak(g)$

]
#statement("Theorem")[
Let $M$ be a smooth manifold of dimension $m$, $G$ be a Lie group, $omega in Omega^1 \( M \, frak(g) \)$, then

#strong[\(1)] For any $p in M$, there exists a neighborhood $U$ of $p$ such that $omega = f^(*) omega^G$ $arrow.l.r.double$ $d omega + 1 / 2 \[ omega \, omega \] = 0$

#strong[\(2)] Suppose $f \, h : U arrow.r G$ satisfying $f^(*) omega^G = h^(*) omega^G$, then there exists $g in G$, such that $h = L_g compose f$

#strong[\(3)] If $M$ is simply connected, then $f$ extends to $M$

]
#proof(title: "Proof")[
Given $omega in Omega^1 \( M \, frak(g) \)$, $d omega + 1 / 2 \[ omega \, omega \] = 0$

#strong[\(1)] Define $theta in Omega^1 \( M times G \, frak(g) \)$ by $theta = pi_M^(*) omega - pi_G^(*) omega^G$, $theta = theta^i X_i$, ${ X_i }$ being a basis of $frak(g)$, $ker theta lt.eq T \( M times G \)$, given $u in T_p M$, $p in M$, given $g in G$, $exists_1 v in T_g G$ such that $omega_p \( u \) = omega_g^G \( v \)$ $arrow.r.double$ $forall \( p \, g \) in M times G$, $T_p M arrow.r \( ker theta \)_(\( p \, g \))$ is an isomorphism with inverse $\( d pi_M \)_(\( p \, g \))$ #math.equation(block: true, numbering: none, $d theta & = d \( pi_M^(*) omega \) - d \( pi_G^(*) omega^G \)\
 & = pi_M^(*) d omega - pi_G^(*) d omega^G\
 & = 1 / 2 \( pi_M^(*) \[ omega \, omega \] - pi_G^(*) \[ omega^G \, omega^G \] \)\
 & = 1 / 2 \( \[ pi_M^(*) omega \, pi_M^(*) omega \] - \[ pi_G^(*) omega^G \, pi_G^(*) omega^G \] \)\
 & = 1 / 2 \( \[ pi_M^(*) omega \, pi_M^(*) omega \] - \[ pi_G^(*) omega^G \, pi_G^(*) omega^G \] - \[ pi_G^(*) omega^G \, pi_M^(*) omega \] + \[ pi_G^(*) omega^G \, pi_M^(*) omega \] \)\
 & = 1 / 2 \( \[ theta \, pi_M^(*) omega \] + \[ pi_G^(*) omega^G \, theta \] \)\
 & = 1 / 2 \[ theta \, pi_M^(*) omega - pi_G^(*) omega^G \]\
 & = 1 / 2 \[ theta \, theta \]$) $1 / 2 \[ theta^i X_i \, theta^j X_j \] \( xi \, eta \) = 1 / 2 \( theta^i \( xi \) theta^j \( eta \) \[ X_i \, X_j \] - theta^i \( eta \) theta^j \( xi \) \[ X_i \, X_j \] \) = 1 / 2 \[ theta^i \, theta^j \] c_(i j)^k X_k$ where $c_(i j)^k$ are structure constants of the Lie algebra $frak(g)$, i.e. $\[ X_i \, X_j \] = c_(i j)^k X_k$

Apply Frobenius Theorem#ref(label("Frobenius theorem"), supplement: none), $forall \( p \, q \)$, there exists a submanifol of dimension $dim M$ everywhere tangent to $ker theta$, $\( d pi_M \)_(\( p \, g \)) \) : T_(\( p \, g \)) = \( ker theta \)_(\( p \, g \)) arrow.r T_p M$ is surjective, by inverse function theorem, there exists a neighborhood $U$ of $p$ and $f : U arrow.r M times G$, $f \( U \) subset.eq Gamma$, $f \|_U = pi_M^(- 1)$ $arrow.r.double$ $Gamma$ is the graph of $f$ and $f^(*) \( omega^G \) = omega$

#strong[\(2)] Let $f \( p \) = g$, $h \( p \) = g'$, $exists_1 k in G$ such that $g' = k g$, thus $\( L_k compose f \) \( p \) = k g = g'$, thus $\( L_k compose f \)^(*) omega^G = f^(*) L_k^(*) omega^G = f^(*) omega^G = omega$, thus the graph of $L_k compose f$ coincides the graph of $h$ on a neighborhood of $p$, because both are integral submanifolds of $theta$ at $\( p \, g \)$

#strong[\(3)] $pi_M \|_Gamma : Gamma arrow.r M$ for $Gamma$ a maximal integral submanifold for $ker theta$ is a covering map

]
#statement("Example")[
$M = I subset bb(R)$, $G = upright(I s o m^(+)) \( bb(R)^2 \)$, $omega^G = mat(delim: "(", 0, 0, 0; *, 0, - d theta; *, d theta, 0; #none)$, consider $alpha \, beta : I arrow.r bb(R)^2$ are paths parametrized by arc length, $tilde(alpha) : I arrow.r G$, $tilde(alpha) \( t \) = mat(delim: "(", 1, 0, 0; alpha^1 \( t \), alpha^1' \( t \), - alpha^2' \( t \); alpha^2 \( t \), alpha^2' \( t \), alpha^1' \( t \); #none)$, $tilde(alpha)' \( t \) = mat(delim: "(", 0, 0, 0; alpha^1' \( t \), alpha^1'' \( t \), - alpha^2' \( t \); alpha^2' \( t \), alpha^2'' \( t \), alpha^1'' \( t \); #none)$, $tilde(alpha)^(*) d tau = vec(alpha^1' d t, alpha^2' d t)$, $r_0^(- 1) compose tilde(alpha) = mat(delim: "(", alpha^1', alpha^2'; - alpha^2', alpha^1')$

Thus $\( r_0^(- 1) compose tilde(alpha) \) \( tilde(alpha)^(*) d tau \) = vec(\( alpha^1' \)^2 + \( alpha^2' \)^2, 0) d t = vec(d t, 0)$

$theta = arctan (alpha^2' / alpha^1') arrow.r.double d theta = frac(1, 1 + (alpha^2' / alpha^1')^2) frac(alpha^2'' alpha^1' - alpha^1'' alpha^2', \( alpha^1' \)^2) d t = \( alpha^2'' alpha^1' - alpha^1'' alpha^2' \) d t$ Note that $kappa \( t \) = - alpha^1'' \( t \) alpha^2' \( t \) + alpha^2'' \( t \) alpha^1' \( t \) = vec(alpha^1'', alpha^2'') dot.op vec(- alpha^2', alpha^1')$ is the curvature, $tilde(alpha)^(*) omega^G \( t \) = mat(delim: "(", 0, 0, 0; d t, 0, - kappa \( t \) d t; 0, kappa \( t \) d t, 0; #none)$

Therefore, $tilde(alpha)^(*) omega^G = tilde(beta)^(*) omega^G arrow.l.r.double tilde(alpha) = L_g compose tilde(beta) arrow.l.r.double alpha = g beta arrow.l.r.double kappa_alpha = kappa_beta$

]

#pagebreak()

= Two identities about Maurer-Cartan form - 2/11/2020

#statement("Remark", title: [Uniqueness of $omega^G$])[
$omega^G$ is the unique left invariant $frak(g)$ valued $1$-form on $G$ given an isomorphism $omega_e^G : T_e G arrow.r frak(g)$, $omega_g^G = L_(g^(- 1))^(*) omega_e^G$

]
#statement(tag: "Idetity 1 for Maurer-Cartan form", "Proposition")[
Due to the left invariance of $omega^G$ and the fact that $R_g \, L_h$ commutes, we have $L_(h *) R_(g *) X = R_(g *) L_(h *) X = R_(g *) X$, for any $X in frak(X)^G \( G \)$, thus pushforward of conjugation $C_(g^(- 1)) = L_h R_g$ also preserves $frak(X)^G \( G \)$, giving an automorphism of $frak(g)$

Similarly, it is easy to see #math.equation(block: true, numbering: none, $R_g^(*) omega^G = L_(g^(- 1))^(*) R_g^(*) omega^G = A d \( g \)^(- 1) omega^G$)

]
#statement(tag: "Idetity 2 for Maurer-Cartan form", "Proposition")[
Given $alpha : U arrow.r G$, $alpha^(*) omega^G in Omega^1 \( U \, frak(g) \)$, $p : U arrow.r G$, let $beta \( x \) = alpha \( x \) p \( x \)$, then $d beta = R_(p *) compose d alpha + L_(alpha *) compose d p$, $beta^(*) omega^G = A d \( p \)^(- 1) alpha^(*) omega^G + p^(*) omega^G$

]

#pagebreak()

= Schwarzian - 2/13/2020

#statement("Example")[
Consider a map $alpha : U subset.eq bb(C) arrow.r bb(C) P^1$

Let $G = {z mapsto frac(a z + b, c z + d) mid(bar.v) mat(delim: "(", a, b; c, d) in S L \( 2 \, bb(C) \)} \/ plus.minus upright(i d)$ be the group of Möbius transformations

The projection is defined by $G arrow.r bb(C) P^1$, $g mapsto g \[ 1 : 0 \] = \[ g_11 : g_21 \]$, it is clear that this map is onto, thus $G$ acts on $bb(C) P^1$ transitively, $bb(C) P^1$ is a homogeneous space, the stabilizer of $\[ 1 : 0 \]$ is ${mat(delim: "(", a, b^(- 1); 0, a^(- 1)) mid(bar.v) a in bb(C)^times \, b in bb(C)} = : P$, for any other $y = g \[ 1 : 0 \] in bb(C) P^1$, the stabilizer would be $g P g^(- 1)$

Pick a lift $hat(alpha) : U arrow.r G$, $z mapsto mat(delim: "(", alpha \( z \), - 1; 1, 0)$, $hat(alpha)^(- 1) d hat(alpha) = mat(delim: "(", 0, 1; - 1, alpha) mat(delim: "(", alpha' d z, 0; 0, 0) = mat(delim: "(", 0, 0; - alpha' d z, 0)$, let $tilde(alpha) \( z \) = hat(alpha) \( z \) p \( z \)$ for some $p : U arrow.r P < G$, $p \( z \) = mat(delim: "(", a \( z \), b \( z \); 0, a \( z \)^(- 1))$, apply Proposition #ref(label("Idetity 2 for Maurer-Cartan form"), supplement: none), we have #math.equation(block: true, numbering: none, $tilde(alpha)^(- 1) d tilde(alpha) & = p^(- 1) \( hat(alpha)^(- 1) d hat(alpha) \) p + p^(- 1) d p\
 & = mat(delim: "(", a^(- 1), - b; 0, a) mat(delim: "(", 0, 0; - alpha' d z, 0) mat(delim: "(", a, b; 0, a^(- 1)) + mat(delim: "(", a^(- 1), - b; 0, a) mat(delim: "(", a', b'; 0, - a' / a^2) d z\
 & = mat(delim: "(", a b alpha' + a^(- 1) a', b^2 alpha' + a^(- 1) b' + b a' a^(- 2); - a^2 alpha', - a b alpha' - a^(- 1) a') d z$) Set $a = \( alpha' \)^(- 1 / 2)$, $b = 1 / 2 alpha'' \( alpha' \)^(- 3 / 2)$, $tilde(alpha)^(- 1) d tilde(alpha)$ becomes $mat(delim: "(", 0, 1 / 2 S_alpha \( z \); 1, 0) d z$, here $S_alpha \( z \) = alpha''' / alpha' - 3 / 2 (alpha'' / alpha')^2$ is called the #strong[Schwarzian]#index-entry("Schwarzian")

]
#statement("Remark")[
${z mapsto frac(a z + b, c z + d) mid(bar.v) mat(delim: "(", a, b; c, d) in S L \( 2 \, bb(R) \)} = upright(I s o m^(+)) \( bb(H)^2 \)$, where $bb(H)^2$ is the half space model for hyperbolic space, $bb(H)^2 = { upright(I m) z > 0 }$ with metric $frac(d x^2 + d y^2, y^2)$

]
#statement("Example")[
Let $beta : U subset.eq bb(C) P^1 arrow.r bb(C) P^1$ be the identity map, $hat(beta) \( z \) = mat(delim: "(", z, - 1; 1, 0)$ is a lift of $beta \( z \)$, $hat(beta)^(- 1) d hat(beta) = mat(delim: "(", 0, 0; - 1, 0)$, then we know $alpha = g \|_U$ for some $g in S L \( 2 \, bb(C) \)$ $arrow.l.r.double$ $alpha = g compose beta$ for some $g in S L \( 2 \, bb(C) \)$ $arrow.l.r.double$ $hat(beta)^(- 1) d hat(beta) = tilde(alpha)^(- 1) d tilde(alpha)$ on $U$ $arrow.l.r.double$ $S_alpha equiv 0$ on $U$

]
#statement("Lemma")[
If $u \, v$ are both solutions to the differential equation $X'' + q X = 0$, then $S_(u \/ v) = 2 q$

]
#proof(title: "Proof")[

]
#statement("Lemma")[
$H o m \( V \, W \) arrow.r V^(*) times.o W$, $A = \( a_(i j) \) mapsto sum_(i \, j) a_(j i) v_i^(*) times.o w_j$ is an isomorphism

]
#statement("Definition")[
A #strong[tableau]#index-entry("Tableau") is a linear subspace $A lt.eq H o m \( V \, W \) tilde.equiv V^(*) times.o W$ where $V \, W$ are linear vector spaces of dimension $n$ and $s$, consider a smooth map $f : V arrow.r W$, $D_x f : V tilde.equiv T_x V arrow.r T_(f \( x \)) W tilde.equiv W in H o m \( V \, W \)$, $D_x f in A \, forall x in V$ if it satisfies a linear, constant coefficient PDE

Let ${ v^1 \, dots.h.c \, v^n }$ be a basis of $V^(*)$, ${ w_1 \, dots.h.c \, w_s }$ be a basis of $W$ #math.equation(block: true, numbering: none, $A = upright(S p a n) {A_i^(t a) times.o w_a mid(bar.v) t = 1 \, dots.h.c \, T} = inter.big_r ker {B_a^(r i) v_i times.o w^a mid(bar.v) r = 1 \, dots.h.c \, R}$) where $R = dim V^(*) times.o W - dim T$, ${ w^1 \, dots.h.c \, w^s }$, ${ v_1 \, dots.h.c \, v_n }$ are the dual basis, then #math.equation(block: true, numbering: none, $D_x f in A \, forall x in V arrow.l.r.double B_a^(r i) d f^a \( v^i \) = 0 \, forall r arrow.l.r.double B_a^(r i) frac(partial f^a, partial x^i) = 0 \, forall r$) $f \( x \) = f_0 + A_0 x$, $f_0 in W$, $A_0 in A$ is always a solution. Also #math.equation(block: true, numbering: none, $D_x f in A \, forall x arrow.r.double D_x^2 f \( y \, dot.op \) in A \, forall x \, y in V arrow.r.double dots.h.c arrow.r.double D_x^k f \( y_1 \, dots.h.c \, y_(k - 1) \, dot.op \) in A \, forall x \, y_1 \, dots.h.c \, y_(k - 1)$) We define the $l$-th #strong[prolongation]#index-entry("Prolongation") of $A$ as #math.equation(block: true, numbering: none, $A^(\( l \)) = S^(l + 1) V^(*) times.o W inter V^(* times.o l) times.o A = S^(l + 1) V^(*) times.o W inter V^(*) times.o A^(\( l - 1 \))$)

]
#statement("Example")[
Consider Cauchy-Riemann equations, $\( u \( x \, y \) \, v \( x \, y \) \) : bb(R)^2 arrow.r bb(R)^2$, $frac(partial u, partial x) = frac(partial v, partial y)$, $frac(partial u, partial y) = - frac(partial v, partial x)$, $A subset.eq E n d \( bb(R)^2 \) = {mat(delim: "(", A^1, - A^2; A^2, A^1) mid(bar.v) A^1 \, A^2 in bb(R)} tilde.equiv frak(c o) \( 2 \) tilde.equiv bb(R) times.o frak(s o) \( 2 \) tilde.equiv frak(g l)_1 \( bb(C) \) tilde.equiv bb(C)$

]
#statement("Example")[
$A = frak(s o) \( n \) subset.eq E n d \( bb(R)^2 \) = { X^T = - X } = {mat(delim: "(", 0, , - A_i^j; #none, dots.down, ; A_j^i, , 0) mid(bar.v) i > j}$, corresponds to $frac(partial f^j, partial x^i) = - frac(partial f^i, partial x^j)$

Let $alpha in S^2 bb(R)^(n *) times.o bb(R)^n inter bb(R)^(n *) times.o frak(s o) \( n \)$, $X in frak(s o) \( n \) arrow.r.double chevron.l X u \, v chevron.r = - chevron.l u \, X v chevron.r$

$chevron.l alpha \( u \, v \) \, w chevron.r = - chevron.l alpha \( u \, w \) \, v chevron.r = chevron.l alpha \( v \, w \) \, u chevron.r = - chevron.l alpha \( v \, u \) \, w chevron.r = - chevron.l alpha \( u \, v \) \, w chevron.r arrow.r.double alpha = 0$. Thus the only solutions to $frac(partial u^j, partial x^i) = - frac(partial u^i, partial x^j)$ are $u = u_0 + X$

]
#statement("Proposition")[
$A^(\( l \)) = { \( p^1 \( x \) \, dots.h.c \, p^s \( x \) \) }$ where $p^i \( x \)$ are $l + 1$-homogeneous symmetric polynomials such that $D_x p^i in A \, forall x in V$

]
#proof(title: "Proof")[

]

#pagebreak()
#heading(numbering: none)[Index]
#index-list()
