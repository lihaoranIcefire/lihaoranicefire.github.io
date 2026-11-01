#import "universe-style.typ": *
#import "universe-drawings.typ": universe-drawing

= Abstract algebra

#statement("Definition", title: [#strong[Rings]#index-entry("Ring")])[
$R$ is an abelian group with addition $+$ and additive identity $0$, a monoid with multiplication $dot.op$ and multiplicative identity $1$, and distributive, $a dot.op\(b + c\)= a dot.op b + a dot.op c$, $\(a + b\)dot.op c = a dot.op c + b dot.op c$

]
#statement("Definition")[
Ring $R$ is #strong[commutative] if $a b = b a$

]
#statement("Definition")[
$u$ is a #strong[unit]#index-entry("Unit") if there exists $v in R$ such that $u v = v u = 1$. The set of units $R^times$ is a multiplicative group

]
#statement("Definition")[
A #strong[semiring] or #strong[rig] is a ring without negatives

]
#statement("Definition")[
A #strong[rng] is ring without identity

]
