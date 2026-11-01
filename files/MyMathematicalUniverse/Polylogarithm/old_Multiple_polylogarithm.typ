#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Multiple polylogarithms (older draft)

#statement("Definition")[
The #emph[multiple polylogarithms]#index-entry("Multiple polylogarithm") are #display-equation($"Li"_(upright(bold(n)))\(upright(bold(z))\)= sum_(upright(bold(k))) upright(bold(z))^(upright(bold(k))) / upright(bold(k))^(upright(bold(n))) = integral_0^1 (frac(d t, t))^(n_1 - 1) frac(d t, a_1 - t) dots.h.c (frac(d t, t))^(n_d - 1) frac(d t, a_d - t)$) Here $upright(bold(k))$ runs over $k_1 > dots.h.c > k_d gt.eq 1$, $a_j = a_j\(upright(bold(z))\)=\(z_1 dots.h.c z_j\)^(- 1)$, $a_0 = 1$, $a_(n + 1) = 0$

]
#aside("Note")[
For $upright(bold(k))$ runs over $\(k_1\,dots.h.c\,k_d\)in bb(Z)_(gt.eq 1)^d$ #display-equation($sum_(upright(bold(k))) upright(bold(z))^(upright(bold(k))) / upright(bold(k))^(upright(bold(n))) = (sum_(k_1) z_1^(k_1) / k_1^(n_1)) dots.h.c (sum_(k_d) z_d^(k_d) / k_d^(n_d)) = "Li"_(n_1)\(z_1\)dots.h.c "Li"_(n_d)\(z_d\)$) Can be written in terms of multiple polylogarithms

]
#statement("Exercise", title: [Derivatives of polylogarithms])[
If $m_i > 1$, then #display-equation($frac(partial, partial z_i) "Li"_(upright(bold(m))'\,m_i\,upright(bold(m))'')\(upright(bold(z))'\,z_i\,upright(bold(z))''\)= 1 / z_i "Li"_(upright(bold(m))'\,m_i - 1\,upright(bold(m))'')\(upright(bold(z))'\,z_i\,upright(bold(z))''\)$) #display-equation($frac(partial, partial z_1) "Li"_(1\,upright(bold(m))')\(z_1\,z_2\,upright(bold(z))'\)= frac(1, 1 - z_1) "Li"_(upright(bold(m))')\(z_1 z_2\,upright(bold(z))'\)$) #display-equation($frac(partial, partial z_d) "Li"_(upright(bold(m))'\,1)\(upright(bold(z))'\,z_(d - 1)\,z_d\)= frac(1, 1 - z_d) "Li"_(upright(bold(m))')\(upright(bold(z))'\,z_(d - 1)\)- frac(1, z_d\(1 - z_d\)) "Li"_(upright(bold(m))')\(upright(bold(z))'\,z_(d - 1) z_d\)$) If $1 < i < d$, then #display-equation($frac(partial, partial z_i) "Li"_(upright(bold(m))'\,1\,upright(bold(m))'')\(upright(bold(z))'\,z_(i - 1)\,z_i\,z_(i + 1)\,upright(bold(z))''\) & = frac(1, 1 - z_i) "Li"_(upright(bold(m))'\,upright(bold(m))'')\(upright(bold(z))'\,z_(i - 1)\,z_i z_(i + 1)\,upright(bold(z))''\)\
 & - frac(1, z_i\(1 - z_i\)) "Li"_(upright(bold(m))'\,upright(bold(m))'')\(upright(bold(z))'\,z_(i - 1) z_i\,z_(i + 1)\,upright(bold(z))''\)$)

]
#statement("Lemma")[
Write $frak(S)_n = { 0\,1 }^n$, $upright(bold(0)) =\(0\,dots.h.c\,0\)$, $upright(bold(1)) =\(1\,dots.h.c\,1\)$, $upright(bold(u))_s =\(0\,dots.h.c\,1_arrow.t_(s upright("-th"))\,dots.h.c\,0\)$, define #emph[multiple logarithm] $cal(L)_n = "Li"_(upright(bold(1)))$, $cal(L)_0 = 1$. Denote $upright(bold(x))_j =\(x_1\,dots.h.c\,x_j x_(j + 1)\,x_(j + 2)\,dots.h.c\,x_n\)$, $upright(bold(x))_n =\(x_1\,dots.h.c\,x_(n - 1)\)$, we have #display-equation($d_j cal(L)_n\(upright(bold(x))\) & = cal(L)_(n - 1)\(upright(bold(x))_(j - 1)\)frac(d x_j, x_j\(x_j - 1\)) - cal(L)_(n - 1)\(upright(bold(x))_j\)frac(d x_j, x_j - 1)$)For $2 lt.eq j lt.eq n$, and #display-equation($d_1 cal(L)_n\(upright(bold(x))\) & = - cal(L)_(n - 1)\(upright(bold(x))_1\)frac(d x_1, x_1 - 1)$) Therefore #display-equation($d cal(L)_n\(upright(bold(x))\) & = sum_(j = 1)^n d_j cal(L)_n\(upright(bold(x))\)\
 & = sum_(j = 1)^(n - 1) (cal(L)_(n - 1) \( upright(bold(x))_j \) frac(d x_j, 1 - x_j) + cal(L)_(n - 1) \( upright(bold(x))_j \) frac(d x_(j + 1), x_(j + 1)\(x_(j + 1) - 1\))) + cal(L)_(n - 1)\(upright(bold(x))_n\)frac(d x_n, x_n - 1)\
 & = sum_(j = 1)^(n - 1) cal(L)_(n - 1)\(upright(bold(x))_j\)(- d ln \( 1 - x_j \) + d ln (frac(x_(j + 1) - 1, x_(j + 1)))) + cal(L)_(n - 1)\(upright(bold(x))_n\)frac(d x_n, x_n - 1)\
 & = sum_(j = 1)^n cal(L)_(n - 1)\(upright(bold(x))_j\)d ln (frac(1 - x_(j + 1)^(- 1), 1 - x_j))$) Here $x_(n + 1) = oo$, $cal(L)_0 = 1$

]#label("Total differential on L_n")
Suppose $upright(bold(i)) in frak(S)_n$, $\|upright(bold(i))\|= k$ and $i_(tau_1) = dots.h.c = i_(tau_k) = 1$ for some $1 lt.eq tau_1 lt.eq dots.h.c lt.eq tau_k lt.eq n$, set #display-equation($upright(bold(x))\(upright(bold(i))\)= upright(bold(y))\,quad y_m = product_(j = tau_(m - 1) + 1)^(tau_m) x_j = a_(tau_(m - 1)) / a_(tau_m)$) #display-equation($w_j\(upright(bold(x))\)= d ln (frac(1 - x_(j + 1)^(- 1), 1 - x_j))$) With $tau_0 = 0$, $w_0\(upright(bold(x))\)= 1$. A partial order $prec.curly.eq$ on $frak(S)_n$ is given by $upright(bold(i)) prec.curly.eq upright(bold(j))$ if $i_k lt.eq j_k$

Define #display-equation($X_n = {product_(j lt.eq k) \( 1 - x_j dots.h.c x_k \) = 0}\,quad S_n = bb(C)^n\\X_n$) #display-equation($X'_n = {product_i x_i product_(j lt.eq k) \( 1 - x_j dots.h.c x_k \) = 0}\,quad S'_n = bb(C)^n\\X'_n$) #display-equation($D_n = inter.big_j {lr(|x_j - 1 / 2|) < 1 / 2}$)

#statement("Theorem")[
Multiple logarithm $cal(L)_n\(upright(bold(x))\)$ is a multi-valued holomorphic function on $S_n$ #display-equation($cal(L)_n\(upright(bold(x))\)= sum_(0 eq.not upright(bold(j))_1 prec dots.h.c prec upright(bold(j))_n) integral_0^(upright(bold(x))) w_(upright(bold(j))_n - upright(bold(j))_(n - 1))\(upright(bold(x))\(upright(bold(j))_n\)\)dots.h.c w_(upright(bold(j))_2 - upright(bold(j))_1)\(upright(bold(x))\(upright(bold(j))_2\)\)w_1\(upright(bold(x))\(upright(bold(j))_1\)\)$) Here $upright(bold(j)) - upright(bold(i)) = cases(s' quad j_t = i_t + delta_(s t), 0 quad upright("otherwise"))$ for $upright(bold(i)) prec upright(bold(j))$, $j_s$ is the $s'$-th nonzero element in $upright(bold(j))$, and the integration is taken over $alpha : I arrow.r bb(C)^n$

]
#proof(title: "Proof")[
Use induction and Lemma #ref(label("Total differential on L_n"), supplement: none) #display-equation($cal(L)_n\(upright(bold(x))\) & = integral_(upright(bold(0)))^(upright(bold(x))) d cal(L)_n\(upright(bold(x))\)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) sum_(k = 1)^(n - 1) cal(L)_(n - 1)\(upright(bold(x))_k\)d ln (frac(1 - x_(k + 1)^(- 1), 1 - x_k)) + cal(L)_(n - 1)\(upright(bold(x))_n\)frac(d x_n, 1 - x_n)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) sum_(j = 1)^n w_(upright(bold(1)) - upright(bold(f))_k)\(upright(bold(x))\)sum_(0 eq.not upright(bold(p))_1 prec dots.h.c prec upright(bold(p))_(n - 1)) w_(upright(bold(p))_(n - 1) - upright(bold(p))_(n - 2))\(upright(bold(x))_k\(upright(bold(p))_(n - 1)\)\)dots.h.c w_(upright(bold(p))_2 - upright(bold(p))_1)\(upright(bold(x))_k\(upright(bold(p))_2\)\)w_1\(upright(bold(x))_k\(upright(bold(p))_1\)\)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) sum_(j = 1)^n w_(upright(bold(1)) - upright(bold(f))_k)\(upright(bold(x))\)sum_(0 eq.not upright(bold(q))_1 prec dots.h.c prec upright(bold(q))_(n - 1)) w_(upright(bold(q))_(n - 1) - upright(bold(q))_(n - 2))\(upright(bold(x))\(upright(bold(q))_(n - 1)\)\)dots.h.c w_(upright(bold(q))_2 - upright(bold(q))_1)\(upright(bold(x))\(upright(bold(q))_2\)\)w_1\(upright(bold(x))\(upright(bold(q))_1\)\)\
 & = sum_(0 eq.not upright(bold(j))_1 prec dots.h.c prec upright(bold(j))_n) integral_0^(upright(bold(x))) w_(upright(bold(j))_n - upright(bold(j))_(n - 1))\(upright(bold(x))\(upright(bold(j))_n\)\)dots.h.c w_(upright(bold(j))_2 - upright(bold(j))_1)\(upright(bold(x))\(upright(bold(j))_2\)\)w_1\(upright(bold(x))\(upright(bold(j))_1\)\)$) Here $upright(bold(f))_k =\(1\,dots.h.c\,0_arrow.t_(k upright("-th"))\,dots.h.c\,1\)$, $upright(bold(q))_i$ is $upright(bold(p))_i$ with $0$ inserted in as the $k$-th entry. Note that $S_n$ is given so that $w_i\(upright(bold(x))\(upright(bold(j))\)\)$ are defined

]
#statement("Example")[
When $n = 1$ #display-equation($cal(L)_1\(x_1\) & = integral_0^(x_1) w_1\(upright(bold(x))\(1\)\)\
 & = integral_0^(x_1) d ln (frac(1, 1 - x_1))\
 & = integral_0^(x_1) frac(d x_1, 1 - x_1)$) When $n = 2$ #display-equation($cal(L)_2\(upright(bold(x))\) & = integral_(upright(bold(0)))^(upright(bold(x))) w_(\(1\,1\)-\(1\,0\))\(upright(bold(x))\(upright(bold(1))\)\)w_1\(upright(bold(x))\(1\,0\)\)+ w_(\(1\,1\)-\(0\,1\))\(upright(bold(x))\(upright(bold(1))\)\)w_1\(upright(bold(x))\(0\,1\)\)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) w_2\(upright(bold(x))\)w_1\(x_1\)+ w_1\(upright(bold(x))\)w_1\(x_1 x_2\)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) d ln (frac(1, 1 - x_2)) d ln (frac(1, 1 - x_1)) + d ln (frac(1 - x_2^(- 1), 1 - x_1)) d ln (frac(1, 1 - x_1 x_2))\
 & = integral_(upright(bold(0)))^(upright(bold(x))) frac(d x_2, 1 - x_2) frac(d x_1, 1 - x_1) + (frac(d x_2, x_2\(x_2 - 1\)) + frac(d x_1, 1 - x_1)) frac(d\(x_1 x_2\), 1 - x_1 x_2)\
$) When $n = 3$ #display-equation($cal(L)_3\(upright(bold(x))\) & = integral_(upright(bold(0)))^(upright(bold(x))) w_(\(1\,1\,1\)-\(1\,1\,0\))\(upright(bold(x))\(upright(bold(1))\)\)w_(\(1\,1\,0\)-\(1\,0\,0\))\(upright(bold(x))\(1\,1\,0\)\)w_1\(upright(bold(x))\(1\,0\,0\)\)+\
 & w_(\(1\,1\,1\)-\(1\,1\,0\))\(upright(bold(x))\(upright(bold(1))\)\)w_(\(1\,1\,0\)-\(0\,1\,0\))\(upright(bold(x))\(1\,1\,0\)\)w_1\(upright(bold(x))\(0\,1\,0\)\)+\
 & w_(\(1\,1\,1\)-\(1\,0\,1\))\(upright(bold(x))\(upright(bold(1))\)\)w_(\(1\,0\,1\)-\(1\,0\,0\))\(upright(bold(x))\(1\,0\,1\)\)w_1\(upright(bold(x))\(1\,0\,0\)\)+\
 & w_(\(1\,1\,1\)-\(1\,0\,1\))\(upright(bold(x))\(upright(bold(1))\)\)w_(\(1\,0\,1\)-\(0\,0\,1\))\(upright(bold(x))\(1\,0\,1\)\)w_1\(upright(bold(x))\(0\,0\,1\)\)+\
 & w_(\(1\,1\,1\)-\(0\,1\,1\))\(upright(bold(x))\(upright(bold(1))\)\)w_(\(0\,1\,1\)-\(0\,1\,0\))\(upright(bold(x))\(0\,1\,1\)\)w_1\(upright(bold(x))\(0\,1\,0\)\)+\
 & w_(\(1\,1\,1\)-\(0\,1\,1\))\(upright(bold(x))\(upright(bold(1))\)\)w_(\(0\,1\,1\)-\(0\,0\,1\))\(upright(bold(x))\(0\,1\,1\)\)w_1\(upright(bold(x))\(0\,0\,1\)\)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) w_3\(upright(bold(x))\)w_2\(x_1\,x_2\)w_1\(x_1\)+ w_3\(upright(bold(x))\)w_1\(x_1\,x_2\)w_1\(x_1 x_2\)+\
 & w_2\(upright(bold(x))\)w_2\(x_1\,x_2 x_3\)w_1\(x_1\)+ w_2\(upright(bold(x))\)w_1\(x_1\,x_2 x_3\)w_1\(x_1 x_2 x_3\)+\
 & w_1\(upright(bold(x))\)w_2\(x_1 x_2\,x_3\)w_1\(x_1 x_2\)+ w_1\(upright(bold(x))\)w_1\(x_1 x_2\,x_3\)w_1\(x_1 x_2 x_3\)\
 & = integral_(upright(bold(0)))^(upright(bold(x))) frac(d x_3, 1 - x_3) frac(d x_2, 1 - x_2) frac(d x_1, 1 - x_1) + frac(d x_3, 1 - x_3) (frac(d x_2, x_2\(x_2 - 1\)) + frac(d x_1, 1 - x_1)) frac(d\(x_1 x_2\), 1 - x_1 x_2) +\
 & (frac(d x_3, x_3\(x_3 - 1\)) + frac(d x_2, 1 - x_2)) frac(d\(x_2 x_3\), 1 - x_2 x_3) frac(d x_1, 1 - x_1) +\
 & (frac(d x_3, x_3\(x_3 - 1\)) + frac(d x_2, 1 - x_2)) (frac(d\(x_2 x_3\), x_2 x_3\(x_2 x_3 - 1\)) + frac(d x_1, 1 - x_1)) frac(d\(x_1 x_2 x_3\), 1 - x_1 x_2 x_3) +\
 & (frac(d x_2, x_2\(x_2 - 1\)) + frac(d x_1, 1 - x_1)) frac(d x_3, 1 - x_3) frac(d\(x_1 x_2\), 1 - x_1 x_2) +\
 & (frac(d x_2, x_2\(x_2 - 1\)) + frac(d x_1, 1 - x_1)) (frac(d x_3, x_3\(x_3 - 1\)) + frac(d\(x_1 x_2\), 1 - x_1 x_2)) frac(d\(x_1 x_2 x_3\), 1 - x_1 x_2 x_3)\
$)

]
#statement("Definition")[
$upright(bold(i))\,upright(bold(j)) in frak(S)_n$, $\|upright(bold(i))\|= k$, $\|upright(bold(j))\|= l$, the $upright(bold(i))$-th #emph[retraction] map $rho_(upright(bold(i))) : frak(S)_n arrow.r frak(S)_k$ is defined by

- If $upright(bold(i)) succ.curly.eq.not upright(bold(j))$, $rho_(upright(bold(i)))\(upright(bold(j))\)= upright(bold(0))$

- If $upright(bold(i)) succ.curly.eq upright(bold(j))$, assume $tau_1\,dots.h.c\,tau_k$ and $t_1\,dots.h.c\,t_l$ are the nonzero entries in $upright(bold(i))$ and $upright(bold(j))$, suppose $tau_(alpha_r) = t_r$, then $alpha_1\,dots.h.c\,alpha_l$ are the nonzero entries of $rho_(upright(bold(i)))\(upright(bold(j))\)$

Write $theta_s = theta_s\(upright(bold(x))\)= frac(d t, t - a_s)$, the $2^n times 2^n$#emph[variation matrix] $cal(M)_(upright(bold(1)))\(upright(bold(x))\)=\(2 pi i\)^l E_(upright(bold(i))\,upright(bold(j)))\(upright(bold(x))\)$ associated with $cal(L)_n\(upright(bold(x))\)$ is defined by #display-equation($E_(upright(bold(i))\,upright(bold(j))) = gamma_(rho_(upright(bold(i)))\(upright(bold(j))\))^k\(upright(bold(y))\) & =\(- 1\)^(k - l) product_(r = 0)^l integral_(a_(alpha_(r + 1))\(upright(bold(y))\))^(a_(alpha_r)\(upright(bold(y))\)) theta_(alpha_r + 1)\(upright(bold(y))\)dots.h.c theta_(alpha_(r + 1) - 1)\(upright(bold(y))\)\
 & =\(- 1\)^(k - l) product_(r = 0)^l integral_(a_(t_(r + 1)))^(a_(t_r)) theta_(tau_(alpha_r + 1))\(upright(bold(x))\)dots.h.c theta_(tau_(alpha_(r + 1) - 1))\(upright(bold(x))\)\
 & =\(- 1\)^(k - l) product_(r = 0)^l integral_(p_r) theta_(tau_(alpha_r + 1))\(upright(bold(x))\)dots.h.c theta_(tau_(alpha_(r + 1) - 1))\(upright(bold(x))\)$) $tau_(k + 1) = t_(l + 1) = n + 1$, $alpha_(l + 1) = k + 1$. $p_r$ are independent from $upright(bold(i))$ These thetas are very weird

]
#statement("Proposition")[
#display-equation($E_(upright(bold(i))\,upright(bold(j))) & = product_(r = 0)^l cal(L)_(alpha_(r + 1) - alpha_r - 1) (frac(a_(t_r)\(upright(bold(x))\)- a_(t_(r + 1))\(upright(bold(x))\), a_(tau_(alpha_r + 1))\(upright(bold(x))\)- a_(t_(r + 1))\(upright(bold(x))\)) \, dots.h.c \, frac(a_(tau_(alpha_(r + 1) - 2))\(upright(bold(x))\)- a_(t_(r + 1))\(upright(bold(x))\), a_(tau_(alpha_(r + 1) - 1))\(upright(bold(x))\)- a_(t_(r + 1))\(upright(bold(x))\)))\
 & = cal(L)_(k - alpha_l)\(x_(1 + t_l) dots.h.c x_(tau_(alpha_l + 1))\,dots.h.c\,x_(1 + tau_(k - 1)) dots.h.c x_(tau_k)\)dot.op\
 & product_(r = 0)^(l - 1) cal(L)_(alpha_(r + 1) - alpha_r - 1) (frac(1 - x_(1 + t_r) dots.h.c x_(t_(r + 1)), 1 - x_(1 + tau_(alpha_r + 1)) dots.h.c x_(t_(r + 1))) \, dots.h.c \, frac(1 - x_(1 + tau_(alpha_(r + 1) - 2)) dots.h.c x_(t_(r + 1)), 1 - x_(1 + tau_(alpha_(r + 1) - 1)) dots.h.c x_(t_(r + 1))))$)

]
#proof(title: "Proof")[

]
#statement("Example")[
#display-equation($E_(upright(bold(1))\,upright(bold(j)))\(upright(bold(x))\)= gamma_(upright(bold(j)))^n\(upright(bold(x))\) & = product_(r = 0)^l cal(L)_(t_(r + 1) - t_r - 1) (frac(a_(t_r) - a_(t_(r + 1)), a_(t_r + 1) - a_(t_(r + 1))) \, dots.h.c \, frac(a_(t_(r + 1) - 2) - a_(t_(r + 1)), a_(t_(r + 1) - 1) - a_(t_(r + 1))))\
 & = product_(r = 0)^l cal(L)_(t_(r + 1) - t_r - 1) (frac(1 - x_(1 + t_r) dots.h.c x_(t_(r + 1)), 1 - x_(2 + t_r) dots.h.c x_(t_(r + 1))) \, dots.h.c \, frac(1 - x_(t_(r + 1) - 1) x_(t_(r + 1)), 1 - x_(t_(r + 1))))\
 & = cal(L)_(k - alpha_l)\(x_(1 + t_l) dots.h.c x_(t_l + 1)\,dots.h.c\,x_n\)dot.op\
 & product_(r = 0)^(l - 1) cal(L)_(t_(r + 1) - t_r - 1) (frac(1 - x_(1 + t_r) dots.h.c x_(t_(r + 1)), 1 - x_(2 + t_r) dots.h.c x_(t_(r + 1))) \, dots.h.c \, frac(1 - x_(t_(r + 1) - 1) x_(t_(r + 1)), 1 - x_(t_(r + 1))))$) In particular we have #display-equation($E_(upright(bold(1))\,upright(bold(0)))\(upright(bold(x))\)= gamma_(upright(bold(0)))^n\(upright(bold(x))\)= cal(L)_n\(upright(bold(x))\)\,quad E_(upright(bold(1))\,upright(bold(1)))\(upright(bold(x))\)= gamma_(upright(bold(1)))^n\(upright(bold(x))\)= product_(r = 0)^n cal(L)_0 = 1$)

]
$E = E\(upright(bold(x))\)$ has columns #display-equation($C_(upright(bold(j))) = sum_(upright(bold(i)) succ.curly.eq upright(bold(j))) gamma_(rho_(upright(bold(i)))\(upright(bold(j))\))^(\|upright(bold(i))\|)\(upright(bold(x))\(upright(bold(i))\)\)e_(upright(bold(i)))$) $e_(upright(bold(i)))$ is the standard unit column vector, using the complete order $upright(bold(<))$ on $frak(S)_n$: if $\|upright(bold(i))\|<\|upright(bold(j))\|$, then $upright(bold(i)) < upright(bold(j))$, if $\|upright(bold(i))\|=\|upright(bold(j))\|$, then compare the lexicographic order from left to right with $1 < 0$. By definition, the $upright(bold(i))$-th row of $cal(M)_(upright(bold(1)))$ is #display-equation($R_(upright(bold(i))) = sum_(upright(bold(i)) succ.curly.eq upright(bold(j)))\(2 pi i\)^(\|upright(bold(j))\|) gamma_(rho_(upright(bold(i)))\(upright(bold(j))\))^(\|upright(bold(i))\|)\(upright(bold(x))\(upright(bold(i))\)\)e_(upright(bold(j)))^T$) And the $upright(bold(j))$-th column of $cal(M)_(upright(bold(1)))$ is $\(2 pi i\)^(\|upright(bold(j))\|) C_(upright(bold(j)))$ Note that $gamma_(rho_(upright(bold(i)))\(upright(bold(i))\))^(\|upright(bold(i))\|)\(upright(bold(x))\(upright(bold(i))\)\)= 1$, and the first entry of $R_(upright(bold(i)))$ is $cal(L)_(\|upright(bold(i))\|)\(upright(bold(x))\(upright(bold(i))\)\)$

#statement("Example")[
The variation matrix associated with double logarithm is #display-equation($cal(M)_(1\,1) & = mat(delim: "[", gamma_(rho_(\(0\,0\))\(0\,0\))^0, \(2 pi i\)gamma_(rho_(\(0\,0\))\(1\,0\))^0, \(2 pi i\)gamma_(rho_(\(0\,0\))\(0\,1\))^0, \(2 pi i\)^2 gamma_(rho_(\(0\,0\))\(1\,1\))^0; gamma_(rho_(\(1\,0\))\(0\,0\))^1\(x_1\), \(2 pi i\)gamma_(rho_(\(1\,0\))\(1\,0\))^1\(x_1\), \(2 pi i\)gamma_(rho_(\(1\,0\))\(0\,1\))^1\(x_1\), \(2 pi i\)^2 gamma_(rho_(\(1\,0\))\(1\,1\))^1\(x_1\); gamma_(rho_(\(0\,1\))\(0\,0\))^1\(x_1 x_2\), \(2 pi i\)gamma_(rho_(\(0\,1\))\(1\,0\))^1\(x_1 x_2\), \(2 pi i\)gamma_(rho_(\(0\,1\))\(0\,1\))^1\(x_1 x_2\), \(2 pi i\)^2 gamma_(rho_(\(0\,1\))\(1\,1\))^1\(x_1 x_2\); gamma_(rho_(\(1\,1\))\(0\,0\))^2\(x_1\,x_2\), \(2 pi i\)gamma_(rho_(\(1\,1\))\(1\,0\))^2\(x_1\,x_2\), \(2 pi i\)gamma_(rho_(\(1\,1\))\(0\,1\))^2\(x_1\,x_2\), \(2 pi i\)^2 gamma_(rho_(\(1\,1\))\(1\,1\))^2\(x_1\,x_2\))\
 & = mat(delim: "[", 1, , , ; cal(L)_1\(x_1\), 2 pi i, , ; cal(L)_1\(x_1 x_2\), , 2 pi i, ; cal(L)_2\(x_1\,x_2\), \(2 pi i\)cal(L)_1\(x_2\), \(2 pi i\)cal(L)_1 (frac(1 - x_1 x_2, 1 - x_2)), \(2 pi i\)^2)$)

]
#statement("Lemma")[
The variation matrix is lower triangular. The principal submatrix of $cal(M)_(upright(bold(1)))$ with $\|upright(bold(i))\|=\|upright(bold(j))\|= k$ is $\(2 pi i\)^k$ times the $binom(n, k) times binom(n, k)$ identity matrix

]#label("Variation matrix of multiple logarithm is lower triangular ans principal submatrix is a scalar matrix")
#proof(title: "Proof")[
By definition

]
#statement("Proposition")[
$cal(M)_(upright(bold(1)))\(upright(bold(x))\)$ is the fundamental matrix of linear differential equations #display-equation($cases(d X_(upright(bold(i))) quad = sum_(\|upright(bold(k))\|=\|upright(bold(i))\|- 1\,upright(bold(k)) prec upright(bold(i))) d rho_(upright(bold(i)))^(\|upright(bold(i))\|)\(upright(bold(k))\)\(upright(bold(x))\(upright(bold(i))\)\)X_(upright(bold(k))), d X_(upright(bold(0))) quad = upright(bold(0)))$)

]#label("Variation matrix is the fundamental matrix")
#statement("Theorem")[

]
#statement("Corollary")[
The monodromy representation $rho_(upright(bold(x))) : pi_1\(S_n\,upright(bold(x))\)arrow.r "GL"_(2^n)\(bb(Z)\)$ is unipotent

]
#statement("Definition")[
Let $cal(D)_n = X'_n union\(bb(C P)^n\\bb(C)^n\)$ and #display-equation($bold(omega) =\(c_(upright(bold(i\,j)))\)in H^0\(bb(C P)^n\,Omega_(bb(C P)^n)^1\(log\(cal(D)_n\)\)\)times.o M_(2^n)\(bb(C)\)$) Here #display-equation($c_(upright(bold(i\,j))) = cases(d gamma_(rho_(upright(bold(i)))\(upright(bold(j))\))^(\|upright(bold(i))\|)\(upright(bold(x))\(upright(bold(i))\)\)quad\|upright(bold(j))\|=\|upright(bold(i))\|- 1\,upright(bold(j)) prec upright(bold(i)), upright(bold(0)) quad upright("otherwise"))$) All one forms in $bold(omega)$ has logarithmic singularity. By Proposition #ref(label("Variation matrix is the fundamental matrix"), supplement: none), $d cal(M)_(upright(bold(1))) = bold(omega) cal(M)_(upright(bold(1)))$, thus #display-equation($upright(bold(0)) = d^2 cal(M)_(upright(bold(1))) = d bold(omega) and cal(M)_(upright(bold(1))) - bold(omega) and d cal(M)_(upright(bold(1))) = d bold(omega) and cal(M)_(upright(bold(1))) - bold(omega) and bold(omega) cal(M)_(upright(bold(1)))$) Since $cal(M)_(upright(bold(1)))\(upright(bold(x))\)$ is invertible and $bold(omega)$ is by definition closed, i.e. $d bold(omega) = 0$, hence $bold(omega) and bold(omega) = 0$, which implies $bold(omega)$ is integrable. Define a meromorphic connection on trivial bundle $bb(C P)^n times bb(C)^(2^n) arrow.r bb(C P)^n$ #display-equation($nabla f = d f - bold(omega) f$) Here $f : S_n arrow.r bb(C)^(2^n)$ is a section

]
#statement("Example")[
If $n = 2$ #display-equation($bold(omega) = mat(delim: "[", #none, , , ; - d ln\(1 - x_1\), , , ; - d ln\(1 - x_1 x_2\), , , ; #none, - d ln\(1 - x_2\), - d ln (frac(x_2\(x_1 - 1\), 1 - x_2)), )$)

]
#statement("Definition")[
Let $V_(upright(bold(1)))\(upright(bold(x))\)$ be the locally constant sheaf of $bb(Q)$ vector space generated by the column vectors in $cal(M)_(upright(bold(1)))\(upright(bold(x))\)$, define a weight filtration $W_bullet$ by letting $W_(2 k + 1) = W_(2 k)$ and $W_(- 2 k)$ is generated by $\(2 pi i\)^(\|upright(bold(j))\|) C_(upright(bold(j)))\(upright(bold(x))\)$, $\|upright(bold(j))\|gt.eq k$, and $W_(- 2 k) = 0$ for $k > n$, note that $W_(- 2 k) = V_(upright(bold(1)))\(upright(bold(x))\)$ for $k gt.eq n$. Define filtration $cal(F)^bullet$ by $cal(F)^(- k) V_(upright(bold(1)))\(bb(C)\)= chevron.l e_(upright(bold(i)))\,\|upright(bold(i))\|lt.eq k chevron.r_(bb(C))$, $cal(F)^(- k) = 0$ for $k < 0$, note that $cal(F)^(- k) = V_(upright(bold(1)))\(bb(C)\)$ for $k gt.eq n$. By induction on $n$ and Lemma #ref(label("Variation matrix of multiple logarithm is lower triangular ans principal submatrix is a scalar matrix"), supplement: none) #display-equation($cal(F)^(- p) inter W_(- 2 k)\(bb(C)\)= cases(0 quad p lt.eq k - 1, chevron.l\(2 pi i\)^(\|upright(bold(j))\|) e_(upright(bold(j)))\,k lt.eq\|upright(bold(j))\|lt.eq p chevron.r quad k lt.eq p lt.eq n, chevron.l\(2 pi i\)^(\|upright(bold(j))\|) e_(upright(bold(j)))\,k lt.eq\|upright(bold(j))\|lt.eq n chevron.r quad p > n)$) Which implies that #display-equation($cal(F)^(- p)\("gr"_(- 2 k)^W V_(upright(bold(1)))\)\(bb(C)\)= cases(0 quad p lt.eq k - 1, W_(- 2 k) V_(upright(bold(1)))\(bb(C)\)\/W_(- 2 k - 1) V_(upright(bold(1)))\(bb(C)\)= "gr"_(- 2 k)^W V_(upright(bold(1)))\(bb(C)\)quad k lt.eq p)$) $"gr"_(- 2 k)^W V_(upright(bold(1)))\(bb(C)\)$ is isomorphic to a direct sum of $binom(n, k)$ copies of Tate structure $bb(Z)\(k\)$

]
Let $cal(D) subset.eq bb(C P)^n$ be a subvariety, $T_(cal(D))$ be the restriction of $cal(M)_(upright(bold(1)))$ on $cal(D)$, $N_(cal(D)) = log T_(cal(D))\/\(2 pi i\)$, note that $N_(cal(D))$ is well defined since $T_(cal(D))$ is unipotent

#statement("Definition")[
$X$ is a complex manifold of dimension $d$, $X arrow.r.hook^j tilde(X)$ is an embedding, $D = tilde(X) - X$ is a divisor with normal crossings, let $bb(V)$ is a unipotent local system of complex vector spaces over $X$, $cal(V)$ is a corresponding vector bundle. By Theorem #ref(label("Deligne's theorem on unipotent VMHS"), supplement: none), there is a canonical extension of $cal(V)$ to $tilde(cal(V))$ over $tilde(X)$

]
#statement("Definition")[
Variation matrix $cal(M)_(upright(bold(n)))$

]
#statement("Example")[
$\(1\,0\,x^(- 1)\,x^(- 1) y^(- 1)\,0\)=\(1\,0\,a_1\,a_2\,0\)=\(b_0\,b_1\,b_2\,b_3\,b_4\)$, we have #display-equation($ & #box(stroke: black, inset: 3pt, [$ 1 $])\|0\|a_1\|a_2\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(0\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|0\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|a_2\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|0\|a_1\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|a_2\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(2\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|0\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,1\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\|a_1\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(2\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(2\,1\)$) Therefore (columns tells how many pieces in multiplication, rows tells which can be chosen in the iterated integral) #display-equation($cal(M)_(2\,1) = mat(delim: "[", 1, , , , , , ; "Li"_1\(x\), 1, , , , , ; "Li"_1\(x y\), 0, 1, , , , ; "Li"_2\(x\), log\(x\), 0, 1, , , ; "Li"_(1\,1)\(x\,y\), "Li"_1\(y\), "Li"_1\(x\)- "Li"_1\(y^(- 1)\), 0, 1, , ; "Li"_2\(x y\), 0, log\(x y\), 0, 0, 1, ; "Li"_(2\,1)\(x\,y\), "Li"_1\(y\)log\(x\), g\(x\,y\), "Li"_1\(y\), log\(x\), - "Li"_1\(y^(- 1)\), 1)$) Here #display-equation($g\(x\,y\) & = integral_(x^(- 1) y^(- 1))^1 frac(d t, t) frac(d t, x^(- 1) - t)\
 & = integral_(x^(- 1) y^(- 1))^1 frac(d t, t) integral_(x^(- 1) y^(- 1))^t frac(d tau, x^(- 1) - tau)\
 & = integral_(x^(- 1) y^(- 1))^1 frac(d t, t) ("Li"_1 \( x t \) - "Li"_1 \( y^(- 1) \))\
 & = integral_(x^(- 1) y^(- 1))^1 frac(d t, t) "Li"_1\(x t\)- "Li"_1\(y^(- 1)\)integral_(x^(- 1) y^(- 1))^1 frac(d t, t)\
 & = integral_(y^(- 1))^x frac(d t, t) "Li"_1\(t\)- "Li"_1\(y^(- 1)\)log\(x y\)\
 & = "Li"_2\(x\)- "Li"_2\(y^(- 1)\)- "Li"_1\(y^(- 1)\)log\(x y\)$)

]
#aside("Note")[
Note that $"Li"_1\(x\)- "Li"_1\(y^(- 1)\)= "Li"_1 (frac(1 - x y, 1 - y))$

]
#statement("Example")[
$\(1\,x^(- 1)\,0\,x^(- 1) y^(- 1)\,0\)=\(1\,a_1\,0\,a_2\,0\)=\(b_0\,b_1\,b_2\,b_3\,b_4\)$, we have #display-equation($ & #box(stroke: black, inset: 3pt, [$ 1 $])\|a_1\|0\|a_2\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(0\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|0\|a_2\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|a_1\|0\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|0\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,1\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|a_1\|#box(stroke: black, inset: 3pt, [$ 0 $])\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(2\,0\)\
 & #box(stroke: black, inset: 3pt, [$ 1 $])\|#box(stroke: black, inset: 3pt, [$ a_1 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\|#box(stroke: black, inset: 3pt, [$ a_2 $])\|#box(stroke: black, inset: 3pt, [$ 0 $])\,quad upright(bold(m)) =\(1\,2\)$) #display-equation($cal(M)_(1\,2) = mat(delim: "[", 1, , , , , ; "Li"_1\(x\), 1, , , , ; "Li"_1\(x y\), 0, 1, , , ; "Li"_(1\,1)\(x\,y\), "Li"_1\(y\), "Li"_1\(x\)- "Li"_1\(y^(- 1)\), 1, , ; "Li"_2\(x y\), 0, log\(x y\), 0, 1, ; "Li"_(1\,2)\(x\,y\), "Li"_2\(y\), g\(x\,y\), log\(y\), "Li"_1\(x\), 1; #none)$) Here #display-equation($g\(x\,y\) & = integral_(x^(- 1) y^(- 1))^1 frac(d t, x^(- 1) - t) frac(d t, t)\
 & = integral_(x^(- 1) y^(- 1))^1 frac(d t, x^(- 1) - t) integral_(x^(- 1) y^(- 1))^t frac(d tau, tau)\
 & = integral_(x^(- 1) y^(- 1))^1 frac(d t, x^(- 1) - t) (log \( t \) + log \( x y \))\
 & = integral_(x^(- 1) y^(- 1))^1 frac(d t, x^(- 1) - t) log\(t\)+ log\(x y\)integral_(x^(- 1) y^(- 1))^1 frac(d t, x^(- 1) - t)\
 & = integral_(y^(- 1))^x frac(d t, 1 - t)\(log\(t\)- log\(x\)\)+ log\(x y\)integral_(y^(- 1))^x frac(d t, 1 - t)\
 & = integral_(y^(- 1))^x frac(d t, 1 - t) log\(t\)+ log\(y\)"Li"_1 (frac(1 - x y, 1 - y))\
 & = log\(y\)"Li"_1 (frac(1 - x y, 1 - y)) + integral_(y^(- 1))^x log\(t\)d "Li"_1\(t\)\
 & = log\(y\)"Li"_1 (frac(1 - x y, 1 - y)) + log \( t \) "Li"_1 \( t \)\|_(y^(- 1))^x - integral_(y^(- 1))^x frac(d t, t) "Li"_1\(t\)\
 & = log\(y\)"Li"_1 (frac(1 - x y, 1 - y)) + log\(x\)"Li"_1\(x\)+ log\(y\)"Li"_1\(y^(- 1)\)- "Li"_2\(x\)+ "Li"_2\(y^(- 1)\)\
$)

]
