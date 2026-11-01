#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Examples

#statement("Example")[
Suppose $1 mapsto k$ is an element in $H o m\(bb(Z)\/n bb(Z)\,bb(Z)\/m bb(Z)\)$, then $m divides k n arrow.r.double frac(m, \(n\,m\))$ divides $k frac(n, \(n\,m\))$, thus $frac(m, \(n\,m\))$ divides $k$, thus $k = frac(i m, \(n\,m\))\,i = 0\,dots.h.c\,\(n\,m\)- 1$, thus $H o m\(bb(Z)\/n bb(Z)\,bb(Z)\/m bb(Z)\)tilde.equiv bb(Z)\/\(n\,m\)bb(Z)$

Consider $bb(Z)\/n bb(Z) times.o bb(Z)\/m bb(Z)$, then $n\(1 times.o 1\)= n times.o 1 = 0$, $m\(1 times.o 1\)= 1 times.o m = 0$, thus $\(n\,m\)\(1 times.o 1\)=\(r n + s m\)\(1 times.o 1\)= 0$

Apply functor $H o m\(-\,bb(Z)\/m bb(Z)\)$ to short exact sequence $0 arrow.r bb(Z) arrow.r^(times m) bb(Z) arrow.r bb(Z)\/n bb(Z) arrow.r 0$, we get a left exact sequence $H o m\(bb(Z)\/n bb(Z)\,bb(Z)\/m bb(Z)\)arrow.r bb(Z)\/m bb(Z) arrow.r^(times n) bb(Z)\/m bb(Z) arrow.r 0$

Apply functor $- times.o bb(Z)\/m bb(Z)$ to short exact sequence $0 arrow.r bb(Z) arrow.r^(times m) bb(Z) arrow.r bb(Z)\/n bb(Z) arrow.r 0$, we get a left exact sequence $bb(Z)\/m bb(Z) arrow.r^(times n) bb(Z)\/m bb(Z) arrow.r bb(Z)\/n bb(Z) times.o bb(Z)\/m bb(Z) arrow.r 0$

And the kernel and cokernel of $bb(Z)\/m bb(Z) arrow.r^(times n) bb(Z)\/m bb(Z)$ are both $bb(Z)\/\(n\,m\)bb(Z)$

]
#statement("Example")[
$bb(Q)\/bb(Z) tilde.equiv xor.big_p bb(Z) [1 / p]$

]
#statement("Example")[
$O\(1\,1\)= {mat(delim: "(", cosh t, sinh t; sinh t, cosh t)}$

]
#statement("Example")[
$F$ is a field, $R = "End"\(F^oo\)= { upright("infinite dimensional matrices") }$, Consider $R arrow.r.hook R$ by embedding into odd rows and even rows, we have $R^2 tilde.equiv R$ as right $R$ modules

]#label("R^2=R")
#statement("Example")[
$G L\(2\,bb(F)_2\)= S L\(2\,bb(F)_2\)tilde.equiv S_3$

]
#statement("Example", title: [A ring homomorphism between two local rings that isn't a local ring homomorphism])[
$A = {a / b mid(bar.v) a \, b in bb(Z) \, b upright(" odd")}$ with maximal ideal $2 A$, $B = bb(Q)$, inclusion is not a local ring homomorphism

]
#statement("Example")[
$V subset.eq bb(A)^n$ is an affine variety, $m in upright(S p m) k\[V\]$, $k\[V\]_m$ is the stalk of the sheaf of regular functions. Tow representatives $f / u\,g / v$ are of the same germ $arrow.l.r.double$ $f / u = g / v$ on $D\(w u v\)$ for some $w\(m\)eq.not 0$ $arrow.l.r.double$ $w\(f v - g u\)= 0$

]
#statement("Example", title: [Multiplicative group scheme])[
The multiplicative group scheme over $R$ is $bb(G)_m = "Spec" bb(R)\[x\,x^(- 1)\]$, $bb(G)_m\(A\)= "Hom"\(bb(R)\[x\,x^(- 1)\]\,A\)tilde.equiv A^times\,phi.alt_a arrow.l.r a$, $phi.alt_a\(x\)= a$. The corresponding group multiplication $bb(G)_m times bb(G)_m arrow.r^m bb(G)_m$ should be given by $bb(G)_m\(R\)times bb(G)_m\(R\)arrow.r bb(G)_m\(R\)$, $\(phi.alt_a\,phi.alt_b\)mapsto phi.alt_(a b)$, which factors through $\(bb(G)_m times bb(G)_m\)\(R\)arrow.r bb(G)_m\(R\)$, hence the corresponding comultiplication should be given by $bb(Z)\[x\,x^(- 1)\]arrow.r^Delta bb(Z)\[x\,x^(- 1)\]times.o bb(Z)\[x\,x^(- 1)\]$, $Delta x = x times.o x$, so that $phi.alt_a times.o phi.alt_b\(Delta\(x\)\)= phi.alt_(a b)\(x\)$. By Yoneda's Lemma, this is the unique choice

]
#statement("Example", title: [A surjective local homeomorphism may not be a covering])[
$p : bb(R)\\{ 0 } arrow.r S^1$, or $n$ sheeted cover with a point missing, $p$ is discrete but not proper

]
#statement("Example", title: [Bundle with fiber isomorphic to vector space but not a vector bundle])[
$E := union.sq.big_(x in X) bb(R)^n$

]
#statement("Example")[
$H'_n = H_(k + n)$ also defines a homology theory where the dimension axiom fails

]
#statement("Example", title: [Hawaiian earring])[
The #strong[Hawaiian earring]#index-entry("Hawaiian earring") $H$ is the union of circles with radius $1 / n$ and centered at $\(1 / n\,0\)$ with subspace topology in $bb(R)^2$

#align(center)[
#universe-drawing(8.0)
]
]#label("Hawaiian earring")
#statement("Proposition")[
Hawaiian earring is not a CW complex since it is not locally contractible

]
#statement("Example", title: [Topologist's sine curve])[
The #strong[topologist's sine curve]#index-entry("topologist’s sine curve") is #display-equation($T = {(x \, sin (1 / x)) mid(bar.v) x in \( 0 \, 1 \]} union {\(0\,0\)}$)

#align(center)[
#universe-drawing(9.0)
]
]
#statement("Proposition")[
The topologist's sine curve $T$ is connected but not path connected

]
#statement("Example", title: [Warsaw circle])[
The #strong[Warsaw circle]#index-entry("Warsaw circle") $W$ is the topologist's sine curve enclosed

Bijective map $W arrow.r\[0\,1\)$ is not a homeomorphism, thus not a quotient map. $W$ is weakly homotopic to a point but not homotopic

]
#statement("Example")[
$X = bb(N)$ with discrete topology, $Y = { 0\,1\,1 / 2\,1 / 3\,dots.h.c }$ with subspace topology of $bb(R)$, then $f : X arrow.r Y\,n mapsto 1 / n$ is a weak homotopy equivalence, however, $X\,Y$ are not homotopy equivalent, otherwise suppose $g : X arrow.r Y\,h : Y arrow.r X$ such that $h g tilde.eq 1_X$, $g h tilde.eq 1_Y$, suppose $F : Y times I arrow.r Y$ is a homotopy, then the restriction of $F$ on ${ y } times I$ must be a constant map since the connected components of $Y$ are just points, thus $F\(y\,0\)= F\(y\,1\)$, i.e. homotopic maps are in fact the same, for a similar argument on $X$, we have $h g = 1_X$, $g h = 1_Y$ , thus $h$ is injective which is impossible since $h^(- 1)\(h\(0\)\)$ consists of more then one point

]
#statement("Example")[
$D^2 = S^2\\{ N } subset.eq S^2$ is not a cofibration. $D^2\\{ 0 } subset.eq D^2$ is not a cofibration

]#label("Cofibration counterexample")
#statement("Example")[
$A =\[- 1\,0\)union\(0\,1\]$, $X =\[- 1\,1\]$, then the mapping cylinder of the inclusion $A arrow.r.hook^i X$ has different topology from the subspace topology $X times { 0 } union A times I$ induced from $X times I$

#align(center)[
#universe-drawing(10.0)
]
]#label("Mapping cylinder of inclusion may have different topology then induced subspace topology")
#statement("Example")[
${ a\,b }$ with trivial topology, ${ a } subset.eq { a\,b }$ is a nonclosed cofibration since there is a retraction $I union.sq I arrow.r I union.sq { 0 }$, $\(s\,t\)mapsto\(s\,0\)$

]#label("Nonclosed cofibration")
#statement("Example")[
The #strong[comb space]#index-entry("Comb space") is $\[\(0\,0\)\,\(1\,0\)\]union.big union.big_(n = 1)^oo\[\(1 / n\,0\)\,\(1 / n\,1\)\]$

#align(center)[
#universe-drawing(11.0)
]
]
#statement("Example")[
A topological space with a cell decomposition may not be Hausdorff, consider $\(- 1\,1\)$ with two origins, which has $\(- 1\,0\)\,\(0\,1\)$ as $1$ cells and two origins as $0$ cells

#align(center)[
#universe-drawing(12.0)
]
]#label("A line with two origins")
#statement("Example")[
$D subset.eq bb(C)$ is the unit disc, $f\(z\)= sum_(n = 0)^oo z^(2^n) / n^2$ is continuous on $overline(D)$ and holomorphic on $D$ but not on any point on $partial D$

]
#statement("Example", title: [Tractrix])[
An interval $I$ with one end point pushed or dragged along the $x$ axis gives a #strong[Tractrix]#index-entry("Tractrix"). The velocity has the same direction as $I$, i.e. $frac(d x, d y) = plus.minus sqrt(a^2 - y^2) / y$, which gives solution $x = plus.minus (ln frac(a + sqrt(a^2 - y^2), y) - sqrt(a^2 - y^2))$

#align(center)[
#universe-drawing(13.0)
]
]
#statement("Example")[
$R$ is a commutative ring. The category of $R$-modules is a monoidal category with

- $\(A times.o B\)times.o C arrow.r^alpha A times.o\(B times.o C\)$, $\(a times.o b\)times.o c mapsto a times.o\(b times.o c\)$

- $R times.o A arrow.r^lambda A$, $r times.o a mapsto r a\,A times.o R arrow.r^rho A$, $a times.o r mapsto r a$

]
#statement("Example")[
$R$ is a commutative ring. $R$-algebra/coalgebra/bialgebra is a monoid/comonoid/bimonoid of the category of $R$-modules,

]
#statement("Example")[
The image of a functor is not necessarily a category

Consider the following categories $cal(C)$ and $cal(D)$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,0),[$B$]),
node((2,0),[$C$]),
node((3,0),[$D$]),
edge((0,0),(1,0),"->",[$f$]),
edge((0,0),(1,0),"->",[$1_A$]),
edge((1,0),(2,0),"->",[$1_B$]),
edge((2,0),(3,0),"->",[$g$]),
edge((2,0),(3,0),"->",[$1_C$]),
edge((3,0),(4,0),"->",[$1_D$]))]
]
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$E$]),
node((1,0),[$F$]),
node((2,0),[$G$]),
edge((0,0),(1,0),"->",[$h$]),
edge((0,0),(1,0),"->",[$1_E$]),
edge((0,0),(2,0),"->",[$i h$],bend:-15deg),
edge((1,0),(2,0),"->",[$1_F$]),
edge((1,0),(2,0),"->",[$i$]),
edge((2,0),(3,0),"->",[$1_G$]))]
]
Consider functor $F : cal(C) arrow.r cal(D)$, $F\(A\)= E$, $F\(B\)= F$, $F\(C\)= F$, $F\(D\)= G$, $F\(f\)= h$, $F\(g\)= i$

]
#statement("Example", title: [Presheaves that are not sheaves])[
+ $G$ is a nontrivial abelian group. Consider presheaf $cal(G)$ given by $cal(G)\(U\)= G$ for any nonempty open subset and $cal(G)\(diameter\)= 0$. For example $G = bb(Z)\/2$, $X = { a\,b }$ with discrete topology, $cal(G)\({ a\,b }\)= cal(G)\({ a }\)= cal(G)\({ b }\)= bb(Z)\/2$, $cal(G)\(diameter\)= 0$. Then $1$ on ${ a }$ and $0$ on ${ b }$ cannot be glued together.

+ Suppose $phi.alt : cal(F) arrow.r cal(G)$ is a morphism of sheaves, $"im" phi.alt$ and $"coker" phi.alt$ are not generally sheaves. For example consider $exp : cal(O) arrow.r cal(O)^times$, $"im" exp$ is a presheaf but not a sheaf

]
#statement("Definition", title: [$cal(O)\(n\)$ bundle over Riemann sphere $S^2 tilde.equiv bb(C) P^1$])[
Suppose $(bb(C) \, z mapsto z)$, $(S^2 \\ 0 \, z mapsto 1 / z)$ are the charts coordinate of $S^2$ with transition map $z mapsto 1 / z$ both ways on $bb(C)\\0$, or equivalently

$(U_0 \, \[ 1 \, z \] mapsto z)$, $(U_1 \, \[ z \, 1 \] mapsto z)$ are the corresponding charts of $bb(C) P^1$ with transition map $z mapsto 1 / z$ both ways on $U_0 inter U_1$, namely, $S^2 arrow.r bb(C) P^1$, $z mapsto\[1\,z\]$, $oo mapsto\[0\,1\]$ is and isomorphism because of isomorphisms on charts

Now define $cal(O)\(n\)$ line bundle on $S^2$ by specify transition functions $g_10\(z\)= z^(- n)$, $g_01\(z\)= z^n$, $forall z in bb(C)\\0 tilde.equiv U_0 inter U_1$

]
#statement("Definition", title: [Tautological line bundle over Riemann sphere])[
The tautological bundle#index-entry("Tautological bundle") is $cal(O)\(- 1\)$, tautological bundle is defined as a subspace $E$ of $bb(C) P^1 times bb(C)^2$ consists of $\(l\,v\)$ with $v in l$ projects to the first factor, let's figure out the trivializations!

$phi_0 : U_0 times bb(C)^2 inter E arrow.r bb(C) times bb(C)$, $\(\[1\,z\]\,t\(1\,z\)\)mapsto\(z\,t\)$, and $phi_1 : U_1 times bb(C)^2 inter E arrow.r bb(C) times bb(C)$, $\(\[z\,1\]\,t\(z\,1\)\)mapsto\(z\,t\)$, since $phi_1 compose phi_0^(- 1) :\(U_0 inter U_1\)times bb(C)^2 inter E arrow.r\(U_0 inter U_1\)times bb(C)^2 inter E$, $\(z\,t\)mapsto (1 / z \, z t)$, the transition function $g_10\(z\)= z$

]
#aside("Remark")[
$cal(O)\(- 1\)$ doesn't nonzero global section, suppose $s$ is a global section of $cal(O)\(- 1\)$, then $s\(x\)=\(x\,f\(x\)\)in E arrow.r.hook bb(C) P^1 times bb(C)^2$ is holomorphic, but then image of $sigma$ has to be a point, and this point must be zero

]
#statement("Example")[
We still use $U_0\,U_1$ to denote coordinate charts, $phi_0\,phi_1$ to denote corresponding trivializations

Global sections of $cal(O) = cal(O)\(0\)$ are exactly holomorphic functions which are just constants, suppose $s : S^2 arrow.r cal(O)$ is a section, and $phi_0 compose s\|_(U_0)\(z\)=\(z\,f_0\(z\)\)$, $phi_1 compose s\|_(U_1) (1 / z) = (1 / z \, f_1 (1 / z))$, then we have $\(z\,f_1\(z\)\)= phi_1 compose s\|_(U_1)\(z\)= phi_1 compose s\|_(U_0)\(z\)= phi_1 compose phi_0^(- 1) compose phi_0 compose s\|_(U_0)\(z\)= phi_1 compose phi_0^(- 1)\(z\,f_0\(z\)\)=\(z\,g_10\(z\)f_0\(z\)\)\,forall z in U_0 inter U_1$, thus $f_1\(z\)= g_10\(z\)f_0\(z\)= f_0\(z\)$ which precisely means $s$ correspond to holomorphic function $f$ over $X$, $f\|_(U_0) = f_0\,f\|_(U_1) = f_1$

Let's show that the canonical bundle(which in the case of a Riemann surface is the same as the cotangent bundle) is $cal(O)\(- 2\)$, since $d (1 / z) = - 1 / z^2 d z$, the transition function would be $g_10\(z\)= - z^2$, but using $d z$ or $- d z$ as the a basis element would be isomorphic

]
#statement("Proposition")[
$H^0 (C P^1 \, cal(O) \( n \))$, the vector space of global sections of $cal(O)\(n\)arrow.r bb(C) P^1\,n gt.eq 0$ generated by homogeneous polynomials $z_0^n\,z_0^(n - 1) z_1\,dots.h.c\,z_0 z_1^(n - 1)\,z_1^n$

]
#proof(title: "Proof")[
$z_0^k z_1^(n - k)$ have the forms $z_1^(n - k)$ and $z_0^k$ in $U_0$ and $U_1$

]
#statement("Example", title: [Line bundles on the projective space $bb(C) P^n$])[
Suppose $(U_0 \, \[ 1 \, z_1 \, dots.h.c \, z_n \] mapsto \( z_1 \, dots.h.c \, z_n \))$, $(U_n \, \[ z_0 \, z_1 \, dots.h.c \, z_(n - 1) \, 1 \] mapsto \( z_0 \, dots.h.c \, z_(n - 1) \))$ be coordinate charts of $bb(C) P^n$, with transition map $U_i inter U_j arrow.r U_i inter U_j\,(z_0 / z_i \, dots.h.c \, hat(z_i / z_i) \, dots.h.c \, z_n / z_i) mapsto (z_0 / z_j \, dots.h.c \, hat(z_j / z_j) \, dots.h.c \, z_n / z_j)$, which is kind of like multiply by $z_i / z_j$, then the line bundle $cal(O)\(m\)$ is defined by transition function $g_(j i) = z_j / z_i$ which satisfies the cocycle condition

Similarly, we can check that the tautological bundle $E = {\( l \, v \) mid(bar.v) v in l} subset bb(C) P^n times bb(C)^(n + 1)$ projects to $bb(C) P^n$ is $cal(O)\(1\)$

It is obvious that any degree $n$ polynomial are global section of $cal(O)\(n\)$

]
#statement("Example")[
$X$ is topological space, $E n d\(X\)$ is a unital nonassociative $bb(R)$ algebra which is not symmetric, antisymmetric, nor does it satisfy Jacobi identity

]
#statement("Example")[
Consider $C^oo\(M\)$ where $M$ is a smooth manifold, then $cal(L)\(M\)= D e r\(C^oo\(M\)\)$ consists of vector fields, it is a Lie algebra, hence we can think of derivations as linear differential operator of order $1$, then we know that the commutator of two such operators is again a linear differential operator of order $1$

]
#statement("Example")[
Let $frak(g)$ be a Lie algebra, then ideals of $frak(g)$ precisely the Lie algebra subrepresentations of the adjoint representation $\(a d\,frak(g)\)$

]
#statement("Example", title: [Lie algebra of $M_n\(bb(R)\)$])[
Suppose $X = sum_(i\,j) X_(i j) frac(partial, partial x_(i j))$ is a left invariant #display-equation($X_(k l)\(A\) & = sum_(i\,j) X_(i j)\(A\)frac(partial x_(k l), partial x_(i j))\(A\)\
 & = X_A\(x_(k l)\)=\(L_A\)_0 X_0\(x_(k l)\)\
 & = X_0\(x_(k l) compose L_A\)\
 & = sum_(i\,j) X_(i j)\(0\)frac(partial\(x_(k l) compose L_A\), partial x_(i j))\(0\)\
 & = X_(k l)\(0\)$) Thus $X_(i j)$ are constants #display-equation($\[X\,Y\] & = [sum_(i\,j) X_(i j) frac(partial, partial x_(i j)) \, sum_(k\,l) Y_(k l) frac(partial, partial x_(k l))]\
 & = sum_(i\,j\,k\,l) X_(i j) Y_(k l) [frac(partial, partial x_(i j)) \, frac(partial, partial x_(k l))]\
 & = sum_(i\,j) X_(i j) Y_(i j) [frac(partial, partial x_(i j)) \, frac(partial, partial x_(k l))]\
 & = 0$) Therefore $upright(L i e)\(M_n\(bb(R)\)\)= 0$

]
#statement("Example", title: [Lie algebra of $G L\(n\,bb(R)\)$])[
Suppose $X = sum_(i\,j) c_(i j) frac(partial, partial x_(i j))$ is a left invariant field #display-equation($c_(k l)\(A\) & = sum_(i\,j) c_(i j)\(A\)frac(partial x_(k l), partial x_(i j))\(A\)\
 & = X_A\(x_(k l)\)=\(L_A\)_I X_I\(x_(k l)\)\
 & = X_I\(x_(k l) compose L_A\)\
 & = sum_(i\,j) c_(i j)\(I\)frac(partial\(x_(k l) compose L_A\), partial x_(i j))\(I\)\
 & = sum_i a_(k i) c_(i l)\(I\)$) Hence $C\(A\)= A C\(I\)$, $frac(partial c_(k l), partial x_(i j)) = delta_(k i) c_(j l)\(I\)$ #display-equation($\[X\,Y\] & = [sum_(i\,j) c_(i j) frac(partial, partial x_(i j)) \, sum_(k\,l) d_(k l) frac(partial, partial x_(k l))]\
 & = sum_(i\,j\,k\,l) [c_(i j) frac(partial, partial x_(i j)) \, d_(k l) frac(partial, partial x_(k l))]\
 & = sum_(i\,j\,k\,l) c_(i j) frac(partial, partial x_(i j)) (d_(k l) frac(partial, partial x_(k l))) - d_(k l) frac(partial, partial x_(k l)) (c_(i j) frac(partial, partial x_(i j)))\
 & = sum_(i\,j\,k\,l) c_(i j) (frac(partial d_(k l), partial x_(i j)) frac(partial, partial x_(k l)) + d_(k l) frac(partial^2, partial x_(i j) partial x_(k l))) - d_(k l) (frac(partial c_(i j), partial x_(k l)) frac(partial, partial x_(i j)) + c_(i j) frac(partial^2, partial x_(i j) partial x_(k l)))\
 & = sum_(i\,j\,k\,l) c_(i j) frac(partial d_(k l), partial x_(i j)) frac(partial, partial x_(k l)) - d_(k l) frac(partial c_(i j), partial x_(k l)) frac(partial, partial x_(i j))\
 & = sum_(i\,j\,k\,l) c_(i j) frac(partial d_(k l), partial x_(i j)) frac(partial, partial x_(k l)) - sum_(i\,j\,k\,l) d_(k l) frac(partial c_(i j), partial x_(k l)) frac(partial, partial x_(i j))\
 & = sum_(i\,j\,k\,l) c_(i j) frac(partial d_(k l), partial x_(i j)) frac(partial, partial x_(k l)) - sum_(i\,j\,k\,l) d_(i j) frac(partial c_(k l), partial x_(i j)) frac(partial, partial x_(k l))\
 & = sum_(i\,j\,k\,l) (c_(i j) frac(partial d_(k l), partial x_(i j)) - d_(i j) frac(partial c_(k l), partial x_(i j))) frac(partial, partial x_(k l))\
 & = sum_(j\,k\,l) (c_(k j) d_(j l) - d_(k j) c_(j l)) frac(partial, partial x_(k l))\
 & = sum_(k\,l) (sum_j c_(k j) d_(j l) - d_(k j) c_(j l)) frac(partial, partial x_(k l))\
 & = sum_(k\,l) b_(k l) frac(partial, partial x_(k l))$) Here $B =\[C\,D\]$. Therefore $upright(L i e)\(G L\(n\,bb(R)\)\)= frak(g l)\(n\,bb(R)\)$

]
#statement("Example")[
Consider the $Phi : G L\(n\,bb(R)\)arrow.r M_n\(bb(R)\)\,A mapsto A^T A$ which is a smooth map, and level set $Phi^(- 1)\(I\)= O\(n\,bb(R)\)$ is the orthogonal group, to show this is a Lie subgroup, thanks to Theorem #ref(label("Constant rank level set theorem"), supplement: none), it suffices to show $Phi$ is of constant rank, but $Phi$ is equivariant assuming $G L\(n\,bb(R)\)$ acts on itself by right multiplication and acts on $M_n\(bb(R)\)$ by $X dot.op A = A^T X A\,X in M_n\(bb(R)\)\,A in G L\(n\,bb(R)\)$, since $Phi\(A\)dot.op B = B^T A^T A B = Phi\(A B\)$

$\(d Phi\)_I\(B\)= B^T + B$, and $T_I\(O\(n\,bb(R)\)\)= ker\(d Phi\)_I = { B in M\(n\,bb(R)\)\|B^T + B = 0 }$

]
#statement("Example")[
Union of topologies may not be a topology

]
