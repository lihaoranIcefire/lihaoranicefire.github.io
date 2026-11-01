#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Axiomatic sheaf cohomology theory

#statement("Definition")[
A #emph[sheaf cohomology theory] $H$ for $M$ with coefficients in the sheaves of $K$-modules over $M$ is a covariant cohomological $delta$ functor that consists of

+ A family of covariant additive functors $H^q$ from the category of sheaves of $K$-modules over $M$ to the category of $K$-modules

+ For each short exact sequence $0 arrow.r cal(S)' arrow.r cal(S) arrow.r cal(S)'' arrow.r 0$, a homomorphism $H^q\(M\,cal(S)''\)arrow.r H^(q + 1)\(M\,cal(S)'\)$

such that

+ $H^q\(M\,cal(S)\)= 0$ for $q < 0$. $H^0\(M\,cal(S)\)tilde.equiv Gamma\(cal(S)\)$, and for any homomorphism $cal(S) arrow.r cal(S)'$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$H^0\(M\,cal(S)\)$]),
  node((1,0),[$Gamma\(cal(S)\)$]),
  node((0,1),[$H^0\(M\,cal(S)'\)$]),
  node((1,1),[$Gamma\(cal(S)'\)$]),
  edge((0,0),(1,0),"->",[$tilde.equiv$]),
  edge((0,0),(0,1),"->"),
  edge((1,0),(1,1),"->"),
  edge((0,1),(1,1),"->",[$tilde.equiv$]))]
  ]
  commutes

+ If $cal(S)$ is a fine sheaf, then $H^q\(M\,cal(S)\)= 0$ for $q > 0$

+ For each short exact sequence $0 arrow.r cal(S)' arrow.r cal(S) arrow.r cal(S)'' arrow.r 0$, we have long exact sequence #display-equation($dots.h.c arrow.r H^q\(M\,cal(S)'\)arrow.r H^q\(M\,cal(S)\)arrow.r H^q\(M\,cal(S)''\)arrow.r H^(q + 1)\(M\,cal(S)'\)arrow.r dots.h.c$)

+ For commutative diagram

  #align(center)[
  #align(center)[#set text(size:7pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$0$]),
  node((1,0),[$cal(S)'$]),
  node((2,0),[$cal(S)$]),
  node((3,0),[$cal(S)''$]),
  node((4,0),[$0$]),
  node((0,1),[$0$]),
  node((1,1),[$cal(T)'$]),
  node((2,1),[$cal(T)$]),
  node((3,1),[$cal(T)''$]),
  node((4,1),[$0$]),
  edge((0,0),(1,0),"->"),
  edge((1,0),(2,0),"->"),
  edge((1,0),(1,1),"->"),
  edge((2,0),(2,1),"->"),
  edge((2,0),(3,0),"->"),
  edge((3,0),(3,1),"->"),
  edge((3,0),(4,0),"->"),
  edge((0,1),(1,1),"->"),
  edge((1,1),(2,1),"->"),
  edge((2,1),(3,1),"->"),
  edge((3,1),(4,1),"->"))]
  ]
  we have commutative diagram

  #align(center)[
  #align(center)[#set text(size:7pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$dots.h.c$]),
  node((1,0),[$H^q\(M\,cal(S)'\)$]),
  node((2,0),[$H^q\(M\,cal(S)\)$]),
  node((3,0),[$H^q\(M\,cal(S)''\)$]),
  node((4,0),[$H^(q + 1)\(M\,cal(S)'\)$]),
  node((5,0),[$dots.h.c$]),
  node((0,1),[$dots.h.c$]),
  node((1,1),[$H^q\(M\,cal(T)'\)$]),
  node((2,1),[$H^q\(M\,cal(T)\)$]),
  node((3,1),[$H^q\(M\,cal(T)''\)$]),
  node((4,1),[$H^(q + 1)\(M\,cal(T)'\)$]),
  node((5,1),[$dots.h.c$]),
  edge((0,0),(1,0),"->"),
  edge((1,0),(2,0),"->"),
  edge((1,0),(1,1),"->"),
  edge((2,0),(2,1),"->"),
  edge((2,0),(3,0),"->"),
  edge((3,0),(3,1),"->"),
  edge((3,0),(4,0),"->"),
  edge((4,0),(5,0),"->"),
  edge((4,0),(4,1),"->"),
  edge((0,1),(1,1),"->"),
  edge((1,1),(2,1),"->"),
  edge((2,1),(3,1),"->"),
  edge((3,1),(4,1),"->"),
  edge((4,1),(5,1),"->"))]
  ]

]
Existence of cohomology theories

Let $cal(K) = M times K$ be the constant sheaf over $M$, we shall show that any fine torsionless resolution of $cal(K)$ #display-equation($0 arrow.r cal(K) arrow.r cal(C)^0 arrow.r cal(C)^1 arrow.r dots.h.c$) Give rise to a cohomology theory by defining $H^q\(M\,cal(S)\)= H^q\(Gamma\(cal(C)^(*) times.o cal(S)\)\)$, since $cal(C)_i$ are fine torsionless resolution, we have #display-equation($0 arrow.r Gamma\(C^(*) times.o cal(S)'\)arrow.r Gamma\(C^(*) times.o cal(S)\)arrow.r Gamma\(C^(*) times.o cal(S)''\)arrow.r 0$) is exact, which gives us the long exact sequence

Let $cal(Z)^q = ker\(cal(C)^q arrow.r cal(C)^(q + 1)\)$, then we have short exact sequence $0 arrow.r cal(Z)^q arrow.r cal(C)^q arrow.r cal(Z)^(q + 1) arrow.r 0$, as a subsheaf $cal(Z)^q$ is also torsionless, thus $0 arrow.r cal(Z)^q times.o cal(S) arrow.r cal(C)^q times.o cal(S) arrow.r cal(Z)^(q + 1) times.o cal(S) arrow.r 0$ is exact, so $0 arrow.r Gamma\(cal(Z)^q times.o cal(S)\)arrow.r Gamma\(cal(C)^q times.o cal(S)\)arrow.r Gamma\(cal(Z)^(q + 1) times.o cal(S)\)$ is exact, and $Gamma\(cal(C)^q times.o cal(S)\)arrow.r Gamma\(cal(C)^(q + 1) times.o cal(S)\)$ is the composition $Gamma\(cal(C)^q times.o cal(S)\)arrow.r Gamma\(cal(Z)^(q + 1) times.o cal(S)\)arrow.r Gamma\(cal(C)^(q + 1) times.o cal(S)\)$, hence $H^q\(M\,cal(S)\)= H^q\(Gamma\(cal(C)^(*) times.o cal(S)\)\)= Gamma\(cal(Z)^q times.o cal(S)\)\/"im"\(Gamma\(cal(C)^(q - 1) times.o cal(S)\)\)$. If $cal(S)$ is fine, then $0 arrow.r Gamma\(cal(Z)^(q - 1) times.o cal(S)\)arrow.r Gamma\(cal(C)^(q - 1) times.o cal(S)\)arrow.r Gamma\(cal(Z)^q times.o cal(S)\)arrow.r 0$ is exact, hence $H^q\(M\,cal(S)\)= 0$ for $q gt.eq 1$

Let $cal(S)_0$ denote the sheaf of germs of discontinuous sections of $cal(S)$ (which is the shefification of the sheaf of discontinuous sections of $cal(S)$), we shall show that $cal(S)_0$ is always a fine sheaf

#statement("Definition")[
$H\,tilde(H)$ are cohomology theories, a homomorphism $H arrow.r tilde(H)$ is a natural transformation such that

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H^0\(M\,cal(S)\)$]),
node((1,0),[$Gamma\(cal(S)\)$]),
node((0,1),[$tilde(H)^0\(M\,cal(S)\)$]),
node((1,1),[$Gamma\(cal(S)\)$]),
edge((0,0),(1,0),"->",[$tilde.equiv$]),
edge((0,0),(0,1),"->"),
edge((1,0),(1,1),"="),
edge((0,1),(1,1),"->",[$tilde.equiv$]))]
]
commutes

]
#statement("Theorem")[
$H\,tilde(H)$ are cohomology theories, then there is a unique homomorhpism $H arrow.r tilde(H)$

]
#statement("Corollary")[
Any two cohomology theories $H\,tilde(H)$ are uniquely isomorphic

]
#statement("Theorem")[
$H$ is a cohomology theory #display-equation($0 arrow.r cal(S) arrow.r cal(C)^0 arrow.r cal(C)^1 arrow.r dots.h.c$) is a fine resolution of $cal(S)$, then there are canonical isomorphisms $H^q\(M\,cal(S)\)arrow.r^tilde.equiv H^q\(Gamma\(cal(C)^(*)\)\)$

]
