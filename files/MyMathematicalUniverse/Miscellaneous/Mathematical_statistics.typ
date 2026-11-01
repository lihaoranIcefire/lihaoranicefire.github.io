#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Mathematical statistics

#statement("Definition")[
Suppose $X tilde.op N\(mu\,sigma^2\)$, $sigma$ is known, $P (- 1.96 < frac(macron(X) - mu, sigma\/sqrt(n)) < 1.96) = 0.95$ and #display-equation($- 1.96 < frac(macron(X) - mu, sigma\/sqrt(n)) < 1.96 arrow.l.r.double macron(X) - 1.96 sigma / sqrt(n) < mu < macron(X) + 1.96 sigma / sqrt(n)$) $\(macron(x) - 1.96 sigma\/sqrt(n)\,macron(x) + 1.96 sigma\/sqrt(n)\)$ is called the 95% #emph[confidence interval]#index-entry("Confidence interval")

]
