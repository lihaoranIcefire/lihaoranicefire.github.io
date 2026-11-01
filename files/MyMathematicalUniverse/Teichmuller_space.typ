#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Teichmuller space

Let $S_(g\,b\,n\,m)$ be the surface with genus $g$, $b$ boundaries, $n$ punctures inside and $m$ punctures on the boundaries. Then #display-equation($chi\(S_(g\,b\,n\,m)\)=\(1 + b\)-\(2 g + 2 b + n + m\)+ 1 = 2 - 2 g - b - n - m$)

#statement("Definition")[
Suppose $"Aut"\(X\)$ has a natural topology, the mapping class group is $"Aut"\(X\)\/"Aut"_0\(X\)$, where $"Aut"_0\(X\)$ is the path connected component of the identity, hence we have exact sequence #display-equation($0 arrow.r "Aut"_0\(X\)arrow.r "Aut"\(X\)arrow.r "MCG"\(X\)arrow.r 0$) If $X$ is a space, then a path connecting $f\,g in "Aut"\(X\)$ is an isotopy

]
#statement("Example")[
$"MCG"\(S^2\)= bb(Z)\/2 bb(Z)$

]
#statement("Definition")[
Let $S$ be a compact surface with finitely many holes, $X$ be a surface with a complete, finite area hyperbolic metric. A #emph[hyperbolic structure] on $S$ is a diffeomorphism $phi.alt : S arrow.r X$, $phi.alt$ is called a #emph[marking], $\(X\,phi.alt\)$ is a marked hyperbolic surface. $\(X\,phi.alt\)$, $\(Y\,psi\)$ are equivalent if there is an isometry $i : X arrow.r Y$ such that $i compose phi.alt$ and $psi$ are homotopic

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$S$]),
node((0,1),[$X$]),
node((2,1),[$Y$]),
edge((1,0),(0,1),"->",[$phi.alt$]),
edge((1,0),(2,1),"->",[$psi$]),
edge((0,1),(2,1),"->",[$i$]))]
]
The Teichmuller space of $S$ is #display-equation($T\(S\)= {\(X\,phi.alt\)}\/tilde.op$)

]
#statement("Definition", title: [Change of marking])[
$f : S arrow.r S$ is a homeomorphism

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$S$]),
node((0,1),[$X$]),
node((2,1),[$Y$]),
edge((1,0),(0,1),"->",[$phi.alt$]),
edge((1,0),(2,1),"->",[$psi$]),
edge((1,0),(2,0),"->",[$f$]),
edge((0,1),(2,1),"->",[$psi compose f compose phi.alt^(- 1)$]))]
]
When $f = 1_S$, $psi compose phi.alt^(- 1)$ is the #emph[change of marking] The mapping class group left acts on $T\(S\)$ by $h dot.op\(X\,f\)=\(X\,f h^(- 1)\)$, then $T\(S\)$ mod the action is just $S$

]
#statement("Example")[
By Uniformization theorem #ref(label("Uniformization theorem"), supplement: none), $T\(bb(S)^2\)$ is a point corresponds to the Riemann sphere, $T\(bb(R)^2\)$ is two points corresponds the complex plane and the unit disc. $T\(A\)=\[0\,1\)$, where $A$ is the open annulus, and $lambda in\[0\,1\)$ corresponds to ${ lambda <\|z\|< lambda^(- 1) }$ according to Exercise #ref(label("Complex structures on an open annulus"), supplement: none)

]
By Gauss-Bonnet theorem, it is necessary that a closed hyperbolic surface $X$ has area $upright("Area")\(X\)= - integral_X K d S = - 2 pi chi\(X\)$ since the Gaussian curvature $K$ is $- 1$. Similarly, by Gauss-Bonnet theorem, it is reasonable to consider flat structures on the torus $T^2$, by modulo homothety, we may just assume it has unit area. Thus let's define $T\(T^2\)$ as the isotopy classes of unit-area flat structures on $T^2$, i.e. markings $T^2 arrow.r bb(T)^2$. Similarly, $T\(S^2\)$ should be defined to be the unique induced metric on the unit sphere $bb(S)^2$

A marking on a lattice $Lambda$ in $bb(R)^2$ is an ordered pair of generators, two marked lattices are equivalent if they transitive under $"Isom"\(bb(R)^2\)$. Marked lattices in $bb(R)^2$ are in bijection with the upper half plane $bb(H)^2$ as follows: $bb(Z) + bb(Z) tau arrow.l.r tau$. note that $bb(Z) lambda + bb(Z) mu tilde.op bb(Z) + bb(Z) mu / lambda$ by homothety, $bb(Z) + bb(Z) tau tilde.op bb(Z) + bb(Z) macron(tau)$ by reflection

#statement("Proposition")[
$T\(T^2\)$ is in bijection $bb(H)^2$, this induces a hyperbolic metric on $T\(T^2\)$ so that $T\(T^2\)tilde.equiv bb(H)^2$

]
#proof(title: "Proof")[
It suffices to show that $T\(T^2\)$ is in bijection with equivalence classes of marked lattices in $bb(R)^2$. $bb(R)^2$ is the metric universal cover of $bb(T)^2$ \ Given a marked lattice $bb(Z) + bb(Z) tau$, $tau in bb(H)^2$, using homothety, we get an equivalent lattice $bb(Z) lambda + bb(Z) mu$ with unit area, we can simply take the marking to be the map induced by the linear map $bb(R)^2 arrow.r bb(R)^2$, taking $bb(Z) + bb(Z) i$ to $bb(Z) lambda + bb(Z) mu$ \ For any marking $phi.alt : T^2 arrow.r bb(T)^2$, we have the following diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(R)^2$]),
node((1,0),[$bb(R)^2$]),
node((0,1),[$T^2$]),
node((1,1),[$bb(T)^2$]),
edge((0,0),(0,1),"->",[$pi$]),
edge((0,0),(1,0),"->",[$tilde(phi.alt)$],stroke:(dash:"dashed")),
edge((1,0),(1,1),"->",[$pi$]),
edge((0,1),(1,1),"->",[$phi.alt$]))]
]
Hence $tilde(phi.alt) in "Isom"\(bb(R)^2\)$, the image of the standard lattice gives us the desired marked lattice

]
Since $bb(H)^2$ is the universal cover of $X$, for any marking $phi.alt : S_g arrow.r X$, we have

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(H)^2$]),
node((1,0),[$bb(H)^2$]),
node((0,1),[$S_g$]),
node((1,1),[$X$]),
edge((0,0),(0,1),"->",[$pi$]),
edge((0,0),(1,0),"->",[$tilde(phi.alt)$],stroke:(dash:"dashed")),
edge((1,0),(1,1),"->",[$pi$]),
edge((0,1),(1,1),"->",[$phi.alt$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(H)^2$]),
node((1,0),[$bb(H)^2$]),
node((2,0),[$bb(H)^2$]),
node((0,1),[$Y$]),
node((1,1),[$S_g$]),
node((2,1),[$X$]),
edge((0,0),(0,1),"->",[$pi$]),
edge((1,0),(1,1),"->",[$pi$]),
edge((1,0),(2,0),"->",[$tilde(phi.alt)$],stroke:(dash:"dashed")),
edge((1,0),(0,0),"->",[$tilde(psi)$]),
edge((2,0),(2,1),"->",[$pi$]),
edge((2,0),(0,0),"->",[$tilde(i)$],bend:-15deg),
edge((1,1),(2,1),"->",[$phi.alt$]),
edge((1,1),(0,1),"->",[$psi$]),
edge((2,1),(0,1),"->",[$i$],bend:15deg))]
]
$tilde(phi.alt) in "Isom"\(bb(H)^2\)tilde.equiv "PGL"\(2\,bb(R)\)$

#statement("Proposition")[
Let $D F\(pi_1\(S_g\)\,"PSL"\(2\,bb(R)\)\)$ be the subset of discrete and faithful representations in $"Hom"\(pi_1\(S_g\)\,"PSL"\(2\,bb(R)\)\)$, there is a natural bijection #display-equation($T\(S_g\)arrow.l.r D F\(pi_1\(S_g\)\,"PSL"\(2\,bb(R)\)\)\/"PGL"\(2\,bb(R)\)$)

]
#proof(title: "Proof")[
Consider map $T\(S_g\)arrow.r "Hom"\(pi_1\(S_g\)\,"Isom"\(bb(H)^2\)\)$ by $pi_1\(S_g\)arrow.r^(phi.alt_(*)) pi_1\(X\)arrow.r^tilde.equiv "Aut"\(bb(H)^2\/X\)arrow.r.hook "Aut"\(bb(H)^2\)tilde.equiv "Isom"\(bb(H)^2\)$, if $\(X\,phi.alt\)tilde.op\(Y\,psi\)$

]
#statement("Definition")[
Use the discrete topology on $T\(S_g\)$, and Lie group topology on $"PSL"\(2\,bb(R)\)$, and then use compact-open topology on $"Hom"\(pi_1\(S_g\)\,"PSL"\(2\,bb(R)\)\)$ which can be embedded in $"PSL"\(2\,bb(R)\)^(2 g)$ (this is well defined regardless of the choice the generator), called the algebraic topology on $T\(S_g\)$

]
#statement("Proposition")[
Let $c$ be an isotopy class of simple closed curves, then the map $T\(S_g\)arrow.r bb(R)$, $cal(X) arrow.r ell_(cal(X))\(c\)$ is continuous

]
