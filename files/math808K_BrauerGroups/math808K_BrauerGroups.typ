#set document(title: "MATH808K - Brauer Groups", author: "Haoran Li")
#set page(paper: "a4", margin: (top: 1in, bottom: 1.25in, x: 1.25in), numbering: "1")
#set text(size: 10pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#let statement-counter = counter("statement")
#let statement(kind, title: none, label: none, body) = context {
  statement-counter.step()
  let chapter = counter(heading).get().first()
  let number = str(chapter) + "." + str(statement-counter.get().first() + 1)
  let item = figure(
    block(above: 0.8em, below: 0.8em)[
      #strong[#kind #number#if title != none [ (#title)].] #body
    ],
    kind: "statement", supplement: kind, numbering: n => number, caption: none,
  )
  if label != none { [#item#label] } else { item }
}
#show figure.where(kind: "statement"): it => align(left, it.body)
#show heading.where(level: 1): it => {
  statement-counter.update(0)
  it
}
#let proof(body) = block(above: 0.6em, below: 0.6em)[
  #emph[Proof.] #body #h(1fr) $square$
]
#let remark(body) = block(above: 0.6em, below: 0.6em)[#emph[Remark.] #body]
#let Hom = math.op("Hom")
#let End = math.op("End")

#show math.equation.where(block: true): it => layout(size => {
  let width = measure(it).width
  if width > size.width {
    let ratio = size.width / width * 100%
    scale(x: ratio, y: ratio, reflow: true, it)
  } else { it }
})

#let diagram(columns: 0, rows: 0, nodes: (), edges: ()) = context layout(size => {
  set text(size: 9pt)
  let dimensions = nodes.map(node => measure(node.at(2)))
  let widths = range(columns).map(column => {
    let widths = nodes.enumerate().filter(pair => pair.at(1).at(1) == column)
      .map(pair => dimensions.at(pair.at(0)).width / 1pt)
    calc.max(0, ..widths)
  })
  let gaps = range(columns - 1).map(column => {
    let labels = edges.filter(edge => edge.from.at(0) == edge.to.at(0)
      and calc.min(edge.from.at(1), edge.to.at(1)) == column
      and calc.abs(edge.from.at(1) - edge.to.at(1)) == 1)
      .map(edge => edge.labels.map(label => measure(label.body).width / 1pt))
      .flatten()
    calc.max(28, ..labels.map(width => width + 12))
  })
  let centers = range(columns).map(column => {
    widths.slice(0, column).sum(default: 0) + gaps.slice(0, column).sum(default: 0) + widths.at(column) / 2
  })
  let node-height = calc.max(10, ..dimensions.map(value => value.height / 1pt))
  let row-height = node-height + 44
  let width = widths.sum() + gaps.sum(default: 0)
  let height = rows * row-height
  let label-boxes = edges.map(edge => {
    let dx = centers.at(edge.to.at(1)) - centers.at(edge.from.at(1))
    let dy = (edge.to.at(0) - edge.from.at(0)) * row-height
    let distance = calc.sqrt(dx * dx + dy * dy)
    let ux = dx / distance
    let uy = dy / distance
    let mx = (centers.at(edge.to.at(1)) + centers.at(edge.from.at(1))) / 2 + uy * edge.bend * 18
    let my = (edge.to.at(0) + edge.from.at(0) + 1) * row-height / 2 - ux * edge.bend * 18
    edge.labels.map(label => {
      let dim = measure(label.body)
      let sign = if label.flipped { -1 } else { 1 }
      let x = mx + uy * sign * (dim.width / 2pt + 5) - dim.width / 2pt
      let y = my - ux * sign * (dim.height / 2pt + 5) - dim.height / 2pt
      (x: x, y: y, width: dim.width / 1pt, height: dim.height / 1pt)
    })
  }).flatten()
  let extra-left = calc.max(0, ..label-boxes.map(bounds => -bounds.x + 4))
  let extra-right = calc.max(0, ..label-boxes.map(bounds => bounds.x + bounds.width - width + 4))
  let extra-top = calc.max(0, ..label-boxes.map(bounds => -bounds.y + 4))
  let extra-bottom = calc.max(0, ..label-boxes.map(bounds => bounds.y + bounds.height - height + 4))
  let contents = box(width: width * 1pt, height: height * 1pt)[
    #for edge in edges {
      let source = nodes.position(node => (node.at(0), node.at(1)) == edge.from)
      let target = nodes.position(node => (node.at(0), node.at(1)) == edge.to)
      let sx = centers.at(edge.from.at(1))
      let sy = edge.from.at(0) * row-height + row-height / 2
      let tx = centers.at(edge.to.at(1))
      let ty = edge.to.at(0) * row-height + row-height / 2
      let dx = tx - sx
      let dy = ty - sy
      let distance = calc.sqrt(dx * dx + dy * dy)
      let ux = dx / distance
      let uy = dy / distance
      let inset(dimensions) = calc.min(
        if ux == 0 { 100000 } else { (dimensions.width / 2pt + 5) / calc.abs(ux) },
        if uy == 0 { 100000 } else { (dimensions.height / 2pt + 5) / calc.abs(uy) },
      )
      let start-inset = inset(dimensions.at(source))
      let end-inset = inset(dimensions.at(target))
      sx += ux * start-inset
      sy += uy * start-inset
      tx -= ux * end-inset
      ty -= uy * end-inset
      let mx = (sx + tx) / 2 + uy * edge.bend * 18
      let my = (sy + ty) / 2 - ux * edge.bend * 18
      let segment(ax, ay, bx, by) = place(top + left, line(
        start: (ax * 1pt, ay * 1pt), end: (bx * 1pt, by * 1pt), stroke: 0.5pt,
      ))
      if edge.kind == "equal" {
        segment(sx + uy, sy - ux, tx + uy, ty - ux)
        segment(sx - uy, sy + ux, tx - uy, ty + ux)
      } else {
        segment(sx, sy, mx, my)
        segment(mx, my, tx, ty)
        let end-distance = calc.sqrt((tx - mx) * (tx - mx) + (ty - my) * (ty - my))
        let ex = (tx - mx) / end-distance
        let ey = (ty - my) / end-distance
        let tip(x, y) = place(top + left, polygon(
          (x * 1pt, y * 1pt),
          ((x - 5 * ex + 2 * ey) * 1pt, (y - 5 * ey - 2 * ex) * 1pt),
          ((x - 5 * ex - 2 * ey) * 1pt, (y - 5 * ey + 2 * ex) * 1pt),
          fill: black, stroke: none,
        ))
        tip(tx, ty)
        if edge.kind == "surjection" { tip(tx - 4 * ex, ty - 4 * ey) }
        if edge.kind == "hook" {
          segment(sx - 3 * uy, sy + 3 * ux, sx - 2 * ux - 3 * uy, sy - 2 * uy + 3 * ux)
          segment(sx - 2 * ux - 3 * uy, sy - 2 * uy + 3 * ux, sx - 2 * ux, sy - 2 * uy)
          segment(sx - 2 * ux, sy - 2 * uy, sx, sy)
        }
      }
      for label in edge.labels {
        let dim = measure(label.body)
        let sign = if label.flipped { -1 } else { 1 }
        let lx = mx + uy * sign * (dim.width / 2pt + 5) - dim.width / 2pt
        let ly = my - ux * sign * (dim.height / 2pt + 5) - dim.height / 2pt
        place(top + left, dx: lx * 1pt - 1pt, dy: ly * 1pt - 1pt, box(fill: white, inset: 1pt, label.body))
      }
    }
    #for (index, node) in nodes.enumerate() {
      let dim = dimensions.at(index)
      place(top + left,
        dx: centers.at(node.at(1)) * 1pt - dim.width / 2,
        dy: (node.at(0) * row-height + row-height / 2) * 1pt - dim.height / 2,
        node.at(2),
      )
    }
  ]
  let framed = pad(left: extra-left * 1pt, right: extra-right * 1pt,
    top: extra-top * 1pt, bottom: extra-bottom * 1pt, contents)
  let ratio = calc.min(1, size.width / ((width + extra-left + extra-right) * 1pt)) * 100%
  block(width: 100%, above: 0.8em, below: 0.8em,
    align(center, scale(x: ratio, y: ratio, reflow: true, framed)),
  )
})

#align(center)[
  #v(1cm)
  #text(size: 23pt, weight: "bold")[MATH808K - Brauer Groups]
  #v(1cm)
  Haoran Li
  #v(1cm)
]
#outline(title: [Contents])
#pagebreak()

= Overview

The goals of the this course:

+ Define central simple $k$-algebras(CSA/k)

+ Classify CSA's

+ Define the Brauer group(motivate Galois cohomology)

+ Blackbox Galois cohomology

+ Computing Brauer gorups of some special fields

#statement("Example", title: [CSA/k(Central simple $k$-algebras)])[
+ $cal(C)$ is a category, $"Hom"_(cal(C)) \( A \, B \)$ are finite dim vector spaces, $"End"_(cal(C)) \( A \)$ are finite dim $k$-algebras

+ $cal(C)'$ is the category of finite dim vector spaces, $"End"_(cal(C)') \( k^(xor n) \) = M_n \( k \)$

+ $cal(C)$ is the cat of local Artinian $k$-algebras, $"Hom"_(cal(C)) \( A \, B \) subset.eq "Hom"_(cal(C)') \( A \, B \)$

+ $X$ proj $k$-var and $V \, W$ vector bundles over $X$ $ "Hom" \( V \, W \) = Gamma \( X \, "Hom" \( V \, W \) \) = Gamma \( X \, V^or times.o W \) = H^0 \( X \, V^or times.o W \) $

]
#statement("Example", title: [Examples of finite $k$-algebras])[
$F \/ k$ finite field extension, $k \[ x \] \/ \( x^2 \)$, $k \[ x \, y \] \/ \( x^2 \, y^2 \, x y \)$, $M_n \( k \)$, $M_n \( F \)$

]

= Quaternion Algebras

First let's assume $"Char" k eq.not 2$

#statement("Definition")[
$a \, b in k^times$, the #emph[generalized quaternion algebra] is denoted as $\( a \, b \) = k \[ i \, j \] \/ \( i^2 = a \, j^2 = b \, i j = - j i \)$, for $q = x + y i + z j + w i j$, write $macron(q) = x - y i - z j - w i j$, and $parallel q parallel^2 = q macron(q) = macron(q) q = x^2 + a y^2 + b z^2 + a b w^2$

]
#statement("Definition")[
We say a $k$-algebra $A$ has #emph[division] if $A$ is a division ring. We say $A$ #emph[split] if $A tilde.equiv M_n \( k \)$ for some $n$. We call $f : A arrow.r^tilde.equiv M_n \( k \)$ a splitting of $A$

]
#statement("Example")[
$\( - 1 \, - 1 \) \/ bb(R)$ has divsion: $q^(- 1) = frac(macron(q), parallel q parallel^2) = frac(x - y i - z j - w i j, x^2 + y^2 + z^2 + w^2)$ for $q = x + y i + z j + w i j$. $\( - 1 \, - 1 \) \/ bb(C)$ splits with splitting $f : Q arrow.r M_2 \( bb(C) \)$, $f \( i \) = mat(delim: "[", - i, ; #none, i)$, $f \( j \) = mat(delim: "[", #none, - 1; 1, )$

]
#statement("Proposition")[
Suppose $Q = \( a \, b \) \/ k$, then the following are equivalent

+ $Q$ split

+ $Q$ doesn't have division

+ There is a nontrivial solution over $k$ to $x^2 - a y^2 - b z^2 + a b w^2 = 0$

+ There is a solution over $k$ to either $a = x^2 - b y^2$ or $b = z^2 - a w^2$

]
#remark[
$\( - 1 \, - 1 \) \/ macron(k)$ always split

]
#proof[
- \(1)$arrow.r.double$\(2): $E_(i j)$ has no inverse

- \(2)$arrow.r.double$\(3): Assume not, then $q^(- 1) = frac(macron(q), parallel q parallel^2)$ is defined

- \(3)$arrow.r.double$\(4):

- \(4)$arrow.r.double$\(1):

]
#statement("Lemma")[
+ $\( a \, b \) tilde.equiv \( b \, a \)$

+ $\( a \, b \) tilde.equiv \( a u^2 \, b \)$ for all $u in k^times$

+ $\( 1 \, b \) tilde.equiv M_2 \( k \)$

]
#proof[
+ Switch $i \, j$

+ Consider $i mapsto u i$

+ $i mapsto mat(delim: "[", 1, 0; 0, - 1)$, $j mapsto mat(delim: "[", 0, b; 1, 0)$

]
#statement("Proposition", title: [Classification of finite division $k$-algebra of dimension 1,2,3,4])[
+ $dim_k A = 1$: $A = k$

+ $dim_k A = 2$: $A = k 1 xor k i$, hence $A$ is commutative, therefore $A \/ k$ is a quadratic field extension

+ $dim_k A = 3$: Consider $Z \( A \)$, we have the following cases

  + $dim_k Z \( A \) = 3$: $A$ is commutative, hence $A \/ k$ is a cubic field extension

  + $dim_k Z \( A \) = 2$: we may assume $A = k 1 xor k i xor k j$ and $Z \( A \) = k 1 xor k i$, but then $i j = j i$ and $dim_k Z \( A \) = 3$

  + $dim_k Z \( A \) = 1$: we may assume $A = k 1 xor k i xor k j$, $Z \( A \) = k$ and $i j eq.not j i$. Let's write $i^2 = a + b i + c j$, then $a i + b i^2 + c i j = i i^2 = i^2 i = a i + b i^2 + c j i arrow.r.double c \( i j - j i \) = 0 arrow.r.double c = 0$, hence $i^2 = a + b i$. Then multiply by $i$ as a matrix would look like $mat(delim: "[", 0, a, x; 1, b, y; 0, 0, z) = : M$ for some $x \, y \, z in k$, so $exists v eq.not 0$ such that $i v = z v$, but then $\( i - z \) v = 0$ which is impossible

+ $dim_k A = 4$: $A tilde.equiv \( a \, b \)$ for some $a \, b in k^times$

]
#statement("Lemma")[
Let $D$ be a 4 dimensional, $k$-central division algebra, and assume there exists a $k$-subalgebra $E subset.eq A$ so that $E tilde.equiv k \( sqrt(a) \)$, $a in.not k^times^2$, then $A tilde.equiv \( a \, b \)$ for some $b in k^times$

]
If $"Char" k = 2$\(note that $- 1 = 1$), things are more complicated

#statement("Definition")[
$a in k \, b in k^times$, define $\[ a \, b \) = k \[ i \, j \] \/ \( i^2 + i = a \, j^2 = b \, i j = j i + j \)$, suppose $q = x + y i + z j + w i j$, then $macron(q) = x + y \( 1 + i \) + z j + w i j = \( x + y \) + y i + z j + w i j$, since the minimal polynomials of $i \, j \, i j$ are $x^2 + x + a$ , $x^2 + b$ and $x^2 + a b$ \[since $\( i j \)^2 = i j i j = i \( i j + j \) j = i^2 j^2 + i j^2 = \( i + a \) b + i b = a b$\]

]
#statement("Exercise")[
Suppose $"Char" k = 2$, the following are equivalent

+ $\[ a \, b \)$ split

+ $\[ a \, b \)$ doesn't have division

+ $b$ is a norm from $k \( alpha \) \/ k$ where $alpha$ is a root of $x^2 + x + a = 0$

+ The conic $a x^2 + b y^2 = z^2 + z w$ has a $k$ point

]

= Projective Conics

For $a \, b in k^times$, consider $ mat(delim: "[", y_0; y_1; y_2) = mat(delim: "[", 0, b, 0; a, 0, 0; 0, 0, a b) = mat(delim: "[", x_0; x_1; x_2) = mat(delim: "[", b x_1; a x_0; a b x_2) $ Then conics $V \( a y_0^2 + b y_1^2 - y_2^2 \) = V \( a \( b x_1 \)^2 + b \( a x_0 \)^2 - \( a b x_2 \)^2 \) = V \( a x_0^2 + b x_1^2 - a b x_2^2 \)$

#statement("Proposition")[
$\( a \, b \) \, \( c \, d \)$ are two quaternion algebras over $k$, then $\( a \, b \) tilde.equiv \( c \, d \)$ iff $C_(a \, b) = V \( a x_0^2 + b x_1^2 - x_2^2 \)$ and $C_(c \, d) = V \( c x_0^2 + d x_1^2 - x_2^2 \)$ define the same conics up to $P G L_2 \( k \)$

]
#statement("Proposition")[
$\( a \, b \) \/ k$ split iff $C_(a \, b) \( k \) eq.not diameter$

]
Let's briefly recall Hensel's lemma

#statement("Lemma", title: [Hensel's lemma], label: <brauer-Hensel-s-lemma>)[
$f \( x \) in bb(Z)_p \[ x \]$, $a in bb(Z)_p$, $f \( a \) equiv 0 #h(0em) mod med p$, $f' \( a \) equiv.not 0 #h(0em) mod med p$, then there exists $alpha in bb(Z)_p$ such that $f \( alpha \) = 0$ in $bb(Z)_p$ and $alpha equiv a #h(0em) mod med p$

]
#statement("Example", title: [Non-isomorphic quaternion algebras with divisions])[
$Q_1 = \( - 1 \, 7 \) \/ bb(Q) tilde.nequiv Q_2 = \( - 1 \, 3 \) \/ bb(Q)$.

- Check $Q_1$ has division, suppose not, then $7 = z^2 + w^2$ has a solution, but since $0 = z^2 + w^2$ has no non-trivial solution in $bb(F)_7$, hence we have $7 = \( 7 alpha \)^2 + \( 7 gamma \)^2 = 49 \( alpha^2 + gamma^2 \)$ which is impossible

- Check $Q_2$ has division, suppose not, then $3 = z^2 + w^2$ has a solution, but since $0 = z^2 + w^2$ has no non-trivial solution in $bb(F)_3$, hence we have $3 = \( 3 alpha \)^2 + \( 3 gamma \)^2 = 9 \( alpha^2 + gamma^2 \)$ which is impossible

- $\( - 1 \, 3 \) \/ bb(Q)_7$ split, consider $x^2 + y^2 - 3 z^2 - 3 w^2 = 0$, let $y = z = 1$, $w = 0$ and $f \( x \) = x^2 - 2$, then $f \( 3 \) equiv 0 #h(0em) mod med 7$ and $f' \( 3 \) equiv 1 #h(0em) mod med 7$, by Hensel's lemma~#ref(<brauer-Hensel-s-lemma>, supplement: none) we know there exists $bb(Q)_7 in.rev alpha equiv 3$ such that $f \( alpha \) = 0$

]
#statement("Example")[
Quaternion algebras over $bb(F)_q \( q = p^n \, p eq.not 2 \)$ split, just consider $1^2 - a x^2 - b y^2 + 0^2 = 0 arrow.r.double a x^2 = 1 - b y^2$, write $S_a = { a x^2 }$, $S_b = { 1 - b y^2 }$, then $\| S_a \| = \| S_b \| = \| { x^2 } \| = frac(q - 1, 2) + 1 = frac(q + 1, 2)$, so $S_a$ and $S_b$ cannot be disjoint

]

= Central Simple Algebras

#statement("Definition")[
A $k$-algebra $A$ is a #emph[simple] if the only two-sided ideals of $A$ is $0$ and $A$. A $k$#emph[central algebra] is a finite $k$-algebra with $Z \( A \) = k$

]
#statement("Example")[
$M_n \( k \)$ as a left module is not simple, for example, consider left ideal generated by $mat(delim: "(", 1, 0; 1, 0)$

]
#statement("Example")[
+ $M_n \( k \)$

+ Quaternion algebra $A \/ k$, $F \/ k$ is a quadratic field extension such that $A$ splits over $F$, i.e. $A times.o_k F tilde.equiv M_2 \( F \)$, thus $Z \( A \) times.o_k F subset.eq Z \( A times.o_k F \) = Z \( M_2 \( F \) \) = F$, which implies that $Z \( A \) = k$. (Similarly, if $I subset.eq A$ is a two-sided ideal, then $I times.o_k F$ is either $M_2 \( F \)$ or $0$, which implies that $I = A$ or $I = 0$ respectively)

]
#statement("Proposition")[
$A \, B$ are finite $k$-algebras, then $Z \( A times.o_k B \) = Z \( A \) times.o_k Z \( B \)$

]
#statement("Proposition")[
$A$ is $C S A \/ k$, $B$ finite $k$-alg, then two-sided ideals of $A times.o_k B$ are of the form $A times.o_k J$ where $J = I inter \( 1 times.o_k B \)$ is a two-sided ideal in $B$

]
#statement("Example")[
If $D = \( a \, b \) \/ k$, $D' = \( a \, b' \) \/ k$, then $D times.o_k D' tilde.equiv \( a \, b b' \) times.o_k M_2 \( k \)$

]
#statement("Example")[
$D$ is a $k$-central division algebra, then $M_n \( k \) times.o_k D arrow.r M_n \( D \)$ $\( a_(i j) \) times.o d mapsto \( a_(i j) d \)$ is an iso, in particular $M_n \( k \) times.o M_m \( k \) arrow.r M_(n m) \( k \)$ is the Kronecker product

]
#statement("Theorem", title: [Wedderburn's theorem], label: <brauer-Wedderburn-s-theorem>)[
$A$ is a finite simple $k$-alg, then $A tilde.equiv M_n \( D \)$ for some division $k$-alg and some $n$, $D$ is unique up to iso, $n$ is unique. Moreover, if $A$ is $k$-central, so is $D$

]
As a corollary of a Theorem~#ref(<brauer-Wedderburn-s-theorem>, supplement: none), $dim_k \( A \) = n^2$, so we can define

#statement("Definition")[
The the #emph[degree] of a simple $k$-algebra is the square root of its dimension

]
#statement("Definition")[
We say the a CSA/$k$ $A$ is split if $A tilde.equiv M_n \( k \)$ for some $n$, we say $A$ is a $F$ split, or split by $F$ for a field extension $F \/ k$ if $A times.o_k F tilde.equiv M_n \( F \)$ for some $n$

]
The notion of a CSA is really irrelevant with respect to base change, as the following proposition asserts

#statement("Proposition")[
$A$ is a finite $k$-algebra, $F \/ k$ field extension. Then $A$ is a CSA/k iff $A times.o_k F$ is a CSA/F for all $F$\(for some $F$)

]
#statement("Corollary")[
$A$ is a CSA/$k$, then there is a finite field extension $F \/ k$ where $A$ splits

]
#proof[
Let $phi : A times.o_k macron(k) arrow.r M_n \( macron(k) \)$ be an isomorphism, pick a basis ${ a_i }$ of $A$, let $phi \( a_i \) = sum c_(i j) e_j$ for $c_(i j) in macron(k)$. Let $F = k \( c_(i j) \)$, hten we can define $psi : A times.o_k F arrow.r M_n \( F \)$, $psi \( a_i \) = sum c_(i j) e_j$, since $psi times.o_F macron(k) = phi$, and since $macron(k)$ is a faithfully flat $F$-module, we find $psi$ is an isomrophism

]
#statement("Lemma")[
If $D$ is a finite division $macron(k)$ algebra, then $D tilde.equiv macron(k)$

]
#statement("Theorem")[
A finite $k$-algebra $A$ is CSA/k iff $A times.o_k macron(k) tilde.equiv M_n \( macron(k) \)$

]
#proof[

]

= Galois Splitting Fields

#statement("Definition")[

]

= Brauer Groups

#statement("Theorem", title: [Relative Skolem-Noether theorem])[
$S$ is a CSA/k, $R arrow.r.hook S$ is a simple $k$-algebra, suppose $f \, g : R arrow.r S$ are are homomorphisms, there there exists automorphism $alpha : S arrow.r S$ such that $alpha compose f = g$

]
Consider $A$ is a CSA/k with $E$ being a maximal subfield where $E \/ k$ is finite Galois with Galois group $G$, then for each $sigma in G$, we can find $x_sigma in A^times$ such that $x_sigma a x_sigma^(- 1) = sigma \( a \)$, $forall a in E$. If $y_sigma$ is another choice, then $x_sigma \, y_sigma$ differ by $E^times$, hence this defines $x_sigma x_tau = alpha_(sigma \, tau) x_(sigma tau)$

$alpha : G times G arrow.r E^times$ is actually a 2-cocycle

#statement("Definition")[
Suppose $H$ is an abelian group with a $G$ action, $Z^2 \( G \, H \)$ consists of $alpha : G times G arrow.r H$ such that $alpha_(rho sigma \, tau) dot.op alpha_(rho \, sigma) = rho \( alpha_(sigma \, tau) \) dot.op alpha_(rho \, sigma tau)$. $B^2 \( G \, H \)$ consists of $gamma_(sigma \, tau) = frac(sigma \( f_tau \) dot.op f_sigma, f_(sigma tau))$

]
#statement("Lemma")[
Suppose $A$ is a finite dimensional $k$-algebra, $E \/ k subset.eq A$ is a finite Galois extension with Galois group $G$, and if ${ x_sigma }_(sigma in G) subset.eq A^times$ such that $x_sigma a x_sigma^(- 1) = sigma \( a \)$, $forall a in E$. Then $x_sigma$ are $E$-linear independent in $A$

]
#proof[

]
#statement("Proposition")[
Suppose $alpha : G times G arrow.r E^times$ is a 2-cocycle, There is a $k$-algebra $\( E \/ k \, alpha \) := xor E x_sigma$ with $x_sigma x_tau = alpha_(sigma \, tau) x_(sigma tau)$, $x_sigma a x_sigma^(- 1) = sigma \( a \)$, $forall a in E$. This is a CSA/k. Moreover, $\( E \/ k \, alpha \) tilde.equiv \( E \/ k \, beta \)$ if $alpha tilde.op beta$

]
#proof[

]
#statement("Theorem")[
Consider $phi.alt : "Br" \( E \/ k \) arrow.r H^2 \( G \, E^times \)$

]
#proof[
Consider the inverse $phi.alt^(- 1) : H^2 \( G \, E^times \) arrow.r "Br" \( E \/ k \)$, $\[ alpha \] mapsto \( E \/ k \, alpha \)$

]
#statement("Definition")[
Suppose $H$ is a group with a $G$-action, then $ H^0 \( G \, H \) = Z^0 \( G \, H \) = H^G = { h in H \| sigma \( h \) = h \, forall sigma in G } $ If $H$ is not abelian, this is a pointed set

]
#remark[
A sequence of pointed set is $L arrow.r^pi M arrow.r^rho N$, and every element in $ker rho$ has an preimage in $L$. If $N = { * }$, then $pi$ is surjective, but even if $L = { * }$, $rho$ might be non-injective

]
#statement("Proposition")[
Suppose $1 arrow.r A arrow.r B arrow.r C arrow.r 1$ is an exact sequence of groups with $G$-action, then there is the long exact sequence $ 1 arrow.r H^0 \( G \, A \) arrow.r^(\( 1 \)) H^0 \( G \, B \) arrow.r^(\( 2 \)) H^0 \( G \, C \) arrow.r^(delta^1) H^1 \( G \, A \) arrow.r^(\( 3 \)) H^1 \( G \, B \) arrow.r^(\( 4 \)) H^1 \( G \, C \) $ Moreover, if $A$ is central in $B$, then $delta^2$ exists and we can extend this with $arrow.r^(delta^2) H^2 \( G \, A \) arrow.r H^2 \( G \, B \) arrow.r H^2 \( G \, C \)$

]
#proof[

]
#statement("Example")[
$ 1 arrow.r E^times arrow.r "GL"_n \( E \) arrow.r "PGL"_n \( E \) arrow.r 1 $ Then we get $H^1 \( G \, E^times \) arrow.r H^1 \( G \, "PGL"_n \( E \) \) \( tilde.equiv C S A \/ k \) arrow.r^(delta^2) H^2 \( G \, times E \) \( tilde.equiv "Br" \( E \/ k \) \)$

]
#statement("Proposition")[
+ For CSA/k $A \, B$ with $deg A = n$, $deg B = m$, $delta_(n m)^2 \( \[ A times.o_k B \] \) = delta_n^2 \( \[ A \] \) delta_m^2 \( \[ B \] \)$

+ For CSA/k $A$ with $deg A = n$, $delta_n^2 \( \[ A \] \) = 0 arrow.l.r.double A tilde.equiv M_n \( k \)$

+ If $\[ E : k \] = n$, then $delta_n^2$ is surjective, and $phi.alt^(- 1) compose delta_n^2 \( \[ \( E \/ k \, alpha \) \] \) = \[ \( E \/ k \, alpha \)^("op") \]$

]
#statement("Proposition")[
Suppose $A$ is a CSA/k with $"ind" A = d$, then $"ind" A^(times.o r) divides binom(d, r)$, $r lt.eq d$. In particular, $A^(times.o r)$ split, and $"Br" \( E \/ k \)$ are torsion

]
#proof[
Let $E \/ k$ be finite Galois extension that splits $A$, $G = "Gal" \( E \/ k \)$, $V = E^(xor d)$, we get the following commutative diagram

#block[
#diagram(
  columns: 5, rows: 2,
  nodes: (
    (0, 0, [$1$]),
    (0, 1, [$E^times$]),
    (0, 2, [$"GL" \( V \)$]),
    (0, 3, [$"GL" \( V \)$]),
    (0, 4, [$1$]),
    (1, 0, [$1$]),
    (1, 1, [$E^times$]),
    (1, 2, [$"GL" \( and.big^r V \)$]),
    (1, 3, [$"PGL" \( and.big^r V \)$]),
    (1, 4, [$1$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (1, 1), labels: ((body: [$lambda mapsto lambda^r$], flipped: true),), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: (), kind: "arrow", bend: 0),
    (from: (0, 2), to: (1, 2), labels: ((body: [$pi$], flipped: true),), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 4), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (1, 3), labels: (), kind: "arrow", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "arrow", bend: 0),
    (from: (1, 1), to: (1, 2), labels: (), kind: "arrow", bend: 0),
    (from: (1, 2), to: (1, 3), labels: (), kind: "arrow", bend: 0),
    (from: (1, 3), to: (1, 4), labels: (), kind: "arrow", bend: 0),
  ),
)
]
Here $pi \( phi.alt \) = and.big^r phi.alt$, so we get exact squares

]

= Group Cohomology Spectral Sequence

#statement("Definition")[
Let $A tilde.equiv M_n \( D_A \)$ be a CSA/$k$ with underlying division algebra $D_A$. The #emph[index of $A$] is defined to be $"ind" \( A \) = deg \( D_A \)$. The index depends only on the class of $A$ in $"Br" \( k \)$

]
#statement("Lemma", title: [Shapiro's lemma], label: <brauer-Shapiro-s-lemma>)[
$B$ is a $bb(Z) H$-module, then $H^i \( G \, M_H^G \( B \) \) tilde.equiv H^i \( H \, B \)$

]
#proof[

]
#statement("Definition")[
Suppose $\[ G : H \] < oo$ and $A$ is a $bb(Z) G$-module, $S$ is a set of representatives of cosets of $G \/ H$, for any $phi in M_H^G \( A \) = "Hom" \( bb(Z) G \, A \)$ we can define $ phi_H^G : bb(Z) G arrow.r A \, x mapsto sum_(s in S) s phi \( s^(- 1) x \) $ It is easy to check that $phi_H^G$ is defined independently from $S$. So we get a map $M_H^G \( A \) arrow.r A$ which induce the #emph[corestriction map] $"cor"_G^H : H^i \( H \, A \) arrow.r H^i \( G \, A \)$

]
#statement("Proposition", label: <brauer-01-02-04-28-2022>)[
Suppose $K lt.eq H lt.eq G$

+ $"res"_K^G = "res"_K^H compose "res"_H^G$

+ If $\[ G : K \] < oo$, then $"cor"_G^K = "res"_H^K compose "res"_G^H$

+ If $\[ G : H \] < oo$, then $"cor"_G^H compose "res"_H^G$ is multiplication by $\[ G : H \]$

]
#proof[
+
+
+

]

= Reduced Norm

$"Br" \( macron(k) \) = 0$, $"Br" \( bb(F)_q \) = 0$, $"Br" \( bb(R) \) = bb(Z) \/ 2 bb(Z)$ is generated by $\( - 1 \, - 1 \)$, note that $"Br" \( bb(R) \) = "Br" \( bb(C) \/ bb(R) \) = bb(R)^times \/ N_(bb(C) \/ bb(R)) \( bb(C)^times \) = bb(R)^times \/ bb(R)_(> 0)$, however $"Br" \( bb(Q) \) eq.not 0$ and $"Br" \( bb(Q)_p \) eq.not 0$

#statement("Definition")[
$A \/ k$ is a CSA, pick $E \/ k$ finite Galois splitting field for $A$ with splitting $f : A times.o_k E arrow.r M_n \( E \)$, then the following map $ A tilde.equiv A times.o_k k subset.eq A times.o_k E arrow.r_tilde.equiv^f M_n \( E \) arrow.r_()^det E $ is called the #emph[reduced norm] $"Nrd"$ of $A$

]
#remark[
$"Nrd" : A arrow.r E$ is independent of the splitting, suppose $f \, g : A times.o_k E arrow.r_()^tilde.equiv M_n \( E \)$ are splittings, then we have the commutative diagram

#block[
#diagram(
  columns: 4, rows: 2,
  nodes: (
    (0, 0, [$A$]),
    (0, 1, [$A times.o_k E$]),
    (0, 2, [$M_n \( E \)$]),
    (0, 3, [$E$]),
    (1, 0, [$A$]),
    (1, 1, [$A times.o_k E$]),
    (1, 2, [$M_n \( E \)$]),
    (1, 3, [$E$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "hook", bend: 0),
    (from: (0, 0), to: (1, 0), labels: (), kind: "equal", bend: 0),
    (from: (0, 1), to: (1, 1), labels: (), kind: "equal", bend: 0),
    (from: (0, 1), to: (0, 2), labels: ((body: [$f$], flipped: false), (body: [$tilde.equiv$], flipped: true)), kind: "arrow", bend: 0),
    (from: (0, 2), to: (1, 2), labels: ((body: [$g compose f^(- 1)$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: ((body: [$det$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 3), to: (1, 3), labels: (), kind: "equal", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "hook", bend: 0),
    (from: (1, 1), to: (1, 2), labels: ((body: [$g$], flipped: false), (body: [$tilde.equiv$], flipped: true)), kind: "arrow", bend: 0),
    (from: (1, 2), to: (1, 3), labels: ((body: [$det$], flipped: false),), kind: "arrow", bend: 0),
  ),
)
]
$"Nrd"$ is independent of the choice of the splitting field $E$, #text(fill: blue)[for some reasoning about composite fields]

]
#remark[
$"Nrd" : A arrow.r k$ is multiplicative, i.e. $"Nrd" \( x y \) = "Nrd" \( x \) "Nrd" \( y \)$, so $"Nrd" : A^times arrow.r k^times$ is a group homomorphism

]
#statement("Proposition")[
$A \/ k$ is a CSA, $deg A = n$, $N_(A \/ k) : A arrow.r k$, $a mapsto det m_a$ is the #emph[field norm] map, $N_(A \/ k) = "Nrd"^n$

]
#proof[
Note that #text(fill: blue)[$N_(A \/ k) \( a \) = N_(A times.o_k E \/ E) \( a times.o 1 \)$] and that $"Nrd" \( a \) = "Nrd" \( a times.o 1 \)$. So we may assume that $E = k$, if we write elementary matrices $E_(i j)$ as a basis of $M_n \( k \)$, so a matrix $M in M_n \( k \)$ as an linear operator on $M_n \( k \)$ as the form $ A_M = mat(delim: "[", M, , ; #none, dots.down, ; #none, , M; #none) $ Hence $N_(A \/ k) \( M \) = det \( A_M \) = \( det M \)^n = "Nrd" \( M \)^n$

]
#statement("Proposition", label: <brauer-reduced-norm-polynomial>)[
$"Nrd"$ is a homogeneous polynomial in $n^2$ variables(a basis of $A$ over $k$) of degree $n$ with $k$-coefficients

]
#proof[
$a = sum_(k = 1)^(n^2) lambda_k v_k$, so $"Nrd" \( a \) = det \( f \( a times.o 1 \) \)$

]
#statement("Definition")[
$k$ is a quasi algebraically closed (or $C_1$) field if any homogeneous polynomial $f in k \[ x_1 \, dots.h.c \, x_n \]$ with $deg f = d < n$, there is some $a_1 \, dots.h.c \, a_n$ not all zero with $f \( a_1 \, dots.h.c \, a_n \) = 0$

]
#statement("Proposition")[
Algebraically closed fields are $C_1$

]
#proof[
Write $f in k \[ x_1 \, dots.h.c \, x_n \]$ as $phi.alt_m x_1^m + dots.h.c + phi.alt_0$ and then do induction on the variables

]
#statement("Lemma")[
$L \/ k$ finite extension, $k$ is $C_1$, then so is $L$

]
#proof[
Suppose ${ v_j }_(j = 1)^m$ is a $k$-basis of $L$, $f in L \[ x_1 \, dots.h.c \, x_n \]$ is a degree $d < n$ homogeneous polynomial, write $x_i = sum_(j = 1)^m x_(i j) v_j$, Then $f \( x_1 \, dots.h.c \, x_n \) = g \( x_11 \, dots.h.c \, x_(n m) \)$, note that products of $v_j$'s can written as the $k$-linear combinations of $v_j$'s, $g$ can be seen as a $k \[ x_11 \, dots.h.c \, x_(n m) \]$-linear combination of $v_j$'s, view this as an linear operator on the $k$ vector space $L$, denote its determinant $h$, which is then a homogeneous polynomial of degree $m d$ with coefficients in $k$, since $m d < m n$, $h$ has non trivial solution, which says that $f$ also has a non-trivial solution.

]
#statement("Proposition")[
If $k$ is $C_1$, then $"Br" \( k \) = 0$

]
#proof[
If $k$ is finite, we already know that $"Br" \( k \) = 0$. #text(fill: blue)[We can actually show that finite fields are $C_1$] \
Assume $k$ is infinite, $A \/ k$ is a central division algebra over $k$ of degree $n gt.eq 1$, then by Theorem~#ref(<brauer-reduced-norm-polynomial>, supplement: none) we know that $"Nrd" : A arrow.r k$ is a homogeneous polynomial of degree $n$ in $n^2$ variables with $k$-coefficients. If $n > 1$, then $"Nrd" \( x \) = 0$ for some $0 eq.not x in A$ which is impossible, so $n = 1$, and $"Br" \( k \) = 0$

]
#statement("Theorem", title: [Tsen's theorem], label: <brauer-Tsen-theorem>)[
$k$ is algebraically closed, $C$ is a curve over $k$, then its function field $F = k \( C \)$ is $C_1$

]
#remark[
This is equivalent of saying that $F$ is a finite extension of $k \( t \)$, e.g. $F = bb(C) \( t \)$, $F = bb(C) \( t \) \( sqrt(t \( t - 1 \) \( t + 1 \)) \)$

]
#proof[
By clearing out the denominators, we may assume $f$ is a degree $d$ homogeneous polynomial in $k \[ t \] \[ x_1 \, dots.h.c \, x_n \]$. Suppose $r$ is the maximal degree of the coefficients in $f$. If we write for some sufficiently large $N$ $ x_i = sum_(j = 0)^N a_(i j) t^j $ Then we can rewrite $f$ as $ sum_(l = 0)^(d N + r) f_l \( a_10 \, dots.h.c \, a_(n N) \) t^l $ Then $f_l$ are homogeneous polynomial of $a_10 \, dots.h.c \, a_(n N)$ of degree $d$, so $V \( f_0 \, dots.h.c \, f_(d N + r) \)$ is a closed subvariety of $bb(P)^(n \( N + 1 \) - 1)$, then we can apply Lemma~#ref(<brauer-04-14-2022-13-40>, supplement: none), there exists $a_10 \, dots.h.c \, a_(n N)$ not all zero such that $f = 0$, so $x_i$ would be a solution.

]
#statement("Lemma", label: <brauer-04-14-2022-13-40>)[
$W subset.eq bb(P)^n$ is a positive dimensional closed subvariety, $f eq.not 0$ is a rational function on $bb(P)^n$, then $W inter V \( f \) eq.not diameter$

]
#proof[
This is equivalent to $W subset.eq D \( f \)$, we know that $D \( f \)$ is affine so we could assume $D \( f \) = "Spec" A$, then a morphism $W arrow.r.hook D \( f \)$ corresponds to $A arrow.r Gamma \( W \, cal(O)_W \) = k$ since $W$ is proper and projective

]
#remark[
If $k = overline(bb(F)_p)$, $A \/ bb(F)_q \( C \)$ is a CSA, then $A$ split over $k \( C \)$

]

= Unramified Splitting Field For Complete Discretely Valued Fields

#statement("Definition")[
A #emph[discrete valuation] on a field $F$ is $v : F arrow.r bb(Z) union { oo }$ satisfying

+ $v \( x \) = oo arrow.l.r.double x = 0$

+ $v \( x + y \) gt.eq min \( v \( x \) \, v \( y \) \)$, equality holds iff $v \( x \) eq.not v \( y \)$

+ $v \( x y \) = v \( x \) + v \( y \)$

A valuation is when replacing $bb(Z)$ by some totally ordered abelian group(called the value group). $v$ is trivial if $v \( F^times \) = 0$

]
#statement("Definition")[
A #emph[discrete valuation ring] is an integral domain $R$ with a discretely valued fraction field $F = "Frac" \( R \)$ such that $R = { x in F \| v \( x \) gt.eq 0 }$. In this case $m = { x in F \| v \( x \) > 0 }$ is the unique prime ideal in $R$, and $m = \( pi \)$, we call $pi$ the #emph[uniformizer], and for $x in F$, $v \( x \)$ is the maximal power of $pi$ in $a$.

]
#statement("Definition")[
Pick some $0 < c < 1$, we can define norm $\| dot.op \| : F arrow.r bb(R)_(gt.eq 0)$ as $\| x \| = c^(v \( x \))$, this defines a metric topology(#text(fill: blue)[which can be shown to be independent of the choice of $c$])

]
#statement("Example")[
$bb(Z)_(\( p \)) subset.eq bb(Q)$ with the $p$-adic valuation, $c = p^(- 1)$

]
#statement("Definition")[
By completing the metric topology, we obtain a complete discretely valued field $hat(F)$ with extended norm $\| dot.op \|$, and the closure of $R$ in $F$ is denoted by $hat(R)$ which can be proven is $hat(R) = limits(attach(lim, b: arrow.l)) R \/ m^n$

]
#statement("Example")[
$k \[ t \]_(\( t \)) subset.eq k \( t \)$ with $t$-adic valuation, $hat(k \( t \)) = k \( \( t \) \)$ is the field of formal Laurent series, $hat(k \[ t \]_(\( t \))) = k \[ \[ t \] \]$ is the ring of formal power series

]
#statement("Definition")[
Consider finite separable extension $E \/ F$, then $x in E$, $\| x \|_E = \| N_(E \/ F) \( x \) \|_F^(frac(1, \| \[ E : F \] \|))$. If $F$ was complete wrt $\| dot.op \|_F$, then $E$ is complete wrt $\| dot.op \|_E$ and has a valuation $w : E^times arrow.r bb(Z)$ satisfying

+ The valuation ring of $w$ is $S$ the integral closure of $R$ in $E$

+ $exists e$, such that $forall x in R$, $w \( x \) = e v \( x \)$, and $\[ E : F \] = e f$, where $f = \[ S \/ m' : R \/ m \]$

]
Our setting: If $F$ is complete, $E \/ F$ finite and separable is said to be unramified if $f = \[ E : F \]$ and $\( S \/ m' \) \/ \( R \/ m \)$ is separable

#statement("Theorem")[
Let $N_F$ be the category with objects unramified extensions $E \/ F$ and morphisms are $E arrow.r E'$ over $F$. $R_F$ be the category of finite separable extension $R \/ m$ with $R \/ m$-algebra morphism. Consider the restion functor $"res" : N_F arrow.r R_F$, $E \/ F arrow.r.squiggly \( S \/ m' \) \/ \( R \/ m \)$, and $\( E_1 arrow.r E_2 \) arrow.r.squiggly \( S_1 \/ m'_1 arrow.r^(f^r) S_2 \/ m'_2 \)$ where $f^r$ is defined as follows: for $x in S_1 \/ m'_1$, let $y in S_1$ be a lift, and let $f^r \( x \)$ be the image of $f \( y \)$ in $S_2 \/ m'_2$. This functor is an equivalence of categories. So $"Hom"_F \( E \, E \) = "Hom"_(R \/ m) \( S \/ m' \, S \/ m' \)$ have isomorphic Galois groups

]
#statement("Example")[
$F = bb(Q)_p$, $E \/ F$ unramified with $\[ E : F \] = n$, then $E = F \( xi_(p^n - 1) \)$, and $"Gal" \( E \/ F \)$ is cyclic

]
Now assume $k$ is infinite, $v : k^times arrow.r bb(Z)$ is a valuation, $k$ is complete with respect to associated absolute values. $R$ is the valuation ring.

#statement("Lemma")[
$D \/ k$ is a central division algebra with $deg D = d$, then $exists$ valution $w : D^times bb(Z)$. And $w$ is uniquely determined by restricting on any field $F subset.eq D$ containing $k$ by $w \( x \) = v_F \( x \) = frac(1, \[ F : k \]) v \( N_(F \/ k) \( x \) \)$. Moreover $w \( x \) = 1 / d v \( "Nrd" \( x \) \)$ and this valuation gives $D$ the structure of a normed $k$-vector space

]
#proof[
For a fixed $F subset.eq D$, $N_(D \/ k) \( x \) = "Nrd" \( x \)^d$, so $D$ viewed as a left $F$-vector space is $D tilde.equiv F^(xor m)$ where $m = frac(d^2, \[ F : k \])$. since for $x in F$, $"Nrd" \( x \)^d = N_(D \/ k) \( x \) = N_(F \/ k) \( x \)^m$, $m v \( N_(F \/ k) \( x \) \) = d v \( "Nrd" \( x \) \) arrow.r.double frac(1, \[ F : k \]) v \( N_(F \/ k) \( x \) \) = 1 / d v \( "Nrd" \( x \) \) = w \( x \)$. Now let $x \, y in D^times$ such that $x + y in D^times$, $F = k \( x^(- 1) y \) subset.eq D$, we know $w$ is a group homomorphism(since $"Nrd"$ is a group homomorphism), we have $ w \( 1 + x^(- 1) y \) = v_F \( 1 + x^(-) 1 y \) gt.eq min \( v_F \( 1 \) \, v_F \( x^(- 1) y \) \) = min \( v_F \( 1 \) \, v_F \( x^(- 1) y \) \) arrow.r.double w \( x + y \) gt.eq min \( w \( x \) \, w \( y \) \) $ So $w$ is a valuation

]
#statement("Theorem", label: <brauer-15-20-04-20-2022>)[
If $R \/ m$ is a perfect field, then any CSA/k is split by an unramified extension of $k$

]
#proof[
We will show that for any $L \/ k$ unramified, any $A in upright("CSA") \/ k$ is split by another unramified $E \/ L$. We prove this by induction on the index. If $A \/ L$ has index one, then we can just take $E = L$. Now suppose the statement holds for all $L \/ k$ unramified, $"ind"_L \( A \) lt.eq d$, by Lemma~#ref(<brauer-17-21-4-19-2022>, supplement: none), $A$ contains an unramified $E \/ L$ with $\[ E : L \] > 1$, then $"ind"_E \( A \)$ becomes less

]
#statement("Lemma", label: <brauer-17-21-4-19-2022>)[
If $R \/ m$ is perfect, $L \/ k$ is a unramified and $D$ is a division algebra over $L$ with $"ind"_L \( D \) > 1$, then $D$ contains an unramified $E \/ L$ with $\[ E : L \] > 1$

]
#proof[
Suppose not, then for every field $L subset.eq F subset.eq D$, the residue field extension $\( S \/ m' \) \/ \( R \/ m \)$ ($S subset.eq F$ valution ring with $m' subset.eq S$ maximal ideal) is trivial. Pick $x in D^times$, $pi in D^times$ such that $w \( pi \) = 1$. By induction we can write $y = a_0 + a_1 pi + a_2 pi^2 + dots.h.c + a_(n - 1) pi^(n - 1) + b_n pi^n$ which is a Cauchy sequence, so $y in R \( pi \)$

]
By Theorem~#ref(<brauer-15-20-04-20-2022>, supplement: none), we know $ "Br" \( k \) = limits(attach(lim, b: arrow.r))_(E \/ k upright(" (finite) unramified")) "Br" \( E \/ k \) = limits(attach(lim, b: arrow.r))_(E \/ k upright(" (finite) unramified")) H^2 \( "Gal" \( E \/ k \) \, E^times \) $ And we have a split short exact sequence of $G = "Gal" \( E \/ k \)$-modules

#block[
#diagram(
  columns: 5, rows: 1,
  nodes: (
    (0, 0, [$1$]),
    (0, 1, [$S^times$]),
    (0, 2, [$E^times$]),
    (0, 3, [$bb(Z)$]),
    (0, 4, [$0$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: ((body: [$v$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 4), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 2), labels: ((body: [$1 mapsto pi$], flipped: false),), kind: "arrow", bend: 1),
  ),
)
]
So there is a split exact sequence for all $i gt.eq 0$ $ 0 arrow.r H^i \( G \, S^times \) arrow.r H^i \( G \, E^times \) arrow.r H^i \( G \, bb(Z) \) arrow.r 0 $

#statement("Proposition")[
$H^i \( G \, S^times \) = 0$ for all $i gt.eq 1$

]
#proof[
Since $G$ is cyclic, for all $j gt.eq 1$, $H^(2 j - 1) \( G \, S^times \) = H^1 \( G \, S^times \) = 1$ by Hilbert 90. $H^(2 j) \( G \, S^times \) = H^2 \( G \, S^times \) = \( S^times \)^G \/ N_G \( S^times \)$, here recall the norm map $N_G \( x \) = product_(g in G) g x$. First consider commutative diagram

#block[
#diagram(
  columns: 2, rows: 2,
  nodes: (
    (0, 0, [$S^times$]),
    (0, 1, [$\( S \/ m' \)^times$]),
    (1, 0, [$R^times = \( S^times \)^G$]),
    (1, 1, [$\( R \/ m \)^times$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "surjection", bend: 0),
    (from: (0, 0), to: (1, 0), labels: ((body: [$N_G$], flipped: false),), kind: "surjection", bend: 0),
    (from: (0, 1), to: (1, 1), labels: ((body: [$N_G$], flipped: false),), kind: "surjection", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "surjection", bend: 0),
  ),
)
]
The right map is surjective since $"Gal" \( \( S \/ m' \) \( R \/ m \) \)$ induce action of $\( S \/ m' \)^times$, we know $H^2 \( G \, \( S \, m' \)^times \) = \( S \/ m' \)^times \/ N_G \( S \/ m' \)^times$, we want to show that the left map is surjective. For $x in R^times$, we can find $z_1 in S^times$ such that $N_G \( z_1 \)$ has the same image as $x$ in $\( R \/ m \)^times$, so $frac(x, N_G \( z_1 \)) = 1 + u pi$ for some $u in R$ Define $ U_E^(\( j \)) = 1 + m' ""^j \, quad U_k^(\( j \)) = 1 + m^j $ Consider commutative diagram

#block[
#diagram(
  columns: 2, rows: 2,
  nodes: (
    (0, 0, [$U_E^(\( j \))$]),
    (0, 1, [$S \/ m'$]),
    (1, 0, [$U_k^(\( j \))$]),
    (1, 1, [$R \/ m$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 0), to: (1, 0), labels: ((body: [$N_G$], flipped: false),), kind: "surjection", bend: 0),
    (from: (0, 1), to: (1, 1), labels: ((body: [$N_G$], flipped: false),), kind: "surjection", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "arrow", bend: 0),
  ),
)
]
The right map(called the trace map $x mapsto sum_(g in G) g x$) is surjective by lemma~#ref(<brauer-15-56-01-20-2022>, supplement: none), so $frac(1, N_G \( z_j \)) frac(x, N_G \( z_1 dots.h.c z_(j - 1) \)) = frac(x, N_G \( z_1 dots.h.c z_j \)) = 1 + u_j pi^j$. Note that ${ product_(i = 1)^n z_i }$ is Cauchy in $E^times$, if we take $z$ to be the limit, then $frac(x, N_G \( z \)) = 1$

]
#statement("Lemma", label: <brauer-15-56-01-20-2022>)[
$H^i \( G \, S \/ m' \) = 0$ for all $i gt.eq 1$

]
#proof[
Suppose $R \/ m = bb(F)_q$, $S \/ m' = bb(F)_(q^n)$ for some $n$. Consider $bb(F)_(q^n)$ as an abelian group, since $G$ is cyclic of order $n$, $bb(F)_(q^n) = frac(bb(F)_q \[ t \], \( t^n - 1 \)) = bb(F)_q G tilde.equiv M_({ e })^G \( bb(F)_q \) tilde.equiv "Hom"_(upright("Ab")) \( bb(Z) G \, bb(F)_q \)$, then apply Shapiro's lemma~#ref(<brauer-Shapiro-s-lemma>, supplement: none).

]
#statement("Lemma")[
The short exact sequence of $bb(Z) G$ modules(as trivial modules) $ 0 arrow.r bb(Z) arrow.r bb(Q) arrow.r bb(Q) \/ bb(Z) $ Induces isomorphisms $H^(i - 1) \( G \, bb(Q) \/ bb(Z) \) arrow.r^(delta^i) H^i \( G \, bb(Z) \)$

]
#proof[
We have $H^i \( G \, bb(Q) \) arrow.r^("res") H^i \( { e } \, bb(Q) \) = 0 arrow.r^("cor") H^i \( G \, bb(Q) \)$ for $i gt.eq 1$ is multiplying by $\| G \|$ which is an isomorphism, hence $H^i \( G \, bb(Q) \) = 0$

]
#statement("Corollary")[
There are isomorphisms

#block[
#diagram(
  columns: 3, rows: 1,
  nodes: (
    (0, 0, [$H^2 \( G \, E^times \)$]),
    (0, 1, [$H^2 \( G \, bb(Z)^times \)$]),
    (0, 2, [$H^1 \( G \, bb(Q) \/ bb(Z) \)$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0.35),
    (from: (0, 1), to: (0, 0), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0.35),
    (from: (0, 2), to: (0, 1), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
  ),
)
]
]
#statement("Theorem")[
If $f$ is a 1-cocycle, then $f \( g h \) = f \( g \) + g \( f \( h \) \) = f \( g \) + f \( h \)$ is a group homomorphism, so as $bb(Z) G$ modules, $H^1 \( G \, bb(Q) \/ bb(Z) \) = "Hom"_(upright("Ab")) \( G \, bb(Q) \/ bb(Z) \)$. Let $H = ker f$, $F = E^H$, $chi = macron(f) : G \/ H arrow.r frac(1, \[ F : k \]) bb(Z) \/ bb(Z)$, so it can be identified with $ { \( F \/ k \, chi \) \, k lt.eq F lt.eq E upright(" cyclic Galois, and ") chi : frac("Gal" \( E \/ k \), "Gal" \( F \/ k \)) arrow.r^tilde.equiv frac(1, \[ F : k \]) bb(Z) \/ bb(Z) subset.eq bb(Q) \/ bb(Z) } $ And in our case, we have

#block[
#diagram(
  columns: 5, rows: 2,
  nodes: (
    (0, 0, [$frac(1, \[ F : k \]) bb(Z) \/ bb(Z)$]),
    (0, 1, [$"Hom" \( G \, bb(Q) \/ bb(Z) \)$]),
    (0, 2, [$H^1 \( G \, bb(Q) \/ bb(Z) \)$]),
    (0, 3, [$H^2 \( G \, bb(Z) \)$]),
    (0, 4, [$H^2 \( G \, E^times \)$]),
    (1, 0, []),
    (1, 1, []),
    (1, 2, []),
    (1, 3, [$"Br" \( E \/ k \)$]),
    (1, 4, [$"Br" \( E \/ k \)$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 0), to: (1, 3), labels: ((body: [$1 mapsto \[ \( chi \, pi \) \]$], flipped: true),), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 4), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 4), to: (1, 4), labels: ((body: [$\[ alpha \] mapsto \[ \( E \/ k \, alpha \) \]$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 4), to: (1, 3), labels: ((body: [$delta^2$], flipped: false),), kind: "arrow", bend: 0),
    (from: (1, 4), to: (1, 3), labels: ((body: [$\[ A \] mapsto \[ A^(upright("op")) \]$], flipped: false),), kind: "arrow", bend: 0),
  ),
)
]
If $L \/ E \/ k$ unramified, $G' = "Gal" \( L \/ k \)$ and $chi : G' arrow.r frac(1, \[ L : k \]) bb(Z) \/ bb(Z)$ such that $overline(chi') : frac("Gal" \( L \/ k \), "Gal" \( E \/ L \)) arrow.r^tilde.equiv frac(1, \[ E : k \]) bb(Z) \/ bb(Z)$ is canonically $chi$, then

#block[
#diagram(
  columns: 2, rows: 2,
  nodes: (
    (0, 0, [$frac(1, \[ E : k \]) bb(Z) \/ bb(Z)$]),
    (0, 1, [$"Br" \( E \/ k \)$]),
    (1, 0, [$frac(1, \[ L : k \]) bb(Z) \/ bb(Z)$]),
    (1, 1, [$"Br" \( E \/ k \)$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 0), to: (1, 0), labels: (), kind: "hook", bend: 0),
    (from: (0, 1), to: (1, 1), labels: (), kind: "hook", bend: 0),
    (from: (1, 0), to: (1, 1), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
  ),
)
]
Hence $"Br" \( k \) = tilde.equiv limits(attach(lim, b: arrow.r)) "Br" \( E \/ k \) tilde.equiv bb(Q) \/ bb(Z)$

]
#statement("Corollary")[
If $A$ is a CSA/$k$, then $"ind" \( A \) = exp \( A \)$

]
#proof[
Since $"Br" \( k \) = bb(Q) \/ bb(Z)$, the algebra $\[ A \]$ generates a subgroup of size $exp \( A \) = d$, so $\[ A \]$ is the image of $1 / d tilde.equiv H^2 \( "Gal" \( E_d \/ k \) \, E_d^times \)$, where $E_d$ is the unique unramified extension of degree $d$, so $d = exp \( A \) \| "ind" \( A \) \| d arrow.r.double exp \( A \) = "ind" \( A \) = d$

]
#statement("Corollary")[
Every CSA/$k$ is a cyclic

]
#proof[
If $A$ is a CSA/$k$, $deg \( A \) = n$, and $"ind" \( A \) = d$, then $d = "ind" \( A \) \| deg \( A \) = n$, so $A$ is split by $E_d$, Hence $A$ is split by $E_d subset.eq E_n$, so $E_n subset.eq A$ is the maximal subfield of $A$.

]
#statement("Example")[
$k = bb(F)_3 \( \( t \) \)$, $E = bb(F)_3 \( \( t \) \) \[ x \] \/ \( x^3 - x - 1 \) tilde.nequiv bb(F)_27 \( \( t \) \)$ #text(fill: blue)[which is actually a infinite degree extension]. $A = \[ 1 \, t \)_(bb(F)_3 \( \( t \) \))$ has non zero class in $"Br" \( k \) arrow.r.double "Br" \( bb(F)_3 \( \( t \) \) \) eq.not 0$, $A' = \[ 1 \, t \)_(bb(F)_3 \( t \))$, $A' times.o_(bb(F)_3 \( t \)) bb(F) \( \( t \) \) tilde.equiv A$

]
#strong[Setting:]
- $k$ is a field.

- $C \/ k$ is a smooth geometrically connected, projective curve.

- $C_F = C times_k F$ for any field extension $F \/ k$, denote $pi : C_F arrow.r C$.

- $E \/ k$ is a finite Galois extension with $G = "Gal" \( E \/ k \)$. $forall sigma in G$

  #block[
  #diagram(
    columns: 2, rows: 2,
    nodes: (
      (0, 0, [$C_E$]),
      (0, 1, [$C_E$]),
      (1, 0, []),
      (1, 1, [$C$]),
    ),
    edges: (
      (from: (0, 0), to: (0, 1), labels: ((body: [$"id" times sigma$], flipped: false),), kind: "arrow", bend: 0),
      (from: (0, 0), to: (1, 1), labels: ((body: [$pi$], flipped: false),), kind: "arrow", bend: 0),
      (from: (0, 1), to: (1, 1), labels: ((body: [$pi$], flipped: false),), kind: "arrow", bend: 0),
    ),
  )
  ]
  defines a $G$-action on $C_E$.

- $E \( C_E \) = k \( C \) times.o_k E$ is the function field of $C_E$.

- $"Div" \( C_E \) = xor.big_(x in C_E^(\( 1 \))) bb(Z) x$ is the group of divisors of $C_E$.

- $"Pic" \( C_E \)$ is the Picard group of $C_E$.

We have the following short exact sequence

#math.equation(block: true, numbering: n => "(9.1)", $1 arrow.r E^times arrow.r E \( C_E \)^times arrow.r^("div") "Div" \( C_E \) arrow.r^(D mapsto cal(O) \( D \)) "Pic" \( C_E \) arrow.r 0$) <brauer-14-08-04-27-2022>
#statement("Lemma")[
There is an isomorphism of $bb(Z) G$-modules $ "Div" \( C_E \) = xor.big_(x in C^(\( 1 \))) (xor.big_(y in pi^(- 1) \( x \)) bb(Z) y) tilde.equiv xor.big_(x in C^(\( 1 \))) M_(G_y)^G \( bb(Z) \) $ Here $G_y$ is the stabilizer of $y$

]
#proof[
Look at the fiber over $x$, we may identify $bb(Z) G$-modules $ G \/ G_y = { sigma_1 \, dots.h.c \, sigma_r } arrow.r pi^(- 1) \( x \) = { y_1 \, dots.h.c \, y_r } \, quad sigma_i mapsto sigma_i y $ then we can define isomorphism

#math.equation(block: true, numbering: n => "(9.2)", $M_(G_y)^G \( bb(Z) \) = "Hom" \( bb(Z) G \, bb(Z) \) arrow.r xor.big_(i = 1)^r bb(Z) y_i \, quad f mapsto sum_(i = 1)^r f \( sigma_i \) y_i$) 
]
#statement("Example")[
$ pi^(- 1) \( x \) & = C_E times_C "Spec" k \( x \) = E times_k C times_C "Spec" k \( x \) = E times_k "Spec" k \( x \)\
 & = "Spec" \( k \( x \) times.o_k E \) = "Spec" (k \( x \) times.o_k frac(k \[ t \], \( f \( t \) \))) tilde.equiv "Spec" frac(k \( x \) \[ t \], f \( t \))\
 & = "Spec" (product_(i = 1)^r k \( x \) \[ t \] \/ \( h_i \( t \) \)) = product.co_(i = 1)^r "Spec" frac(k \( x \) \[ t \], \( h_i \( t \) \)) $

]
#statement("Example")[
$k = bb(Q)$, $E = bb(Q) \( i \, root(4, 2) \)$, $k \( x \) tilde.equiv bb(Q) \( sqrt(2) \)$ $ "Gal" \( E \/ k \) = chevron.l sigma \, tau \| tau^2 = e \, sigma^4 = e \, tau sigma tau = sigma^(- 1) chevron.r \, {sigma \( root(4, 2) = i root(4, 2) \)\
sigma \( i \) = i \, {tau \( root(4, 2) = root(4, 2) \)\
tau \( i \) = - i $ $ E = bb(Q) \[ x \] \/ \( x^8 - 4 x^6 + 8 x^4 - 4 x^2 + 1 \) $ $ k \( x \) times.o_k E = bb(Q) \( sqrt(2) \) \[ x \] \/ \( x^8 - 4 x^6 + 8 x^4 - 4 x^2 + 1 \) = frac(bb(Q) \( sqrt(2) \) \[ x \], \( h_1 \( x \) \)) times frac(bb(Q) \( sqrt(2) \) \[ x \], \( h_2 \( x \) \)) $ Here $h_1 \( x \) = x^4 + \( - sqrt(2) - 2 \) x^2 - 2 sqrt(2) + 3$, $h_2 \( x \) = x^4 + \( sqrt(2) - 2 \) x^2 + 2 sqrt(2) + 3$. The stabilizer is $H = chevron.l e \, sigma^2 \, tau \, sigma^2 tau chevron.r$

]
#statement("Definition")[
The #emph[residue map] $r_x^i \( y \)$ is defined to be $ H^i \( G \, E \( C_E \)^times \) & arrow.r H^i \( G \, "Div" \( C_E \) \) tilde.equiv xor.big_(x in C^(\( 1 \))) H^i \( G \, M_(G_y)^G \( bb(Z) \) \) tilde.equiv xor.big_(x in C^(\( 1 \))) H^i \( G_y \, bb(Z) \)\
 & tilde.equiv xor.big_(x in C^(\( 1 \))) H^(i - 1) \( G_y \, bb(Q) \/ bb(Z) \) arrow.r H^(i - 1) \( G_y \, bb(Q) \/ bb(Z) \) $

]
#statement("Lemma")[
For any $y \, z in pi^(- 1) \( x \)$, the residue maps $r_x^i \( y \) \, r_x^i \( z \)$ differ by a canonical isomorphism

]
#proof[
There exists $sigma in G$ such that $sigma y = z$, and $G_z = sigma G_y sigma^(- 1)$

]
#statement("Lemma", label: <brauer-13-06-04-29-2022>)[
The sequence

#block[
#diagram(
  columns: 7, rows: 1,
  nodes: (
    (0, 0, [$H^i \( G \, E \( E_E \)^times \)$]),
    (0, 1, []),
    (0, 2, []),
    (0, 3, [$xor.big_(x in C^(\( 1 \))) H^(i - 1) \( G_y \, bb(Q) \/ bb(Z) \)$]),
    (0, 4, []),
    (0, 5, []),
    (0, 6, [$H^(i - 1) \( G \, bb(Q) \/ bb(Z) \)$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 3), labels: ((body: [$xor.big_(x in C^(\( 1 \))) r_x^i \( y \)$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 6), labels: ((body: [$sum_(x in C^(\( 1 \))) d_y "cor"_G^(G_y)$], flipped: false),), kind: "arrow", bend: 0),
  ),
)
]
is a complex for $i gt.eq 2$, here $d_y = \[ E \( y \) : E \]$ is the degree of $y$

]
#proof[
We can split #ref(<brauer-14-08-04-27-2022>, supplement: none) into two exact sequences

#math.equation(block: true, numbering: n => "(9.3)", $1 arrow.r E^times arrow.r E \( C_E \)^times arrow.r E \( C_E \)^times \/ E^times arrow.r 1$) <brauer-00-30-04-48-2022>
#math.equation(block: true, numbering: n => "(9.4)", $1 arrow.r E \( C_E \)^times \/ E^times arrow.r "Div" \( C_E \) arrow.r "Pic" \( C_E \) arrow.r 0$) <brauer-00-31-04-48-2022>
Hence we get commutative diagram with the help of Lemma~#ref(<brauer-08-59-04-28-2022>, supplement: none)

#block[
#diagram(
  columns: 3, rows: 2,
  nodes: (
    (0, 0, [$H^i \( G \, E \( C_E \)^times \/ E^times \)$]),
    (0, 1, [$H^i \( G \, "Div" \( C_E \) \)$]),
    (0, 2, [$H^i \( G \, "Pic" \( C_E \) \)$]),
    (1, 0, [$H^i \( G \, E \( C_E \) \)^times$]),
    (1, 1, [$xor.big_(x in C^(\( 1 \))) H^i \( G_y \, bb(Z) \)$]),
    (1, 2, [$H^(i - 1) \( G \, bb(Q) \/ bb(Z) \) tilde.equiv H^i \( G \, bb(Z) \)$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (1, 1), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 2), to: (1, 2), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (1, 0), to: (0, 0), labels: (), kind: "arrow", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "arrow", bend: 0),
    (from: (1, 1), to: (1, 2), labels: (), kind: "arrow", bend: 0),
  ),
)
]
Looking at a single summand, the map reads $ H^i \( G \, "Div" \( C_E \) \) arrow.r H^i \( G \, M_(G_y)^G \( bb(Z) \) \) arrow.r H^i \( G_y \, bb(Z) \) arrow.r H^i \( G \, M_(G_y)^G \( bb(Z) \) \) arrow.r^(phi.alt_(*)) H^i \( G \, bb(Z) \) $ Recall $phi.alt : M_(G_y)^G \( bb(Z) \) = "Hom"_G \( bb(Z) \[ G \] \, bb(Z) \) arrow.r bb(Z)$ is defined via $phi.alt \( f \) = sum_(s in G \/ G_y) s f \( s^(- 1) e \)$

]
#statement("Lemma", label: <brauer-08-59-04-28-2022>)[
There is a commutative exact ladder

#block[
#diagram(
  columns: 6, rows: 2,
  nodes: (
    (0, 0, [$0$]),
    (0, 1, [$"Div"^0 \( C_E \)$]),
    (0, 2, [$"Div" \( C_E \)$]),
    (0, 3, [$bb(Z)$]),
    (0, 4, [$bb(Z) \/ d bb(Z)$]),
    (0, 5, [$0$]),
    (1, 0, [$0$]),
    (1, 1, [$"Pic"^0 \( C_E \)$]),
    (1, 2, [$"Pic" \( C_E \)$]),
    (1, 3, [$bb(Z)$]),
    (1, 4, [$bb(Z) \/ d bb(Z)$]),
    (1, 5, [$0$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (1, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: ((body: [$deg$], flipped: false),), kind: "arrow", bend: 0),
    (from: (0, 2), to: (1, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 4), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (1, 3), labels: (), kind: "equal", bend: 0),
    (from: (0, 4), to: (0, 5), labels: (), kind: "arrow", bend: 0),
    (from: (0, 4), to: (1, 4), labels: (), kind: "equal", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "arrow", bend: 0),
    (from: (1, 1), to: (1, 2), labels: (), kind: "arrow", bend: 0),
    (from: (1, 2), to: (1, 3), labels: (), kind: "arrow", bend: 0),
    (from: (1, 3), to: (1, 4), labels: (), kind: "arrow", bend: 0),
    (from: (1, 4), to: (1, 5), labels: (), kind: "arrow", bend: 0),
  ),
)
]
Here $deg (sum n_y y) = sum n_y \[ E \( y \) : E \]$

]
#proof[
Hartshorne chapter II, corollary 6.10

]
#statement("Example")[
$C = bb(P)_k^1$, $E \( C_E \) = E \( t \)^times$, $G = "Gal" \( E \/ k \) = "Gal" \( E \( t \) \/ k \( t \) \)$, then $ H^2 \( G \, E \( C_E \)^times \) tilde.equiv H^2 \( "Gal" \( E \( t \) \/ k \( t \) \) \, E \( t \)^times \) tilde.equiv "Br" \( E \( t \) \/ k \( t \) \) $ And our complex is

#block[
#diagram(
  columns: 3, rows: 1,
  nodes: (
    (0, 0, [$"Br" \( E \( t \) \/ k \( t \) \)$]),
    (0, 1, [$xor.big_(x in \( bb(P)_k^1 \)^(\( 1 \))) H^1 \( G_y \, bb(Q) \/ bb(Z) \)$]),
    (0, 2, [$H^1 \( G \, bb(Q) \/ bb(Z) \)$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
  ),
)
]
Let $p \( t \) in E \( t \)^times$, assume $E \/ k$ is cyclic with $chi : "Gal" \( E \/ k \) arrow.r bb(Z) \/ n bb(Z)$. Then $\[ \( chi \, p \( t \) \)^(o p) \]$ is given by the 2 cocycle $alpha : G times G arrow.r E \( t \)^times$, $alpha \( sigma^i \, sigma^j \) = 1$ if $i + j < n$, $p \( t \)$ otherwise.

The residue map just takes $"div" \( alpha \) = 0$, $\[ oo \] - \[ 0 \]$

]
#statement("Theorem")[
Assume $C = bb(P)_k^1$ such that $H^2 \( G \, E^times \) = H^3 \( G \, E^times \) = 0$ (This happens if $k$ is a finite field), then #ref(<brauer-13-06-04-29-2022>, supplement: none) is exact

]
#proof[
$"Pic" \( bb(P)_E^1 \) arrow.r_tilde.equiv^deg bb(Z)$, then we get a splitting in #ref(<brauer-00-31-04-48-2022>, supplement: none) with $1 mapsto \[ oo \]$.

so we get

#block[
#diagram(
  columns: 5, rows: 2,
  nodes: (
    (0, 0, [$0$]),
    (0, 1, [$H^2 \( G \, E \( C_E \)^times \/ E^times \)$]),
    (0, 2, [$H^2 \( G \, "Div" \( C_E \) \)$]),
    (0, 3, [$H^2 \( G \, bb(Z) \)$]),
    (0, 4, [$0$]),
    (1, 0, [$0$]),
    (1, 1, [$H^2 \( G \, E \( C_E \)^times \)$]),
    (1, 2, [$xor.big H^1 \( G_y \, bb(Q) bb(Z) \)$]),
    (1, 3, [$H^1 \( G \, bb(Q) \/ bb(Z) \)$]),
    (1, 4, [$0$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 4), labels: (), kind: "arrow", bend: 0),
    (from: (1, 0), to: (1, 1), labels: (), kind: "arrow", bend: 0),
    (from: (1, 1), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (1, 1), to: (1, 2), labels: (), kind: "arrow", bend: 0),
    (from: (1, 2), to: (0, 2), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
    (from: (1, 2), to: (1, 3), labels: (), kind: "arrow", bend: 0),
    (from: (1, 3), to: (1, 4), labels: (), kind: "arrow", bend: 0),
    (from: (1, 3), to: (0, 3), labels: ((body: [$tilde.equiv$], flipped: false),), kind: "arrow", bend: 0),
  ),
)
]
]
#statement("Lemma")[
For any curve $C \/ k$ as the in the set up $ H^2 \( G \, E \( C_E \)^times \) tilde.equiv H^2 \( "Gal" \( E \( C_E \) \/ k \( C \) \) \, E \( C_E \)^times \) tilde.equiv "Br" \( E \( C_E \) \/ k \( C \) \) $ Moreover, if $k$ is perfect $ "Br" \( k \( C \) \) = limits(attach(lim, b: arrow.r))_(E \/ k upright(" finite Galois")) "Br" \( E \( C_E \) \/ k \( C \) \) = limits(attach(lim, b: arrow.r))_(E \/ k upright(" finite Galois")) H^2 \( "Gal" \( E \( C_E \) \/ k \( C \) \) \, E \( C_E \)^times \) $

]
#proof[
The restriction $ "Gal" \( E \( C_E \) \/ k \( C \) \) arrow.r "Gal" \( E \/ k \) \, phi mapsto phi \|_E $ is an isomorphism. This gives the first part. Suppose $k < E < F$ are all finite Galois, then we have inclusion $ "Br" \( E \( C_E \) \/ k \( C \) \) arrow.r "Br" \( F \( C_F \) \/ k \( C \) \) $ And all these map to $"Br" \( k \( C \) \)$, surjective since any CSA/$k$, say $A$ is split over $macron(k) \( C_(macron(k)) \)$ by Tsen's theorem~#ref(<brauer-Tsen-theorem>, supplement: none). This proves the moreover part

]
#statement("Example")[
$"Br" \( bb(F)_3 \( t \) \) eq.not 0$, Take $k = bb(F)_3$, $E = bb(F)_27$, $C = bb(P)_k^1$, we get split exact sequence

#block[
#diagram(
  columns: 5, rows: 1,
  nodes: (
    (0, 0, [$0$]),
    (0, 1, [$"Br" \( bb(F)_27 \( t \) \/ bb(F)_3 \( t \) \)$]),
    (0, 2, [$xor.big H^1 \( G_y \, bb(Q) \/ bb(Z) \)$]),
    (0, 3, [$H^1 \( G \, bb(Q) \/ bb(Z) \)$]),
    (0, 4, [$0$]),
  ),
  edges: (
    (from: (0, 0), to: (0, 1), labels: (), kind: "arrow", bend: 0),
    (from: (0, 1), to: (0, 2), labels: (), kind: "arrow", bend: 0),
    (from: (0, 2), to: (0, 3), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 4), labels: (), kind: "arrow", bend: 0),
    (from: (0, 3), to: (0, 2), labels: (), kind: "arrow", bend: 1),
  ),
)
]
So $"Br" \( bb(F)_27 \( t \) \/ bb(F)_3 \( t \) \) tilde.equiv xor.big_(x in bb(A)_k^1) H^1 \( G_y \, bb(Q) \/ bb(Z) \) = xor.big_(x in bb(A)_k^1 \, y^3 - y - 1 upright(" doesn't split in ") k \( x \)) bb(Z) \/ 3 bb(Z)$

For every point $x in bb(A)_k^1$ with $k \( x \) = bb(F)_3$, the local ring $cal(O)_(bb(A)^1 \, x)$ can be completed to $hat(cal(O)_(bb(A)^1 \, x))$ with fraction field $bb(F)_3 \( \( lambda \) \)$, where $lambda$ is a uniformizer of $cal(O)_(bb(A)^1 \, x)$, the map $O_(bb(A)^1 \, x) arrow.r hat(O_(bb(A)^1 \, x))$ induces $F \( t \) arrow.r F \( \( lambda \) \)$, giving $"Br" \( bb(F)_27 \( t \) \/ bb(F)_3 \( t \) \) arrow.r "Br" \( bb(F)_27 \( \( lambda \) \) \/ bb(F)_3 \( \( lambda \) \) \) tilde.equiv bb(Z) \/ 3 bb(Z)$

]
