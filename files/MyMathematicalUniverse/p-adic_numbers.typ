#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= p-adic numbers

#statement("Definition")[
The $p$#strong[\-adic intergers] are #display-equation($bb(Z)_p = lim_arrow.l_n bb(Z)\/p^n bb(Z) & = {\( a_0 \, a_1 \, a_2 \, dots.h.c \) in product bb(Z) \/ p^n bb(Z) mid(bar.v) a_n equiv a_m #h(0.444em) mod med p^m \, n gt.eq m}\
 & = {b_0 + b_1 p + b_2 p^2 + dots.h.c}$) Here $a_n = b_0 + b_1 p + dots.h.c + b_n p^n$

]
#statement("Example")[
If $p = 7$, we can write $3 + 6 dot.op 7 + 7^2 + 4 dot.op 7^3 + 2 dot.op 7^4 + dots.h.c$ as #display-equation($dots.h.c 24163$) with base $7$

]
#statement("Definition")[
Given $a_0 in bb(F)_p$, there is a unique solution to $x^p - x = 0$ in $bb(Z)_p$ such that $bb(Z)_p arrow.r bb(Z)_p\/p bb(Z)_p$, $x mapsto a_0$, giving the unique section the $omega : bb(F)_p arrow.r bb(Z)_p$, the restriction $omega : bb(F)_p^times arrow.r bb(Z)_p^times$ is the #emph[Teichmuller character]#index-entry("Teichmuller character"), the image is called the #emph[Teichmüller representative]#index-entry("Teichmüller representative"), the coefficients in the $p$ power series are Teichmuller coefficients

]
#statement("Definition")[
To compute additions and multiplications, we introduce #emph[Witt vectors]#index-entry("Witt vectors") $\(X_0\,X_1\,dots.h.c\,X_n\,dots.h.c\)$, define ghost components or Witt polynomials #display-equation($W_n = X^(\(n\)) = sum_(i = 0)^n p^i X_i^(p^(n - i))$) Define addition and multiplication using $X^(\(n\))$ by #display-equation($\(X + Y\)^(\(n\)) = X^(\(n\)) + Y^(\(n\))\,\(X Y\)^(\(n\)) = X^(\(n\)) Y^(\(n\))$) Thus we have #display-equation($\(X_0\,X_1\,dots.h.c\)+\(Y_0\,Y_1\,dots.h.c\) & = (X_0 + Y_0 \, X_1 + Y_1 + frac(X_0^p + Y_0^p -\(X_0 + Y_0\)^p, p) \, dots.h.c)\
\(X_0\,X_1\,dots.h.c\)times\(Y_0\,Y_1\,dots.h.c\) & =\(X_0 Y_0\,X_0^p Y_1 + X_1 Y_0^p + p X_1 Y_1\,dots.h.c\)$)

]
