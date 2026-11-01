#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Isotopy

#statement("Definition")[
$f\,g : X arrow.r Y$ are topological embeddings, an #strong[isotopy]#index-entry("Isotopy") from $f$ to $g$ is a homotopy $H$ such that $H_t$ are embeddings

]
#statement("Definition")[
$g\,h$ are embeddings of $N$ in $M$, an #strong[ambient isotopy]#index-entry("Ambient isotopy") from $g$ to $h$ is $M times I arrow.r^F M$ such that $F_t$ are homeomorphisms, and $F_0 = 1_M$, $F_1 compose g = h$

]
#statement("Theorem", title: [Alexander's trick])[
$D subset.eq bb(R)^n$ is the unit ball, homeomorphisms of $D$ that are isotopic on $partial D$ are also isotopic on $D$

]
#proof(title: "Proof")[
Suppose $f\,g : D arrow.r D$ are homeomorphisms with $f\|_(partial D)$, $g\|_(partial D)$ isotopic

]
