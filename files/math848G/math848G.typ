#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH848G - Index Theory on Manifolds", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(font: "New Computer Modern", size: 10pt, lang: "en")
#set par(justify: true)
#set heading(numbering: "1.1")
#set math.equation(numbering: none)
#show figure.where(kind: "statement"): set block(breakable: true)
#let statement(name, title: none, body) = figure(
  align(left, block(width: 100%, breakable: true)[
    #context strong[
      #name #counter(heading).get().first().#counter(figure.where(kind: "statement")).display("1")
      #if title != none [(#title)]
    ]
    #body
  ]),
  kind: "statement",
  supplement: name,
  numbering: number => context numbering("1.1", counter(heading).get().first(), number),
  caption: none,
)
#show ref: it => context {
  let target = it.element
  if target != none and target.func() == figure and target.kind == "statement" {
    let location = target.location()
    link(location, numbering("1.1", counter(heading).at(location).first(), counter(figure.where(kind: "statement")).at(location).first()))
  } else { it }
}
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "statement")).update(0)
  it
}
#let proof(title: "Proof", body) = block(width: 100%, breakable: true)[
  _#title._ #body #h(1fr) $square$
]
#let exercise(number, body) = block(width: 100%, breakable: true)[
  *Exercise #number.* #body
]
#let index-entry(term) = metadata((kind: "index-entry", term: term))
#let index-list() = context {
  let entries = query(metadata).filter(it => it.value.kind == "index-entry")
  let terms = entries.map(it => it.value.term).dedup().sorted(key: lower)
  columns(2, gutter: 2em)[
    #for term in terms {
      let matches = entries.filter(it => it.value.term == term)
      let pages = matches.map(it => it.location().page()).dedup()
      let links = pages.map(page => link(matches.find(it => it.location().page() == page).location(), str(page)))
      par[#term #h(1fr) #links.join[, ]]
    }
  ]
}

#align(center)[
  #set par(justify: false)
  #v(1cm)
  #text(size: 22pt, weight: "bold")[MATH848G \ Index Theory on Manifolds]
  #v(2cm)
  #image("Pictures/Michael_Francis_Atiyah.jpg", width: 50%)
  #v(2cm)
  Taught by Jonathan Rosenberg \
  Notes taken by Haoran Li \
  2019 Fall
  #v(2cm)
  Department of Mathematics \
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()

= Pseudodifferential calculus

#statement("Definition")[
A differential operator#index-entry("differential operator") $P$ of order $m$ is of the form $p(x,D)=sum_(abs(alpha)<=m) a_alpha(x) D^alpha$, where $a_alpha(x)$ are functions and $D_j:=frac(1,i) partial_j$, the symbol $p(x,xi)$ associated with it is defined as $p(x,xi)=sum_(abs(alpha)<=m) a_alpha(x) xi^alpha$, then we necessarily get the estimate, the principal symbol of $p(x,xi)$ is $sigma(P)(x,xi)=sum_(abs(alpha)=m) a_alpha(x) xi^alpha$.

If a differential operator $P$ of order $m$ is acting on functions on $bb(C)^n approx.eq bb(R)^(2n)$, then we may consider it as the form $p(x,D)=sum_(abs(alpha+beta)<=m) a_(alpha,beta)(x) D^alpha overline(D)^beta$, and $D_j:=frac(partial,partial z_j)$, $overline(D)_j:=frac(partial,partial overline(z)_j)$, the symbol $p(x,xi)$ associated with it is defined as $p(x,xi)=sum_(abs(alpha+beta)<=m) a_(alpha,beta)(x) xi^alpha overline(xi)^beta$.
]

#statement("Definition")[
On a manifold $M$, a differential operator of order $m$ is a linear map $P: C^(infinity)(M) arrow.r C^(infinity)(M)$ which in local charts has the above form.

More generally, let $E arrow.r M, F arrow.r M$ be vector bundles, a differential operator $P: Gamma(E) arrow.r Gamma(F)$ of order $m$ is a linear operator of the above form in local trivializations.

Notice $C^(infinity)(M)=Gamma(and.big^0 T^* M)$, another example is exterior derivative $d: Gamma(and.big^k T^* M) arrow.r Gamma(and.big^(k+1) T^* M)$ which is a first order differential operator.
]

We can generalize the notion of differential operators (DO) to pseudodifferential operators ($psi$DO) via symbols.

#statement("Definition")[
Let $Omega subset.eq bb(R)^n$ be an open set, the symbols#index-entry("Symbol") of order $m$ form the space
$ S^(m)(Omega):=lr({ f(x,xi) in C^(infinity)(Omega times bb(R)^n) mid(|)
  #stack(dir: ttb, spacing: 0.4em,
    $forall alpha,beta,K subset.double Omega, exists C_(K,alpha,beta),$,
    $abs(D_x^alpha D_xi^beta f(x,xi)) <= C_(K,alpha,beta)(1+abs(xi))^(m-abs(beta))$
  ) }) $
Given symbol $p(x,xi) in S^(m)(Omega)$, it defines a pseudodifferential operator $p(x,D)$ of order $m$#index-entry("Pseudodifferential operator"), such that $(p(x,D)f)(x)=frac(1,(2pi)^n) integral p(x,xi) hat(f)(xi) e^(i x dot xi) dif xi$.

All pseudodifferential operators of order $m$ are defined this way, denoted as $Psi^(m)(Omega)$.
]
#statement("Remark")[
It might be more natural to think of $f in C^(infinity)(Omega times (bb(R)^n)^*)$ in the manifold setting.
]
#statement("Theorem")[
Let $Omega,Omega'$ be open subsets of $bb(R)^n$, $Phi: Omega arrow.r Omega'$ is a diffeomorphism, induces a bijection of $S^(m)(Omega) arrow.r S^(m)(Omega')$.
]
#proof[
Since $Phi: Omega arrow.r Omega'$ is a diffeomorphism, $(Phi_*)_x: T_x Omega arrow.r T_(Phi(x)) Omega'$ and $(Phi^*)_x: T^*_(Phi(x)) Omega' arrow.r T^*_x Omega$ are isomorphisms.
]
#statement("Corollary")[
Let $M$ be a smooth manifold, $S^(m)(M) subset.eq Gamma(T^* M)$ is well-defined.
]
#statement("Definition")[
The principal symbol#index-entry("Principal symbol") of symbol $p(x,xi)$ of order $m$ is defined as $lim_(abs(xi) arrow.r infinity) frac(p(x,xi),abs(xi)^m)$.
]

#pagebreak()
= K-theory

#statement("Definition")[
For commutative monoid $M$: there exists an abelian group $K$ and $i: M arrow.r K$ having the universal property
#align(center)[#diagram(
  cell-size: (14mm, 10mm), spacing: (10mm, 8mm),
  node((0, 0), $M$), node((0, 1), $K$), node((1, 1), $A$),
  edge((0, 0), (0, 1), "hook->", $i$),
  edge((0, 0), (1, 1), "->", $f$),
  edge((0, 1), (1, 1), "->", $g$, stroke: (dash: "dashed")),
)]
where $A$ is an Abelian group.

Concrete construction: consider the set of formal differences $M times M approx.eq {m-n mid(|) m,n in M}$ with addition $(m_1-n_1)+(m_2-n_2):=[(m_1+m_2)-(n_1+n_2)]$ which is an Abelian group with $0-0$ the identity and $n-m$ the inverse to $m-n$, let $K:=M times M slash tilde.op$, $m_1-n_1 tilde.op m_2-n_2$ if $m_1+n_2+m=m_2+n_1+m$ for some $m in M$ (adding $m$ to make sure it is an equivalence relation), and $i: M arrow.r K, m mapsto m-0$.

Alternatively, consider the free Abelian group $F(M)$ generated by $M$, let $K:=F(M) slash tilde.op$, $m +' n tilde.op (m+n)$, or mod the subgroup generated by $m +' n -' (m+n)$, here $+', -'$ are operations in $F(M)$.

More generally, for a semigroup $S$, there exists a group $K$ and $i: S arrow.r K$ having the universal property
#align(center)[#diagram(
  cell-size: (14mm, 10mm), spacing: (10mm, 8mm),
  node((0, 0), $S$), node((0, 1), $K$), node((1, 1), $G$),
  edge((0, 0), (0, 1), "hook->", $i$),
  edge((0, 0), (1, 1), "->", $f$),
  edge((0, 1), (1, 1), "->", $g$, stroke: (dash: "dashed")),
)]
where $G$ is a group.

Concrete construction: consider the free group $F(S)$ generated by $S$, let $K:=F(S) slash tilde.op$, $m *' n tilde.op (m*n)$, or mod the subgroup generated by $m *' n *' (m*n)^(-1)$, here $*', -^(-1)$ are operations in $F(M)$.
] <grothendieck-group>

#statement("Definition", title: [Alternative definition of Grothendieck group])[
Let $R$ be a finite dimensional $k$ algebra (or more generally an Artinian ring), define Grothendieck group $G_0(R)$ to be the set of all finitely generated $R$ modules mod relation, if $0 arrow.r A arrow.r B arrow.r C arrow.r 0$ is exact, then $[B]=[A]+[C]$, namely, $G_0(R):={[M]}$, where $[M]$ are equivalent classes of finitely generated $R$ modules.
]
#statement("Definition")[
Two vector bundles $E arrow.r X$, $F arrow.r X$ are stably isomorphic#index-entry("Stably isomorphic") if $E plus.o epsilon^n approx F plus.o epsilon^n$, denoted as $E approx_s F$, we also denote $E tilde.op_s F$ if $E plus.o epsilon^n approx F plus.o epsilon^m$ for some $n,m$.
]
#statement("Remark")[
Here stably isomorphic does not imply isomorphic, for example, $T S^2 approx_s epsilon^2$, since $epsilon^3 approx T^2 plus.o N S^2 approx T^2 plus.o epsilon^1$ whereas $T S^2$ is not trivial by the hairy ball theorem, and $N S^2 approx epsilon^1$ is trivial because it is very easy to find a nonvanishing global section.
]
#statement("Definition")[
#index-entry("Topologcial K-theory")
Let $X$ be a topological space, then the Abelian group $tilde(K)_(bb(F))(X)$ is defined to be the $tilde.op$-equivalent classes of $bb(F)$-vector bundles over $X$, since all vector bundles over $X$ with $plus.o$ form a commutative monoid, we can define its Grothendieck group $K(X)$ to be the $K$-theory, as it turns out, $K(X)$ also has a commutative ring structure with $times.o$,
$ (E_1-F_1) times.o (E_2-F_2):= E_1 times.o E_2 plus.o F_1 times.o F_2 - E_1 times.o F_2 plus.o F_1 times.o E_2. $
$K_(bb(F))(X,Y)$ is defined to be ${E-F in K_(bb(F))(X) mid(|) exists "isomorphism " E_Y arrow.r F_Y}$.

Note suppose $X$ is compact Hausdorff, we can redefine the equivalence relation for the formal differences to be $E_1-F_1=E_2-F_2$ if $E_1 plus.o F_2 approx_s E_2 plus.o F_1$, because if $E_1 plus.o F_2 plus.o E approx E_2 plus.o F_1 plus.o E$, for some $E$, then there exists $E'$ such that $E plus.o E' approx epsilon^m$ for some $m$, and any $E-F=(E plus.o F')-epsilon^m$ for some $F'$ such that $F plus.o F' approx epsilon^m$, thus we can define a map $K(X) arrow.r tilde(K)(X), E-epsilon^m mapsto E$ which is obviously surjective, consider $K(X) arrow.r K(*) approx.eq bb(Z)$ by restricting a vector bundle to a point, and $K(*) arrow.r K(X)$ by extending a vector space into a trivial vector bundle, we then get an exact sequence which splits
#align(center)[#diagram(
  cell-size: (12mm, 8mm), spacing: (6mm, 6mm),
  node((0, 0), $0$), node((1, 0), $K(*)$), node((2, 0), $K(X)$),
  node((3, 0), $tilde(K)(X)$), node((4, 0), $0$),
  edge((0, 0), (1, 0), "->"), edge((1, 0), (2, 0), "->"),
  edge((2, 0), (1, 0), "->", bend: 18deg),
  edge((2, 0), (3, 0), "->"), edge((3, 0), (4, 0), "->"),
)]
Thus $K(X) approx.eq tilde(K)(X) plus.o K(*) approx.eq tilde(K)(X) plus.o bb(Z)$.

Suppose $X$ is a locally compact Hausdorff space, think of its one point compactification $X^*$ as a pointed space, then $K(X) approx.eq ker[K(X^*) arrow.r K(*)] approx.eq ker tilde(K)(X^*) approx.eq K(X,*)$.

From this we have excision, if $Y subset.eq X$ are both compact Hausdorff, $tilde(K)(X slash Y) approx.eq tilde(K)((X-Y)^*) approx.eq K(X-Y) approx.eq K(X,Y)$.
] <topological-k-theory>
#statement("Remark")[
Normally $K(X)$ denotes $K_(bb(C))(X)$, $"KO"(X)$ denotes $K_(bb(R))(X)$.
]
#statement("Theorem")[
$K$-theory forms an extraordinary cohomology theory.
]
#proof[]
#statement("Definition")[
Let $X$ be a locally compact, Hausdorff space, consider all the complexes
$ dots.h.c arrow.r^(alpha_(-2)) E_(-1) arrow.r^(alpha_(-1)) E_0 arrow.r^(alpha_0) E_1 arrow.r^(alpha_1) E_2 arrow.r^(alpha_2) dots.h.c $
with only finitely many $E_j != 0$, and exact off a compact set, give a semigroup structure by direct sum, then define $K(X):=$ all such complexes$slash tilde.op$, where a complex is equivalent to the identity if it is chain homotopic to an exact sequence off a compact set, $K(X,A)$ means an extra condition that the complexes in consideration are exact over $A$.
]
#statement("Proposition")[
The above two definitions of $K(X,A)$ coincide.
]
#proof[
If $X$ is compact, then every complex of vector bundles over $X$ will be exact off a compact set and homotopic to a complex with zero maps, then define Euler characteristic map
$ K(X) arrow.r K(X), $
$ [0 arrow.r E_1 arrow.r^(alpha_1) dots.h.c arrow.r E_n arrow.r^(alpha_n) 0] $
$ = [0 arrow.r E_1 arrow.r^0 dots.h.c arrow.r E_n arrow.r^0 0] mapsto sum_(k=0)^n (-1)^k [E_i] $
which would give an isomorphism.

If $X$ is locally compact and Hausdorff, $K(X) approx.eq ker[K(X^*) arrow.r K(*)] approx.eq K(X)$.
]
#statement("Theorem")[
Let $X$ be a connected compact oriented two dimensional manifold without boundary (oriented closed surface), every complex vector bundle $E$ is a sum of line bundles $[L_1]+dots.h.c+[L_n]-[L_(n+1)]-dots.h.c-[L_(n+m)]$, and line bundles are classified by Chern classes in $H^2(X,bb(Z)) approx.eq bb(Z)$, the rank and degree of $E$ are defined as $upright("rank") E=n-m$, $deg E=sum_(i<=n) deg[L_i]-sum_(i>n) deg[L_i]$. Therefore, $K(X) arrow.r^((upright("rank"),deg)) bb(Z) plus.o bb(Z)$ is an isomorphism.
]

#pagebreak()
= Atiyah-Singer index theorem

#statement("Theorem", title: [*Atiyah-Singer index theorem*])[
#index-entry("Atiyah-Singer index theorem")
$M$ is a compact manifold, $p: T^* M arrow.r M$ is the cotangent bundle, $E,F$ are vector bundles over $M$, $P: Gamma(E) arrow.r Gamma(F)$ is an elliptic $psi$DO of order $m$ with principal symbol $sigma(P): p^* E arrow.r p^* F$, $P$ defines a Fredholm operator $H^(s)(E) arrow.r H^(s-m)(F)$, from this we get its index (analytic index) $upright("ind")_a(P)$, then

*(1):* $upright("ind")_a(P)$ is independent of the choice of $s$.

*(2):* $sigma(P)$ defines an element of $K(T^* M)$.

*(3):* $upright("ind")_a(P)$ only depends on $[sigma(P)] in K(T^* M)$.

*(4):* $exists$ homomorphism $upright("ind")_t$ (topological index) $: K(T^* M) arrow.r bb(Z)$ independent of $P,E,F$ such that $upright("ind")_a(P)=upright("ind")_t([sigma(P)])$.
] <atiyah-singer-index-theorem>
#proof[
*(1):* Follows from what we did about $psi$DOs.

*(2):* Since $sigma(P)$ is an elliptic operator, at $(x,xi) in T^* M$, $sigma(P)(x,xi)$ is a linear map $(p^* E)_(x,xi) arrow.r (p^* F)_(x,xi)$ which is invertible except for $xi$ small, thus $0 arrow.r p^* E arrow.r^(sigma(P)) p^* F arrow.r 0$ is exact off a compact set, thus $[0 arrow.r p^* E arrow.r^(sigma(P)) p^* F arrow.r 0]$ defines an element in $K(T^* M)$.

*(3):* The $K$-theory class of $sigma(P)$ only depends on $sigma(P)$ over $S^* M$, which is compact, then you can extend it to $T^* M$ just by homogeneity, $sigma(P)(x,r xi)=r^m sigma(P)(x,xi)$, varying this symbol over $S^* M$ continuously, keeping it invertible, gives a homotopy of Fredholm operators, the index doesn't change since the index is locally constant, and such a homotopy preserves the $K$-theory class.

*(4):*
]
#statement("Theorem", title: [*Dolbeault theorem*])[
#index-entry("Dolbeault theorem")
Consider complex
$ Omega^(0,0)(E) arrow.r^(overline(partial)) Omega^(0,1)(E) arrow.r^(overline(partial)) Omega^(0,2)(E) arrow.r^(overline(partial)) dots.h.c $
The $j$-th cohomology will be $H^(j)(M,cal(O)_E)$.
] <dolbeault-theorem>
#proof[
$ 0 arrow.r cal(O)(E) arrow.r.hook Omega^(0,0)(E) arrow.r^(overline(partial)) Omega^(0,1)(E) arrow.r^(overline(partial)) Omega^(0,2)(E) arrow.r^(overline(partial)) dots.h.c $
is a resolution of $cal(O)(E)$ by fine sheaves as defined in Definition @fine-sheaves.
]
#statement("Definition")[
A fine sheaf#index-entry("Fine sheaf") $cal(F)$ over $X$ is one with "partitions of unity"; more precisely for any open cover of the space $X$ we can find a family of homomorphisms from the sheaf to itself with sum $1$ such that each homomorphism is $0$ outside some element of the open cover.
] <fine-sheaves>
#statement("Example")[
$M$ is compact Riemann surface, $E arrow.r M$ is a holomorphic vector bundle, $E$ is equipped with $overline(partial)$ operator, $overline(partial): Gamma(E) arrow.r Gamma(E times.o Omega^(0,1))$, $overline(partial) f:=frac(partial f,partial overline(z)) dif overline(z)$ (notice when $E$ is trivial this is the normal $overline(partial)$ operator), $overline(partial)$ is an elliptic operator since its principal symbol is given by $sigma(overline(partial))(x,xi)=overline(xi)$, thus $upright("ind")_a(overline(partial))=dim H^0(M,E)-dim H^1(M,E)$, $H^0(M,E)$ is space of all holomorphic sections of $E$.
]
#statement("Lemma")[
$E arrow.r^p X$ is a vector bundle, then the pullback bundle $p^*(E):=E times_X X$ is a trivial bundle.
]
#proof[]
#statement("Definition")[
Let $X$ be a compact $G$ space (meaning $G$ acts on $X$), where $G$ is a compact Lie group, a $G$-vector bundle#index-entry("G-vector bundle") $E$ is a vector bundle over $X$ which is also a $G$ space, with $g: E_x arrow.r E_(g x)$ a linear map on fibers. In particular, if $X$ is a point, then a $G$-bundle is just a finite dimensional representation of $G$, and $K_G(X)$ is the $K$-theory of such vector bundles, thus $R(G):=K_G(*)$ is the representation ring of $G$, if $X$ is a trivial $G$ space, then a $G$-vector bundle is just a continuous family of $G$ representations.
]
#statement("Example", title: [Examples of representation rings $R(G)$])[
$R(G)=bb(Z)$.
]
#statement("Theorem")[
If $X$ is a trivial $G$ space, $K_G(X) approx.eq K(X) times.o_(bb(Z)) R(G)$.

If $X$ is a free $G$ space, $K_G(X) approx.eq K(X slash G)$.
]
#statement("Theorem", title: [*Equivariant Bott periodicity theorem*])[
Let $X$ be a locally compact $G$ space, where $G$ is a compact Lie group, $V$ is a finite dimensional representation of $G$, then there is an isomorphism $K_G arrow.r K_G(V times X)$ defined as follows.

Consider the complex
$ 0 arrow.r bb(C)=and.big^0 V arrow.r^(lambda_v) V=and.big^1 V arrow.r^(lambda_v) and.big^2 V arrow.r^(lambda_v) dots.h.c arrow.r^(lambda_v) and.big^n V arrow.r 0 $
where $lambda_v:=v and -$.
] <equivariant-bott-periodicity-theorem>
#statement("Theorem", title: [Thom isomorphism theorem in $K$-theory])[
Let $X$ be a compact Hausdorff space, $E arrow.r X$ is a complex vector bundle, then multiplication by $lambda_(E^*)$ gives an isomorphism $K(X) arrow.r K(E)$.
]
#proof[
Give an inner product on each fiber varying smoothly, $n=dim E$, let $G=U(n)$, $Y$ be the fiber bundle over $X$ with fiber over $x$ the Stiefel manifold of $E_x$, then $G$ acts on $Y$ and $bb(C)^n times Y$ freely, thus
$ K(X)=K(Y slash G) approx.eq K_G(Y) arrow.r^(approx.eq) K_G(bb(C)^n times Y) $
$ approx.eq K((bb(C)^n times Y) slash G)=K(E). $
Here $lambda_E$ is the complex $and.big(p^* E)$.
]

#pagebreak()
= Clifford algebra

#statement("Definition")[
Let $V=bb(F)^n$ be a vector space with a quadratic form $q$, $T V$ be its tensor algebra, let $I$ be the ideal generated by elements of the form $v times.o v+q(v,v)1$, the Clifford algebra is defined to be $italic("Cl")_n=upright("Cliff")(V,q)=T V slash I$, in particular, we only consider the case when $V=bb(R)^n$ is the Euclidean space with the standard inner product, if $e_1,dots.h.c,e_n$ are the standard basis, $e_i times.o e_i+1 in I$, $(e_i+e_j) times.o (e_i+e_j)+2=e_i times.o e_i+e_j times.o e_j+e_i times.o e_j+e_j times.o e_i+2 in I$, we have $e_i^2=-1$ and $e_i e_j=-e_j e_i, i != j$, thus $dim italic("Cl")_n=2^n$, $italic("Cl")_n=italic("Cl")_n^"even" plus.o italic("Cl")_n^"odd"$, $dim italic("Cl")_n^"even"=dim italic("Cl")_n^"odd"=2^(n-1)$, $italic("Cl")_n^"even"$ is a module over $italic("Cl")_n^"even"$.
]
#statement("Example")[
If $n=1$, $italic("Cl")_1 approx.eq bb(R)[e_1] slash (e_1^2+1) approx.eq bb(C)$.

If $n=2$, $italic("Cl")_2 approx.eq bb(R)[e_1,e_2] slash (e_1^2=e_2^2=-1,e_1 e_2=-e_2 e_1) approx.eq bb(H)$.
]
#statement("Proposition")[
$italic("Cl")_(n+m) approx.eq italic("Cl")_n times.o italic("Cl")_m$, here the tensor product is the graded tensor product.
]
#proof[]
#statement("Proposition")[
$italic("Cl")_n times.o_(bb(R)) bb(C)$ is semisimple over $bb(C)$ of dimension $2^n$, and
$ italic("Cl")_n times.o_(bb(R)) bb(C) = cases(
  M_(2^(n/2))(bb(C)) & "if " n " is even",
  M_(2^(floor(n/2)))(bb(C)) plus.o M_(2^(floor(n/2)))(bb(C)) & "if " n " is odd"
) $
]
#proof[]

#pagebreak()
= Spin group

#statement("Definition")[
$italic("Spin")(n)$ is a subgroup of $italic("Cl")_n^"even"$ consisting of elements of norm $1$.
]
#statement("Example")[
$italic("Spin")(2)=bb(T)$ is the circle group. Since $italic("Cl")_3^"even" approx.eq italic("Cl")_2 approx.eq bb(H)$, $italic("SU")(2) approx.eq italic("Spin")(3)$ are the corresponding subgroups.
]
#statement("Definition")[
$italic("Spin")(n)$ naturally acts on $bb(R)^n$ by $g dot v=g v g^(-1)$, then it is easy to see that $italic("Spin")(n) arrow.r italic("SO")(n)$ is a double covering, if $M$ is a Riemannian manifold, it has a principal bundle
#align(center)[#diagram(
  cell-size: (14mm, 10mm), spacing: (10mm, 8mm),
  node((0, 0), $italic("SO")(n)$), node((1, 0), $P$), node((1, 1), $M$),
  edge((0, 0), (1, 0), "->"), edge((1, 0), (1, 1), "->"),
)]
where $P_m$ are the oriented orthonormal frames on $T_m M$.

A spin structure on $M$ is a lifting of $P$ to a principal bundle for $italic("Spin")(n)$, note this may or may not exist.
]
#statement("Example")[
$bb(C) italic(P)^(2n)$ doesn't have a spin structure.
]
#statement("Proposition")[
If spin structures exist, the set of such structures is acted on transitively by $H^1(M,bb(Z) slash 2bb(Z))$.
]
#proof[
Consider the long exact sequence
$ H^1(M,bb(Z) slash 2bb(Z)) arrow.r H^1(M,italic("Spin")(n)) arrow.r H^1(M,italic("SO")(n)) arrow.r^(w_2) H^2(M,bb(Z) slash 2bb(Z)). $
]
#statement("Proposition")[
If $n$ is even and $M$ has a spin structure, fix it, then since $italic("Spin")(n) subset.eq italic("Cl")_n^"even" subset.eq italic("Cl")_n subset.eq italic("Cl")_n times.o bb(C) approx.eq M^(2^(n/2))(bb(C))$, and $italic("Cl")_n times.o bb(C)$ has a unique irreducible representation of dimension $2^(n/2)$, called the spin representation $Delta$, so we get a (complex) spin vector bundle $S=P_(italic("Spin")(n)) times_(italic("Spin")(n)) Delta$.
]
#statement("Definition")[
There is an elliptic operator acting on $S$ via $sum_(j=1)^n e_j dot nabla e_j$, where $e_1,dots.h.c,e_n$ is a local orthonormal frame, the symbol is $sum e_j xi_j$, this is called the Dirac operator $cancel(D)$.
]
#statement("Theorem")[
Assume $M$ is a closed Riemannian spin manifold of dimension $n=2l$, $italic("ind") cancel(D)=chevron.l hat(A)(M),[M] chevron.r$, here $hat(A)(M)$ is a polynomial in Pontryagin classes defined as follows: suppose $T M times.o bb(C) approx.eq L_1 plus.o dots.h.c plus.o L_l$ where $L_j$ are complex line bundles with Chern class $x_j$, then $hat(A)(M)=product_j frac(x_j,2sinh(x_j/2))$.
]

#pagebreak()
= Homeworks

== Homework 1

*1.*

Consider Hilbert space $(cal(H)_s,chevron.l , chevron.r)$, where
$ cal(H)_s={ (c_m)_(m in bb(Z)^m) mid(|) sum_(m in bb(Z)^n) abs(c_m)^2(1+abs(m)^2)^s < infinity }, $
with the obvious vector space structure and $chevron.l (c_m),(d_m) chevron.r=sum_(m in bb(Z)^n) c_m overline(d_m)(1+abs(m)^2)^s$, then Fourier transform $cal(F): H^(s)(bb(T)^n) arrow.r cal(H)_s$, $f mapsto (hat(f)(m))$ is an isometry, thus it suffices to prove $cal(H)_(s_2) arrow.r.double cal(H)_(s_1)$ is compact.

Suppose ${(c_(alpha m)) in cal(H)_(s_2)}$ is a bounded set, namely, $sum_(m in bb(Z)^n) abs(c_(alpha m))^2(1+abs(m)^2)^(s_2) <= M$ for some $M$, $forall k in bb(N)$, there exists $N_k$, for $abs(m)>=N_k$, we have $(1+abs(m)^2)^(s_1-s_2)<frac(1,M 2^(k+2))$, and for $abs(m)<=N_k$, $(c_(alpha m))_(abs(m)<=N_k)$ is a bounded set, thus having a convergent subsequence such that any $(c_(alpha m)),(c_(beta m))$ in that sequence satisfy $sum_(abs(m)<=N_k) abs(c_(alpha m)-c_(beta m))^2(1+abs(m)^2)^(s_1)<frac(1,2^(k+1))$, then by repeating this process, each time we get a subsequence out of the previous one, taking the diagonal sequence, we get a sequence $(c_(k m))$ where for $abs(m)>=N_k$, $(1+abs(m)^2)^(s_1-s_2)<frac(1,M 2^(k+2))$, and $forall p,q>=k$, $sum_(abs(m)<=N_k) abs(c_(p m)-c_(q m))^2(1+abs(m)^2)^(s_1)<frac(1,2^(k+1))$, then
$ sum_(m in bb(Z)^n) abs(c_(p m)-c_(q m))^2(1+abs(m)^2)^(s_1) $
$ <= sum_(abs(m)<=N_k) abs(c_(p m)-c_(q m))^2(1+abs(m)^2)^(s_1)
  + sum_(abs(m)>=N_k) abs(c_(p m)-c_(q m))^2(1+abs(m)^2)^(s_2)(1+abs(m)^2)^(s_1-s_2) $
$ < frac(1,2^(k+1))+frac(1,M 2^(k+2)) sum_(m in bb(Z)^n) abs(c_(p m)-c_(q m))^2(1+abs(m)^2)^(s_2)<frac(1,2^k). $
Therefore $(c_(k m))$ is a convergent sequence in $cal(H)_(s_1)$.

*2.*

If $theta$ is an irrational number and $alpha$ is a rational number, then $m_1+theta m_2+alpha != 0$, $forall (m_1,m_2) in bb(Z)^2$.

Since $hat(f)(m)=frac(1,(2pi)^n) integral_(bb(T)^n) f(z) z^(-m) frac(dif z,z)$, hence
$ hat(D_j f)(m)=frac(1,(2pi)^n) integral_(bb(T)^n) z_j frac(partial,partial z_j) f(z) z^(-m-1) dif z $
$ =frac(1,(2pi)^n) integral_(bb(T)^n) [frac(partial,partial z_j) f(z) z_j z^(-m-1)-f(z) frac(partial,partial z_j)(z_j z^(-m-1))] dif z $
$ =frac(1,(2pi)^n) integral_(bb(T)^n) frac(partial,partial z_j) f(z) z_j z^(-m-1) dif z
  -frac(m_j,(2pi)^n) integral_(bb(T)^n) f(z) z^(-m-1) dif z=m_j hat(f)(m), $
hence by Plancherel theorem
$ norm(hat(f)(m))^2=norm(hat(D f))^2=norm(hat(D_1 f)+theta hat(D_2 f)+alpha hat(f)(m))^2 $
$ =sum_(m in bb(Z)^n) abs(hat(D_1 f)(m)+theta hat(D_2 f)(m)+alpha hat(f)(m))^2 $
$ =sum_(m in bb(Z)^n) abs(m_1 hat(f)+theta m_2 hat(f)+alpha hat(f)(m))^2 $
$ =sum_(m in bb(Z)^n) abs(m_1+theta m_2+alpha)^2 abs(hat(f)(m))^2, $
thus $D$ is injective.

On the other hand, we want $hat(f)(m)$ to be not rapidly decreasing while $(m_1+theta m_2+alpha)hat(f)(m)$ is, consider Liouville number $ell=sum_(k=0)^infinity 2^(-k!)$ which is a transcendental number with the property that
$ abs(ell-sum_(k=0)^n 2^(-k!))=abs(sum_(k=n+1)^infinity 2^(-k!))<=2^(1-(n+1)!)<=(2^(-n!))^n, $
let $frac(a_n,b_n):=sum_(k=0)^n 2^(-k!)$, then $a_n$ is an odd number whereas $b_n$ is an even number with $abs(ell-frac(a_n,b_n))<=frac(1,b_n^n)$, thus if we choose $alpha=frac(1,2), theta=ell, m_1=frac(a_n-1,2), m_2=frac(b_n,2)$, then
$ abs(m_1+theta m_2+alpha)=abs(m_2) abs(theta+frac(2m_1+1,2m_2))<=frac(C,abs(m_2)^(n-1)), $
and as $m_2$ is big enough, we would have $frac(1,abs(m_2))<=frac(C,(1+abs(m)^2)^(1/2))$, hence $abs(m_1+theta m_2+alpha)<=frac(C,(1+abs(m)^2)^((n-1)/2))$, for such choices, make $hat(f)(m)=1$ and all others $0$, then $hat(f)(m)$ is not rapidly decreasing while $(m_1+theta m_2+alpha)hat(f)(m)$ is.

#pagebreak()
== Homework 2

*1.*

First we show that the $n$-th derivative of $p(x,xi)=p(xi)=xi(1+xi^2)^(-1/2)$ has the form $Q_(n+1)(xi)(1+xi^2)^(-(2n+1)/2)$ where $Q_(n+1)(xi)$ is polynomial of $xi$ with degree no more than $n+1$, notice
$ [Q_(n+1)(xi)(1+xi^2)^(-(2n+1)/2)]' $
$ =Q_(n+1)'(xi)(1+xi^2)^(-(2n+1)/2)-(2n+1)xi Q_(n+1)(xi)(1+xi^2)^(-(2n+3)/2) $
$ =[(1+xi^2)Q_(n+1)'(xi)-(2n+1)xi Q_(n+1)(xi)](1+xi^2)^(-(2(n+1)+1)/2), $
we can define $Q_1(xi)=xi$ and $Q_(n+2)(xi)=(1+xi^2)Q_(n+1)'(xi)-(2n+1)xi Q_(n+1)(xi)$ inductively, then $abs(Q_(n+1)(xi))<=C_n(1+abs(xi))^(n+1)$ for some constant $C_n$ only depends on $n$, and $(1+xi^2)^(-1/2)>=sqrt(2)(1+abs(xi))^(-1)$, thus $abs(Q_(n+1)(xi)(1+xi^2)^(-(2n+1)/2))<=sqrt(2)C_n(1+abs(xi))^(-n)$, also $abs(p(x,xi))>frac(1,2)$ when $xi$ is sufficiently large, thus $P$ is an elliptic pseudo-differential operator of order $0$, the symbol for $I-P^2$ is $frac(1,1+xi^2)$, it is not a smoothing operator since $hat(e^(-abs(x)))(xi)=frac(2,1+xi^2)$ and apply Fourier inversion theorem then kernel corresponding to operator $I-P^2$ is
$ K(x,y)=frac(1,2pi) integral_(bb(R)) frac(e^(i(x-y)xi),1+xi^2) dif xi=frac(1,2)e^(-abs(x-y)) $
which is not smooth along the diagonal.

$P$ is not Fredholm on $L^2(bb(R))$, because Fourier transform is an isometry on $L^2(bb(R))$, $P$ corresponds to multiplication by $frac(xi,sqrt(1+xi^2))$ on $L^2(bb(R))$, it is easy to see $ker P=0$, as for cokernel of $P$, consider functions $xi^alpha bb(1)_([-1,1])$ with $-frac(1,2)<alpha<=frac(1,2)$, they belong to $L^2(bb(R))$ but without preimages in $L^2(bb(R))$, and any nonzero linear combination of them also doesn't have a preimage, so they are linearly independent representatives of cokernel of $P$, hence cokernel of infinite dimension and $P$ is not Fredholm on $L^2(bb(R))$.

Suppose $f$ is a periodic function on $bb(R)$ of period $2pi$, then
$ P(x,D)f=integral_(bb(R)) frac(xi,sqrt(1+xi^2))hat(f)(xi)e^(i x xi) dif xi $
$ =integral_(bb(R)) frac(xi,sqrt(1+xi^2))e^(-i 2pi xi)hat(f)(xi)e^(i(x+2pi)xi) dif xi $
$ =integral_(bb(R)) frac(xi,sqrt(1+xi^2))hat(f)(xi)e^(i(x+2pi)xi) dif xi=P(x+2pi,D)f, $
hence $P(x,D)f$ is also a periodic function on $bb(R)$ of period $2pi$, thus we may define $P$ as an operator on $S^1 approx.eq bb(R) slash 2pi bb(Z)$, notice
$ P(x,D)(e^(i n x))=integral_(bb(R)) frac(xi,sqrt(1+xi^2))hat(e^(i n x))(xi)e^(i x xi) dif xi $
$ =integral_(bb(R)) frac(xi,sqrt(1+xi^2))delta_n(xi)e^(i x xi) dif xi=frac(n,sqrt(1+n^2))e^(i n x), $
$ P(x,D)(sum c_n e^(i n x))=sum frac(n c_n,sqrt(1+n^2))e^(i n x) $
then it is easy to see $upright("ind") P=dim ker P-dim upright("coker") P=1-1=0$.

*2.*

After Fourier transform, $P_K$ corresponds to multiplication by $K^2-n^2$, suppose for a $norm(f)_(H^2(S^1))=sum (1+abs(n)^2)^2 abs(hat(f)(n))^2=1$, we have
$ norm((P_(K_2)-P_(K_1))f)_(L^2(S^1))=sum abs((K_2^2-K_1^2)hat(f)(n))^2 $
$ =(K_2^2-K_1^2)^2 sum abs(hat(f)(n))^2 <= (K_2^2-K_1^2)^2, $
thus $P_K$ varies continuously with $K$, when $K=0$, the periodic functions in the kernel of $P_0$ are only constants, i.e. $dim ker P_0=1$, on the other hand, consider linear operator $T: L^2(S^1) arrow.r bb(R), f mapsto integral_0^(2pi) f dif x$, notice $ker T={f in L^2(S^1) mid(|) integral_0^(2pi) f dif x=0}=upright("im") P_0$ since for such $f$, periodic function $integral_0^x integral_0^y f(z) dif z dif y-integral_0^(2pi) z f(z) dif z$ is a preimage, hence cokernel of $P_0$ is of dimension 1, thus $upright("ind") P=dim ker P-dim upright("coker") P=1-1=0$.

More directly, $sum frac(frac(1,2pi) integral_0^(2pi) f(y)e^(-i n y) dif y,K^2-n^2)e^(i n x)$ will be a solution when $K$ is not an integer.

#pagebreak()
== Homework 3

*1.*

*(i)*

Since $d_0(f)=dif f=frac(partial f,partial x)dif x+frac(partial f,partial y)dif y$,
$ d_1^*(f dif x and dif y)=-star d star(f dif x and dif y)=-star dif f $
$ =-star(frac(partial f,partial x)dif x+frac(partial f,partial y)dif y)=frac(partial f,partial y)dif x-frac(partial f,partial x)dif y, $
the symbol (or in this case the principal symbol) of $D$ is $mat(i xi_1,i xi_2; i xi_2,-i xi_1)=i mat(xi_1,xi_2; xi_2,-xi_1)$ is invertible off the zero section, hence $D$ is elliptic.

Alternatively, $d_0(f)=dif f=frac(partial f,partial z)dif z+frac(partial f,partial overline(z))dif overline(z)$, $d_1^*(f dif z and dif overline(z))=i frac(partial f,partial z)dif z-i frac(partial f,partial overline(z))dif overline(z)$, thus the symbol (principal symbol) of $D$ would be $mat(xi,i xi; overline(xi),-i overline(xi))$ which is invertible off the zero section, thus $D$ is elliptic.

*(ii)*

*(iii)*

$D^*=d_0^*+d_1$, thus
$ D^* D=(d_0^*+d_1)(d_0+d_1^*)=d_0^* d_0+d_0^* d_1^*+d_1 d_0+d_1 d_1^* $
$ =d_0^* d_0+(d_1 d_0)^*+d_1 d_0+d_1 d_1^*=d_0^* d_0+d_1 d_1^*, $
then
$ chevron.l D(f+omega),D(f+omega) chevron.r=chevron.l D^* D(f+omega),(f+omega) chevron.r $
$ =chevron.l d_0^* d_0 f,f chevron.r+chevron.l d_1 d_1^* omega,omega chevron.r $
$ =chevron.l d_0 f,d_0 f chevron.r+chevron.l d_1^* omega,d_1^* omega chevron.r, $
thus $D(f+omega)=0 arrow.l.r.double d_0 f=d_1^* omega=0$,
$ ker D=ker d_0 plus.o ker d_1^* approx.eq H_(italic("dR"))^0(S^2,bb(R)) plus.o H_(italic("dR"))^2(S^2,bb(R)) $
$ approx.eq H^0(S^2,bb(R)) plus.o H^2(S^2,bb(R)), $
but the cokernel of $D$ is just $H_(italic("dR"))^1(S^2,bb(R)) approx.eq H^1(S^2,bb(R))=0$, therefore $upright("ind") D=dim ker D-dim upright("coker") D=2$.

*2.*

#pagebreak()
== Homework 4

*1.*

*(i)*

Notice $ker overline(partial)_(cal(O)(n))=H^0(bb(C)italic(P)^1,cal(O)(n))$, and $upright("coker") overline(partial)_(cal(O)(n))=0$, $G$ acts on $H^0(bb(C)italic(P)^1,cal(O)(n))$ by $(g dot f)(z)=f(g^(-1)z)$ where $f(z)$ is a homogeneous polynomial of $z_0,z_1$ of degree $n$, suppose $f=sum_(k=0)^n alpha_k z_0^k z_1^(n-k)$, with $alpha_(k_0) != 0$ for some $k_0$, consider $h_l=upright("diag")(overline(u_l),u_l), h=sum_(l=0)^m c_l h_l$ acting on $f$, we get
$ (h dot f)(z)=sum_(l=0)^m (h_l dot f)(z)=sum_(l=0)^m sum_(k=0)^n c_l u_l^(n-2k)alpha_k z_0^k z_1^(n-k) $
$ =sum_(k=0)^n (sum_(l=0)^m c_l u_l^(n-2k))alpha_k z_0^k z_1^(n-k), $
take distinct $u_1,dots.h.c,u_n$ with $abs(u_l)=1$, and consider system of equations $sum_(l=0)^n c_l u_l^(n-2k)=0, forall k != k_0$, and $sum_(l=0)^n c_l u_l^(n-2k_0)=frac(1,alpha_(k_0))$ which has a solution of $c_l$'s since determinant
$ abs((u_l^(n-2k)))=abs((u_l^(n)(u_l^(-2))^k))=(product abs(u_l)^n) abs(((u_l^(-2))^k)) != 0 $
and $(u_l^(-2))^k$ is a Vandermonde matrix, thus $(h dot f)(z)=z_0^(k_0)z_1^(n-k_0)$, then $z_0^(k_0)z_1^(n-k_0) in bb(C)G f$.

Let $g=mat(u,w; -overline(w),overline(u))$, $g dot z_0^(k_0)z_1^(n-k_0)=(u z_0+w z_1)^(k_0)(-overline(w)z_0+overline(u)z_1)^(n-k_0)$ which in expansion has nonzero coefficient for term $z_0^n$, use the argument we have $z_0^n in bb(C)G f$, then $g dot z_0^n=(u z_0+w z_1)^n$ which in expansion has nonzero coefficients for each term $z_0^k z_1^(n-k)$, by the argument again, we know each term $z_0^k z_1^(n-k) in bb(C)G f$, thus $bb(C)G f$ generates all homogeneous polynomials of degree $n$.

Therefore this representation is irreducible.

Notice that $upright("diag")(overline(z),z)(z_0^k z_1^(n-k))=z_0^k z_1^(n-k)z^(n-2k)$ thus this is a subrepresentation $chevron.l z_0^k z_1^(n-k) chevron.r$ corresponds to $t^(n-2k)$, thus the restriction of this representation to $H$ is the direct sum of $chevron.l z_0^k z_1^(n-k) chevron.r$ which is $t^n+dots.h.c+t^(-n)=chi_n$.

This question I got some hints from Artavia Josue.

*(ii)*

Obviously $bb(Z)[u] subset.eq bb(Z)[t,t^(-1)]^sigma$, on the other hand, if $f(t)=sum_(n=-infinity)^infinity c_n t^n in bb(Z)[t,t^(-1)]^sigma$, then $sum_(n=-infinity)^infinity c_n t^(-n)=sigma f(t)=f(t)=sum_(n=-infinity)^infinity c_n t^n$, which implies that $c-n=c_(-n)$, thus $f(t)=c_0+sum_(n=1)^infinity c_n(t^n+t^(-n))$, but note that
$ 2(t+t^(-1))^n &=sum_(i=0)^n binom(n,i)t^(n-i)t^(-i)+sum_(i=0)^n binom(n,i)t^i t^(i-n) \
  &=sum_(i=0)^n binom(n,i)t^(n-2i)+sum_(i=0)^n binom(n,i)t^(2i-n) \
  &=sum_(i=0)^n binom(n,i)(t^(n-2i)+t^(2i-n)). $
Thus $t^n+t^(-n) in bb(Z)[u]$, $bb(Z)[u]=bb(Z)[t,t^(-1)]^sigma$.

Each power of $u$ is a sum of characters of the form $chi_n$ because $t^n+t^(-n)=chi_(n+2)-chi_n$.

Therefore the image of $R(G)$ in $R(H)$ is contained in $bb(Z)[u]$ and the restriction map is injective, then consider $R(H) arrow.r R(G) arrow.r R(H), t^n mapsto V_n mapsto chi_n$, thus $bb(Z)[u]$ will be contained in the image, hence $R(H) arrow.r R(G)$ is surjective and $R(G) arrow.r R(H)$ has precisely image $bb(Z)[u]$.

By Serre duality, we know that $dim H^1(bb(C)italic(P)^1,cal(O)(n))=dim H^0(bb(C)italic(P)^1,K times.o cal(O)(-n))=dim H^0(bb(C)italic(P)^1,cal(O)(-n-2))$, when $n=-1$, $t^(-1)$ is mapped to $0$, when $n<=-2$, the image of $t^n$ is $-V_(-n-2)$, which restricts to $chi_(-n-2)$.

*2.*

#pagebreak()
#heading(numbering: none)[Index]
#index-list()