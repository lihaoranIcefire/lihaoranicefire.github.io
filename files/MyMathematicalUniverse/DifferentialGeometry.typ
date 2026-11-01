#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Differential geometry

== Manifold
<manifold>
#statement("Definition")[
A #emph[submanifold]#index-entry("Submanifold") $N$ is a inclusion and an immersion $i : N arrow.r.hook M$

]
#statement("Definition")[
The kernel of $C_p^oo\(M\)arrow.r bb(R)\,f mapsto f\(p\)$ is a maximal ideal $m_p$, define the #emph[cotangent space]#index-entry("Cotangent space") $T_p^(*) M := m_p / m_p^2$, for $f in C^oo\(M\)$, define $\(d f\)_p = f - f\(p\)#h(0.444em) mod med m_p$, $\(d x_1\)_p\,dots.h.c\,\(d x_n\)_p$ form a basis of $T_p^(*) M$ locally, $\(d f\)_p = frac(partial f, partial x_1)\(p\)\(d x_1\)_p + dots.h.c + frac(partial f, partial x_n)\(p\)\(d x_n\)_p$

]
#statement("Definition")[
The #emph[tangent space]#index-entry("Tangent space") $T_p M$ at $p$ are the derivations $D e r\(C_p^oo\(M\)\)$

$(frac(partial, partial x_1))_p\,dots.h.c\,(frac(partial, partial x_n))_p$ form a basis of $T_p M$ locally

]
#statement("Definition")[
The #emph[pushforward(differential)]#index-entry("Pushforward(differential)") of smooth map $phi.alt : M arrow.r N$ is $phi.alt_p : T_p M arrow.r T_p N$, $phi.alt_p\(X_p\)\(f\)= X_p\(f compose phi.alt\)$

]
#statement("Definition")[
The #emph[pullback]#index-entry("Pullback") of smooth map $phi.alt : M arrow.r N$ is $phi.alt^(*) : C^oo\(N\)arrow.r C^oo\(N\)$, $phi.alt^(*)\(f\)= f compose phi.alt$

]
#statement("Definition")[
$(phi^(*) alpha)_x\(X\)= alpha_(phi\(x\))\(d phi_x\(X\)\)= alpha_(phi\(x\))\(\(phi_(*)\)_x\(X\)\)$, or in short $phi^(*) alpha\(X\)= alpha\(phi_(*) X\)$, similarly, for $k$ forms, $phi^(*) alpha\(X_1\,dots.h.c\,X_k\)= alpha\(phi_(*) X_1\,dots.h.c\,phi_(*) X_k\)$

In particular, $phi^(*)\(d x\)= d\(x compose phi\)$, pullback is compatible with wedge product, $phi^(*)\(alpha and beta\)= phi^(*) alpha and phi^(*) beta$, and pullback is compatible with exterior derivative, $phi^(*)\(d alpha\)= d\(phi^(*) alpha\)$ The exterior multiplication by $alpha$ is $beta mapsto alpha and beta$ The interior multiplication by $v in T M$ is $v corner.r.b : omega\(-\)mapsto omega\(v\,-\)$

]
#statement("Definition")[
$pi : T^(*) M arrow.r M$ is the cotangent bundle, the #emph[tautological one form] or #emph[canonical one form]#index-entry("Tautological one form") is $pi^(*) omega$

]
#statement("Definition")[
Let $M$ be a smooth manifold, $X\,Y in C^oo\(M\,T M\)$ are vector fields, define Lie bracket#index-entry("Lie bracket of vector fields") $\[X\,Y\]in C^oo\(M\,T M\)$, $\[X\,Y\]\(f\):=\(X Y - Y X\)\(f\)= X\(Y\(f\)\)- Y\(X\(f\)\)$

]
#aside("Remark")[
Check from local coordinates, $X\(Y\(f\)\)$ is not well defined

]
#statement("Definition")[
Let $M\,N$ be smooth manifolds, $f : M arrow.r N$ is a smooth map, it is called an immersion if $d f$ is injective at any point, it is called submersion if $d f$ is surjective at any point

]
#statement("Theorem")[
Suppose $M\,N$ are smooth manifolds with dimension $m\,n$, $f : M arrow.r N$ is a smooth map with constant rank $r$, then for any $p in M$, denote $f\(p\)= q$, there are local charts $\(p\,U\)$, $\(q\,V\)$ such that $chi_V compose f compose chi_U\(x_1\,dots.h.c\,x_m\)=\(x_1\,dots.h.c\,x_r\,0\,dots.h.c\,0\)$. Moreover, suppose $M$ is second countable, if $f$ is injective, then $f$ is a immersion, if $f$ is surjective, then $f$ is a submersion, if $f$ is bijective, then $f$ is a diffeomorphism

]#label("Constant rank mapping theorem")
#proof(title: "Proof")[
If $f$ is surjective but not a submersion, then $r < n$, but then by Theorem #unresolved-reference("Baire category theorem"), $f$ can't be surjective which is a contradiction

]
#statement("Theorem")[
Suppose $M\,N$ are smooth manifolds with dimension $m\,n$, $f : M arrow.r N$ is a smooth map with constant rank $r$, then a level set $S = f^(- 1)\(c\)$ is an embedded submanifold in $M$ of codimension $r$ with $f\|_S$ being a proper map

]#label("Constant rank level set theorem")
#statement("Proposition")[
Let $G$ be a Lie group, $M\,N$ be smooth manifolds with a $G$ action, and $G$ acts transitively on $M$, for any equivariant map $f : M arrow.r N$, $f$ has constant rank

]
#proof(title: "Proof")[
For any $x in M$, denote $y = f\(x\)$, it suffices to show $upright(r a n k)\(d f\)_x = upright(r a n k)\(d f\)_(g x)$ since $G$ acts transitively on $M$, note that $f\(g x\)= g f\(x\)$, thus $f L_g = L_g f$, $\(d f\)_(g x)\(d L_g\)_x = d\(L_g\)_y\(d f\)_x$, and group actions are isomorphisms, we have $upright(r a n k)\(d f\)_x = upright(r a n k)\(d f\)_(g x)$

]
#statement("Theorem", title: [Stokes' theorem])[
$chevron.l partial Omega\,omega chevron.r = chevron.l Omega\,d omega chevron.r$, here $chevron.l Omega\,omega chevron.r = integral_Omega omega$

]#label("Stokes' theorem")
#statement("Theorem", title: [de Rham's theorem])[
$M$ is a smooth manifold. $H_(upright(d R))^p\(X\;bb(R)\)arrow.r^tilde.equiv H^p\(X\;bb(R)\)$ is an isomorphism

]
#proof(title: "Proof")[
Since $bb(R)$ is a divisible abelian group, thus an injective $bb(Z)$ module, hence $"Ext"_(bb(Z))^1\(A\,bb(R)\)$, thus universal coefficient theorem gives exact sequence #display-equation($0 = "Ext"_(bb(Z))^1\(H_(p - 1)\(X\;bb(Z)\)\,bb(R)\)arrow.r H^p\(M\;bb(R)\)arrow.r "Hom"\(H_p\(X\;bb(Z)\)\,bb(R)\)arrow.r 0$) The isomorphism is given by $H_(upright(d R))^p\(X\;bb(R)\)arrow.r "Hom"\(H_p\(X\)\,bb(R)\)$, $omega mapsto integral_(-) omega$

]
#statement("Definition")[
$E arrow.r X$ is a vector bundle, a connection on $E$ is an $bb(R)$ linear map #display-equation($nabla : Gamma\(E\)arrow.r Gamma\(T^(*) X times.o E\)$) satisfying Leibniz rule $nabla\(f sigma\)= f times.o nabla sigma + d f times.o sigma$

]
#statement("Lemma")[
$nabla_X\(sigma\)=\(nabla sigma\)\(X\)$ defines a covariant derivative, conversely, every covariant derivative is defined this way

]
== Differential geometry of surfaces
<differential-geometry-of-surfaces>
#statement("Definition")[
A #strong[differentiable surface] is an embedding $S arrow.r.hook bb(R)^3$

]
#statement("Lemma")[
$gamma\(t\)$ is a geodesic iff $dot.double(gamma)$ is parallel to the normal $arrow(n)$, meaning no acceleration in $S$

A geodesic $gamma$ on $S$ has constant speed

The geodesic curvature of a curve $gamma$ is the curvature of the projection onto tangent plane, $gamma$ is a geodesic iff the geodesic curvature of $gamma$ is zero

]
#proof(title: "Proof")[
$frac(d, d t)\|dot(gamma)\|^2 = 2 dot.double(gamma) dot.op dot(gamma) = 0$

]
== Connection and curvature
<connection-and-curvature>
#statement("Definition")[
The #emph[volume form]#index-entry("Volume form") is $sqrt(\|det g\|) d x_i and d x_j$, which happen to be $star.op 1$

]
#statement("Definition")[
#emph[Hodge star]#index-entry("Hodge star") is defined to be $eta and star.op xi = chevron.l eta\,xi chevron.r omega$, $omega$ is the volume form. Consider $\(alpha\,beta\)= integral_X alpha and star.op beta$, $d^(*) =\(- 1\)^(k l + 1) star.op d star.op$ is the #emph[codifferential]#index-entry("Codifferential") that $\(d alpha\,beta\)=\(alpha\,d^(*) beta\)$, $Delta = d d^(*) + d^(*) d$ is the Laplacian

]
#statement("Definition")[
An #strong[affine connection]#index-entry("Affine connection") is #display-equation($nabla : Gamma\(T M\)times.o Gamma\(T M\) & arrow.r Gamma\(T M\)\
\(X\,Y\) & mapsto nabla_X Y$)satisfying

- $nabla_(f X) Y = f nabla_X Y$, i.e. $nabla$ is $C^oo\(M\,bb(R)\)$ linear in the first variable

- $nabla_X\(f Y\)= X f Y + f nabla_X Y$, i.e. $nabla$ satisfies Leibniz rule in the second variable

From this we can define covariant derivative $nabla$, $nabla_X f = X_f$, $\(nabla_X alpha\)\(Y\)= nabla_X\(alpha\(Y\)\)- alpha\(nabla_X Y\)$, here $alpha$ is a covector, similarly for any tensor, Write contraction $\(nabla T\)\(alpha_1\,dots.h.c\,alpha_m\,X_1\,dots.h.c\,X_n\,X\)=\(nabla_X T\)\(alpha_1\,dots.h.c\,alpha_m\,X_1\,dots.h.c\,X_n\)$, $T$ is a tensor

]
#aside("Note")[
$nabla_X\(alpha\(Y\)\)= nabla_X\(alpha\)\(Y\)+ alpha\(nabla_X Y\)$

]
#statement("Definition")[
$nabla$ is an affine connection, the #strong[torsion tensor]#index-entry("Torsion tensor") is #display-equation($T\(X\,Y\)= nabla_X Y - nabla_Y X -\[X\,Y\]$)

]
#statement("Definition")[
The Levi-Civita connection $nabla$ is the one satisfying

- $nabla_Z g\(X\,Y\)= g\(nabla_Z X\,Y\)+ g\(X\,nabla_Z Y\)$, i.e. $nabla g = 0$

- $nabla_X Y - nabla_Y X =\[X\,Y\]$, i.e. $nabla$ is torsion free

]
#statement("Definition")[
$nabla$ is the Levi-Civita connection, the Riemannian curvature tensor is $R_(X Y) =\[nabla_X\,nabla_Y\]- nabla_(\[X\,Y\])$

]
#aside("Remark")[
$X\,Y$ are commuting vector fields around $x_0$, then $frac(d, d s) frac(d, d t) tau_(s X)^(- 1) tau_(t Y)^(- 1) tau_(s X) tau_(t Y) Z = R_(X Y) Z$, $tau$ is the parallel transport

#figure([#universe-drawing(5.0)],
  caption: [
  ]
)

]
#statement("Definition")[
$nabla$ is a affine connection, denote $partial_i = frac(partial, partial x_i)$, $g_(i j) = chevron.l partial_i\,partial_j chevron.r$, $nabla_i = nabla_(partial_i)$. The #emph[Christoffel symbols]#index-entry("Christoffel symbol") $Gamma_(i j)^k$ is defined such that $nabla_i partial_j = sum_k Gamma_(i j)^k partial_k$, then $nabla_i partial_j - nabla_j partial_i = sum_k\(Gamma_(i j)^k - Gamma_(j i)^k\)partial_k$, if $nabla$ is torsion free, then $nabla_i partial_j - nabla_j partial_i =\[partial_i\,partial_j\]= 0 arrow.r.double Gamma_(i j)^k = Gamma_(j i)^k$. Since #display-equation($frac(partial g_(i j), partial x_k) = nabla_k g_(i j) = sum_l Gamma_(k i)^l g_(j l) + sum_l Gamma_(k j)^l g_(i l)$) Switch $j\,k$, we have #display-equation($frac(partial g_(i k), partial x_j) = sum_l Gamma_(j i)^l g_(k l) + sum_l Gamma_(k j)^l g_(i l)$) Then switch $i\,j$, we have #display-equation($frac(partial g_(j k), partial x_i) = sum_l Gamma_(i j)^l g_(k l) + sum_l Gamma_(k i)^l g_(j l)$) Thus #display-equation($frac(partial g_(j k), partial x_i) + frac(partial g_(i k), partial x_j) - frac(partial g_(i j), partial x_k) = 2 sum_l Gamma_(i j)^l g_(k l)$) Therefore #display-equation($Gamma_(i j)^k = 1 / 2 sum_l g^(k l) (frac(partial g_(j k), partial x_i) + frac(partial g_(i k), partial x_j) - frac(partial g_(i j), partial x_k))$)

]
#statement("Proposition")[
+ $R_(Y X) = - R_(X Y)$

+ $\(R_(X Y) Z\,W\)= -\(R_(X Y) W\,Z\)$

+ $R_(X Y) Z + R_(Y Z) X + R_(Z X) Y = 0$

+

The #strong[second Bianchi identity]#index-entry("Second Bianchi identity") follows #display-equation($nabla_X R_(Y Z) + nabla_Y R_(Z X) + nabla_Z R_(X Y) = 0$)

]
#aside("Remark")[
If write $\(R_(X Y) Z\,W\)= R\(X\,Y\,Z\,W\)$, then $R$ is antisymmetric about the first two variables and the last two variables, $R$ satisfies Jacobi identity, the first two and the last two variables can switch place

]
#proof(title: "Proof")[
+

+

+

+ Follow from above

]
#statement("Definition")[
There is a unique way to define the connection on all $\(r\,s\)$ tensors that are compatible with tensor products(Leibniz rule) and tensor contraction. In particular we would have #display-equation($nabla_X\(omega\(Y\)\)=\(nabla_X omega\)\(Y\)+ omega\(nabla_X Y\)$) Hence we have #display-equation($nabla d x_i = - sum_(j\,k) Gamma_(k j)^i d x_k times.o d x_j$)

]
#statement("Definition")[
${ e_i }$ is an orthonomal basis, the #strong[Ricci curvature]#index-entry("Ricci curvature") is $"Ric"\(X\)= sum R_(X\,e_i) e_i$. The #strong[scalar curvature]#index-entry("Scalar curvature") is $S = "Tr" "Ric" = sum\("Ric"\(e_j\)\,e_j\)= sum\(R_(e_j\,e_i) e_i\,e_j\)$. The #strong[Einstein curvature]#index-entry("Einstein curvature") is $G = R - 1 / 2 g S$

]
#statement("Definition")[
The gradient $"grad" f$ of a function $f$ is defined so that $g\("grad" f\,X\)= X f$. Assume $"grad" f = Y$, $sum_i g_(i k) Y_i = frac(partial f, partial x_k)$, suppose $\(g^(i j)\)$ is the inverse of $\(g_(i j)\)$, then $Y_j = sum_i frac(partial f, partial x_i) g^(i j)$, $"grad" f = sum_j (sum_i frac(partial f, partial x_i) g^(i j)) frac(partial, partial x_j)$

]
#statement("Definition")[
The Hessian $"Hess" f$ of a function $f$ is $nabla^2 f$, or defined through $"Hess" f\(X\,Y\)= g\(nabla_X "grad" f\,Y\)$. In local coordinates, we have #display-equation($nabla^2 f & = nabla\(d f\)= sum_i nabla (frac(partial f, partial x_i) d x_i)\
 & = sum_i nabla (frac(partial f, partial x_i)) times.o d x_i + sum_i frac(partial f, partial x_i) nabla d x_i\
 & = sum_(i\,j) frac(partial^2 f, partial x_i partial x_j) d x_j times.o d x_i - sum_(i\,j\,k) frac(partial f, partial x_i) Gamma_(k j)^i d x_k times.o d x_j\
 & = sum_(i\,j) frac(partial^2 f, partial x_i partial x_j) d x_i times.o d x_j - sum_(i\,j\,k) frac(partial f, partial x_k) Gamma_(i j)^k d x_i times.o d x_j\
 & = sum_(i\,j) (frac(partial^2 f, partial x_i partial x_j) - sum_k frac(partial f, partial x_k) Gamma_(i j)^k) d x_i times.o d x_j$) In other words, $"Hess" f\(X\,Y\)= X\(Y f\)-\(nabla_X Y\)f$

]
#statement("Definition", title: [Musical isomorphisms])[
$sharp : T^(*) M arrow.r T M\,flat : T M arrow.r T^(*) M$. $\(omega^sharp\,X\)= omega\(Y\)$, $\(X^flat\,alpha\)= alpha\(X\)$. For example, $d x_i^sharp = sum_k g^(i k) frac(partial, partial x_k)$

]
Riemann metric induces an inner product on $T^(*) M$ through musical isomorphisms. For example, $\(d x_i\,d x_j\)=\(d x_i^sharp\,d x_j^sharp\)= sum_(k l) g^i k g^(j l) (frac(partial, partial x_k) \, frac(partial, partial x_l)) = sum_(k l) g^(i k) g^(l j) g^(k l) = g^(i j)$. This also gives an inner product on $T_M^k$

#statement("Definition")[
The Laplacian $Delta f = "tr" "Hess" f$ is the trace of the Hessian. Here the trace is the trace contraction taken with respect to the metric. In local coordinates #display-equation($Delta f = sum_(i\,j) g^(i j) (frac(partial^2 f, partial x_i partial x_j) - sum_k frac(partial f, partial x_k) Gamma_(i j)^k)$)

]
== Hyperbolic geometry
<hyperbolic-geometry>
#statement("Definition")[
$bb(R)^(n + 1)$ with metric $d s^2 = d x_1^2 + dots.h.c + d x_n^2 - d x_0^2$ is the #emph[Minkowski space]#index-entry("Minkowski space")

The #strong[hyperboloid model]#index-entry("Hyperboloid model") is $bb(H) = { x_1^2 + dots.h.c + x_n^2 - x_0^2 = - 1\,x_0 > 0 }$. The Riemannian metric is the pullback metric $d s^2 = d x_1^2 + dots.h.c + d x_n^2 - d x_0^2$

The geodesics are intersections of $bb(H)$ and two dimensional subspaces of $bb(R)^(n + 1)$ $\(d sinh s\)^2 +\(d cosh s\)^2 = cosh^2 s d s^2 - sinh^2 s d s^2 = d s^2$, thus $bb(H)^1$ is isomorphic to $bb(E)^1$

#align(center)[
#universe-drawing(6.0)
]
$\(x'\,x_n\)mapsto (frac(2 x', 1 + x_n) \, 1)$, $x' =\(x_0\,dots.h.c\,x_(n - 1)\)$ is the isometry from the hemisphere to the halfspace

$\(x'\,1\)mapsto (frac(4 x', 4 +\|x'\|^2) \, frac(4 -\|x'\|^2, 4 +\|x'\|^2))$, $x' =\(x_0\,dots.h.c\,x_(n - 1)\)$ is the isometry from the halfspace to the hemisphere

$x mapsto (frac(x', 1 + x_0))$, $x' =\(x_1\,dots.h.c\,x_n\)$ is the isometry from the hemisphere to Poincaré disc

$x mapsto (frac(2 x, 1 -\|x\|^2) \, frac(1 +\|x\|^2, 1 -\|x\|^2))$ is the isometry from Poincaré disc to the hyperboloid

$x mapsto (1 \, x')$, $x' =\(x_1\,dots.h.c\,x_n\)$ is the isometry from the hemisphere to Klein disc

$x mapsto (x' / x_0 \, 1 / x_0)$, $x' =\(x_1\,dots.h.c\,x_n\)$ is the isometry from the hyperboloid to the hemisphere

$x mapsto (x' / x_0 \, 1 / x_0)$, $x' =\(x_1\,dots.h.c\,x_n\)$ is the isometry from the hemisphere to the hyperboloid \ $\(x_0\,x'\)mapsto (1 \, x' / x_0)$ is the isometry from the hyperboloid to the Klein model \ $\(x\,1\)mapsto (1 / sqrt(1 -\|x\|^2) \, x / sqrt(1 -\|x\|^2))$ is the isometry from the Klein model to the hyperboloid \ The #strong[hemisphere model]#index-entry("Hemisphere model") is $bb(H) = { x_0 > 0 } inter S^n$. The Riemannian metric is pullback metric #display-equation($sum_(i = 0)^(n - 1) [d (x_i / x_n)]^2 - [d (1 / x_n)]^2 & = sum_(i = 0)^(n - 1) (frac(x_0 d x_i - x_i d x_0, x_0^2))^2 - (- frac(d x_0, x_0^2))^2\
 & = sum_(i = 0)^(n - 1) frac(x_0^2 d x_i^2 - 2 x_i x_0 d x_i d x_0 + x_i^2 d x_0^2, x_0^4) - frac(d x_0^2, x_0^4)\
 & = frac(d x' ""^2, x_0^2) - frac(d\(\|x'\|^2\)d\(x_0^2\), 2 x_0^4) + frac(\|x'\|^2 d x_0^2 - d x_0^2, x_0^4)\
 & = frac(d x' ""^2, x_0^2) - frac(d\(1 - x_0^2\)d\(x_0^2\), 2 x_0^4) - frac(d x_0^2, x_0^2)\
 & = frac(d x' ""^2, x_0^2) + frac(2 d x_0^2, x_0^2) - frac(d x_0^2, x_0^2)\
 & = frac(d x' ""^2 + d x_0^2, x_0^2)$) The #strong[half space model]#index-entry("Half space model") is $bb(H) = { x_0 > 0 } inter { x_n = 1 }$. The Riemannian metric is pullback metric #display-equation($frac(sum_(i = 0)^(n - 1) d (frac(4 x_i, 4 +\|x'\|^2))^2 + d (frac(4 -\|x'\|^2, 4 +\|x'\|^2))^2, (frac(4 x_0, 4 +\|x'\|^2))^2) & =^(X = 4 +\|x'\|^2) frac(sum_(i = 0)^(n - 1) d (frac(4 x_i, X))^2 + d (8 / X - 1)^2, (frac(4 x_0, X))^2)\
 & = X^2 / x_0^2 (sum_(i = 0)^(n - 1) d (x_i / X)^2 + 4 d (1 / X)^2)\
 & = X^2 / x_0^2 (sum_(i = 0)^(n - 1) (frac(X d x_i - x_i d X, X^2))^2 + 4 frac(d X^2, X^4))\
 & = 1 / x_0^2 (sum_(i = 0)^(n - 1) frac(X^2 d x_i^2 + x_i^2 d X^2 - 2 X x_i d X d x_i, X^2) + 4 frac(d X^2, X^2))\
 & = 1 / x_0^2 (d x' ""^2 + frac(\|x'\|^2 d X^2, X^2) + frac(4 d X^2, X^2) - frac(d X d\(\|x'\|^2\), X))\
 & = 1 / x_0^2 (d x' ""^2 + frac(X d X^2, X^2) - frac(d X d\(X - 4\), X))\
 & = frac(d x' ""^2, x_0^2)\
$) The #strong[Poincaré disc model]#index-entry("Poincaré disc model") is $bb(H) = D^n$. The Riemannian metric is pullback metric #display-equation($sum_(i = 1)^n d (frac(2 x_i, 1 -\|x\|^2))^2 - d (frac(1 +\|x\|^2, 1 -\|x\|^2))^2 & =^(X = 1 -\|x'\|^2) sum_(i = 1)^n d (frac(2 x_i, X))^2 - d (2 / X - 1)^2\
 & = 4 sum_(i = 1)^n (frac(X d x_i + x_i d X, X^2))^2 - 4 (- frac(d X, X^2))^2\
 & = 4 sum_(i = 1)^n frac(X^2 d x_i^2 + x_i^2 d X^2 - X x_i d X d x_i, X^4) - 4 frac(d X^2, X^4)\
 & = 4 (frac(d x^2, X^2) + frac(\|x\|^2 d X^2, X^4) - frac(d X^2, X^4) - frac(d\(\|x\|^2\)d X, X^3))\
 & = 4 (frac(d x^2, X^2) - frac(X d X^2, X^4) - frac(d\(1 - X\)d X, X^3))\
 & = frac(4 d x^2, X^2) = frac(4 d x^2, \(1 -\|x\|^2\)^2)$)

The #strong[Klein disc model]#index-entry("Klein disc model") is $bb(H) = D^n$. The Riemannian metric is #display-equation($lr(|d (x / sqrt(1 -\|x\|^2))|)^2 - d (1 / sqrt(1 -\|x\|^2))^2 = frac(\|d x\|^2, 1 -\|x\|^2) + frac(\(x dot.op d x\)^2, \(1 -\|x\|^2\)^2) = sum frac(\(1 -\|x\|^2 + x_i^2\), \(1 -\|x\|^2\)^2) d x_i^2$) The distance between $P\,Q$ is $1 / 2 ln (frac(\|X Q\|\|P Y\|, \|X Y\|\|P Q\|)) = 1 / 2 ln (X \, P \; Q \, Y)$, $\(X\,P\;Q\,Y\)$ is the cross ratio

#align(center)[
#universe-drawing(7.0)
]
]
#statement("Theorem")[
$"Isom"\(bb(H)^2\)= P S L\(2\,bb(R)\)$

]
#proof(title: "Proof")[
An isometry sends half circles and orthogonal lines to half circles or orthogonal lines, by Schwarz reflection principle #ref(label("Schwarz reflection principle"), supplement: none), it is can be regard as an isometry on $bb(C) P^1$ sending $bb(R) P^1$ to $bb(R) P^1$, then it necessarily has to be in $P S L\(2\,bb(R)\)$

]
#statement("Theorem")[
$"Isom"\(bb(H)^3\)= P S L\(2\,bb(C)\)times.l bb(Z)\/2 bb(Z) tilde.equiv S L\(2\,bb(C)\)$

]
#proof(title: "Proof")[
Since $partial bb(H)^3$ is the Riemann sphere, every isometry on $bb(H)^3$ restricts to a conformal map on $partial bb(H)^3$ because it sends hemispheres and orthogonal planes to hemispheres or orthogonal planes, hence it is a Möbius transformation. On the other hand, Möbius transformations which can all be extended to an isometry on $bb(H)^3$, translations $z mapsto z + lambda$ can be extended to $\(z\,x_3\)mapsto\(z + lambda\,x_3\)$, dilations $z mapsto lambda z$ can be extended to $\(z\,x_3\)mapsto\(lambda z\,\|lambda\|x_3\)$, inversions $z mapsto - 1 / z$ can be extended to $\(z\,x_3\)mapsto (frac(- macron(z), \|z\|^2 + x_3^2) \, frac(x_3, \|z\|^2 + x_3^2))$. Therefore the isometry group for $bb(H)^3$ is $P S L\(2\,bb(C)\)times.l bb(Z)\/2 bb(Z) tilde.equiv S L\(2\,bb(C)\)$

]
== Complex manifold
<complex-manifold>
Suppose $chevron.l\,chevron.r$ is a Hermitian inner product on $bb(C)^n$, then $"Re" chevron.l\,chevron.r$ is a real inner product on $bb(R)^(2 n)$, i.e. $"Re" chevron.l X_1 + i X_2\,Y_1 + i Y_2 chevron.r = "Re" chevron.l X_1\,Y_1 chevron.r + "Re" chevron.l X_2\,Y_2 chevron.r$. On the other hand, a inner product on $bb(R)^n$ can be extended to a Hermitian inner product on the complexification $bb(C)^n$ by complex linearality

#statement("Definition")[
$M$ is an even dimensional real manifold, an #emph[almost complex structure]#index-entry("Almost complex structure") is $J : T_(bb(R)) M arrow.r T_(bb(R)) M$ such that $J^2 = - 1_(T_(bb(R)) M)$. A complex manifold has an almost complex structure #display-equation($J frac(partial, partial x_i) = frac(partial, partial y_i)\,J frac(partial, partial y_i) = - frac(partial, partial x_i)$)

]
#statement("Example")[
$S^4$ cannot be given an almost complex structure. $S^6$ can be given an almost complex structure but not a complex structure

]
#statement("Definition")[
$A$ is a $\(1\,1\)$ form, the Nijenhuis tensor is #display-equation($N_A\(X\,Y\)= - A^2\[X\,Y\]+ A\(\[A X\,Y\]+\[X\,A Y\]\)-\[A X\,A Y\]$)

]
#statement("Theorem", title: [Newslander-Nirenberg theorem])[
$J$ is #emph[integrable] iff $N_J = 0$. Meaning there is a unique complex structure which will give $J$

]
#statement("Proposition")[
Given an almost complex structure, we can find coordinate charts $\(z_1\,dots.h.c\,z_n\,macron(z)_1\,dots.h.c\,macron(z)_n\)$ such that $"Span" {frac(partial, partial z_i)}$, $"Span" {frac(partial, partial macron(z)_i)}$ to be the $i$ and $- i$ eigenspaces of $J$

]
#statement("Definition")[
A #emph[Hermitian manifold]#index-entry("Hermitian manifold") $M$ is a complex manifold with a #emph[Hermitian metric]#index-entry("Hermitian metric") $h = sum h_(alpha macron(beta)) d z_alpha times.o d macron(z)_beta$ on $T M times.o bb(C)$, where $h_(alpha macron(beta))$ is a positive definite Hermitian matrix. The real part gives a Riemannian metric #display-equation($g & = 1 / 2\(h + macron(h)\)\
 & = 1 / 2 (sum h_(alpha macron(beta)) d z_alpha times.o d macron(z)_beta + sum h_(beta macron(alpha)) d macron(z)_alpha times.o d z_beta)\
 & = 1 / 2 sum h_(alpha macron(beta))\(d z_alpha times.o d macron(z)_beta + d macron(z)_beta times.o d z_alpha\)\
 & = sum h_(alpha macron(beta)) d z_alpha d macron(z)_beta$) Also gives #emph[associate] $\(1\,1\)$ #emph[form]#index-entry("Associate (1,1) form") #display-equation($omega = - frac(h - macron(h), 2 i) = i / 2\(h - macron(h)\)= i / 2 sum h_(alpha macron(beta))\(d z_alpha times.o d macron(z)_beta - d macron(z)_beta times.o d z_alpha\)= i / 2 sum h_(alpha macron(beta)) d z_alpha and d macron(z)_beta$) Note that the volume form is $"vol"_M = frac(omega^(and n), n !)$

]
#aside("Remark")[
$omega\(u\,v\)= g\(J u\,v\)$, $h = g - i omega$, $g\(u\,v\)= omega\(u\,J v\)$. Any one determines the other two. $omega$ corresponds to #emph[Kähler class]#index-entry("Kähler class") in $H^2\(M\,bb(R)\)$

]
#statement("Definition")[
A Hermitian manifold $M$ is a #emph[Kähler manifold]#index-entry("Kähler manifold") if $d omega = 0$, $omega$ is called the #emph[Kähler form]#index-entry("Kähler form"). A symplectic manifold $\(M\,omega\)$ with an almost complex structrue $J$ is a Kahler manifold if $omega\(J u\,J v\)= omega\(u\,v\)$ and $g\(u\,v\)= omega\(u\,J v\)$ is a Riemannian metric. An even dimensional Riemannian manifold $\(M\,g\)$ with an almost complex structure $J$ is a Kahler manifold if $g\(J u\,J v\)= g\(u\,v\)$ and $J$ is preserved by parallel transport, i.e. $nabla J = 0$

Since $omega$ is a real form, thus by Poincare's lemma, $omega = d alpha$ for some $alpha = beta + macron(beta)$, where $beta$ is a $\(1\,0\)$ form, then we have $partial beta = macron(partial) macron(beta) = 0$, hence $omega = partial macron(beta) + macron(partial) beta$, $beta = partial phi.alt$, $omega = partial macron(partial)\(macron(phi.alt) - phi.alt\)$. We have $partial_gamma h_(alpha macron(beta)) = partial_alpha h_(gamma macron(beta))$, $partial_(macron(gamma)) h_(alpha macron(beta)) = partial_(macron(beta)) h_(alpha macron(gamma))$, this implies at least locally $h_(alpha macron(beta)) = partial_alpha f_(macron(beta))$, and then $partial_alpha partial_(macron(gamma)) f_(macron(beta)) = partial_(macron(gamma)) partial_alpha f_(macron(beta)) = partial_(macron(beta)) partial_alpha f_(macron(gamma)) = partial_alpha partial_(macron(beta)) f_(macron(gamma))$, hence $h_(alpha macron(beta)) = partial_alpha partial_(macron(beta)) rho$, $rho$ is called the local #emph[Kähler potential]#index-entry("Kähler potential"), $rho$ is a Kähler potential if $omega = i / 2 partial macron(partial) rho$

]
#statement("Definition")[
Consider $L = omega and - : H^k\(M\)arrow.r H^(k + 2)\(M\)$, the #emph[primitive cohomology] is #display-equation($P^(n - k)\(M\)= ker (H^(n - k) \( M \) arrow.r^(L^(k + 1)) H^(n + k + 2) \( M \))$) The #emph[hard Lefschetz theorem] says #display-equation($H^n\(M\)= xor.big L^k P^(n - 2 k)\(M\)$)

]
#statement("Theorem", title: [Serre duality])[
#index-entry("Serre duality") $X$ is complex manifold of complex dimension $n$, $E arrow.r X$ is a holomorphic vector bundle, then we have #display-equation($H^i\(X\,E\)tilde.equiv H^(n - i)\(X\,K times.o E^(*)\)^(*)$) Where $K := and.big^n T^(*) X$ is the canonical bundle

For example, if $X$ is a Riemann surface, $E = cal(O)$, then $H^1\(X\,cal(O)\)tilde.equiv H^0\(X\,K times.o cal(O)\)^(*) tilde.equiv H^0\(X\,Omega\)^(*) = Omega\(X\)^(*)$

]#label("Serre duality")
== Symplectic manifold
<symplectic-manifold>
#statement("Definition")[
$M$ is a smooth manifold, a #emph[symplectic structure]#index-entry("Symplectic structure") on $M$ is a $2$ form $omega$ that is nondegenerate and anti-symmetric on $T_p M$

]
