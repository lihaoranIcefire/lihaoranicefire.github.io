#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Algebraic K theory

#statement("Definition")[
The Grothendieck group of $R$ is $K_0\(R\)$, the Grothendieck group of monoid of finitely generated projective modules over $R$

]
#statement("Theorem", title: [Swan's theorem])[
$X$ is a compact Hausdorff space, $K\(X\)= K_0\(C\(X\,bb(R)\)\)$

]#label("Swan's theorem")
#proof(title: "Proof")[
If $E arrow.r X$ is a vector bundle, then it is the direct summand of some trivial vector bundle. Conversely, if $P$ is a finitely generated module over $R = C\(X\,bb(R)\)$, then $P$ is image of some idempotent endomorphism of $R^n$ which is a vector bundle

]
#statement("Definition", title: [Whitehead group])[
The #strong[Whitehead group]#index-entry("Whitehead group") of ring $R$ is an abelian group $K_1\(R\)$ satisfying universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$G L\(R\)$]),
node((0,1),[$K_1\(R\)$]),
node((1,1),[$A$]),
edge((0,0),(0,1),"->",[$pi$]),
edge((0,0),(1,1),"->"),
edge((0,1),(1,1),"->",[$exists_1$],stroke:(dash:"dashed")))]
]
For any abelian group $A$

]
#statement("Construction")[
Thanks to Whitehead's lemma #ref(label("Whitehead's lemma"), supplement: none), $K_1\(R\)= G L\(R\)\/\[G L\(R\)\,G L\(R\)\]= G L\(R\)\/E\(R\)$

]
#statement("Definition")[
If $R$ is commutative, $S L\(R\)$ is the kernel of $G L\(R\)arrow.r^det R^times$, the special Whitehead group $S K_1\(R\)= S L\(R\)\/E\(R\)$ is the kernel of $K_1\(R\)arrow.r^det R^times$, $G L\(R\)tilde.equiv S L\(R\)times.r R^times$, $K_1\(R\)tilde.equiv S K_1\(R\)xor R^times$. $K_1\(F\)= F^times$

]
#statement("Lemma")[
Since $G L\(R_1 times R_2\)= G L\(R_1\)times G L\(R_2\)$, $K_1\(R_1 times R_2\)= K_1\(R_1\)xor K_1\(R_2\)$

]
