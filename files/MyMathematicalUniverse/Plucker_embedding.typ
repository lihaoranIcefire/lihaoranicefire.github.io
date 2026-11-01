#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Plucker embedding

#statement("Definition")[
Consider Grassmannian $W in G r_k\(n\)$, the #emph[Plücker coordinates]#index-entry("Plücker coordinates") $W_(i_1\,dots.h.c\,i_k)$ to be the minor of $i_1\,dots.h.c\,i_k$-th columns. For $1 lt.eq i_1 < dots.h.c < i_(k - 1) lt.eq n$, $1 lt.eq j_1 < dots.h.c < j_k lt.eq n$, $r lt.eq k$, the #strong[Plücker relations]#index-entry("Plücker relations") is #display-equation($W_(i_1\,dots.h.c\,i_k) W_(j_1\,dots.h.c\,j_k) = sum W_(i'_1\,dots.h.c\,i'_k) W_(j'_1\,dots.h.c\,j'_k)$) The summation is over all swaps of a size $r$ order set of ${ i_1\,dots.h.c\,i_k }$ with $w_1\,dots.h.c\,w_r$, respectively

]
#proof(title: "Proof")[
If $r = k$, it is trivial. So we may assume $r < k$. For $v_1\,dots.h.c\,v_k\,w_1\,dots.h.c\,w_k in bb(C)^k$, consider multilinear function #display-equation($f\(v_1\,dots.h.c\,v_k\,w_1\,dots.h.c\,w_k\)=\|v_1 dots.h.c v_k\|\|w_1 dots.h.c w_k\|- sum\|v'_1 dots.h.c v'_k\|\|w'_1 dots.h.c w'_k\|= "LHS" - "RHS"$) Let's first show that $f$ is skew-symmetric, it is suffices to prove if $v_i = v_(i + 1)$ or $v_k = w_k$, then $f = 0$

+ If $v_i = v_(i + 1)$, $"LHS" = 0$, $"RHS"$ consists of terms $\|dots.h.c v_i dots.h.c\|\|dots.h.c v_(i + 1) dots.h.c\|$ or $\|dots.h.c v_(i + 1) dots.h.c\|\|dots.h.c v_i dots.h.c\|$, and each pair will cancel out in summation

+ If $v_k = w_k$, through a linear transformation, $v_k = w_k$ can be taken to be $\(0\,dots.h.c\,0\,1\)^T$, and then it reduces to a lower case

Since $w_k\,v_k$ can be move to any column up to a sign, we know $f$ is indeed skew-symmetric

]
#statement("Example")[
Consider $"Gr"_2\(4\)$, the only Plücker relation is #display-equation($W_12 W_34 - W_13 W_24 + W_14 W_23 = 0$)

]
#statement("Theorem")[
The #emph[Plücker embedding]#index-entry("Plücker embedding") is #display-equation($"Gr"_k\(n\) & arrow.r bb(P)\(and.big^k bb(C)\)\
"Span"\(v_1\,dots.h.c\,v_k\) & mapsto\[v_1 and dots.h.c and v_k\]$) The image is an irreducible projective algebraic variety defined exactly by Plücker relations on Plücker coordinates

]
