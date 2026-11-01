#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Real analysis

#statement("Definition", title: [Hyperbolic functions])[
$sin z = frac(e^(i z) - e^(- i z), 2 i)$, $cos z = frac(e^(i z) + e^(- i z), 2)$ $sinh z = - i sin\(i z\)= frac(e^z - e^(- z), 2)$, $cosh z = cos\(i z\)= frac(e^z + e^(- z), 2)$

]
#statement("Definition")[
$X$ is a convex set, $X arrow.r^f bb(R)$ is #strong[convex]#index-entry("Convex function") if $f\(t x +\(1 - t\)y\)lt.eq t f\(x\)+\(1 - t\)f\(y\)$ for $0 lt.eq t lt.eq 1$ and $x\,y in X$, $f$ is #strong[strictly convex] if $f\(t x +\(1 - t\)y\)< t f\(x\)+\(1 - t\)f\(y\)$ for $0 < t < 1$ and $x eq.not y in X$. $f$ is #strong[concave]#index-entry("Concave function") if $- f$ is convex

]
#statement("Definition")[
$X arrow.r^f\[- oo\,oo\]$ is #strong[upper semicontinuous]#index-entry("Semicontinuity") at $x$ if for any $y > f\(x\)$, there exists a neighborhood $U$ of $x$ such that $f\(U\)< y$, i.e. $f$ can only jump down at $x$. Thus $X arrow.r^f\[- oo\,oo\]$ is upper semicontinuous if ${ f < a }$ are open. $X arrow.r^f\[- oo\,oo\]$ is #strong[lower semicontinuous] if $- f$ is upper semicontinuous, i.e. $f$ can only jump up

#align(center)[
#universe-drawing(39.0)
#universe-drawing(40.0)
]
]
#statement("Lemma")[
${ f_alpha }_(alpha in A)$ is a family of upper semicontinuous functions, $f = inf_(alpha in A) f_alpha$ is also upper semicontinuous

]
#proof(title: "Proof")[
#display-equation(${ f < a } = union.big_(alpha in A) { f_alpha < a }$)

]
#statement("Lemma")[
$f$ is upper semicontinuous, $K$ is compact, then $f$ attains maximum over $K$

]
#statement("Definition")[
$Omega arrow.r^u\[- oo\,oo\)$ is #strong[harmonic]#index-entry("Harmonic") at $x in Omega$ if $u$ is continuous at $x$ and for any ball $B\(x\,r\)$, $u\(x\)= frac(1, \|B\(x\,r\)\|) integral_(B\(x\,r\)) u\(y\)d y$. $Omega arrow.r^u\[- oo\,oo\)$ is #strong[subharmonic]#index-entry("Subharmonic") at $x in Omega$ if $u$ is upper semicontinuous at $x$ and for any ball $B\(x\,r\)$, any continuous $v$ harmonic on $B\(x\,r\)$, $u lt.eq v$ on $partial B\(x\,r\)$ $arrow.r.double$ $u lt.eq v$ on $overline(B\(x\,r\))$. $Omega arrow.r^u\[- oo\,oo\)$ is #strong[superharmonic]#index-entry("Superharmonic") if $- u$ is subharmonic

Harmonic $arrow.l.r.double$ subharmonic and superharmonic

]
#statement("Lemma")[
$Omega arrow.r^u bb(R)$ is subharmonic, $bb(R) arrow.r^f bb(R)$ is convex, then $f compose u$ is also subharmonic

]
#statement("Example")[
If $f$ is holomorphic, then $log\|f\|$ is subharmonic

]#label("f holomorphic => log|f| subharmonic")
#statement("Lemma", title: [Vitali covering lemma])[
${ B_i }_(i in I)$ is a collection of balls in $bb(R)^d$ such that $sup_i B_i < oo$, then there exists a disjoint subcollection ${ B_j }_(j in J)$, $J subset.eq I$ such that $union.big_(i in I) B_i subset.eq union.big_(j in J) 5 B_j$

]
#proof(title: "Proof")[

]
#statement("Theorem", title: [Vitali covering theorem])[

]
#statement("Theorem", title: [Interpolation])[
If $f_n arrow.r f$ in $L^lambda inter L^mu$, $lambda < mu$, then $f_n arrow.r f$ in $L^p$ for $lambda < p < mu$

]
#proof(title: "Proof")[
Holder's inequality

]
