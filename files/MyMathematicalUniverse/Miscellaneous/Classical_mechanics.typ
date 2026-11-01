#import "../universe-style.typ": *
#import "../universe-drawings.typ": universe-drawing

== Classical mechanics

Consider a system of $N$ particles in $bb(R)^n$ with masses $m_i$, with positions $upright(bold(r))_i = upright(bold(r))_i\(t\)$, $dot(upright(bold(r))_i)\,dot.double(upright(bold(r))_i)$ denote velocities and accelerations. Let $upright(bold(x))\,t$ denote Cartesian coordinates and time, $upright(bold(r))_i$ may have some constraints(such as $f_j\(upright(bold(r))_i\,t\)= 0$), consider another coordinates(generalized coordinates, preferably free, i.e. with no constraints) $upright(bold(y))$, particles will have generalized positions, generalized velocities and generalized accelerations $upright(bold(q))_i = upright(bold(q))_i\(t\)$, $dot(upright(bold(q))_i)\,dot.double(upright(bold(q))_i)$. The system itself should produce no work, i.e. #display-equation($0 & = sum m_i dot.double(upright(bold(r))_i) dot.op dot(upright(bold(r))_i)\
 & = sum m_i dot.double(upright(bold(q))_i) dot.op [frac(partial upright(bold(x)), partial upright(bold(y))) \( upright(bold(q))_i \) dot(upright(bold(q))_i)]\
$)

#statement("Example")[

]
#statement("Definition")[

]
