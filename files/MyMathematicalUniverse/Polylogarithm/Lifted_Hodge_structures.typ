#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Lifted Hodge structures

Take $"Li"_(2\,1)\(x\,y\)$ for an example, we have differential equation #display-equation($d V = omega V$)

Here $omega$ is an integrable connection since $d omega - omega and omega = 0$. Let $Omega$ be such that $d Omega = omega$

Then the lifted variation matrix should be $hat(V) = e^(- Omega) V$, and we should have $d hat(V) = hat(omega) hat(V)$, but we have #display-equation($d hat(V) = d\(e^(- Omega) V\)= d\(e^(- Omega)\)e^Omega e^(- Omega) V + e^(- Omega) omega e^Omega e^(- Omega) V =\(d\(e^(- Omega)\)e^Omega + e^(- Omega) omega e^Omega\)hat(V)$) Thus $hat(omega) =\(d e^(- Omega)\)e^Omega + e^(- Omega) omega e^Omega$ gives the lifted connection form which is again integrable since #display-equation($d hat(omega) - hat(omega) and hat(omega) & = (- \( d e^(- Omega) \) and \( d e^Omega \) + \( d e^(- Omega) \) and omega e^Omega + e^(- Omega) d omega e^Omega - e^(- Omega) omega and \( d e^Omega \)) -\
 & (\( d e^(- Omega) \) e^Omega and \( d e^(- Omega) \) e^Omega + \( d e^(- Omega) \) and omega e^Omega + e^(- Omega) omega e^Omega and d \( e^(- Omega) \) e^Omega + e^(- Omega) omega and omega e^Omega)\
 & = -\(d e^(- Omega)\)and\(d e^Omega\)- e^(- Omega) omega and\(d e^Omega\)-\(d e^(- Omega)\)e^Omega and\(d e^(- Omega)\)e^Omega - e^(- Omega) omega e^Omega and\(d e^(- Omega)\)e^Omega\
 & + e^(- Omega)\(d omega - omega and omega\)e^Omega\
 & = - (d e^(- Omega) + e^(- Omega) omega) and (d e^Omega + e^Omega \( d e^(- Omega) \) e^Omega)\
 & = - (d e^(- Omega) + e^(- Omega) omega) and (d e^Omega - \( d e^Omega \) e^(- Omega) e^Omega)\
 & = 0$)

But $d e^(- Omega) = e^(- Omega) frac(e^("ad"_Omega) - 1, "ad"_Omega) omega$, thus $hat(omega) = e^(- Omega) frac(e^("ad"_Omega) + "ad"_Omega - 1, "ad"_Omega) omega e^Omega$

Conversely, $V = e^Omega hat(V)$, $d V =\(\(d e^Omega\)e^(- Omega) + e^Omega hat(omega) e^(- Omega)\)V = omega V$

Note that #display-equation($sum_(i = 0)^k\(- 1\)^i binom(n + 1, i) = 1 + sum_(i = 1)^k\(- 1\)^i (binom(n, i) + binom(n, i - 1)) =\(- 1\)^k binom(n, k)$)

#display-equation($ & sum_(p + q + r = n - 1\
p\,q\,r gt.eq 0) frac(\(- 1\)^(p + q + 1), \(p + q + 1\)! r !) Omega^p omega Omega^(q + r) + sum_(k + l = n - 1\
k\,l gt.eq 0) frac(\(- 1\)^k, k ! l !) Omega^k omega Omega^l\
 & = sum_(k + l = n - 1) Omega^k omega Omega^l (frac(\(- 1\)^k, k ! l !) + sum_(q + r = l) frac(\(- 1\)^(k + q + 1), \(k + q + 1\)! r !))\
 & = sum_(k + l = n - 1) Omega^k omega Omega^l (frac(\(- 1\)^k, k ! l !) + frac(\(- 1\)^n, n !) sum_(r = 0)^l \( - 1 \)^r binom(n, r))\
 & = sum_(k + l = n - 1) Omega^k omega Omega^l (frac(\(- 1\)^k, k ! l !) + frac(\(- 1\)^n, n !) \( - 1 \)^l binom(n - 1, l))\
 & = frac(n - 1, n !) sum_(k + l = n - 1)\(- 1\)^(k + 1) binom(n - 1, k) Omega^k omega Omega^l$)

Note that we also observe #display-equation($ & [sum_(k + l = n - 1\
k\,l gt.eq 0) \( - 1 \)^(k + 1) binom(n - 1, k) Omega^k omega Omega^l \, Omega]\
 & = sum_(k + l = n - 1\
k\,l gt.eq 0)\(- 1\)^(k + 1) binom(n - 1, k)\(Omega^k omega Omega^(l + 1) - Omega^(k + 1) omega Omega^l\)\
 & = sum_(k + l = n\
k gt.eq 0\,l gt.eq 1)\(- 1\)^(k + 1) binom(n - 1, k) Omega^k omega Omega^l - sum_(k + l = n\
l gt.eq 0\,k gt.eq 1)\(- 1\)^k binom(n - 1, k - 1) Omega^k omega Omega^l\
 & = sum_(k + l = n\
k gt.eq 0\,l gt.eq 1)\(- 1\)^(k + 1) binom(n - 1, k) Omega^k omega Omega^l + sum_(k + l = n\
l gt.eq 0\,k gt.eq 1)\(- 1\)^(k + 1) binom(n - 1, k - 1) Omega^k omega Omega^l\
 & = sum_(k + l = n\
k\,l gt.eq 0)\(- 1\)^(k + 1) binom(n, k) Omega^k omega Omega^l$)

A formula of Richard Hain says #display-equation($V & = integral I + omega + omega omega + omega omega omega + dots.h.c$) So $upright("SymbolMap")\(V\)= I + Omega + Omega times.o Omega + Omega times.o Omega times.o Omega + dots.h.c$, and $upright("SymbolToForms")\(upright("SymbolMap")\(V\)\)= hat(omega)$ which is symmetrized since #display-equation($upright("Symmetrization") (sum_(k = 0)^n \( - 1 \)^(k + 1) binom(n, k) Omega^k omega Omega^l) & = sum_(k = 0)^n\(- 1\)^(k + 1) binom(n, k) Omega^k omega Omega^l - (frac(1, n + 1) sum_(k = 0)^n \( - 1 \)^(k + 1) binom(n, k)) d\(Omega^(n + 1)\)\
 & = sum_(k = 0)^n\(- 1\)^(k + 1) binom(n, k) Omega^k omega Omega^l$)
