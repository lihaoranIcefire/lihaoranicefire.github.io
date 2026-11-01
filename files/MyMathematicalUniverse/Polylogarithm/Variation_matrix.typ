#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Variation matrix

#statement("Theorem")[
$Lambda$ is the fundamental solution of the system of linear differential equations #display-equation($d Lambda = omega Lambda$)

]
#statement("Example")[
For #display-equation($"Li"_(1\,1)\(x\,y\) & = integral_(\(0\,0\))^(\(x\,y\)) d v_1 d v_2 + d v_12 d\(u_1 - v_1 + v_2\)\
 & = integral_(\(0\,0\))^(\(x\,y\)) d v_1 d v_2 + d v_12 d u_1 - d v_12 d v_1 + d v_12 d v_2$) $\(0\,0\)<\(0\,1\)<\(1\,0\)<\(1\,1\)$ in $frak(S)\(1\,1\)$ #display-equation($Lambda = mat(delim: "[", 1, , , ; "Li"_1\(y\), 1, , ; "Li"_1\(x y\), , 1, ; "Li"_(1\,1)\(x\,y\), "Li"_1\(x\), "Li"_1 (frac(1 - x y, 1 - x)), 1) tau_(1\,1)\(2 pi i\)$) #display-equation($omega = mat(delim: "[", 0, , , ; - d v_2, 0, , ; - d v_12, 0, 0, ; 0, - d v_1, d\(- u_1 + v_1 - v_2\), 0)$)

]
#statement("Example")[
For #display-equation($"Li"_(2\,1)\(x\,y\) & = integral_(\(0\,0\))^(\(x\,y\))\(d v_1 d v_2 + d v_12 d\(u_1 - v_1 + v_2\)\)d u_1 + d v_12 d\(u_1 + u_2\)d v_2\
 & = integral_(\(0\,0\))^(\(x\,y\)) d v_1 d v_2 d u_1 + d v_12 d u_1 d u_1 - d v_12 d v_1 d u_1\
 & + d v_12 d v_2 d u_1 + d v_12 d u_1 d v_2 + d v_12 u_2 d v_2$) $\(0\,0\)<\(0\,1\)<\(1\,0\)<\(1\,1\)<\(2\,0\)<\(2\,1\)$ in $frak(S)\(2\,1\)$ #display-equation($Lambda = mat(delim: "[", 1, , , , , , ; "Li"_1\(y\), 1, , , , ; "Li"_1\(x y\), , 1, , , ; "Li"_(1\,1)\(x\,y\), "Li"_1\(x\), log frac(1 - x, \(1 - y\)x), 1, , ; "Li"_2\(x y\), , log\(x y\), , 1, ; "Li"_(2\,1)\(x\,y\), "Li"_2\(x\), g\(x\,y\), log x, "Li"_1\(y\), 1) tau_(2\,1)\(2 pi i\)$) Where $d g = log frac(1 - x, \(1 - y\)x) frac(d x, x) + log\(x y\)frac(d y, 1 - y)$ #display-equation($omega = mat(delim: "[", 0, , , , , ; - d v_2, 0, , , , ; - d v_12, 0, 0, , ; 0, - d v_1, d\(- u_1 + v_1 - v_2\), 0, , ; 0, 0, d\(u_1 + u_2\), 0, 0, ; 0, 0, 0, d u_1, - d v_2, 0)$)

]
#statement("Example")[
For #display-equation($"Li"_(1\,1\,1)\(x\,y\,z\) & = integral_(\(0\,0\,0\))^(\(x\,y\,z\))\
 & = integral_(\(0\,0\,0\))^(\(x\,y\,z\))$) $\(0\,0\,0\)<\(0\,0\,1\)<\(0\,1\,0\)<\(1\,0\,0\)<\(0\,1\,1\)<\(1\,0\,1\)<\(1\,1\,0\)<\(1\,1\,1\)$ in $frak(S)\(1\,1\,1\)$ #display-equation($Lambda = mat(delim: "[", 1, , , , , , , ; "Li"_1\(z\), 1, , , , , , ; "Li"_1\(y z\), , 1, , , , , ; "Li"_1\(x y z\), , , 1, , , , ; "Li"_(1\,1)\(y\,z\), "Li"_1\(y\), log frac(1 - y, \(1 - z\)y), , 1, , , ; "Li"_(1\,1)\(x y\,z\), "Li"_1\(x y\), , log frac(1 - x y, \(1 - z\)x y), , 1, , ; "Li"_(1\,1)\(x\,y z\), , "Li"_1\(x\), log frac(1 - x, \(1 - y z\)x), , , 1, ; "Li"_(1\,1\,1)\(x\,y\,z\), g\(x\,y\), "Li"_1\(x\)log frac(1 - y, \(1 - z\)y), h\(x\,y\), "Li"_1\(x\), log frac(1 - y, \(1 - x\)x), log frac(1 - z, \(1 - y\)y), 1) tau_(1\,1\,1)\(2 pi i\)$) Where #display-equation($omega = mat(delim: "[", 0; - d v_3, 0; - d v_23, 0, 0; - d v_13, 0, 0, 0; 0, - d v_2, d\(v_2 - u_2 - v_3\), 0, 0; 0, - d v_12, 0, d\(v_12 - u_1 - u_2 - v_3\), 0, 0; 0, 0, - d v_1, d\(v_1 - u_1 - v_23\), 0, 0, 0; 0, 0, 0, 0, - d v_1, d\(v_1 - u_1 - v_2\), d\(v_2 - u_2 - v_3\), 0)$)

]
#statement("Example")[
For #display-equation($"Li"_(1\,2)\(x\,y\) & = d v_12 d\(u_1 + u_2\)d\(u_1 - v_2\)+\(d v_1 d v_2 + d v_12 d\(u_1 - v_1 + v_2\)\)d u_2\
 & = d v_12 d u_1 d u_1 - d v_12 d u_1 d v_2 + d v_12 d u_2 d u_1 - d v_12 d u_2 d v_2\
 & + d v_1 d v_2 d u_2 + d v_12 d u_1 d u_2 - d v_12 d v_1 d u_2 + d v_12 d v_2 d u_2$) $\(0\,0\)<\(0\,1\)<\(1\,0\)<\(1\,1\)<\(0\,2\)<\(1\,2\)$ in $frak(S)\(1\,2\)$ #display-equation($Lambda = mat(delim: "[", 1, , , , , , , ; "Li"_1\(y\), 1, , , , , ; "Li"_1\(x y\), 0, 1, , , , ; "Li"_(1\,1)\(x\,y\), "Li"_1\(x\), log frac(1 - x, \(1 - y\)x), 1, , , ; "Li"_2\(y\), log y, , , 1, , , ; "Li"_2\(x y\), 0, log\(x y\), , , 1, , ; "Li"_(1\,2)\(x\,y\), "Li"_1\(x\)log y, g\(x\,y\), log y, "Li"_1\(x\), - "Li"_1\(x^(- 1)\), 1) tau_(1\,2)\(2 pi i\)$) Where $g\(x\,y\)= - I\(\(x y\)^(- 1)\;y^(- 1)\,0\;1\)$ #display-equation($omega = mat(delim: "[", 0, , , , , , ; - d v_2, 0, , , , , ; - d v_12, 0, 0, , , ; 0, - d v_1, d\(- u_1 + v_1 - v_2\), 0, , , ; 0, d u_2, 0, 0, 0, , ; 0, 0, d\(u_1 + u_2\), 0, 0, 0, ; 0, 0, 0, d u_2, - d v_1, d\(v_1 - u_1\), 0)$)

]
#statement("Example")[
For #display-equation($"Li"_(2\,2)\(x\,y\) & =\(d v_12 d u\(u_1 + u_2\)d\(u_1 - v_2\)+\(d v_1 d v_2 + d v_12 d\(u_1 - v_1 + v_2\)\)d u_2\)d u_1\
 & +\(\(d v_1 d v_2 + d v_12 d\(u_1 - v_1 + v_2\)\)d u_1 + d v_12 d\(u_1 + u_2\)d v_2\)d u_2\
 & = d v_12 d u_1 d u_1 d u_1 - d v_12 d u_1 d v_2 d u_1 + d v_12 d u_2 d u_1 d u_1 - d v_12 d u_2 d v_2 d u_1\
 & + d v_1 d v_2 d u_2 d u_1 + d v_12 d u_1 d u_2 d u_1 - d v_12 d v_1 d u_2 d u_1 + d v_12 d v_2 d u_2 d u_1\
 & + d v_1 d v_2 d u_1 d u_2 + d v_12 d u_1 d u_1 d u_2 - d v_12 d v_1 d u_1 d u_2\
 & + d v_12 d v_2 d u_1 d u_2 + d v_12 d u_1 d v_2 d u_2 + d v_12 u_2 d v_2 d u_2$) $\(0\,0\)<\(0\,1\)<\(1\,0\)<\(1\,1\)<\(0\,2\)<\(2\,0\)<\(1\,2\)<\(2\,1\)<\(2\,2\)$ in $frak(S)\(2\,2\)$ #display-equation($Lambda = mat(delim: "[", 1, , , , , , , , ; "Li"_1\(y\), 1, , , , , , , ; "Li"_1\(x y\), , 1, , , , , , ; "Li"_(1\,1)\(x\,y\), "Li"_1\(x\), log frac(1 - x, \(1 - y\)x), 1, , , , , ; "Li"_2\(y\), log y, , , 1, , , , ; "Li"_2\(x y\), , log\(x y\), , , 1, , , ; "Li"_(1\,2)\(x\,y\), "Li"_1\(x\)log y, g\(x\,y\), log y, "Li"_1\(x\), log frac(1 - x, x), 1, , ; "Li"_(2\,1)\(x\,y\), "Li"_2\(x\), h\(x\,y\), log x, , "Li"_1\(y\), , 1, ; "Li"_(2\,2)\(x\,y\), "Li"_2\(x\)log y, i\(x\,y\), log x log y, "Li"_2\(x\), "Li"_2\(y\)- "Li"_2\(x\)- 1 / 2 log^2 x, log x, log y, 1) tau_(2\,2)\(2 pi i\)$) #display-equation($omega = mat(delim: "[", 0, , , , , , , , ; - d v_2, 0, , , , , , , ; - d v_12, 0, 0, , , , , ; 0, - d v_1, d\(- u_1 + v_1 - v_2\), 0, , , , , ; 0, d u_2, 0, 0, 0, , , , ; 0, 0, d\(u_1 + u_2\), 0, 0, 0, , , ; 0, 0, 0, d u_2, - d v_1, d\(v_1 - u_1\), 0, , ; 0, 0, 0, d u_1, 0, - d v_2, 0, 0, ; 0, 0, 0, 0, 0, 0, d u_1, d u_2, 0)$)

]
