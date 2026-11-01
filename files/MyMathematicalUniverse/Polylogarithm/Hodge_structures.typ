#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Hodge structures

#statement("Definition")[
$D$ is a simple normal crossing divisor of $X$, $Y = X - D$, $Y arrow.r.hook^j X$ is the embedding, the #emph[log de Rham commplex] of $X$ along $D$ is $Omega_X^(*)\(log D\)$, which is the smallest chain complex of $j_(*) Omega_Y^(*)$ closed under wedge product such that for any $f in j_(*) cal(O)_X^(*)\(U\)$ meromorphic along $D$, $frac(d f, f) in Omega_X^(*)\(log D\)\(U\)$. A section of $j_(*) Omega_Y^(*)$ has #emph[logarithmic poles] if it is a section of $Omega_X^(*)\(log D\)$

]
#statement("Proposition")[
+ Section $omega$ of $j_(*) Omega_Y^(*)$ has logarithmic poles along $D$ iff both $omega\,d omega$ have at most simple poles along $D$

+ $Omega_X^1\(log D\)$ is locally free and $Omega_X^p\(log D\)= and.big^p Omega_X^1\(log D\)$

+ For $\(X\,D\)=\(X_1\,D_1\)times\(X_2\,D_2\)=\(X_1 times X_2\,X_1 times D_2 union X_2 times D_1\)$, isomorphism $Omega_(Y_1)^(*) times.square Omega_(Y_2)^(*) arrow.r "pr"_(X_1)^(*) Omega_(X_1)^(*) times.o "pr"_(X_2)^(*) Omega_(X_2)^(*)$ induces isomorphism $Omega_(X_1)^(*)\(log D_1\)times.square Omega_(X_2)^(*)\(log D_2\)arrow.r Omega_X^(*)\(log D\)$

+ For $f : X_1 arrow.r X_2$, $f^(- 1)\(D_2\)= D_1$, $f^(*) : j_2_(*) Omega_(Y_2)^(*) arrow.r j_1_(*) Omega_(Y_1)^(*)$ induces $f^(*) : Omega_(X_2)^(*)\(log D_2\)arrow.r Omega_(X_1)^(*)\(log D_1\)$

]
#statement("Lemma")[
$X = D^n$, $D = union.big_(1 lt.eq i lt.eq k) D_i$ with $D_i = "pr"_i^(- 1)\(0\)$, $Y = D^(*)^k union D^(n - k)$. Then $Omega_X^1\(log D\)$ is a free sheaf with base ${frac(d z_i, z_i)}_(1 lt.eq i lt.eq k)$ and ${ d z_i }_(k lt.eq i lt.eq n)$. In fact, any section of $j_(*) cal(O)_Y^(*)$ meromorphic along $D$ can be written locally as $f = g product_(i = 1)^k z_i^(n_i)$, then #display-equation($frac(d f, f) = frac(d g, g) + sum_(i = 1)^k n_i / z_i d z_i$)

]
