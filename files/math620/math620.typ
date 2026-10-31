#import "@preview/fletcher:0.5.8": diagram, node, edge
#set document(title: "MATH620 - Algebraic Number Theory", author: "Haoran Li")
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
#text(size:22pt,weight:"bold")[MATH620 - Algebraic Number Theory]
#v(2cm)
#image("Pictures/Emil_Artin.jpg",width:50%)
#v(2cm)
Taught by Niranjan Ramachandran \
Notes taken by Haoran Li \
2020 Spring
#v(2cm)
Department of Mathematics \
University of Maryland
]
#pagebreak()
#outline(title:[Contents])
#pagebreak()

#pagebreak(weak:true)
= Disciminant
<disciminant>
#statement("Definition")[
An #emph[algebraic number field]#index-entry("Algebraic number field") $K$ is a finite field extension of $bb(Q)$, thus $K = bb(Q)\[alpha\]$ for some algebraic number $alpha$, its ring of algebraic integers is denoted $cal(O)_K$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$cal(O)_K$]),
node((1,0),[$K$]),
node((0,1),[$bb(Z)$]),
node((1,1),[$bb(Q)$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
More generally, if $E\/F$ is a finite separable field extension, $B\,A$ are their ring of integers

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$E$]),
node((0,1),[$A$]),
node((1,1),[$F$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
]
#statement("Definition")[
The minimal polynomial of $alpha$ is #math.equation(block: true, numbering: none, $f\(x\)= product_(i = 1)^n\(x - alpha_i\)= product_(i = 1)^r\(x - alpha_i\)dot.op product_(j = 1)^s\(x - alpha_(r + j)\)dot.op product_(j = 1)^s\(x - overline(alpha_(r + j))\)$) $alpha = alpha_1\,dots.h.c\,alpha_r$ are the real roots and $alpha_(r + 1)\,alpha_(r + s + 1) = overline(alpha_(r + 1))\,dots.h.c\,alpha_(r + s)\,alpha_(r + 2 s) = overline(alpha_(r + s))$ are the complex roots. Then #math.equation(block: true, numbering: none, $K times.o_(bb(Q)) bb(R) = bb(Q)\[alpha\]times.o_(bb(Q)) bb(R) & tilde.equiv frac(bb(Q)\[x\], f\(x\)) times.o bb(R)\
 & tilde.equiv frac(bb(R)\[x\], f\(x\))\
 & tilde.equiv product_(i = 1)^r frac(bb(R)\[x\], x - alpha_i) times product_(j = 1)^s frac(bb(R)\[x\], \(x - beta_j\)\(x - overline(beta_j)\))\
 & tilde.equiv bb(R)^r times bb(C)^s$) $alpha mapsto alpha_i$ corresponds to all the real embeddings $sigma_i : K arrow.r.hook bb(R)$. $alpha mapsto alpha_(r + i)$, $alpha mapsto overline(alpha_(r + i))$ corresponds all the conjugate complex embeddings $sigma_(r + i)\,sigma_(r + s + i) = overline(sigma_i) : K arrow.r.hook bb(C)$. $n =\[K : bb(Q)\]= deg f = r + 2 s$

]
#aside("Note")[
$\(r\,s\)$ is called the signature of $K$

]
#statement("Example")[
$bb(Q)\(sqrt(5)\)arrow.r.hook bb(R) times bb(R)$ give the two real embeddings. $bb(Q)\(sqrt(- 5)\)arrow.r.hook bb(C)$ give the two conjugate complex embeddings

]
#statement("Definition")[
$\[E : F\]= n$, then $B tilde.equiv A^n$ as an $A$ module, assume $beta_1\,dots.h.c\,beta_n$ is a basis, define #math.equation(block: true, numbering: none, $D\(beta_1\,dots.h.c\,beta_n\)= det\("Tr"_(B\/A)\(beta_i beta_j\)\)in A$) The #emph[discriminant]#index-entry("Discriminant") $"disc"\(B\/A\)= D\(beta_1\,dots.h.c\,beta_n\)$ is well-defined in $A\/\(A^times\)^2$. In particular, $"disc"\(cal(O)_K\/bb(Z)\)$ is a well-defined integer

]
#statement("Lemma")[
$gamma_1\,dots.h.c\,gamma_n in cal(O)_K$ is an $bb(Z)$-basis for $cal(O)_K$ iff $D\(gamma_1\,dots.h.c\,gamma_n\)= "disc"\(cal(O)_K\/bb(Z)\)$. More generally, if $A$ is integrally closed and Noetherian, $gamma_1\,dots.h.c\,gamma_n in B$ is an $A$-basis of $B$ iff $D\(gamma_1\,dots.h.c\,gamma_n\)= "disc"\(B\/A\)$

]
#proof(title: "Proof")[
Write $gamma_i = sum c_(j i) beta_j$, then $det\("Tr"\(gamma_i gamma_j\)\)=\(det C\)^2 "disc"\(cal(O)_K\/bb(Z)\)$. Thus $D\(gamma_1\,dots.h.c\,gamma_n\)= "disc"\(cal(O)_K\/bb(Z)\)arrow.l.r.double det C = plus.minus 1 arrow.l.r.double C in "GL"_n\(bb(Z)\)arrow.l.r.double gamma_1\,dots.h.c\,gamma_n$ is an $bb(Z)$-basis

]
#statement("Example")[
$K = bb(Q)\(sqrt(d)\)$, $d$ is square free. $cal(O)_K$ has ${ 1\,sqrt(d) }$ as an $bb(Z)$-basis if $d equiv 2\,3 #h(0.444em) mod med 4$ #math.equation(block: true, numbering: none, $"disc"\(cal(O)_K\/bb(Z)\)= det "Tr"_(cal(O)_K\/bb(Z)) mat(delim: "(", 1, sqrt(d); sqrt(d), d) = det mat(delim: "(", 2, 0; 0, 2 d) = 4 d$) $cal(O)_K$ has ${ 1\,frac(1 + sqrt(d), 2) }$ as an $bb(Z)$-basis if $d equiv 1 #h(0.444em) mod med 4$ #math.equation(block: true, numbering: none, $"disc"\(cal(O)_K\/bb(Z)\)= det "Tr"_(cal(O)_K\/bb(Z)) mat(delim: "(", 1, frac(1 + sqrt(d), 2); frac(1 + sqrt(d), 2), frac(1 + 2 sqrt(d) + d, 4)) = det mat(delim: "(", 2, 1; 1, frac(2 + 2 d, 4)) = d$) Therefore $7$ can never be a discriminant

]
#statement("Proposition")[
$gamma_1\,dots.h.c\,gamma_n in cal(O)_K$, $N = bb(Z) gamma_1 + dots.h.c + bb(Z) gamma_n lt.eq cal(O)_K$ has finite index in $cal(O)_K$ iff $D\(gamma_1\,dots.h.c\,gamma_n\)eq.not 0$, $D\(gamma_1\,dots.h.c\,gamma_n\)=\[cal(O)_K : N\]^2 "disc"\(cal(O)_K\/bb(Z)\)$

]
#proof(title: "Proof")[
Suppose $beta_1\,dots.h.c\,beta_n$ is an $bb(Z)$-basis, $D\(beta - 1\,dots.h.c\,beta_n\)= "disc"\(cal(O)_K\/bb(Z)\)$, $gamma_i = sum c_(j i) beta_j$, $det C =\[cal(O)_K : N\]$

]
#statement("Proposition")[
If $D\(gamma_1\,dots.h.c\,gamma_n\)$ is square free, then $gamma_1\,dots.h.c\,gamma_n$ is an $bb(Z)$-basis

]
#statement("Example")[
$K = bb(Q)\(alpha\)$, $alpha$ is a root of irreducible polynomial $x^3 - x - 1$, $D\(1\,alpha\,alpha^2\)= - 23$ which is square free, hence $cal(O)_K = bb(Z) + bb(Z) alpha + bb(Z) alpha^2 = bb(Z)\[alpha\]$

]
#statement("Proposition")[
$\[E : F\]= n$ is separable, $Omega$ is the Galois closure of $E$, $"Hom"_F\(E\,Omega\)= { sigma_1\,dots.h.c\,sigma_n }$ are distinct $F$-embeddings of $E$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$E$]),
node((0,1),[$A$]),
node((1,1),[$F$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
If $beta_1\,dots.h.c\,beta_n$ is an $F$-basis of $E$, then $D\(beta_1\,dots.h.c\,beta_n\)= det\(sigma_i\(beta_j\)\)^2 eq.not 0$

]
#proof(title: "Proof")[
Deonte $Q = sigma_i\(beta_j\)$, then #math.equation(block: true, numbering: none, $D\(beta_1\,dots.h.c\,beta_n\) & = det\("Tr"_(E\/F)\(beta_i beta_j\)\)\
 & = det\(sum sigma_k\(beta_i beta_j\)\)\
 & = det\(sum sigma_k\(beta_i\)sigma_k\(beta_j\)\)\
 & = det\(Q^T Q\)\
 & = det\(sigma_i\(beta_j\)\)^2\
 & eq.not^(upright("Theorem ") #ref(label("Dedekind's theorem"), supplement:none)) 0$)

]
#statement("Theorem", title: [Dedekind's theorem])[
$G$ is group, $Omega$ is a field, $sigma_1\,dots.h.c\,sigma_n$ are distinct homomorphisms $G arrow.r Omega^times$, then $sigma_i$'s are linear independent over $Omega$

]#label("Dedekind's theorem")
#statement("Definition")[
Assume $A\,B$ are integrally closed in $F\,E$, $beta_1\,dots.h.c\,beta_n in B$ is an $F$-basis of $E$, $C = A beta_1 + dots.h.c + A beta_n lt.eq B$, $C^(*) = { beta in E\|"Tr"_(E\/F)\(beta beta_i\)in A }$, $beta in B arrow.r.double beta beta_i in B arrow.r.double "Tr"\(beta beta_i\)in A arrow.r.double C lt.eq B lt.eq C^(*)$, $C^(*) = A beta'_1 + dots.h.c + A beta'_n$, $beta'_1\,dots.h.c\,beta'_n$ is a dual basis. For $alpha in E$, $alpha = sum "Tr"_(E\/F)\(alpha beta_i\)beta'_i$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$E$]),
node((0,1),[$A$]),
node((1,1),[$F$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
]
#statement("Example")[
$E = F\(beta\)$, $f in A\[x\]$ is the minimal polynomial of $beta in B$, $deg f = n$, $C = A\[beta\]lt.eq B$, Euler discovered #math.equation(block: true, numbering: none, $"Tr"_(E\/F)\(beta^i\/f'\(beta\)\)= cases(0 quad 0 lt.eq i lt.eq n - 1, 1 quad i = n - 1)\,det "Tr"_(E\/F)\(frac(beta^i beta^j, f'\(beta\))\)=\(- 1\)^n$) $frac(beta^(n - 1 - i), f'\(beta\))$ is the dual basis of $beta^i$

]#label("Example of dual basis")
#statement("Proposition")[
In Example #ref(label("Example of dual basis"), supplement: none), suppose $f\(x\)= product_(i = 1)^n\(x - beta_i\)in macron(E)\[x\]$, $f'\(x\)= sum_(i = 1)^n product_(j eq.not i)\(x - beta_j\)$. Then #math.equation(block: true, numbering: none, $D\(1\,beta\,dots.h.c\,beta^(n - 1)\)= product_(1 lt.eq i < j lt.eq n)\(beta_i - beta_j\)^2 =\(- 1\)^(frac(n\(n - 1\), 2)) = N_(E\/F)\(f'\(beta\)\)$)

]
#proof(title: "Proof")[
#math.equation(block: true, numbering: none, $D\(1\,beta\,dots.h.c\,beta^(n - 1)\) & = det\(sigma_i\(beta^j\)\)^2\
 & = det\(beta_i^j\)^2\
 & = product_(1 lt.eq i < j lt.eq n)\(beta_i - beta_j\)^2\
 & =\(- 1\)^(frac(n\(n - 1\), 2)) product_i product_(j eq.not i)\(beta_i - beta_j\)\
 & =\(- 1\)^(frac(n\(n - 1\), 2)) product_i f'\(beta_i\)\
 & =\(- 1\)^(frac(n\(n - 1\), 2)) N\(f'\(beta\)\)$)

]
#statement("Remark")[
$Delta = product_(1 lt.eq i < j lt.eq n)\(beta_i - beta_j\)^2$ is the determinant $"disc"\(f\)= "disc"\(E\/F\)$

]
#statement("Lemma")[
$f\(x\)= x^n + a x + b$, $"disc"\(f\)=\(- 1\)^(frac(n\(n - 1\), 2))\(n^n b^(n - 1) +\(- 1\)^n\(n - 1\)^(n - 1) a^n\)$

]
#statement("Example")[
$K = bb(Q)\(beta\)$, $beta$ is a root of $f\(x\)= x^5 - x - 1 in bb(Z)\[x\]$, $"disc"\(f\)= 2869 = 19 times 151$ is square free, hence $\[cal(O)_K : bb(Z)\[beta\]\]= 1$, $cal(O)_K = bb(Z)\[beta\]$

]
#statement("Proposition")[
+ $K = bb(Q)\(alpha\)$, $"sgn" "disc"\(K\/bb(Q)\)=\(- 1\)^s$

+ \(Stickelberger) $"disc"\(bb(O)_K\/bb(Z)\)equiv 0\,1 #h(0.444em) mod med 4$

]
#proof(title: "Proof")[
+ $1\,alpha\,dots.h.c\,alpha^n$ is a basis for $K$, since $"disc"\(K\/bb(Q)\)in bb(Q)^times\/\(bb(Q)^times\)^2$ $"sgn" D\(1\,alpha\,dots.h.c\,alpha^n\)= "sgn" det\(sigma_j\(alpha^i\)\)^2 = "sgn" product_(1 lt.eq i < j lt.eq n)\(alpha_i - alpha_j\)^2 = "sgn" product_(1 lt.eq j lt.eq s)\(alpha_(r + j) - macron(alpha)_(r + j)\)^2 =\(- 1\)^s$

+ $beta_1\,dots.h.c\,beta_n$ is an $bb(Z)$-basis of $cal(O)_K$, $"disc"\(cal(O)_K\/bb(Z)\)= det\(sigma_i\(beta^j\)\)^2$, $"Gal"\(overline(bb(Q))\/bb(Q)\)$ acts on $"Hom"\(K\,overline(bb(Q))\)$, $K arrow.r.hook^sigma overline(bb(Q)) arrow.r^tau overline(bb(Q))$. $det A = sum_(tau in S_n) "sgn"\(tau\)product_(i = 1)^n a_(i tau\(i\)) = P - N$, $P$ for those $tau in A_n$, $N$ for those aren't, so $"disc"\(cal(O)_K\/bb(Z)\)=\(P - N\)^2 =\(P + N\)^2 - 4 P N$, $eta in "Gal"\(overline(bb(Q))\/bb(Q)\)$ induce a permutation $pi_eta$ on $"Hom"\(K\,overline(bb(Q))\)$, if $pi_eta$ is even, $pi_eta\(P\)= P\,pi_eta\(N\)= N$, if $pi_eta$ is odd, then $pi_eta$ swich $P\,N$, and $P + N\,P N$ are integral over $bb(Z)$, thus $P + N\,P N in bb(Z)$, hence $"disc"\(bb(O)_K\/bb(Z)\)equiv 0\,1 #h(0.444em) mod med 4$

]
#statement("Definition")[
For any nonzero ideal $I lt.eq cal(O)_K$, since $I inter bb(Z) = m bb(Z)$, $cal(O)_K\/m cal(O)_K tilde.equiv\(bb(Z)\/m bb(Z)\)^m arrow.r cal(O)_K\/I$ is surjective, hence the #emph[norm]#index-entry("Ideal norm") $N\(I\)=\|cal(O)_K\/I\|< oo$. The #emph[Dedekind zeta function]#index-entry("Dedekind zeta function") of an algebraic number field is $zeta_K\(s\)= sum_(I eq.not 0) frac(1, N\(I\)^s) = product_p frac(1, 1 - N\(p\)^(- s))$

]
#pagebreak(weak:true)
= Minkowski's theorem
<minkowskis-theorem>
#statement("Definition")[
$L = bb(Z) v_1 + dots.h.c + bb(Z) v_n lt.eq bb(R)^n$ is a lattice, $D = { c_1 v_1 + dots.h.c + c_n v_n\|0 lt.eq c_i lt.eq 1 }$ , the #emph[covolume] $"covol"\(L\)= "vol"\(bb(R)^n\/L\)= "vol"\(D\)$, $pi : D arrow.r bb(R)^n\/L$ is the quotient map, $"covol"\(L\)^2 = det\(chevron.l v_i\,v_j chevron.r\)$, $"covol"\(L\)= det\(v_1\,dots.h.c\,v_n\)$

]
#statement("Theorem")[
If $B subset.eq bb(R)^n$ is convex, symmetric (i.e. $B = - B$) subset such that either

+ $"vol"\(B\)> 2^n "covol"\(L\)$ or

+ $"vol"\(B\)gt.eq 2^n "covol"\(L\)$ and $B$ is compact

Then $\(B inter L\)\\{ 0 } eq.not diameter$

]
#proof(title: "Proof")[
+ $B arrow.r bb(R)^(2 n) arrow.r bb(R)^n\/2 L$ is not injective by comparing volume, there exist $x eq.not y in B$ such that $x - y in 2 L$, hence $0 eq.not 1 / 2\(x - y\)in B inter L$ since $B$ is convex and symmetric

+ By 1, $C_k = L inter\(1 + 1 / k\)B\\{ 0 } eq.not diameter$, $C_k$ is discrete and closed, $inter.big_(k = 1)^oo C_k eq.not diameter$, containing a limit point of $B$, but $B$ is closed

]
#statement("Proposition")[
$D_K = "disc"\(cal(O)_K\/bb(Z)\)in bb(Z)$

+ $cal(O)_K arrow.r.hook K_(bb(R))$ is a lattice

+ $"covol"\(cal(O)_K\)= 2^(- s) sqrt(\|D_K\|)$

+ If $I$ is an ideal of $cal(O)_K$, $"covol"\(I\)=\[cal(O)_K : I\]sqrt(\|D_K\|)$ (union of all members in the coset)

]
#proof(title: "Proof")[
+ $cal(O)_K$ is an additive group, only need to show $cal(O)_K inter B_r$ is finite. Let $f\(t\)= product\(t - sigma\(x\)\)$ be the minimal polynomial of $x in cal(O)_K inter B_r$, which has $bb(Z)$ coefficients and of degree no more than $\[K : bb(Q)\]$, $sigma$ are all the possible complex embeddings of $bb(Q)\[x\]$ which is a subset of ${ sigma_1\,dots.h.c\,sigma_n }$, thus #math.equation(block: true, numbering: none, $sum\|sigma_i\(x\)\|^2 lt.eq r arrow.r.double sum\|sigma_i sigma\(x\)\|^2 = sum\|sigma_i\(x\)\|^2 lt.eq r$) Hence the coefficients of $f$ are bounded, there are only finitely many choices of $f$

+ $beta_1\,dots.h.c\,beta_n$ is a $bb(Z)$-basis for $cal(O)_K$, the coordinate of $beta_i$ in $K_(bb(R))$ would be #math.equation(block: true, numbering: none, $\(sigma_1\(beta_i\)\,dots.h.c\,sigma_r\(beta_i\)\,"Re" sigma_(r + 1)\(beta_i\)\,"Im" sigma_(r + 1)\(beta_i\)\,dots.h.c\,"Re" sigma_(r + 1)\(beta_i\)\,"Im" sigma_(r + 1)\(beta_i\)\)^T$) With easy elementary row operations we have #math.equation(block: true, numbering: none, $det\(beta_1\,dots.h.c\,beta_n\)= (i / 2)^s det\(w_1\,dots.h.c\,w_n\)$)where $w_i in K_(bb(R))$ has coordinate #math.equation(block: true, numbering: none, $\(sigma_1\(beta_i\)\,dots.h.c\,sigma_r\(beta_i\)\,sigma_(r + 1)\(beta_i\)\,overline(sigma_(r + 1)\(beta_i\))\,dots.h.c\,sigma_(r + 1)\(beta_i\)\,overline(sigma_(r + 1)\(beta_i\))\)^T$)which is exactly $\(sigma_1\(beta_i\)\,dots.h.c\,sigma_n\(beta_i\)\)$. Therefore $"covol"\(cal(O)_K\)^2 = (i / 2)^(2 s) det\(M^T M\)$, $M =\(sigma_i\(beta_j\)\)$, thus $"covol"\(cal(O)_K\)^2 = 2^(- 2 s)\|D_K\|arrow.r.double "covol"\(cal(O)_K\)= 2^(- s) sqrt(\|D_K\|)$

]
#statement("Lemma")[
For $m gt.eq 1$, the number of ideals of $cal(O)_K$ of index less than $m$ is finite, if $\[cal(O)_K : I\]lt.eq m$, then $cal(O)_K\/I$ is killed by $m !$, thus $m ! cal(O)_K subset.eq I subset.eq cal(O)_K$, but $cal(O)_K\/m ! cal(O)_K tilde.equiv bb(Z)^n\/m ! bb(Z)^n tilde.equiv\(bb(Z)\/m !\)^n$ is finite

]
#statement("Theorem")[
For any $g in "Cl"\(cal(O)_K\)$, $exists I subset.eq cal(O)_K$ such that $N I =\[cal(O)_K : I\]lt.eq\(2 / pi\)^s sqrt(D_K) arrow.r.double "Cl"\(cal(O)_K\)$ is finite

]
#proof(title: "Proof")[
$J$ be an ideal representation for $g^(- 1)$, if $0 eq.not alpha in J$, then $0 eq.not\(alpha\)subset.eq J arrow.r.double exists I$ ideal of $cal(O)_K$ such that $\(alpha\)= I J$, so $I$ represents $g$, $N alpha = N I dot.op N J$, for $c =\(c_1\,dots.h.c\,c_r\,c_(r + 1)\,dots.h.c\,c_(r + s)\)$, $c_i > 0$ #math.equation(block: true, numbering: none, $B\(c\)= {\(x_1\,dots.h.c\,x_r\,x_(r + 1)\,dots.h.c\,x_(r + s)\)in bb(R)^r times bb(C)^s\|\|x_i\|lt.eq c_i }$) $"vol"\(B\(c\)\)=\(2 c_1\)dots.h.c\(2 c_r\)\(2 pi c_(r + 1)^2\)dots.h.c\(2 pi c_(r + s)^2\)= 2^n\(pi / 2\)^s c_1 dots.h.c c_r c_(r + 1)^2 dots.h.c c_(r + s)^2 = 2^n\(pi / 2\)^s xi$. Pick $c$ such that $"vol"\(B\(c\)\)= 2^n "covol"\(J\)$, by Minkowski's theorem, $B\(c\)inter J\\{ 0 } eq.not diameter$, pick $alpha in B\(c\)inter J\\{ 0 }$, $\|N\(alpha\)\|=\|sigma_1\(alpha\)\|dots.h.c\|sigma_n\(alpha\)\|lt.eq xi$, thus $N alpha = N I dot.op N J lt.eq xi =\(2 / pi\)^s "covol" J =\(2 / pi\)^s\[cal(O)_K : J\]sqrt(\|D_K\|)$, hence $N I lt.eq\(2 / pi\)^s sqrt(\|D_K\|)$

]
#pagebreak(weak:true)
= Dirichlet's unit theorem
<dirichlets-unit-theorem>
#statement("Proposition")[
For $alpha in cal(O)_K$, $alpha in cal(O)_K^times arrow.l.r.double N_(K\/bb(Q))\(alpha\)= plus.minus 1$

]
#proof(title: "Proof")[
Let $T_alpha$ be the $bb(Q)$-linear operator on $K$ by multiplying $alpha$. $f\(x\)= x^m + dots.h.c + a_(m - 1) x + a_m$ be the charateristic polynomial of $T_alpha$, $N alpha =\(- 1\)^m a_m$. If $N alpha = plus.minus 1$, then $g\(x\)= x^m + a_m^(- 1) a_(m - 1) x^(m - 1) + dots.h.c + a_m^(- 1) a_1 x + a_m^(- 1) in bb(Z)\[x\]$ has $alpha^(- 1)$ as a root, thus $alpha in cal(O)_K^times$. If $alpha in cal(O)_K^times$, there exists $beta in cal(O)_K^times$ such that $alpha beta = 1$, $"id" = T_alpha T_beta$, thus $1 = det T_alpha det T_beta = N alpha dot.op N beta arrow.r.double N alpha = plus.minus 1$

]
#statement("Lemma")[
The torsion subgroup of $cal(O)_K^times$ is $mu\(K\)$, the set of roots of unity in $K$ . $mu\(K\)$ is finite and hence cyclic

]
#proof(title: "Proof")[
$zeta_m in K arrow.r.double phi\(m\)\|\[K : bb(Q)\]$

]
#statement("Example")[
If $K arrow.r.hook bb(R)$, then $mu\(K\)= { plus.minus 1 }$. If $K = bb(Q)\(zeta_p\)$, then $mu\(K\)= { plus.minus 1 } times chevron.l zeta_p chevron.r$. If $K = bb(Q)\(sqrt(d)\)$, $d < 0$, then $zeta_m in K arrow.r.double phi\(m\)lt.eq 2 arrow.r.double m = 2\,3\,4\,6$

]
#statement("Example")[
$K = bb(Q)\(zeta_p\)$, $p divides.not r s$, then $frac(zeta^r - 1, zeta^s - 1) in bb(Z)\[zeta\]^times$

]
#statement("Proposition")[
$alpha in cal(O)_K$. $\|sigma\(alpha\)\|= 1$ for all embeddings $K arrow.r.hook^sigma bb(C) arrow.l.r.double alpha in mu\(K\)$

]#label("alpha in mu(K) <=> |sigma(alpha)|=1")
#proof(title: "Proof")[
Fix $C\,D > 0$ #math.equation(block: true, numbering: none, $E_(C\,D) = { beta in overline(bb(Z))\|deg\(beta\)lt.eq C\,\|sigma\(beta\)\|lt.eq D\,forall bb(Q)\(beta\)arrow.r.hook^sigma bb(C) }$) $f_beta\(x\)in bb(Z)\[x\]$ is the monic irreducible polynomial of $beta$. $deg f_beta lt.eq C arrow.r.double deg f_beta$ has finitely many choice and coefficients of $f_beta$ is bounded by function of $D$ $arrow.r.double$ finitely many choices for $f_beta$ $arrow.r.double$ $E_(C\,D)$ is finite. $alpha in E_(n\,1)$, $n =\[K : bb(Q)\]$, $alpha^2\,alpha^3\,dots.h.c in E_(n\,1) arrow.r.double alpha in mu\(K\)$ since $E_(n\,1)$ is finite, $alpha^n$ repeats. The other direction is obvious

]
#statement("Definition")[
Define #math.equation(block: true, numbering: none, $cal(L) :\(bb(R)^times\)^r times\(bb(C)^times\)^s & arrow.r bb(R)^(r + s)\
\(x_1\,dots.h.c\,x_(r + s)\) & mapsto\(log\|x_1\|\,dots.h.c\,log\|x_r\|\,2 log\|x_(r + 1)\|\,dots.h.c\,2 log\|x_(r + s)\|\)$) Note that #math.equation(block: true, numbering: none, $\|N_(K\/bb(Q))\(alpha\)\|= lr(|product sigma_i \( alpha \)|) =\|sigma_1\(alpha\)\|dots.h.c\|sigma_r\(alpha\)\|\|sigma_(r + 1)\(alpha\)\|^2 dots.h.c\|sigma_(r + s)\(alpha\)\|^2$)

]
#statement("Theorem")[
+ $ker cal(L) = mu\(K\)= "Tor"\(cal(O)_K^times\)$

+ $cal(L)\(cal(O)_K^times\)$ is a lattice in the hyperplane $H = { a_1 + dots.h.c + a_(r + s) = 0 }$

+ $cal(O)_K^times tilde.equiv bb(Z)^(r + s - 1) times mu\(K\)$, $cal(O)_K^times$ is finitely generated

]
#proof(title: "Proof")[
+ By Proposition #ref(label("alpha in mu(K) <=> |sigma(alpha)|=1"), supplement: none)

+ $bb(C) arrow.r^(\|dot.op\|) bb(R)_(> 0)$, $log : bb(R)_(> 0) arrow.r bb(R)$ are homomorphisms and homeomorphisms, and $bb(C)^times tilde.equiv U\(1\)times bb(R)^times$

  #align(center)[
  #align(center)[#set text(size:9pt)
  #diagram(spacing:(7mm,9mm),
  node((0,0),[$cal(O)_K^times$]),
  node((1,0),[$\(bb(R)^times\)^r times\(bb(C)^times\)^s$]),
  node((2,0),[$bb(R)^r times bb(R)^s$]),
  node((0,1),[$cal(O)_K$]),
  node((1,1),[$bb(R)^r times bb(C)^s$]),
  edge((0,0),(1,0),"hook->"),
  edge((0,0),(0,1),"hook->"),
  edge((1,0),(1,1),"hook->"),
  edge((1,0),(2,0),"hook->",[$cal(L)$]),
  edge((0,1),(1,1),"hook->"))]
  ]
  Thus additive group $cal(L)\(cal(O)_K^times\)$ is discrete in $bb(R)^r times bb(R)^s$ $arrow.r.double "rank"_(bb(Z)) cal(O)_K^times lt.eq r + s$. $cal(L)\(cal(O)_K^times\)subset.eq H$ is clear

]
#pagebreak(weak:true)
= Discrete valuation domain
<discrete-valuation-domain>
#statement("Definition")[
$A$ is a #emph[discrete valuation ring]#index-entry("Discrete valuation ring") if $A$ is an integrally closed PID with a unique nonzero prime ideal. $k = A\/m$, $m =\(pi\)$, $pi$ irreducible is unique up to $A^times$, called the #emph[uniformizer]#index-entry("Uniformizer"), $F = "Frac"\(A\)= A\[1 / pi\]$

]
#statement("Proposition")[
$A$ is a DVR, then $m^i - m^(i + 1) = A^times pi^i$, $A^times = A - m = union.sq.big_(i in bb(N)) A^times pi^i$, $F^times = union.sq.big_(i in bb(Z)) A^times pi^i$

#figure([#svg-drawing("<circle cx='220' cy='120' r='27'/><circle cx='220' cy='120' r='54'/><circle cx='220' cy='120' r='81'/><circle cx='220' cy='120' r='108'/><g fill='black' stroke='none' font-family='serif' font-size='14' text-anchor='middle'><text x='220' y='135'>⋮</text><text x='220' y='162'>m = A<tspan baseline-shift='super' font-size='10'>×</tspan>π</text><text x='220' y='190'>m<tspan baseline-shift='super' font-size='10'>0</tspan> = A<tspan baseline-shift='super' font-size='10'>×</tspan></text><text x='220' y='216'>m<tspan baseline-shift='super' font-size='10'>−1</tspan> = A<tspan baseline-shift='super' font-size='10'>×</tspan>/π</text><text x='220' y='245'>⋮</text></g>", width: 65%, height: 270)],
  caption: [
    Discrete Valuation Ring
  ]
)
<DVR>

]
#statement("Proposition")[
$X$ is a compact Riemann surface, $F = bb(C)\(X\)$, then $A = { f in F\|f upright(" is defined at ") x } subset.eq F$ is a DVR

]
#statement("Theorem")[
$"sgn" "disc"\(K\/bb(Q)\)=\(- 1\)^s$

]
#proof(title: "Proof")[
$"disc"\(K\/bb(Q)\)= det\("Tr"\(alpha_i alpha_j\)\)=\(det M\)^2$, $M =\(sigma_i\(alpha_j\)\)$, $overline(M) =\(overline(sigma_i\(alpha_j\))\)$, $det overline(M) =\(- 1\)^s det M$

]
#statement("Example")[
- $bb(Z)_(\(p\))$ with $pi = p$

- $bb(C)\[t\]_(\(t - a\))$ with $pi = t - a$

- $bb(R)\[t\]_(\(t - c\))$ with $pi = t - c$

- $bb(F)_p\[t\]_(\(t - c\))$ with $pi = t - c$

]
#statement("Definition")[
The additive valuation $nu : F arrow.r bb(Z) union { oo }$, $0 mapsto oo$, $u pi^i mapsto i$ satisfies

+ $nu\(x\)= oo arrow.l.r.double x = 0$

+ $nu\(x y\)= nu\(x\)+ nu\(y\)$

+ $nu\(x + y\)gt.eq min\(nu\(x\)\,nu\(u\)\)$

Any $nu$ on $F$ satisfying 1.-3. knows $A$, i.e. $A = { nu gt.eq 0 }$, $m = { nu > 0 }$, $A^times = { nu = 0 }$

]
#statement("Definition")[
$F$ is a field, a #emph[discrete valuation]#index-entry("Discrete valuation") on $F$ is a function $F arrow.r bb(R) union { oo }$ satisfying

+ $nu\(x\)= oo arrow.l.r.double x = 0$

+ $nu\(x y\)= nu\(x\)+ nu\(y\)$

+ $nu\(x + y\)gt.eq min\(nu\(x\)\,nu\(u\)\)$

$nu\(F^times\)subset.eq bb(R)$ is a lattice in $bb(R)$. $nu$ is normalized if $nu\(F^times\)= bb(Z)$ is the standard lattice

]
#statement("Remark")[
Given a normalized, discrete valuation, we get $A\,m\,A^times$ and $A$ is a DVR

]
#statement("Example")[
$"ord"_p : bb(Q) arrow.r bb(R) union { oo }$, $"ord"_p\(x\)= r$ if $x = p^r a / b$, $p divides.not a b$, then $A = { x in bb(Q)\|"ord"_p\(x\)gt.eq 0 } = bb(Z)_(\(p\))$, $m = p bb(Z)_(\(p\))$

]
#statement("Exercise")[
$A$ is a DVR with valuation $nu$

+ If $nu\(x\)eq.not nu\(y\)$, then $nu\(x + y\)= min\(nu\(x\)\,nu\(y\)\)$

+ If $x_1 + dots.h.c + x_n = 0$, $n gt.eq 2$, then $exists i eq.not j$ such that $nu\(x_i\)= nu\(x_j\)= min_(1 lt.eq k lt.eq n) nu\(x_k\)$

]
#statement("Definition")[
$R$ is a Noetherian domain, $K = "Frac"\(R\)$, a fractional ideal $I lt.eq K$ is a sub $R$-module such that $r I subset.eq R$ for some nonzero $r in R$, define $I^(- 1) = { x in K\|x I subset.eq R }$, a principal fractional ideal is $x R$ for some nonzeor $x in K$, clearly $I I^(- 1) subset.eq R$

]
#statement("Lemma")[
If $I\,J$ are fractional ideals, then so are $I^(- 1)\,I J\,I + J$

]
#statement("Proposition")[
$F$ is a field, discrete valuations are in bijective correspondence with DVR subrings of $F$

]
#statement("Definition")[
Consider $"Spv"\(R\)= { upright("All valuations on ") R }\/tilde.op$, and there is a topology given by $R\(f\/g\)= { nu in "Spv"\(R\)\|nu\(f\)lt.eq nu\(g\)eq.not 0 }$

]
Hilbert rings and adic spaces

#statement("Definition")[
$I$ is invertible $I I^(- 1) = R$

]
#statement("Example")[
$R = bb(C)\[x\,y\]$, $I =\(x\,y\)$, $I^(- 1) = bb(C)\[x\,y\]$

]
#statement("Proposition")[
+ If $I =\(f\)$, then $I^(- 1) =\(f^(- 1)\)$, hence principal fractional ideals are invertible

+ If $I$ is invertible, then $I$ is finitely generated as an $R$-module. $1 = sum_(i = 1)^n x_i y_i$, $x_i in I\,y_i in I^(- 1)$, so for any $r in I$, $r = tilde.op r x_i y_i = sum x_i\(r y_i\)$, hence $I$ is finitely generated by $x_1\,dots.h.c\,x_n$

+ $\(R\,m\)$ is a local ring, then $I$ invertible $arrow.r.double$ $I$ principal. $1 = sum_(i = 1)^n x_i y_i$, $x_i in I\,y_i in I^(- 1)$ are not all in $m$, say $x_1 y_1 in.not m$, then $x_1 y_1 = u$ is a unit, let $y'_1 = y_1 u^(- 1)$, then $1 = x_1 y'_1$, then $r in I arrow.r.double r = r x_1 y'_1 = x_1\(r y'_1\)$, thus $I =\(x_1\)$

+ $p$ is a prime of $R$, $\(R_p\,p R_p\)$ is a local ring, then $I$ fractional invertible $arrow.r.double$ $I R_p$ fractional invertible $arrow.r.double$ $I R_p$ principal

+ $I\,J$ invertible $arrow.r.double$ $I J$ invertible

]
#statement("Definition")[
The group of divisors $"Div"\(R\)$ is the set of invertible fractional ideals of $R$, this becomes an abelian group, $R$ is the neutral element. The set of principal fractional ideals is a subgroup of $"Div"\(R\)$, define the Picard group $"Pic"\(R\)= "Div"\(R\)\/{ upright("principal fractional ideals") }$

]
#statement("Proposition")[
If $R$ is a domain, $dim R = 1 arrow.l.r.double R$ is a field $arrow.l.r.double$ all primes are maximal. $R$ is a DVR $arrow.r.double dim R = 1$, $dim R\[t\]= 1 + dim R$

]
#statement("Proposition")[
Every prime in $cal(O)_K$ is maximal

]
#proof(title: "Proof")[
For any nonzero $alpha in p$, $0 eq.not N alpha in p inter bb(Z)$, $f\(x\)= x^n + a_(n - 1) x^(n - 1) + dots.h.c + a_0$ is the minimal polynomial of $alpha$, then $a_0 = - a_1 alpha - a_2 alpha^2 - dots.h.c - alpha^n in\(p\)$. Recall $N\(p\)=\[cal(O)_K : p\]=\|cal(O)_K\/p\|$ is finite, $cal(O)_K tilde.equiv bb(Z)^n$, thus $cal(O)_K\/p$ is a domain $arrow.r.double$ $cal(O)_K\/p$ is a field $arrow.r.double$ $p$ is maximal

]
#statement("Theorem")[
$R$ is a domain, then the following are equivalent

+ $R$ is Noetherian, normal, and $dim R = 1$

+ $R$ is Noetherian, $R_p$ is a DVR for any nonzero prime $p$

+ All fractional ideals of $R$ are invertible

Such a ring is called a #emph[Dedekind domain]#index-entry("Dedekind domain"). This is why DVR is sometimes called a local Dedekind domian. $cal(O)_K$ is a Dedekind domain

]
#statement("Theorem", title: [DVR recognition theorem])[
$\(R\,m\)$ is a local domain, the following are equivalent

+ $R$ is a DVR

+ $R$ is a PID

+ $R$ is Noetherian and $m$ is principal

+ $R$ is a Noetherian and $m$ is invertible

+ All fractional ideals are invertible

+ $R$ is Noetherian, normal and $dim R = 1$

]
#proof(title: "Proof")[
#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$\(1\)$]),
node((1,0),[$\(2\)$]),
node((2,0),[$\(3\)$]),
node((3,0),[$\(4\)$]),
node((0,1),[$\(6\)$]),
node((1,1),[$\(5\)$]),
edge((0,0),(0,1),"->"),
edge((0,0),(1,0),"->"),
edge((1,0),(1,1),"->"),
edge((1,0),(2,0),"->"),
edge((2,0),(3,0),"->"))]
]
is clear, here (2)$arrow.l.r.double$\(5) uses local rings + invertible fractional ideals $arrow.r.double$ principal

\(3)$arrow.r.double$\(1): $m =\(pi\)$, $N = inter_(i = 1)^oo m^i = inter_(i = 1)^oo pi^i R$, $N$ is finitely generated, $m N = N$, by Nakayama's lemma, $N = 0$. Thus for any $r in R$, $r in pi^n R - pi^(n + 1) R$ for some $n$, hence $R\\{ 0 } = union.sq_(n gt.eq 0) pi^n R^times$

\(6)$arrow.r.double$\(4): $K = "Frac"\(R\)$, need to show $1 in m m^(- 1)$

- Set $s\(m\)= { x in K\|x m subset.eq m }$, $R subset.eq s\(m\)subset.eq K$, $s\(m\)subset.eq "End"_R\(m\)arrow.r.double s\(m\)$ is integral over $R$ (Cayley-Hamilton). Since $R$ is normal, $s\(m\)= R$, i.e. $R$ is the largest subring of $K$ such that $m$ is an ideal

- $R subset.eq m^(- 1)$, $m subset.eq m m^(- 1) subset.eq R$, since $m$ is maximal, if $m m^(- 1) = R$ then we are done, otherwise $m = m m^(- 1) arrow.r.double m^(- 1) subset.eq s\(m\)= R arrow.r.double m^(- 1) = R$

- Consider $T = { I subset.eq R upright(" ideal")\|R subset.neq I^(- 1) } in.rev\(0\)= K$, since $R$ is Noetherian, $T$ has a maximal element $I$, $I subset.neq R subset.neq I^(- 1)$, claim $I$ is prime, then $I$ is maximal since $dim R = 1$, then $I = m$, $R subset.neq m^(- 1)$. Pf of claim: suppose $r\,s in R$, $r s in I$, $r in.not I$, let $J =\(r\)+ I subset.eq R$ is an ideal, then $I subset.neq J$, $J^(- 1) = R$, but $exists t in I^(- 1)\\R$, $t s J = t s\(r\)+ t s I subset.eq R$ $arrow.r.double t s in J^(- 1) = R$, thus $t\(\(s\)+ I\)subset.eq R$ $arrow.r.double t in\(\(s\)+ I\)^(- 1) - R$, thus $\(s\)+ I in I arrow.r.double s in I$ which is a contradiction

]
$R$ is a Noetherian ring, $X = "Spec" R$ or any scheme. Consider the category of projective modules, and the subcategory of rank $1$ projective $R$-modules. If $M$ is of rank $1$, $M times.o R_p tilde.equiv R_p$ as $R_p$ module, $M times.o M^(*) tilde.equiv R$, Picard category

#statement("Definition")[
The #emph[class group]#index-entry("Class group") is $"Cl"\(cal(O)_K\)= { upright("Fractional ideals")\/upright("Principal ideals") }$

]
#statement("Exercise")[
Every ideal in $cal(O)_K$ is generated by at most $2$ elements

]
#statement("Theorem")[
$R$ is a domain, the following are equivalent

+ $R$ is Noetherian, normal and $dim R = 1$

+ $R$ is Noetherian, $R_p$ is a DVR for any nonzero prime $p$

+ All nonzero fractional ideals are invertible

]
#proof(title: "Proof")[
\1.$arrow.r.double$2.: $R$ is Noetherian, so is $R_p$, $dim R_p lt.eq dim R$, there is a bijection between primes in $S^(- 1) R$ and primes in $R$ that doesn't intersect $S$, thus $dim R_p = 1$. Claim: $R$ normal $arrow.r.double$ $S^(- 1) R$ normal. If $x in "Frac" S^(- 1) R = K$ is normal and integral over $S^(- 1) R$, then $x^n + a_(n - 1) x^(n - 1) + dots.h.c + a_1 x + a_0 = 0$, $a_i in S^(- 1) R$, pick $s in S$, $s a_i in R$, then $\(s x\)^n + s a_(n - 1)\(s x\)^(n - 1) + dots.h.c + s^(n - 1) a_1\(s x\)+ s^n a_0 = 0$ $arrow.r.double$ $s x$ is integral over $R$ $arrow.r.double$ $s x in R$ $arrow.r.double$ $x in S^(- 1) R$

\2.$arrow.r.double$3.: $I subset.eq R$ is a nonzero fractional ideal, $I R_p subset.eq R_p$ is a nonzero fractional ideal, since $R_p$ is a DVR, $I R_p$ is invertible, $\(I R_p\)^(- 1) = I^(- 1) R_p$ is easy, $I I^(- 1) R_p =\(I R_p\)\(I^(- 1) R_p\)= R_p$, if $I I^(- 1) subset.neq R$, then $I I^(- 1) subset.eq p$ for some prime(maximal) $p$ $arrow.r.double I I^(- 1) R_p subset.eq p R_p$ which is a contradiction

\3.$arrow.r.double$1.: $0 eq.not I subset.eq R$ $arrow.r.double$ $I$ is invertible $arrow.r.double$ $I$ is a finitely genenrated $R$-module $arrow.r.double$ $R$ is Noetherian, $x in K$ integral over $R$, the subring $B = R\[x\]$ is a finitely generated $R$-module $arrow.r.double$ $B$ is a fractional ideal of $R$ $arrow.r.double$ $B$ is invertible, $B = B R = B B B^(- 1) = B B^(- 1) = R$ $arrow.r.double x in R$. $p eq.not 0$ is a prime in $R$, $p subset.neq m$ is maximal, then $m^(- 1) subset.eq p^(- 1) arrow.r.double p m^(- 1) subset.eq R = p p^(- 1)$, $p m m^(- 1) = p arrow.r.double p subset.eq m$ or $p subset.eq p m^(- 1)$ $arrow.r.double p supset.eq p m^(- 1) arrow.r.double m^(- 1) supset.eq R arrow.r.double m m^(- 1) subset.eq m arrow.r.double R subset.eq m$ which is a contradiction

]
#statement("Theorem")[
If $A$ is a Dedekind domain, then so is $B$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$E$]),
node((0,1),[$A$]),
node((1,1),[$F$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
]
#proof(title: "Proof")[
$B$ is normal, $B$ is a finitely generated $A$-module. $I subset.eq B$ is an ideal $arrow.r.double$ $I$ is a finitely generated $A$-module $arrow.r.double$ $I$ is a finitely generated $B$-module $arrow.r.double$ $B$ is Noetherian. Pick $p eq.not 0$ prime in $B$, $A inter p subset.eq A$ is prime, $A\/A inter p arrow.r.hook B\/p$. $0 eq.not alpha in p$, $alpha^n + a_(n - 1) alpha^(n - 1) + dots.h.c + a_0 = 0$, $a_i in A$ minimal so that $a_0 eq.not 0$, $0 eq.not a_0 in A inter p arrow.r.double A inter p$ is maximal, $k = A\/A inter p$, $B\/p$ is a $k$-algebra, finite dimensional vector space, $0 eq.not y in B\/p$, $B\/p arrow.r^(times y) B\/p$ is injective, this an isomorphism, hence $1 = y y^(- 1)$

$R$ is a Dedekind domain, $0 eq.not p$ maximal, $K = "Frac"\(R\)$, $R_p$ is a DVR with valuation $nu_p$, $a in K^times$, $a R_p = p^(nu_p\(a\)) R_p =\(p R_p\)^(nu_p\(a\))$. $I$ is a fractional ideal of $R$, $nu_p\(I\)= n$ if $I R_p = p^n R_p =\(p R_p\)^n$, $n in bb(Z)$, it is enough to check

- $nu_p\(I J\)= nu_p\(I\)+ nu_p\(J\)$

- $nu_p\(I + J\)= min { nu_p\(I\)\,nu_p\(J\)}$

- $nu_p\(I inter J\)= max { nu_p\(I\)\,nu_p\(J\)}$

- $I subset.eq J arrow.r.double nu_p\(J\)lt.eq nu_p\(I\)$

]
#statement("Example")[
$A = bb(C)\[t\]$, PID $arrow.r.double$ Dedekind domain, $F = bb(C)\(t\)$, $nu_oo : F arrow.r bb(Z) union { oo }$, $nu_oo\(0\)= oo$, $nu_oo\(f\/g\)= deg g - deg f$. Normalized valuations on $bb(C)\(t\)arrow.l.r bb(C P)^1$

]
#statement("Theorem")[
$A$ is a Dedekind domain, then any nonzero ideal $I$ can be written as a product of prime ideals in a unique way, thus $A$ is a UFD $arrow.l.r.double$ $A$ is a PID

]
#proof(title: "Proof")[
The abelian group of invertible ideals of $A$ is a free abelian group generated by $"Spec" A$. $I$ is a nonzero ideal, $I_0 = I$, if $I_(k - 1) = A$, then set $I_k = A$, otherwise, $exists p_k supset.eq I_(k - 1)$, set $I_k = p_k^(- 1) I_(k - 1)$, then $I_(k - 1) subset.eq I_k subset.eq A$. Since $I_(k - 1) subset.neq A$, $I_(k - 1) subset.neq I_k$, $I = I_0 subset.neq I_1 subset.neq dots.h.c subset.neq I_(n - 1) subset.neq I_n = A = dots.h.c$, so $I_0 = p_1 dots.h.c p_n I n = p_1 dots.h.c p_n$. For fractional ideal $I$, $a I subset.eq A$, $a I = dots.h.c$ and $\(a\)= dots.h.c$ $arrow.r.double$ $I = dots.h.c$

Uniqueness: $q in "Spec" A$, $q_1\,dots.h.c\,q_s eq.not q$, $q + q_i = A$, $\(q + q_1\)^(f_1) dots.h.c\(q + q_s\)^(f_s) = A arrow.r.double q + q_1^(f_1) dots.h.c q_s^(f_s) = A$, $f_i gt.eq 0 arrow.r.double q_1^(f_1) dots.h.c q_s^(f_s) A_q$ is not in $q A_(q_1)$ thus not in $A_q$ $arrow.r.double 0 = nu_q\(q_1^(f_1) dots.h.c q_s^(f_s)\)arrow.r.double nu_q\(q^(f_0) q_1^(f_1) dots.h.c q_s^(f_s)\)= f_0 = nu_q\(q^(f_0)\)$

]
#statement("Remark")[
#math.equation(block: true, numbering: none, $1 arrow.r A^times arrow.r F^times arrow.r^(xor nu_p) xor.big_(p in "Spec" A) bb(Z) arrow.r "Cl"\(A\)arrow.r 0$) #math.equation(block: true, numbering: none, $dots.h.c arrow.r K_1\(A\)arrow.r K_1\(F\)arrow.r xor.big_(p in "Spec" A) K_0\(A\/p\)arrow.r dots.h.c$) is the localization sequence in K-theory

]
#statement("Lemma")[
$A$ is a Dedekind domain, $"Spec" A$ has closed points and a unique generic point $\(0\)$

]
#statement("Example")[
$A = bb(C)\[x\]$ is a PID, $F = bb(C)\(x\)$, $"Cl"\(A\)$ is trivial

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B = frac(bb(C)\[x\,y\], \(y^2 - x^3 - 1\))$]),
node((1,0),[$frac(bb(C)\(x\)\[y\], \(y^2 - x^3 - 1\))$]),
node((0,1),[$A = bb(C)\[x\]$]),
node((1,1),[$F = bb(C)\(x\)$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
$"Cl"\(B\)$ is uncountable, $bb(C)^2\/Gamma$

]
#pagebreak(weak:true)
= Ramification
<ramification>
#statement("Definition")[
$A\,B$ are Dedekind domains, $F\,E$ are fractional field

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$B$]),
node((1,0),[$E$]),
node((0,1),[$A$]),
node((1,1),[$F$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
$beta in B$ is maximal $arrow.r.double$ $beta inter A$ is maximal in $A$. $p B = beta_1^(e_1) dots.h.c beta_r^(e_r)$, $e_i > 0$. $k_p = A\/p arrow.r B\/beta = k_beta$, $B$ is a finitely generated $A$-module, $B\/beta$ is a finitely generated $k_p$ vector space, $f_i =\[k_beta : k_p\]$

- $p$ is #emph[ramified] if $e_i > 1$ for some $i$

- $p$ is #emph[inert] if $p B$ is a prime

- $p$ #emph[total split] if $e_i = 1\,f_i = 1$

]
#statement("Proposition")[
Suppose $p B = beta_1^(e_1) dots.h.c beta_r^(e_r)$, $e_i > 0$

+ $B\/p B tilde.equiv product_(i = 1)^r B\/beta_i^(e_i)$

+ $\[E : F\]= dim_(k_p)\(B\/p B\)= sum_(i = 1)^r e_i f_i arrow.r.double r lt.eq\[E : F\]$, (totally split $arrow.l.r.double$ \"$=$\")

]
#proof(title: "Proof")[
+ Chinese remainder theorem

+ If $B tilde.equiv A^n$, then $B\/p B tilde.equiv A^n p A^n tilde.equiv\(A\/p\)^n tilde.equiv k_p^n$

]
#statement("Example")[
$2 bb(Z)\[i\]=\(1 + i\)^2$ is ramified, $3 bb(Z)\[i\]$ is prime inert, $5 bb(Z)\[i\]=\(2 - i\)\(2 + i\)$ totally split

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$bb(Z)\[i\]$]),
node((1,0),[$bb(Q)\[i\]$]),
node((0,1),[$bb(Z)$]),
node((1,1),[$bb(Q)$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
]
#statement("Example")[
$f : "Spec" B arrow.r "Spec" A$, $f\(beta\)= beta inter A$, If $p B = beta_1^(e_1) dots.h.c beta_r^(e_r)$, then $f^(- 1)\(p\)= T_p = { beta_1\,dots.h.c\,beta_r }$. If $beta inter A = p$, then $beta supset.eq p B = beta_1^(e_1) dots.h.c beta_r^(e_r)$, since $beta$, $beta_i$ are maximal, $beta = beta_i$ for some $i$. $p B subset.eq beta_i arrow.r.double p B inter A = p subset.eq beta_i inter A arrow.r.double beta_i inter A = p$

#align(center)[
#svg-drawing("<path d='M60 60C100 40 100 60 140 60C220 60 240 90 300 120C320 135 340 160 380 180M60 120C100 135 110 150 140 150C170 150 180 180 220 180C260 180 260 130 300 120C330 100 350 80 380 60M60 180C100 160 100 155 140 150C220 135 220 120 300 120C340 120 360 120 380 120M60 240H380'/><path d='M140 60V240M300 120V240' stroke-dasharray='4 3'/>", height: 270)
]
In general, $A_p$ is a DVR $arrow.r.double$ PID, $A_p\/p A_p tilde.equiv A\/p tilde.equiv k_p$, $B_p = B times.o_A A_p$ is torsion free since $B_p subset.eq E$, $B_p$ is finitely generated and torsion free over PID $A_p$ $arrow.r.double B_p tilde.equiv A_p^n arrow.r.double B_p\/p B_p tilde.equiv\(A_p\/p A_p\)tilde.equiv k_p^n$

]
#statement("Theorem")[
If $E\/F$ is Galois, then $G = "Gal"\(E\/F\)$ acts on $f^(- 1)\(p\)= { beta_1\,dots.h.c\,beta_r }$ transitively, thus $n = sum_(i = 1)^r e_i f_i = r e f$, $e\,f\,r\|n$

]
#proof(title: "Proof")[
For any $sigma in G$, $f\(beta\)= f\(sigma\(beta\)\)$, preserving $e_i\,f_i$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$k_p$]),
node((1,0),[$B\/beta$]),
node((0,1),[$k_p$]),
node((1,1),[$B\/sigma\(beta\)$]),
edge((0,0),(1,0),"hook->"),
edge((0,0),(0,1),"="),
edge((1,0),(1,1),"->",[$sigma$]),
edge((0,1),(1,1),"hook->"))]
]
Suppose $beta\,beta'$ are not related by $G$, then $exists x in B$ such that #math.equation(block: true, numbering: none, $x equiv cases(1 #h(0.444em) mod med sigma beta quad forall sigma in G, 0 #h(0.444em) mod med tau beta' quad forall tau in G)$) Thus #math.equation(block: true, numbering: none, $A in.rev N_(B\/A)\(x\)= N_(E\/F)\(x\)= product_(sigma in G) sigma\(x\)equiv cases(1 #h(0.444em) mod med sigma beta, 0 #h(0.444em) mod med sigma beta')\
arrow.r.double N_(B\/A)\(x\)equiv cases(0 #h(0.444em) mod med sigma beta inter A = p, 1 #h(0.444em) mod med sigma beta' inter A = p)$) Fix $beta$, define $D_beta = { sigma in G\|sigma beta = beta }$, $D_(tau\(beta\)) = tau D_beta tau^(- 1)$, $\|D_beta\|= e f$. $p$ totally splits in $B$ $arrow.l.r.double$ $D_beta = { 1 }$ for any $beta$

If $G$ is abelian, $D_beta$ depends only on $p$, not $beta$ since $tau D_beta tau^(- 1) = D_beta$

#align(center)[
#align(center)[#set text(size:7pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$0$]),
node((1,0),[$beta$]),
node((2,0),[$B$]),
node((3,0),[$k_beta$]),
node((4,0),[$0$]),
node((0,1),[$0$]),
node((1,1),[$sigma beta$]),
node((2,1),[$B$]),
node((3,1),[$k_(sigma beta)$]),
node((4,1),[$0$]),
edge((0,0),(1,0),"->"),
edge((1,0),(2,0),"->"),
edge((1,0),(1,1),"->"),
edge((2,0),(3,0),"->"),
edge((2,0),(2,1),"->",[$sigma$]),
edge((3,0),(4,0),"->"),
edge((3,0),(3,1),"->"),
edge((0,1),(1,1),"->"),
edge((1,1),(2,1),"->"),
edge((2,1),(3,1),"->"),
edge((3,1),(4,1),"->"))]
]
If $sigma in D_beta$, $k_beta arrow.r k_beta$ is an automorphism $arrow.r.double D_beta arrow.r "Aut"\(k_beta\/k_p\)$ $arrow.r.double ker = I_beta$, the inertia group of $beta$, $I_(tau beta) = tau I_beta tau^(- 1)$

]
#statement("Theorem")[
$p$ ramifies in $cal(O)_K$ $arrow.l.r.double$ $p\|"disc"\(cal(O)_K\/bb(Z)\)$

]
#pagebreak(weak:true)
#pagebreak(weak:true)

#pagebreak()
#heading(numbering:none)[References]


#pagebreak()
#heading(numbering:none)[Index]
#index-list()
