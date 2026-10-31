#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH621 - Algebraic Number Theory", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH621 - Algebraic Number Theory]
#v(2cm)
#image("Pictures/Michael_Artin.jpg",width:50%)
#v(2cm)
Taught by Yihang Zhu \
Notes taken by Haoran Li \
2021 Spring
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Overview
<overview>
Class field theory(CFT) is the study of abelian extensions of global and local fields

#statement("Definition")[
A global field is a finite separable extension of $bb(Q)$ or function field of a geometrically smooth curve over $F_q$. A local field is a finite extension of $bb(Q)_p$ or function field of $F_q\(\(t\)\)$

]
we want to understand abelian extensions of $K$ in terms of an invariant of $K$: the #emph[idele class group]#index-entry("idele class group")\(some generalization of $"Cl"\(O_K\)$) #math.equation(block: true, numbering: none, $C_K = cases(bb(A)_k^times\/K^times\,K upright(" global"), K^times\,K upright(" local"))$)

Why do we care?

Power reciprocity: The Legendre symbol $\(n\/p\)= cases(1 quad n upright(" is a square ") #h(0.444em) mod med p, - 1 quad upright("otherwise"))$

Quadratic reciprocity: For $p\,q$ distinct odd primes $\(p\/q\)\(q\/p\)= 1$ if one of $p\,q equiv 1 #h(0.444em) mod med 4$, -1 if $p equiv q equiv 3 #h(0.444em) mod med 4$, or more succinctly $\(p\/q\)\(q\/p\)=\(- 1\)^(frac(\(p - 1\)\(q - 1\), 4))$. Also $\(- 1\/p\)=\(- 1\)^(frac(p - 1, 2))$, $\(2\/p\)=\(- 1\)^(frac(p^2 - 1, 8))$

Class field theory is a vast and conceptual generalization of this, it put quadratic reciprocity into context. CFT $arrow.r.double$ higher power reciprocity, e.g. cubic reciprocity: 2,7 are not cubic powers mod 61

A classical problem: $p = x^2 + n y^2$, when a prime $p$ can be written as above

If $n = 1$, this holds iff $p equiv 1 #h(0.444em) mod med 4$ or $p = 2$ iff $p$ splits in $bb(Q)\(sqrt(- 1)\)$. CFT gives a complete solution to this for all $n$. See D. Cox \"Primes of the form $x^2 + n y^2$\"

If $n = 14$, then this holds iff $\(- 14\/p\)= 1$ and $\(x^2 + 1\)^2 - 8$ has root mod $p$

$K = bb(Q)\(sqrt(- 14)\)$, then this holds iff $p = macron(P) P$ splits in $K$ and $P$ is principle iff(by CFT) $p = macron(P) P$ splits in $K$ and $P$ splits in the Hilbert class field of $K$\($H\/K$ some specific finite abelian extension) iff $p$ splits in $H$

\"Reciprocity\": whether a prime is principal is related to whether it splits in certain abelian extensions

\"Class field\": $K$ is a number field, a modulus of $K$ is a formal symbol $frak(m) = v_1^(e_1) dots.h.c v_k^(e_k)$. $v_i$'s are places of $K$, and $e_i in bb(Z)_(gt.eq 0)$, satisfying: Complex places $v$ don't appear in $frak(m)$, for real places $v$, $e_i = 0\,1$. e.g. $K = bb(Q)$

Here a place is an equivalence class of absolute values, two absolute values are equivalent if they differ by a positive real power

The #emph[ray class group]#index-entry("ray class group") $C l_m$ is generated by fractional ideals coprime to $frak(m)$ modulo principal ideals generated by $f in K^times\,f equiv 1 #h(0.444em) mod med frak(m)$. In the number field case, $"Cl"_m$ is finite which is no longer true for global fields with char\>0

The usual class group $"Cl"\(cal(O)_K\)$ is where $frak(m) = 1$

Fact: $"Cl"_m$ is always finite abelian

The narrow class group, corresponds to $frak(m)$ is the product of all real places. This is the quotient group of all fractional ideals modulo those principal ideals generated $x in K^times$ such that $v\(x\)> 0$ for all real places $v$, i.e., the totally positive $x in K^times$

CFT: there is a finite abelian ext $K_m\/K$ called #emph[ray class field]#index-entry("ray class field") of $frak(m)$

Example: $m = 1\,K_m$ is the hilbert class field

$K_m$ is uniquely characterized among finite abelian(Galois) extension over $K$ such that whether prime $p$ of $K$ splits in $K_m$ iff whether $p$ has trivial image in $C l_m$, for all $p$ coprime to $m$

#statement("Theorem", title: [Generalized Kronecker-Weber theorem])[
Every finite abelian extension $E\/K$ is contained in $K_m\/K$ for sufficiently large $frak(m)$, one can choose $frak(m)$ such that its members are precisely the places of $K$ that ramify in $E$

]
#statement("Example")[
If $v_1\,dots.h.c\,v k$ are the achmedian places of $K$ that ramify in $E$, and $p_1 dots.h.c\,p_k$ are unramified places, then $m = v_1\,dots.h.c\,v_k\,p^(e_1)\,dots.h.c\,p_k^(e_k)$ for suff large $e_1\,dots.h.c\,e_k\,E subset.eq K_m$

]
#emph[Artin isomorphism]#index-entry("Artin isomorphism") $Psi : "Cl"_m arrow.r "Gal"\(K_m\/K\)$ has a concrete formula, $p mapsto\(p\,K_m\/K\)$\(well-definedness is nontrivial, called the Artin reciprocity). for every $p$ coprime to $m$, know $p$ is unramifed in $K_m$,

Recall: $E\/K$ is a finite Galois extension of global fields, suppose $p$ is a prime of $K$ that is unramifed in $E$, then $forall P\|p$, the arithmetic Frobenius element $sigma =\(P\,E\/K\)$\(Artin symbol) in $"Gal"\(E\/K\)$ is characterized by $sigma$ stablizes $P$, the action of $sigma o n k\(P\)$ as $x mapsto x^q\,q =\|k\(p\)\|$. ${\(P\,E\/K\)\|P }$ runs through the primes of $P\|p$ is a conjugacy class in $"Gal"\(E\/K\)$ called $\(p\,E\/K\)$. If $"Gal"\(E\/K\)$ is abelian, then $\(p\,E\/K\)$ is an element

Fact: For $p$ of $K$ unramified in $E$, $\(p\,E\/K\)= { 1 }$ iff $p$ splits in $E$

The theory of ray CFT + Artin iso $Psi$ + K-W theorem gives the ideal theoretic formulation of global CFT

Adelic formulation in terms of $bb(A)_k^times\/K^times$ is cleaner. And it's easier to see functoriality in $K$ that way

#pagebreak(weak:true)
= Class field theory over $bb(Q)$
<class-field-theory-over-mathbb-q>
Application: Chebotarev density theorem

$E\/K$ is a finite Galois extension of number fields, $G = "Gal"\(E\/K\)$, forall $p$ prime in $K$, unramified in $E$

#statement("Theorem")[
$forall$ conjugacy classes $C$ in $G$ the set of $p$ of $K$ such that $\(p\,E\/K\)= C$ has density $\|C\|\/\|G\|$ among all primes of $K$. In particular, there are infinitely many such primes $p$

]
applications in global Galois representation by density

consequence: $p$ splits iff $\(p\,E\/K\)= { 1 }$, such primes constitute $1\/\|G\|$ of all primes, thus infinitely many

#statement("Theorem", title: [Dirichlet theorem: primes in arithemetic progression])[
if $a\,b in bb(Z)$, $\(a\,b\)= 1$, exists infinitely many primees $p$ in the arithemetic progression $a + b bb(Z)$, e.g. $a = 1\,b = 4$, infinitely primes $equiv 1 #h(0.444em) mod med 4$

]
More application of CFT

Artin $L$ funcitons: Let $E\/K$ be a finite Galois extension of number fields, $rho : "Gal"\(E\/K\)arrow.r G L_n\(bb(C)\)$, S finite primes including all ramified primes of $K$, define $L\(rho\,s\)$ for $"re"\(s\)> > 0$, CFT $arrow.r.double$ meoromorphic extension to $bb(C)$

Conjecture(Artin):.\.

#statement("Theorem", title: [Grumwold-Wang, local-global behavior of number fields, local-global principle for quadratic forms])[
A non-degenerate quadratic form over a number field $K$ represents 0 over K(it=0 has sol over $K$) iff it represents 0 over $K_v$ for all places $v$ of $K$

]
CFT is the $"GL"_1$ case of the Langlands program

CFT for $bb(Q)$\(given by cyclotomic extension of $bb(Q)$)

Review of cyclotomic extesions of $bb(Q)$

$K$ is a general field, $m in bb(Z)_(> 0)$, the $m$-th cyclotomic extension of $K$ is $K\(mu_m\)$, $mu_m$ is the roots of unity in $macron(K)$, all roots would be simple, and is a cyclic group $tilde.equiv\(bb(Z)\/m\)^times$ under multiplication, generator is primitive $m$-th root of 1, denoted $zeta_m$. $K\(mu_m\)= K\(zeta_m\)$, by definition also the splitting field of $x^m - 1$ over $K$, thus Galois. Obeservation: $"Gal"\(K\(zeta_m\)\)$ embeds into $\(bb(Z)\/m bb(Z)\)^times$, $sigma mapsto a\,sigma\(zeta_m\)zeta_m^a$, so the extension is abelian. Cyclotomic polynomials are $Phi_m\(x\)= product_zeta\(x - zeta\)in bb(Z)\[x\]$, $zeta$ runs primitive $m$-th roots of unity in $bb(C)$

$Phi_1 = x - 1$, $Phi_2 = x + 1$, $Phi_m = frac(x^m - 1, product_(d\|m\,d < m) Phi_d\(x\))$. $K\(zeta_m\)\/K$ is the spliting filed of $Phi_m$. $deg\(Phi_m\)= phi.alt\(m\)=\|\(bb(Z)\/m bb(Z)\)^times\|$

$alpha : "Gal"\(K\(zeta_m\)\/K\)arrow.r\(bb(Z)\/m\)^times$ is an isomorphism iff $Phi_m$ is irreducible

#statement("Theorem", title: [Gauss])[
$Phi_m$ is irreducible in $bb(Q)\[x\]$

]
#proof(title: "Proof")[
Gauss's lemma, reduce to factorization mod $p$

]
#statement("Fact", title: [L washington sec2])[
+ $cal(O)_(bb(Q)\(zeta_m\)) = bb(Z)\[zeta_m\]tilde.equiv bb(Z)\[x\]\/Phi_m\(x\)$

+ assume $m equiv 2 #h(0.444em) mod med 4$\(if $m equiv 2 #h(0.444em) mod med 4$, then $phi.alt\(m\)= phi.alt\(m\/2\)arrow.r.double bb(Q)\(zeta_m\)= bb(Q)\(zeta_(m\/2)\)$) prime $p$ of $bb(Q)$ is unramified in $bb(Q)\(zeta_m\)$ iff $p divides.not m$

+ formula for $"disc" bb(Q)\(zeta_m\)$

]
#statement("Lemma")[
$forall p divides.not m$, $p in\(bb(Z)\/m\)^times$ is $\(p\,bb(Q)\(zeta_m\)\/bb(Q)\)$ the Frobenius element in $"Gal"\(bb(Q)\(zeta_m\)\/bb(Q)\)$

]
#proof(title: "Proof")[
Only need to prove $sigma$ fix $P$ for $P\|p$ \ Recall: Suppose $E\/K$ is finite separable extension of number fields, there is a way to explicitly factorize a prime $p$ of $K$ inside $E$\(for almost all $p$), write $E = K\(alpha\)$ such that $alpha in cal(O)_E$, $cal(O)_K\[alpha\]subset.eq cal(O)_E$ and $cal(O)_k\[alpha\]times.o_(cal(O)_E) E = E\(cal(O)_K\[alpha\]$ is an order in $cal(O)_E$). Conductor: $f = { x in O_E\|x O_E subset.eq O_K\[alpha\]}$, largest ideal of $cal(O)_E$ that lies inside $cal(O)_K\[alpha\]$ \ Fact: for $p$ prime of $K$, coprime to $f$, $p cal(O)_E = product_(i = 1)^g P_i^(e_i)$, $f\(x\)$ is the minimal polynomial of $alpha$ in $cal(O)_K\[x\]$, factorize over $k\(p\)= cal(O)_K\/p$, $product_(i = 1)^g f_i^(e_i)$, $f_i$ irreducible in $k\(p\)\[x\]$, $P_i$ is a lift of $f_i\(alpha\)cal(O)_E + p cal(O)_E$ \ $cal(O)_E = bb(Z)\[zeta_m\]$, $min\(z e t a_m\/bb(Q)\)= Phi_m$, $p cal(O)_E = product P_i^(e_i)$, $Phi_m$ in $F_p\[x\]$ factor as $product f_i^(e_i)$, $P_i$ is a lift of $f_i\(zeta_m\)$. Suppose $p$ sends $P_i$ to $P_j$, $i eq.not j$, but $p$ send $P_i$ to lift of $f_i\(zeta_m^p\)= h\(zeta_p\)$, $h\(zeta_p\)=\(tilde(f)\(zeta_m\)\)^p$ in $F_p$ implies $B_j subset.eq B_i$, contradiction!

]
#statement("Theorem")[
For $bb(Q)$, a modulus is a symbol $frak(m) = oo m$ or $frak(m) = m$ for some $m in bb(Z)_(> 0)$, $C l_(frak(m))$ is the group of fractional ideals of $bb(Q)$ coprime to $m$/principle ideals generated by $x in bb(Q)^times$ such that $x$ coprime to $m$, $x equiv 1 #h(0.444em) mod med m$, $x > 0$ if $frak(m) = oo dot.op m$

]
#statement("Exercise")[
When $frak(m) = oo dot.op m$, then we have an iso $\(bb(Z)\/m\)^times arrow.r C l_m$, $forall p divides.not m$, the ray class group, $p mapsto$ the class of the prime ideal $\(p\)$ iso $\(bb(Z)\/m\)^times\/{ plus.minus 1 } arrow.r C l_m$, $frak(m) = m$, $forall p divides.not m$, $p mapsto$ the class of the prime ideal $\(p\)$

]
$E_m = bb(Q)\(zeta_m\)$, think of this as $C l_(oo m) arrow.r "Gal"\(bb(Q)\(zeta_m\)\/bb(Q)\)$

This means that $bb(Q)\(zeta_m\)\/bb(Q)$ is the ray class field

Recall: this is also characterized by the following property: for almost all primes p, p splits in the ray class field iff $p$ is trivial in the ray class group

for $p divides.not m$, $p$ splits in $m$ iff $\(p\,E_m\/bb(Q)\)= 1$ iff $p$ is trivial in $C l_(oo m)$

Note if $E subset.eq E_m$, then $E\/bb(Q)$ is again finte abelian extesion, and the composition $C l_oo m arrow.r G a l\(E_m\/bb(Q)\)arrow.r^(upright("restriction")) G a l\(E\/bb(Q)\)$

Theorem\[Kronecker-Weber, proof given by Hilbert, later simplified\] Every finite abelian extension $E\/bb(Q)$ is over some $bb(Q)\(zeta_m\)$, can also choose $m$ to be divisible only by those $p$ that ramify in $E$

there is an elementary proof for the analogous result for $bb(Q)_p$\(local Kronecker-Weber, see Larry's book). Theorem true for all $bb(Q)_p$ imply $bb(Q)$\(any non-trivial $E\/bb(Q)$ cannot be unramified everywhere)

CFT for $bb(Q)$ is basically: $Psi$ and Kronecker-Weber theorem

Elegant proof for quadratic reciprocity: $p eq.not q$ odd primes, and $q equiv 1 #h(0.444em) mod med 4$, then $\(p\/q\)=\(q\/p\)$

there is a unique index 2 subgroup of $\(bb(Z)\/q\)^times$, i.e. there is a unique quadratic extension $K$ of $bb(Q)$ inside $E_q$, we know that $q$ is the only finite prime that ramifies in $E_q$, thus $q$ is the only finite prime that ramifies in $K$, thus $K = bb(Q)\(sqrt(q)\)\(K eq.not Q\(sqrt(- q)\)$ since $q equiv 1 #h(0.444em) mod med 4\,"disc" = q$, not $4 q$\(2 also ramifies))

One can explicitly construct $sqrt(q)$ inside $Q\(zeta_q\)$\(Gauss, see exercise in the notes). $\(p\/q\)= 1$ iff $p$ represents a square in $\(bb(Z)\/q\)^times tilde.equiv "Gal"\(E_q\/bb(Q)\)$ iff $p$ lies in the kernel of $"Gal"\(E_q\/bb(Q)\)arrow.r "Gal"\(K\/bb(Q)\)$ iff $\(p\,E_q\/bb(Q)\)arrow.r 1$ iff $\(p\,K\/bb(Q)\)= 1$ iff $p$ splits in $K$. $cal(O)_K = bb(Z)\[frac(1 + sqrt(q), 2)\]$ contain $bb(Z)\[sqrt(q)\]$ with conductor $2 cal(O)_K$ iff $X^1 - q$ splits mod $p$ iff $\(q\/p\)= 1$

#statement("Exercise")[
Try other cases: prove $\(p\/q\)= -\(q\/p\)$ if $p equiv q equiv 3 #h(0.444em) mod med 4$

]
#pagebreak(weak:true)
= Ramification in $bb(Q)\(zeta_m\)$
<ramification-in-mathbb-qzeta_m>
$p divides.not m$ imply $p$ unramified in $bb(Q)\(zeta_m\)$, $p cal(O)_(bb(Q)\(zeta_m\)) = P_1^e dots.h.c P_g^e$, $f =\[k\(P_i\): k\(p\)\]$, $e f g =\[bb(Q)\(zeta_m\)$, $bb(Q)\]= phi\(m\)$. $e = 1$, $f$ is the order of $p$ in $\(bb(Z)\/m bb(Z)\)^times$

#statement("Lemma")[
If $m = p^r$, $bb(Q)\(zeta_m\)\/bb(Q)$ is totally unramified at $p$, i.e. $p cal(O)_(bb(Q)\(zeta_m\)) = P^(\[bb(Q)\(zeta_m\): bb(Q)\])$

]
#proof(title: "Proof")[
Modulo $p$, $Phi_m\(X\)= frac(X^(p^r) - 1, X^(p^(r - 1) - 1)) = frac(\(X - 1\)^(p^r), \(X - 1\)^(p^(r - 1))) =\(X - 1\)^(phi\(m\))$, thus $p cal(O)_(bb(Q)\(zeta_m\)) = P^(phi\(m\))$

]
In general, $m = n p^r$, $p divides.not n$, $bb(Q)\(zeta_m\)$ is the composite $bb(Q)\(zeta_n\)bb(Q)\(zeta_(p^r)\)$, and $bb(Q)\(zeta_n\)\,bb(Q)\(zeta_(p^r)\)$ are linearly disjoint over $bb(Q)$ since $phi\(m\)= phi\(n\)phi\(p^r\)$

$p divides.not m$, $bb(Q)\(zeta_m\)_P\/bb(Q)_p tilde.equiv bb(Q)_p\(zeta_m\)\/bb(Q)_p$, here $bb(Q)\(zeta_m\)_P = bb(Q)_p\(zeta_m\)$ is the composite $bb(Q)_p bb(Q)\(zeta_m\)$

$D_P\(bb(Q)\(zeta_m\)\/bb(Q)\)tilde.equiv "Gal"\(bb(Q)_p\(zeta_m\)\/bb(Q)_p\)$, thus $bb(Q)_p\(zeta_m\)\/bb(Q)_p$ is unramified, and its degree is the order of $p$ in $bb(Z)\/m bb(Z)^times$. Similarly, $m = p^r\,bb(Q)_p\(zeta_m\)\/bb(Q)_p$ is totally unramified, and its degree is $e = phi\(p^r\)$

#statement("Fact")[
$K$ local field, $E\/K\,F\/K$ two finite Galois extensions. If $E\/K$ is unramified of degree $f$ and $F\/K$ is totally ramified of degree $e$, then $E\,F$ are linear disjoint over $K$, $\[E : K\]= e f$, $e$ is ramification index, $f$ is residue extension degree

]
$bb(Q)_p\(zeta_m\)$ is the composite $bb(Q)_p\(zeta_n\)bb(Q)_p\(zeta_(p^r)\)$, $e = phi\(p^r\)$, $f$ is the order of $p$ in $bb(Z)\/m bb(Z)^times$. $\[bb(Q)_p\(zeta_m\): bb(Q)_p\]= e f$. The Galois group is the direct product

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$"Gal"\(bb(Q)_p\(zeta_m\)\/bb(Q)_p\)$]),
node((1,0),[$"Gal"\(bb(Q)_p\(zeta_n\)\/bb(Q)_p\)times "Gal"\(bb(Q)_p\(zeta_(p^r)\)\/bb(Q)_p\)$]),
node((0,1),[$\(bb(Z)\/m\)^times$]),
node((1,1),[$\(bb(Z)\/n\)^times times\(bb(Z)\/p^r\)^times$]),
edge((0,0),(1,0),"->"),
edge((0,1),(1,1),"->"),
edge((0,1),(0,0),"->",[$alpha_m$]),
edge((1,1),(1,0),"->"))]
]
$alpha_n : "Gal"\(bb(Q)_p\(zeta_n\)\,bb(Q)_p\)arrow.r\(bb(Z)\/n\)^times$ sends Frobenius element to $p$, and the subgroup generated by Frobenius element to the subgroup generated by $p$

$alpha_(p^r)$ is an isomorphism because $\[bb(Q)_p\(zeta_(p^r)\): bb(Q)_p\]= phi\(p^r\)=\|\(bb(Z)\/p^r\)^times\|$

$bb(Q)_p^times = p^(bb(Z)) times bb(Z)_p^times$, $bb(Z)_p^times = lim_arrow.l_n\(bb(Z)\/p^n\)^times$, $bb(Z)_p^times\/\(1 + p^r bb(Z)_p\)tilde.equiv\(bb(Z)\/p^r\)^times$

Define a map $j_m : bb(Q)_p^times arrow.r\(bb(Z)\/m\)^times$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(Q)_p^times$]),
node((1,0),[$tilde.equiv$]),
node((2,0),[$p^(bb(Z))$]),
node((3,0),[$times$]),
node((4,0),[$bb(Z)_p^times$]),
node((0,1),[$\(bb(Z)\/m\)^times$]),
node((1,1),[$tilde.equiv$]),
node((2,1),[$\(bb(Z)\/n\)^times$]),
node((3,1),[$times$]),
node((4,1),[$\(bb(Z)\/p^r\)^times$]),
edge((0,0),(0,1),"->",[$j_m$]),
edge((2,0),(2,1),"|->",[$p mapsto p$]),
edge((4,0),(4,1),"|->",[$x mapsto x^(- 1) mapsto upright("natural projection")$]))]
]
#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(Q)_p^times$]),
node((1,0),[$\(bb(Z)\/m\)^times$]),
node((2,0),[$"Gal"\(bb(Q)_p\(zeta_m\)\/bb(Q)_p\)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(2,0),"->",[$psi_m$],bend:-15deg),
edge((2,0),(1,0),"->"))]
]
$psi_m$ is continuous and surjective \ Suppose $m' in bb(Z)_(gt.eq 1)$ divisible by $m$, then $bb(Q)_p\(zeta_m\)subset.eq bb(Q)_p\(zeta_(m')\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(Q)_p^times$]),
node((1,0),[$\(bb(Z)\/m\)^times$]),
node((2,0),[$"Gal"\(bb(Q)_p\(zeta_m\)\/bb(Q)_p\)$]),
node((0,1),[$bb(Q)_p^times$]),
node((1,1),[$\(bb(Z)\/m'\)^times$]),
node((2,1),[$"Gal"\(bb(Q)_p\(zeta_(m')\)\/bb(Q)_p\)$]),
edge((0,0),(1,0),"->"),
edge((0,0),(0,1),"="),
edge((1,0),(1,1),"->>"),
edge((2,0),(1,0),"->"),
edge((2,0),(2,1),"->>"),
edge((0,1),(1,1),"->"),
edge((2,1),(1,1),"->"))]
]
Take the inverse limit $phi.alt : bb(Q)_p^times arrow.r lim_arrow.l_m "Gal"\(bb(Q)_p\(zeta_m\)\/bb(Q)_p\)= "Gal"\(union bb(Q)_p\(zeta_m\)\/bb(Q)_p\)= "Gal"\(bb(Q)_p^(c y c)\/bb(Q)_p\)$. The image is dense

#statement("Theorem", title: [local Kronecker-Weber theorem for $bb(Q)_p$])[
Every finite abelian ext of $bb(Q)_p$ is contained in some $bb(Q)_p\(zeta_m\)$. $bb(Q)_p^(c y c) = bb(Q)_p^(a b)$ is the maximal abelian extension(which is the union of all finite abelian extension) of $bb(Q)_p$ in $overline(bb(Q)_p)$

]
One of the main goals of local CFT is: for every local field $K$, to construct a map $K^times arrow.r "Gal"\(K^(a b)\/K\)$\(local Artin map) and study its behaviour

e.g. If $L\/K$ is a finite abelian extension, if restrict to $L\/K$\(finite abelian extension, $psi_L\/K$), $phi.alt_L\/K$ is surj and $ker psi_L\/K = I m\(N_L\/K : L^times arrow.r K^times\)$

Can characterize which subgroups of $K^times$ are of the form $ker psi_L\/K$ for some $L$

Local-global relationship: We have local Artin map $psi_p : bb(Q)_p^times arrow.r "Gal"\(bb(Q)_p^(a b)\/bb(Q)_p\)$ and the global Artin map $Psi_m :\(bb(Z)\/m\)^times arrow.r "Gal"\(bb(Q) zeta_m\/bb(Q)\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$\(bb(Z)\/m\)^times$]),
node((1,0),[$"Gal"\(bb(Q)\(zeta_m\)\/bb(Q)\)$]),
node((0,1),[$bb(Q)_p^times$]),
node((1,1),[$"Gal"\(bb(Q)_p\(zeta_m\)\/bb(Q)_p\)= D_p\(bb(Q)\(zeta_m\)\/bb(Q)\)$]),
edge((0,0),(1,0),"->",[$Psi_m$]),
edge((0,1),(1,1),"->",[$psi_(p\,m)$]),
edge((0,1),(0,0),"->",[$j_(m\,p)$]),
edge((1,1),(1,0),"hook->"))]
]
#statement("Definition", title: [Chevalley(finite ideles)])[
$bb(A)_f^times = {\(x_p\)in product_p bb(Q)_p^times\|x_p in bb(Z)_p^times upright(" for almost all ") p }$, ideles is $bb(A)^times = bb(R)^times times bb(A)_f^times$

]
$bb(Q)^times$ diagonally sits in $bb(A)^times$, i.e. $x mapsto\(x_oo\,x_2\,x_3\,x_5\,dots.h.c\)$. Idelic global Artin map $Psi_m : bb(A)_f^times arrow.r G a l\(bb(Q)\(zeta_m\)\/bb(Q)\)\,\(x_p\)mapsto psi_(oo\,p) product psi_(p\,m)\(x_p\)$ which is a finite product since $bb(Z)_p^times$ elements go to 0

Here $psi_(oo\,p)\(x\)$ is identity if $x$ is positive, and $sigma_oo$ which is $- 1 in "Gal"\(bb(Q)\(zeta_m\)\/bb(Q)\)=\(bb(Z)\/m\)^times$ if $x$ is negative. So #math.equation(block: true, numbering: none, $\(x_oo\,x_f\)mapsto cases(Psi\(x_f\)quad x_oo > 0, sigma_oo Psi\(x_f\)quad x_oo < 0)$)

#statement("Exercise")[
This is actually a map $A^times\/bb(Q)^times arrow.r "Gal"\(bb(Q)^(c y c)\/bb(Q)\)= "Gal"\(bb(Q)^(a b)\/bb(Q)\)$

]
Global CFT: For any global field $K$, Artin map $Psi : A_K^times\/K^times arrow.r "Gal"\(K^(a b)\/K\)$

Future plan:

review of profinite groups: allows us to talk about infinite Galois theory

State the main theorems in local CFT after reviewing some basics about local fields

Lubin-Tate theory: analogue of the local cyclotomic extensions, gives an explicit construction of $K^(a b)$ for a local field $K$

Group cohomology

Use Group cohomology to fully prove local CFT

Global CFT

#pagebreak(weak:true)
= Profinite groups
<profinite-groups>
Example of direct system:

+ $\(bb(N)\,gt.eq\)$

+ $\(bb(N)\,\|\)$

+ $G$ is a (topological)group, $I = { upright("finite index(open) normal subgrps of ") G }$, $N gt.eq N'$ if $N subset.eq N'$

+ Fix a field extension $E\/K$, $I = { L\/K upright(" finite Galois") }$, $L gt.eq L'$ if $L supset.eq L'$. If $L\,L'$ are both finite Galois, then so is their composite

Let $C$ be a category(sets, groups, rings, top groups, top spaces, top rings). A profinite group is a topological group isomorphic to a inverse limit of finite groups. A profinite group is Hausdorff and compact

#statement("Theorem", title: [Tychonoff's theorem])[
A product of compact spaces is compact

]
#statement("Theorem")[
$G$ is a topological group, $G$ is profinite iff it is Hausdorff compact and $1 in G$ has a neighborhood basis consisting of open subgroups of $G$

]
#proof(title: "Proof")[
$arrow.l.double$: Suppose $G = lim_arrow.l G_i$, $forall i in I$, $N_i = ker\(G arrow.r G_i\)$ give such a basis \ $arrow.r.double$:

]
#statement("Remark")[
In a topological group, every open subgroup is closed(being the complement of the union of its other cosets). In a compact group, a closed subgroup is open iff it's of finite index(conjugates cover $G$, then by compactness), and every open subgroup is closed hence compact

]
#statement("Example")[
$bb(Z)_p$ with topology given by the $p$-adic value, $p^n bb(Z)_p$ form a neighborhood basis of 0 in $bb(Z)_p$ consisting of open subgroups. $bb(Z)_p^times = lim_arrow.l_n\(bb(Z)\/m bb(Z)\)^times$ has $1 + p^n bb(Z)_p$ as an open neighborhood basis of 0

]
#statement("Remark")[
A topological group is called locally profinte it's locally compact and Hausdorff and 1 has a neighborhood basis consisting of open subgroups. Equivalently, $G$ has an open subgroup which is profinite

]
#statement("Example")[
$Q_p supset.eq^(upright("open")) Z_p$ is locally profinite since its not compact

]
Fact: A topological group is (locally) profinite iff it is Hausdorff, (locally compact) and totally disconnected

$G$ is a topological group, $I$ is the set of open normal finite index subgroups(Note: quotient top on $G\/N_i$ is discrete), so $hat(G) = lim_arrow.l G\/N_i$ defines a profinite group, called the profinite completion, and a natural continuous map $G arrow.r hat(G)$, it is an isomorphism iff $G$ is profinite. For every continuous $G arrow.r H$, where $H$ is profinite, the it factors through $hat(G) arrow.r H$

Exercise: $hat(bb(Z)) = product_p bb(Z)_p$

Infinite Galois theory: $E\/K$ Galois(separable and normal), $I$ is the subset consists of $L\/K$ which are finite Galois

Fact(easy): As abstract groups, $"Gal"\(E\/K\)= lim_arrow.l "Gal"\(L\/K\)$, define Krull topology on $"Gal"\(E\/K\)$ by profinite topology given by the right hand side

#statement("Theorem", title: [Galois correspondence])[
Sub-extensions $L\/K$ corresponds to closed subgroups of $"Gal"\(E\/K\)$, $L mapsto "Gal"\(E\/L\)$, $H mapsto E^H$, $E^H = E^(macron(H))$, finite extensions are in bijective correspondence to open subgroups, Galois extensions are in bijective correspondence to normal subgroups. If $L\/K$ is Galois, then $"Gal"\(E\/L\)$ is normal in $"Gal"\(E\/K\)$, and $"Gal"\(L\/K\)tilde.equiv "Gal"\(E\/K\)\/"Gal"\(E\/L\)$ as topological groups

]
#statement("Example")[
$"Gal"\(overline(bb(F)_q)\/bb(F)_q\)tilde.equiv lim_arrow.l_n "Gal"\(bb(F)_(q^n)\/bb(F)_q\)tilde.equiv lim_arrow.l_n bb(Z)\/n bb(Z)$, $bb(Z) arrow.r hat(bb(Z))$, $1 mapsto 1$ is the Frobenius element

]
remark: $G =$ profinite, $S$ is dense iff image of S in each $G_i$ is $G_i$, since $G_i$ is discrete

$\(bb(Z)\/m bb(Z)\)^times tilde.equiv "Gal"\(bb(Q)\(zeta_m\)\/bb(Q)\)$, thus $hat(bb(Z))^times tilde.equiv "Gal"\(bb(Q)^(c y c)\/bb(Q)\)= "Gal"\(bb(Q)^(a b)\/bb(Q)\)$ But $bb(Q)_p^times arrow.r "Gal"\(bb(Q)_p^(a b)\/bb(Q)_p\)$ only has dense image

#statement("Exercise")[
$G$ is locally profinite, and $phi.alt : G arrow.r G'$ is continuous, $G'$ is profinite, $phi.alt$ has dense image, then $hat(G) tilde.equiv G'$

]
#pagebreak(weak:true)
= Local fields
<local-fields>
A discrete valued field $\(K\,v\)$ is a surjective(normalized and exclude trivial valuations) function $v : K arrow.r bb(Z) union { + oo }$ satisfying

+ $v\(x\)= + oo arrow.l.r.double x = 0$

+ $v\(x y\)= v\(x\)+ v\(y\)$ is a group homomorphism $K^times arrow.r bb(Z)$

+ $v\(x + y\)gt.eq min\(v\(x\)\,v\(y\)\)$

Subring $cal(O)_K = { x in K\|v\(x\)gt.eq 0 }$ of $K$ with $"Frac"\(cal(O)_K\)= K$ and that it is a valuation ring(in fact a DVR, i.e. a PID with unique non-zero prime ideal), with the unique non-zero prime ideal $m_K = { x in K\|v\(x\)> 0 }$, generated by the uniformizer $pi$ such that $v\(pi\)= 1$. $cal(O)_K^times = { x in K\|v\(x\)= 0 }$. For any $x in K$, there is a unique $n$ such that $pi^(- n) x in cal(O)_K^times$, $n = v\(x\)$, i.e. $v$ can be recovered from $cal(O)_K$, in fact, all discrete valuations $v$ on $K$ corresponds to DVR's $cal(O) subset.eq K$ whose fraction field is $K$. $k = cal(O)_K\/m$ is the residue field, then is a natural topology on $K$, pick $alpha in bb(R)$, $0 < alpha < 1$, define absolute value on $K$, $K^times arrow.r bb(R)_(> 0)$, $x mapsto alpha^(v\(x\)) =\|x\|$. Discrete valuations correspond to non-Archimedean absolute values whose image is a discrete subgroup of $bb(R)^times\/tilde.op$, making $K$ into a metric space, whose topology is independent of $alpha$. In fact, $cal(O)_K$ is open, and $m^n$, $n gt.eq 1$ form an open neighborhood basis of $0$

#statement("Theorem", title: [Ostrowski's theorem])[
Every non-trivial absolute value on $bb(Q)$ is equivalent to either the real absolute value $\|\|_oo$ or $p$-adic absolute values $\|\|_p$. A field that is complete with respect to an Archimedean absolute value is(topologically and algebraically) $bb(R)$ or $bb(C)$

]#label("Ostrowski's theorem")
#aside("Note")[
An absolute value is a norm with $\|x y\|=\|x\|\|y\|$. Two absolute values $\|\|\,\|\|_(*)$ are equivalent if $\|\|_(*) =\|\|^c$ for some $c > 0$. The trivial absolute value is $\|0\|= oo$ and 0 otherwise

]
#statement("Example")[
$K = bb(Q)\,v = v_p\,cal(O)_K = bb(Z)_(\(p\))\,m = p bb(Z)_(\(p\))$ is locally profinite. $K = bb(Q)_p\,v = v_p\,cal(O)_K = Z_p$ is profinite

]
#statement("Definition")[
$\(R\,m\)$ is a local ring, its completion $hat(R) = lim_arrow.l_n R\/m^n$. $hat(R)$ is also local with unique max ideal $hat(m) = ker\(hat(R) arrow.r R\/m\)$, $R arrow.r hat(R)$ is a natural local ring homomorphism, induce $R\/m^n tilde.equiv hat(R)\/hat(m)^n$, thus $hat(hat(R)) tilde.equiv hat(R)$

]
We call $\(K\,v\)$ complete if $cal(O)_K$ is complete as a local ring. and this is true iff $K$ is complete in the metric sense

#statement("Definition")[
A non-archimedean local field is a discrete valued field $\(K\,v\)$ which is complete and has finite residue field. Archimedean local fields are $bb(Q)\,bb(C)$ by Theorem #ref(label("Ostrowski's theorem"), supplement: none)

]
We use local fields to mean just non-archimedean local fields. In this case, $cal(O)_K\/m^n$ are discrete by exact sequences, so $cal(O)_K$ is profinite, thus compact, $K$ is locally profinite. Conversely, if $\(K\,v\)$ is a discrete valued field such that $K$ is locally profinite(suffices to show that $K$ is locally compact), then $\(K\,v\)$ is a local field

$\(K\,v\)$ is a discretely valued field, we have $hat(cal(O)_K)$ as a DVR with $pi$ again as the uniformizer, let $hat(K)$ to be the field of fractions with a natural valuation $hat(v)$, and $K$ has dense image in $hat(K)$. So if $\(K\,v\)$ has finite residue field, the completion is a local field

#statement("Example")[
$bb(F)_q\(t\)$, $v_t$ valuation, with residue field $bb(F)_q$, valuation ring $bb(F)_q\[t\]$, and max ideal $t bb(F)_q\[t\]$, the completion is the Laurent series in $t$, $v_t$ gives the order of zero or pole, with valuation ring $bb(F)\[\[t\]\]$

]
$K$ is a local field

Structure of $\(K\,+\)$ and $\(K^times\,times\)$

$K^times tilde.equiv bb(Z) times cal(O)_K^times$ as topological groups, $bb(Z)$ with discrete topology

$U = cal(O)_K^times$, $U_n = 1 + m_K^n$, then $U supset.eq U_1 supset.eq dots.h.c$ form an open subgroup neighborhood basis of $1$, $U\/U_1 tilde.equiv k^times$, $U_n\/U_(n + 1) tilde.equiv m_K^n\/m_K^(n + 1) tilde.equiv k$, $x mapsto x - 1$

$U_1$ is the unique pro-$p$ Sylow subgroup of $U$ since $\|U_n\/U_(n + 1)\|= p$ and $\|U\/U_1\|= p - 1$ is coprime to $p$

$U$ is profinite since $U$ is compact(closed in $cal(O)_K$)

#statement("Remark")[
If $K$ is a local field of characteristic 0, then for sufficiently large $n$\(so that the series converge), $m_K^n tilde.equiv U_n$, $x mapsto e^x$

]
#statement("Corollary")[
In this case, every finite index subgroup of $K^times$ is open

]
#proof(title: "Proof")[
Suppose $H$ is of finite index $j$ in $K^times$, then $\(K^times\)^j subset.eq H$. Fix uniformizer $pi$, $\(K^times\)^j tilde.equiv pi^(j bb(Z)) times U^j$. $U^j supset.eq U_1^j supset.eq dots.h.c$, only need to show $U_n^j$ is open for some $n$, for $n$ large enough, $U_n tilde.equiv m_K^n tilde.equiv cal(O)_K$, so $U_n^j tilde.equiv j cal(O)_K subset.eq^(o p e n) cal(O)_K$

]
Teichmuller lift:

#statement("Fact")[
The surjective homomrophism $cal(O)_K^times arrow.r k^times$\($k$ is the residue field which is finite) has a unique multiplicative section $\[\]: k^times arrow.r cal(O)_K^times$. Moreover, $\[x\]= lim_arrow.r_n y_n^(p^n)$, $y_n in cal(O)_K^times$ is an arbitrary lift of $sqrt(p^n) x in k^times$

]
#statement("Example")[
$K = bb(Q)_5$, $\[macron(4)\]= - 1 in cal(O)_K^times = bb(Z)_5^times$

]
#statement("Fact")[
$forall x in K^times$, $exists_1\(a_n\)_(n gt.eq v\(x\))$ such that $a_n in { 0 } union\[k^times\]$, $x = sum_(n gt.eq v\(x\)) pi^n a_n$

]
Warning: $x = s u m pi^n a_n$, $y = s u m pi^n b_n$, $x + y = x = s u m pi^n\(a_n + b_n\)$ is not the canonical choice

Finite extensions of local fields

#statement("Theorem", title: [Serre II.2])[
$\(K\,v\)$ is a complete discretely valued field, $E\/K$ is a separable field extension, $exists_1 w$ on $E$ and $exists_1 e in bb(Z)_(gt.eq 1)$ such that $forall x in K$\($e$ is the ramification index), $w\(x\)= e v\(x\)$. Moreover, $\(E\,w\)$ is complete, $k_E\/k_K$ is a finite extension of degree $f =\[E : K\]\/e$

]
#statement("Remark")[
$w\(y\)= v\(N_(E\/K)\(y\)\)\/f$, $forall y in E$

]
$arrow.r.double$ Every finite extension of a local field has canonical structure of a local field itself. In the future, when we talk about finite extensions of local fields $E\/K$, it's always assumed that the local field structure on $E$ is obtained from $K$ in this way

#statement("Fact")[
Every local field is either a finite extension of $bb(Q)_p$ or $bb(F)_q\(\[t\]\)$, Laurent series

]
#pagebreak(weak:true)
= Galois theory for local fields
<galois-theory-for-local-fields>
#statement("Definition")[
A finite separable extension $E\/K$ is unramified if $e\(E\/K\)= 1$

]
#statement("Fact")[
If $E\/K$ is unramified, then it's Galois. $"Gal"\(E\/K\)arrow.r "Gal"\(k_E\/k_K\)$ is an isomorphism

]
$K$ is a local field

#statement("Fact")[
$E\/K$ finite unramified, $L\/K$ finite extension, $"Hom"_K\(E\,L\)arrow.r "Hom"_(k_K)\(k_E\,k_L\)$ is a bijection. It's an equivalence of categories: unramified extensions over $K$ to finite extensions over $k_K$

]
Thus we have #math.equation(block: true, numbering: none, ${ K subset.eq E subset.eq L\,E\/K upright(" unramified") } arrow.l.r { upright("subextension of ") k_L\/k_K }$)

$K^s\/K$ is the separable closure. $forall n in bb(Z)_(gt.eq 1)$, $exists_1 K subset.eq K_n subset.eq K^s$ such that $K_n\/K$ is unramified and of degree $n$. $K^(u n) = union.big_(n gt.eq 1) K_n$, $K^(u n)\/K$ is a Galois field extension and contains all possible finite unramified extensions of $K$ inside $K^s$\(all are of the form $K_n$). $v$ on $K$ extends to $K^(u n)$, $\(K^(u n)\,v_(u n)\)$ is a discretely valued field(not complete in general), has $breve(K)$ for its completion

$"Gal"\(K^(u n)\/K\)= lim_arrow.l "Gal"\(K_n\/K\)= lim_arrow.l bb(Z)\/n = hat(bb(Z))$

Define the inertia group $I_K = ker\("Gal"\(K^s\/K\)arrow.r "Gal"\(K^(u n)\/K\)\)tilde.equiv "Gal"\(K^s\/K^(u n)\)$. For all separable finite extension $E\/K$, let $E_(u r)$ be the maximal unr ext of $K$ inside $E$. $"Gal"\(E\/E_(u n)\)= I\(E\/K\)$, $lim_arrow.l "Gal"\(E\/E_(u r)\)= lim_arrow.l I\(E\/K\)= I_K$

We have exact sequence #math.equation(block: true, numbering: none, $1 arrow.r I_K arrow.r G_K = "Gal"\(K^s\/K\)arrow.r "Gal"\(K^(u r)\/K\)tilde.equiv hat(bb(Z)) arrow.r 1$)

#statement("Exercise")[
$"Gal"\(K^(a b)\/K\)$ is the maximal Hausdorff and abelian quotient of $G_K$, i.e. $ker\(G_K arrow.r "Gal"\(K^(a b)\/K\)\)$ is the closure of the derived subgroup of $G_K$

]
#statement("Theorem", title: [Local Reciprocity])[
$exists_1 psi_K : K^times arrow.r "Gal"\(K^(a b)\/K\)$ such that

+ For any uniformizer $pi in K$, $K^times arrow.r "Gal"\(K^(a b)\/K\)arrow.r "Gal"\(K^(u r)\/K\)$ sends $pi$ to the Frobenius $sigma$. Thus for any $x in cal(O)_K^times$, $x$ goes to the trivial element in $"Gal"\(K^(u r)\/K\)$, in fact, $cal(O)_K^times$ is the kernel

+ For all finite abelian extension $L\/K$ inside $K^(a b)$, $psi_(L\/K) : K^times arrow.r "Gal"\(K^(a b)\/K\)arrow.r "Gal"\(L\/K\)$ has kernel $N_(L\/K)\(L^times\)subset.eq K^times$ and is surjective and $psi_(L\/K) : K^times\/N_(L\/K)\(L^times\)arrow.r^tilde.equiv "Gal"\(L\/K\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$K^times$]),
node((1,0),[$"Gal"\(K^(a b)\/K\)$]),
node((2,0),[$"Gal"\(K^(u r)\/K\)$]),
node((1,1),[$bb(Z)$]),
node((2,1),[$hat(bb(Z))$]),
edge((0,0),(1,1),"->"),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"->"),
edge((1,1),(2,1),"->"))]
]
]
#statement("Definition")[
By a norm subgroup of $K^times$, we mean a subgroup of the fomr $N_(L\/K)\(L^times\)$ for some finite abelian extension $L\/K$, write $N_L$ for this to simplify notation

]
#statement("Remark", title: [Norm Limitation theorem])[
If $L\/K$ is an arbitrary finite separable extension, $E\/K$ is the maximal abelian extension of $K$ inside $L$, then $N_L = N_E$

]
#statement("Corollary")[
$L\,L'$ are finite abelian extensions of $K$

+ $N_L subset.eq N_(L') arrow.l.r.double L' subset.eq L$

+ $N_(L L') = N_L inter N_(L')$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$K^times$]),
node((1,0),[$K^times\/N_L$]),
node((2,0),[$"Gal"\(L\/K\)$]),
node((1,1),[$"Gal"\(K^(a b)\/K\)$]),
node((2,1),[$"Gal"\(L'\/K\)$]),
edge((0,0),(1,1),"->"),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(2,1),"->"),
edge((1,1),(2,1),"->"))]
]
]
#proof(title: "Proof")[
+ $N_(L\/K) = N_(L\/L') N_(L'\/K)$

+ $"Gal"\(L L'\/K\)arrow.r.hook "Gal"\(L\/K\)times "Gal"\(L'\/K\)$

]
#statement("Corollary")[
Every norm subgroup is of finite index in $K^times$. Every subgroup $K^times$ containing some norm subgroup is itself a norm subgroup

]
#proof(title: "Proof")[
Say $K^times supset.eq M supset.eq N_L$, $K^times\/N_L arrow.r^tilde.equiv "Gal"\(L\/K\)$, $M\/N_L$ corresponds to $"Gal"\(L\/L'\)$ for some $L' supset.eq L$. So $M$ is the kernel of $K^times arrow.r K^times\/N_L arrow.r "Gal"\(L\/K\)arrow.r "Gal"\(L'\/K\)$

]
#statement("Theorem")[
$L arrow.r N_L$ is an inclusion reversing bijection So finite abelian extensions over $K$ to normal subgroups

]
#statement("Lemma")[
$L\/K$ finite extension such that $N_(L\/K)\(L^times\)$ is of finite index in $K^times$, then $N_(L\/K)\(L^times\)$ is open in $K^times$. If $"char" k = 0$, know every finite index subgroup of $K^times$ is open

]
#proof(title: "Proof")[

]
#pagebreak(weak:true)
#pagebreak(weak:true)
= 3-2
<section>
$K_pi = union_L L$, L finite alge ext of K such that $N_L = N_(L\/K)\(K^times\)$ containing $pi$

#statement("Theorem", title: [local existence theorem])[
For every open finite index subgroup $U subset.eq K^times$, there exists a finite abelian extsion $L\/K$ such that $N_L = U$

]
$K^(a b) = K_pi K^(u r)$ is linearly disjoint

#statement("Remark")[
To proof this, we used the local existence theorem

]
In the proof, we have actually proved: Suppose $H$ is a profinite group, $G = bb(Z) times H$ with the product topology, then every open finite index subgroup $N$ of $G$ contains $n bb(Z) times H'$, $H' subset.eq H$ is an open subgroup

#statement("Corollary")[
If $G = bb(Z) times H$, then $hat(G) = lim_arrow.l_(n\,H') G\/n bb(Z) times H' = lim_arrow.l_(n\,H') bb(Z)\/n times H\/H' = hat(bb(Z)) times H$, since $H$ is profinite

]
#statement("Theorem")[
Assuming the local existence theorem, then $phi.alt_K$ in the local reciprocity theorem must be unique

]
#proof(title: "Proof")[
By local existence theorem, $K^(a b) = K_pi K^(u r)$. Suppose $phi.alt\,phi.alt'$ are two candidates for $phi.alt_K$, $phi.alt\(pi\)\,phi.alt'\(pi\)$ acts trivially on $K_pi$, and acts as Frobenius on $K^(u r)$, then $phi.alt\(pi\)= phi.alt'\(pi\)in "Gal"\(K^(a r)\/K\)$. But $K^times$ is generated by all uniformizers

]
Idea of Lubin-Tate theory: Explicitly construct $K_(pi\,n)$

$K_(pi\,n) = bb(Q)_p\(zeta_(p^n)\)$

$bb(Q)_p\(zeta_(p^n)\)= bb(Q)_p\(Lambda_n\)$

$Lambda_n$ is free of rank 1 over $bb(Z)\/p^n$

$"Gal"\(Q_p\(Lambda_n\)\/Q_p\)$ permutes $Lambda_n$, giving iso $"Gal"\(Q_p\(Lambda_n\)\/Q_p\)arrow.r\(bb(Z)\/p^n\)^times$

#pagebreak(weak:true)
= 3-4
<section-1>
Recall: want to construct $K_(pi\,n)$ as $K\(Lambda_n\)$, $Lambda_n = { x in Lambda\|\[pi^n\]x = 0 }$, $Lambda = union.big_L m_L$, $L\/K$ finite extension

$x +' y = x + y +$ higher power terms with coefficients in $cal(O)_K$, $\(Lambda\,+'\)$ also has $cal(O)_K$-module structure, $a in cal(O)_K\,x in Lambda$, $\[a\]x$

Formal group laws

$A$ is a fixed commutative ring. A formal group low over $A$ is a just $F in A\[\[X\,Y\]\]$, $F\(X\,Y\)= X + Y +$ higher degree terms, satisfying axioms that mimic usual group axioms. (The difference is that we don't have a set)

Composition of power series

$f in A\[\[x_1\,dots.h.c\,x_n\]\]$, $g_1\,dots.h.c\,g_n in A\[\[y_1\,dots.h.c\,y_k\]\]$ want $f\(g 1\(y 1\,. . . y k\)\,. . .\,g n\(y 1\,. . . y k\)\)$. This doesn't work in general!

Counterexample: $n = k = 1$, $f\(x\)= 1 + x + x^2 + dots.h.c\,g\(x\)= 1$, then $f\(g\(x\)\)$ doesn't make sense. Need each $g_i$ have no constant terms

$A\[\[y_1\,dots.h.c\,y_k\]\]_(+)$ is the set of g's without constant terms

$forall f in A\[\[x_1\,dots.h.c\,x_n\]\]\,g_1\,dots.h.c\,g_n in A\[\[y_1\,dots.h.c\,y_k\]\]_(+)$, then $f\(g_1\,dots.h.c\,g_n\)in A\[\[y_1\,dots.h.c\,y_k\]\]$, if $f in A\[\[x_1\,dots.h.c\,x_n\]\]_(+)$, then $f\(g_1\,dots.h.c\,g_n\)in A\[\[y_1\,dots.h.c\,y_k\]\]_(+)$

#statement("Example")[
$f\(x\)= g\(x\)= sum_(n gt.eq 1) x^n$

]
#statement("Lemma")[
Let $f\,g\,h in A\[\[x\]\]_(+)$,

+ this is associative

+ $f$ has a right composition inverse $g in A\[\[x\]\]_(+)$ iff the linear term of $f$ is $a x$ with $a in A^times$. When this is the case, it is also the left inverse

]
#statement("Remark")[
\2. is a power series analogue of the \"inverse function theorem\"

]
#proof(title: "Proof")[
+ Obvious

+ $f = sum a_i x^i$, $g = sum b_i x^i$, if $x = f compose g\(x\)= sum a_i g^i$ with linear term $a_1 b_1 x$, hence $a_1 in A^times$. Conversely, if $a_1 in A^times$

]
#statement("Exercise")[
Formulate and prove a multi-variable version of 2.

]
#statement("Definition")[
A formal group low over $A$ is $F in A\[\[X\,Y\]\]_(+)$\(write $F\(x\,y\)= x +_F y$) satisfying

+ Associative, i.e. $F\(F\(x\,y\)\,z\)= F\(x\,F\(y\,z\)\)$

+ Commutative(want it to be an abelian group), i.e. $F\(x\,y\)= F\(y\,x\)$

+ 0 is the identity, i.e. $F\(x\,0\)= x$

+ Inverse, i.e. $exists i\(x\)= - x + upright("higher terms") in A\[\[X\]\]_(+)$ such that $F\(X\,i\(x\)\)= 0$

]
#statement("Remark")[
Have higher dimensional and non-commutative versions, we only care about the one dimensional commutative formal group laws

]
Observation: From 3. $F\(x\,y\)= x + y + x y g$

#statement("Lemma")[
Suppose $F in A\[\[x\,y\]\]_(+)$ satisfies 1. and suppose $F\(x\,y\)= x + y +$ higher terms, then it automatically satisfying the 3.

]
#proof(title: "Proof")[
Set $f\(x\)= F\(x\,0\)in A\[\[x\]\]_(+)$ is of the form $x +$ higher terms, note that $F\(0\,0\)= 0$, by associativity, $f compose f\(x\)= F\(F\(x\,0\)\,0\)= F\(x\,0\)= f\(x\)$. Let $g$ be the composition inverse of $f$, then $g compose f compose f\(x\)= g compose f\(x\)= x$

]
#statement("Example", title: [Formal addtive group $hat(bb(G))_a$])[
$F\(x\,y\)= x + y$, $i\(x\)= - x$ works universal over arbitrary ring $A$

]
#statement("Example", title: [Formal multiplicative group $hat(bb(G))_m$])[
$F\(x\,y\)= x + y + x y =\(x + 1\)\(y + 1\)- 1$, $i\(x\)= sum_(n gt.eq 1)\(- x\)^n$

]
#statement("Definition")[
Let $F\,G in A\[\[x\,y\]\]_(+)$ be formal gropus laws, a homomorphism $f : F arrow.r G$ is by definition an element of $A\[\[x\]\]_(+)$ such that $f\(x +_F y\)= f\(x\)+_G f\(y\)$, i.e. $f\(F\(x\,y\)\)= G\(f\(x\)\,f\(y\)\)$

]
#statement("Definition")[
$"End"\(F\)$ is a ring under $+_F$ and composition

]
#statement("Example")[
$A = bb(Q)$, $F\(x\,y\)= x + y + x y$, $G\(x\,y\)= x + y$, $f\(x\)= log\(1 + x\)$ is a homomorphims $F arrow.r G$, $f\(x +_F y\)= f\(\(1 + x\)\(1 + y\)- 1\)= log\(1 + x\)+ log\(1 + y\)= f\(x\)+_G f\(y\)$

]
Let $K$ be a local field, $pi in K$ a uniformizer, construct certain formal group laws over $A = cal(O)_K$. These group laws are equipped with the structure of a formal $A$-module, i.e. $A arrow.r "End"\(F\)$

#statement("Definition")[
$cal(F)_pi$ is the set of $f in A\[\[x\]\]_(+)$ such that

+ $f\(x\)= pi x + O\(x^2\)$

+ $f\(x\)= equiv x^q #h(0.444em) mod med pi$, $bb(F)_1 = cal(O)_K\/pi$ i.e. $f\(x\)= sum a_n x^n\,a_n in m_K\,a_q in 1 + m_K$

]
#statement("Example")[
$f\(x\)= pi x + x^q$ $K = O_p\,pi = p\,f\(x\)=\(1 + x\)^p - 1$

]
#statement("Lemma", title: [Key lemma])[
$forall f\,g in cal(F)_pi$, $forall n gt.eq 1$, $exists phi.alt in A\[\[x_1\,dots.h.c\,x_n\]\]_(+)$ such that $f\(phi.alt\(x_1\,dots.h.c\,x_n\)\)= phi.alt\(g\(x_1\)\,dots.h.c\,g\(x_n\)\)$. Moreover, $phi.alt$ is uniquely determined by its linear part $a_1 x_1 + dots.h.c + a_n x_n$, also the linear part can be arbitrary

]
#proof(title: "Proof")[
Start with $phi.alt_1 = a_1 x_1 + dots.h.c + a_n x_n$, construct uniquely by induction $phi.alt_r$ which is a degree $r$ polynomial in $x_1\,dots.h.c\,x_n$ such that $f\(phi.alt_r\(x_1\,dots.h.c\,x_n\)\)= phi.alt_r\(g\(x_1\)\,dots.h.c\,g\(x_n\)\)+ O\(x^(r + 1)\)$ $phi.alt_r = phi.alt_(r - 1) + Q_r$, where $Q_r$ is homogeneous of deg $r$ in $x_1\,dots.h.c\,x_n$ $f\(phi.alt_1\)= pi phi.alt_1 + O\(x^2\)$, and $phi.alt_1\(g\)= phi.alt_1\(pi x_1\,dots.h.c\,pi x_n\)+ O\(x^2\)$ Suppose $phi.alt_r$ has been constructed, $phi.alt_(r + 1) = phi.alt_r + Q$ for some $deg Q = r + 1$ $f\(phi.alt_(r + 1)\)= f\(phi.alt_r + Q\)= f\(phi.alt_r\)+ f'\(phi.alt_r\)Q + O\(x^(2 r + 2)\)= f\(phi.alt_r\)+ pi Q + O\(x^(r + 2)\)$ $phi.alt_(r + 1)\(g\(x_1\)\,dots.h.c\,g\(x_n\)\)= phi.alt_r\(g\(x_1\)\,dots.h.c\,g\(x_n\)\)+ Q\(g\(x_1\)\,dots.h.c\,g\(x_n\)\)= phi.alt_r\(g\(x_1\)\,dots.h.c\,g\(x_n\)\)+ Q\(pi x_1\,dots.h.c\,pi x_n\)+ O\(x^(r + 2)\)$ Set $Q$ to be $frac(\[f\(phi.alt_r\)- phi.alt_r\(g\)\]m o d x^(r + 1), pi^(r + 1) - pi)$. Mod $pi$, $f\(phi.alt_r\)equiv phi.alt_r^q$, $phi.alt_r\(g\)equiv phi.alt_r\(x_1^q\,dots.h.c\,x_n^q\)equiv phi.alt_r^q\)$, so the numerator is divisible by $pi$. Hence $Q$ has coefficients in $A = cal(O)_K$

]
#statement("Proposition", title: [Lubin-Tate formal group law])[
$forall f in cal(F)_pi$, $exists_1$ formal group law $F_f = F\(x\,y\)in A\[\[x\,y\]\]_(+)$ such that $f in "End"\(F\)$ which defines a Lubin-Tate group

]
#proof(title: "Proof")[
By the Key lemma, there is a unique $F in A\[\[x\,y\]\]_(+)$ with linear part is $x + y$ such that $f\(F\(x\,y\)\)= F\(f\(x\)\,f\(y\)\)$, only need to check that $F$ is a formal group law. Denote $G_1\(x\,y\,z\)= F\(x\,F\(y\,z\)\)\,G_2\(x\,y\,z\)= F\(F\(x\,y\)\,z\)$, then $f\(G_1\(x\,y\,z\)\)= f\(F\(x\,F\(y\,z\)\)\)= F\(f\(x\)\,f\(F\(y\,z\)\)\)= F\(f\(x\)\,F\(f\(y\)\,f\(z\)\)\)= G_1\(f\(x\)\,f\(y\)\,f\(z\)\)$, same for $G_2$, and they have the same linear parts $x + y + z$, so they are indeed equal

]
#statement("Remark")[
over $bb(F)_q$, there is an endomorphism $x^q$

]
Fix $f in cal(F)_pi$, ther is $cal(O)_K arrow.r "End"\(cal(F)_f\)$

#statement("Lemma")[
$forall a in cal(O)_K\,forall f\,g in cal(F)_pi$, $e x i s t s_1$ homomorphism $\[a\]_(g\,f) : F_f arrow.r F_g$ which intertwines the endomorphisms $f\,g$, i.e. $\[a\]_(g\,f) in cal(O)_K\[\[x\]\]_(+)$, $\[a\]_(g\,f)\(F_f\(x\,y\)\)= F_g\(\[a\]_(g\,f)\(x\)\,\[a\]_(g\,f)\(y\)\)$, $\[a\]_(g\,f)\(f\(x\)\)= g\(\[a\]_(g\,f)\(x\)\)$, the linear part of $\[a\]_(g\,f)$ is $a x$

]
#proof(title: "Proof")[
By the key lemma, there exists a unique $h\(x\)in cal(O)_K\[\[x\]\]_(+)$ that intertwines $f\,g$ with linear part $a x$, only need to check $h$ is a homomorphism, i.e. $F_g\(h\(x\)\,h\(y\)\)= h\(F_f\(x\,y\)\)$, note that bothe sides have linear part $a x + a y$

]
#statement("Lemma")[
$forall a\,b in cal(O)_K\,forall f\,g\,h in cal(F)_pi$

+ $\[a\]_(g\,f) +_(F_g)\[b\]_(g\,f)$ is the of course the unique homomorphism $F_f arrow.r F_g$ with linear part $\(a + b\)x$, i.e. $\[a + b\]_(g\,f)$

+ $\[b\]_(h\,g)\[a\]_(g\,f) =\[a b\]_(h\,f)$

Special case: $\[1\]_(g\,f)\,\[1\]_(f\,g)\,\[1\]_(f\,f)\,\[1\]_(g\,g)$ are canonical isomorphisms $\[\]_(f\,f) : cal(O)_K arrow.r "End"\(F_f\)$ is a ring homomorhpism, and uniquely characterized by $\[a\]_(f\,f)$ has linear part $a x$, $\[pi\]_(f\,f) = f$ We have a formal $cal(O)_K$-module structure on $F_f$, $cal(O)_K arrow.r "End"\(F_f\)$, $\[1\]_(f\,g)$ is a formal $cal(O)_K$ module isomorphism $F_f arrow.r F_g$

]
#statement("Example")[
$K = bb(Q)_p$, $pi = p$, $f =\(1 + x\)^p - 1 in cal(F)_p$, and $F_f\(x\,y\)=\(1 + x\)\(1 + y\)- 1$. In this case, $\[a\]_(f\,f) =\(1 + x\)^a - 1$ for $a in bb(Z)_p$, why is $binom(a, i) in bb(Z)_p$, since $bb(Z)$ is dense in $bb(Z)_p$, let $a_k arrow.r a$, $a_k in bb(Z)$, $bb(Z) in.rev binom(a_k, i) arrow.r binom(a, i)$ in $bb(Q)_p$, but $bb(Z)_p$ is closed in $bb(Q)_p$, to finish, see $\(1 + x\)^a\(1 + y\)^a - 1 =\(\(1 + x\)\(1 + y\)\)^a - 1$, and $\[a\]_(f\,f)$ commutes with $f$

]
Extending valuation $v : K arrow.r bb(Z) union { oo }$ to $macron(K)$

recall $L\/K$ finite ext, $exists_1$ discrete valuation $w : L arrow.r bb(Z) union { oo }$, recall $w$ must be surjective, $w\(x\)= e\(L\/K\)v\(x\)$, so we can extend and define $v : L arrow.r bb(Q) union { oo }$, $v\(y\)= w\(y\)\/e\(L\/K\)$, in the end have $v : macron(K) arrow.r bb(Q) union { oo }$

Define $Lambda = { x in macron(K)\|v\(x\)> 0 }$, $Lambda = union_L m_L$, $L$ runs over finite ext

Obeservation: $forall f\(x_1\,dots.h.c\,x_n\)in cal(O)_K\[\[x_1\,dots.h.c\,x_n\]\]$ with constant term in $Lambda$\(resp $m_L$), $forall x_1\,dots.h.c\,x_n in Lambda$\(resp $m_L$), $f\(x_1\,dots.h.c\,x_n\)$ converges in $Lambda$\(resp $m_L$). For example $f\(x\)= a_0 + a_1 x + dots.h.c\,x in Lambda$, so $x in m_L$ for some $L$, just need $a_i x^i = 0$, but $v\(a_i x^i\)= v\(a_i\)+ i v\(x\)$

For $f in cal(F)_pi$, we can make $Lambda$ into a group $Lambda_f$ with addition $+_(F_f)$, and an $cal(O)_K$ module $\[a\]_(f\,f)$

#pagebreak(weak:true)
= 3-23
<section-2>
#statement("Definition")[
For any A module M, $M_n = ker\(M arrow.r^(pi^n) M\)$, this is independent of the choice of $pi$, consider $Lambda_(f\,n) subset.eq macron(K)$, define $K_(pi\,n)$ to be $K\(Lambda_(f\,n)\)$ which is independent of the choice of $f$\(reason: $x in Lambda_(f\,n) inter L$ for some L/K finite, $\[1\]_(g\,f) : Lambda_(f\,n) arrow.r Lambda_(g\,n)$ is an isomorphism since it is an isomorphism between $F_f$ and $F_g$, so $\[1\]_(g\,f)\(x\)in Lambda_(g\,n) inter L$, since $L$ can be arbitrary, and the smallest field extension containing $x$ is unique)

]
Claim: $K_(pi\,n) = K\(r o o t s o f f^(\(n\))\)$, $f\(x\)= X^q + pi x$, $f^(\(n\))\(x\)= f^(compose n)$

Newton Polygon\[Neukirch's book\]: Suppose $f\(x\)= a_n x^n + dots.h.c + a_1 x + a_0 in K\[x\]$, $\(K\,v\)$ disc valued field draw $\(i\,v\(a_i\)\)$, join them so that it the joining curve is convex(the convex hull) i-th segment has slope $s_i$, horizontal dist $n_i$, $sum n_i = n$. Among all the roots of $f$ in $macron(K)$\(count with multiplicity), exactly $n_i$ of them have valuation -$s_i$

$f^(\(n\))\(x\)equiv x^(q^n) #h(0.444em) mod med pi$ and $f^(\(n\))\(x\)= x^(q^n) + dots.h.c + pi^n x$. Try the Newton Polygon, exactly one with valuation $oo$ which corresponds to 0, the others have positive valution $gt.eq 1$, justifying the claim So $K_(pi\,n)\/K$ is Galois, being the splitting field of $f^(\(n\))\(x\)$

#statement("Lemma")[
For any $f in F_pi$, the module $Lambda_(f\,1)$ has $q$ distinct elements. The map $pi : Lambda_f arrow.r Lambda_f$ is surjective

]#label("2021/3/25-12:52")
#proof(title: "Proof")[
$f$ and $f'$ are coprime, so $f$ has $q$ distinct roots. And use Newton polygon, for any $lambda in Lambda$ see $f\(x\)- lambda = x^q - pi x - lambda$ has roots of valuations $gt.eq 1$

]
#statement("Lemma")[
$K_(pi\,n)\/K$ is separable

]
#proof(title: "Proof")[
Induction on $n$. $n = 1$, $K_(pi\,1) = K\(Lambda_(f\,1)\)$ is true by Lemma #ref(label("2021/3/25-12:52"), supplement: none). For $alpha in Lambda_(f\,n + 1)$, need to show $alpha$ is separable over $K$. $f\(alpha\)= pi dot.op_phi.alt alpha in Lambda_(f\,n)$, denote as $beta$, $alpha$ is a root of $g\(x\)= f\(x\)- beta$, $g' = f' = q x^(q - 1) + pi$, all roots of $g'$ has valuation $lt.eq 0$, hence $alpha$ is not a root of $g'$, so $alpha$ is a simple root of $g$, and $g in K_(pi\,n)\[x\]$

]
#statement("Proposition")[
$forall f in F_pi$ and $n gt.eq 1$, the $A$-module $Lambda_(f\,n)$ is iso to $A\/pi^n A$. In particular, it has $q^n$ elements

]
#proof(title: "Proof")[
First show $\|Lambda_(f\,n)\|= q^n$. We have short exact sequence #math.equation(block: true, numbering: none, $0 arrow.r Lambda_(f\,1) arrow.r Lambda_(f\,n + 1) arrow.r^pi arrow.r Lambda_(f\,n) arrow.r 0$) The surjectivity is due to Lemma #ref(label("2021/3/25-12:52"), supplement: none). By classification theorem of finitely generated module over a PID($A$) #math.equation(block: true, numbering: none, $Lambda_(f\,n) tilde.equiv A\/pi^(n_1) xor dots.h.c xor A\/pi^(n_k)$) So the $pi$ torsion of $Lambda_(f\,n)$ is $pi^(n_1 - 1) A\/pi^(n_1) xor dots.h.c xor pi^(n_k - 1) A\/pi^(n_k) tilde.equiv A\/p i dots.h.c xor A\/pi$, $k$ copies, which is impossible since it should be $Lambda_(f\,1)$

]
As a consequence, the group of $A$-module automorphisms of $Lambda_(f\,n)$ is equal to $\(A\/pi^n\)\^times$

$"Gal"\(K_(pi\,n)\/K\)$ acts on $K_(pi\,n)$, and $x in Lambda_(f\,n)$ iff $x$ is a root of $f^(\(n\))$ which is acted on by the Galois group, $f$ can be power series in $A\[\[x\]\]_(+)$ since the action is continuous and preserve the valuation. In fact, $"Gal"\(K_(pi\,n)\/K\)$ acts on $Lambda_(f\,n)$ preserving the $A$-module structure, so we get the lubin-Tate homomorphism $rho_(pi\,n) : "Gal"\(K_(pi\,n)\/K\)arrow.r\(A\/pi^n\)^times$

#statement("Theorem")[
+ $K_(pi\,n)\/K$ is totally ramified with deg $\(q - 1\)q^(n - 1)$

+ $rho_(pi\,n)$ is an isomorphism

+ $pi$ is a norm from $K_(pi\,n)$, i.e. $exists y in K_(pi\,n)$, $N_(K_(pi\,n)\/K)\(y\)= pi$

]
#proof(title: "Proof")[
+ Take a non-zero root $pi_1 in Lambda_(f\,1) - { 0 }$ of $f$. Take $pi_2 in Lambda_(f\,2) - Lambda_(f\,1)$ to be a root of $f\(x\)- pi_1$, inductively defined $pi_i in Lambda_(f\,i) - Lambda_(f\,i - 1)$'s. $v\(pi_1\)= frac(1, q - 1)$, use Newton polygon, $v\(pi_2\)= frac(1, \(q - 1\)q)$, and $v\(pi_n\)= frac(1, \(q - 1\)q^(n - 1))$, hence the ramification index $e\(K_(pi\,n)\/K\)gt.eq\(q - 1\)q^(n - 1)$. Since $rho_(pi\,n)$ is obviously injective, $\[K_(pi\,n) : K\]lt.eq\|\(A\/pi^n A\)^times\|=\(q - 1\)q^(n - 1)$

+ Also done by 1

+ $f^(\(n - 1\))\(pi_n\)= pi_1$, and $frac(f\(x\), x) compose f^(\(n - 1\))\(pi_n\)= 0$, denote the polynomial $h$, then $deg h =\(q - 1\)q^(n - 1)$, hence the monic minimal polynomial, justifing 3, $K_(pi\,n) = K\(pi_n\)$, $N_(K_(pi\,n)\/K)\(pi_n\)=\(- 1\)^(\(q - 1\)q^(n - 1)) pi$, and the sign is $1$ unless $n = 1$ and $q = 2^k$

]
It turns out, the maximal abelian extension $K^(a b) = K_pi dot.op K^(u r)$\(linearly disjoint, since $K_pi$ is totally ramified), $K_pi = union_(n gt.eq 1) K_(pi\,n)$. Hence $"Gal"\(K^(a b)\/K\)= "Gal"\(K_pi\/K\)times "Gal"\(K^(u r)\/K\)tilde.equiv "Gal"\(K_pi\/K\)times hat(bb(Z))$

Recall the Lubin-Tate homomorphism $rho_(pi\,n) : "Gal"\(K_(pi\,n)\/K\)arrow.r\(A\/pi^n\)^times$ is an iso, taking inverse limit, we have iso $rho_pi : "Gal"\(K_pi\/K\)arrow.r A^times$. So $"Gal"\(K^(a b)\/K\)tilde.equiv A^times hat(bb(Z))$. It will turn out that the local reciprocity map $phi.alt : K^times arrow.r "Gal"\(K^(a b)\/K\)$ is given by $K^times = pi^Z times A^times arrow.r hat(Z) times A^times$, $\(pi^i\,a\)mapsto\(i\,a^(- 1)\)$

#statement("Definition")[
$K^(L T) = K_pi K^(u r)$, $phi.alt_pi : "Gal"\(K^(L T)\/K\)$\(don't yet know that $K^(L T) = K^(a b)$)

]
#statement("Lemma")[
+ $\(B\,+\)arrow.r\(B\,+\)$, $x mapsto x - sigma\(x\)$, is surjective, and kernel is $A$

+ $B^times arrow.r B^times$, $x mapsto x dot.op sigma\(x\)^(- 1)$ is surjective and kernel is $A^times$

]
#proof(title: "Proof")[
+ Prove by induction that $0 arrow.r A arrow.r B arrow.r^(1 - sigma) B arrow.r 0$ is exact, so we prove $0 arrow.r A\/pi^n arrow.r B\/pi^n arrow.r B\/pi^n arrow.r$ is exact. The case $n = 1$, it's just $0 arrow.r F_q arrow.r macron(F)_q arrow.r macron(F)_q arrow.r 0$ is exact by Galois theory. Assuming exactness for $n$, for $n + 1$, $0 arrow.r B\/pi arrow.r B\/pi^(n + 1) arrow.r B\/pi^n arrow.r 0$

  #align(center)[
  #align(center)[#set text(size:7pt)
  #diagram(spacing:(7mm,9mm),
  node((1,0),[$0$]),
  node((3,0),[$0$]),
  node((1,1),[$A\/pi$]),
  node((2,1),[$A\/pi^(n + 1)$]),
  node((3,1),[$A\/pi^n$]),
  node((0,2),[$0$]),
  node((1,2),[$B\/pi$]),
  node((2,2),[$B\/pi^(n + 1)$]),
  node((3,2),[$B\/pi^n$]),
  node((4,2),[$0$]),
  node((0,3),[$0$]),
  node((1,3),[$B\/pi$]),
  node((2,3),[$B\/pi^(n + 1)$]),
  node((3,3),[$B\/pi^n$]),
  node((4,3),[$0$]),
  node((1,4),[$0$]),
  node((3,4),[$0$]),
  edge((1,0),(1,1),"->"),
  edge((3,0),(3,1),"->"),
  edge((1,1),(1,2),"->"),
  edge((1,1),(2,1),"->",stroke:(dash:"dashed")),
  edge((2,1),(3,1),"->",stroke:(dash:"dashed")),
  edge((2,1),(2,2),"->",stroke:(dash:"dashed")),
  edge((3,1),(3,2),"->"),
  edge((0,2),(1,2),"->"),
  edge((1,2),(2,2),"->"),
  edge((1,2),(1,3),"->",[$1 - sigma$]),
  edge((2,2),(3,2),"->"),
  edge((2,2),(2,3),"->",[$1 - sigma$]),
  edge((3,2),(4,2),"->"),
  edge((3,2),(3,3),"->",[$1 - sigma$]),
  edge((0,3),(1,3),"->"),
  edge((1,3),(2,3),"->"),
  edge((1,3),(1,4),"->"),
  edge((2,3),(3,3),"->"),
  edge((3,3),(4,3),"->"),
  edge((3,3),(3,4),"->"))]
  ]
  Then use Snake lemma. In general, the inverse limit is only left exact, but recall $0 arrow.r A_i arrow.r B_i arrow.r C_i arrow.r 0$ are short exact sequences, Mittag-Leffler condition: $forall i$, the subgroups $Im\(A_j arrow.r A_i\)$ of $A_i$ stablizes when $j$ is large, the the inverse limit is exact. Here $B = lim_arrow.l B\/pi^n$ since $B$ is complete

+ Multiplicative analogue

]
#statement("Proposition")[
$pi\,pi.alt = pi u$, $f in F_pi\,g in F_pi$. Fix $epsilon.alt in B^times$ such that $sigma\(epsilon.alt\)epsilon.alt^(- 1) = u in A^times$, by surjection $B^times arrow.r B^times$, i.e. $sigma\(epsilon.alt\)= u epsilon.alt$. There exists $theta\(T\)in B\[\[T\]\]_(+)$ such that

+ the linear coefficient of $theta$ is $epsilon.alt$

+ $sigma theta = theta compose\[u\]_f$

+ $theta$ is an iso $F_f arrow.r F_g$\(base changed from $A$ to $B$)

+ $theta$ is $A$-linear, i.e. $forall a in A$, $\[a\]_g compose theta = theta compose\[a\]_f$. Thus $theta$ is an iso between formal $A$-modules $F_f$ and $F_g$ over $B$

]
#proof(title: "Proof")[
Construct $theta$ satisfying $1\,2$ by applying Lemma. Given such $theta$, let's modify it so it also satisfies $3\,4$. Actually, we modify $theta$ such that $g = sigma theta compose f compose theta^(- 1) = theta compose\[u\]_f compose f compose theta^(- 1) = theta compose f compose\[u\]_f compose theta^(- 1) = h$, $sigma h = sigma theta compose f compose\[u\]_f\(sigma theta\)^(- 1) = sigma theta compose f compose theta^(- 1) = h$, so $h in A\[\[x\]\]_(+)$

]
#statement("Theorem")[
$K^(L T)\,phi.alt_pi$ is independent of $pi$

]
#proof(title: "Proof")[
Idea: If $pi\,pi.alt$ are two different uniformizers, $f in F_pi\,$, $f in F_pi.alt\,$, they are iso whose base change from $A = O_K$ to $B = O_(breve(K))$, $breve(K)$ is the completion of $K^(u r)$

]
#statement("Fact")[
If $L$ is discretely valued field, then $L$ is algebraically closed in $hat(L)$, i.e. every element in $hat(L) - L$ is transcendental over $L$

]
#statement("Fact")[
Suppose $L\/K$ is a finite extension of discretely valued fields, then $K$ is algebraically closed in $hat(L)$

]
Frobenius reciprocity: #math.equation(block: true, numbering: none, $"Hom"_G\(X\,C o I n d_H^G A\)tilde.equiv "Hom"_H\(X\,A\)$) #math.equation(block: true, numbering: none, $"Hom"_G\(I n d_H^G A\,X\)tilde.equiv "Hom"_H\(A\,X\)$)

#statement("Lemma")[
$"Ind"^G : A b arrow.r G - m o d u l e s$ takes inj to inj, $C o I n d^G :$ takes proj to proj

]
#statement("Corollary")[
The category of $G$ modules have enough inj and proj

]
A G module X is relatively inj if it's a direct summand of a coinduced G module. relative proj.

#statement("Proposition")[
$H^i\(G\,X\)= 0\,forall i gt.eq 1$ For $X$ relative inj. $H_i\(G\,Y\)= 0\,forall i gt.eq 1$ For $Y$ relative proj

]
#proof(title: "Proof")[
$P_bullet arrow.r bb(Z) arrow.r 0$ free resolution. Without loss of generality, say $X = C o I n d^G A$, $"Hom"_G\(P_bullet\,C o I n d^G A\)tilde.equiv "Hom"_Z\(P_bullet\,A\)= 0$

]
#pagebreak(weak:true)
= Tate cohomology
<tate-cohomology>
$G$ is finite, the goal is to put homology and cohomology in the same framework

#statement("Fact")[
If $P$ is relatively projective module, then $hat(H)^i\(G\,P\)= 0$ for all $i$

]
Cup product for Tate cohomology $A times.o_Z B$ is a $G$ module with diagonal action of $G$

The cup product $hat(H)^p\(X\,A\)times.o hat(H)^q\(X\,B\)arrow.r hat(H)^(p + q)\(X\,A times.o B\)$ is uniquely characterized by

+ It is functorial in $A$ and $B$

+ For $p = q = 0$, it is induced by $A^G times.o B^G arrow.r\(A times.o B\)^G$, $a times.o b mapsto a times.o b$

+ compatible with connecting homomorphism If #math.equation(block: true, numbering: none, $0 arrow.r A arrow.r A' arrow.r A'' arrow.r 0$) is exact such that #math.equation(block: true, numbering: none, $0 arrow.r A times.o B arrow.r A' times.o B arrow.r A'' times.o B arrow.r 0$) is exact, the $forall beta in hat(H)^q\(B\)$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$hat(H)^p\(A''\)$]),
  node((1,0),[$hat(H)^p\(A'' times.o B\)$]),
  node((0,1),[$hat(H)^(p + 1)\(A\)$]),
  node((1,1),[$hat(H)^(p + 1)\(A times.o B\)$]),
  edge((0,0),(1,0),"->",[$- smile beta$]),
  edge((0,0),(0,1),"->",[$delta$]),
  edge((1,0),(1,1),"->",[$delta$]),
  edge((0,1),(1,1),"->",[$- smile beta$]))]
  ]
  Similar for $alpha smile -$, up to a sign $\(- 1\)^p$ which comes from the fact that it is graded commutative


#pagebreak()
#heading(numbering:none)[References]


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
