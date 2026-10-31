#set document(title: "MATH808Q - Abelian varieties", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(size: 10pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#let statement(kind, title: none, body) = figure(
  context {
    let number = "1." + str(counter(figure.where(kind: "statement")).get().first())
    block(above: 0.8em, below: 0.8em)[
      #set align(left)
      #strong[#kind #number#if title != none [ (#title)].] #body
    ]
  },
  kind: "statement",
  supplement: kind,
  numbering: n => "1." + str(n),
  caption: none,
)
#show figure.where(kind: "statement"): it => it.body
#let proof(body) = block(above: 0.6em, below: 0.6em)[
  #emph[Proof.] #body #h(1fr) $square$
]
#let Aut = math.op("Aut")
#let Lie = math.op("Lie")
#let Hom = math.op("Hom")
#let End = math.op("End")
#let GL = math.op("GL")
#let Spec = math.op("Spec")
#let Cl = math.op("Cl")
#let Res = math.op("Res")
#let SL = math.op("SL")
#let SO = math.op("SO")
#let rank = math.op("rank")
#let ord = math.op("ord")
#let im = math.op("im")
#let varphi = sym.phi.alt
#let isogenous = sym.tilde

#align(center)[
  #v(1cm)
  #text(size: 23pt, weight: "bold")[MATH808Q - Abelian varieties]
  #v(4cm)
  Taught by #raw("Ramachadran")\
  Notes taken by #raw("Haoran Li")\
  2021 Fall
  #v(2cm)
  Department of Mathematics\
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()

= Introduction to Abelian varieties

Motivating example: $V tilde.equiv bb(C)^g$, $Lambda lt.eq V$ is a lattice(discrete cocompact subgroup), $V times.o_(bb(Z)) bb(R) = V$, $G = V/Lambda$ is a compact complex abelian Lie group, a complex torus since $V/Lambda tilde.equiv (S^1)^(2g)$

#statement("Theorem")[
  Any compact connected(connected is necessary, otherwise finite groups would all be abelian) complex Lie group $X$ is abelian
]

#proof[
  $n = dim_(bb(C)) X$. Let $e in U subset.eq bb(C)^n$ be an open subset of $X$, $phi_g: X arrow X, x arrow.r.bar g x g^(-1)$ induces $phi: X arrow Aut(X)$, for a fixed $g in X$,
]

#proof[
  Consider $phi: X times X arrow X, (x,y) arrow.r.bar x y x^(-1) y^(-1)$, open neighborhood $V_g$ of $g$ and open neighborhood $W_g$ of $e$ such that $phi(V_g,W_g) subset.eq U$ and $phi(g,e) = e$. Since $X$ is compact, $X = union_(i=1)^r V_(g_i)$, let $W = inter W_(g_i)$, then $phi(X,W) subset.eq U$, is homomorphic, hence $phi(X,W) = e$
]

Every such group would be like $X = V/Lambda$, $V = Lie X = tilde(X)$, and $Lambda = pi_1(X,e) = H_1(X,bb(Z))$. This is a complex tori, consider $X arrow^n X$, let $X[n] tilde.equiv (bb(Z)/n bb(Z))^(2g)$ denote the kernel which consists of $n$-torsion elements, this is an isogeny of degree $n^(2g)$

How to classify all such $X$, $phi X = V/Lambda arrow X' = V'/Lambda' arrow.l.r.double tilde(phi): V arrow V'$ and $tilde(phi)(V) subset.eq V'$, need to consider something like $GL_(g)(bb(C))/GL_(g)(bb(C)) inter GL_(2g)(bb(Z))$

Tate module $T_p A tilde.equiv (bb(Z)_p)^(2g)$

#statement("Definition")[
  $F$ is a perfect field with $F = overline(F)$, an abelian variety $A$ is a group variety that is proper(irreducible, reduced, connected)
]

#statement("Lemma", title: [Rigidity])[
  Suppose $X$ is proper, $f: X times Y arrow Z$ is a morphism such that $f(X times y_0) = z_0 in Z$, then $f(X times y)$ is a point in $Z$ for any $y in Y$
] <rigidity-lemma>

#proof[
  Just need to show that there exists a unique map $g: Y arrow Z$ such that $f = g p_2$, and it suffices to show that $f = g p_2$ on a nonempty open set of $X times Y$. Since $f(X times y_0) = z_0$, there exists nonempty closed $W subset.eq Z$ such that $f^(-1)(W)$ is disjoint from $X times y_0$, and since $X$ is proper, $X times Y arrow Y$ is closed, so $Y' = p_2(f^(-1)(W))$ is closed, and $V = Y - Y'$ is a nonempty open set in $Y$ containing $y_0$, for any $y in V$, $f(X times y) subset.eq U = Z - W$ open, but $X times y tilde.equiv X$ is proper, hence $f(X times y)$ is a point, denote as $g(y)$, then $f = g p_2$ on $X times V subset.eq X times Y$
]

#statement("Remark")[
  Note that the lemma is false if $X$ is not proper, for example $bb(A)^1 times bb(A)^1 arrow bb(A)^1, (x,y) arrow.r.bar x y$
]

#statement("Theorem", title: [Chevalley])[
  There is an exact sequence(in general non split)
  $ 1 arrow H arrow G arrow A arrow 1 $
  $A$ is an abelian variety, $H$ is affine
]

#statement("Theorem")[
  Any abelian variety $A$ is commutative(hence the term "abelian")
]

#proof[
  Consider $f: A times A arrow A, (x,y) arrow.r.bar x y x^(-1) y^(-1)$, then $f(A,e) = e$, by @rigidity-lemma, $f(A,y) = f(e,y) = e$, thus $A$ is commutative
]

#statement("Corollary")[
  $A$ is an abelian variety, $G$ is a group variety, $f: A arrow G$ is a morphism with $f(e_A) = e_G$, then $f$ is a group homomorphism
]

#proof[
  Consider $phi: A times A arrow G$, $(x,y) arrow.r.bar f(x) f(y) f(x y)^(-1)$, then $phi(A,e_A) = e_G$, by @rigidity-lemma, $phi(x,y) = phi(e_A,y) = e_G$, hence $f$ is a homomorphism
]

#statement("Corollary")[
  $A$ is an abelian variety, $X,Y$ are proper varieties pointed at $x_0,y_0$, then there is a bijection
  $ Hom(X,A) times Hom(Y,A) arrow Hom(X times Y,A), quad (f,g) arrow.r.bar f + g $
]

#proof[
  This is injective since $f(x) = h(x,y_0)$, $g(y) = h(x_0,y)$. This is also surjective by define $f,g$ the same way and consider $k(x,y) = h(x,y) - f(x) - g(y)$
]

#statement("Definition")[
  $S$-group scheme. $G$ is commutative if $m$ is a symmetric
]

#statement("Exercise")[
  $G arrow S$ is separable iff $e: S arrow G$ is a closed immersion
]

#statement("Definition")[
  $f: G arrow H$ is a $S$-group scheme homomorphism if it is compatible with $m,i,e$, $ker f$ as the pullback of $G arrow^f H$ and $S arrow^(e_H) H$ is again a $S$-group scheme, and $(ker f)(T) = ker(f_T)$
]

An abelian variety doesn't in general have a Hopf algebra structure, but due to Mumford, we can use Heisenberg group, or Mumford Tate group to help us study and understand

A group scheme can be reduced, for example $Spec bb(F)_p[t]/(t^p)$. However we have

#statement("Theorem", title: [Oort])[
  $"char" k = 0$, then any group scheme over $k$ is reduced
]

$X$ is a compact complex Lie group, $g = dim X$, $H^0(X,Omega^1) tilde.equiv bb(C)^g$, $H_1(X,bb(Z)) arrow H^0(X,Omega^1)^*$ with the image being a lattice $Lambda$, $X arrow^(tilde.equiv) H^0(X,Omega^1)^* / Lambda = V/Lambda$, $V = Lie X tilde.equiv tilde(X)$ by sending $p in X$ to $integral_0^p$

If $phi: X_1 arrow X_2$ is a holomorphic, $phi(0)$, $phi(e_(X_1)) = e_(X_2)$, then $phi$ is a homomorphism

#proof[
  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto),
      align: center + horizon,
      column-gutter: 0.3em, row-gutter: 0.5em,
      $H_1(X_1,bb(Z))$, $arrow$, $H^0(X_1,Omega^1)^*$, $arrow$, $V_1/Lambda_1$, $arrow.l$, $X_1$,
      $arrow.b$, [], $arrow.b$, [], $arrow.b$, [], $arrow.b$,
      $H_1(X_2,bb(Z))$, $arrow$, $H^0(X_2,Omega^1)^*$, $arrow$, $V_2/Lambda_2$, $arrow.l$, $X_2$,
    )
  ]
]

This means any holomorphic map $phi: X_1 arrow X_2$ is homomorphism + translation

#align(center)[
  #grid(
    columns: (auto, auto, auto), align: center + horizon,
    column-gutter: 1em, row-gutter: 0.5em,
    [], [$varphi_(bb(C))$ #rotate(-45deg)[$arrow.r.hook$]], $Hom_(bb(C))(V_1,V_2)$,
    $Hom(X_1,X_2)$, $arrow.r.hook$, $Hom_(bb(Z))(Lambda_1,Lambda_2)$,
    [], rotate(45deg)[$arrow.r.hook$], $Hom(H_1(X,bb(Z)_p),H_1(X,bb(Z)_p))$,
  )
]

$phi in Hom(X_1,X_2)$ determines $tilde(phi): V_1 arrow V_2$, and $phi(Lambda_1) subset.eq Lambda_2$, thus makes $varphi_(bb(Z))$ injective, and $Hom_(bb(Z))(Lambda_1,Lambda_2)$ is of rank $(2 dim X_1)(2 dim X_2)$, hence we know $Hom(X_1,X_2)$ is finite, in fact, $End(X)$ will be a free $bb(Z)$-algebra of rank $4 dim X^2$. We also have $im varphi subset.eq X_2$ is a subtorus, $ker varphi$ is a subtorus

#statement("Definition")[
  $phi: X_1 arrow X_2$ is an isogeny if $phi$ is surjective and $ker phi$ is finite, define $deg phi = |ker phi| < infinity$
]

Composition of isogeny is again an isogeny, deg multiply

$X_1 isogenous X_2$ isogeny is an equivalence relation. Suppose $phi: X_1 arrow X_2$ is an isogeny of deg $n$, then there exists a unique isogeny $phi^*: X_2 arrow X_1$

Consider

#align(center)[
  #grid(
    columns: (auto, auto, auto), align: center + horizon,
    column-gutter: 1em, row-gutter: 0.5em,
    $X_1$, $arrow^phi$, $X_2$,
    [], [$n$ #rotate(45deg)[$arrow$]], $arrow.b^(phi^*)$,
    [], [], $X_1$,
  )
]

since homo, we have

#align(center)[
  #grid(
    columns: (auto, auto, auto), align: center + horizon,
    column-gutter: 1em, row-gutter: 0.5em,
    $X_1$, $arrow^phi$, $X_2$,
    $arrow.b^n$, [], $arrow.b^n$,
    $X_1$, $arrow^phi$, $X_2$,
  )
]

$(phi phi^* - n) phi = 0$ and $phi$ is surjective

By Chow's theorem, any analytic variety $V$ in $bb(C) bb(P)^n$ is an algebraic variety, and thus a group variety(The graph $m: V times V arrow V$ being $V times V times V$ being an analytic variety that can be embedded in $bb(C) bb(P)^N$), actually an abelian variety(being proper)

Let $V$ be a dimension $g$ complex vector space, $H: V times V arrow bb(C)$ is a Hermitian form, $H = S + i E$, $S = "Re" H$, $E = "Im" H$, then

$X = V/Lambda$ is an abelian variety, $E|_(Lambda times Lambda): Lambda times Lambda arrow bb(Z)$ is a bilinear $bb(Z)$ valued map, then we say that $E$ is a Riemann form

#statement("Example")[
  $X = bb(C)/Lambda$, where $Lambda = bb(Z) lambda_1 + bb(Z) lambda_2$, define $E$ such that $z and w = E(z,w) lambda_1 and lambda_2$,
]

#statement("Example")[
  Suppose $K/bb(Q)$ is a CM field(totally imaginary field), $K^+/bb(Q)$ is the totally real field. $Phi: K times.o_(bb(Q)) bb(R) arrow bb(C)^g$ is an embedding. Nonzero ideal $I subset.eq cal(O)_K$ are both lattices, say $Phi(cal(O)_K)$ is $Lambda$, $X = bb(C)^g/Lambda$ is called a CM abelian variety, $cal(O)_K arrow.r.hook End(X)$ are multiplications. It is a fact that $K = K^+(xi)$ with $-xi^2 in K^+$ totally positive and $"Im"(phi_(j)(xi)) > 0$. For $z,w in bb(C)^g$, define $E(z,w) = sum_j phi(g_j)(overline(z)_j w_j - z_j overline(w)_j)$, for $alpha,beta in cal(O)_K$, $E(Phi(alpha),Phi(beta)) = "Tr"_(K/bb(Q))(xi tilde(alpha) beta)$, here $K arrow K, x arrow.r.bar tilde(x)$ is the unique automorphism fixing $K^+$
]

#align(center)[
  #grid(
    columns: (auto, auto, auto), align: center + horizon,
    column-gutter: 1em, row-gutter: 0.5em,
    $V times bb(C) tilde.equiv pi^* L$, $arrow$, $L$,
    $arrow.b$, [], $arrow.b$,
    $V$, $arrow^pi$, $X$,
  )
]

$pi^* L$ is holomorphically trivial because the exponential sequence $0 arrow 2 pi i bb(Z) arrow cal(O)_V arrow cal(O)_V^times arrow 0$

Consider the group action of $Lambda$ on $V$, and corresponding action $Lambda$ on $V times bb(C)$ defined as $(z,t) dot lambda = (z + lambda,e_(lambda)(z)t)$, here $e_lambda in bb(O)_V^times$ satisfying the cocycle condition $e_(lambda_1 + lambda_2)(z) = e_(lambda_2(z + lambda_1)) e_(lambda_1)(z)$, note that this is commutative

Let $F$ be a number field, with $r_1$ real embeddings and $2 r_2$ complex embeddings, $r_1 + 2 r_2 = [F:bb(Q)]$, let $w_F$ be the number of roots of unity, $h_F = |Cl(cal(O)_F)|$ be the class number of $F$, $r_F$ is the regulator of $F$ which is the covolume of the lattice $cal(O)_F^times/"torsion" arrow.r.hook bb(R)^(r_1 + r_2 - 1)$. We can the define the zeta function
$
  zeta_(F)(s) = sum_(0 != frak(I) lt.eq cal(O)_F) 1/(|frak(I)|^s)
  = product_(frak(p) "prime") 1/(1 - |frak(p)|^s), quad op("Re") s > 1
$

#statement("Theorem")[
  $zeta_(F)(s)$ admits analytic continuation to all of $bb(C)$ with a simple pole at $s = 1$, so $(s - 1) zeta_(F)(s)$ is analytic, and it satisfies the functional relation $zeta_(F)(s) = 2^s pi^(s - 1) sin((pi s)/2) Gamma(1 - s) zeta_(F)(1 - s)$. Denote
  $
    zeta_F^*(1) = Res_(s=1) zeta_(F)(s) = plus.minus (2^(r_1) (2 pi)^(r_2) h_F r_F)/(w_F sqrt(|d_F|))
  $
]

$F = bb(Q)(sqrt(-d))$, $d > 0$, $r_F = 1$, $zeta_F^*(1) = 2 pi h_F$

$F = bb(Q)(sqrt(d))$, $d > 0$, $cal(O)_F^times = plus.minus epsilon_F^(bb(Z))$, $epsilon_F$ is the fundamental unit, $zeta_F^*(1) = (h_F log(epsilon_F))/sqrt(|d_F|)$. $h_F$ is a global invariant

$C/bb(F)_q$ is a smooth projective curve, geometrically connected
$
  zeta(C,s) = product_(x in C "closed points") 1/(1 - N(x)^(-s))
  = product_x 1/(1 - (q^(-s))^(deg x))
$
here $N(x) = [k(x):k] = q^(deg s)$. Write $Z(C,t) = product_x 1/(1 - t^(deg x))$, then $zeta(C,s) = Z(C,q^(-s))$

$Z(C,t) = P_1(t)/((1 - t)(1 - q t))$, $P_1(t) in bb(Z)[t]$ of degree $2g$, $g$ is the genus of $C$

#statement("Theorem", title: [Weil, Emil Artin, Hasse])[
  $s = 1$, $t = 1/q$, $(1 - q t) Z(C,t)|_(t=1/q) = P_1(1/q)/(1 - 1/q) = h_C/(q - 1) q^(1 - g)$, here $h_C$ is the class number which is $hash J(C)(bb(F)_q)$($J$ is the Jacobian), $q - 1$ is like $w_C$, $q^(g - 1)$ is like $sqrt(|d_C|)$
  #align(center)[
    #grid(
      columns: (auto, auto, auto), align: center + horizon,
      column-gutter: 1em, row-gutter: 0.5em,
      $C$, $arrow$, $Spec cal(O)_F$,
      $arrow.b$, [], $arrow.b$,
      $Spec bb(F)_p$, $arrow$, $Spec bb(Z)$,
    )
  ]
]

We generalize in dimension 2 $cal(E) subset.eq bb(P)^2_(bb(Z))$

#align(center)[
  #grid(
    columns: (auto, auto, auto), align: center + horizon,
    column-gutter: 1em, row-gutter: 0.5em,
    $E$, $arrow$, $cal(E)$,
    $arrow.b$, [], $arrow.b$,
    $Spec bb(Q)$, $arrow$, $Spec bb(Z)$,
  )
]

In Tate's thesis, he dealt with $F$ number field, $bb(F)_(q)(C)$

$bb(Z) = product_p bb(Z)_p$, $A_(bb(Q))^f = hat(bb(Z)) times.o_(bb(Z)) bb(Q) subset.eq product bb(Q)_p$, $A_(bb(Q))^f = (hat(bb(Z)) times.o_(bb(Z)) bb(Q)) times bb(R) subset.eq (product bb(Q)_p) times bb(R)$, $bb(A)_F = bb(A)_Q times.o_(bb(Q)) F$ for a number field $F$, $bb(G)_(m)(bb(A)_F) = bb(I)_F$, we have diagonal maps $F arrow^Delta bb(A)_F$, $F^times arrow^Delta bb(I)_F$, $|bb(G)_(m)(bb(A)_F)^1/bb(G)_(m)(F)|$ is finite and arithmetically interesting, here $bb(I)_F^1$ is the kernel of $bb(I)_F arrow bb(R)^times$, $x arrow.r.bar N(x)$

Andr#text("\u{e9}") Weil considered $|G(bb(A)_F)^1/G(F)|$ for $G/F$ is an algebraic group(e.g. $G = SL_n, SO_n$), and reintepreted the result of Siegel on quadratic forms

$E/bb(Q)$ is an elliptic curve, since $E(bb(Q)_p) = E(bb(Z)_p)$, $bb(P)^(n)(bb(Q)) = bb(P)^(n)(bb(Z))$, $E(bb(A)_(bb(Q)))/E(bb(Q)) = (E(hat(bb(Z))) times E(bb(R)))/E(bb(Z))$ is not Hausdorff if $rank E bb(Q) > 0$

BSD conjecture: $E/F$ is an elliptic curve(Abelian variety), $L(E,s) = product L_(p)(E,s)$, $op("Re") s > 3/2$ has a analytic continuation to all of $bb(C)$, $ord_(s=0) L(F,s) = rank cal(O)_F^times$

Weak: $ord_(s=1) L(E,s) = rank E(F)$

Strong: $L^(times)(E,s)$

#pagebreak()
#heading(numbering: none)[References]

#pagebreak()
#heading(numbering: none)[Index]