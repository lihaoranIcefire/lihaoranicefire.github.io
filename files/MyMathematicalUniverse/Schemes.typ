#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Schemes

#statement("Definition")[
A #emph[subscheme] $Y$ of $X$ is a topological subspace of $Y subset.eq X$

]
#statement("Proposition", title: [Gluing schemes])[
${ X_i }_(i in I)$ is a family of schemes, suppose that

- $V_(i j) subset.eq X_i$ are open subschemes with $V_(i i) = X_i$

- $phi_(i j) : V_(i j) arrow.r V_(j i)$ are isomorphisms with $phi_(i i) = "id"$

- $phi_(i k) = phi_(i j) compose phi_(j k) : V_(k i) inter V_(k j) arrow.r V_(i k) inter V_(i j)$

- $phi_(i j)\|_(V_(i j) inter V_(i k)) : V_(i j) inter V_(i k) arrow.r V_(j i) inter V_(j k)$ are isomorphisms

Then there is a scheme $X$ (up to isomorphism) with an open covering ${ U_i }_(i in I)$ with open immersions $psi_i : X_i arrow.r X$ with $psi\(X_i\)= U_i$ such that $d$

]
#proof(title: "Proof")[

]
#statement("Lemma", title: [Functor of points])[
$X$ is a scheme, its #emph[functor of points] is #display-equation($"Hom"\(-\,X\): { mono("Affine schemes") }^(upright("op")) arrow.r { mono("Sets") }$) Conversely, a functor is the functor of points of some scheme if it is a Zariski sheaf covered by affine schemes

]
#proof(title: "Proof")[

]
#statement("Definition")[
Suppose $\(X\,cal(O)\)$ is a ringed space. $cal(F)$ is a sheaf of $cal(O)$-module. $cal(F)$ is quasi-coherent if for any $x in X$, there is an open neighborhood $U$ of $x$ such that $cal(F)_U$ is the cokernel of $xor.big_(i in I) cal(O)_U arrow.r xor.big_(j in J) cal(O)_U$

]
#statement("Proposition")[
Quasi-coherent sheaves over $"Spec" R$ are $R$-modules.

]
#proof(title: "Proof")[

]
#statement("Definition")[
$phi : X arrow.r Y$ is #emph[dominant]#index-entry("Dominant morphism") if $phi\(X\)$ is dense

]
#statement("Definition")[
$phi : X arrow.r Y$ is #emph[quasi-finite]#index-entry("Quasi-finite morphism") if $phi^(- 1)\(x\)$ is finite for any $x in X$

]
#statement("Definition")[
A #emph[variety] is a separated, finite type and integral scheme $X$ over $k$.

]
#statement("Proposition")[
An affine variety $X$ is of the form $"Spec" k\[x_1\,dots.h.c\,x_n\]\/\(f_1\,dots.h.c\,f_m\)$

]
#statement("Definition")[
$phi : X arrow.r Y$ is #emph[affine] if $phi^(- 1)\(U\)$ is affine for any affine open $U$

]
#statement("Definition")[
An affine morphism $phi : X arrow.r Y$ is #emph[finite]#index-entry("Finite morphism") if $k\[U\]$ is finite $k\[V\]$-algebra for any $phi^(- 1)\(V\)= U$ with $U\,V$ affine.

]
#statement("Proposition")[
A finite morphism $phi$ is quasi-finite

]
#statement("Definition")[
An affine morphism $phi : X arrow.r Y$ is #emph[integral]#index-entry("Integral morphism") if $k\[U\]$ is integral over $k\[V\]$ for any $phi^(- 1)\(V\)= U$ with $U\,V$ affine.

]
#statement("Definition")[
The #emph[canonical bundle]#index-entry("canonical bundle") of an algebraic variety $X$ of dimension $n$ is $K = and.big^n Omega$, $Omega$ is the cotangent bundle

]
#statement("Definition")[
The #emph[Picard group]#index-entry("Picard group") is $H^1\(X\,cal(O)^(*)\)$

]
#statement("Definition")[
$X$ is #emph[complete]#index-entry("Complete variety") if for any variety $Y$, the projection $X times Y arrow.r Y$ is closed

]
#statement("Proposition")[
A closed subvariety of a complete variety is complete. The image of a complete variety is complete. A complex variety is complete if and only if it is compact as a complex-analytic variety

]
#statement("Definition")[
A #emph[rational map] between algebraic varieties $f : X arrow.r Y$ is a morphism from a nonempty open subseteq $U subset.eq X$ to $Y$, if $g : Y arrow.r Z$ is also a rational map, then we can consider $g compose f : X arrow.r Z$, $f$ is a #emph[birational map] if it has an inverse

]
#statement("Definition")[
A rational curve is an algebraic variety birational equivalent to $bb(A)^1$, since birational equivalence preserve function field, we may assume it's $F\(t\)$

]
#statement("Definition")[
$X$ is #emph[integral] if $cal(O)\(U\)$ is an integral domain for any open $U$

]
#statement("Lemma")[
Scheme $X$ is integral $arrow.l.r.double$ $X$ is irreducible and reduced

]
#proof(title: "Proof")[
Suppose $X$ is integral, then obviously it is reduced, if $X$ is not irreducible, then there exist disjoint nonempty open subsets $U\,V$\(just take irreducible component minus the others), but then $cal(O)\(U union V\)tilde.equiv cal(O)\(U\)times cal(O)\(V\)$ is not integral. Conversely, suppose $X$ is irreducible and reduced, note that if $U subset.eq X$ is affine integral $arrow.l.r.double$ $cal(O)\(U\)$ is the spectrum of an integral domain. $cal(O)\(U\)$ is a domain for any open subset $U$, just show that $cal(O)\(U\)arrow.r cal(O)\(V\)$ restriction is injective for any affine $V subset.eq U$

]
#statement("Definition")[
$X$ is #emph[reduced] if $cal(O)\(U\)$ is reduced for any open $U$

]
#statement("Definition")[
$X arrow.r S$ is #emph[separated] if $Delta\(X\)$ is closed, $Delta : X arrow.r X times_S X$ is a closed immersion

]
#statement("Definition")[
$f : X arrow.r Y$ is locally P if for each affine chart $V subset.eq Y$, $f^(- 1)\(V\)$ is covered by affine charts $U_i$ such that $f\|_(U_i) : U_i arrow.r V$ between affine schemes are of P. Such examples include

+ Locally of finite type

+ Locally finitely presented

]
#statement("Definition")[
$f : X arrow.r S$ is a flat morphism iff for each $x in X$, $cal(O)_(X\,x)$ is a flat $cal(O)_(S\,f\(x\))$ module. Suppose $cal(F)$ is a quasi-coherent sheaf on $X$, then $cal(F)$ is flat iff $cal(F)_x$ is a flat $cal(O)_(S\,f\(x\))$ module.

]
#statement("Definition")[
$f : X arrow.r Y$ is universally P if $f_Z : X times_Y Z arrow.r Z$ is P for any $Z arrow.r Y$, i.e. under base change

]
#statement("Definition")[
$X$ is an integral scheme, $X = union.big "Spec" A_i$, $A_i$ are integral domains, let $B_i$ be the integral closure of $A_i$, the #emph[normalization] of $X$ is $Y = union.big "Spec" B_i$ with the induced finite morphism $Y arrow.r X$

]
#statement("Lemma")[
Normalizations of dimension $1$ schemes are regular, normalizations of dimension $2$ schemes only have isolated singularities

]
#statement("Example")[
$k\[x\,y\]\/\(x^2 - y^3\)tilde.equiv k\[t^2\,t^3\]$ with field of fractions $k\(t\)$ and integral closure $k\[t\]$, thus the normalization of curve $"Spec" (frac(k\[x\,y\], \(x^2 - y^3\)))$ is #display-equation($"Spec" k\[t\] & arrow.r "Spec" (frac(k\[x\,y\], \(x^2 - y^3\)))\
t & mapsto\(t^3\,t^2\)$)

]
#statement("Definition")[
$f : X arrow.r Y$ is #emph[flat] if $f : cal(O)_(X\,f\(x\)) arrow.r cal(O)_(Y\,x)$ is flat for all $x in X$

]
#statement("Definition")[
$X$ is a #emph[regular] scheme $arrow.l.r.double cal(O)_(X\,x)$ is a regular local ring for any $x in X$

]
#statement("Definition")[
$X$ is a #emph[normal] scheme $arrow.l.r.double cal(O)_(X\,x)$ is a normal domain for any $x in X arrow.l.r.double cal(O)_X\(U\)$ is a normal domain for any open set $U subset.eq X arrow.l.r.double forall x in X$, there exists $U in.rev x$ such that $cal(O)_X\(U\)$ is a normal domain

]
#statement("Lemma")[
If $X$ is an integral normal scheme, then $Gamma\(X\,cal(O)_X\)$ is a normal domain.

]
#proof(title: "Proof")[

]
#statement("Lemma")[
Regularity implies normality.

]
#proof(title: "Proof")[

]
#statement("Definition")[
$f : X arrow.r S$ is a smooth if it is smooth on each affine patch, or equivalently, locally of finite presentation and flat

]
#statement("Definition")[
$f : X arrow.r Y$ is #emph[unramified]#index-entry("Unramified morphism") if

- $f$ is locally finitely presented

- For $f\(x\)= y$, $k\(x\)\/k\(y\)$ is a separable algebraic extension and $m_y cal(O)_(X\,x) = m_x$

]
#statement("Definition")[
$f : X arrow.r Y$ is an #emph[étale morphism]#index-entry("Étale morphism") if $f$ is flat and unramified. Étale morphism should be thought of as a local isomorphism.

]
#statement("Definition")[
The #emph[direct image functor]#index-entry("Direct image functor") of $f : X arrow.r Y$ is $f_(*) : "Sh"\(X\)arrow.r "Sh"\(Y\)$, $f_(*)\(F\)\(V\)= F\(f^(- 1) V\)$ The $f_(*)$ is left exact, $R^q f_(*) F$ is the associated sheaf to the presheaf $U mapsto H^q\(f^(- 1)\(U\)\,F\)$

]
#statement("Definition")[
The #emph[inverse image functor]#index-entry("Inverse image functor") of $f : X arrow.r Y$ is $f^(- 1) : "Sh"\(Y\)arrow.r "Sh"\(X\)$, the sheafification of #display-equation($U mapsto lim_arrow.r_(V supset.eq f\(U\)) G\(V\)$) The pullback sheaf of $y arrow.r.hook Y$ is the stalk $O_(Y\,y)$

For $cal(O)_Y$ modules $cal(V)$, we have $f^(*) cal(V) = f^(- 1) cal(V) times.o_(f^(- 1) cal(O)_Y) cal(O)_X$

]
#aside("Remark")[
Given a vector bundle, its sheaf of sections is locally free. Conversely, if we have a locally free sheaf then it's the sheaf of sections of a vector bundle which we can build by taking sheaf Spec of the symmetric algebra of the locally free sheaf

]
#statement("Definition")[
$f : Z arrow.r X$ is a closed immersion if $f\(Z\)$ is closed and locally regular functions on $Z$ can be extended to regular functions on $X$, i.e. $f^(\#) : cal(O)_X arrow.r f_(*) cal(O)_Z$ is surjective

]
#statement("Definition")[
$f : X arrow.r Y$ is proper if it is separated, universally closed and of finite type

]
#statement("Proposition")[
Composition of proper morphisms is proper. Closed immersions are proper

]
#statement("Definition")[
$L\/k$ is a field extension, #emph[Weil restriction] is the right adjoint of fiber product, i.e. $"Res"_(L\/k) X\(S\)= X\(S times_k L\)$, or $"Hom"\(-\,"Res"_(L\/k) x\(-\)\)= "Hom"\(- times_k L\,-\)$

]
#statement("Proposition")[
Suppose $X = "Spec" A$, $Y = "Spec" B$, $f : B arrow.r A$, $M\,N$ are modules over $A\,B$ that corresponds to $cal(O)$-modules $cal(F)\,cal(G)$ over $X\,Y$, then $f_(*) cal(F)$ corresponds to $M$ regarded as a $B$ module, $f^(- 1) cal(G)$ corresponds to

]
#statement("Definition")[
Let $X$ be a locally Noetherian integral scheme, a prime divisor is an integral subscheme $Z subset.eq U$, a #emph[Weil divisor] is $sum_(Z upright(" prime divisors")) n_Z Z$, where the sum is locally finite

]
#statement("Definition")[
Let $X$ be a integral Noetherian scheme, a Cartier divisor is a family ${ U_i\,f_i }$, where ${ U_i }$ is an open cover of $X$, and $f_i in Gamma\(U_i\,cal(M)_X^times\)$ such that $f_i\/f_j in Gamma\(U_i inter U_j\,cal(O)_X^times\)$, i.e. a Cartier divisor is a global section of $cal(M)_X^times\/cal(O)_X^times$

]
#statement("Lemma")[
There is a map $"Div"\(X\)arrow.r "Pic"\(X\)$ that sends a Cartier divisor to its associated line bundle, which is given by $cal(L)\|_(U_i) = cal(O)_X 1 / f_i$, hence the transition map is $f_i\/f_j$ on $U_i inter U_j$ from $U_i$ to $U_j$

]
#statement("Example", title: [Vector bundles over $bb(A)_k^n$])[
Suppose $E = bb(A)_k^n times_k bb(A)_k^r arrow.r^pi bb(A)_k^n$ is a vector bundle, then a section would be determined by $\(t_1\,dots.h.c\,t_r\)mapsto\(f_1\(x_1\,dots.h.c\,x_n\)\,dots.h.c\,f_r\(x_1\,dots.h.c\,x_n\)\)$

]
#statement("Definition", title: [Gluing construction of $bb(P)^n$])[
Consider $U_i = k\[X_0 / X_i\,dots.h.c\,hat(X_i / X_i)\,dots.h.c\,X_n / X_i\]$, then $U_i -\[0 : dots.h.c : 1_j : dots.h.c : 0\]$ would be $k\[X_0 / X_i\,dots.h.c\,hat(X_i / X_i)\,dots.h.c\,\(X_j / X_i\)^(plus.minus 1)\,dots.h.c\,X_n / X_i\]$, and the transition map would be $phi_(i j) : U_i arrow.r^(X_i / X_j) U_j$

]
#statement("Definition", title: [$cal(O)\(n\)$ bundles over $bb(P)^n$])[
Suppose $L arrow.r^pi bb(P)^n$ is a line bundle, and $U_i times_k bb(A)_k^1 tilde.equiv "Spec" k\[X_0 / X_i\,dots.h.c\,hat(X_i / X_i)\,dots.h.c\,X_n / X_i\]times.o_k k\[t_i\]$, and consider map #display-equation($U_i times bb(A)_k^1 arrow.r^(X_i / X_j times.o\(X_i / X_j\)^d) U_j times bb(A)_k^1$) Hence a global section of $H^0\(bb(P)^n\,cal(O)\(d\)\)$ would necessarily looks like a homogeneous polynomial $f$ of degree $d$, so that #display-equation($\(X_i / X_j\)^d f\(X_0 / X_i\,dots.h.c\,hat(X_i / X_i)\,dots.h.c\,X_n / X_i\)= f\(X_0 / X_j\,dots.h.c\,hat(X_j / X_j)\,dots.h.c\,X_n / X_j\)$)

]
#statement("Example", title: [Tautological bundle and Hyperplane bundle(Serre's twisting sheaf)])[

]
#statement("Definition")[
Dimension

]
#statement("Proposition")[
$dim\(cal(O)_(Y\,y)\)= "codim"\(X\,Y\)$

]
Classically, ideal $I subset.eq k\[x_1\,dots.h.c\,x_n\]$ corresponds to an algebraic set $V\(I\)subset.eq bb(A)^n$, $p =\(a_1\,dots.h.c\,a_n\)in bb(A)^n$, then tangent space $T_p V$\(view as embedded in $bb(A)^n$) will just be #display-equation(${\( y_1 \, dots.h.c \, y_n \) in bb(A)^n mid(bar.v) sum_(i = 1)^n \( y_i - a_i \) frac(partial f, partial x_i) \( p \) = 0 \, forall f in I}$)

#statement("Definition")[
$k\[epsilon.alt\]= k\[x\]\/\(x^2\)$ is a local $k$ algebra with maximal ideal $\(epsilon.alt\)$, $p in X\(k\)$, then $T_p V tilde.equiv "Hom"_(upright("loc"))\(cal(O)_(V\,p)\,k\[epsilon.alt\]\)$, i.e. $T_p X$ is the fiber over $p$ of $X\(k\[epsilon.alt\]\)arrow.r X\(k\)$ induced by $k\[epsilon.alt\]arrow.r k$, $epsilon.alt mapsto 0$, i.e. $alpha : A arrow.r k\[epsilon.alt\]$ such that $A arrow.r^alpha k\[epsilon.alt\]arrow.r k$ has kernel $p$\(which is a maximal ideal), i.e. $alpha^(- 1)\(\(epsilon.alt\)\)= p$. For $phi.alt : V arrow.r W$, $\(d phi.alt\)_p : "Hom"_(upright("loc"))\(cal(O)_(V\,p)\,k\[epsilon.alt\]\)arrow.r "Hom"_(upright("loc"))\(cal(O)_(W\,phi.alt\(p\))\,k\[epsilon.alt\]\)$ is induced by $cal(O)_(W\,phi.alt\(p\)) arrow.r cal(O)_(V\,p)$

]
#statement("Definition")[
$A$ is a $k$ algebra, $M$ is an $A$ module, a derivation is a $k$ linear map $A arrow.r M$ such that $D\(a b\)= a D\(b\)+ D\(a\)b$. Denote the $k$ vector space of derivations as $"Der"_k\(A\,M\)$

]
#statement("Example")[
$R$ is a local $k$ algebra with maximal ideal $m$ and $R\/m = k$, then $R tilde.equiv k xor m$ as a $k$ vector space since the exact sequence split

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$m$]),
node((2,0),[$R$]),
node((3,0),[$R\/m tilde.equiv k$]),
node((4,0),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->"),
edge((3,0),(4,0),"->"),
edge((3,0),(2,0),"->",bend:-15deg))]
]
Here $k arrow.r R$ maps 1 to 1, making $k arrow.r R arrow.r R\/m tilde.equiv k$ a $k$ linear isomorphism. Thus $d : R arrow.r m\/m^2$, $f mapsto f - f\(m\)#h(0.444em) mod med m^2$ is a $k$ derivation

]
#statement("Proposition")[
$\(R\,m\)$ is a local ring, there is a canonical isomorphism $"Hom"_(upright("loc"))\(R\,k\[epsilon.alt\]\)arrow.r "Der"_k\(R\,k\)arrow.r "Hom"_k\(m\/m^2\,k\)$

]
#proof(title: "Proof")[
Given a local homomorhpim $alpha : R arrow.r k\[epsilon.alt\]$, $alpha\(f\)= f\(m\)+ D_alpha\(f\)epsilon.alt$, here $D_alpha$ would be a derivation. Given a derivation $D$, $D$ vanishes on $k$ as well as $m^2$, thus induces a linear map $m\/m^2 arrow.r k$. Given a linear map $m\/m^2 arrow.r k$, define derivation $R arrow.r m\/m^2$, $f mapsto d f$

]
#statement("Definition")[
The blow up of the origin in $bb(A)^n$ is #display-equation($B l_0 bb(A)^n = {\( x_1 \, dots.h.c \, x_n \) times \[ y_1 \, dots.h.c \, y_n \] in bb(A)^n times bb(P)^(n - 1) mid(bar.v) x_i y_j = x_j y_i}$)Let $phi : B l_0 bb(A)^n arrow.r bb(A)^n$ be the projection to the first factor, then $B l_0 bb(A)^n$ is covered by $n$ open affine charts $U_i = { y_i eq.not 0 } inter B l_0 bb(A)^n$, where $k\[U_i\]= k [x_i \, y_1 / y_i \, dots.h.c \, y_n / y_i]$, so $U_i tilde.equiv bb(A)^n$, with $phi\|_(U_i) : U_i arrow.r bb(A)^n$ given by \ $k\[x_1\,dots.h.c\,x_n\]arrow.r^(alpha_i) k [x_i \, y_1 / y_i \, dots.h.c \, y_n / y_i]\,x_j mapsto x_i y_j / y_i$

$forall i$, $phi\|_(U_i)\|_(D\(x_i\)) : D\(x_i\)arrow.r D\(x_i\)$ is an isomorphism, $phi\|_(U_i)^(- 1)\(0\)= V\(alpha_i\(x_1\,dots.h.c\,x_n\)\)= V\(x_i\)tilde.equiv S p m k [y_1 / y_i \, dots.h.c \, y_n / y_i] tilde.equiv bb(A)^(n - 1)$, and these $V\(x_i\)$'s glue to give $phi^(- 1)\(0\)tilde.equiv bb(P)^(n - 1)$ which called the exceptional divisor

]
#statement("Proposition")[
There is a bijection between points on $phi^(- 1)\(0\)$ and the line in $bb(A)^n$ passing $0$

]
#proof(title: "Proof")[
Let $L = inter.big_(i = 1)^n { x_i = a_i t }$, not all $a_i$'s are zero be a line, then $phi\|_(U_i)^(- 1)\(L\\0\)= {x_i = a_i t \, t eq.not 0 \, a_i y_j = a_j y_i}$, and $overline(phi\|_(U_i)^(- 1)\(L\\0\)) = {x_i = a_i t \, a_i y_j = a_j y_i}$, so this line corresponds to $\[a_1\,dots.h.c\,a_n\]in bb(P)^(n - 1) tilde.equiv phi^(- 1)\(0\)$, thus if $L' eq.not L$, $overline(phi\|_(U_i)^(- 1)\(L\\0\)) inter overline(phi\|_(U_i)^(- 1)\(L'\\0\)) = nothing$

$B l_0 bb(A)^n$ is nonsingular since it is covered by affine spaces $bb(A)^n$, $B l_0 bb(A)^n$ is irreducible since $B l_0 bb(A)^n\\phi^(- 1)\(0\)tilde.equiv bb(A)\\0$ is irreducible, and each point of $phi^(- 1)\(0\)$ is in the closure of some line $L$ in $B l_0 bb(A)^n\\phi^(- 1)\(0\)$, so $B l_0 bb(A)^n\\phi^(- 1)\(0\)$ is dense in $B l_0 bb(A)^n$

]
#statement("Definition")[
If $V subset.eq bb(A)^n$ is a closed subvariety containing $0$, then the blow up of the origin $B l_0 V := overline(phi^(- 1)\(V\\0\))$, from this, we get an birational isomorphism $phi : B l_0 V arrow.r V$ which is an isomorphism away from $0$

]
#statement("Lemma")[
Suppose $X\,Y$ are both $S$-scheme, $x in X\,y in Y$ are both over $s$, then the set of points in $X times_S Y$ whose projections to $X\,Y$ are $x\,y$ are in bijection with the prime ideals of $k\(x\)times.o_(k\(s\)) k\(y\)$, i.e. $"Spec" k\(x\)times_("Spec" k\(s\)) "Spec" k\(y\)$

]#label("05:59-/04/28/2022")
#statement("Definition")[
$f : X arrow.r Y$ is a morphism between $k$-schemes, $y in Y$ is a point, then the #emph[scheme-theoretic fiber] over $y$ of $f$ is

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$X times_Y "Spec" k\(y\)$]),
node((1,0),[$X$]),
node((0,1),[$"Spec" k\(y\)$]),
node((1,1),[$Y$]),
edge((0,0),(0,1),"->"),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->",[$f$]),
edge((0,1),(1,1),"hook->"))]
]
]
#statement("Proposition")[
$p_2 : "Spec" k\(y\)times_Y X arrow.r X$ is homeomorphism onto the set-theoretic fiber $f^(- 1)\(y\)$

]
#proof(title: "Proof")[
- Surjectivity: $forall x in f^(- 1)\(y\)$ there is a unique point in $"Spec" k\(y\)times_Y X$ mapping to $x$ under $p_2$ (by Lemma~#ref(label("05:59-/04/28/2022"), supplement: none), $"Spec" k\(y\)times.o_(k\(y\)) k\(x\)= "Spec" k\(x\)\)$

- Injectivity: Image of $p_2$ lies in $f^(- 1)\(y\)$

- Homeomorphism: The assertion about homeomorphism is local, so we can assume $Y = "Spec" A$, $X = "Spec" B$, then $p_2$ corresponds to $B arrow.r k\(y\)times.o_A B$, $b mapsto 1 times.o b$. Apply Lemma~#ref(label("06:35-04/28/2022"), supplement: none), any element in $k\(y\)times.o_A B$ can be written as $sum overline(a_i) / overline(s) times.o b_i =\(1 / overline(s) times.o 1\)\(1 times.o\(sum a_i b_i\)\)$, here $y in "Spec" A$ corresponds to prime $p < A$ and so $k\(y\)= frac(A_p, p A_p)$

]
#statement("Lemma")[
$X$ scheme, $cal(J)$ is a quasi-coherent sheaf of ideals in $cal(O)_X$, let $Y := "supp"\(cal(O)_X / cal(J)\)$. Then $Y arrow.r.hook^i X$ is closed and $\(Y\,cal(O)_Y\)$ is a scheme with $cal(O)_Y := i^(- 1)\(cal(O)_X / cal(J)\)$

]#label("07:02-04/28/2022")
#proof(title: "Proof")[

]
#statement("Definition")[
$\(Y\,cal(O)_Y\)$ is a #emph[subscheme] of $\(X\,cal(O)_X\)$ if $Y subset.eq X$ is locally closed and if $U = X -\(overline(Y) - Y\)$\(largest open subseteq of $X$ in which $Y$ is closed), then $Y = "supp" cal(O)_(X\|U) / cal(J)$ for some quasi-coherent sheaf of ideals in $cal(O)_(X\|U)$. In the case $U = X$ we say $Y$ is a #emph[closed subscheme] of $X$.

]
#statement("Proposition")[
$exists$ bijection between closed subschemes of $X$ and quasi-coherent ideal sheaves of $cal(O)_X$

]
#proof(title: "Proof")[
This follows from the fact that if $cal(J)\,cal(J)'$ are tow quasi-coherent sheaves of ideals with the same support $Y$ and the restriction of $cal(O)_X\/cal(J)$, $cal(O)_X\/cal(J)'$ to $Y$ are the same, then $cal(J) = cal(J)'$ (follows from $I\,I' < A$ two ideals then $I = I' arrow.l.r.double A\/I = A\/I'$)

]
#statement("Proposition")[
There is a equivalence of categories between $A$ modules and quasi-coherent sheaves over affine scheme $"Spec" A$, sending $A$ module $M$ to the constant sheaf $underline(M)$, and quasi-coherent sheaf $cal(F)$ to $A$ module of global sections $cal(F)\("Spec" A\)$

]
#statement("Theorem")[
Quasi-coherent sheaves over a scheme forms an abelian category

]
