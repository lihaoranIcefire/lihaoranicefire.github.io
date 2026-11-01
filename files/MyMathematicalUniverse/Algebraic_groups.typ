#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Algebraic groups

#statement("Definition")[
- A #emph[$k$-group scheme] is a group object in the category of $k$-schemes

- A #emph[$k$-algebraic group] is a group object in the category of $k$-varieties

- A #emph[linear algebraic group] is an affine algebraic group

]
#statement("Definition")[
Let $k$ be a commutative ring. A $k$-#emph[group functor] is #display-equation($G : { k mono("-algebras") } arrow.r { mono("Sets") }$) With natural transformations

- multiplication $m : G times G arrow.r G$

- unit $e : "Hom"\(k\,-\)arrow.r G$

- inverse $i : G arrow.r G$

such that $m_A : G\(A\)times G\(A\)arrow.r G\(A\)$, $e_A : { * } arrow.r G\(A\)$, $i_A : G\(A\)arrow.r G\(A\)$ give $G\(A\)$ a group structure. Thus $G$ is actually a functor ${ k mono("-algebras") } arrow.r { mono("Groups") }$

]
#aside("Remark")[
The functor $G times G$ is defined to be $\(G times G\)\(A\)= G\(A\)times G\(A\)$ and $\(G times G\)\(A arrow.r^phi B\)= G\(A\)times G\(A\)arrow.r^(G\(phi\)times G\(phi\)) G\(B\)times G\(B\)$

]
#statement("Proposition")[
$k$-group functor is representable by $k$-group schemes

]
#proof(title: "Proof")[
Apply Yoneda lemma #display-equation($G times G = "Hom"\(-\,G\)times "Hom"\(-\,G\)tilde.equiv "Hom"\(-\,G times G\)tilde.equiv "Hom"\(-\,"Spec" R\[G\]times.o R\[G\]\)$) Multiplication $G\(A\)times G\(A\)arrow.r\(G times G\)\(A\)$ is given by

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$"Spec" A$]),
node((1,1),[$G times G$]),
node((2,1),[$G$]),
node((1,2),[$G$]),
node((2,2),[$"Spec" R$]),
edge((0,0),(1,1),"->",[$\(phi.alt\,psi\)$],stroke:(dash:"dashed")),
edge((0,0),(1,2),"->",[$psi$],bend:-15deg),
edge((0,0),(2,1),"->",[$phi.alt$],bend:15deg),
edge((1,1),(2,1),"->"),
edge((1,1),(1,2),"->"),
edge((2,1),(2,2),"->"),
edge((1,2),(2,2),"->"))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$A$]),
node((1,1),[$R\[G\]times.o R\[G\]$]),
node((2,1),[$R\[G\]$]),
node((1,2),[$R\[G\]$]),
node((2,2),[$R$]),
edge((1,1),(0,0),"->",[$f times.o g$],stroke:(dash:"dashed")),
edge((2,1),(0,0),"->",[$f$],bend:-15deg),
edge((2,1),(1,1),"->"),
edge((1,2),(0,0),"->",[$g$],bend:15deg),
edge((1,2),(1,1),"->"),
edge((2,2),(1,2),"->"),
edge((2,2),(2,1),"->"))]
]

]
#statement("Definition")[
$G$ is a $k$-group scheme, $X$ is a $k$-scheme, then a #emph[group action] is $mu : G times_k X arrow.r X$ such that the following diagrams commute

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((1,0),[$G times X$]),
node((0,1),[$G times G times X$]),
node((2,1),[$X$]),
node((1,2),[$G times X$]),
edge((1,0),(2,1),"->",[$mu$]),
edge((0,1),(1,0),"->",[$1 times mu$]),
edge((0,1),(1,2),"->",[$m times 1$]),
edge((1,2),(2,1),"->",[$mu$]))]
#v(0.5em)
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1 times X$]),
node((1,0),[$G times X$]),
node((1,1),[$X$]),
edge((0,0),(1,0),"->",[$e times 1$]),
edge((0,0),(1,1),"->",[$p_2$]),
edge((1,0),(1,1),"->",[$mu$]))]
]
]
#statement("Definition")[
$G$ is a $k$-group scheme, $X\,Y$ are $k$-group schemes. $phi : X arrow.r Y$ is a $G$-torsor if the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$G times X$]),
node((1,0),[$X$]),
node((0,1),[$X$]),
node((1,1),[$Y$]),
edge((0,0),(1,0),"->",[$mu$]),
edge((0,0),(0,1),"->",[$p_2$]),
edge((1,0),(1,1),"->",[$phi$]),
edge((0,1),(1,1),"->",[$phi$]))]
]
And $G times X arrow.r X times_Y X$ induced by

#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$G times X$]),
node((1,1),[$X times_Y X$]),
node((2,1),[$X$]),
node((1,2),[$X$]),
node((2,2),[$Y$]),
edge((0,0),(1,2),"->",[$mu$],bend:-15deg),
edge((0,0),(2,1),"->",[$p_2$],bend:15deg),
edge((0,0),(1,1),"->",stroke:(dash:"dashed")),
edge((1,1),(1,2),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(2,2),"->",[$phi$]),
edge((1,2),(2,2),"->",[$phi$]))]
is an isomorphism

]
#statement("Proposition")[
The ring of regular functions $R\[G\]$ of a linear algebraic group $G$ form a Hopf algebra

]
#proof(title: "Proof")[
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$G times G times G$]),
node((1,0),[$G times G$]),
node((0,1),[$G times G$]),
node((1,1),[$G$]),
edge((0,0),(1,0),"->",[$1 times m$]),
edge((0,0),(0,1),"->",[$m times 1$]),
edge((1,0),(1,1),"->",[$m$]),
edge((0,1),(1,1),"->",[$m$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$R\[G\]times.o R\[G\]times.o R\[G\]$]),
node((1,0),[$R\[G\]times.o R\[G\]$]),
node((0,1),[$R\[G\]times.o R\[G\]$]),
node((1,1),[$R\[G\]$]),
edge((1,0),(0,0),"->",[$1 times.o Delta$]),
edge((0,1),(0,0),"->",[$Delta times.o 1$]),
edge((1,1),(0,1),"->",[$Delta$]),
edge((1,1),(1,0),"->",[$Delta$]))]
]
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$R\[G\]times.o R$]),
node((1,0),[$R\[G\]times.o R\[G\]$]),
node((0,1),[$R\[G\]$]),
node((1,1),[$R times.o R\[G\]$]),
edge((1,0),(0,0),"->",[$1 times.o epsilon.alt$]),
edge((1,0),(1,1),"->",[$epsilon.alt times.o 1$]),
edge((0,1),(0,0),"->"),
edge((0,1),(1,1),"->"),
edge((0,1),(1,0),"->",[$Delta$]))]
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$G times "Spec" R$]),
node((1,0),[$G times G$]),
node((0,1),[$G$]),
node((1,1),[$"Spec" R times G$]),
edge((0,0),(1,0),"->",[$1 times e$]),
edge((1,0),(0,1),"->",[$m$]),
edge((0,1),(0,0),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(1,0),"->",[$e times 1$]))]
]
If $g in G\(A\)= "Hom"_R\(R\[G\]\,A\)$, $f in R\[G\]$, then write $f\(g\)in A$. There are coproduct $Delta : R\[G\]arrow.r R\[G\]times.o R\[G\]$, counit $epsilon.alt : R\[G\]arrow.r R$, antipode(coinverse) $S : R\[G\]arrow.r R$. Suppose $Delta f = sum f_i times.o f'_i$, then for any $g_1\,g_2 in G\(A\)$, $f\(g_1 g_2\)= sum f_i\(g_1\)f'_i\(g_2\)$. The counit is given by $epsilon.alt\(f\)= f\(1\)$. The antipode is given by $S\(f\)\(g\)= f\(g^(- 1)\)$

]
#statement("Example")[
The category of $bb(Z)$-graded vector spaces $\(V^n\)_(n in bb(Z))$ is equivalent to $"Rep"\(bb(G)_m\)$

]
#proof(title: "Proof")[
Suppose the coaction is $rho : V arrow.r V times.o k\[t\,t^(- 1)\]\,rho\(v\)= sum_n rho_n\(v\)times.o t^n$, $\(rho times.o 1\)rho\(v\)= sum_(m\,n) rho_m\(rho_n\(v\)\)times.o t^m times.o t^n$. On the other hand $\(1 times.o Delta\)rho\(v\)= sum_n rho_n\(v\)times.o t^n times.o t^n$ also $\(1 times.o epsilon.alt\)rho\(v\)= sum_n rho_n times.o 1$, which would imply $rho_n rho_m = delta_(n m) rho_n\,1 = sum_n rho_n$, i.e. $rho_n$ are orthogonal idempotents. The inverse would be given $sum_n rho_(- n) times.o t^n$. Thus $V = xor.big_n V^n$ where $V^n$ corresponds to the subrepresentation $rho_n : V^n arrow.r V^n times.o k\[t\,t^(- 1)\]$

]
#statement("Example", title: [Deligne torus])[
$bb(S) = "Res"_(bb(C)\/bb(R)) bb(G)_m$ is the Deligne torus, with Hopf algebra $bb(R)\[x\,y\,\(x^2 + y^2\)^(- 1)\]$, The coproduct is $Delta x = x times.o x - y times.o y$, $Delta y = x times.o y + y times.o x$, or $bb(C)\[z^(plus.minus 1)\,macron(z)^(plus.minus 1)\]^(bb(Z)\/2)$, The coproduct is $Delta x = x times.o x - y times.o y$, $Delta z = z times.o z$, $Delta macron(z) = macron(z) times.o macron(z)$. $bb(S)\(bb(R)\)= bb(C)^times$, $bb(S)\(bb(C)\)= bb(C)^times times bb(C)^times$

]
