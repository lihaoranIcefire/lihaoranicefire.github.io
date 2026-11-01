#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Iterated integral

#statement("Definition")[
Chen's #emph[iterated integral] is defined to be #display-equation($integral_gamma omega_1\(t\)dots.h.c omega_n\(t\)= integral_(0 lt.eq t_1 lt.eq dots.h.c lt.eq t_n lt.eq 1) gamma^(*) omega_1\(t_1\)and dots.h.c and gamma^(*) omega_n\(t_n\)$)

]
#statement("Theorem")[
#unresolved-reference("Zhao: Multiple Zeta Functions, Multiple Polylogarithms and Their Special Values")

+ Inversion #display-equation($integral_gamma omega_1\(t\)dots.h.c omega_n\(t\)=\(- 1\)^n integral_gamma omega_n\(t\)dots.h.c omega_1\(t\)$)

+ Path composition ($gamma_1\(1\)= gamma_2\(0\)$) #display-equation($integral_(gamma_2 compose gamma_1) omega_1\(t\)dots.h.c omega_n\(t\)= sum_(i = 0)^n integral_(gamma_1) omega_1\(t\)dots.h.c omega_i\(t\)integral_(gamma_2) omega_(i + 1)\(t\)dots.h.c omega_n\(t\)$)

+ Shuffle Product #display-equation($integral_gamma omega_1\(t\)dots.h.c omega_m\(t\)integral_gamma omega_(m + 1)\(t\)dots.h.c omega_(m + n)\(t\)= sum_(sigma upright(" runs over all ")\(m\,n\) upright(" shuffles")) integral_gamma omega_(sigma^(- 1)\(1\))\(t\)dots.h.c omega_(sigma^(- 1)\(1\))\(t\)$)

+ Homotopy invariance \ $integral_gamma sum_(j = 1)^n omega_1^(\(j\)) dots.h.c omega_m^(\(j\))$ is homotopy invariant if $omega_i^(\(j\))$ are closed and $sum_j omega_(i - 1)^(\(j\)) and omega_i^(\(j\)) = 0$

]
under the standard choice of path #display-equation($I\(0\;a_1\,dots.h.c\,a_n\;1\)= integral_(0 < t_1 < dots.h.c < t_n < 1) frac(d t_1, t_1 - a_1) and dots.h.c and frac(d t_n, t_n - a_n)$)

#statement("Theorem", title: [Differential of iterated integrals])[
#display-equation($d I\(a_0\;a_1\,dots.h.c\,a_n\;a_(n + 1)\)= sum_(i = 1)^n I\(a_0\;a_1\,dots.h.c\,hat(a_i)\,dots.h.c\,a_n\;a_(n + 1)\)d log frac(\(a_(i + 1) - a_i\), a_(i + 1) - a_i)$)

]
#proof(title: "Proof")[
$d I\(a_0\;a_1\,dots.h.c\,a_n\;a_(n + 1)\)$ is #display-equation($ & sum_(i = 1)^n integral_(a_0 < t_1 < dots.h.c < t_n < a_(n + 1)) frac(d t_1, t_1 - a_1) and dots.h.c and frac(d t_i, \(t_i - a_i\)^2) and dots.h.c and frac(d t_n, t_n - a_n) d a_i\
 & = sum_(i = 1)^n integral_(a_0 < t_1 < dots.h.c < t_(i - 1) < t_(i + 1) < dots.h.c < t_n < a_(n + 1)) frac(d t_1, t_1 - a_1) and dots.h.c and (frac(1, t_(i - 1) - a_i) - frac(1, t_(i + 1) - a_i)) and dots.h.c and frac(d t_n, t_n - a_n) d a_i\
 & = sum_(i = 1)^n integral_(a_0 < t_1 < dots.h.c < t_(i - 1) < t_(i + 1) < dots.h.c < t_n < a_(n + 1)) frac(d t_1, t_1 - a_1) and dots.h.c and frac(d t_(i - 1), \(t_(i - 1) - a_(i - 1)\)\(t_(i - 1) - a_i\)) and dots.h.c and frac(d t_n, t_n - a_n) d a_i\
 & - sum_(i = 1)^n integral_(a_0 < t_1 < dots.h.c < t_(i - 1) < t_(i + 1) < dots.h.c < t_n < a_(n + 1)) frac(d t_1, t_1 - a_1) and dots.h.c and frac(d t_(i + 1), \(t_(i + 1) - a_i\)\(t_(i + 1) - a_(i + 1)\)) and dots.h.c and frac(d t_n, t_n - a_n) d a_i\
 & =$)

$d I\(0\;a_1\,dots.h.c\,a_n\;1\)$ with respect to $a_i$ is #display-equation($integral_(0 < t_1 < dots.h.c < t_n < 1) frac(d t_1, t_1 - a_1) and dots.h.c and frac(d t_i, \(t_i - a_i\)^2) and dots.h.c and frac(d t_n, t_n - a_n)$) By Fubini, we can first do integration #display-equation($integral_(t_(i - 1))^(t_(i + 1)) frac(d t_i, \(t_i - a_i\)^2) = frac(1, t_(i - 1) - a_i) - frac(1, t_(i + 1) - a_i)$) On the other hand

]
