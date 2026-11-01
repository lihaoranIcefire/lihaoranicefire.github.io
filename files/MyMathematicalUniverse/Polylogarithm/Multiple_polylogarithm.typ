#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Multiple polylogarithm

#statement("Definition")[
The #emph[multiple polylogarithms]#index-entry("Multiple polylogarithm") are #display-equation($"Li"_(upright(bold(n)))\(upright(bold(x))\)= sum_(upright(bold(k))) upright(bold(x))^(upright(bold(k))) / upright(bold(k))^(upright(bold(n))) = integral_0^1 frac(d t, a_1 - t) (frac(d t, t))^(n_1 - 1) dots.h.c frac(d t, a_d - t) (frac(d t, t))^(n_d - 1)$) Here $upright(bold(k))$ runs over $0 < k_1 < dots.h.c < k_d$, $a_j = a_j\(upright(bold(x))\)=\(x_j dots.h.c x_d\)^(- 1)$

]
Define $"Li"_0\(x\)= frac(x, 1 - x)$

#aside("Note")[
For $upright(bold(k))$ runs over $\(k_1\,dots.h.c\,k_d\)in bb(Z)_(gt.eq 1)^d$ #display-equation($sum_(upright(bold(k))) upright(bold(x))^(upright(bold(k))) / upright(bold(k))^(upright(bold(n))) = (sum_(k_1) x_1^(k_1) / k_1^(n_1)) dots.h.c (sum_(k_d) x_d^(k_d) / k_d^(n_d)) = "Li"_(n_1)\(x_1\)dots.h.c "Li"_(n_d)\(x_d\)$) Can be written in terms of multiple polylogarithms

]
#aside("Note")[
#display-equation($"Li"_(n_1\,dots.h.c\,n_(i - 1)\,0\,n_(i + 1)\,dots.h.c\,n_d)\(x_1\,dots.h.c\,x_d\) & = sum_(0 < k_1 < dots.h.c < k_d) frac(x_1^(k - 1) dots.h.c x_d^(k_d), k_1^(n_1) dots.h.c k_(i - 1)^(n_(i - 1)) k_(i + 1)^(n_(i + 1)) dots.h.c k_d^(n_d))\
 & = sum_(0 < k_1 < dots.h.c < k_d) frac(x_1^(k - 1) dots.h.c x_(i - 1)^(k_(i - 1)) x_(i + 1)^(k_(i + 1)) dots.h.c x_d^(k_d), k_1^(n_1) dots.h.c k_(i - 1)^(n_(i - 1)) k_(i + 1)^(n_(i + 1)) dots.h.c k_d^(n_d)) frac(x_i^(k_(i - 1) + 1) - x_i^(k_(i + 1)), 1 - x_i)\
 & = sum_(0 < k_1 < dots.h.c < k_d) frac(x_1^(k - 1)\(dots.h.c x_(i - 1) x_i\)^(k_(i - 1)) x_(i + 1)^(k_(i + 1)) dots.h.c x_d^(k_d), k_1^(n_1) dots.h.c k_(i - 1)^(n_(i - 1)) k_(i + 1)^(n_(i + 1)) dots.h.c k_d^(n_d)) frac(x_i, 1 - x_i)\
 & - sum_(0 < k_1 < dots.h.c < k_d) frac(x_1^(k - 1) dots.h.c x_(i - 1)^(k_(i - 1))\(x_i x_(i + 1)\)^(k_(i + 1)) dots.h.c x_d^(k_d), k_1^(n_1) dots.h.c k_(i - 1)^(n_(i - 1)) k_(i + 1)^(n_(i + 1)) dots.h.c k_d^(n_d)) frac(1, 1 - x_i)\
 & = "Li"_(n_1\,dots.h.c\,n_(i - 1)\,n_(i + 1)\,dots.h.c\,n_d)\(x_1\,dots.h.c\,x_(i - 1) x_i\,x_(i + 1)\,dots.h.c\,x_d\)frac(x_i, 1 - x_i)\
 & - "Li"_(n_1\,dots.h.c\,n_(i - 1)\,n_(i + 1)\,dots.h.c\,n_d)\(x_1\,dots.h.c\,x_(i - 1)\,x_i x_(i + 1)\,dots.h.c\,x_d\)frac(1, 1 - x_i)$) #display-equation($"Li"_(n_1\,dots.h.c\,n_(d - 1)\,0)\(x_1\,dots.h.c\,x_d\) & = "Li"_(n_1\,dots.h.c\,n_(d - 1))\(x_1\,dots.h.c\,x_(d - 1) x_d\)frac(x_d, 1 - x_d)$) #display-equation($"Li"_(0\,n_2\,dots.h.c\,n_d)\(x_1\,dots.h.c\,x_d\) & = "Li"_(n_2\,dots.h.c\,n_(d - 1))\(x_2\,dots.h.c\,x_d\)frac(x_1, 1 - x_1) - "Li"_(n_2\,dots.h.c\,n_(d - 1))\(x_1 x_2\,dots.h.c\,x_d\)frac(1, 1 - x_1)$)

]
#statement("Exercise", title: [Derivatives of polylogarithms])[
Observe the following #display-equation($frac(partial, partial x_i) (sum_(upright(bold(k))) frac(dots.h.c x_(i - 1)^(k_(i - 1)) x_i^(k_i) x_(i + 1)^(k_(i + 1)) dots.h.c, dots.h.c k_(i - 1)^(n_(i - 1)) k_i^(n_i) k_(i + 1)^(n_(i + 1)) dots.h.c)) & = sum_(upright(bold(k))) frac(dots.h.c x_(i - 1)^(k_(i - 1)) x_i^(k_i - 1) x_(i + 1)^(k_(i + 1)) dots.h.c, dots.h.c k_(i - 1)^(n_(i - 1)) k_i^(n_i - 1) k_(i + 1)^(n_(i + 1)) dots.h.c)\
 & = sum_(upright(bold(k))) frac(dots.h.c x_(i - 1)^(k_(i - 1)) x_i^(k_i) x_(i + 1)^(k_(i + 1)) dots.h.c, dots.h.c k_(i - 1)^(n_(i - 1)) k_i^(n_i - 1) k_(i + 1)^(n_(i + 1)) dots.h.c) 1 / x_i$) Write $u_i = log\(x_i\)$, $v_i = log\(1 - x_i\)$, $u_(i j) = log\(x_i dots.h.c x_j\)$, $v_(i j) = log\(1 - x_i dots.h.c x_j\)$. If $m_i > 1$, then #display-equation($d_i "Li"_(n_1\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_d\) & = "Li"_(n_1\,dots.h.c\,n_i - 1\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_d\)frac(d x_i, x_i)\
 & = "Li"_(n_1\,dots.h.c\,n_i - 1\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_d\)d u_i$) #display-equation($d_d "Li"_(n_1\,dots.h.c\,n_(d - 1)\,1)\(z_1\,dots.h.c\,z_d\) & = "Li"_(n_1\,dots.h.c\,n_(d - 1))\(z_1\,dots.h.c\,z_(d - 1) z_d\)frac(d x_d, 1 - x_d)\
 & = - "Li"_(n_1\,dots.h.c\,n_(d - 1))\(z_1\,dots.h.c\,z_(d - 1) z_d\)d v_d$) #display-equation($d_1 "Li"_(1\,n_2\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_d\) & = "Li"_(n_2\,dots.h.c\,n_d)\(z_2\,dots.h.c\,z_d\)frac(d x_1, 1 - x_1)\
 & - "Li"_(n_2\,dots.h.c\,n_d)\(z_1 z_2\,dots.h.c\,z_d\)frac(d x_1, x_1\(1 - x_1\))$) #display-equation($d_i "Li"_(n_1\,dots.h.c\,n_(i - 1)\,1\,n_(i + 1)\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_d\) & = "Li"_(n_1\,dots.h.c\,n_(i - 1)\,n_(i + 1)\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_(i - 1) z_i\,z_(i + 1)\,dots.h.c\,z_d\)frac(d x_i, 1 - x_i)\
 & - "Li"_(n_1\,dots.h.c\,n_(i - 1)\,n_(i + 1)\,dots.h.c\,n_d)\(z_1\,dots.h.c\,z_(i - 1)\,z_i z_(i + 1)\,dots.h.c\,z_d\)frac(d x_i, x_i\(1 - x_i\))$)

]
#aside("Remark")[

]
Note that $"Li"_(2 n)\(1\)= zeta\(2 n\)=\(- 1\)^(n + 1) frac(\(2 pi\)^(2 n) B_(2 n), 2\(2 n\)!)$, $"Li"_(2 n)\(1\)+ "Li"_(2 n)\(- 1\)= 1 / 2^(2 n - 1) "Li"_(2 n)\(1\)$, which implies $"Li"_(2 n)\(- 1\)=\(1 / 2^(2 n - 1) - 1\)"Li"_(2 n)\(1\)=\(- 1\)^(n + 1) frac(pi^(2 n) B_(2 n), \(2 n\)!)\(1 - 2^(2 n - 1)\)$

#statement("Theorem")[
$"Li"_(2 n)\(x\)+ "Li"_(2 n)\(x^(- 1)\)= - sum_(k = 0)^k frac(pi^(2\(n - k\)), \(2 k\)!) log^(2 k)\(- x\)$ $"Li"_(2 n + 1)\(x\)- "Li"_(2 n - 1)\(x^(- 1)\)=$

]
#proof(title: "Proof")[
$"Li"_0\(x\)+ "Li"_0\(x^(- 1)\)= - 1$, $"Li"_1\(x\)+ "Li"_1\(x^(- 1)\)= log\(- x\)$, $"Li"_2\(x\)+ "Li"_2\(x^(- 1)\)= - 1 / 2 log^2\(- x\)- pi^2 / 6$ #display-equation($d\("Li"_n\(x\)+\(- 1\)^n "Li"_n\(x^(- 1)\)\)=\("Li"_(n - 1)\(x\)+\(- 1\)^(n - 1) "Li"_(n - 1)\(x^(- 1)\)\)frac(d x, x)$)

]
#statement("Definition")[
The generating function of Bernoulli polynomials is $frac(t e^(x t), e^t - 1) = sum B\(x\)frac(t^n, n !) = frac(d\/d x, e^(d\/d x) - 1) x^n$

]
We have #display-equation($"Li"_n\(u\)+\(- 1\)^n "Li"_n\(- u\)= - frac(\(2 pi i\)^n, n !) B_n\(u\)$)
