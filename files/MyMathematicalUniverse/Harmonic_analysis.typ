#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Harmonic analysis

#statement("Definition")[
Group $G$ is a #emph[topological group] if the multiplication and inverse maps are continuous

]
#statement("Definition")[
$k$ is a topological field, $V$ is a #emph[topological vector space]#index-entry("Topological vector space") over a $k$ if

- $V$ is a topological abelian group

- Scalar multiplication $k times V arrow.r V$ is continuous

]
#statement("Definition")[
$k$ is a field. A #emph[semi-norm] $parallel dot.op parallel$ on a

- Abelian group $A$ is $A arrow.r^(parallel dot.op parallel) k_(gt.eq 0)$ such that $parallel - a parallel = parallel a parallel$, $parallel a + b parallel lt.eq parallel a parallel + parallel b parallel$

- Rng $R$ is $R arrow.r^(parallel dot.op parallel) k_(gt.eq 0)$ such that $parallel r s parallel lt.eq parallel r parallel parallel s parallel$

- Vector space $V$ is is $V arrow.r^(parallel dot.op parallel) k_(gt.eq 0)$ such that $parallel k v parallel =\|k\|parallel v parallel$

$parallel dot.op parallel$ is a #emph[norm] if $parallel x parallel = 0 arrow.l.r.double x$ is trivial

]
#aside("Remark")[
A norm $parallel dot.op parallel$ induces a metric $d\(x\,y\)= parallel x - y parallel$

]
#statement("Definition")[
A topological vector space $V$ is

- #emph[locally convex] if 0 has a neighborhood basis consists of convex subsets. Such neighborhood basis exists iff it is induced by a family of seminorms $p_i$ as ${ p_i < c }$

- #emph[Banach] if it is normed and complete with respect to the metric induced by that norm

- #emph[Fréchet] space is a locally convex and completely metrizable

]
#statement("Definition")[
$Y$ is a topological vector space, $T$ is a set, $cal(G) subset.eq cal(P)\(T\)$ is a directed set by inclusion, $cal(N)$ is a local base around $0 in Y$. The #emph[topology of uniform convergence]#index-entry("Topology of uniform convergence") on sets in $cal(G)$ or $cal(G)$ #emph[topology]#index-entry("\\mathcal G topology") is the unique translation invariant topology given by basis #display-equation($U\(G\,N\)= {f in Y^T mid(bar.v) G in cal(G) \, N in cal(N) \, f \( G \) subset.eq N}$)

]
#statement("Example")[
$cal(G)$ is the set of compact subspaces, $Y$ is a metric space

]
#statement("Definition")[
#index-entry("Equicontinuity") Let $X\,Y$ be a topological spaces, a family of continuous functions $A subset.eq Y^X$ is #emph[equicontinuous] at $x in X$, if for any open neighborhood $V$ of $y = f\(x\)$, there is an open neighborhood $U$ of $x$ such that $f\(U\)subset.eq V\,forall f in A$

]
#statement("Definition")[
A topological space $X$ is called separable if $X$ has a countable dense subset

]
#statement("Theorem", title: [Arzela-Ascoli theorem])[
Let $X$ be a topological space and $Y$ be a complete metric space, $A subset.eq Y^X$ be a family of equicontinuous functions(meaning pointwise equicontinuous). If $X$ is compact, and $A_x := { f\(x\)\|f in A } subset.eq Y$ is relatively compact for any $x in A$, then $A$ is relatively compact in $Y^X$. If $X$ is separable with $S$ being a countable dense subset, and $A_x$ is relatively compact for any $x in S$, then any sequence ${ f_n }$ has a subsequence ${f_(n_k)}$ converges uniformly on any compact subset of $X$

]#label("Arzela-Ascoli theorem")
#statement("Definition")[
A topological space $X$ is a #emph[Baire space]#index-entry("Baire space") if for any countable open dense subsets ${ U_i }$, $inter.big_(i = 1)^oo U_i$ is also dense

]
#statement("Theorem", title: [Baire's category theorem])[
Every complete metric space $X$ is a Baire space

]#label("Baire's category theorem")
#proof(title: "Proof")[
Let ${ U_i }$ be a countable open dense subsets, suppose $inter.big_(i = 1)^oo U_i$ is not dense, then the complement of its closure is open nonempty, suppose $B\(x\,r\)$ is in the complement of the closure, since $U_1$ is dense, $U_1 inter B\(x\,r\)eq.not nothing$, then there exists $overline(B\(x_1\,r_1\)) subset.eq U_1 inter B\(x\,r\)$, similarly, we can find $overline(B\(x_n\,r_n\)) subset.eq U_n inter B\(x_(n - 1)\,r_(n - 1)\)$, and we can also assume $r_i arrow.r 0$, thus $x_i arrow.r y in X$ since $X$ is complete, but $y in B\(x\,r\)inter.big inter.big_(i = 1)^oo U_i = nothing$ which is a contradiction

]
#statement("Definition", title: [Test function spaces])[
Suppose $U subset.eq bb(R)^n$ is an open subset, a #emph[test function space] $cal(D)$ could be

+ $cal(D) = C_c^oo\(U\)$, $phi.alt_i arrow.r phi.alt$ in $cal(D)$ if there exists compact $K subset.eq U$ such that $union.big_i "supp" phi.alt_i subset.eq K$ and $partial^alpha phi.alt_i arrow.r partial^alpha phi.alt$ uniformly. Or a neighborhood basis given by $W$ such that $W inter cal(D)_K$ is open

+

]
#statement("Theorem")[
$cal(D) = C_c^oo\(U\)$ is sequential compact

]
#statement("Theorem")[
$cal(D) = C_c^oo\(U\)$ is not metrizable

]
#proof(title: "Proof")[
Let $cal(D)_K = { f in cal(D)\|"supp" f subset.eq K }$ for $K subset.eq U$ compact, they are Frechet with seminorms $sup_K\|partial^alpha f\|$, they are closed subspaces of $cal(D)$. It is easy to see that the interior of $cal(D)$ in $cal(D)$ is empty, so it is nowhere dense, By Baire's category theorem~#ref(label("Baire's category theorem"), supplement: none) and $cal(D)$ is sequential compact, $cal(D) = cal(D)_K$ is not metrizable

]
#statement("Definition")[
Suppose $cal(D)$ is a test function space. Distributions are defined to be the continuous functionals

]
#statement("Definition")[
A #emph[Banach algebra]#index-entry("Banach algebra") is an associative algebra $A$ which is a complete normed rng such that $parallel r s parallel lt.eq parallel r parallel parallel s parallel$. $A$ is #emph[unital] if $A$ is a ring with identity element having norm $1$

]
#statement("Definition")[
A #emph[\*-algebra]#index-entry("*-algebra") is a Banach algebra over $bb(C)$ such that there is an antilinear involution $* : A arrow.r A$, such that $\(x y\)^(*) = y^(*) x^(*)$. $A$ is a $C^(*)$#emph[\-algebra]#index-entry("C^*-algebra") if $parallel x^(*) x parallel = parallel x^(*) parallel parallel x parallel$

]
#statement("Example")[
$X$ is locally compact, $C_0\(X\)$ are the continuous functions vanishes at infinity, then $C_0\(X\)$ is a Banach algebra with the supremum norm, $C_0\(X\)$ is unital if $X$ is compact with $1$ being the identity. $C_0\(X\)$ is a $C^(*)$-algebra with complex conjugation as the involution

]
#statement("Definition")[
$A$ is a unital Banach algebra over $bb(R)\,bb(C)$, $e^x = sum_(k = 0)^oo frac(x^k, k !)$ defines the #emph[exponential] #display-equation($parallel e^x parallel = ∥sum_(k = 0)^oo frac(x^k, k !)∥ lt.eq sum_(k = 0)^oo ∥frac(x^k, k !)∥ lt.eq sum_(k = 0)^oo frac(parallel x parallel^k, k !) = e^(parallel x parallel)$) The #emph[logarithm] $log x = sum_(k = 1)^oo frac(\(- 1\)^(x + 1)\(x - 1\)^k, k)$ is defined on $parallel x - 1 parallel < 1$

]
#statement("Lemma")[
$e^x$ and $log x$ are inverses to each other locally

]
#statement("Proposition")[
Let $A$ be a $k$-Banach algebra, $V$ is a Banach $A$-module

+ $v'\(t\)= a v\(t\)$ with $v\(0\)= x$ has the unique solution $v\(t\)= e^(t a) x$

+ A linear map $D : A arrow.r A$ is a derivation iff $e^(t D)$ are automorphisms for all $t in k$

+ For any $a in A$, $t in k$, $a$-invariant subspaces are precisely $e^(t a)$-invariant subspaces

+ Consider the representation $A^times arrow.r "GL"\(V\)$, $\(a f\)\(x\):= f\(a^(- 1) x\)$. This induces another representation $A arrow.r frak(g l)\(V\)$ via $\(a f\)\(x\)= frac(d, d t)\|_(t = 0) f\(e^(- t a) x\)$

  Suppose $V = k\[x_1\,dots.h.c\,x_n\]$, $A = frak(g l)_n\(k\)$, $A^times = "GL"_n\(k\)$

  consider $v\(t\)= e^(t A) dot.op f := f\(e^(- t A) x\)$, then $v'\(t\)= frac(d, d t)\|_(t = 0) f\(e^(- t A) x\)= : D_A f$, where $D_A$ is a linear differential operator $V_m arrow.r V_m$ by Lemma #unresolved-reference("AV<=V <=> e^tAV<=V"), then we should have $f\(e^(- t A) x\)= v\(t\)= e^(t D_A) f$, therefore we would get $D_A = - A^T$, and it will be easy to check that $D_(\[A\,B\]) =\[D_A\,D_B\]$

+ If $\[X\,\[X\,Y\]\]= 0$, then $e^X e^Y = e^(X + Y + 1 / 2\[X\,Y\])$

]
#proof(title: "Proof")[
+

+

+ If $a V subset.eq V$, then $e^(t a) V = sum_(k = 0)^oo t^k frac(a^k, k !) V subset.eq V$. If $e^(t a) V subset.eq V\,forall t$, since $V$ is closed, $frac(d, d t)\|_(t = 0) e^(t a) V = a V subset.eq V$

+ If we denote $g =\(g_(i j)\)in G L\(n\,bb(C)\)$, $f\(x\)= sum_(i_1\,dots.h.c\,i_n) C_(i_1\,dots.h.c\,i_n) x_1^(i_1) dots.h.c x_n^(i_n)$, then $f\(g^(- 1) x\)= sum_(i_1\,dots.h.c\,i_n) C_(i_1\,dots.h.c\,i_n)\(g_11 x_1 + dots.h.c + g_(1 n) x_n\)^(i_1) dots.h.c\(g_(n 1) x_1 + dots.h.c + g_(n n) x_n\)^(i_n)$ is still a homogeneous polynomial in $n$ variables of degree $m$

  Denote $A =\(a_(i j)\)$, #display-equation($frac(d, d t)\|_(t = 0) f\(e^(- t A) x\) & = nabla f\(x\)dot.op frac(d, d t)\|_(t = 0) e^(- t A) x\
   & = - nabla f\(x\)dot.op A x\
   & = - sum_(i\,j) a_(i j) x_j frac(partial f, partial x_i)\
   & = (- sum_(i\,j) a_(i j) x_j frac(partial, partial x_i)) f\
   & =\(- nabla^T A x\)f\
   & = D_A f$) In particular, $D_A x_i = - sum_(j = 1)^n a_(i j) x_j$, thus $D_A$ has matrix $- A^T$ with respect to $x_1\,dots.h.c\,x_n$, basis of $V_1$

+ Let $A\(t\)= e^(t X) e^(t Y) e^(- t^2 / 2\[X\,Y\])$, $B\(t\)= e^(t\(X + Y\))$, then $A\(0\)= B\(0\)$, $B'\(t\)= B\(t\)\(X + Y\)$ and #display-equation($A'\(t\)= e^(t X) X e^(t Y) e^(- t^2 / 2\[X\,Y\]) + e^(t X) e^(t Y) Y e^(- t^2 / 2\[X\,Y\]) - e^(t X) e^(t Y) t\[X\,Y\]e^(- t^2 / 2\[X\,Y\])$) Since $\[X\,\[X\,Y\]\]= 0$, $\[Y\,\[X\,Y\]\]= -\[Y\,\[Y\,X\]\]= 0$ #display-equation($e^(- t Y) X e^(t Y) = A d_(e^(- t Y))\(X\)= e^(a d_(- t Y))\(X\)= X + t\[X\,Y\]$) #display-equation($A'\(t\)= e^(t X) e^(t Y)\(X + Y\)e^(- t^2 / 2\[X\,Y\]) = e^(t X) e^(t Y) e^(- t^2 / 2\[X\,Y\])\(X + Y\)= A\(t\)\(X + Y\)$) Thus $A\(t\)\,B\(t\)$ satisfies the same ODE and initial condition, $A\(t\)= B\(t\)arrow.r.double e^X e^Y = A\(1\)= B\(1\)= e^(X + Y + 1 / 2\[X\,Y\])$

]
#statement("Theorem", title: [Lie product formula])[
$e^(A + B) = lim_(n arrow.r oo) (e^(A / n) e^(B / n))^n$

]#label("Lie product formula")
#statement("Theorem", title: [Lie commutator formula])[
$e^(\[A\,B\]) = lim_(n arrow.r oo) [e^(A / n) \, e^(B / n)]^(n^2)$, the left and right $\[\,\]$ are Lie bracket and commutator

]#label("Lie commutator formula")
#statement("Theorem", title: [Backer-Campbell-Hausdorff formula])[
$e^X e^Y = e^Z$ around $0$, where $Z = X + integral_0^1 psi\(e^(a d_X) e^(t a d_Y)\)d t\(Y\)$ and #display-equation($psi\(x\) & = frac(x log x, x - 1) =^(y = 1 - x) = sum_(n = 1)^oo y^(n - 1) / n - sum_(n = 1)^oo y^n / n = 1 + sum_(n = 1)^oo (frac(y^n, n + 1) - y^n / n) = 1 - sum_(n = 1)^oo frac(\(1 - x\)^n, n\(n + 1\))$) The first few terms are #display-equation($e^X e^Y = e^(X + Y + 1 / 2\[X\,Y\]+ 1 / 12\[X\,\[X\,Y\]\]+ 1 / 12\[Y\,\[Y\,X\]\]+ dots.h.c)$)

]
#proof(title: "Proof")[
Note that $lim_(m arrow.r oo) sum_(k = 0)^(m - 1) 1 / m e^(- frac(k x, m)) = integral_0^1 e^(- t x) d t = frac(1 - e^(- x), x)$, we have #display-equation($frac(d, d t)\|_(t = 0) e^(X + t Y) & = frac(d, d t)\|_(t = 0) (e^(X / m) e^(frac(t Y, m)))^m = lim_(m arrow.r oo) frac(d, d t)\|_(t = 0) (e^(X / m) e^(frac(t Y, m)))^m = lim_(m arrow.r oo) sum_(k = 0)^(m - 1) e^(frac(k X, m)) Y / m e^(frac(\(m - k\)X, m))\
 & = lim_(m arrow.r oo) sum_(k = 0)^(m - 1) 1 / m e^(frac(k X, m)) Y e^(- frac(k X, m)) e^X = (lim_(m arrow.r oo) sum_(k = 0)^(m - 1) 1 / m e^(frac(k a d_X, m)))\(Y\)e^X = frac(e^(a d_X) - 1, a d_X)\(Y\)e^X$) Let $e^(Z\(t\)) = e^X e^(t Y)$, $frac(d, d t) e^(Z\(t\)) = frac(d, d t)\(e^X e^(t Y)\)= e^X e^(t Y) Y = e^(Z\(t\)) Y$, but $frac(d, d t) e^(Z\(t\)) = frac(d, d s)\|_(s = t) e^(Z\(s\)) = frac(d, d s)\|_(s = t) e^(Z\(t\)+ Z'\(t\)\(s - t\)) = frac(e^(a d_(Z\(t\))) - 1, a d_(Z\(t\)))\(Z'\(t\)\)e^(Z\(t\))$, hence $frac(e^(a d_(Z\(t\))) - 1, a d_(Z\(t\)))\(Z'\(t\)\)= e^(Z\(t\)) Y e^(- Z\(t\)) = A d_(e^(Z\(t\)))\(Y\)= e^(a d_(Z\(t\)))\(Y\)$, $Z'\(t\)= frac(a d_(Z\(t\)) e^(a d_(Z\(t\))), e^(a d_(Z\(t\))) - 1)\(Y\)$, since $e^(a d_(Z\(t\))) = A d_(e^(Z\(t\))) = A d_(e^X e^(t Y)) = e^(a d_X) e^(t a d_Y)$ #display-equation($Z & = Z\(1\)= Z\(0\)+ integral_0^1 frac(a d_(Z\(t\)) e^(a d_(Z\(t\))), 1 - e^(- a d_(Z\(t\))))\(Y\)d t = X + integral_0^1 frac(e^(a d_X) e^(t a d_Y) log\(e^(a d_X) e^(t a d_Y)\), e^(a d_X) e^(t a d_Y) - 1)\(Y\)d t$)

]
#statement("Theorem", title: [Stone-Weierstrass])[
$X$ is compact Hausdorff, $A subset.eq C\(X\,bb(R)\)$ is a unital subalgebra. $A$ is dense in $C\(X\,bb(R)\)$ with the topology of uniform convergence iff $A$ separates points

$S subset.eq C\(X\,bb(C)\)$ is a unital \*-algebra that separating points, then $S$ is dense in $C\(X\,bb(C)\)$

]
