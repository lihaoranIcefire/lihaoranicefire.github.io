#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Partial differential equations

== Laplace's equation
<laplaces-equation>
== Heat equation
<heat-equation>
#statement("Definition")[
The fundamental solution to solution to #strong[heat equation]#index-entry("Heat equation") $u_t - Delta u = 0$ is #display-equation($E\(x\,t\)= cases(frac(1, \(4 pi t\)^(n / 2)) e^(- frac(\|x\|^2, 4 t)) quad t > 0, 0 quad t lt.eq 0)$)

]
#statement("Theorem")[
$U subset.eq bb(R)^n$ is open and bounded, $f in C_c^1\(U times\(0\,T\]\)$, then #display-equation($u\(x\,t\)= integral_(bb(R)^(n + 1)) E\(x - y\,t - s\)f\(s\,y\)d s d y$) Satisfies #display-equation($(frac(partial, partial t) - Delta) u\(x\,t\)= f\(x\,t\)$) Where $u$ is $C^1$ in $t$ and $C^2$ in $x$

]
#proof(title: "Proof")[
$E\(x\,t\)$ is supported in $t gt.eq 0$ and $integral_(bb(R)^n)\|nabla_x E\(x\,t\)\|d x lt.eq C / sqrt(t)$ if $t > 0$, so $nabla_x E\(x\,t\)$ is integrable near $\(0\,0\)$ #display-equation($nabla_x integral_(bb(R)^(n + 1)) E\(y\,s\)f\(x - y\,t - s\)d s d y & = integral_(bb(R)^(n + 1)) E\(y\,s\)nabla_x f\(x - y\,t - s\)d s d y\
 & = lim_(epsilon arrow.r 0) integral_epsilon^oo integral_(bb(R)^n) E\(y\,s\)nabla_x f\(x - y\,t - s\)d s d y\
 & = lim_(epsilon arrow.r 0) integral_epsilon^oo integral_(bb(R)^n)\(nabla E\)\(y\,s\)f\(x - y\,t - s\)d s d y\
 & = lim_(epsilon arrow.r 0) integral_(bb(R)^(n + 1))\(nabla E\)\(y\,s\)f\(x - y\,t - s\)d s d y$) And #display-equation($Delta integral_(bb(R)^(n + 1)) E\(y\,s\)f\(x - y\,t - s\)d s d y & = integral_(bb(R)^(n + 1))\(nabla E\)\(y\,s\)dot.op\(nabla f\)\(x - y\,t - s\)d s d y\
 & = lim_(epsilon arrow.r 0) integral_epsilon^oo\(nabla E\)\(y\,s\)dot.op\(nabla f\)\(x - y\,t - s\)d s d y$) And #display-equation($(frac(partial, partial t) - Delta) integral_(bb(R)^(n + 1)) E\(y\,s\)f\(x - y\,t - s\)d s d y & = - lim_(epsilon arrow.r 0) integral_epsilon^oo integral_(bb(R)^n)\(nabla E\)\(y\,s\)dot.op\(nabla f\)\(x - y\,t - s\)d s d y\
 & quad + lim_(epsilon arrow.r 0) integral_epsilon^oo integral_(bb(R)^n) E\(y\,s\)frac(partial f, partial x)\(x - y\,t - s\)d s d y\
 & = lim_(epsilon arrow.r 0) integral_epsilon^oo integral_(bb(R)^n) (frac(partial, partial s) - Delta_y) E\(y\,s\)f\(x - y\,t - s\)d s d y\
 & quad + lim_(epsilon arrow.r 0) integral_(bb(R)^n) E\(y\,epsilon\)f\(x - y\,t - epsilon\)d s d y\
 & = f\(x\,t\)$) Next, let $u in C^2 (U times \( 0 \, T \])$ and $u_t - Delta u = 0$, $chi in C^oo$, $chi\(x\,t\)= 1$ if $d\(\(x\,t\)\,Gamma_U\)gt.eq 2$, $chi\(x\,t\)= 0$ if $d\(\(x\,t\)\,Gamma_U\)lt.eq epsilon$ and $\(x\,t\)in U times\(0\,T\]$, apply the previous argument to $f\(x\,t\)= (frac(partial, partial t) - Delta)\(chi\(x\,t\)u\(x\,t\)\)= ((frac(partial, partial t) - Delta) chi \( x \, t \)) u - 2 nabla chi dot.op nabla u in C_c^1\(U times\(0\,T\]\)$, we get #display-equation($(frac(partial, partial t) - Delta) (chi \( x \, t \) u \( x \, t \) - integral_(- oo)^t integral_(bb(R)^n) E \( x - y \, t - s \) f \( y \, s \)) = 0$) And #display-equation($u\(x\,t\)chi\(x\,t\)- integral_(- oo)^t E\(x - y\,t - s\)f\(y\,s\)d s d y = 0$) if $t = 0$, so if $0 lt.eq t lt.eq T$ #display-equation($chi\(x\,t\)u\(x\,t\)= integral_(- oo)^t integral_(bb(R)^n) E\(x - y\,t - s\)(frac(partial, partial t) - Delta)\(chi\(y\,s\)u\(y\,s\)\)d s d y$)

]
== Wave equation
<wave-equation>
#statement("Definition")[
The fundamental solution to #strong[wave equation]#index-entry("Wave equation") $square.stroked u = (frac(partial^2, partial t^2) - Delta) u = 0$ is #display-equation($E\(x\,t\)= cases(frac(1, 2 pi^(frac(n - 1, 2))) chi_(+)^(frac(1 - n, 2))\(t^2 -\|x\|^2\)quad t > 0, 0 quad t < 0)$)

]
#statement("Theorem")[
$f in C^2\(bb(R)^3\)$, $u\(x\,t\)= frac(1, 4 pi t) integral_(partial B\(x\,t\)) f\(y\)d S_y = frac(t, 4 pi) integral_(S^2) f\(x + t w\)d S_w$, then $u in C^2 (bb(R)^3 times \[ 0 \, oo \))$, $u\(x\,0\)= 0$, $frac(partial, partial t)\|_(t = 0) u\(x\,t\)= f\(x\)$ and $square.stroked u = 0$ for $t > 0$

]
#proof(title: "Proof")[
#display-equation($frac(partial, partial t) u\(x\,t\) & = frac(1, 4 pi) integral_(S^2) f\(x + t w\)d S_w + frac(t, 4 pi) integral_(S^2)\(w dot.op nabla\)f\(x + t w\)d S_w\
 & = frac(1, 4 pi) integral_(S^2) f\(x + t w\)d S_w + frac(1, 4 pi t) integral_(partial B\(x\,t\)) n dot.op nabla f\(y\)d S_y\
 & = frac(1, 4 pi) integral_(S^2) f\(x + t w\)d S_w + frac(1, 4 pi t) integral_(B\(x\,t\)) Delta f\(y\)d y$) Thus #display-equation($frac(partial^2, partial t^2) u\(x\,t\) & = frac(1, 4 pi) integral_(S^2)\(w dot.op nabla\)f\(x + t w\)d S_w - frac(1, 4 pi t^2) integral_(B\(x\,t\)) Delta f\(y\)d y\
 & quad + frac(1, 4 pi t) frac(d, d t) integral_0^t integral_(S^2) lambda^2 Delta f\(x + lambda w\)d S_w d lambda\
 & = frac(1, 4 pi t^2) integral_(B\(x\,t\)) Delta f\(y\)d y - frac(1, 4 pi t^2) integral_(B\(x\,t\)) Delta f\(y\)d y\
 & quad + frac(t, 4 pi) integral_(S^2) Delta f\(x + lambda w\)d S_w\
 & = frac(1, 4 pi t) integral_(partial B\(x\,t\)) Delta f\(y\)d S_y\
 & = Delta u\(x\,t\)$)

]
#statement("Theorem")[
$f in C^2\(bb(R)^2\)$, then $u\(x\,t\)= frac(1, 2 pi) integral_(\|y\|< t) 1 / sqrt(t^2 -\|y\|^2) f\(x - y\)d y$ solves $square.stroked u = 0$ for $t > 0$, $u\(x\,0\)= 0$, $u_t\(x\,0\)= f$

]
#proof(title: "Proof")[
Consider $f : bb(R)^3 arrow.r bb(R)$, $f\(x_1\,x_2\,x_3\)= f\(x_1\,x_2\)$ is independent of $x_3$, then $u\(x\,t\)= frac(1, 4 pi t) integral_(partial B\(x\,t\)) f\(y\)d y = frac(1, 4 pi t) integral_(partial B\(0\,t\)) f\(x - y\)d S_y$ #display-equation($y_3 = plus.minus sqrt(t^2 - y_1^2 - y_2^2) = gamma\(y\)\,d s = sqrt(1 +\|nabla gamma\(y\)\|^2) d y_1 d y_2 = frac(t, t^2 - y_1^2 - y_2^2)\,upright("upper + lower hemisphere")$) $= frac(2, 4 pi t) integral_(\|\(y_1\,y_2\)\|< t) f\(x - y\)frac(t d y_1 d y_2, sqrt(t^2 -\|\(y_1\,y_2\)\|^2)) = frac(1, 2 pi) integral_(\|y\|< t) 1 / sqrt(t^2 -\|y\|^2) f\(x - y\)d y$

]
#statement("Theorem")[
$f in C^oo\(bb(R)^n times\[0\,oo\)\)$, $u\(x\,t\)= integral_0^t E\(dot.op\,t - s\)* f\(dot.op\,s\)d s$, then $square.stroked u = f$, $u\(x\,0\)= u_t\(x\,0\)= 0$

]
#proof(title: "Proof")[
Define $u\(x\,t\,s\)= E\(dot.op\,t - s\)* f\(dot.op\,s\)in C^oo$ for $t > s$ #display-equation($frac(partial, partial t) u\(x\,t\) & = u\(x\,t\,t\)+ integral_0^t frac(partial, partial t) u\(x\,t\,s\)d s\
 & = integral_0^t frac(partial, partial t) u\(x\,t\,s\)d s$) #display-equation($frac(partial^2, partial t^2) u\(x\,t\) & = integral_0^t frac(partial^2, partial t^2) u\(x\,t\,s\)d x + frac(partial, partial t)\|_(t = s) u\(x\,t\,s\)\
 & = f\(x\,t\)+ integral_0^t frac(partial^2, partial t^2) u\(x\,t\,s\)d x$) Thus $(frac(partial^2, partial t^2) - Delta) u\(x\,t\)= f\(x\,t\)+ integral_0^t (frac(partial^2, partial t^2) - Delta) u\(x\,t\,s\)d x$, the second term is zero for $s < t$

By the same argument, $square.stroked integral_(- oo)^t E\(dot.op\,t - s\)* f\(dot.op\,s\)d s = f\(dot.op\,t\)$, thus $Delta E = delta_(\(x\,t\))$ is the fundamental solution

]
#statement("Lemma")[
The solution to $square.stroked u = 0$ in $t > 0\,x > 0$ with $u\(0\,t\)$ for all $t > 0$, $u\(x\,0\)= 0$, $u_t\(x\,0\)= f\(x\)$, $f in C^1\(\[0\,oo\)\)$, $f\(0\)= 0$ is #display-equation($u\(x\,t\)= 1 / 2 integral_(\|t - x\|)^(t + x) f\(lambda\)d lambda$)

]#label("1 dim wave equation reflection")
#proof(title: "Proof")[
Define $tilde(f) : bb(R) arrow.r bb(R)$, $tilde(f)\(x\)= cases(f\(x\)quad x gt.eq 0, - f\(- x\)quad x < 0)$ which solves $square.stroked tilde(u) = 0$ for $t > 0\,x in bb(R)$, $tilde(u)\(x\,0\)= 0$, $tilde(u)_t\(x\,0\)= tilde(f)$, hence #display-equation($tilde(u)\(x\,t\)= 1 / 2 integral_(x - t)^(x + t) tilde(f)\(lambda\)d lambda = 1 / 2 integral_(\|x - t\|)^(x + t) f\(lambda\)d lambda$)

]
#statement("Lemma")[
$f\(x\)= f\(\|x\|\)$ is spherical symmetric in $bb(R)^n$, then $\(Delta f\)\(x\)= (frac(partial^2, partial r^2) + frac(n - 1, r) frac(partial, partial r)) f$

]#label("Laplacian of a spherical symmetric function")
#proof(title: "Proof")[
$Delta u$ is characterized by #display-equation($integral_(bb(R)^n) nabla u dot.op nabla v d x = - integral_(bb(R)^n) v Delta u\,forall v in C_c^oo\(bb(R)^n\)$) If $u\(x\)= u\(\|x\|\)$, $v\(x\)= v\(\|x\|\)$ #display-equation($integral_(bb(R)^n) nabla u dot.op nabla v d x & = integral_(S^(n - 1)) integral_0^oo frac(partial u, partial r) frac(partial v, partial r) d r d S_w\
 & = - integral_(S^(n - 1)) integral_0^oo 1 / r^(n - 1) frac(partial, partial r) (r^(n - 1) frac(partial u, partial r)) v\(r\)r^(n - 1) d r d S_w\
 & = - integral_(bb(R)^n) 1 / r^(n -) frac(partial, partial r) (r^(n - 1) frac(partial u, partial r)) v\(r\)d x\
 & = - integral_(bb(R)^n) (frac(n - 1, r) frac(partial, partial r) + frac(partial^2, partial r^2)) u v\(r\)d x$) Note that $1 / r^(n - 1) frac(partial, partial r) (r^(n - 1) frac(partial u, partial r)) = frac(n - 1, r) frac(partial u, partial r) + frac(partial^2 u, partial r^2)$

]
#statement("Theorem")[
The solution to $square.stroked u = 0$ in $bb(R)^(3 + 1)$ with $u\(x\,0\)= 0$, $u_t\(x\,0\)= f\(x\)= f\(\|x\|\)$, $f in C^oo\(bb(R)^3\)$ is #display-equation($u\(x\,t\)= frac(1, 2\|x\|) integral_(t -\|x\|)^(t +\|x\|) lambda f\(lambda\)d lambda$)

]
#proof(title: "Proof")[
By Lemma #ref(label("Laplacian of a spherical symmetric function"), supplement: none), when $n = 3$, $(frac(partial^2, partial r^2) + 2 / r frac(partial, partial r)) u = frac(1, partial r) frac(partial^2, partial r^2)\(r u\)$, thus if $square.stroked u = 0$ in $bb(R)^(3 + 1)$, $u\(x\,t\)= u\(\|x\|\,t\)$, then $(frac(partial^2, partial t^2) - frac(partial^2, partial r^2))\(r u\(r\,t\)\)= 0$ and $r u\(r\,t\)= 0$ if $r = 0$, $frac(partial, partial t)\|_(t = 0)\(r u\(r\,t\)\)= r f\(r\)$, by Lemma #ref(label("1 dim wave equation reflection"), supplement: none), $r u\(r\,t\)= 1 / 2 integral_(\|t - r\|)^(t + r) lambda f\(lambda\)d lambda$. We can check $u in C^1$

]
#statement("Theorem", title: [Energy estimate version 1])[
$square.stroked u = 0$ for $t > 0$, then the energy $1 / 2 integral_(bb(R)^n)\|u_t\|^2 +\|nabla u\|^2 d x$ is a constant

]
#statement("Theorem", title: [Energy estimate version 2])[
$square.stroked u = 0$ in $U_T = U times\(0\,T\]$, $u = 0$ on $Gamma_U$, $u_t\(x\,0\)= 0$, implicitly, $u_t = 0$ on $partial U times\[0\,T\]$, then $1 / 2 integral_(bb(U))\|u_t\|^2 +\|nabla u\|^2 d x$ is a constant

]
#statement("Theorem", title: [Energy estimate version 3])[
$C = {\( x \, t \) in bb(R)^(n + 1) mid(bar.v) \| x - x_0 \| lt.eq \| t - t_0 \|}$ is the cone, $D_t = {x in bb(R)^n mid(bar.v) \| x - x_0 \| lt.eq \| t - t_0 \|}$ is the section at time $t$, considet the case $t < t_0$, then $1 / 2 integral_(bb(D)_t)\|u_t\|^2 +\|nabla u\|^2 d x$ is decreasing on $0 lt.eq t lt.eq t_0$

]
== Euler-Lagrange equation
<euler-lagrange-equation>
== Energy momentum tensor
<energy-momentum-tensor>
#statement("Definition")[
$nabla$ is the gradient, write $nabla^T nabla = nabla dot.op nabla = Delta$ is the laplacian, $nabla dot.op 1 = upright(d i v)$ is the divergence, $nabla nabla^T = D^2$ is the Hessian

]
#statement("Definition")[
$L\(z\,q\): bb(R) times bb(R)^n arrow.r bb(R)$ is $C^oo$, $u$ satisfies Euler-Langrange equation, then #display-equation($nabla_x L\(u\,nabla u\) & = frac(partial L, partial z) nabla u +\(nabla nabla^T u\)\(nabla_q L\)\
 & =\(nabla_x dot.op nabla_q L\)\(nabla u\)+\(nabla nabla^T u\)\(nabla_q L\)\
 & =\(nabla^T u nabla_q L\)nabla_x$) #strong[Energy-momentum tensor]#index-entry("Energy-momentum tensor") $T_(alpha beta) = frac(partial u, partial x^alpha) frac(partial L, partial q_beta) - delta_(alpha beta) L$, $T = nabla^T u nabla_q L - L 1$, then $T nabla_x =\(nabla^T nabla_q L\)nabla_x - nabla_x L = 0$

]
#statement("Example")[
$u_(t t) - Delta u + u^3 = 0$, $L\(u\,nabla_(x\,t) u\)= 1 / 2\(u_t^2 -\|nabla_x u\|^2\)- 1 / 4 u^4$, $T_00 = u_t^2 - [1 / 2 \( u_t^2 - \| nabla u \|^2 \) - 1 / 4 u^4] = 1 / 2\(u_t^2 +\|nabla u\|^2\)+ 1 / 4 u^4$, $T_(0 i) = - u_t frac(partial u, partial x^i)$, thus $0 =\(T_00\,dots.h.c\,T_(0 n)\)nabla_x = upright(d i v)\(T_00\,dots.h.c\,T_(0 n)\)$

]
