#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Commutative algebra

== Commutative ring
<commutative-ring>
#statement("Proposition")[
$I\,J subset.eq A$ are ideals, $P subset A$ is a prime ideal, then

+ $I J subset.eq P arrow.r.double I subset.eq P$ or $J subset.eq P$

+ $I subset.eq sqrt(J) arrow.r.double sqrt(I) subset.eq sqrt(J)$

]
#proof(title: "Proof")[

]
#statement("Definition")[
$S subset.eq R$ is #emph[multiplictive closed], the localization $S^(- 1) R$ of $R$ with respect to $S$ is $R times S\/tilde.op$, $\(r\,s\)tilde.op\(r'\,s'\)$ iff there exists $t in S$ such that $t\(r s' - s r\)= 0$. $S^(- 1) R$ has the universal property that for any $f : R arrow.r T$ such that maps $S$ to units, then there exists a unique $g : S^(- 1) R arrow.r T$ such that $g i = f$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$R$]),
node((1,0),[$S^(- 1) R$]),
node((1,1),[$T$]),
edge((0,0),(1,1),"->",[$f$]),
edge((0,0),(1,0),"->",[$i$]),
edge((1,0),(1,1),"->",[$exists_1 g$],stroke:(dash:"dashed")))]
]
]
#statement("Definition")[
Given a ring $R$ and a proper ideal $I$, we can define an #emph[associated graded ring]#index-entry("Associated graded ring") $g r_I R := xor.big_(n = 0)^oo I^n\/I^(n + 1)$, if $M$ is a left $R$-module, we can define #emph[associated graded module]#index-entry("Associated graded module") $g r_I M := xor.big_(n = 0)^oo I^n M\/I^(n + 1) M$

]
#statement("Definition")[
$R$ is a #emph[local ring]#index-entry("Local ring") if it has a unique maximal ideal $m$. The #emph[residue field]#index-entry("Residue field") is $k = R\/m$

]
#statement("Definition")[
$R$ is a #emph[semilocal ring]#index-entry("Semilocal ring") if it has only finitely many maximal ideal

]
#statement("Proposition")[
Let $R$ be a UFD, $f$ a prime element, then $h t\(f\)= 1$

]
#proof(title: "Proof")[
Suppose there exists prime ideal $P$ such that $0 subset.neq P subset.neq\(f\)$, then we can find a prime element in $g in P$, thus we have $0 subset.neq\(g\)subset.eq P subset.neq\(f\)$, but then $g = f h$ for some $h$, but since $f$ is prime, thus $\(f\)=\(g\)$ which is a contradiction, such a prime element exists since we can pick any element $0 eq.not q = q_1 dots.h.c q_m in P$ where $q_i$'s are prime, but then at least one of them has to be in $P$

]
#statement("Theorem")[
Let $A subset.eq B$ be finitely generated $k$-algebras, and $A\,B$ are both domains, $0 eq.not b in B arrow.r.double exists 0 eq.not a in A$ such that for any $k$-algebra homomorphism $alpha : A arrow.r k$ with $alpha\(a\)eq.not 0$ can be extended to $k$-algebra homomorphism $beta : B arrow.r k$ with $beta\(b\)eq.not 0$

]
#statement("Definition")[
Suppose $R$ is a commutative ring with identity, a prime element#index-entry("Prime element") $p in R$ is an element which is nonzero nor a unit and $p\|f g arrow.r.double p\|f$ or $p\|g$

]
#statement("Definition")[
A #emph[graded ring]#index-entry("Graded ring") $R$ is a ring such that $R = xor.big_i R_i$ is a direct sum of abelian groups and $R_i R_j subset.eq R_(i + j)$

An ideal is called a #emph[homogeneous ideal]#index-entry("Homogeneous ideal") if it consists of only homogeneous elements

]
#statement("Theorem", title: [Chinese remainder theorem])[
#index-entry("Chinese remainder theorem") Let $R$ be a commutative ring, and $I_1\,dots.h.c\,I_n lt.eq R$ be pairwise coprime ideals, then $R tilde.equiv R\/I_1 times dots.h.c R\/I_n\,r mapsto\(r #h(0.444em) mod med I_1\,dots.h.c\,r #h(0.444em) mod med I_n\)$

]#label("Chinese remainder theorem")
#statement("Definition")[
An #emph[integral domain]#index-entry("Integral domain") is a commutative ring $R$ such that $\(0\)$ is a prime ideal. Equivalently, $r s in R arrow.r.double$ $r in R$ or $s in R$

]
#statement("Definition")[
Suppose $R$ is a domain, $K$ is the field of fractions, a #emph[fractional ideal]#index-entry("Fractional ideal") is an $R$ submodule $I lt.eq K$ such that $r I subset.eq R$ for some nonzero $r in R$. $I$ is invertible if $I J = R$ for some other fractional ideal $J$

]
#statement("Definition")[
A #emph[Dedekind domain]#index-entry("Dedekind domain") is an integral domain such that every proper ideal is a product of prime ideal

]
#statement("Definition")[
A #emph[discrete valuation ring(DVR)]#index-entry("Discrete valuation ring(DVR)") is a PID with a unique nonzero prime ideal

]
#statement("Definition")[
A local ring homomorphism $phi.alt : R arrow.r S$ between local rings is such that $phi.alt\(m_R\)subset.eq m_S$

]
#statement("Definition")[
$R$ is a commutative ring. An $R$-#emph[linear category]#index-entry("R-linear category") $cal(C)$ is a category enriched over $R$-modules, i.e. $"Hom"\(A\,B\)$ are $R$-modules, $"Hom"\(B\,C\)times.o_R "Hom"\(A\,B\)arrow.r "Hom"\(A\,C\)$ is $R$-bilinear

]
#statement("Definition")[
A unital associative $R$-algebra $A$ is a monoid in the monoidal category of $R$-modules, coalgebras are comonoids

]
#statement("Definition")[
Commutative ring $R$ is a preadditive category with a single object $bullet$. An $R$-#emph[algebra]#index-entry("R algebra") is an additive functor $phi.alt in R^(upright(R M o d))$, write $phi.alt\(bullet\)= S$, $phi.alt\(r\)s = r s$. A ring $A$ is an $R$ #emph[algebra]#index-entry("R algebra") is a ring homomorphism $R arrow.r^phi.alt A$, $r a = phi.alt\(r\)a$

]
#statement("Definition")[
A #emph[coalgebra]#index-entry("Coalgebra") is the categorical dual to a unital associative algebra

]
#statement("Definition")[
$A$ is #emph[finite] or $phi.alt$ is #emph[finite]#index-entry("Finite ring homomorphism") if $A$ is a finitely generated $R$ module

$phi.alt$ is of #emph[finite type]#index-entry("Finite type ring homomorphism") if $A$ is #emph[finitely generated] $R$ algebra

]
#statement("Definition")[
For $p in "Spec" A$, $q in "Spec" B$, $A subset.eq B$, $p$ #emph[lies under] $q$ or $q$ #emph[lies over] $p$ if $q inter A = p$ $A subset.eq B$ satisfies #emph[lying over property] if every $p in "Spec" A$ lies under some $q in "Spec" B$

$A subset.eq B$ satisfies the #emph[incomparability property] if different prime ideals $q\,q'$ both lie over $p$ are incomparable, i.e. they don't contain each other

$A subset.eq B$ satisfies #emph[going up property] if for any chain of prime ideals $p_1 subset.eq dots.h.c subset.eq p_n$, $q_1 subset.eq dots.h.c subset.eq q_m$ with $q_i$ lies over $p_i$ and $m < n$ can be extended to a chain of prime ideals $q_1 subset.eq dots.h.c subset.eq q_n$ with $q_i$ lies over $p_i$

$A subset.eq B$ satisfies #emph[going down property] if for any chain of prime ideals $p_1 supset.eq dots.h.c supset.eq p_n$, $q_1 supset.eq dots.h.c supset.eq q_m$ with $q_i$ lies over $p_i$ and $m < n$ can be extended to a chain of prime ideals $q_1 supset.eq dots.h.c supset.eq q_n$ with $q_i$ lies over $p_i$

]
#statement("Definition")[
$R subset.eq S$ are commutative rings, $a in S$ is #emph[integral]#index-entry("Integral element") over $R$ if it is a root of some monic polynomial in $R\[x\]$. The #emph[integral closure] of $R$ in $S$ are the integral elements of $S$

]
#statement("Theorem")[
$B$ is integral over $A$, then $A subset.eq B$ satisfies going up property and incomparability property

]#label("Going up and Going down theorems")
#statement("Lemma", title: [Noether's normalization lemma])[
$A$ is a finitely generated $k$ algebra, then there exists algebraically independent elements $x_1\,dots.h.c\,x_d in A$ such that $A$ is a finite $k\[x_1\,dots.h.c\,x_d\]$ algebra

]#label("Noether's normalization lemma")
#statement("Definition")[
The #emph[height] of prime ideal $p$ is $"ht" p = sup_d p_0 subset.neq dots.h.c subset.neq p_d = p$. The #emph[Krull dimension]#index-entry("Krull dimension") of a ring $R$ is $dim R = sup_d p_0 subset.neq dots.h.c subset.neq p_d = sup_p "ht" p$, $p_i$ are prime ideals

]
#statement("Theorem", title: [Krull's height theorem])[
$R$ is Noetherian, $I$ is an ideal which can be generated by $n$ elements, then the minimal prime over $I$ is of height at most $n$

]
#statement("Definition")[
A local ring $R$ is #emph[regular] if $dim R = dim_k m\/m^2$

]
#statement("Proposition")[
$A$ is a integral domain, finitely generated over some subfield $k$, then $dim A = upright(t r d e g)\(upright(F r a c) A\/k\)$

]
#statement("Definition")[
A #emph[finitely presented algebra]#index-entry("Finitely presented algebra") over $R$ is of the form $R\[x_1\,dots.h.c\,x_n\]\/I$, $I$ is a finitely generated ideal

]
#statement("Definition")[
$R$ is a commutative ring. Elements in $W\(R\)= 1 + t R\[\[t\]\]$ can be factored #display-equation($sum_(n = 0)^oo A_n t^n = product_(n = 1)^oo\(1 - X_n t^n\)= f_X\(t\)$) #display-equation($A_n = sum_I\(- 1\)^(\|I\|) product_(i in I) X_i$) $I$ runs over subsets of ${ 1\,dots.h.c\,n }$ that add up to $n$. $X =\(X_1\,X_2\,dots.h.c\)$ are #emph[Witt vectors]#index-entry("Witt vector"). #emph[Witt polynomials]#index-entry("Witt polynomials")\(ghost components) are #display-equation($W_n = X^(\(n\)) = sum_(d\|n) d X_d^(n / d)$) The #emph[Witt ring]#index-entry("Witt ring") is the ring of Witt vectors with addtion and multiplication defined by #display-equation($\(X + Y\)^(\(n\)) = X^(\(n\)) + Y^(\(n\))\,\(X Y\)^(\(n\)) = X^(\(n\)) Y^(\(n\))$) $1 - t$ is the multiplicative identity. Notice #display-equation($- t frac(d, d t) log f_X\(t\) & = sum_(d gt.eq 1) frac(d X_d t^d, 1 - X_d t^d)\
 & = sum_(d gt.eq 1) d X_d t^d sum_(i gt.eq 0) X_d^i t^(d i)\
 & = sum_(d gt.eq 1) sum_(i gt.eq 1) d X_d^i t^(d i)\
 & = sum_(n gt.eq 1) X^(\(n\)) t^n$) $Z = X + Y arrow.l.r.double f_Z\(t\)= f_X\(t\)f_Y\(t\)$ since #display-equation($sum_(n gt.eq 1) Z^(\(n\)) t^n & = - t frac(d, d t) log f_Z\(t\)\
 & = - t frac(d, d t) log f_X\(t\)- t frac(d, d t) log f_X\(t\)\
 & = sum_(n gt.eq 1) X^(\(n\)) t^n + sum_(n gt.eq 1) Y^(\(n\)) t^n$) Since $A_j$ are polynomials in $X_i$'s, $B_j$ are polynomials in $Y_i$'s, we can show that by induction #display-equation($Z_n = C_j - sum_(I eq.not { n })\(- 1\)^(\|I\|) product_(i in I) Z_i = sum_(k + l = j) A_k B_l - sum_(I eq.not { n })\(- 1\)^(\|I\|) product_(i in I) Z_i$) are polynomials in $X_i\,Y_i$'s \ If $Z = X Y$, then . In particular, consider $Y =\(r\,0\,dots.h.c\)$, $f_Z\(t\)= f_X\(r t\)$

]
#statement("Definition")[
A commutative ring $R$ is a $lambda$ #emph[ring]#index-entry("\\lambda ring") if it has $lambda$ operations $lambda^k$ satisfying

- $lambda^0\(x\)= 1$

- $lambda^1\(x\)= x$

- $lambda^k\(x + y\)= sum_(i = 0)^k lambda^i\(x\)lambda^(k - i)\(y\)$

The last of which is equivalent to a group homomorphism #display-equation($lambda_t : R & arrow.r W\(R\)= 1 + t R\[\[t\]\]\
x & mapsto sum lambda^k\(x\)t^k$)An $lambda$ ideal is an ideal $I lt.eq R$ such that $lambda^k\(I\)subset.eq I$ for any $k$. A #emph[special] $lambda$ #emph[ring]#index-entry("Special \\lambda ring") is a $lambda$ ring such that #display-equation($lambda^k\(1\) & = 0\,k > 2\
lambda^k\(x y\) & = P_k\(lambda^1\(x\)\,dots.h.c\,lambda^k\(x\)\,lambda^1\(y\)\,dots.h.c\,lambda^k\(y\)\)\
lambda^n\(lambda^k\(x\)\) & = P_(n\,k)\(lambda^1\(x\)\,dots.h.c\,lambda^(n k)\(x\)\)$) $P_n\,P_(n\,k)$ are defined through #display-equation($sum P_(n\,k)\(s_1\(X\)\,dots.h.c\,s_(n k)\(X\)\)t^n = product_(1 lt.eq X_(i_1) lt.eq dots.h.c lt.eq X_(i_n) lt.eq n k)\(1 + t X_(i_1) dots.h.c X_(i_n)\)$) #display-equation($sum P_n\(s_1\(X\)\,dots.h.c\,s_n\(X\)\,s_1\(Y\)\,dots.h.c\,s_n\(Y\)\)t^n = product_(i\,j = 1)^n\(1 + t X_i X_j\)$) $s_i$'s are elementary symmetric polynomials

]
#statement("Example")[
A binomial ring is a $bb(Q)$ algebra $R$ with $lambda_t\(x\)=\(1 + t\)^x$, $lambda^k\(x\)= binom(x, k) = frac(x\(x - 1\)dots.h.c\(x - k + 1\), k !)$

]
#statement("Example")[
$R$ is a semiring. $K_0\(R\)$ is a $lambda$ ring with $lambda^k\(P\)= and.big^k P$

]
#statement("Definition")[
$R arrow.r^epsilon bb(Z)$ is the augmentation. The Adams operation $psi$ is defined by #display-equation($psi_t\(x\)= sum psi^k\(x\)t^k = epsilon\(x\)- t frac(d, d t) log lambda_(- t)\(x\)$)

]
#statement("Example")[
Vector bundles and representation are $lambda$ semirings with augmentation $dim$

]
#statement("Proposition")[
If $R$ satisfies splitting principle, then $psi^k$'s are endomorphisms of $R$ and $psi^j psi^k = psi^(j k)$

]
#statement("Definition")[
Let $s = frac(t, 1 - t)$, then $t = frac(s, 1 + s)$, $R\[\[t\]\]= R\[\[s\]\]$. The $gamma$ operation is defined by #display-equation($gamma_t\(x\)= sum gamma^k\(x\)t^k = sum lambda^k\(x\)s^k = lambda_s\(x\)$)

]
#statement("Example")[
$gamma^k\(x\)= lambda^k\(x + k - 1\)= binom(x + k - 1, k) =\(- 1\)^k binom(- x, k)$

]
#statement("Definition")[
The $gamma$ dimension $dim_gamma x$ is the greatest integer $k$ such that $gamma^k\(x - epsilon\(x\)\)eq.not 0$, $dim_gamma R = sup_x dim_gamma x$. The $gamma$ filtration is #display-equation($R = F_gamma^0 R supset.eq F_gamma^1 R supset.eq dots.h.c$) Here $F_gamma^1 R = ker epsilon$, $F_gamma^k R$ is the ideal generated by products $gamma^(i_1)\(x\)dots.h.c gamma^(i_m)\(x\)$ whereas $sum i_j gt.eq k$, $x_j in F_gamma^1 R$

]
#statement("Definition")[
A #emph[discrete valuation] on a field $F$ is $v : F arrow.r bb(Z) union { oo }$ satisfying

+ $v\(x\)= oo arrow.l.r.double x = 0$

+ $v\(x + y\)gt.eq min\(v\(x\)\,v\(y\)\)$, equality holds iff $v\(x\)eq.not v\(y\)$

+ $v\(x y\)= v\(x\)+ v\(y\)$

A valuation is when replacing $bb(Z)$ by some totally ordered abelian group(called the value group). $v$ is trivial if $v\(F^times\)= 0$

]
#statement("Definition")[
A #emph[discrete valuation ring] is an integral domain $R$ with a discretely valued fraction field $F = "Frac"\(R\)$ such that $R = { x in F\|v\(x\)gt.eq 0 }$. In this case $m = { x in F\|v\(x\)> 0 }$ is the unique prime ideal in $R$, and $m =\(pi\)$, we call $pi$ the #emph[uniformizer], and for $x in F$, $v\(x\)$ is the maximal power of $pi$ in $a$.

]
#statement("Definition")[
Pick some $0 < c < 1$, we can define norm $\|dot.op\|: F arrow.r bb(R)_(gt.eq 0)$ as $\|x\|= c^(v\(x\))$, this defines a metric topology(which can be shown to be independent of the choice of $c$)

]
#statement("Example")[
$bb(Z)_(\(p\)) subset.eq bb(Q)$ with the $p$-adic valuation, $c = p^(- 1)$

]
#statement("Definition")[
By completing the metric topology, we obtain a complete discretely valued field $hat(F)$ with extended norm $\|dot.op\|$, and the closure of $R$ in $F$ is denoted by $hat(R)$ which can be proven is $hat(R) = lim_arrow.l R\/m^n$

]
#statement("Example")[
$k\[t\]_(\(t\)) subset.eq k\(t\)$ with $t$-adic valuation, $accent(k\(t\), ̂) = k\(\(t\)\)$ is the field of formal Laurent series, $accent(k\[t\]_(\(t\)), ̂) = k\[\[t\]\]$ is the ring of formal power series

]
#statement("Definition")[
$V subset.eq bb(A)^n$ is an algebraic set, $f in k\[V\]$ #display-equation($D\(f\)= {\(x_1\,dots.h.c\,x_n\)in V\|f\(x_1\,dots.h.c\,x_n\)eq.not 0 } = V\(f\)^c$) form a basis for the Zariski topology on $V$

$D\(f\)$ can also be thought of as an algebraic set #display-equation(${\( x_1 \, dots.h.c \, x_n \, z \) mid(bar.v) z f \( x_1 \, dots.h.c \, x_n \) = 0}$) The coordinate ring can be written as $k\[V\]\[1 / f\]= k\[V\]_f$, where $z$ is just replaced by $1 / f$

]
#statement("Theorem")[
$sqrt(I) = inter.big_(P supset.eq I upright(" prime")) P$

]
#statement("Theorem", title: [Hilbert Nullstellensatz weak form])[
$k$ is algebraically closed, $m < k\[x_1\,dots.h.c\,x_n\]$ is a maximal ideal, then $k\[x\]\/m tilde.equiv k$

]#label("Hilbert Nullstellensatz weak form")
#statement("Theorem", title: [Hilbert Nullstellensatz strong form])[
$k$ is algebraically closed, $I\(V\(J\)\)= sqrt(J)$

]
#proof(title: "Proof")[
Since $sqrt(J) = inter.big_(P supset.eq J upright(" prime")) P$, suppose $f in.not P$ for some $P supset.eq J$, consider $phi : k\[x\]arrow.r k\[x\]\/P arrow.r A_(overline(f)) arrow.r A_(overline(f))\/m$ which is a field, hence $ker phi$ is a maximal ideal, by Theorem #ref(label("Hilbert Nullstellensatz weak form"), supplement: none), $B\/m tilde.equiv k\[x\]\/ker phi tilde.equiv k$, then $\(phi\(x_1\)\,dots.h.c\,phi\(x_n\)\)in V\(P\)subset.eq V\(J\)$ but $f\(phi\(x_1\)\,dots.h.c\,phi\(x_n\)\)= phi\(f\)eq.not 0 arrow.r.double f in.not I\(V\(J\)\)$

]
#statement("Proposition")[
Morphism $V arrow.r^phi W$ induce a ring homomorphism $k\[W\]arrow.r^(phi^(*)) k\[V\]\,f mapsto f compose phi$, and if $f\(p\)= q$, then $\(phi^(*)\)^(- 1)\(m_q\)= m_p$, thus conversely, if $alpha : k\[W\]arrow.r k\[V\]$ is a ring homomorphism, then $alpha^(- 1) : S p m k\[V\]arrow.r S p m\[W\]$ is a morphism which can be identified with $phi : V arrow.r W$, and $phi^(*) = alpha$

]
#statement("Proposition")[
A finite morphism $V arrow.r^phi W$ between affine varieties is quasifinite

]
#proof(title: "Proof")[
$phi\(p\)= q arrow.l.r.double\(phi^(*)\)^(- 1)\(m_p\)= q$, $m_p supset.eq phi^(*)\(phi^(*)\)^(- 1)\(m_p\)= phi^(*)\(m_q\)$ #display-equation($phi^(- 1)\(q\)arrow.l.r {upright("maximal ideals of ") B = frac(k\[W\], chevron.l phi^(*)\(m_q\)chevron.r)}$) Since $k\[W\]$ is a finite $k\[V\]$ algerba, so $B$ is finite dimensional over $frac(k\[V\], m_p) tilde.equiv k$ By Chinese Remainder theorem #ref(label("Chinese remainder theorem"), supplement: none), $B arrow.r B\/m_1 times dots.h.c times B\/m_s$ is surjective, $dim B gt.eq s$, since $dim B < oo$, hence $s < oo$, thus $B$ has only finitely many maximal ideals

]
#statement("Proposition")[
$W arrow.r^phi V$ is dominant iff $k\[V\]arrow.r^phi k\[W\]$ is injective

]#label("W->V dominant => k[V]->k[W] injective")
#proof(title: "Proof")[
$f in ker phi^(*) arrow.l.r.double f compose phi = 0$, $upright(i m) phi$ dense $arrow.r.double f = 0$. Conversely, $overline(upright(i m) phi) subset.neq V arrow.r.double 0 eq.not f in I\(overline(upright(i m) phi)\)$

]
#statement("Proposition")[
If $W arrow.r^phi V$ is dominant and finite, then $phi$ is surjective

]
#proof(title: "Proof")[
By Proposition #ref(label("W->V dominant => k[V]->k[W] injective"), supplement: none), $k\[W\]$ is integral over $k\[V\]$, by Theorem #ref(label("Going up and Going down theorems"), supplement: none), for any $m_q < k\[V\]$, there exists maximal ideal $n < k\[W\]$ such that $n inter k\[V\]= m_q$

]
#statement("Proposition")[
Assume $A$ is a $k$-algebra, $f\,g in A$, then

+ $"Spec" A$ is irreducible $arrow.l.r.double$ $sqrt(0)$ is prime

+ $f$ is nilpotent $arrow.l.r.double D\(f\)= diameter$

+ $D\(f\)inter D\(g\)= D\(f g\)$

+ $D\(f\)= "Spec" A arrow.l.r.double f$ is a unit

+ $union.big_(i in I) D\(f_i\)= V\({ f_i }_(i in I)\)^c$

]
#statement("Lemma")[
There is a bijection #display-equation(${ upright("Idempotents in ") A } arrow.r { upright("Open and closed subsets of ") "Spec" A }\,quad e mapsto D\(e\)$)

]#label("16:28-04/27/2022")
#statement("Proposition")[
+ Localization is exact

+ Localization and quotient commutes. i.e. $S^(- 1)\(A\/I\)= S^(- 1) A\/S^(- 1) I$

]
#proof(title: "Proof")[
Injectivity: Suppose $e_1 eq.not e_2$ are both idempotents, denote $e'_i = 1 - e_i$, then #display-equation($0 eq.not e_1 - e_2 = e_1\(e_2 + e'_2\)-\(e_1 + e'_1\)e_2 = e_1 e'_2 - e'_1 e_2$) so one of $e_1 e'_2\,e'_1 e_2$ has to be a nonzero idempotent and not a nilpotent, so $exists p in "Spec" A$ such that one of $e_1 e'_2\,e'_1 e_2$ is not in $p$, this implies that $e_1\,e_2$ cannot both be in or not in $p$. \ Surjectivity: Suppose $U subset.eq "Spec" A$ is both open and closed, then both $U$ and $U^c$ are quasi-compact and can be written as $union.big_(i = 1)^n D\(f_i\)= V\(I\)^c\,union.big_(j = 1)^m D\(g_j\)= V\(J\)^c$ respectively, denote $I =\(f_1\,dots.h.c\,f_n\)\,J =\(g_1\,dots.h.c\,g_m\)$, since $diameter = D\(f_i\)inter D\(g_j\)= D\(f_i g_j\)$, $f_i g_j$ is a nilpotent and $\(I J\)^N = 0$ for some $N$. On the other hand, $"Spec" A = union.big_(i = 1)^n D\(f_i\)union union.big_(j = 1)^m D\(g_j\)= V\(I + J\)^c$, so $I + J = A$, raise to the $2 N$-th power we get $I^N + J^N = A$, therefore $exists f in I^N\,g in J^N$ such that $1 = f + g$ and $0 = f g = f\(1 - f\)$ which implies that both $f\,g$ are idempotents. We have #display-equation($p in D\(f\)arrow.l.r.double f in.not p arrow.l.r.double I^N subset.eq.not p arrow.l.r.double J^N subset.eq p arrow.l.r.double J subset.eq p arrow.l.r.double p in V\(J\)$) Hence $D\(f\)= V\(J\)$. Here $I^N subset.eq.not p arrow.r.double J^N subset.eq p$ because $0 = I^N J^N subset.eq p$. $J^N subset.eq p arrow.r.double I^N subset.eq.not p$ because $I^N + J^N = A$. $I^N subset.eq.not p arrow.r.double f in.not p$ because otherwise $f in p arrow.r.double g = 1 - f in.not p arrow.r.double J^N subset.eq.not p$ which is impossible

]
#statement("Definition")[
Topological space $X$ is an H-#emph[space]#index-entry("H-space") if there is a continuous map $mu : X times X arrow.r X$ and an identity element $e$ such that $mu\(x\,e\)= mu\(e\,x\)= e$

]
#statement("Definition")[
A #emph[Hopf algebra]#index-entry("Hopf algebra") $H$ is a bialgebra with an #emph[antipode] $S : H arrow.r H$ such that the following diagram commutes

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$H times.o H$]),
node((2,0),[$H times.o H$]),
node((0,1),[$H$]),
node((1,1),[$I$]),
node((2,1),[$H$]),
node((0,2),[$H times.o H$]),
node((2,2),[$H times.o H$]),
edge((0,0),(2,0),"->",[$S times.o 1$]),
edge((2,0),(2,1),"->",[$mu$]),
edge((0,1),(1,1),"->",[$epsilon.alt$]),
edge((0,1),(0,0),"->",[$Delta$]),
edge((0,1),(0,2),"->",[$Delta$]),
edge((1,1),(2,1),"->",[$eta$]),
edge((0,2),(2,2),"->",[$1 times.o S$]),
edge((2,2),(2,1),"->",[$mu$]))]
]
]
#statement("Proposition")[
Suppose $phi : "Spec" B arrow.r "Spec" A$ corresponds to $phi.alt : A arrow.r B$, if $forall b in B$, $b = u f\(a\)$ for some $a in A\,u in B^times$, then $phi$ is a homeomorphism

]#label("06:35-04/28/2022")
#proof(title: "Proof")[

]
== Field
<field>
#statement("Definition")[
A #strong[division ring]#index-entry("Division ring") $R$ is a nonzero ring such that $bb(F)^times = bb(F) - { 0 }$

A #strong[field]#index-entry("Field") $bb(F)$ is a nonzero commutative ring such that $bb(F)^times = bb(F) - { 0 }$

]
#statement("Definition")[
A #strong[character]#index-entry("Group character") is of $G$ is a group homomorphism $G arrow.r bb(F)^times$, and a #strong[cocharacter] is a group homomorphism $bb(F)^times arrow.r G$

]
#statement("Lemma")[
Characters of $G$, denoted as $c h\(G\)$ are linear independent on $bb(F)\[G\]$

]
#proof(title: "Proof")[
Suppose not, we can find $c_1 chi_1 + dots.h.c + c_m chi_m = 0\,c_i in bb(F)^times$, with minimal terms, since $chi_1 eq.not chi_m$, there exists $g_0 in G$ such that $chi_1\(g_0\)eq.not chi_m\(g_0\)$, on the other hand we have $0 = c_1 chi_1\(g\)+ dots.h.c + c_m chi_m\(g\)= c_1 chi_1\(g\)chi_m\(g_0\)+ dots.h.c + c_m chi_m\(g\)chi_m\(g_0\)\,forall g in G$ and $0 = c_1 chi_1\(g g_0\)+ dots.h.c + c_m chi_m\(g g_0\)= c_1 chi_1\(g\)chi_1\(g_0\)+ dots.h.c + c_m chi_m\(g\)chi_m\(g_0\)\,forall g in G$, subtract to get $0 = c_1\(chi_m\(g_0\)- chi_1\(g_0\)\)chi_1\(g\)+ dots.h.c + c_(m - 1)\(chi_m\(g_0\)- chi_(m - 1)\(g_0\)\)chi_(m - 1)\(g\)$ with fewer terms which is a contradiction

]
#statement("Definition")[
$E\/F$ is a field extension, $alpha in E$ induces an $F$-linear automorphism $T_alpha : E arrow.r E$ by multiplication, then the #emph[field trace]#index-entry("Field trace") is $"Tr"_(E\/F)\(alpha\)= "Tr" T_alpha$. The #emph[field norm]#index-entry("Field norm") is $N_(E\/F)\(alpha\)= det T_alpha$. Suppose #display-equation($f\(x\)= product\(x - sigma_i\(alpha\)\)= x^n + a_1 x^(n - 1) + dots.h.c + a_n$) is the minimal monic polynomial, use $1\,alpha\,dots.h.c\,alpha^(n - 1)$ as a basis for $F\(alpha\)$, then $T_alpha$ has the matrix form #display-equation($mat(delim: "[", 0, 0, dots.h.c, 0, - a_n; 1, 0, dots.h.c, 0, - a_(n - 1); #none, 1, dots.h.c, 0, - a_(n - 2); #none, , dots.down, dots.v, dots.v; #none, , , 1, - a_1)$)

Hence $"Tr"_(F\(alpha\)\/F)\(alpha\)= - a_1 = sum sigma_i\(alpha\)$, $N_(F\(alpha\)\/F)\(alpha\)=\(- 1\)^n a_n = product sigma_i\(alpha\)$

]
#statement("Definition")[
$bb(F)$ is a #strong[perfect field]#index-entry("Perfect field") if $bb(F)^p = bb(F)$ if $upright(c h a r) bb(F) = p eq.not 0$ or $upright(c h a r) bb(F) = 0$

]
#statement("Definition")[
$E\/F$ is a field extension, $alpha in E$ is algebraic over $F$ if $alpha$ is a zero of some polynomial in $F\[x\]$. The #strong[algebraic closure] of $F$ in $E$ are the algebraic elements of $E$

]
#statement("Theorem", title: [Emil Artin])[
Any field $F$ has an algebraically closed extension

]
#statement("Theorem")[
$F lt.eq L$ is a field extension, $G = "Aut"_F\(L\)$ as a profinite group with induced topology as a topological group. then there is a one to one correspondence between intermediate fields $E$ and closed subgroups $H$. $E$ is finite $arrow.l.r.double$ $H$ is open. $sigma E$ corresponds to $sigma H sigma^(- 1)$ for any $sigma in G$. $E$ is Galois $arrow.l.r.double$ $H$ is normal, in such case, $"Aut"_F\(E\)= G\/H$

]
== Number Field
<number-field>
#statement("Lemma")[
$K = bb(Q)\[alpha\]$ is number field, $f$ is the minimal polynomial of $alpha$. Suppose $sigma : K arrow.r.hook bb(C)$ is an embedding, then $sigma\(alpha\)$ is a root of $f$, and any such choice gives an embedding

]
#statement("Definition")[
$E\,F$ are algebraic number fields of finite degree, $E\/F$ is finite separable, $A\,B$ are corresponding ring of integers, ${ beta_1\,dots.h.c\,beta_n }$ is an integral basis of $B$ over $A$. The #strong[discriminant] of $E\/F$ with respect to ${ beta_1\,dots.h.c\,beta_n }$ is $D_(E\/F)\(beta_1\,dots.h.c\,beta_n\)= det\(T r\(beta_i beta_j\)\)$

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
]
#statement("Lemma")[
$D_K$ is well defined in $frac(A, \(A^times\)^2)$

]
#statement("Definition")[
$E\,F$ are algebraic number fields of finite degree, $E\/F$ is finite separable, $A\,B$ are corresponding ring of integers which are Dedekind domains

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
$p B = q_1^(e_1) dots.h.c q_r^(e_r)$ with $e_i > 0$. $p$ is #strong[ramified]#index-entry("Ramified") if $e_i > 1$ for some $i$, otherwise unramified. $p$ is #strong[inert]#index-entry("Inert") if $r = e = 1$. $p$ #strong[totally split]#index-entry("Totally split") if $e_i = f_i = 1$

$B\/p B tilde.equiv product_(i = 1)^r B\/q_i^(e_i)$, $f_i =\[k_(q_i) : k_p\]$, $\[E : F\]= dim_(k_p)\(B\/p B\)= sum_(i = 1)^r e_i f_i$

If $E\/F$ is Galois, $G = A u t\(E\/F\)$ acts transitively on ${ q_1\,dots.h.c\,q_r }$, then $n = sum_(i = 1)^r e_i f_i = r e f$

]
#proof(title: "Proof")[
$B tilde.equiv A^n$, $B\/p B tilde.equiv A^n\/p A^n tilde.equiv\(A\/p\)^n tilde.equiv k_p^n$

]
#statement("Example")[
$2 bb(Z)\[i\]=\(1 + i\)^2$ is ramified, $3 bb(Z)\[i\]$ is inert, $5 bb(Z)\[i\]=\(2 + i\)\(2 - i\)$ totally split

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
#statement("Theorem")[
$p$ ramifies in $O_K$ $arrow.l.r.double$ $p divides upright(d i s c)\(O_K\/bb(Z)\)$

#align(center)[
#align(center)[#set text(size:9pt)
#diagram(spacing:(7mm,9mm),
node((0,0),[$O_K$]),
node((1,0),[$K$]),
node((0,1),[$bb(Z)$]),
node((1,1),[$bb(Q)$]),
edge((0,0),(1,0),"hook->"),
edge((0,1),(0,0),"hook->"),
edge((0,1),(1,1),"hook->"),
edge((1,1),(1,0),"hook->"))]
]
]
#proof(title: "Proof")[
$p O_K = beta_1^(e_1) dots.h.c beta_r^(e_r)$, $O_K\/p O_K tilde.equiv O_K\/beta_i^(e_i)$ is an isomorphism of $bb(F)_p$ algebras. $d_i = upright(d i s c)\(\(O_K\/beta_i^(e_i)\)\/bb(F)_p\)\)$, $d = upright(d i s c)\(\(O_K\/p O_K\)\/bb(F)_p\)\)$, thus $d = d_1 dots.h.c d_r$, since discriminant is functorial, $D = det\(T r_(O_K\/bb(Z))\(\)\)mapsto d$, $p\|D arrow.l.r.double d = 0 arrow.l.r.double d_i = 0$ for some $i$

]
