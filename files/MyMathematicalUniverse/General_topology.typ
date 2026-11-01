#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= General topology

#statement("Definition")[
A #emph[topological space]#index-entry("Topological space") $X$ is a set with #emph[topology]#index-entry("Topology") $tau subset.eq cal(P)\(X\)$, such that $diameter\,X in tau$, $U_i in tau arrow.r.double union.big_i U_i in tau$, $U\,V in tau arrow.r.double U inter V in tau$, elements in $tau$ are #emph[open sets]#index-entry("Open set"), complements of open sets are #emph[closed sets]#index-entry("Closed set")

$N$ is a #emph[neighborhood]#index-entry("Neighborhood") of $A subset.eq X$ if $A subset.eq U subset.eq N subset.eq X$ for some open set $U$

$x$ is a #emph[limit point]#index-entry("Limit point") of $A$ if any neighborhood of $x$ intersects $A$. $x$ is a #emph[limit] of ${ x_n }$ if for any neighborhood $U$ of $x$, all but finitely many lies in $U$

A #emph[subspace] is $A subset.eq X$ with #emph[subspace topology]#index-entry("Subspace topology") given by ${ U inter A\|U in tau }$

]
#statement("Definition")[
$X arrow.r^f Y$ is #emph[continuous]#index-entry("Continuous") at $x$ if for any neighborhood $V$ of $y = f\(x\)$, there exists a neighborhood $U$ of $x$ such that $f\(U\)subset.eq V$. Then $f$ is continuous iff $f^(- 1)\(V\)$ is open for any open set $V subset.eq Y$

]
#statement("Definition")[
A #emph[base]#index-entry("Base of a topology") for $tau$ is $B subset.eq tau$ such that $B$ covers $X$ and for any $U_1\,U_2 in B$ such that $U_1 inter U_2 eq.not diameter$, there exists $U_3 in B$ such that $U_3 subset.eq U_1 inter U_2$

A #emph[local base]#index-entry("Local base") for $tau$ at $x$ is a collection of neighborhoods $B\(x\)$ of $x$ such that any neighborhood of $x$ contain an element of $B\(x\)$

A #emph[subbase]#index-entry("Subbase") for $tau$ is $B subset.eq tau$ such that $B$ generates $tau$, i.e. by arbitrary union of finite intersections, equivalently, $tau$ is the smallest topology containing $B$. Here empty union and empty intersection are $diameter$ and $X$

]
#statement("Definition")[
$X$ is #emph[first countable]#index-entry("First countable") if each point has a countable local base. $X$ is #emph[second countable]#index-entry("Second countable") if it has a countable base

]
#statement("Definition")[
$X$ is #emph[regular]#index-entry("Regular topological space") if any point and a disjoint closed set have disjoint neighborhoods. $X$ is #emph[normal]#index-entry("Normal topological space") if disjoint closed sets have disjoint neighborhoods

]
#statement("Definition")[
${ A_i }$ can be #emph[completely separated] if ${ A_i }$ can be completely separated by a continuous function $X arrow.r^f bb(R)$. Closed subsets ${ A_i }$ can be #emph[perfectly separated]#index-entry("perfectly separated") if ${ A_i }$ can be perfectly separated by a continuous function $X arrow.r^f bb(R)$. $bb(R)$ can be replaced with $I$ considering $bb(R) arrow.r I$, $x mapsto cases(frac(x, x - 1) quad x lt.eq 0, x quad 0 lt.eq x lt.eq 1, frac(2, x + 1) quad x gt.eq 1)$ and $I arrow.r.hook bb(R)$

#figure([#universe-drawing(16.0)],
  caption: [
  ]
)

]
#statement("Definition", title: [Kolmogorov classification of topological spaces])[
#index-entry("Kolmogorov classification of topological spaces") $X$ is a $T_0$ #emph[space] if for any two distinct points in $X$, at least one of them has a neighborhood which doesn't intersect the other piont, i.e. they are #emph[topologically distinguishable]

$X$ is a $T_1$ #emph[space] if for any two distinct points in $X$, each of them has a neighborhood which doesn't intersect the other point. $T_1$ $arrow.l.r.double$ points are closed

$X$ is a $T_2$ #emph[space] or #emph[Hausdorff space]#index-entry("Hausdorff space") if any two distinct points have disjoint neighborhoods. Then the limit of ${ x_n }$ is unique, denotes the limit $x = lim x_n$

$X$ is a $T_(2 zws^1\/_2)$ #emph[space] or #emph[Urysohn space]#index-entry("Urysohn space") if any two distinct points have disjoint closed neighborhoods

$X$ is a $T_3$ #emph[space] if $X$ is regular Hausdorff

$X$ is a $T_(3 zws^1\/_2)$ #emph[space] if $X$ is completely regular Hausdorff

$X$ is a $T_4$ #emph[space] if $X$ is normal $T_1$ space $arrow.l.r.double$ normal Hausdorff

$X$ is a $T_5$ #emph[space] if $X$ is completely normal Hausdorff

$X$ is a $T_6$ #emph[space] if $X$ is perfectly normal $arrow.l.r.double$ perfectly normal Hausdorff

]
#statement("Definition")[
$A subset.eq X$ is #emph[nowhere dense] if the interior of $overline(A)$ is $diameter$

]
#statement("Definition")[
$X$ is #emph[sequential compact] if every sequence has a convergent subsequence

]
#statement("Definition")[
The #emph[box topology]#index-entry("Box topology") on $product_(i in I) X_i$ has base ${product_(i in I) U_i mid(bar.v) U_i subset.eq X_i upright(" open")}$

]
#statement("Lemma")[
$X$ is Hausdorff iff the diagonal ${\(x\,x\)\|x in X }$ is closed

]
#proof(title: "Proof")[

]
#statement("Definition")[
$X times I arrow.r^F Y$ is a #emph[homotopy]#index-entry("Homotopy") between $X arrow.r^(f_0\,f_1) Y$ if $F\(x\,0\)= f_0\(x\)$, $F\(x\,1\)= f_1\(x\)$, write $f_t = F\(dot.op\,t\)$. $X arrow.r^f Y$ is a #emph[homotopy equivalence]#index-entry("Homotopy equivalence") if there is $Y arrow.r^g X$ such that $g f tilde.eq 1_X$, $f g tilde.eq 1_Y$

]
#statement("Definition")[
$X arrow.r^f Y$ is a #emph[topological embedding] if $f : X arrow.r f\(X\)$ is a homeomorphism

]
#statement("Definition")[
$K subset.eq X$ is #emph[compact]#index-entry("Compact") if any open cover has a finite subcover. Equivalently, $K$ is disjoint from the intersection of a family of closed sets, then $K$ is disjoint from the intersection of finitely many of them

$X$ is #emph[locally compact]#index-entry("Locally compact") if there is a compact neighborhood for each point

$Y subset.eq X$ is #emph[precompact]#index-entry("Precompact") if $overline(Y)$ is compact

]
#statement("Definition")[
$A subset.eq X$ is #emph[dense]#index-entry("Dense") if $overline(A) = X$

$X$ is #emph[separable]#index-entry("Separable space") if $X$ has a countable dense subset

]
#statement("Definition")[
$X_alpha subset.eq X$, ${ X_alpha }$ is #emph[locally finite]#index-entry("Locally finite") if for any $x in X$, there is a neighborhood of $x$ intersecting only finitely many $X_alpha$'s

$cal(U) = { U_alpha }$, $cal(V) = { V_beta }$ are covers of $X$, $cal(V)$ is a #emph[refinement]#index-entry("Refinement") of $cal(U)$ if for any $V_beta$, there exists $U_alpha$ containing $V_beta$

$X$ is #emph[paracompact]#index-entry("Paracompact") if every open cover has a locally finite open refinement

]
#statement("Lemma")[
Closed subsets of compact space are closed

The image of a compact set is compact

Compact subsets of a Hausdorff space are closed

]
#statement("Lemma")[
$X$ is compact, $Y$ is Hausdorff, an injective map $X arrow.r^f Y$ is a topological embedding

]#label("X compact, Y Hausdorff, injective maps are embeddings")
#proof(title: "Proof")[
$f : X arrow.r f\(X\)$ is a continuous bijection. If $K subset.eq X$ is closed, $K$ is also compact since $X$ is compact, thus $f\(K\)$ is compact, $f\(K\)$ is also closed since $Y$ is Hausdorff

]
#statement("Definition")[
$X$ is called #emph[connected]#index-entry("Connected") if it can be written as the union of two open subsets

$X$ is called #emph[locally connected]#index-entry("Locally connected") if for any $x in X$, there is a local basis that are connected

]
#statement("Proposition")[
Connected components are closed

Connectedness and local path connectedness implies path connectedness

]
#aside("Remark")[
Connected components may not be open

]
#statement("Definition")[
$E arrow.r^p B$ has #emph[lift extension property]#index-entry("Lift extension property") for $\(X\,A\)$ if for any $X arrow.r^f B$, a lift $A arrow.r^(tilde(f)) E$ can be extended to $tilde(f) : X arrow.r E$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$E$]),
node((0,1),[$X$]),
node((1,1),[$B$]),
edge((0,0),(1,0),"->",[$tilde(f)$]),
edge((0,0),(0,1),"hook->"),
edge((1,0),(1,1),"->",[$p$]),
edge((0,1),(1,0),"->",[$tilde(f)$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->",[$f$]))]
]
$E arrow.r^p B$ has #emph[homotopy lifting property]#index-entry("Homotopy lifting property") for $\(X\,A\)$ if it has lift extension property for $\(X times I\,X times { 0 } union A times I\)$

]
#statement("Proposition")[
If $\(X\,A\)$ satisfies homotopy extension property, and $A$ is contractible, then the quotient map $X arrow.r^q X\/A$ is a homotopy equivalence

]
#proof(title: "Proof")[
Consider $X times { 0 } union A times I arrow.r A arrow.r.hook X$, where $\(x\,0\)mapsto x$, $\(a\,1\)mapsto *$ can be extended to $f : X times I arrow.r X$, $f_0 = 1_X$, $f_1\(A\)= { * }$, thus $f_1$ induces $r : X\/A arrow.r X$, $f_1 = r q$, $X times I arrow.r^f X arrow.r^q X\/A$ also induce $g : X\/A times I arrow.r X\/A$, where $q f_t = g_t q$, and $g_0 = 1_(X\/A)$, $g_1 = q r$ thus $q r tilde.eq 1_(X\/A)$

]
#statement("Definition")[
$U subset.eq X$ is open if $U inter K$ is open for any compact subspace $K subset.eq X$ defines a topology. Equivalently, $F subset.eq X$ is closed if $F inter K$ is closed for any compact subspace $K subset.eq X$. $X$ is #emph[compactly generated]#index-entry("Compactly generated") if $X$ has this topology

]
#statement("Definition")[
A map is #emph[proper]#index-entry("Proper map") if the preimage of a compact set is compact

A map is #emph[discrete]#index-entry("Discrete map") if the preimage of a discrete set is discrete

]
#statement("Definition")[
$X$ has #emph[discrete topology]#index-entry("Discrete topology") if $tau = cal(P)\(X\)$. $X$ has #emph[trivial topology]#index-entry("Trivial topology") if $tau = { diameter\,X }$

]
#statement("Proposition")[
Suppose $X$ has discrete topology

#emph[\(a)] Any map $f : Y arrow.r X$ is continuous iff $f^(- 1)\(x\)$ is open for all $x in X$

#emph[\(b)] If continuous maps $f\,g : X arrow.r X$ are homotopic, then they are actually the same

]#label("Properties of discrete topology")
#proof(title: "Proof")[
$quad$ #emph[\(a)] For any subset $U subset.eq X$, $f^(- 1)\(U\)= union.big_(x in U) f^(- 1)\(x\)$ is open

#emph[\(b)] If $F : X times I arrow.r X$ is a homotopy, then the restriction on ${ x } times I$ is gives a continuous map $I arrow.r X$, the image has to be connected, thus the restriction is a constant, thus $f\(x\)= F\(x\,0\)= F\(x\,1\)= g\(x\)$

]
#statement("Lemma")[
$F_i subset.eq X$ are closed, $union.big_i F_i = X$, $f\|_(F_i)$ are continuous, then $f$ is continuous

]#label("Pasting lemma")
#statement("Lemma")[
If $X$ is compact, $Y$ is Hausdorff, a surjective continuous map $f : X arrow.r Y$ is a quotient map

]#label("X compact + Y Hausdorff => f:X->Y quotient map")
#proof(title: "Proof")[
Let's use the universal property of quotient space, consider a continuous map $g : X arrow.r Z$ such that $g$ maps fibers of $f$ to points, thus we have a map $tilde(g) : Y arrow.r Z$, $tilde(g) f = g$, for any closed set $F$ in $Z$, so is $K = g^(- 1)\(F\)= f^(- 1)\(tilde(g)^(- 1)\(F\)\)$, since $X$ is compact, so is $K$, hence $f\(K\)= tilde(g)^(- 1)\(F\)$ is compact, and since $Y$ is Hausdorff, $tilde(g)^(- 1)\(F\)$ is closed

]
#statement("Lemma")[
$X$ is locally compact, Hausdorff, $F subset.eq X$ is closed iff $F inter K$ is compact for any compact subset $K subset.eq X$

]#label("X locally compact+Hausdorff, F closed iff F intersects K is compact for any K compact")
#proof(title: "Proof")[
$F$ closed $arrow.r.double F inter K$ closed. Conversely, suppose $F inter K$ is compact for any compact subsets $K subset.eq X$, for any $x in.not F$, there is a compact set $K$ containing an open neighborhood $U$ of $x$, $F inter K$ is compact thus closed, hence $G = U - F inter K$ is an open neighborhood of $x$ which is disjoint of $F$, hence $F$ is closed

]
#statement("Lemma")[
$X\,Y$ are locally compact, Hausdorff, $p : X arrow.r Y$ is continuous, proper, then $p$ is closed

]
#proof(title: "Proof")[
Suppose $F subset.eq X$ is closed, since $p (F inter p^(- 1) \( K \)) = p\(F\)inter K$, by Lemma #ref(label("X locally compact+Hausdorff, F closed iff F intersects K is compact for any K compact"), supplement: none), we can take any $K subset.eq Y$ compact, hence $F$ is closed

]
#statement("Definition")[
$X$ is noncompact, the #emph[Alexandorff extension]#index-entry("Alexandorff extension") of $X$ is $X^(*) = X union { oo }$ with open sets $diameter\,X^(*)$, open sets in $X$ and complements of closed compact sets of $X$

$X arrow.r.hook X^(*)$ is an open topological embedding

If $X$ is also locally compact Hausdorff, $X^(*)$ is the #emph[one point compactification]#index-entry("One point compactification") of $X$ which is Hausdorff

]
#statement("Lemma")[
$X\,Y$ are locally compact Hausdorff, $X arrow.r^f Y$ is proper, then $f$ sends discrete sets to discrete sets

]#label("X,Y locally compact Hausdorff, f:X->Y proper, f send discrete sets to discrete sets")
#proof(title: "Proof")[
Suppose $A subset.eq X$ is discrete, $x_0 in A$, $y_0 = f\(x_0\)in Y$, $K$ is a compact neighborhood of $y_0$, then $f^(- 1)\(K\)$ is a compact neighborhood of $x_0$, thus $f^(- 1)\(K\)inter A$ is finite, so is $K inter f\(A\)$, since $Y$ is Hausdorff, there is a neighborhood $U$ of $y_0$ such that $U inter f\(A\)= y_0$

]
#statement("Lemma")[
$X\,Y$ are locally compact, $X arrow.r^p Y$ is proper and discrete, then $p^(- 1)\(y\)$ is finite, and for any neighborhood $V$ of $p^(- 1)\(y\)$, there is a neighborhood $U$ of $y$ such that $p^(- 1)\(U\)subset.eq V$

]
#statement("Lemma")[
$X\,Y$ are locally compact Hausdorff, $X arrow.r^p Y$ is a proper local homeomorphism, then $p$ is a finite sheeted covering

]
#statement("Definition")[
The #emph[compact-open topology]#index-entry("Compact-open topology") on $Y^X$ is given by a subbase $V\(K\,U\):= {f in Y^X mid(bar.v) f \( K \) subset.eq U}$, with $K subset.eq X$ compact and $U subset.eq Y$ open

A #emph[normal family]#index-entry("Normal family") ${ f_i }$ is a precompact subset of $Y^X$

]
#statement("Lemma")[
${ f_n }$ converges pointwise on $X$ iff ${ f_n }$ converges in $Y^X$ with the product topology $product_(x in X) Y$. Hence we call the product topology the #emph[topology of pointwise convergence]#index-entry("Topology of pointwise convergence")

]
#proof(title: "Proof")[
If $f_n$ converges pointwise on $X$ to $f$, then for any neighborhood $V_i$ of $f\(x_i\)$, $i = 1\,dots.h.c\,k$, $V_k$ contains all but finitely many $f_n\(x_i\)$, thus for $n$ big enough, $f_n in V_1 inter dots.h.c inter V_k inter product_(x eq.not x_0) Y$, i.e. ${ f_n }$ converges to $f$ in $Y^X$

]
#statement("Theorem")[
$X$ is compact, $Y$ is a complete metric space, then the topology induced by metric $d\(f\,g\)= sup_(x in X) d\(f\(x\)\,g\(x\)\)$ is the same as the compact-open topology on $Y^X$

]
#statement("Theorem")[
$Y^(*) tilde.equiv Y$

]
#statement("Theorem")[
The composition $Z^Y times Y^X arrow.r Z^X\,\(g\,f\)mapsto g compose f$ is continuous, in particular, if $X = *$, then this becomes the evaluation map $upright(e v a l) : Z^Y times Y\,\(f\,y\)mapsto f\(y\)$

]
#statement("Theorem")[
$Z^(X times Y) tilde.equiv (Z^Y)^X$

]
#statement("Definition")[
A topological space $X$ is reducible if $X = X_1 union X_2$, $X_1\,X_2$ are proper nonempty closed subsets, $X_1 subset.eq.not X_2$, $X_2 subset.eq.not X_1$, $X$ is #emph[irreducible]#index-entry("Irreducible topological spaces") if not reducible

]
#statement("Definition")[
A topological space $X$ is #emph[Noetherian]#index-entry("Noetherian topological space") if $X supset.neq X_1 supset.neq X_2 supset.neq dots.h.c$ terminates, $dim V = sup_d\(X_0 supset.neq X_1 supset.neq dots.h.c supset.neq X_d\)$, $V_i$'s are closed and irreducible

]
#statement("Theorem", title: [Tychonoff's theorem])[
${ K_i }_(i in I)$ are compact, so is $product_(i in I) K_i$

]#label("Tychonoff's theorem")
#statement("Proposition")[
Connected sets of $bb(R)$ are intervals $\(a\,b\)$, $\[a\,b\)$, $\(a\,b\]$ or $\[a\,b\]$

]
#statement("Theorem", title: [Jordan curve theorem])[
#index-entry("Jordan curve theorem") $S^n arrow.r^i bb(R)^(n + 1)$ is injective thus an open embedding by Lemma #ref(label("X compact, Y Hausdorff, injective maps are embeddings"), supplement: none), denote $X = i\(S^n\)$, then $Y = bb(R)^(n + 1)\\X$ consists of exactly two connected components, the interior $U$ which is bounded, and the exterior $V$ which is not. When $n = 1$, $U$ and $V$ are homeomorphic to $D$ and $bb(R)^2\\D$

]#label("Jordan curve theorem")
#statement("Definition")[
$W subset.eq X$ is a #emph[locally closed set]#index-entry("Locally closed set") if for any point $p in W$, there is an open neighborhood $U in.rev p$ such that $U inter W$ is closed in $U$. Equivalently, $W$ is the intersection of an open subset and a closed subset, or equivalently, $W$ is relatively open in $overline(W)$. A #emph[constructible set]#index-entry("Constructible set") is a finite union of locally closed sets

]
#statement("Theorem", title: [Lefschetz fixed point theorem])[
#index-entry("Lefschetz fixed point theorem") $X$ is a compact triangulable space of dimension $n$, the #emph[Lefschetz number]#index-entry("Lefschetz number") of $f$ is $sum_(k = 0)^n "tr"\(f_(*)\|_(H_k\(X\;bb(Q)\))\)$. If the Lefschetz number of $f$ is nonzero, then $f$ has fixed points. The converse is not true, i.e. even if the Lefschetz number is zero, then could be fixed points

If $f = "id"_X$, then the Lefschetz number is the Euler characteristic $chi$

]#label("Lefschetz fixed point theorem")
#statement("Definition")[
The #emph[join]#index-entry("Join") of $X\,Y$ is #display-equation($X * Y = frac(X times Y times I, \(x\,y_1\,0\)tilde.op\(x\,y_2\,0\)\,\(x_1\,y\,1\)tilde.op\(x_2\,y\,1\))$) We can also interpret it as all possible paths from $X$ to $Y$. In general, $*_i X_i$ can be thought of as finite sum $sum_i t_i x_i$, $t_i in I$, $x_i in X_i$

]
#statement("Definition")[
$X$ is #emph[Noetherian] if every descending chain of subspaces is finite

]
#statement("Proposition")[
+ Subspaces of Noetherian spaces are Noetherian

+ $X$ is Noetherian iff $X$ is locally Noetherian and compact

]
#proof(title: "Proof")[
+ A descending chain of a subspace is also a descending chain

+

]
#statement("Definition")[
A covering space is a fiber bundle with discrete fibers

]
#statement("Proposition")[
$Z arrow.r^p X$ is a covering, $f\(y_0\)= p\(z_0\)$. $f$ lifts $tilde(f) : Y arrow.r Z$ with $f\(y_0\)= z_0$ iff $f_(*) pi_1\(Y\,y_0\)lt.eq p_(*) pi_1\(Z\,z_0\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$Z$]),
node((0,1),[$Y$]),
node((1,1),[$X$]),
edge((1,0),(1,1),"->",[$p$]),
edge((0,1),(1,1),"->",[$f$]),
edge((0,1),(1,0),"->",[$exists_1 tilde(f)$]))]
]
]#label("Unique lifting iff fundamental group is a subgroup")
#statement("Proposition")[
Covering $Y arrow.r^p X$ is regular if $"Aut"\(Y\/X\)$ is a normal subgroup of $pi_1\(X\,x_0\)$

]
#proof(title: "Proof")[
Assume $p\(y_1\)= p\(y_2\)= x_0$, by Proposition #ref(label("Unique lifting iff fundamental group is a subgroup"), supplement: none), $p_(*) pi_1\(Y\,y_1\)= p_(*) pi_1\(Y\,y_2\)$ are conjugate, hence normal

]
#statement("Definition")[
$A arrow.r^i X$ is inclusion. A #strong[deformation]#index-entry("Deformation") of $A$ into $B subset.eq X$ in $X$ is a homotopy $A arrow.r^(f_t) X$ such that $f_0 = i$ and $f_1\(A\)subset.eq B$, onto if equality holds. $X arrow.r^r A$ is a #strong[retraction]#index-entry("Retraction") if $r i = 1_A$. $r$ is a #strong[weak retraction]#index-entry("Weak retraction") if inclusion $A arrow.r^i X$ has a left homotopy inverse, i.e. $r i tilde.eq 1_A$. A #strong[deformation retraction]#index-entry("Deformation retraction") is a deformation $X arrow.r^(f_t) X$ such that $f_1 = r i$ for some retraction $X arrow.r^r A$. Deformation retraction $f_t$ is #strong[strong]#index-entry("Strong deformation retraction") if $f_t\|_A = 1_A$

$X$ is #strong[contractible]#index-entry("Contractible") if $X$ deformation retracts onto a point

$\(X\,A\)$ is a #strong[good pair]#index-entry("Good pair of topological spaces") if $A$ is a strong neighborhood deformation retract of $X$

]
#statement("Lemma")[
$A arrow.r^i X$ is inclusion

+ $X$ is deformable into $A$ iff $i$ is a #strong[weak section], namely $i$ has a right homotopy inverse, i.e. $i r tilde.eq 1_X$

+ $i$ is a homotopy equivalence iff $A$ is a weak retract of $X$ and $X$ is deformable into $A$

+ If $X$ is deformable into a retract $A$, then $A$ is a deformation retract of $X$

+ If $\(X\,A\)$ is cofibered, then $A$ is a weak retract of $X$ iff $A$ is a retract of $X$

]#label("Some rudimentary lemma about retract and deformation")
#proof(title: "Proof")[
+ If $X times I arrow.r^H X$ is a homotopy from $1_X$ to $i r$, then $H$ is a deformation of $X$ into $A$ since $H_0 = 1_X$, $H_1\(X\)subset.eq A$. If $H$ is a deformation of $X$ into $A$, since $H_1\(X\)subset.eq A$, define $X arrow.r^r A$ such that $i r = H_1$, then $r$ is a right homotopy inverse of $i$

+ $i$ is a homotopy equivalence $arrow.l.r.double$ there exists $X arrow.r^r A$ such that $r i tilde.eq 1_A$, $1_X tilde.eq^H i r$ $arrow.l.r.double$ $r$ is a weak retract, $H$ is a deformation of $X$ into $A$

+ $X arrow.r^r A$ is a retraction, $X times I arrow.r^H X$ is a deformation of $X$, then $1_X tilde.eq i r'$ for some $X arrow.r^(r') A$, hence $r tilde.eq r i r' = r'$ $arrow.r.double$ $1_X tilde.eq i r tilde.eq i r$ giving a deformation retract

+ $A times I arrow.r^H A$ is a homotopy from $r i$ to $1_A$, since $r\(a\)= H_0\(a\)$ and $\(X\,A\)$ is cofibered, we have $X times I arrow.r^F A$, then $F_0 = r$, $F_1 i = 1_A$, i.e. $r$ is homotopic to retraction $F_1$

]
#statement("Definition")[
$cal(C)$ is a class of topological spaces closed under homeomorphism and closed subsets. $X$ is an #strong[absolute retract]#index-entry("Absolute retract") for $cal(C)$ if for $Y in cal(C)$, embedding $X arrow.r.hook Y$ is closed $arrow.r.double$ $X$ is a retract of $Y$. $X$ is an #strong[absolute neighborhood retract]#index-entry("Absolute neighborhood retract") for $cal(C)$ if for $Y in cal(C)$, embedding $X arrow.r.hook Y$ is closed $arrow.r.double$ $X$ is a neighborhood retract of $Y$

]
