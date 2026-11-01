#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Complex analysis

#statement("Definition")[
A #strong[polydisc]#index-entry("Polydisc") $D\(z\,r\)subset.eq bb(C)^n$ is $D\(z_1\,r_1\)times dots.h.c times D\(z_n\,r_n\)$

]
#statement("Definition", title: [Wirtinger derivatives])[
#display-equation($frac(partial, partial z) = 1 / 2 (frac(partial, partial x) - i frac(partial, partial y))\,frac(partial, partial macron(z)) = 1 / 2 (frac(partial, partial x) + i frac(partial, partial y))$)

]
#aside("Note")[
#display-equation($frac(partial, partial z) = frac(partial, partial x) frac(partial x, partial z) + frac(partial, partial y) frac(partial y, partial z)\,frac(partial, partial macron(z)) = frac(partial, partial x) frac(partial x, partial macron(z)) + frac(partial, partial y) frac(partial y, partial macron(z))$) #display-equation($d z and d macron(z) = - 2 i d x and d y$)

]
#statement("Definition")[
$f : Omega arrow.r bb(C)$ is #strong[holomorphic]#index-entry("Holomorphic") at $z_0 in Omega$ if $f'\(z\)$ exists around $z_0$. $f$ is #strong[univalent]#index-entry("Univalent") if $f$ is injective

]
#statement("Theorem", title: [Cauchy-Riemann equations])[
If we write $z = x + i y$, $f\(z\)= u\(x\,y\)+ i v\(x\,y\)$, then the existence of $f'\(z\)$ implies that $frac(partial f, partial x) = 1 / i frac(partial f, partial y)$ which give the #strong[Cauchy-Riemann equations]#index-entry("Cauchy-Riemann equations") #display-equation($cases(frac(partial u, partial x) = frac(partial v, partial y), frac(partial v, partial x) = - frac(partial u, partial y))$) If $f$ satisfies Cauchy-Riemann equations around $z_0$, then $f$ is holomorphic at $z_0$

]
#statement("Lemma")[
A univalent map is a biholomorphism to its image

]
#statement("Theorem", title: [Goursat])[
If $f$ is holomorphic on $Omega subset.eq bb(C)$, $overline(T) subset.eq Omega$ is a triangle, then $integral.cont_T f\(z\)d z = 0$

]
#statement("Theorem", title: [Cauchy's integral theorem])[
If $f$ is holomorphic on $Omega subset.eq bb(C)$, $gamma subset.eq Omega$ is a piecewise $C^1$ curve, then $integral.cont_gamma f\(z\)d z = 0$

]
#statement("Theorem", title: [Morera's theorem])[
$U subset.eq bb(C)$ is open, if $integral.cont_T f\(z\)d z = 0$ for any triangle $T subset.eq U$, then $f$ is holomorphic on $D$

]
#statement("Theorem", title: [Cauchy-Pompeiu formula])[
$f$ is a complex valued $C^1$ function on a disc $D subset.eq bb(C)$, then #display-equation($f\(zeta\)= frac(1, 2 pi i) integral_(partial D) frac(f\(z\)d z, z - zeta) - 1 / pi integral.double_D frac(partial f\(z\), partial macron(z)) frac(d x and d y, z - zeta)$) In particular, if $f$ is holomorphic, then #display-equation($f\(zeta\)= frac(1, 2 pi i) integral_(partial D) frac(f\(z\), z - zeta) d z$)

]#label("Cauchy-Pompeiu formula")
#proof(title: "Proof")[
Denote $D_epsilon.alt = D - B\(0\,epsilon.alt\)$, consider #display-equation($eta = frac(f\(w\)d w, w - z)\,d eta = frac(partial f\(w\), partial macron(w)) frac(d macron(w) and d w, w - z)$) By Stokes' theorem #display-equation($frac(1, 2 pi i) integral_(partial D_epsilon.alt) eta = frac(1, 2 pi i) integral_(D_epsilon.alt) d eta$) As $epsilon.alt arrow.br 0$ #display-equation($f\(zeta\)= frac(1, 2 pi i) integral_(partial D) frac(f\(w\)d w, w - z) + frac(1, 2 pi i) integral.double_D frac(partial f\(w\), partial macron(w)) frac(d w and d macron(w), w - z)$)

]
#statement("Lemma", title: [Osgood's lemma])[
$f$ is continuous on an open subset $Omega subset.eq bb(C)^n$ and holomorphic on each variable, then $f$ is holomorphic

]#label("Osgood's lemma")
#proof(title: "Proof")[
For each $a in Omega$, pick $P = D\(a\,r\)subset.eq Omega$, since $frac(partial f, partial macron(z)_j) equiv 0$ on $Omega$, fix $z_2\,dots.h.c\,z_n$, then #display-equation($f\(w_1\,z_2\,dots.h.c\,z_n\)= frac(1, 2 pi i) integral_(\|z_1 - a_1\|= r_1) frac(f\(z_1\,dots.h.c\,z_n\), z_1 - w_1) d z_1$) For $w_1 in D\(a_1\,r_1\)$, iterate and we get #display-equation($f\(w_1\,dots.h.c\,w_n\)= frac(1, \(2 pi i\)^n) integral_(\|z_1 - a_1\|= r_1) dots.h.c integral_(\|z_n - a_n\|= r_n) frac(f\(z_1\,dots.h.c\,z_n\), product\(z_j - w_j\)) d z_1 dots.h.c d z_n$) For $w in P$. Since $f$ is continuous, it is bounded on $overline(P)$, $frac(1, z_j - w_j) = sum_(m = 0)^oo frac(\(w_j - a_j\)^m, \(z_j - a_j\)^(m + 1))$ converges uniformly on compact subsets of $D\(a_j\,r_j\)$. Hence $f\(w\)= sum c_alpha\(w - a\)^alpha$, where #display-equation($c_alpha = frac(1, \(2 pi i\)^n) integral_(\|z_1 - a_1\|= r_1) dots.h.c integral_(\|z_n - a_n\|= r_n) frac(f\(z\), product\(z_j - a_j\)^(alpha_j + 1)) d z_1 dots.h.c d z_n$)

]
#statement("Corollary", title: [Cauchy inequality])[

]
#statement("Theorem", title: [Maximum principle])[

]#label("Maximum principle")
#statement("Theorem")[
${ f_n }$ are holomorphic on $Omega subset.eq bb(C)^n$, $f_n$ are uniformly convergent on each compact subset, then $f_n$ converges to a holomorphic function $f$, and $D^alpha f_n arrow.r D^alpha f$ on each compact subset

]
#statement("Theorem", title: [Montel's theorem])[
#index-entry("Montel’s theorem") $cal(F) = { f_n }$ are holomorphic on $Omega subset.eq bb(C)^n$ and locally uniformly bounded, i.e. for any $z_0 in Omega$, there exists a neighborhood $U$ and $M$ such that $sup_(z in K)\|f_n\|lt.eq M$, then $cal(F)$ is normal

]#label("Montel's theorem")
#statement("Lemma", title: [Schwarz lemma])[
#index-entry("Schwarz lemma") $f$ is holomorphic on the unit disc $D subset.eq bb(C)$, $f\(0\)= 0$ and $\|f\|lt.eq 1$ on $D$, then $\|f\(z\)\|lt.eq\|z\|$ and $\|f'\(0\)\|lt.eq 1$, if $\|f\(z\)\|=\|z\|$ for some nonzero $z$ or $\|f'\(0\)\|= 1$, then $f\(z\)= a z$, $a = f'\(0\)$

]#label("Schwarz lemma")
#proof(title: "Proof")[
Define $g\(z\)= frac(f\(z\), z)$, since $f\(0\)= 0$, $0$ is a removable singularity, since $\|f\(z\)\|lt.eq 1$, $\|g\(z\)\|lt.eq 1$ on $partial D$, by maximum principle #ref(label("Maximum principle"), supplement: none), $\|g\(z\)\|lt.eq 1$ on $D$, thus $\|f\(z\)\|lt.eq\|z\|$ on $D$ and $\|f'\(0\)\|=\|g\(0\)\|lt.eq 1$, if $\|f\(z\)\|=\|z\|$ for some nonzero $z$ or $\|f'\(0\)\|= 1$, then $g$ attains maximum within $D$, then $g equiv a$ for some $\|a\|= 1$, thus $f\(z\)= a z$

]
#statement("Corollary")[
$D arrow.r^f D$ is a biholomorphic, then $f = e^(i phi.alt) frac(z - a, 1 - macron(a) z)$ for some $phi.alt$ and $a in D$

]
#proof(title: "Proof")[
Denote $psi_a\(z\)= frac(z - a, 1 - macron(a) z)$, $psi_(- a)$ is the inverse of $psi_a$

Assume $f\(a\)= 0$, consider $g\(z\)= f compose psi_(- a)$, then $g\(0\)= 0$, by Schwarz lemma #ref(label("Schwarz lemma"), supplement: none), $g = e^(i phi.alt)$, $f = g compose phi.alt_a = e^(i psi) frac(z - a, 1 - macron(a) z)$

]
#statement("Lemma")[
Suppose $0 in U subset.neq D$ is a simply connected open set, there exists $U arrow.r^f D$ univalent such that $f\(0\)= 0$, $\|f'\(0\)\|> 1$. Note that this is impossible if $U = D$ due to Schwarz lemma #ref(label("Schwarz lemma"), supplement: none)

]#label("Lemma for Riemann mapping theorem")
#proof(title: "Proof")[
Denote $psi_a\(z\)= frac(z - a, 1 - macron(a) z)$, $psi'_a\(z\)= frac(1 -\|a\|^2, \(1 - macron(a) z\)^2)$. Consider $f = psi_(g\(a\)) compose g compose psi_(- a)$ with some $psi_(- a)\(U\)arrow.r^g D$ univalent, then $f\(0\)= 0$ #display-equation($f'\(0\)= frac(1 -\|g\(a\)\|^2, \(1 -\|g\(a\)\|^2\)^2) g'\(a\)\(1 -\|a\|^2\)= frac(1 -\|a\|^2, 1 -\|g\(a\)\|^2) g'\(a\)$) Since $U$ is simply connected, so is $psi_(- a)\(U\)$ given $- a in D\\U$, we can take $g\(z\)= sqrt(z)$ to be one branch, since $\|a\|< 1$, we get #display-equation($\|f'\(0\)\|= frac(1 -\|a\|^2, 1 -\|a\|) frac(1, 2 sqrt(\|a\|)) = frac(1 +\|a\|, 2 sqrt(\|a\|)) > 1$)

]
#statement("Lemma")[
$phi$ is holomorphic on $D$, $f$ is meromorphic on $D$ and $f eq.not 0$ on $partial D$, $a_1\,dots.h.c\,a_m$ and $b_1\,dots.h.c\,b_n$ are the zeros and poles of order $k_1\,dots.h.c\,k_m$ and $l_1\,dots.h.c\,l_n$ of $f$ in $D$, then #display-equation($frac(1, 2 pi i) integral_(partial D) phi\(z\)frac(f'\(z\), f\(z\)) d z = sum_(i = 1)^m k_i phi\(a_i\)- sum_(i = 1)^n l_i phi\(b_i\)$)

]#label("Lemma for finding zeros")
#proof(title: "Proof")[
$f\(z\)= g\(z\)product_(i = 1)^m\(z - z_i\)^(q_i)$ with $g eq.not 0$ on $overline(D)$, $z_i\,q_i$ could be $a_i\,k_i$ or $b_i\,- l_i$ depending on whether it is a zero or a pole, hence #display-equation($frac(1, 2 pi i) integral_(partial D) phi\(z\)frac(f'\(z\), f\(z\)) d z & = frac(1, 2 pi i) integral_(partial D) phi\(z\)frac(g'\(z\)product_(i = 1)^m\(z - z_i\)+ g\(z\)sum_(i = 1)^m product_(j eq.not i)\(z - z_j\), g\(z\)product_(i = 1)^m\(z - z_i\)) d z\
 & = frac(1, 2 pi i) integral_(partial D) [frac(phi\(z\)g'\(z\), g\(z\)) + sum_(i = 1)^m frac(phi\(z\), z - z_i)] d z\
 & = sum_(i = 1)^m k_i phi\(a_i\)- sum_(i = 1)^n l_i phi\(b_i\)$)

]
#statement("Theorem", title: [Rouché's theorem])[
#index-entry("Rouche’s theorem")

]#label("Rouche's theorem")
#statement("Theorem", title: [Hurwitz's theorem])[
#index-entry("Hurwitz’s theorem") $U subset.eq bb(C)$ is open connected, holomorphic functions ${ f_n }$ converges uniformly to $f$ on compact subsets of $U$ and $f equiv.not 0$, $f$ has order $m$ at $z_0$, for $r$ small enough, there exists $K$ such that for any $k gt.eq K$, $f_k$ has precisely $m$ zeros in $B\(z_0\,r\)$, counting multiplicities, and these zeros converge to $z_0$ as $k arrow.r oo$

]#label("Hurwitz's theorem")
#aside("Remark")[
$B\(z_0\,r\)$ can't be arbitrarily large. For example, $f_n\(z\)= z - 1 + 1 / n$ converges uniformly to $f\(z\)= z - 1$ on compact subsets, $f$ has no zeros in the unit disc $D$, but $f_n$ all have zeros in $D$

]
#proof(title: "Proof")[
For $r$ small enough, $f$ doesn't vanish on $partial B\(z_0\,r\)$ on which $\|f\|$ attains minimum, then apply Rouché's theorem #ref(label("Rouche's theorem"), supplement: none)

]
#statement("Corollary")[
$U$ is open connected, univalent maps ${ f_n }$ converges to $f$ on compact subsets, then $f$ is either univalent or constant

]
#proof(title: "Proof")[
If $f$ is not a constant and $f\(z_0\)= f\(w_0\)= zeta$, then $f\(z\)- xi$ has $z_0\,w_0$ as zeros, by Hurwitz's theorem #ref(label("Hurwitz's theorem"), supplement: none), there exist ${ z_k }\,{ w_k }$ converging to $z_0\,w_0$ such that $f_(n_k)\(z_k\)= f_(n_k)\(w_k\)= xi$, but $f_n$'s are univalent, hence $z_k = w_k arrow.r.double z_0 = w_0$, i.e. $f$ is univalent

]
#statement("Theorem", title: [Riemann mapping theorem])[
#index-entry("Riemann mapping theorem") $U subset.neq bb(C)$ is a nonempty simply connected open subset, $z_0 in U$,then there is a unique biholomorphism $f$ from $U$ to the unit disc such that $f\(z_0\)= 0$, $f'\(z_0\)> 0$

]#label("Riemann mapping theorem")
#proof(title: "Proof of uniqueness")[
Suppose $U arrow.r^(f_1\,f_2) D$ are biholomorphisms such that $f_i\(z_0\)= 0$, $f'_i\(z_0\)> 0$, consider $g = f_2 f_1^(- 1)$, $g\(0\)= 0$, $\|g\|lt.eq 1$ on $D$ and $g'\(0\)= frac(f'_2\(z_0\), f'_1\(z_0\)) > 0$, by Schwarz lemma #ref(label("Schwarz lemma"), supplement: none), $g\(z\)= z$, i.e. $f_1 = f_2$

]
#proof(title: "Proof of existence")[
Fix $a in.not U$, $z_0 in U$. Define #display-equation($cal(F) = {f upright(" univalent on ") U mid(bar.v) \| f \| lt.eq 1 \, f \( z_0 \) = 0}$) Since $U$ is simply connected, we can pick one branch $h\(z\)= sqrt(z - a)$, then $h\(U\)inter - h\(U\)= diameter$, $frac(h\(z\)- h\(z_0\), h\(z\)+ h\(z_0\))$ is univalent and bounded, scale to get some $f_0 in cal(F)$ $arrow.r.double$ $cal(F)$ is nonempty

Let $A = sup_(f in cal(F))\|f'\(z_0\)\|> 0$, $f'_n\(z_0\)arrow.r A$ for some ${ f_n } subset.eq cal(F)$, by Montel's theorem #ref(label("Montel's theorem"), supplement: none), $f_(n_k)$ converges to $g$ uniformly on compact subsets, then $\|g\|lt.eq 1$, $g\(z_0\)= 0$ and $0 < A =\|g'\(z_0\)\|< oo$, according to Hurwitz's theorem #ref(label("Hurwitz's theorem"), supplement: none), $g$ is also univalent, i.e. $g in cal(F)$ attains maximal derivative at $z_0$

Suppose $0 in g\(U\)subset.neq D$, if not, by Lemma #ref(label("Lemma for Riemann mapping theorem"), supplement: none), there exists univalent map $g\(U\)arrow.r^f D$ such that $f\(0\)= 0$, $\|f'\(0\)\|> 1$, then $f compose g in cal(F)$, but $\|\(f compose g\)'\(z_0\)\|=\|f'\(0\)g'\(z_0\)\|>\|g'\(z_0\)\|$ which is a contradiction

]
#aside("Remark")[
Suppose $f_1\,f_2 in cal(F)$ and $f_1$ is biholomorphic, then $g = f_2 f_1^(- 1)$ is a map $D arrow.r D$, with $g\(0\)= 0$, according to Schwarz lemma #ref(label("Schwarz lemma"), supplement: none), $frac(\|f'_2\(z_0\)\|, \|f'_1\(z_0\)\|) =\|g'\(0\)\|lt.eq 1$, and if $\|f'_2\(z\)\|=\|f'_1\(z\)\|$, $g = e^(i phi.alt)$, $f_2$ is also biholomorphic

]
#statement("Example")[
$U = bb(C) - { z gt.eq 0 }$, then $h\(z\)= sqrt(z)$ maps $U$ to the upper half plane

]
#statement("Theorem", title: [Runge's theorem])[
$K subset.eq bb(C)$ is compact, then $bb(C)\\K$ is the union of its connected components whereas the components are either bounded or not, denote

]
#statement("Theorem", title: [Hartogs's extension theorem])[
An isolated singularity is always a removable singularity when $n gt.eq 2$

]#label("Hartogs's extension theorem")
#proof(title: "Proof")[
It suffices to consider the case $P = {\|z_1\|lt.eq 1\,\|z_2\|lt.eq 1 }$ is a polydisc, $f$ is holomorphic on $partial P$, then $f$ is holomorphic on $P$

]
#statement("Lemma")[
$Omega subset.eq bb(C)^n$ is connected, $Omega arrow.r^f partial B^n$ is holomorphic, then $f equiv upright(c o n s t)$

]#label("Lemma for Remmert-Stein theorem")
#proof(title: "Proof")[
If $h$ is holomorphic, then $frac(partial^2, partial z partial macron(z))\|h\|^2 =\|h'\|^2$, hence #display-equation($0 = frac(partial^2, partial z partial macron(z))\|f\|^2 = sum_(i = 1)^n frac(partial^2, partial z partial macron(z))\|f_i\|^2 = sum_(i = 1)^n\|f'_i\(z\)\|^2 arrow.r.double f'_i\(z\)= 0 arrow.r.double f equiv upright(c o n s t)$)

]
#statement("Theorem", title: [Remmert-Stein])[
$U_1 subset.eq bb(C)^(n_1)\,U_2 subset.eq bb(C)^(n_2)$ are nonempty connected open subsets, $B = {\|z\|< 1 } subset.eq bb(C)^n$, then there is no proper holomorphic map $U_1 times U_2 arrow.r B$

]
#proof(title: "Proof")[
Suppose $f : U_1 times U_2 arrow.r B$ is a proper holomorphic map. For any $\(x\,y\)in U_1 times partial U_2$, there is a discrete sequence ${ y_nu } subset.eq U_2$ converging to $y$ as in Exercise #ref(label("U<R^n open, boundary point is the limit of some discrete sequence"), supplement: none), apply Lemma #ref(label("X,Y locally compact Hausdorff, f:X->Y proper, f send discrete sets to discrete sets"), supplement: none) to $f\(x\,y\): { x } times U_2 arrow.r B$, ${ f\(x\,y_nu\)}$ is discrete, thus there exists a subsequence ${ y_mu } subset.eq { y_nu }$ such that $f\(x\,y_mu\)$ such that $f\(x\,y\)= lim f\(x\,y_mu\)in partial B$. Then $f\(x\,y\): U_1 times { y } arrow.r partial B$ is a holomorphic, by Lemma #ref(label("Lemma for Remmert-Stein theorem"), supplement: none), $f\(x\,y\)$ is constant on $U_1 times { y }$, hence $U_1 times { y } subset.eq f^(- 1)\(f\(x\,y\)\)$ which is noncompact since it has noncompact image under projection to $U_1$. This contradicts the fact that $f$ is proper

]
#statement("Corollary", title: [Poincaré])[
The $2$ polydisc $P = {\|z_1\|< 1\,\|z_2\|< 1 }$ and the $2$ ball $B = {\|z_1\|^2 +\|z_2\|^2 < 1 }$ are not biholomorphic

]
#statement("Theorem", title: [Weierstrass preparation theorem])[
$f$ is analytic near $0$, $f\(0\)= 0$, $f\(z\)$ written as power series around $0$ has terms only involve $z_1$ which can always be achieved by a change of variables as in Exercise #ref(label("f analytic near 0, after change of variables, f has terms only involve one variable"), supplement: none), then $f = w h$, where $w\(z\)= z_1^k + g_(k - 1) z^(k - 1) + dots.h.c + g_0$ is a #strong[Weierstrass polynomial]#index-entry("Weierstrass polynomial"), i.e. $g_i\(z\)$ are analytic around $0$ and $g_i\(0\)= 0$, $h\(z\)$ is analytic around $0$ and $h\(0\)eq.not 0$

]
#statement("Theorem", title: [Weierstrass division theorem])[
Suppose $f\,g$ are analytic near $0$, $g$ is a Weierstrass polynomial of degree $k$, then there exist unique $h\,r$ such that $f = g h + r$, where $r$ is a polynomial of degree less than $k$

]
#statement("Definition")[
A conformal mapping is a map preserves angles and orientation

]
#aside("Note")[
Antiholomorphic map preserves angles but changes orientation

]
#statement("Definition")[
#strong[Möbius transformations]#index-entry("Möbius transformation") are $f\(z\)= frac(a z + b, c z + d)$, $mat(delim: "|", a, b; c, d) eq.not 0$, #strong[Möbius group] acts regularly on $bb(C) P^1$ and preserves cross ratio $\(z_0\,z_1\;z_2\,z_3\)= frac(\(z_2 - z_0\)\(z_3 - z_1\), \(z_3 - z_0\)\(z_2 - z_1\))$

]
#statement("Lemma", title: [Schwarz reflection principle])[
If $f$ is holomorphic on ${ upright(I m) z > 0 }$ and continuous on ${ upright(I m) z gt.eq 0 }$ with real values on $upright(I m) z = 0$, then it can be extended to $bb(C)$ with $f\(macron(z)\)= overline(f\(z\))$ for $upright(z) < 0$

]#label("Schwarz reflection principle")
#statement("Definition")[
$Lambda subset.eq bb(C)$ is a lattice. #emph[Weierstrass sigma function]#index-entry("Weierstrass sigma function") associated to lattice $Lambda$ is #display-equation($sigma\(z\)= z product_(omega in Lambda^(*)) (1 - z / omega) e^(z / omega + 1 / 2\(z / omega\)^2)$) #emph[Weierstrass zeta function]#index-entry("Weierstrass zeta function") is the logarithmic derivative of $sigma$ #display-equation($zeta\(z\)= frac(sigma'\(z\), sigma\(z\)) = 1 / z + sum_(omega in Lambda^(*)) frac(1, z - w) + 1 / w + z / w^2$) #emph[Weierstrass eta function]#index-entry("Weierstrass eta function") is #display-equation($eta\(w\)= zeta\(z + w\)- zeta\(z\)\,w in Lambda$) This is independent of choice of $z$

#emph[Weierstrass elliptic function]#index-entry("Weierstrass elliptic function") is #display-equation($℘\(z\)= - zeta'\(z\)= 1 / z^2 + sum_(omega in Lambda^(*)) (frac(1, \(z + omega\)^2) - 1 / omega^2)$) #display-equation($℘'\(z\)= - sum_(omega in Lambda) frac(2, \(z + omega\)^3)$)

]
