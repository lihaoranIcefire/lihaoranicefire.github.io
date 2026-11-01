#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Category theory

== Category
<category>
#statement("Definition")[
A #emph[semicategory]#index-entry("semicategory") $cal(C)$ consists of

- A class of #emph[objects]#index-entry("Object") $"Ob" cal(C)$

- A class of #emph[morphisms]#index-entry("Morphism") $"Hom" cal(C)$

- Compositions $"Hom"\(A\,B\)times "Hom"\(B\,C\)arrow.r "Hom"\(A\,C\)$

Such that

- Compositions are associative: $\(h g\)f = h\(g f\)$

]
#statement("Definition")[
The #emph[empty category]#index-entry("Empty category") is the category without any objects nor morphisms

]
#statement("Definition")[
A #emph[category]#index-entry("Categroy") $cal(C)$ consists of

- A class of #emph[objects]#index-entry("Object") $"Ob" cal(C)$

- A class of #emph[morphisms]#index-entry("Morphism") $"Hom" cal(C)$

- Compositions $"Hom"\(A\,B\)times "Hom"\(B\,C\)arrow.r "Hom"\(A\,C\)$

Such that

- Compositions are associative: $\(h g\)f = h\(g f\)$

- $"Hom"\(A\,A\)$ contains #emph[identity] $1_A$: $1_A f = f$, $g 1_A = g$

]
#statement("Definition")[
A #emph[subcategory] $cal(S)$ is a category consists of subclasses of objects and morphisms with the same composition map

]
#statement("Definition")[
The #emph[dual category]#index-entry("Dual category") $cal(C)^(o p)$ of $cal(C)$ consists of the same objects and morphisms but with morphisms reversed

]
#statement("Definition")[
A #emph[functor]#index-entry("Functor") $F : cal(C) arrow.r cal(D)$ consists of maps

- $"Ob" cal(C) arrow.r "Ob" cal(D)$

- $"Hom"_(cal(C))\(A\,B\)arrow.r "Hom"_(cal(D))\(F\(A\)\,F\(B\)\)$

Such that it

- Preserves identities: $F\(1_A\)= 1_(F\(A\))$

- Preserves compositions: $F\(g compose f\)= F\(g\)compose F\(f\)$

]
#statement("Definition")[
A #emph[contravariant functor]#index-entry("Contravariant functor") $F : cal(C) arrow.r cal(D)$ consists of maps

- $"Ob" cal(C) arrow.r "Ob" cal(D)$

- $"Hom"_(cal(C))\(A\,B\)arrow.r "Hom"_(cal(D))\(F\(B\)\,F\(A\)\)$

Such that

- $F\(1_A\)= 1_(F\(A\))$

- $F\(g compose f\)= F\(f\)compose F\(g\)$

]
#aside("Remark")[
A contravariant functor $F : cal(C) arrow.r cal(D)$ is a functor $F : cal(C)^(o p) arrow.r cal(D)$

]
#statement("Definition")[
$A arrow.r^f B$ is a

- #emph[monomorphism]#index-entry("Monomorphism") if $f g_1 = f g_2 arrow.r.double g_1 = g_2$

- #emph[epimorphism]#index-entry("Epimorphism") if $g_1 f = g_2 f arrow.r.double g_1 = g_2$

- #emph[bimorphism]#index-entry("Bimorphism") if it is both a monomorphism and an epimorphism

- #emph[isomorphism]#index-entry("Isomorphism") if it is invertible

- #emph[automorphism]#index-entry("Automorphism") if it is an isomorphism and $B = A$

- #emph[constant morphism]#index-entry("Constant morphism") if $f g = f h$ for any $g\,h$

- #emph[coconstant morphism] if $g f = h f$ for any $g\,h$

- #emph[zero morphism]#index-entry("Zero morphism") if it is both constant and coconstant

- #emph[involution]#index-entry("Involution") if $B = A$ and $f^2 = 1_A$

]
#aside("Remark")[
Isomorphisms are bimorphisms

]
#statement("Example")[
A bimorphism is not necessary an isomorphism. In the category of rings, $bb(Z) arrow.r.hook bb(Q)$ is a bimorphism because $bb(Q) = bb(Z)_(\(0\))$ is a localization and the universal property of localization

]
#statement("Definition")[
A #emph[natural transformation]#index-entry("Natural transformation") is a family of morphisms $eta_A : F\(A\)arrow.r G\(A\)$ making the following diagram commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(A\)$]),
node((1,0),[$F\(B\)$]),
node((0,1),[$G\(A\)$]),
node((1,1),[$G\(B\)$]),
edge((0,0),(0,1),"->",[$eta_A$]),
edge((0,0),(1,0),"->",[$F\(f\)$]),
edge((1,0),(1,1),"->",[$eta_B$]),
edge((0,1),(1,1),"->",[$G\(f\)$]))]
]
For contravariant functors

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(B\)$]),
node((1,0),[$F\(A\)$]),
node((0,1),[$G\(B\)$]),
node((1,1),[$G\(A\)$]),
edge((0,0),(0,1),"->",[$eta_B$]),
edge((0,0),(1,0),"->",[$F\(f\)$]),
edge((1,0),(1,1),"->",[$eta_A$]),
edge((0,1),(1,1),"->",[$G\(f\)$]))]
]
$eta$ is a #emph[natural isomorphism]#index-entry("Natural isomorphism") if $eta_A$ are isomorphisms

]
#statement("Definition")[
A category $cal(C)$ is

- #emph[small]#index-entry("Small category") if $o b\(cal(C)\)$ and $"Hom"\(cal(C)\)$ are sets

- #emph[locally small]#index-entry("Locally small category") if $"Hom"\(a\,b\)$ are sets

- #strong[filtered]#index-entry("Filtered category") if it is not empty, and for any two objects $j\,j' in J$, there is an object $k in J$ and morphisms $f : j arrow.r k$ and $f' : j' arrow.r k$, for any two morphisms $u\,v : i arrow.r j$, there is an object $k in J$ and a morphism $w : j arrow.r k$ such that $w compose u = w compose v$

  A filtered colimit#index-entry("Filtered colimit") is the colimit of a functor $F : J arrow.r cal(C)$ where $J$ is a filtered category, direct limit is a special case of a filtered colimit

  The dual notion is called #strong[cofiltered]

- #emph[pointed]#index-entry("Pointed category") is a category with zero object #emph[connected]#index-entry("Connected category") if there is a finite sequence of morphisms connecting any two objects

]
#statement("Example")[
$C arrow.l A arrow.r B$ is a connected even there is no morphism between $B\,C$

]
#statement("Definition")[
we say categories $cal(C)\,cal(D)$ are #emph[isomorphic]#index-entry("Isomorphic category") if there are functors $F : cal(C) arrow.r cal(D)$ and $G : cal(D) arrow.r cal(C)$ such that $G compose F = 1_(cal(C))$, $F compose G = 1_(cal(D))$ and we say $cal(C)\,cal(D)$ are #emph[equivalent]#index-entry("Equivalent category") if $G compose F$ is naturally isomorphic to $1_(cal(C))$ and $F compose G$ is naturally isomorphic to $1_(cal(D))$

]
#statement("Definition")[
Suppose $cal(C)\,cal(D)$ are categories, define the #emph[functor category]#index-entry("Functor category") $\[cal(C)\,cal(D)\]$ or $cal(D)^(cal(C))$ has all functors from $cal(C)$ to $cal(D)$ as objects, and natural transformations as morphisms

]
#statement("Definition")[
$cal(C) times cal(D)$ is the #emph[product category]#index-entry("Product category") with $o b\(cal(C) times cal(D)\)= o b cal(C) times o b cal(D)$, $H o m_(cal(C) times cal(D))\(A times B\,C times D\)= H o m_(cal(C))\(A\,C\)times H o m_(cal(D))\(B\,D\)$

]
#statement("Definition")[
A functor $F : cal(C) arrow.r cal(D)$ is

- #emph[faithful]#index-entry("Faithful functor") if $"Hom"_(cal(C))\(X\,Y\)arrow.r "Hom"_(cal(D))\(F\(X\)\,F\(Y\)\)$ is injective

- #emph[full]#index-entry("Full functor") if $"Hom"_(cal(C))\(X\,Y\)arrow.r "Hom"_(cal(D))\(F\(X\)\,F\(Y\)\)$ is surjective

- #emph[fully faithful] if $"Hom"_(cal(C))\(X\,Y\)arrow.r "Hom"_(cal(D))\(F\(X\)\,F\(Y\)\)$ is bijective

- #emph[essentially surjective]#index-entry("Essentially surjective") if $forall d in o b cal(D)$, $exists c in o b cal(C)$ such that $F c tilde.equiv d$

]
#statement("Theorem")[
$F : cal(C) arrow.r cal(D)$ is an equivalence iff $F$ is fully faithful and essentially surjective

]#label("A functor F is an equivalence iff it is fully faithful and essentially surjective")
#proof(title: "Proof")[
If $F$ is an equivalence, there exist functor $G : cal(D) arrow.r cal(C)$ and natural isomorphisms $eta : 1_(cal(C)) arrow.r G F$, $xi : 1_(cal(D)) arrow.r F G$, $forall d in cal(C)$, $xi_d : d = 1_(cal(D))\(d\)arrow.r F G\(d\)= F\(G d\)$ is an isomorphism, i.e. $F$ is essentially surjective, similarly, so is $G$

The composition of #display-equation($H o m\(c\,c'\)arrow.r^F H o m\(F c\,F c'\)arrow.r^G H o m\(G F c\,G F c'\)\,quad f mapsto F f mapsto G F f$) Is the same as #display-equation($H o m\(c\,c'\)arrow.r^eta H o m\(G F c\,G F c'\)\,quad f mapsto eta'_c f eta_c^(- 1)$) By Exercise #ref(label("X1,X2 iso and Y1,Y2 iso implies Hom(X1,Y1),Hom(X2,Y2) iso"), supplement: none), this is bijective, thus $H o m\(c\,c'\)arrow.r^F H o m\(F c\,F c'\)$ is injective, i.e. $F$ is faithful. Similarly, consider the composition #display-equation($H o m\(F c\,F c'\)arrow.r^G H o m\(G F c\,G F c'\)arrow.r^F H o m\(F G F c\,F G F c'\)$) We know $H o m\(G F c\,G F c'\)arrow.r^F H o m\(F G F c\,F G F c'\)$ is surjective, but we also have the following diagram

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m\(c\,c'\)$]),
node((1,0),[$H o m\(F c\,F c'\)$]),
node((0,1),[$H o m\(G F c\,G F c'\)$]),
node((1,1),[$H o m\(F G F c\,F G F c'\)$]),
edge((0,0),(1,0),"->",[$F$]),
edge((0,0),(0,1),"->",[$eta$]),
edge((1,0),(1,1),"->",[$xi$]),
edge((0,1),(1,1),"->",[$F$]))]
]
Since $eta\,xi$ are bijective, $H o m\(c\,c'\)arrow.r^F H o m\(F c\,F c'\)$ is surjective, i.e. $F$ is full

Conversely, suppose $F$ is fully faithful and essentially surjective, then for any $d in cal(D)$, there exists $c$ and an isomorphism $d arrow.r^(xi_d) F c$, denote this $c$ as $G d$, we can define a functor $G : cal(D) arrow.r cal(C)$, $d mapsto G d$\(Here we have used the axiom of choice), $d arrow.r^f d' mapsto c arrow.r^(G f) c'$ where $F G f = xi_d^(- 1) f xi_(d')$ since $F$ is fully faithful

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$d$]),
node((1,0),[$d'$]),
node((0,1),[$F G d$]),
node((1,1),[$F G d'$]),
node((0,2),[$G d$]),
node((1,2),[$G d'$]),
edge((0,0),(0,1),"->",[$xi_d$]),
edge((0,0),(1,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$xi_(d')$]),
edge((0,1),(1,1),"->",[$F G f$]),
edge((0,2),(0,1),"->",[$F$]),
edge((0,2),(1,2),"->",[$G f$]),
edge((1,2),(1,1),"->",[$F$]))]
]
$xi : 1_(cal(D)) arrow.r F G$ is a natural isomorphism

Since $F$ is fully faithful, there are unique $eta_c : c arrow.r G F c$, $F\(eta_c\)= xi_(F c)$

If $f\,g : c arrow.r c'$ such that $eta_(c') f = eta_(c') g$, then $xi_(F c') F f = xi_(F c') F g arrow.r.double F f = F g arrow.r.double f = g$

If $f\,g : c arrow.r c'$ such that $f eta_c = g eta_c$, then $F f xi_(F c) = F g xi_(F c) arrow.r.double F f = F g arrow.r.double f = g$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$c$]),
node((1,0),[$c'$]),
node((0,1),[$F c$]),
node((1,1),[$F c'$]),
node((0,2),[$G F c$]),
node((1,2),[$G F c'$]),
node((0,3),[$F G F c$]),
node((1,3),[$F G F c'$]),
edge((0,0),(0,1),"->"),
edge((0,0),(1,0),"->"),
edge((0,0),(0,2),"->",[$eta_c$],bend:-15deg),
edge((1,0),(1,1),"->"),
edge((1,0),(1,2),"->",[$eta_(c')$],bend:15deg),
edge((0,1),(0,2),"->",[$G$]),
edge((0,1),(1,1),"->"),
edge((0,1),(0,3),"->",[$xi_(F c)$],bend:-15deg),
edge((1,1),(1,2),"->",[$G$]),
edge((1,1),(1,3),"->",[$xi_(F c')$],bend:15deg),
edge((0,2),(0,3),"->",[$F$]),
edge((0,2),(1,2),"->"),
edge((1,2),(1,3),"->",[$F$]),
edge((0,3),(1,3),"->"))]
]
$eta : 1_(cal(C)) arrow.r G F$ is a natural isomorphism

]
#statement("Definition")[
Suppose $u : S arrow.r A$, $v : T arrow.r A$ are morphisms, $v$ filter through $s$ means there is a morphism $w : T arrow.r S$ such that $v = u compose w$, then mutually filter defines an equivalence relation on monomorphisms(or equivalent by saying that $w$ is an isomorphism), the equivalence classes are called #emph[subobjects]#index-entry("Subobject") of $A$, the dual notion is called #emph[quotient objects]#index-entry("Quotient object")

]
#statement("Proposition")[
Direct limit is an exact functor

]
#statement("Definition")[
An object $X$ is a

- #emph[injective object]#index-entry("Injective object") if for any monomorphism $f : Y arrow.r Z$ and morphism $g : Y arrow.r X$, there is a morphism $h : Z arrow.r X$ such that $g = h compose f$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$Y$]),
  node((1,0),[$Z$]),
  node((0,1),[$X$]),
  edge((0,0),(1,0),"hook->",[$f$]),
  edge((0,0),(0,1),"->",[$g$]),
  edge((1,0),(0,1),"->",[$exists h$],stroke:(dash:"dashed")))]
  ]

- #emph[projective object]#index-entry("Projective object") if for any epimorphism $f : Y arrow.r Z$, and morphism $g : X arrow.r Z$, there is a morphism $h : X arrow.r Y$ such that $g = f compose h$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((1,0),[$X$]),
  node((0,1),[$Y$]),
  node((1,1),[$Z$]),
  edge((1,0),(1,1),"->",[$g$]),
  edge((1,0),(0,1),"->",[$exists h$],stroke:(dash:"dashed")),
  edge((0,1),(1,1),"->>",[$f$]))]
  ]

#emph[initial object]#index-entry("Initial object") if for every $Y$, there is a unique $X arrow.r Y$

#emph[final object]#index-entry("Final object") if for every $Y$, there is a unique $Y arrow.r X$

#emph[zero object]#index-entry("Zero object") is an object which is both initial and final

]
#aside("Remark")[
Final objects are also called terminal

]
#statement("Lemma", title: [Yoneda lemma])[
#index-entry("Yoneda lemma") $cal(C)$ is locally small #display-equation($"Hom"\("Hom"\(c\,-\)\,F\)arrow.r^tilde.equiv F\(c\)\,eta mapsto eta_c\(1_c\)$) #display-equation($"Hom"\("Hom"\(-\,c\)\,F\)arrow.r^tilde.equiv F\(c\)\,eta mapsto eta_c\(1_c\)$) If $F = "Hom"\(-\,d\)$ or $"Hom"\(d\,-\)$, then #display-equation($"Hom"\("Hom"\(c\,-\)\,"Hom"\(d\,-\)\)arrow.r^tilde.equiv "Hom"\(d\,c\)$) #display-equation($"Hom"\("Hom"\(-\,c\)\,"Hom"\(-\,d\)\)arrow.r^tilde.equiv "Hom"\(c\,d\)$) $"Hom"\(c\,-\)\,"Hom"\(-\,c\)$ give fully faithful embeddings

]#label("Yoneda lemma")
#proof(title: "Proof")[
\

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$"Hom"\(c\,c\)$]),
node((3,0),[$"Hom"\(c\,x\)$]),
node((1,1),[$1_c$]),
node((2,1),[$f$]),
node((1,2),[$u$]),
node((2,2),[$F f\(u\)= eta_x\(f\)$]),
node((0,3),[$F\(c\)$]),
node((3,3),[$F\(x\)$]),
edge((0,0),(3,0),"->",[$f$]),
edge((0,0),(0,3),"->",[$eta_c$]),
edge((3,0),(3,3),"->",[$eta_x$]),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((1,2),(2,2),"->"),
edge((0,3),(3,3),"->",[$F f$]))]
]
The natural transformation $eta$ is determined by the element $u$ in $F\(c\)$

]
#aside("Remark")[
Functor $"Hom"\(c\,-\)\,"Hom"\(-\,c\)$ is called #strong[Yoneda embedding], here embedding in the sense of a fully faithful functor, which is injective on objects up to isomorphism as in Lemma #ref(label("Fully faithfull functor is injective on objects up to isomorphism"), supplement: none)

]
#statement("Definition")[
A functor $F : cal(C) arrow.r S e t$ is called a #emph[representable] functor if there is an object $A$ in $cal(C)$ such that $H o m\(A\,-\)\,F$ are naturally isomorphic, By Yoneda lemma, the isomorphism is determined by an element $a in A$ called the universal element

]
#statement("Definition")[
Let $cal(C)$ be a category, we can define #emph[quotient category]#index-entry("quotient category") by moding out a congruence relation $tilde.op$, here $tilde.op$ is an equivalence relation on $H o m\(X\,Y\)$ for any $X\,Y$ and it respects composition, i.e. suppose $f_1 tilde.op f_2 : X arrow.r Y$, $g_1 tilde.op g_2 : Y arrow.r Z$, then $g_1 compose f_1 tilde.op g_2 compose f_2$, thus $H o m_(cal(C)\/tilde.op)\(X\,Y\)= H o m_(cal(C))\(X\,Y\)\/tilde.op$

]
#statement("Definition")[
$cal(C)$ is #emph[concretizable]#index-entry("Concrete category") if there is a faithful functor $F : cal(C) arrow.r S e t$. A morphism $f : X arrow.r Y$ is an #emph[embedding] if $F\(f\)$ is injective, and for any $F\(Z\)arrow.r^phi.alt F\(X\)$, $Z arrow.r^h Y$ such that $F\(Z\)arrow.r^(F\(h\)) F\(Y\)$, $F\(h\)= F\(f\)compose phi.alt$, $phi.alt = F\(g\)$ for some $Z arrow.r^g X$

]
#aside("Note")[
$cal(C)$ may have different concretization

]
#statement("Definition")[
$W$ is a class of morphisms of $cal(C)$, the #emph[localization]#index-entry("Localization of a category") of $cal(C)$ with respect to $W$, denoted $cal(C)\[W^(- 1)\]$, satisfies universal property

- Any functor $F : cal(C) arrow.r cal(D)$ sending morphisms in $W$ to isomorphisms in $cal(D)$ uniquely factors through the #emph[localization functor] $cal(C) arrow.r cal(C)\[W^(- 1)\]$

]
#statement("Construction")[
Add formal inverses of the morphisms in $overline(W)$

]
#aside("Note")[
$"Hom"_(cal(C)\[W^(- 1)\])\(A\,B\)$ consists of #emph[roofs] $A arrow.l C arrow.r B$ and $A arrow.r D arrow.l B$

]
#statement("Definition")[
A #strong[diagram]#index-entry("Diagram") is a functor $D : J arrow.r cal(C)$, $J$ is called the #strong[indexed category]#index-entry("Indexed category"), the diagram $D$ can be thought of as indexing a collection of objects and morphisms in $cal(C)$ patterned on $J$, we say $D$ is a diagram in $cal(C)$ shaped $J$

Let $F : J arrow.r cal(C)$ be a diagram in $cal(C)$, $N$ be an object in $cal(C)$, then a #strong[cone]#index-entry("Cone") from $N$ to $F$ is a family of morphisms $psi_X$ such that the following diagram commutes, a #strong[cocone]#index-entry("Cocone") from $F$ to $N$ is a family of morphisms $psi_X$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$N$]),
node((0,1),[$F\(X\)$]),
node((2,1),[$F\(Y\)$]),
edge((1,0),(0,1),"->",[$psi_X$]),
edge((1,0),(2,1),"->",[$psi_Y$]),
edge((0,1),(2,1),"->",[$F f$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$N$]),
node((0,1),[$F\(X\)$]),
node((2,1),[$F\(Y\)$]),
edge((0,1),(1,0),"->",[$psi_X$]),
edge((0,1),(2,1),"->",[$F f$]),
edge((2,1),(1,0),"->",[$psi_Y$]))]
]
A #strong[limit]#index-entry("Limit") of the diagram $F$ is cone $\(L\,phi.alt\)$ such that for any other cone $\(N\,psi\)$ there is a unique $u : N arrow.r L$ such that the following diagram commutes, a #strong[colimit]#index-entry("Colimit") of the diagram $F$ is cone $\(L\,phi.alt\)$ such that for any other cone $\(N\,psi\)$ there is a unique $u : L arrow.r N$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$N$]),
node((1,1),[$L$]),
node((0,2),[$F\(X\)$]),
node((2,2),[$F\(Y\)$]),
edge((1,0),(0,2),"->",[$psi_X$],bend:-15deg),
edge((1,0),(2,2),"->",[$psi_Y$],bend:15deg),
edge((1,0),(1,1),"->",[$exists_1 u$]),
edge((1,1),(0,2),"->",[$phi.alt_X$]),
edge((1,1),(2,2),"->",[$phi.alt_Y$]),
edge((0,2),(2,2),"->",[$F f$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$N$]),
node((1,1),[$L$]),
node((0,2),[$F\(X\)$]),
node((2,2),[$F\(Y\)$]),
edge((1,1),(1,0),"->",[$exists_1 u$]),
edge((0,2),(1,1),"->",[$phi.alt_X$]),
edge((0,2),(2,2),"->",[$F f$]),
edge((0,2),(1,0),"->",[$psi_X$],bend:15deg),
edge((2,2),(1,1),"->",[$phi.alt_Y$]),
edge((2,2),(1,0),"->",[$psi_Y$],bend:-15deg))]
]
Limits may also be characterized as terminal objects in the category of cones to $F$, thus unique up to isomorphism, so is colimits, a category contains all limits is called #strong[complete]#index-entry("Complete"), and is called #strong[cocomplete]#index-entry("Cocomplete") if containing all colimits

The #strong[equaliser]#index-entry("Equaliser") $E q\(f\,g\)$ is defined to be the limit of the diagram

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
edge((0,0),(1,0),"->",[$f$],shift:2pt),
edge((0,0),(1,0),"->",[$g$],shift:-2pt))]
, the #strong[coequaliser]#index-entry("Coequaliser") is the colimit

]
#aside("Remark")[
Direct limit and inverse limit are defined on directed set, thus limit and colimit are more general

]
#statement("Definition")[
A #strong[directed set]#index-entry("Directed set") $X$ is a set with a preorder $lt.eq$ and any pair of elements has an upper bound, i.e., $forall x\,y in X\,exists z in X$ such that $x lt.eq z\,y lt.eq z$

]
#statement("Definition")[
Given a directed set $I$, we can define a #strong[direct(inductive) system]#index-entry("Direct system"), with modules $A_i$, and functions $f_(i j) : A_i arrow.r A_j$, $f_(i i) = 1_(A_i)$, $f_(j k) compose f_(i j) = f_(i k)\,i lt.eq j lt.eq k$, we can also define an #strong[inverse system]#index-entry("Inverse system"), with module $A_i$, and functions $f_(i j) : A_j arrow.r A_i$, $f_(i i) = 1_(A_i)$, $f_(i j) compose f_(j k) = f_(i k)$

We can define morphism betweem direct and inverse systems and modules

Suppose $A_i$ is a direct system, then a morphism $g_i : A_i arrow.r B$ is such that $g_j compose f_(i j) = g_i\,i lt.eq j$ or $g_i : B arrow.r A_i$ is such that $g_j = f_(i j) compose g_i\,i lt.eq j$. Suppose $A_i$ is an inverse system, then a morphism $g_i : A_i arrow.r B$ is such that $g_i compose f_(i j) = g_j\,i lt.eq j$ or $g_i : B arrow.r A_i$ is such that $g_i = f_(i j) compose g_j\,i lt.eq j$, We can define morphisms between direct and inverse systems

Suppose $A_i\,B_i$ are both direct systems, a morphism $g_i : A_i arrow.r B_i$ is a family of maps such that $g_j compose f_(i j) = f_(i j) compose g_i\,i lt.eq j$. Suppose $A_i\,B_i$ are both inverse systems, a morphism $g_i : A_i arrow.r B_i$ is a family of maps such that $g_i compose f_(i j) = f_(i j) compose g_j\,i lt.eq j$.

]
#statement("Definition")[
The #strong[direct limit]#index-entry("Direct limit") of a direct system is a module $A_oo$ and morphisms $iota_i : A_i arrow.r A$ with the universal property: given any morphism $g_i : A_i arrow.r B$, it induces a unique $g_oo : A_oo arrow.r B$ such that $g compose iota_i = g_i$, there is a concrete construction: define the direct limit $lim_arrow.r A_i = union.sq.big_(i in I) A_i\/tilde.op$, where $a_i tilde.op a_j\,a_i in A_i\,a_j in A_j$ if there is an upper bound $k$ such that $f_(i k)\(a_i\)= f_(j k)\(a_k\)$, or equivalently, $a_i tilde.op f_(i j)\(a_i\)\,i lt.eq j$

]
#statement("Definition")[
The #strong[inverse limit]#index-entry("Inverse limit") of an inverse system is a module $A_oo$ and morphisms $pi_i : A arrow.r A_i$ with the universal property: given any morphism $g_i : B arrow.r A_i$, it induces a unique $g_oo : B arrow.r A_oo$ such that $pi_i compose g = g_i$, there is a concrete construction: define the inverse limit $lim_arrow.l A_i = {\( a_i \) in product_(i in I) A_i mid(bar.v) a_i = f_(i j) \( a_j \) \, i lt.eq j}$,

]
#aside("Remark")[
Direct limit and inverse limit are dual to each other in the categorical sense

]
#statement("Definition")[
Product, coproduct The #strong[biproducts]#index-entry("Biproduct") $\(xor.big_i A_i\,p_i\,iota_i\)$ of $A_i$ is such that $\(xor.big_i A_i\,p_i\)$ is the product and $\(xor.big_i A_i\,iota_i\)$ is the coproduct

]
#aside("Remark")[
The initial and final object are the limit and colimit of empty diagram

In the category of sets, the initial object is $diameter$ and a terminal object is ${ * }$

]
#statement("Lemma")[
$"Hom"\(X\,-\)$ functor takes limits to limits, dually, $"Hom"\(-\,X\)$ functor takes colimits to limits

]
#proof(title: "Proof")[
Consider $Y arrow.r^(f_i) "Hom"\(X\,X_i\)$, we want to define a map $Y arrow.r "Hom"\(X\,lim_arrow.l X_i\)$, for $y in Y$, $X arrow.r^(f_i\(y\)) X_i$ induces $X arrow.r^g lim_arrow.l X_i$

]
#aside("Remark")[
In general, $"Hom"\(X\,-\)$ functor doesn't take colimits to colimits

]
#statement("Definition")[
A #emph[skeleton of a category]#index-entry("Skeleton of a category") $cal(D)$ of $cal(C)$ is a full subcategory such that no two objects in $cal(D)$ are isomorphic and for every object in $cal(C)$ is isomorphic to some object in $cal(D)$, the functor $cal(D) arrow.r.hook cal(C)$ is an equivalence of categories

]
#statement("Definition")[
Suppose $cal(C)$ is a category, a #emph[filtered object]#index-entry("Filtered object") $X$ is an object with a #emph[filtration]#index-entry("Filtration") of $X$, a descending filtration #display-equation($dots.h.c arrow.r X_(n + 1) arrow.r X_n arrow.r X_(n - 1) arrow.r dots.h.c arrow.r X$) Or an ascending filtration #display-equation($X arrow.r dots.h.c arrow.r X_(n + 1) arrow.r X_n arrow.r X_(n - 1) arrow.r dots.h.c$)

]
#statement("Definition")[
Suppose $cal(C)$ is a category, $f : X arrow.r Y$ is a morphism, the #emph[image]#index-entry("Image of a morphism") of $f$ is a monomorphism $m : I arrow.r Y$ such that there is a morphism $e : X arrow.r I$ such that the following diagram commutes and satisfies the universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((2,0),[$Y$]),
node((1,1),[$I$]),
node((1,2),[$I'$]),
edge((0,0),(2,0),"->",[$f$]),
edge((0,0),(1,1),"->",[$e$]),
edge((0,0),(1,2),"->",[$e'$],bend:-15deg),
edge((1,1),(2,0),"hook->",[$m$]),
edge((1,1),(1,2),"->",[$exists_1 v$],stroke:(dash:"dashed")),
edge((1,2),(2,0),"hook->",[$m'$],bend:-15deg))]
]
]
#statement("Definition")[
A #emph[quiver]#index-entry("Quiver") is a functor from

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet$]),
node((1,0),[$bullet$]),
edge((0,0),(1,0),"->",shift:2pt),
edge((0,0),(1,0),"->",shift:-2pt),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"))]
to the category of sets. Equivalently, a directed graph allowing multiple arrows and loops

]
#statement("Definition")[
The #emph[free category]#index-entry("Free category") generated by quiver $Q$ has objects vertices in $Q$ and morphisms paths in $Q$ with empty path the identity

]
#statement("Definition")[
$A arrow.r^i B$ has #emph[left lifting property]#index-entry("Left lifting property") or #emph[LLP] and $X arrow.r^p Y$ has #emph[right lifting property]#index-entry("Right lifting property") or #emph[RLP] for each other in this diagram if

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$X$]),
node((0,1),[$B$]),
node((1,1),[$Y$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"->",[$i$]),
edge((1,0),(1,1),"->",[$p$]),
edge((0,1),(1,1),"->"),
edge((0,1),(1,0),"->",[$exists$],stroke:(dash:"dashed")))]
]
$i\,p$ are #emph[orthogonal] if the lifting is unique

]
#statement("Definition")[
A class of morphisms $upright(bold(M))$ of $cal(C)$ satisfies #emph[2 out of 3]#index-entry("2 out of 3") if any two of $f\,g\,f compose g$ are in $upright(bold(M))$, so is the third. $upright(bold(M))$ is clearly closed under composition

A class of #emph[weak equivalences]#index-entry("Weak equivalence") is a class of morphisms $upright(bold(W))$ containing isomorphisms and satisfies 2 out of 3. The class of isomorphisms $upright(bold(I))$ is a class of weak equivalences

]
#statement("Definition")[
$G$ is a #emph[group object] in category $cal(C)$\(having finite products, thus terminal object $1$) if there are multiplication $m : G times G arrow.r G$, identity $e : 1 arrow.r G$, and inverse $i : G arrow.r G$ satisfying the group law

+ Associativity

  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((1,0),[$G times G$]),
  node((0,1),[$G times G times G$]),
  node((2,1),[$G$]),
  node((1,2),[$G times G$]),
  edge((1,0),(2,1),"->",[$m$]),
  edge((0,1),(1,0),"->",[$m times 1$]),
  edge((0,1),(1,2),"->",[$1 times m$]),
  edge((1,2),(2,1),"->",[$m$]))]
  commutes

+ Unity

  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$1 times G$]),
  node((1,0),[$G times G$]),
  node((1,1),[$G$]),
  edge((0,0),(1,0),"->",[$e times 1$]),
  edge((0,0),(1,1),"->",[$p_2$]),
  edge((1,0),(1,1),"->",[$m$]))]
  #h(1em)

  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$G times 1$]),
  node((1,0),[$G times G$]),
  node((1,1),[$G$]),
  edge((0,0),(1,0),"->",[$1 times e$]),
  edge((0,0),(1,1),"->",[$p_1$]),
  edge((1,0),(1,1),"->",[$m$]))]
  commute

+ Invertibility

  #align(center)[#set text(size:7pt)
  #diagram(spacing:(7mm,9mm),
  node((2,0),[$G times G$]),
  node((0,1),[$G$]),
  node((1,1),[$G times G$]),
  node((3,1),[$G times G$]),
  node((2,2),[$G times G$]),
  edge((2,0),(3,1),"->",[$m$]),
  edge((0,1),(1,1),"->",[$Delta$]),
  edge((1,1),(2,0),"->",[$1 times i$]),
  edge((1,1),(2,2),"->",[$i times 1$]),
  edge((2,2),(3,1),"->",[$m$]))]
  commutes

]
#statement("Definition")[
$Y$ is an object such that all binary products $X times Y$ exist, the #strong[exponential object]#index-entry("Exponential object") is $Z^Y$ together with morphism $Z^Y times Y arrow.r^(upright(e v a l)) Z$ satisfying universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X times Y$]),
node((0,1),[$Z^Y times Y$]),
node((1,1),[$Z$]),
edge((0,0),(1,1),"->",[$f$]),
edge((0,0),(0,1),"->",[$exists_1 tilde(f) times 1_Y$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->",[$upright(e v a l)$]))]
]
]
#statement("Proposition")[
$H o m\(X times Y\,Z\)arrow.r H o m\(X\,Z^Y\)$ is an adjunction

]
#statement("Definition")[
Consider functors $S : cal(A) arrow.r cal(C)$, $T : cal(B) arrow.r cal(C)$\(for source and target), define #strong[comma category]#index-entry("Comma category") $\(S arrow.b T\)$ with objects $\(A\,B\,h\)$, $A in cal(A)\,B in cal(B)$ are objects, $h : S\(A\)arrow.r T\(B\)$ is a morphism, and with morphisms $\(f\,g\):\(A\,B\,h\)arrow.r\(A'\,B'\,h'\)$ where $f : A arrow.r A'\,g : B arrow.r B'$ are morphisms such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S\(A\)$]),
node((1,0),[$S\(A'\)$]),
node((0,1),[$T\(B\)$]),
node((1,1),[$T\(B'\)$]),
edge((0,0),(1,0),"->",[$S\(f\)$]),
edge((0,0),(0,1),"->",[$h$]),
edge((1,0),(1,1),"->",[$h'$]),
edge((0,1),(1,1),"->",[$T\(g\)$]))]
]
]
#statement("Definition")[
Consider the comma category of $1_(cal(A)) : cal(A) arrow.r cal(A)$, $T : * arrow.r cal(A)$ which we call #strong[slice category]#index-entry("Slice category"), sometimes denoted as $\(cal(A) arrow.b A_(*)\)$ where $A_(*) = T\(*\)$, the objects of the slice category are $A arrow.r^(pi_A) A_(*)$ and morphisms are

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((2,0),[$A'$]),
node((1,1),[$A_(*)$]),
edge((0,0),(2,0),"->",[$f$]),
edge((0,0),(1,1),"->",[$pi_A$]),
edge((2,0),(1,1),"->",[$pi_(A')$]))]
]
Its dual notion, the comma category of $S : * arrow.r cal(B)$ $1_(cal(B)) : cal(B) arrow.r cal(B)$, which we call #strong[coslice category]#index-entry("Coslice category"), sometimes denoted as $\(B_(*) arrow.b cal(B)\)$ where $B_(*) = S\(*\)$, the objects of the slice category are $B_(*) arrow.r^(pi_B) B$ and morphisms are

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$B_(*)$]),
node((0,1),[$B$]),
node((2,1),[$B'$]),
edge((1,0),(0,1),"->",[$pi_B$]),
edge((1,0),(2,1),"->",[$pi_(B')$]),
edge((0,1),(2,1),"->",[$g$]))]
]
The comma category of $1_(cal(C)) : cal(C) arrow.r cal(C)$, $1_(cal(C)) : cal(C) arrow.r cal(C)$ which we call #strong[arrow category]#index-entry("Arrow category"), sometimes denoted as $cal(C)^arrow.r$ the objects of the arrow category are just the morphisms(arrows) $A arrow.r^f A'$, and morphisms are

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$A'$]),
node((0,1),[$B$]),
node((1,1),[$B'$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(0,1),"->",[$h$]),
edge((1,0),(1,1),"->",[$h'$]),
edge((0,1),(1,1),"->",[$g$]))]
]
]
#statement("Definition")[
A right inverse are called a #strong[section]#index-entry("Section"), a left inverse is called a #strong[retraction]#index-entry("Retraction")

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
node((1,1),[$X$]),
edge((0,0),(1,1),"="),
edge((0,0),(1,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$g$]))]
]
$f$ is a section of $g$, $g$ is a retraction of $f$

]
#statement("Definition")[
A Galois category is the category of finite $G$-sets for some profinite group $G$, the fiber functor $Phi$ is simply to the category finite sets, $G tilde.equiv "Aut" Phi$

]
#statement("Example")[
$sans("Finite sets") arrow.r^("id") sans("Finite sets")$ gives a Galois category, the group being the permutation group

]
#statement("Example")[
Covering spaces

]
#statement("Example")[
Field extensions

]
#statement("Definition", title: [Monoidal category])[
A category $cal(C)$ is #emph[monoidal]#index-entry("Monoidal category") if there are

- A #emph[tensor product(monoidal product)] $cal(C) times cal(C) arrow.r^times.o cal(C)$ with a tensor unit 1

- #emph[Associator] $\(x times.o y\)times.o z arrow.r^(alpha_(x\,y\,z)) x times.o\(y times.o z\)$ which are natural isomorphisms

- #emph[Left] and #emph[right unitor] $1 times.o x arrow.r^(lambda_x) x$, $x times.o 1 arrow.r^(rho_x) x$ which are natural isomorphisms

Such that

+ Unital

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$\(x times.o 1\)times.o y$]),
  node((2,0),[$x times.o\(1 times.o y\)$]),
  node((1,1),[$x times.o y$]),
  edge((0,0),(1,1),"->",[$rho times.o 1$]),
  edge((0,0),(2,0),"->",[$alpha$]),
  edge((2,0),(1,1),"->",[$1 times.o lambda$]))]
  ]

+ Associative

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$\(\(w times.o x\)times.o y\)times.o z$]),
  node((2,0),[$\(w times.o x\)times.o\(y times.o z\)$]),
  node((0,1),[$\(w times.o\(x times.o y\)\)times.o z$]),
  node((1,1),[$w times.o\(\(x times.o y\)times.o z\)$]),
  node((2,1),[$w times.o\(x times.o\(y times.o z\)\)$]),
  edge((0,0),(0,1),"->",[$alpha$]),
  edge((0,0),(2,0),"->",[$alpha$]),
  edge((2,0),(2,1),"->",[$alpha$]),
  edge((0,1),(1,1),"->",[$alpha$]),
  edge((1,1),(2,1),"->",[$alpha$]))]
  ]

$cal(C)$ is #emph[strictly monoidal] if $alpha\,lambda\,rho$ are identities, i.e. $times.o$ is associative and $1$ is an actual unit

]
#statement("Definition", title: [Monoids, comonoids and bimonoids])[
$cal(C)$ is a monoidal category \ $M in cal(C)$ is a #emph[monoid] if there are

- Multiplication $mu : M times.o M arrow.r M$

- Unit $eta : 1 arrow.r M$

Such that

+ unital

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$I times.o M$]),
  node((1,0),[$M times.o M$]),
  node((2,0),[$M times.o I$]),
  node((1,1),[$M$]),
  edge((0,0),(1,0),"->",[$eta times.o 1$]),
  edge((0,0),(1,1),"->",[$lambda$]),
  edge((1,0),(1,1),"->",[$mu$]),
  edge((2,0),(1,0),"->",[$1 times.o eta$]),
  edge((2,0),(1,1),"->",[$rho$]))]
  ]

+ associative

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$\(M times.o M\)times.o M$]),
  node((2,0),[$M times.o\(M times.o M\)$]),
  node((0,1),[$M times.o M$]),
  node((1,1),[$M$]),
  node((2,1),[$M times.o M$]),
  edge((0,0),(2,0),"->",[$alpha$]),
  edge((0,0),(0,1),"->",[$mu times.o 1$]),
  edge((2,0),(2,1),"->",[$1 times.o mu$]),
  edge((0,1),(1,1),"->",[$mu$]),
  edge((2,1),(1,1),"->",[$mu$]))]
  ]

A morphism between monoids would be $f : M arrow.r N$ such that the following diagrams commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$M times.o M$]),
node((1,0),[$N times.o N$]),
node((0,1),[$M$]),
node((1,1),[$N$]),
edge((0,0),(1,0),"->",[$f times.o f$]),
edge((0,0),(0,1),"->",[$mu_M$]),
edge((1,0),(1,1),"->",[$mu_N$]),
edge((0,1),(1,1),"->",[$f$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$R$]),
node((1,0),[$M$]),
node((1,1),[$N$]),
edge((0,0),(1,0),"->",[$eta_M$]),
edge((0,0),(1,1),"->",[$eta_N$]),
edge((1,0),(1,1),"->",[$f$]))]
]
$R$ it self is a monoid with

$M times.o N$ is again a monoid with $mu_(M times.o N) :\(M times.o N\)times.o\(M times.o N\)arrow.r M times.o N$, $\(m_1 times.o n_1\)times.o\(m_2 times.o n_2\)mapsto m_1 m_2 times.o n_1 n_2$, and $eta_(M times.o N) : R arrow.r R times.o R arrow.r^(eta_M times.o eta_N) M times.o N$

$C in cal(C)$ is a #emph[comonoid] if it is a monoid in $cal(C)^(upright(o p))$, i.e. there are

- Comultiplication $Delta : C arrow.r C times.o C$

- Counit $epsilon.alt : C arrow.r I$

Such that

+ counital

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((1,0),[$C times.o C$]),
  node((0,1),[$C times.o I$]),
  node((1,1),[$C$]),
  node((2,1),[$I times.o C$]),
  edge((1,0),(0,1),"->",[$1 times.o epsilon.alt$]),
  edge((1,0),(2,1),"->",[$epsilon.alt times.o 1$]),
  edge((0,1),(1,1),"->",[$rho$]),
  edge((1,1),(1,0),"->",[$Delta$]),
  edge((2,1),(1,1),"->",[$lambda$]))]
  ]

+ coassociative

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$C times.o C$]),
  node((1,0),[$C$]),
  node((2,0),[$C times.o C$]),
  node((0,1),[$C times.o\(C times.o C\)$]),
  node((2,1),[$\(C times.o C\)times.o C$]),
  edge((0,0),(0,1),"->",[$1 times.o Delta$]),
  edge((1,0),(0,0),"->",[$Delta$]),
  edge((1,0),(2,0),"->",[$Delta$]),
  edge((2,0),(2,1),"->",[$Delta times.o 1$]),
  edge((2,1),(0,1),"->",[$alpha$]))]
  ]

A morphism between comonoids would be $f : M arrow.r N$ such that the following diagrams commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$M$]),
node((1,0),[$M times.o M$]),
node((0,1),[$N$]),
node((1,1),[$N times.o N$]),
edge((0,0),(1,0),"->",[$Delta_M$]),
edge((0,0),(0,1),"->",[$f$]),
edge((1,0),(1,1),"->",[$f times.o f$]),
edge((0,1),(1,1),"->",[$Delta_N$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$R$]),
node((1,0),[$M$]),
node((1,1),[$N$]),
edge((1,0),(0,0),"->",[$epsilon.alt_M$]),
edge((1,0),(1,1),"->",[$f$]),
edge((1,1),(0,0),"->",[$epsilon.alt_N$]))]
]
$B in cal(C)$ is a #emph[bimonoid] if it is both a monoid and a comonoid satisfying following compatibility

+ Multiplication $mu$ and comultiplication $Delta$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$B times.o B$]),
  node((1,0),[$B$]),
  node((2,0),[$B times.o B$]),
  node((0,1),[$\(B times.o B\)times.o\(B times.o B\)$]),
  node((2,1),[$\(B times.o B\)times.o\(B times.o B\)$]),
  node((0,2),[$B times.o\(B times.o B\)times.o B$]),
  node((2,2),[$B times.o\(B times.o B\)times.o B$]),
  edge((0,0),(1,0),"->",[$mu$]),
  edge((0,0),(0,1),"->",[$Delta times.o Delta$]),
  edge((1,0),(2,0),"->",[$Delta$]),
  edge((0,1),(0,2),"->"),
  edge((2,1),(2,0),"->",[$mu times.o mu$]),
  edge((0,2),(2,2),"->",[$1 times.o tau times.o 1$]),
  edge((2,2),(2,1),"->"))]
  ]
  Here $tau\(x times.o y\)= y times.o x$

+ Multiplication $mu$ and counit $epsilon.alt$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$B times.o B$]),
  node((1,0),[$B$]),
  node((0,1),[$I times.o I$]),
  node((1,1),[$I$]),
  edge((0,0),(1,0),"->",[$mu$]),
  edge((0,0),(0,1),"->",[$epsilon.alt times.o epsilon.alt$]),
  edge((1,0),(1,1),"->",[$epsilon.alt$]),
  edge((0,1),(1,1),"->"))]
  ]

+ Comultiplication $Delta$ and unit $eta$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$B times.o B$]),
  node((1,0),[$B$]),
  node((0,1),[$I times.o I$]),
  node((1,1),[$I$]),
  edge((1,0),(0,0),"->",[$Delta$]),
  edge((0,1),(0,0),"->",[$eta times.o eta$]),
  edge((0,1),(1,1),"->"),
  edge((1,1),(1,0),"->",[$eta$]))]
  ]

+ Unit $eta$ and counit $epsilon.alt$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$I$]),
  node((1,0),[$B$]),
  node((1,1),[$I$]),
  edge((0,0),(1,0),"->",[$eta$]),
  edge((0,0),(1,1),"="),
  edge((1,0),(1,1),"->",[$epsilon.alt$]))]
  ]

]
#statement("Definition")[
Let $L : cal(D) arrow.r cal(C)$, $R : cal(C) arrow.r cal(D)$ be functors, and there is a natural isomorphism $Phi_(X\,Y)$, $X in cal(C)\,Y in cal(D)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H o m_(cal(C))\(L X\,Y\)$]),
node((1,0),[$H o m_(cal(D))\(X\,R Y\)$]),
node((0,1),[$H o m_(cal(C))\(L X'\,Y'\)$]),
node((1,1),[$H o m_(cal(D))\(X'\,R Y'\)$]),
edge((0,0),(1,0),"->",[$Phi_(X\,Y)$]),
edge((0,0),(0,1),"->",[$\(L f\,g\)$]),
edge((1,0),(1,1),"->",[$\(g\,R f\)$]),
edge((0,1),(1,1),"->",[$Phi_(X'\,Y')$]))]
]
Here $f : X' arrow.r X$, $g : Y arrow.r Y'$, $H o m_(cal(C))\(L f\,g\)\(h\)= h compose g compose L f$

We say $L$ is the #strong[left adjoint]#index-entry("Adjoint functors") of $R$ and $R$ is the #strong[right adjoint] of $L$

]
#statement("Example")[
Let $G : G r o u p arrow.r S e t$ be the forgetful functor, then the functor $F : S e t arrow.r G r o u p$, sending $S$ to $F\(S\)$ is the left adjoint of $G$

In the category of $R$-modules $M o d$, consider functor $F := - times.o B$ and functor $G := H o m\(B\,-\)$, then $F$ is the left adjoint to $G$, i.e. $H o m\(A times.o B\,C\)tilde.equiv H o m\(A\,H o m\(B\,C\)\)$

]
#statement("Theorem")[
$"Ext"^n\(A\,B\)$ is the equivalent classes of $n$-extensions #display-equation($0 arrow.r B arrow.r E_1 arrow.r dots.h.c arrow.r E_n arrow.r A arrow.r 0$)

]
#proof(title: "Proof")[
First consider $n = 1$, given $0 arrow.r B arrow.r E arrow.r A arrow.r 0$, we have $0 arrow.r "Hom"\(A\,B\)arrow.r "Hom"\(A\,E\)arrow.r "Hom"\(A\,A\)arrow.r "Ext"^1\(A\,B\)$, take the image of $1_A$. Conversely, Find some $0 arrow.r M arrow.r P arrow.r A arrow.r 0$, where $P$ is projective, then we have $"Hom"\(M\,B\)arrow.r "Ext"^1\(A\,B\)arrow.r "Ext"^1\(P\,B\)= 0$, we get a map $M arrow.r B$, let $E$ be the pushout

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$M$]),
node((2,0),[$P$]),
node((3,0),[$A$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$B$]),
node((2,1),[$E$]),
node((3,1),[$A$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"="),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]

]
#statement("Definition")[
An injective resolution $C^bullet arrow.r I^bullet$ is a quasi-isomorphism where $I^bullet in D^(+)\(cal(A)\)$ consists of injective objects. A projective resolution $P^bullet arrow.r C^bullet$ is a quasi-isomorphism where $P^bullet$ consists of projective objects

]
#statement("Definition")[
$"Ext"_(cal(A))^i\(C\,D\)= "Hom"_(D\(cal(A)\))\(C\,D\[i\]\)= "Hom"_(D\(cal(A)\))\(C\[- i\]\,D\)$, $"Ext"_(cal(A))^i\(C^bullet\,D^bullet\)= "Hom"_(D\(cal(A)\))\(C^bullet\,I^bullet\[i\]\)= "Hom"_(D\(cal(A)\))\(P^bullet\[- i\]\,C^bullet\)$, here $D^bullet arrow.r I^bullet$ is an injective resolution, $P^bullet arrow.r C^bullet$ is a projective resolution

]
#statement("Definition")[
$F : cal(A) arrow.r cal(B)$ is a left exact functor, the derived functor $bb(R) F : D^(+)\(cal(A)\)arrow.r D^(+)\(cal(B)\)$ is given as follows

- Take any injective resolution $I^bullet$ quasi-isomorphic to $C^bullet in D^(+)\(cal(A)\)$, $bb(R) F\(C^bullet\)= F\(I^bullet\)$

$G : cal(A) arrow.r cal(B)$ is a right exact functor, the derived functor $bb(L) F : D^(-)\(cal(A)\)arrow.r D^(-)\(cal(B)\)$ is given as follows

- Take any projective resolution $P_bullet$ quasi-isomorphic to $C_bullet in D^(-)\(cal(A)\)$, $bb(L) F\(C_bullet\)= F\(P_bullet\)$

As cohomology and homology arise from derived functors, hypercohomology and hyperhomology arise from hyper-derived functors

]
#aside("Remark")[
By definition, $bb(R) F\(C^bullet\)= bb(R) F\(D^bullet\)$ if $C^bullet\,D^bullet$ are quasi-isomorphic. Let $A^bullet$ is the chain complex with only $A$ centered at zero, then $R^i F$ is the composition of the following #display-equation($cal(A) arrow.r D^(+)\(cal(A)\)arrow.r^(bb(R) F) D^(+)\(cal(B)\)arrow.r^(H^i) cal(B)$) i.e. $H^i\(bb(R) F\(A^bullet\)\)= R^i F\(A\)$. Denote $H^i compose bb(R) F$ as $bb(R)^i F$. Since any resolution $0 arrow.r A arrow.r C^bullet$ is a quasi-isomorphism between $A^bullet$ and $C^bullet$, $R^i F\(A\)= bb(R)^i F\(A^bullet\)= bb(R)^i F\(C^bullet\)$. Hyper-derived functor gives a way of computing derived functor using any resolution instead of only those \"nice\" resolutions

]
#statement("Example")[
The derived functors of $Gamma : "Sh"\(X\)arrow.r A b$, $cal(F) mapsto cal(F)\(X\)$ define sheaf cohomology #display-equation($H^i\(X\,cal(F)\)=\(R^i Gamma\)\(cal(F)\)$) The hyper-derived functors of $Gamma$ define sheaf hypercohomology #display-equation($bb(H)^i\(X\,cal(F)^bullet\)=\(R^i Gamma\)\(cal(F)^bullet\)$) The derived functors of $F : R M o d arrow.r A b$, $M mapsto M times.o_(R G) R$ define group homology #display-equation($H_i\(G\,M\)=\(L_i F\)\(M\)$) The hyper-derived functors of $F$ define group hyperhomology #display-equation($bb(H)_i\(G\,M^bullet\)=\(L_i F\)\(M^bullet\)$)

]
#statement("Definition")[
The #strong[pullback]#index-entry("Pullback") of $f : X arrow.r Z$, $g : Y arrow.r Z$ is $\(X times_Z Y\,p_X\,p_Y\)$ satisfying the universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$W$]),
node((1,1),[$X times_Z Y$]),
node((2,1),[$X$]),
node((1,2),[$Y$]),
node((2,2),[$Z$]),
edge((0,0),(1,1),"->",[$exists_1 h$],stroke:(dash:"dashed")),
edge((0,0),(1,2),"->",[$psi$],bend:-15deg),
edge((0,0),(2,1),"->",[$phi.alt$],bend:15deg),
edge((1,1),(1,2),"->",[$p_Y$]),
edge((1,1),(2,1),"->",[$p_X$]),
edge((2,1),(2,2),"->",[$f$]),
edge((1,2),(2,2),"->",[$g$]))]
]
$p_X$ is the #strong[base change]#index-entry("Base change") of $g$ along $f$, $p_Y$ is the base change of $f$ along $g$

If $f$ is an epimorphism, so is $p_X$

More generally, we can also define the puullback of $f_i : X arrow.r Y_i$

]
#statement("Definition")[
The #strong[pushout]#index-entry("Pushout") of $f : Z arrow.r X$, $g : Z arrow.r Y$ is $\(X union_Z Y\,iota_X\,iota_Y\)$ satisfying the universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$Z$]),
node((1,0),[$X$]),
node((0,1),[$Y$]),
node((1,1),[$X union_Z Y$]),
node((2,2),[$W$]),
edge((0,0),(0,1),"->",[$g$]),
edge((0,0),(1,0),"->",[$f$]),
edge((1,0),(1,1),"->",[$iota_X$]),
edge((1,0),(2,2),"->",[$phi.alt$],bend:15deg),
edge((0,1),(1,1),"->",[$iota_Y$]),
edge((0,1),(2,2),"->",[$psi$],bend:-15deg),
edge((1,1),(2,2),"->",[$exists_1 h$],stroke:(dash:"dashed")))]
]
$iota_X$ is the #strong[cobase change]#index-entry("Cobase change") of $g$ along $f$, $iota_Y$ is the cobase change of $f$ along $g$

If $f$ is a monomorphism, so is $iota_X$

More generally, we can also define the pushout of $f_i : Z arrow.r X_i$

]
#statement("Proposition")[
Pushout preserve epimorphisms and isomorphisms and in the category of sets, pushout preserve injection

Pullback preserve monomorphisms and isomorphisms and in the category of sets, pullback preserve surjection

]
== Sheaf
<sheaf>
#statement("Definition", title: [Site, also known as Grothendieck topology])[
Suppose $cal(C)$ is a category. ${ U_i arrow.r U }_(i in I)$ is a family of morphisms with a fixed target $U$. Let's call this an open coverings of $U$. A #emph[site] is a set of families of open coverings such that

+ ${ U arrow.r^("id") U }$ is an open covering

+ Suppose ${ V_(i j) arrow.r U_i }_(j in J_i)$ are open coverings, then so is ${ V_(i j) arrow.r U_i arrow.r U }_(i\,j)$

+ $U_i times_U V$ exists in the category and ${ U_i times_U V arrow.r V }$ is an open covering

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$U_i times_U V$]),
  node((1,0),[$V$]),
  node((0,1),[$U_i$]),
  node((1,1),[$U$]),
  edge((0,0),(1,0),"->"),
  edge((0,0),(0,1),"->"),
  edge((1,0),(1,1),"->"),
  edge((0,1),(1,1),"->"))]
  ]

]
#statement("Definition")[
The Zariski site has the category of open subsets in Zariski topology. The étale site has the category of étale coverings

]
#statement("Definition")[
$cal(A)$ is a category. A #emph[presheaf]#index-entry("Presheaf") is a functor #display-equation($F : { mono("open subsets of ") X }^(o p) arrow.r cal(A)$) $F\(U arrow.r.hook V\)= "res"_(U V)$ are #emph[restriction maps]. A #emph[morphism of presheaves] $F arrow.r^phi.alt G$ is a natural transformation, i.e. the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(V\)$]),
node((1,0),[$F\(U\)$]),
node((0,1),[$G\(V\)$]),
node((1,1),[$G\(U\)$]),
edge((0,0),(1,0),"->",[$"res"_(U V)$]),
edge((0,0),(0,1),"->",[$phi.alt_V$]),
edge((1,0),(1,1),"->",[$phi.alt_U$]),
edge((0,1),(1,1),"->",[$"res"_(U V)$]))]
]
]
#statement("Definition")[
$U subset.eq X$ is an open subset, $F$ is a presheaf over $X$, the #emph[restricted presheaf]#index-entry("Restricted presheaf") $F\|_U$ is given by $F\|_U\(V\)= F\(U inter V\)$

]
#statement("Definition")[
$F$ is a presheaf, $x in X$, open subsets containing $x$ is full subcategory $tau\(x\)$, the #emph[stalk]#index-entry("Stalk") $F_x$ is the colimit $lim_arrow.r_(x in U) F\(U\)$, elements in $F_x$ are called #emph[germs]#index-entry("Germ"), denote the germ of $f$ at $x$ as $f_x$

]
#statement("Lemma")[
$B\(f\,U\)= { f_x\|x in U\,f in F\(U\)}$ form a basis on the #emph[étalé space]#index-entry("étalé space") $\|F\|= union.big F_x$. $\|F\|arrow.r X$, $f_x mapsto x$ is a local homeomorphism

]
#statement("Definition")[
Presheaf $F$ is a #emph[sheaf]#index-entry("Sheaf") if

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$F\(U\)$]),
node((2,0),[$product_i F\(U_i\)$]),
node((4,0),[$product_(i\,j) F\(U_i inter U_j\)$]),
edge((0,0),(2,0),"->",[$"res"_(U_i\,U)$]),
edge((2,0),(4,0),"->",[$"res"_(U_i inter U_j\,U_i)$],shift:2pt),
edge((2,0),(4,0),"->",[$"res"_(U_i inter U_j\,U_j)$],shift:-2pt))]
]
Is an equaliser. Equivalently, $F$ satisfying

+ If $U = union.big_i U_i$, $f\,g in F\(U\)$, $f\|_(U_i) = g\|_(U_i)$, then $f = g$

+ If $U = union.big_i U_i$, $f_i in F\(U_i\)$, $f_i\|_(U_i inter U_j) = f_j\|_(U_i inter U_j)$, then there exists $f in F\(U\)$ such that $f\|_(U_i) = f_i$, here $f$ has to be unique because of 1

]#label("Sheaf")
#statement("Proposition")[
$F arrow.r^phi.alt G$ is a monomorphism or a epimorphism iff $F_x arrow.r^(phi.alt_x) G_x$ is injective or surjective on each stalk

]
#statement("Definition", title: [Sheafification])[
$F$ is a presheaf over $X$, the sheaf of sections $X arrow.r\|F\|$ is the #emph[sheafification]#index-entry("Sheafification")

]
#statement("Proposition")[
$cal(F)$ is a presheaf, $cal(G)$ is a sheaf. Then any morphism $cal(F) arrow.r cal(G)$ factors uniquely through $cal(F) arrow.r\|cal(F)\|arrow.r cal(G)$. i.e. $"Hom"\(cal(F)\,i\(cal(G)\)\)= "Hom"\(\|cal(F)\|\,cal(G)\)$, the inclusion functor $i$ from the category of sheaves to the category of presheaves is right adjoint to the sheafification functor $\|dot.op\|$

]
#statement("Definition")[
The #emph[constant presheaf]#index-entry("Constant presheaf") $underline(A)$ given by $underline(A)\(U\)= A$, $"res"_(U V) = 1_A$

$F$ is a #emph[locally constant sheaf]#index-entry("Locally constant sheaf") if for any $x in X$, there exists $U in.rev x$ such that $F\|_U$ is a constant sheaf. $F : Pi_1 X arrow.r cal(A)$ is a functor. The category of locally constant sheaves is equivalent to the category of covering spaces of $X$

]
#statement("Definition")[
Functor $Gamma : S h\(X\)arrow.r cal(A)$, $F mapsto F\(X\)$ is a left exact functor, the #emph[sheaf cohomology]#index-entry("Sheaf cohomology") is the right derived functor $R^i Gamma$, i.e. $R^i Gamma\(F\)= H^i\(X\,F\)$

]
#statement("Definition")[
$X arrow.r^f Y$ is a continuous map, $F$ is a presheaf/sheaf over $X$. The #emph[pushforward presheaf/sheaf]#index-entry("Pushforward sheaf") $f_(*) F$ of $F$ under $f$ is the presheaf/sheaf over $Y$ given by $f_(*) F\(V\)= F\(f^(- 1)\(V\)\)$, $f_(*)$ is the direct image functor

]
#statement("Definition")[
A #emph[ringed space]#index-entry("Ringed space") $\(X\,cal(O)\)$ is a topological space $X$ and a sheaf of rings over $X$, $cal(O)$ is the #emph[structure sheaf]#index-entry("Structure sheaf"). $\(X\,cal(O)\)$ is a #emph[locally ringed space]#index-entry("Locally ringed space") if each stalk is a local ring

]
#statement("Definition")[
A #emph[fine sheaf]#index-entry("Fine sheaf") $F$ is one with \"partition of unities\", more precisely, for any open cover, there is a family of endomorphisms such that each endomorphism is zero outside some element of the cover

]
#statement("Example")[
The de Rham complex is a resolution of the locally constant sheaf $bb(R)$, although not injective but fine sheaves. Thus the de Rham cohomology coincides with the sheaf cohomology

]
#statement("Definition")[
An #emph[acyclic sheaf]#index-entry("Acyclic sheaf") $F$ if its higher sheaf cohomologies vanishes

]
#statement("Definition")[
A #emph[soft sheaf]#index-entry("Soft sheaf") $F$ is one that any section over a closed subset can be extended to a global section

]
#statement("Definition")[
A #emph[flasque sheaf]#index-entry("Flasque sheaf") or #emph[flabby sheaf]#index-entry("Flabby sheaf") $F$ is one that the restriction maps are surjective

]
#statement("Lemma")[
Flasque sheaves are acyclic \ Fine sheaves are acyclic

]
#proof(title: "Proof")[

]
#statement("Definition", title: [Godemont resolution])[
A flasque resolution construction

]
#statement("Definition")[
A morphism between ringed spaces is $\(X\,cal(O)_X\)arrow.r^(\(f\,phi.alt\))\(Y\,cal(O)_Y\)$, $X arrow.r^f Y$ is a continuous map, $cal(O)_Y arrow.r^phi.alt f_(*) cal(O)_X$ is a morphism of sheaves. A morphism between locally ringed spaces require $phi.alt$ is a local ring homomorphism between stalks

]
#statement("Definition")[
$\(X\,cal(O)_X\)$ is a ringed space, a sheaf of $cal(O)_X$ modules#index-entry("\\mathcal O modules") $cal(F)$ is a sheaf of abelian groups such that $cal(F)\(U\)$ are $cal(O)_X\(U\)$ modules that respect restriction, i.e. $\(r m\)\|_V = r\|_V m\|_V$

]
#statement("Definition")[
The #emph[pullback sheaf]#index-entry("Pullback sheaf") $f^(- 1) F$ of $F$ under $f$ is the sheafification of the presheaf $f^(- 1) F\(U\)= lim_arrow.r_(V supset.eq f\(U\)upright(" open")) F\(V\)$. $\(f^(- 1) F\)_x tilde.equiv F_(f\(x\))$, thus $f^(- 1)$ is exact

]
#statement("Definition")[
$G$ is a sheaf of $cal(O)_Y$ modules, $f^(*) G = f^(- 1) G times.o_(f^(- 1) cal(O)_Y) cal(O)_X$, $f^(- 1)$ is exact, $f^(*)$ is right exact is the inverse image functor, $f^(*)$ is exact iff $f$ is flat, $f^(- 1)$ and $f_(*)$ are adjoints, i.e. $"Hom"\(f^(- 1) G\,F\)= "Hom"\(G\,f_(*) F\)$. Suppose $f\(U\)= V$, then $"Hom"\(f^(- 1) cal(G)\(U\)\,cal(F)\(U\)\)= "Hom"\(cal(G)\(f\(U\)\)\,cal(F)\(U\)\)= "Hom"\(cal(G)\(V\)\,cal(F)\(f^(- 1)\(V\)\)\)= "Hom"\(cal(G)\(V\)\,f_(*) cal(F)\(V\)\)$

]
#statement("Definition")[
$cal(F)\,cal(G)$ are $cal(O)$ modules, then $cal(F) times.o_(cal(O)) cal(G)$ is the sheafification of the presheaf $\(cal(F) times.o_(cal(O)) cal(G)\)\(U\)= cal(F)\(U\)times.o_(cal(O)\(U\)) cal(G)\(U\)$, $cal(F) xor_(cal(O)) cal(G)$ is the sheafification of the presheaf $\(cal(F) xor_(cal(O)) cal(G)\)\(U\)= cal(F)\(U\)xor_(cal(O)\(U\)) cal(G)\(U\)$

]
#statement("Definition")[
A #emph[quasi-coherent sheaf]#index-entry("Quasi-coherent sheaf") $cal(F)$ on ringed space $X$ is a sheaf of $cal(O)$ modules that has a local presentation, i.e. for each $x in X$ there is a neighborhood $U in.rev x$ with #display-equation($cal(O)^(xor I)\|_U arrow.r cal(O)^(xor J)\|_U arrow.r cal(F)\|_U arrow.r 0$) exact

]
#aside("Note")[
Quasi-coherent sheaves are being thought of as \"genearalized vector bundles\"

]
#statement("Definition")[
$cal(F)$ is of #emph[finite type] over $X$ if for each $x in X$ there is a neighborhood $U in.rev x$ such that $cal(O)^n\|_U arrow.r cal(F)\|_U arrow.r 0$ is exact for some $n$. Quasi-coherent sheaf $cal(F)$ is a #emph[coherent sheaf]#index-entry("Coherent sheaf") if $cal(F)$ is of finite type over $X$ and for any $cal(O)$-module morphism $phi : cal(O)^m\|_U arrow.r cal(F)\|_U$, $ker phi$ is of finite type over $X$

]
#statement("Definition")[
$cal(F)$ is #emph[locally free]#index-entry("Locally free") if for each $x in X$ there is a neighborhood $U in.rev x$ such that $cal(F)\|_U tilde.equiv cal(O)^I\|_U$

]
== Abelian category
<abelian-category>
#statement("Definition")[
$cal(A)$ is an #emph[abelian category]#index-entry("Abelian category") if

+ $"Hom"\(X\,Y\)$ are abelian groups, satisfying distribution law #display-equation($f compose\(g + h\)= f compose g + f compose h\,\(f + g\)compose h = f compose h + g compose h$)

+ Finite biproducts exist

+ Every morphism has a kernel and a cokernel

+ Every monomorphisms is normal and every epimorphisms is conormal

]
#aside("Note")[
$cal(A)$ is a #emph[preadditive category]#index-entry("Preadditive category") or an #strong[Ab]-#emph[category] if it only satisfies 1. An #emph[additive category]#index-entry("Additive category") if it satisfies 1. 2. A #emph[preabelian category]#index-entry("preabelian category") if it satisfies 1. 2. and 3. \ $0 in "Hom"\(X\,Y\)$ is a zero morphism from 1. \ $cal(A)$ has a zero object, the empty biproduct \ Kernels and cokernels are the equalisers and coequalisers of the morphism $f\,0$ in 3.

]
#statement("Definition")[
$F : cal(A) arrow.r cal(B)$ is a functor between abelian cateogories is #emph[additive]#index-entry("Additive funtor") if $F$ is are group homomorphisms on $"Hom"\(F\(A\)\,F\(B\)\)$. i.e. $F\(f + g\)= F\(f\)+ F\(g\)$

]
#statement("Definition")[
For a morphism $A arrow.r^f B$, define its image $upright(i m) f$ by the following commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$A$]),
node((0,1),[$0$]),
node((1,1),[$upright(i m) f$]),
node((2,1),[$B$]),
node((3,1),[$upright(c o k e r) f$]),
node((4,1),[$0$]),
edge((1,0),(2,1),"->",[$f$]),
edge((1,0),(1,1),"->",[$exists_1$],stroke:(dash:"dashed")),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"hook->"),
edge((2,1),(3,1),"->>"),
edge((3,1),(4,1),"->"))]
]
The image satisfies universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((2,0),[$B$]),
node((1,1),[$upright(i m) f$]),
node((1,2),[$I$]),
edge((0,0),(2,0),"->",[$f$]),
edge((0,0),(1,2),"->",bend:-15deg),
edge((0,0),(1,1),"->"),
edge((1,1),(2,0),"hook->"),
edge((1,1),(1,2),"->",[$exists_1$],stroke:(dash:"dashed")),
edge((1,2),(2,0),"hook->",bend:-15deg))]
]
]
#statement("Example")[
A ring $R$ can be thought of as a preadditive category with a single object and morphisms $r in R$ The category of left $R$ modules can be thought of as the functor category $\[R\,A b\]$, where $A b$ the category of abelian groups

]
#statement("Definition")[
Let $cal(A)$ be an abelian category, a ($bb(Z)$-graded) #emph[chain complex]#index-entry("Chain complex") $C_bullet$ is #display-equation($dots.h.c arrow.r C_1 arrow.r^(partial_1) C_0 arrow.r^(partial_0) C_(- 1) arrow.r dots.h.c$) Such that $partial_n compose partial_(n + 1) = 0$, $partial_i$ are called #emph[boundary maps(differentials)]#index-entry("Boundary maps")

We can define chain maps, chain homotopy, boundaries, cycles, and homology groups, and we say the chain complex is exact if each homology groups is zero, the chain complexes form the #emph[category of chain complexes]#index-entry("Category of chain complexes") $C h cal(A)$

The #emph[homotopy category of chain complexes]#index-entry("Homotopy category of chain complexes") often denoted as $K\(cal(A)\)$ is the quotient category with chain maps modulo chain homotopy equivalence as morphisms

a chain map is called a #emph[quasi-isomorphism]#index-entry("Quasi-isomorphism") if it induces isomorphisms on homology groups

]
#statement("Lemma")[
An alternative definition of an exact functor $F$ could be that $F$ preserve exactness, i.e. $F\(A\)arrow.r F\(B\)arrow.r F\(C\)$ is exact for any short exact sequence $A arrow.r B arrow.r C$

]
#statement("Definition")[
The #emph[direct sum] $\(C xor D\)_bullet$ of chain complexes#index-entry("Direct sum of chain complexes") $C_bullet\,D_bullet$ is #display-equation($dots.h.c arrow.r C_1 xor D_1 arrow.r^(partial_1^C xor partial_1^D) C_0 xor D_0 arrow.r^(partial_0^C xor partial_0^D) C_(- 1) xor D_(- 1) arrow.r dots.h.c$)

]
#statement("Definition")[
A #emph[double complex]#index-entry("Double complex") $C_(*\,*)$ is ${ C_(p\,q) }_(p\,q in bb(Z))$ two differentials $partial' : C_(p\,q) arrow.r C_(p - 1\,q)$, $partial'' : C_(p\,q) arrow.r C_(p\,q - 1)$ such that $\(partial'\)^2 =\(partial''\)^2 = 0$ and $partial' partial'' + partial'' partial' = 0$\($partial'\,partial''$ anticommutes)

The #emph[total chain complexes]#index-entry("Total chain complex") are $\(T o t^xor\)_n = xor.big_(p + q = n) C_(p\,q)$ and $\(T o t^Pi\)_n = product_(p + q = n) C_(p\,q)$ with $partial = partial' + partial''$

]
#statement("Example")[
$C_(*) times.o D_(*)$ is the total complex of double complex $C_(p\,q) := C_p times.o D_q$, $partial' := partial^C times.o 1$, $partial'' :=\(- 1\)^p 1 times.o partial^D$

]
#statement("Definition")[
A #emph[filtered chain complex]#index-entry("Filtered chain complex") is a filtered object in $C h cal(A)$ #display-equation($dots.h.c arrow.r F_(p + 1) C_bullet arrow.r F_p C_bullet arrow.r dots.h.c arrow.r C_bullet$)

]
#statement("Lemma", title: [Snake lemma])[
#index-entry("Snake lemma") Given the following commutative diagram with exact rows, then we have an exact sequence

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$ker a$]),
node((2,0),[$ker b$]),
node((3,0),[$ker c$]),
node((0,1),[$D$]),
node((1,1),[$A$]),
node((2,1),[$B$]),
node((3,1),[$C$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$A'$]),
node((2,2),[$B'$]),
node((3,2),[$C'$]),
node((4,2),[$D'$]),
node((1,3),[$upright(c o k e r) a$]),
node((2,3),[$upright(c o k e r) b$]),
node((3,3),[$upright(c o k e r) c$]),
edge((1,0),(2,0),"->",[$u_(*)$]),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->",[$v_(*)$]),
edge((2,0),(2,1),"->"),
edge((3,0),(1,3),"->",[$delta$]),
edge((3,0),(3,1),"->"),
edge((0,1),(1,0),"->",[$w_(*)$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$u$]),
edge((1,1),(1,2),"->",[$a$]),
edge((2,1),(3,1),"->",[$v$]),
edge((2,1),(2,2),"->",[$b$]),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->",[$c$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$u'$]),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->",[$v'$]),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((1,3),(2,3),"->",[$u'_(*)$]),
edge((2,3),(3,3),"->",[$v'_(*)$]),
edge((3,3),(4,2),"->"))]
]
]#label("Snake lemma")
#statement("Lemma", title: [Five lemma])[
If $b$ and $d$ are monic and $a$ is an epi, then $c$ is monic. Dually, if $b$ and $d$ are epis and $e$ is monic, then $c$ is an epi. In particular, if $a\,b\,d$ and $e$ are iso, then $c$ is also an iso

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A'$]),
node((1,0),[$B'$]),
node((2,0),[$C'$]),
node((3,0),[$D'$]),
node((4,0),[$E'$]),
node((0,1),[$A$]),
node((1,1),[$B$]),
node((2,1),[$C$]),
node((3,1),[$D$]),
node((4,1),[$E$]),
edge((0,0),(1,0),"->",[$u'$]),
edge((0,0),(0,1),"->",[$a$ \ $tilde.equiv$]),
edge((1,0),(2,0),"->",[$v'$]),
edge((1,0),(1,1),"->",[$b$ \ $tilde.equiv$]),
edge((2,0),(3,0),"->",[$w'$]),
edge((2,0),(2,1),"->",[$c$]),
edge((3,0),(4,0),"->",[$x'$]),
edge((3,0),(3,1),"->",[$d$ \ $tilde.equiv$]),
edge((4,0),(4,1),"->",[$e$ \ $tilde.equiv$]),
edge((0,1),(1,1),"->",[$u$]),
edge((1,1),(2,1),"->",[$v$]),
edge((2,1),(3,1),"->",[$w$]),
edge((3,1),(4,1),"->",[$x$]))]
]
]#label("Five lemma")
#statement("Lemma", title: [Horseshoe lemma])[
Suppose $P_bullet arrow.r^epsilon M$, $Q_bullet arrow.r^eta N$ are projective resolutions, then any exact sequence $0 arrow.r M arrow.r^f A arrow.r^g N arrow.r 0$ can be extended into commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$0$]),
node((1,1),[$P_0$]),
node((2,1),[$P_1 xor Q_1$]),
node((3,1),[$Q_1$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$P_0$]),
node((2,2),[$P_0 xor Q_0$]),
node((3,2),[$Q_0$]),
node((4,2),[$0$]),
node((0,3),[$0$]),
node((1,3),[$M$]),
node((2,3),[$A$]),
node((3,3),[$N$]),
node((4,3),[$0$]),
node((1,4),[$0$]),
node((2,4),[$0$]),
node((3,4),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->"),
edge((3,1),(4,1),"->"),
edge((3,1),(3,2),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->"),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((0,3),(1,3),"->"),
edge((1,3),(2,3),"->",[$f$]),
edge((1,3),(1,4),"->"),
edge((2,3),(3,3),"->",[$g$]),
edge((2,3),(2,4),"->"),
edge((3,3),(4,3),"->"),
edge((3,3),(3,4),"->"))]
]
With $\(P xor Q\)_bullet$ being a projective resolution, every row and column are exact

]#label("Horseshoe lemma")
#proof(title: "Proof")[
Since $A arrow.r^g N$ is epi and $Q_0$ is projective, we get $Q_0 arrow.r^(s_0) A$ such that $g s_0 = partial_0$ which gives us $P_0 xor Q_0 arrow.r^(mat(delim: "(", f partial_0, s_0)) A$, by Lemma #ref(label("Snake lemma"), supplement: none), this is epi, and we get an exact sequence $0 arrow.r Z_0 P arrow.r ker i_0 arrow.r Z_0 Q arrow.r 0$, similarly, we can construct $Q_1 arrow.r^(s_1) ker i_0$, then $P_1 xor Q_1 arrow.r^(mat(delim: "(", iota_0 partial_0, s_1)) ker i_0$ is again epi by Lemma #ref(label("Snake lemma"), supplement: none), inductively, we can construct the commutative diagram

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((3,0),[$dots.v$]),
node((0,1),[$0$]),
node((1,1),[$P_1$]),
node((2,1),[$P_1 xor Q_1$]),
node((3,1),[$Q_1$]),
node((4,1),[$0$]),
node((0,2),[$0$]),
node((1,2),[$Z_0 P$]),
node((2,2),[$ker i_0$]),
node((3,2),[$Z_0 Q$]),
node((4,2),[$0$]),
node((0,3),[$0$]),
node((1,3),[$P_0$]),
node((2,3),[$P_0 xor Q_0$]),
node((3,3),[$Q_0$]),
node((4,3),[$0$]),
node((0,4),[$0$]),
node((1,4),[$M$]),
node((2,4),[$A$]),
node((3,4),[$N$]),
node((4,4),[$0$]),
node((1,5),[$0$]),
node((2,5),[$0$]),
node((3,5),[$0$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(1,2),"->",[$partial_1$]),
edge((1,1),(2,1),"->"),
edge((2,1),(2,2),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(3,2),"->",[$partial_1$]),
edge((3,1),(4,1),"->"),
edge((3,1),(2,2),"->",[$s_1$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$iota_0$]),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"),
edge((3,2),(4,2),"->"),
edge((3,2),(3,3),"->"),
edge((0,3),(1,3),"->"),
edge((1,3),(2,3),"->"),
edge((1,3),(1,4),"->",[$partial_0$]),
edge((2,3),(3,3),"->"),
edge((2,3),(2,4),"->",[$i_0$]),
edge((3,3),(4,3),"->"),
edge((3,3),(3,4),"->",[$partial_0$]),
edge((3,3),(2,4),"->",[$s_0$]),
edge((0,4),(1,4),"->"),
edge((1,4),(2,4),"->",[$f$]),
edge((1,4),(1,5),"->"),
edge((2,4),(3,4),"->",[$g$]),
edge((2,4),(2,5),"->"),
edge((3,4),(4,4),"->"),
edge((3,4),(3,5),"->"))]
]

]
#statement("Lemma")[
If $A arrow.r^f B arrow.r^g C$ is a sequence and there is a homomorphism(retraction) $C arrow.r^r B$ such that $r g = 1_B$, then there is an exact sequence $0 arrow.r upright(c o k e r) f arrow.r upright(c o k e r)\(g f\)arrow.r upright(c o k e r) g arrow.r 0$

]#label("Lemma for universal coefficient theorem for cohomology")
#proof(title: "Proof")[
First observe that we have $0 arrow.r upright(i m) g\/upright(i m)\(g f\)arrow.r C\/upright(i m)\(g f\)arrow.r C\/upright(i m) g arrow.r 0$, $B arrow.r upright(i m) g$, $upright(i m) f arrow.r upright(i m)\(g f\)$, thus $B\/upright(i m) f arrow.r upright(i m) g\/upright(i m)\(g f\)$, since $r g = 1_B$, $B\/upright(i m) f tilde.equiv upright(i m) g\/upright(i m)\(g f\)$, therefore, $0 arrow.r B\/upright(i m) f arrow.r C\/upright(i m)\(g f\)arrow.r C\/upright(i m) g arrow.r 0$

]
#statement("Lemma")[
Suppose $cal(A)$ is abelian category, then $upright(i m) f = ker upright(c o k e r) f = upright(c o k e r) ker f$

]
#statement("Definition")[
Pick $p in bb(Z)$, define the #emph[translation]#index-entry("Translation of a chain complex") of $X$ by $p$ is $X_bullet\[p\]$ where $\(X_bullet\[p\]\)_n = X_(p + n)$, differential $X_bullet\[p\]_n arrow.r X_bullet\[p\]_(n - 1)$ is given by $\(- 1\)^p partial$ The #emph[translation functor] $T : C h\(cal(A)\)arrow.r C h\(cal(A)\)$, $X mapsto X_bullet\[1\]$ is an auto morphism of $C h\(cal(A)\)$

]
#statement("Theorem", title: [Acyclic model theorem])[
#footnote[Consult Theorem 9.12 of @AnIntroductionToAlgebraicTopologyJosephJRotman or `https://amathew.wordpress.com/2010/09/11/the-method-of-acyclic-models/`] #emph[Model] $cal(M) = { M_j }$ is a subclass(possibly with repetition) of objects in $cal(C)$, $F\,G : cal(C) arrow.r C h_(gt.eq 0)$ are functors, $H_n\(G\(M_j\)\)= 0$ for any $n eq.not 0$, $M_j in cal(M)$. For any $C$, there exist $m_j in F_k M_j$ such that $F_k\(C\)$ is free with basis ${F_k \( sigma \) \( m_j \) mid(bar.v) M_j arrow.r^sigma C}$

]#label("Acyclic model theorem")
#statement("Theorem", title: [Universal coefficient theorem for cohomology])[
There is an exact sequence #display-equation($0 arrow.r E x t^1\(H_(n - 1)\,A\)arrow.r H^n\(C\;A\)arrow.r H o m\(H_n\,A\)arrow.r 0$)

]#label("Universal coefficient theorem for cohomology")
#proof(title: "Proof")[
Since $C_n$ is a free group, so are subgroups $B_n\,Z_n$, exact sequence #display-equation($0 arrow.r Z_n arrow.r.hook C_n arrow.r B_(n - 1) arrow.r 0$) Splits, i.e. we have a splitting homomorphism $B_(n - 1) arrow.r^s C_n$, $C_n tilde.equiv Z_n xor B_(n - 1)$, thus exact sequence #display-equation($0 arrow.r H_n = Z_n\/B_n arrow.r C_n\/B_n arrow.r C_n\/Z_n tilde.equiv B_(n - 1) arrow.r 0$) Induces exact sequence #display-equation($H o m\(B_(n - 1)\,A\)arrow.r H o m\(C_n\/B_n\,A\)arrow.r H o m\(H_n\,A\)arrow.r E x t^1\(B_(n - 1)\,A\)= 0$) $H o m\(H_n\,A\)$ is the cokernel of $H o m\(B_(n - 1)\,A\)arrow.r H o m\(C_n\/B_n\,A\)$

Note that #display-equation($H^n\(C\;A\)= Z^n\(C\;A\)\/B^n\(C\;A\)= frac(ker\(H o m\(C_n\,A\)arrow.r H o m\(C_(n + 1)\,A\)\), upright(i m)\(H o m\(C_(n - 1)\,A\)arrow.r H o m\(C_n\,A\)\))$) $C_n arrow.r^phi.alt A in Z^n\(C\;A\)arrow.l.r.double phi.alt partial = 0 arrow.l.r.double phi.alt in H o m\(C_n\/B_n\,A\)$, thus $H o m\(C_n\/B_n\,A\)tilde.equiv Z^n\(C\;A\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$C_(n + 1)$]),
node((1,0),[$C_n$]),
node((1,1),[$A$]),
edge((0,0),(1,1),"->"),
edge((0,0),(1,0),"->",[$partial$]),
edge((1,0),(1,1),"->",[$phi.alt$]))]
]
$C_n arrow.r^psi A in B^n\(C\;A\)arrow.l.r.double psi = phi.alt partial$ for some $C_(n - 1) arrow.r^phi.alt A arrow.l.r.double psi = phi.alt partial$ for some $Z_(n - 1) arrow.r^phi.alt A$, and since $B^n\(C\;A\)subset.eq Z^n\(C\;A\)tilde.equiv H o m\(C_n\/B_n\,A\)$, we have $B^n\(C\;A\)tilde.equiv upright(i m)\(H o m\(Z_(n - 1)\,A\)arrow.r H o m\(C_n\/B_n\,A\)\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$C_n$]),
node((1,0),[$C_(n - 1)$]),
node((1,1),[$A$]),
edge((0,0),(1,1),"->",[$psi$]),
edge((0,0),(1,0),"->",[$partial$]),
edge((1,0),(1,1),"->",[$phi.alt$]))]
]
Exact sequence #display-equation($0 arrow.r B_(n - 1) arrow.r Z_(n - 1) arrow.r B_(n - 1)\/Z_(n - 1) = H_(n - 1) arrow.r 0$) Induces exact sequence #display-equation($H o m\(Z_(n - 1)\,A\)arrow.r H o m\(B_(n - 1)\,A\)arrow.r E x t^1\(H_(n - 1)\,A\)arrow.r E x t^1\(Z_(n - 1)\,A\)= 0$) $E x t^1\(H_(n - 1)\,A\)$ is the cokernel of $H o m\(Z_(n - 1)\,A\)arrow.r H o m\(B_(n - 1)\,A\)$

Since composition $B_(n - 1) arrow.r^s C_n arrow.r C_n\/B_n arrow.r^partial B_(n - 1)$ is identity, we have a homomorphism $r : H o m\(C_n\/B_n\,A\)arrow.r H o m\(B_(n - 1)\,A\)$ induced by $B_(n - 1) arrow.r C_n\/B_n$ such that composition $H o m\(B_(n - 1)\,A\)arrow.r H o m\(C_n\/B_n\,A\)arrow.r^r H o m\(B_(n - 1)\,A\)$ is identity

Apply Lemma #ref(label("Lemma for universal coefficient theorem for cohomology"), supplement: none) to $H o m\(Z_(n - 1)\,A\)arrow.r H o m\(B_(n - 1)\,A\)arrow.r H o m\(C_n\/B_n\,A\)$, we get an exact sequence #display-equation($0 arrow.r E x t^1\(H_(n - 1)\,A\)arrow.r H^n\(C\;A\)arrow.r H o m\(H_n\,A\)arrow.r 0$)

]
#aside("Remark")[
$B_n$ is not necessarily a direct summand of $C_n$, a map $B_n arrow.r^phi.alt A$ may not be possible to extended to $C_n arrow.r^phi.alt A$, however a map $Z_n arrow.r^phi.alt A$ can always be extended to $C_n arrow.r^phi.alt A$

]
#statement("Theorem", title: [Algebraic Künneth formula])[
$C\,D$ are free chain complexes, then #display-equation($0 arrow.r xor.big_(p + q = n) H_p\(C\)times.o H_q\(D\)arrow.r H_n\(C times.o D\)arrow.r xor.big_(p + q = n - 1) T o r_1\(H_p\(C\)\,H_q\(D\)\)arrow.r 0$) Is exact

]#label("Algebraic Kunneth formula")
#proof(title: "Proof")[
If $D$ has trivial differentials, then $H_q\(D\)= D_q$ is free, hence #display-equation($H_n\(C times.o D\)= xor.big_(p + q = n) H_p\(C times.o D_q\)= xor.big_(p + q = n) H_p\(C\)times.o D_q = xor.big_(p + q = n) H_p\(C\)times.o H_q\(D\)$) In general, consider exact sequence $0 arrow.r Z arrow.r^i D arrow.r^partial B\[- 1\]arrow.r 0$, $0 arrow.r B arrow.r^i Z arrow.r H\(D\)arrow.r 0$, then $0 arrow.r C times.o Z arrow.r C times.o D arrow.r C times.o B\[- 1\]arrow.r 0$ is exact since $C_k$ are free, this gives us long exact sequence #display-equation($dots.h.c arrow.r H_n\(C times.o Z\)arrow.r^(1 times.o i) H_n\(C times.o D\)arrow.r^(1 times.o partial) H_n\(C times.o B\[- 1\]\)arrow.r^(1 times.o i) H_(n - 1)\(C times.o Z\)arrow.r dots.h.c$) $Z\,B\[- 1\]$ have trivial differentials, hence the connecting homomorphism is just #display-equation($xor.big_(p + q = n) H_p\(C\)times.o H_q\(B\[- 1\]\)= xor.big_(p + q = n - 1) H_p\(C\)times.o H_q\(B\)arrow.r^(1 times.o i) xor.big_(p + q = n - 1) H_p\(C\)times.o H_q\(Z\)$) Then we have #display-equation($0 arrow.r upright(c o k e r)\(1 times.o i\)arrow.r H_n\(C times.o D\)arrow.r ker\(1 times.o i\)arrow.r 0$) We also have #display-equation($0 arrow.r T o r_1\(H_p\(C\)\,H_q\(D\)\)arrow.r H_p\(C\)times.o B_q arrow.r^(1 times.o i) H_p\(C\)times.o Z_q arrow.r H_p\(C\)times.o H_q\(D\)arrow.r 0$) Therefore, we have exact sequence #display-equation($0 arrow.r xor.big_(p + q = n) H_p\(C\)times.o H_q\(D\)arrow.r H_n\(C times.o D\)arrow.r xor.big_(p + q = n - 1) T o r_1\(H_p\(C\)\,H_q\(D\)\)arrow.r 0$)

]
#statement("Definition")[
A #emph[composition series]#index-entry("Composition series") of $A$ is a sequence of subobjects #display-equation($A = A_n supset.eq dots.h.c supset.eq A_1 supset.eq A_0 = 0$) With #emph[composition factors]#index-entry("Composition factors") $H_(i + 1)\/H_i$ simple and #emph[composition length]#index-entry("composition length") $ell\(A\)= n$

]
#statement("Definition")[
$F : cal(C) arrow.r cal(D)$ is an additive functor between abelian categories. $C^bullet$ is #emph[$F$-acyclic] if $R^i F C^bullet = 0\,forall i > 0$

]
#statement("Proposition")[
$F$ is left exact, $0 arrow.r A arrow.r K^0 arrow.r K^1 arrow.r dots.h.c$ is a $F$-acyclic resolution, then $R^i F A = H^i F K^bullet$

]
#proof(title: "Proof")[
Consider $0 arrow.r A arrow.r K^0 arrow.r K^1$, get $F A = ker\(F K^0 arrow.r F K^1\)= H^0 F K^bullet$ \ Consider $0 arrow.r A arrow.r K^1 arrow.r K^0\/A arrow.r 0$, get $R^1 F A = "coker"\(F K^0 arrow.r F\(K^0\/A\)\)$, and consider $0 arrow.r K^0\/A arrow.r K^1 arrow.r K^2$, get $F\(K^0\/A\)= ker\(F K^1 arrow.r F K^2\)$, hence $R^1 F A = H^1 F K^bullet$ \ For $i > 1$, still have $R^i F A = R^(i - 1) F\(K^0\/A\)$, but $0 arrow.r K^0\/A arrow.r K^1 arrow.r K^2 arrow.r dots.h.c$ is now a $F$-acyclic resolution of $K^0\/A$, thus $R^i F A = R^(i - 1) F\(K^0\/A\)= H^i F K^bullet$

]
#statement("Lemma")[
$ell\(A\)$ is independent of the composition series

]
#statement("Definition")[
$f : A^bullet arrow.r B^bullet$ is a chain map, the #emph[mapping cone] is $A\[1\]xor B$ with differential

#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$$]),
node((1,0),[$A^(i - 1)$]),
node((2,0),[$A^i$]),
node((3,0),[$A^(i + 1)$]),
node((4,0),[$$]),
node((0,1),[$$]),
node((1,1),[$B^(i - 1)$]),
node((2,1),[$B^i$]),
node((3,1),[$B^(i + 1)$]),
node((4,1),[$$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->",[$d$]),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->",[$d$]),
edge((2,0),(2,1),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$d$]),
edge((2,1),(3,1),"->",[$d$]),
edge((3,1),(4,1),"->"))]
]
== Spectral sequences
<spectral-sequences>
#statement("Definition")[
Suppose $cal(A)$ is an abelian category, a #strong[spectral sequence]#index-entry("Spectral sequence") consists of objects ${ E_r }_(r gt.eq r_0)$\($r_0$ is mostly $0$), and morphisms $d_r : E_r arrow.r E_r$ such that $d_r compose d_r = 0$ and $E_(r + 1) tilde.equiv H\(E_r\)= ker d_r\/upright(i m) d_r$

]
#statement("Definition")[
Suppose $cal(A)$ is an abelian category, an #strong[exact couple]#index-entry("Exact couple") is $\(D\,E\,i\,j\,k\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$D$]),
node((2,0),[$D$]),
node((1,1),[$E$]),
edge((0,0),(2,0),"->",[$i$]),
edge((2,0),(1,1),"->",[$j$]),
edge((1,1),(0,0),"->",[$k$]))]
]
Such that it is exact at each term, define differential $d = j k$, then $d^2 = j k j k = j\(k j\)k = 0$, we can define the #strong[derived couple]#index-entry("Derived couple")

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$D'$]),
node((2,0),[$D'$]),
node((1,1),[$E'$]),
edge((0,0),(2,0),"->",[$i'$]),
edge((2,0),(1,1),"->",[$j'$]),
edge((1,1),(0,0),"->",[$k'$]))]
]
Where $D' = i\(D\)$, $E' = ker k\/upright(i m) j$, $i'\(a\)= i\(a\)$, $j'\(i\(a\)\)= overline(j\(a\))$, $k'\(b\)= overline(k\(b\))$, then the derived couple is again an exact couple, thus we can carry this process indefinitely, giving the $n$-th derived couple $\(D^(\(n\))\,E^(\(n\))\,i^(\(n\))\,j^(\(n\))\,k^(\(n\))\)$

]
#statement("Example")[
Suppose $dots.h.c subset.eq F_(p - 1) C_bullet subset.eq F_p C_bullet subset.eq dots.h.c$ is a filteration of chain complex $C_bullet$\(or #strong[filtered chain complex]#index-entry("Filtered chain complex")), exact sequence $0 arrow.r F_(p - 1) C_bullet arrow.r F_p C_bullet arrow.r\(g r C_bullet\)_p arrow.r 0$ give a long exact sequence #display-equation($dots.h.c arrow.r H_n\(F_(p - 1) C_bullet\)arrow.r^(i_(*)) H_n\(F_p C_bullet\)arrow.r^(j_(*)) H_n\(F_p C_bullet\/F_(p - 1) C_bullet\)arrow.r^(k_(*)) H_(n - 1)\(F_(p - 1) C_bullet\)arrow.r dots.h.c$) If we write $D_(p\,q)^1 := H_(p + q)\(F_p C_bullet\)$, $E_(p q)^1 := H_(p + q)\(F_p C_bullet\/F_(p - 1) C_bullet\)$, then the long exact sequence become #display-equation($dots.h.c arrow.r D_(p\,q)^1 arrow.r D_(p + 1\,q - 1)^1 arrow.r E_(p\,q)^1 arrow.r D_(p\,q - 1)^1 arrow.r dots.h.c$) Consider $D^1 = xor.big D_(p\,q)^1$, $E^1 = xor.big E_(p\,q)^1$, then $\(D^1\,E^1\,i_(*)\,j_(*)\,k_(*)\)$ form an exact couple, note that $d_r : E_(p\,q)^r arrow.r E_(p - r\,q + r - 1)^r$

]
#aside("Remark")[
$g r C_bullet = xor.big_p F_p C_bullet\/F_(p - 1) C_bullet$ is called the #strong[associated graded complex]#index-entry("Associated graded complex")

If $X$ is a CW complex, we can take $F_p C_bullet = C_bullet\(X^p\)$, here $X^p$ is the $p$-th skeleton of $X$

]
#statement("Definition")[
A #strong[double cochain complex]#index-entry("Double cochain complex") $C^(bullet\,bullet)$ is bigraded with anticommuting differetials $d_h\,d_v$, i.e. $\(d_h\)^2 = 0$, $\(d_v\)^2 = 0$, $d_h d_v + d_v d_h = 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$C^(0\,1)$]),
node((2,1),[$C^(1\,1)$]),
node((3,1),[$dots.h.c$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$C^(0\,0)$]),
node((2,2),[$C^(1\,0)$]),
node((3,2),[$dots.h.c$]),
node((1,3),[$dots.v$]),
node((2,3),[$dots.v$]),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$d_h^(0\,1)$]),
edge((1,1),(1,0),"->"),
edge((2,1),(3,1),"->"),
edge((2,1),(2,0),"->"),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$d_h^(0\,0)$]),
edge((1,2),(1,1),"->",[$d_v^(0\,0)$]),
edge((2,2),(3,2),"->"),
edge((2,2),(2,1),"->",[$d_v^(1\,0)$]),
edge((1,3),(1,2),"->"),
edge((2,3),(2,2),"->"))]
]
Define the #strong[total cochain complex]#index-entry("Total cochain complex") to be $C^n = xor.big_(p + q = n) C^(p\,q)$, with total differential $d = d_h + d_v$, this is indeed a differential since $d^2 =\(d_h + d_v\)^2 =\(d_h\)^2 + d_h d_v + d_v d_h +\(d_v\)^2 = 0$

We can define the #strong[horizontal filtration] of the total cochain complex $\(F_p^h C\)^n = xor.big_(k + l = n\
k lt.eq p) C^(k\,l)$ and the #strong[vertical filtration] of the total cochain complex $\(F_q^h C\)^n = xor.big_(k + l = n\
l lt.eq q) C^(k\,l)$

A #strong[double chain complex] $C_(bullet\,bullet)$ is bigraded with anticommuting differetials $partial^h\,partial^v$, i.e. $\(partial^h\)^2 = 0$, $\(partial^h\)^2 = 0$, $partial^h partial^v + partial^v partial^h = 0$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$dots.v$]),
node((2,0),[$dots.v$]),
node((0,1),[$dots.h.c$]),
node((1,1),[$C_(1\,1)$]),
node((2,1),[$C_(0\,1)$]),
node((3,1),[$dots.h.c$]),
node((0,2),[$dots.h.c$]),
node((1,2),[$C_(1\,0)$]),
node((2,2),[$C_(0\,0)$]),
node((3,2),[$dots.h.c$]),
node((1,3),[$dots.v$]),
node((2,3),[$dots.v$]),
edge((1,0),(1,1),"->"),
edge((2,0),(2,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->",[$partial_(1\,1)^h$]),
edge((1,1),(1,2),"->",[$partial_(1\,1)^v$]),
edge((2,1),(3,1),"->"),
edge((2,1),(2,2),"->",[$partial_(0\,1)^v$]),
edge((0,2),(1,2),"->"),
edge((1,2),(2,2),"->",[$partial_(1\,0)^h$]),
edge((1,2),(1,3),"->"),
edge((2,2),(3,2),"->"),
edge((2,2),(2,3),"->"))]
]
Define the #strong[total chain complex] to be $C_n = xor.big_(p + q = n) C_(p\,q)$, with total differential $partial = partial_h + partial_v$

We can define the #strong[horizontal filtration] of the total chain complex $\(F_p^h C\)_n = xor.big_(k + l = n\
k lt.eq p) C_(k\,l)$ and the #strong[vertical filtration] of the total chain complex $\(F_q^h C\)_n = xor.big_(k + l = n\
l lt.eq q) C_(k\,l)$

]
#aside("Remark")[
If $d_h\,d_v$ commutes instead of anticommuting, then $C^(bullet\,bullet)$ can be viewed as a cochain complex of cochain complexes, the total differential becomes $d^n\(c\)= d_h^p c +\(- 1\)^p d_v^q c$ for any $c in C^(p\,q)$, this is indeed a differential since #display-equation($d^(n + 1) d^n\(c\) & = d^(n + 1)\(d_r^p c +\(- 1\)^p d_v^q c\)\
 & = d^(n + 1) d_h^p c +\(- 1\)^p d^(n + 1) d_v^q c\
 & = d_h^(p + 1) d_h^p c +\(- 1\)^(p + 1) d_v^q d_h^p c +\(- 1\)^p d_h^p d_v^q c +\(- 1\)^(2 p) d_v^(q + 1) d_v^q c\
 & =\(- 1\)^(p + 1) d_v^q d_h^p c +\(- 1\)^p d_h^p d_v^q c\
 & =\(- 1\)^p\(d_h^p d_v^q - d_v^q d_h^p\)c\
 & = 0$) However, these two types of definitions are equivalent

]
#statement("Proposition")[
Let $E_(p\,q)^r$ be the spectral sequence corresponds to the horizontal filtration

#strong[\(1)] $E_(p\,q)^0 tilde.equiv C^(p\,q)$

#strong[\(2)] $E_(p\,q)^1 tilde.equiv H_q\(C_(p\,bullet)\)$

#strong[\(3)] $E_(p\,q)^0 tilde.equiv H_p\(H_q^v\(C\)\)$

#strong[\(4)] If $C_(p\,q)$ vanishes outside the first quadrant, i.e. $C_(p\,q) = 0$ for any $p < 0$ or $q < 0$, then the spectral sequence converges to the homology of the total chain complex $E_(p\,q)^r arrow.r.double H_(p + q)\(C\)$, i.e. $E_(p\,q)^oo tilde.equiv H_(p + q)\(C\)$

]
#proof(title: "Proof")[
#strong[\(1)] By definition $E_(p\,q)^0 :=\(F_p^h C\)_(p + q)\/\(F_(p - 1)^h C\)_(p + q) tilde.equiv C^(p\,q)$

#strong[\(2)] $E_(p\,q)^1 = H_(p + q)\(F_p^h C\/F_(p - 1)^h C\)tilde.equiv H_(p + q)\(C_(p\,bullet)\)$

#strong[\(3)]

]
#statement("Definition")[
$C$ is a chain complex, $dots.h.c subset.eq F_(p - 1) C subset.eq F_p C subset.eq F_(p + 1) C subset.eq dots.h.c$ is a filtration of chain complexes. $F C$ is #strong[exhaustive] if $union.big F_p C = C$. $F C$ is #strong[Hausdorff] if $inter.big F_p C = 0$. $hat(C) = lim_arrow.l C\/F_p C$ is the #strong[completion]. $F C$ is #strong[complete] if $hat(C) tilde.equiv C$, since $C arrow.r hat(C)$ has kernel $inter.big F_p C$, hence completeness implies Hausdorff. $F C$ is #strong[bounded below] if $forall n$, $F_p C_n = 0$ for $p$ small enough. $F C$ is #strong[bounded above] if $forall n$, $F_p C_n = C_n$ for $p$ big enough. $F C$ is #strong[bounded] if bounded below and above

$F_p H_n\(C\)= upright(i m)\(H_n\(F_p C\)arrow.r H_n\(C\)\)$

]
#statement("Definition")[
$F_n C$ is a filtered chain complex, $E_(p q)^0 = frac(F_p C_(p + q), F_(p - 1) C_(p + q))$ defines a spectral sequence

$E_(p q)^1$ #strong[converges] to $H_(*) C$ if $E_(p q)^1 = H_(p + q)\(F_p C\/F_(p - 1) C\)arrow.r.double H_(p + q) C$

]
#statement("Theorem")[
$A_p^r = {x in F_p C mid(bar.v) d x in F_(p - r) C}$, $Z_p^r = A_p^r + F_(p - 1) C$, $B_p^r = d A_(p + r - 1)^(r - 1) + F_(p - 1) C$, $A_p^r inter F_(p - 1) C = A_(p - 1)^(r - 1)$ #display-equation($E_p^r & = Z_p^r / B_p^r = frac(A_p^r + F_(p - 1) C, d A_(p + r - 1)^(r - 1) + F_(p - 1) C) = frac(A_p^r + F_(p - 1) C, F_(p - 1) C) / frac(d A_(p + r - 1)^(r - 1) + F_(p - 1) C, F_(p - 1) C) = A_p^r / A_(p - 1)^(r - 1) / frac(d A_(p + r - 1)^(r - 1), d A_(p + r - 1)^(r - 1) inter F_(p - 1) C)\
 & = A_p^r / A_(p - 1)^(r - 1) / frac(d A_(p + r - 1)^(r - 1), d A_(p + r - 1)^(r - 1) inter A_(p - 1)^(r - 1)) = A_p^r / A_(p - 1)^(r - 1) / frac(d A_(p + r - 1)^(r - 1) + A_(p - 1)^(r - 1), A_(p - 1)^(r - 1)) = frac(A_p^r, d A_(p + r - 1)^(r - 1) + A_(p - 1)^(r - 1))$)

]
#statement("Lemma")[
$C$ and $hat(C)$ give the same spectral sequence

]
#statement("Theorem")[
If $F_(*) C$ is bounded, then $E_(p\,q)^1$ converges to $H_(*) C$

If $F_(*) C$ is bounded below and exhaustive, then $E_(p\,q)^1$ converges to $H_(*) C$, the convergence is natural

]
#statement("Theorem")[
$C$ is a complete filtration, then

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$lim_arrow.l ""^1 H_(n + 1)\(C\/F_p C\)$]),
node((2,0),[$H_n\(C\)$]),
node((3,0),[$H_n\(C\/F_p C\)$]),
node((4,0),[$0$]),
node((1,1),[$inter.big F_p H_n\(C\)$]),
node((3,1),[$lim_arrow.l H_n\(C\)\/F_p H_n\(C\)$]),
node((3,2),[$H_(*)\(C\)\/inter.big F_p H_n\(C\)$]),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"="),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"="),
edge((3,1),(3,2),"="))]
]
]
#statement("Lemma")[
$F_(*) C$ is Hausdorff and exhaustive, then

+ $A_(p q)^oo = ker\(F_p C_(p + q) arrow.r^d F_p C_(p + q - 1)\)$

+ $F_p H_(p + q)\(C\)tilde.equiv A^oo\/union.big d A_(p + r\,q - r + 1)^r$

+ The subgroup $e_(p q)^oo = A_(p q)^oo + B_(p q)^oo$ is isomorphic to $F_p H_(p + q)\(C\)\/F_(p - 1) H_(p + q)\(C\)$

]
#proof(title: "Proof")[
#display-equation($frac(F_p H_(p + q)\(C\), F_(p - 1) H_(p + q)\(C\)) & = frac(ker\(F_p C_(p + q) arrow.r F_p C_(p + q - 1)\)\/"im"\(C_(p + q + 1) arrow.r C_(p + q)\), ker\(F_(p - 1) C_(p + q) arrow.r F_(p - 1) C_(p + q - 1)\)\/"im"\(C_(p + q + 1) arrow.r C_(p + q)\))\
 & = frac(A_p^oo\/d C_(p + q) inter F_p C_(p + q), A_(p - 1)^oo\/d C_(p + q) inter F_(p - 1) C_(p + q))\
 & = frac(A_p^oo, A_(p - 1)^oo + union.big_(r gt.eq 0) d A_(p + r)^r)\
 & = frac(A_p^oo, A_(p - 1)^oo + d A_(p + oo)^oo) = E_(p\,q)^oo$) Note that here $union.big_(r gt.eq 0) A_(p - 1 + r)^r subset.eq union.big_(r gt.eq 0) A_(p + r)^r$

]
== Factorization system
<factorization-system>
#statement("Definition")[
A #strong[factorization system]#index-entry("Factorization system") $\(upright(bold(E))\,upright(bold(M))\)$ for category $cal(C)$ is two classes of morphisms such that

\1. Any morphism $f$ can be decomposed as $f = m e$, $m in upright(bold(M))$, $e in upright(bold(E))$

\2. $upright(bold(E))\,upright(bold(M))$ are closed under composition and contain all isomorphisms

\3. Factorization is functorial, i.e. for any $u\,v$ such that $v m e = m' e' u$, there exists a unique $w$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet$]),
node((1,0),[$bullet$]),
node((2,0),[$bullet$]),
node((0,1),[$bullet$]),
node((1,1),[$bullet$]),
node((2,1),[$bullet$]),
edge((0,0),(1,0),"->",[$e$]),
edge((0,0),(0,1),"->",[$u$]),
edge((1,0),(2,0),"->",[$m$]),
edge((1,0),(1,1),"->",[$exists_1 w$],stroke:(dash:"dashed")),
edge((2,0),(2,1),"->",[$v$]),
edge((0,1),(1,1),"->",[$e'$]),
edge((1,1),(2,1),"->",[$m'$]))]
]
]
#statement("Example")[
$upright(bold(E))\,upright(bold(M))$ being epi and mono in $S e t$ is a factorization system

]
#statement("Definition")[
A #strong[weak factorization system]#index-entry("Weak factorization system") $\(upright(bold(E))\,upright(bold(M))\)$ for category $cal(C)$ is two classes of morphisms such that

\1. Any morphism $f$ can be decomposed as $f = m e$, $m in upright(bold(M))$, $e in upright(bold(E))$

\2. $upright(bold(E))$ are exactly those morphisms having left lifting property for all morphisms in $upright(bold(M))$

\3. $upright(bold(M))$ are exactly those morphisms having right lifting property for all morphisms in $upright(bold(E))$

]
