#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Hopf algebra structure

#statement("Definition")[
Iterated integrals form a Hopf algebra $H$ with coproduct #display-equation($Delta I\(a_0\;a_1\,dots.h.c\;a_n\;a_(n + 1)\)= sum_(0 = i_0 < i_1 < dots.h.c < i_k < i_(k + 1) = n + 1) I\(a_(i_0)\;a_(i_1)\,dots.h.c\,a_(i_k)\;a_(i k + 1)\)times.o product_(p = 1)^k I\(a_(i_p)\;a_(i_p + 1)\,dots.h.c\,a_(i_(p + 1) - 1)\;a_(i_(p + 1))\)$) The product is the just shuffle product, $Delta_(i_1\,dots.h.c\,i_k)$ means those in grading $\(i_1\,dots.h.c\,i_k\)$. $Delta'\(x\)= Delta\(x\)- 1 times.o x - x times.o 1$ is the reduced coproduct. The space of indecomposables $Q\(H\)= H\/\(H_(> 0) dot.op H_(> 0)\)$ is mod products. The projection $1 / n R = P : H arrow.r Q\(H\)$, where $R$ is defined inductively as $R\(x\)= n x - mu\(1 times.o R\)Delta'\(x\)$, $mu$ is multiplication. The cobracket is defined as $delta\(x\)=\(P times.o P\)\(1 - tau\)Delta\(x\)$, $tau\(x times.o y\)= y times.o x$ \ Symbol of a multiple polylogarithm is defined to be $Delta_(1\,dots.h.c\,1)\(x\)$, and omit $log$ sign

]
