#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Set theory

== Set theory
<set-theory>
#statement("Definition")[
${ A_i } subset.eq cal(P)\(X\)$, $X arrow.r^f Y$ is a map. $f$ #strong[separates]#index-entry("Separating function") $A_i$ if $inter.big_i f\(A_i\)= diameter$. $f$ #strong[completely separates]#index-entry("Completely separating function") $A_i$ if $f\(A_i\)= f\(a_i\)$ for some distinct $a_i in A_i$. $f$ #strong[perfectly separates]#index-entry("Perfectly separating function") $A\,B$ if $A_i = f^(- 1)\(a_i\)$ for some $a_i in A_i$

]
#statement("Lemma", title: [Zorn's lemma])[
$P$ is a nonempty poset and every chain has an upper bound, then $P$ contains a maximal element

]#label("Zorn's lemma")
#statement("Theorem", title: [Schröder--Bernstein theorem])[
$A arrow.r^f B$ and $B arrow.r^g A$ are injective, then there exists $A arrow.r^h B$ bijective

]
#statement("Theorem", title: [Inclusion-exclusion principle])[
#index-entry("Inclusion-exclusion principle") $A_1\,dots.h.c\,A_n subset.eq S$ are of finite cardinality, then #display-equation($lr(|union.big_(i = 1)^n A_n|) = sum_(k = 1)^n\(- 1\)^k sum_(i_1 < dots.h.c < i_k) lr(|A_(i_1) inter dots.h.c inter A_(i_k)|)$)

]#label("Inclusion-exclusion principle")
#statement("Definition")[
A #strong[lattice]#index-entry("Lattice") is a partially ordered set in which the supremum and infinimum of any two elements exists uniquely

]
#statement("Lemma")[
Trees are bipartite

]
#proof(title: "Proof")[
Take some $v in T$ as the root, and label the nodes that are even distance away from $2$ and odd distance away from $1$

]
#statement("Definition")[
A #strong[Hasse diagram]#index-entry("Hasse diagram") is a mathematical diagram used to represent a partially ordered set

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[${ x\,y\,z }$]),
node((3,0),[$2$]),
node((0,1),[${ x\,y }$]),
node((1,1),[${ x\,z }$]),
node((2,1),[${ y\,z }$]),
node((3,1),[$1$]),
node((0,2),[${ x }$]),
node((1,2),[${ y }$]),
node((2,2),[${ z }$]),
node((3,2),[$0$]),
node((1,3),[${ }$]),
node((3,3),[$- 1$]),
edge((0,1),(1,0),"->"),
edge((1,1),(1,0),"->"),
edge((2,1),(1,0),"->"),
edge((0,2),(0,1),"->"),
edge((0,2),(1,1),"->"),
edge((1,2),(0,1),"->"),
edge((1,2),(2,1),"->"),
edge((2,2),(2,1),"->"),
edge((2,2),(1,1),"->"),
edge((1,3),(2,2),"->"),
edge((1,3),(0,2),"->"),
edge((1,3),(1,2),"->"))]
]
]
#statement("Definition")[
The #emph[Bermoulli numbers]#index-entry("Bermoulli number") $B_n$ are defined by #display-equation($frac(t, e^t - 1) = sum_(k = 0)^oo frac(B_k t^k, k !)$) For instance, $B_0 = 1$, $B_1 = - 1 / 2$, $B_2 = 1 / 6$, $B_3 = 0$, $B_4 = - 1 / 30$, etc.

]
