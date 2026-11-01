#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Moduli space

Consider a parametrized curve $C = {\(t\,upright(bold(x))\(t\)\)}_(t in I)$, $upright(bold(x))\(t\)in bb(R)^n$, now we change $I$ to some space $X$, $upright(bold(x))\(t\)$ to some algebro-geometric objects, then we have a parametrization of these objects by $X$

#statement("Definition")[
$U$ is a family of some algebro-geometric objects. A parametrization of $U$ by space $X$ is a map $X arrow.r U$, attaching some object $U_x$ for each $x in X$, we can also think of this map as a section of $X times U arrow.r X$

We say $X$ is the parametrization space, $U$ is parametrized over $X$

A moduli functor $F$ is a contravariant functor $S p a c e arrow.r S e t$ that takes a space $X$ to the set of families of objects over $X$, and take a morphism $f$ to the pullback $f^(*)$ that taking section $s$ to pullback section $f^(*) s\(y\)=\(y\,Pr_U s f\(y\)\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$Y times U$]),
node((1,0),[$X times U$]),
node((0,1),[$Y$]),
node((1,1),[$X$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->"),
edge((1,0),(1,1),"->"),
edge((0,1),(1,1),"->",[$f$]))]
]
The category of spaces can be the category of schemes, manifolds, topological spaces, etc.

$M$ is a fine moduli space if $F$ is corepresentable by $M$, i.e. there is a natural isomorphism $tau : F arrow.r "Hom"\(-\,M\)$. There is a universal family over $M$ corresponds to $1_M in "Hom"\(M\,M\)$. Then any family over $X$ is the pullback along some $X arrow.r^f M$ of the universal family. The universal family is essentially unique and \"tautological\"

$M$ is a coarse moduli space if there is exists a natural transformation $tau : F arrow.r "Hom"\(-\,M\)$ and universal among these natural transformations, i.e. for any natural transformation $tau' : F arrow.r "Hom"\(-\,M'\)$, there is a morphism $M' arrow.r^phi.alt M$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$F$]),
node((0,1),[$"Hom"\(-\,M'\)$]),
node((1,1),[$"Hom"\(-\,M\)$]),
edge((1,0),(1,1),"->",[$tau$]),
edge((1,0),(0,1),"->",[$tau'$]),
edge((0,1),(1,1),"->",[$exists_1 phi.alt$]))]
]
]
