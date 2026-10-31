#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH744 - Lie Groups I", author: "Haoran Li")
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

#let aside(name, title: none, body) = block(breakable: true)[*#name#if title != none [ (#title)].* #body]
#let numbered-equation(body) = math.equation(block: true, numbering: number => context numbering("1.1", counter(heading).get().first(), number), body)
#show heading.where(level: 1): it => { counter(math.equation).update(0); it }
#let svg-drawing(body, width: 85%, height: 180) = align(center, image(bytes("<svg xmlns='http://www.w3.org/2000/svg' width='440' height='" + str(height) + "' viewBox='0 0 440 " + str(height) + "'><defs><marker id='a' markerWidth='6' markerHeight='6' refX='5' refY='3' orient='auto'><path d='M0 0L6 3L0 6' fill='none' stroke='black'/></marker></defs><g fill='none' stroke='black' stroke-width='1.2'>" + body + "</g></svg>"), width: width))
#let sampled-path(fn, start: 0, stop: 2 * calc.pi, steps: 120) = range(steps + 1).map(index => { let point = fn(start + (stop - start) * index / steps); (if index == 0 { "M" } else { "L" }) + str(point.at(0)) + " " + str(point.at(1)) }).join(" ")


#align(center)[
#set par(justify:false)
#v(1cm)
#text(size:22pt,weight:"bold")[MATH744 - Lie Groups I]
#v(2cm)
#image("Pictures/Sophus_Lie.jpg",width:50%)
#v(2cm)
Taught by Jeffrey Adams \
Notes taken by Haoran Li \
2019 Fall
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Matrix groups
<matrix-groups>
#statement("Definition")[
The exact sequence

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1$]),
node((1,0),[$A$]),
node((2,0),[$B$]),
node((3,0),[$C$]),
node((4,0),[$1$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->",[$phi.alt$]),
edge((3,0),(4,0),"->"),
edge((3,0),(2,0),"->",[$s$],stroke:(dash:"dashed"),bend:-15deg))]
]
split if there exists $s : C arrow.r B$ such that $phi.alt s = 1_C$ which is equivalent of saying that $B = C times.l A$

]
#statement("Lemma")[
- $e^0 = I$

- $\(e^X\)^T = e^(X^T)$

- $overline(e^X) - e^(overline(X))$

- $\(e^X\)^(- 1) = e^(- X)$

- $g e^X g^(- 1) = e^(g X g^(- 1))$

- $frac(d, d t) e^(t X) = X e^(t X)$

]
#statement("Theorem")[
$phi.alt_X : bb(R) arrow.r "GL"\(n\,bb(C)\)$, $t mapsto e^(t X)$ is a group homomorphism. Conversely, any group homomorphism $phi.alt : bb(R) arrow.r "GL"\(n\,bb(C)\)$ is of the form $phi.alt_X$ for some $X in M_n\(bb(C)\)$

]
#statement("Definition")[
$G$ is a Lie group, the Lie algebra is #math.equation(block: true, numbering: none, $"Lie"\(G\) & = { X in M_n\(bb(C)\)\|e^(t X) in G\,forall t in bb(R) }\
 & = { X in M_n\(bb(C)\)\|"im" phi.alt_X subset.eq G }$)

]
#pagebreak(weak:true)
= Homeworks
<homeworks>
== Homework1
<homework1>
#statement("Exercise")[
Let $G = O\(2\,bb(R)\)$ be the (real) orthogonal group in dimension 2

+ Show that $"SO"\(2\,bb(R)\)$ is isomorphic to the circle $S^1$

+ Show that $O\(2\,bb(R)\)$ has two connected components, and is not abelian

+ Show that ${ g in O\(2\,bb(R)\)\|det g = - 1 }$ is a single conjugacy class

+ Show there is an exact sequence $1 arrow.r "SO"\(2\)arrow.r O\(2\)arrow.r bb(Z)\/2 bb(Z) arrow.r 1$. Is this sequence split

]
#proof(title: "Solution")[
+ Suppose $g = (mat(delim:#none, a, b; c, d)) in S O\(2\,bb(R)\)$, then #math.equation(block: true, numbering: none, $(mat(delim:#none, 1, 0; 0, 1)) = (mat(delim:#none, a, b; c, d)) (mat(delim:#none, a, c; b, d)) = (mat(delim:#none, a^2 + b^2, a c + b d; a c + b d, c^2 + d^2)) arrow.r.double cases(a^2 + b^2 = 1, a c + b d = 0, c^2 + d^2 = 1)$) we can find $0 lt.eq theta - phi lt.eq 2 pi$ such that $cases(a = cos theta, b = sin theta, c = cos phi, d = sin phi)$ \ then $0 = cos theta cos phi + sin theta sin phi = cos theta - phi$, hence $theta - phi = pi / 2$ or $frac(3 pi, 2)$

  hence if $theta - phi = pi / 2$, $g = (mat(delim:#none, cos theta, sin theta; sin theta, - cos theta))$, $det g = 1$, if $theta - phi = frac(3 pi, 2)$, $g = (mat(delim:#none, cos theta, sin theta; - sin theta, cos theta))$, $det g = 1$, thus $phi.alt : S^1 arrow.r S O\(2\,bb(R)\)$, $theta mapsto (mat(delim:#none, cos theta, sin theta; - sin theta, cos theta))$ is an isomorphism

+ From the analysis in (a), all matrices of form ${(mat(delim:#none, cos theta, sin theta; sin theta, - cos theta))} = O\(2\,bb(R)\)\\S O\(2\,bb(R)\)$ is path-connected, and all matrices of form ${(mat(delim:#none, cos theta, sin theta; - sin theta, cos theta))} = S O\(2\,bb(R)\)$ is also path-connected, but $O\(2\,bb(R)\)$ is not path-connected since $det : O\(2\,bb(R)\)arrow.r bb(R)$ is a continuous function but the image is ${ plus.minus 1 }$ is not connected, thus $O\(2\,bb(R)\)$ has two connected components #math.equation(block: true, numbering: none, $(mat(delim:#none, sqrt(2) / 2, sqrt(2) / 2; - sqrt(2) / 2, sqrt(2) / 2)) (mat(delim:#none, 1, 0; 0, - 1)) = (mat(delim:#none, sqrt(2) / 2, - sqrt(2) / 2; - sqrt(2) / 2, - sqrt(2) / 2)) eq.not (mat(delim:#none, sqrt(2) / 2, sqrt(2) / 2; sqrt(2) / 2, - sqrt(2) / 2)) = (mat(delim:#none, 1, 0; 0, - 1)) (mat(delim:#none, sqrt(2) / 2, sqrt(2) / 2; - sqrt(2) / 2, sqrt(2) / 2))$) hence $O\(2\,bb(R)\)$ is not abelian

+ $(mat(delim:#none, 1, 0; 0, - 1)) (mat(delim:#none, cos theta, sin theta; - sin theta, cos theta)) = (mat(delim:#none, cos theta, sin theta; sin theta, - cos theta))$ hence $O\(2\,bb(R)\)\\S O\(2\,bb(R)\)$ is a single conjugacy class

+ Notice $det : O\(2\,bb(R)\)arrow.r bb(Z)\/2 bb(Z) tilde.equiv { plus.minus 1\,upright("multiplication") }$ is a surjective group homomorphism with kernel $S O\(2\,bb(R)\)$, hence #align(center)[#set text(size:7pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$1$]),
  node((1,0),[$S O\(2\,bb(R)\)$]),
  node((2,0),[$O\(2\,bb(R)\)$]),
  node((3,0),[$bb(Z)\/2 bb(Z)$]),
  node((4,0),[$1$]),
  edge((0,0),(1,0),"->"),
  edge((1,0),(2,0),"hook->"),
  edge((2,0),(3,0),"->",[$det$]),
  edge((3,0),(4,0),"->"))] is an exact sequence \ There is a map $mu : bb(Z)\/2 bb(Z) arrow.r O\(2\,bb(R)\)$, $macron(1) mapsto (mat(delim:#none, 1, 0; 0, - 1))$ which is a homomorphism such that $det compose mu = 1$, hence the exact sequence splits

]
#statement("Exercise")[

]
#strong[\(a)]

Suppose $g = (mat(delim:#none, a, b; c, d)) in S O\(1\,1\)$, then #math.equation(block: true, numbering: none, $(mat(delim:#none, 1, 0; 0, 1)) = (mat(delim:#none, a, b; c, d)) (mat(delim:#none, 1, 0; 0, - 1)) (mat(delim:#none, a, c; b, d)) = (mat(delim:#none, a^2 + b^2, a c + b d; a c + b d, c^2 + d^2)) arrow.r.double cases(a^2 - b^2 = 1, a c - b d = 0, c^2 - d^2 = - 1)$) we can find $x\,y in bb(R)$ such that $cases(b = sinh x, c = sinh y)$, and $cases(a = cosh x, d = cosh y)$ or $cases(a = - cosh x, d = cosh y)$ or $cases(a = cosh x, d = - cosh y)$ or $cases(a = - cosh x, d = - cosh y)$

then #math.equation(block: true, numbering: none, $0 = cosh x sinh y - sinh x cosh y = sinh\(y - x\) arrow.l.r.double y = x\,upright("or")$) #math.equation(block: true, numbering: none, $0 = - cosh x sinh y - sinh x cosh y = - sinh\(x + y\) arrow.l.r.double y = - x\,upright("or")$) #math.equation(block: true, numbering: none, $0 = cosh x sinh y + sinh x cosh y = sinh\(x + y\) arrow.l.r.double y = - x\,upright("or")$) #math.equation(block: true, numbering: none, $0 = - cosh x sinh y + sinh x cosh y = sinh\(x - y\) arrow.l.r.double y = x$)

then $det g = 1\,- 1\,- 1\,1$ correspondingly, hence $g$ can only be $(mat(delim:#none, cosh x, sinh x; sinh x, cosh x))$ or $(mat(delim:#none, - cosh x, sinh x; sinh x, - cosh x))$, consider $phi.alt : bb(R)^(*) arrow.r S O\(1\,1\)$, #math.equation(block: true, numbering: none, $x mapsto cases((mat(delim:#none, cosh (ln x), sinh (ln x); sinh (ln x), cosh (ln x)))\,x > 0, (mat(delim:#none, - cosh (ln (frac(1, - x))), sinh (ln (frac(1, - x))); sinh (ln (frac(1, - x))), - cosh (ln (frac(1, - x)))))\,x < 0)$) is an isomorphism easily by checking 4 cases

#strong[\(b)]

Notice $det : O\(1\,1\)arrow.r bb(Z)\/2 bb(Z) tilde.equiv { plus.minus 1\,upright("multiplication") }$ is a surjective group homomorphism with kernel $S O\(1\,1\)$, hence $O\(1\,1\)\/S O\(1\,1\)tilde.equiv bb(Z)\/2 bb(Z)$

#strong[\(c)]

Notice $phi.alt$ from (a) is continuous, hence $O\(1\,1\)^0 = {(mat(delim:#none, cosh x, sinh x; sinh x, cosh x))}$, and $frac(x, \|x\|) : bb(R)^(*) arrow.r bb(Z)\/2 bb(Z) tilde.equiv { plus.minus 1\,upright("multiplication") }$ is a surjective group homomorphism with kernel $bb(R)_(> 0)$, hence $S O\(1\,1\)\/O\(1\,1\)^0 tilde.equiv bb(R)^(*)\/bb(R)_(> 0)$, $lr(|O \( 1 \, 1 \) \/ O \( 1 \, 1 \)^0|) = [O \( 1 \, 1 \) : S O \( 1 \, 1 \)] [S O \( 1 \, 1 \) : O \( 1 \, 1 \)^0] = 4$, hence it is isomorphic to either $bb(Z)\/4 bb(Z)$ or $bb(Z)\/2 bb(Z) times bb(Z)\/2 bb(Z)$, but $- I\,J\,- J in O\(1\,1\)\/O\(1\,1\)^0$ are of order 2 and $\(- I\)J = - J\,\(- I\)\(- J\)= J\,J\(- J\)= - I$, thus the component group $O\(1\,1\)\/O\(1\,1\)^0 tilde.equiv bb(Z)\/2 bb(Z) times bb(Z)\/2 bb(Z)$

#statement("Exercise")[

]
#strong[\(a)]

Here $J in G L\(n\,bb(C)\)$, $G_J = { g in G L\(n\,bb(C)\)\|g^T J g = J } = { g in G L\(n\,bb(C)\)\|g^T = J g^(- 1) J^(- 1) }$, $G_I = { g in G L\(n\,bb(C)\)\|g^T g = I } = { g in G L\(n\,bb(C)\)\|g^T = g^(- 1) }$, since $J$ is symmetric, $exists P in G L\(n\,bb(C)\)$ such that $P J P^T = I$\(corresponding to changing of basis), then we have $P G_J P^(- 1) = G_I$ since $forall g in G_J$, we have $J g^T J^(- 1) = g^(- 1)$, then $\(P g P^(- 1)\)^(- 1) = P g^(- 1) P^(- 1) = P J g^T J^(- 1) P^(- 1) = P J P^T\(P^T\)^(- 1) g^T P^T\(P^T\)^(- 1) J^(- 1) P^(- 1) =\(P J P^T\)\(P g P^(- 1)\)^T\(P J P^T\)^(- 1) =\(P g P^(- 1)\)^T$, hence $P g P^(- 1) in G_I$, thus $G_J$ and $O\(n\,bb(C)\)$ are conjugate in $G L\(n\,bb(C)\)$

#strong[\(b)]

Let $K = (mat(delim:#none, quad, 1; 1, quad))$, then $(mat(delim:#none, a, quad; quad, b)) (mat(delim:#none, quad, 1; 1, quad)) (mat(delim:#none, a, quad; quad, b)) = (mat(delim:#none, quad, 1; 1, quad))$ which gives $a b = 1$, if $n$ is even, let $J = (mat(delim:#none, K, quad, quad; quad, dots.down, quad; quad, quad, K))$, then the diagonal subgroup of $G_J$ is isomorphic to $bb(C)^(* n / 2) = bb(C)^(* ⌊n / 2⌋)$, if $n$ is odd, if $J = (mat(delim:#none, K, quad, quad, quad; quad, dots.down, quad, quad; quad, quad, K, quad; quad, quad, quad, 0))$, then the diagonal subgroup of $G_J$ is isomorphic to $bb(C)^(* ⌊n / 2⌋)$, if $J = (mat(delim:#none, K, quad, quad, quad; quad, dots.down, quad, quad; quad, quad, K, quad; quad, quad, quad, 1))$, then the diagonal subgroup of $G_J$ is isomorphic to $bb(C)^(* ⌊n / 2⌋) times bb(Z)\/2 bb(Z)$ which contains a subgroup isomorphic to $bb(C)^(* ⌊n / 2⌋)$

#strong[\(c)]

By (a) and (b), we know that $O\(n\,bb(C)\)$ contains a subgroup isomorphic to $bb(C)^(* ⌊n / 2⌋)$

#strong[\(d)]

If $A in upright(L i e)$, then $e^(t A) in O\(n\,bb(C)\)$, $e^(t A^T) = (e^(t A))^T = (e^(t A))^(- 1) = e^(- t A)$, then $A^T = frac(d e^(t A^T), d t)\|_(t = 0) = frac(d e^(- t A), d t)\|_(t = 0) = - A$, hence $upright(L i e) (O \( n \, bb(C) \)) = { A in M_n\(bb(C)\)parallel A^T = - A }$, $dim upright(L i e) (O \( n \, bb(C) \)) = frac(n\(n - 1\), 2)$

#statement("Exercise")[

]
#strong[\(a)]

#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1$]),
node((1,0),[$S L\(n\,bb(C)\)$]),
node((2,0),[$G L\(n\,bb(C)\)$]),
node((3,0),[$bb(C)^(*)$]),
node((4,0),[$1$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"hook->"),
edge((2,0),(3,0),"->",[$det$]),
edge((3,0),(4,0),"->"))] is an exact sequence

#strong[\(b)]

#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1$]),
node((1,0),[$bb(C)^(*)$]),
node((2,0),[$G L\(n\,bb(C)\)$]),
node((3,0),[$P G L\(n\,bb(C)\)$]),
node((4,0),[$1$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"hook->",[$a mapsto a I$]),
edge((2,0),(3,0),"->",[$q$]),
edge((3,0),(4,0),"->"))] is an exact sequence, where $q$ is the quotient map

#strong[\(c)]

$S L\(n\,bb(C)\)arrow.r G L\(n\,bb(C)\)$ pass to $P S L\(n\,bb(C)\)arrow.r P G L\(n\,bb(C)\)$ by quotient map, for $A Z in P G L\(n\,bb(C)\)$, $A / root(n, det A) Z mapsto A Z$, hence the map is surjective, if $A Z in P S L\(n\,bb(C)\)$, and $A in Z\(P G L\(n\,bb(C)\)\)$, then $A = a I$, for some $a eq.not 0$, but since $A in S L\(n\,bb(C)\)$, $1 = det A$, $A in Z\(P S L\(n\,bb(C)\)\)$, hence the map is also injective

#strong[\(d)]

When $n$ is odd, the previous argument still works, namely $P S L\(n\,bb(R)\)tilde.equiv P G L\(n\,bb(R)\)$, when $n = 2 k$ is even, the injectivity still works, however, for $a I\,A in G L\(n\,bb(R)\)$, $det\(a I dot.op A\)= a^(2 k) det A$ has the same sign as $det A$, thus there is an exact sequence #align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1$]),
node((1,0),[$P S L\(n\,bb(R)\)$]),
node((2,0),[$P G L\(n\,bb(R)\)$]),
node((3,0),[$bb(Z)\/2 bb(Z)$]),
node((4,0),[$1$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"hook->"),
edge((2,0),(3,0),"->",[$det$]),
edge((3,0),(4,0),"->"))]

#statement("Exercise")[

]
#strong[\(a)]

If $g = (mat(delim:#none, alpha, beta; gamma, xi)) in S U\(2\)$, then #math.equation(block: true, numbering: none, $I = g g^(*) = (mat(delim:#none, alpha, beta; gamma, xi)) (mat(delim:#none, macron(alpha), macron(gamma); macron(beta), macron(xi))) = (mat(delim:#none, \|alpha\|^2 +\|beta\|^2, alpha macron(gamma) + beta macron(xi); macron(alpha) gamma + macron(beta) xi, \|gamma\|^2 +\|xi\|^2))$) Hence $cases(\|alpha\|^2 +\|beta\|^2 = 1, alpha macron(gamma) + beta macron(xi) = 0, \|gamma\|^2 +\|xi\|^2)$, and also $1 = det g = alpha xi - beta gamma$

If $gamma = 0$, then $\|alpha\|=\|xi\|= 1$, $beta = 0$, $alpha xi = 1 arrow.r.double xi = macron(alpha)$

If $gamma = 0$, then $alpha = - frac(beta macron(xi), macron(gamma))$, $beta = 0$, then $1 = - frac(beta\|xi\|^2, macron(gamma)) - beta gamma arrow.r.double - macron(gamma) = beta$, hence $alpha = macron(xi)$

#strong[\(b)]

Since $S^3 subset.eq bb(C)^2 = {\|alpha\|^2 +\|beta\|^2 = 1 }$ which is the same zero set, thus $S U\(2\)$ is topologically equivalent to $S^3$, and is therefore 3-dimensional, connected and simply connected

#strong[\(c)]

#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1$]),
node((1,0),[$S U\(2\)$]),
node((2,0),[$U\(2\)$]),
node((3,0),[$S^1$]),
node((4,0),[$1$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"hook->"),
edge((2,0),(3,0),"->",[$det$]),
edge((3,0),(4,0),"->"))] is an exact sequence, there is a map $mu : S^1 arrow.r U\(2\)$, $z mapsto (mat(delim:#none, 1, 0; 0, z))$ which is a homomorphism such that $det compose mu = 1$, hence the exact sequence splits

#strong[\(d)]

#math.equation(block: true, numbering: none, $(mat(delim:#none, alpha, beta; gamma, xi)) + (mat(delim:#none, macron(alpha), macron(gamma); macron(beta), macron(xi))) = (mat(delim:#none, alpha + macron(alpha), beta + macron(gamma); gamma + macron(beta), xi + macron(xi))) = (mat(delim:#none, 0, 0; 0, 0)) arrow.r.double alpha + macron(alpha) = xi + macron(xi) = gamma + macron(beta) = 0$) and $0 = t r g = alpha + xi$, thus $xi = - alpha in i bb(R)$ and $gamma = - macron(beta)$, hence $W$ is a 3-dimensional real vector space of the form ${(mat(delim:#none, i x, y + i z; - y + i z, - i x)) \| x \, y \, z in bb(R)}$ and $t r ((mat(delim:#none, i x_1, y_1 + i z_1; - y_1 + i z_1, - i x_1)) (mat(delim:#none, i x_2, y_2 + i z_2; - y_2 + i z_2, - i x_2))) = - 2\(x_1 x_2 + y_1 y_2 + z_1 z_2\)$ is a definite symmetric bilinear form

#strong[\(e)]

$forall g in S U\(2\)$, $g^(*) = g^(- 1)$, $X\,Y in W$, $g X g^(- 1) +\(g X g^(- 1)\)^(*) = g X g^(- 1) + g X * g^(*) = g\(X + X^(*)\)g^(*) = 0$, $t r\(g X g^(- 1)\)= t r\(X\)= 0$, $\(g X g^(- 1)\,g Y g^(- 1)\)= t r\(g X g^(- 1) g Y g^(- 1)\)= t r\(g X Y g^(- 1)\)= t r\(X Y\)=\(X\,Y\)$, hence $S U\(2\)$ acts on $W$ by conjugation, preserving the form

#strong[\(f)]

By calculation in (d), $chevron.l X\,Y chevron.r := 1 / 2 t r\(X Y\)$ will be the standard inner product in $bb(R)^3$, and $S U\(2\)$ still acts on $W$ by conjugation, preserving the form, this can be regarded as a continuous homomorphism $phi : S U\(2\)arrow.r O\(3\)$, since $S U\(2\)$ is connected by (b), hence $phi$ is actually a continuous homomorphism from $S U\(2\)$ to $S O\(3\)$, now compute its kernel #math.equation(block: true, numbering: none, $(mat(delim:#none, i x, 0; 0, - i x)) = (mat(delim:#none, alpha, beta; - macron(beta), macron(alpha))) (mat(delim:#none, i x, 0; 0, - i x)) (mat(delim:#none, macron(alpha), - beta; macron(beta), alpha)) = i x (mat(delim:#none, \|alpha\|^2 -\|beta\|^2, - 2 alpha beta; - 2 macron(alpha) macron(beta), \|beta\|^2 -\|alpha\|^2)) arrow.r.double cases(beta = 0, \|alpha\|^2 = 1)$) and #math.equation(block: true, numbering: none, $(mat(delim:#none, quad, gamma; - macron(gamma), quad)) = (mat(delim:#none, alpha, quad; quad, macron(alpha))) (mat(delim:#none, quad, gamma; - macron(gamma), quad)) (mat(delim:#none, macron(alpha), quad; quad, alpha)) = (mat(delim:#none, quad, alpha^2 gamma; - macron(alpha)^2 macron(gamma), quad)) arrow.r.double alpha^2 = 1 arrow.r.double alpha = plus.minus 1$) Thus we have the exact sequence

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$1$]),
node((1,0),[$bb(Z)\/2 bb(Z)$]),
node((2,0),[$S U\(2\)$]),
node((3,0),[$S O\(3\)$]),
node((4,0),[$1$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->",[$phi$]),
edge((3,0),(4,0),"->"))]
]
#statement("Exercise")[
Let $G = "GL"\(2\,bb(F)_q\)$

+ Show that $G$ acts transitively on $X = bb(F)_2^2 - {\(0\,0\)}$

+ Show that the stabilizer of a point has order $q\(q - 1\)$

+ Show there is a bijection $G\/H arrow.l.r X$

+ Show that $\|"GL"\(2\,bb(F)_q\)\|=\(q + 1\)q\(q - 1\)^2$

+ What is the order of $"PGL"\(2\,bb(F)_q\)\|$? How about $"PGL"\(2\,bb(F)_5\)$

+ #emph[Extra credit]: Show that $"PGL"\(2\,bb(F)_q\)tilde.equiv A_5$

]
#proof(title: "Solution")[
+ $forall\(x\,y\)in X$, if $x = 0$, then $(mat(delim:#none, 0, 1; y, 0)) (mat(delim:#none, 1; 0)) = (mat(delim:#none, 0; y))$, if $x eq.not 0$, then $(mat(delim:#none, x, 0; y, 1)) (mat(delim:#none, 1; 0)) = (mat(delim:#none, x; y))$, hence $(mat(delim:#none, 1; 0))$ can move to any point in $X$ by an action of $G$, hence $G$ acts transitively on $X$

+ If $(mat(delim:#none, 1; 0)) = (mat(delim:#none, a, b; c, d)) (mat(delim:#none, 1; 0)) = (mat(delim:#none, a; c)) arrow.r.double cases(a = 1, c = 0)$, and since $0 eq.not det g = a d - b c = d$, hence $\|H\|= q\(q - 1\)$

+ Consider $phi : G\/H arrow.r X$, $g H mapsto g (mat(delim:#none, 1; 0))$ which is well-defined, and surjectivity follows from (a), injectivity follows from the fact if $g (mat(delim:#none, 1; 0)) = g' (mat(delim:#none, 1; 0))$, then $g^(- 1) g' (mat(delim:#none, 1; 0)) = (mat(delim:#none, 1; 0)) arrow.r.double g^(- 1) g' in H$, hence $phi$ is bijective

+ Because of (c), $\|G\|=\|G\/H\|\|H\|=\|X\|\|H\|=\(q^2 - 1\)q\(q - 1\)=\(q + 1\)q\(q - 1\)^2$

+ Since $Z = { a I\|a eq.not 0 }$, $\|Z\|= q - 1$, $\|P G L\(2\,bb(F)_q\)\|=\|G\|\/\|Z\|=\(q + 1\)q\(q - 1\)$, in particular, $\|P G L\(2\,bb(F)_5\)\|= 120$

+ From group action $G L\(2\,bb(F)_4\)$ on $bb(F)_4^2\\{\(0\,0\)}$, we can pass to a group action $P G L\(2\,bb(F)_4\)$ on $P bb(F)_4$, this action is faithful since for $g = (mat(delim:#none, a, b; c, d))$, if $c eq.not 0$, $g (mat(delim:#none, 1; 0)) = (mat(delim:#none, a; c)) eq.not (mat(delim:#none, 1; 0))$ in $P bb(F)_4$, if $b eq.not 0$, $g (mat(delim:#none, 0; 1)) = (mat(delim:#none, b; d)) eq.not (mat(delim:#none, 0; 1))$ in $P bb(F)_4$, hence $b = c = 0$, if $a eq.not d$, $g (mat(delim:#none, 1; 1)) = (mat(delim:#none, a; d)) eq.not (mat(delim:#none, 1; 1))$ in $P bb(F)_4$, hence $g in Z$, thus we get a injective group #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$P G L\(2\,bb(F)_4\)$]),
  node((1,0),[$S_5$]),
  edge((0,0),(1,0),"hook->"))] since $\|P bb(F)_4\|= 5$, but $\|P G L\(2\,bb(F)_4\)\|= 60$, $\|S_5\|= 120$, any subgroup of $S_5$ of order $60$ should be normal, intersection of normal subgroups is again a normal subgroup, but $A_5$ is a simple group, hence $A_5$ is the only subgroup of $S_5$ of order $60$, thus $P G L\(2\,bb(F)_4\)tilde.equiv A_5$

  Note that $G = "PGL"\(2\,bb(F)_5\)$ has exactly 5 5-Sylow subgroups, and it acts by conjugation on this set of 5 elements. The resulting map $G arrow.r S_5$ is injective, and has image $A_5$. Also $"PGL"\(2\,bb(F)_5\)$ as on the projective plane over $bb(F)_5$, which has 6 elements. This gives a homomorphism $G arrow.r S_6$. Now $S_6$ has an outer automorphism (unique among symmetric groups), which takes an "obvious" $S_5$ subgroup (fixing one point of the 6 element set) to a subgroup not fixing any elements of the set. The even permutations in the image give $A_5$

]
#statement("Exercise")[

]
#proof(title: "Solution")[
+ By Jordan normal form theorem, $forall g in G L\(n\,bb(C)\)$, $g$ can be decomposed uniquely as $S U = U S$ where $S$ is semisimple and $U$ is unipotent, thus $log U = sum_(m = 1)^oo frac(\(- 1\)^(m + 1)\(U - I\)^m, m)$ is actually a finite sum, so is $e^(log U)$, now consider $U\(t\)= I + t\(U - I\)$, when $t$ is small, $e^(log U\(t\)) = U\(t\)$, and since $e^(log U\(t\)) - U\(t\)$ is a matrix with entries polynomials in $t$, $e^(log U\(t\)) = U\(t\)\,forall t$, in particular, $e^(log U) = U$, the general case follows by dividing $g$ into Jordan blocks

+ The image of then exponential map from $M_n\(bb(R)\)$ to $G L\(n\,bb(R)\)$ is ${ A in G L\(n\,bb(R)\)\|det A\|U > 0\,U upright(" is any A invariant space") }$, notice that $det e^(A\|U) = e^(t r A\|U) > 0$, $R_theta = (mat(delim:#none, cos theta, sin theta; - sin theta, cos theta)) = exp (mat(delim:#none, quad, theta; - theta, quad))$, for any $A in G L\(n\,bb(R)\)$ with $det A > 0$, $A$ can be written in real Jordan canonical form, and then a Jordan block can be written as $S U = U S$, $U$ is unipotent, and $S$ is diagonalizable with real numbers or $R_theta$'s, for negative diagonal numbers we can pair them up and notice $R_pi = (mat(delim:#none, - 1, quad; quad, - 1)) = exp (mat(delim:#none, quad, pi; - pi, quad))$, thus $A$ is in the image of the exponential map

]
#pagebreak(weak:true)
== Homework2
<homework2>
#statement("Exercise")[
Show that if $phi.alt : frak(g) arrow.r frak(g)'$ is a Lie algebra homomorphism then $ker\(phi.alt\)$ is an ideal in $frak(g)$. How about the converse?

]
#proof(title: "Solution")[
$ker phi.alt$ is evidently a vector space, and $forall X in ker phi.alt\,Y in frak(g)$, we have $phi.alt\(\[X\,Y\]\)=\[phi.alt\(X\)\,phi.alt\(Y\)\]= 0 arrow.r.double\[X\,Y\]in ker phi.alt$, thus $ker phi.alt$ is an ideal. The converse is not true, since we can easily find an injection $phi.alt$ such that it is a vector space homomorphism but not a Lie algebra homomorphism

On the other hand, if the converse is true, if $frak(h)$ is an ideal in $frak(g)$, we can define Lie algebra homomorphism the quotient map $pi : frak(g) arrow.r frak(g)\/frak(h)$ which have kernel $frak(h)$

]
#statement("Exercise")[
Prove: if $G$ is a connected Lie group and $H$ is a connected Lie subgroup then $H$ is normal in $G$ if and only if $"Lie"\(H\)$ is an ideal in $"Lie"\(G\)$

]
#proof(title: "Solution")[
Suppose $G$ is a connected matrix group, $H lt.eq G$ is a connected subgroup, $frak(h)\,frak(g)$ are their corresponding Lie algebras, then by Lie subgroup-Lie subalgebra correspondence, we know that $G$ and $H$ consists of elements of the form ${e^(X_1) e^(X_2) dots.h.c e^(X_n) \| X_i in frak(g)}$ and ${e^(Y_1) e^(Y_2) dots.h.c e^(Y_m) \| Y_i in frak(h)}$, to show $H lt.eq G$, we only need to show $e^X e^Y e^(- X) in H\,X in frak(g)\,Y in frak(h)$, since then $e^(X_1) dots.h.c e^(X_n) e^Y e^(- X_n) dots.h.c e^(- X_1) in H\,Y in frak(h)$ and $e^(X_1) dots.h.c e^(X_n) e^(Y_1) dots.h.c e^(Y_m) e^(- X_n) dots.h.c e^(- X_1)\,Y_i in frak(h)$, notice $e^X e^Y e^(- X) = e^(e^X Y e^(- X)) = e^(A d_(e^Y)\(X\)) = e^(e^(a d_Y)\(X\))$, where $e^(a d_Y)\(X\)= X + a d_Y\(X\)+ frac(a d_Y^2, 2)\(X\)+ dots.h.c in frak(h)$ since $frak(h)$ is an ideal in $frak(g)$ which is certainly a closed subspace because they are finite dimensional, thus $e^(e^(a d_Y)\(X\)) in H$ \ Conversely, if $H lt.eq G$, then $e^X e^(t Y) e^(- X) = e^(t e^X Y e^(- X)) in H\,forall t in bb(R)\,X in frak(g)\,Y in frak(h)$, thus $e^X Y e^(- X) in frak(h)$, then $e^(t X) Y e^(- t X) in frak(h)\,forall t in bb(R)$, so we have $frac(d, d t)\|_(t = 0) e^(t X) Y e^(- t X) =\[X\,Y\]in frak(h)$, therefore $frak(h) lt.eq frak(g)$ is an ideal

]
#statement("Exercise")[

]
#proof(title: "Solution")[
Let $frak(g)_0 = bb(R)$ be a real Lie algebra of dimension 1 with $\[a\,b\]= 0$ for any $a\,b in bb(R)$, suppose $frak(g) = chevron.l chevron.l chevron.r chevron.r$ is a real Lie algebra of dimension 1, then $\[v\,v\]= 0$ because of anti-symmetry, hence $phi : frak(g) arrow.r frak(g)_0\,v mapsto 1$ is a Lie algebra isomorphism, hence Lie algebra of dimension 1 is $frak(g)_0$ up to isomorphism

Let $frak(g)_(a b) = bb(R)^2$ be a real Lie algebra of dimension 2 with $\[e_1\,e_2\]= a e_1 + b e_2$, suppose $frak(g) = chevron.l v chevron.r xor chevron.l w chevron.r$ is a real Lie algebra of dimension 2, with $\[v\,w\]= a v + b w$, hence $phi : frak(g) arrow.r frak(g)_(a b)\,v mapsto e_1\,w mapsto e_2$ is a Lie algebra isomorphism, suppose $phi.alt : frak(g)_(a b) arrow.r frak(g)_(c d)$ is an isomorphism, $phi.alt\(e_1\)= x e_1 + y e_2\,phi.alt\(e_2\)= z e_1 + w e_2$, then we necessarily have $A (mat(delim:#none, a; b)) = det A (mat(delim:#none, c; d))$, where $det A eq.not 0$, if $c = d = 0$, then $a = b = 0$, you can just take $A = I$, if $c\,d$ are not both zero, then $a\,b$ are not both zero and without loss of generality we may assume $d eq.not 0$, in that case, if $b eq.not 0$, we can take $A = (mat(delim:#none, b / d, frac(c d - a b, b d); 0, d / b))$, if $b = 0$, then $a eq.not 0$, we can take $A = (mat(delim:#none, c / a, - a / d; d / a, 0))$, Therefore, there are two classes of real Lie algebras of dimension 2, namely $frak(g)_00$ and $frak(g)_01$

]
#statement("Exercise")[

]
#math.equation(block: true, numbering: none, $(mat(delim:#none, quad, I; - I, quad)) (mat(delim:#none, A, B; C, D)) = (mat(delim:#none, C, D; - A, - B)) = (mat(delim:#none, A, B; C, D)) (mat(delim:#none, quad, I; - I, quad)) = (mat(delim:#none, - B, A; - D, C)) arrow.r.double cases(D = A, C = - B)$) Let $J = (mat(delim:#none, quad, I; - I, quad))$, then these are the matrices deonoted as $frak(g) lt.eq frak(g l)\(2 n\,bb(R)\)$ commuting with $J$, consider $phi : frak(g l)\(n\,bb(C)\)arrow.r frak(g)\,A + i B mapsto (mat(delim:#none, A, B; - B, A))$ is evidently a linear map, and $\[phi\(A_1 + i B_1\)\,phi\(A_2 + i B_2\)\]=$

$(mat(delim:#none, A_1, B_1; C_1, D_1)) (mat(delim:#none, A_2, B_2; C_2, D_2)) - (mat(delim:#none, A_2, B_2; C_2, D_2)) (mat(delim:#none, A_1, B_1; C_1, D_1)) = (mat(delim:#none, \[A_1\,A_2\]-\[B_1\,B_2\], \[A_1\,B_2\]+\[B_1\,A_2\]; -\[A_1\,B_2\]-\[B_1\,A_2\], \[A_1\,A_2\]-\[B_1\,B_2\])) =$

$phi (\[ A_1 \, A_2 \] - \[ B_1 \, B_2 \] + i \( \[ A_1 \, B_2 \] + \[ B_1 \, A_2 \] \)) = phi (\[ A_1 + i B_1 \, A_2 + i B_2 \])$, thus $phi$ is an isomorphism

#statement("Exercise")[

]
#strong[\(a)]

Define group homomorphism $phi : bb(H) arrow.r G L\(2\,bb(C)\)$, $1 mapsto (mat(delim:#none, 1, quad; quad, 1))$, $i mapsto (mat(delim:#none, i, quad; quad, - i))$, $j mapsto (mat(delim:#none, quad, 1; - 1, quad))$, $k mapsto (mat(delim:#none, quad, i; i, quad))$, $a + b i + c j + d k mapsto (mat(delim:#none, a + b i, c + d i; - c + d i, a - b i))$, i.e. $lambda + j mu mapsto (mat(delim:#none, lambda, macron(mu); - mu, macron(lambda)))$ with determinant $\|lambda\|^2 +\|mu\|^2 =\|lambda + j mu\|^2$ which is the norm, and $(mat(delim:#none, frac(overline(lambda), \|lambda\|^2 +\|mu\|^2), frac(- overline(mu), \|lambda\|^2 +\|mu\|^2); frac(mu, \|lambda\|^2 +\|mu\|^2), frac(lambda, \|lambda\|^2 +\|mu\|^2)))$ is the left and right inverse, similarly, we can define $Phi : G L\(n\,bb(H)\)arrow.r G L\(2 n\,bb(C)\)$,

$(mat(delim:#none, lambda_11 + j mu_11, dots.h.c, lambda_(1 n) + j mu_(1 n); dots.v, dots.down, dots.v; lambda_(n 1) + j mu_(n 1), dots.h.c, lambda_(n n) + j mu_(n n))) mapsto (mat(delim:#none, mat(delim:#none, lambda_11, overline(mu_11); - mu_11, overline(lambda_11)), dots.h.c, mat(delim:#none, lambda_(1 n), overline(mu_(1 n)); - mu_(1 n), overline(lambda_(1 n))); dots.v, dots.down, dots.v; mat(delim:#none, lambda_(n 1), overline(mu_(n 1)); - mu_(n 1), overline(lambda_(n 1))), dots.h.c, mat(delim:#none, lambda_(n n), overline(mu_(n n)); - mu_(n n), overline(lambda_(n n)))))$ which shows that $G L\(n\,bb(H)\)$ is a matrix group of complex dimension $2 n^2$, it is not compact since the entries are not bounded

#strong[\(b)]

#math.equation(block: true, numbering: none, $chevron.l lambda arrow(v)\,arrow(w) chevron.r = sum_(i = 1)^n overline(lambda v_i) w_i = sum_(i = 1)^n overline(lambda) overline(v_i) w_i = overline(lambda) chevron.l arrow(v)\,arrow(w) chevron.r$) #math.equation(block: true, numbering: none, $chevron.l arrow(v)\,arrow(w) chevron.r = sum_(i = 1)^n overline(v_i) w_i lambda = chevron.l arrow(v)\,arrow(w) chevron.r lambda$) #math.equation(block: true, numbering: none, $chevron.l arrow(v)\,arrow(w) chevron.r = sum_(i = 1)^n overline(v_i) w_i = sum_(i = 1)^n overline(overline(w_i) v_i) = overline(sum_(i = 1)^n overline(w_i) v_i) = overline(chevron.l arrow(w)\,arrow(v) chevron.r)$) #strong[\(c)]

$(mat(delim:#none, lambda, macron(mu); - mu, macron(lambda))) (mat(delim:#none, alpha, macron(beta); - beta, macron(alpha))) = (mat(delim:#none, lambda alpha - macron(mu) beta, lambda macron(beta) + macron(mu) macron(alpha); - mu alpha - macron(lambda) beta, - mu macron(beta) + macron(lambda) macron(alpha)))$, we can define $(mat(delim:#none, lambda, macron(mu); - mu, macron(lambda))) dot.op (mat(delim:#none, alpha; beta)) = (mat(delim:#none, lambda alpha - macron(mu) beta; mu alpha + macron(lambda) beta))$, then the corresponding matrix would be $(mat(delim:#none, lambda, - macron(mu); mu, macron(lambda)))$, here we are identifying $alpha + j beta$ with $(mat(delim:#none, alpha; beta))$ and $(mat(delim:#none, alpha_1 + j beta_1; dots.v; alpha_n + j beta_n))$ with $(mat(delim:#none, alpha_1; beta_1; dots.v; alpha_n; beta_n))$, the we have $chevron.l arrow(v)\,arrow(w) chevron.r = chevron.l arrow(v)\,arrow(w) chevron.r_1 + j chevron.l arrow(v)\,arrow(w) chevron.r_2$ where $arrow(v) = (mat(delim:#none, alpha_1; beta_1; dots.v; alpha_n; beta_n))\,arrow(w) = (mat(delim:#none, gamma_1; eta_1; dots.v; gamma_n; eta_n))$, and $chevron.l arrow(v)\,arrow(w) chevron.r_1 = sum_(i = 1)^n\(overline(alpha_i) gamma_i + overline(beta_i) eta_i\)$, $chevron.l arrow(v)\,arrow(w) chevron.r_2 = sum_(i = 1)^n\(- overline(beta_i) gamma_i + overline(alpha_i) eta_i\)$, hence $chevron.l accent(g v, ⃗)\,accent(g w, ⃗) chevron.r_1 + j chevron.l accent(g v, ⃗)\,accent(g w, ⃗) chevron.r_2 = chevron.l accent(g v, ⃗)\,accent(g w, ⃗) chevron.r = chevron.l arrow(v)\,arrow(w) chevron.r = chevron.l arrow(v)\,arrow(w) chevron.r_1 + j chevron.l arrow(v)\,arrow(w) chevron.r_2$, $chevron.l\,chevron.r_2$ is a symplectic form with respect to vectors of the form $arrow(v) = (mat(delim:#none, alpha_1; dots.v; alpha_n; beta_1; dots.v; beta_n))\,arrow(w) = (mat(delim:#none, gamma_1; dots.v; gamma_n; eta_1; dots.v; eta_n))$ compare to $chevron.l\,chevron.r_1$, thus $g in U\(2 n\)inter S p\(2 n\,bb(C)\)$

#statement("Exercise")[

]
#strong[\(a)]

Suppose $\(arrow(v)\,t\)in Z$, then $\(arrow(v)\,t\)*\(arrow(w)\,u\)=\(arrow(v) + arrow(w)\,t + u + 1 / 2 chevron.l arrow(v)\,arrow(w) chevron.r\)=\(arrow(v) + arrow(w)\,t + u + 1 / 2 chevron.l arrow(w)\,arrow(v) chevron.r\)=\(arrow(v)\,t\)*\(arrow(w)\,u\)\,forall\(arrow(w)\,u\)in H\(V\)$, then $- chevron.l arrow(w)\,arrow(v) chevron.r = chevron.l arrow(v)\,arrow(w) chevron.r = chevron.l arrow(w)\,arrow(v) chevron.r arrow.r.double chevron.l arrow(v)\,arrow(w) chevron.r = 0\,forall arrow(w) in V$, since $chevron.l\,chevron.r$ is non-degenerate, $arrow(v) = 0$, $Z tilde.equiv bb(R)$

#strong[\(b)]

Define $phi : H\(V\)arrow.r V\,\(arrow(v)\,t\)mapsto arrow(v)$ which is surjective, then $ker phi = Z$, hence $H\(V\)\/Z tilde.equiv V$

#strong[\(c)]

From (b), we can easily see there is an exact sequence $1 arrow.r Z arrow.r H\(V\)arrow.r V arrow.r 1$, consider $psi : V arrow.r H\(V\)\,arrow(v) mapsto\(arrow(v)\,0\)$, we have $phi compose psi = i d_V$, thus the exact sequence splits

#strong[\(d)]

Define $phi.alt : H\(V\)arrow.r H\,\(arrow(v)\,arrow(w)\,t\)mapsto (mat(delim:#none, 1, arrow(v)^T, t + 1 / 2 arrow(v)^T arrow(w); 0, I_n, arrow(w); 0, 0, 1))$is an isomorphism where $H$ is Heisenberg group and the non-degenerate symplectic form $chevron.l\,chevron.r$ is first isomorphic to $chevron.l\(arrow(v_1)\,arrow(w_1)\)\,\(arrow(v_2)\,arrow(w_2)\)chevron.r = 1 / 2\(arrow(v_1)^T arrow(w_2) - arrow(w_1)^T arrow(v_2)\)$, then

$phi.alt\(arrow(v_1)\,arrow(w_1)\,t_1\)phi.alt\(arrow(v_1)\,arrow(w_1)\,t_1\)= (mat(delim:#none, 1, arrow(v_1)^T, t_1 + 1 / 2 arrow(v_1)^T arrow(w_1); 0, I_n, arrow(w_1); 0, 0, 1)) (mat(delim:#none, 1, arrow(v_2)^T, t_2 + 1 / 2 arrow(v_2)^T arrow(w_2); 0, I_n, arrow(w_2); 0, 0, 1)) =$

$(mat(delim:#none, 1, arrow(v_1)^T + arrow(v_2)^T, t_1 + 1 / 2 arrow(v_1)^T arrow(w_1) + t_2 + 1 / 2 arrow(v_2)^T arrow(w_2) + arrow(v_1)^T arrow(w_2); 0, I_n, arrow(w_1) + arrow(w_2); 0, 0, 1)) =$

$(mat(delim:#none, 1, arrow(v_1)^T + arrow(v_2)^T, t_1 + t_2 + 1 / 2 chevron.l\(arrow(v_1)\,arrow(w_1)\)\,\(arrow(v_2)\,arrow(w_2)\)chevron.r + 1 / 2\(arrow(v_1) + arrow(v_2)\)^T\(arrow(w_1) + arrow(w_2)\); 0, I_n, arrow(w_1) + arrow(w_2); 0, 0, 1)) =$

$phi.alt\(arrow(v_1) + arrow(v_2)\,arrow(w_1) + arrow(w_2)\,t_1 + t_2 + 1 / 2 chevron.l\(arrow(v_1)\,arrow(w_1)\)\,\(arrow(v_2)\,arrow(w_2)\)chevron.r\)$

#statement("Exercise")[

]
#strong[\(a)]

Let $E_(i j)$ denote the matrix with only the $\(i\,j\)$-th entry 1, and 0 else where, then $E_(i j) E_(k l) = delta_(j k) E_(i l)$, $\[E_(i j)\,E_(k l)\]= E_(i j) E_(k l) - E_(k l) E_(i j) = delta_(j k) E_(i l) - delta_(l i) E_(k j)$, and $frak(n)$ is spaned by ${ E_(i j) }_(j > i)$, it is easy to see that $\[frak(n)\,frak(n)\]$ is spaned by ${ E_(i j) }_(j > i + 1)$

#strong[\(b)]

Consider ${ I + a E_(i j) }_(j > i)$ Notice $\(I + a E_(i j)\)^(- 1) = I - a E_(i j)$, and it is easy to calculate that given $j > i\,l > k$, we have $\(I + a E_(i j)\)\(I + b E_(k l)\)\(I + a E_(i j)\)^(- 1)\(I + b E_(k l)\)^(- 1) = I + a b delta_(j k) E_(i l) - a b delta_(i l) E_(k j)$, as the same analysis in $\(a\)$, we know the commutator subgroup contains all the elements in $I +\[frak(n)\,frak(n)\]$, on the other hand, for any $I - P in N$ with $P$ nilpotent, we have $\(I - P\)^(- 1) = I + P + P^2 + dots.h.c$, thus $\(I - P\)\(I - Q\)\(I - P\)^(- 1)\(I - Q\)^(- 1) =\(I - P\)\(I - Q\)\(I + P + P^2 + dots.h.c\)\(I + Q + Q^2 + dots.h.c\)=\(I - P - Q + P Q\)\(I + P + Q + P^2 + Q^2 + P Q + dots.h.c\)= I +\[P\,Q\]+ dots.h.c$, with the result in $\(a\)$, we know that $\[P\,Q\]+ dots.h.c in\[frak(n)\,frak(n)\]$, and for $X\,Y in\[frak(n)\,frak(n)\]$, $\(I + X\)\(I + Y\)= I +\(X + Y + X Y\)in I +\[frak(n)\,frak(n)\]$, thus the commutator subgroup ${ N\,N }$ of $N$ is $I +\[frak(n)\,frak(n)\]$, $log\(e^X e^Y\)= X + Y + S$, where $S in\[frak(n)\,frak(n)\]$, thus $f\(e^X e^Y\)= e^(phi.alt\(X + Y + S\)) = e^(phi.alt\(X\)+ phi.alt\(Y\)) = f\(e^X\)f\(e^Y\)$ meaning $f$ is a homomorphism

#strong[\(c)]

The sufficient and necessary condition needed is ${ N\,N } lt.eq ker f$, first notice this map is well defined, that $N$ is the image of $frak(n)$ under exponential map because you can take $log$ where the power series has only finitely many terms, and $frak(n)$ is the Lie algebra of $N$, if $e^X = e^Y$ where $X\,Y in frak(n)$, then $X - Y in\[frak(n)\,frak(n)\]lt.eq ker phi.alt$, thus $f\(e^X\)= e^(phi.alt\(X\)) = e^(phi.alt\(Y\)) = f\(e^Y\)$, the condition is obvious necessary, on the other hand, if ${ N\,N } lt.eq ker f$, $e^X e^Y = I + X + Y + R$ where $R in\[frak(n)\,frak(n)\]$

#statement("Exercise")[

]
For any $g = (mat(delim:#none, a, b; c, d)) in S L\(2\,bb(R)\)$, suppose $g = k a n$ with $k in S O\(2\,bb(R)\)\,a = (mat(delim:#none, e^x, quad; quad, e^(- x)))\,n = (mat(delim:#none, 1, y; quad, 1))$, then we would have $(mat(delim:#none, a^2 + c^2, a b + c d; a b + c d, b^2 + d^2)) = g^T g = n^T a^T k^T k a n = n^T a^T a n = (mat(delim:#none, e^(2 x), y e^(2 x); y e^(2 x), y^2 e^(2 x) + e^(- 2 x)))$ thus we would necessarily have $x = frac(ln\(a^2 + c^2\), 2)\,y = frac(a b + c d, a^2 + c^2)$, and $k = g^(- T) n^T a^T$ this shows the uniqueness, only need to check that $k$ is indeed in $S O\(2\,bb(R)\)$ and calculation shows that $k^T k = a n g^(- 1) g^(- T) n^T a^T = (mat(delim:#none, \(a d - b c\)^2, 0; 0, 1)) = I$

#statement("Exercise")[

]
#strong[\(a)]

Since $upright(C e n t)_G\(h g h^(- 1)\)= h upright(C e n t)_G\(g\)h^(- 1)$, up to conjugacy, if $g = r I_3$, then $upright(C e n t)_G\(g\)= S L\(3\,bb(C)\)$, if $g = upright(d i a g)\(r I_2\,a\)$ where $a eq.not r$, then $upright(C e n t)_G\(g\)= {upright(d i a g) \( A \, b \)}$, and if $g = upright(d i a g)\(a\,b\,c\)$, where $a\,b\,c$ are distinct, then $upright(C e n t)_G\(g\)= upright(d i a g)\(alpha\,beta\,gamma\)$, only need to prove $S L\(n\,bb(C)\)$ is connected. Notice any element of $S L\(n\,bb(C)\)$ can be written as $g = C (mat(delim:#none, lambda_1, quad, *; quad, dots.down, quad; quad, quad, lambda_n)) C^(- 1)$, where $lambda_1 dots.h.c lambda_n = 1$, let $(mat(delim:#none, lambda_1, quad, *; quad, dots.down, quad; quad, quad, lambda_n)) = upright(d i a g)\(lambda_1\,dots.h.c\,lambda_n\)+ N$, $N$ is nilpotent, consider path $g\(t\)= C (upright(d i a g) \( lambda_1 \( t \) \, dots.h.c \, lambda_(n - 1) \( t \) \, lambda_n \( t \) \) + t N) C^(- 1)$, where $lambda_j\(t\)= r_j^t e^(i t theta_j)$, with $lambda_j = r_j e^(i theta_j)\,1 lt.eq j lt.eq n - 1$, and $lambda_n\(t\)= frac(1, lambda_1\(t\)dots.h.c lambda_(n - 1)\(t\))$, then $g\(0\)= I\,g\(1\)= g$

#strong[\(b)]

$Z$ only consists of three elements $I_3\,omega I_3\,omega^2 I_3$, where $omega = e^(frac(2 pi i, 3))$, up to conjugacy, if $g = r I_3$, then $upright(C e n t)_G\(g\)= P S L\(3\,bb(C)\)$ which has trivial component group, if $g = upright(d i a g)\(r I_2\,a\)$ where $a eq.not r$, then $upright(C e n t)_G\(g\)= {upright(d i a g) \( A \, b \)}$ which has trivial component group, if $g = upright(d i a g)\(a\,b\,c\)$, where $a\,b\,c$ are distinct, suppose $a = b omega = c omega^2$\(or $a = c omega = b omega^2$), then $upright(C e n t)_G\(g\)$ consists of diagonal matrices $(mat(delim:#none, x, quad, quad; quad, y, quad; quad, quad, z))$ and matrices of the form $(mat(delim:#none, quad, x, quad; quad, quad, y; z, quad, quad))$ and $(mat(delim:#none, quad, quad, x; y, quad, quad; quad, z, quad))$, and they form two different connected components other than the diagonal matrices easily seen from the fact that they are the preimages of ${ 1 }$ under the maps $(mat(delim:#none, a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33)) mapsto a_11 a_22 a_33$, $(mat(delim:#none, a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33)) mapsto a_12 a_23 a_31$ and $(mat(delim:#none, a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33)) mapsto a_13 a_21 a_32$, these are all connected since you can find a path connected with $(mat(delim:#none, 1, quad, quad; quad, 1, quad; quad, quad, 1))\,(mat(delim:#none, quad, 1, quad; quad, quad, 1; 1, quad, quad))$ and $(mat(delim:#none, quad, quad, 1; 1, quad, quad; quad, 1, quad))$ correspondingly as above, so the component group is $bb(Z)\/3 bb(Z)$, for other possibilities of $a\,b\,c$, $upright(C e n t)_G\(g\)= upright(d i a g)\(alpha\,beta\,gamma\)$ which is connected

#pagebreak(weak:true)
== Homework3
<homework3>
#statement("Exercise")[
Give a list of all three-dimensional and four-dimensional compact, connected Lie groups, up to isomorphism

]
#proof(title: "Solution")[
We know the following facts: \ The Lie algebra a compact Lie group is reductive \ If $frak(g)$ is semisimple Lie algebra with $dim frak(g) lt.eq 4$, then $frak(g) = frak(s l)\(2\,bb(C)\)$ \ Suppose $frak(g)$ is a complex, semisimple Lie algebra, then there exists unique up to isomorphism a compact simply connected Lie group $G$ such that $frak(g) = upright(L i e)\(G\)times.o_(bb(R)) bb(C)$ \ If $G$ is a $3$ dimensional compact connected Lie group, let $tilde(G)$ be its universal cover, then $upright(L i e)\(tilde(G)\)_(bb(C)) = frak(s l)\(2\,bb(C)\)$ or $bb(C) xor bb(C) xor bb(C)$, in the first case, $tilde(G)$ is necessarily isomorphic to $S U\(2\,bb(C)\)$ since $frak(s u)\(2\,bb(C)\)_(bb(C)) = frak(s l)\(2\,bb(C)\)$, and since $Z\(S U\(2\,bb(C)\)\)= { plus.minus I }$, thus $G$ can only be $S U\(2\,bb(C)\)$ or $P S U\(2\,bb(C)\)$, in the second case, $tilde(G)$ is $bb(R)^3$, hence $G = bb(R)^3\/Lambda tilde.equiv T^3$ \ If $G$ is a $4$ dimensional compact connected Lie group, let $tilde(G)$ be its universal cover, then since $upright(L i e)\(tilde(G)\)_(bb(C))$ is reductive, so it is necessarily $frak(s l)\(2\,bb(C)\)xor bb(C)$ or $bb(C) xor bb(C) xor bb(C) xor bb(C)$, in the first case, $tilde(G) tilde.equiv S U\(2\,bb(C)\)times bb(R)$ since it has $frak(s l)\(2\,bb(C)\)xor bb(C)$ as its complexified Lie algebra, thus $G$ is $S U\(2\,bb(C)\)times T^1$ or $P S U\(2\,bb(C)\)times T^1$, in the second case, $tilde(G)$ is $bb(R)^4$, $G = T^4$

]
#statement("Exercise")[

]
#strong[\(a)]

Denote $X :=\(X_1\,dots.h.c\,X_n\)^T$, $Y :=\(Y_1\,dots.h.c\,Y_n\)^T$, suppose $X' =\(X'_1\,dots.h.c\,X'_n\)^T = A X$, $Y' =\(Y'_1\,dots.h.c\,Y'_n\)^T = B Y$ such that $Y'$ is also the dual basis of $X'$, where $A =\(alpha_(i j)\)\,B =\(beta_(i j)\)$, then $delta_(i j) =\(X'_i\,Y'_j\)= sum_k alpha_(i k) beta_(j k)$, thus $A B^T = I$, which also implies $B^T A = I$, hence #math.equation(block: true, numbering: none, $sum_i pi\(X'_i\)pi\(Y'_i\) & = sum_(i\,k\,l) alpha_(i k) beta_(i l) pi\(X_k\)pi\(X_l\)\
 & = sum_(k\,l) (sum_i alpha_(i k) beta_(i l)) pi\(X_k\)pi\(X_l\)\
 & = sum_(k\,l) delta_(k l) pi\(X_k\)pi\(X_l\)\
 & = sum_k pi\(X_k\)pi\(X_k\)$) Thus $Omega$ is independent of the choice of basis

#strong[\(b)]

Since $\(\,\)$ is nondegenerate, we can choose basis $X_i$ such that $\(X_i\,X_i\)= epsilon_i$, where $epsilon_i = cases(1\,1 lt.eq i lt.eq p, - 1\,p + 1 lt.eq i lt.eq p + q)$, and $\(X_i\,X_j\)= 0\,i eq.not j$, then $Y_i = epsilon_i X_i$, $Omega = sum_i pi\(X_i\)pi\(Y_i\)= sum_i epsilon_i pi\(X_i\)^2$, let $\[X_i\,X_j\]= sum_k c_k^(i j) X_k$, $c_k^(i j)$ are the structure constants, notice $epsilon_k c_k^(i j) =\(\[X_i\,X_j\]\,X_k\)=\(X_i\,\[X_j\,X_k\]\)= epsilon_i c_i^(j k)$, so we have

#math.equation(block: true, numbering: none, $c_k^(i j) = - c_k^(i j)$) #math.equation(block: true, numbering: none, $epsilon_k c_k^(i j) = epsilon_i c_i^(j k) = epsilon_j c_j^(k i)$) now let's compute

#math.equation(block: true, numbering: none, $\[Omega\,pi\(X_j\)\] & = sum_i epsilon_i pi\(X_i\)^2 pi\(X_j\)- sum_i epsilon_i pi\(X_j\)pi\(X_i\)^2\
 & = sum_i epsilon_i pi\(X_i\)(\[ pi \( X_i \) \, pi \( X_j \) \] + pi \( X_j \) pi \( X_i \)) + sum_i epsilon_i (\[ pi \( X_i \) \, pi \( X_j \) \] - pi \( X_i \) pi \( X_j \)) pi\(X_i\)\
 & = sum_i epsilon_i pi\(X_i\)\[pi\(X_i\)\,pi\(X_j\)\]+ sum_i epsilon_i\[pi\(X_i\)\,pi\(X_j\)\]pi\(X_i\)\
 & = sum_i epsilon_i pi\(X_i\)pi (\[ X_i \, X_j \]) + sum_i epsilon_i pi (\[ X_i \, X_j \]) pi\(X_i\)\
 & = sum_i epsilon_i pi\(X_i\)pi (sum_k c_k^(i j) pi \( X_k \)) + sum_i epsilon_i pi (sum_k c_k^(i j) pi \( X_k \)) pi\(X_i\)\
 & = sum_(i\,k) epsilon_i c_k^(i j) pi\(X_i\)pi\(X_k\)+ sum_(i\,k) epsilon_i c_k^(i j) pi\(X_k\)pi\(X_i\)\
 & =^(\(2\)) sum_(i\,k) epsilon_i c_k^(i j) pi\(X_i\)pi\(X_k\)+ sum_(i\,k) epsilon_i epsilon_j epsilon_k c_j^(k i) pi\(X_k\)pi\(X_i\)\
 & = sum_(i\,k) epsilon_i c_k^(i j) pi\(X_i\)pi\(X_k\)+ sum_(k\,i) epsilon_i epsilon_j epsilon_k c_j^(i k) pi\(X_i\)pi\(X_k\)\
 & =^(\(1\)) sum_(i\,k) epsilon_i c_k^(i j) pi\(X_i\)pi\(X_k\)- sum_(k\,i) epsilon_i epsilon_j epsilon_k c_j^(k i) pi\(X_i\)pi\(X_k\)\
 & =^(\(2\)) sum_(i\,k) epsilon_i c_k^(i j) pi\(X_i\)pi\(X_k\)- sum_(k\,i) epsilon_i c_k^(i j) pi\(X_i\)pi\(X_k\)\
 & = 0$) Thus $Omega$ commutes with $pi\(X\)$ for any $X in frak(g)$

#strong[\(c)]

For this part, we assume $frak(g) = frak(s l)\(2\,bb(C)\)$, pick $X_1 = x = mat(delim: "(", 0, 1; 0, 0)\,X_2 = y = mat(delim: "(", 0, 0; 1, 0)\,X_3 = h = mat(delim: "(", 1, 0; 0, - 1)$ be the basis of $frak(g)$, the its Cartan matrix is $mat(delim: "(", 0, 4, 0; 4, 0, 0; 0, 0, 8)$, then we have $Y_1 = y / 4\,Y_2 = x / 4\,Y_3 = h / 8$, $Omega = 1 / 4 pi\(x\)pi\(y\)+ 1 / 4 pi\(y\)pi\(x\)+ 1 / 8 pi\(h\)^2$ \ Since the irreducible representation of $frak(s l)\(2\,bb(C)\)$ of dimension $n$ is $S^(n - 1)\(bb(C)^2\)$, unique up to isomorphism, let $t_1 =\(1\,0\)^T\,t_2 =\(0\,1\)^T$ be a basis of $bb(C)^2$, then $t_1^(n - 1)\,t_1^(n - 2) t_2\,dots.h.c\,t_1 t_2^(n - 2)\,t_2^(n - 1)$ is a basis of $S^(n - 1)\(bb(C)^2\)$, we have $Omega t_1 = 3 / 8 t_1\,Omega t_2 = 3 / 8 t_2$, thus $Omega t_1^k = frac(3 k, 8) t_1^k$ by induction $Omega t_1^(k + 1) = Omega (t_1^k t_1) = t_1^k Omega t_1 + t_1 Omega t_k = 3 / 8 t_1^(k + 1) + frac(3 k, 8) t_1^(k + 1) = frac(3\(k + 1\), 8) t_1^(k + 1)$, hence $Omega\(t_1^k t_2^(m - k)\)= t_1^k Omega t_2^(n - 1 - k) + t_2^(n - 1 - k) Omega t_1^k = frac(3\(n - 1\), 8) t_1^k t_2^(n - 1 - k)$, thus $Omega$ acts by multiplying a scalar $frac(3\(n - 1\), 8)$ \

#statement("Exercise")[

]
Let $Omega = mat(delim: "(", 0, I; I, 0)$, then ${X in S L \( 2 n \, bb(C) \) mid(bar.v) X^T Omega X = Omega}$ is conjugate to $S O\(2 n\,bb(C)\)$, thus then also induce isomorphic Lie algebra, hence we can identify $frak(s o)\(2 n\,bb(C)\)$ with ${X in M \( 2 n \, bb(C) \) mid(bar.v) Omega X^T + X Omega = 0}$ which is the same as ${mat(delim: "(", A, B; C, - A^T) in M \( 2 n \, bb(C) \) mid(bar.v) B^T = - B \, C^T = - C} = : frak(g)$, then one Cartan subalgebra of $frak(g)$ will be \ $frak(h) = {mat(delim: "(", D, 0; 0, - D) in M \( 2 n \, bb(C) \) mid(bar.v) D = upright(d i a g) \( d_1 \, dots.h.c \, d_n \)}$, note that #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0; 0, - D) \, mat(delim: "(", E_(i j), 0; 0, - E_(j i))] =\(d_i - d_j\)mat(delim: "(", E_(i j), 0; 0, - E_(j i))$) #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0; 0, - D) \, mat(delim: "(", 0, E_(i j); 0, 0)] =\(d_i + d_j\)mat(delim: "(", 0, E_(i j); 0, 0)$) #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0; 0, - D) \, mat(delim: "(", 0, 0; E_(i j), 0)] = -\(d_i + d_j\)mat(delim: "(", 0, 0; E_(i j), 0)$)Define $e_i in frak(h)^(*)$ with $e_i (mat(delim: "(", D, 0; 0, - D)) = d_i$, then the roots are $Delta = { plus.minus\(e_i - e_j\)\,plus.minus\(e_i + e_j\)\|i < j }$, and a set of simple roots could be $S = { e_1 - e_2\,e_2 - e_3 dots.h.c\,e_(n - 1) - e_n\,e_(n - 1) + e_n }$, we can check that $K (mat(delim: "(", E_(i i), 0; 0, - E_(i i)) \, mat(delim: "(", E_(j j), 0; 0, - E_(j j))) = delta_(i j) 3\(n - 1\)$, thus we can treat ${ e_i }$ as an othonormal basis \ Thus $chevron.l e_(i - 1) - e_i\,e_i plus.minus e_(i + 1) chevron.r chevron.l e_i plus.minus e_(i + 1)\,e_(i - 1) - e_i chevron.r = frac(4\(e_(i - 1) - e_i\,e_i plus.minus e_(i + 1)\)^2, \(e_(i - 1) - e_i\,e_(i - 1) - e_i\)\(e_i plus.minus e_(i + 1)\,e_i plus.minus e_(i + 1)\)) = 1$, $\(e_(i - 1) - e_i\,e_j plus.minus e_(j + 1)\)= 0$ for $i < j$, \ and $\(e_(n - 1) - e_n\,e_(n - 1) + e_n\)= 0$, hence the root system of $frak(s o)\(2 n\,bb(C)\)$ is of type $D_n$ \

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((4,0),[$bullet$]),
node((0,1),[$bullet r$]),
node((1,1),[$bullet r$]),
node((2,1),[$bullet r$]),
node((3,1),[$bullet r$]),
node((4,1),[$bullet u r$]),
node((5,1),[$bullet$]),
edge((0,1),(1,1),"->",stroke:(dash:"dashed")),
edge((1,1),(2,1),"->",stroke:(dash:"dashed")),
edge((2,1),(3,1),"->",stroke:(dash:"dashed")),
edge((3,1),(4,1),"->",stroke:(dash:"dashed")),
edge((4,1),(5,1),"->",stroke:(dash:"dashed")),
edge((4,1),(5,1),"->",stroke:(dash:"dashed")))]
]
By abuse of notation, let $Omega = mat(delim: "(", 0, I, 0; I, 0, 0; 0, 0, 1)$, then ${X in S L \( 2 n + 1 \, bb(C) \) mid(bar.v) X^T Omega X = Omega}$ is conjugate to $S O\(2 n + 1\,bb(C)\)$, hence we can identify $frak(s o)\(2 n + 1\,bb(C)\)$ with ${X in M \( 2 n + 1 \, bb(C) \) mid(bar.v) Omega X^T + X Omega = 0}$ which is the same as \ ${mat(delim: "(", A_11, A_12, A_13; A_21, - A_11^T, A_23; - A_23^T, - A_13^T, 0) in M \( 2 n \, bb(C) \) mid(bar.v) A_12^T = - A_12 \, A_21^T = - A_21} = : frak(g)$, then one Cartan subalgebra of $frak(g)$ will be \ $frak(h) = {mat(delim: "(", D, 0, 0; 0, - D, 0; 0, 0, 0) in M \( 2 n + 1 \, bb(C) \) mid(bar.v) D = upright(d i a g) \( d_1 \, dots.h.c \, d_n \)}$, note that #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0, 0; 0, - D, 0; 0, 0, 0) \, mat(delim: "(", E_(i j), 0, 0; 0, - E_(j i), 0; 0, 0, 0)] =\(d_i - d_j\)mat(delim: "(", E_(i j), 0, 0; 0, - E_(j i), 0; 0, 0, 0)$) #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0, 0; 0, - D, 0; 0, 0, 0) \, mat(delim: "(", 0, E_(i j), 0; 0, 0, 0; 0, 0, 0; #none)] =\(d_i + d_j\)mat(delim: "(", 0, E_(i j), 0; 0, 0, 0; 0, 0, 0; #none)$) #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0, 0; 0, - D, 0; 0, 0, 0) \, mat(delim: "(", 0, 0, 0; E_(i j), 0, 0; 0, 0, 0)] = -\(d_i + d_j\)mat(delim: "(", 0, 0, 0; E_(i j), 0, 0; 0, 0, 0)$) #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0, 0; 0, - D, 0; 0, 0, 0) \, mat(delim: "(", 0, 0, e_i; 0, 0, 0; 0, - e_i^T, 0)] = d_i mat(delim: "(", 0, 0, e_i; 0, 0, 0; 0, - e_i^T, 0)$) #math.equation(block: true, numbering: none, $[mat(delim: "(", D, 0, 0; 0, - D, 0; 0, 0, 0) \, mat(delim: "(", 0, 0, 0; 0, 0, e_i; - e_i^T, 0, 0)] = - d_i mat(delim: "(", 0, 0, 0; 0, 0, e_i; - e_i^T, 0, 0)$)Define $delta_i in frak(h)^(*)$ with $delta_i (mat(delim: "(", D, 0; 0, - D)) = d_i$, then the roots are $Delta = { plus.minus\(delta_i - delta_j\)\,plus.minus\(delta_i + delta_j\)\|i < j } union { plus.minus delta_i }$, and a set of simple roots could be $S = { delta_1 - delta_2\,delta_2 - delta_3 dots.h.c\,delta_(n - 1) - delta_n\,delta_n }$, we can check that \ $K (mat(delim: "(", E_(i i), 0, 0; 0, - E_(i i), 0; 0, 0, 0) \, mat(delim: "(", E_(j j), 0, 0; 0, - E_(j j), 0; 0, 0, 0)) = delta_(i j)\(3\(n - 1\)+ 2\)$, thus we can treat ${ delta_i }$ as an othonormal basis \ Thus $chevron.l delta_(i - 1) - delta_i\,delta_i - delta_(i + 1) chevron.r chevron.l delta_i - delta_(i + 1)\,delta_(i - 1) - delta_i chevron.r = frac(4\(delta_(i - 1) - delta_i\,delta_i - delta_(i + 1)\)^2, \(delta_(i - 1) - delta_i\,delta_(i - 1) - delta_i\)\(delta_i - delta_(i + 1)\,delta_i - delta_(i + 1)\)) = 1$, \ $chevron.l delta_(n - 1) - delta_n\,delta_n chevron.r chevron.l delta_n\,delta_(n - 1) - delta_n chevron.r = frac(4\(delta_(n - 1) - delta_n\,delta_n\)^2, \(delta_(n - 1) - delta_n\,delta_(n - 1) - delta_n\)\(delta_n\,delta_n\)) = 2$, $\(delta_(i - 1) - delta_i\,delta_j - delta_(j + 1)\)= 0$ for $i < j$, \ and $\(delta_(i - 1) - delta_i\,delta_n\)= 0$ for $i < n$, hence the root system of $frak(s o)\(2 n + 1\,bb(C)\)$ is of type $B_n$ \

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bullet r$]),
node((1,0),[$bullet r$]),
node((2,0),[$bullet r$]),
node((3,0),[$bullet r$]),
node((4,0),[$bullet$]),
node((5,0),[$bullet$]),
edge((0,0),(1,0),"->",stroke:(dash:"dashed")),
edge((1,0),(2,0),"->",stroke:(dash:"dashed")),
edge((2,0),(3,0),"->",stroke:(dash:"dashed")),
edge((3,0),(4,0),"->",stroke:(dash:"dashed")),
edge((4,0),(5,0),"->"))]
]
#statement("Exercise")[

]
Since the Weyl group acts on Weyl chambers freely, for any regular $gamma in V$, $w gamma eq.not gamma\,forall w in W$, suppose $w = s_(gamma_0)$ for some regular $gamma_0$, then $H_(gamma_0)$ must contain some regular element, which is a contradiction \ Therefore, $w = s_alpha$ for some $alpha in Delta$ \

#statement("Exercise")[

]
Note that $alpha^or in V^(*)$ is defined such that $chevron.l beta\,alpha^or chevron.r = frac(2\(beta\,alpha\), \(alpha\,alpha\))$, let $S = { alpha_1\,dots.h.c\,alpha_n } subset.eq Delta$ be a set of simple roots which is also a basis of $V$, thus the gram matrix $\(\(alpha_i\,alpha_j\)\)$ will be invertible, for any $f in V^(*)$, $i = 1\,dots.h.c\,n$, $chevron.l alpha_i\,f chevron.r = sum_j c_j frac(2\(alpha_i\,alpha_j\), \(alpha_j\,alpha_j\)) = sum_j frac(2 c_j, \(alpha_j\,alpha_j\))\(alpha_i\,alpha_j\)$, so for any choice of $chevron.l alpha_i\,f chevron.r$ has a unique solution $frac(2 c_j, \(alpha_j\,alpha_j\))$, which gives a unique solution $c_j$, thus $chevron.l alpha_i\,f chevron.r = sum_j c_j frac(2\(alpha_i\,alpha_j\), \(alpha_j\,alpha_j\)) = chevron.l alpha_i\,sum_j c_j alpha_j^or chevron.r$, which implies that $f = sum_j c_j alpha_j^or$, hence $V^(*) lt.eq chevron.l S^or chevron.r lt.eq chevron.l Delta^or chevron.r lt.eq V^(*) arrow.r.double V^(*) = chevron.l Delta^or chevron.r$, for any $alpha in Delta$, $i = 1\,dots.h.c\,n$, $chevron.l alpha_i\,\(c alpha\)^or chevron.r = frac(2\(alpha_i\,c alpha\), \(c alpha\,c alpha\)) = 1 / c frac(2\(alpha_i\,alpha\), \(alpha\,alpha\)) = 1 / c chevron.l alpha_i\,alpha^or chevron.r = chevron.l alpha_i\,alpha^or / c chevron.r$, thus $\(c alpha\)^or = alpha^or / c$, but the only multiple of $alpha$ that are in $Delta$ are precisely $alpha\,- alpha$, hence the only multiple of $alpha^or$ that are in $Delta^or$ are precisely $alpha^or\,- alpha^or$ \ By the definition of the inner prouct on the dual Euclidean space $V^(*)$, we know $\(alpha^or\,beta^or\)= frac(4\(alpha\,beta\), \(alpha\,alpha\)\(beta\,beta\))$, thus $frac(2\(alpha^or\,beta^or\), \(alpha^or\,alpha^or\)) = frac(2\(alpha\,beta\), \(beta\,beta\)) in bb(Z)$ and $s_(alpha^or)\(beta^or\)= beta^or - frac(2\(alpha^or\,beta^or\), \(alpha^or\,alpha^or\)) alpha^or = beta^or - frac(2\(alpha\,beta\), \(beta\,beta\)) alpha^or$, then $s_(alpha^or)\(alpha^or\)= - alpha^or$ and since $\(s_alpha\(beta\)\,s_alpha\(beta\)\)=\(beta\,beta\)$, we have#math.equation(block: true, numbering: none, $⟨alpha_i \, s_(alpha^or) \( beta^or \)⟩ & = ⟨alpha_i \, beta^or⟩ - frac(2\(alpha\,beta\), \(beta\,beta\)) ⟨alpha_i \, alpha^or⟩\
 & = frac(2\(alpha_i\,beta\), \(beta\,beta\)) - frac(2\(alpha\,beta\), \(beta\,beta\)) frac(2\(alpha_i\,alpha\), \(alpha\,alpha\))\
 & = frac(2\(alpha_i\,s_alpha\(beta\)\), \(beta\,beta\))\
 & = frac(2\(alpha_i\,s_alpha\(beta\)\), \(s_alpha\(beta\)\,s_alpha\(beta\)\))\
 & = ⟨alpha_i \, s_alpha \( beta \)^or⟩$)Thus $s_(alpha^or)\(beta^or\)= s_alpha\(beta\)^or in Delta^or$

Therefore, the dual $\(V^(*)\,Delta^or\)$ is also a root system

From the calculation above, we also have $⟨beta^or \, (alpha^or)^or⟩ = frac(\(alpha\,beta\), \(beta\,beta\)) = chevron.l alpha\,beta^or chevron.r$

Notice that in the construction of a Dynkin diagram, the number of edges between $alpha$ and $beta$ equals $chevron.l beta\,alpha^or chevron.r chevron.l alpha\,beta^or chevron.r$, then the number of edges between $alpha^or$ and $beta^or$ equals $⟨beta^or \, (alpha^or)^or⟩ ⟨alpha^or \, (beta^or)^or⟩ = chevron.l alpha\,beta^or chevron.r chevron.l beta\,alpha^or chevron.r$, but with the arrow reversed, therefore $A_n\,D_n$ are the classical root systems that are self-dual, and $B_n\,C_n$ are dual to each other

#statement("Exercise")[

]
Since#math.equation(block: true, numbering: none, $\(arrow(v)\,arrow(w)\)= sum_(alpha in Delta) chevron.l arrow(v)\,alpha^or chevron.r chevron.l arrow(w)\,alpha^or chevron.r = sum_(alpha in Delta) chevron.l arrow(w)\,alpha^or chevron.r chevron.l arrow(v)\,alpha^or chevron.r =\(arrow(w)\,arrow(v)\)$) #math.equation(block: true, numbering: none, $\(arrow(v)\,arrow(v)\)= sum_(alpha in Delta) chevron.l arrow(v)\,alpha^or chevron.r^2 gt.eq 0$)And $\(arrow(v)\,arrow(v)\)= 0$ iff $chevron.l arrow(v)\,alpha^or chevron.r = frac(2\(arrow(v)\,alpha\), \(alpha\,alpha\)) = 0\,forall alpha in Delta$ iff $arrow(v) = 0$, therefore $\(\,\)$ is symmetric and positive definite, finally, we have #math.equation(block: true, numbering: none, $\(s_beta arrow(v)\,s_beta arrow(w)\) & = sum_(alpha in Delta) chevron.l s_beta arrow(v)\,alpha^or chevron.r chevron.l s_beta arrow(w)\,alpha^or chevron.r\
 & = sum_(alpha in Delta) frac(4\(s_beta arrow(v)\,alpha\)\(s_beta arrow(w)\,alpha\), \(alpha\,alpha\))\
 & = sum_(alpha in Delta) frac(4\(arrow(v)\,s_beta alpha\)\(arrow(w)\,s_beta alpha\), \(alpha\,alpha\))\
 & = sum_(alpha in Delta) frac(4\(arrow(v)\,s_beta alpha\)\(arrow(w)\,s_beta alpha\), \(s_beta alpha\,s_beta alpha\))\
 & = sum_(alpha in Delta) frac(4\(arrow(v)\,alpha\)\(arrow(w)\,alpha\), \(alpha\,alpha\))\
 & =\(arrow(v)\,arrow(w)\)$)Thus $\(\,\)$ is also $W$ invariant

#statement("Exercise")[

]
Suppose $\(V\,Delta\)$ is a root system, $tau : V arrow.r V\,x mapsto - x$ is a linear map, since $alpha in Delta arrow.r.double - alpha in Delta$, thus $tau\(Delta\)subset.eq Delta$, also for any $alpha\,beta in Delta$, $chevron.l tau alpha\,\(tau beta\)^or chevron.r = frac(2\(tau alpha\,tau beta\), \(tau alpha\,tau alpha\)) = frac(2\(- alpha\,- beta\), \(- alpha\,- alpha\)) = frac(2\(alpha\,beta\), \(alpha\,alpha\)) = chevron.l alpha\,beta^or chevron.r$, and $tau^2 = upright(i d)$, thus $tau$ is an automorphism $\(V\,Delta\)$ \

#statement("Exercise")[

]
#strong[\(a)]

Let $e_1 =\(1\,0\)\,e_2 =\(0\,1\)$ be the standard basis of $bb(R)^2$, suppose the coordinates of $arrow(v_1)\,arrow(v_2)$ are $\(r_1 cos alpha\,r_1\,sin alpha\)$ and $\(r_2 cos\(theta + alpha\)\,r_2 sin\(theta + alpha\)\)$, since $s_i\(arrow(v)\)= v - 2 frac(arrow(v) dot.op arrow(v_i), arrow(v_i) dot.op arrow(v_i)) arrow(v_i)$, we have the matrix of $s_1$ and $s_2$ with respect to $e_1\,e_2$ are $mat(delim: "(", - cos 2 alpha, - sin 2 alpha; - sin 2 alpha, cos 2 alpha)$ and $mat(delim: "(", - cos 2\(theta + alpha\), - sin 2\(theta + alpha\); - sin 2\(theta + alpha\), cos 2\(theta + alpha\))$, thus the matrix for $s_1 s_2$ would be $mat(delim: "(", cos 2 theta, sin 2 theta; - sin 2 theta, cos 2 theta)$ which means that $s_1 s_2$ is a rotation by $2 theta$

#strong[\(b)]

In order for the group $chevron.l s_1\,s_2 chevron.r$ to be finite, necessarily we need $theta$ to be a rational multiple of $pi$, but for any $theta = frac(p pi, q)$ where $p\,q > 0$ are relatively prime integers, $2 theta = p / q dot.op 2 pi$, if we denote $r = s_1 s_2\,s = s_1$, then we the relations then we have the relation $s^2 = 1$, $r^q = 1$, and $s r s r = 1$, therefore $chevron.l s_1\,s_2 chevron.r = chevron.l s\,r chevron.r = F\(s\,r\)\/chevron.l s^2\,r^q\,s r s r chevron.r tilde.equiv D_q$, where $D_q$ is the dihedral group, the symmetry group of a regular $q$-gon

#pagebreak(weak:true)
#pagebreak(weak:true)
#pagebreak(weak:true)
#pagebreak(weak:true)
= An introduction to AdS geometry
<an-introduction-to-ads-geometry>
#statement("Definition")[
Anti de Sitter space is Lorentzian space form of constant curvature -1

]
#aside("Motivation")[
+ Gravity: study of Lorentzian metrics which solve Einstein equation $\(Lambda = - 1\)arrow.r.double$ AdS metrics are solutions. In dimension 3, AdS metrics are the only solutions. Hence 3D gravity = study of AdS metrics(Witten, Moncrief, Andersson, Mess, Benedetti)

+ Proper isometric actions: Margulis: free groups acting properly on Minkowski space

+ On a homogeneous space $G\/H$ often you can define a matural pseudo-Riemannian structure. $G = "SO"\(n\,2\)$, $"SO"\(n\,2\)\/S\(O\(n\)times O\(2\)\)$, $"SO"\(n\,2\)\/S O\(n - 1\,2\)$

+ 3D gravity is Teichmuller(Mess)

]
#statement("Definition")[
$\(bb(R)^(n + 2)\,chevron.l\,chevron.r\)$, $chevron.l x\,y chevron.r = x_1 y_1 + dots.h.c + x_n y_n - x_(n + 1) y_(n + 1) - x_(n + 2) y_(n + 2)$. $bb(H)^(n\,1) = { x in bb(R)^(n\,2)\|chevron.l x\,x chevron.r = - 1 }$, $T_x\(bb(H)^(n\,1)\)= x + x^perp$ by taking derivative, $"Isom"_0\(bb(H)^(n\,1)\)= "SO"\(n\,2\)$. If $x in bb(H)^(n\,1)$, then $x_(n + 1)^2 + x_(n + 2)^2 = 1 + x_1^2 + dots.h.c + x_n^2 gt.eq 1$, can write $\(x_(n + 1)\,x_(n + 2)\)= rho\(cos theta\,sin theta\)$, we have $bb(H)^n times S^1 tilde.equiv bb(H)^(n\,1)$, $(mat(delim: "[", x_1; dots.v; x_n; rho) \, e^(i theta)) arrow.l.r mat(delim: "[", x_1; dots.v; x_n; rho cos theta; rho sin theta)$

]
#statement("Fact")[
Any isometry between two connected open sets of $bb(H)^(n\,1)$ extends to a global isometry. Any AdS manifold is modelled on $\("Isom"\(bb(H)^(n\,1)\)\,bb(H)^(n\,1)\)$

]
Klein model of AdS space: $upright("AdS")^(n\,1) = bb(H)^(n\,1)\/{ x tilde.op - x } subset.eq bb(R P)^(n + 1)$, $"Isom"_0 = "PSO"\(n\,2\)$. $partial upright("AdS")^(n\,1) = { chevron.l x\,x chevron.r = 0 }$. Geodesics are projective lines: time like geodesics: $chevron.l dot(gamma)\,dot(gamma) chevron.r < 0$, light like, space like

Poincare model: $bb(H)^n times S^1 arrow.r bb(H)^(n\,1)$, $g_(upright("AdS")) = g_(bb(H)^n) - rho^2 d theta^2$

Dimension 2+1: $V = M_2\(bb(R)\)$, $q = - det$ is a quadratic form, $bb(H)^(2\,1) = "SL"_2\(bb(R)\)$, $"SL"_2\(bb(R)\)times "SL"_2\(bb(R)\)$ acts on $V$ by $\(A\,B\)dot.op X = A X B^(- 1)$, given a group homomorphism $"SL"_2\(bb(R)\)times "SL"_2\(bb(R)\)arrow.r "SO"\(2\,2\)$, $"Isom"\(bb(H)^(2\,1)\)= "SL"_2\(bb(R)\)times "SL"_2\(bb(R)\)\/plus.minus I$, $upright("AdS")^(2\,1) tilde.equiv "PSL"_2\(bb(R)\)$,

#pagebreak(weak:true)
= Large scale geometry of nilpotent and solvable Lie groups
<large-scale-geometry-of-nilpotent-and-solvable-lie-groups>
Large scale is often captured by the notion of a quasi-isometry

#statement("Definition")[
A $\(K\,C\)$ quasi isometry(QI) is $f :\(X\,d_X\)arrow.r\(Y\,d_Y\)$ such that

+ $- C + 1 / K d_X\(x_1\,x_2\)lt.eq d_Y\(f\(x_1\)\,f\(x_2\)\)lt.eq K d_X\(x_1\,x_2\)+ C$

+ $forall y in Y\,exists x in X$ such that $d_Y\(y\,f\(x\)\)lt.eq C$

]
#statement("Exercise")[
\

+ Any map that is bounded distance (the difference with sup norm being finite) from a quasi-isometry is a quasi-isometry

+ The composition of quasi-isometries is a quasi-isometry

+ Every quasi-isometry has a coarse inverse (i.e if $f ratio X arrow.r Y$ is a quasi-isometry then there is $macron(f) ratio Y arrow.r X$ such that $f compose macron(f)$ and $macron(f) compose f$ are bounded distance from the identity map)

+ Being quasi-isometric is an equivalence relation

]
#proof(title: "Solution")[
For any $y$, pick some $x in X$ to be $macron(f)\(y\)$ such that $d_Y\(y\,f macron(f)\(y\)\)= d_Y\(y\,f\(x\)\)lt.eq C$

+ $d_X\(macron(f)\(y_1\)\,macron(f)\(y_2\)\)lt.eq K d_Y\(f macron(f)\(y_1\)\,f macron(f)\(y_2\)\)+ K C lt.eq K d_Y\(y_1\,y_2\)+ 3 K C$. $d_Y\(y_1\,y_2\)lt.eq d_Y\(f macron(f)\(y_1\)\,f macron(f)\(y_2\)\)+ d_Y\(y_1\,f macron(f)\(y_1\)\)+ d_Y\(f macron(f)\(y_2\)\,y_2\)lt.eq d_Y\(f macron(f)\(y_1\)\,f macron(f)\(y_2\)\)+ 2 C lt.eq K d_X\(macron(f)\(y_1\)\,macron(f)\(y_2\)\)+ 3 C$

+ $forall x in X$, $d_X\(x\,macron(f) f\(x\)\)lt.eq K d_Y\(f\(x\)\,f macron(f) f\(x\)\)+ K C lt.eq 2 K C$

]
#aside("Note")[
\

+ If $C = 0$, then $f$ is biLipschitz

+ If $C = 0\,K = 1$, then $f$ is just an isometry

]
#statement("Example")[
$G$ is a finitely generated group, $S\,S'$ are finite generating sets, then $\(G\,d_S\)tilde.eq^(upright("QI"))\(G\,d_(S')\)$, here $d_S$ is the word metric

]
#statement("Exercise")[
Any word metric on a finitely generated group is biLipschitz (hence quasi-isometric) to any other word metric on that group

]
#statement("Exercise")[
Any finite index subgroup of a finitely generated group is quasi-isometric to its supergroup

]
#proof(title: "Solution")[
Say $\[G : H\]< oo$, consider the left cosets ${ g H }$, pick representatives $g_1 H\,dots.h.c\,g_n H$

]
#statement("Example", title: [Fundamental lemma of geometric group theory])[
If discrete group $G$ acts proper discontinuously and cocompactly on $\(X\,d_X\)$ which is a proper geodesic metric space. Then $G$ with any word metric is QI to $X$, $X$ is called a model space for $G$

]
#statement("Question")[
- Which spaces/finitely generated groupos are QI to each other

- Examples of (self) QI's

- What properties are preserved by QI's

]
#statement("Example")[
$bb(R)$ with euclidean metric is QI to $bb(R)$ with $max$ metric

]
#statement("Example")[
$f : bb(R) arrow.r bb(R)$ is QI, then it preserves two \"ends\"

]
#statement("Exercise")[
Verify that $f ratio bb(R)^2 arrow.r bb(R)^2$ defined by $f\(r\,theta\)=\(r\,ln\(1 + theta\)\)$ is a quasi-isometry

]
Focus on finitely generated nilpotent and solvable groups that have (connected and simply connected) Lie groups as model spaces

#statement("Exercise")[
Any Riemannian metric on $G$ give QI metric space

]
#statement("Definition")[
$Gamma lt.eq G$ discrete is a uniform lattice if $G\/Gamma$ is compact

]
#statement("Exercise")[
If $Gamma$ is a uniform lattice in $G$, then $G$ is a model space for $Gamma$

]
#aside("Warning")[
Not all Lie groups have uniform lattices!

]
#statement("Exercise", title: [Hard])[
$bb(R) times.r bb(R)$ where $bb(R)$ acts on $bb(R)$ by $x mapsto e^t x$

- Verify $bb(R) times.r bb(R)$ is solvable

- Show that $bb(R) times.r bb(R)$ does not admit any uniform lattices

- Find a metric on $bb(R) times.r bb(R)$ that makes it isometric to $bb(H)^2$

]
#statement("Fact")[
- Any finitely generated nilpotent group is (virtually, i.e. has finite index subgroup) a lattice in a nilpotent Lie group

- Any finitely generated polycyclic group is (virtually) a lattice in a solvable Lie group. For example, $B S\(1\,n\)= chevron.l a\,b\|b a b^(- 1) = a^n chevron.r$ is solvable but not polycyclic

]
#statement("Exercise", title: [Heisenberg group])[
$H\(bb(R)\)mat(delim: "[", 1, x, z; #none, 1, y; #none, , 1)$ with $x\,y\,z in bb(R)$, $H\(bb(Z)\)$ is a uniform lattice and both are nilpotent

]
#statement("Example", title: [Sol])[
$bb(R)^2 times.r bb(R)$, $bb(R)$ acts on $bb(R)^2$ by $\(x\,y\)mapsto\(e^t x\,e^(- t) x\)$ is a solvable group with lattice $bb(Z)^2 times.r bb(Z)$, $mat(delim: "[", x; y) mapsto mat(delim: "[", 2, 1; 1, 1)^n mat(delim: "[", x; y)$

]
QI basics:

#statement("Theorem", title: [Gromov])[
Any finitely generated group $G$ that is QI to a nilpotent group is (virtually) nilpotent

]
#aside("Note")[
\[Ershler\]Exists finitely generated group $G$ that are QI to solvable groups that not virtually solvable

]
Open question: What about polycyclic groups?

#statement("Theorem", title: [Eskin-Fisher-Whyte])[
If $G$ is a finitely generated group QI to Sol then it is (virtually) a uniform lattice in Sol

]
#statement("Fact")[
$exp : cal(N) arrow.r N$ is a diffeomorphism, assuming $N$ is connected and simply connected

]
#statement("Example", title: [Heisenberg group])[
The Lie algebra has basis ${ e_1\,e_2\,e_3 }$, and $\[e_1\,e_2\]= e_3$ is the only non-trivial bracket

]
#statement("Exercise")[
Show this is the Heisenberg group

]
Write $cal(N)_i =\[cal(N)\,cal(N)_(i - 1)\]$, $cal(N) = V_1 xor V_2 xor dots.h.c xor V_r$, where $V_i$ is a complement of $cal(N)_i$ in $cal(N)_(i - 1)$, i.e. $V_i tilde.equiv cal(N)_(i - 1)\/cal(N)_i$, let $pi_i : cal(N) arrow.r V_i$ be projection

#statement("Theorem", title: [Ball-Box])[
There exists $V_i$ and a left invariant Riemannian metric on $cal(N)$ such that $V_i perp V_j$ for all $i eq.not j$ and the induced distance satisfies: There exists $a > 1$ such that $forall R gt.eq 1$, $B o x\(R / a\)subset.eq B_1\(R\)subset.eq B o x\(a R\)$, where $B o x\(R\)= { n in N\|\|pi_i\(n\)\|lt.eq R_i }$

]
#aside("Note")[
$\|n\|_h = sum_i\|pi_i\(n\)\|^(1 / i)$, $1 / d d\(0\,n\)lt.eq\|n\|_h lt.eq a r d\(0\,n\)$

]
Warning: $d_h\(m\,n\)=\|m^(- 1) n\|_h$ doesn't give a distance

QI of $N$

Affine maps $bb(R)^n times.r "GL"\(n\,bb(R)\)$ are QI's, generalize this, affine maps $N times.r "Aut"\(N\)$ are QI's

#statement("Theorem", title: [Xie])[
Let $S_g : N arrow.r N$, $S_g\(n\)= n + g\(pi_1\(n\)\)$ for some $g : V_1 arrow.r V_r$, then $S_g$ is QI iff $\|g\(x\)- g\(y\)\|lt.eq K\|x - y\|+ C$. $S_g$ is bounded distance from an affine map iff $g$ is bounded distance from a linear map

]
#proof(title: "Proof")[
If $\|g\(x\)- g\(y\)\|lt.eq K\|x - y\|+ C$, then $S_g$ is a QI \ Pretend $d_h$ is a distance #math.equation(block: true, numbering: none, $d_h\(S_g\(n_1\)\,S_g\(n_2\)\) & =\|\(- n_2 - g\(pi_1\(n_2\)\)\)star.op\(n_1 + g\(pi_1\(n_2\)\)\)\|_h\
 & lt.eq\|\(- n_2\)\|\
 & lt.eq d_h\(n_1\,n_2\)+ d_h\(g\(pi_1\(n_1\)\)+ g\(pi_1\(n_2\)\)\)\
 & lt.eq d_h\(n_1\,n_2\)+\|K d\(n_1\,n_2\)+ C\|^(1 / r)$)

]
See Xie for other examples of \"exotic\" QI's of Heisenberg group

QI between nilpotent Lie groups

#statement("Definition")[
The associated graded Lie group $"gr"\(N\)$ as vector space is just $N$, but with bracket $\[x\,y\]_oo = pi_(i + j)\(\[x\,y\]\)$, for $x in V_i\,y in V_j$, so that $\[V_i\,V_j\]_oo subset.eq V_(i + j)$

]
#statement("Theorem", title: [Pansu])[
If $N_1\,N_2$ are QI nilpotent Lie groups, then $"gr"\(N_1\)tilde.equiv "gr"\(N_2\)$

]
#proof(title: "Proof")[
Asymptotic cone of $\(N\,d\)$ is $\("gr"\(N\)\,d_(c c)\)$, $\(N\,1 / t d\)arrow.r^(t arrow.r oo)\("gr"\(N\)\,d_(c c)\)$. And a QI indeces a biLipschitz map of asymptotic cones. Note that even if $N = "gr"\(N\)$, $d_(c c)$ is not $d$, but rather Carnot-Cartheodory metric(a sub-Riemannian metric) #math.equation(block: true, numbering: none, $d_(c c)\(p\,q\)= inf_(upright("join ") p upright(" to ") q upright(", the tangent lines in translates of ") V_1) upright("Length")\(gamma\)$)

]
Shalom,Sauer: cohomological invariants can be used to distinguish certain nilpotent Lie groups up to QI with the same associated gradded Lie groups

Isenrihc-Pallier-Tessera: Dehn functions of certain lattices can distinguish some nilpotent Lie groups up to QI

Open question: Which nilpotent Lie groups are QI. Smallest open case is actually 5

QI and geometry of solvable Lie gorups #math.equation(block: true, numbering: none, $1 arrow.r N arrow.r S arrow.r N' arrow.r 1$) Let $N' = bb(R)$, i.e. $S tilde.equiv N times.r bb(R)$

#statement("Example")[
$bb(R) times.r bb(R)$, $d s^2 = e^(- 2 t) d x^2 + d t^2$ by letting $y = e^t$, this is the log model of $bb(H)^2$. This is negatively curved

Sol$= bb(R)^2 times.r bb(R)$, $d^2 = e^(- 2 t) d x^2 + e^(2 t) d y^2 + d t^2$, note that $\(x\,y_0\,t\)tilde.equiv^("Isom") bb(H)^2$, $\(x_0\,y\,t\)tilde.equiv^("Isom") bb(H)^2$. This is foliated by negatively curved Lie groups

]
#statement("Question")[
Which $N times bb(R)$ can be made negatively curved? Which $N times.r bb(R)$ are foliated by negatively curved? Are there others? What do QI's look like? Which are QI's

]
Let $A : cal(N) arrow.r cal(N)$ be a derivation, then $e^(t A) : N arrow.r N$ is a one parameter family of automorphisms. $G_A = N times.r bb(R)$ where action is $e^(t A)$

#statement("Definition")[
If the real part of eigenvalues of $A$ is positive, then $e^(t A)$ is a one parameter family of dilations(this is not a standard definition, a little more broad)

]
We say $G_A$ is Heintze group if $e^(t A)$ is one parameter family of dilations. We say $G_A$ is a purely real if eigenvalues are real

#statement("Theorem", title: [Heintze])[
All negatively curved homogeneous spaces are Heintze groups, and all Heintze groups are negative curved homogeneous spaces

]
#statement("Exercise")[
Every Heintze group is QI to a purely real one. If $r A\,s B$ have same real Jordan form, then $G_A tilde.eq^(Q I) G_B$

]
Special Heintze groups:

$G_(I_n) = bb(R)^n times.r bb(R) tilde.equiv^("Isom") bb(H)^(n + 1)$

$G_A = H_n times.r bb(R) tilde.equiv^("Isom") bb(C H)^n$, $A = mat(delim: "[", 1; #none, dots.down; #none, , 1; #none, , , 2)$, $H_2 = H$ is the Heisenberg group

There are $N$ such that $N times.r bb(R) tilde.equiv^("Isom")$ for any rank one symmetric space

Negative curvature give $delta$ hyperbolic

Morse lemma: QI map geodesics to within a bounded distance of geodesics(use $delta$ hyperbolicity)

Boundaries of $G_A$

For any $n in N$, let $gamma_n\(s\)=\(n\,s\)$, this is a \"vertical\" geodesic choosing suitable metric

#math.equation(block: true, numbering: none, $d_(G_A)\(gamma_n\(s\)\,gamma_(n')\(s\)\)= cases(0 quad upright("as ") s arrow.r oo, oo quad upright("as ") s arrow.r - oo)$) $partial G_A = N union { oo } tilde.equiv S^n$

#statement("Fact")[
QI's of $G_A$ induce homeomorphisms of the boundary(use Morse lemma)

]
#statement("Conjecture", title: [Pointed sphere - de Cornulier])[
Unless $G_A tilde.equiv^("Isom")$ rank 1 symmetric space, then any QI of $G_A$ preserves $oo$

]
#statement("Remark")[
True in many cases(Carraso, Xie)

]
We will assume all QI's fix $oo$

Parabolic visual boundary metric: $partial_oo G_A = N$. $d_A\(n\,n'\)= e^(t_0)$ is not always a metric, but it is a quasi-metric, i.e. $d_A\(n_1\,n_2\)lt.eq M\(d_A\(n_1\,n_3\)+ d_A\(n_3\,n_2\)\)$

$\(bb(R)\,d_(I_1)\)tilde.eq\(bb(R)\,d_(E u c)\)$

$\(bb(R)^2\,d_(mat(delim: "[", 1; #none, 2))\)tilde.eq^(b i L i p s c h i t z)\(bb(R)\)\,max {\|Delta x\|\,\|Delta y\|^(1 / 2) }$

#statement("Exercise")[
If two QI's (that fix $oo$) are bounded distance apart, then they induce the same map on $\(N\,d_A\)$

]
#statement("Definition")[
A QI of $G_A tilde.equiv N times.r bb(R)$ is coarsely height respecting if it preserves level sets of $bb(R)$ up to bounded distance, i.e. $f\(N times { t_0 }\)$ is contained in a bounded neighborhood of $N times { t_0 }$

]
#statement("Conjecture")[
All QI's of non-special Heintze groups are height respecting

]
#statement("Exercise")[
Height respecting QI of $G_A$ induce biLipschitz maps of $\(N\,d_A\)$

]
Conclusion: $Q I\(G_A\)tilde.eq b i L i p\(N\,d_A\)$

Sol-like group: #math.equation(block: true, numbering: none, $G_(A_1\,A_2) =\(N_1 times N_2\)times.r bb(R)$) $bb(R)$ acts on $N_1\,N_2$ by $\(n_1\,n_2\)mapsto\(e^(t A_1) n_1\,e^(- t A_2) n_2\)$, i.e. $G_(A_1)\,G_(A_2)$ are both Heintze groups

\(EFW) Any QI of $G_(A_1\,A_2)$ is up to isometry bounded distance from $\(n_1\,n_2\,t\)arrow.r\(f_1\(n_1\)\,f_2\(n_2\)\,t\)$, $f_i in b i L i p\(N_i\,d_(A_i)\)$

Other example: $H times.r bb(R) = G_A$, $A = mat(delim: "[", 1; #none, - 1; #none, , , )$, $\[e^t x\,e^(- t) y\]= z$. Not much is known(open)

#statement("Conjecture", title: [Eskin-Fisher-Whyte])[
Let $E\(S\)$ be the group generated by exponentially distorted elements(exponential radical), then any QI coarsely preserves cosets of $E\(S\)$

]
#aside("Note")[
In our examples $E\(G_A\)= N$

]
Other work:

Peng $bb(R)^n times.r bb(R)^m$

Healy-Pengitore $N times.r bb(R)^n$ CAT0

Tullia Dymarz understand subgroups of $Q I\(G_A\)$, used to show $G$ f.g., QI to $G_A$, then $G$ is virtually a lattice of some $G_(A')$\(QI rigidity)

#statement("Exercise", title: [Hard])[
Any group that acts cocompactly and properly discontinously on a proper geodesic metric space X is finitely generated and quasi-isometric to that space

]
#statement("Exercise")[
Show that any two left invariant Riemannian metrics on a Lie group give metric spaces that are quasi-isometric

]
#statement("Exercise")[
A discrete subgroup of a Lie group that is cocompact (i.e $G\/H$ compact ) is quasiisometric the Lie group itself (and is called a uniform lattice)

]
#statement("Exercise")[
There are coarsely dense subsets of $bb(Z)^2$ that are not biLipschitz equivalent to $bb(Z)^2$ (Burago-Kleiner)

]
#statement("Exercise")[
Are there uniform lattices in a nilpotent Lie group that are not biLipschitz equivalent?

]

#pagebreak()
#heading(numbering:none)[References]
#emph[Lie Groups, Lie Algebras, and Representations: An Elementary Introduction] - Brian C. Hall

#emph[Introduction to Lie Algebras and Representation Theory] - James E. Humphreys


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
