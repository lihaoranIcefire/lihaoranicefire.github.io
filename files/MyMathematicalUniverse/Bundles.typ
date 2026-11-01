#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Bundles

#statement("Definition")[
A #strong[bundle]#index-entry("Bundle") is $E arrow.r^p B$, where $E$ is the #strong[total space], $B$ is the #strong[base space], and $p$ is the projection, $p^(- 1)\(b\)$ is the #strong[fiber] over $b$. A #strong[cross section]#index-entry("Cross section") is $s : X arrow.r E$, such that $p s = 1_X$. The restriction $p^(- 1)\(A\)arrow.r^pi A$, $A subset.eq B$ is also a bundle

]
#statement("Definition")[
Suppose $E arrow.r^p B$ is a bundle, $f : A arrow.r B$ is a map, then the pullback $f^(*)\(E\)= A times_p E arrow.r A$ is the #strong[pullback bundle]#index-entry("Pullback bundle"), the pullback of a section#index-entry("Pullback of sections") $s : B arrow.r E$ is defined as $f^(*) s := s compose f$, notice $p\(f^(*) s\(y\)\)= p\(s\(f\(y\)\)\)= f\(y\)$

]
#statement("Definition")[
A #strong[fiber bundle]#index-entry("Fiber bundle") is a bundle $E arrow.r^p B$ such that there exists an open neighborhood $U$ of $b$ and a homeomorphism $phi.alt$ making the following diagram commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$p^(- 1)\(U\)$]),
node((1,0),[$U times F$]),
node((0,1),[$U$]),
edge((0,0),(1,0),"->",[$phi.alt$]),
edge((0,0),(0,1),"->",[$p$]),
edge((1,0),(0,1),"->",[$p r_1$]))]
]
]
#statement("Definition")[
$G$ is a topological group, a $G$ #strong[fiber bundle] $E arrow.r^p B$ is a fiber bundle and also a morphism of $G$ spaces

]
#statement("Lemma")[
A fiber bundle is a Serre fibration

]
#statement("Definition")[
$bb(F)$ is a topological field, a #strong[vector bundle]#index-entry("Vector bundle") is a fiber bundle $E arrow.r^p X$ with fiber being $bb(F)^n$ and $phi.alt$ restricts on each fiber is an $bb(F)$ isomorphism

]
#statement("Definition")[
$G$ is a topological group, a #strong[principal] $G$ #strong[bundle] $p : P arrow.r B$ is a morphism of $G$ spaces, $B$ with the trivial $G$ action, and for each $b in B$, there is a local trivialization

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$p^(- 1)\(U\)$]),
node((1,0),[$U times G$]),
node((0,1),[$U$]),
edge((0,0),(1,0),"->",[$phi.alt$]),
edge((0,0),(0,1),"->",[$p$]),
edge((1,0),(0,1),"->",[$p r_1$]))]
]
$phi.alt$ is an isomorphism

]
#aside("Remark")[
$G$ action on $P$ preserves fibers, and the action on fiber is free and transitive, each fiber is a $G$ torsor. A morphism of principal $G$ bundles is always an isomorphism. A principal $G$ bundle is trivial iff it has a global section

]
#statement("Proposition")[
Suppose $P arrow.r B$ is a principal $G$ bundle, $G arrow.r G\/H$ is a principal $H$ bundle, then $P arrow.r P\/H$ is a principal $H$ bundle

]
#proof(title: "Proof")[
$P tilde.equiv P times_G G arrow.r P times_G\(G\/H\)tilde.equiv P\/H$

]
#statement("Proposition")[
Suppose $P arrow.r B$ is a principal $G$ bundle, $F$ is a left $G$ space, $P times_G F arrow.r P times_G * tilde.equiv B$ is a $G$ fiber bundle. $X arrow.r^f Y$ is a map, $f^(*)\(P times_G F\)arrow.r f^(*)\(P\)times_G F$ is a natural homeomorphism

]
#statement("Proposition")[
$P arrow.r^p B$ is a principal $G$ bundle, $X$ is a right $G$ space, a morphism $P arrow.r^f X$ induce $P arrow.r^(vec(1, f)) P times X$, $B tilde.equiv P\/G arrow.r P times X\/G tilde.equiv P times_G X$ which is a section $s_f$ of $P times_G X arrow.r B$, this is a natural bijection

]
#statement("Proposition")[
$P arrow.r B times I$ is principal $G$ bundle, then $P$ and $P_0 times I$ is an isomorphism, here $P_0$ is the restriction of $P$ over $B times { 0 }$

]
#proof(title: "Proof")[
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$P times_G\(P_0 times I\)$]),
node((0,1),[$B times I$]),
node((1,1),[$B times I$]),
edge((0,0),(0,1),"hook->"),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->"),
edge((0,1),(1,0),"->",stroke:(dash:"dashed")))]
]

]
#statement("Definition")[
Let $E arrow.r^p X$ be a vector bundle, consider two trivializations $phi_U : E_U arrow.r U times bb(R)^n$ and $phi_V : E_V arrow.r V times bb(R)^n$ around $x in X$, then $phi_V compose phi_U^(- 1)$ restricted on $U inter V times bb(R)^n$ is a local isomorphism with inverse $phi_U compose phi_V^(- 1)$ restricted on $U inter V times bb(R)^n$, it is also called a transition function and it can also be regard as a continuous map $g_(V U) : U inter V arrow.r G L\(n\,bb(R)\)$ or $g_(V U) in G L\(n\,C\(U inter V\)\)$, such that $phi_V compose phi_U\(x\,v\)=\(x\,g_(V U)\(x\)v\)$, notice then $g_(U V) = g_(V U)^(- 1)$, and $g_(V U)$'s satisfy the cocycle relation $g_(W V) g_(V U) = g_(W U)$ on $U inter V inter W$

Conversely, given $union.sq.big_(alpha in A) U_alpha times bb(R)^n times A$ transition functions $g_(alpha beta) : U_alpha inter U_beta arrow.r G L\(n\,bb(R)\)$ that satisfying cocycle relation $g_(gamma beta) g_(beta alpha) = g_(gamma alpha)$ on $U_alpha inter U_beta inter U_gamma$, mod equivalence relation $\(x\,v\,alpha\)tilde.op\(x\,g_(beta alpha)\(v\)\,beta\)\,x in U_alpha inter U_beta$, you will get back the vector bundle

Suppose $s : X arrow.r E$, is a section, denote $phi_i compose s\|_(U_i)\(x\)=\(x\,f_i\(x\)\)$ over $U_i$, then $\(x\,f_j\(x\)\)= phi_j compose s\|_(U_j)\(x\)= phi_j compose s\|_(U_i)\(x\)= phi_j compose phi_i^(- 1) compose phi_i compose s\|_(U_i)\(x\)= phi_j compose phi_i^(- 1)\(x\,f_i\(x\)\)=\(x\,g_(j i)\(x\)f_i\(x\)\)\,forall x in U_i inter U_j$, thus $f_j = g_(j i) f_i$, conversely, this relation also defines a section

]
#statement("Definition")[
The pullback of a transition function is defined to be $f^(*) g_(i j) := g_(i j) compose f$

]
#statement("Definition")[
A morphism between vector bundles $phi : E arrow.r F$ is map such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$E$]),
node((1,0),[$F$]),
node((0,1),[$X$]),
node((1,1),[$Y$]),
edge((0,0),(1,0),"->",[$phi$]),
edge((0,0),(0,1),"->",[$p$]),
edge((1,0),(1,1),"->",[$q$]),
edge((0,1),(1,1),"->",[$f$]))]
]
and $phi_x : E_x arrow.r F_(f\(x\))$ is a homomorphism between vector spaces

]
#statement("Definition")[
Let $E arrow.r^p X$ and $F arrow.r^q Y$ be vector bundles, then direct sum $E times F arrow.r^(p times q) X times Y$ is also a vector bundle, suppose $phi_U : U arrow.r U times bb(R)^n$, $psi_V : V arrow.r V times bb(R)^m$ are trivializations, then $phi_U times psi_V : U times V arrow.r U times bb(R)^n times V times bb(R)^m tilde.equiv U times V times bb(R)^(n + m)$ is also a trivialization

]
#statement("Proposition")[
Let $E arrow.r^p X$ is a vector bundle, and $f : X arrow.r Y$ is a homeomorphism, then $E arrow.r^(f compose p) Y$ is a vector bundle, suppose $phi_U : E_U arrow.r U times bb(F)^n$ is a trivialization, then $\(f times 1\)compose phi_U = : psi_(f\(U\)) : E_U arrow.r U times bb(F)^n arrow.r f\(U\)times bb(F)^n$ is a trivialization

]
#statement("Proposition")[
$p : Gamma_f arrow.r X\,\(x\,f\(x\)\)mapsto x$ is homeomorphism

]#label("Domain is homeomorphic to its graph")
#proof(title: "Proof")[
$p$ as a restriction on $Gamma_f$ of $X times Y$ projecting to $X$ is continuous, and define $q : X arrow.r Gamma_f\,x arrow.r\(x\,f\(x\)\)$, since the composition $X arrow.r^q Gamma_f arrow.r.hook X times Y$ which is continuous because $X arrow.r^f Y$, $X arrow.r^(i d) X$ are continuous, $q$ is continuous, and $p\,q$ are inverses to each other

]
#statement("Definition")[
$E arrow.r^pi X$ ia vector bundle, $f : Y arrow.r X$ is a continuous map, then we can construct the pullback bundle#index-entry("pullback bundle") $f^(*) E arrow.r^p Y$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$f^(*) E$]),
node((1,0),[$E$]),
node((0,1),[$Y$]),
node((1,1),[$X$]),
edge((0,0),(0,1),"->",[$p$]),
edge((0,0),(1,0),"->",[$g$]),
edge((1,0),(1,1),"->",[$pi$]),
edge((0,1),(1,1),"->",[$f$]))]
]
satisfying universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F$]),
node((1,1),[$Y times_X E$]),
node((2,1),[$E$]),
node((1,2),[$Y$]),
node((2,2),[$X$]),
edge((0,0),(1,2),"->",[$beta$],bend:-15deg),
edge((0,0),(2,1),"->",[$alpha$],bend:15deg),
edge((0,0),(1,1),"->",[$exists_1 h$],stroke:(dash:"dashed")),
edge((1,1),(1,2),"->",[$p$]),
edge((1,1),(2,1),"->",[$g$]),
edge((2,1),(2,2),"->",[$pi$]),
edge((1,2),(2,2),"->",[$f$]))]
]
Concrete construction: let $f^(*) E = Y times_X E subset.eq Y times X$ with subspace topology, where $Y times_X E = {\( y \, v \) in Y times E mid(bar.v) f \( y \) = pi \( v \)}$, let's check it is a vector bundle over $Y$, notice that $Y times_X E arrow.r Y$ factor through $Y times_X E arrow.r Gamma_f arrow.r Y$, $\(y\,v\)mapsto\(y\,pi\(v\)\)=\(y\,f\(y\)\)mapsto y$, where $Gamma_f$ is the graph of $f$ which is homeomorphic to $Y$ due to Proposition #ref(label("Domain is homeomorphic to its graph"), supplement: none), notice that $Y times_X E arrow.r Gamma_f$ is the restriction of vector bundle $Y times E arrow.r^(1 times pi) Y times X$ over $Gamma_f$, thus $Y times_X E arrow.r Y$ is a vector bundle, suppose $F$ as in the commutative diagram, then $h$ is simply defined as $h\(w\):=\(beta\(w\)\,alpha\(w\)\)$

]
#aside("Remark")[
In general, this is a pullback, but it has a vector bundle structure such that it induces an isomorphism on each fiber, now suppose $F arrow.r^q Y$ is a another vector bundle such that not only the diagram commutes but also induce isomorphism on each fiber, then $F tilde.equiv f^(*) E$

Use this we have $\(f g\)^(*) E tilde.equiv g^(*)\(f^(*) E\)$, $f^(*)\(E xor F\)tilde.equiv f^(*) E xor f^(*) F$, $f^(*)\(E times.o F\)tilde.equiv f^(*) E times.o f^(*) F$, $1^(*) E tilde.equiv E$

]
#statement("Definition")[
Suppose $E\,F$ are vector bundles both trivialized over ${ U_alpha }$\(this can easily be achieved, just take intersections), suppose the transition functions are $g_(alpha beta)\,h_(alpha beta)$, then define the tensor product of vector bundles#index-entry("tensor product of vector bundles") $E times.o F$ by letting its transition functions be $g_(alpha beta) times.o h_(alpha beta)$

Similarly, we can define symmetric power and exterior power of vector bundles by specifying its transition function

Does it have universal property also?

]
#statement("Definition")[
Let $E arrow.r^p X$, $E arrow.r^p X$ be vector bundles, then the direct sum#index-entry("direct sum of vector bundles") $E xor F arrow.r^p X$ is defined by transition functions $g_(alpha beta) xor h_(alpha beta)$, where $g_(alpha beta)\,h_(alpha beta)$ are transition functions of $E\,F$

]
#statement("Definition")[
Let $E arrow.r X$ be a vector bundle, define its dual bundle as follows, if $g_(alpha beta)$ is a transition function, the transition function for $E^(*)$ would be $(g_(alpha beta)^(- 1))^T$

]
#statement("Definition")[
quotient bundle, exterior and symmetric power of vector bundle

]
#statement("Proposition")[
$E arrow.r^p X$ is a vector bundle with $X$ being a paracompact space, then there exists a continuous map $chevron.l\,chevron.r : E xor E arrow.r bb(R)$ with $chevron.l\,chevron.r\|_(E_x)$ defines an inner product

]
#statement("Definition")[
$F subset.eq E$ is called a vector subbundle #index-entry("vector subbundle") if $F$ is a subspace of $E$ and $F arrow.r^p X$ is also a vector space

]
#statement("Proposition")[
$E arrow.r^p X$ is a vector bundle with $X$ being a paracompact space and $F subset.eq E$ is a vector subbundle, then there exists a vector subbundle $F^perp subset.eq E$ such that $F_x xor F^perp\|_x = E\|_x$ and $(F \|_x)^perp = F^perp\|_x$

]
#proof(title: "Proof")[

]
#statement("Theorem")[
If $E arrow.r^p X$ is vector bundle over a compact Hausdorff space $X$, then there exists a vector bundle $E' arrow.r^(p') X$ such $E xor E'$ is a trivial bundle

]#label("X compact Hausdorff => E has complement")
#statement("Proposition")[
Every Lie group $G$ is parallelizable

]
#proof(title: "Proof")[
Pick an arbitrary basis $e_1\,dots.h.c\,e_n$ of $T_1 G$, then $L_g^(*)\(e_i\)$ will be a basis of $T_(g^(- 1)) G$ since $L_g^(*)$ is an isomorphism, they form independent global sections of the tangent bundle

]
#statement("Definition")[
Tautological bundle

]
#statement("Definition")[
Let $X$ be a smooth manifold of dimension $n$\(depending on the field), $Omega$ denote the cotangent bundle, then $omega := and.big^n Omega$ is called the canonical bundle#index-entry("Canonical bundle")

]
#statement("Definition")[
Universal bundle

]
#statement("Theorem")[
Let $X$ be a paracompact Hausdoff space, there is a bijection $[X \, lim_arrow.r G r_(bb(C)) \( n \, N \)] arrow.r upright(V e c t)_(bb(C))^n\(X\)\,\[f\]mapsto\[f^(*)\(E\)\]$

]
#statement("Definition")[
Let $E arrow.r^p X$ is a vector bundle, an inner product is a continuous map $chevron.l\,chevron.r : E xor E arrow.r bb(R)$ with $chevron.l\,chevron.r\|_(E_x)$ defines an inner product on $E_x$

]
#statement("Proposition")[
Let $E arrow.r^p X$ is a vector bundle with an inner product $chevron.l\,chevron.r$, then we can local trivialization to be isometry on each fiber, i.e. $chevron.l v\,w chevron.r = (phi_U \( v \) \, phi_U \( w \))\,v\,w in E_x$, where $\(\,\)$ is the standard inner product on $U times bb(R)^n$

]
#statement("Proposition")[
$E arrow.r^p X$ is a vector bundle with $X$ being a paracompact space, then there exists a continuous map $chevron.l\,chevron.r : E xor E arrow.r bb(R)$ with $chevron.l\,chevron.r\|_(E_x)$ defines an inner product

]
#statement("Definition")[
let $G$ be a topological group, $E\,X$ be $G$-spaces, then $E arrow.r^p X$ is a $G$-vector bundle#index-entry("G-vector bundle") if it is a vector bundle, $p$ is a $G$ map, and for any $x in X$, $g : E_x arrow.r E_(g x)$ is a linear map

]
#statement("Definition")[
Let $G$ be a topological group, $H$ be a closed subgroup, a $G$ vector bundle $pi : E arrow.r G\/H$ is called a homogeneous vector bundle#index-entry("Homogeneous vector bundle")

]
#statement("Lemma")[
Let $Y arrow.r^f X\,Z arrow.r^g X$ be open surjective continuous maps, then the projection $p_Y : Y times_X Z arrow.r Y$ is open surjective

]
#proof(title: "Proof")[
For surjectivity, if $y in Y$, since $g$ is surjective, $exists z in Z$ such that $g\(z\)= f\(y\)$, then $\(z\,y\)in Y times_X Z$

To prove $p_Y$ is open, suppose $\(z_0\,y_0\)in Y times_X Z$ is in some open set, then $\(z_0\,y_0\)in U times V inter Y times_X Z$ for some $y_0 in U\,z_0 in V$ open, since $f\,g$ are open, $U' := f\(U\)inter g\(V\)$ is open, let $V' := V inter f^(- 1)\(U'\)$, then we can show $V'$ is in the image of $U times V inter Y times_X Z$, since $forall y in V'$, $f\(y\)in U' subset.eq g\(V\)$, thus $f\(y\)= g\(z\)$ for some $z in V$, hence $\(y\,z\)in U times V inter Y times_X Z$

]
#statement("Proposition")[
Let $pi : E arrow.r G\/H$ be a homogeneous vector bundle, $E_H$ be the fiber over the coset $H$, action $G times E_H arrow.r E$ can be regard as $alpha : G times_H E_H arrow.r E$ which is an isomorphism of $G$ vector bundles. Moreover, if $H$ is locally compact, then for a given $bb(R) H$ module $E_H$, $G times_H E_H arrow.r G\/H$ is indeed a $G$ vector bundle, hence $G$ vector bundle $E$ is in one to one correspondence with representations of $H$ on $E_H$, so $K_G\(G\/H\)tilde.equiv R\(H\)$

]
#proof(title: "Proof")[
$E_H$ is an $bb(R) H$ module, let $G times_H E_H$ denote the space of orbits of $G times E_H$ under $H$ by $h dot.op\(g\,xi\)=\(g h^(- 1)\,h xi\)$, $G times_H E_H$ is a $G$ space with $G$ action $g dot.op\(g'\,xi\)mapsto\(g g'\,xi\)$, then the group action can be regarded as $alpha : G times_H E_H arrow.r E\,\(g\,xi\)mapsto g xi$, we can find its inverse $beta : E arrow.r G times_H E_H\,E_(g H) in.rev xi mapsto\(g\,g^(- 1) xi\)$, to show that this is continuous, consider $gamma : G times E arrow.r G times E\,\(g\,xi\)mapsto\(g\,g^(- 1) xi\)$, then the preimage of $G times E_H$ will be the pullback $G times_(G\/H) E := {\( g \, xi \) in G times E mid(bar.v) g H = pi xi}$, then $G times_(G\/H) E arrow.r G times E_H arrow.r G times_H E_H\,\(g\,xi\)mapsto\(g\,g^(- 1) xi\)$ factors as $G times_(G\/H) E arrow.r E arrow.r^beta G times_H E\,\(g\,xi\)mapsto xi mapsto\(g\,g^(- 1) xi\)$ which open surjective, therefore $beta$ is continuous due to the previous Lemma

]
#statement("Definition")[
A clutching function for $S^k$ is $f : S^(k - 1) arrow.r G L\(n\,bb(C)\)$, then we can define vector bundle $E_f$ with $f$ being the transition function, conversely, if $E$ is a vector bundle over $S^k$, since its upper and lower hemispheres are both contractible, $E = E_f$, where $f$ is the transition function, denoting the corresonding matrix $T_f$

]
#statement("Theorem")[
$\[S^(k - 1)\,G L\(n\,bb(C)\)\]arrow.r upright(V e c t)_(bb(C))^n\(S^k\)\,f mapsto E_f$ is a bijection

]
#statement("Lemma")[
Suppose $f\,g : S^(k - 1) arrow.r G L\(n\,bb(C)\)$, then $\(E_f times.o E_g\)xor epsilon^n tilde.equiv E_(f g) xor epsilon^n tilde.equiv E_f xor E_g$

]
#proof(title: "Proof")[
Since $G L\(n\,bb(C)\)$ is path connected, there is a path $A_t in G L\(2 n\,bb(C)\)$ that $A_0 = mat(delim: "(", 1, ; #none, 1)\,A_1 = mat(delim: "(", #none, 1; 1, )$, then $mat(delim: "(", T_f; #none, I) A_t mat(delim: "(", I; #none, T_g) A_t$ is $mat(delim: "(", T_f; #none, T_g)$ when $t = 0$ and $mat(delim: "(", T_f T_g; #none, I) = mat(delim: "(", T_(f g); #none, I)$ when $t = 1$

]
#statement("Definition")[
Let $E arrow.r^p X$ be vector bundle of rank $n$, and there is a inner product over $E$, we can define the sphere bundle $S\(E\)$ associated to $E$ to be $S\(E\)= union.big_(x in X) S\(E_x\)$ with the subspace topology, this is a fiber bundle, suppose $phi_U$ is a local trivialization, since we can choose $phi_U$ to be isometry over each fiber, thus the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S\(E\)_U$]),
node((1,0),[$U times S\(bb(R)^n\)$]),
node((0,1),[$E_U$]),
node((1,1),[$U times bb(R)^n$]),
node((1,2),[$U$]),
edge((0,0),(1,0),"->",[$phi_U$]),
edge((0,0),(0,1),"hook->"),
edge((1,0),(1,1),"hook->"),
edge((0,1),(1,1),"->",[$phi_U$]),
edge((0,1),(1,2),"->",[$p$]),
edge((1,1),(1,2),"->"))]
]
]
#statement("Definition")[
Let $E arrow.r^p X$ be vector bundle of rank $n$, and there is a inner product over $E$, we can define the projective bundle $P\(E\)$ associated to $E$ to be $P\(E\)= union.big_(x in X) P\(E_x\)$ with the quotient topology, this is a fiber bundle, suppose $phi_U$ is a local trivialization, since we can choose $phi_U$ to be isometry over each fiber, thus the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S\(E\)_U$]),
node((2,0),[$U times S\(bb(R)^n\)$]),
node((1,1),[$U$]),
node((0,2),[$P\(E\)_U$]),
node((2,2),[$U times P\(bb(R)^n\)$]),
edge((0,0),(2,0),"->",[$phi_U$]),
edge((0,0),(1,1),"->"),
edge((0,0),(0,2),"->",[$q$]),
edge((2,0),(1,1),"->"),
edge((2,0),(2,2),"->",[$q$]),
edge((0,2),(2,2),"->",[$phi_U$]),
edge((0,2),(1,1),"->"),
edge((2,2),(1,1),"->"))]
]
]
#statement("Definition")[
Let $E arrow.r^p X$ be vector bundle of rank $n$, and there is a inner product over $E$, we can define the flag bundle $F\(E\)$ associated to $E$ to be $F\(E\)= union.big_(x in X) F\(E_x\)$ with the subspace topology in $P\(E\)times dots.h.c times P\(E\)$

]
#aside("Remark")[
Consider the pullback of $pi : F\(E\)arrow.r X$, $pi^(*)\(E\)subset.eq F\(E\)times E$, consider its subbundles $L_1\,dots.h.c\,L_n$, where $L_i$ is the subbundle that over a point in $F\(E\)$, it is the $i$-th factor, then $pi^(*)\(E\)tilde.equiv L_1 xor dots.h.c xor L_n$

]
#statement("Definition")[
Let $X$ be a paracompact and Hausdorff space, there exist unique functions $w_1\,w_2\,dots.h.c$, $w_i : upright(V e c t_(bb(R))\(X\)) arrow.r H^i\(X\,bb(Z)_2\)$, $E arrow.r w_i\(E\)$, and they only depend on the isomorphism classes of $E$, satisfying

\1. $w_i\(f^(*)\(E\)\)= f^(*)\(w_i\(E\)\)$, for pullback bundle $f^(*)\(E\)$

\2. $w\(E_1 xor E_2\)= w\(E_1\)smile w\(E_2\)$ where $w = 1 + w_1 + w_2 + dots.h.c in H^(*)\(X\,bb(Z)_2\)$

\3. $w_i\(E\)= 0\,forall i > dim E$

\4. If $E arrow.r bb(R) P^oo$ is the canonical line bundle, then $w_1\(E\)$ is the generator of $H^(*)\(bb(R) P^oo\,bb(Z)_2\)tilde.equiv bb(Z)_2\[x\]$

$w_i\(E\)$ are called the Stiefel-Whitney classes of $E$

]
#statement("Definition")[
Let $X$ be a paracompact and Hausdorff space, there exist unique functions $c_1\,c_2\,dots.h.c$, $c_i : upright(V e c t_(bb(C))\(X\)) arrow.r H^(2 i)\(X\;bb(Z)\)$, $E arrow.r c_i\(E\)$, and they only depend on the isomorphism classes of $E$, satisfying

\1. $c_i\(f^(*)\(E\)\)= f^(*)\(c_i\(E\)\)$, for pullback bundle $f^(*)\(E\)$

\2. $c\(E_1 xor E_2\)= c\(E_1\)smile c\(E_2\)$ where $c = 1 + c_1 + c_2 + dots.h.c in H^(*)\(X\;bb(Z)\)$

\3. $c_i\(E\)= 0\,forall i > dim E$

\4. If $E arrow.r bb(C) P^oo$ is the canonical line bundle, then $c_1\(E\)$ is a generator of $H^(*)\(bb(C) P^oo\;bb(Z)\)tilde.equiv bb(Z)\[x\]$, specify a generator in advance

$c_i\(E\)$ are called the Chern classes of $E$, also we define the Chern polynomial to be $c_t = 1 + c_1 t + c_2 t^2 + dots.h.c$ where $t$ is just a formal variable used to keep tracking of the degree

]
#statement("Lemma")[
Let $L_1\,L_2$ be line bundles, then $c_1\(L_1 times.o L_2\)= c_1\(L_1\)+ c_1\(L_2\)$

]
#statement("Definition")[
Suppose $L$ is a line bundle, define the Chern character $c h\(L\)= e^(c_1\(L\)) = 1 + c_1\(L\)+ frac(c_1\(L\)^2, 2 !) + dots.h.c in H^(*)\(X\;bb(Q)\)$, then we have $c h\(L_1 times.o L_2\)= e^(c_1\(L_1 times.o L_2\)) = e^(c_1\(L_1\)+ c_1\(L_2\)) = e^(c_1\(L_1\)) e^(c_1\(L_2\)) = c h\(L_1\)c h\(L_2\)$, If we assume $c h\(L_1 xor L_2\)= c h\(L_1\)+ c h\(L_2\)$, then for $E = L_1 xor dots.h.c xor L_n$, $c h\(E\)= c h\(L_1\)+ dots.h.c + c h\(L_n\)= n + (c_1 \( L_1 \) + dots.h.c + c_1 \( L_n \)) + (c_1 \( L_1 \)^2 + dots.h.c + c_1 \( L_n \)^2)\/2 ! + dots.h.c$, on the other hand, we have $c\(E\)= c\(L_1\)smile dots.h.c smile c\(L_n\)=\(1 + c_1\(L_1\)\)smile dots.h.c smile\(1 + c_1\(L_n\)\)= 1 + c_1\(E\)+ dots.h.c + c_n\(E\)$, where $c_i\(E\)$ would just be the $i$-th elementary symmetric polynomial of $c_1\(L_1\)\,dots.h.c\,c_1\(L_n\)$, i.e. $c_i\(E\)= sigma_i\(c_1\(L_1\)\,dots.h.c\,c_1\(L_n\)\)$, so we can express $c_1\(L_1\)^k + dots.h.c + c_1\(L_n\)^k$ in terms of $c_i\(E\)$, i.e. $c_1\(L_1\)^k + dots.h.c + c_1\(L_n\)^k = s_k\(c_1\(E\)\,dots.h.c\,c_n\(E\)\)$, thus we have an abstract definition of Chern character, $c h\(E\)= dim E + s_1\(c_1\(E\)\,dots.h.c\,c_n\(E\)\)+ s_2\(c_1\(E\)\,dots.h.c\,c_n\(E\)\)\/2 ! + dots.h.c$

]
#statement("Proposition")[
$c h\(E_1 xor E_2\)= c h\(E_1\)+ c h\(E_2\)$, $c h\(E_1 times.o E_2\)= c h\(E_1\)c h\(E_2\)$

]
#statement("Theorem", title: [Thom isomorphism])[
$Lambda$ is a ring, $p : E arrow.r B$ is an oriented vector bundle of rank $r$, then there exists the #emph[Thom class]#index-entry("Thom class") $u in H^r\(E\,E\\B\,Lambda\)$\($B subset.eq E$ as the zero section) such that its restriction to any fiber $F$, $H^r\(F\,F\\0\,Lambda\)$ is the local orientation. And $H^r\(E\,E\\B\,bb(Z)\)arrow.r H^r\(E\,bb(Z)\)arrow.r H^r\(B\,bb(Z)\)$ defines the #emph[Euler class]#index-entry("Euler class") $e\(E\)$

For the tangent bundle of a smooth manifold, the Euler class evaluated at the fundamental class of $B$ is the Euler characteristic

]
#statement("Lemma")[
$V$ is a vector space of dimension $n$, $cal(V)$ is the set of frames(bases) of $V$, then $"GL"\(bb(F)\,n\)$ acts transitively and freely on the right of $cal(V)$

]
#statement("Definition")[
#index-entry("Principal G-bundle") If $G$ is a topological group, then a principal $G$-bundle#index-entry("Principal G-bundle") $P$ is a fiber bundle with a continuous right $G$ action $P times G arrow.r P$, and the action is free and transitive(thus regular), which imply each fiber is a $G$-torsor, also, $g mapsto y g$ is a homeomorphism

]
#statement("Definition", title: [Vector bundle(Koszul) connection])[
\ $E arrow.r B$ is a vector bundle. $E$ valued $k$-forms are #display-equation($Omega^k\(E\)= Gamma (and.big^k T^(*) B times.o E) = Omega^k\(B\)times.o Gamma\(E\)$) A #emph[vector bundle(Koszul) connection] is #display-equation($nabla : Omega^0\(E\)arrow.r Omega^1\(E\)= "Hom"\(T B\,bb(F)\)times.o Gamma\(E\)$) Satisfying the Leibniz rule #numbered-equation($nabla\(f times.o s\)= d f times.o s + f and nabla s$)#label("06/10/2021-13:50") By feeding $X in T B$, $nabla_X : Gamma\(E\)arrow.r Gamma\(E\)$ is the covariant derivative along $X$. This extends to exterior covariant derivative $d_nabla : Omega^k\(E\)arrow.r Omega^(k + 1)\(E\)$ through #ref(label("06/10/2021-13:50"), supplement: none)

]
#statement("Definition", title: [Connection form])[
\ Over a local trivialization, $s = sum s_i times.o e_i$, $nabla e_j = sum_i omega_(i j) times.o e_i$, $nabla s = sum_i\(d s_i + sum_j omega_(i j) and s_j\)times.o e_i$, in short, $nabla s = d s + omega and s$ in local coordinates, here $omega =\(omega_(i j)\)$ is the #emph[connection form]

]
#statement("Definition", title: [Curvature])[
In general $d_nabla$ may not give a chain complex. The curvature tensor is #display-equation($d_nabla^2 : Omega^0\(E\)arrow.r Omega^2\(E\)$) Over a local trivialization, $d_nabla^2 s = d_nabla\(d s + omega and s\)=\(d omega + omega and omega\)and s$, $d omega + omega and omega$ is the #emph[curvature form]. A connection is #emph[flat(completely integrable)] if its curvature is zero

]
#statement("Definition")[
Two vector bundles $E arrow.r X$, $F arrow.r X$ are stably isomorphic#index-entry("Stably isomorphic") if $E xor epsilon^n tilde.equiv F xor epsilon^n$, denoted as $E approx F$, we also denote $E tilde.op F$ if $E xor epsilon^n tilde.equiv F xor epsilon^m$ for some $n\,m$

]
#aside("Remark")[
Here stably isomorphic does not imply isomorphic, for example, $T S^2 approx_s epsilon^2$, since $epsilon^3 approx T^2 xor N S^2 approx T^2 xor epsilon^1$ whereas $T S^2$ is not trivial by the hairy ball theorem, and $N S^2 approx epsilon^1$ is trivial because it is very easy to find a nonvanishing global section

]
#statement("Definition")[
Define the reduced K group to be $tilde(K)\(X\)$ which consists of $tilde.op$-equivalent classes, and define K group to be the formal difference of isomorphic classes $E - F$, and $E - F = E' - F'$ if $E xor F' xor G tilde.equiv E' xor F xor G$ for some vector bundle $G$

]
#aside("Remark")[
When $X$ is compact Hausdorff, $E xor F' xor G tilde.equiv E' xor F xor G$ is equivalent to $E xor F' xor epsilon^m tilde.equiv E' xor F xor epsilon^m$, since we can find $G'$ such that $G xor G' tilde.equiv epsilon^m$ due to Theorem #ref(label("X compact Hausdorff => E has complement"), supplement: none)

$K\(*\)= { epsilon^m - epsilon^n } tilde.equiv bb(Z)$, $tilde(K)\(*\)= 0$, and when $X$ compact Hausdorff we have an exact sequence $0 arrow.r K\(*\)arrow.r K\(X\)arrow.r tilde(K)\(X\)arrow.r 0$, where $K\(*\)arrow.r K\(X\)$ is simply given by $epsilon^m - epsilon^n mapsto epsilon^m - epsilon^n$, $K\(X\)arrow.r tilde(K)\(X\)$ is defined as follows, given $E - F in K\(X\)$, $E - F = E xor F' - F xor F' = E' - epsilon^m$ is mapped to $E'$, this exact sequence splits since we have map $K\(X\)arrow.r K\(*\)$ given by restriction

]
#statement("Conjecture")[
Let $M$ be the Möbius line bundle over $S^1$, since $M xor M tilde.equiv epsilon^2$, and $M times.o M tilde.equiv epsilon^1$, thus real $K$-theory of $S^1$ is isomorphic to $bb(Z)\[M\]\/\(M^2 - 1\,2 M - 2\)$

]
#statement("Example")[
Let $S^n subset bb(R)^(n + 1)$ be the unit sphere, $T S^n\,N S^n$ be the tangent bundle and normal bundle, then $T S^n xor N S^n$ can be seen as the restriction of the trivial bundle $bb(R)^(n + 1) times bb(R)^(n + 1)$ on $S^n$, thus $T S^n xor N S^n$ is trivial

]
#statement("Definition")[
Define external product $K\(X\)times.o K\(Y\)arrow.r K\(X times Y\)\,a times.o b mapsto p_1^(*)\(a\)p_2^(*)\(b\)= : a times b$, this is a ring homomorphism

]
#statement("Definition")[
Suppose $G$ is a topological group, $P_G$ is the contravariant functor from the category of CW complexes to the category of sets, mapping $X$ to all the principal $G$ bundles over $X$, a #strong[classifying space] $B G$ is a topological space such that $\[-\,B G\]arrow.r P_G\(-\)$ is a natural isomorphism

]
#statement("Lemma")[
$B G$ is unique up to weak homotopy equivalence

]
#proof(title: "Proof")[
Suppose $B' G$ is also a classifying space, then $\[-\,B G\]tilde.equiv P_G\(-\)tilde.equiv\[-\,B' G\]$ are natural isomorphic, by Theorem #ref(label("CW approximation"), supplement: none), we may assume $B G$, $B' G$ are both CW complexes, and by Lemma #ref(label("Yoneda lemma"), supplement: none), $X arrow.r H o m\(-\,X\)$ is fully faithful functor, thus $B G\,B' G$ are homotopic

]
#statement("Theorem", title: [Milnor's contruction for classifying space])[
Define $E^n G$ to be $overbrace(G * dots.h.c * G, n + 1)$ are formal sums $t_0 g_0 + t_1 g_1 + dots.h.c + t_n g_n$, with $sum t_i = 1$. $E G := lim_arrow.r E^n G$ are finite formal sums $sum t_i g_i$ with $sum t_i = 1$. $E^n G arrow.r E^n G\/G$, $E G arrow.r E G\/G = : B G$ are principal $G$ bundles, any principal $G$ bundle over $X$ is a pullback bundle of $E G arrow.r^p B G$

]
#proof(title: "Proof")[
Define $G$ right action on $E^n G\,E G$ #display-equation($E^n G times G arrow.r E^n G\,(sum t_i g_i \, g) mapsto sum t_i g_i g$) #display-equation($E G times G arrow.r E G\,(sum t_i g_i \, g) mapsto sum t_i g_i g$) Let $U_i = {p (sum t_i g_i) mid(bar.v) t_i eq.not 0}$, then we would have a equivariant homeomorphism $p^(- 1)\(U_i\)arrow.r U_i times G\,sum t_i g_i mapsto (p (sum t_i g_i) \, g_i)$ with inverse $U_i times G arrow.r p^(- 1)\(U_i\)\,(p (sum t_i g_i) \, g) mapsto sum t_j g_j g_i^(- 1) g$, this is well defined since $(p (sum t_i g_i h) \, g) mapsto sum t_j g_j h h^(- 1) g_i^(- 1) g = sum t_j g_j g_i^(- 1) g$

]
#statement("Definition")[
A #strong[topological category]#index-entry("Topological category") $cal(C)$ is a small category where $o b cal(C)$, $m o r cal(C)$ are topological spaces and $i : o b cal(C) arrow.r m o r cal(C)\,c mapsto 1_c$, $s : m o r cal(C) arrow.r o b cal(C)\,c arrow.r^f d mapsto c$, $t : m o r cal(C) arrow.r o b cal(C)\,c arrow.r^f d mapsto d$, $compose : m o r cal(C) times m o r cal(C) arrow.r m o r cal(C)$ are continuous. A #strong[continuous functor]#index-entry("Continuous functor") between topological categories is a functor that are continuous on both objects and morphisms

]
#statement("Definition")[
Define #strong[nerve]#index-entry("Nerve") $N cal(C)$ on category $cal(C)$ which is also a simplicial set, $N cal(C)\(\[n\]\):= H o m\(\[n\]\,cal(C)\)$, the set of all functors from $\[n\]$ to $cal(C)$, viewing $\[n\]= 0 arrow.r 1 arrow.r dots.h.c arrow.r n$ as a category

]#label("Nerve of a category")
#statement("Definition", title: [Segal's contruction for classifying space])[
Define the classifying space of $cal(C)$ to be $B cal(C) :=\|N cal(C)\|$ as in Definition #ref(label("Nerve of a category"), supplement: none)

]
