#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Li 5,1

$d omega_(5\,1)\(x\,y\)- omega_4\(x y\)omega_4\(y\)+ omega_3\(x y\)and omega_3\(y\)- omega_2\(x y\)and omega_4\(y\)= 0$, we have $d bold(omega) - bold(omega) and bold(omega) = 0$ for #display-equation($bold(omega) = mat(delim: "[", 0; omega_2\(x y\), 0; omega_3\(x y\), 0, 0; omega_4\(x y\), 0, 0, 0; omega_(5\,1)\(x\,y\), - omega_4\(y\), omega_3\(y\), - omega_2\(y\), 0)$)

And the variation matrix should be #display-equation($mat(delim: "[", 1; hat(cal(L))_2\(x y\), 1; hat(cal(L))_3\(x y\), 0, 1; hat(cal(L))_4\(x y\), 0, 0, 1; hat(cal(L))_(5\,1)\(x\,y\), - hat(cal(L))_4\(y\), hat(cal(L))_3\(y\), - hat(cal(L))_2\(y\), 1; #none)$)

Here #display-equation($hat(cal(L))_2\(x\)= "Li"_2\(x\)+ 1 / 2 v_1 u_1$) #display-equation($hat(cal(L))_3\(x\)= "Li"_3\(x\)- "Li"_2\(x\)u_1 - 1 / 3 u_1^2 v_1$) #display-equation($hat(cal(L))_4\(x\)= "Li"_4\(x\)- "Li"_3\(x\)u_1 + 1 / 2 u_1^2 "Li"_2\(x\)+ 1 / 8 u_1^3 v_1$) #display-equation($hat(cal(L))_(5\,1)\(x\,y\) & = "Li"_(5\,1)\(x\,y\)+ v_2 L i_5\(x y\)- u_1 L i_(4\,1)\(x\,y\)+\(- u_1 v_2 - 1 / 2 u_2 v_2\)L i_4\(x y\)+ 1 / 2 u_1^2 L i_(3\,1)\(x\,y\)+\(1 / 2 u 1 u 2 v 2 + 1 / 6 u 2^2 v 2 + 1 / 2 u 1^2 v 2\)L i\[3\,u 12\]- 1 / 6 u 1^3 L i\[2\,1\,u 1\,u 2\]+\(- 1 / 24 u 2^3 v 2 - 1 / 6 u 1 u 2^2 v 2 - 1 / 4 u 1^2 u 2 v 2 - 1 / 6 u 1^3 v 2\)L i_2\(x y\)+ 1 / 24 u 1^4 L i\[1\,1\,u 1\,u 2\]-\(u 1^5 v 12\)\/144 + 1\/144 u 1^4 v 1 v 12 - 1\/144 u 1^4 v 1 v 2 - 5\/144 u 1^4 v 12 v 2 - 5\/72 u 1^3 u 2 v 12 v 2 - 5\/72 u 1^2 u 2^2 v 12 v 2 - 5\/144 u 1 u 2^3 v 12 v 2 - 1\/144 u 2^4 v 12 v 2$)

The unipotent monodromy representation would be
