#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Ordinary differential equations

#statement("Theorem")[
Linear differential equations $y'\(t\)= A\(t\)y\(t\)+ b\(t\)$ with initial condition $y\(0\)= y_0$, where $A\,b\,y$ are smooth, then there exists unique local solution

]
#proof(title: "Proof")[
Define $T y\(t\)= integral_0^t A\(s\)y\(s\)+ b\(s\)d s + y_0$, note that $parallel T y\(t\)- T z\(t\)parallel = ∥integral_0^t A \( s \) \( y \( s \) - z \( s \) \) d s∥ lt.eq\|t\|parallel A parallel parallel y - z parallel$, then there exists $delta > 0$ such that $\|t\|parallel A parallel < 1\,forall\|t\|lt.eq delta$, here we use $parallel dot.op parallel$ to denote the supremum norm in $\|t\|lt.eq delta$, by Banach fixed point theorem, we have a unique local solution

]
#statement("Example")[
$v'\(t\)= A v\(t\)\,v\(0\)= v_0$, $A in M_n\(bb(C)\)$, the solution is $v\(t\)= e^(t A) v_0$ since $frac(d, d t) A^(t A) = A e^(t A)$

]
#statement("Theorem")[
\(#strong[Picard-Lindelöf theorem]) Suppose $f\(y\,t\)$ is uniformly Lipschitz continuous in $y$ and continuous in $t$, then the ODE #display-equation($cases(y'\(t\)= f\(y\(t\)\,t\), y\(0\)= y_0)$)Has a unique solution $y\(t\)$ on $\[- epsilon\,epsilon\]$

]#label("Picard-Lindelof theorem")
#aside("Remark")[
$f\(y\,t\)$ is Lipschitz continuous in $y$ and continuous in $t$ would implie loacl uniformly Lipschitz in $y$ and $f$ uniformly continuous

When you have a local solution, you can try to extend it to a maximal length, i.e. $y\(t\)$ is defined on $\(a\,b\)supset\[- epsilon\,epsilon\]$, it is open precisely because of the theorem

]
#proof(title: "Proof")[
Define $T y\(t\)= integral_0^t f\(y\(s\)\,s\)d s$, then \ $parallel T y - T z parallel = ∥integral_0^t f \( y \( s \) \, s \) - f \( z \( s \) \, s \) d s∥ lt.eq ∥C integral_0^t \| y \( s \) - z \( s \) \| d s∥ lt.eq C\|t\|parallel y - z parallel$, then there exists $epsilon > 0$ such that $C\|t\|< 1$, $forall t in\[- epsilon\,epsilon\]$, then by Banach fixed point theorem, we have a unique local solution

]
#statement("Theorem")[
\(#strong[Peano existence theorem]) Let $f\(y\,t\)$ be a continuous function around $\(y_0\,0\)$, then the ODE #display-equation($cases(y'\(t\)= f\(y\(t\)\,t\), y\(0\)= y_0)$)Has a local solution $y\(t\)$ on $\[- epsilon\,epsilon\]$

]#label("Peano existence theorem")
#proof(title: "Proof")[
Say $\|f\|lt.eq M$ around $\(y_0\,0\)$, Define $phi.alt_n\(t\)= cases(y_0 quad\,x lt.eq 0, y_0 + integral_0^t phi.alt_n (s - epsilon / n) d s quad\,0 lt.eq x lt.eq epsilon)$ for $n gt.eq 1$

By Arzelà-Ascoli theorem, we know that there is a subsequence $phi.alt_(n_k)$ converges on $\[- epsilon\,epsilon\]$, and the limit $phi.alt\(t\)$ satisfies $phi.alt\(t\)= y_0 + integral_0^t phi.alt_n (s) d s$ which is a local solution to the problem

]
#aside("Remark")[
The uniqueness may fail without the Lipschitz condition in $y$, for example, consider $frac(d y, d t) = y^(1 / 3)$, $y\(0\)= 0$ has solutions $y\(t\)= 0$ or $y\(t\)= plus.minus (2 / 3 t)^(3 / 2)$

]
