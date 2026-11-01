#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Symbols

#statement("Definition")[
The symbol mod product map is #display-equation($rho\(a_1 times.o dots.h.c times.o a_k\)= frac(k - 1, k)\[rho\(a_1 times.o dots.h.c times.o a_(k - 1)\)times.o a_k - rho\(a_2 times.o dots.h.c times.o a_k\)times.o a_1\]$) Starting with $rho\(a_1\)= a_1$

]
#aside("Note")[
Roughly $rho$ is given inductively by $frac(k - 1, k)\[rho\,1\]$

]
#statement("Theorem")[
$ker rho$ is precisely products(shuffle product) of symbols. And $rho$ is idempotent

]
