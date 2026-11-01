#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Weil conjecture

#statement("Definition")[
$X$ is a non-singular $n$ dimensional projective algebraic variety over $F_q$, the #emph[zeta function] is #display-equation($zeta\(X\,s\)= exp (sum_(m = 1)^oo N_m / m q^(- m s))$) Where $N_m$ are the number of points of $X$ over $F_(q_m)$. The #emph[Weil conjectures]#index-entry("Weil conjectures") are

+ Let $T = q^(- s)$ #display-equation($zeta\(X\,s\)= frac(P_1\(T\)P_3\(T\)dots.h.c P_(2 n - 1)\(T\), P_0\(T\)P_2\(T\)dots.h.c P_(2 n)\(T\)) = product_(i = 0)^(2 n) P_i\(T\)^(\(- 1\)^(i + 1))$) Where $P_0\(T\)= 1 - T$, $P_(2 n)\(T\)= 1 - q^n T$, $P_i\(T\)$ can be split into $product_j\(1 - alpha_(i j) T\)$ over $bb(C)$. In particular, $zeta\(X\,s\)$ is a rational function of $T$

+ #display-equation($zeta\(X\,n - s\)= plus.minus q^(frac(n E, 2) - E s) zeta\(X\,s\)$) Or equivalently #display-equation($zeta\(X\,q^(- n) T^(- 1)\)= plus.minus q^(frac(n E, 2)) T^E zeta\(X\,T\)$) $E$ is the Euler characteristic. ${ alpha_(2 n - i\,1)\,alpha_(2 n - i\,2)\,dots.h.c }$ coincide with ${q^n / alpha_(i\,1) \, q^n / alpha_(i\,2) \, dots.h.c}$ in some order

+ $\|alpha_(i\,j)\|= q^(i\/2)$

+

]
#statement("Example")[
If $X$ is the $n$ dimensional projective space, $N_m = 1 + q^m + dots.h.c + q^(n m)$, $zeta\(bb(P)^n\,s\)= frac(1, \(1 - q^(- s)\)dots.h.c\(1 - q^(n - s)\))$

]
