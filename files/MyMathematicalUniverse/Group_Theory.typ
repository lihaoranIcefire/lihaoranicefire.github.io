#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Group Theory

#statement("Definition")[
A #strong[semigroup]#index-entry("Semigroup") is a semicategory with a single object. A #strong[monoid]#index-entry("Monoid") $M$ is a category with a single object. A #strong[group]#index-entry("Group") is a monoid with all morphisms invertible. A #strong[groupoid]#index-entry("Groupoid") is a category with all morphisms invertible

A $G$ #strong[set]#index-entry("G set") is a functor from $G$ to the category of sets. Equivalently, a #strong[left group action]#index-entry("Group action") is $G times X arrow.r X$, $\(g\,x\)mapsto g dot.op x$ satisfying $1 dot.op x = x$, $g dot.op\(h dot.op x\)=\(g h dot.op x\)$, a right $G$ action is functor $G^(o p)$ to the category of sets. A $G$ #strong[space]#index-entry("G space") is a functor from $G$ to the category of topological spaces

An #strong[equivariant map]#index-entry("Equivariant map") of $G$ spaces is a natural transformation $f : X arrow.r Y$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X$]),
node((1,0),[$Y$]),
node((0,1),[$X$]),
node((1,1),[$Y$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(0,1),"->",[$g$]),
edge((1,0),(1,1),"->",[$g$]),
edge((0,1),(1,1),"->",[$f$]))]
]
]#label("Semigroup")
#statement("Definition")[
The #strong[center]#index-entry("Center") of $G$ is $Z\(G\)= {z in G mid(bar.v) g z = z g \, forall g in G}$. $Z\(G_1 times G_2\)= Z\(G_1\)times Z\(G_2\)$

]
#statement("Definition")[
#strong[Inner automorphism group]#index-entry("Inner automorphism") of $G$ is $I n n\(G\)lt.eq A u t\(G\)$ consists of conjugations $x mapsto g x g^(- 1)$. #strong[Outer automorphism group]#index-entry("Outer automorphism") is $O u t\(G\)= A u t\(G\)\/I n n\(G\)$

]
#statement("Definition")[
$G$ is #strong[perfect]#index-entry("Perfect group") if $\[G\,G\]= G$

]
#statement("Definition")[
A group action is #strong[trivial]#index-entry("Trivial action") if $g dot.op x = x$. A group action is #strong[free]#index-entry("Free action") if $g dot.op x = h dot.op x$ for some $x$ implies $g = h$, or equivalently. A group action is #strong[transitive]#index-entry("Transitive action") if $G dot.op x = X$. A free and transitive action is also called #strong[regular]. A group action is #strong[faithful]#index-entry("Faithful action") if $forall x in X\,G dot.op x eq.not x$

A #strong[homogeneous space]#index-entry("Homogeneous space") is a $G$ space with $G$ acting transitively

]
#statement("Definition")[
A #strong[torsor]#index-entry("Torsor") $P$ is a set with an action $G times P arrow.r P\,\(g\,p\)mapsto g p$ such that this action is free and transitive

When chosen an element $e in P$, automatically you are giving it a group structure with $e$ as identity, notice $e : G arrow.r P\,g mapsto g e$ is a bijection, suppose $g_p e = p$, then $g_e = 1$, the group structure could be given as follows, $P times P arrow.r P\,\(p\,q\)mapsto g_p g_q e$, and the inverse of $p$ is $g_p^(- 1) e$. i.e. a torsor is a group forgetting its identity

]#label("Torsor")
#statement("Definition")[
Let $X\,Y$ be $G$ sets, the we can give $Y^X$ a $G$ set structure by $\(g f\)\(x\)= g f\(g^(- 1) x\)$, it is easy to check that a map $f : X arrow.r Y$ is equivariant iff $f$ is fixed under the $G$ action

Specially, if $G$ acts on $Y$ trivially, we have $\(g f\)\(x\)= f\(g^(- 1) x\)$

]
#statement("Definition")[
$H lt.eq G$ is a subgroup, $N lt.eq G$ is a normal subgroup, $G = N H = N times.r H upright(" or ") H N = H times.l N$ is the #strong[semidirect product]#index-entry("Semidirect product") and every $g in G$ can be uniquely written as $n h$ or $h n$ #display-equation($\(n h\)\(n' h'\)= n\(h n' h^(- 1)\)h h' upright(" or ")\(h n\)\(h' n'\)= h h'\(h' ""^(- 1) n' h'\)n'$)

]
#statement("Theorem", title: [Jordan-Hölder theorem])[
Composition series is unique up to reordering

]
#statement("Definition")[
A #strong[group representation]#index-entry("Group representation") $V$ is a $bb(F) G$ module

]
#statement("Definition")[
Let $\(rho\,V\)$ be a group representation of finite group $G$, $W lt.eq V$ is called $G$ invariant if $G W subset.eq W$, namely, $W$ is $bb(F) G$ submodule, then we get a subrepresentation on $\(rho\|_W\,W\)$ of $G$, with $rho\|_W\(g\):= rho\(g\)\|_W$, if the only $G$ invariant subspace of $W$ are $0$ and $V$, we say $rho$ is irreducible

]
#statement("Definition")[
A group representation $\(rho\,V\)$ is completely reducible#index-entry("Completely reducible representation")\(semisimple) if $V = V_1 xor dots.h.c xor V_n$, where $\(rho\|_(V_i)\,V_i\)$ are irreducible subrepresentations, namely, $V$ is the direct sum of simple $bb(F) G$ modules

]
#statement("Definition")[
Let $V$ be a complex vector space with Hermitian form $\(\,\)$ finite group representation $\(rho\,V\)$ of $G$ is called unitary if $\(rho\(g\)v\,rho\(g\)w\)=\(v\,w\)\,forall g in G\,v\,w in V$

]
#statement("Proposition")[
Let $\(rho\,V\)$ be a unitary representation of $G$, $\(rho\,V\)$ is completely reducible

]
#proof(title: "Proof")[
$W$ is $G$ invariant $arrow.r.double$ $W^perp$ is $G$ invariant

]
#statement("Proposition")[
Let $V$ be a complex vector space, $\(rho\,V\)$ is a representation, then there exists a positive definite Hermitian form on $V$ such that $\(rho\,V\)$ become a unitary representation

]
#statement("Corollary")[
Let $V$ be a complex vector space, a finite group representation $\(rho\,V\)$ is always completely reducible

]
#statement("Definition")[
Let $\(rho\,V\)$ be a representation of $G$, then the dual representation $\(rho^(*)\,V^(*)\)$ is defined as $rho^(*)\(g\):= rho\(g^(- 1)\)^(- T)$. The dual representation is chosen so that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$V times.o V^(*)$]),
node((1,0),[$V times.o V^(*)$]),
node((1,1),[$k$]),
edge((0,0),(1,0),"->",[$rho\(g\)times.o rho^(*)\(g\)$]),
edge((0,0),(1,1),"->"),
edge((1,0),(1,1),"->"))]
]
]
#statement("Definition")[
$H subset.eq G$, $\(V\,pi\)$ is a $H$ representation, the #strong[induced representation]#index-entry("Induced representation") is $bb(F) G times.o_(bb(F) H) V$. Suppose $g_1\,dots.h.c\,g_n$ is a set of representatives of left cosets in $G\/H$, $v_j$ is a basis for $V$, then $g_i times.o v_j$ form a basis for $bb(F) G times.o_(bb(F) H) V$. If $g g_i = g_j h$ for some $h in H$, then $g\(g_i times.o v\)= g g_i times.o v = g_j h times.o v = g_j times.o h v$

]
#statement("Definition")[
If $X$ is a right $G$ space, $Y$ is a left $G$ space, $X times_G Y$ is $X times Y\/tilde.op$, $\(x g\,y\)tilde.op\(x\,g y\)$. Equivalently, $X times_G Y = X times Y\/G$ with left action $g\(x\,y\)=\(x g^(- 1)\,g y\)$ or right action $\(x\,y\)g =\(x g\,g^(- 1) y\)$

If $X\,Y$ are left $G$ spaces, $X times_G Y = X times Y\/G$ with left action $g\(x\,y\)=\(g x\,g y\)$

If $X\,Y$ are right $G$ spaces, $X times_G Y = X times Y\/G$ with right action $\(x\,y\)g =\(x g\,y g\)$

]
#statement("Theorem", title: [Sylow's theorem])[
#index-entry("Sylow’s theorem") $p$ is a prime, a $p$-group is a group consists of elements of order $p$-th power, a maximal one is a #strong[Sylow] $p$#strong[\-subgroup] $P$ of $G$ which always exists by Zorn's Lemma #ref(label("Zorn's lemma"), supplement: none)

+ If $\|G\|= p^n m$, $p divides.not m$, then $\|P\|= p^n$

+ Any subgroup of a Sylow $p$ subgroup is subconjugate to some other Sylow $p$ subgroup

+ $n_p =\[G : N_G\(P\)\]$, if the cojugacy class of $P$ is of order $n_p < oo$, then $n_p equiv 1 #h(0.444em) mod med p$

]#label("Sylow's theorem")
#statement("Definition")[
An #emph[isogeny]#index-entry("Isogeny") is a morphism that is surjective with finite kernel

]
#statement("Definition")[
A #emph[central extension]#index-entry("Central extension") of $G$ is $1 arrow.r K arrow.r C arrow.r G arrow.r 1$, here $K lt.eq Z\(C\)$

]
#statement("Definition")[
A #emph[stem extension]#index-entry("Stem extension") of $G$ is $1 arrow.r K arrow.r C arrow.r G arrow.r 1$, here $K lt.eq Z\(C\)inter C'$

]
#statement("Definition")[
Denote $\[n\]= { 1\,dots.h.c\,n }$, a #strong[permutation]#index-entry("Permutation") $\[n\]arrow.r^sigma\[n\]$ is a bijection, equivalently write $sigma = mat(delim: "(", 1, dots.h.c, n; sigma\(1\), dots.h.c, sigma\(n\))$. $S_n = upright(A u t)\(\[n\]\)$ is the permutation group

The #strong[length] of $sigma in S_n$ is $\|sigma\|$ is the number of $sigma\(i\)< sigma\(j\)$ while $i > j$

]
#statement("Definition")[
Just like shuffling a deck of cards, $sigma in S_n$ is a $\(p_1\,dots.h.c\,p_m\)$#strong[\-shuffle]#index-entry("Shuffle"), $p_1 + dots.h.c + p_m = n$ if $sigma\(i\)< sigma\(i + 1\)$ for $p_1 + dots.h.c + p_k + 1 lt.eq i lt.eq p_1 + dots.h.c + p_(k + 1)$

A $\(p\,q\)$ shuffle can be represented by a path going only right or up from the lower left corner to the upper right corner in a $\(p + 1\)times\(q + 1\)$ grid, $\|sigma\|$ happen to be the number squares under the path

]#label("Definition for shuffle")
#statement("Example", title: [$\(5\,4\)$ shuffles in $S_9$])[
The red one is $mat(delim: "(", 1, 2, 3, 4, 5, 6, 7, 8, 9; 2, 5, 7, 8, 9, 1, 3, 4, 6)$. The blue one is $mat(delim: "(", 1, 2, 3, 4, 5, 6, 7, 8, 9; 1, 2, 4, 7, 8, 3, 5, 6, 9)$

#align(center)[
#universe-drawing(19.0)
]
]
#statement("Definition")[
$G$ is a #emph[Coxeter group]#index-entry("Coxeter group") if it has presentation #display-equation($⟨r_1 \, dots.h.c \, r_n mid(bar.v) \( r_i r_j \)^(m_(i j)) = 1⟩$) $m_(i i) = 1$\(we should think of $r_i$'s as reflections), and $2 lt.eq m_(i j) lt.eq oo\,forall i eq.not j$\($m_(i j) = 2$ means $r_i\,r_j$ commutes). $S = { r_1\,dots.h.c\,r_n }$ is called a #emph[Coxeter system]#index-entry("Coxeter system"), $G$ doesn't determine $S$. The #emph[Coxeter matrix]#index-entry("Coxeter matrix") $M =\(m_(i j)\)$ is symmetric, the corresponding #emph[Schläfli matrix] is $C_(i j) = - 2 cos\(pi\/m_(i j)\)$

]
#statement("Definition")[
The #emph[Coxeter element]#index-entry("Coxeter element") is the product of all simple reflections $s_i$'s, different order in multiplication give conjugation, the #emph[Coxeter number]#index-entry("Coxeter number") is the order of the Coxeter element

]
#statement("Definition")[
The #emph[Coxeter diagram]#index-entry("Coxeter diagram") consists of $n$ nodes for $r_i$'s, there is an edge numbered $m_(i j)$ between $i$ and $j$ if $m_(i j) gt.eq 3$\(number $m_(i j) = 3$ can just be omitted)

]
#statement("Theorem")[
Finite Coxeter groups are classified by Coxeter diagram

]
#proof(title: "Proof")[

]
#statement("Definition", title: [Grothendieck group])[
The #strong[Grothendieck group]#index-entry("Grothendieck group") of a commutative monoid $M$ is the abelian group $K$ and $i : M arrow.r K$ satisfying universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$M$]),
node((0,1),[$K$]),
node((1,1),[$A$]),
edge((0,0),(1,1),"->",[$f$]),
edge((0,0),(0,1),"hook->",[$i$]),
edge((0,1),(1,1),"->",[$exists_1 g$],stroke:(dash:"dashed")))]
]
For any abelian group $A$

]#label("Grothendieck group")
#statement("Construction")[
#display-equation($K = M times M\/tilde.op\,thin M arrow.r^i K\,m mapsto\[m - 0\]$) Abelian group $M times M tilde.equiv {\[m - n\]\|m\,n in M }$ is the set of formal differences with addition #display-equation($\[m_1 - n_1\]+\[m_2 - n_2\]=\[\(m_1 + m_2\)-\(n_1 + n_2\)\]$) $\[0 - 0\]$ is the identity and $\[n - m\]$ is the inverse to $\[m - n\]$ #display-equation($\[m_1 - n_1\]tilde.op\[m_2 - n_2\]upright(" if ") m_1 + n_2 + m = m_2 + n_1 + m upright(" for some ") m in M$)

]
#statement("Construction", title: [Grothedieck completion])[
#index-entry("Grothedieck completion") #display-equation($K = F\(M\)\/tilde.op\,thin m +' n tilde.op\(m + n\)$) $F\(M\)$ is the free abelian group generated by $M$ with addition $+'$

]
#statement("Definition")[
The #strong[Grothendieck group] of a semigroup $S$ is a group $K$ and $i : S arrow.r K$ satisfying the universal property

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$S$]),
node((0,1),[$K$]),
node((1,1),[$G$]),
edge((0,0),(1,1),"->",[$f$]),
edge((0,0),(0,1),"hook->",[$i$]),
edge((0,1),(1,1),"->",[$exists_1 g$],stroke:(dash:"dashed")))]
]
Where $G$ is a group

]
#statement("Construction")[
#display-equation($K = F\(S\)\/tilde.op\,thin m *' n tilde.op\(m * n\)$) $F\(S\)$ is the free group generated by $S$ with multiplication $*'$

]
#statement("Definition")[
$A$ is a unital $K$-algebra. The #emph[standard complex]#index-entry("Standard complex") is #display-equation($dots.h.c arrow.r A times.o A times.o A arrow.r A times.o A arrow.r A arrow.r 0$) with differentials #display-equation($d_n\(a_0 times.o dots.h.c times.o a_(n + 1)\)= sum_(i = 0)^n\(- 1\)^i a_0 times.o dots.h.c times.o a_i a_(i + 1) times.o dots.h.c times.o a_(n + 1)$) Define $s_i : S^(i + 2)\(A\)arrow.r S^(i + 3)\(A\)$, $a mapsto 1 times.o a$, $t_(i + 1) : S^(i + 3)\(A\)arrow.r S^(i + 2)\(A\)$, $lambda times.o a mapsto lambda a$, then $t s = 1$, hence $s$ is a monomorphism. $d_n$'s are uniquely determined by $d_0\(lambda times.o mu\)= lambda mu$, $d s + s d = 1$, i.e. the identity map is null homotopic, hence the standard complex is a free $A$ bimodule resolution of $A$. If we denote $a_0 times.o dots.h.c times.o a_(n + 1)$ as $a_0\[a_1\|dots.h.c\|a_n\]a_(n + 1)$, then #display-equation($d_n\[a_1\|dots.h.c\|a_n\]= a_1\[a_2\|dots.h.c\|a_n\]+ sum_(i = 1)^(n - 1)\(- 1\)^i\[a_1\|dots.h.c\|a_i a_(i + 1)\|dots.h.c\|a_n\]+\(- 1\)^n\[a_1\|dots.h.c\|a_(n - 1)\]a_n$)

]
#statement("Example")[
$d\[a\]= a\[\]-\[\]a$, $d\[a\|b\]= a\[\]-\[a b\]+\[\]b$

]
#statement("Definition")[
The #emph[normalized standard complex]#index-entry("Normalized standard complex") is with $A times.o A\/K times.o dots.h.c times.o A\/K times.o A$

]
#statement("Definition")[
$R$ is a commutative ring, $C_(*)\(G\)$ is the tuple complex, equivalently, $B_(*)\(G\)$ is the bar resolution, $macron(B)_(*)\(G\)= B_(*)\(G\)times.o_(R\[G\]) R$. $B_(*)\(G\)$ is a differential graded algebra with shuffled product

]
#statement("Definition")[
$R$ is a commutative ring, $M$ is right $R\[G\]$ module, $C_(*)\(G\)$ is the tuple complex, equivalently, $B_(*)\(G\)$ is the bar complex, $macron(B)_(*)\(G\)= B_(*)\(G\)times.o_(R\[G\]) R$, thus #display-equation($M times.o_(R\[G\]) B_(*)\(G\)tilde.equiv M times.o_R R times.o_(R\[G\]) B_(*)\(G\)tilde.equiv M times.o_R macron(B)_(*)\(G\)$) Group homology with coefficients in $M$ is #display-equation($H_k\(G\;M\) & = H_k\(M times.o_(R\[G\]) C_(*)\(G\)\)\
 & = H_k\(M times.o_(R\[G\]) B_(*)\(G\)\)\
 & = H_k\(M times.o_R macron(B)_(*)\(G\)\)\
 & = "Tor"_k^(R\[G\])\(M\,R\)$) The differential of $M times.o_(R\[G\]) B_(*)\(G\)$ is given by #display-equation($partial\(m times.o\[g_1\|dots.h.c\|g_n\]\) & = partial\(m times.o\(1\,g_1\,g_1 g_2\,dots.h.c\,g_1 dots.h.c g_n\)\)\
 & = m g_1 times.o\[g_2\|dots.h.c\|g_n\]+ sum_(i = 1)^(n - 1)\(- 1\)^i m times.o\[g_1\|dots.h.c\|g_i g_(i + 1)\|dots.h.c\|g_n\]\
 & +\(- 1\)^n m times.o\[g_1\|dots.h.c\|g_(n - 1)\]$) $H_0\(G\;M\)= M times.o_(R\[G\]) R = M_G$. Write $H_k\(G\)$ for $H_k\(G\;bb(Z)\)$

Group cohomology with coefficients in left $R\[g\]$ module $M$ is #display-equation($H^k\(G\;M\) & = H_k\("Hom"_(R\[G\])\(B_(*)\(G\)\,M\)\)\
 & = "Ext"_(R\[G\])^k\(R\,M\)$) The differential of $"Hom"_(R\[G\])\(B_(*)\(G\)\,M\)$ is given by #display-equation($\(d phi.alt\)\[g_1\|dots.h.c\|g_(n + 1)\] & =\(d phi.alt\)\(1\,g_1\,g_1 g_2\,dots.h.c\,g_1 dots.h.c g_(n + 1)\)\
 & = phi.alt\(partial\(1\,g_1\,g_1 g_2\,dots.h.c\,g_1 dots.h.c g_(n + 1)\)\)\
 & = g_1 phi.alt\[g_2\|dots.h.c\|g_(n + 1)\]+ sum_(i = 1)^n\(- 1\)^i phi.alt\[g_1\|dots.h.c\|g_i g_(i + 1)\|dots.h.c\|g_(n + 1)\]\
 & +\(- 1\)^(n + 1) phi.alt\[g_1\|dots.h.c\|g_n\]$) $H^0\(G\;M\)= "Hom"_(R\[G\])\(R\,M\)= M^G$. Write $H^k\(G\)$ for $H^k\(G\;bb(Z)\)$

]
#aside("Remark")[
A right $R\[G\]$ module $M$ can be viewed as a left $R\[G\]$ module and vice versa via $g^(- 1) m = m g$

]
#statement("Definition")[
The #emph[augmentation ideal]#index-entry("Augmentation ideal") is the kernel of the augmentation map $R\[G\]arrow.r R$

]
#statement("Definition")[
A #emph[derivation] or #emph[crossed homomorphism]#index-entry("Crossed homomorphism") is $D : G arrow.r M$ such that $D\(g h\)= g D\(h\)+ D\(g\)$, this can be identified with $Z^1\(G\;M\)$. $D_m\(g\)= g m - m$ are #emph[principal derivations], this can be identified with $B^1\(G\;M\)$

]
