#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Li 3,1

#display-equation($"Li"_(3\,1)\(x\,y\) & = integral frac(d y, 1 - y) frac(d x, 1 - x) (frac(d x, x))^2 + frac(d\(x y\), 1 - x y) (frac(d y, 1 - y) - frac(d x, x\(1 - x\))) (frac(d x, x))^2\
 & + frac(d\(x y\), 1 - x y) frac(d\(x y\), x y) frac(d y, 1 - y) frac(d x, x) + frac(d\(x y\), 1 - x y) (frac(d\(x y\), x y))^2 frac(d y, 1 - y)\
 & = integral d v_2 d v_1\(d u_1\)^2 + d v_12 d w_1\(d u_1\)^2 + d v_12 d u_12 d v_2 d u_1 + d v_12\(d u_12\)^2 d v_2$) Here we write $w_1 = u_1 + v_2 - v_1 = log frac(x\(1 - y\), 1 - x)$

To compute the monodromy around $x = 0$, take $q\(epsilon.alt\)$ to be the loop $\(x = epsilon.alt e^(i t)\,y = epsilon.alt\)$, we get $0$. \ To compute the monodromy around $y = 0$, take $q\(epsilon.alt\)$ to be the loop $\(x = epsilon.alt\,y = epsilon.alt e^(i t)\)$, we get $0$. \ To compute the monodromy around $x = 1$, take $q\(epsilon.alt\)$ to be the composition of $\(x =\(1 - t\)epsilon.alt + t\(1 - epsilon.alt\)\,y = epsilon.alt\)$, $\(x = 1 - epsilon.alt e^(i t)\,y = epsilon.alt\)$ and $\(x =\(1 - t\)\(1 - epsilon.alt\)+ t epsilon.alt\,y = epsilon.alt\)$, we get $0$. \ To compute the monodromy around $y = 1$, take $q\(epsilon.alt\)$ to be the composition of $\(x = epsilon.alt\,y =\(1 - t\)epsilon.alt + t\(1 - epsilon.alt\)\)$, $\(x = epsilon.alt\,y = 1 - epsilon.alt e^(i t)\)$ and $\(x = epsilon.alt\,y =\(1 - t\)\(1 - epsilon.alt\)+ t epsilon.alt\)$, we get $- 2 pi i "Li"_3\(x\)$. \ To compute the monodromy around $x y = 1$, take $q$ to be the loop $\(x = x^0\,y upright(" such that ") integral_q d log\(1 - x y\)= 2 pi i\)$, we get $- 2 pi i "Li"_1\(frac(1 - x y, 1 - x)\)$

The variation matrix is #display-equation($Lambda = mat(delim: "[", 1; "Li"_1\(y\), 1; "Li"_1\(x y\), , 1; "Li"_(1\,1)\(x\,y\), "Li"_1\(x\), "Li"_1\(y\)- "Li"_1\(x^(- 1)\), 1; "Li"_2\(x y\), , log\(x y\), , 1; "Li"_(2\,1)\(x\,y\), "Li"_2\(x\), log\(x y\)"Li"_1\(y\)- "Li"_2\(y\)+ "Li"_2\(x^(- 1)\), log x, "Li"_1\(y\), 1; "Li"_3\(x y\), , log^2\(x y\)\/2, , log\(x y\), , 1; "Li"_(3\,1)\(x\,y\), "Li"_3\(x\), 1 / 2 log^2\(x y\)"Li"_1\(y\)- log\(x y\)"Li"_2\(y\)+ "Li"_3\(y\)- "Li"_3\(x^(- 1)\), log^2 x\/2, log\(x y\)"Li"_1\(y\)- "Li"_2\(y\), log x, "Li"_1\(y\), 1) tau_(3\,1)\(2 pi i\)$) #display-equation($mat(delim: "[", 1; - I\(0\;y^(- 1)\;1\), 1; - I\(0\;\(x y\)^(- 1)\;1\), 0, 1; I\(0\;\(x y\)^(- 1)\,y^(- 1)\;1\), - I\(0\;\(x y\)^(- 1)\;y^(- 1)\), - I\(\(x y\)^(- 1)\;y^(- 1)\;1\), 1; - I\(0\;\(x y\)^(- 1)\,0\;1\), 0, - I\(\(x y\)^(- 1)\;0\;y^(- 1)\), 0, 1; I\(0\;\(x y\)^(- 1)\,0\,y^(- 1)\;1\), - I\(0\;\(x y\)^(- 1)\,0\;y^(- 1)\), - I\(\(x y\)^(- 1)\;0\,y^(- 1)\;1\), I\(\(x y\)^(- 1)\;0\;y^(- 1)\), - I\(0\;y^(- 1)\;1\), 1; - I\(0\;\(x y\)^(- 1)\,0\,0\;1\), 0, I\(\(x y\)^(- 1)\;0\,0\;1\), 0, I\(\(x y\)^(- 1)\;0\;0\), 0, 1; I\(0\;\(x y\)^(- 1)\,0\,0\,y^(- 1)\;1\), - I\(0\;\(x y\)^(- 1)\,0\,0\;y^(- 1)\), - I\(\(x y\)^(- 1)\;0\,0\,y^(- 1)\;1\), I\(\(x y\)^(- 1)\;0\,0\;y^(- 1)\), - I\(\(x y\)^(- 1)\;0\;0\)I\(0\;y^(- 1)\;1\)- I\(0\;0\,y^(- 1)\;1\), I\(\(x y\)^(- 1)\;0\;0\)+ I\(0\;0\;y^(- 1)\), - I\(0\;y^(- 1)\;1\), 1)$) #display-equation($omega = mat(delim: "[", 0, , , , , , , ; - d v_2, 0, , , , , , ; - d v_12, 0, 0, , , , , ; #none, - d v_1, - d w_1, 0, , , , ; #none, , d u_12, 0, 0, , , ; #none, , , d u_1, - d v_2, 0, , ; #none, , , , d u_12, 0, 0, ; #none, , , , , d u_1, - d v_2, 0)$) The monodromy representation $rho$ is as follows \ For monodromy around $x = 0$ #display-equation($mat(delim: "[", 1, , , , , , , ; #none, 1, , , , , , ; #none, , 1, , , , , ; #none, , - 1, 1, , , , ; #none, , 1, , 1, , , ; #none, , , 1, , 1, , ; #none, , 1 / 2, , , , 1, ; #none, , , , , 1, , 1)$) For monodromy around $y = 0$ #display-equation($mat(delim: "[", 1, , , , , , , ; #none, 1, , , , , , ; #none, , 1, , , , , ; #none, , , 1, , , , ; #none, , , , 1, , , ; #none, , , , , 1, , ; #none, , , , , , 1, ; #none, , , , , , , 1)$) For monodromy around $x = 1$ #display-equation($mat(delim: "[", 1, , , , , , , ; #none, 1, , , , , , ; #none, , 1, , , , , ; #none, , , 1, , , , ; #none, , , , 1, , , ; #none, , , , , 1, , ; #none, , , , , , 1, ; #none, , , , , , , 1)$) For monodromy around $y = 1$ #display-equation($mat(delim: "[", 1, , , , , , , ; #none, 1, , , , , , ; #none, , 1, , , , , ; #none, , , 1, , , , ; #none, , , , 1, , , ; #none, , , , , 1, , ; #none, , , , , , 1, ; #none, , , , , , , 1)$) For monodromy around $x y = 1$ #display-equation($mat(delim: "[", 1, , , , , , , ; #none, 1, , , , , , ; #none, , 1, , , , , ; #none, , , 1, , , , ; #none, , , , 1, , , ; #none, , , , , 1, , ; #none, , , , , , 1, ; #none, , , , , , , 1)$)

$d w_(3\,1) - w_2\(y\)and w_2\(x y\)= 0$. So $xi = w_(3\,1) - 1 / 2\(L_2\(y\)and w_2\(x y\)- w_2\(y\)and L_2\(x y\)\)$ should be closed. So we want $hat(L)_(3\,1)$ such that $hat(d) L_(3\,1) = xi$

$d omega_(3\,1)\(x\,y\)+ omega_2\(y\)and omega_2\(x y\)= 0$, we have $d bold(omega) - bold(omega) and bold(omega) = 0$ for #display-equation($bold(omega) = mat(delim: "[", 0; omega_2\(x y\), 0; omega_(3\,1)\(x\,y\), - omega_2\(y\), 0)$)

And the variation matrix should be #display-equation($mat(delim: "[", 1; hat(cal(L))_2\(x y\), 1; hat(cal(L))_(3\,1)\(x\,y\), - hat(cal(L))_2\(y\), 1; #none)$)

Here #display-equation($hat(cal(L))_2\(x\)= "Li"_2\(x\)- 1 / 2 "Li"_1\(x\)log x$) #display-equation($hat(cal(L))_(3\,1)\(x\,y\) & = "Li"_(3\,1)\(x\,y\)+ "Li"_3\(x y\)v_2 - "Li"_(2\,1)\(x\,y\)u_1 + 1 / 2 "Li"_(1\,1)\(x\,y\)u_1^2 - 1 / 2 "Li"_2\(x y\)v_2\(2 u_1 + v_1\)\
 & + 1 / 4\(- 1 / 2 v_1 u_1^2 v_2 + 1 / 2 v_1 u_1^2 v_12 - 1 / 2 u_1^3 v_12 - 3 / 2 u_1^2 v_2 v_12 - 3 / 2 u_1 v_2 u_2 v_12 - 1 / 2 v_2 u_2^2 v_12\)$)

The unipotent monodromy representation would be

Monodromy along the commutator of $x = 0\,x y = 1$ #display-equation($mat(delim: "[", 1; - 1, 1; 1 / 2, , 1)$)

Monodromy along the commutator of $y = 0\,y = 1$ #display-equation($mat(delim: "[", 1; #none, 1; #none, - 1, 1)$)

Monodromy along the commutator of $y = 0\,x y = 1$ #display-equation($mat(delim: "[", 1; - 1, 1; #none, , 1)$)

Monodromy along all other commutators #display-equation($mat(delim: "[", 1; #none, 1; #none, , 1)$)
