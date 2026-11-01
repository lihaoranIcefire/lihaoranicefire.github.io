#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Bloch Wigner polylogarithm

#statement("Definition")[
The #emph[Bloch-Wigner polylogarithm]#index-entry("Bloch-Wigner polylogarithm") is defined as #display-equation($cal(L)_n\(z\)= Re_n (sum_(r = 0)^(n - 1) frac(2^r B_r, r !) "Li"_(n - r) \( z \) log^r \| z \|)$) Here $Re_n$ is $"Re"$ if $n$ is odd and $"Im"$ if $n$ is even. $B_n$ are Bernoulli numbers. For instance, $cal(L)_1\(z\)= log\|1 - z\|$, $cal(L)_2\(z\)= "Im"\("Li"_2\(z\)\)+ "Im"\(log\(1 - z\)\)log\|z\|$

]
#statement("Lemma")[
$cal(L)_n\(z\)+\(- 1\)^n cal(L)_n\(z^(- 1)\)= 0$. $cal(L)_3\(z\)+ cal(L)_3 (frac(1, 1 - z)) + cal(L)_3\(1 - z^(- 1)\)= zeta\(3\)$. $cal(L)_2\(z\)- cal(L)_2 (frac(1, 1 - z)) = 0$

]
