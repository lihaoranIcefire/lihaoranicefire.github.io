#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Hodge structure

Use $H_(bb(F))$ or $H\(bb(F)\)$ to indicate coefficients in $bb(F)$

#statement("Definition")[
An abelian group $H_(bb(Z))$ has a #emph[pure Hodge structure]#index-entry("Pure Hodge structure") of weight $n$ if #display-equation($H_(bb(C)) = xor.big_(p + q = n) H^(p\,q)\,quad overline(H^(p\,q)) = H^(q\,p)$) Or equivalently, if there is a decreasing #emph[Hodge filtration] $F^p$ on $H_(bb(C))$ such that $H_(bb(C)) = F^p xor overline(F^(n + 1 - p))$. The equivalence of the two definitions is given by ($p + q = n$) #display-equation($F^p = xor.big_(i gt.eq p) H^(i\,n - i)\,quad overline(F^q) = xor.big_(j lt.eq p) H^(j\,n - j)$) #display-equation($H^(p\,q) = F^p inter overline(F^q)\,quad F^p inter overline(F^(n + 1 - p)) = 0$)

]
#statement("Example")[
$X$ is a complex manifold, $H_(bb(Z)) = H^n\(X\;bb(Z)\)$, then #display-equation($H^n\(X\;bb(C)\)= xor.big_(p + q = n) H^(p\,q) = xor.big_(p + q = n) H^p\(X\;bb(C)\)and overline(H^p\(X\;bb(C)\))$)

]
#statement("Example", title: [#emph[Tate-Hodge structure]])[
$bb(Z)\(1\)=\(2 pi i\)bb(Z)$ has a pure Hodge structure of weight -2 such that $bb(Z)\(1\)_(bb(C)) = H^(- 1\,- 1)$, this is the unique one dimensional weight -2 pure Hodge structure($H^(- 2\,0) = overline(H^(0\,- 2))$ should be 0 or nonzero at the same time). $bb(Z)\(n\):= bb(Z)\(1\)^(times.o n)$

]
#statement("Definition")[
A #emph[polarization] over $bb(Q)$ of a Hodge structure over $bb(Q)$ of weight $k$ is a $\(- 1\)^k$ symmetric nondegenerate flat bilinear map $beta : bb(V)_(bb(Q)) times bb(V)_(bb(Q)) arrow.r bb(Q)$ such that the Hermitian form $beta_x\(C_x v\,macron(w)\)$ on each fiber $cal(V)_x$ is positive definite, here $C_x$ is the #emph[Weil operator], given as the direct sum of multiplication $i^(p - q)$ on $H_x^(p\,q)$

]
#statement("Definition")[
A #emph[mixed Hodge structure]#index-entry("Mixed Hodge structure") on $H_(bb(Z))$ consists of an increasing #emph[weight filtration] $W_bullet$ on $H_(bb(Q))$ and a decreasing filtration $F^bullet$ on $H_(bb(C))$ that are compatible, i.e. #display-equation($F^p\("gr"_k W\)_(bb(C)) = frac(F^p inter W_(k + 1)\(bb(C)\)+ W_k\(bb(C)\), W_k\(bb(C)\))$) is a pure Hodge structure of weight $k$ of $"gr"_k W$

]
#statement("Definition")[
A #emph[variation] of Hodge structure of weight $k$ over $bb(Q)$ and a complex manifold $X$ is $\(bb(V)_(bb(Q))\,cal(F)^bullet\)$, $bb(V)_(bb(Q))$ is a locally constant sheaf of $bb(Q)$ vector spaces, $cal(F)^bullet$ is a decreasing filtration of holomorphic subbundles of the locally free sheaf $cal(V) = cal(O)_X times.o bb(V)_(bb(Q))$ such that

- $\(cal(V)_x\,cal(F)_x^bullet\)$ has a pure Hodge structure of weight $k$, i.e. $cal(V)_x = cal(F)^p xor overline(cal(F)^(k + 1 - p))$

- \(Griffiths transversality) $nabla cal(F)^p subset.eq Omega_X^1 times.o_(cal(O)_X) cal(F)^(p - 1)$

]
#statement("Definition")[
A variation of mixed Hodge structure over $bb(Q)$ and a complex manifold $X$ is $\(bb(V)_(bb(Q))\,cal(W)_bullet\,cal(F)^bullet\)$, $cal(W)_bullet$ is an increasing filtration of $bb(V)_(bb(Q))$ by locally constant subsheaves such that

- $\(cal(V)_x\,\(cal(W)_bullet\)_x\,cal(F)_x^bullet\)$ has a mixed Hodge structure, i.e. $\(\)$ is a pure Hodge structure of weight $k$

- $nabla cal(F)^p subset.eq Omega_X^1 times.o_(cal(O)_X) cal(F)^(p - 1)$

]
#aside("Remark")[
Given a locally constant sheaf is equivalent to given a monodromy representation $rho_(upright(bold(x))) : pi_1\(X\,upright(bold(x))\)arrow.r "Aut"_(bb(Q))\(cal(V)_x\)$. A variation is #emph[unipotent] if the the monodromy representation is unipotent

]
#statement("Theorem", title: [Deligne])[
$tilde(X)$ is a normalization of $X$, $\(bb(V)_(bb(Q))\,cal(W)_bullet\,cal(F)^bullet\)$ is a unipotent variation of mixed Hodge structure of weight $k$, then there is a unique extension $cal(tilde(V))$ over $tilde(X)$ such that

- Inside every section of $cal(tilde(V))$, flat sections increase at most at the rate of $O\(log\(parallel x parallel^k\)\)$ on each compact set of $tilde(X) - X$

- Every flat section of $cal(V)^or$ increases at most at the rate of $O\(log\(parallel x parallel^k\)\)$

These conditions are equivalent to

- In a local basis of $cal(tilde(V))$, the connection matrix $bold(omega)$ of $cal(V)$ has at most logarithmic singularities along $tilde(X) - X$

- The residue of $bold(omega)$ along any irreducible component of $tilde(X) - X$ is nilpotent

]#label("Deligne's theorem on unipotent VMHS")
For smooth complex vector bundle $E$. Dolbeault operators are $macron(partial)_E : Omega^(p\,q)\(E\)arrow.r Omega^(p\,q + 1)\(E\)$ satisfying Leibniz. By Newlander-Nirenberg, $E$ has a unique holomorphic structure iff $macron(partial)_E$ is the unique Dolbeault operator

For a holomorphic complex vector bundle $E$ with a Hermitian metric $h$, the Chern connection is the unique metric connection such that the $\(0\,1\)$ part of $nabla s$ is $macron(partial)_E s$. The connection form is $h^(- 1) partial h$

#statement("Definition")[
A harmonic differential $omega = A d x + B d y$ is the real part of an analytic complex differential, then we can define its conjugate $* omega = A d y - B d x$, which should be the imaginary part, we may think of $*$ as the Hodge star operator. Note that the complex form should have been $\(A - i B\)\(d x + i d y\)$. Thus $omega$ is a harmonic differential iff $d omega = d * omega = 0$, $d * d u = Delta u d x and d y$ gives the Laplacian

]
Let $Delta = d d^(*) + d^(*) d$ be the Laplacian, then the following are equivalent(very easy to check): $Delta alpha = 0$, $d alpha = d^(*) alpha = 0$, $alpha in ker d inter\("im" d\)^perp$, such forms are called harmonic forms

There is a unique harmonic representative for each cohomology class, which happen to be of the smallest norm, consider the isomorphism(very easy to check) $ker d inter\("im" d\)^perp arrow.r H^k$, suppose $alpha in ker d inter\("im" d\)^perp$, then $\|alpha + partial beta\|^2 =\|alpha\|^2 +\|partial beta\|^2 gt.eq\|alpha\|^2$, equality holds iff $partial beta = 0$
