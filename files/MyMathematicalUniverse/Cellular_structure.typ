#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Cellular structure

#statement("Definition")[
An #strong[abstract simplicial complex]#index-entry("abstract simplicial complex") is $K subset.eq cal(P)\(S\)\\diameter$ such that $X in K arrow.r.double cal(P)\(X\)\\diameter subset.eq K$. Finite elements of $K$ are called #strong[faces]. The #strong[dimension] of a face $X$ is $dim X =\|X\|- 1$. The $d$ skeleton $K^d$ is the union of faces of dimension no more than $d$. $dim K = sup_(X in K) dim X$. $K^0$ are #strong[vertices]. Maximal elements are #strong[facets]. $K$ is #strong[pure] if all facets have dimension $dim K$. A #strong[simplex] is a subcomplex which contains all its nonempty subsets, for $X in K$, $overline(X)$ is the corresponding simplicial complex

]
#statement("Definition")[
The #strong[closure] $overline(L)$ of $L subset.eq K$ is smallest subcomplex of $K$ containing $L$. The #strong[star] of $Y in K$ is $"st" L = { X\|X inter Y eq.not 0 }$, the star of $L subset.eq K$ is $"st" L = union.big_(Y in L) "st" Y$. The #strong[link] of a face $Y in K$ is or $"lk" Y = { X\|X inter Y = diameter\,X union Y in X }$. Equivalently, $"lk" Y = overline("st" Y) - "st" overline(Y)$

#figure([#box(image("Pictures/Closure_of_a_complex.png", width: 65.0%))],
  caption: [
    Two simplices and their closure
  ]
)
#label("Closure of a complex")

#figure([#box(image("Pictures/Star_of_a_complex.png", width: 65.0%))],
  caption: [
    A vertex and its star
  ]
)
#label("Star of a complex")

#figure([#box(image("Pictures/Link_of_a_complex.png", width: 65.0%))],
  caption: [
    A vertex and its link
  ]
)
#label("Link of a complex")

]
#aside("Note")[
$"lk" diameter = K$

]
#statement("Definition")[
If $K\,L$ has disjoint sets of vertices, then $K * L = { X union.sq Y\|X in K\,Y in L }$

]
#statement("Definition")[
$L subset.eq K$, the #strong[deletion] $K\\L$ consists of those sets which don't contain sets in $L$ as subsets. The stellar subdivision of $X in K$ is by introducing a new vertex $x$, and form $K\\X union\(overline(x) * partial overline(X) * "lk" X\)$

]
#statement("Definition")[
A simplicial map $f : K arrow.r L$ is such that $f\(K^d\)subset.eq L^d$

]
The Eilenberg-Zilber map $C_(*)\(X\)times.o C^(*)\(Y\)arrow.r C^(*)\(X times Y\)$ is a quasi-isomorphism

Take $X\,Y = I$

#align(center)[
#universe-drawing(1.0)
]
The map sends $v_1 times.o v_3 mapsto v_5\,v_1 times.o v_4 mapsto v_8\,v_2 times.o v_3 mapsto v_6\,v_2 times.o v_4 mapsto v_7\,e_1 times.o v_3 mapsto e_5\,e_1 times.o v_4 mapsto e_7\,v_1 times.o e_2 mapsto e_8\,v_2 times.o e_2 mapsto e_6\,e_1 times.o e_2 mapsto f$. The we get the quasi-isomorphism

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$bb(Z)\[{ e_1 times.o e_2 }\]$]),
node((2,0),[$bb(Z)\[{ e_1 times.o v_3\,e_1 times.o v_4\,v_1 times.o e_2\,v_2 times.o e_2 }\]$]),
node((3,0),[$bb(Z)\[{ v_1 times.o v_3\,v_1 times.o v_4\,v_2 times.o v_3\,v_2 times.o v_4 }\]$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$bb(Z)\[{ f }\]$]),
node((2,1),[$bb(Z)\[{ e_5\,e_7\,e_8\,e_6 }\]$]),
node((3,1),[$bb(Z)\[{ v_5\,v_8\,v_6\,v_7 }\]$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
#statement("Definition")[
With the standard basis ${ e_i }$ for $bb(R)^oo$ as vertices, the #strong[standard] $n$#strong[\-simplice] is #display-equation($Delta^n = {\( t_0 \, dots.h.c \, t_n \) in bb(R)^(n + 1) subset.eq bb(R)^oo mid(bar.v) sum t_i = 1 \, 0 lt.eq t_i lt.eq 1}$) The $i$#strong[\-th face] of $Delta^n$ is the face oppose to the $i$-th vertex, i.e. ${t_i = 0} inter Delta^n$

The #strong[boundary] of $Delta^n$ to be $partial Delta^n$ is the union of faces. $partial Delta^0 = diameter$

#align(center)[
#universe-drawing(2.0)
]
$Delta^(n - 1) arrow.r^(d_(n\,i)) Delta^n$, $e_j mapsto cases(e_j quad j < i, e_(j + 1) quad j gt.eq i)$ is $i$-th #strong[face map] attaching $Delta^(n - 1)$ to the $i$-th face of $Delta^n$

$Delta^(n + 1) arrow.r^(s_(n\,i)) Delta^n$, $e_j mapsto cases(e_j quad j lt.eq i, e_(j - 1) quad j > i)$ is the $i$-th #strong[degeneracy map] which is a projection

]#label("Standard simplex")
#statement("Definition")[
$X$ has a #strong[cell decomposition]#index-entry("Cell decomposition") if $X$ can be written as the disjoint union of open $n$ cells, i.e. $X = union.big_(n\,alpha) e_alpha^n$, where cells $e_alpha^n$ with subspace topology are homeomorphic to open $n$ disks or open $n$ simplices and disjoint, $X^n = union.sq.big_(k lt.eq n\,alpha) e_alpha^k$ is called the $upright(bold(n))$#strong[\-skeleton]#index-entry("Skeleton"), define $X^(- 1) = nothing$

Suppose $X\,Y$ have cell decomposition $X = union.big_(n\,alpha) e_alpha^n$, $Y = union.big_(m\,beta) e_beta^m$, then $X times Y$ also has a cell decomposition $X times Y = union.big_k union.big_(n + m = k\
alpha\,beta) e_alpha^n times e_beta^m$, note that $e_alpha^n times e_beta^m tilde.equiv e^(n + m)$

Every topological space has a cell decomposition into points

]
#statement("Definition")[
A #strong[cellular map]#index-entry("Cellular map") is a map $f : X arrow.r Y$ between topological spaces with cell decompositions such that $f\(X^n\)subset.eq Y^n$

]
#statement("Definition")[
$X$ is called a #strong[cell complex]#index-entry("Cell complex") if $X$ is a Hausdorff space with cell decomposition $X = union.big_(n\,alpha) e_alpha^n$ and a cell complex structure: a family of characteristic maps $Phi_alpha^n : Delta^n arrow.r X$ such that $Phi_alpha^n$ restricted on $Delta^n\\partial Delta^n$ is a homeomorphism onto $e_alpha^n$ and $Phi_alpha^n (partial Delta^n) subset.eq X^(n - 1)$

Note that in the definition, we could also replace $Delta^n$ with $D^n$

]
#aside("Remark")[
Since $Delta^n$ is compact Hausdorff and $X$ is Hausdorff, $overline(e_alpha^n) subset.eq Phi_alpha^n (Delta^n)$, $partial e_alpha^n subset.eq Phi_alpha^n (partial Delta^n)$ for $n > 0$, on the other hand, if $partial e_alpha^n subset.neq Phi_alpha^n (partial Delta^n)$, then there exists $x in partial Delta^n$ such that $y = Phi_alpha^n\(x\)in.not overline(e_alpha^n)$, this means there is an open neighborhood $U$ of $y$ disjoint from $overline(e_alpha^n)$, but then the preimage of $U$ under $Phi_alpha^n$ would be a nonempty open subset of $Delta^n$ which intersects $Delta^n\\partial Delta^n$ which is impossible, hence $Phi_alpha^n (Delta^n) = overline(e_alpha^n)$, $Phi_alpha^n (partial Delta^n) = partial e_alpha^n$ for $n > 0$

A Hausdorff space $X$ with a cell decomposition doesn't immediately give a cell complex structure, for example, consider an open disk union with an open segment right in the middle

#align(center)[
#universe-drawing(3.0)
]
Cell complex $X$ can be seen as $Delta^n$ is compact Hausdorff and $X$ is Hausdorff and Lemma #ref(label("X compact + Y Hausdorff => f:X->Y quotient map"), supplement: none)

]
#statement("Definition")[
A cell complex $X$ is called #strong[regular] if all characteristic maps are embeddings

]
#statement("Definition")[
Let $X$ be a cell complex, it is #strong[closure finite] if $overline(e_alpha^n)$ is contained in the union of finitely many cells, and we say $X$ has the #strong[weak topology], meaning $F subset.eq X$ is closed iff $F inter overline(e_alpha^n)$ is closed in $overline(e_alpha^n)$ for any cell, if a cell complex is both closure finite and has the weak topology, we say it is a #strong[CW complex]

Closure finiteness is equivalent of saying $partial e_alpha^n subset.eq union.big_(k < n\,alpha) e_alpha^k$ a finite union of cells

]
#statement("Example")[
Consider $X = D^2$ with a cell complex structure $D^2 arrow.r D^2$ and $* arrow.r x$ for each $x in partial D^2$, this doesn't satisfy closure finiteness since $overline(e^2) = X$, but the weak topology is the same as the original one, since if $F subset.eq D^2$ is closed in the weak topology, then $F inter overline(e^2) = F$ is closed

Consider $X = S^1$ with a cell complex structure $* arrow.r x$ for each $x in S^1$, the weak topology is the discrete topology on $S^1$ which doesn't match with the original topology on $S^1$, but it does satisfy closure finiteness

]
#aside("Remark")[
Suppose $X$ is a CW complex

$X^n$ is obviously closed due to the weak topology

Since $overline(e_alpha^n)$ is contained in the union of finitely many cells, $overline(e_alpha^n)$ contains at most finitely many $0$ cells, thus any union of $0$ cells $F$ is closed because $F inter overline(e_alpha^n)$ is finitely many points which is closed given that $X$ is Hausdorff, therefore $X^0$ is discrete

Suppose $K subset.eq X$ is a compact subset, then $K subset.eq X = union.big e_alpha^n subset.eq union.big overline(e_alpha^n)\\partial e_alpha^n$

contained in finitely many cells, since $K subset.eq union.big overline(e_alpha^n)\\partial e_alpha^n$

if $K inter e_alpha^n eq.not nothing$,

, otherwise $K$ intersects infinitely many cells,

]
#statement("Theorem")[
Another description of CW complexes is as follows:

These two definitions coincides

]
#statement("Proposition")[
Any compact set of a CW complex is contained in finitely many cells

]
#statement("Proposition")[
CW complexes are locally contractible, thus they are locally path connected, hence connectedness and path connectedness are equivalent for CW complexes

]
#statement("Theorem")[
CW complexes are normal, satisfies $T_4$ axiom

]
#statement("Proposition")[
If $A subset.eq X$ is a CW subcomplex, then $\(X\,A\)$ is a good pair

]
#statement("Theorem")[
CW complexes have partitions of unity

]
#statement("Proposition")[
Covering space of CW complexes are CW complexes

]
#statement("Proposition")[
The product of two countable CW complexes is again a CW complex

]
#statement("Theorem", title: [CW approximation])[
For any topological space $X$, there is a $C W$ complex $Z$ and a weak homotopy equivalence $f : Z arrow.r X$, this is called a CW approximation

]#label("CW approximation")
#statement("Theorem", title: [Whitehead's theorem])[
Suppose $f : X arrow.r Y$ is weak homotopy equivalence between CW complexes, then it is a homotopy equivalence

]#label("Whitehead's theorem")
#statement("Definition")[
A #strong[pseudomanifold]#index-entry("pseudomanifold") $M$ is a pure triangulated space of dimension $n$ such that $M$ is not branching, i.e. any two $n$ simplices have precisely one $\(n - 1\)$ common face, $M$ is strongly connected, i.e. any two $n$ simplices can be linked with a sequence of simplices having common $\(n - 1\)$ face pairwise

]
#aside("Note")[
The dual graph $Gamma$ of $M$ is connected and $n$-regular

]
#statement("Example")[
The $0$ dimensional pseudomanifold is the disjoint union of two points, since the empty set has to be the common face two point. The dual graph is a two points joined by an edge, this example is weird

A $1$ dimensional pseudomanifold is a infinite chain or a loop, its dual graph is the same

]
#statement("Definition")[
$D$ is a nonmaximal simplex, then $"lk" D$ is a $n -\|D\|$ pure dimensional simplicial complex. A pseudomanifold such that $"lk" D$ is also pseudomanifolds for any nonmaximal simplex is an #strong[abstract polytope]

]
