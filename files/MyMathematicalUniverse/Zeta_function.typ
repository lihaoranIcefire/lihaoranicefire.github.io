#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Zeta function

#statement("Proposition")[
#display-equation($integral_0^oo frac(x^(s - 1), e^x - 1) d x & = integral_0^oo x^(s - 1) e^(- x) sum_(n = 0)^oo e^(- n x) d x\
 & = sum_(n = 1)^oo integral_0^oo x^(s - 1) e^(- n x) d x\
 & = sum_(n = 1)^oo 1 / n^s integral_0^oo x^(s - 1) e^(- x) d x\
 & = sum_(n = 1)^oo 1 / n^s Gamma\(s\)\
 & = zeta\(s\)Gamma\(s\)$)

]
#statement("Theorem", title: [Euler's reflection formula])[
$Gamma\(z\)Gamma\(1 - z\)= frac(pi, sin\(pi z\))$, $z in.not bb(Z)$

]
