#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Riemann surface

#statement("Definition")[
A #strong[Riemann surface]#index-entry("Riemann surface") is a one dimensional complex manifold

]
#statement("Theorem", title: [Riemann's removable singularity theorem])[
$f$ is holomorphic on $X\\{ a }$ and bounded near $a$, then $f$ is holomophic on $X$

]
#statement("Theorem", title: [Principle of analytic continuation])[
$X$ is connected, $X arrow.r^f Y$ is holomorphic and $f equiv c$ on some nondiscrete subset of $X$, then $f equiv c$ on $X$

]
#aside("Remark")[
This does not apply to higher dimensions, for example, $f\(z\,w\)= z$, but in higher dimensions, we have Theorem #unresolved-reference("Identity principle")

]
#statement("Theorem", title: [Local behaviour of holomorphic maps])[
$X arrow.r^f Y$ is a nonconstant holomorphic map, $a in X$, $f\(a\)= b in Y$. There are local charts $U arrow.r^phi.alt bb(C)$, $V arrow.r^psi bb(C)$ of $a\,b$ such that $psi f phi.alt^(- 1) = z^k$ for some $k gt.eq 1$

]
#aside("Remark")[
If the #strong[multiplicity] $k > 1$, $a$ is a #strong[branch point]#index-entry("Branch point")

]
#statement("Theorem")[
$X arrow.r^f Y$ is a proper nonconstant holomorphic map between Riemann surfaces, there exists some $n$ such that $f$ take every value $c in Y$, counting multiplicities, $n$ times

]
#statement("Theorem", title: [Radó's theorem])[
A connected Riemann surface is second countable

]
#statement("Theorem", title: [Uniformization theorem])[
#index-entry("Uniformization theorem") A simply connected Riemann surface is either $bb(C)$, $bb(P)$ or $bb(H)^2$

]#label("Uniformization theorem")
