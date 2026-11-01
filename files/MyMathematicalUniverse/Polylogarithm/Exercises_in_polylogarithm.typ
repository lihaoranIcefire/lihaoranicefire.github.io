#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Exercises in polylogarithm

#statement("Exercise", title: [Derivatives of polylogarithms])[
If $m_i > 1$ for $1 lt.eq i lt.eq d$, then #display-equation($frac(partial, partial z_i) "Li"_(m_1\,dots.h.c\,m_d)\(z_1\,dots.h.c\,z_d\) & = sum_(k_1 > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1) dots.h.c z_i^(k_i - 1) dots.h.c z_d^(k_d), k_1^(m_1) dots.h.c k_i^(m_i - 1) dots.h.c k_d^(m_d))\
 & = 1 / z_i "Li"_(m_1\,dots.h.c\,m_i - 1\,dots.h.c\,m_d)\(z_1\,dots.h.c\,z_d\)$) #display-equation($frac(partial, partial z_1) "Li"_(1\,m_2\,dots.h.c\,m_d)\(z_1\,dots.h.c\,z_d\) & = sum_(k_1 > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1 - 1) z_2^(k_2) dots.h.c z_d^(k_d), k_2^(m_2) dots.h.c k_d^(m_d))\
 & = sum_(k_2 > dots.h.c > k_d gt.eq 1) frac(z_2^(k_2) dots.h.c z_d^(k_d), k_2^(m_2) dots.h.c k_d^(m_d)) sum_(k_1 = k_2 + 1)^oo z_1^(k_1 - 1)\
 & = sum_(k_2 > dots.h.c > k_d gt.eq 1) frac(z_2^(k_2) dots.h.c z_d^(k_d), k_2^(m_2) dots.h.c k_d^(m_d)) frac(z_1^(k_2), 1 - z_1)\
 & = frac(1, 1 - z_1) sum_(k_2 > dots.h.c > k_d gt.eq 1) frac(\(z_1 z_2\)^(k_2) dots.h.c z_d^(k_d), k_2^(m_2) dots.h.c k_d^(m_d))\
 & = frac(1, 1 - z_1) "Li"_(m_2\,dots.h.c\,m_d)\(z_1 z_2\,dots.h.c\,z_d\)$) #display-equation($frac(partial, partial z_d) "Li"_(m_1\,dots.h.c\,m_(d - 1)\,1)\(z_1\,dots.h.c\,z_d\) & = sum_(k_1 > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1) dots.h.c z_(d - 1)^(k_(d - 1)) z_d^(k_d - 1), k_2^(m_2) dots.h.c k_(d - 1)^(m_(d - 1)))\
 & = sum_(k_1 > dots.h.c > k_(d - 1) gt.eq 2) frac(z_1^(k_1) dots.h.c z_(d - 1)^(k_(d - 1)), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1))) sum_(k_d = 1)^(k_(d - 1) - 1) z_d^(k_d - 1)\
 & = sum_(k_1 > dots.h.c > k_(d - 1) gt.eq 2) frac(z_1^(k_1) dots.h.c z_(d - 1)^(k_(d - 1)), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1))) frac(1 - z_d^(k_(d - 1) - 1), 1 - z_d)\
 & = sum_(k_1 > dots.h.c > k_(d - 1) gt.eq 1) frac(z_1^(k_1) dots.h.c z_(d - 1)^(k_(d - 1)), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1))) frac(1 - z_d^(k_(d - 1) - 1), 1 - z_d)\
 & = frac(1, 1 - z_d) sum_(k_1 > dots.h.c > k_(d - 1) gt.eq 1) frac(z_1^(k_1) dots.h.c z_(d - 1)^(k_(d - 1)), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1)))\
 & - frac(1, z_d\(1 - z_d\)) sum_(k_1 > dots.h.c > k_(d - 1) gt.eq 1) frac(z_1^(k_1) dots.h.c\(z_(d - 1) z_d\)^(k_(d - 1)), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1)))\
 & = frac(1, 1 - z_d) "Li"_(m_1\,dots.h.c\,m_(d - 1))\(z_1\,dots.h.c\,z_(d - 1)\)\
 & - frac(1, z_d\(1 - z_d\)) "Li"_(m_1\,dots.h.c\,m_(d - 1))\(z_1\,dots.h.c\,z_(d - 1) z_d\)$) If $1 < i < d$, then #display-equation($ & frac(partial, partial z_i) "Li"_(m_1\,dots.h.c\,1\,dots.h.c\,m_d)\(z_1\,dots.h.c\,z_d\)\
 & = sum_(k_1 > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1) dots.h.c z_i^(m_i - 1) dots.h.c z_d^(k_d), k_2^(m_2) dots.h.c k_d^(m_d))\
 & = sum_(k_1 > dots.h.c > k_(i - 1) > k_(i + 1) > dots.h.c > k_d gt.eq 1\
k_(i - 1) > k_(i + 1) + 1) frac(z_1^(k_1) dots.h.c z_(i - 1)^(k_(i - 1)) z_(i + 1)^(k_(i + 1)) dots.h.c z_d^(k_d), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1))) sum_(k_i = k_(i + 1) + 1)^(k_(i - 1) - 1) z_i^(k_i - 1)\
 & = sum_(k_1 > dots.h.c > k_(i - 1) > k_(i + 1) > dots.h.c > k_d gt.eq 1\
k_(i - 1) > k_(i + 1) + 1) frac(z_1^(k_1) dots.h.c z_(i - 1)^(k_(i - 1)) z_(i + 1)^(k_(i + 1)) dots.h.c z_d^(k_d), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1))) frac(z_i^(k_(i + 1)) - z_i^(k_(i - 1) - 1), 1 - z_i)\
 & = sum_(k_1 > dots.h.c > k_(i - 1) > k_(i + 1) > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1) dots.h.c z_(i - 1)^(k_(i - 1)) z_(i + 1)^(k_(i + 1)) dots.h.c z_d^(k_d), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1))) frac(z_i^(k_(i + 1)) - z_i^(k_(i - 1) - 1), 1 - z_i)\
 & = frac(1, 1 - z_i) sum_(k_1 > dots.h.c > k_(i - 1) > k_(i + 1) > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1) dots.h.c z_(i - 1)^(k_(i - 1))\(z_i z_(i + 1)\)^(k_(i + 1)) dots.h.c z_d^(k_d), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1)))\
 & - frac(1, z_i\(1 - z_i\)) sum_(k_1 > dots.h.c > k_(i - 1) > k_(i + 1) > dots.h.c > k_d gt.eq 1) frac(z_1^(k_1) dots.h.c\(z_(i - 1) z_i\)^(k_(i - 1)) z_(i + 1)^(k_(i + 1)) dots.h.c z_d^(k_d), k_1^(m_1) dots.h.c k_(d - 1)^(m_(d - 1)))\
 & = frac(1, 1 - z_i) "Li"_(m_1\,dots.h.c\,m_(i - 1)\,m_(i + 1)\,dots.h.c\,m_d)\(z_1\,dots.h.c\,z_(i - 1)\,z_i z_(i + 1)\,dots.h.c\,z_d\)\
 & - frac(1, z_i\(1 - z_i\)) "Li"_(m_1\,dots.h.c\,m_(i - 1)\,m_(i + 1)\,dots.h.c\,m_(d - 1))\(z_1\,dots.h.c\,z_(i - 1) z_i\,z_(i + 1)\,dots.h.c\,z_d\)$)

]
