#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Hodge theory

#statement("Definition")[
An abelian group $H_(bb(Z))$\(write $H_R = H_(bb(Z)) times.o R$) has a #emph[pure Hodge structure]#index-entry("Pure Hodge structure") of weight $n$ if #display-equation($H_(bb(C)) = xor.big_(p + q = n) H_(bb(C))^(p\,q)\,quad overline(H_(bb(C))^(p\,q)) = H_(bb(C))^(q\,p)$) Or equivalently, if there is a decreasing #emph[Hodge filtration] $F^p H_(bb(C))$ on $H_(bb(C))$ such that $H_(bb(C)) = F^p H_(bb(C)) xor overline(F^(n + 1 - p) H_(bb(C)))$. The equivalence of the two definitions is given by ($p + q = n$) #display-equation($F^p H_(bb(C)) = xor.big_(i gt.eq p) H_(bb(C))^(i\,n - i)\,quad overline(F^q H_(bb(C))) = xor.big_(j lt.eq p) H_(bb(C))^(j\,n - j)$) #display-equation($H_(bb(C))^(p\,q) = F^p H_(bb(C)) inter overline(F^q H_(bb(C)))\,quad F^p H_(bb(C)) inter overline(F^(n + 1 - p) H_(bb(C))) = 0$)

]
#statement("Example")[
$X$ is a complex manifold, $H_(bb(Z)) = H^n\(X\;bb(Z)\)$, then #display-equation($H_(bb(C))^n\(X\;bb(C)\)= xor.big_(p + q = n) H^(p\,q) = xor.big_(p + q = n) H^p\(X\;bb(C)\)and overline(H^q\(X\;bb(C)\))$)

]
#statement("Example", title: [#emph[Hodge-Tate structure]])[
The first ???? , $bb(Z)\(1\)=\(2 pi i\)bb(Z)$ has a pure Hodge structure of weight -2. Here $bb(Z)\(1\)_(bb(C)) = H^(- 1\,- 1)$ is the unique one dimensional weight -2 pure Hodge structure. Uniqueness is due to the fact that $H^(- 2\,0) = overline(H^(0\,- 2))$ must be 0 or nonzero at the same time.

]
#statement("Definition")[
The tensor product of two Hodge structures $H_1$ and $H_2$ is given by $H^(p\,q) =$

]
#statement("Example", title: [Hodege-Tate $n$])[
The previous example generalizes to $bb(Z)\(n\):= bb(Z)\(1\)^(times.o n)$. This has a one dimensional pure Hodge structure of weight $n$

]
#statement("Definition")[
A #emph[polarization] over $bb(Q)$ of a Hodge structure over $bb(Q)$ of weight $k$ is a $\(- 1\)^k$ symmetric nondegenerate flat bilinear map $beta : bb(V)_(bb(Q)) times bb(V)_(bb(Q)) arrow.r bb(Q)$ such that the Hermitian form $beta_x\(C_x v\,macron(w)\)$ on each fiber $cal(V)_x$ is positive definite, here $C_x$ is the #emph[Weil operator], given as the direct sum of multiplication $i^(p - q)$ on $cal(V)_x^(p\,q)$

]
#statement("Definition")[
A #emph[mixed Hodge structure]#index-entry("Mixed Hodge structure") on $H_(bb(Z))$ consists of an increasing #emph[weight filtration] $W_bullet$ on $H_(bb(Q))$ and a decreasing filtration $F^bullet$ on $H_(bb(C))$ that are compatible, i.e. #display-equation($F^p\("gr"_k W\)_(bb(C)) = frac(F^p inter W_(k + 1)\(bb(C)\)+ W_k\(bb(C)\), W_k\(bb(C)\))$) is a pure Hodge structure of weight $k$ of $"gr"_k W$

]
#statement("Definition")[
A #emph[variation] of Hodge structure of weight $k$ over $bb(Q)$ and a complex manifold $X$ is $\(bb(V)_(bb(Q))\,cal(F)^bullet\)$, $bb(V)_(bb(Q))$ is a locally constant sheaf of $bb(Q)$ vector spaces, $cal(F)^bullet$ is a decreasing filtration of holomorphic subbundles of the locally free sheaf $cal(V) = cal(O)_X times.o bb(V)_(bb(Q))$ such that

- $\(cal(V)_x\,cal(F)_x^bullet\)$ has a pure Hodge structure of weight $k$, i.e. $cal(V)_x = cal(F)^p xor overline(cal(F)^(k + 1 - p))$

- \(Griffiths transversality) $nabla cal(F)^p subset.eq Omega_X^1 times.o_(cal(O)_X) cal(F)^(p - 1)$

]
#statement("Definition")[
A variation of mixed Hodge structure over $bb(Q)$ and a complex manifold $X$ is $\(bb(V)_(bb(Q))\,cal(W)_bullet\,cal(F)^bullet\)$, $cal(W)_bullet$ is an increasing filtration of $bb(V)_(bb(Q))$ by locally constant subsheaves such that

- $\(cal(V)_x\,\(cal(W)_bullet\)_x\,cal(F)_x^bullet\)$ has a mixed Hodge structure, i.e. $\(\)$ is a pure Hodge structure of weight $k$

- $nabla cal(F)^p subset.eq Omega_X^1 times.o_(cal(O)_X) cal(F)^(p - 1)$

]
