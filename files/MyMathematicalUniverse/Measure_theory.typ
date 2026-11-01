#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Measure theory

#statement("Definition")[
$mu$ is a finite measure on $X$ if $mu\(X\)< oo$

]
#statement("Definition")[
$mu$ is inner regular if $mu\(A\)= sup_(K subset.eq A upright(" compact")) mu\(K\)$. $mu$ is outer regular if $mu\(A\)= inf_(U supset.eq A upright(" open")) mu\(U\)$

]
#statement("Theorem", title: [Riesz--Markov--Kakutani representation theorem])[
$X$ is a locally compact Hausdorff space, for each linear functional $phi.alt : C_c\(X\)arrow.r bb(R)$, there exists a unique regular Borel measure $mu$ such that #display-equation($integral_X f d mu = phi.alt\(f\)$)

]
#aside("Note")[
The converse that a regular Borel measure defines a linear functional is obvious. $phi.alt$ is nonnegative iff $mu$ is nonnegative. The norm of $phi.alt$ is the total variation of $mu$

]
#statement("Definition")[
Suppose $X_t$, $Y_t$ are random processes with $E\(\|Y_t\|\)< oo$. $Y_t$ is called a #emph[martingale] with respect to $X_t$ if $E\(Y_t\|{ X_tau\,tau lt.eq s }\)= Y_tau$

]
