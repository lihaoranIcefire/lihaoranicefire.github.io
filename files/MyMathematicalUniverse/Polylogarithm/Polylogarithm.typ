#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Polylogarithm

#statement("Definition")[
The #emph[Polylogarithms]#index-entry("Polylogarithm") are #display-equation($"Li"_n\(z\)= sum_(k = 1)^oo z^k / k^n$) Note that #display-equation($"Li"_(n + 1)\(z\)= integral_0^z frac("Li"_n\(t\), t) d t\,quad "Li"_1\(z\)= - ln\(1 - z\)$) Hence #display-equation($"Li"_n\(z\)= integral_0^z (frac(d t, t))^(n - 1) frac(d t, 1 - t) = integral_0^1 (frac(d t, t))^(n - 1) frac(d t, z^(- 1) - t)$) #emph[Dilogarithm]#index-entry("Dilogarithm") $"Li"_2\(z\)= - integral_0^z frac(ln\(1 - u\), u) d u$ is the analytic continuation on $bb(C)\\{ 0\,1 }$, avoiding the the cut $\[1\,oo\]$

]
#statement("Lemma")[
$"Li"_k\(z\)$ satisfies differential equation #display-equation($[\( 1 - z \) frac(d, d z)] (z frac(d, d z))^(k - 1) y = 1$) Other solutions are $frac(ln^j z, j !)$, $1 lt.eq j lt.eq k - 1$

]
To compute the monodromy around $x = 0$, take $q\(epsilon.alt\)$ to be the loop $x = epsilon.alt e^(i t)$, we get $0$. \ To compute the monodromy around $x = 1$, take $q\(epsilon.alt\)$ to be the composition of $x =\(1 - t\)epsilon.alt + t\(1 - epsilon.alt\)$, $x = 1 - epsilon.alt e^(i t)$ and $x =\(1 - t\)\(1 - epsilon.alt\)+ t epsilon.alt$, we get $- frac(2 pi i, \(n - 1\)!) log^(n - 1) x$

The variation matrix is #display-equation($Lambda = mat(delim: "[", 1, ; "Li"_1\(x\), 1, ; "Li"_2\(x\), log x, 1; dots.v, dots.v, dots.down, dots.down; "Li"_(n - 1)\(x\), frac(log^(n - 2) x, \(n - 2\)!), dots.h.c, log x, 1, ; "Li"_n\(x\), frac(log^(n - 1) x, \(n - 1\)!), dots.h.c, frac(log^2 x, 2 !), log x, 1) tau_n\(2 pi i\)$) #display-equation($omega = mat(delim: "[", 0; - d v, 0; 0, d u, 0; dots.v, dots.v, dots.down, dots.down; 0, 0, dots.h.c, d u, 0; 0, 0, dots.h.c, 0, d u, 0; #none)$) The monodromy representation $rho$ is as follows \ For monodromy around $x = 0$ #display-equation($mat(delim: "[", 1; #none, 1; #none, 1, 1; #none, dots.v, dots.v, dots.down; #none, frac(1, n !), frac(1, \(n - 1\)!), dots.h.c, 1)$) For monodromy around $x = 1$ #display-equation($mat(delim: "[", 1; - 1, 1; #none, , dots.down; #none, , , 1)$)

$hat(bb(C)) = {\(u\,v\)in bb(C)^2\|e^u + e^v = 1 }$, $u = log x\,v = log\(1 - x\)$

$hat(cal(L))_1 : hat(bb(C)) arrow.r bb(C)\/\(2 pi i\)bb(Z)$ is just $"Li"_1$

$hat(cal(L))_2 : hat(bb(C)) arrow.r bb(C)\/\(2 pi i\)^2 bb(Z)$ is $"Li"_2\(x\)- 1 / 2 log x "Li"_1\(x\)$, $\[M_1\,M_0\]hat(cal(L))_2 =\(2 pi i\)^2$, $d hat(cal(L))_2 = 1 / 2\(u d v - v d u\)$
