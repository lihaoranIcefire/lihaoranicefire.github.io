#import "@preview/fletcher:0.5.8": diagram as fletcher-diagram, node, edge
#let diagram(text-size: 8pt, ..args) = context {
  set text(size: text-size)
  layout(size => {
    let body = fletcher-diagram(..args)
    let width = measure(body).width
    if width > size.width {
      scale(x: size.width / width * 100%, y: size.width / width * 100%, reflow: true, body)
    } else { body }
  })
}
#set document(title: "MATH808K - Algebraic K-Theory", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(font: "New Computer Modern", size: 10pt, lang: "en")
#set par(justify: true)
#set heading(numbering: "1.1")
#set math.equation(numbering: none)
#let numbered-equation(body) = math.equation(block: true, numbering: number => context numbering("(1.1)", counter(heading).get().first(), number), body)
#let statement(name, title: none, tag: none, body) = [
  #figure(
    align(left, block(width: 100%, breakable: true)[
      #context strong[
        #name #counter(heading).get().first().#counter(figure.where(kind: "statement")).display("1")
        #if title != none [(#title)]
      ]
      #body
    ]),
    kind: "statement", supplement: name,
    numbering: number => context numbering("1.1", counter(heading).get().first(), number),
    caption: none,
  )
  #if tag != none { label(tag) }
]
#show ref: it => context {
  let target = it.element
  if target != none and (target.func() == figure or target.func() == math.equation) {
    let location = target.location()
    let equation = target.func() == math.equation
    let target-counter = if equation { counter(math.equation) } else { counter(figure.where(kind: "statement")) }
    link(location, numbering(
      if equation { "(1.1)" } else { "1.1" },
      counter(heading).at(location).first(), target-counter.at(location).first(),
    ))
  } else { it }
}
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "statement")).update(0)
  counter(math.equation).update(0)
  it
}
#let proof(title: "Proof", body) = block(width: 100%, breakable: true)[
  _#title._ #body #h(1fr) $square$
]
#let aside(name, title: none, body) = block(width: 100%, breakable: true)[
  _#name#if title != none [ (#title)]._ #body
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
  #text(size: 22pt, weight: "bold")[MATH808K \ Algebraic K-Theory]
  #v(2cm)
  #image("Pictures/Grothendieck.jpg", width: 50%)
  #v(2cm)
  Taught by Jonathan Rosenberg \
  Notes taken by Haoran Li \
  2021 Spring
  #v(2cm)
  Department of Mathematics \
  University of Maryland
]
#pagebreak()
#outline(title: [Contents])
#pagebreak()

= Introduction
<introduction>
K-theory is the study of categories of #strong[vector bundles] or similar objects. A vector bundle is a parametrized family of vector spaces: $p : E arrow.r X$ is a vector bundle, $X$ is a topological space. For each $x in X$, $E_x = p^(- 1) \( x \)$ is a vector space depending \"continuously\" on $x in X$. K-theory deals with parametrized linear algebra. Often we don't deal directly with geometry, but with rings

#statement(tag: "Swan-Serre Theorem", "Theorem", title: [Swan-Serre])[
There is an equivalence of cateogories between vector bundles over $X$ and finitely generated projective modules over an associated ring of functions on $X$. Here are 3 categories in which this works

+ $X$ compact Hausdorff, $R = C \( X \)$ the continuous $bb(F)$-valued function on $X$. Here $bb(F)$ could be $bb(R) \, bb(C)$ or $bb(H)$

+ $X$ affine variety over a field $k$, $R = cal(O) \( X \)$ is the ring of regular functions. If $X$ is projective, it is more complicated

+ $X$ stein manifold(holomorphic submanifold of $bb(C)^n$), $R = cal(O) \( X \)$ holomorphic functions on $X$, category of vector bundles is holomorphic category

]
= Projective modules
<projective-modules>
In this course, a ring almost always have units but not necessarily commutative

#statement("Definition")[
$R$ is a ring with unit. A free $R$-module is one isomorphic to $R^I$, $I$ is some index set. A finitely generated free $R$-module is one isomorphic to $R^n$. $R$ is said to have the #emph[invariant basis property] if $R^n tilde.equiv R^m arrow.r.double n = m$. Note that this is always true if $R$ is commutative(reason: true for fields, and if $R$ is commutative, $k = R \/ m$ is field, $R times.o k$ is a vector space over $k$)

]
#statement("Exercise", title: [Counter-example])[
$k$ is a field, $R = "End"_k \( k^oo \)$ doesn't have the invariant basis property, as $R tilde.equiv R^2$. Idea: $k^oo xor k^oo tilde.equiv k^oo$

]
#proof(title: "Solution")[
$R$ corresponds to a matrix with rows and columns ranging in $bb(N)$, and each column has all but finitely many non-zero elements, and we can decompose any matrix to the direct sum of two matrices with even columns or odd columns #math.equation(block: true, numbering: none, $mat(delim: "[", compose, times, compose, times, compose, times, dots.h.c; compose, times, compose, times, compose, times, dots.h.c; compose, times, compose, times, compose, times, dots.h.c; compose, times, compose, times, compose, times, dots.h.c; compose, times, compose, times, compose, times, dots.h.c; compose, times, compose, times, compose, times, dots.h.c; dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.down; #none)$)

]
#statement("Theorem")[
$R$ is ring, $P$ is an $R$-module. The following are equivalent

+ $P$ is a direct summand in a free $R$-module, i.e. $F tilde.equiv P xor Q$ for some free $R$-module $F$

+ $"Hom"_R \( P \, - \)$ is an exact functor

+ $P$ has the property that if $phi.alt : M arrow.r N$ is a surjective $R$-module map and we are given $alpha : P arrow.r N$, there exists $beta : P arrow.r M$ such that $alpha = phi.alt compose beta$

An $R$-module with these 3 equivalent conditions is called #emph[projective]#index-entry("Projective module")

]
#proof(title: [Proof])[

]
The first invariant of K-theory is $K_0 \( R \)$, then #strong[Grothendieck group] of finitely generated projective modules over $R$. If $P$ and $Q$ are finitely generated projecive $R$ modules, we can \"add\" by taking direct sum, but not subtract. $K_0 \( R \)$ is the group with generators $\[ P \]$, $P$ finitely generated $R$-module with relations $\[ P \] = \[ Q \]$ if $P tilde.equiv Q$. We build in the relation $\[ P \] + \[ Q \] = \[ P xor Q \]$. Note that every element of $K_0 \( R \)$ is of the form $\[ P \] - \[ Q \]$ for some $P \, Q$, $\[ P \] - \[ Q \] = \[ P' \] - \[ Q' \] arrow.l.r.double P xor Q' xor S tilde.equiv R' xor Q xor S$ for some $S$. In general, \"addition\" of projective modules does not have the cancellation property, just as addition of vector bundles does not

#statement("Example")[
$T S^2$ is not free since $chi \( S^2 \) = 2 eq.not 0$

]
#statement("Fact", title: [reference: Hatcher's K-theory book])[
+ Any vector bundle (by definition) is locally trivial, then rank $X arrow.r bb(N)$ is continuous, hence locally constant

+ Any vector bundle can be equipped with a metric, i.e. a family of inner products varying continuously with $x in X$. (Construction: use local triviality and patch with partition of unity)

+ Any vector bundle can be embedded into a trivial vector bundle $X times bb(F)^n$ for $n$ large enough. (Use local triviality and partition of unity)

+ 2+3 $arrow.r.double$ Any vector bundle is a direct summand in a trivial bundle

]
#proof(title: [Proof of Theorem~#ref(label("Swan-Serre Theorem"), supplement: none)])[
Send $p : E arrow.r X$ to the set of sections $Gamma \( E \)$, then $Gamma \( E \)$ is a $cal(O) \( X \)$-module, from above, $Gamma \( E \)$ is finitely generated and projective. The rest is formal

]
#statement("Example")[
Observation: Any vector bundle over $S^n \, n gt.eq 1$ is obtained by gluing(\"clutching\"): two trivial vector bundles over the upper and lower hemispheres via a map $S^(n - 1) arrow.r "GL" \( k \, bb(F) \)$. This is because any vector bundle over a contractible space is trivial, so #math.equation(block: true, numbering: none, $"Vect"_(bb(F))^k \( S^n \) tilde.equiv \[ S^(n - 1) \, "GL" \( k \, bb(F) \) \] tilde.equiv cases(pi_(n - 1) \( O \( k \) \) quad bb(F) = bb(R), pi_(n - 1) \( U \( k \) \) quad bb(F) = bb(C), pi_(n - 1) \( "Sp" \( k \) \) quad bb(F) = bb(H))$) $X = S^2$, $bb(F) = bb(R)$, what is the classification of rank $n$ vector bundles over $X$? We see that rank $k$ vector bundles over $S^2$ are classified by $pi_1 \( O \( k \) \)$, since $S^1$ is connected, any map $S^1 arrow.r O \( k \)$ lies in a single component, both isomorphic to $"SO" \( k \)$, for $k gt.eq 3$, $"SO" \( k \)$ is a simple Lie group and $pi_1 \( "SO" \( k \) \) tilde.equiv bb(Z) \/ 2$ for $k gt.eq 3$\(except $"SO" \( 4 \)$ is only semi-simple with two cover?)

]
#aside("Note")[
$S U \( 2 \)$ as quaternions acts on $S^3$, gives a double cover of $"SO" \( 3 \)$

]
Implication for K-theory: The stable isomorphic classes of vector bundles $E$ over $S^2$ is characterized by #math.equation(block: true, numbering: none, $cases("rank" in bb(N), upright("Stiefel-Whitney number") = chevron.l w_2 \( E \) \, \[ S^2 \] chevron.r in bb(Z) \/ 2)$) Similar analysis holds for $S^n$ #math.equation(block: true, numbering: none, $cases("rank" in bb(N), upright("something in ") pi_(n - 1) \( "SO" \))$) Here $pi_(n - 1) \( "SO" \) = pi_(n - 1) \( "SO" \( oo \) \) = lim_arrow.r_k pi_(n - 1) \( "SO" \( k \) \)$, $pi_(n - 1) \( "SO" \( k \) \)$ stablizes as $k arrow.r oo$

#statement("Theorem", title: [Bott periodicity theorem])[
#math.equation(block: true, numbering: none, $pi_(n - 1) \( "SO" \) = cases(bb(Z) \, quad n upright(" is a multiple of ") 4, bb(Z) \/ 2 \, quad n equiv 1 \, 2 #h(0em) mod med 8, 0 \, quad upright("otherwise"))$)

]
Lessons form this example: stable classification is much easier than the unstable classification. A stably trivial bundle need not to be trivial. These lessons carry over to the purely algebraic setting of projective modules over a ring. To get a corresponding example with projective modules over a Noetherian commutative ring, take $R = bb(R) \[ x \, y \, z \] \/ \( x^2 + y^2 + z^2 - 1 \)$, $"Spec" R$ is an \"algebraic model\" for $S^2$. Our non-trivial but stably trivial vector bundle can be constructed as ${ \( x \, y \, z \, u \, v \, w \) \| x^2 + y^2 + z^2 = 1 \, x u + y v + z w = 0 }$. This is an algebraic model for the tangent bundle of $S^2$

= Homotopy Invariance
<homotopy-invariance>
#statement(tag: "theorem1 - 1/29/2021", "Theorem")[
The classification of the topological vector bundles over a compact Hausdorff space X is homotopy invariant. In other words, if $f \, g : X arrow.r Y$ are maps of compact spaces and $E$ is an $bb(F)$ bundle over $Y$, then $f tilde.eq g arrow.r.double f^(*) \( E \) tilde.equiv g^(*) \( E \)$

]
#statement("Corollary")[
Every vector bundle over a contractible space is trivial

]
#statement(tag: "theorem2 - 1/29/2021", "Theorem")[
$A$ is a unital Banach algebra(For application, $A = C \( X \, M_n \( bb(F) \) \)$). Let $"Idem" A$ be the set of idempotents in $A$\($x^2 = x$). If $e \, f in "Idem" A$ lies in the same component, then they are conjugate under $"GL"_1 \( A \)$

]
#proof(title: [Proof])[
It's enough to show that if $e \, f in "Idem" A$ are sufficiently close in norm, then $e \, f$ are conjugate. Suppose $e \, f$ are close and let $a = e + f - 1 in A$, then $a^2$ is close to $\( 2 e - 1 \)^2 = 1$, so $a^2$ is invertible, thus $a$ is invertible. $a e = f a$ since $a e = \( e + f - 1 \) e = f e$, $f a = f \( e + f - 1 \) = f e$, thus $a e a^(- 1) = f$

]
#proof(title: [Proof Theorem~#ref(label("theorem1 - 1/29/2021"), supplement: none)])[
Embed $E$ as a direct summand in a trivial bundle of rank $n$, then $f^(*) \( E \) \, g^(*) \( E \)$ are obtained by projecting down from $X times bb(F)^n$ via homotopic idempotents in $C \( X \, M_n \( bb(F) \) \)$

]
= Projective modules over a local ring
<projective-modules-over-a-local-ring>
#statement("Definition")[
$R$ is a ring with unit, $R$ is called #strong[local] if the non-invertible elements in $R$ constitute a 2-sided ideal $m$. Obviously $m$ is the unique maximal 2-sided ideal

]
Caution: In the non-commutative case, having a unique maximal 2-sided ideal is not good enough! Since $M_n \( bb(F) \)$ has this property for $bb(F)$ a field, and this ring is not local

Note: If $R$ is local and $x in R$ has a left inverse, then it also has a right inverse. Suppose $a x = 1$, then $a x in.not m$, so $x in.not m$, so $x$ is invertible

#statement("Fact")[
+ If $R$ is local with maximal ideal $m$ and $x in m$, then $1 + x$ is invertible. If not, then $1 + x in m arrow.r.double 1 in m$ which is a contradiction

+ \(Nakayama's lemma) $R$ is a local ring with maximal ideal $m$, and let $m$ be a finitely generated $R$-module, if $m M = M$, then $M = 0$. Let $M = R x_1 + dots.h.c + R x_n$ such that $n$ is minimal, then since $m M = M$, $x_n = r_1 x_1 + dots.h.c + r_n x_n$ with $r_j in m$, now $\( 1 - r_n \) x_n = r_1 x_1 + dots.h.c + r_(n - 1) x_(n - 1)$, but $1 - r_n$ is invertible, we can divide to get $x_n$, contradicting the minimality unless $n = 0$, i.e. $M = 0$

]
#statement("Corollary", title: [Corollary of Nakayama's lemma])[
$M$ is a finitely generated $R$-module, $x_1 \, dots.h.c \, x_k in M$

+ If $dot(x)_1 \, dots.h.c \, dot(x)_k$ generate $M \/ m M$, then it generate $M$

+ If $dot(x)_1 \, dots.h.c \, dot(x)_k$ is a free basis for $M \/ m M$, then it is a free basis for $M$

]
#proof(title: [Proof])[
Consider $N = M \/ \( R x_1 + dots.h.c + R x_k \)$, this shows that $x_1 \, dots.h.c \, x_k in M$ generates $M$. To show this is a basis, consider

]
#statement("Theorem")[
Let $R$ be a local ring, $M$ a finitely generated projective $R$-module, then $M$ is free

]
#proof(title: [Proof])[
$M xor N tilde.equiv R^n$. $m \( M xor N \) = m^n$, so $\( R \/ m \) M$ is a direct summand in $\( R \/ m \)^n$, but $R \/ m$ is a division ring, so $\( R \/ m \) M tilde.equiv \( R \/ m \)^k$ for some $0 lt.eq k lt.eq n$, and $\( R \/ m \) N = \( R \/ m \)^(n - k)$. Let $dot(x)_1 \, dots.h.c \, dot(x)_k$ be a free basis for $\( R \/ m \) M tilde.equiv M \/ m M$ and extend it to a free basis by adding $dot(x)_(k + 1) \, dots.h.c \, dot(x)_n$ for $\( R \/ m \) N$, pull these back to $x_1 \, dots.h.c \, x_k in M$ and $x_(k + 1) \, dots.h.c \, x_n in N$. $M = R x_1 + dots.h.c + R x_k$ by Nakayama's lemma. Since $x_1 \, dots.h.c \, x_n$ is another generating set for $R^n$ with $n$ elements, writing the the matrix of $x_i$'s and $e_i$'s gives the linear independence

]
#statement("Corollary")[
For $R$ is a local ring, $K_0 \( R \) = bb(Z)$, with the class of a projective module given by its rank(this is only stable case, note that the theorem actually prove the non-stable case, which is more general)

]
= Projective modules versus vector bundles
<projective-modules-versus-vector-bundles>
We discussed the Swan-Serre theorem, that if $E$ is a vector bundle over a compact Hausdorff space $X$, then $Gamma \( X \, E \)$ is a finitely generated projective $C \( X \)$-module. This suggests a deeper connection between properties of vector bundles and finitely generated projective moduels. A key aspect of vector bundles is that they are #strong[locally trivial]. The algebraic analogue of this is #strong[local freeness]

#statement(tag: "theorem 1,2021-2-1", "Theorem", title: [Lemma 2.4, #link(<Weibel>)[Weibel]])[
$R$ is a commutative ring, $M$ is a finitely generated $R$-module. The following are equivalent

+ $M$ is projective

+ $M$ is locally free, i.e. for each prime ideal $p$, $exists s in R \\ p$ such that $M \[ 1 \/ s \]$ is free of finite rangk over $R \[ 1 \/ s \]$

+ For each prime ideal $p$ of $M$, $M_p$ is a free $R_p$-module, and $M$ is finitely presented, i.e. there is an exact sequence $R^m arrow.r R^n arrow.r M arrow.r 0$\(If $R$ is Noetherian, then finitely generated implies finitely presented)

]
#proof(title: [Proof])[
1$arrow.r.double$2,3: Assume $M$ is projective, $R^n tilde.equiv M xor P$, then $M$ is finitely presented, i.e. $R^n arrow.r R^n arrow.r M arrow.r 0$. Also $R_p^n tilde.equiv M_p xor P_p$ over teh local ring $R_p$, by Theorem~#ref(label("theorem 1,2021-2-1"), supplement: none), $M_p$ is finitely generated and free over $R_p$. So after inverting things in $R \\ p$, we get a free module. But we really only have to invert finitely many elements since $M$ is finitely presented, which is the same as inverting their product, which is a single $s in M \\ p$, so $M \[ 1 \/ s \]$ is free of finite rangk over $R \[ 1 \/ s \]$ \
3$arrow.r.double$1: Since $M$ is finitely presented, we have an exact sequence $R^m arrow.r R^n arrow.r^epsilon.alt M arrow.r 0$. To show $M$ is projective, it suffices to show that $epsilon.alt^(*) : "Hom" \( M \, R^n \) arrow.r "Hom" \( M \, M \)$ is surjective, since $"id"_M$ then has a preimage. Given a prime ideal $p$, $M_p$ is free over $R_p$, so $epsilon.alt_p^(*)$ is split surjective, so is $epsilon.alt^(*)$, since $"Hom" \( M \, M \) \/ "Hom" \( M \, R^n \)$ is 0 after localizing at any prime ideal, hence 0

]
So at least over a Noetherian commutative ring, $M$ finitely generated projective $arrow.l.r.double$ $M_p$ finitely generated free for each $p in "Spec" R$. This suggests(and we used this to study vector bundles over spheres) that to construct interesting projective modules, we get them by patching(clutching) finitely generated free modules over different open sets

#statement("Example", title: [Milnor square, his book on algebraic K-theory])[
Suppose $f : R arrow.r S$ is a map of rings, $I tilde.equiv f \( I \)$, then $R$ is the puback of the diagram

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $R$),
node((1, 0), $S$),
node((0, 1), $R \/ I$),
node((1, 1), $S \/ I$),
edge((0, 0), (1, 0), "->", $f$),
edge((0, 0), (0, 1), "->"),
edge((1, 0), (1, 1), "->"),
edge((0, 1), (1, 1), "->", $f$),
)
]
Think of $S$ as $R \/ J$, so we are patching over $I$ and $J$

]
#statement("Example", title: [Topological example])[
$R = C \( S^2 \)$, $I$ is the ideal of functions which vanish on the open upper hemisphere and tend to zero along the equator. Then $R \/ I tilde.equiv C \( D_(-)^2 \)$, continuous functions on the closed lower hemisphere. Let $S$ be the continuous functions on the closed upper hemisphere $C \( D_(+)^2 \)$, $R arrow.r S$ is just restriction $S$ and $R \/ I$ are both of the form $C \( D^2 \)$, and since $D^2$ is contractible, every vector bundle on $D^2$ is trivial, and so every finitely generated projective $S$-module or $R \/ I$-module is free. But $S^2$ is contractible, we want to describe fintiely generated projective $R$-modules in terms of patching of trivial bundles along the equator

]
#statement("Theorem", title: [Milnor patching theorem])[
In a Milnor square

+ An $R$-moudle $P$ obtained by patching a finitely generated projective $S$-module $P_1$ and a finitely generated projective $R \/ I$-module $P_2$ is finitely genereated and projective

+ In the situation of 1, $S times.o_R P tilde.equiv P_1$ and $P \/ I P tilde.equiv P times.o_R R \/ I tilde.equiv P_2$

+ \(important)Every finitely generated projective $R$-mod arises this way

+ Suppose $P$ is obtained by patching $S^n$ and $\( R \/ I \)^n$ via $g in "GL"_n \( S \/ I \)$, and $Q$ is obtained similarly via $g^(- 1) in "GL"_n \( S \/ I \)$, Then $P xor Q tilde.equiv R^(2 n)$

+ More generally, if $P$ is obtained by patching $S^n$ and $\( R \/ I \)^n$ via $g in "GL"_n \( S \/ I \)$, and $Q$ is obtained by patching $S^n$ and $\( R \/ I \)^n$ via $h$, then $P xor Q tilde.equiv$ patching of $S^n$ and $\( R \/ I \)^n$ via $g h xor R^n$

]
#proof(title: [Proof])[
Translate to algebra the idea of gluing vector bundles when $X = X_1 union_Y X_2$, here $X_1 \, X_2$ are closed subsets of a compact Hausdorff sopace $X_1$ and $Y = X_1 inter X_2$. Alternatively, the Milnor patching theorem is a kind of \"algebraic Mayer-Vietoris\"

proof of 3: Recall $R$ is embedded in $S xor R \/ I$. Let $P$ be a finitely generated projective $R$-module Let $P_1 = S times.o_R P$ which is finitely generated projective $S$-module, let $P_2 = P \/ I P$ is a finitely generated projective $R \/ I$-module. We want to show that $P$ is obtained by patching $P_1$ and $P_2$. We have an exact sequence of $R$-modules #math.equation(block: true, numbering: none, $0 arrow.r R arrow.r S xor R \/ I arrow.r S \/ I arrow.r 0$) $"Hom"_R \( P \, - \)$ and $- times.o_R P$ is exact since $P$ is projective, so we have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r P arrow.r P_1 xor P_2 arrow.r S \/ I times.o_R P$) which says that $P$ is patched from $P_1$ and $P_2$ $mat(delim: "[", 1, 0; 0, 1) tilde.eq mat(delim: "[", 0, - 1; 1, 0)$ through homotopy $mat(delim: "[", 1 - t, - t; t, 1 - t)$ which has determinant $\( 1 - t \)^2 + t^2 > 0$, hence $mat(delim: "[", g, 0; 0, g^(- 1)) = mat(delim: "[", 1, g; 0, 1) mat(delim: "[", 1, 0; - g^(- 1), 1) mat(delim: "[", 1, g; 0, 1) mat(delim: "[", 0, - 1; 1, 0)$ and $mat(delim: "[", g, 0; 0, h) = mat(delim: "[", g, 0; 0, g^(- 1)) mat(delim: "[", 1, 0; 0, g h)$, here $mat(delim: "[", 1, g; 0, 1) tilde.eq mat(delim: "[", 1, 0; 0, 1)$ through homotopy $mat(delim: "[", 1, t g; 0, 1)$

]
= Line bundles and Picard Groups
<line-bundles-and-picard-groups>
We assume in this section $R$ is commutative. We showed that a finitely generated $R$-module $P$ is projective exactly when it's locally free. We call it(by analogy with topology) a #strong[line bundle] if $P$ is #strong[locally free of rank 1]. Commutativity of $R$ enables you to tensor two $R$-modules together to get a new one. This preserves the property of being a line bundle. So we can define the #strong[Picard group] $"Pic" \( R \)$ of $R$, to be the abelian group of line bundles over $R$ up to isomorphism with tensor product as the group operation and $\[ R \]$ as the identity element. The dual line bundle $P^or = "Hom"_R \( P \, R \)$, and $P times.o_R P^or arrow.r R$ is an isomorphism, so $\[ P^or \] = \[ P \]^(- 1)$. For topological line dunles over $bb(C)$, the dual line bundle can also be identified with the complex conjuate bundle. The dual of vector bundle $E arrow.r X$ is the bundle whose fibers are the dual vector spaces. Over $bb(C)$, $bb(C)^(*) tilde.equiv overline(bb(C))$ via the usual inner product

#statement("Example")[
+ $R = C^(bb(R)) \( X \)$, $X$ compact Hausdorff. $"Pic" \( R \) tilde.equiv H^1 \( X \, bb(Z) \/ 2 \)$

+ $R = C^(bb(C)) \( X \)$, $X$ compact Hausdorff. $"Pic" \( R \) tilde.equiv H^1 \( X \, bb(Z) \)$

]
#statement("Theorem")[
$R$ is a commutative ring, if two line bundle are stably isomorphic, then they are actually isomorphic

]
== Rank and Dimension
<rank-and-dimension>
Here are some more properties of rank of finitely generated projective modules over a commutative ring $R$. They are algebraic analogues of some theorems in topology

#statement("Theorem")[
If $M$ is a manifold of dimension $n$ and $E$ is a vector bundle of rank $k$ which is stably trivial, then $E$ is trivial provided $cases(k > n quad bb(F) = bb(R), k > \( n + 1 \) \/ 2 quad bb(F) = bb(C))$

]
#statement("Example")[
The tangent bundle of $S^2$ is stably trivial but not trivial, in this case, $n = 2 \, k = 2 \, bb(F) = bb(R)$. But every stably trivial 3 plane bundle over $S^2$ is trivial

]
#proof(title: [Proof])[
There is a fibration $O \( n - 1 \) arrow.r O \( n \) arrow.r S^(n - 1)$, we have $pi_(j + 1) \( S^(n - 1) \) arrow.r pi_j \( O \( n \) \) arrow.r pi_j \( O \( n - 1 \) \) arrow.r pi_j \( S^(n - 1) \)$. The map $pi_j \( O \( n - 1 \) \) arrow.r pi_j \( O \( n \) \)$ is sujective if $j < n - 1$. an iso if $j < n - 2$. and we can decompose $M$ as ($n$-1)-skeleton$union D^n$ via gluing along the ($n$-1)-skeleton

Similarly with $U \( n - 1 \) arrow.r U \( n \) arrow.r S^(2 n - 1)$, which gives $pi_j \( U \( n - 1 \) \) arrow.r pi_j \( U \( n \) \)$ surjective if $j < 2 n - 1$, an iso if $j < 2 n - 2$

]
== The rank function
<the-rank-function>
$R$ is a commutative ring, we get a notion of local rank function of a finitely generated projective $R$-mod $P$, $"Spec" \( R \) arrow.r bb(N) \, p mapsto "rank" \( P_p \)$.

#statement("Lemma")[
The rank funciton is continuous in Zariski topology

]
#proof(title: [Proof])[
$p$ is contained in a maximal ideal $m$, $"rank" "Spec" R \[ 1 \/ s \] = "rank" \( P_p \) = "rank" \( P_m \)$. We get a partition of $"Spec" R$ into disjoint open sets

]
#statement("Theorem", title: [Stable rank theorem, Bass-Serre, Bass's book on algebraic K theory, not easy])[
$R$ commutative and Noetherian of dimension $d$. If $R$ has a finitely projective module $P$ of constant rank $k$. then if $k > d$

+ $P = P_0 xor R^(k - d)$ for some projective module $P_0$ of rank $d$

+ $P$ is stably isomorphic to $P'$ of same rank $arrow.r.double P tilde.equiv P'$

+ $P$ stably free $arrow.r.double$ $P$ is free

]
#statement("Corollary")[
If $R$ is a commutative ring with no idempotents other than 0 and 1, then every finitely generated projective $R$-module has constant rank

]
#proof(title: [Proof])[
$"Spec" R$ is connected iff $R$ has no non-trivial idempotent. And an integral domain is connected(if $x$ is an idempotent, so is $1 - x$, and $x \( 1 - x \) = 0$)

]
== Back to line bundles
<back-to-line-bundles>
Let $R$ be a commutative ring, $P$ finitely generated projective $R$-module. We can form new modules $and.big^j P$. If $P$ has constant rank $k$, then $and.big^j P$ is projective of rank $binom(k, j)$. So we can define the determinant of $P$, $det \( P \) = and.big^k P$,$k = "rank" P$. If $R$ has no non-trivial idempotents, the determinant module is defined for all finitely generated projective modules

+ $det P$ is a line bundle

+ $det \( P xor Q \) = det P times.o det Q$

From these facts we deduce

#statement("Theorem")[
$R$ is a commutative ring, if two line bundles are stably isomorphic iff isomorphic, i.e. define the same class in $"Pic" \( R \)$

]
#proof(title: [Proof])[
Assume $P xor R^n tilde.equiv P' xor R^n$, then $P tilde.equiv det P times.o R = det \( P xor R^n \) tilde.equiv det \( P' xor R^n \) = det P' times.o R tilde.equiv P'$

]
#statement("Theorem")[
$R$ commutative Noetherian of dimension 1(in particular, Dedekind domain: Noetherian integral domain which is integrally closed in the field of fractions). Then every finitely generated projective $R$-module of constant rank is of the form $P xor R^(k - 1)$ for some $k$ and for some line bundle $P$, namely the determinant bundle of the module. Thus finitely generated projective $R$-module are completely classified by rank and determinant

]
#proof(title: [Proof])[
Just use stable rank theorem

]
#statement("Corollary")[
If $R$ is a commutative Noetherian integral domain of dimension 1, then $K_0 \( R \) tilde.equiv bb(Z) xor "Pic" \( R \)$, $\[ P \] mapsto \( "rank" P \, det P \)$

]
Note $det \( P xor Q \) = det P times.o det Q$ says it is a homomorphism in $"Pic"$, rank adding says it is a homomorphism in $bb(Z)$

= Ideal classes and Picard groups
<ideal-classes-and-picard-groups>
$R$ commutative integral domain, $F$ its field of fractions. A fractional ideal of $R$ is a non-zero $R$-submodule $I$ of $F$, is such that $x I subset.eq R$ for some $x in F^times$ (i.e. we can clear denominators). $I$ is invertible if $I J = R$ for some other fraction ideal $J$. Principal fractional ideals are $R x$ for $x in F^times$. Principal fractional ideals are invertible. The invertible fractional ideals form the Cartier group $"Cart" \( R \)$ of Cartier divisors under multiplication

#statement("Proposition")[
The line bundles over $R$ are the same as invertible ideals up to isomorphism. If $I \, J$ are fractional ideals and $I$ is invertible, then $I times.o_R J tilde.equiv I J$. There is an exact sequence #math.equation(block: true, numbering: none, $1 arrow.r R^times arrow.r F^times arrow.r^("div") "Cart" \( R \) arrow.r "Pic" \( R \) arrow.r 0$)

]
#proof(title: [Proof])[
Suppose $I$ is an invertible fractional ideal, $I J = R$, then there exist $x_i in I \, y_i in J$, $sum_(i = 1)^n x_i y_i = 1$, ${ x_i }$ define homomorphisms $R^n arrow.r I$, ${ y_i }$'s define homomorphisms $I arrow.r R^n$. $I arrow.r R^n arrow.r I$ is the identity, so $I$ is projective, and has rank one because $I times.o_R F = F$, so $I$ is a line bundle. Conversely, suppose $L$ is a line bundle, we get an embedding $L = R times.o_R L subset.eq F times.o_R L = F$, $L$ is isomorphic to a nonzero $R$ submodule of $F$, i.e. a fractional ideal. Since $I$ is finitely generated and projective, we have $R tilde.equiv L times.o_R L^or$, hence $L$ is invertible

]
Equivalent definition for Dedekind domain: Integral domain for which every fractional ideal is invertible

#statement("Theorem")[
$R$ Dedekind domain, every finitely generated torsion-free $R$-module $M$ is projective and isomorphic to $I times.o R^(n - 1)$ for some fractional ideal $I$

]
#proof(title: [Proof])[
Induction on $"rank" M = dim_F \( F times.o_R M \)$. $M$ torsion-free means $M$ embeds into $F times.o_R M$, so if $"rank" M = 0$, $M = 0$. Suppose $"rank" M = n$, $M$ embeds into $F^n$ and then projects to the last factor $F$, image can't be zero, so we have $0 arrow.r M_0 arrow.r M arrow.r I arrow.r 0$ with $I$ fractional ideal projective, so $M = M_0 xor I$, by induction, $M = I xor J xor R^(n - 2)$. $I xor J = I J xor R$ since they have the same determinant

]
== Applications
<applications>
+ If $R$ is a PID, then $"Pic" \( R \) = 0$, $1 arrow.r R^times arrow.r F^times arrow.r "Cart" \( R \) arrow.r 1$ is exact

  + $R = bb(Z) \, F = bb(Q)$, get #math.equation(block: true, numbering: none, $1 arrow.r bb(Z)^times arrow.r bb(Q)^times arrow.r bb(Q)^times \/ { plus.minus 1 } = bb(Q)_(> 0)^times arrow.r 1$)

  + $R = bb(Z) \[ i \] \, F = bb(Q) \[ i \]$, $R^times = { plus.minus 1 \, plus.minus i }$

  + $R = k \[ t \] \, F = k \( t \)$, $R^times = k^times$

+ $F$ be a number field, $R = cal(O)_F$. Then $R$ is a Dedekind domain, the $"Pic" \( R \)$ is finite, and $R^times$ is finitely generated, in fact, $"rank" \( R^times \) = r_1 + r_2 - 1$. Most of the time, $R$ is not a PID

+ $k$ is a field, $C$ is a smooth affine curve over $k$, $R$ is the ring of regular functions on $C$, then $R$ is a Dedekind domain. In the case $k = bb(C)$, $"Pic" \( R \)$ is the group of algebraic line bundles. $"Cart" \( R \)$ indeed corresponds to the group of divisors(finite linear combinations of points)

= Mayer-Vietoris for Picard groups
<mayer-vietoris-for-picard-groups>
Recall that if $R$ is a commutative ring, $"Pic" \( R \)$ is the group of isomorphism classes of line bundles over $R$. Thiss can sometimes be computed by \"patching\" or \"Mayer-Vietoris\"

#statement("Theorem", title: [In Weibel I.3])[
In a Milnor square

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $R$),
node((1, 0), $S$),
node((0, 1), $R \/ I$),
node((1, 1), $S \/ I$),
edge((0, 0), (1, 0), "->", $f$),
edge((0, 0), (0, 1), "->>"),
edge((1, 0), (1, 1), "->>"),
edge((0, 1), (1, 1), "->", $dot(f)$),
)
]
we get an eaxt sequence #math.equation(block: true, numbering: none, $1 arrow.r R^times arrow.r^Delta S^times times \( R \/ I \)^times arrow.r \( S \/ I \)^times arrow.r^partial "Pic" \( R \) arrow.r "Pic" \( S \) times "Pic" \( R \/ I \) arrow.r^(upright("ratio")) "Pic" \( S \/ I \)$) Here $Delta$ is the diagonal map and the maps $S^times times \( R \/ I \)^times arrow.r \( S \/ I \)^times$, $"Pic" \( S \) times "Pic" \( R \/ I \) arrow.r "Pic" \( S \/ I \)$ are the \"ratio maps\" $\( x \, y \) mapsto frac(dot(x), dot(f) \( y \))$ (with multiplicative notation). Note that this is highly analogous to Mayer-Vietoris in topology. The connecting homomorphism $partial$ is given by the gluing map.

]
= Classification of topological vector bundles and characteristic classes
<classification-of-topological-vector-bundles-and-characteristic-classes>
Let $X$ be a compact Hausdorff space, $bb(F) = bb(R)$ or $bb(C)$. Let $E arrow.r X$ be a rank $k$ vector bundle. Recall that $E$ embeds in a trivial rank $n$ bundle for some $n$ sufficiently large, then at each point $x in X$, we have an associated fiber $E_x subset.eq bb(F)^n$. thus we get a continuous map $X arrow.r "Gr"_(bb(F)) \( k \, n \)$ #math.equation(block: true, numbering: none, $"Gr"_(bb(F)) \( k \, n \) = cases(O \( n \) \/ O \( k \) times O \( n - k \) quad bb(F) = bb(R), U \( n \) \/ U \( k \) times U \( n - k \) quad bb(F) = bb(C))$) Over $"Gr"_(bb(F)) \( k \, n \)$, we have a canonical or universal bundle of rank $k$. Now we get classifying space $B O \( k \) = lim_arrow.r_(n arrow.r oo) "Gr"_(bb(R)) \( k \, n \)$ and $B U \( k \) = lim_arrow.r_(n arrow.r oo) "Gr"_(bb(C)) \( k \, n \)$, $B O \( 1 \) = bb(R P)^oo$, $B U \( 1 \) = bb(C P)^oo$

#statement("Theorem", title: [Classification theorem])[
$X$ is a compact Hausdorff space, there is a natural bijection #math.equation(block: true, numbering: none, ${ upright("isomorphism class of rank ") k upright(" real vector bundle over ") X } arrow.l.r \[ X \, B O \( k \) \]$) #math.equation(block: true, numbering: none, ${ upright("isomorphism class of rank ") k upright(" complex vector bundle over ") X } arrow.l.r \[ X \, B U \( k \) \]$) Given a map $X arrow.r B O \( k \)$, the associated vector bundle is just the pullback. Note that since $X$ is compact, the image lands in $"Gr" \( k \, n \)$ for some $n$

]
#proof(title: [Proof])[
We saw the every vector bundle arises this way, we also showed that homotopic maps give isomorphic vector bundles. It remains to show that isomorphic vector bundles come from homotopic maps. Suppose $E tilde.equiv F$ are rank $k$ vector bundles, both embedded in a trivial $n$-dimensional vector bundle. Taking $n$ large enough we can construct $phi.alt$ as a map $X arrow.r "GL"_n \( bb(F) \)$, $phi.alt \( x \) : E_x arrow.r F_x$, sending $E_x$ and $E_x^perp$ to $F_x$ and $F_x^perp$ isomorphically. We want to show that maps classifying $E$ and $F$ are homotopic. Trick: double $n$, and replace $phi.alt$ by $mat(delim: "[", phi.alt; #none, phi.alt^(- 1))$ This map can be homotoped to the identity. This shows the classifying maps to $"Gr"_(bb(F)) \( k \, 2 n \)$ are homotopic

]
== Characteristic classes
<characteristic-classes>
It turns out that $H^(*) \( B O \( k \) \, bb(Z) \/ 2 \)$ and $H^(*) \( B U \( k \) \, bb(Z) \)$ are polynomial rings on $k$ variables(prove this by induction on $k$ using the fibrations $O \( k - 1 \) arrow.r O \( k \) arrow.r S^(k - 1)$, $U \( k - 1 \) arrow.r U \( k \) arrow.r S^(2 k - 1)$). From this, one gets the following result

#statement("Theorem", title: [Existence and uniqueness theorem for characteristic classes, ref: see Hatcher on vector bundles and K theory])[
There are unique classes $w_j in H^j \( B O \( k \) \, bb(Z) \/ 2 \)$ with the following properties

+ $H^(*) \( B O \( k \) \, bb(Z) \/ 2 \) tilde.equiv bb(Z) \/ 2 \[ w_1 \, dots.h.c \, w_k \]$

+ If $L$ is a real line bundle over $X$, $w_1$ pulls back to the element of $H^1 \( X \, bb(Z) \/ 2 \) = "Hom" \( pi_1 \( X \) \, bb(Z) \/ 2 \)$ which classifies the line bundles, as $"Hom" \( pi_1 \( X \) \, bb(Z) \/ 2 \)$ corresponds to the two to one coverings $tilde(X)$, and $L = tilde(X) times_(pi_1 \( X \)) bb(R)$

+ For arbitrary real vector bundles $E$ of rank $k$ over $X$, we define $w \( E \)$, called the total Stiefel-Whitney class of $E$, to be $1 + f^(*) \( w_1 \) + f^(*) \( w_2 \) + dots.h$ which has the property that $w \( E \) = w \( F \)$ if $E tilde.equiv F$, $w \( E \) w \( F \) = w \( E xor F \)$, $w \( upright("trivial bundle") \) = 1$. These imply that $w$ is a stable invariant

There are unique classes $c_j in H^j \( B U \( k \) \, bb(Z) \)$ with the following properties

+ $H^(*) \( B U \( k \) \, bb(Z) \) tilde.equiv bb(Z) \[ c_1 \, dots.h.c \, c_k \]$

+ If $L$ is a complex line bundle over $X$, $c_1 \( L \)$ under usual isomorphism $"Pic" \( X \) tilde.equiv H^2 \( X \, bb(Z) \)$

+ For arbitrary complex vector bundles $E$ of rank $k$ over $X$, we define $c \( E \)$, called the total Chern class of $E$, to be $1 + f^(*) \( c_1 \) + f^(*) \( c_2 \) + dots.h$ which has the property that $c \( E \) = c \( F \)$ if $E tilde.equiv F$, $c \( E \) c \( F \) = c \( E xor F \)$, $c \( upright("trivial bundle") \) = 1$

]
#aside("Note")[
These facts follow from above:

+ If $E$ is a rank $k$ complex vector bundle over $X$, we can think of $E$ as a real vector bundle(realification) of rank $2 k$, then $w_(2 j) \( E \) = c_j \( E \) #h(0em) mod med 2$, $w_(2 j + 1) \( E \) = 0$

+ $w_1 \( L_1 times.o L_2 \) = w_1 \( L_1 \) + w_1 \( L_2 \)$, $c_1 \( L_1 times.o L_2 \) = c_1 \( L_1 \) + c_1 \( L_2 \)$

]
#statement("Theorem", title: [Lerary-Hirsch theorem])[
$F arrow.r^iota E arrow.r^p B$ is a fiber bundle, $H^(*) \( F \, R \)$ is finitely generated free $R$-module, and $exists c_j in H^(k_j) \( E \, R \)$ such that $iota^(*) \( c_j \)$ form a basis for $H^(*) \( F \, R \)$. Then $H^(*) \( B \, R \) times.o_R H^(*) \( F \, R \) arrow.r H^(*) \( E \, R \)$, $sum b_i times.o iota^(*) \( c_j \) mapsto p^(*) \( b_i \) smile c_j$ is an isomorphism

]
#statement("Theorem", title: [Splitting principle])[
Informal statement: For formulas involving characteristic classes, you can pretend that all vector bundles are direct sum of line bundles

Formal statement: Let $X$ be a compact Hausdorff space, $E arrow.r X$ a rank $k$ vector bundle(over $bb(R)$ or $bb(C)$), then there is another space $Y_E$ with a surjective projection $p : Y_E arrow.r X$ such that $p^(*) : H^(*) \( X \) arrow.r H^(*) \( Y_E \)$ is injective, and $p^(*) \( E \)$ splits as a direct sum of line bundles

]
#proof(title: [Proof])[
Idea: Let $Y_E$ be the fiber bundle over $X$ whose fiber over $x in X$ is the flag manifold of $E_x$ which can be identified with $U \( k \) \/ U \( 1 \)^k$ or $O \( k \) \/ O \( 1 \)^k$. By Leray-Hirsch theorem, $p^(*)$ is injective on cohomology(with $bb(Z)$ coefficients in the complex case and $bb(Z) \/ 2$ in the real case)

We get the formula for behavior under tensor products: if $E = L_1 xor dots.h.c xor L_k$, $F = M_1 xor dots.h.c xor M_l$, then $E times.o F tilde.equiv xor_(j \, m) L_j times.o M_m$, so $C \( E times.o F \) = product_(j \, m) \( 1 + c_1 \( L_j \) + c_1 \( M_m \) \)$, $c \( E \) = product_j \( 1 + c_1 \( L_j \) \)$, we can express $c_k$ using elementary symmetric functions

]
What is this good for? K theory is about stable classification of vector bundles. Sometimes this is hard to compute, but we have a calculational tool: $E$ is stably isomorphic to $F$ implies that $E$ and $F$ has the same characteristic classes

#statement("Example")[
Given line bundles $L \, L'$, $c_1 \( L \) = x \, c_1 \( L' \) = y$, $c \( L times.o L' \) = 1 + \( x + y \) + x y$, so if a rank 2 bundle $E$ is to be stably isomorphic to $L xor L'$, we need to have $c_1 \( E \) = x + y$ and $c_2 \( E \) = x y$, this is necessary but not sufficient

]
#statement("Example")[
Over $S^2$, we have complex vector bundles of rank 1, $L_n \, n in bb(Z)$ with $c_1 \( L_n \) = n x$, $x$ is the usual generator of $H^2 \( S^2 \)$. If we realify $L_n$, there are only two stable isomorphism classes, since $L_n$ is stably isomorphic to $L_(n + 2)$

]
= Other categories of vector bundles
<other-categories-of-vector-bundles>
The subject of K-theory is useful in studying many different categories of vector bundles. A useful framework is that of a #strong[ringed sapce] $\( X \, cal(O)_X \)$. Here $X$ is a topological space (not necessarily Hausdorff) and $cal(O)_X$ is a #strong[sheaf of rings] on $X$. That means that for each open set $U subset.eq X$, we have a ring $cal(O)_X \( U \)$ (to be thought of as the allowable functions on $U$) and that we have compatible #strong[restriction maps], in general neither injective nor surjective $cal(O)_X \( U \) arrow.r cal(O)_X \( V \)$ when $V subset.eq U$. The key axioms enable one to #strong[recover a function from its restrictions]:

+ If ${ U_i }$ is a covering of $U$, then $cal(O)_X \( U \) arrow.r product_i cal(O)_X \( U_i \)$ is injective

+ If ${ U_i }$ is a covering of $U$ and one is given $f_i in cal(O)_X \( U_i \)$ such that $f_i \|_(U_i inter U_j) = f_j \|_(U_i inter U_j)$ for all $i$ and $j$, then there exists $f in cal(O)_X \( U \)$ restricting to $f_i$ on $U_i$ (gluing condition)

In all cases we will be interested in, $\( X \, cal(O)_X \)$ will be what Weibel calls #strong[locally ringed], where we add two more axioms:

+ $cal(O)_X$ is a sheaf of #strong[commutative rings]

+ for $x in X$, $cal(O)_(X \, x) = lim_arrow.r_(x in U) cal(O)_X \( U \)$ is a local ring

+ the topology on $X$ is $T_0$, i.e. distinct points have distinct families of open neighborhoods. (Otherwise we can pass to a quotient space)

#statement("Example")[
- $X$ a topological (say compact Hausdorff) space and $cal(O)_X \( U \) = { upright("continuous functions ") U arrow.r bb(F) }$, where $bb(F) = bb(R)$ or $bb(C)$. In this case, $cal(O)_(x \, x)$ is the local ring of #strong[germs of continuous functions] at $x$.

- $R$ a commutative ring. $X = "Spec" R$, $cal(O)_X \( X \) = R$, $cal(O)_X \( D \( f \) \) = R \[ 1 / f \]$, $cal(O)_(X \, frak(p)) = R_(frak(p))$. This is a key example called an #strong[affine scheme].

- a locally ringed space $\( X \, cal(O)_X \)$ such that $X$ has an open covering ${ U_i }$ with $\( U_i \, cal(O)_X \|_(U_i) \)$ an affine scheme for each $i$. Such a ringed space is called a #strong[scheme]. Aside from affine schemes themselves, the key examples are #strong[projective schemes] over a field $k$. These are subschemes of #strong[projective space] $bb(P)_k^n$, which is constructed from the ring of homogeneous polynomials in $n + 1$ #strong[homogeneous coordinates] $x_0 \, dots.h.c \, x_n$. Note that $bb(P)_k^n$ has a covering ${ U_i }_(i = 0)^n$, where $U_i = { x_i eq.not 0 }$. Each $U_i$ is isomorphic to #strong[affine $n$-space] $bb(A)_k^n = "Spec" k \[ x_1 \, dots.h.c \, x_n \]$.

- A #strong[stein manifold] $X$, i.e. a complex analytic submanifold of $bb(C)^n$ for some $n$. These are the analytic counterparts of (smooth) affine schemes. The sheaf $cal(O)_X$ is defined by $cal(O)_X \( U \) = { upright("holomorphic functions on ") U }$

- More generally, an #strong[analytic space] $X$, with $cal(O)_X \( U \) = { upright("holomorphic functions on ") X }$

]
== Vector bundles on a ringed space
<vector-bundles-on-a-ringed-space>
Let $\( X \, cal(O)_X \)$ be a locally ringed space like one of the examples above. A #strong[vector bundle] over $X$ of #strong[rank] $k$ is a sheaf $cal(F)$ of $cal(O)_X$-modules (i.e., for each $U$ open in $X$, $cal(F) \( U \)$ is a module over $cal(O)_X \( U \)$, and the sheaf axioms hold) which is #strong[locally free] of rank $k$, i.e., such that there is an open covering ${ U_i }$ with $cal(F) \( U_i \) tilde.equiv cal(O)_X \( U_i \)^k$. In the cases of affine schemes and Stein manifolds, a vector bundle $cal(F)$ over $X$ is equivalent to a finitely generated projective module over $R = cal(O)_X \( X \)$. However, this fails badly over projective schemes and compact complex manifolds, since then $R$ is much too small (it consists only of constant functions).

== Classifying vector bundles
<classifying-vector-bundles>
Suppose $cal(F)$ is a rank $k$ vector bundle over $\( X \, cal(O)_X \)$, choose ${ U_i }$ with $cal(F) \( U_i \) = cal(O)_X \( U_i \)^k$. Over $U_(i j) = U_i inter U_j$, we have an isomorphism $cal(F) \( U_i \) \|_(U_(i j)) arrow.r^tilde.equiv cal(F) \( U_j \) \|_(U_(i j))$, which we can identify with a regular function over $U_(i j)$ with values in bundle automorphisms. This gives a Cech cocycle with values in $"GL"_k \( cal(O)_X \)$, and so we get the Classification theorem

#statement("Theorem")[
${ upright(V B) \( X \, cal(O)_X \) } tilde.equiv H^1 \( X \, "GL"_k \( cal(O)_X \) \)$. The right hand side is somewhat mysterious unless $k = 1$, when it is the cohomology of the #strong[multiplicative group] sheaf $underline(bb(G)_m)$ or $cal(O)_X^times$. So we have $"Pic" \( X \, cal(O)_X \) tilde.equiv H^1 \( X \, cal(O)_X^times \)$

]
== Chern classes of line bundles
<chern-classes-of-line-bundles>
Suppose $X$ is an analytic manifold, a Stein manifold, a compact complex manifold, or the underlying analytic space of a projective variety over $bb(C)$ (algebraic variety = reduced irreducible scheme). Let $X_(upright("top")) = X$ just as a topological space, the cohomology of $X$ is the target for Chern classes of topological vector bundles. Note that there is a natural map (forget analytic or algebraic structures) $upright(V B) \( X \, O_X \) arrow.r upright(V B) \( X_(t o p) \)$. So via this forgetful map, we can define Chern classes. But the forgetful map need not be either injective nor surjective, i.e. many algebraic vector bundles can give rise to the same topological vector bundle, and some topological vector bundles can't be made algebraic.

Another useful construction: The #strong[exponential sequence]. This works in the analytic but not in the algebraic category. Say $X$ is a connected complex analytic space or a complex manifold, $cal(O)$ is the sheaf of holomorphic functions, then we have an exact sequence of sheaves: #math.equation(block: true, numbering: none, $0 arrow.r bb(Z) arrow.r.hook^(2 pi i) cal(O) arrow.r^exp cal(O)^times arrow.r 1$) This gives a long exact sequence in sheaf cohomology #math.equation(block: true, numbering: none, $0 arrow.r bb(Z) arrow.r H^0 \( X \, O \) arrow.r H^0 \( X \, O^times \) arrow.r H^1 \( X \, bb(Z) \) arrow.r H^1 \( X \, cal(O) \) arrow.r H^1 \( X \, O^times \) = "Pic" \( X \, O \) arrow.r^(c_1) H^2 \( X \, bb(Z) \)$) There are cases where $c_1 : "Pic" \( X \, O \) arrow.r H^2 \( X \, bb(Z) \)$ is an isomorphism, then the classification of analytic and topological line bundles is the same

#statement("Example")[
$X = bb(P)_(bb(C))^1$, every analytic vector bundle is determined by its Chern class, and all Chern classes can be realized. So the analytic line bundles are all of the form $cal(O) \( n \)$, $n in bb(Z)$

]
#statement("Theorem", title: [Highly non-trivial, GAGA])[
For complex projective varieties, classifications of algebraic and analytic vector bundles coincide

]
== More on Algebraic and holomorphic vector bundles
<more-on-algebraic-and-holomorphic-vector-bundles>
#statement("Example")[
On $X = bb(P)_k^1$, $"Pic" \( bb(P)_k^1 \) tilde.equiv bb(Z)$ with line budnles denoted by $O \( m \)$, $m in bb(Z)$, whose local sections are homogeneous Laurent polynomials of degree $m$. If $k = bb(C)$, use exponential sequence we have #math.equation(block: true, numbering: none, $0 arrow.r H^1 \( bb(P)_(bb(C))^n \, cal(O)_X \) arrow.r H^1 \( bb(P)_(bb(C))^n \, cal(O)_X^times \) = "Pic" \( bb(P)_(bb(C))^n \) arrow.r^(c_1) H^2 \( bb(P)_(bb(C))^n \, bb(Z) \) arrow.r H^2 \( bb(P)_(bb(C))^n \, cal(O)_X \)$) The higher cohomology $H^j \( bb(P)_k^n \, cal(O)_X \)$ vanishes for $j > 0$, so the Chern class map $c_1$ is an isomorphism

]
== Similarities and differences between algebraic and topological categories
<similarities-and-differences-between-algebraic-and-topological-categories>
+ The same topological bundles may admit many inequivalent algebraic structures. Or it may admit none at all.

+ Exact sequences of algebraic vector bundles #strong[do not split] in general, this is different from the projective modules over a ring.

#statement("Example")[
+ $E$ Elliptic curve, say over $bb(C)$. We have the exponential exact sequence #math.equation(block: true, numbering: none, $0 arrow.r bb(Z) arrow.r^(2 pi i) bb(C) arrow.r^exp bb(C)^times arrow.r^0 H^1 \( E \, bb(Z) \) arrow.r H^1 \( E \, cal(O) \) arrow.r "Pic" \( E \) arrow.r H^2 \( E \, bb(Z) \) arrow.r H^2 \( E \, cal(O) \)$) Here $E$ is topologically $S^1 times S^1$, so $H^1 \( E \, bb(Z) \) = bb(Z)^2$, $H^2 \( E \, bb(Z) \) = bb(Z)$, we have $H^1 \( E \, cal(O) \) = bb(C)$, $H^2 \( E \, cal(O) \) = 0$. So we get the short exact sequence

  #align(center)[
  #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
  node((0, 0), $0$),
  node((1, 0), $bb(C) \/ bb(Z) times bb(Z)$),
  node((2, 0), $"Pic" \( E \)$),
  node((3, 0), $bb(Z)$),
  node((4, 0), $0$),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
  edge((3, 0), (2, 0), "->", bend: 18deg),
  )
  ]
  and $"Pic" \( E \) tilde.equiv bb(T)^2 times bb(Z)$. In particular, the Chern class $c_1$ does not determine the class of a line bundle.

+ $X = P_k^1$, every vector bundle over $X$ splits as a direct sum of line bundles. But unlike the case of complex top bundles over $S^2 = P_(bb(C))^1$, not every rank two vector bundle splits as $V = det \( V \) xor upright("trivial")$. For example, $cal(O) xor cal(O)$ and $cal(O) \( 1 \) xor cal(O) \( - 1 \)$ are both topologically trivial, but they are algebraically distinct.

+ Even on $bb(P)^1$, we have exact sequence #math.equation(block: true, numbering: none, $0 arrow.r cal(O) \( - 2 \) arrow.r arrow.r^alpha cal(O) \( - 1 \) xor cal(O) \( - 1 \) arrow.r^beta cal(O) arrow.r 0$) doesn't split. Since there are no morphisms from $cal(O) \( p \) arrow.r cal(O) \( q \)$, $p > q$. Here $beta \( f \, g \) = x_0 f + x_1 g$, $alpha \( h \) = \( x_1 h \, - x_0 h \)$

]
== Invertible ideal sheaves and divisors
<invertible-ideal-sheaves-and-divisors>
Let $X$ be an integral scheme, i.e., one such that $cal(O)_X \( U \)$ is an integral domain for each affine open set $U$. In particular, $X$ is connected and reduced, there is a common field of fractions for all $cal(O)_X \( U \)$, called $k \( X \)$, the field of rational functions

#statement("Example")[
$X = bb(P)_k^n$, $k \( X \) = k \( x_0 \, dots.h.c \, x_n \)$. $cal(K)$ is the constant sheaf $k \( X \)$. A #strong[fractional ideal sheaf] $cal(I)$ is a $cal(O)$-submodule of $cal(K)$ containded in $f cal(O)$ for some $f in k \( X \)$. It's called invertible if $cal(I) cal(J) = cal(O)$ for some other fractional ideal sheaf $cal(J)$. Then it's a line bundle (invertible locally free sheaf) with dual line bundle $cal(J)$

]
#statement("Proposition")[
$X$ integral scheme, then there is an exact sequence #math.equation(block: true, numbering: none, $1 arrow.r H^0 \( X \, cal(O)^times \) arrow.r k \( X \)^times arrow.r "Cart" \( X \) arrow.r "Pic" \( X \) arrow.r 1$) with $"Cart" \( X \)$ the group of invertible ideal sheaves. (Note that $"Pic" \( X \) = "Cart" \( X \) \/ tilde.op$)

]
In case $X$ is integral, separated, and locally factorial (local rings are all UFDs), there is an isomorphism between Cartier and Weil divisors (integral linear com of closed integral subschemes of codimension 1)

= Weibel chapter II on $K_0$
<weibel-chapter-ii-on-k_0>
$M$ is an abelian monoid, $F$ is the forgetful functor, the group completion functor $G$ is the left adjoint of $F$, i.e. $"Hom" \( M \, F \( A \) \) tilde.equiv "Hom" \( G \( M \) \, A \)$. If $M$ is a semiring, then $G \( M \)$ would be a ring. $G \( M \)$ consists of formal expressions $\[ m \] - \[ m' \]$, with $\( \[ m \] - \[ m' \] \) + \( \[ n \] - \[ n' \] \) = \[ m + n \] - \[ m + n \]'$, $\( \[ m \] - \[ m' \] \) times.o \( \[ n \] - \[ n' \] \) = \[ m times.o n \] - \[ m times.o n' \] - \[ m' times.o n \] + \[ m' times.o n' \]$, and $\[ m \] - \[ m' \] = \[ n \] - \[ n' \] arrow.l.r.double m + n' + p = n + m + p$ for some $p in M$

#statement("Example")[
$X$ compact Hausdorff, $M = upright(V B) \( X \)$, either over $bb(R)$ or $bb(C)$, $G \( M \) = K^0 \( X \)$

]
#statement("Example")[
+ $M = bb(N)$, $G \( M \) = bb(Z)$.

+ $R$ is an integral domain, $M = R - { 0 }$, $G \( M \) = "Frac" \( R \)^times$

+ $X$ is a compact Hausdorff space, $M = upright(V B) \( X \)$, the isomorphism classes of vector bundles over $X$ (say over either $bb(R)$ or $bb(C)$), $G \( M \)$ is called $K^0 \( X \)$

+ $X$ scheme, $M = upright(V B) \( X \)$, $G \( M \)$ is called $K^0 \( X \)$ (may differ from the topological case, even with the same notation). When $X$ is a projective variety over $bb(C)$, we have a forgetful map $K^0 \( X \) arrow.r K^0 \( X_(upright("top")) \)$

+ $R$ is a commutative ring, $M$ is the semiring of isomorphism classes of finitely generated projective $R$-modules. The multiplication comes from $times.o_R$, Then $K_0 \( R \) = G \( M \)$ is a commutative ring. The product operation is called the #strong[cup product]. For example, if $R = C^(bb(R)) \( S^2 \)$, we saw that $M$ is graded by rank and $M_n tilde.equiv cases(bb(Z) \, n = 2, bb(Z) \/ 2 \, n gt.eq 3)$. So $K_0 \( R \) tilde.equiv bb(Z) xor bb(Z) \/ 2$ as an abelian group, with the isomorphism given by the rank and the Stiefel-Whitney class $w_2$. Taking tensor product with a (stably) trivial bundle doesn't change $w_2$. On the other hand, if $w_2 \( E \) eq.not 0$ and $w_2 \( F \) eq.not 0$, then $w_2 \( E xor F \) = w_2 \( E \) + w_2 \( F \) = 0$ and $w_2 \( E times.o F \) = 0$. So as a ring $K_0 \( R \) = bb(Z) \[ t \] \/ \( 2 t \, t^2 \)$

+ $G$ finite group, $M$ is the commutative semiring(under $xor \, times.o$) of isomorphism classes of finite dimensional representations of $G$, the group completion is the representation ring $R \( G \)$ which is a free abelian group with rank the number of conjugacy classes. $R \( G \) arrow.r bb(Z) = R \( { 1 } \)$ by restriction is the augmentation map, kernel being the augmentation ideal. Representation ring plays an important role in equivariant K-theory. If $G = bb(Z) \/ k$, all irreducible representations are characters of $G^or$, $R \( G \) = bb(Z) \[ t \] \/ \( t^k - 1 \)$, $t$ maps the generator of $G$ to $e^(frac(2 pi i, k))$

+ $G$ finite group, $M$ is the commutative semiring(under $union.sq \, times$) of finite $G$ sets, the group completion is $A \( G \)$, called the Burnside ring, which free abelian group with rank the number of conjugacy classes of subgroups $H lt.eq G$, there is a natural ring map $A \( G \) arrow.r R \( G \)$, sending a $G$-set $X$ to the representation of $G$ on $bb(C) X$

]
== Basics of $K_0 \( R \)$
<basics-of-k_0r>
$R$ is a ring, not necessarily commutative, $K_0 \( R \)$ is the Grothendieck group of the monoid of isomorphism classes of finitely genearated projective $R$-modules. We can't drop the finitely generated condition because of the #strong[Eilenberg swindle]: Suppose $P$ is a projective module over $R$, with $P xor Q$ a free module. Claim that $P$ is always stably free(if we don't restrict to finite rank). Since free module $\( P xor Q \) xor \( P xor Q \) xor dots.h.c$ can be written as $P xor \( Q xor P \) xor \( Q xor P \) xor dots.h.c = P xor upright("free module")$. Not only that, but sometimes for some rings, $K_0 \( R \) = 0$

#statement("Definition", title: [Karoubi])[
A ring $R$ is called #strong[flasque]#index-entry("Flasque ring")\(French word meaning flabby) if there is an $R$-bimodule $M$, finitely generated and projective as a right $R$-module, such that $R xor M tilde.equiv M$ as $R$-bimodules

]
#statement("Proposition", title: [Karoubi])[
If $R$ is flasque, then $K_0 \( R \) = 0$. In fact, all of its K groups vanishes

]
#proof(title: [Proof])[
Let $P$ be a finitely generated right $R$-module, then $P xor \( P times.o_R M \) = P times.o_R \( R xor M \) tilde.equiv P times.o_R M$, so $P$ is stably isomorphic to 0

]
#statement("Example")[
$"End" \( R^oo \)$ is flasque, with $M$ being itself

]
== Von Neumann regular rings
<von-neumann-regular-rings>
#index-entry("Von Neumann regular rings")

A ring $R$ (not necessarlily commutative) is called #strong[Von Neumann regular] (the notion was introduced by Von Neumannm PNAS, 1936) if $forall a in R$, $exists x in R$ with $a x a = a$, $x$ behaves like an inverse for $a$. Any division ring $D$ is von neumann regular ($x = 0$ if $a = 0$, and $x = a^(- 1)$ if $a eq.not 0$), and $M_n \( D \)$ is also Von Neumann regular

#statement("Proposition")[
If $R$ is Von Neumann regular, then $lambda : I arrow.r$ left annihilator of $I$, $rho : J arrow.r$ right annihilator of $J$. This gives order reversing maps between left and right ideals

]
#proof(title: [Proof])[
Obviously $I_1 subset.eq I_2 arrow.r.double lambda \( I_2 \) subset.eq lambda \( I_1 \)$, and similarly for $rho$. $I subset.eq rho lambda \( I \)$, $J subset.eq lambda rho \( J \)$. So $lambda rho lambda \( I \) subset.eq lambda \( I \)$, but on the other hand $lambda \( I \) subset.eq lambda rho lambda \( I \)$, so $lambda = lambda rho lambda$, similarly $rho = rho lambda rho$

]
#statement(tag: "17:48-06/02/2022", "Proposition")[
If $R$ is Von Neumann regular, then each principal left ideal $R a = R e$ for some idempotent $e$, and the right annihilator of $R a$ is $\( 1 - e \) R$. Similarly, any $a R = e R$ for some idempotent $e$, and the left annihilator of $a R$ is $R \( 1 - e \)$. Thus there is an order revering bijection between left and right principal ideals.

]
#proof(title: [Proof])[
choose $x$ such that $a x a = a$, then $e = x a$, $R a = R e$. $R e$ and $\( 1 - e \) R$ are each other's annihilators

]
#statement("Proposition")[
Suppose $R$ is Von Neumann regular, then there are some orthogonal idempotentes $e \, f$ such that $a R = e R$, $b R = f R$ and $a R + b R = e R + f R = \( e + f \) R$

]
#proof(title: [Proof])[
By Proposition~#ref(label("17:48-06/02/2022"), supplement: none), there exists an idempotent $e$ such that $a R + b R = e R + b R = e R + \( 1 - e \) b R$, choose $f_1$ such that $\( 1 - e \) b R = f_1 R$, clearly $e f_1 = 0$, let $f = f_1 \( 1 - e \)$, then $f f_1 = f_1$, so $f^2 = f$. $a R + b R = e R + f_1 R = e R + f R$

]
#statement("Corollary")[
If $R$ is Von Neumann regular, then every finitely generated right projective $R$-module is a direct sum of $e R$'s with $e$ being idempotents, and in particular every finitely generated right ideal is projective

]
It is often easy to compute $K_0$ in this case

== More about $K_0$ of rings
<more-about-k_0-of-rings>
If $R = lim_arrow.r R_i$, then $K_0 = lim_arrow.r K_0 \( R_i \)$

#statement("Example")[
An AF or AFD(approximately finite dimensional) rings is a ring of the form $lim_arrow.r R_i$, where $R_i$ is a finite dimensional semisimple algebra over $bb(C)$. i.e. a direct sum of matrix algebras. Note that $K_0 \( R_i \) = bb(Z)^(n_i)$, where $n_i$ is the number of matrix summands. maps between such algebras can be described by #emph[Bratteli diagrams]#index-entry("Bratteli diagrams")

#align(center)[

]
Thus any countable torsion-free abelian group can arise as $K_0$ of an AF algebra examples: the CAR algebra(canonical anticommutation relations) 1--2--4--8--..., $K_0$ is $bb(Z) \[ 1 \/ 2 \]$ and gauge invariant CAR algebra(or Pascal's triangle algebra), $K_0$ is countable torsion free abelian but not finitely generated

]
#statement(tag: "Lemma for idempotent lifting", "Lemma", title: [Idempotent lifting])[
$R$ ring, $I$ either nilpotent or complete ideal($sum_(n = 1)^oo x_n$ with $x_n in I^n$ converges to a unique element of $I$). Then any idempotent $dot(e) in R \/ I$ can be lifted to an idempotent $e$ in $R$. Furthermore, any two such lifts are conjugate under some $u in 1 + I$

]
#proof(title: [Proof])[
Choose $e_1 in R$ lifting $dot(e)$, then $e_1^2 - e_1 in I$. take $e = u e_1^k$

If instedad, $I$ is complete, we replacfe $e_1 b y u e_1$, where $u = \( e_1^2 + f_1^2 \)^(- 1)$, which commutes with $e_1$ and $f_1$. Now $u \( e_1^2 + f_1 \)^2 = 1$. $\( u e_1 \)^2 + \( u f_1 \)^2 = u$

]
#statement("Lemma")[
$R$ is a ring, $dot(u) in R \/ I$ which is invertible. Then $mat(delim: "[", dot(u); #none, dot(u)^(- 1))$ lift to something in $"GL"_2 \( R \)$

]
#proof(title: [Proof])[
$mat(delim: "[", dot(u); #none, dot(u)^(- 1)) = mat(delim: "[", 1, dot(u); #none, 1) mat(delim: "[", 1; - dot(u)^(- 1), 1) mat(delim: "[", 1, dot(u); #none, 1) mat(delim: "[", #none, - 1; 1)$

]
#statement("Theorem")[
$R$ is a ring with ideal $I$ which is either nilpotent or complete. Then $K_0 \( R \) tilde.equiv K_0 \( R \/ I \)$, via the natural map $R arrow.r R \/ I$

]
#proof(title: [Proof])[
Surjectivity: Let $P$ be a finitely generated projective $\( R \/ I \)$-module, then $P$ comes from an $n times n$ idempotent matrix $dot(e)$ over $R \/ I$. Now $dot(e) in M_n \( R \/ I \) tilde.equiv M_n \( R \) \/ M_n \( I \)$ and note that $M_n \( I \)$ is either nilpotent(if $I$ is) or complete (if $I$ is). This requires checking, but if $a in M_n \( I \)$, then powers of $a$ have entries in powers of $I$, apoly Lemma #ref(label("Lemma for idempotent lifting"), supplement: none) to $M_n \( R \) \, M_n \( I \)$ shows $P$ comes from a finitely generated $R$-module \
Injectivity: Suppose $e \, e'$ are idempotents in $M_n \( R \)$ which map to conjugate idempotents in $M_n \( R \/ I \)$. Replacing $e'$ by a conjugate, can assume $e = e' #h(0em) mod med I$\(Note: if $dot(e)$ is conjugate to $dot(e)'$ under $dot(u) in "GL"_n \( R \/ I \)$, we can't necessairly lift $u$ to an invertible matrix in $M_n \( R \)$). But you can lift $mat(delim: "[", dot(u); #none, dot(u)^(- 1)) in "GL"_(2 n) \( R \/ I \)$ to something invertible element in $"GL"_2 \( R \)$. So at the expense of increasing $n$, you can achieve $e - e' in M_n \( I \)$. Then use the Lemma to show $e \, e'$ conjugate in $M_n \( R \)$

]
== The $K_0$ exact sequence and Exision for $K_0$
<the-k_0-exact-sequence-and-exision-for-k_0>
We now want to show that $K_0$ behaves like the begining of a “homology theory\" for rings. Axioms for homology of spaces:

+ Long exact sequences

+ Functoriality

+ Homotopy invariance

+ Normalization

+ \(depends on what homology theory you use) behavior under limits

+ Excision

It turns out that $K_0$ satisfies all of these (in a suitable sense) except for homotopy invariance, even that one doesn't fail by much. Now we want to explain these. Some (normalization, behavior under limits) are fairly easy. Usual homology is normalized by requiring $H_0 \( upright("point") \) = bb(Z)$, $H_j \( upright("point") \) = 0$ for $j eq.not 0$. We will eventually have a whole sequence $K_j$ of functors from rings to abelian groups and the second part of this (the values of $K_j \( bb(Z) \)$, $j eq.not 0$, $bb(Z)$ being the “simplest\" ring(Since all rings come with a canonical ring map $bb(Z) arrow.r R$)) will fail. In fact, the $K_j \( bb(Z) \)$ for $j > 1$ are quite difficult to compute and tied up with a lot of deep number theory. But $K_0 \( bb(Z) \)$ is as we expect, in fact we have

#statement("Proposition")[
If $R$ is a PID, then $K_0 \( R \) tilde.equiv bb(Z)$, the isomorphism being the rank

]
#proof(title: [Proof])[
Any finitely generated torsion-free module over $R$ (and certainly any finitely generated projective module) is free and characterized by its rank.

]
#strong[Functoriality] is clear. If $phi : R arrow.r S$ is a ring homomorphism sending 1 to 1, then we have an induced map $phi_(*) : K_0 \( R \) arrow.r K_0 \( S \)$, and in this way $K_0$ is a functor from rings to abelian groups. The point here is that if $P$ is a finitely generated projective $R$-module, say $P xor Q tilde.equiv R^n$, then $\( S times.o_phi P \) xor \( S times.o_phi Q \) tilde.equiv S times.o_phi R^n = S^n$, so $phi_(*) \( P \) = S times.o_phi P$ is finitely generated projective, and we get functoriality from associativity of the tensor product. In fact we even have functoriality under #strong[non-unital] ring homomorphisms. Suppose $phi : R arrow.r S$ is a non-unital ring homomorphism. Then $phi \( 1_R \) = e$ is an idempotent in $S$, and $phi$ sends the free $R$-module to the projective (not necessarily free) $S$-module defined by $e$. Similarly, if $P$ is a direct summand in $R^n$, then $S times.o_phi P$ is a direct summand in $\( S e \)^n subset.eq S^n$, so again $phi_(*) \( P \)$ is finitely generated projective.

Let $R$ be a aring with dieal $I$. Define a new ring (#strong[double]) $D = { \( x \, y \) in R times R \, x - y in I }$. Projection $p_1$ onto the first coordinate gives a split surjection of rings #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $D$),
node((1, 0), $R$),
edge((0, 0), (1, 0), "->", $p_1$, label-side: right),
edge((1, 0), (0, 0), "->", $Delta$, bend: 18deg, label-side: right),
), where $Delta \( x \) = \( x \, x \)$. So as $R$-modules, $D tilde.equiv R xor I$. Define #strong[relative $K_0$] by $K_0 \( R \, I \) = ker \( K_0 \( D \) arrow.r^(\( p_1 \)_(*)) K_0 \( R \) \)$.

#statement("Theorem")[
There is an exact sequence #math.equation(block: true, numbering: none, $"GL" \( R \) arrow.r "GL" \( R \/ I \) arrow.r^partial K_0 \( R \, I \) arrow.r^(\( p_2 \)_(*)) K_0 \( R \) arrow.r K_0 \( R \/ I \)$)

]
“Excision\": $phi.alt : R arrow.r S$, $I tilde.equiv phi.alt \( I \)$, then $phi.alt_(*) : K_0 \( R \, I \) arrow.r K_0 \( S \, phi.alt \( I \) \)$ is an iso We can define $K_0 \( I \)$ to be $K_0 \( R \, I \)$ for any ring $R$ containing $I$ as an ideal. $R$ could be $I_(+) = I xor bb(Z)$ with $\( i \, n \) dot.op \( j \, m \) = \( i j + n j + m i \, n m \)$

#proof(title: [Proof])[

]
What about #strong[homotopy invariance]?

The analogue of the homotopy invariance in algebra would be invariance under taking polynomials (This is called $bb(A)^1$ homotopy invariance in algebraic geometry, since $bb(A)_k^1 = "Spec" k \[ t \]$ is the algebraic geometry analogue of $\[ 0 \, 1 \]$, and homotopy invariance says multipliying with $\[ 0 \, 1 \]$ doesn't change anything). What happens is that if $R$ is a ring, we get a split injection #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $K_0 \( R \)$),
node((1, 0), $K_0 \( R \[ t \] \)$),
edge((0, 0), (1, 0), "->"),
edge((1, 0), (0, 0), "->", $t mapsto 0$, bend: 18deg, label-side: right),
). In general, this is not an isomorphism, and $K_0 \( R \[ t \] \) tilde.equiv K_0 \( R \) xor N K_0 \( R \)$. However, if $R$ is nice enough (e.g. $"Spec" R$ a smooth scheme), then $N K_0 \( R \) = 0$

= Traces and Dimensions
<traces-and-dimensions>
While we've defined $K_0 \( R \)$ as an abstract group, sometimes one would like #strong[numerical invariants] that enable one to detect or even identify elements of this group. For example, if one has two vector bundles over a space (or ringed space like $"Spec" R$), are there numerical invariants that enable one to determine when they are stably isomorphic? Here are some examples:

+ $R$ is a PID, $"rank" : K_0 \( R \) arrow.r^tilde.equiv bb(Z)$

+ \(much less trivial) $R = C^(bb(C)) \( S^2 \)$, $K_0 \( R \) arrow.r_(\( "rank" \, w_2 \))^tilde.equiv bb(Z) xor bb(Z)$, or as a ring $bb(Z) \[ t \] \/ \( t^2 \)$

+ \(still less trivial) $R = C^(bb(R)) \( S^2 \)$, $K_0 \( R \) arrow.r_(\( "rank" \, w_2 \))^tilde.equiv bb(Z) xor bb(Z) \/ 2$, or as a ring $bb(Z) \[ t \] \/ \( 2 t \, t^2 \)$

+ $R$ is a Boolean ring, so $"Spec" R$ is totally disconnected, $K_0 \( R \) arrow.r^tilde.equiv C \( "Spec" R \, bb(Z) \)$

Let's start with a more general notion of dimension that will encompass (4).

#statement("Definition")[
Let $R$ be a commutative ring, $H_0 \( R \) = C \( "Spec" R \, bb(Z) \)$. This is a free abelian group.

]
#statement("Proposition")[
Let $R$ be a commutative ring, then the #strong[rank] or #strong[dimension] function $K_0 \( R \) arrow.r H_0 \( R \)$ is split surjective. The kernel of the map is called #strong[reduced K-theory], $tilde(K)_0 \( R \)$. If $R$ is an integral domain, or if $R$ has no non-trivial idempotents (this is automatic if $R_(upright("red")) = R \/ "nilrad" \( R \)$) is an integral domain, then $H_0 \( R \) = bb(Z)$

]
#statement("Example", title: [Topological reduced K-theory])[
Let $X$ be a connected compact Hausdorff space, $bb(F) = bb(R)$ or $bb(C)$, $R = C^(bb(F)) \( X \)$. Then $H_0 \( R \) = bb(Z)$ since $R$ has no non-trivial idempotents (even though it's very far from being an integral domain).

]
In this case, recall that isomorphism classes of rank $k$ vector bundles over $X$ are classified by $\[ X \, B U \( k \) \]$ or $\[ X \, B O \( k \) \]$, homotopy classes of maps from $X$ to the infinite Grassmannian $lim_arrow.r "Gr"_(bb(F)) \( k \, n \)$. In this case, $tilde(K)_0 \( R \)$, written also $t i l d e K_(bb(F)) \( X \)$, is the group of stable isomorphism classes of virtual vector bundles of (virtual) rank 0. Since every such class can be written as $\[ E \] - \[ 1_k \]$, where $E$ is a rank $k$ bundle and $1_k$ is the trivial rank $k$ bundle, we see that $tilde(K)_(bb(C)) \( X \) = \[ X \, B U \( k \) \]$ and $tilde(K)_(bb(R)) \( X \) = \[ X \, B O \( k \) \]$

Aside from looking just at “rank\", sometimes we can get more subtle information from “trace\". For any ring $R$ (not necessarily commutative - the noncommutative case is much more interesting), define the #strong[Hattori-Stallings trace map] as follows. Let $\[ R \, R \]$ be the additive subgroup of $R$ generated by commutators $r s - s r$. The trace of a matrix defines an isomorphism $M_n \( R \) \/ \[ M_n \( R \) \, M_n \( R \) \] arrow.r^tilde.equiv R \/ \[ R \, R \]$. Note that these are just additive groups, the multiplicative structure has been lost. Now one gets #math.equation(block: true, numbering: none, $"tr" : K_0 \( R \) arrow.r R \/ \[ R \, R \]$) by sending $\[ R^n e \]$ ($e$ an idempotent in $M_n \( R \)$), to $"tr" \( e \)$ modulo commutators

#statement("Proposition")[

]
= Lambda rings and Adams operations
<lambda-rings-and-adams-operations>
Another piece of structure on $K_0 \( R \)$ when $R$ is a commutative ring comes from the operation $E mapsto and.big^j \( E \)$ on vector bundles. When $j = "rank" E$, this is what we previously called the #strong[determinant]

#statement("Definition")[
$A$ is a #strong[$lambda$-ring]\(for Grothendieck, a #strong[pre-$lambda$-ring]) if there are maps $lambda^j : A arrow.r A$, $j gt.eq 0$, satisfying

+ $lambda^0 \( x \) = 1$

+ $lambda^1 \( x \) = x$

+ $lambda^k \( x + y \) = sum_(i + j = k) lambda^i \( x \) lambda^j \( y \)$

]
#statement("Example")[
$A = bb(Z)$, $lambda^j \( n \) = binom(n, j)$. It follows from the identities #math.equation(block: true, numbering: none, $(sum_(j = 0)^oo binom(n, j) t^j) (sum_(k = 0)^oo binom(m, k) t^k) = \( t + 1 \)^(n + m) = sum_(j = 0)^oo binom(m + n, j) t^j$)

]
#statement("Example")[
$R$ is a commutative ring, $A = K_0 \( R \)$ which is the group completion of $"Proj" \( R \)$ (the semiring of isomorphism classes of finitely generated projective $R$-modules), define $lambda^j \[ P \] = \[ and^j \( P \) \]$. Note $lambda^0 \[ P \] = \[ and.big^0 P \] = \[ R \]$, $lambda^1 \[ P \] = \[ and.big^1 P \] = \[ P \]$, and $lambda^k \[ P xor Q \] = sum_(i + j = n) lambda^i \[ P \] lambda^j \[ Q \]$ follows from the decomposition $and.big^k \( P xor Q \) = xor_(i + j = n) and.big^i \( P \) and.big^j \( Q \)$. These operations extend to the group completion $A$ because $\[ P \] mapsto sum_j lambda^j \[ P \] t^j$ is a monoid homomorphism from $"Proj" \( R \)$ to $A \[ \[ t \] \]$, since #math.equation(block: true, numbering: none, $(sum_(j = 0)^oo lambda^j \[ P \] t^j) (sum_(k = 0)^oo lambda^k \[ P \] t^k) = sum_(n = 0)^oo sum_(i + j = n) lambda^i \[ P \] lambda^j \[ Q \] t^n = sum_(n = 0)^oo lambda^n \[ P xor Q \] t^n$)

]
#statement("Definition")[
$I$ is #strong[$lambda$-ideal] if $lambda^j \( I \) subset.eq I$ for all $j gt.eq 1$. (Recall $lambda^0 : A arrow.r { 1 }$, so we can't expect this for $j = 0$). A #strong[binomial ring] is a commutative ring $A$ contained in a $bb(Q)$-algebra $A_(bb(Q))$ with property that if $k gt.eq 1$, $x in A$, then $binom(x, k)$ lies in $A$ and not just in $A_(bb(Q))$. Example $A = bb(Z)$

]
#statement("Definition")[
$A$ be a $lambda$-ring. We say it has a #strong[positive structure] if

+ there is a $lambda$-subring $H^0$ which is a binomial ring

+ there is a surjective $lambda$ ring homomorphism $epsilon.alt : A arrow.r H^0$ which is identity on $H^0$, called augmentation

+ there is a $lambda$-subsemiring $P$ of $A$ containing $bb(N)$, such that every element in $tilde(A) = ker epsilon.alt$ can be written as $p - q$ for $p \, q in P$

+ if $p in P$, then $epsilon.alt \( P \) in bb(N)$, and $lambda^i \( p \) = 0$ for $i > epsilon.alt \( P \)$, furthermore, $lambda^(epsilon.alt \( P \)) \( P \)$ (the “determinant\" of $p$) is a unit in $A$

]
When we have prositive structure, the #strong[line elements] (analogues of line bundles) of $A$ are elements $ell in P$ with $epsilon.alt \( ell \) = 1$. These are a subgroup of $A^times$. Let $L$ be the set of line elements

#statement("Example")[
If $R$ is a commutative ring, $A = K_0 \( R \)$ is a $lambda$-ring with a positive structure, where $P = "Proj" \( R \)$, $H^0 \( R \) = \[ "Spec" R arrow.r Z \]$, $epsilon.alt$ is the dimension function, $L = "Pic" \( R \)$

]
#statement("Example")[
$G$ is a finite group, $A = R \( G \)$ is a $lambda$-ring with positive structure. $P$ is the isomorphism classes of finite dimensional representations of $G$ (This is a semiring with cancellation with respect to addition, and $P$ generates $R \( G \)$). $lambda^j \( pi \) = and^j \( pi \)$, $epsilon.alt$ is the dimension function(by evaluating the character at 1). The group of line elements consists of 1-dimensional representations, i.e. homomorphisms $G arrow.r bb(T)$, so it can be identified with the Pontryagin dual group to $G_(a b)$

]
== Splitting principle
<splitting-principle>
#statement("Definition")[
Let $A$ be a $lambda$-ring with positive structure $\( P \, epsilon.alt \)$. We say that $A$ #strong[satisfies the splitting principle] if given $p in P$, there is an injection $\( A \, P \) arrow.r.hook \( tilde(A) \, tilde(P) \)$ of $lambda$-rings such that $p$ is a sum of line elements in $tilde(P)$

]
#statement("Example", title: [Topological splitting principle, Karoubi's book on topological K theory])[
$X$ is a compact Hausdorff space, $A = K_(bb(F)) \( X \)$, $P$ is the set of vector bundles. This satisfies the splitting principle since if $E arrow.r^p X$ is a vector bundle, $Y$ is the associated flag variety bundle over $X$ (i.e. $Y arrow.r X$ is a fiber bundle with $Y_x$ = flag variety of $E_x$). Then $K \( X \) arrow.r.hook K \( Y \)$ and the pullback of $E$ to $Y$ splits as a direct sum of line bundles

]
In the topological setting, the advantage of the splitting principle is that it made it easy to define Chern classes. In the $lambda$-ring setting, it gives us a formula for $lambda^j$ using the fact that for $ell_1 \, dots.h.c \, ell_n$ line elements, $lambda^j \( ell_1 + dots.h.c + ell_n \) = sum_(k_1 < dots.h.c < k_j) ell_(k_1) dots.h.c ell_(k_j)$

#statement("Example", title: [Splitting principle for $R \( G \)$, $G$ is a finite group])[
Any element of $R \( G \)$ is determined by its character. To determine the character, it's enough to compute all restrictions $R \( G \) arrow.r R \( H \)$ where $H$ is a cyclic subgroup of $G$. In $R \( H \)$, every representation is a direct sum of 1-dimensional representations

]
== Preview of Adams operations
<preview-of-adams-operations>
Out of the $lambda$-operations, Adams constructed the #strong[Adams operations] $psi^j$ on topological K-theory, and these enable you to recover a good notion of dimension. He used these for his famous “vector fields on spheres\" calculation, to compute the maximal number of linear independent sections on a generic vector bundle over a sphere, and on the tangent bundle $T S^n$

#statement("Theorem")[
Let $A$ be a $lambda$-ring with augmentation $epsilon.alt$. (We assume $H^0 subset.eq A$ is a binomial ring, e.g. $bb(Z)$, $epsilon.alt : A arrow.r H^0$ is a $lambda$-ring homomorphism which is the identity on $H^0$, and we have a generating subsemiring $P subset.eq A$ of #strong[positive elements] such that $epsilon.alt : P arrow.r bb(N)$ and $lambda^j \( p \) = 0$ for $j > epsilon.alt \( p \)$ if $p in P$. Also, every element of $tilde(A) = ker epsilon.alt$ is a difference of two elements of $P$ with the same $epsilon.alt$-value and $lambda^(epsilon.alt \( p \)) p$ is a unit for $p in P$. Then there are unique #strong[Adams operations] $psi^k : A arrow.r A$, $k in bb(N)$, with the following properties:

+ $psi^0 = epsilon.alt$

+ $psi^1 = "id"$

+ $psi^k \( ell \) = ell^k$ for $ell$ a line element

+ $psi^k \( x \) =$ coefficient of $t^k$ in the formal power series $epsilon.alt \( x \) - t frac(d, d t) log lambda_(- t) \( x \)$, where $lambda_t \( x \) = sum_k lambda^k \( x \) t^k$ and of course $lambda_(- t) \( x \) = sum_k \( - 1 \)^k lambda^k \( x \) t^k$

]
#proof(title: [Proof])[

]
#statement("Proposition")[
If the $lambda$-ring $A$ satisfies the splitting principle, then each $psi^k$ is a ring homomorphism and $psi^l psi^k = psi^(l + k)$

]
#proof(title: [Proof])[

]
#statement("Proposition")[
Assume the hypotheses of the previous proposition, and also that $tilde(A) = ker \( epsilon.alt : A arrow.r H^0 \)$ is a nilpotent ideal. (This is the case if $A = K_0 \( X \)$ for $X$ a finite CW complex, or if $A = K_0 \( R \)$ for $R$ an algebra of finite type over a field. So the hypothesis covers many examples of interest.) Then the eigenvalues of $psi^k$ on $A times.o bb(Q)$ are powers of $k$

]
#proof(title: [Proof])[
So get a finite filtration of $A_(bb(Q))$ with $psi^k = k^n$ on $n$-th graded piece, this proves the result

]
Lambda operations and Adams operations play a big role in K-theory. In particular, $psi^p$ for $p$ prime behaves very much like the Frobenius automorphism in Galois theory since $psi^p$ is a ring homomorphism with $psi^p \( l \) = ell^p$ for line element $ell$

= $K_0$ in more general contexts
<k_0-in-more-general-contexts>
Aside from $K_0$ of rings, (using projective modules), we will want to study things like $K_0$ of algebraic vector bundles, which don't always split as direct sums. For this, we want to introduce K-theory not just of rings but of suitable categories, “like\" categories of vector bundles. What does “like\" mean? There are several possible answers, depending on the level of abstraction you are willing to tolerate

+ Symmetric monoidal categories(Weibel II.5)

+ Abelian categories(Weibel II.6)

+ Exact categories(Weibel II.7)

+ Waldhausen categories(Weibel II.9)

We will concentrate on Abelian and exact categories, which cover most of the applications you need, at least at first.

#strong[Symmetric monoidal categories] are categories $cal(S)$ with $square.stroked.tiny : cal(S) times cal(S) arrow.r cal(S)$, a distringuished object $e$, and natural equivalences $e square.stroked.tiny s tilde.equiv s square.stroked.tiny e tilde.equiv s$, $\( s square.stroked.tiny t \) square.stroked.tiny u tilde.equiv s square.stroked.tiny \( t square.stroked.tiny u \)$, $s square.stroked.tiny t tilde.equiv t square.stroked.tiny s$. There are some compatibility axioms

#statement("Example")[
$R$ is a ring, $S$ is the category of finitely generated projective $R$-modules, and $square.stroked.tiny = xor$

]
From a symmetric monoidal category, one can construct a $K_0$ group. This covers K-theory of rings but also other examples

== $K_0$ of abelian categories and G-theory (Weibel II.6)
<k_0-of-abelian-categories-and-g-theory-weibel-ii.6>
Recall that an #strong[additive category] $cal(C)$ is a category in which $"Hom"$ sets are abelian groups, composition is bilinear, and there is a distinguished initial and termial object 0 with $"Hom" \( 0 \, A \) = "Hom" \( A \, 0 \) = 0$ for all $A in o b cal(C)$. In addition, we require finite products and coproducts, which coincide and are denoted $xor$ (There may or may not be inifinite products and coproducts, when these exists, they are usually not the same and we denote products by $product$)

An #strong[abelian category] is a bit stronger, it's an additive category $cal(C)$ in which #strong[every morphism has a kernel and a cokernel], every monic is a kernel, and every eop is a cokernel. These axioms insure that exact sequence exist and have the usual properties. The #strong[standard example] of an abelian category is the category of left (or) right $R$-modules. This example is also universal

#statement("Theorem", title: [Freyd and Mitchell])[
Every abelian category embeds in a category of modules over a ring

]
== $K_0$ of abelian category
<k_0-of-abelian-category>
$cal(C)$ is a skeletally small abelian category, we define $K_0 \( cal(C) \)$ be the universal abelian group on the objects (in the skeleton) of $cal(C)$, subject to the axioms: $\[ A' \] + \[ A'' \] = \[ A \]$ if $0 arrow.r A' arrow.r A arrow.r A'' arrow.r 0$ is exact ($\[ 0 \] = 0$ follows). Note that if $A' arrow.r A$ is an isomorphism, then $\[ A \] = \[ A' \]$

If $cal(C)$ and $cal(C)'$ are abelian categories and $F : cal(C) arrow.r cal(C)'$ is an #strong[exact functor], then $F$ induces a homomorphism $F_(*) : K_0 \( cal(C) \) arrow.r K_0 \( cal(C)' \)$

#statement("Example", title: [#strong[Main example]])[
$R$ is a right Noetherian ring, and $cal(C)$ is the category of finitely generated right $R$-modules. This is an abelian category, since a submodule or quotient of a finitely generated module is finitely generated. Define $G_0 \( R \)$ (also writen as $K'_0 \( R \)$) to be $K_0 \( cal(C) \)$

]
== The Cartan map
<the-cartan-map>
The #strong[Cartan homomorphism] is the natural map $K_0 \( R \) arrow.r G_0 \( R \)$ sending $\[ P \] in K_0 \( R \)$, $P$ a finitely generated projective $R$-module, to the class of $P$ in $G_0 \( R \)$

#statement("Proposition")[
If $R$ is a PID, then the Cartan map $bb(Z) tilde.equiv K_0 \( R \) arrow.r G_0 \( R \)$ is an isomorphism

]
#proof(title: [Proof])[
$M$ is a finitely generated $R$-module, $0 arrow.r F' arrow.r F arrow.r M arrow.r 0$ is a presentation with $F \, F'$ free, then $\[ M \] = \[ F \] - \[ F' \]$ lies in the image of the Cartan map. So $G_0 \( R \)$ is a quotient of $K_0 \( R \)$ under the Cartan map. But the map is injective since $\[ M \] mapsto "rank" M = dim_F F times.o_R M$, $F = "Frac" \( R \)$, gives a splitting $G_0 \( R \) arrow.r K_0 \( R \)$

]
== Functoriality of $G_0$
<functoriality-of-g_0>
$f : R arrow.r S$ is a ring homomorphism of right Noetherian rings

+ If $S$ is flat over $R$, then $f_(*) = - times.o_R S : G_0 \( R \) arrow.r G_0 \( S \)$ is exact. Flatness is very restrictive, so we will weaken this later to the assumtion that $S$ has a finite resolution by finitely generated projective $R$-modules, which is often the case in examples of interest.

+ If $S$ is a finitely generated $R$-module, then we get a transfer homomorphism $f^(*) : G_0 \( S \) arrow.r G_0 \( R \)$ by thinking of finitely generated $S$-modules as finitely generated $R$-modules

$K_0$ has more functoriality but harder to compute, $G_0$ has less but easier to compute

== Examples from algebraic geometry
<examples-from-algebraic-geometry>
Lots of interesting examples of this machinery come from algebraic geometry. If $\( X \, cal(O)_X \)$ is a Noetherian scheme, then the coherent sheaves $cal(F)$ over $X$ form an abelian category $"Coh" \( X \)$. (Recall that an $cal(O)_X$-module is coherent if locally there is an exact sequence $cal(O)^m arrow.r cal(O)^n arrow.r cal(F)$ for some finite $m \, n$). Then $K_0 \( "Coh" \( X \) \)$ is denoted $G_0 \( X \)$. It behaves like a #strong[homology] theory for schemes, whereas $K_0 \( X \)$ behaves like a #strong[cohomology] theory. The Cartan map $K_0 \( X \) arrow.r G_0 \( X \)$ is thus related to #strong[Poincare duality].

If $X = "Spec" R$, $R$ Noetherian commutative ring, then $"Coh" \( X \)$ is just the category of finitely generated $R$-modules, and we get back $G_0 \( R \)$

#statement("Example")[
$R = bb(Z) \, S = bb(Z) \/ p^n$, then $S$ is finitely generated as an $R$-module, but the map $R arrow.r S$ is definitely not flat, we know that $bb(Z) tilde.equiv K_0 \( R \) arrow.r G_0 \( R \)$ is an isomorphism since $R$ is a PID, we also know that the map $bb(Z) \/ p^n arrow.r bb(Z) \/ p$ induces an iso on $K_0$, since the kernel is nilpotent. Since $S$ is Artinian, every finitely generated $S$-module has finite length and has a composition series with subquotients all isomorphic to the unique simple $S$-module $bb(Z) \/ p$. $G_0 \( bb(Z) \/ p \) tilde.equiv bb(Z)$ with generator $\[ bb(Z) \/ p \]$. The Cartan map $K_0 \( S \) arrow.r G_0 \( S \)$ sends $\[ bb(Z) \/ p^n \]$ to $\[ bb(Z) \/ p^n \]$, which has length $n$ and is thus equal to $n$ times the generator $\[ bb(Z) \/ p \]$. So if $n > 1$, the Cartan map for $S$ is not an isomorphism.

]
== Dévissage
<dévissage>
\(French word, from déviser, to divide) Motto: Divide and conquer

#statement("Theorem", title: [Theorem II6.3 in Weibel, generalize the previous example])[
Let $cal(B) subset.eq cal(A)$ be small abelian categories. Assume

+ $cal(B)$ is a full subcategory, and all quotients and subobjects (in $cal(A)$) in $cal(B)$ stay in $cal(B)$

+ Every object $A$ in $cal(A)$ has a finite filtration $0 subset.eq A_1 subset.eq A_2 subset.eq dots.h.c subset.eq A_n = A$ with all subquotients $A_(j + 1) \/ A_j$ lying in $cal(B)$

Then the inclusion $cal(B) arrow.r.hook cal(A)$ is an exact functor and induces an isomorphism $K_0 \( cal(B) \) arrow.r K_0 \( cal(A) \)$

]
#proof(title: [Proof])[
The first statement follows immediately from the assumptions. Surjectivity follows from b). since $\[ A \] = \[ A_1 \] + \[ A_2 \/ A_1 \] + dots.h.c + \[ A_n \/ A_(n - 1) \]$ in $K_0 \( cal(A) \)$. For injectivity, construct $K_0 \( cal(A) \) arrow.r K_0 \( cal(B) \)$ similarly

]
#statement("Proposition")[
$X$ is a Noetherian scheme, $X_(upright("red"))$ is the associated reduced scheme, then $X_(upright("red")) arrow.r X$ induces an isomorphism on $G_0$. If $X = "Spec" R$, $X_(upright("red")) = "Spec" \( R \/ "nil" R \)$, the transfer map $G_0 \( R \/ "nil" R \) arrow.r G_0 \( R \)$ is an isomorphism

]
#proof(title: [Proof])[
Let $cal(A)$ be the category of coherent $cal(O)_X$-modules, $cal(B)$ the subcategory of those that factor through an $cal(O)_(X_(upright("red")))$-module. Then $G_0 \( X_(upright("red")) \) = K_0 \( cal(B) \)$ and $G_0 \( X \) = K_0 \( cal(A) \)$. Every object in $cal(A)$ has as finite filtration with subquotients in $cal(B)$, so we can apply Devissage to conclude that $K_0 \( cal(B) \) arrow.r K_0 \( cal(A) \)$ is an isomorphism

]
#statement("Proposition", title: [analogue of excision for $G_0$ of schemes])[
$X$ Noetherian scheme, $Z$ closed subscheme, $i$ inclusion, $cal(A)$ is the category of coherent $cal(O)_X$-modules supported on $Z$, $cal(B) = "Coh" \( Z \)$, $cal(I)$ is the ideal sheaf such that $cal(O)_X \/ cal(I) = cal(O)_Z$, identify $cal(B)$ with subcategory of $cal(A)$ annihilated by $cal(I)$, then $cal(B) arrow.r cal(A)$ induces an isomorphism on $K_0$

]
#proof(title: [Proof])[
An object $cal(F)$ in $cal(A)$ has a finite filtration $cal(F) supset I cal(F) supset I^2 F supset dots.h.c$ with subquotients in $cal(B)$

]
== Localization
<localization>
Let $cal(A)$ be a small ableian category, $cal(B)$ a #strong[Serre subcategory], i.e. a subcategory closed under subobjects, quotients and extensions. Define the #strong[quotient category] $cal(A) \/ cal(B)$ as follows. The objects are the same as objects of $cal(A)$, A morphism $A_1 arrow.r A_2$ is an equivalence of classes of diagrams

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((1, 0), $A'$),
node((0, 1), $A_1$),
node((2, 1), $A_2$),
edge((1, 0), (0, 1), "->", $f$, label-side: right),
edge((1, 0), (2, 1), "->", $g$),
)
]
with $f$ an isomorphism mod $cal(B)$ (i.e. $ker f \, "coker" f$ lie in $cal(B)$). Two such diagrams are equivalent if one has a commutative diagram

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((1, 0), $A'$),
node((0, 1), $A_1$),
node((1, 1), $A$),
node((2, 1), $A_2$),
node((1, 2), $A''$),
edge((1, 0), (0, 1), "->", $f$, label-side: right),
edge((1, 0), (2, 1), "->", $g$),
edge((1, 1), (1, 0), "->"),
edge((1, 1), (1, 2), "->"),
edge((1, 1), (0, 1), "->"),
edge((1, 1), (2, 1), "->"),
edge((1, 2), (0, 1), "->", $k$),
edge((1, 2), (2, 1), "->", $h$, label-side: right),
)
]
With $A' arrow.l A arrow.r A''$ isomorphisms mod $cal(B)$

This construction is universal so that there is an exact #strong[quotient functor] $q : cal(A) arrow.r cal(A) \/ cal(B)$, and if $T : cal(A) arrow.r cal(C)$ is an exact functor, $T \( cal(B) \) = 0$, then $T$ factors uniquely through $q : cal(A) arrow.r cal(A) \/ cal(B)$

#statement("Example")[
$cal(A)$ is the category of finitely generated abelian groups chosen in small skeleton, $cal(B)$ is the category of $p$-primary torsion groups

]
#statement("Theorem", title: [Localization theorem])[
$cal(A)$ small abelian category, $cal(B)$ Serre subcategory, i.e. a subcategory closed under subobjects, quotients and extensions. Then the sequence $K_0 \( cal(B) \) arrow.r^(i_(*)) K_0 \( cal(A) \) arrow.r^(q_(*)) K_0 \( cal(A) \/ cal(B) \) arrow.r 0$ is exact

]
#proof(title: [Proof])[
$q_(*) : K_0 \( cal(A) \) arrow.r K_0 \( cal(A) \/ cal(B) \)$ is surjective, and the composite $K_0 \( cal(B) \) arrow.r K_0 \( cal(A) \) arrow.r K_0 \( cal(A) \/ cal(B) \)$ is 0 in $K_0 \( cal(A) \/ cal(B) \)$, since we have an isomorphism between $cal(B)$ and 0 in $cal(A) \/ cal(B)$ given by showing that $B arrow.r^0 B$ and $B arrow.r^("id") B$ are equivalent

Suppose $\[ A_1 \] = \[ A_2 \] in K_0 \( cal(A) \)$ goes to 0 in $K_0 \( cal(A) \/ cal(B) \)$, thus $\[ A_1 \] tilde.equiv \[ A_2 \]$ in $K_0 \( cal(A) \/ cal(B) \)$, we want to show $\[ A_1 \] - \[ A_2 \] = \[ B_1 \] - \[ B_2 \]$ with $B_j$ in $cal(B)$. Suppose you have $f : A_1 arrow.r A_2$ with kernel, cokernel in $cal(B)$, so we have an exact sequence $0 arrow.r B_1 arrow.r A_1 arrow.r^f A_2 arrow.r B_2 arrow.r 0$

]
#statement("Corollary")[
$R$ is a Dedekind domain with field of fractions $F$. The the localization sequence $xor.big_(0 eq.not frak(p) upright(" prime")) K_0 \( R \/ frak(p) \) arrow.r K_0 \( R \) arrow.r K_0 \( F \) arrow.r 0$ is exact

]
#proof(title: [Proof])[
$cal(A)$ is the category of finitely generated $R$-modules. By resolution theorem which we will prove later, the Cartan map $K_0 \( R \) arrow.r G_0 \( R \) = K_0 \( cal(A) \)$ is an isomorphism. Let $cal(B)$ the subcategory of finitely generated torsion modules, and $M$ in $cal(B)$ has a primary decomposition $M = xor.big_(frak(p)) M \[ frak(p) \]$, $M \[ frak(p) \]$ is the $frak(p)$-torsion part. For fixed $frak(p)$, $K_0 \( R \/ frak(p) \) arrow.r G_0 \( R \/ frak(p) \)$ is an isomorphism (since $R \/ frak(p)$ is a field), then Devissage.

]
#statement("Proposition")[
$R$ commutative Noetherian ring, $frak(p)$ is a prime ideal, then we get an exact sequence $G_0 \( R \/ frak(p) \) arrow.r G_0 \( R \) arrow.r G_0 \( R_(frak(p)) \) arrow.r 0$

]
#proof(title: [Proof])[
Let $cal(A)$ be a suitable small skeleton of the category of finitely generated $R$-modules. Let $cal(B)$ be the Serre subcategory of $p$-primary torsion $R$-modules. Then $K_0 \( cal(A) \) = G_0 \( R \)$ by definition, $K_0 \( cal(B) \) = G_0 \( R \/ frak(p) \)$ by Devissage. We claim $G_0 \( R_(frak(p)) \) = K_0 \( cal(A) \/ cal(B) \)$. This is because elements of $cal(A) \/ cal(B)$ are really $R$-modules in which maps of modules with cokernel and kernel in $cal(B)$ are declared to be isomorphisms. This effectively means that we are inverting everything not in $frak(p)$

]
== $bb(A)^1$-homotopy invariance
<mathbb-a1-homotopy-invariance>
If $R$ is a Noetherian ring, $G_0 \( R \) tilde.equiv G_0 \( R \[ t \] \)$. Similarly, if $X$ is a Noetherian scheme, $G_0 \( X \) tilde.equiv G_0 \( bb(A)_X^1 \)$\(or if $X$ is a scheme over $"Spec" k$, $G_0 \( X \) = G_0 \( X times A^1 \)$), also $G_0 \( R \[ t \] \) tilde.equiv G_0 \( R \[ t \, t^(- 1) \] \)$, etc.

#proof(title: [Proof])[
We only do the case of rings, the case of schemes is analogous. Let $cal(A)$ be the category of finitely generated $R \[ t \]$-modules, $cal(B)$ the subcategory where $t$ acts nilpotently, by Devissage, $K_0 \( cal(B) \) = G_0 \( R \[ t \] \/ \( t \) \) = G_0 \( R \)$. The quotient cat $cal(A) \/ cal(B)$ is equivalent to the category where $t$ acts by an isomorphism. So we get the exact sequence #math.equation(block: true, numbering: none, $G_0 \( R \) arrow.r^(pi^(*)) G_0 \( R \[ t \] \) arrow.r^(j_(*)) G_0 \( R \[ t \, t^(- 1) \] \) arrow.r 0$) the first map $pi^(*)$ is the dual to the projection $pi : R \[ t \] arrow.r R$, sending $t$ to 0 (it's the transfer map viewing an $R$-module as a n $R \[ t \]$-module with $t$ acting by 0), and the second map $j_(*)$ is induced by the flat inclusion $R \[ t \] arrow.r.hook R \[ t \, t^(- 1) \]$, $pi^(*)$ is 0 since if $M$ is finitely generated $R$-module, we have the exact sequence of $R \[ t \]$-modules #math.equation(block: true, numbering: none, $0 arrow.r M \[ t \] arrow.r^t M \[ t \] arrow.r M arrow.r 0$) giving(in $G_0 \( R \[ t \] \)$), $\[ M \] + \[ M \[ t \] \] = \[ M \[ t \] \]$, i.e. $\[ M \] = 0$, thus $G_0 \( R \[ t \] \) tilde.equiv G_0 \( R \[ t \, t^(- 1) \] \)$

]
To sum up, we've proved the

#statement("Theorem", title: [Fundamental theorem for $G_0$])[
$R$ Noetherian ring, Then $G_0 \( R \) arrow.r_(i_(*))^tilde.equiv G_0 \( R \[ t \] \) arrow.r_(j_(*))^tilde.equiv G_0 \( R \[ t \, t^(- 1) \] \)$. The corresponding statement for $K_0$ is #strong[false], for two reasons

+ $K_0 \( R \[ t \] \)$ can be bigger than $K_0 \( R \)$ if $R$ is not regular. One has $K_0 \( R \[ t \] \) tilde.equiv K_0 \( R \) xor N K_0 \( R \)$

+ When $R$ isn't regular, there is another contribution to $K_0 \( R \[ t \, t^(- 1) \] \)$ called $K_(- 1) \) \( R \)$ (This is in addition to the cokernel $N K_0 \( R \)$ of $K_0 \( R \) arrow.r K_0 \( R \[ t \] \)$), which occurs twice, once because of $K_0 \( R \[ t^(- 1) \] \)$.

]
== Euler characteristics and the resolution theorem
<euler-characteristics-and-the-resolution-theorem>
Now we want to come back to the Cartan map $c : K_0 \( R \) arrow.r G_0 \( R \)$ for $R$ a Noetherian ring.

#statement("Theorem", title: [Resolution theorem])[
$R$ Noetherian ring of #strong[finite projective dimension], i.e., such that any finitely generated $R$-module $M$ has a finite resolution #math.equation(block: true, numbering: none, $0 arrow.r P_n arrow.r P_(n - 1) arrow.r dots.h.c arrow.r P_0 arrow.r M arrow.r 0$) by finitely generated projective $R$-modules (the scheme is smooth and reduced), then the Cartan map $c : K_0 \( R \) arrow.r G_0 \( R \)$ is an isomorphism, and $\[ M \] = c \( \[ P_0 \] - \[ P_1 \] + dots.h.c plus.minus \[ P_n \] \)$. This is related to the #strong[Euler characteristic] of a resolution, which is $\[ P_0 \] - \[ P_1 \] + dots.h.c plus.minus \[ P_n \]$. These Euler characteristics also show up in the #strong[Wall finiteness obstruction], which is a necessary and sufficient for a connected #strong[finitely dominated] CW-complex to be homotopy equivalent to a finite CW-complex

]
#proof(title: [Proof])[

]
#statement("Definition")[
Let $X$ be a CW-complex. We say $X$ is #strong[finitely dominated] if there is a finite CW-complex $Y$ and there are maps #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $X$),
node((1, 0), $Y$),
edge((0, 0), (1, 0), "->", $i$, bend: 18deg, label-side: right),
edge((1, 0), (0, 0), "->", $r$, bend: 18deg, label-side: right),
) such that $r compose i tilde.eq "id"_X$.

]
Obviously if $X$ is a retract $Y$, i.e., we can choose $i$ injective and $r$ so that $r compose i = "id"_X$, then $X$ is finitey dominated.

The interest in this condition is that certain general topology conditions give this for free (see theory of ANR's, absolute neighborhood retracts.)

#strong[Wall's idea]: Suppose $X$ is dominated as above, then you can reduce to the case where $X$ is connected, and $C_(*) \( tilde(X) \)$, the cellular chain complex of $tilde(X)$, sits as a direct summand in $C_(*) \( tilde(Y) \)$, as complexes of $bb(Z) pi_1 \( X \)$-modules. Since $Y$ is finite, $C_(*) \( tilde(Y) \)$ is finite generated free over $bb(Z) pi$. So $C_(*) \( tilde(X) \)$ are a chain complex of finitely generated projective $bb(Z) pi$-modules.

If $X$ is finite up to homotopy, we can choose a model for $X$ (up to homotopy) in which $C_(*) \( tilde(X) \)$ is finitely generated and free.

The #strong[Wall finiteness obstruction] is the alternating sum $sum_(i = 0)^(dim X) \( - 1 \)^i \[ C_i \( tilde(X) \) \]$ in $tilde(K)_0 \( bb(Z) pi \) = K_0 \( bb(Z) pi \) \/ upright("copy of ") bb(Z) upright(" coming from free modules")$

Key idea: Suppose $R$ is a ring, $M$ is an $R$-module with a finite projective resolution, or more generally, any chain complex of f.g. projective $R$-modules. Then the Euler characteristic $sum \( - 1 \)^i \[ P_i \]$ in $K_0 \( R \)$ is in the first case, an invariant of M in the second case, an invariant chain homotopy equivalent to M

#proof(title: [Proof])[
For surjectivity, split up the resolutions to exact sequences, and add up to get the Euler characteristic = \[M\] #math.equation(block: true, numbering: none, $0 arrow.r P_n arrow.r^(alpha_n) arrow.r dots.h.c arrow.r P_0 arrow.r^(alpha_0) arrow.r M arrow.r 0$) For injectivity, want to show $chi$\(M) is independent of the choice of the resolution. Since any two resolutions are chain homotopic, construct the cone of two resolutions $P_bullet = P'_bullet xor P''_bullet$, have short exact sequence $0 arrow.r P' arrow.r P arrow.r P''_(bullet + 1) arrow.r 0$, Euler characteristic is additive, $chi \( P \) = chi \( P' \) - chi \( P'' \)$, but since $P$ is acyclic, so $chi \( P \) = 0$

]
Exact categories An exact cat is a full subcat containint 0 and closed under extensions

#statement("Example")[
A cat of f.g. R module C cat of f.g. proj R module, C is a exact cat in abelian cat A

]
#statement("Definition")[
$cal(C) subset.eq cal(A)$ is a an exact category of a small abelian category $cal(A)$, then we define $K_0 \( cal(C) \)$ to be the free abelian group on objects of $cal(C)$ module relations $\[ P \] = \[ P' \] + \[ P'' \]$. And the Cartan map is $K_0 \( cal(C) \) arrow.r K_0 \( cal(A) \)$

]
#statement("Example")[
$R$ is a left Noetherian ring, $cal(A)$ a small model for f.g. R modules, C=f.g., the usual example

]
#statement("Example")[
$X$ is a Noetherian scheme, $cal(A)$ is the category of coherent $cal(O)_X$-modules, $cal(C)$ is the category of locally free coherent $cal(O)_X$ modules, i.e. the category of algebraic vector bundles over $X$, then $K_0 \( cal(A) \) = G_0 \( X \)$, $cal(K)_0 \( cal(C) \) = K_0 \( X \)$

]
#statement("Example")[
$R$ is a ring(not necessarily Noetherian). Let $cal(A)$ be a small model for the category pseudo-coherent $R$-modules, i.e. ones with resolution by f.g. proj $R$ moduels, whrere the resoluiton dones't have to be finite. If $R$ is Noetherian, every finite generated $R$-module is pseudo-coherent. Then we define $G_0 \( R \) = K_0 \( cal(A) \)$, and we get a Cartan map $K_0 \( R \) arrow.r G_0 \( R \)$. And analogue for non-Noetherian schemes

]
#statement("Example")[
$R$ is a ring, define $"Nil" \( R \)$ to be the category of pairs $\( P \, T \)$ with $P$ a finitely generated(right) $R$-module(in a small model), and $T : P arrow.r P$ is a nilpotent $R$-module endomorphism. Morphisms are commutative diagrams

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $P$),
node((1, 0), $P$),
node((0, 1), $P'$),
node((1, 1), $P'$),
edge((0, 0), (1, 0), "->", $T$),
edge((0, 0), (0, 1), "->", $f$),
edge((1, 0), (1, 1), "->", $f$),
edge((0, 1), (1, 1), "->", $T'$, label-side: right),
)
]
This is an exact subcategory of the larger category of pairs $\( P \, alpha \)$, with $alpha$ not required to be nilpotent If $R$ is right Noetherian, there is a still larger abelian category of f.g. right $R$-modules

]
What is this good for? Recall that $G_0 \( R \[ t \] \) tilde.equiv G_0 \( R \)$ for $R$ Noetherian, and the analogue fails for $K_0$, $K_0 \( "Nil" R \)$ is the missing piece in $K_0 \( R \[ t \] \)$, i.e. $K_0 \( R \[ t \] \) tilde.equiv K_0 \( "Nil" \( R \) \)$. There is an obvius summand $K_0 \( R \)$ inside $K_0 \( "Nil" \( R \) \)$ given by $P mapsto \( P \, 0 \)$ and $\( P \, T \) mapsto P$. Sometimes $K_0 \( "Nil" \( R \) \) tilde.equiv K_0 \( R \)$, sometimes no

Recall there is an exact sequence #math.equation(block: true, numbering: none, $"GL"_(\() R \) arrow.r "GL" \( R \/ I \) arrow.r K_0 \( I \) arrow.r K_0 \( R \) arrow.r K_0 \( R \/ I \)$)

This suggests that $K_1 \( R \)$ should be related to GL(R), but homology groups shooulde be commutative

Guess K\_1(R)$tilde.equiv$$"GL"$\(R)\_ab

#statement("Theorem")[
$R$ is a Euclidean domain, then $K_1 \( R \) tilde.equiv R^times$

]
#proof(title: [Proof])[

]
#statement("Remark")[
The determinant $det : "GL"_n \( R \) arrow.r R^times$ givs split surjection $K_1 \( R \) arrow.r R^times$, the kernel is denoted $S K_1 \( R \)$, $S K_1 \( R \) = 0$ for euclidean domain, but not generally for PID

]
#statement("Theorem", title: [Dieudonné])[
$R$ is a division ring, there is a unique determinant map giving an isomorphism $K_1 \( R \) arrow.r R_(a b)^times$

]
#statement("Example")[
$bb(H)$ is the quaternions, $bb(H)^times tilde.equiv bb(R)_(+)^times times S U \( 2 \)$, since $S U \( 2 \)$ is simple, $K_1 \( bb(H) \) tilde.equiv bb(R)_(+)^times$

]
#proof(title: [Proof])[
There is a unique map such tat $d e t \( E A = d e t \( A \)$ $det$induces an iso $K_1 \( R \) arrow.r R_(a b)^times$, we have split surjection $"GL"_n \( R \)_(a b) arrow.r R_(a b)^times$ with the splitting map induced by inclusion into the first component

]
D division ring center F, dim\_FD=n^2, n is the dim over F of a maximal commutative subfield. say $E$

#statement("Example")[
D=H^2, F=R,E=C, then n=2,dim\_FD=2^2=4,dim\_ED=2

]
#statement("Theorem")[
$N_(r e d)$ is an iso

]
D$arrow.r.hook$M\_n(E) by tensoring with E, $D^times arrow.r.hook "GL"_n \( E \)$, so the det map $G L_n \( E \) arrow.r E^times$ induces $D^times arrow.r E^times$. If $E \/ F$ is Galois, then Gal(E/F), get N\_red:K\_1(D)=D^$times$$arrow.r$F^$times$

#statement("Example")[
D=H^2, F=R,E=C, the reduced norm is a multiplicative map $D^times arrow.r F^times$. On $F^times$, for a$in$F^$times$, a$mapsto$$det$\(a,$dots.h.c$,a)=a^n, sending i,j,k to 1,so N\_red\(z=a+bi+cj+dk)=z|z

]
#proof(title: [Proof])[
Want to show $N_(r e d)$ is an iso mod n. In general, it's neither injective nor surjective, but the kernel and cokernel are $n$-torsion. This map almost split by the inclusion $F^times arrow.r.hook D^times$. So $"coker"$N\_red is a quotient of $F^times \/ \( F^times \)^n$, can similarly check that $ker N_(r e d)$ is n-torsion

]
The Whitehead Group $W h \( G \)$

GL\_1(ZG)=(ZG)^$times$

#statement("Definition")[
Wh(G)=K\_1(ZG)/(Z^$times$$times$G)

]
$K_0 \( R "rel" S \)$ to be K\_0 of the Waldhausen category of bounded complexes of finitely generated projective $R$-modules P\_$bullet$such that S^-1P is exact

#statement("Theorem")[
R=k\[t\], K\_1(R)$tilde.equiv$k\[t\]^$times$$tilde.equiv$k^$times$, S=t,t^2,$dots.h.c$, S^-1R=k\[t,t^-1\] is a PID, K\_0(R rel S) is generated by \[k\[t\]$arrow.r$tk\[t\]\]. The exact sequence becomes

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $K_1 \( R \)$),
node((1, 0), $K_1 \( S^(- 1) R \)$),
node((2, 0), $K_0 \( R r e l S \)$),
node((3, 0), $K_0 \( R \)$),
node((4, 0), $K_0 \( S^(- 1) R \)$),
node((0, 1), $k^times$),
node((1, 1), $k^times times bb(Z)$),
node((2, 1), $bb(Z)$),
node((3, 1), $bb(Z)$),
node((4, 1), $bb(Z)$),
edge((0, 0), (1, 0), "->"),
edge((0, 0), (0, 1), "->"),
edge((1, 0), (2, 0), "->"),
edge((1, 0), (1, 1), "->"),
edge((2, 0), (3, 0), "->"),
edge((2, 0), (2, 1), "->"),
edge((3, 0), (4, 0), "->"),
edge((3, 0), (3, 1), "->"),
edge((4, 0), (4, 1), "->"),
edge((0, 1), (1, 1), "->"),
edge((1, 1), (2, 1), "->"),
edge((2, 1), (3, 1), "->", $0$),
edge((3, 1), (4, 1), "->", $tilde.equiv$),
)
]
]
Fundamental theorem $R$ is a ring, consider $R \[ t \]$, $S = { t \, t^2 \, dots.h.c }$, $S^(- 1) R \[ t \] = R \[ t \, t^(- 1) \]$. We want to relate K-theory of $R$, $R \[ t \]$ and $R \[ t \, t^(- 1) \]$. Let $"Nil" \( R \)$ be the category of pairs $\( P \, T \)$ where $P$ is a finitely generated projective $R$-module, $T in "End" \( P \)$ nilpotent. This is an exact category with maps commutating diagrams

#align(center)[

]
The category of finitely generated projective $R$-modules embeds in $"Nil" \( R \)$ as the pairs $\( P \, 0 \)$. So we have a split injection $K_0 \( R \) arrow.r K_0 \( "Nil" \( R \) \)$. Note that for \"nice\" rings, e.g. regular Noetherian rings, this map is an isomorphism and $K_0 \( "Nil" \( R \) \) tilde.equiv K_0 \( R \)$

Recall the localization theorem gives an exact sequence $K_1 \( R \[ t \] \) arrow.r K_1 \( R \[ t \, t^(- 1) \] \) arrow.r^partial K_0 \( R \[ t \] r e l { t \,^2 \, dots.h.c } \) arrow.r^0 K_0 \( R \[ t \] \) arrow.r.hook K_0 \( R \[ t \, t^(- 1) \] \)$

It will turn out that $K_1 \( R \[ t \] \) tilde.equiv K_1 \( R \) xor "coker" \( K_0 \( R \) arrow.r K_0 \( "Nil" \( R \) \) \) = : K_1 \( R \) xor N K_1 \( R \)$. Similarly, we have $K_0 \( R \[ t \] \) tilde.equiv K_0 \( R \) xor N K_0 \( R \)$. If we had the algebraic analogue of homotopy invariance, $N K_j$ would be 0

#statement("Lemma")[
g$in$GL(R\[t\]) is conjruent ot the identity mod t, then \[g\]=\[1-$nu$t\] in K\_1(R\[t\]) for some nilpotent $nu in M_n \( R \)$\(n maybe large compare to the size of $g$)

]
#proof(title: [Proof])[
Think of $g$ as a poly in t with coef that are matices over R, the constant term being the identity matrix, if the polynomial is of deg 1, then g=1-$nu$t, but g being invertible, $g^(- 1) = 1 + nu t + dots.h.c$ has to terminate, so $nu$is nilpotent. Induction for $deg$g, so assume g=1-$nu$t+$gamma$t^n for some nilpotent $nu$,

#align(center)[
g \
&1 \~ g&$gamma$t^n-1 \
&1 \~1-$nu$t&$gamma$t^n-1 \
\-t1&1 =1 \
&1-t $nu$&$gamma$t^n-2 \
1&0

]

]
#statement("Theorem")[
K\_1(R\[t\])$tilde.equiv$K\_1(R)$xor$NK\_1(R), where $N K_1 R xor K_0 \( R \) tilde.equiv K_0 \( N i l R \)$

]
#proof(title: [Proof])[
Map ker(K\_1(R\[t\]$arrow.r$K\_1(R))) NK\_1(R) to use lemma. For $nu$nilpotent, send to 1-$nu$t$in$$ker$\(K\_1(R\[t\]$arrow.r$K\_1(R)))

]
#statement("Theorem", title: [Fundamental theorem of K-theory])[
$K_1 \( R \[ t \, t^(- 1) \] \) tilde.equiv K_1 \( R \) xor N K_1 \( R \) xor N K_1 \( R \) xor K_0 \( R \)$, ($N K_1 \( R \)$ from $R \[ t \]$ and $R \[ t^(- 1) \]$)

]
#proof(title: [Proof])[
Construct exact seq 0$arrow.r$K\_1(R)$arrow.r$$Delta$K\_1(R\[t\])+K\_1(R\[t^-1\])$arrow.r$\(a,b)$mapsto$a-b K\_1(R\[t,t^-1\])$arrow.r$$partial$K\_0(R)$arrow.r 0$ $partial$is split by the map \[P\]$arrow.r$t \
&1 Localization theorem gives K\_1(R\[t\])$arrow.r$K\_1(R\[t,t^-1\])$arrow.r$$partial$K\_0(R\[t\]rel S)$arrow.r$K\_0(R\[t\])$arrow.r$K\_0(R\[t,t^-1\]) the last map is injective, so we have exact seq K\_1(R\[t\])$arrow.r$K\_1(R\[t,t^-1\])$arrow.r$$partial$K\_0(R\[t\]rel S)$arrow.r 0$

]
#statement("Lemma")[
K\_0(R\[t\]rel S)$tilde.equiv$K\_0($"Nil"$\(R)), which by the last theorem is K\_0(R)$xor$NK\_1(R)

]
#proof(title: [Proof])[
K\_0(R\[t\]rel S) is generated by length one complexes R\[t\]^n$arrow.r$$alpha$R\[t\]^n, wehre $alpha$is iso after inverting t. If $P$ is a f.g. proj R module, Po+Q$tilde.equiv$R^n, then P$in$K\_0(R) can be identityfed with R\[t\]^n$arrow.r$R\[t\]^n which is the identity on Q\[t\] and mult by t on P\[t\] Similarly, given nu nil, t1-nu is an iso after inverting t, sicne (t1-nu)^-1t^-1\(1-nu t)^-1$in$GL\_n(R\[t,t^-1\]), so repre a class in K\_0(R\[t\]rel S) A gneral S iso R\[t\]^n$arrow.r$$alpha$R\[t\]^n is given (since t is not a zero divisor) by an exact seq 0$arrow.r$R\[t\]^n$arrow.r$$alpha$R\[t\]^n$arrow.r$M$arrow.r 0$ M is annilated by some power t^m of t, tensor the seq with R\[t\]/(t^m), we obtain 0$arrow.r$Tor\_1^R\[t\]\(M,R\[t\]/(t^m))$arrow.r$\(R\[t\]/(t^m))^n$arrow.r$\(R\[t\]/(t^m))^n$arrow.r$M$arrow.r 0$ But from the free resolution 0$arrow.r$R\[t\]$arrow.r$t^m R\[t\]$arrow.r$R\[t\]/(t^m)$arrow.r 0$

]
Construct splitting $K_0 \( "Nil" \( R \) \) arrow.r K_1 \( R \[ t \, t^(- 1) \] \)$, $\[ P \, T \] mapsto \[ \( P xor Q \) \, 1 - T t^(- 1)\
 & 1 \]$, $P xor Q tilde.equiv R^n$

#statement("Proposition")[
R is an algebra over F\_p, then NK\_1(R) is a p group

]
#proof(title: [Proof])[
Consider $R = F_p \[ x \] \/ \( x^n \)$, (1+tf(x,t))^p^m=1+t^p^mf(x^p^m,t^p^m)

]
#statement("Proposition")[
R algebra over Q, then NK\_1(R) is a Q vector space

]
#proof(title: [Proof])[
Similar argument to reduce to $R = Q \[ x \] \/ \( x^n \)$. Use Witt vectors

]
#statement("Definition")[
$F : upright("rings") arrow.r upright("Groups")$ is a functor. Let $L F \( R \) = "coker" \( F \( R \[ t \] xor F \( R \[ t^(- 1) \] \) \) arrow.r F \( R \[ t \, t^(- 1) \] \) \)$ Then we get a sequence Seq(F,R) #math.equation(block: true, numbering: none, $0 arrow.r F \( R \) arrow.r^Delta F \( R \[ t \] \) xor F \( R \[ t^(- 1) \] \) arrow.r F \( R \[ t \, t^(- 1) \] \) \) arrow.r L F \( R \) arrow.r 0$)

F is acyclic if

The fundamental theorem syas $K_1$ is a contracted funcor with $L K_1 = K_0$ Definte $K_n = L K_(1 - n)$, $N F \( R \) = "coker" \( F \( R \) arrow.r F \( R \[ t \] \) \)$ If is regular and Noe, then the resolution theorme showed $K_0 \( R \) = G_0 \( R \)$ and $N K_0 \( R \) = 0 \, K_(- 1) \( R \) = 0$. In fact $K_(- n) \( R \) = 0 forall n gt.eq 1$. So negative K theory is mostly interesting for non-regular rings

]
#statement("Example")[
$R = bb(Z)$, $I = \( n \)$, $R \/ I = bb(Z) \/ n$. If $n$ has more than one prime factor, $Z \/ n tilde.equiv Z \/ p_1^(r_1) xor dots.h.c xor Z \/ p_k^(r_k)$ a product of k local rings, $K_0 \( R \/ I \) = Z^k$, $K_0 \( R \) = Z$. We will obtain a long exact sequence

]
#statement("Proposition")[
If F is contracted functor, then so are LF,NF and $N L F tilde.equiv L N F$

]
#proof(title: [Proof])[

]
#statement("Theorem", title: [Fundamental theorem])[
$K_n \( R \[ t \, t^(- 1) \] \) tilde.equiv K_n \( R \) xor K_(n - 1) \( R \) xor N K_n \( R \) xor N K_n \( R \)$, for $n lt.eq 1$

]
#statement("Corollary")[
If $F$ is a contracted functor, then $F \( R \[ t_1 \, dots.h.c \, t_n \] \) tilde.equiv \( 1 + N \)^n F \( R \)$, $F \( R \[ t_1^(plus.minus 1) \, dots.h.c t_n^(plus.minus 1) \] \) tilde.equiv \( 1 + 2 N + L \)^n F \( R \)$

]
#statement("Theorem")[

]
#proof(title: [Proof])[
Use the definition of $L K_0$ to get

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $0$),
node((1, 0), $0$),
node((2, 0), $0$),
node((0, 1), $K_0 \( I \)$),
node((1, 1), $K_0 \( R \)$),
node((2, 1), $K_0 \( R \/ I \)$),
node((0, 2), $K_0 \( I \[ t \] xor I \[ t^(- 1) \] \)$),
node((1, 2), $K_0 \( R \[ t \] xor R \[ t^(- 1) \] \)$),
node((2, 2), $K_0 \( R \/ I \[ t \] xor R \/ I \[ t^(- 1) \] \)$),
node((0, 3), $K_0 \( I \[ t \, t^(- 1) \] \)$),
node((1, 3), $K_0 \( R \[ t \, t^(- 1) \] \)$),
node((2, 3), $K_0 \( R \/ I \[ t \, t^(- 1) \] \)$),
node((0, 4), $K_(- 1) \( I \)$),
node((1, 4), $K_(- 1) \( R \)$),
node((2, 4), $K_(- 1) \( R \/ I \)$),
node((0, 5), $0$),
node((1, 5), $0$),
node((2, 5), $0$),
edge((1, 0), (1, 1), "->"),
edge((0, 1), (1, 1), "->"),
edge((0, 1), (0, 2), "->"),
edge((1, 1), (2, 1), "->"),
edge((1, 1), (1, 2), "->"),
edge((2, 1), (2, 2), "->"),
edge((0, 2), (0, 3), "->"),
edge((1, 2), (1, 3), "->"),
edge((2, 2), (2, 3), "->"),
edge((0, 3), (0, 4), "->"),
edge((1, 3), (1, 4), "->"),
edge((2, 3), (2, 4), "->"),
edge((0, 4), (0, 5), "->"),
edge((0, 4), (1, 4), "->"),
edge((0, 4), (0, 3), "->", bend: 18deg),
edge((1, 4), (1, 5), "->"),
edge((1, 4), (2, 4), "->"),
edge((1, 4), (1, 3), "->", bend: 18deg),
edge((2, 4), (2, 5), "->"),
edge((2, 4), (2, 3), "->", bend: 18deg),
)
]
We get a boundary map $partial : K_0 \( R \/ I \) arrow.r K_(- 1) \( I \)$, but this comes from the boundary map $K_1 \( R \/ I \[ t \, t^(- 1) \] \) arrow.r^partial K_0 \( I \[ t \, t^(- 1) \] \)$

]
#statement("Definition")[
A ring $R$ is called $K_n$ regular for some $n$ if $L K_n \, N K_n$ both vanish. A regular Noetherian ring is $K_n$ regular for all $n$

]
#statement("Fact")[
$K_1$ regular $arrow.r.double$ $K_0$ regular $arrow.r.double$ $K_(- 1)$ regular $arrow.r.double$, None of these arrows are reversible. In general, NK groups and lower K groups can often be computed using the definition and polynomial, Laurent polynomial rings. NK groups can also be computed using the Nil category. Recall $N K_1 \( R \) = ker \( K_0 \( "Nil" \( R \) \) arrow.r K_0 \( R \) \)$ Applying the machinery of contracted functors, you can also get a description of $N K_0$. There are lots o interesting contracted functors, especially on commutative rings, other than K-theory functors

]
#statement("Example")[
The group of units $U \( R \)$ is a contracted functor, $"Pic"$ is a contracted functor

]
Still another approach to negative K-theory(due to Karoubi). Show that $K_n \( R \) = K_n \( M \( R \) \)$, where $M \( R \) = lim M_k \( R \)$\(Morita invariance) clearly true for $K_0 \, K_1$. This inherits to $L K_n \, N K_n$. Embed $M \( R \)$ as an ideal in a larger ring which has identically 0 K-groups. From the exact sequence $0 arrow.r M \( R \) arrow.r B \( R \) arrow.r Q \( R \) = B \( R \) \/ M \( R \) arrow.r 0$

There is an obvious map $"St"_n \( R \) arrow.r E_n \( R \)$

#statement("Lemma")[
The subgroup of $"St"_n \( R \)$ generated by $x_(i j) \( r \) \, i < j$, maps iso to the group of strictly upper triangular matrices in $"GL"_n \( R \)$, $n gt.eq 3$

]
#statement("Definition")[
1$arrow.r$A$arrow.r$E$arrow.r$G$arrow.r 1$ is a central extension if A is abelian and central in E

]
#statement("Theorem")[
A group $G$ has a universal central extension $E$ iff $G$ is perfect iff $E$ is perfect and all central extensions of $E$ are trivial

]
#proof(title: [Proof])[
Consider presentation 1$arrow.r$R$arrow.r$F$arrow.r$G$arrow.r 1$ F is free, then $G = \[ F \, F \] \/ R$, let $E = \[ F \, F \] \/ \[ F \, R \]$, we have $E arrow.r G$, the kernel is central, $E$ is perfect

]
#statement("Theorem", title: [Milnor])[
$"St"_n \( R \)$ is the universal central extension of $E \( R \)$. Define $K_2 \( R \)$ to be the kernel of $"St" \( R \) arrow.r E \( R \)$

]
#proof(title: [Proof])[
$"St" \( R \)$ is perfect

]
#statement("Corollary")[
$K_2 \( R \)$ is naturally isomorphic to $H_2 \( E \( R \) \, bb(Z) \)$

]
#statement("Theorem")[
G is a group, G has a universal central extension if $H_1 \( G \, bb(Z) \) = 0$

]
#statement("Definition")[
A #emph[Waldhausen category]#index-entry("Waldhausen category") is a small(skeleton small) category $cal(C)$ with two special classes of morphisms: cofibrations $A arrow.r.tail B$, weak equivalences $A arrow.r B$, satisfying:

+ Every iso is both a cofibration and a weak equivalence

+ There is a zero object, and for every $A in cal(C)$, $0 arrow.r.tail A$ is a cofibration

+ the pushout of a cofibration along any morphism exists and is a cofibration, i.e.

  #align(center)[
  #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
  node((0, 0), $A$),
  node((1, 0), $B$),
  node((0, 1), $C$),
  node((1, 1), $B union_A C$),
  edge((0, 0), (1, 0), ">->"),
  edge((0, 0), (0, 1), "->"),
  edge((1, 0), (1, 1), "->"),
  edge((0, 1), (1, 1), ">->"),
  )
  ]
  Note that if $A = 0$, $B union_0 C = B product.co C$. Also the pushout square

  #align(center)[
  #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
  node((0, 0), $A$),
  node((1, 0), $B$),
  node((0, 1), $0$),
  node((1, 1), $B union_A 0$),
  edge((0, 0), (1, 0), ">->"),
  edge((0, 0), (0, 1), "->"),
  edge((1, 0), (1, 1), "->"),
  edge((0, 1), (1, 1), ">->"),
  )
  ]
  gives us the cokernel $B \/ A$

+ Weak equivalences are closed under compositions, and we can glue weak equivalences

  #align(center)[
  #diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
  node((0, 0), $C$),
  node((1, 0), $A$),
  node((2, 0), $B$),
  node((0, 1), $C'$),
  node((1, 1), $A'$),
  node((2, 1), $B'$),
  edge((0, 0), (0, 1), "->", $tilde.eq$),
  edge((1, 0), (2, 0), "->"),
  edge((1, 0), (1, 1), "->", $tilde.eq$),
  edge((1, 0), (0, 0), "->"),
  edge((2, 0), (2, 1), "->", $tilde.eq$),
  edge((1, 1), (2, 1), "->"),
  edge((1, 1), (0, 1), "->"),
  )
  ]

]
#statement("Definition")[
Let $cal(C)$ is a Waldhausen category, then $K_0 \( cal(C) \)$ is the free abelian group on the objects modulo relations

+ $\[ A \] = \[ A' \]$ if there is a weak equivalence $A arrow.r^tilde.eq A'$

+ $\[ C \] = \[ B \] + \[ C \/ B \]$ if there is a cofibration sequence $B arrow.r.tail C arrow.r C \/ B$. One gets the relation $\[ 0 \] = 0$, $\[ B union_A C \] = \[ B \] + \[ C \] - \[ A \]$ as a consequence

]
#statement("Example")[
$cal(C) subset.eq cal(A)$ is an exact category, then $cal(C)$ is a a Waldhausen category, with cofibration sequences the short exact sequence

]
#statement(tag: "2021/3/22-11:10", "Example")[
$cal(C)$ is the category of based finite CW complexes, $0 = *$ is the zero object, $0 arrow.r A$ is the inclusion, cofibrations are based inclusions of subcomplexes, weak equivalences are based homotopy equivalences

]
#statement("Proposition", title: [Waldhausen])[
$K_0 \( cal(C) \) = bb(Z)$, given by the Euler characteristic $A arrow.r chi \( A \)$

]
#proof(title: [Proof])[
$S^(n - 1) arrow.r.tail D^n arrow.r S^n$, thus $\[ S^(n - 1) \] + \[ S^n \] = 0$, so $\[ S^0 \]$ generates $K_0 \( C \)$, identify this with $1 in bb(Z)$, then $\[ S^n \] = \( - 1 \)^n$

]
#statement("Example")[
A small abelian category, $cal(C)$ the category of bounded chain complexes, $cal(C)$ is Waldhausen, cofibrations are monic chain maps and weak equivalences are quasi isomorphisms

]
#statement("Theorem", title: [SGA])[
In the situation of Example #ref(label("2021/3/22-11:10"), supplement: none), the map $A_(*) arrow.r chi \( A_(*) \)$ is an iso $K_0 \( cal(C) \) arrow.r K_0 \( cal(A) \)$

]
#proof(title: [Proof])[
By \"Euler-Poincare principle\", $chi \( A_(*) \) = chi \( H_(*) \( A_(*) \) \)$, $0 arrow.r Z_n arrow.r A_n arrow.r A_(n - 1) arrow.r A_(n - 1) \/ B_(n - 1) arrow.r 0$, $0 arrow.r B_n arrow.r Z_n arrow.r H_n arrow.r 0$, and add these. The Euler characteristic is also additive on cofibration sequences $B_(*) arrow.r.tail A_(*) arrow.r A_(*) \/ B_(*)$

]
#statement("Theorem", title: [Approximation theorem])[
$F : cal(A) arrow.r cal(B)$ is exact(take cofibrations to cofibrations) between Waldhausen categories. Assume

+ $f$ is a weak equivalence in $cal(A)$ iff $F \( f \)$ is a weak equivalence in $cal(B)$

+ Any $b : F \( cal(A) \) arrow.r cal(B)$ factors as $b' F \( a' \)$, $b' : B' arrow.r B$ is a weak equivalence, $a : A arrow.r A'$ is a cofibration with $F \( A' \) = B'$

+ can choose skeleton small?

Then $F$ induces iso $K_0 \( cal(A) \) arrow.r K_0 \( cal(B) \)$

]
#proof(title: [Proof])[
Consider $A = 0$, we see that any $B in cal(B)$ is weakly equivalent to $F \( A' \)$, thus $K_0 \( cal(A) \) arrow.r K_0 \( cal(B) \)$ is surjective. The sets of weak equivalence classes in $cal(A)$ and in $cal(B)$ coincide, or in bijection under $F_(*)$

]
Application: Let $R$ be a ring, we have the following Waldhausen categories:

- $"Proj" \( R \)$, finite generated projective R moudles

- $"Ch"^b \( "Proj" \( R \) \)$, bounded complexes of finitely generated R modules

- Perfect chain complexes, i.e. chain complexes quasi isomorphic to complexes in $"Ch"^b \( "Proj" \( R \) \)$

The Approximation theorem says they have the same $K_0$, namely $K_0 \( R \)$

The real use of Waldhausen categories will be in the construction of higher K-theory, where Waldhausen \"S-construction\" gives a simple elegant approach covering all of these examples

#statement("Example")[
Fix a field $k$, say $bb(C)$, $cal(A)$ be the category of smooth quasi-projective varieties over $k$. This is a Waldhausen category with cofibrations being closed inclusions, weak equivalences being isomorphisms, $\[ bb(P)^1 \] = \[ * \] + \[ bb(A)^1 \]$

]
#statement("Example")[
$R$ is a ring, let $"End" \( R \)$ be the category of pairs $\( P \, T \)$, $P$ is a finitely generated projective $R$-module, $T : P arrow.r P$, morphisms are commutative diagrams

#align(center)[
#diagram(cell-size: (13mm, 10mm), spacing: (8mm, 6mm), text-size: 8pt,
node((0, 0), $P$),
node((1, 0), $P'$),
node((0, 1), $P$),
node((1, 1), $P'$),
edge((0, 0), (1, 0), "->"),
edge((0, 0), (0, 1), "->", $T$),
edge((1, 0), (1, 1), "->", $T'$, label-side: right),
edge((0, 1), (1, 1), "->"),
)
]
You get $K_0 \( "End" \( R \) \)$ containing $K_0 \( R \)$ as a direct summand via the functor $P mapsto \( P \, 0 \)$. Compute the rest of $K_0 \( "End" \( R \) \)$. This was studied by Grayson

]

= Introduction to higher K theory
<introduction-to-higher-k-theory>
Now that we've seen an #strong[ad hoc] construction of $K_0 \, K_1 \, K_2$, and negative K-groups, it is time to study how one could get all the K-groups at once, so that they fit together as that they fit together as a unit. Quillen's idea, which won him the Fields medal in 1972, was to construct not a sequence of groups, but a #strong[topological space], or actually a #strong[spectrum], so that $K_i$ is just the $i$-homotopy group of this space. In other words, out of a ring $R$ (or later, an abelian category or exact category or Waldhausen category) we want a space $K \( R \)$ so that $K_i \( R \) = pi_i \( K \( R \) \)$. Of course, certain key conditinos have to be satisfied:

+ The association $R mapsto K \( R \)$ should be functorial.

+ Given an ideal $I subset.eq R$, we should get a fibration $K \( R \, I \) arrow.r K \( R \) arrow.r K \( R \/ I \)$, so that the induced long exact sequence of homotopy groups has the form #math.equation(block: true, numbering: none, $dots.h.c arrow.r K_i \( R \, I \) arrow.r K_i \( R \) arrow.r K_i \( R \/ I \) arrow.r^partial K_(i - 1) \( R \, I \) arrow.r dots.h.c$)

+ The groups $K_0 \, K_1 \, K_2$ should agree with the ones we've already defined. To motivate the simplest construction, the Quillen $+$-construction, recall that topological K-theory $K^(upright("top"))$ is given by homotopy classes of maps $X arrow.r K_0 \( bb(C) \) times B "GL" \( bb(C) \)^(upright("top"))$

#statement("Theorem")[
#math.equation(block: true, numbering: none, $K_i \( F_q \) = cases(Z \, i = 0, upright("cyclic of order ") q^k - 1 \, i = 2 k - 1, 0 \, i upright(" even") gt.eq 2)$) More precisely, $K \( F_q \)$ is homotopy equivalent to the homotopy fiber of the map $B U arrow.r^(psi^q - 1) B U$, where $psi^q$ is the Adams operation

]
Idea: Given a matrix with entries in $macron(F)_q$, which is roughly analogues to $bb(C)$, it has entries in $F_q$ iff it is fixed under Frobenius map. Once you make this precise, $K_i \( F_q \)$ falls out from the homotopy sequence since $pi_i \( B U \) = cases(Z \, i upright(" even"), 0 \, i upright(" odd"))$, and $psi^q - 1$ on $pi_(2 k)$ acts by $q^k$, and then consider the long exact sequence of this fibration

== Motivation
<motivation>
We've talked a lot about defining K-theory. But how do you actually compute it in practice? For motivation, it helps to look at the easier case of topological K-theory. There we had characteristic classes which provide a lot of information. We also had the splitting principle, which, you may recall, says that \"one can pretend every vector bundle is a direct sum of line bundles.\" Using these, one can define the Chern character $"Ch" : K^0 \( X \) arrow.r xor_i H^(2 i) \( X \, bb(Q) \)$ for $X$ a finite CW-complex by $"Ch" \( L_1 xor dots.h.c xor L_n \) = sum_j e^(c_1 \( L_j \))$, for $L_1 \, dots.h.c \, L_n$ line bundles with characteristic classes $c_1 \( L_j \) in H^2 \( X \, bb(Z) \)$ and with #math.equation(block: true, numbering: none, $e^(c_1 \( L_j \)) = 1 + c_1 \( L_j \) + 1 / 2 c_1 \( L_j \)^2 + dots.h.c$) The sum is finite since $c_1 \( L_j \)$ is nilpotent. The splitting principle and naturality imply that $"Ch"$ is well-defined for all vector bundles, and in fact for all formal differences of vector bundles, since we can define $"Ch" \( E - F \) = "Ch" \( E \) - "Ch" \( F \)$

#statement("Theorem")[
$"Ch"$ is a ring homomorphism $K^0 \( X \) arrow.r H^(upright("even")) \( X \, bb(Q) \)$ and its kernel is a finite nilpotent ideal. Furthermore, by Bott periodicity, it extends to a homomorphism of graded rings $K^(*) \( X \) arrow.r H^(*) \( X \, bb(Q) \)$, with finite kernel. It's an isomorphism after tensoring $K^(*) \( X \)$ with $bb(Q)$. So cohomology almost completely computes topological K-theory. And there is a spectral sequence $H^p \( X \, K^q \( upright("pt") \) arrow.r.double K^(p + q) \( X \)$. This suggests that having the right cohomology theories should give most of the information about algebraic K-theory as well, and indeed this is the case. There are two main theories that apply:

- Cyclic homology and its variants, especially topological cyclic homology TC

- Motivic (co)homology for schemes

]
== Motivic cohomology
<motivic-cohomology>
For $X$ a smooth quasi-projective scheme over a field $k$, there are complexes of sheaves $bb(Z) \( j \) \, j gt.eq 0$ over $X$ and the motivic cohomology of $X$ is $H^(n \, j) \( X \, bb(Z) \)$ is defined to be $H^n \( X \, bb(Z) \( j \) \)$. Note the bigrading. These groups are only nonzero for $j gt.eq 0$, and $bb(Z) \( 0 \) = bb(Z)$, $bb(Z) \( 1 \) = bb(G)_m \[ - 1 \]$. They are related to the usual Chow groups by $"CH"^i \( X \) = H^(2 i) \( X \, bb(Z) \( i \) \)$. There is a spectral sequence (for $q$ even) #math.equation(block: true, numbering: none, $E_2^(p \, q) = H^p \( X \, bb(Z) \( - q \/ 2 \) \) arrow.r.double K_(- p - q) \( X \)$) For $X = "Spec" k$, $H^(j \, j) \( X \) = K_j^M \( k \)$, the Milnor K-theory ($bb(Z)$ for $j = 0$ and generated by $k^times$ with the Steinberg relations for $j gt.eq 1$). So all of this gives considerable information about K-theory of fields. There is also the Suslin-Nestorenko Theorem: $K_n^M \( k \) arrow.r K_n \( k \)$ followed by the Chern class $c_(n \, n) : K_n \( k \) arrow.r H^(n \, n) \( "Spec" k \, bb(Z) \) = K_n^M \( k \)$ is multiplication by $\( - 1 \)^(n - 1) \( n - 1 \) !$, and in particular, is an injection modulo torsion of order involving only primes $lt.eq n - 1$.

Motivic cohomology thus turns out to be a very powerful tool for computing K-theory of schemes

Some results proved with this technology: Milnor conjecture, proved by Voevodsky, Bloch-Kato conjecture, proved by Voevodsky, Rost, et al. Information on Quillen-Lichtenbaum conjecture


#pagebreak()

= Homeworks

== Homework 1

#statement("Exercise")[
For $R$ a commutative ring and $P$ an $R$-module, we have $P$ finitely generated projective $arrow.l.r.double$ for every $p in "Spec" R$, $exists s in.not p$ with $P \[ 1 / s \]$ finitely generated and free. This implies that for every $p in "Spec" R$, $P_p$ is finitely generated and free, and that condition is equivalent if $R$ is Noetherian. Show that $R$ not Noetherian, the conditions are not equivalent, i.e., it could be that $P_p$ is finitely generated free for every prime ideal $p$, but $P$ is not finitely generated projective

]
#proof(title: "Solution")[

]
#statement("Exercise")[
Let $R$ be a commutative ring. Show that $"Spec" R$ (with the Zariski topology) is a connected topological space (i.e., is not the disjoint union of two non-empty open sets) $arrow.l.r.double$ the only idempotents in $R$ are 0 and 1. (We mentioned this in class but didn't prove it.) In particular, $"Spec" R$ is connected if $R$ is an integral domain

]
#proof(title: "Solution")[

]
#statement("Exercise")[
Work out the details of Example I.3.10.1 in Weibel: if $k$ is a field and $R = k \[ t^2 \, t^3 \]$, a subring of $k \[ t \]$, then $"Pic" \( R \) tilde.equiv k$\(the additive group of the field), with the isomorphism sending $alpha in k^times$ to the ideal of $R$ generated by $I_alpha = R inter \( t - alpha^(- 1) \) k \[ t \]$ and sending $0 in k$ to $R$ itself(So $I_alpha$ is the ideal of $R$ gotten by intersecting $R$ with the ideal generated by $t - alpha^(- 1)$ in $k \[ t \]$). Since $I_alpha$ is obviously an ideal, it is an $R$-module. Show that it is locally free of rank 1, and that all non-trivial line bundles on $R$ are isomorphic to ones arising this way

]
#proof(title: "Solution")[

]

#pagebreak()
#heading(numbering: none)[References]

#block[Charles Weibel. _The K-Book_.] <Weibel>

#pagebreak()
#heading(numbering: none)[Index]
#index-list()
