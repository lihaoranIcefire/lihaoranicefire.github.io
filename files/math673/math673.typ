#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH673 - Partial Differential equations I", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH673 - Partial Differential equations I]
#v(2cm)
#image("Pictures/Lagrange.jpg",width:50%)
#v(2cm)
Taught by Matei Machedon \
Notes taken by Haoran Li \
2018 Fall
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Distribution
<distribution>
#statement("Definition")[
$cal(D)$ is the #emph[test function space], a #emph[distribution]#index-entry("Distribution") is a functional $T : cal(D) arrow.r bb(R)$ such that if $phi.alt_j arrow.r phi.alt$ in $cal(D)$, then $T\(phi.alt_j\)= T\(phi.alt\)$

]
#pagebreak(weak:true)
= Jacobi-Hamilton's equation
<jacobi-hamiltons-equation>
#statement("Definition", title: [Legendre transformation])[
$\(x\,v\)mapsto\(frac(partial L, partial v)\,x\)=\(p\,x\)$, define the Hamiltonian as $H\(x\,p\)= x dot.op frac(partial L, partial v) - L$, so we have equations #math.equation(block: true, numbering: none, $frac(partial H, partial x) = dot(x) dot.op frac(partial L, partial v) + x dot.op frac(d, d t)\(frac(partial L, partial v)\)- frac(partial L, upright("?"))$)

]
#pagebreak(weak:true)
= Homeworks
<homeworks>
== Homework1
<homework1>
#aside("Problem", title:[2.5.3])[
Define #math.equation(block: true, numbering: none, $phi.alt\(r\):= frac(1, \|partial B\(0\,r\)\|) integral_(partial B\(0\,r\)) u\(x\)d S + integral_(B\(0\,r\)) Phi\(x\)f\(x\)d x - Phi\(r\)integral_(B\(0\,r\)) f\(x\)d x$)Where $Phi\(x\)= frac(1, n\(n - 2\)\|B\(0\,1\)\|) frac(1, \|x\|^(n - 2))$, then #math.equation(block: true, numbering: none, $phi.alt'\(r\) & = r / n frac(1, \|B\(0\,r\)\|) integral_(B\(0\,r\)) Delta u\(x\)d x + integral_(partial B\(0\,r\)) Phi\(x\)f\(x\)d S\
 & quad - Phi'\(r\)integral_(B\(0\,r\)) f\(x\)d x - Phi\(r\)integral_(partial B\(0\,r\)) f\(x\)d S\
 & = - r / n frac(1, \|B\(0\,r\)\|) integral_(B\(0\,r\)) f\(x\)d x + r / n frac(1, \|B\(0\,r\)\|) integral_(B\(0\,r\)) f\(x\)d x\
 & quad + integral_(partial B\(0\,r\)) (Phi \( x \) - Phi \( r \)) f\(x\)d S\
 & = 0$) #math.equation(block: true, numbering: none, $phi.alt\(s\) & = u\(0\)+ frac(1, \|partial B\(0\,s\)\|) integral_(partial B\(0\,s\)) (u \( x \) - u \( 0 \)) d S + integral_(B\(0\,s\)) Phi\(x\)f\(x\)d x - Phi\(s\)integral_(B\(0\,s\)) f\(x\)d x\
 & := u\(0\)+ I_1 + I_2 + I_3$) #math.equation(block: true, numbering: none, $\|I_1\|lt.eq frac(1, \|partial B\(0\,s\)\|) integral_(partial B\(0\,s\)) lr(|u \( x \) - u \( 0 \)|) d S arrow.r 0\,thin s arrow.r 0$) By the continuity of $u$ #math.equation(block: true, numbering: none, $\|I_2\|lt.eq lr(bar.v.double f bar.v.double)_(L^oo) integral_(B\(0\,s\)) Phi\(x\)d x = lr(bar.v.double f bar.v.double)_(L^oo) integral_(B\(0\,s\)) Phi\(x\)d x = frac(s^2 lr(bar.v.double f bar.v.double)_(L^oo), 2\(n - 2\)) arrow.r 0\,thin s arrow.r 0$) #math.equation(block: true, numbering: none, $\|I_3\|lt.eq Phi\(s\)lr(bar.v.double f bar.v.double)_(L^oo) integral_(B\(0\,s\)) d x = lr(bar.v.double f bar.v.double)_(L^oo) integral_(B\(0\,s\)) Phi\(x\)d x = frac(s^2 lr(bar.v.double f bar.v.double)_(L^oo), n\(n - 2\)) arrow.r 0\,thin s arrow.r 0$) Thus #math.equation(block: true, numbering: none, $u\(0\) & = lim_(s arrow.r 0) phi.alt\(s\)= lim_(s arrow.r r) phi.alt\(s\)\
 & = frac(1, \|partial B\(0\,r\)\|) integral_(partial B\(0\,r\)) g\(x\)d S + integral_(B\(0\,r\)) (Phi \( x \) - Phi \( r \)) f\(x\)d x$)

]
#aside("Problem", title:[2.5.4])[
#strong[a)]

Since #math.equation(block: true, numbering: none, $frac(d, d r) {frac(1, \|partial B\(x\,r\)\|) integral_(partial B\(x\,r\)) v \( y \) d S} = r / n frac(1, \|B\(x\,r\)\|) integral_(B\(x\,r\)) Delta v\(y\)d y gt.eq 0$) Thus #math.equation(block: true, numbering: none, $v\(x\)lt.eq frac(1, \|partial B\(x\,r\)\|) integral_(partial B\(x\,r\)) v\(y\)d S$) and #math.equation(block: true, numbering: none, $frac(1, \|B\(x\,r\)\|) integral_(B\(x\,r\)) v\(y\)d y & = frac(1, \|B\(x\,r\)\|) integral_0^r (integral_(partial B\(x\,s\)) v \( y \) d S) d s\
 & gt.eq v\(x\)frac(1, \|B\(x\,r\)\|) integral_0^r\|partial B\(x\,s\)\|d s\
 & = v\(x\)$) #strong[b)]

Suppose $v$ attains at $x_0 in U$ its maximum $upright(m a x)_(overline(U)) thin v > upright(m a x)_(partial U) thin v$, consider the connected component $U_0$ which contains $x_0$, then by $a\)$ we know that the set ${ x in U_0 med v\(x\)= upright(m a x)_(overline(U)) thin v }$ is both open and closed, thus $upright(m a x)_(partial U_0) thin v = upright(m a x)_(overline(U)) thin v$ which is a contradiction.

#strong[c)]

Since $phi.alt$ is convex, $phi.alt''\(x\)gt.eq 0$, thus #math.equation(block: true, numbering: none, $Delta v\(x\)= Delta phi.alt\(u\(x\)\)= phi.alt'\(u\(x\)\)Delta u + phi.alt''\(u\(x\)\)\|nabla u\|^2 = phi.alt''\(u\(x\)\)\|nabla u\|^2 gt.eq 0$) Hence $v$ is subharmonic.

#strong[d)]

#math.equation(block: true, numbering: none, $Delta v & = Delta\|nabla u\|^2 = 2 sum_(i\,j) u_(x_i x_j)^2 + 2 nabla u dot.op nabla\(Delta u\)gt.eq 0$) By #strong[a)] we know $v$ is subharmonic

]
#aside("Problem", title:[2.5.5])[
Define $M := upright(m a x)_(B\(0\,1\)) thin\|f\|$ and $v := u + frac(M, 2 n)\|x\|^2$, then we have $Delta v = Delta u + M = M - f gt.eq 0$ in $B^0\(0\,1\)$, thus $v$ is subharmonic, maximum principle still holds, hence #math.equation(block: true, numbering: none, $upright(m a x)_(B\(0\,1\)) thin u lt.eq upright(m a x)_(B\(0\,1\)) thin v = upright(m a x)_(partial B\(0\,1\)) thin v lt.eq upright(m a x)_(partial B\(0\,1\)) thin\|g\|+ frac(M, 2 n) = upright(m a x)_(B\(0\,1\)) thin\|v\|lt.eq upright(m a x)_(partial B\(0\,1\)) thin\|g\|+ frac(1, 2 n) upright(m a x)_(B\(0\,1\)) thin\|f\|$)Similary, we could consider ${- Delta\(- u\)= - f\
- u = - g$, then we would have #math.equation(block: true, numbering: none, $- upright(m i n)_(B\(0\,1\)) thin u = upright(m a x)_(B\(0\,1\)) thin\(- u\)lt.eq upright(m a x)_(partial B\(0\,1\)) thin\|g\|+ frac(1, 2 n) upright(m a x)_(B\(0\,1\)) thin\|f\|$) Therefore, we have #math.equation(block: true, numbering: none, $upright(m a x)_(B\(0\,1\)) thin\|u\|lt.eq upright(m a x)_(partial B\(0\,1\)) thin\|g\|+ frac(1, 2 n) upright(m a x)_(B\(0\,1\)) thin\|f\|lt.eq upright(m a x)_(partial B\(0\,1\)) thin\|g\|+ upright(m a x)_(B\(0\,1\)) thin\|f\|$)

]
#aside("Problem", title:[2.5.6])[
Using Poisson's formula and the fact that $u$ is harmonic, we have #math.equation(block: true, numbering: none, $u\(x\) & = frac(r^2 -\|x\|^2, \|partial B\(0\,1\)\|r) integral_(partial B\(0\,r\)) frac(u\(y\), \|x - y\|^n) d S\
 & lt.eq frac(r^2 -\|x\|^2, \|partial B\(0\,1\)\|r) integral_(partial B\(0\,r\)) frac(u\(y\), \(r -\|x\|\)^n) d S\
 & = frac(r^2 -\|x\|^2, \|partial B\(0\,1\)\|r) frac(1, \(r -\|x\|\)^n) integral_(partial B\(0\,r\)) u\(y\)d S\
 & = frac(r^(n - 2)\(r +\|x\|\), \(r -\|x\|\)^(n - 1)) u\(0\)$)Similarly, we have#math.equation(block: true, numbering: none, $u\(x\) & = frac(r^2 -\|x\|^2, \|partial B\(0\,1\)\|r) integral_(partial B\(0\,r\)) frac(u\(y\), \|x - y\|^n) d S\
 & gt.eq frac(r^2 -\|x\|^2, \|partial B\(0\,1\)\|r) integral_(partial B\(0\,r\)) frac(u\(y\), \(r +\|x\|\)^n) d S\
 & = frac(r^2 -\|x\|^2, \|partial B\(0\,1\)\|r) frac(1, \(r +\|x\|\)^n) integral_(partial B\(0\,r\)) u\(y\)d S\
 & = frac(r^(n - 2)\(r -\|x\|\), \(r +\|x\|\)^(n - 1)) u\(0\)$)Thus $frac(r^(n - 2)\(r -\|x\|\), \(r +\|x\|\)^(n - 1)) u\(0\)lt.eq u\(x\)lt.eq frac(r^(n - 2)\(r +\|x\|\), \(r -\|x\|\)^(n - 1)) u\(0\)$

]
#aside("Problem", title:[2.5.7])[
Since $K\(x\,y\)in C^oo\(B^0\(0\,1\)\)$, thus #math.equation(block: true, numbering: none, $u\(x\):= integral_(partial B\(0\,r\)) K\(x\,y\)g\(y\)d S\(y\)in C^oo\(B^0\(0\,1\)\)$) Also, #math.equation(block: true, numbering: none, $Delta u\(x\)= integral_(partial B\(0\,r\)) Delta_x K\(x\,y\)g\(y\)d S\(y\)= 0$)Since $Delta_x K\(x\,y\)= 0$, when $y in partial B\(0\,r\)$

By taking $u equiv 1$ we get $integral_(partial B\(0\,r\)) K\(x\,y\)d S\(y\)= 1$

Since $g in C\(partial B\(0\,r\)\)$, $\|g\|lt.eq M$ for some $M > 0$, and $forall epsilon.alt > 0\,exists delta > 0$, such that $lr(|g \( y \) - g \( x^0 \)|) lt.eq epsilon.alt\,forall y in partial B\(0\,r\)inter B\(x^0\,delta\)$, hence, when $\|x - x^0\|< delta / 2$, we have $\|x - y\|gt.eq\|x^0 - y\|-\|x - x^0\|> delta / 2\,forall y in partial B\(0\,r\)- B\(x^0\,delta\)$, hence #math.equation(block: true, numbering: none, $lr(|u \( x \) - g \( x^0 \)|) & = lr(|integral_(partial B\(0\,r\)) K \( x \, y \) (g \( y \) - g \( x^0 \)) d S \( y \)|)\
 & lt.eq lr(|integral_(partial B\(0\,r\)inter B\(x^0\,delta\)) K \( x \, y \) (g \( y \) - g \( x^0 \)) d S \( y \)|)\
 & quad + lr(|integral_(partial B\(0\,r\)- B\(x^0\,delta\)) K \( x \, y \) (g \( y \) - g \( x^0 \)) d S \( y \)|)\
 & lt.eq epsilon.alt integral_(partial B\(0\,r\)inter B\(x^0\,delta\)) K\(x\,y\)d S\(y\)+ 2 M integral_(partial B\(0\,r\)- B\(x^0\,delta\)) K\(x\,y\)d S\(y\)\
 & lt.eq epsilon.alt integral_(partial B\(0\,r\)) K\(x\,y\)d S\(y\)+ frac(2 M (r^2 - \| x \|^2), \|partial B\(0\,1\)\|r) integral_(partial B\(0\,r\)) 2^n / delta^n d S\(y\)\
 & = epsilon.alt + frac(2^(n + 1) M r^(n - 2) (r^2 - \| x \|^2), delta^n)$)Thus $lim_(x arrow.r x^0)_(x in B^0\(0\,r\)) thin u\(x\)= g\(x^0\)$

]
#aside("Problem", title:[1])[
\[January 2010\] #strong[a)]

Suppose $u\,u_1$ are two bounded solution, then $forall epsilon.alt > 0\,exists R > 0$, such that $forall r > R$ #math.equation(block: true, numbering: none, $u\(x\)- epsilon.alt ln\|x\|lt.eq u_1\(x\)lt.eq u\(x\)+ epsilon.alt ln\|x\|$) on $partial B\(0\,r\)$, using maximum principle for $u\(x\)- epsilon.alt ln\|x\|- u_1\(x\)$ and $u_1\(x\)- u\(x\)- epsilon.alt ln\|x\|$ on $B\(0\,r\)- B^0\(0\,1\)$

Thus the inequality above holds for any $epsilon.alt > 0$ and $\|x\|> 1$, let $epsilon.alt arrow.r 0$, we have $u = u_1$

#strong[b)]

$u equiv 1$ and $u\(x\)= frac(1, \|x\|)$ are both bounded solutions with $f equiv 1$

One additional condition that ascertain the uniqueness of the solution could be $lim_(x arrow.r oo) u\(x\)= 0$, in this case we would have #math.equation(block: true, numbering: none, $u\(x\)- epsilon.alt lt.eq u_1\(x\)lt.eq u\(x\)+ epsilon.alt$) On $partial B\(0\,r\)$ for sufficiently large $r$

]
#aside("Problem", title:[1])[
\[January 2005\] #strong[Lemma:] If $g = sum_(k = 0)^oo a_k z^k$ is a holomorphic fuction on $bb(C)$, then #math.equation(block: true, numbering: none, $integral integral_(B\(0\,R\))\|f'\(z\)\|^2 d x d y = sum_(k = 0)^oo\|a_k\|^2 frac(pi R^(2 k + 2), k + 1)$) #strong[Proof:] Using the fact that #math.equation(block: true, numbering: none, $integral integral_(B\(0\,R\)) z^k overline(z)^l d x d y = {frac(pi R^(2 k + 2), k + 1)\,thin k = l\
0\,#h(2em) quad k eq.not l$) #strong[Method 1:]

Since $u$ is harmonic on $bb(R)^2$, there exists a holomorphic function $f$ on $bb(C)$, such that $upright(R e) f = u$, then $\|nabla u\|=\|f'\|$, hence we have $integral integral_(bb(R)^2)\|nabla u\|^2 d x d y = integral integral_(bb(C))\|f'\(z\)\|^2 d x d y < oo$, according to the lemma above, we have $f' equiv 0$, hence $f$ is a constant, so is $u$

#strong[Method 2:]

According to #strong[2.5.4 d)], we know that $\|nabla u\|^2$ is subharmonic, thus #math.equation(block: true, numbering: none, $\|nabla u\(x\)\|^2 lt.eq frac(1, \|B\(x\,r\)\|) integral_(B\(x\,r\))\|nabla u\(y\)\|^2 d y lt.eq frac(1, \|B\(x\,r\)\|) integral_(bb(R)^2)\|nabla u\(y\)\|^2 d y$)Which tends to $0$ as $r$ tends to $0$, thus $nabla u equiv 0$, $u$ is a constant

]
#aside("Problem", title:[1])[
\[August 2004\] Assume $f equiv.not 0$, since $f in C^1\(bb(R)^n\)$, there is some $B\(x\,epsilon.alt\)$, such that $f$ is positive(negative) on it, consider $v equiv 1$, then we have#math.equation(block: true, numbering: none, $0 & = integral_(partial B\(x\,epsilon.alt\)) v frac(partial u, partial n) d S = integral_(B\(x\,epsilon.alt\)) v Delta u d x + integral_(B\(x\,epsilon.alt\)) nabla v dot.op nabla u d x\
 & = integral_(B\(x\,epsilon.alt\)) nabla v dot.op nabla u d x - integral_(B\(x\,epsilon.alt\)) v f d x\
 & = - integral_(B\(x\,epsilon.alt\)) f d x <\(>\)0$) Which is a contradiction, Thus $f equiv 0$

]
#pagebreak(weak:true)
== Homework2
<homework2>
#aside("Problem", title:[2.5.13])[
#strong[\(a)]

We have $u_t = - frac(x, 2 t^(3 / 2)) v'$ and $u_(x x) = 1 / t v''$, thus $u_t - u_(x x) = 0 arrow.l.r.double - frac(x, 2 t^(3 / 2)) v' - 1 / t v'' = 0 arrow.l.r.double v'' + z / 2 v' = 0$

Multiply $e^(z^2 / 4)$ on both sides, we get $e^(z^2 / 4) v'' + frac(z e^(z^2 / 4), 2) v' = (e^(z^2 / 4) v')' = 0$, Thus $e^(z^2 / 4) v' = c$ for some constant $c$, $v' = c e^(- z^2 / 4) arrow.r.double v = c integral_0^z e^(- s^2 / 4) d s + d$ for some other constant $d$

#strong[\(b)]

According to (a), we have $u\(x\,t\)= c integral_0^(x / sqrt(t)) e^(- s^2 / 4) d s + d$, thus $u_x = c / sqrt(t) e^(- frac(x^2, 4 t))$, which again solve the heat equation, in order to obtain a fundamental solution, we also need $lim_(t arrow.b 0) u_x\(x\,t\)= u_x\(x\,0\)= delta_0$, thus we should have $1 = integral_(bb(R)) u_x\(x\,0\)d x = integral_(bb(R)) lim_(t arrow.b 0) u_x\(x\,t\)d x = lim_(t arrow.b 0) integral_(bb(R)) u_x\(x\,t\)d x = lim_(t arrow.b 0) integral_(bb(R)) c / sqrt(t) e^(- frac(x^2, 4 t)) d x = 2 c sqrt(pi) arrow.r.double thin c = 1 / sqrt(4 pi)$

]
#aside("Problem", title:[2.5.14])[
Consider $v = u e^(c t)$, we have $v_t - Delta v = e^(c t) (u_t - Delta u + c u)$, thus the initial value problem becomes

#math.equation(block: true, numbering: none, ${v_t - Delta v = f e^(c t)\,thin upright("in") thin bb(R)^n times\(0\,oo\)\
v = g\,thin upright("on") thin bb(R)^n times { t = 0 }$) Solve it to get #math.equation(block: true, numbering: none, $v\(x\,t\)= integral_(bb(R)^n) Phi\(x - y\,t\)g\(y\)d y + integral_0^t integral_(bb(R)^n) Phi\(x - y\,t - s\)f\(y\,s\)e^(c s) d y d s$) Thus #math.equation(block: true, numbering: none, $u\(x\,t\)= integral_(bb(R)^n) Phi\(x - y\,t\)g\(y\)e^(- c t) d y + integral_0^t integral_(bb(R)^n) Phi\(x - y\,t - s\)f\(y\,s\)e^(- c\(t - s\)) d y d s$)

]
#aside("Problem", title:[January 2013, Problem 4])[
#strong[\(a)]

Since $u\(x\,t\)= integral_0^x u_x\(y\,t\)d y + u\(0\,t\)= integral_0^x u_x\(y\,t\)d y$ #math.equation(block: true, numbering: none, $\|u\(x\,t\)\|^2 = lr(|integral_0^x u_x \( y \, t \) d y|)^2 lt.eq (integral_0^1 \| u_x \( y \, t \) \| d y)^2 lt.eq (integral_0^1 \| u_x \( y \, t \) \|^2 d y) (integral_0^11 ""^2 d y) = integral_0^1\|u_x\(y\,t\)\|^2 d y$) Hence $sup_x\|u\(x\,t\)\|^2 lt.eq integral_0^1\|u_x\(y\,t\)\|^2 d y$

Then we have #math.equation(block: true, numbering: none, $integral_0^1 u^3 d x & lt.eq integral_0^1\|u^3\|d x lt.eq (integral_0^1 \| u_x \|^2 d x) integral_0^1\|u\|d x\
 & lt.eq (integral_0^1 \| u_x \|^2 d x) (integral_0^1 \| u \|^2 d x)^(1 / 2) (integral_0^11 ""^2 d y)^(1 / 2)\
 & = (integral_0^1 \| u_x \|^2 d x) (integral_0^1 \| u \|^2 d x)^(1 / 2)$) Since $u$ is smooth, we have #math.equation(block: true, numbering: none, $frac(d, d t) integral_0^1\|u\|^2 d x & = integral_0^1 frac(d, d t) u^2 d x = integral_0^12 u u_t d x = 2 integral_0^1 u\(u_(x x) + c u^2\)d x\
 & = 2 u u_(x x)\|_0^1 - 2 integral_0^1\|u_x\|^2 d x + 2 c integral_0^1 u^3 d x\
 & lt.eq - 2 integral_0^1\|u_x\|^2 d x + 2 c (integral_0^1 \| u_x \|^2 d x) (integral_0^1 \| u \|^2 d x)^(1 / 2)\
 & = - 2 (integral_0^1 \| u_x \|^2 d x) (1 - c (integral_0^1 \| u \|^2 d x)^(1 / 2))$) #strong[\(b)]

Since $u$ is smooth, so is $F\(t\):= (integral_0^1 \| u \|^2 d x)^(1 / 2)$, suppose $exists t_0 in\(0\,oo\)$ such that $F\(t_0\)gt.eq 1 / c^2$, then $diameter eq.not S := {t in \[ 0 \, t_0 \] \| F \( t \) = 1 / c^2}$ is closed, let $0 < t_1 = min_(t in S) t$, then we have $F\(t_1\)= 1 / c^2$ and $F\(t\)< 1 / c^2$ for $t in\[0\,t_1\)$, using intermediate value theorem, we have $0 < F\(t_1\)- F\(0\)= F'\(xi\)t_1$, where $xi in\(0\,t_1\)$, but according to (a), we have $F'\(xi\)lt.eq - 2 (integral_0^1 \| u_x \|^2 d x) (1 - c F \( xi \)^(1 / 2)) lt.eq 0$ which leads to a contradiction

]
#aside("Problem", title:[January 2012, Problem 2])[
#strong[\(a)]

This is equivalent to solve ODE ${w' + w^3 = 0\,thin t > 0\
w\(0\)= c$, thus $w\(t\)= 1 / sqrt(2 t + 1 / c^2)$

#strong[\(b)]

Assume otherwise, then $exists\(t_0\,x_0\)in\(0\,oo\)times\(0\,1\)$ such that $\(w - u\)\(t_0\,x_0\)< 0$, suppose $w - u$ must attain the minimum of $\[0\,t_0\]times\[0\,1\]$ at $\(t_1\,x_1\)$, then $\(w - u\)\(t_1\,x_1\)< 0$, thus $0 lt.eq w\(t_1 . x_1\)< u\(t_1 . x_1\)$, hence $w^3\(t_1 . x_1\)< u^3\(t_1 . x_1\)$, then we would have $0 < u^3\(t_1 . x_1\)- w^3\(t_1 . x_1\)=\(frac(partial, partial t) - Delta\)\(w - u\)\(t_1\,x_1\)gt.eq 0$ which is a contradiction, hence $u\(t\,x\)lt.eq 1 / sqrt(2 t + 1 / c^2)$ on $\[0\,oo\)times\[0\,1\]$

]
#aside("Problem", title:[August 2011, Problem 3])[
#strong[\(a)]

Assume $exists\(x_0\,t_0\)in Omega times\(0\,oo\)$ such that $u\(x_0\,t_0\)< 0$, suppose $u\(x_1\,t_1\)= min_(macron(Omega)_(t_0)) u < 0$, since $\|f'\|lt.eq K$, $f\(x\)= integral_0^x f' d y lt.eq integral_0^x K d y = K x$ if $x gt.eq 0$, or $f\(x\)gt.eq K x$ if $x < 0$

let $K_1 > K$, then $0 gt.eq (frac(partial, partial t) - Delta) (u e^(- K_1 t)) = e^(- K_1 t) [(frac(partial, partial t) - Delta) u - K_1 u] = e^(- K_1 t) [f \( u \) - K_1 u] = e^(- K_1 t) integral_u^0 [K_1 - f'] d x > 0$ at $\(x_1\,t_1\)$ which is a contradiction

#strong[\(b)]

Assume $exists\(x_0\,t_0\)in Omega times\(0\,oo\)$ such that $u\(x_0\,t_0\)> M e^(K t_0) arrow.r.double u\(x_0\,t_0\)e^(- K_1 t_0) > M$ for some $K_1 > K$, suppose $u\(x_1\,t_1\)e^(- K_1 t_1) = max_(macron(Omega)_(t_0)) u e^(- K_1 t) > 0$

$0 lt.eq (frac(partial, partial t) - Delta) (u e^(- K_1 t)) = e^(- K_1 t) [f \( u \) - K_1 u] = e^(- K_1 t) integral_0^u [f' - K_1] d x < 0$ at $\(x_1\,t_1\)$ which is a contradiction

]
#aside("Problem", title:[August 2005, Problem 6])[
Suppose $\|f'\|< K$, $u\,w$ are both solutions, then $\(u - w\)e^(K t) = 0$ on $Omega times { 0 } union partial Omega times\(0\,oo\)$, Assume $exists\(x_0\,t_0\)in Omega times\(0\,oo\)$ such that $\(u - w\)\(x_0\,t_0\)e^(K t_0) < 0$, suppose $\(u - w\)\(x_1\,t_1\)e^(- K t_1) = min_(macron(Omega)_(t_0))\(u - w\)e^(K t) < 0$, the we have $0 gt.eq (frac(partial, partial t) - Delta) (\( u - w \) e^(K t)) = e^(- K t) [(f \( w \) - f \( u \)) + K \( u - w \)] = e^(- K t) integral_u^w [f' + K] d x > 0$ at $\(x_1\,t_1\)$, which is a contradiction

]
#aside("Problem", title:[2.5.15])[
Define $v\(x\,t\)= u\(x\,t\)- g\(t\)$ on $x gt.eq 0$, extend $v$ to ${ x < 0 }$ by odd reflection, then we have $v\(x\,t\)= - v\(- x\,t\)$ on $x < 0$, thus the initial boundary problem becomes #math.equation(block: true, numbering: none, ${v_t - v_(x x) = - g'\(t\)\,thin upright("in ") bb(R)_(+) times\(0\,oo\)\
v_t - v_(x x) = g'\(t\)\,thin upright("in ") bb(R)_(-) times\(0\,oo\)\
v = 0\,thin upright("on ") bb(R)_(+) times { t = 0 }\
v = 0\,thin upright("on ") { x = 0 } times\[0\,oo\)$) Define $f\(x\,t\)= {- g'\(t\)\,thin x gt.eq 0\
g'\(t\)\,thin x < 0$, we have #math.equation(block: true, numbering: none, $v\(x\,t\) & = integral_0^t 1 / sqrt(4 pi\(t - s\)) integral_(bb(R)) e^(- frac(\(x - y\)^2, 4\(t - s\))) f\(y\,s\)d y d s\
 & = integral_0^t 1 / sqrt(4 pi\(t - s\)) (integral_(- oo)^0 e^(- frac(\(x - y\)^2, 4\(t - s\))) g' \( s \) d y - integral_0^oo e^(- frac(\(x - y\)^2, 4\(t - s\))) g' \( s \) d y) d s\
 & = 1 / sqrt(pi) integral_0^t (integral_(- oo)^(- x / sqrt(4\(t - s\))) e^(- y^2) d y - integral_(- x / sqrt(4\(t - s\)))^oo e^(- y^2) d y) g'\(s\)d s\
 & = 1 / sqrt(pi) g \( s \) (integral_(- oo)^(- x / sqrt(4\(t - s\))) e^(- y^2) d y - integral_(- x / sqrt(4\(t - s\)))^oo e^(- y^2) d y)\|_0^t + x / sqrt(4 pi) integral_0^t 1 / (\( t - s \))^(3 / 2) e^(- frac(x^2, 4\(t - s\))) g\(s\)d s\
 & = - upright(s g n)\(x\)1 / sqrt(pi) g\(t\)integral_(- oo)^oo e^(- y^2) d y - x / sqrt(4 pi) integral_0^t 1 / (\( t - s \))^(3 / 2) e^(- frac(x^2, 4\(t - s\))) g\(s\)d s\
 & = - upright(s g n)\(x\)g\(t\)- x / sqrt(4 pi) integral_0^t 1 / (\( t - s \))^(3 / 2) e^(- frac(x^2, 4\(t - s\))) g\(s\)d s$) Where $upright(s g n)\(x\)= {- 1\,thin x < 0\
0\,thin x = 0\
1\,thin x > 0$, thus $u\(x\,t\)= x / sqrt(4 pi) integral_0^t 1 / (\( t - s \))^(3 / 2) e^(- frac(x^2, 4\(t - s\))) g\(s\)d s$ is the solution

]
#aside("Problem", title:[2.5.17])[
#strong[a)]

Define $phi.alt\(r\):= frac(1, 4 r^n) integral integral_(E\(0\,0\;r\)) v\(y\,s\)frac(\|y\|^2, s^2) d y d s$, then #math.equation(block: true, numbering: none, $phi.alt'\(r\) & = 1 / r^(n + 1) integral integral_(E\(0\,0\;r\)) - n v_s psi - frac(n, 2 s) sum_(i = 1)^n v_(y_i) y_i d y d s\
 & gt.eq 1 / r^(n + 1) integral integral_(E\(0\,0\;r\)) - n Delta v psi - frac(n, 2 s) sum_(i = 1)^n v_(y_i) y_i d y d s\
 & = 0$) Since $phi.alt\(r\)= v\(0\,0\)+ frac(1, 4 r^n) integral integral_(E\(0\,0\;r\)) (v \( y \, s \) - v \( 0 \, 0 \)) frac(\|y\|^2, s^2) d y d s arrow.r v\(0\,0\)\,thin r arrow.r 0$, $v\(0\,0\)= lim_(s arrow.r 0) phi.alt\(r\)lt.eq lim_(s arrow.r r) phi.alt\(s\)= phi.alt\(r\)$

Thus $v\(x\,t\)lt.eq frac(1, 4 r^n) integral integral_(E\(x\,t\;r\)) v\(y\,s\)frac(\|x - y\|^2, \(t - s\)^2) d y d s$

#strong[b)]

Define $v_epsilon.alt\(x\,t\)= v\(x\,t\)+ epsilon.alt\|x\|^2$, then $(frac(partial, partial t) - Delta) v_epsilon.alt = (frac(partial, partial t) - Delta) v - 2 n epsilon.alt < 0$, $v_epsilon.alt$ can't attain its maximum at $\(x_0\,t_0\)in overline(U_T)\\Gamma_T$, otherwise $frac(partial, partial t) v_epsilon.alt\(x_0\,t_0\)gt.eq 0\,Delta v_epsilon.alt\(x_0\,t_0\)lt.eq 0$, then $Delta v_epsilon.alt\(x_0\,t_0\)gt.eq 0$, thus $upright(m a x)_(overline(U_T)) (v + epsilon.alt \| x \|^2) lt.eq upright(m a x)_(Gamma_T) (v + epsilon.alt \| x \|^2) lt.eq upright(m a x)_(Gamma_T) thin v + C epsilon.alt$ since $U$ is bounded, hence $upright(m a x)_(overline(U_T)) thin v = upright(m a x)_(Gamma_T) thin v$ #strong[c)]

Since $phi.alt$ is convex, $phi.alt''\(x\)gt.eq 0$ #math.equation(block: true, numbering: none, $(frac(partial, partial t) - Delta) v\(x\)= (frac(partial, partial t) - Delta) phi.alt (v \( x \, t \)) = phi.alt'\(v\)(frac(partial v, partial t) - Delta) v - phi.alt''\(v\)\|nabla v\|^2 lt.eq 0$) Thus $v$ is a subsolution

#strong[d)]

#math.equation(block: true, numbering: none, $(frac(partial, partial t) - Delta) v & = (frac(partial, partial t) - Delta) (lr(|nabla u|)^2 + u_t^2)\
 & = 2 nabla u dot.op nabla u_t + 2 u_t u_(t t) - 2 sum_(i\,j) u_(x_i x_j)^2 - 2 nabla u dot.op nabla\(Delta u\)- 2\|nabla u_t\|^2 - 2 u_t\(Delta u\)_t\
 & = 2 nabla u dot.op nabla\(u_t - Delta u\)+ 2 u_t\(u_t - Delta u\)_t - 2 sum_(i\,j) u_(x_i x_j)^2 - 2\|nabla u_t\|^2\
 & lt.eq 0$) Thus $v$ is a subsolution

]
#pagebreak(weak:true)
== Homework3
<homework3>
#aside("Problem", title:[2.5.24])[
Since the solution is given by d'Alembert's formula #math.equation(block: true, numbering: none, $u\(x\,t\)= 1 / 2\[g\(x + t\)- g\(x - t\)\]+ 1 / 2 integral_(x - t)^(x + t) h\(y\)d y$) and $g\,h$ are compactly supported, $u\(x\,t\)$ is also compactly supported for any fixed $t$, hence $k\(t\)\,p\(t\)$ make sense

#strong[\(a)]

#math.equation(block: true, numbering: none, $frac(d, d t)\(p\(t\)+ k\(t\)\)= integral_(- oo)^(+ oo) u_t u_(t t) + u_x u_(x t) d x = integral_(- oo)^(+ oo) u_t u_(x x) + u_x u_(x t) d x = integral_(- oo)^(+ oo) frac(partial, partial x) (u_t u_x) d x = u_t u_x\|""_(- oo)^(+ oo) = 0$) Thus $k\(t\)+ p\(t\)$ is a constant in $t$

#strong[\(b)]

#math.equation(block: true, numbering: none, $ & u_t\(x\,t\)= 1 / 2\[g'\(x + t\)- g'\(x - t\)\]+ 1 / 2\[h\(x + t\)+ h\(x - t\)\]\
 & u_x\(x\,t\)= 1 / 2\[g'\(x + t\)+ g'\(x - t\)\]+ 1 / 2\[h\(x + t\)- h\(x - t\)\]$) Suppose $upright(s u p p) thin g union upright(s u p p) thin h subset D\(0\,T\)$, then consider $t > T$, one of $g'\(x + t\)\,g'\(x - t\)$ must be zero and one of $h\(x + t\)\,h\(x - t\)$ must be zero, thus $u_t^2 = u_x^2$, $p\(t\)= k\(t\)$

#strong[Additional Problem]

#math.equation(block: true, numbering: none, $\|u\(x\,t\)\| & = lr(|frac(1, 4 pi t) integral_(partial B\(x\,t\)) f \( y \) d S_y|)\
 & = lr(|frac(t, 4 pi) integral_(S^2) f \( x + t omega \) d S_omega|)\
 & = lr(|- frac(t, 4 pi) integral_(S^2) integral_t^(- oo) frac(d, d lambda) f \( x + lambda omega \) d lambda d S_omega|)\
 & = lr(|- frac(t, 4 pi) integral_(S^2) integral_t^(- oo) \( nabla f dot.op omega \) \( x + lambda omega \) d lambda d S_omega|)\
 & lt.eq frac(t, 4 pi) integral_(S^2) integral_t^(- oo) lr(|nabla f|)\|omega\|\(x + lambda omega\)d lambda d S_omega\
 & = frac(t, 4 pi) integral_(S^2) integral_t^(- oo) lr(|nabla f|)\(x + lambda omega\)d lambda d S_omega\
 & = frac(t, 4 pi) integral_(partial B\(x\,lambda\)) integral_t^(- oo) lr(|nabla f|)\(y\)d lambda d S_y\
 & lt.eq frac(1, 4 pi t) integral_(bb(R)^3) lr(|nabla f|) d y\
$)

]
#aside("Problem", title:[January 2007, Problem 2])[
#strong[\(a)]

Define #math.equation(block: true, numbering: none, $E\(t\)= 1 / 2 integral_(partial Omega) u^2 d S + 1 / 2 integral_Omega {u_t^2 + \| nabla u \|^2 + V \( x \) u^2} d x$) Then we have #math.equation(block: true, numbering: none, $E'\(t\) & = integral_(partial Omega) u u_t d S + integral_Omega {u_t u_(t t) + nabla u dot.op nabla u_t + V \( x \) u u_t} d x\
 & = integral_(partial Omega) u u_t d S + integral_Omega {u_t (Delta u - V \( x \) u) + nabla u dot.op nabla u_t + V \( x \) u u_t} d x\
 & = integral_(partial Omega) u u_t d S + integral_Omega {u_t Delta u + nabla u dot.op nabla u_t} d x\
 & = integral_(partial Omega) u u_t d S + integral_(partial Omega) u_t frac(partial u, partial n) d S\
 & = integral_(partial Omega) u_t (u + frac(partial u, partial n)) d S\
 & = 0$) #strong[\(b)]

Uniqueness theorem: Suppose $u\,v$ are two solutions to the equation, then $u = v$

Consider $w = u - v$ which satisfies equation $w_(t t) - Delta w + V\(x\)w = 0\,thin x in Omega\,t > 0$, with initial conditions $w\(x\,0\)= 0\,w_t\(x\,0\)= 0$ and boundary conditions $w + frac(partial w, partial n) = 0$

Since $E\(0\)= 1 / 2 integral_(partial Omega) w^2\(x\,0\)d S + 1 / 2 integral_Omega {w_t^2 \( x \, 0 \) + \| nabla w \|^2 \( x \, 0 \) + V \( x \) w^2 \( x \, 0 \)} d x = 0$ and $E'\(t\)= 0$, hence $E\(t\)= 0$, since $V\(x\)gt.eq 0$, $u = 0$

#strong[\(c)]

As for $h eq.not 0$, the result is the same as (b)

]
#aside("Problem", title:[August 2003, Problem 4])[
Suppose there are two solutions $u\,v$, define $w = u - v$, which would satisfies equation

#math.equation(block: true, numbering: none, $w_(t t) - w_(x x) - w_(y y t) = 0\,thin\(x\,y\)in Omega\,thin t > 0$)#math.equation(block: true, numbering: none, $w\(x\,y\,0\)= 0\,thin w_t\(x\,y\,0\)= 0$)#math.equation(block: true, numbering: none, $w\(0\,y\,t\)= w\(1\,y\,t\)= 0\,thin w_y\(x\,0\,t\)= w_y\(x\,1\,t\)= 0$) Consider $E\(t\)= 1 / 2 integral_Omega\(w_t^2 + w_x^2\)d x d y$, since #math.equation(block: true, numbering: none, $w\(0\,y\,t\)= w\(1\,y\,t\)= 0 arrow.r.double w_t\(0\,y\,t\)= w_t\(1\,y\,t\)= 0$)#math.equation(block: true, numbering: none, $w_y\(x\,0\,t\)= w_y\(x\,1\,t\)= 0 arrow.r.double w_(y t)\(x\,0\,t\)= w_(y t)\(x\,1\,t\)= 0$) Thus we have #math.equation(block: true, numbering: none, $E'\(t\) & = integral_Omega\(w_t w_(t t) + w_x w_(x t)\)d x d y\
 & = integral_Omega\(w_t w_(x x) + w_t w_(y y t) + w_x w_(x t)\)d x d y\
 & = integral_0^1 integral_0^1\(w_t w_x\)_x d x d y + integral_0^1 integral_0^1\(w_t w_(y t)\)_y d y d x - integral_Omega w_(y t)^2 d x d y\
 & lt.eq integral_0^1\[w_t w_x\(1\,y\,t\)- w_t w_x\(0\,y\,t\)\]d y + integral_0^1\[w_t w_(y t)\(x\,1\,t\)- w_t w_(y t)\(x\,0\,t\)\]d x\
 & = 0$) Thus $u_x = 0$, but $u\(0\,y\,t\)= 0$, hence $u = 0$

]
#aside("Problem", title:[August 2003, Problem 5])[
Since #math.equation(block: true, numbering: none, $u\(0\,t\)^2 & = (frac(1, 4 pi t) integral_(partial B\(0\,t\)) g \( y \) d S_y)^2\
 & lt.eq frac(1, 8 pi^2 t^2) (integral_(partial B\(0\,t\)) g \( y \)^2 d S_y) (integral_(partial B\(0\,t\)) 1^2 d S_y)\
 & = frac(1, 4 pi) integral_(S^2) g\(y\)^2 d S_y\
$) Thus #math.equation(block: true, numbering: none, $integral_0^oo u\(0\,t\)^2 d t lt.eq integral_0^oo frac(1, 4 pi) integral_(partial B\(0\,t\)) g\(y\)^2 d S_y d t = frac(1, 4 pi) integral_(bb(R)^3) g\(x\)^2 d x$)

]
#aside("Problem", title:[August 2006, Problem 3])[
#strong[\(a)]

Direct check to find $u_(t t) - Delta u = 0$ when $r eq.not 0$, if $t < 1$, then $psi\(t + r\)= 0$ on a neighborhood of $r = 0$, thus $u\(x\,t\)= 0$ on this neighborhood, hence $u_(t t) - Delta u = 0$, if $t < 1$

#strong[\(b)]

The extended formula should be given by $u\(x\,t\)= frac(psi\(t + r\)- psi\(t - r\), r) = integral_(- 1)^1 psi'\(t + lambda r\)d lambda$

#strong[\(c)]

Since $psi in C^k$ by the formula of $psi$ we showed that $u in C^(k - 1)$

#strong[\(d)]

Since $psi$ is compactly supported, so is $u$

Define Energy to be $E\(t\)= 1 / 2 integral_(bb(R)^3) (u_t^2 + \| nabla u \|^2) d x$, then #math.equation(block: true, numbering: none, $E'\(t\) & = integral_(bb(R)^3) (u_t u_(t t) + nabla u dot.op nabla u_t) d x\
 & = integral_(bb(R)^3) (u_t Delta u + nabla u dot.op nabla u_t) d x\
 & = integral_(B\(0\,R\)) (u_t Delta u + nabla u dot.op nabla u_t) d x\
 & = integral_(partial B\(0\,R\)) u_t frac(partial u, partial n) d S\
 & = 0$) Hence the energy is conserved

]
#aside("Problem", title:[August 2001, Problem 1])[
#strong[\(a)]

#math.equation(block: true, numbering: none, $u\(x\,t\)= frac(1, 4 pi t) integral_(partial B\(x\,t\)) g\(y\)d S_y = frac(t, 4 pi) integral_(S^2) g\(x + t omega\)d S_omega$) but $\|x + t omega\|gt.eq t\|omega\|-\|x\|= t -\|x\|gt.eq a$, $g\(x + t omega\)= 0$, hence $u\(x\,t\)= 0$

#strong[\(b)]

First we prove $g = 0$, assume $g\(x_1\)> 0$, then $u\(x_0\,\|x_1 - x_0\|\)= frac(\|x_1 - x_0\|, 4 pi) integral_(S^2) g\(x_0 +\|x_1 - x_0\|omega\)d S_omega > 0$, since $g in C\(bb(R)^3\)\,g gt.eq 0$, that is a contradiction, thus $g = 0$, $u\(x\,t\)= 0$

]
#pagebreak(weak:true)
== Homework4
<homework4>
#aside("Problem", title:[August 2006, Problem 1])[
Define $F\(x\,t\,p\,q\,z\)= q + x p - z^2$

The characteristics are #math.equation(block: true, numbering: none, ${mat(delim:#none, dot(x) = x; dot(t) = 1; dot(z) = x p + q = z^2)$) With initial condition #math.equation(block: true, numbering: none, ${mat(delim:#none, x\(0\)= x^0; t\(0\)= 0; z\(0\)= f\(x^0\))$) Thus we get #math.equation(block: true, numbering: none, ${mat(delim:#none, x = x^0 e^s; t = s; z\(0\)= frac(f\(x^0\), 1 - s f\(x^0\)))$) which is defined on ${t f \( x e^(- t) \) eq.not 1}$, thus $u\(x\,t\)= frac(f\(x e^(- t)\), 1 - t f\(x e^(- t)\))$

]
#aside("Problem", title:[January 2005, Problem 2(b)])[
Define $F\(x\,t\,p\,q\,z\)= q +\(2 z + 1\)p$

The characteristics are #math.equation(block: true, numbering: none, ${mat(delim:#none, dot(x) = 2 z + 1; dot(t) = 1; dot(z) = 0)$) With initial condition #math.equation(block: true, numbering: none, ${mat(delim:#none, x\(0\)= x^0; t\(0\)= 0; z\(0\)= u\(x^0\,0\))$) Thus we get #math.equation(block: true, numbering: none, ${mat(delim:#none, x = x^0 + (2 u \( x^0 \, 0 \) + 1) s; t = s; z\(0\)= u\(x^0\,0\))$) By Rankine-Hugoniot condition, we have $0 = F\(u_l\)- F\(u_r\)= dot(s)\(t\)\(u_l - u_r\)= 3 dot(s)\(t\)$

Thus we have a piecewise smooth solution #math.equation(block: true, numbering: none, $u\(x\,t\)= {mat(delim:#none, 1\,thin x < 0; - 2\,thin x > 0)$)

]
#aside("Problem", title:[January 2000, Problem 2])[
Consider the initial condition to be #math.equation(block: true, numbering: none, $g\(x\)= {mat(delim:#none, 0\,thin x < 0; 1\,thin 0 < x < 1; 0\,thin x > 1)$) Then #math.equation(block: true, numbering: none, $X\(t\)= {mat(delim:#none, 1 + t / 3\,thin 0 < t < 3 / 2; root(3, 9 / 4 t)\,thin t > 3 / 2) quad f (x / t) = {mat(delim:#none, sqrt(x / t)\,thin 0 < x < X\(t\)\,x / t < 1; 1\,thin 0 < x < X\(t\)\,x / t > 1)$) $forall t in [0 \, 3 / 2]$, $integral_0^oo u\(x\,t\)d x = integral_0^t sqrt(x / t) d x + integral_t^(1 + t / 3) 1 d x = 2 / 3 t + (1 - 2 / 3 t) = 1$

$forall t in (3 / 2 \, oo)$, $integral_0^oo u\(x\,t\)d x = integral_0^(root(3, 9 / 4 t)) sqrt(x / t) d x = 1$

Along $x = t\,0 lt.eq t lt.eq 3 / 2$, $u_l = 1 = u_r$

Along $x = 1 + t / 3\,0 lt.eq t lt.eq 3 / 2$, $1 = u_l > 1 / 3 = dot(X)\(t\)> 0 = u_r$

Along $x = root(3, 9 / 4 t)\,t > 3 / 2$, $u_l = t^(- 1 / 3) root(3, 3 / 2) > 1 / 3 t^(- 2 / 3) root(3, 9 / 4) = dot(X)\(t\)> 0 = u_r$

Which shows that $u$ satisfies the entropy condition, and along $x = t\,0 lt.eq t lt.eq 3 / 2$, $u$ is a rarefaction wave, along $X\(t\)$, $u$ is a shock wave

#align(center)[
#svg-drawing("<defs><clipPath id='plot'><rect x='57.5' y='32.5' width='227.5' height='390'/></clipPath></defs><path d='M57.5 390H295' marker-end='url(#a)'/><path d='M90 422.5V22' marker-end='url(#a)'/><g clip-path='url(#plot)'><path d='M90 390L187.5 292.5' stroke='#0000ff' stroke-width='2'/><path d='M155 390L187.5 292.5' stroke='#993300' stroke-width='2'/><path d='" + sampled-path(t => (90 + 65 * calc.pow(9 * t / 4, 1 / 3), 390 - 65 * t), start: 1.5, stop: 6) + "' stroke='#2e7d32' stroke-width='2'/><path d='M90 390L285 -1469M90 390L285 -498.5M90 390L285 -176.5M90 390L229.793 102.624M90 390L210.451 206.167M90 390L171.25 341.25M90 390L162.445 367.666' stroke-width='0.7' stroke-dasharray='1 3'/></g><g fill='black' stroke='none' font-family='serif' font-size='12'><text x='87' y='405'>0</text><text x='152' y='405'>1</text><text x='217' y='405'>2</text><text x='282' y='405'>3</text><text x='75' y='328'>1</text><text x='75' y='263'>2</text><text x='75' y='198'>3</text><text x='75' y='133'>4</text><text x='75' y='68'>5</text></g><g fill='#1565c0' stroke='none'><circle cx='90' cy='390' r='2'/><circle cx='155' cy='390' r='2'/><circle cx='187.5' cy='292.5' r='2'/></g>", width: 65%, height: 440)
]
]
#aside("Problem", title:[August 1998, Problem 5])[
$0 = u_t + u u_x = u_t + (1 / 2 u^2)_x$, since $u$ and $xi\(t\)$ are both continuous, so is $u\(xi\(t\)\,t\)$, there is a $C^1$ function $u_L$ in a neighborhood of $C_l$ which agrees with $u$ on $C_l$ and curve $C$, and there is a $C^1$ function $u_R$ in a neighborhood of $C_r$ which agrees with $u$ on $C_r$ and curve $C$, $frac(d, d t) u\(xi\(t\)\,t\)= frac(d, d t) u_L\(xi\(t\)\,t\)$ is continuous since $u_L$ and $xi$ are both $C^1$ function, then we have $frac(d, d t) u_L\(xi\(t\)\,t\)= frac(d, d t) u_R\(xi\(t\)\,t\)$ $arrow.r.double$ $0 = frac(d, d t) u_L\(xi\(t\)\,t\)- frac(d, d t) u_R\(xi\(t\)\,t\)= (u_x^(-) - u_x^(+)) xi' + (u_t^(-) - u_t^(+))$

On the other hand, since $u$ is continuous, $0 = u_t^(-) + u^(-) u_x^(-) = u_t^(-) + u u_x^(-) = u_t^(+) + u^(+) u_x^(+) = u_t^(+) + u u_x^(+)$ $arrow.r.double$ $0 = (u_t^(-) + u u_x^(-)) - (u_t^(+) + u u_x^(+)) = (u_x^(-) - u_x^(+)) u + (u_t^(-) - u_t^(+))$

But $u_x$ has jump discontinuity on the curve, hence $u_x^(-) - u_x^(+) eq.not 0$, compare to get $xi'\(t\)= u$

]
#pagebreak(weak:true)
== Homework5
<homework5>
#aside("Problem", title:[August 1996, Problem 1a])[
Assume $u$ attains its maximum $max_(partial Omega) u$ at $x^0 in partial Omega$, since $f gt.eq 0$, $U$ is a domain which is bounded, maximum principle applies. Suppose $u\(x\)< u\(x^0\)\,forall x in Omega$, then according to Hopf lemma, $frac(partial u, partial n)\(x^0\)> 0$ since $Omega$ has a smooth boundary, which contradicts $frac(partial u, partial n) = 0$ on $partial Omega$. Thus $exists y in Omega$, such that $u\(y\)= u\(x^0\)$, by strong maximum principle, $u$ is a constant and $f = Delta u + a\(x\)dot.op nabla u = 0$

#strong[\6.]

Since $f$ is bounded, assume $\|f\|< C$, consider $v := u - C w$, we have $v\(x^0\)= 0$, $v lt.eq 0$ on $partial U$ and $L v = L u - C L w lt.eq L u - C < 0$, by maximum principle, we know $v\(x\)< v\(x^0\)\,forall x in U$, by Hopf lemma, $frac(partial u, partial nu)\(x^0\)- C frac(partial w, partial nu)\(x^0\)= frac(partial v, partial nu)\(x^0\)> 0$, similarly, if we consider $- u - C w$ and $- w$, we have $- frac(partial u, partial nu)\(x^0\)- C frac(partial w, partial nu)\(x^0\)> 0$ and $- frac(partial w, partial nu)\(x^0\)> 0$. Also, since $u = 0$ on $partial U$, $lr(|D u \( x^0 \)|) = lr(|frac(partial u, partial nu) \( x^0 \)|)$, hence we have #math.equation(block: true, numbering: none, ${- C frac(partial w, partial nu)\(x^0\)> - frac(partial u, partial nu)\(x^0\)\
- C frac(partial w, partial nu)\(x^0\)> frac(partial u, partial nu)\(x^0\) arrow.r.double - C frac(partial w, partial nu)\(x^0\)> lr(|frac(partial u, partial nu) \( x^0 \)|) arrow.r.double C lr(|frac(partial w, partial nu) \( x^0 \)|) > lr(|D u \( x^0 \)|)$)

]
#aside("Problem", title:[\7.])[
#strong[\(a)]

#math.equation(block: true, numbering: none, $0 = integral_U u Delta u = 1 / 2 integral_(partial U) u frac(partial u, partial nu) - 1 / 2 integral_U\|nabla u\|^2 arrow.r.double integral_U\|nabla u\|^2 = 0 arrow.r.double\|nabla u\|equiv 0 arrow.r.double u equiv upright("const")$) #strong[\(b)]

Using maximum principle, let $x^0 in partial U$ be a maximizer of $u$, suppose $u\(x\)< u\(x^0\)\,forall x in U$, by Hopf lemma, $frac(partial u, partial nu)\(x^0\)> 0$ which contradicts $frac(partial u, partial nu) = 0$ on $partial U$, thus $exists y in U$, such that $u\(y\)= u\(x^0\)$, hence $u$ is a constant by strong maximum principle

]
#pagebreak(weak:true)
#pagebreak(weak:true)
#pagebreak(weak:true)

#pagebreak()
#heading(numbering:none)[References]
#emph[Partial Differential Equations] - Lawrence C. Evans


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
