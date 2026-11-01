#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Topological groups

#statement("Definition")[
$G$ is a #strong[topological group]#index-entry("Topological groups") if it is a group and a topological space so that the group multiplication $G times G arrow.r G$ and the inverse map $G arrow.r G$ are continuous maps

]
#statement("Definition")[
$f : G arrow.r bb(R)\/bb(C)$ is a continuous function, $L_y f\(x\)= f\(y^(- 1) x\)$, $R_y f\(x\)= f\(x y\)$, $L_(y z) = L_y L_z$, $R_(y z) = R_y R_z$, $f$ is called left/right uniformly continuous if $forall epsilon > 0$, $exists V in.rev e$ such that $parallel L_y f - f parallel < epsilon$/$parallel R_y f - f parallel < epsilon$, $forall y in V$, $parallel dot.op parallel$ is the supremum norm

]
#statement("Proposition")[
If $f in C_c\(G\)$, then $f$ is both left and right uniformly continuous

]
#proof(title: "Proof")[
Easy proof by a very standard analysis argument

]
#statement("Definition")[
If $f$ is a Borel measurable function on $G$, then $f$ factor through $G\/H$, otherwise suppose $f\(y\)eq.not f\(z\)$, $y\,z in x H$, $f^(- 1)\(f\(y\)\)inter x H subset.neq x H$ is a Borel set which is impossible, because then $x^(- 1) f^(- 1)\(f\(y\)\)inter H subset.neq H$ will also be a Borel set, consider $Gamma = {S in cal(P) mid(bar.v) H subset.eq H upright(" or ") H inter S = nothing}$, then $Gamma$ is a sigma algebra containing all open sets hence Borel algebra, we reached a contradiction

Thus for most purposes one may as well work with $G\/H$ which is Hausdorff($L^p$ spaces for instance, mod almost everywhere vanishing function)

For a locally compact Hausdorff group, A Borel measure $mu$ on $G$ is called left/right invariant if $mu\(x E\)= mu\(E\)$/$mu\(E x\)= mu\(E\)$, $x in G\,E in cal(B)\(G\)$

A linear functional $I$ is left/right invariant if $I\(L_x f\)= I\(f\)$/$I\(R_x f\)= I\(f\)$

A left/right Haar measure on $G$ is a left/right invariant Radon measure $mu$ on $G$, for example, Lebesgue measure on $bb(R)^n$, counting measure on $G$ with discrete topology

]
#statement("Example")[
Continuous bijective group homomorphism doesn't imply homeomorphism, which is really obvious, by taking the identity map and a discrete topology on the topological group $G$

]
#statement("Definition")[
Let $G$ be a topological group, then a $1$-parameter subgroup means a continuous group homomorphism $phi : bb(R) arrow.r G$, $phi\(s + t\)= phi\(s\)phi\(t\)$, in the case of a Lie group, $phi$ is required to be smooth

]
#statement("Definition")[
Suppose $G$ is a connected, locally pathconnected and (semi-)locally simply connected topological space, then it has a universal cover $tilde(G)$ which is unique up to an isomorphism, a connected Lie group certain satisfies this

]
#statement("Proposition")[
Denote $pi : tilde(G) arrow.r G$ as the covering map, let $macron(G)$ be the set of maps $T : tilde(G) arrow.r tilde(G)$, such that $pi\(T x\)= g\(pi x\)$ for some $g in G$, i.e. the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$tilde(G)$]),
node((1,0),[$tilde(G)$]),
node((0,1),[$G$]),
node((1,1),[$G$]),
edge((0,0),(1,0),"->",[$T$]),
edge((0,0),(0,1),"->",[$pi$]),
edge((1,0),(1,1),"->",[$pi$]),
edge((0,1),(1,1),"->",[$g$]))]
]
Then $macron(G)$ which is a group acts transitively and freely on $tilde(G)$, thus we can think of the universal cover $tilde(G)$ also as a topological group

]
#proof(title: "Proof")[
Given $x\,y in tilde(G)$, there is a unique $g in G$ such that $g\(pi x\)= pi y$, since $tilde(G)$ is the universal cover, there is a unique lift such that $T\(x\)= y$, thus the action is free and transitive

]
