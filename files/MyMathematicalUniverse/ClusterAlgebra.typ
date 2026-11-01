#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Cluster algebras

== Cluster algebra
<cluster-algebra>
#statement("Lemma")[
$bb(P)$ is a torsion free abelian group written multiplicatively, then the group ring $bb(Z P)$ is a UFD

]#label("ZP is a UFD")
#proof(title: "Proof")[
Finitely generated torsion free abelian groups are free

]
#statement("Definition", title: [Exchange pattern])[
$I = { 1\,dots.h.c\,n }$, $bb(T)_n$ is the regular $n$ tree, the coefficient group $bb(P)$ is a torsion free abelian group under multiplication, thus the group ring $bb(Z P)$ is a domain. Cluster variables are $upright(bold(x))\(t\)= { x_i\(t\)}_(i in I)$ for $t in bb(T)_n$ such that for $eq.not j$ and $t -^j t'$ #display-equation($x_i\(t\)= x_i\(t'\)$) $cal(M) = {M_j \( t \)}$ are monomials such that #display-equation($M_j\(t\)\(upright(bold(x))\)= p_j\(t\)product_i x_i^(b_i)\,p_j\(t\)in bb(P)\,b_i gt.eq 0$) and for $t -^j t'$, $b_i$'s depend on $j$ and $t$ #display-equation($x_j\(t\)x_j\(t'\)= M_j\(t\)\(upright(bold(x))\(t\)\)+ M_j\(t'\)\(upright(bold(x))\(t'\)\)$) satisfying #strong[exchange pattern]

+ $x_j divides.not M_j\(t\)$

+ $x_i divides M_j\(t\)arrow.r.double x_i divides.not M_j\(t'\)$ for $t -^j t'$

+ $x_j divides M_i\(t\)arrow.l.r.double x_i divides M_j\(t'\)$ for $t -^i t' -^j t_1$

+ $frac(M_i\(t_3\), M_i\(t_4\)) = frac(M_i\(t_2\), M_i\(t_1\))\|_(x_j arrow.l M_0 / x_j)$ for $t_1 -^i t_2 -^j t_3 -^i t_4$, $M_0 =\( M_j \( t_2 \) + M_j \( t_3 \) \)\|_(x_i = 0)$

]
#aside("Remark")[
The substitution $x_j arrow.l M_0 / x_j$ is effectively a monomial. Since if $M_j\(t_2\)$ nor $M_j\(t_3\)$ contain $x_i$, then $M_i\(t_2\)$ nor $M_i\(t_3\)$ contain $x_j$ which it substitute for nothing

#display-equation($frac(M_i\(t_2\), M_i\(t_1\)) = (frac(M_i\(t_2\), M_i\(t_1\))\|_(x_j arrow.l M_0 / x_j))\|_(x_j arrow.l M_0 / x_j) = frac(M_i\(t_3\), M_i\(t_4\))\|_(x_j arrow.l M_0 / x_j)$)

]
#statement("Definition")[
There is an involution between $\(upright(bold(x))\,cal(M)\)$ and $\(upright(bold(x'))\,cal(M)'\)$ where $x'_j\(t\)= x_j\(t'\)$, $M'_j\(t\)= M_j\(t'\)$ for every $t -^j t'$

]
#statement("Definition")[
Suppose $J subset.eq I$ is a subset of size $m$, delete sides labeled in $I - J$ in $bb(T)_n$ and choose choose a connected component which would be $bb(T)_m$, add to the coefficient group $x_k$'s $k in I - J$. This is called a restriction

]
#statement("Definition")[
Exchange pattern on exponents is a family of $B\(t\)$ such that for each $t -^quad t'$ #display-equation($frac(M_j\(t\), M_j\(t'\)) = frac(p_j\(t\), p_j\(t'\)) product_i x_i^(b_(i j)\(t\))$) Thus #display-equation($M_j\(t\)= p_j\(t\)product_i x_i^(\[b_(i j)\(t\)\]_(+))\,M_j\(t'\)= p_j\(t'\)product_i x_i^(\[- b_(i j)\(t\)\]_(+))$)

]
#statement("Definition")[
An $n times n$ matrix $B$ is #strong[sign-skew-symmetric] if $b_(i i) = 0$ and for $i eq.not j$, $b_(i j)\,b_(j i)$ are both zeros or of opposite signs. $B$ is #strong[skew-symmetrizable] if there is a diagonal matrix $D$ such that $D B$ is skew symmetric, i.e. $d_i b_(i j) = - d_j b_(j i)$. Skew-symmetrizable matrices are obviously sign-skew-symmetric

]
#statement("Lemma")[
#display-equation($frac(\|a\|b + a\|b\|, 2) = cases(a b quad a\,b > 0, - a b quad a\,b < 0, 0 quad a b < 0) = "sgn"\(a\)\[a b\]_(+) = "sgn"\(b\)\[a b\]_(+)$)

]#label("Lemma on (|a|b+a|b|)/2")
#aside("Note")[
$\|a\|=\[a\]_(+) +\[- a\]_(+)$

]
#statement("Definition")[
A #strong[mutation] on a $m times n$ ($m > n$) matrix $B$ in direction $k$ denoted by $mu_k$ is given by #display-equation($b'_(i j) = cases(- b_(i j) quad i = k upright(" or ") j = k, b_(i j) + frac(\|b_(i k)\|b_(k j) + b_(i k)\|b_(k j)\|, 2) = b_(i j) + "sgn"\(b_(i k)\)\[b_(i k) b_(k j)\]_(+) quad upright("otherwise"))$) Here $mu_k\(B\)= B'$. $mu_k$ is involutive

]
#statement("Theorem")[
If $B\(t\)$ are sign-skew-symmetric and $mu_k\(B\(t\)\)= B\(t'\)$ for each $t -^k t'$, then it gives a exchange pattern

]
#proof(title: "Proof")[
Suppose $B\(t\)$ is an exchange pattern, then $B\(t\)$ is obviously sign-skew-symmetric. For $t -^k t'$, we have #display-equation($frac(M_k\(t\), M_k\(t'\)) = frac(p_k\(t\), p_k\(t'\)) product_i x_i^(b_(i k))\,frac(M_k\(t'\), M_k\(t\)) = frac(p_k\(t'\), p_k\(t\)) product_i x_i^(b'_(i k))$) Hence $b'_(i k) = - b_(i k)$. Consider $t_1 -^j t' -^k t -^j t_2$ #display-equation($frac(M_j\(t'\), M_j\(t_1\)) = frac(M_j\(t\), M_j\(t_2\))\|_(x_k arrow.l M_0 / x_k)$) becomes #display-equation($frac(p_j\(t'\), p_j\(t_1\)) product_i x_i^(b'_(i j)) = frac(p_j\(t\), p_j\(t_2\)) product_i x_i^(b_(i j))\|_(x_k arrow.l M_0 / x_k)$) Where #display-equation($M_0 = (p_k \( t \) product_i x_i^(\[b_(i k)\]_(+)) + p_k \( t' \) product_i x_i^(\[- b_(i k)\]_(+)))\|_(x_j = 0)$)

+ $b_(j k) > 0 arrow.l.r.double b_(k j) < 0$, then $M_0 = p_k\(t'\)product_(i eq.not j) x_i^(\[- b_(i k)\]_(+))$, thus #display-equation($product_(i eq.not j) x_i^(b'_(i j)) & = product_(i eq.not j\,k) x_i^(b_(i j)) dot.op (x_k^(- 1) product_(i eq.not j\,k) x_i^(\[- b_(i k)\]_(+)))^(b_(k j)) = product_(i eq.not j\,k) x_i^(b_(i j) + b_(k j)\[- b_(i k)\]_(+)) x_k^(- b_(k j))$)

+ $b_(j k) < 0 arrow.l.r.double b_(k j) > 0$, then $M_0 = p_k\(t'\)product_(i eq.not j) x_i^(\[- b_(i k)\]_(+))$, thus #display-equation($product_(i eq.not j) x_i^(b'_(i j)) & = product_(i eq.not j\,k) x_i^(b_(i j)) dot.op (x_k^(- 1) product_(i eq.not j\,k) x_i^(\[b_(i k)\]_(+)))^(b_(k j)) = product_(i eq.not j\,k) x_i^(b_(i j) + b_(k j)\[b_(i k)\]_(+)) x_k^(- b_(k j))$)

+ $b_(j k) = 0 arrow.l.r.double b_(k j) = 0$, then #display-equation($product_(i eq.not j\,k) x_i^(b'_(i j)) = product_(i eq.not j\,k) x_i^(b_(i j))$)

Therefore $b'_(k j) = - b_(k j)$ and $b'_(i j) = b_(i j) + "sgn"\(b_(i k)\)\[b_(i k) b_(k j)\]_(+)$

Conversely, if $B\(t\)$ are sign-skew-symmetric and $mu_k\(B\(t\)\)= B\(t'\)$ for each $t -^k t'$, take #display-equation($M_k\(t\)= product_i x_i^(\[b_(i k)\(t\)\]_(+))\,M_k\(t'\)= product_i x_i^(\[- b_(i k)\(t\)\]_(+))$) for $t -^k t'$, then obviously $x_k divides.not M_k\(t\)$ since $b_(k k) = 0$ and #display-equation($x_j divides M_k\(t\)arrow.l.r.double b_(j k) > 0 arrow.l.r.double - b_(j k) < 0 arrow.r.double x_j divides.not M_k\(t'\)$) For $t -^k t' -^j t_1$ #display-equation($x_j divides M_k\(t\)arrow.l.r.double b_(j k) > 0 arrow.l.r.double b'_(k j) = - b_(k j) > 0 arrow.l.r.double x_k divides M_j\(t'\)$) For $t_1 -^j t' -^k t -^j t_2$, it is the exact argument above by taking $p_j\(t\)equiv 1$

]
#statement("Proposition")[
Given a skew-symmetrizable matrix $B$, the all possible mutations $B\(t\)$ in $bb(T)_n$ are skew-symmetrizable with the same skew-symmetrizing matrix $D$

]#label("Mutation of a skew-symmetrizable matrix preserves the skew-symmetrizing matrix")
#proof(title: "Proof")[
True for each mutation $mu_k$

]
#aside("Remark")[
For cluster algebra of rank $n lt.eq 2$, the exchange pattern is skew-symmetrizable. If $n = 1$, $B\(t\)equiv 0$. If $n = 2$, $B\(t_n\)=\(- 1\)^n mat(delim: "(", 0, b; - c, 0)$

]
#statement("Definition")[
Denote $2 n$ tuple $upright(bold(p))\(t\)$ the coefficients $p_j\(t\)\,p_j\(t'\)$ for $t -^j t'$. $Sigma\(t\)=\(upright(bold(x))\(t\)\,upright(bold(p))\(t\)\,B\(t\)\)$ is a #strong[seed], $upright(bold(x))\(t\)$ is the #strong[cluster] of the seed. If we assume $upright(bold(x))\(t_0\)$ are algebraically independent ($upright(bold(x))\(t_0\)$ is a cluster of rank $n$), then so are $upright(bold(x))\(t\)$ since they are all mutationally equivalent. Denote the collection of all cluster variables $cal(X)$, the collection of all coefficients $cal(P)$, the collection of exchange matrices $cal(B)$, the collection of $M_j\(t\)$'s $cal(M)$, the collection of seeds $cal(S)$

We can take $cal(F) = bb(Z P)\(x_1\,dots.h.c\,x_n\)$ to be the #strong[ambient field], $upright(bold(x))$ can be some cluster $upright(bold(x))\(t_0\)$. The #strong[cluster algebra] is the subalgebra $bb(Z) cal(P)\[cal(X)\]$

]
#statement("Proposition")[
Given $B\(t\)$ that give rise to exchange pattern, the coefficients must satisfy #numbered-equation($p_i\(t_1\)p_i\(t_3\)p_i\(t_3\)^(\[b_(j i)\(t_3\)\]_(+)) = p_i\(t_2\)p_i\(t_4\)p_i\(t_2\)^(\[b_(j i)\(t_2\)\]_(+))$)#label("exchange pattern on coefficients")

]
#proof(title: "Proof")[
For $t_1 -^i t_2 -^j t_3 -^i t_4$ #display-equation($frac(p_i\(t_3\), p_i\(t_4\)) product_k x_k^(b_(k i)\(t_3\)) = frac(M_i\(t_3\), M_i\(t_4\)) = frac(M_i\(t_3\), M_i\(t_4\))\|_(x_j arrow.l M_0 / x_j) = frac(p_i\(t_2\), p_i\(t_1\)) product_k x_k^(b_(k i)\(t_2\))\|_(x_j arrow.l M_0 / x_j)$) Here #display-equation($M_0 = (M_j \( t_2 \) + M_j \( t_3 \))\|_(x_i = 0) = (p_j \( t_2 \) product_k x_k^(\[b_(k j)\(t_2\)\]_(+)) + p_j \( t_3 \) product_k x_k^(\[b_(k j)\(t_3\)\]_(+)))\|_(x_i = 0)$) Take $x_k = 1$ for $k eq.not j$, and use the fact that $B\(t\)$ are sign-skew-symmetric, we get #display-equation($p_i\(t_1\)p_i\(t_3\)= p_i\(t_2\)p_i\(t_4\)M_0^(b_(j i)\(t_2\))$) With

+ $b_(i j)\(t_2\)> 0$. Then $b_(i j)\(t_3\)< 0$, $M_0 = p_j\(t_3\)$ and #display-equation($p_i\(t_1\)p_i\(t_3\)p_i\(t_3\)^(b_(j i)\(t_3\)) = p_i\(t_2\)p_i\(t_4\)$)

+ $b_(i j)\(t_2\)< 0$. Then $b_(i j)\(t_3\)> 0$, $M_0 = p_j\(t_2\)$ and #display-equation($p_i\(t_1\)p_i\(t_3\)= p_i\(t_2\)p_i\(t_4\)p_i\(t_2\)^(b_(j i)\(t_2\))$)

+ $b_(i j)\(t_2\)= 0$. Then $b_(i j)\(t_3\)= 0$, $M_0 = p_j\(t_2\)+ p_j\(t_3\)$, but $b_(j i)\(t_2\)= b_(j i)\(t_3\)= 0$, hence #display-equation($p_i\(t_1\)p_i\(t_3\)= p_i\(t_2\)p_i\(t_4\)$)

]
#aside("Note")[
A trivial solution of #ref(label("exchange pattern on coefficients"), supplement: none) is $p_j\(t\)= 1$

]
#statement("Proposition")[
The #strong[universal coefficient group] $cal(P)$ of $bb(P)$ is the free abelian group generated by $p_i\(t\)$ modulo #ref(label("exchange pattern on coefficients"), supplement: none). $cal(P)$ is torsion free, more precisely, it is the free abelian group generated by $p_i\(t_0\)\,p_i\(t\)$ for every $t_0 -^i t$ and exactly one of $p_i\(t\)\,p_i\(t'\)$ for every $t -^i t'$ where $t\,t' eq.not t_0$

]
#statement("Definition")[
Take the field of rational functions of cluster variables $upright(bold(x))\(t_0\)$ with coefficients in $bb(Z) cal(P)$ to be the ambient field $cal(F)$, all other cluster variables $upright(bold(x))\(t\)$ are also in $cal(F)$ by Theorem #ref(label("Laurent phenonmenon"), supplement: none). The #strong[universal cluster algebra] $cal(A)$ is the subalgebra generated by all cluster variables with coefficients in $bb(Z) cal(P)$

]
#statement("Definition")[
$t\,t' in bb(T)_n$ are $cal(M)$-#strong[equivalent] if there is a permutation $sigma$ of $I$ such that

- $x_(sigma\(i\))\(t\)= x_i\(t'\)$

- $M_(sigma\(j\))\(t\)\(upright(bold(x))\(t\)\)= M_j\(t'\)\(upright(bold(x))\(t'\)\)$ and $M_(sigma\(j\))\(t_1\)\(upright(bold(x))\(t\)\)= M_j\(t'_1\)\(upright(bold(x))\(t'\)\)$ for $t -^(sigma\(j\)) t_1$ and $t' -^j t'_1$

]#label("M-equivalence")
== Laurent phenomenon
<laurent-phenomenon>
#statement("Lemma", title: [Caterpillar lemma])[
Define the caterpillar tree $bb(T)_(n\,m)$ consists of a spine of $m + 2$ nodes, with an orientation from $t_(upright(t a i l))$ to $t_(upright(h e a d))$ with $t_(upright(b a s e))$ connected to $t_(upright(t a i l))$, as illustrated in Figure #ref(label("T4,8"), supplement: none)

#figure([#universe-drawing(4.0)],
  caption: [
    $bb(T)_(4\,8)$
  ]
)
#label("T4,8")

Let $bb(A)$ be a UFD, exchange polynomial $P in bb(A)\[x_1\,dots.h.c\,x_n\]$ for each edge $t -^j t'$, denoted $x -^j_P t'$ satisfying the generalized exchange pattern

- $P$ doesn't depend on $x_j$ and $x_i$ doesn't divide $P$

- For $t_0 -^i_P t_1 arrow.r^j_Q t_2$, $P\,Q_0$ are coprime in $bb(A)\[x_1\,dots.h.c\,x_n\]$, where $Q_0 = Q\|_(x_i = 0)$

- For $t_0 -^i_P t_1 arrow.r^j_Q t_2 -^i_R t_3$, $L Q_0^b P = R\|_(x_j arrow.l Q_0 / x_j)$ for some $b gt.eq 0$ and some Laurent monomial $L$ with coefficients in $bb(A)$ coprime with $P$

Cluster variables $upright(bold(x))\(t\)= { x_i\(t\)}$ for $t in bb(T)_(n\,m)$ satisfying for each $t -^i_P t'$

- $x_i\(t\)= x_i\(t'\)$ for any $i eq.not j$

- $x_j\(t\)x_j\(t'\)= P\(t\)\(upright(bold(x))\(t\)\)$

Then $upright(bold(x))\(t_(upright(h e a d))\)$ are Laurent polynomials in $upright(bold(x))\(t_0\)$ with coefficients in $bb(A)$

]#label("Caterpillar lemma")
#proof(title: "Proof")[
Write the subring of Laurent polynomials generated by $upright(bold(x))\(t\)$ as #display-equation($cal(L)\(t\)= bb(A)\[x_1\(t\)^(plus.minus 1)\,dots.h.c\,x_n\(t\)^(plus.minus 1)\]$) Make induction on $m$. If $m = 1$, consider $t_(upright(t a i l)) = t -^i_P t_(upright(b a s e)) = t' -^j_Q t_(upright(h e a d)) = t_1$, we have for $k eq.not i\,j$ #display-equation($x_k\(t_1\) & = x_k\(t'\)= x_k\(t\)\
x_i\(t_1\) & = x_i\(t'\)= frac(P\(upright(bold(x))\(t\)\), x_i\(t\))\
x_j\(t_1\) & = frac(Q\(upright(bold(x))\(t'\)\), x_j\(t'\)) = frac(Q\(upright(bold(x))\(t'\)\), x_j\(t\))$) Now suppose $m gt.eq 2$, let's show that $X = x_k\(t_(upright(h e a d))\)in cal(L)\(t_0\)$, by induction, $X in cal(L)\(t_1\)inter cal(L)\(t_3\)$. Since $X\,x_i\(t_1\)= frac(P\(upright(bold(x))\(t_0\)\), x_i\(t_0\)) in cal(L)\(t_0\)$, $X = frac(f_0, x_i\(t_1\)^a)$ for some $f_0 in cal(L)\(t_0\)$ and $a gt.eq 0$, similarly, $X = frac(g_0, x_j\(t_2\)^b x_i\(t_3\)^c)$ for some $g_0 in cal(L)\(t_0\)$ and $b\,c gt.eq 0$, thanks to Lemma #ref(label("Lemma for caterpillar lemma"), supplement: none), $X in cal(L)\(t_0\)$

]
#statement("Lemma")[
For $t_0 -^i_P t_1 arrow.r^j_Q t_2 -^i_R t_3$, $upright(bold(x))\(t_1\)\,upright(bold(x))\(t_2\)\,upright(bold(x))\(t_3\)in cal(L)\(t_0\)$, and #display-equation($gcd\(x_i\(t_1\)\,x_i\(t_3\)\)= gcd\(x_j\(t_2\)\,x_i\(t_1\)\)= 1$) in $cal(L)\(t_0\)$

]#label("Lemma for caterpillar lemma")
#aside("Note")[
$cal(L)\(t_0\)$ is a UFD, $cal(L)\(t_0\)^times$ consists of Laurent monomials with coefficients $bb(A)^times$

]
#proof(title: "Proof")[
Denote $x = x_i\(t_0\)$, $y = x_j\(t_0\)= x_j\(t_1\)$, $z = x_i\(t_1\)= x_i\(t_2\)$, $u = x_j\(t_2\)= x_j\(t_3\)$, $v = x_i\(t_3\)$, think of $P\,Q\,R$ as functions of $x_j\,x_i\,x_j$ respectively, then #display-equation($z & = frac(P\(y\), x)\
u & = frac(Q\(z\), y) = frac(Q (frac(P\(y\), x)), y)\
v & = frac(R\(u\), z) = frac(R (frac(Q\(z\), y)), z) = frac(R (frac(Q\(z\), y)) - R (frac(Q\(0\), y)), z) + frac(R (frac(Q\(0\), y)), z)$) #display-equation($frac(R (frac(Q\(z\), y)) - R (frac(Q\(0\), y)), z) = R' (Q_0 / y) frac(Q'\(0\), y) + 1 / 2 R (frac(Q\(z\), y))''\|_(z = 0) z + dots.h.c equiv R' (Q_0 / y) frac(Q'\(0\), y) #h(0.444em) mod med z$) #display-equation($frac(R (Q_0 / y), z) = frac(L\(y\)Q_0\(y\)^b P\(y\), z) = L\(y\)Q_0\(y\)^b x$) Thus $v in cal(L)\(t_0\)$

Since $gcd\(P\,Q_0\)= gcd\(P\,L\)= 1$ #display-equation($gcd\(z\,v\)= gcd (frac(P\(y\), x) \, L \( y \) Q_0 \( y \)^b x) = gcd (P \( y \) \, L \( y \) Q_0 \( y \)^b) = 1$) Since $frac(Q\(z\), y) equiv Q_0 / y #h(0.444em) mod med z$ #display-equation($gcd\(z\,u\)= gcd (z \, Q_0 / y) = gcd (P \( y \) \, Q_0) = 1$)

]
#statement("Theorem")[
Catepillar lemma #ref(label("Caterpillar lemma"), supplement: none) implies that in a cluster algebra, any cluster variable can be expressed as a Laurent polynomial in a given $upright(bold(x))\(t_0\)$ with coefficients in $bb(Z)_(gt.eq 0) bb(P)$ since there is no subtraction involved

]#label("Laurent phenonmenon")
#proof(title: "Proof")[
$bb(T)_(n\,m)$ can be embedded in $bb(T)_n$. $M_j\(t\)+ M_j\(t'\)$ doesn't depend on $x_j$ and not divisible by $x_i$ for $t -^j t'$ and any $i eq.not j$

For $t_0 -^i_P t_1 arrow.r^j_Q t_2 -^i_R t_3$, we have #display-equation($frac(P, M_i\(t_0\)) = 1 + frac(M_i\(t_1\), M_i\(t_0\)) = 1 + frac(M_i\(t_2\), M_i\(t_3\))\|_(x_j arrow.l M_0 / x_j) = frac(R, M_i\(t_3\))\|_(x_j arrow.l M_0 / x_j)$) Where $M_0 =\( M_j \( t_1 \) + M_j \( t_2 \) \)\|_(x_i = 0) = Q_0$, thus #display-equation($frac(R\|_(x_j arrow.l Q_0 / x_j), P) = frac(M_i\(t_3\)\|_(x_j arrow.l Q_0 / x_j), M_i\(t_0\))$) Note that $M_i\(t_0\)= p_i\(t_0\)product_k x_k^(\[b_(k i)\(t_0\)\]_(+))$ and #display-equation($M_i\(t_3\)\|_(x_j arrow.l Q_0 / x_j) & = p_i\(t_3\)product_k x_k^(\[b_(k i)\(t_3\)\]_(+))\|_(x_j arrow.l Q_0 / x_j)\
 & = p_i\(t_3\)(Q_0 / x_j)^(\[b_(j i)\(t_3\)\]_(+)) product_(k eq.not i\,j) x_k^(\[b_(k i)\(t_3\)\]_(+))\
 & = p_i\(t_3\)Q_0^(\[b_(j i)\(t_3\)\]_(+)) x_j^(-\[b_(j i)\(t_3\)\]_(+)) product_(k eq.not i\,j) x_k^(\[b_(k i)\(t_3\)\]_(+))\
$) Hence #display-equation($R\|_(x_j arrow.l Q_0 / x_j) = frac(p_i\(t_3\), p_i\(t_0\)) x_j^(-\[b_(j i)\(t_3\)\]_(+) -\[b_(j i)\(t_0\)\]_(+)) product_(k eq.not i\,j) x_k^(\[b_(k i)\(t_3\)\]_(+) -\[b_(k i)\(t_0\)\]_(+)) Q_0^(\[b_(j i)\(t_3\)\]_(+)) P = L Q_0^b P$) Since the sum of two monomials $P$ doesn't depend on $x_i$ and is not divisible by any $x_k$ for $k eq.not i$, $Q_0$ is a monomial, $L$ is a Laurent monomial, $Q_0\,P$ are coprime in $bb(A)\[upright(bold(x))\]$ and $L\,P$ are coprime in $cal(L)\[upright(bold(x))\]$

]
== Y-system
<y-system>
$A$ is the Cartan matrix of root system $Phi$ with simple system $Pi$, denote $\[alpha : alpha_i\]$ as the coefficients of $alpha in Phi$, write $Phi_(gt.eq - 1) = Phi_(+) union\(- Pi\)$. Since the Coxeter graph is a tree, it is bipartite, up to renaming $I = { 1\,dots.h.c\,n } = I_(-) union.sq I_(+)$, $epsilon\(i\)= epsilon$ for $i in I_epsilon$ be the indicator. Let $t_epsilon = product_(i in I_epsilon) s_i$, $t = t_(-) t_(+)$ is a Coxeter element, $h$ is the Coxeter number. $s_(upright(bold(i))_(-))\,s_(upright(bold(i))_(+))$ are reduced words of $t_(-)\,t_(+)$, then #display-equation($w_compose = underbrace(s_(upright(bold(i))_(-)) s_(upright(bold(i))_(+)) dots.h.c s_(upright(bold(i))_plus.minus), h upright(" times")) = s_(upright(bold(i))_compose)$) is the element of longest length

#statement("Definition")[
Suppose $Phi$ is irreducible, then #display-equation($\[s_i\(alpha\): alpha_k\]= cases(-\[alpha : alpha_i\]- sum_(j eq.not i) a_(i j)\[alpha : alpha_j\]quad k = i, \[alpha : alpha_k\]quad k eq.not i)$) Define a piecewise linear modification #display-equation($\[sigma_i\(alpha\): alpha_k\]= cases(-\[alpha : alpha_i\]- sum_(j eq.not i) a_(i j)\[alpha : alpha_j\]_(+) quad k = i, \[alpha : alpha_k\]quad k eq.not i)$)

]
#statement("Proposition")[
+ $sigma_i$ are involutions

+ $sigma_i\,sigma_j$ commutes if $i\,j$ are not adjacent in the Coxeter graph

+ $sigma_i$ preserves $Phi_(gt.eq - 1)$

]
#statement("Proposition")[
Let $tau_epsilon = product_(i in I_epsilon) sigma_i$

+ $tau_epsilon$ are involutions that preserve $Phi_(gt.eq - 1)$

+ $tau_epsilon alpha = t_epsilon alpha$ for $alpha in bb(Z)_(gt.eq 0) Pi$

+ $Phi_(gt.eq - 1) arrow.r Phi_(gt.eq - 1)^or$, $alpha mapsto alpha^or$ are $tau_epsilon$ equivariant, i.e. $\(tau_epsilon alpha\)^or = tau_epsilon alpha^or$

]
#statement("Definition")[
A #strong[Y-system] is a family of commuting variables $Y_i\(t\)$, $i in I = { 1\,dots.h.c\,n }$, $t in bb(Z)$ such that #numbered-equation($Y_i\(t + 1\)Y_i\(t - 1\)= product_(j eq.not i)\(1 + Y_i\(t\)\)^(- a_(i j))$)#label("Y-system")

]
#aside("Remark")[
#ref(label("Y-system"), supplement: none) only really involve those $Y_j\(k\)$ with $epsilon\(j\)dot.op\(- 1\)^k = "const"$, assume $Y_j\(k\)= Y_j\(k + 1\)$ for $epsilon\(i\)=\(- 1\)^k$, then we have #display-equation($Y_i\(k + 1\)= cases(frac(product_(j eq.not i)\(1 + Y_i\(k\)\)^(- a_(i j)), Y_i\(k\)) quad epsilon\(i\)=\(- 1\)^k + 1, Y_i\(k\)quad epsilon\(i\)=\(- 1\)^k)$) Denote $cal(Y)$ as the collection of all $Y_j\(k\)$'s, $u_i = Y_i\(0\)$, define #display-equation($tau_epsilon\(u_i\)= cases(frac(product_(j eq.not i)\(1 + u_i\)^(- a_(i j)), u_i) quad epsilon\(i\)= epsilon, u_i quad upright("otherwise"))$)

]
#statement("Theorem", title: [Zamolodichikov])[
$Y_i\(t\)$'s are $2\(h + 2\)$ periodic, i.e. $Y_i\(t + 2\(h + 2\)\)= Y_i\(t\)$

]
#statement("Theorem")[
There is a unique family ${ F\[alpha\]}_(alpha in Phi_(gt.eq - 1))$ of polynomials in $u_i$ such that $F\[- alpha_i\]= - 1$ and #display-equation($tau_epsilon\(F\[alpha\]\)= frac(product_(epsilon\(i\)= - epsilon)\(u_i + 1\)^(\[alpha^or : alpha_i^or\]), product_(epsilon\(i\)= epsilon) u_i^(\[alpha^or : alpha_i^or\]_(+))) F\[tau_(- epsilon)\(alpha\)\]$) Furthermore, $F\[alpha\]in bb(Z)_(gt.eq 0)\[upright(bold(u))\]$ has constant term $1$. Call $F\[alpha\]$ Fibonacci polynomials

Any $alpha in Phi_(gt.eq - 1)$ can be written as $alpha\(k\,i\)=\(tau_(-) tau_(+)\)^k\(- alpha_i\)$, denote $N\[alpha\]= product_(j eq.not i) F\[alpha\(- k\,i\)\]^(- a_(i j))$, note that $N\[alpha\]in bb(Z)_(gt.eq 0)\[upright(bold(u))\]$ also has constant term $1$

]
#statement("Theorem")[
There is a unique bijection $Phi_gt.eq - 1 arrow.r cal(Y)$, $alpha mapsto Y\[alpha\]= frac(N\[alpha\], upright(bold(u))^(alpha^or))$ such that $Y\[- alpha_i\]= u_i$, $tau_epsilon\(Y\[alpha\]\)= Y\[tau_epsilon\(alpha\)\]$

]
#statement("Definition")[
A #strong[tropical specialization] $r_(upright(t r o p))$ of a rational expression $r$ is changing the addition $+$ and multiplication $dot.op$ into $xor$ and $dot.o$ where $a xor b = max\(a\,b\)$, $a dot.o b = a + b$

The #strong[compatibility degree] for $alpha\,beta in Phi_(gt.eq - 1)$ is #display-equation($\(alpha\|\|beta\)=\(Y\[alpha\]+ 1\)\(beta\)_(upright(t r o p))$) Here $\(Y\[alpha\]+ 1\)\(beta\)$ is evaluation at ${ u_i =\[beta : alpha_i\]}$. $alpha\,beta$ are #strong[compatible] if $\(alpha\|\|beta\)= 0$

$Delta\(Phi\)$ is a simplicial complex with $Phi_(gt.eq - 1)$ as vertices and mutually compatible subsets of $Delta\(Phi\)$ are simplices, the maximal simplices are #strong[clusters]. The #strong[exchange graph] $E\(Phi\)$ is an unoriented graph with clusters as vertices and an edge between clusters which has intersection of cardinality $n - 1$

]
#aside("Remark")[
$\(\|\|\)$ is uniquely characterized by #display-equation($\(- alpha_i\|\|beta\)=\(Y\[- alpha_i\]+ 1\)\(beta\)_(upright(t r o p)) =\(u_i + 1\)\(beta\)_(upright(t r o p)) =\[beta : alpha_i\]_(+)$) #display-equation($\(tau_epsilon\(alpha\)\|\|tau_epsilon\(beta\)\)=\(Y\[tau_epsilon\(alpha\)\]+ 1\)\(tau_epsilon\(beta\)\)_(upright(t r o p)) =\(tau_epsilon\(Y\[alpha\]\)+ 1\)\(tau_epsilon\(beta\)\)_(upright(t r o p)) =\(alpha\|\|beta\)$)

]
#statement("Proposition")[
Consider perfect bilinear pairing #display-equation($bb(Z) Pi^or times bb(Z) Pi & arrow.r bb(Z)\
\(xi\,gamma\) & mapsto { xi\,gamma }$) Where ${ xi\,gamma } = sum epsilon\(i\)\[xi : alpha_i^or\]\[gamma : alpha_i\]$. Then #display-equation($\(alpha\|\|beta\)= max\({ tau_(+) alpha^or\,beta }\,{ alpha^or\,tau_(+) beta }\,0\)= max\(- { tau_(-) alpha^or\,beta }\,- { alpha^or\,tau_(-) beta }\,0\)$)

]
#aside("Note")[
$\(\|\|\)$ doesn't depend on the choice of the indicator $epsilon$

]
#statement("Proposition")[
+ $\(alpha\|\|beta\)=\(beta^or\|\|alpha^or\)$, in particular, if $Phi$ is simply laced, then $\(alpha\|\|beta\)=\(beta\|\|alpha\)$

+ If $\(alpha\|\|beta\)= 0$, then $\(beta\|\|alpha\)= 0$

+ $J subset.eq I$, $Phi\(J\)subset.eq Phi$ is a root subsystem, $\(\|\|\)$ on $Phi\(J\)$ is the same as the restriction

]
#statement("Theorem")[
$Delta\(Phi\)$ is pure of dimension $n - 1$, and each facet forms a $bb(Z)$-basis for the root lattice

]
#statement("Theorem")[
The simplicial cones of all clusters form a complete simplicial fan

]
#statement("Corollary")[
The geometric realization of $Delta\(Phi\)$ is $bb(S)^(n - 1)$

]
#statement("Conjecture")[
The simplicial fan of $Delta\(Phi\)$ is the normal fan of some convex polytope $P\(Phi\)$

]
#statement("Theorem")[
$E\(Phi\)$ is a regular $n$ tree

]
#statement("Example")[

]
== Associahedron
<associahedron>
#statement("Definition")[
Any $n$ regular polygon has $binom(n, 2) - n = frac(n\(n - 3\), 2)$ diagonals, with these as vertices, noncrossing subsets as simplexes, we have given it a abstract simplicial complex structure

]
== Cluster algebra of geometric type
<cluster-algebra-of-geometric-type>
#statement("Lemma")[
Semifield $bb(P)$ is multiplicative torison free

]#label("Semifield is multiplicative torison free")
#proof(title: "Proof")[
Suppose $p^m = 1$, then #display-equation($p = frac(p^m xor p^(m - 1) xor dots.h.c + p, p^(m - 1) xor p^(m - 2) xor dots.h.c + 1) = frac(1 xor p^(m - 1) xor dots.h.c + p, p^(m - 1) xor p^(m - 2) xor dots.h.c xor 1) = 1$)

]
#statement("Definition")[
Exchange pattern is #strong[normalized] if $bb(P)$ is a semifield and $p_j\(t\)xor p_j\(t'\)= 1$ for any $t -^j t'$

]
#statement("Proposition")[
Given $p_j\,r_j$ in a semifield $bb(P)$ such that $p_j xor r_j = 1$, and exchange matrix $B\(t\)$ on $bb(T)_n$, define $p_j\(t_0\)= p_j$, $p_j\(t\)= r_j$ for each $t_0 -^i t$, this completely determines the cluster algebra

]#label("Normalized exchange pattern determines the cluster algebra")
#proof(title: "Proof")[
Define $u_j\(t\)= frac(p_j\(t\), p_j\(t'\))$ for $t -^j t'$, then #display-equation($p_j\(t\)= frac(u_j\(t\), 1 xor u_j\(t\))\,p_j\(t'\)= frac(1, 1 xor u_j\(t\))$) Then #ref(label("exchange pattern on coefficients"), supplement: none) becomes #display-equation($u_i\(t_3\)p_j\(t_3\)^(\[b_(j i)\(t_3\)\]_(+)) = u_i\(t_2\)p_j\(t_2\)^(\[b_(j i)\(t_2\)\]_(+))$)

+ $u_i\(t_3\)p_j\(t_3\)^(b_(j i)\(t_3\)) = u_i\(t_2\)arrow.r.double u_i\(t_3\)= u_i\(t_2\)\(1 xor u_j\(t_2\)\)^(b_(j i)\(t_2\))$

+ $u_i\(t_3\)= u_i\(t_2\)p_j\(t_2\)^(b_(j i)\(t_2\)) = u_i\(t_2\)(frac(u_j\(t_2\), 1 xor u_j\(t_2\)))^(b_(j i)\(t_2\))$

Thus for $t -^j t'$, we have #display-equation($u_i\(t'\)= u_i\(t\)u_j\(t\)^(\[b_(j i)\(t\)\]_(+))\(1 xor u_j\(t\)\)^(- b_(j i)\(t\))$)

]
#aside("Remark")[
$upright(bold(p))$ determines $upright(bold(u))$ which in turn determines $upright(bold(p))$

Fix semifield $bb(P)$, $B$ is skew-symmetrizable, then $\(B\,upright(bold(p))\)$ determines the cluster algebra $cal(A) = cal(A)\(B\,upright(bold(p))\)$ up to isomorphism

]
#statement("Corollary")[
The exchange graph of a normalized cluster algebra is $n$-regular

]
#statement("Definition")[
The #strong[tropical semifield]#index-entry("tropical semifield") $\(bb(R)\,xor\,dot.o\)$ is a semifield with multiplication as $dot.o$, $min$ or $max$ as $xor$

The tropical semifield generated by $p$ is the free abelian group generated multiplicatively by $p$ with $p^a xor p^b = p^(min\(a\,b\))$

]
#statement("Definition")[
A normalized cluster algebra is of geometric type if $bb(P)$ is the tropical semifield generated by ${ p_i }_(i in I')$ and each $p_j\(t\)$ is a monomial with nonnegative exponents

]
#aside("Remark")[
In this particular case, normality just means that for $t -^j t'$, $p_j\(t\)\,p_j\(t'\)$ doesn't have a common variable, or the support doesn't intersect

]
#statement("Proposition")[
$bb(P)$ is the tropical semifield generated by $p_i\,i in I'$, $B\(t\)$ is the exchange pattern of exponents, $p_j\(t\)$ give rise to a cluster algebra of geometric type iff $C\(t\)$ satisfies the exchange pattern of coefficients, i.e. $p_j\(t\)= product_i p_i^(\[c_(i j)\(t\)\]_(+))$ and #display-equation($c'_(i j) = cases(- c_(i j) quad j = k, c_(i j) + frac(\|c_(i j)\|b_(j k) + c_(i j)\|b_(j k)\|, 2) quad upright("otherwise"))$) Here the mutation is in direction $k$

]
#proof(title: "Proof")[
Suppose $p_j\(t\)$ give rise to a cluster algebra of geometric type. Define $u_j\(t\)= frac(p_j\(t\), p_j\(t'\)) = product_(i in I') p_i^(c_(i j)\(t\))$ for each $t -^j t'$, then according to Proposition #ref(label("Normalized exchange pattern determines the cluster algebra"), supplement: none) #display-equation($p_j\(t\)= frac(u_j\(t\), 1 xor u_j\(t\)) = frac(product_i p_i^(c_(i j)), 1 xor product_i p_i^(c_(i j))) = frac(product_i p_i^(c_(i j)), product_i p_i^(-\[- c_(i j)\]_(+))) = product_i p_i^(\[c_(i j)\]_(+))$) #display-equation($1 = u_k\(t\)u_k\(t'\)= product_i p_i^(c_(i k) + c'_(i k)) arrow.r.double c'_(i k) = - c_(i k)$) And #display-equation($product_i p_i^(c'_(i j)) & = product_i p_i^(c_(i j)) (product_i p_i^(c_(i k)))^(\[b_(k j)\]_(+)) (1 xor product_i p_i^(c_(i k)))^(- b_(k j))\
 & = product_i p_i^(c_(i j)) product_i p_i^(c_(i k)\[b_(k j)\]_(+)) product_i p_i^(b_(k j)\[- c_(i k)\]_(+))\
 & = product_i p_i^(c_(i j) + frac(\|c_(i j)\|b_(j k) + c_(i j)\|b_(j k)\|, 2))$)

]
#aside("Remark")[
Note if we take $tilde(B)\(t\)=\(tilde(b)_(i j)\)_(i in I union I'\,j in I)$ where $tilde(b)_(i j) = b_(i j)$ for $i\,j in I$ is the principal part of $tilde(B)$, $tilde(b)_(i j) = c_(i j)$ for $i in I'\,j in I$

]
#statement("Corollary")[
Given $tilde(B)_0$ with a skew-symmetrizable principal part $B_0$, then there exists a unique exchange pattern of geometric type such that $tilde(B)\(t_0\)= tilde(B)_0$ for $t_0 in bb(T)_n$

]
#proof(title: "Proof")[
By Proposition #ref(label("Mutation of a skew-symmetrizable matrix preserves the skew-symmetrizing matrix"), supplement: none)

]
#aside("Remark")[
The class of exchange patterns of geometric type is stable under restriction and direct product

]
== Rank two case
<rank-two-case>
#statement("Example")[
If $n = 2$, consider $bb(T)_2$ #display-equation($-^1 t_0 -^2 t_1 -^1 t_2 -^2 t_3 -^1 t_4 -^2 t_5 -^1$) The cluster variables are $y_i\,y_(i + 1)$ for $t_i$ #display-equation($y_(2 k + 1) = x_1\(t_(2 k)\)= x_1\(t_(2 k + 1)\)\,y_(2 k) = x_2\(t_(2 k - 1)\)= x_2\(t_(2 k)\)$) $M_2\(t_0\)$ and $M_2\(t_1\)$ don't have $x_1$ and can't both have $x_2$

If both of them don't have $x_2$, then $M_2\(t_0\)\,M_2\(t_1\)in bb(P)$, thus #display-equation($dots.h.c x_2 divides.not M_1\(t_(- 1)\)arrow.l.r.double x_1 divides.not M_2\(t_0\)arrow.l.r.double x_2 divides.not M_1\(t_1\)arrow.l.r.double x_1 divides.not M_2\(t_2\)dots.h.c$) #display-equation($dots.h.c x_2 divides.not M_1\(t_0\)arrow.l.r.double x_1 divides.not M_2\(t_1\)arrow.l.r.double x_2 divides.not M_1\(t_2\)arrow.l.r.double x_1 divides.not M_2\(t_3\)dots.h.c$) So is every $M_(*)\(t_(*)\)in bb(P)$, write $q_m\,r_m$ as the two monomials of $t_(m - 1) -^quad t_m$, then we have #display-equation($y_(m - 1) y_(m + 1) = q_m + r_m$) And for $t_(m - 2) -^quad t_(m - 1) -^quad t_m -^quad t_(m + 1)$ we have #display-equation($q_(m + 1) / r_(m + 1) = r_(m - 1) / q_(m - 1) arrow.l.r.double q_(m - 1) q_(m + 1) = r_(m - 1) r_(m + 1)$) If $M_2\(t_0\)= q_1 x_1^b$, $M_2\(t_1\)= r_1$\(the other case corresponds to the involution) for some $b > 0$, then $M_1\(t_1\)= q_2 x_2^c$, $M_1\(t_2\)= r_2$ for some $c > 0$, we have #display-equation($frac(M_2\(t_2\), M_2\(t_3\)) = frac(M_2\(t_1\), M_2\(t_0\))\|_(x_1 arrow.l M_0 / x_1) = frac(r_1, q_1 x_1^b)\|_(x_1 arrow.l r_2 / x_1) = frac(r_1 x_1^b, q_1 r_2^b)$) Since $x_1 divides M_2\(t_3\)arrow.r.double x_2 divides.not M_2\(t_2\)$ gives a contradiction, $x_1 divides.not M_2\(t_3\)arrow.r.double M_2\(t_3\)= r_3$, thus $M_2\(t_2\)= q_3 x_1^b$, periodically, we can conclude #display-equation($M_2\(t_(2 k)\) & = q_(2 k + 1) x_1^b\
M_2\(t_(2 k + 1)\) & = r_(2 k + 1)\
M_1\(t_(2 k - 1)\) & = q_(2 k) x_2^c\
M_1\(t_(2 k)\) & = r_(2 k)$) Therefore we have #display-equation($y_(2 k - 1) y_(2 k + 1) & = q_(2 k) y_(2 k)^c + r_(2 k)\
y_(2 k) y_(2 k + 2) & = q_(2 k + 1) y_(2 k + 1)^b + r_(2 k + 1)$) For $t_(2 k - 1) -^1 t_(2 k) -^2 t_(2 k + 1) -^1 t_(2 k + 2)$ we have #display-equation($q_(2 k) q_(2 k + 2) r_(2 k + 1)^c = r_(2 k) r_(2 k + 2)$) For $t_(2 k - 2) -^2 t_(2 k - 1) -^1 t_(2 k) -^2 t_(2 k + 1)$ we have #display-equation($q_(2 k - 1) q_(2 k + 1) r_(2 k)^b = r_(2 k - 1) r_(2 k + 1)$) The exchange matrices are #display-equation($B\(t_m\)=\(- 1\)^m mat(delim: "(", 0, b; - c, 0)$) Conversely, given such relation, we can always find a corresponding cluster algebra

In particular, consider the coordinate ring of $"Gr"_2\(5\)$, let #display-equation($y_m & =\[overline(2 m - 1)\,overline(2 m + 1)\]\
q_m & =\[overline(2 m - 2)\,overline(2 m + 2)\]\
r_m & =\[overline(2 m - 2)\,overline(2 m - 1)\]\[overline(2 m + 1)\,overline(2 m + 2)\]\
b & = c = 1$)

]#label("Cluster algebra of rank 2")
#aside("Note")[
If we denote $m #h(0.444em) mod med 2$ as $chevron.l m chevron.r$, then #display-equation($p_(chevron.l m chevron.r)\(t_m\) & = q_(m + 1)\
p_(chevron.l m + 1 chevron.r)\(t_m\) & = r_m\
x_(chevron.l m chevron.r)\(t_m\) & = q_m\
x_(chevron.l m + 1 chevron.r)\(t_m\) & = y_(m + 1)$)

]
#statement("Example")[
As in Example #ref(label("Cluster algebra of rank 2"), supplement: none), by Theorem #ref(label("Laurent phenonmenon"), supplement: none), we know that #display-equation($y_m = frac(N_m\(y_1\,y_2\), y_1^(d_1\(m\)) y_2^(d_2\(m\)))$) Where $N_m\(y_1\,y_2\)in bb(Z P)\[y_1\,y_2\]$ not divisible by $y_1$ or $y_2$

]
== Cluster algebra of finite type
<cluster-algebra-of-finite-type>
#statement("Definition")[
Seeds $Sigma\(t\)\,Sigma\(t'\)$ are #strong[equivalent] if $t\,t'$ are $cal(M)$-equivalent, i.e. there is a permutation $sigma$ of $I$ such that $x_(sigma\(i\)\(t\)) = x_i\(t'\)$, $b_(sigma\(i\)sigma\(j\))\(t'\)= b_(i j)\(t\)$, $p_(sigma\(j\))\(t\)= p_j\(t'\)$. For geometric type, $c_(i sigma\(j\))\(t\)= c_(i j)\(t'\)$, or rather, $tilde(b)_(sigma\(i\)sigma\(j\))\(t'\)= tilde(b)_(i j)\(t\)$ since $sigma$ as only a permutation of $I$ fixes $I'$. By Proposition #ref(label("Normalized exchange pattern determines the cluster algebra"), supplement: none), if $t\,t'$ are equivalent, and $t -^(sigma\(j\)) t_1$ and $t' -^j t'_1$, then $t_1\,t'_1$ are equivalent

Cluster algebras $cal(A)\(cal(S)\)$, $cal(A)'\(cal(S)'\)$ are strongly isomorphic if there is a field isomorphism $cal(F) arrow.r cal(F)'$ that sends seeds in $cal(S)$ to seeds $cal(S)'$, thus inducing bijection $cal(S) arrow.r cal(S)'$ and an isomorphism $cal(A) arrow.r cal(A)'$

$cal(A)\(B\,-\)$ are all the possible normalized cluster algebras. $cal(A)\(B\)\,cal(A)\(B'\)$ are strongly isomorphic if there is a one-to-one correspondence between $cal(A)\(B\,upright(bold(p))\)$ and $cal(A)\(B'\,upright(bold(p))'\)$, this is true iff $B\,B'$ are mutationally equivalent modulo relabelling rows and columns

$cal(A)$ is of #strong[finite type] if it has finitely many seeds up to equivalences

]
#statement("Definition")[
The #strong[Cartan counterpart] of $B$ is the #strong[generalized Cartan matrix] $A\(B\)=\(a_(i j)\)$, $a_(i i) = 2$, $a_(i j) = -\|b_(i j)\|$ for $i eq.not j$, with the same symmetrizing matrix $D$, i.e. $d_i a_(i j) = d_j a_(j i)$

]
#statement("Theorem")[
$A$ is a Cartan matrix of finite type, there is a sign-skew symmetric $B_compose$ such that $A\(B_compose\)= A$ and $b_(i j) b_(i k) > 0$ for all $i\,j\,k$, and $upright(bold(p))_compose$ is normalized, then $cal(A)\(B_compose\,upright(bold(p))_compose\)$ is of finite type. Any cluster algebra of finite type is strongly isomorphic to one such data

]#label("A Cartan matrix of finite type, A(B)=A, bijbik>0, p normalized, then cluster algebra is of finite type")
#aside("Remark")[
Since the Coxeter graph of $A$ is a tree which is bipartite, thus we can certainly divide them into sinks and sources. Since $b_(i j) > 0$ would be there is a directed edge from $i$ to $j$, thus we can always find such a $B_compose$

]
#statement("Theorem")[
$B\,B'$ sign-skew symmetric, $cal(A)\(B\)\,cal(A)\(B'\)$ iff $A\(B\)\,A\(B'\)$ are of the same Cartan-Killing type

]
#statement("Theorem")[
$cal(A)$ is a cluster algebra, the following are equivalent

+ $cal(A)$ is of finite type

+ $\|cal(X)\|< oo$

+ For every seed $\(upright(bold(x))\,upright(bold(p))\,B\)$, $\|b_(x y) b_(y x)\|< 3$ for $x\,y in upright(bold(x))$

+ $cal(A) = cal(A)\(B_compose\,p_compose\)$ as in Theorem~#ref(label("A Cartan matrix of finite type, A(B)=A, bijbik>0, p normalized, then cluster algebra is of finite type"), supplement: none)

]
#statement("Theorem")[
$cal(A)\(B\)$ consists of cluster algebras all simultaneously of finite type or of infinite type. There is a bijective correspondence between generalized Cartan matrices of finite type and strong isomorphic classes of normalized cluster algebras, through $B arrow.r A\(B\)$

]
#statement("Theorem")[
There is a unique bijection $Phi_(gt.eq - 1) arrow.r cal(X)$, $alpha mapsto x\[alpha\]= frac(P_alpha\(upright(bold(x))_compose\), upright(bold(x))^alpha)$, $P_alpha in bb(Z)_(gt.eq 0) cal(P)$ with nonzero constant term such that $X\[- alpha_i\]= x_i$

]#label("Bijection between almost positive roots and X")
#statement("Theorem")[
Every seed $\(upright(bold(x))\,upright(bold(p))\,B\)$ in $cal(A)$ is uniquely determined by the cluster $upright(bold(x))$, and for any $x in upright(bold(x))$, there is a unique cluster $upright(bold(x))'$ such that $upright(bold(x)) inter upright(bold(x))' = upright(bold(x)) - { x }$. The the cluster complex $Delta\(cal(A)\)$ encodes the combinatorics of seed mutations

]
#statement("Theorem")[
The bijection in Theorem~#ref(label("Bijection between almost positive roots and X"), supplement: none) identifies $Delta\(cal(A)\)$ and $Delta\(Phi\)$, in particular, the cluster complex doesn't depend on $bb(P)$ nor $upright(bold(p))_compose$

]
