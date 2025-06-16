#import "xarrow.typ": * // xarrow pacakge
#import "theorems.typ": * // for theorems
#import "in-dexter.typ": * // for indices
#import "@preview/cetz:0.4.0" // for tikz-like drawing
#import "@preview/subpar:0.2.2" // for subfigures, etc
#show: thmrules

/* Define theorem environments */
#let theorem = thmbox(
	"theorem",
	"Theorem",
	fill: rgb("#e8e8f8")
)
#let lemma = thmbox(
	"theorem",            // Lemmas use the same counter as Theorems
	"Lemma",
	fill: rgb("#efe6ff")
)
#let corollary = thmbox(
	"corollary",
	"Corollary",
	base: "theorem",      // Corollaries are 'attached' to Theorems
	fill: rgb("#f8e8e8")
)

#let definition = thmbox(
	"definition",         // Definitions use their own counter
	"Definition",
	fill: rgb("#e8f8e8")
)

#let exercise = thmbox(
	"exercise",
	"Exercise",
)

#let example = thmbox(
  "example",
  "Example",
)

// Remarks, facts and questions are not numbered
#let remark = thmplain(
	"remark",
	"Remark",
	inset: 0em
).with(numbering: none)

#let fact = thmplain(
	"fact",
	"Fact",
	inset: 0em
).with(numbering: none)

#let question = thmplain(
	"question",
	"Question",
	inset: 0em
).with(numbering: none)

// Proofs are attached to theorems, although they are not numbered
#let proof = thmproof(
	"proof",
	"Proof",
	base: "theorem",
)

#let solution = thmplain(
	"solution",
	"Solution",
	base: "exercise",
	inset: 0em,
).with(numbering: none)

#let answer = thmplain(
	"answer",
	"Answer",
	base: "question",
	inset: 0em,
).with(numbering: none)


// Template
#let project(title: "", authors: (), date: none, body) = {
	set document(author: authors, title: title, date: date)
	set text(font: "New Computer Modern", lang: "en")
	set heading(numbering: "1.", )
  // equation setting
  set math.equation(numbering: (..nums) => {
    let section = counter(heading).get().first()
    numbering("(1.1)", section, ..nums)
  })
  // matrix formatting
  set math.mat(delim: "[")
  set math.vec(delim: "[")
	set par(justify: true)

  // appereance of heading
	show heading: it => [
		#v(1em)
		#it
	]

  // style for reference
	show ref: it => {
		let eq = math.equation
		let el = it.element
		if el != none and el.func() == eq {
			// Override equation references.
			link(el.location(),numbering(
        el.numbering,
        ..counter(eq).at(el.location())
			))
		} else {
			// Other references as usual.
			it
		}
	}

  // writes title, authors, date
	align(center)[
		#block(text(weight: 700, 1.75em, title))
		#block(text(authors, weight: 200, size: 1em))
    #block(text(date.display(), weight: 200, size: 1em))
	]

  // make toc
	outline(indent: auto)

	body
}

// Shorthand for vectors
// #let va = $bold(a)$
// #let vb = $bold(b)$
// #let vx = $bold(x)$
// #let vy = $bold(y)$
// #let vz = $bold(z)$
// #let vv = $bold(v)$
// #let vw = $bold(w)$
// #let ve = $bold(e)$

// LaTeX commands translation

// Operators
// #let grad = (x) => $nabla #x$
// #let ip = (x, y) => $angle.l #x, #y angle.r$
// #let pp = (x, y) => $(diff #x) / (diff #y)$
// #let dd = (x, y) => $(d #x) / (d #y)$
// #let Df = $D f$
// #let Dg = $D g$
// #let DT = $D T$






/* Document starts here */

#show: project.with(
	title: "Introduction to Linear Algebra",
	authors: ("Haoran Li"),
  date: datetime(year: 2025, month: 6, day: 14),
)

#pagebreak()
















= Lecture 1 - System of linear equations





== Linear systems

Throughout this course, we adopt the following notations:
- #text(fill: blue)[Natural numbers]: $NN = {0, 1, 2, 3, ...}$#index[Natural numbers $NN$]
- #text(fill: blue)[Integers]: $ZZ = {..., -2, -1, 0, 1, 2, ...}$#index[Integers: $ZZ$]
- #text(fill: blue)[Rational numbers]: $QQ = {m/n | m, n in ZZ, n != 0}$#index[Rational numbers: $QQ$] is the set of fractions. Here $in$ means #text(fill: blue)[belong to]#index[belongs to: $in$].
- #text(fill: blue)[Real numbers]: $RR$#index[Real numbers: $RR$] is the set of numbers on the whole real number line. It includes:
	- irrational numbers (like $sqrt(2), root(3,3)$)
	- transcendental numbers (like $pi, e$)
- #text(fill: blue)[Complex numbers]: $CC = {a + b i | a, b in RR}$#index[Complex numbers $CC$], $i = sqrt(-1)$ is the imaginary number such that $i^2 = -1$.
- $NN subset.neq ZZ subset.neq QQ subset.neq RR subset.neq CC$
- $RR^n = {(r_1, r_2, r_3, ..., r_n) | r_1, r_2, ..., r_n in RR}$ is the set of all $n$-tuples of real numbers. Geometrically:
	- $RR^1 = RR$ is a line.
	- $RR^2$ is a plane.
	- $RR^3$ is our usual physical space.

#definition[
	A #text(fill:blue)[linear equation]#index[linear equation] in the variables $x_1,x_2,x_3,...,x_n$ is an equation that can be written in the form $
		a_1 x_1 + a_2 x_2 + a_3 x_3 + dots.h.c + a_n x_n = b
	$<eq:3-var-lineq>
	where the coefficients $a_1,a_2,a_3,...,a_n$ and $b$ are real or complex numbers, usually known in advance.
]<def:lineq>

#example[
- $x_1+1/2 x_2=2, checkmark$
- $pi(x_1+x_2)-9.9x_3=e, checkmark$. Because if we expand it, we got $pi x_1+pi x_2-9.9x_3=e$ in which case $a_1=pi,a_2=pi,a_3=-9.9,b=e$ as in the form of @eq:3-var-lineq
- $|x_2|-1=0, crossmark.heavy$
- $x_1+x_2^2=9, crossmark.heavy$
- $sqrt(x_1)+sqrt(x_2)=1, crossmark.heavy$
]<ex:examples-non-examples-of-lineq>

#definition[
	A #text(fill:blue)[system of linear equations] (or a #text(fill:blue)[linear system]#index[linear system]) is a collection of one or more linear equations involving the same variables, say $x_1,x_2,x_3,...,x_n$. $ cases(
		a_11 x_1 + a_12 x_2 + a_13 x_3 + dots.h.c + a_(1n) x_n = b_1,
		a_21 x_1 + a_22 x_2 + a_23 x_3 + dots.h.c + a_(2n) x_n = b_2,
		a_31 x_1 + a_32 x_2 + a_33 x_3 + dots.h.c + a_(3n) x_n = b_3,
    #h(9em) dots.v,
		a_(m 1) x_1 + a_(m 2) x_2 + a_(m 3) x_3 + dots.h.c + a_(m n) x_n = b_m,
	) $<eq:general-linsys>
]

#example[
	For $n=m=2$, @eq:general-linsys is just $ cases(
		a_11 x_1 + a_12 x_2 = b_1,
		a_21 x_1 + a_22 x_2 = b_2,
	) $<eq:general-2by2-linsys>
]

#example[(The Nine Chapters on the Mathematical Art).
  In a cage full of chickens and rabbits. The total number of heads is 10 and the total number of legs is 26. Calculate the number of chickens and rabbits.
]<ex:chicken-rabbit>

#solution[
  Let's assume the number of chickens and rabbits are $x_1$ and $x_2$, then we can write down a linear system $ cases(
    x_1+x_2=10,
    2x_1+4x_2=26
  ) $<eq:chicken-rabbit>
  Let's solve this linear system
  #enum(
    numbering: "step 1.",
    [
      Replace `Row2` by $#`Row2` - 2#`Row1`$, we get $ cases(
        x_1+2x_2=20,
        2x_2=6
      ) $
    ], [
      Divide `Row2` by 2, we get $ cases(
        x_1+2x_2=20,
        x_2=3
        ) $
    ], [
      Replace `Row1` by $#`Row1` - 2#`Row 2`$, we have the solution $ cases(
        x_1=14,
        x_2=3
      ) $
    ]
  )
]

#remark[
  This process is call the #text(fill:blue)[Gaussian elimination]#index[Gaussian elimination]
]

#definition[
  A #text(fill:blue)[solution] of the linear system @eq:general-linsys is $ cases(
    x_1=s_1,
    x_2=s_2,
    x_3=s_3,
    ...,
    x_n=s_n
  ) $ where $s_1,s_2,s_3,...,s_n$ are numbers that make @eq:general-linsys true. The set of all possible solutions is called the #text(fill:blue)[solution set] of the linear system. #text(fill:blue)[To solve] a linear system is to find all its solutions.
]



== Geometric interpretation

#example[
  $ cases(x_1+x_2=10, 2x_1+4x_2=26) $ describes two lines in $RR^2$, and the solution set is the intersection.
]

#question[
  How many solutions does the following linear system have?
  $ cases(
  a_(11)x_1+a_(12)x_2=b_1,
  a_(21)x_1+a_(22)x_2=b_2
  ) $
]

#answer[ It may have
  - a _unique_ solution if these two lines _intersect_.
  - (uncountably) _infinitely many_ solutions if these two lines _overlap_.
  - _no_ solutions if these two lines are _parallel_ but not overlapping.
]

#example[
  Compare the following three linear systems
  #grid( columns: 3,
    [$ display(cases(x_1+x_2=10, 2x_1+4x_2=26)) $<eq:unique-solution>],
    [$ display(cases(x_1+2x_2=10, 2x_1+4x_2=26)) $<eq:no-solutions>],
    [$ display(cases(x_1+2x_2=13, 2x_1+4x_2=26)) $<eq:inf-solutions>]
  )
  - @eq:unique-solution has a unique solution $ cases(x_1=7,x_2=3) $
  - @eq:no-solutions has no solutions since the 1st equation contradicts the 2nd.
  - @eq:inf-solutions has infinitely many solutions since the 2nd equation is twice of the 1st.

  #subpar.grid(
    figure(
      cetz.canvas(length: 1mm, {
        import cetz.draw: *
        grid((-30, -10), (30, 30), step: 10, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
        line((-30, 0), (30, 0), mark: (end: "straight"))
        content((), $x$, anchor: "west")
        line((0, -10), (0, 30), mark: (end: "straight"))
        content((), $y$, anchor: "south")
        let f(y) = 10 - y
        let g(x) = (26-2*x)/4
        line((f(30),30),(f(-10),-10),stroke:(paint:blue))
        line((-30,g(-30)),(30,g(30)),stroke:(paint:red))
        anchor("P", (2,10))
        content((), text(fill:blue)[$x_1+x_2=10$], anchor: "south-west")
        anchor("Q", (-4,5))
        content((), text(fill:red)[$2x_1+4x_2=26$], anchor: "north-east")
      }),
      caption: "Two lines intersect",
    ), <fig:two-lines-intersect>,
    figure(
      cetz.canvas(length: 3mm, {
        import cetz.draw: *
        grid((-12, -3), (12, 13), step: 3, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
        line((-12, 0), (12, 0), mark: (end: "straight"))
        content((), $x$, anchor: "west")
        line((0, -3), (0, 15), mark: (end: "straight"))
        content((), $y$, anchor: "south")
        let f(x) = (26-2*x)/4
        let g(x) = (10-x)/2
        line((-12,f(-12)),(12,f(12)),stroke:(paint:red))
        line((-12,g(-12)),(12,g(12)),stroke:(paint:blue))
        anchor("P", (2,6))
        content((), text(fill:red)[$2x_1+4x_2=26$], anchor: "south-west")
        anchor("Q", (-3,6))
        content((), text(fill:blue)[$x_1+2x_2=10$], anchor: "north-east")
      }),
      caption: "Two lines intersect",
    ), <fig:two-lines-intersect>,
    figure(
      cetz.canvas(length: 1mm, {
        import cetz.draw: *
        grid((-30, -10), (30, 30), step: 10, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
        line((-30, 0), (30, 0), mark: (end: "straight"))
        content((), $x$, anchor: "west")
        line((0, -10), (0, 30), mark: (end: "straight"))
        content((), $y$, anchor: "south")
        let f(x) = (26-2*x)/4-0.1
        let g(x) = (26-2*x)/4+0.1
        line((-30,f(-30)),(30,f(30)),stroke:(paint:blue))
        line((-30,g(-30)),(30,g(30)),stroke:(paint:red))
        anchor("P", (2,10))
        content((), text(fill:red)[$2x_1+4x_2=26$], anchor: "south-west")
        anchor("Q", (-4,5))
        content((), text(fill:blue)[$x_1+2x_2=13$], anchor: "north-east")
      }),
      caption: "Two lines intersect",
    ), <fig:two-lines-intersect>,
    columns: (1fr, 1fr),
    caption: [Two lines in a plane],
    label: <fig:two-lines-in-a-plane>,
  )
]<ex:number-of-solutions>

If we increase the number of equations, we get more lines, it might looks like
#subpar.grid(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    grid((-1, -1), (1, 1), step: 0.5, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
    line((-1,0),(1,0))
    line((0,-1),(0,1))
    line((-1,-1),(1,1))
  }),
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    grid((-1, -1), (1, 1), step: 0.5, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
    line((-1,-0.5),(1,-.5))
    line((-.5,-1),(-0.5,1))
    line((-1,1),(1,-1))
  }),
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    grid((-1, -1), (1, 1), step: 0.5, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
    line((-1,-.5),(1,-0.5))
    line((-1,.5),(1,.5))
    line((0,-1),(0,1))
  }),
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    grid((-1, -1), (1, 1), step: 0.5, stroke: (dash: "dashed", thickness:0.3pt, paint: gray))
    line((-1,-.5),(1,-0.5))
    line((-1,.5),(1,.5))
    line((-1,0),(1,0))
  }),
  columns:(1fr,1fr,1fr,1fr)
)

If we increase the number of variables, we get
- $a_1x_1+a_2x_2+a_3x_3=b$ describes a plane in $RR^3$.
- $a_1x_1+a_2x_2+a_3x_3+dots.h.c+a_n x_n=b$ describes a _hyperplane_ in $RR^n$.
- Therefore the solution set of @eq:general-linsys is the intersection of $m$ hyperplanes.

#example[
  Geometric interpretation of $ cases(x_1-3x_2+2x_3=0, -5x_1+12x_2-x_3=0) $
  #figure(
    cetz.canvas(length: 1cm, {
      import cetz.draw: *
      line((-2,-2,-2),(-2,2,4),(2,2,2),(2,-2,-4),(-2,-2,-2),stroke:(paint:red),fill:rgb(255,0,0,80))
      line((-2,-7/6,-4),(-2,-1/2,4),(2,7/6,4),(2,1/2,-4),(-2,-7/6,-4),stroke:(paint:blue),fill:rgb(0,0,255,80))
      line((-2,-6/7,-2/7),(2,6/7,2/7),stroke:(paint:purple,thickness:2pt))
      line((-4.5,0,0),(4.5,0,0),mark:(end:"straight"),stroke:(thickness:0.3pt))
      content((), $x_1$, anchor: "west")
      line((0,-2.5,0),(0,2.5,0),mark:(end:"straight"),stroke:(thickness:0.3pt))
      content((), $x_2$, anchor: "south")
      line((0,0,-4.5),(0,0,4.5),mark:(end:"straight"),stroke:(thickness:0.3pt))
      content((), $x_3$, anchor: "north")
    }),
    caption: "Two planes intersect",
  )<fig:two-lines-intersect>
]

#remark[
  It is geometrically clear that for a system of 2 equations in 3 variables, there are either no solutions or infinitely many, since two planes either intersects at a line, or overlap, or simply parallel.
]

#definition[
  We say a linear system is #text(fill:blue)[consistent]#index[consistent] if it has solution(s), and #text(fill:blue)[inconsistent]#index[inconsistent] if it has none.
]

// #example[
//   In the previous Example @ex:number-of-solutions, @eq:unique-solution and @eq:inf-solutions are consistent, while @eq:no-solutions is inconsistent
// ]

#exercise[
  + Try Gaussian elimination on the following linear systems
    - $ cases(x_1+5x_2 = 7,-2x_1 - 7x_2 = -5) $
    - $ cases(2x_1+4x_2=-4, 5x_1+7x_2=11) $
    - $ cases(x_1-x_2+x_3=1, 2x_1-x_3=1, x_1+x_2+x_3=3) $
  + Find the point of intersection of the lines $x_1-5x_2=1$ and $3x_1-7x_2=5$.
  + For what values of $h$ and $k$ is the following system consistent?
    $ cases(2x_1-x_2=h, -6x_1+3x_2=k) $
]

= Lecture 2 - Matrices and row echelon form

== Matrices

#definition[
  A $m$ by $n$ (or $m times n$) #text(fill:blue)[matrix]#index[matrix] is a rectangular array of numbers with $m$ rows and $n$ columns
  $ mat(
  a_(11), a_(12), dots.h.c, a_(1n);
  a_(21), a_(22), dots.h.c, a_(2n);
  dots.v,dots.v,dots.down,dots.v;
  a_(m 1), a_(m 2), dots.h.c, a_(m n);
  ) $<eq:general-m-by-n-matrix>
  We use the #text(fill:blue)[$(i,j)$-th entry] to mean the entry on the $i$-th row and $j$-column (i.e. $a_(i j)$).
]

#definition[
  A matrix is
  - a #text(fill:blue)[zero matrix]#index[zero matrix] is a matrix with all entries zeros.
    $ mat(
      0,0,dots.h.c,0;
      0,0,dots.h.c,0;
      dots.v,dots.v,,dots.v;
      0,0,dots.h.c,0
     ) $
  - a #text(fill:blue)[square matrix]#index[square matrix] is a matrix with the same number of rows and columns, i.e. $m=n$.
    $ mat(
      a_(11),a_(12),dots.h.c,a_(1 n);
      a_(21),a_(22),dots.h.c,a_(2 n);
      dots.v,dots.v,,dots.v;
      a_(n 1),a_(n 2),dots.h.c,a_(n n)
     ) $
  - a #text(fill:blue)[vector]#index[vector] if it only has one column, i.e. $n=1$.
    $ vec(
      a_1,a_2,dots.v,a_m
    ) $
  - a #text(fill:blue)[row vector]#index[row vector] if it only has one row, i.e. $m=1$.
    $ mat(
      a_1,a_2,dots.c.h,a_n
    ) $
  - the #text(fill:blue)[identity matrix]#index[identity matrix] if it is a square matrix with diagonal elements 1's, and 0's otherwise. Here the diagonal are the $(i,i)$-th entries.
    $ mat(
      1,0,dots.h.c,0;
      0,1,dots.h.c,0;
      dots.v,dots.v,dots.down,dots.v;
      0,0,dots.h.c,1
    ) $
]

#definition[
  Soon we will be getting tired of writing all these equations in the linear system @eq:general-linsys, instead we write down its #text(fill:blue)[augmented matrix]#index[augmented matrix] $ mat(
    a_(11),a_(12),a_(13),dots.h.c,a_(1 n),b_1;
    a_(21),a_(22),a_(23),dots.h.c,a_(2 n),b_2;
    a_(31),a_(32),a_(33),dots.h.c,a_(3 n),b_3;
    dots.v,dots.v,dots.v,,dots.v;
    a_(m 1),a_(m 2),a_(m 3),dots.h.c,a_(m n),b_m
  ) $
  Which is obtained by omitting $x_i$'s, pluses, and equal signs. If we delete the last column, we will get the #text(fill:blue)[coefficient matrix]#index[coefficient matrix] $ mat(
    a_(11),a_(12),a_(13),dots.h.c,a_(1 n);
    a_(21),a_(22),a_(23),dots.h.c,a_(2 n);
    a_(31),a_(32),a_(33),dots.h.c,a_(3 n);
    dots.v,dots.v,dots.v,,dots.v;
    a_(m 1),a_(m 2),a_(m 3),dots.h.c,a_(m n)
  ) $
]

#example[
  - For @eq:chicken-rabbit, its augmented matrix and coefficient matrix are
  $ mat(
  1,1,10;
  2,4,26
  ), mat(
  1,1;
  2,4
  ) $
  - For $ cases(x_1-x_2+x_3=1, 2x_1-x_3=1,x_1+x_2+x_3=3) $, its augmented matrix and coefficient matrix are $ mat(
  1,-1,1,1;
  2,0,-1,1;
  1,1,1,3
  ), mat(
  1,-1,1;
  2,0,-1;
  1,1,1
   ) $
  - In general, a linear system of $m$ equations in $n$ variables has a $m$ by $(n+1)$ augmented matrix and a $m$ by $n$ coefficient matrix.
]

#definition[
  Inspired by Gaussian elimination, we define the following three #text(fill:blue)[elementary row operations]#index[elementary row operations]
  - #text(fill:blue)[Replacement]#index[row replacement]: Replace one row by the sum of itself and a multiple of another row.
  - #text(fill:blue)[Interchangement]#index[row interchange]: Interchange two rows.
  - #text(fill:blue)[Scaling]#index[row scaling]: Multiply all entries in a row by a _nonzero_ constant.
  We say matrices $A,B$ are #text(fill:blue)[row equivalent]#index[row equivalence] ($A tilde B$) if $B$ can obtained by applying a sequence of elementary row operations to $A$ (or vise versa).
]

#example[
  Let's rewrite the process in Example @ex:chicken-rabbit
  $ mat(
  1,1,10;
  2,4,26
  )xarrow(#`R2`-> #`R2`-2#`R1`)
  mat(
  1,1,10;
  0,2,6
  )xarrow(#`R2`-> #`R2` / 2 )
  mat(
  1,1,10;
  0,1,3
  )xarrow(#`R1`-> #`R1`-#`R2`)
  mat(
  1,0,7;
  0,1,3
  ) $
]


#example[
  Solve $ cases(x_1-x_2+x_3=1, 2x_1-x_3=1,x_1+x_2+x_3=3) $ with augmented matrix.
  $ & mat(
    1,-1,1,1;
    2,0,-1,1;
    1,1,1,3;
  )xarrow(#`R2`-> #`R2`-2#`R1`)
  mat(
    1,-1,1,1;
    0,2,-3,-1;
    1,1,1,3;
  )xarrow(#`R3`-> #`R3`-#`R1`)mat(
    1,-1,1,1;
    0,2,-3,-1;
    0,2,0,2;
  ) \
  & xarrow(#`R3`-> #`R3`-#`R2`)mat(
    1,-1,1,1;
    0,2,-3,-1;
    0,0,3,3;
  )xarrow(#`R3`-> #`R3`/3)mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,0,1,1;
  )xarrow( #`R1`-> #`R1`-#`R3` \ #`R2`-> #`R2`+3#`R3` )mat(
  1,-1,0,0;
  0,2,0,2;
  0,0,1,1;
  ) \
  &xarrow(#`R2`-> #`R2` / 2 )mat(
  1,-1,0,0;
  0,1,0,1;
  0,0,1,1;
  )xarrow(#`R1`-> #`R1`+#`R2`)mat(
  1,0,0,1;
  0,1,0,1;
  0,0,1,1;
  )
  $
  This gives the unique solution $ cases(x_1=1, x_2=1, x_3=1) $
]<ex:example1>

== Row echelon form

#definition[
  - A #text(fill:blue)[leading entry]#index[leading entry] of a row refers to the leftmost nonzero entry (in a nonzero row).
  - A matrix is of #text(fill:blue)[row echelon form (REF)]#index[row echelon form (REF)] if it is of a "staircase shape".
    $ limits(mat(
      square.filled ,*,*,*,*,*,*,*;
      0,0,square.filled ,*,*,*,*,*;
      0,0,0,0,square.filled ,*,*,*;
      0,0,0,0,0,square.filled ,*,*;
    ))^("REF") $
    $square.filled $ are the leading entries, $*$ are some unknown numbers.
  - The leading entries of an REF matrix are called #text(fill:blue)[pivots]#index[pivot].
  - The position of pivots are called #text(fill:blue)[pivot positions]#index[pivot positions].
  - The column pivots are in are called #text(fill:blue)[pivot columns]#index[pivot columns].
  - An REF of #text(fill:blue)[reduced row echelon form (RREF)]#index[reduced row echelon form, RREF] if all its pivots are 1's and in each pivot column, every entry except the pivot are 0's.
    $ limits(mat(
    1,*,0,*,0,0,*,*;
    0,0,1,*,0,0,*,*;
    0,0,0,0,1,0,*,*;
    0,0,0,0,0,1,*,*;
    ))^("RREF") $
]

#example[
  In Example @ex:example1, $ mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,2,0,2;
  ) $ is not an REF. $ mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,0,3,3;
  ) $ is an REF, but not an RREF. $ mat(
  1,0,0,1;
  0,1,0,1;
  0,0,1,1;
  ) $ is an RREF.
]

#theorem[
  Every matrix is row equivalent to some REF matrix (which is not in general unique), but it is row equivalent to some unique RREF matrix.
]<thm:unique-rref>

#remark[
  This ensures that the pivot positions are well-defined, i.e. you won't get different pivot positions if you applied different row operations
]

#example[
  In Example @ex:example1, $ mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,0,3,3;
  ) $ is an REF that is row equivalent to the original matrix $ mat(
  1,-1,1,1;
  2,0,-1,1;
  1,1,1,3;
  ) $ and $ mat(
  1,0,0,1;
  0,1,0,1;
  0,0,1,1;
  ) $ is its unique row equivalent RREF.
]

#remark[
  A linear system has a unique solution if and only if its RREF deleting the last column gives the identity matrix.
]

#example[
  Solve $ cases(x_1-x_2+x_3=1, 2x_1-x_3=1,x_1+x_2-2x_3=1) $ with augmented matrix.
  $ mat(
  1,-1,1,1;
  2,0,-1,1;
  1,1,-2,1;
  )xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-#`R1` )mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,2,-3,0;
  )xarrow(#`R3`-> #`R3`-#`R2`)mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,0,0,1;
  ) $
  You might notice that the last row represents $0 x_1 + 0 x_2 + 0 x_3 = 1$, this is a contradiction, therefore the linear system is inconsistent.
]<ex:no-solution-system>

#remark[
  This only happens if and only if the last pivot column is the last column
]

#example[
$ cases(x_1-x_2+x_3=1, 2x_1-x_3=1) $
we write down its augmented matrix
$ &mat(
1,-1,1,1;
2,0,-1,1;
)xarrow(#`R2`-> #`R2`-2#`R1`)mat(
1,-1,1,1;
0,2,-3,-1;
) \
&xarrow( #`R2` / 2 )mat(
1,-1,1,1;
0,1,- 3 / 2 ,- 1 / 2 ;
)xarrow(#`R1`-> #`R1`+#`R2`)mat(
1,0,- 1 / 2 , 1 / 2 ;
0,1,- 3 / 2 ,- 1 / 2 ;
) $
This gives the solution set
$ cases(x_1- 1 / 2 x_3= 1 / 2 , x_2- 3 / 2 x_3= 1 / 2 ) => cases(x_1= 1 / 2 x_3+ 1 / 2 , x_2= 3 / 2 x_3- 1 / 2) $
]<ex:example3>

Let's formalize these as #text(fill:blue)[row reduction algorithm]#index[row reduction algorithm]
#set enum(numbering: "step 1.")
+ Begin with the leftmost nonzero column. This is a pivot column. The pivot position should be at the top.
+ Select a nonzero entry in the pivot column as a pivot. If necessary, interchange rows to move this entry into the pivot position.
+ Use row replacement operations to create zeros in all positions below the pivot.
+ Cover (or ignore) the rows containing the pivot positions. Apply Steps 1-3 to the rows that remains. Repeat the process until you are left with an REF.
+ Beginning with the rightmost pivot and working upward and to the left, create zeros above each pivot. If a pivot is not 1, make it 1 by a scaling operation.

Steps 1-4 are call #text(fill:blue)[forward phase], after which you get an REF. Step 5 is called #text(fill:blue)[backward phase], after which you get the RREF.
#set enum(numbering: "1.")

#example[
  Consider the augmented matrix $ mat(
  0,-3,-6,4,9;
  -1,-2,-1,3,1;
  -2,-3,0,3,-1;
  1,4,5,-9,-7;
  ) $
  - Forward phase
  $ mat(
  0,-3,-6,4,9;
  -1,-2,-1,3,1;
  -2,-3,0,3,-1;
  1,4,5,-9,-7;
  )xarrow(#`R1` arrow.l.r  #`R4` \ "Step 1,2")mat(
  1,4,5,-9,-7;
  -1,-2,-1,3,1;
  -2,-3,0,3,-1;
  0,-3,-6,4,9;
  ) $
  $ mat(
  1,4,5,-9,-7;
  -1,-2,-1,3,1;
  -2,-3,0,3,-1;
  0,-3,-6,4,9;
  )xarrow(#`R2`-> #`R2`+#`R1` \ #`R3`-> #`R3`+2#`R1` \ "Step 3") mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,5,10,-15,-15;
  0,-3,-6,4,9;
  ) $
  $ mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,5,10,-15,-15;
  0,-3,-6,4,9;
  )xarrow(#`R3`-> #`R3`- 5 / 2 #`R2` \ #`R4`-> #`R4`+ 3 / 2 #`R2`\ "Step 4,1,2,3")mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,0,0,0,0;
  0,0,0,-5,0;
  ) $
  $ mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,0,0,0,0;
  0,0,0,-5,0;
  )xarrow(#`R3` arrow.l.r  #`R4` \ "Step 4,1")mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,0,0,-5,0;
  0,0,0,0,0;
  ) $
  - Backward phase
  $ &mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,0,0,-5,0;
  0,0,0,0,0;
  )xarrow(#`R3`-> #`R3`/(-5) \ "Step 5") mat(
  1,4,5,-9,-7;
  0,2,4,-6,-6;
  0,0,0,1,0;
  0,0,0,0,0;
  )xarrow(#`R1`-> #`R1`+9#`R3` \ #`R2`-> #`R2`+6#`R3` \ "Step 5") mat(
  1,4,5,0,-7;
  0,2,4,0,-6;
  0,0,0,1,0;
  0,0,0,0,0;
  ) \
  &xarrow(#`R2`-> #`R2`/2 \ "Step 5") mat(
  1,4,5,0,-7;
  0,1,2,0,-3;
  0,0,0,1,0;
  0,0,0,0,0;
  )xarrow(#`R1`-> #`R1`-4#`R2` \ "Step 5") mat(
  1,0,-3,0,5;
  0,1,2,0,-3;
  0,0,0,1,0;
  0,0,0,0,0;
  ) $
]

#definition[
  The variables corresponding to pivot columns in a matrix are called #text(fill:blue)[basic variables]#index[basic variable], the other variables are called #text(fill:blue)[free variables]#index[free variable]. In a solution set, basic variables are expressed in terms of free variables, and a free variable can take any value.
]

#example[
  In Example @ex:example3, $x_1,x_2$ are basic variables and $x_3$ is a free variable. And we formally write our solution set as $ cases(
    x_1= 1 / 2 x_3+ 1 / 2,
    x_2= 3 / 2 x_3- 1 / 2,
    x_3 "is free"
  ) $
]

#exercise[
  Find the general solution of the system $ cases(x_1-2x_2-x_3 + 3x_4 = 0, -2x_1 + 4x_2 + 5x_3 - 5x_4 = 3, 3x_1 - 6x_2 - 4x_3 + 8x_4 = 2) $
]<exer:exercise1>

#solution[
  $ &mat(
  1,-2,-1,3,0;
  -2,4,5,-5,3;
  3,-6,-4,8,2;
  )xarrow( #`R2`-> #`R2`+2#`R1` \ #`R3`-> #`R3`-3#`R1` )mat(
  1,-2,-1,3,0;
  0,0,3,1,3;
  0,0,-1,-1,2;
  )xarrow(#`R3`->(-1) dot.c  #`R3`)mat(
  1,-2,-1,3,0;
  0,0,3,1,3;
  0,0,1,1,-2;
  ) \
  &xarrow(#`R2`-> #`R2`-3#`R3`)mat(
  1,-2,-1,3,0;
  0,0,0,-2,9;
  0,0,1,1,-2;
  )xarrow(#`R2` arrow.l.r  #`R3`)mat(
  1,-2,-1,3,0;
  0,0,1,1,-2;
  0,0,0,-2,9;
  ) \
  &xarrow(#`R3`-> #`R3` / -2 )mat(
  1,-2,-1,3,0;
  0,0,1,1,-2;
  0,0,0,1,- 9 / 2 ;
  )xarrow( #`R2`-> #`R2`-#`R3` \ #`R1`-> #`R1`-3#`R3` )mat(
  1,-2,-1,0, 27 / 2 ;
  0,0,1,0, 5 / 2 ;
  0,0,0,1,- 9 / 2 ;
  )xarrow(#`R1`-> #`R1`+#`R2`)mat(
  1,-2,0,0,16;
  0,0,1,0, 5 / 2 ;
  0,0,0,1,- 9 / 2 ;
  ) $
  Write this as solution set, we get
  $ cases(x_1-2x_2=16, x_3= 5 / 2 , x_4=- 9 / 2) => cases(
    x_1=2x_2+16,
    x_2 " is free",
    x_3= 5 / 2,
    x_4=- 9 / 2
  ) $
]

#theorem[
  Suppose the augmented matrix of a linear system is $mat(A,bold(b))$, and its RREF is $mat(U,bold(d))$, then the linear system has
  + no solutions $<=> bold(d)$ is a pivot column, i.e. contains a pivot.
  + has solutions $<=> bold(d)$ is not a pivot column
    - a unique solution $<=>$ every column of $U$ is a pivot column.
    - infinitely many solutions $<=>$ some columns of $U$ is not a pivot column.
]<thm:sol-pivot>

#example[
  - In Example @ex:no-solution-system, the linear system has no solutions since
  $
  mat(
  A,bold(b)
  )=
  mat(
  1,-1,1,1;
  2,0,-1,1;
  1,1,-2,1;
  )-> mat(
  1,-1,1,1;
  0,2,-3,-1;
  0,0,0,1;
  )=mat(
  U,bold(d)
  )
  $
  - In Example  @ex:example1, the linear system has a unique solution since
  $
  mat(
  A,bold(b)
  )=mat(
  1,-1 ,1, 1;
  2,0 ,-1 ,1;
  1,1,1 ,3
  )-> mat(
  1,0,0,1;
  0,1,0,1;
  0,0,1,1;
  )=mat(U,bold(d))
  $
  - In Example @exer:exercise1, the linear system has infinitely many solutions since
  $
  mat(
  A,bold(b)
  )=mat(
  1,-2,-1,3,0;
  -2,4,5,-5,3;
  3,-6,-4,8,2;
  )-> mat(
  1,-2,0,0,16;
  0,0,1,0, 5 / 2 ;
  0,0,0,1,- 9 / 2 ;
  )=mat(U,bold(d))
  $
]

#exercise[
  Find the general solutions of the system with given augmented matrix, name the pivot columns, pivot positions, basic and free variables.
  - $ mat(
  0,1,-6,5;
  1,-2,7,-4;
  ) $
  - $ mat(
  1,-7,0,6,5;
  0,0,1,-2,-3;
  -1,7,-4,2,7
  ) $
]

#question[
How does the size of the augmented matrix affect the solution set?
]

= Lecture 3 - Matrix algebra

== Matrix addition and scalar multiplication

#definition[
  Let's use $M_(m times n)(RR)$ to denote the set of all (real-valued) $m$ by $n$ matrices.
]

#definition[
  Suppose $A,B$ are $m times  n$ matrices, $c$ is a scalar (i.e. a number), then we can define
  - Addition
  $ &mat(
  a_(11),a_(12),dots.h.c,a_(1 n);
  a_(21),a_(22),dots.h.c,a_(2 n);
  dots.v,dots.v,,dots.v;
  a_(m 1),a_(m 2),dots.h.c,a_(m n)
  )+mat(
  b_(11),b_(12),dots.h.c,b_(1n);
  b_(21),b_(22),dots.h.c,b_(2n);
  dots.v,dots.v,,dots.v;
  b_(m 1),b_(m 2),dots.h.c,b_(m n)
  ) \
  &=mat(
  a_(11)+b_(11),a_(12)+b_(12),dots.h.c,a_(1 n)+b_(1n);
  a_(21)+b_(21),a_(22)+b_(22),dots.h.c,a_(2 n)+b_(2n);
  dots.v,dots.v,,dots.v;
  a_(m 1)+b_(m 1),a_(m 2)+b_(m 2),dots.h.c,a_(m n)+b_(m n)
  ) $
  - Scalar multiplication
  $
  c mat(
  a_(11),a_(12),dots.h.c,a_(1 n);
  a_(21),a_(22),dots.h.c,a_(2 n);
  dots.v,dots.v,,dots.v;
  a_(m 1),a_(m 2),dots.h.c,a_(m n)
  )=mat(
  c a_(11),c a_(12),dots.h.c,c a_(1 n);
  c a_(21),c a_(22),dots.h.c,c a_(2 n);
  dots.v,dots.v,,dots.v;
  c a_(m 1),c a_(m 2),dots.h.c,c a_(m n)
  )
  $
]

#example[
  + $ mat(
  1,2;
  3,4
  )+mat(
  4,3;
  2,1
  )=mat(
  5,5;
  5,5
  ) $
  + $ 2mat(
  1,2;
  3,4
  )=mat(
  2,4;
  6,8
  ) $
]

== Matrix multiplication

#definition[
  Suppose $A$ is a $m times  n$ matrix, and $B$ is a $n times  p$ matrix, we can define #text(fill:blue)[matrix multiplication]#index[matrix multiplication] $A B$ to be the $m times  p$ matrix, computed via the #text(fill:blue)[row-column rule]#index[rule-column rule]: The $(i,j)$-entry is to multiply the $i$-row and $j$-th column
  $
  mat(
  ;
  ;
  ;
  a_(i 1),a_(i 2),dots.h.c ,a_(i n);
  ;
  ;
  )mat(
  ,,b_(1 j),,,;
  ,,b_(2 j),,,;
  ,,dots.v,,,;
  ,,b_(n j),,,;
  )=mat(
  ,,,,,;
  ,,,,,;
  ,,,,,;
  ,,square.filled ,,;
  ,,,,,;
  ,,,,,
  )
  $
  Where the $(i,j)$-entry $square.filled =a_(i 1)b_(1 j)+a_(i 2)b_(2 j)+dots.h.c+a_(i n)b_(n j)$.

  If $A$ is a square matrix, then we could define matrix power $A^k$ to be simply $overbrace(A dots.h.c A, k " times")$
]

#example[
  - $ mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23)
  )
  &mat(
  b_(11),b_(12);
  b_(21),b_(22);
  b_{31},b_(32)
  ) \
  =&mat(
  a_(11)b_(11)+a_(12)b_(21)+a_(13)b_{31} , a_(11)b_(12)+a_(12)b_(22)+a_(13)b_(32);
  a_(21)b_(11)+a_(22)b_(21)+a_(23)b_{31} , a_(21)b_(12)+a_(22)b_(22)+a_(23)b_(32)
  ) $
  - $ mat(
  1,2,2;
  2,1,1
  )mat(
  3,1;
  1,2;
  2,3
  )=mat(
  1 dot.c 3+2 dot.c 1+2 dot.c 2,1 dot.c 1+2 dot.c 2+2 dot.c 3;
  2 dot.c 3+1 dot.c 1+1 dot.c 2,2 dot.c 1+1 dot.c 2+1 dot.c 3
  )=mat(
  9,11;
  9,7
  ) $
  - $ mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23)
  )
  mat(
  x_1;
  x_2;
  x_3
  )&=mat(
  a_(11)x_1+a_(12)x_2+a_(13)x_3 ;
  a_(21)x_1+a_(22)x_2+a_(23)x_3
  ) \
  &=x_1 mat(a_(11);a_(21))+x_1 mat(a_(12);a_(22))+x_1 mat(a_(13);a_(23))
  $
  - $ mat(
  0,1;
  0,0
  )mat(
  1,0;
  0,0
  )=mat(
  0 dot.c 1+1 dot.c 0,0 dot.c 0+1 dot.c 0;
  0 dot.c 1+0 dot.c 0,0 dot.c 0+0 dot.c 0
  )=mat(
  0,0;
  0,0
  ) $<eq:equation1>
  - $ mat(
  1,0;
  0,0
  )mat(
  0,1;
  0,0
  )=mat(
  1 dot.c 0+0 dot.c 0,1 dot.c 1+0 dot.c 0;
  0 dot.c 0+0 dot.c 0,0 dot.c 1+0 dot.c 0
  )=mat(
  0,1;
  0,0
  ) $<eq:ABnotBA>
  \item
  $
  mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33);
  )mat(
  1,0,0;
  0,1,0;
  0,0,1
  )=mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33);
  )
  $
  \item
  $
  mat(
  1,0,0;
  0,1,0;
  0,0,1
  )mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33);
  )=mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33);
  )
  $
]

#example[
  + $ mat(
  1,0,-3;
  0,1,0;
  0,0,1
  )mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33);
  )=mat(
  a_(11)-3a_(31),a_(12)-3a_(32),a_(13)-3a_(33);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33);
  ) $
  + $ mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33)
  )mat(
  1,0,0;
  0,1,0;
  2,0,1
  )=mat(
  a_(11)+2a_(13),a_(12),a_(13);
  a_(21)+2a_(23),a_(22),a_(23);
  a_(31)+2a_(33),a_(32),a_(33);
  ) $
  + $ mat(
  1,0,0;
  0,2,0;
  0,0,1
  )mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33)
  )=mat(
  a_(11),a_(12),a_(13);
  2a_(21),2a_(22),2a_(23);
  a_(31),a_(32),a_(33)
  ) $
  + $ mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33)
  )mat(
  1,0,0;
  0,3,0;
  0,0,1
  )=mat(
  a_(11),3a_(12),a_(13);
  a_(21),3a_(22),a_(23);
  a_(31),3a_(32),a_(33)
  ) $
  + $ mat(
  0,0,1;
  0,1,0;
  1,0,0
  )mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33)
  )=mat(
  a_(31),a_(32),a_(33);
  a_(21),a_(22),a_(23);
  a_(11),a_(12),a_(13)
  ) $
  + $ mat(
  a_(11),a_(12),a_(13);
  a_(21),a_(22),a_(23);
  a_(31),a_(32),a_(33)
  )mat(
  0,1,0;
  1,0,0;
  0,0,1
  )=mat(
  a_(12),a_(11),a_(13);
  a_(22),a_(21),a_(23);
  a_(32),a_(31),a_(33)
  ) $
]<ex:elementary-matrices>


#exercise[
  Suppose $A=mat(
  1,1,1;
  2,2,1;
  2,1,1
  ), B=mat(
  1,1,1;
  2,2,1;
  2,1,1
  )$, computes matrix multiplication $A B$
]

#fact[\label{fact:mat-alg}
  Suppose $A,B,C,D$ are matrices, $c$ is a scalar, $0$ is the zero matrix, $I$ is the identity matrix. we have the following facts
  #set enum(numbering: "a.")
  - Matrix multiplication is generally _NOT commutative_, i.e. $A B!=B A$
  - Matrix multiplication is _associative_, i.e. the order of multiplication doesn't matter, in other words $(A B)C=A(B C)$, so it makes sense to write successive multiplication $A_1 A_2 A_3 dots.h.c A_n$
  - Scalar multiplication and matrix multiplication commutes, $A(c B)=c(A B)=(c A)B$. so it makes sense to write $c A_1 A_2 A_3 dots.h.c A_n$
  - Matrix multiplication is _distributive_ over addition, i.e. $A(B+C)=A B+A C$, $(A+B)C=A C+B C$
  - Zero matrix and identity matrix acts as 0 and 1, i.e. $A+0=0+A=A$, $A 0=0 A=0$, $I A=A I=A$
  - Even if $A!=0$, $B!=0$, $A B$ could still be $0$, take \eqref{ eq:equation1} for an example
  - $A B=A C$ does NOT imply $B=C$
  #set enum(numbering: "1.")
]<fact:mat-alg>

#remark[
  Some of the properties of matrices are really similar to that of numbers, so we dub this the name of _matrix algebra_
]

== Partitioned matrix

#definition[
  $A$ is a #text(fill:blue)[partitioned] (or #text(fill:blue)[block]) matrix#index[partitioned matrix] if is divided into smaller submatrix by some horizontal and vertical lines. And the submatrices are the blocks
  $ [#grid(
    columns: (2em,)*3,
    rows: 1.2em,
    grid.hline(y:1),
    grid.hline(y:2),
    grid.vline(x:1),
    grid.vline(x:2),
    [$A_(1 1)$],[$A_(1 2)$],[$A_(1 3)$],
    [$A_(2 1)$],[$A_(2 2)$],[$A_(2 3)$],
    [$A_(3 1)$],[$A_(3 2)$],[$A_(3 3)$],
  )] = [#grid(
    columns: (2em,)*7,
    rows: 1.2em,
    grid.hline(y:2),
    grid.hline(y:3),
    grid.vline(x:2),
    grid.vline(x:6),
    [$a_(11)$],[$a_(12)$],[$a_(13)$],[$a_(1 4)$],[$a_(1 5)$],[$a_(1 6)$],[$a_(1 7)$],
    [$a_(21)$],[$a_(22)$],[$a_(23)$],[$a_(2 4)$],[$a_(2 5)$],[$a_(2 6)$],[$a_(2 7)$],
    [$a_(31)$],[$a_(32)$],[$a_(33)$],[$a_(3 4)$],[$a_(3 5)$],[$a_(3 6)$],[$a_(3 7)$],
    [$a_(4 1)$],[$a_(4 2)$],[$a_(4 3)$],[$a_(4 4)$],[$a_(4 5)$],[$a_(4 6)$],[$a_(4 7)$],
    [$a_(5 1)$],[$a_(5 2)$],[$a_(5 3)$],[$a_(5 4)$],[$a_(5 5)$],[$a_(5 6)$],[$a_(5 7)$],
    [$a_(6 1)$],[$a_(6 2)$],[$a_(6 3)$],[$a_(6 4)$],[$a_(6 5)$],[$a_(6 6)$],[$a_(6 7)$],
  )] $
  Here the blocks are $A_(1 1)=display(mat(
  a_(11),a_(12);
  a_(21),a_(22)
  ))$,
  $A_(1 2)=display(mat(
  a_(13),a_(1 4),a_(1 5),a_(1 6);
  a_(23),a_(2 4),a_(2 5),a_(2 6)
  ))$,
  $A_(1 3)=display(mat(a_(1 7); a_(2 7)))$,
  $A_(2 1)=display(mat(a_(31),a_(32)))$, \
  $A_(2 2)=display(mat(a_(33),a_(3 4),a_(3 5),a_(3 6)))$,
  $A_(2 3)=display(mat(a_(3 7)))$,
  $A_(3 1)=display(mat(
  a_(4 1),a_(4 2);
  a_(5 1),a_(5 2);
  a_(6 1),a_(6 2)
  ))$,
  $A_(3 2)=display(mat(
  a_(4 3),a_(4 4),a_(4 5),a_(4 6);
  a_(5 3),a_(5 4),a_(5 5),a_(5 6);
  a_(6 3),a_(6 4),a_(6 5),a_(6 6)
  ))$,
  $A_(3 3)=display(mat(a_(4 7); a_(5 7); a_(6 7)))$.
]

#fact[
  Suppose $A=mat(
  A_(1 1),A_(1 2),dots.h.c, A_(1 q);
  A_(2 1),A_(2 2),dots.h.c, A_(2 q);
  dots.v,dots.v,,dots.v;
  A_(p 1),A_(p 2),dots.h.c, A_(p q);
  )$, $B=mat(
  B_(11),B_(12),dots.h.c, B_(1r);
  B_(21),B_(22),dots.h.c, B_(2r);
  dots.v,dots.v,,dots.v;
  B_(q 1),B_(q 2),dots.h.c, B_(q r);
  )$ are partitioned matrices, and the number of columns of $A_(1 k)$ is equal to the number of rows of $B_(k 1)$ (so that all submatrices multiplications make sense). Then the usual row-column rule still WORKS!!! By treating submatrices as if they are numbers.
  $
  A B=C=mat(
  C_(11),C_(12),dots.h.c, C_(1 r);
  C_(21),C_(22),dots.h.c, C_(2 r);
  dots.v,dots.v,dots.down,dots.v;
  C_(p 1),C_(p 2),dots.h.c, C_(p r);
  ), C_(i j)=A_(i 1)B_(1j)+A_(i 2)B_(2j)+dots.h.c+A_(i q)B_(q j)
  $
]

#example[
  Consider $ [#grid(
    columns: (2em,)*2,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:1),
    grid.vline(x:1),
    [$A_(1 1)$],[$A_(1 2)$],
    [$A_(2 1)$],[$A_(2 2)$]
  )] = [#grid(
    columns: (1em,)*3,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:2),
    grid.vline(x:2),
    [1],[1],[1],
    [2],[2],[1],
    [2],[1],[1]
  )]$, $ [#grid(
    columns: (2em,)*2,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:1),
    grid.vline(x:1),
    [$B_(1 1)$],[$B_(1 2)$],
    [$B_(2 1)$],[$B_(2 2)$]
  )] = [#grid(
    columns: (1em,)*3,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:2),
    grid.vline(x:1),
    [1],[1],[1],
    [2],[2],[1],
    [2],[1],[1]
  )]$, then
  $
  A_(1 1)B_(11)+A_(1 2)B_(21)=mat(
  1,1;
  2,2
  )mat(
  1;2
  )+mat(
  1;1
  )mat(
  2
  )=mat(
  5;8
  )
  $
  $
  A_(1 1)B_(12)+A_(1 2)B_(22)=mat(
  1,1;
  2,2
  )mat(
  1,1;
  2,1
  )+mat(
  1;1
  )mat(
  1,1
  )=mat(
  4,3;7,5
  )
  $
  $
  A_(2 1)B_(11)+A_(2 2)B_(21)=mat(
  2,1
  )mat(
  1;2
  )+mat(
  1
  )mat(
  2
  )=mat(
  6
  )
  $
  $
  A_(2 1)B_(12)+A_(2 2)B_(22)=mat(
  2,1
  )mat(
  1,1;
  2,1
  )+mat(
  1
  )mat(
  1,1
  )=mat(
  5,4
  )
  $
  $ [#grid(
    columns: (2em,)*2,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:1),
    grid.vline(x:1),
    [$A_(1 1)$],[$A_(1 2)$],
    [$A_(2 1)$],[$A_(2 2)$]
  )] [#grid(
    columns: (2em,)*2,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:1),
    grid.vline(x:1),
    [$B_(1 1)$],[$B_(1 2)$],
    [$B_(2 1)$],[$B_(2 2)$]
  )] = [#grid(
    columns: (7.8em,)*2,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:1),
    grid.vline(x:1),
    [$A_11B_11+A_12B_21$],[$A_11B_12+A_12B_22$],
    [$A_21B_11+A_22B_21$],[$A_21B_12+A_22B_22$],
  )] = [#grid(
    columns: (1em,)*3,
    rows: 1.2em,
    inset: 2pt,
    grid.hline(y:2),
    grid.vline(x:2),
    [5],[4],[3],
    [8],[7],[5],
    [6],[5],[4]
  )] $
]

// #example[
//   Suppose $3 times 3$ matrix $A$ can be partitioned into $mat(
//   #`R1`;#`R2`;#`R3`
//   )$ or $mat(
//   \mathbf a_1,\mathbf a_2,\mathbf a_3
//   )$, then Example @(ex:elementary-matrices) reads
//   \begin{enumerate}
//   - $E=mat(
//   1,0,-3;
//   0,1,0;
//   0,0,1
//   )$, $EA=mat(
//   1,0,-3;
//   0,1,0;
//   0,0,1
//   )mat(
//   #`R1`;#`R2`;#`R3`
//   )=mat(
//   #`R1`-3#`R3`;#`R2`;#`R3`
//   )$, $EA$ acts as subtracting 3 times row 3 from row 1.
//   - $E=mat(
//   1,0,0;
//   0,1,0;
//   2,0,1
//   )$, $AE=mat(
//   \mathbf a_1,\mathbf a_2,\mathbf a_3
//   )mat(
//   1,0,0;
//   0,1,0;
//   2,0,1
//   )=mat(
//   \mathbf a_1+2\mathbf a_3,\mathbf a_2,\mathbf a_3
//   )$, $AE$ acts as adding 2 times column 3 to column 1.
//   - $E=mat(
//   1,0,0;
//   0,2,0;
//   0,0,1
//   )$, $EA=mat(
//   1,0,0;
//   0,2,0;
//   0,0,1
//   )mat(
//   #`R1`;#`R2`;#`R3`
//   )=mat(
//   #`R1`;2#`R2`;#`R3`
//   )$, $EA$ acts as scaling the third row by 2.
//   - $E=mat(
//   1,0,0;
//   0,3,0;
//   0,0,1
//   )$, $AE=mat(
//   \mathbf a_1,\mathbf a_2,\mathbf a_3
//   )mat(
//   1,0,0;
//   0,3,0;
//   0,0,1
//   )=mat(
//   \mathbf a_1,3\mathbf a_2,\mathbf a_3
//   )$, $AE$ acts as scaling the third column by 3.
//   - $E=mat(
//   0,0,1;
//   0,1,0;
//   1,0,0
//   )$, $EA=mat(
//   0,0,1;
//   0,1,0;
//   1,0,0
//   )mat(
//   #`R1`;#`R2`;#`R3`
//   )=mat(
//   #`R3`;#`R2`;#`R1`
//   )$, $EA$ acts as interchanging row 1 and row 3.
//   - $E=mat(
//   0,1,0;
//   1,0,0;
//   0,0,1
//   )$, $AE=mat(
//   \mathbf a_1,\mathbf a_2,\mathbf a_3
//   )mat(
//   0,1,0;
//   1,0,0;
//   0,0,1
//   )=mat(
//   \mathbf a_2,\mathbf a_1,\mathbf a_3
//   )$, $AE$ acts as interchanging column 1 and column 2.
//   \end{enumerate}
// ]

// #definition[
// Matrices $E$ in the previous example is called #text(fill:blue)[elementary matrices]#index[elementary matrices]. They describe row and column elementary operations.
// ]

// #exercise[
// If $A$ is a 4 by 5 matrix, what is the elementary matrix $E$ that acts as replacing the fourth row by adding twice of the second row.
// ]

// #exercise[
// Suppose $B=mat(
// bold(b)_1,bold(b)_2,dots.h.c,bold(b)_n
// )$, show that $AB=mat(
// Abold(b)_1,Abold(b)_2,dots.h.c,Abold(b)_n
// )$
// ]

// #exercise[
// Verify that $A^2=I_2$ where $A=mat(
// 1,0;3,-1
// )$, and use partitioned matrices to show that $M^2=I_4$, where $M=mat(
// 1,0,0,0;
// 3,-1,0,0;
// 1,0,-1,0;
// 0,1,-3,1
// )$
// ]

// #exercise[
// Suppose $mat(
// A,bold(b)
// )tilde mat(
// U,bold(d)
// )$ is the REF/RREF, then $U$ will also be the REF/RREF of $A$.
// ]

// #solution[
// Suppose the row elementary operations applied are $E_1,E_2,dots.h.c,E_k$, then
// \begin{center}
// \begin{tikzpicture}
// \node (0,0)[above]{$mat( A,bold(b) )tilde  E_1mat( A,bold(b) )tilde  E_2E_1mat( A,bold(b) )tilde dots.h.ctilde  E_kdots.h.c E_2E_1mat( A,bold(b) )=mat( U,bold(d) )$};
// \foreach \x/\y/\expr in {
// -3.2/-3.5/{mat( E_1A,E_1bold(b) )},
// -1/-1/{mat( E_2E_1A,E_2E_1bold(b) )},
// 3.5/3.5/{mat( E_kdots.h.c E_2E_1A,E_kdots.h.c E_2E_1bold(b) )}
// }{
// \draw (\x-.05,0)--(\y-.05,-0.5);
// \draw (\x+.05,0)--(\y+.05,-0.5);
// \node at (\y,-.5)[below] {$\expr$};
// }
// \end{tikzpicture}
// \end{center}
// The same sequence of row elementary operations would reduce $A$ to $U$.
// ]

// ={Lecture 4 - Matrix equations and linear independence}

// =={Vector and matrix equations}

// Recall a vector is a matrix with one column, the zero vector is a vector with all entries zero. For scalar (i.e. a number) $c$, and vectors $\mathbf a=mat(
// a_1;a_2;dots.v;a_n
// )$, $bold(b)=mat(
// b_1;b_2;dots.v;b_n
// )$, we have
//
// - Addition $\mathbf a+bold(b)=mat(
// a_1;a_2;dots.v;a_n
// )+mat(
// b_1;b_2;dots.v;b_n
// )=mat(
// a_1+b_1;a_2+b_2;dots.v;a_n+b_n
// )$
// - Scalar multiplication $c \mathbf a=cmat(
// a_1;a_2;dots.v;a_n
// )=mat(
// ca_1;ca_2;dots.v;ca_n
// )$
// - Subtraction $\mathbf a-bold(b)=\mathbf a+(-1)bold(b)=mat(
// a_1;a_2;dots.v;a_n
// )-mat(
// b_1;b_2;dots.v;b_n
// )=mat(
// a_1-b_1;a_2-b_2;dots.v;a_n-b_n
// )$
//

// #remark[
// In handwritings, we use $\Vec{v}$ or $\overset{\rightharpoonup}{v}$ to denote a vector, while in printing materials we often use the math bold font $\mathbf v$.
// ]

// #definition[
// A #text(fill:blue)[vector equation]#index[vector equation] is of the form
// $ \label{09:29-06/03/2022}
// x_1\mathbf a_1+x_2\mathbf a_2+dots.h.c+x_n\mathbf a_n=bold(b)
// $
// We can also write the vector equation~\eqref{09:29-06/03/2022} as a #text(fill:blue)[matrix equation]#index[matrix equation] with partitioned matrix
//  $
// x_1\mathbf a_1+x_2\mathbf a_2+dots.h.c+x_n\mathbf a_n=mat(
// \mathbf a_1,\mathbf a_2,dots.h.c,\mathbf a_n
// )mat(
// x_1;x_2;dots.v;x_n
// )=A\mathbf x=bold(b)
//  $
// Here $A=mat(
// \mathbf a_1,\mathbf a_2,dots.h.c,\mathbf a_n
// )$ and $\mathbf x=mat(
// x_1;x_2;dots.v;x_n
// )$
// ]

// #example[
// @eq:chicken-rabbit can be written as a vector equation
//  $
// x_1\mathbf a_1+x_2\mathbf a_2=
// x_1mat(
// 1;2
// )+x_2mat(
// 1;4
// )=mat(
// x_1;2x_1
// )+mat(
// x_2;4x_2
// )=mat(
// x_1+x_2;2x_1+4x_2
// )=mat(
// 10;26
// )=bold(b)
//  $
// Or a matrix equation
//  $
// A\mathbf x=mat(
// 1,1;2,4
// )mat(
// x_1;x_2
// )=mat(
// 10;26
// )=bold(b)
//  $
// )

// #example[\label{16:17-06/03/2022}
// The corresponding vector equation of \systeme*{x_1+x_3=1, 2x_2+x_3=2} is
//  $
// x_1mat(
// 1;0
// )+x_2mat(
// 0;2
// )+x_3mat(
// 1;1
// )=mat(
// 1;2
// )
//  $
// And the corresponding matrix equation is
//  $
// mat(
// 1,0,1;
// 0,2,1
// )mat(
// x_1;x_2;x_3
// )=mat(
// 1;2
// )
//  $
// )

// % #question[
// % Suppose $A$ is a $m times  n$ matrix, when does the matrix equation $A\mathbf x=bold(b)$ always has a solution for any $bold(b)$ in $RR^n$
// % ]

// =={Span}

// #definition[
//
// - A #text(fill:blue)[linear combination]#index[linear combination] of $\mathbf a_1,\mathbf a_2,dots.h.c,\mathbf a_n$ is a sum $c_1\mathbf a_1+c_2\mathbf a_2+dots.h.c+c_n\mathbf a_n$ for some scalars $c_1,dots.h.c,c_n$.
// - The #text(fill:blue)[span]#index[span] of $\{\mathbf v_1,\mathbf v_2,dots.h.c,\mathbf v_n\}$ is the set of all its linear combinations, which we denote $\Span\{\mathbf v_1, \mathbf v_2,dots.h.c,\mathbf v_n\}$.
//
// ]

// #theorem[
// $x_1\mathbf a_1+x_2\mathbf a_2+dots.h.c+x_n\mathbf a_n=bold(b)$ has solution(s) $<=>bold(b)$ is a linear combination of $\mathbf a_1, \mathbf a_2,dots.h.c,\mathbf a_n$ $<=>$ $bold(b)\in\Span\{\mathbf a_1, \mathbf a_2,dots.h.c,\mathbf a_n\}$
// ]

// #exercise[
// Let $\mathbf a_1=mat(
// 1;2;1
// )$, $\mathbf a_2=mat(
// -1;0;1
// )$, $\mathbf a_3=mat(
// 1;-1;-2
// )$, $bold(b)=mat(
// 1;1;1
// )$. Is $bold(b)$ in $\Span\{\mathbf a_1, \mathbf a_2,\mathbf a_3\}$?
// ]

// #solution[
// This is equivalent of asking if whether the vector equation $x_1\mathbf a_1+x_2\mathbf a_2+x_3\mathbf a_3=bold(b)$ has solution(s), we find an REF of its augmented matrix
// \begin{align*}
// mat(
// 1,-1,1,1;
// 2,0,-1,1;
// 1,1,-2,1;
// )xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-#`R1` )mat(
// 1,-1,1,1;
// 0,2,-3,-1;
// 0,2,-3,0;
// )xarrow(#`R3`-> #`R3`-#`R2`)mat(
// 1,-1,1,1;
// 0,2,-3,-1;
// 0,0,0,1;
// )
// \end{align*}
// Since there is a pivot in the last column, by Theorem @(thm:sol-pivot), the linear system is inconsistent, hence $bold(b)\notin\Span\{\mathbf a_1, \mathbf a_2,\mathbf a_3\}$
// ]

// =={Linear independence}

// #definition[
// $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$ is #text(fill:blue)[linearly dependent]#index[linearly dependent] if some $\mathbf v_i$ is in the span of the others (so it is somewhat redundant), or equivalently, if there is a non-trivial solution $c_1,dots.h.c,c_n$ (i.e. not all $c_i$'s are 0) to the vector equation
// $ \label{16:30-06/06/2022}
// c_1\mathbf v_1+dots.h.c+c_n\mathbf v_n=\mathbf0
// $
// \eqref{16:30-06/06/2022} is referred to as a #text(fill:blue)[linear dependence]#index[linear dependence] between $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$. If \eqref{16:30-06/06/2022} has only the trivial solution (i.e. $c_1,dots.h.c, c_n$ are all 0, which is of course always a solution), $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$ is said to be #text(fill:blue)[linearly independent]#index[linearly independent]
// ]

// #remark[
// Equivalence between two different definitions of linear dependence
//
// - If $\mathbf v_i=c_1\mathbf v_1+dots.h.c+c_{i-1}\mathbf v_{i-1}+c_{i+1}\mathbf v_{i+1}+dots.h.c+c_n\mathbf v_n$, then $c_1\mathbf v_1+dots.h.c+(-1)\mathbf v_i+dots.h.c+c_n\mathbf v_n=\mathbf0$
// - If $c_1\mathbf v_1+dots.h.c+c_i\mathbf v_i+dots.h.c+c_n\mathbf v_n=\mathbf0$ and $c_i!=0$ (since not all $c_i$'s are zero, we may assume some $c_i$ is nonzero), then $\mathbf v_i=- c_1 / c_i \mathbf v_1-dots.h.c-\frac{c_{i-1}}{c_i}\mathbf v_{i-1}-\frac{c_{i+1}}{c_i}\mathbf v_{i+1}-dots.h.c- c_n / c_i \mathbf v_n$
//
// ]

// #question[
// How do we determine and find linear dependence of $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$?
// ]

// #answer[
// Let $A=mat(
// \mathbf v_1,dots.h.c,\mathbf v_n
// )$, then non-trivial solutions to $A\mathbf x=x_1\mathbf v_1+dots.h.c+x_n\mathbf v_n=\mathbf0$ would be the linear dependences of $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$. Therefore it is linearly independent if it has only the trivial(zero) solution.
// ]

// #theorem[
// $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$ is linearly independent $<=> A\mathbf x=\mathbf 0$ has only the trivial(zero) solution $<=>$ each column of the RREF of $A$ is a pivot column.
// ]

// \begin{proof}
// Consider the RREF of the augmented matrix $mat(
// A,\mathbf 0
// )$, it is necessarily $mat(
// U,\mathbf 0
// )$ for $A\mathbf x=\mathbf0$ to have only the trivial solution.
// \end{proof}

// #example[\label{06:35-06/06/2022}
// Suppose $\mathbf v_1=mat(
// 1;-1
// )$, $\mathbf v_2=mat(
// 1;1
// )$, $\mathbf e_1=mat(
// 1;0
// )$, $\{\mathbf v_1,\mathbf v_2,\mathbf e_1\}$ is linearly dependent since
//  $
// mat(
// \mathbf v_1,\mathbf v_2,\mathbf e_1
// )=mat(
// 1,1,1;
// -1,1,0;
// )tilde mat(
// 1,0, 1 / 2 ;
// 0,1, 1 / 2 ;
// )
//  $
// The solution to this augmented matrix would be $#cases(
// x_1=- 1 / 2 x_3;
// x_2=- 1 / 2 x_3;
// x_3\text{ is free}
// )$, by choosing any value nonzero value of $x_3$ (say 1) we get a linear dependence $- 1 / 2 \mathbf v_1- 1 / 2 \mathbf v_2+\mathbf e_1=\mathbf0$. On the other hand, $\mathbf v_1,\mathbf v_2$ are linearly independent since
//  $
// mat(
// \mathbf v_1,\mathbf v_2
// )=mat(
// 1,1;
// -1,1
// )tilde mat(
// 1,0;
// 0,1
// )
//  $
// Where each column is a pivot column.
// )

// #exercise[
// Write the system cases(8x_1-x_2=4, 5x_1+4x_2=1,x_1-3x_2=2} first as a vector equation and then as a matrix equation.
// ]

// #exercise[
// Let $\mathbf v_1=mat(
// 0;0;-2
// )$, $\mathbf v_2=mat(
// 0;-3;8
// )$, $\mathbf v_3=mat(
// 4;-1;-5
// )$.
//
// - Does $\{\mathbf v_1,\mathbf v_2,\mathbf v_3\}$ span $RR^3$? Why or why not?
// - Is $\{\mathbf v_1,\mathbf v_2,\mathbf v_3\}$ linearly independent? Why or why not?
//
// ]

// ={Lecture 5 - Geometric interpretation of solutions of linear systems}

// =={Geometric interpretation of vectors}

// We like to identify vectors in $M_{n times 1}(RR)$ with points in $RR^n$. And there are very nice geometric interpretation of vector additions and scalar multiplications.

// #example[[Vector-point correspondence in the case of $n=2$]
// Let $\mathbf a=mat(
// 1;2
// )$, $bold(b)=mat(
// 2;1
// )$, then $\mathbf a+bold(b)=mat(
// 3;3
// )$, $2\mathbf a=mat(
// 2;4
// )$, $-bold(b)=(-1)bold(b)=mat(
// -2;-1
// )$, $\mathbf a-bold(b)=\mathbf a+(-bold(b))=mat(
// -1;1
// )$.
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \draw[help lines, color=gray!30, dashed] (-4.5,-2.5) grid (4.5,4.5);
// \draw[->, color=gray!80] (-4.5,0)--(4.5,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-2.5)--(0,4.5) node[above]{$x_2$};
// \coordinate (a) at (1,2); \node at (a)[above left]{$\mathbf a$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (2,1); \node at (b)[right]{$bold(b)$}; \draw[->, thick] (0,0)--(b);
// \node at ($(0,0)-(b)$)[below right]{$-bold(b)$};
// \draw[->, thick] (0,0)--($(0,0)-(b)$);
// \node at ($2*(a)$)[above left]{$2\mathbf a$}; \draw[->, thick] (0,0)--($2*(a)$);
// \node at ($(a)+(b)$)[below right]{$\mathbf a+bold(b)$}; \draw[->, thick] (0,0)--($(a)+(b)$);
// \node at ($(a)-(b)$)[above left]{$\mathbf a-bold(b)$}; \draw[->, thick] (0,0)--($(a)-(b)$);
// \draw[dashed] ($(a)-(b)$)--($(a)+(b)$);
// \draw[dashed] ($(a)-(b)$)--($(0,0)-(b)$);
// \draw[dashed] (b)--($(a)+(b)$);
// \end{tikzpicture}
// \end{center}
// )

// =={Basis}

// #theorem[\label{16:05-06/06/2022}
// Let $A$ be an $m times  n$ matrix. Then the following statements are logically equivalent. That is, for a particular $A$, either they are all true statements or they are all false.
// \begin{enumerate}[label=\alph*.]
// - For each $bold(b)$ in $RR^m$, the equation $A\mathbf x =bold(b)$ has a solution.
// - Each $bold(b)$ in $RR^m$ is a linear combination of the columns of $A$.
// - The columns of $A$ span $RR^m$.
// - $A$ has a pivot position in every row. (Equivalently, in the last row)
// \end{enumerate}
// ]

// #definition[
// $\{\mathbf v_1,\mathbf v_2,dots.h.c,\mathbf v_n\}$ is said to be a basis for $RR^n$ if it is linearly independent and spans all of $RR^n$
// ]

// #theorem[
// Let $A=mat(
// \mathbf v_1,\mathbf v_2,dots.h.c,\mathbf v_n
// )$, then $\{\mathbf v_1,\mathbf v_2,dots.h.c,\mathbf v_n\}$ forms basis of $RR^n<=> Atilde  I_n$, in other words, each row and each column of $A$ has a pivot.
// ]

// #definition[\label{18:57-06/07/2022}
// The #text(fill:blue)[standard basis]#index[standard basis] for $RR^n$ is the set of vectors $\{\mathbf e_1,dots.h.c,\mathbf e_n\}$, where
// \begin{tikzpicture}
// \node at (0,0) {$\mathbf e_j=mat(
// 0;dots.v;1;dots.v;0
// )$};
// \draw[->] (1.1,0)--(0.8,0);
// \node at (1.1,0)[right] {$j$-th entry};
// \end{tikzpicture}
// ]

// #example[
// $\left\{\mathbf e_1=mat(
// 1;0;0
// ),\mathbf e_2=mat(
// 0;1;0
// ),\mathbf e_3=mat(
// 0;0;1
// )\right\}$ is the standard basis for $RR^3$, and
// \begin{align*}
// mat(
// x_1;x_2;x_3
// ),=mat(
// x_1;0;0
// )+mat(
// 0;x_2;0
// )+mat(
// 0;0;x_3
// )=x_1mat(
// 1;0;0
// )+x_2mat(
// 0;1;0
// )+x_3mat(
// 0;0;1
// )=x_1\mathbf e_1+x_2\mathbf e_2+x_3\mathbf e_3
// \end{align*}
// )

// =={Geometric meaning of spans}

// #example[
// Consider Example @(06:35-06/06/2022) where $\mathbf v_1=mat(
// 1;-1
// )$, $\mathbf v_2=mat(
// 1;1
// )$, $\mathbf e_1=mat(
// 1;0
// )$, $\mathbf e_2=mat(
// 0;1
// )$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \clip(-4.5,-4.5) rectangle (4.5,4.5);
// \draw[help lines, color=gray!30, dashed] (-4.5,-4.5) grid (4.5,4.5);
// \foreach \x in {-6,-4,-2,0,2,4,6} {\draw[help lines, color=purple!30, dashed] (-5+\x,-5)--++(10,10); \draw[help lines, color=purple!30, dashed] (-5+\x,5)--++(10,-10);}
// \draw[->, color=gray!80] (-4.5,0)--(4.5,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-4.5)--(0,4.5) node[above]{$x_2$};
// \coordinate (a) at (1,-1); \node at (a)[below left]{\textcolor{purple}{$\mathbf v_1$}}; \draw[->, purple, thick] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[below right]{\textcolor{purple}{$\mathbf v_2$}}; \draw[->, purple, thick] (0,0)--(b);
// \node at (1,0)[above]{$\mathbf e_1$}; \draw[->, thick] (0,0)--(1,0);
// \node at (0,1)[above]{$\mathbf e_2$}; \draw[->, thick] (0,0)--(0,1);
// \node at ($2*(a)+(b)$)[below]{\textcolor{orange}{$ 2\mathbf v_1+\mathbf v_2 \ =3\mathbf e_1-\mathbf e_2 $}}; \draw[->, orange, thick] (0,0)--($2*(a)+(b)$);
// \end{tikzpicture}
// \end{center}
// $\Span\{\mathbf v_1,\mathbf v_2, \mathbf e_1\}$ and $\Span\{\mathbf v_1,\mathbf v_2\}$ are both the plane $RR^2$, $\mathbf e_1$ is in the span of $\{\mathbf v_1,\mathbf v_2\}$ because $\mathbf e_1= 1 / 2 \mathbf v_1+ 1 / 2 \mathbf v_2$. The gray grids illustrate the span of $\{\mathbf e_1,\mathbf e_2\}$ and the purple grids illustrate the span of $\{\mathbf v_1,\mathbf v_2\}$.
// )

// #exercise[
// Suppose $\mathbf a_1=mat(
// 1;-3;0
// )$, $\mathbf a_2=mat(
// 2;-1;5
// )$, $\mathbf a_3=mat(
// 1;2;3
// )$
//
// - Determine whether $\{\mathbf a_1, \mathbf a_2, \mathbf a_3\}$ forms a basis for $RR^3$.
// - Without performing elementary row operations, how many solutions does $A\mathbf x=bold(b)$ have? Where $bold(b)=mat(
// 1;45;-9
// )$, what about $bold(b)=mat(
// 0;0;0
// )$.
//
// ]

// =={Parametric vector form}

// #example[
// In Example @ex:example3, the solution set can be written as #text(fill:blue)[parametric vector form]#index[parametric vector form]
// \begin{align*}
// mat(
// x_1;x_2;x_3
// )=mat(
//  1 / 2 x_3+ 1 / 2 ; 3 / 2 x_3- 1 / 2 ;x_3
// )=mat(
//  1 / 2 x_3; 3 / 2 x_3;x_3
// )+mat(
//  1 / 2 ;- 1 / 2 ;0
// )=x_3mat(
//  1 / 2 ; 3 / 2 ;1
// )+mat(
//  1 / 2 ;- 1 / 2 ;0
// )
// \end{align*}
// In Example @(exer:exercise1), the solution set can be written as
//  $
// mat(
// x_1;x_2;x_3;x_4
// )=mat(
// 2x_2+16;x_2; 5 / 2 ;- 9 / 2
// )=mat(
// 2x_2;x_2;0;0
// )+mat(
// 16;0; 5 / 2 ;- 9 / 2
// )=x_2mat(
// 2;1;0;0
// )+mat(
// 16;0; 5 / 2 ;- 9 / 2
// )
//  $
// )

// #exercise[
// Suppose the augmented matrix of a linear system is equivalent to the following matrix
//  $
// mat(
// 1,1,0,2,0,3;
// 0,0,1,-2,0,2;
// 0,0,0,0,1,1;
// )
//  $
// Write down the solution set in parametric vector form
// ]

// #solution[
//  $
// \systeme*{x_1+x_2+2x_4=3, x_3-2x_4=2,x_5=1} => #cases(
// x_1=3-x_2-2x_4; x_2\text{ is free};x_3=2+2x_4; x_4\text{ is free}; x_5=1
// )
//  $
// So the solution in parametric vector form would be
//  $
// mat(
// x_1;x_2;x_3;x_4;x_5
// )=mat(
// 3-x_2-2x_4;x_2;2+2x_4;x_4;1
// )=mat(
// 3;0;2;0;1
// )+mat(
// -x_2;x_2;0;0;0
// )+mat(
// -2x_4;0;2x_4;x_4;0
// )=mat(
// 3;0;2;0;1
// )+x_2mat(
// -1;1;0;0;0
// )+x_4mat(
// -2;0;2;1;0
// )
//  $
// ]

// =={Geometric interpretation of solution set to linear system}

// #definition[
// A linear system is #text(fill:blue)[homogeneous]#index[homogeneous] if it has matrix equation $A\mathbf x=\mathbf 0$ (note that this always have the zero solution, called the #text(fill:blue)[trivial solution]#index[trivial solution]).
// ]

// #theorem[
// Suppose $mat(
// A,bold(b)
// )tilde mat(
// U,bold(d)
// )$ is the RREF, then $U$ will be the RREF of $A$. The solutions of $A\mathbf x=\mathbf0$ and $A\mathbf x=bold(b)$ differs by $\widetilde{bold(d)}$ ($\widetilde{bold(d)}$ is $bold(d)$ with 0's inserted at the free variable positions), i.e.
//  $
// \widetilde{bold(d)}+\{\textsf{solutions of }A\mathbf x=\mathbf0\}=\{\textsf{solutions of }A\mathbf x=bold(b)\}
//  $
// Geometrically speaking, the solution set of $A\mathbf x=bold(b)$ is the hyperplane translated from the hyperplane through the origin (solution set of $A\mathbf x=\mathbf0$) by $bold(d)$.
// ]

// #example[
// $x_1-2x_2=2$ has augmented matrix $mat(
// 1,-2,2
// )$ which is already an RREF, which has solution
//  $
// #cases(
// x_1=2+2x_2;
// x_2\text{ is free}
// ) => mat(
// 2;0
// )+x_2mat(
// 2;1
// )
//  $
// Its corresponding homogeneous equation $x_1-2x_2=0$ has solution
//  $
// #cases(
// x_1=2x_2;
// x_2\text{ is free}
// ) =>  x_2mat(
// 2;1
// )
//  $
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \begin{scope}
// \clip(-4.5,-2.5) rectangle (4.5,2.5);
// \draw[help lines, color=gray!30, dashed] (-4.5,-2.5) grid (4.5,2.5);
// \draw[orange] (-6,-3)--(6,3);
// \draw[purple] (-6,-4)--(6,2);
// \filldraw[blue] (2,0) node[below]{$mat(
// 2;0
// )$} circle (1pt);
// \draw[->,blue] (0,0)--(2,1) node[above]{$mat(
// 2;1
// )$};
// \draw[->,blue] (2,0)--++(2,1);
// \node at (0,-1)[below right] {$x_1-2x_2=2$};
// \node at (0,0)[above left] {$x_1-2x_2=0$};
// \end{scope}
// \draw[->, color=gray!80] (-4.5,0)--(4.5,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-2.5)--(0,2.5) node[above]{$x_2$};
// \draw[dashed,blue] (0,0)--(2,0);
// \draw[dashed,blue] (2,1)--(4,1);
// \end{tikzpicture}
// \end{center}
// )

// #example[
// Consider homogeneous linear system $3x_1+x_2-x_3=0$, and non-homogeneous linear system $3x_1+x_2-x_3=3$ .The parametric vector form of the solution sets to both are
//  $
// mat(
// x_1;x_2;x_3
// )=x_2mat(
// - 1 / 3 ;1;0
// )+x_3mat(
//  1 / 3 ;0;1
// )
//  $
//  $
// mat(
// x_1;x_2;x_3
// )=x_2mat(
// - 1 / 3 ;1;0
// )+x_3mat(
//  1 / 3 ;0;1
// )+mat(
// 1;0;0
// )
//  $
// \begin{center}
// \begin{tikzpicture}
// \definecolor{color1}{rgb}{255,0,0}
// \definecolor{color2}{rgb}{0,0,255}
// \definecolor{color3}{rgb}{255,0,255}
// \def\XMAX{3.5}
// \def\YMAX{3.5}
// \def\ZMAX{3.5}
// \newcommand{\planeEq}[2]{#2/3-#1/3}
// \newcommand{\planeEqq}[2]{#2/3-#1/3+1}
// \begin{scope}[blend mode=multiply, rotate around x=-90, rotate around z=30]
// \draw [color1, fill=color1!20] plot (\planeEq{-\YMAX}{-\ZMAX},-\YMAX,-\ZMAX,)node[below left]{$3x_1+x_2-x_3=0$}--(\planeEq{-\YMAX}{\ZMAX},-\YMAX,\ZMAX)--(\planeEq{\YMAX}{\ZMAX},\YMAX,\ZMAX)--(\planeEq{\YMAX}{-\ZMAX},\YMAX,-\ZMAX)--cycle;
// \draw [color2, fill=color2!20] plot (\planeEqq{-\YMAX}{-\ZMAX},-\YMAX,-\ZMAX,)node[below right]{$3x_1+x_2-x_3=3$}--(\planeEqq{-\YMAX}{\ZMAX},-\YMAX,\ZMAX)--(\planeEqq{\YMAX}{\ZMAX},\YMAX,\ZMAX)--(\planeEqq{\YMAX}{-\ZMAX},\YMAX,-\ZMAX)--cycle;
// \draw[->] (-\XMAX,0,0)--(\XMAX,0,0) node[right]{$x_1$};
// \draw[->] (0,-\YMAX,0)--(0,\YMAX,0) node[above]{$x_2$};
// \draw[->] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_3$};
// \coordinate (d) at (1,0,0);
// \coordinate (o) at (0,0,0);
// \coordinate (v1) at (-1/3,1,0);
// \coordinate (v2) at (1/3,0,1);
// \draw[->, ultra thick, color1] (o)--(v1)node[above left]{$\mathbf v_1$};
// \draw[->, ultra thick, color1] (o)--(v2)node[above]{$\mathbf v_2$};
// \draw[->, ultra thick, color2] ($(o)+(d)$)--($(d)+(v1)$)node[above right]{$\mathbf v_1$};
// \draw[->, ultra thick, color2] ($(o)+(d)$)--($(d)+(v2)$)node[above]{$\mathbf v_2$};
// \draw[->, dotted, ultra thick] (o)--(d)node[below]{$\widetilde{bold(d)}$};
// \end{scope}
// \end{tikzpicture}
// \end{center}
// )

// ={Lecture 6 - Linear transformations}

// =={Linear transformations and matrix transformations}

// #definition[
// A #text(fill:blue)[Linear transformation] (or #text(fill:blue)[linear mapping])#index[linear transformation] $T$ from $RR^n$ to $RR^m$ is a mapping satisfying
//
// - $T(\mathbf u+\mathbf v)=T(\mathbf u)+T(\mathbf v)$ for any $\mathbf u,\mathbf v$ in $RR^n$
// - $T(c\mathbf u)=cT(\mathbf u)$ for any scalar $c$ and any $\mathbf u$ in $RR^n$
//
// ]

// #example[
// Reflection, rotation and scaling are all linear transformations from $RR^2$ to $RR^2$.
// )

// #exercise[\label{ex: matrix transformation}
// Suppose $T:RR^2->RR^2$ is defined by $T\left(mat(
// x;y
// )\right)=mat(
// x+y;
// y
// )$. Is $T$ is a linear mapping?
// ]

// #solution[
// Suppose $\mathbf u=mat(
// u_1;u_2
// )$, $\mathbf v=mat(
// v_1;v_2
// )$, then
//
// \item
// \begin{align*}
// T(\mathbf u+\mathbf v),=T\left(mat(
// u_1+v_1;u_2+v_2
// )\right)=mat(
// (u_1+v_1)+(u_2+v_2);u_2+v_2
// );
// ,=mat(
// (u_1+u_2)+(v_1+v_2);u_2+v_2
// )=mat(
// u_1+u_2;u_2
// )+mat(
// v_1+v_2;v_2
// )=T(\mathbf u)+T(\mathbf v)
// \end{align*}
// \item
//  $
// T(c\mathbf u)=T\left(mat(
// cu_1;cu_2
// )\right)=mat(
// cu_1+cu_2;cu_2
// )=cmat(
// u_1+u_2;u_2
// )=cT(\mathbf u)
//  $
//
// ]

// #definition[
// A #text(fill:blue)[matrix transformation]#index[matrix transformation] is the mapping defined via matrix multiplication, i.e. $T(\mathbf x)=A\mathbf x$ for some $m times  n$ matrix $A$. It is a linear transformation thanks to Fact @(fact:mat-alg) c),d) since
//
// - $T(\mathbf u+\mathbf v)=A(\mathbf u+\mathbf v)=A\mathbf u+A\mathbf v=T(\mathbf u)+T(\mathbf v)$
// - $T(c\mathbf u)=A(c\mathbf u)=c(A\mathbf u)=cT(\mathbf u)$
//
// ]

// #example[
// In fact, $T$ in Exercise @(ex: matrix transformation) is a matrix transformation
//  $
// T\left(mat(
// x_1;x_2
// )\right)=mat(
// x_1+x_2;
// x_2
// )=mat(
// 1,1;0,1
// )mat(
// x_1;x_2
// )=A\mathbf x
//  $
// )

// #definition[
// In general, if $T:RR^n->RR^m$ is a linear transformation, and $\{\mathbf e_1,\mathbf e_2,dots.h.c,\mathbf e_n\}$ is the standard basis, then any $\mathbf x=x_1\mathbf e_1+dots.h.c+x_n\mathbf e_n$, and
// $ \label{12:47-06/08/2022}
// T(\mathbf x)=x_1T(\mathbf e_1)+dots.h.c+x_nT(\mathbf e_n)=mat(
// T(\mathbf e_1),dots.h.c ,T(\mathbf e_n)
// )mat(
// x_1;dots.v;x_n
// )
// $
// Denote $A=mat(
// T(\mathbf e_1),dots.h.c ,T(\mathbf e_n)
// )$ (which is called the #text(fill:blue)[standard matrix for the linear transformation $T$])#index[standard matrix], then $T(\mathbf x)=A\mathbf x$, so every linear transformation $T$ from $RR^n->RR^m$ is a matrix transformation.
// ]

// #example[
// In Exercise @(ex: matrix transformation)
//  $
// T(\mathbf e_1)=T\left(mat(
// 1;0
// )\right)=mat(
// 1+0;0
// )=mat(
// 1;0
// ),\quad T(\mathbf e_2)=T\left(mat(
// 0;1
// )\right)=mat(
// 0+1;1
// )=mat(
// 1;1
// )
//  $
// Therefore the standard matrix for $T$ is $mat(
// 1,1;0,1
// )$.
// )

// #exercise[
// Suppose $T:RR^2->RR^2$ is defined by $T\left(mat(
// x_1;x_2
// )\right)=mat(
// x_1+x_2+1;
// x_2
// )$. Is $T$ is a linear mapping?
// ]

// #solution[
// $T$ is not a linear transformation since
// $T(\mathbf x)=mat(
// 1,1;0,1
// )mat(
// x_1;x_2
// )+mat(
// 1;0
// )=A\mathbf x+\mathbf p$ is not a matrix transformation~\eqref{12:47-06/08/2022} ($\mathbf p!=0$)
// ]

// #example[\label{10:10-06/09/2022}
// Suppose $T:RR^2->RR^2$ is a linear transformation
// \begin{enumerate}[label=\alph*)]
// - Suppose $T$ is the reflection over $x_2$-axis, then the standard matrix for $T$ is
//  $
// A=mat(
// T(\mathbf e_1),T(\mathbf e_2)
// )=mat(
// -1,0;
// 0,1
// )
//  $
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf e_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$\mathbf e_2=T(\mathbf e_2)$}; \draw[->, thick] (0,0)--(b);
// \draw[->, purple, thick] (0,0)--($(0,0)-(a)$) node[below left]{$T(\mathbf e_1)$};
// \end{tikzpicture}
// \end{center}
// - Suppose $T$ is the rotation by $60^\circ$ counter-clockwise, then the standard matrix for $T$ is
//  $
// A=mat(
// T(\mathbf e_1),T(\mathbf e_2)
// )=mat(
//  1 / 2 ,-\frac{\sqrt{3}}{2};
// \frac{\sqrt{3}}{2}, 1 / 2
// )
//  $
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \def\XMAX{1.5};\def\YMAX{1.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \draw[opacity=0.6, red, dashed] (0,0) circle (1);
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf e_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$\mathbf e_2$}; \draw[->, thick] (0,0)--(b);
// \coordinate (c) at ($cos(60)*(1,0)+sin(60)*(0,1)$); \node at (c)[above right]{\textcolor{purple}{$T(\mathbf e_1)=mat(
// \cos60^\circ;\sin60^\circ
// )$}}; \draw[->, purple, thick] (0,0)--(c);
// \coordinate (d) at ($cos(150)*(1,0)+sin(150)*(0,1)$); \node at (d)[above left]{#text(fill:blue){$mat(
// \cos150^\circ;\sin150^\circ
// )=T(\mathbf e_2)$}}; \draw[->, blue, thick] (0,0)--(d);
// \draw[opacity=0.6, purple, dashed] (c)--($cos(60)*(1,0)$);
// \draw[opacity=0.6, purple, dashed] (c)--($sin(60)*(0,1)$);
// \draw[opacity=0.6, blue, dashed] (d)--($cos(150)*(1,0)$);
// \draw[opacity=0.6, blue, dashed] (d)--($sin(150)*(0,1)$);
// \end{tikzpicture}
// \end{center}
// \end{enumerate}
// )

// #exercise[\label{10:08-06/09/2022}
// $T:RR^2->RR^2$ is the linear transformation that rotate $60^\circ$ counter-clockwise and then reflects over $x_2$-axis, what is its standard matrix?
// ]

// #solution[
// The standard matrix for $T$ is
//  $
// A=mat(
// T(\mathbf e_1),T(\mathbf e_2)
// )=mat(
// - 1 / 2 ,\frac{\sqrt{3}}{2};
// \frac{\sqrt{3}}{2}, 1 / 2
// )
//  $
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \def\XMAX{1.5};\def\YMAX{1.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \draw[opacity=0.6, red, dashed] (0,0) circle (1);
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf e_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$\mathbf e_2$}; \draw[->, thick] (0,0)--(b);
// \coordinate (c) at ($sin(60)*(0,1)-cos(60)*(1,0)$); \node at (c)[above left]{\textcolor{purple}{$T(\mathbf e_1)=mat(
// -\cos60^\circ;\sin60^\circ
// )=mat(
// \cos120^\circ;\sin120^\circ
// )$}}; \draw[->, purple, thick] (0,0)--(c);
// \coordinate (d) at ($sin(150)*(0,1)-cos(150)*(1,0)$); \node at (d)[above right]{#text(fill:blue){$T(\mathbf e_2)=mat(
// -\cos150^\circ;\sin150^\circ
// )=mat(
// \cos30^\circ;\sin30^\circ
// )$}}; \draw[->, blue, thick] (0,0)--(d);
// \draw[opacity=0.6, purple, dashed] (c)--($(0,0)-cos(60)*(1,0)$);
// \draw[opacity=0.6, purple, dashed] (c)--($sin(60)*(0,1)$);
// \draw[opacity=0.6, blue, dashed] (d)--($(0,0)-cos(150)*(1,0)$);
// \draw[opacity=0.6, blue, dashed] (d)--($sin(150)*(0,1)$);
// \end{tikzpicture}
// \end{center}
// ]

// =={Properties of linear transformations}

// #definition[
// Suppose $T:RR^n->RR^m$ is a mapping. We call
//
// - $RR^n$ the #text(fill:blue)[domain]#index[domain] of $T$
// - $RR^m$ the #text(fill:blue)[codomain]#index[codomain] of $T$
// - $T(\mathbf x)$ the #text(fill:blue)[image]#index[image] of $\mathbf x$ under $T$
// - $T^{-1}(bold(b))=\{\mathbf x|T(\mathbf x)=bold(b)\}$ the set of #text(fill:blue)[preimages]#index[preimage] of $bold(b)$ under $T$
// - the set of images $\{T\mathbf x|\mathbf x\inRR^n\}$ the #text(fill:blue)[range]#index[range] of $T$
//
// ]

// #exercise[
// Suppose the linear transformation $T:RR^3->RR^3$ is defined by $T\left(mat(
// x_1;x_2;x_3
// )\right)=mat(
// x_1-x_2+x_3; 2x_1-x_3; x_1+x_2+x_3
// )$, what is the standard matrix of $T$? What is the image of $mat(
// 2;0;1
// )$, what is the set of vectors with image $mat(
// 1;1;3
// )$, what is the range?
// ]

// #solution[
// The standard matrix is $A=mat(
// 1,-1,1;
// 2,0,-1;
// 1,1,1
// )$, the image $mat(
// 2;0;1
// )$ under $T$ is
//  $
// T\left(mat(
// 2;0;1
// )\right)=mat(
// 1,-1,1;
// 2,0,-1;
// 1,1,1
// )mat(
// 2;0;1
// )=mat(
// 3;3;3
// )
//  $
// The set of vectors with image $bold(b)=mat(
// 1;1;3
// )$ under $T$ is the solution set to $T(\mathbf x)=A\mathbf x=bold(b)$ (this is Example  @ex:example1), which is $\left\{mat(
// 1;1;1
// )\right\}$. And since there is a pivot in each row, by Theorem @(16:05-06/06/2022), the range of $T$ is $RR^3$
// ]

// #definition[
// A mapping $T$ is said to be #text(fill:blue)[onto] $RR^m$ if each $b\in RR^m$ is the image of at least one $x\inRR^n$.
// ]

// Codomain is larger than the range if $T$ is not onto

// #definition[
// A mapping $T$ is said to be #text(fill:blue)[one-to-one] if each $b\in RR^m$ is the image of at most one $x\inRR^n$.
// ]

// #theorem[\label{15:25-06/08/2022}
// Suppose $A$ is the standard matrix for linear transformation $T$ (i.e. $T(\mathbf x)=A\mathbf x$), then
//
// - $T$ is one-to-one $<=> A\mathbf x=bold(b)$ has at most one solution $<=> A\mathbf x=\mathbf 0$ has the unique trivial solution $<=>$ RREF of $A$ has a pivot in each column $<=>$ columns of $A$ are linearly independent.
// - $T$ is onto $<=> A\mathbf x=bold(b)$ always has solution $<=>$ the columns of $A$ span $RR^m$ $<=>$ RREF of $A$ has a pivot in each row.
//
// ]

// #exercise[
// Suppose the linear transformation $T:RR^3->RR^2$ is defined by $T\left(mat(
// x_1;x_2;x_3
// )\right)=mat(
// x_1-x_2+x_3; 2x_1-x_3
// )$, Is $T$ onto? Is $T$ one-to-one?
// ]

// #solution[
// This is the Example @ex:example3. The standard matrix for $T$ is $A=mat(
// 1,-1,1;
// 2,0,-1
// )xarrow(#`R2`-> #`R2`-2#`R1`)mat(
// 1,-1,1;
// 0,2,-3
// )$, since there is a pivot in each row but not in each column, it is onto but not one-to-one
// ]

// #exercise[\label{13:16-06/10/2022}
//
// - If $T:RR^3->RR^2$ is a linear transformation, could it be one-to-one?
// - If $T:RR^2->RR^3$ is a linear transformation, could it be onto?
//
// ]

// #solution[
// Both no! Due to Theorem @(15:25-06/08/2022)
//
// - Since $A$ is a $2 times 3$ matrix, there will be at most 2 pivots (only 2 rows), so there won't be enough pivots to fill all columns.
// - Since $A$ is a $3 times 2$ matrix, there will be at most 2 pivots (only 2 columns), so there won't be enough pivots to fill all rows.
//
// ]

// #exercise[
// Suppose $T\left(mat(
// x_1;x_2;x_3
// )\right)=mat(
// x_1-x_2+x_3;2x_1-x_3;x_1+x_2-2x_3
// )$.
//
// - What is the domain of $T$?
// - What is the codomain of $T$?
// - What is the standard matrix of $T$?
// - What is the image of $mat(
// 1;1;0
// )$?
// - What is the set of vectors with image being $mat(
// 1;1;1
// )$?
// - What is the set of vectors with image being $mat(
// 1;1;0
// )$?
// - Is $T$ onto?
// - Is $T$ one-to-one?
//
// ]

// =={Composition of linear transformations}

// #definition[
// Suppose
//
// - $T_1:RR^p->RR^n$ is a linear transformation with standard matrix $A_1$ (which should be $n times  p$)
// - $T_2:RR^n->RR^m$ is a linear transformation with standard matrix $A_2$ (which should be $m times  n$)
//
// Define the #text(fill:blue)[composition]#index[composition] $T_2\circ T_1$ of $T_1$ and $T_2$ as $(T_2\circ T_1)(\mathbf x)=T_2(T_1(\mathbf x))$
// \begin{center}
// \begin{tikzcd}
// RR^p \arrow[r, "T_1"] \arrow[rr, "T_2\circ T_1"', bend right] , RR^n \arrow[r, "T_2"] , RR^m
// \end{tikzcd}
// \end{center}
// Then $T_2\circ T_1:RR^p->RR^m$ is also a linear transformation (Why? Verify this). For $\mathbf x\inRR^p$,
//  $
// (T_2\circ T_1)(\mathbf x)=T_2(T_1(\mathbf x))=A_2(T_1(\mathbf x))=A_2(A_1\mathbf x)=(A_2A_1)\mathbf x
//  $
// So we have concluded that the standard matrix for $T_2\circ T_1$ is the $m times  p$ matrix $A_2A_1$.
// ]

// \begin{note}
// You should compose maps to the left.
// \end{note}

// #example[
// Consider Example @(10:10-06/09/2022)., If we let $T_1:RR^2->RR^2$ to denote the rotation by $60^\circ$ counter-clockwise, $T_2:RR^2->RR^2$ to denote reflection over $x_2$-axis, and their standard matrices are
//  $
// mat(
//  1 / 2 ,-\frac{\sqrt{3}}{2};\frac{\sqrt{3}}{2}, 1 / 2
// ),\qquadmat(
// -1,0;0,1
// )
//  $
// Then look at Exercise @(10:08-06/09/2022), this is the composition $T_2\circ T_1$, which has the standard matrix
//  $
// A_2A_1=mat(
// -1,0;0,1
// )mat(
//  1 / 2 ,-\frac{\sqrt{3}}{2};\frac{\sqrt{3}}{2}, 1 / 2
// )=mat(
// - 1 / 2 ,\frac{\sqrt{3}}{2};
// \frac{\sqrt{3}}{2}, 1 / 2
// )
//  $
// )

// #question[
// Suppose $A=mat(
//  1 / 2 ,-\frac{\sqrt{3}}{2};\frac{\sqrt{3}}{2}, 1 / 2
// )$ is the standard matrix for the linear transformation of rotating $60^\circ$ counter-clockwise (Example @(10:10-06/09/2022)). What is $A^7$?
// ]

// #answer[
// $A^7=AAAAAAA$ is the standard matrix for composition of linear transformations $T\circ T\circ T\circ T\circ T\circ T\circ T$ which is rotate $7 times 60^\circ=420^\circ$, but that is the same as rotating $420^\circ-360^\circ=60^\circ$ which is the same linear transformation as $T$, so $A^7=A$
// \begin{center}
// \begin{tikzcd}
// A^7=AAAAAAA \arrow[rr,equal]                                                                                                       ,  , A                                      ;
// T^{\circ7}=T\circ T\circ T\circ T\circ T\circ T\circ T \arrow[rr,equal, "\text{same effect}"'] \arrow[u, rightsquigarrow, "\text{Standard matrix}"] ,  , T \arrow[u, rightsquigarrow, "\text{Standard matrix}"']
// \end{tikzcd}
// \end{center}
// ]

// #exercise[
// Let $T$ be the linear transformation that rotate $RR^2$ counter-clockwise of angle $\theta$, find the standard matrix for $T$. What about the standard matrix for $T^{\circ100}$
// ]

// ={Lecture 7 - Matrix transpose and matrix inverse}

// =={Matrix transpose}

// #definition[
// Suppose $A=mat(
// a_(11),a_(12),dots.h.c,a_(1 n);
// a_(21),a_(22),dots.h.c,a_(2 n);
// dots.v,dots.v,,dots.v;
// a_(m 1),a_(m 2),dots.h.c,a_(m n)
// )$ is a $m times  n$ matrix, we define its #text(fill:blue)[transpose]#index[transpose] by flipping it over the diagonal, and this is the $n times  m$ matrix
//  $
// A^T=mat(
// a_(11),a_(21),dots.h.c,a_(m 1);
// a_(12),a_(22),dots.h.c,a_(m n);
// dots.v,dots.v,,dots.v;
// a_(1 n),a_(2 n),dots.h.c,a_(m n)
// )
//  $
// ]

// #example[
// Suppose $A=mat(
// 1,2,3;4,5,6
// )$, then $A^T=mat(
// 1,4;2,5;3,6
// )$
// )

// #theorem[
// Here are some properties of matrix transpose
//
// - $(A^T)^T=A$
// - $(A+B)^T=A^T+B^T$
// - $(cA)^T=cA^T$
// - $(AB)^T=B^TA^T$
//
// ]

// #definition[
// For any $\mathbf v=mat(
// v_1;v_2;dots.v;v_n
// ),\mathbf w=mat(
// w_1;w_2;dots.v;w_n
// )\inRR^n$, we can define the #text(fill:blue)[dot product]#index[dot product] to be $\mathbf v dot.c \mathbf w=\mathbf v^T\mathbf w=v_1w_1+dots.h.c+v_nw_n$. $\|\mathbf v\|=\sqrt{\mathbf v^T\mathbf v}=\sqrt{v_1^2+dots.h.c+v_n^2}$ is the length $\mathbf v$
// ]

// #remark[
// There is a nice geometric interpretation of dot product. Suppose the angle between $\mathbf v$ and $\mathbf w$ is $\theta$, then $\mathbf v dot.c \mathbf w=\|\mathbf v\|\|\mathbf w\|\cos\theta$.
// % With a bit of trigonometry, we see it is the product of one vector and the projection of the other onto the first one.
// \begin{center}
// \begin{tikzpicture}[scale=3]
// \coordinate (a) at ($cos(30)*(1,0)+sin(30)*(0,1)$);
// \coordinate (b) at ($(1.2,0)$);
// \draw[->, thick] (0,0)--(a);
// \draw[->, thick] (0,0)--(b);
// % \draw[dotted] (a)--(a|-0,0);
// % \draw[->] (0,0)--(a|-0,0);
// \draw (0.2,0) arc (0:30:0.2);
// \node at (a)[right] {$\mathbf v$};
// \node at (b)[right] {$\mathbf w$};
// \node at (0.2,0)[above right] {$\theta$};
// % \node at (a|-0,0)[below] {$\mathbf u$};
// \end{tikzpicture}
// \end{center}
// % Here $\mathbf u$ is the projection of $\mathbf v$ onto $\mathbf w$
// ]

// #exercise[
// Let $\mathbf v=mat(
// 1;-2;1
// )$, $\mathbf w=mat(
// 1;0;-1
// )$.
//
// - What is the length of $\mathbf v$?
// - What is $\mathbf v dot.c \mathbf w$?
// - what is the angle between $\mathbf v$ and $\mathbf w$?
//
// ]

// #question[
// Have you wondered about how linear algebra would look like if we make the identification of row vectors $M_{1 times  n}(RR^n)$ and $RR^n$ instead of column vectors.
// ]

// #answer[
// The standard basis for $RR^n$ would be $\{\mathbf e_1^T,\mathbf e_2^T,dots.h.c,\mathbf e_n^T\}$, where $\mathbf e_j^T=mat(
// 0,dots.h.c,1,dots.h.c,0
// )$, where every entry is 0 except the $j$-th entry being 1. For any $\mathbf x^T\inRR^n$ and any linear transformation $T:RR^n->\mathbf R^m$, we have
// \begin{align*}
// T(\mathbf x^T),=T(\mathbf x)^T=\left(x_1T(\mathbf e_1)+x_2T(\mathbf e_2)+dots.h.c+x_nT(\mathbf e_n)\right)^T;
// ,=x_1T(\mathbf e_1)^T+x_2T(\mathbf e_2)^T+dots.h.c+x_nT(\mathbf e_n)^T;
// ,=mat(
// x_1,x_2,dots.h.c,x_n
// )mat(
// T(\mathbf e_1)^T;T(\mathbf e_2)^T;dots.v;T(\mathbf e_n)^T
// )=\mathbf x^TA^T
// \end{align*}
// Here $A=mat(
// T(\mathbf e_1),T(\mathbf e_2),dots.h.c,T(\mathbf e_n)
// )$.

// If you consider composition $T_2\circ T_1$ where $T_1, T_2$ are linear transformations with standard matrices $A,B$, you would get
//  $
// (T_2\circ T_1)(\mathbf x^T)=T_2(T_1(\mathbf x^T))=T_1(\mathbf x^T)B^T=(\mathbf x^TA^T)B^T=\mathbf x^T(A^TB^T)
//  $
// On the other hand, we should know that $(T_2\circ T_1)(\mathbf x^T)=\mathbf x^T(A^TB^T)$, so this implies $A^TB^T=(BA)^T$.
// ]

// =={Matrix inverse}

// #definition[
// Suppose linear transformation $T:RR^n->RR^m$ is both onto and one-to-one (i.e. for each vector $bold(b)$ in the codomain $RR^m$ there is a unique preimage, which we denote as $T^{-1}(bold(b))$). Suppose $A$ is the standard matrix for $T$, then $m$ necessarily equal $n$ as shown in Exercise @(13:16-06/10/2022), so $A$ must be a square matrix. We know $T(\mathbf x)=bold(b)$ always has a unique solution which should be $T^{-1}(bold(b))$, it can be shown that $T^{-1}:RR^n->RR^n$ as mapping is actually also a linear transformation (Why? See if you can figure this out). Then the standard matrix of $T^{-1}$ is defined to be $A^{-1}$ (the #text(fill:blue)[inverse matrix]#index[inverse matrix] of $A$). Note that
// \begin{align*}
// ,(T\circ T^{-1})(bold(b))=T(T^{-1}(bold(b)))=T(\mathbf x)=bold(b);
// ,(T^{-1}\circ T)(\mathbf x)=T^{-1}(T(\mathbf x))=T^{-1}(bold(b))=\mathbf x
// \end{align*}
// Since $T\circ T^{-1}$, $T^{-1}\circ T$ work like the identity mappings, so $AA^{-1}=A^{-1}A=I$. In this case, we see that $A$ is equivalent to the identity matrix (because of Theorem @(06:35-06/06/2022), $A$ has a pivot in each row and column).
// ]

// #remark[
// Because we can write elementary row operations as left elementary matrix multiplications, so we know there are elementary matrices $E_1,E_2,dots.h.c,E_k$ such that
// \begin{align*}
// A,tilde  E_1Atilde  E_2E_1Atilde  E_3E_2E_1Atilde dots.h.c;
// ,tilde  E_kE_{k-1}dots.h.c E_2E_1A=I
// \end{align*}
// If we multiply $A^{-1}$ on the right on both sides, we get $E_kE_{k-1}dots.h.c E_2E_1=A^{-1}$. Thanks to this observation, we introduce an algorithm for computing matrix inverses. Let's consider the RREF of the following partitioned matrix
// \begin{align*}
// \left[\begin{array}{c|c}
// A,I
// \end{array}\right],tilde \left[\begin{array}{c|c}
// E_1A,E_1
// \end{array}\right]tilde \left[\begin{array}{c|c}
// E_2E_1A,E_2E_1
// \end{array}\right]tilde dots.h.c;
// ,tilde \left[\begin{array}{c|c}
// E_kE_{k-1}dots.h.c E_2E_1A,E_kE_{k-1}dots.h.c E_2E_1
// \end{array}\right]=\left[\begin{array}{c|c}
// I,A^{-1}
// \end{array}\right]
// \end{align*}
// ]

// #exercise[\label{19:39-06/13/2022}
// Find the inverse of the following matrices.
// \begin{tasks}(3)
// \task $A=mat(
// -1,0;0,1
// )$
// \task $A=mat(
// 1,2;3,5
// )$
// \task $mat(
// 1,-1,1;
// 2,0,-1;
// 1,1,1;
// )$
// \end{tasks}
// ]

// #solution[
// \begin{enumerate}[label=\alph*)]
// \item
// \begin{align*}
// ,\left[\begin{array}{cc|cc}
// -1,0,1,0;
// 0,1,0,1
// \end{array}\right]xarrow(#`R1`->(-1)#`R1`)\left[\begin{array}{cc|cc}
// 1,0,-1,0;
// 0,1,0,1
// \end{array}\right]
// \end{align*}
// Hence $A^{-1}=mat(
// -1,0;0,1
// )$
// - \begin{align*}
// ,\left[\begin{array}{cc|cc}
// 1,2,1,0;
// 3,5,0,1
// \end{array}\right]xarrow(#`R2`-> #`R2`-3#`R1`)\left[\begin{array}{cc|cc}
// 1,2,1,0;
// 0,-1,-3,1
// \end{array}\right];
// ,xarrow(#`R1`-> #`R1`+2#`R2`)\left[\begin{array}{cc|cc}
// 1,0,-5,2;
// 0,-1,-3,1
// \end{array}\right]xarrow(#`R2`->(-1)#`R2`)\left[\begin{array}{cc|cc}
// 1,0,-5,2;
// 0,1,3,-1
// \end{array}\right]
// \end{align*}
// Hence $A^{-1}=mat(
// -5,2;3,-1
// )$
// - \begin{align*}
// ,\left[\begin{array}{ccc|ccc}
// 1,-1,1,1,0,0;
// 2,0,-1,0,1,0;
// 1,1,1,0,0,1;
// \end{array}\right]xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-#`R1` )\left[\begin{array}{ccc|ccc}
// 1,-1,1,1,0,0;
// 0,2,-3,-2,1,0;
// 0,2,0,-1,0,1;
// \end{array}\right];
// ,xarrow(#`R3`-> #`R3`-#`R2`)\left[\begin{array}{ccc|ccc}
// 1,-1,1,1,0,0;
// 0,2,-3,-2,1,0;
// 0,0,3,1,-1,1;
// \end{array}\right]xarrow(#`R2`-> #`R2`+#`R3`)\left[\begin{array}{ccc|ccc}
// 1,-1,1,1,0,0;
// 0,2,0,-1,0,1;
// 0,0,3,1,-1,1;
// \end{array}\right];
// ,xarrow( #`R2`-> #`R2`/2 \ #`R3`-> #`R3`/3 )\left[\begin{array}{ccc|ccc}
// 1,-1,1,1,0,0;
// 0,1,0,- 1 / 2 ,0, 1 / 2 ;
// 0,0,1, 1 / 3 ,- 1 / 3 , 1 / 3 ;
// \end{array}\right]xarrow(#`R1`-> #`R1`+#`R2`-#`R3`)\left[\begin{array}{ccc|ccc}
// 1,0,0, 1 / 6 , 1 / 3 , 1 / 6 ;
// 0,1,0,- 1 / 2 ,0, 1 / 2 ;
// 0,0,1, 1 / 3 ,- 1 / 3 , 1 / 3 ;
// \end{array}\right]
// \end{align*}
// Hence $A^{-1}=mat(
//  1 / 6 , 1 / 3 , 1 / 6 ;
// - 1 / 2 ,0, 1 / 2 ;
//  1 / 3 ,- 1 / 3 , 1 / 3 ;
// )$
// \end{enumerate}
// ]

// =={Properties of matrix transposes and inverses}

// #definition[
// A square matrix $A$ is #text(fill:blue)[invertible] (or #text(fill:blue)[non-singular])#index[invertible] if it has an inverse $A^{-1}$ such that $AA^{-1}=A^{-1}A=I$. $A$ is called #text(fill:blue)[singular]#index[singular] if $A$ is not invertible.
// ]

// #theorem[
// Suppose $T$ is a linear transformation with standard matrix $A$, then
//  $
// T\text{ is invertible with inverse }T^{-1}<=> A\text{ is invertible with inverse }A^{-1}<=> Atilde  I
//  $
// ]

// #theorem[
// $A=mat(
// a,b;c,d
// )$, $A^{-1}=\dfrac{1}{ad-bc}mat(
// d,-b;-c,a
// )$, here $\det A=ad-bc$
// ]

// #example[
// If $A=mat(
//  1 / 2 ,\frac{\sqrt{3}}{2};-\frac{\sqrt{3}}{2}, 1 / 2
// )$, then
//  $
// A^{-1}=\dfrac{1}{ 1 / 2  1 / 2 -\frac{\sqrt{3}}{2}\left(-\frac{\sqrt{3}}{2}\right)}mat(
//  1 / 2 ,-\frac{\sqrt{3}}{2};\frac{\sqrt{3}}{2}, 1 / 2
// )=mat(
//  1 / 2 ,-\frac{\sqrt{3}}{2};\frac{\sqrt{3}}{2}, 1 / 2
// )
//  $
// )

// #theorem[
// If $A$ is invertible, then the linear system $A\mathbf x=bold(b)$ has a unique solution $\mathbf x=A^{-1}bold(b)$
// ]

// \begin{proof}
// Multiply $A^{-1}$ on the left on both sides
// \end{proof}

// #example[
// Let's consider~@eq:chicken-rabbit, in which case $A=mat(
// 1,1;2,4
// )$, $bold(b)=mat(
// 10;26
// )$, then $A^{-1}=\dfrac{1}{1 dot.c 4-1 dot.c 2}mat(
// 4,-1;-2,1
// )=mat(
// 2,- 1 / 2 ;-1, 1 / 2
// )$, and
//  $
// \mathbf x=A^{-1}bold(b)=mat(
// 2,- 1 / 2 ;-1, 1 / 2
// )mat(
// 10;26
// )=mat(
// 2 dot.c 10- 1 / 2  dot.c 26;-10+ 1 / 2  dot.c 26
// )=mat(
// 7;3
// )
//  $
// )

// #theorem[\label{19:42-06/13/2022}
// Here are some properties of matrix inverse
//
// - $(A^{-1})^{-1}=A$
// - $(AB)^{-1}=B^{-1}A^{-1}$
// - $(A^T)^{-1}=(A^{-1})^T$
//
// ]

// #exercise[
// What is $(A^T)^{-1}$ in Exercise @(19:39-06/13/2022), c)?
// ]

// #solution[
// Use Theorem @(19:42-06/13/2022), we know
//  $
// (A^T)^{-1}=(A^{-1})^T=mat(
//  1 / 6 , 1 / 3 , 1 / 6 ;
// - 1 / 2 ,0, 1 / 2 ;
//  1 / 3 ,- 1 / 3 , 1 / 3 ;
// )^T=mat(
//  1 / 6 ,- 1 / 2 , 1 / 3 ;
//  1 / 3 ,0,- 1 / 3 ;
//  1 / 6 , 1 / 2 , 1 / 3 ;
// )
//  $
// ]

// #exercise[
// Let $T:RR^n->RR^n$ be a linear transformation with standard matrix $A$.
//
// - If $A$ is invertible, then $A$ has $n$ pivots. \ding{51}
// - If $T$ is one-to-one, then $A$ is invertible. \ding{51}
// - If columns of $A$ span $RR^n$, then $A$ is invertible. \ding{51}
// - If $A$ is invertible, $A\mathbf x=\mathbf0$ only has the trivial solution. \ding{51}
// - If $T$ is onto, then $T$ is one-to-one. \ding{51}
// - If $T$ is one-to-one, then $T$ is onto. \ding{51}
//
// ]

// #exercise[
// Suppose $T:RR^3->RR^3$ is a linear transformation with standard matrix $A=mat(
// 1,2,3;
// 0,-1,-2;
// 0,0,1
// )$. Is $A^{-1}$ invertible? Is $T$ one-to-one? Is $A^T$ invertible? If so, what is $(A^T)^{-1}$? If so, what is $(A^{-1})^{-1}$. Is $T$ invertible (i.e. does $T^{-1}$ exist)? What is the standard matrix of $T^{-1}$? Is $T$ onto?
// ]

// #solution[
// \begin{align*}
// ,\left[\begin{array}{c|c}
// A,I
// \end{array}\right]=\left[\begin{array}{ccc|ccc}
// 1,2,3,1,0,0;
// 0,-1,-2,0,1,0;
// 0,0,1,0,0,1
// \end{array}\right]xarrow( #`R1`-> #`R1`-3#`R3` \ #`R2`-> #`R2`+2#`R3` )\left[\begin{array}{ccc|ccc}
// 1,2,0,1,0,-3;
// 0,-1,0,0,1,2;
// 0,0,1,0,0,1
// \end{array}\right];
// ,xarrow(#`R2`-> (-1)#`R2`)\left[\begin{array}{ccc|ccc}
// 1,2,0,1,0,-3;
// 0,1,0,0,-1,-2;
// 0,0,1,0,0,1
// \end{array}\right]xarrow(#`R1`-> #`R1`-2#`R2`)\left[\begin{array}{ccc|ccc}
// 1,0,0,1,2,1;
// 0,1,0,0,-1,-2;
// 0,0,1,0,0,1
// \end{array}\right]=\left[\begin{array}{c|c}
// I,A^{-1}
// \end{array}\right]
// \end{align*}
// So $A^{-1}=mat(
// 1,2,1;
// 0,-1,-2;
// 0,0,1
// )$. By Theorem @(19:42-06/13/2022), we know
//  $
// (A^{-1})^{-1}=A=mat(
// 1,2,3;
// 0,-1,-2;
// 0,0,1
// )
//  $
//  $
// (A^T)^{-1}=(A^{-1})^T=mat(
// 1,2,1;
// 0,-1,-2;
// 0,0,1
// )^T=mat(
// 1,0,0;
// 2,-1,0;
// 1,-2,1
// )
//  $
// Therefore we know $A^{-1}$ and $A^T$ are invertible.;
// In general, if $T$ is invertible, then $A$ is invertible, so $A^{-1}$ will be the standard matrix for $T^{-1}$ as $T^{-1}(\mathbf x)=A^{-1}\mathbf x$, in more explict terms, we have
//  $
// T^{-1}\left(mat(
// x_1;x_2;x_3
// )\right)=mat(
// 1,2,1;
// 0,-1,-2;
// 0,0,1
// )mat(
// x_1;x_2;x_3
// )=mat(
// x_1+2x_2+x_3;-x_2-2x_2;x_3
// )
//  $
// ]

// ={Lecture 8 - Determinant}

// #definition[
// We say a square matrix $A$ is #text(fill:blue)[upper triangular]#index[upper triangular] if it only has zeros to the left of the diagonal
//  $
// mat(
// *,*,*,*,*,*;
// 0,*,*,*,*,*;
// 0,0,*,*,*,*;
// 0,0,0,*,*,*;
// 0,0,0,0,*,*;
// 0,0,0,0,0,*;
// )
//  $
// $A$ is #text(fill:blue)[lower triangular]#index[lower triangular] if it only has zeros to the right of the diagonal
//  $
// mat(
// *,0,0,0,0,0;
// *,*,0,0,0,0;
// *,*,*,0,0,0;
// *,*,*,*,0,0;
// *,*,*,*,*,0;
// *,*,*,*,*,*;
// )
//  $
// $A$ is #text(fill:blue)[diagonal] if $A$ only has nonzero entries on the diagonal
//  $
// mat(
// *,0,0,0,0,0;
// 0,*,0,0,0,0;
// 0,0,*,0,0,0;
// 0,0,0,*,0,0;
// 0,0,0,0,*,0;
// 0,0,0,0,0,*
// )
//  $
// A diagonal matrix is both upper triangular and lower triangular
// ]

// =={Geometric definition of determninants}

// Now let's introduce #text(fill:blue)[determinants] #index[determinant](#text(fill:red){ONLY for square matrices!!!}). Consider the parallelepiped $P$ with edges $\mathbf a_1,dots.h.c,\mathbf a_n$ in $RR^n$. We would like the following geometric definition of determinants.

// #definition[
// The determinant of $A=mat(
// \mathbf a_1,dots.h.c,\mathbf a_n
// )$ (Usually denoted $\det A$ or $|A|=\left|\begin{matrix}\mathbf a_1,dots.h.c,\mathbf a_n\end{matrix}\right|$, replacing brackets with vertical lines) as _signed_ volumes of $P$ . Therefore we have $\Vol(P)=|\det A|$, i.e. actual volume is the absolute value of the determinant.
// ]

// #example[[$n=1$]
// Suppose $A=[a]$ is a 1 by 1 matrix, then $\det A$ is the signed length of $a\inRR^1$, which is $a$ itself! Namely $\det A=a$.
// \begin{center}
// \begin{tikzpicture}
// \draw[->] (-2,0)--(2,0);
// \filldraw (0,0) circle (0.02);
// \draw[->, thick] (0,0)--(1,0) node[below] {$\mathbf a$};
// \end{tikzpicture}
// \end{center}
// )

// #example[[$n=2$]
// Suppose $A=mat(\mathbf a_1,\mathbf a_2)$ is a 2 by 2 matrix. $\det A$ is the actual positive area of the parallelogram if $\mathbf a_1$ turns counter-clockwise to $\mathbf a_2$, otherwise the negative area.
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \begin{scope}[xshift=-1cm]
// \coordinate (o) at (0,0);
// \coordinate (a1) at (1,0);
// \coordinate (a2) at ($cos(60)*(1.2,0)+sin(60)*(0,1.2)$);
// \draw[->, thick] (o)--(a1);
// \draw[->, thick] (o)--(a2);
// \draw[dashed] (a1)--($(a1)+(a2)$)--(a2);
// \draw[->] (0.4,0) arc (0:60:0.4);
// \node at (a1)[right] {$\mathbf a_1$};
// \node at (a2)[above] {$\mathbf a_2$};
// \node at ($0.5*(a1)+0.5*(a2)$){$+$};
// \end{scope}
// \begin{scope}[xshift=1cm]
// \coordinate (o) at (0,0);
// \coordinate (a2) at (1,0);
// \coordinate (a1) at ($cos(60)*(1.2,0)+sin(60)*(0,1.2)$);
// \draw[->, thick] (o)--(a1);
// \draw[->, thick] (o)--(a2);
// \draw[dashed] (a1)--($(a1)+(a2)$)--(a2);
// \draw[<-] (0.4,0) arc (0:60:0.4);
// \node at (a1)[above] {$\mathbf a_1$};
// \node at (a2)[right] {$\mathbf a_2$};
// \node at ($0.5*(a1)+0.5*(a2)$){$-$};
// \end{scope}
// \end{tikzpicture}
// \end{center}
// )

// #example[[$n=3$]
// Suppose $A=mat(\mathbf a_1,\mathbf a_2,\mathbf a_3)$ is a 3 by 3 matrix. To decide the sign of the volume of the parallelepiped, we follow the #text(fill:blue)[right-hand rule].
// \begin{center}
// \includegraphics[scale=.3]{righthandrule.jpg}
// \begin{tikzpicture}[scale=0.7]
// \def\xangle{-80}
// \def\yangle{0}
// \def\zangle{-5}
// \foreach \u/\v/\w/\U/\V/\W/\xshift/\yshift/\sign in {
// a1/a2/a3/{a_1}/{a_2}/{a_3}/-1/2/+,
// a1/a3/a2/{a_1}/{a_3}/{a_2}/1/2/-,
// a2/a1/a3/{a_2}/{a_1}/{a_3}/-1/0/-,
// a2/a3/a1/{a_2}/{a_3}/{a_1}/1/0/+,
// a3/a1/a2/{a_3}/{a_1}/{a_2}/-1/-2/+,
// a3/a2/a1/{a_3}/{a_2}/{a_1}/1/-2/-
// }{
// \begin{scope}[scale=2,rotate around x=\xangle,rotate around y=\yangle,rotate around z=\zangle,xshift=\xshift cm,yshift=\yshift cm]
// \coordinate (o) at (0,0,0);
// \coordinate (e1) at (1,0,0);
// \coordinate (e2) at (0,1,0);
// \coordinate (e3) at (0,0,1);
// \coordinate (\u) at (e1);
// \coordinate (\v) at (e2);
// \coordinate (\w) at (e3);
// \draw[->, thick] (o)--(\u)node[below right]{$\mathbf \U$};
// \draw[->, thick, dashed] (o)--(\v)node[above right]{$\mathbf \V$};
// \draw[->, thick] (o)--(\w)node[left]{$\mathbf \W$};
// \draw (e1)--($(e1)+(e3)$)--($(e1)+(e2)+(e3)$)--($(e1)+(e2)$)--cycle;
// \draw (e3)--($(e1)+(e3)$)--($(e1)+(e2)+(e3)$)--($(e2)+(e3)$)--cycle;
// \draw[dotted] ($(e1)+(e2)$)--(e2)--($(e2)+(e3)$);
// \node at ($0.5*(e1)+0.5*(e2)+(e3)$){$\sign$};
// \end{scope}
// }
// \end{tikzpicture}
// \end{center}
// )

// Determinant has following three properties:

// \begin{enumerate}\label{13:26-06/13/2022}\label{13:30-06/16/2022}
// - Interchanging $\mathbf a_1,\mathbf a_2$ changes the sign of determinant. Namely $\detmat(\mathbf a_2,\mathbf a_1)=-\detmat(\mathbf a_1,\mathbf a_2)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \begin{scope}[xshift=-5cm]
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf a_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$\mathbf a_2$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \node at (1,0.5) {$+$};
// \end{scope}
// \node at (0,0) {$\xrightarrow{\text{switch }\mathbf a_1,\mathbf a_2}$};
// \begin{scope}[xshift=5cm]
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf a_2$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$\mathbf a_1$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \node at (1,0.5) {$-$};
// \end{scope}
// \end{tikzpicture}
// \end{center}
// - Scaling $\mathbf a_1$ scales the determinant. Namely $\detmat(c\mathbf a_1,\mathbf a_2)=c\detmat(\mathbf a_1,\mathbf a_2)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \begin{scope}[xshift=-5cm]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf a_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$\mathbf a_2$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \end{scope}
// \node at (0,0) {$\xrightarrow{\text{double }\mathbf a_1}$};
// \begin{scope}[xshift=5cm]
// \def\XMAX{3.5};\def\YMAX{3.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf a_1$}; \draw[->] (0,0)--(a);
// \node at ($2*(a)$)[below right]{$2\mathbf a_1$}; \draw[->] (0,0)--($2*(a)$);
// \coordinate (b) at (1,1); \node at (b)[above right]{$\mathbf a_2$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--($2*(a)$)--($2*(a)+(b)$)--(b)--cycle;
// \draw[dashed] (a)--($(a)+(b)$);
// \end{scope}
// \end{tikzpicture}
// \end{center}
// - Adding a multiple of $\mathbf a_1$ to $\mathbf a_2$ doesn't change the determinant. Namely $\detmat(\mathbf a_1,\mathbf a_2+c\mathbf a_1)=\detmat(\mathbf a_1,\mathbf a_2)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf a_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$\mathbf a_2$}; \draw[->] (0,0)--(b);
// \node at ($(b)-(a)$)[above left]{$\mathbf a_2-\mathbf a_1$}; \draw[->,red] (0,0)--($(b)-(a)$);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \draw[red] (0,0)--(a)--(b)--($(b)-(a)$)--cycle;
// \end{tikzpicture}
// \end{center}
// \end{enumerate}

// #remark[
// If $\{\mathbf a_1,dots.h.c,\mathbf a_n\}$ is linearly dependent, then $A$ is singular, i.e. not invertible, then the determinant will be zero, since the parallelepiped will be constraint in a hyperplane which has zero volume. Take $n=2$ and $3$ for examples
// \begin{center}
// \begin{tikzpicture}
// \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf a_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (2,0); \node at (b)[below right]{$\mathbf a_2$}; \draw[->] (0,0)--(b);
// \end{tikzpicture}\qquad
// \begin{tikzpicture}
// \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// % \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX,-\ZMAX) grid (\XMAX,\YMAX,\ZMAX);
// \draw[->, color=gray!80] (-\XMAX,0,0)--(\XMAX,0,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX,0)--(0,\YMAX,0) node[above]{$x_2$};
// \draw[->, color=gray!80] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_3$};
// \coordinate (a) at (2,0,0); \node at (a)[below right]{$\mathbf a_1$}; \draw[->] (0,0,0)--(a);
// \coordinate (b) at (0,0,2); \node at (b)[below right]{$\mathbf a_2$}; \draw[->] (0,0,0)--(b);
// \coordinate (c) at (-1,0,1); \node at (c)[below left]{$\mathbf a_3$}; \draw[->] (0,0,0)--(c);
// \draw[blue] (0,0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \draw[blue] (0,0,0)--(a)--($(a)+(c)$)--(c)--cycle;
// \draw[blue] (0,0,0)--(b)--($(b)+(c)$)--(c)--cycle;
// \draw[blue] (a)--($(a)+(b)$)--($(a)+(b)+(c)$)--($(a)+(c)$)--cycle;
// \draw[blue] (b)--($(a)+(b)$)--($(a)+(b)+(c)$)--($(b)+(c)$)--cycle;
// \draw[blue] (c)--($(a)+(c)$)--($(a)+(b)+(c)$)--($(b)+(c)$)--cycle;
// \end{tikzpicture}
// \end{center}
// ]

// =={Properties of determinants}

// #theorem[\label{thm: det A theorem}
// Suppose $A=mat(
// h,0;
// *,B
// )$ or $mat(
// h,*;
// \mathbf 0,B
// )$ where $h$ is a scalar, $B$ is a $(n-1) times (n-1)$ submatrix, then $\det A=h dot.c \det B$.
// \begin{center}
// \begin{tikzpicture}
// \def\XMAX{2.5};\def\YMAX{4.5};\def\ZMAX{3};
// \begin{scope}[rotate around x=-90]
// \coordinate (o) at (0,0,0);
// \coordinate (v) at (1,1,2);
// \coordinate (a) at (.5,1.2,0);
// \coordinate (b) at (1.2,.5,0);
// \coordinate (vpxy) at (1,1,0);
// \coordinate (vpz) at (0,0,2);
// \filldraw[color=pink!30] (-2,-4)--(-2,4)--(2,4)--(2,-4)--cycle;
// \filldraw[blue!50] (o)--(a)--($(a)+(b)$)node[above]{$\det B$}--(b)--cycle;
// \draw[color=gray!80] (-\XMAX,0,0)--(\XMAX,0,0);
// \draw[color=gray!80] (0,-\YMAX,0)--(0,\YMAX,0);
// \draw[->, color=gray!80] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_j$};
// \draw[->] (o)--(v);
// \draw[dashed] (o)--(vpxy)--(v);
// \draw[dashed] (vpz)node[left]{$h$}--(v);
// \end{scope}
// \end{tikzpicture}
// \end{center}
// ]

// \begin{corollary}
// Determinant of a triangular matrix is the product of the diagonal elements.
// \end{corollary}

// \begin{proof}
// Apply Theorem @(thm: det A theorem) repeatedly.
// \end{proof}

// #theorem[\label{13:33-06/16/2022}
// $\det(A)=\det(A^T)$
// ]

// Thanks to Theorem @(13:33-06/16/2022), we can compute determinants via elementary row and column operations.

// #example[
// Use elementary row operations to evaluate the following (Note that we omit the backward phase (which are replacements) since it doesn't change the determinants)
// \begin{enumerate}[label=\roman*.]
// \item
// \begin{align*}
// ,\left|\begin{matrix}
// 1,-1,1;
// 2,0,-1;
// 1,2,1;
// \end{matrix}\right|\xequal{ #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-#`R1` }\left|\begin{matrix}
// 1,-1,1;
// 0,2,-3;
// 0,3,0;
// \end{matrix}\right|\xequal{\text{factor }#`R3`}3\left|\begin{matrix}
// 1,-1,1;
// 0,2,-3;
// 0,1,0;
// \end{matrix}\right|\xequal{#`R2`-> #`R2`-2#`R3`}3\left|\begin{matrix}
// 1,-1,1;
// 0,0,-3;
// 0,1,0;
// \end{matrix}\right|;
// ,\xequal{#`R2` arrow.l.r  #`R3`}(-1) dot.c 3\left|\begin{matrix}
// 1,-1,1;
// 0,1,0;
// 0,0,-3;
// \end{matrix}\right|=(-1) dot.c 3 dot.c 1 dot.c 1 dot.c (-3)=9
// \end{align*}
// \item
// \begin{align*}
// ,\left|\begin{matrix}
// 1,2,1;
// 2,0,-1;
// -1,2,2;
// \end{matrix}\right|\xequal{ #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`+#`R1` }\left|\begin{matrix}
// 1,2,1;
// 0,-4,-3;
// 0,4,3;
// \end{matrix}\right|\xequal{#`R3`-> #`R3`+#`R2`}\left|\begin{matrix}
// 1,2,1;
// 0,-4,-3;
// 0,0,0;
// \end{matrix}\right|=1 dot.c (-4) dot.c 0=0
// \end{align*}
// \item
//  $
// \left|\begin{matrix}
// 1,2,0,0;
// 2,8,0,0;
// 1,3,2,0;
// -4,5,7,1
// \end{matrix}\right|\xequal{C2-> C2-2C1}\left|\begin{matrix}
// 1,0,0,0;
// 2,4,0,0;
// 1,1,2,0;
// -4,13,7,1
// \end{matrix}\right|\xequal{\text{transpose}}\left|\begin{matrix}
// 1,2,1,-4;
// 0,4,1,13;
// 0,0,2,7;
// 0,0,0,1
// \end{matrix}\right|=1 dot.c 4 dot.c 2 dot.c 1=8
//  $
// \end{enumerate}
// )

// #exercise[
// Suppose $I$ is the $n times  n$ identity matrix, what is $\det I$, $\det(-I)$, $\det(2I)$ and $\det(aI)$?
// ]

// #solution[
// Note that $I$ is a diagonal matrix. $\det I=1$, $\det(-I)=(-1)^n$, $\det(2I)=2^n$, and in general $\det (aI)=a^n$ by factoring each row.
// ]

// #example[
// Suppose $A=mat(
// a,b;
// c,d
// )$
//  $
// \left|\begin{matrix}
// a,b;
// c,d
// \end{matrix}\right|\xequal{#`R2`-> #`R2`- c / a #`R1`}\left|\begin{matrix}
// a,b;
// 0,d- bc / a
// \end{matrix}\right|=a\left(d- bc / a \right)=ad-bc
//  $
// )

// #definition[
// Suppose $T:RR^n->RR^n$ is a linear transformation with standard matrix $A$, the determinant of $T$ is defined to be $\det T=\det A$.
// ]

// #question[
// Suppose $T:RR^2->RR^2$ is a linear transformation with standard matrix $A=mat(
// T(\mathbf e_1),T(\mathbf e_2)
// )=mat(
// 2,1;1,2
// )$. What is the area of the image of the unit circle under $T$?
// ]

// #answer[
// We sketch the unit circle and its image
// \begin{center}
// \begin{tikzpicture}
// \def\XMAX{2};\def\YMAX{2};
// \begin{scope}[xshift=-5cm]
// \draw[color=blue!50,fill] (-0.6,-0.6)--(-0.6,-0.4)--(-0.4,-0.4)--(-0.4,-0.6)--cycle;
// \draw[color=gray!10,fill] (0,0)--(1,0)--(1,1)--(0,1)--cycle;
// \clip (-\XMAX,-\YMAX) rectangle (\XMAX,\YMAX);
// \draw[help lines, color=gray!30, step=0.2] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (e1) at (1,0); \node at (e1)[above right]{$\mathbf e_1$}; \draw[->] (0,0)--(e1);
// \coordinate (e2) at (0,1); \node at (e2)[above right]{$\mathbf e_2$}; \draw[->] (0,0)--(e2);
// \draw (0,0) circle (1.7);
// \end{scope}
// \draw[->](-2.5,0)--(-1.5,0);
// \node at (-2,0)[above] {$T$};
// \begin{scope}[xshift=3cm]
// \draw[color=blue!50,fill] (-1.8,-1.8)--(-1.6,-1.4)--(-1.2,-1.2)--(-1.4,-1.6)--cycle;
// \draw[color=gray!10,fill] (0,0)--(2,1)--(3,3)--(1,2)--cycle;
// \clip (-2*\XMAX,-2*\YMAX) rectangle (2*\XMAX,2*\YMAX);
// \foreach \i in {-4,-3.8,...,4}{
// \draw[->, color=gray!30] (-10+\i,-5+2*\i)--(10+\i,5+2*\i);
// \draw[->, color=gray!30] (-5+2*\i,-10+\i)--(5+2*\i,10+\i);
// }
// \draw[->, color=gray!80] (-2*\XMAX,0)--(2*\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-2*\YMAX)--(0,2*\YMAX) node[above]{$x_2$};
// \coordinate (v1) at (2,1); \node at (v1)[above right]{$T(\mathbf e_1)$}; \draw[->] (0,0)--(v1);
// \coordinate (v2) at (1,2); \node at (v2)[above]{$T(\mathbf e_2)$}; \draw[->] (0,0)--(v2);
// \draw[rotate=45] (0,0) ellipse (5.1 and 1.8);
// \end{scope}
// \end{tikzpicture}
// \end{center}
// Since every small blue squares has been deformed into small parallelograms which are congruent to the gray square, parallelogram respectively and are of the same (signed) ratio $\det A$, so any area gets scaled by $\det A=2 dot.c 2-1 dot.c 1=3$ under $T$.
// ]

// #remark[
// In multi-variable calculus, this is known as the #text(fill:blue)[Jacobian].
// ]

// #theorem[
// Suppose $A,B$ are $n times  n$ matrices, then $\det(AB)=(\det A)(\det B)$
// ]

// \begin{proof}
// Suppose $T_1,T_2$ are linear transformations with standard matrices $A,B$, respectively. Consider $T_2\circ T_1$ which should scale area by $\det(BA)$. On the other hand, this should scale area by $\det A$ and then $\det B$
// \end{proof}

// #theorem[
// $A$ is invertible $<=>\det A!=0$. In addition, $\det(A^{-1})=\dfrac{1}{\det A}$.
// ]

// \begin{proof}
// If $A$ is invertible, then $A^{-1}$ is well-defined, then $1=\det I=\det(AA^{-1})=(\det A)(\det(A^{-1})) =>  \det(A^{-1})=\dfrac{1}{\det A}$, so $\det A!=0$. Conversely, if $\det A!=0$, $A$ would have $n$ pivots, so a pivot in each row and column, thus $A$ will be invertible.
// \end{proof}

// #exercise[
// Compute the determinants of the following matrices
//
// - $mat(
// 1,-2;4,3
// )$
// - $mat(
// 1,5,-4;
// -1,-4,5;
// -2,-8,7
// )$
// - $mat(
// 0,0,0,1;
// 0,2,0,3;
// 0,7,-1,-8;
// 2,2,-5,1
// )$
//
// ]

// =={Cofactor expansion}

// There is one more property of determinants. $\detmat(
// \mathbf w,\mathbf u+\mathbf v
// )=\detmat(
// \mathbf w,\mathbf u
// )+\detmat(
// \mathbf w,\mathbf v
// )$

// \begin{center}
// \begin{tikzpicture}[scale=1]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (o) at (0,0);
// \coordinate (w) at (1,0); \draw[->] (o)--(w)node[below right]{$\mathbf w$};
// \coordinate (u) at (1,1); \draw[->,blue] (o)--(u)node[above right]{$\mathbf u$};
// \coordinate (v) at (-0.5,1); \draw[->,red] (o)--($(u)+(v)$)node[above]{$\mathbf v$};
// \draw[dashed,blue] (u)--($(u)+(w)$)--(w);
// \draw[dashed,blue] ($(u)+(v)$)--(u)--($(u)+(w)$)--($(u)+(w)+(v)$)--cycle;
// \draw[dashed,red] ($(u)+(v)$)--($(u)+(w)+(v)$)--(w);
// \end{tikzpicture}
// \end{center}

// #definition[
// We use $a_(i j)$ to be denote the $(i,j)$-th entry of the matrix $A$, and $A_(ij)$ to denote the submatrix of $A$ by deleting the $i$-th row and the $j$-th column
// \begin{center}
// \begin{tikzpicture}
// % \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// % \mygrid{(-\XMAX,-\YMAX)}{(\XMAX,\YMAX)}{(0,0)};
// \node at (0,0) {$mat(
// ,,,,,;
// ,,,,,;
// ,,,,,;
// ,,a_(i j),,;
// ,,,,,;
// ,,,,,
// )$};
// \node at (-1.8,-0.2)[left] {$i$-th row}; \draw[->] (-1.8,-0.2)--(-1.4,-0.2);
// \node at (-0.2,1.8)[above] {$j$-th column}; \draw[->] (-0.2,1.8)--(-0.2,1.4);
// \end{tikzpicture}
// \begin{tikzpicture}
// % \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// % \mygrid{(-\XMAX,-\YMAX)}{(\XMAX,\YMAX)}{(0,0)};
// \node at (0,0) {$A_(ij)=mat(
// ,,,,,;
// ,,,,,;
// ,,,,,;
// ,,\,\,\,\,\,\,\,,,,;
// ,,,,,;
// ,,,,,
// )$};
// \draw[fill=black] (-0.7,-0.3)--(1.7,-0.3)--(1.7,-0.1)--(-0.7,-0.1)--cycle;
// \draw[fill=black] (0.2,-1.3)--(0.4,-1.3)--(0.4,1.3)--(0.2,1.3)--cycle;
// \end{tikzpicture}
// \end{center}
// We define the #text(fill:blue)[$(i,j)$-cofactor]#index[cofactor] to be $C_(ij)=(-1)^{i+j}\det A_(ij)$ (we also call $\det A_(ij)$ a #text(fill:blue)[minor]#index[minor]).
// ]

// For $n\geq2$, with the help of Lemma @(lemma: det A lemma), we derive cofactor expansion formula.

// The #text(fill:blue)[cofactor expansion]#index[cofactor expansion] across the $i$-th row is
//  $
// \det A=a_(i 1)C_(i1)+a_(i 2)C_(i2)+dots.h.c+a_(i n)C_(in)
//  $
// The cofactor expansion across the $j$-th column is
//  $
// \det A=a_{1j}C_(1j)+a_{2j}C_(2j)+dots.h.c+a_{nj}C_(nj)
//  $
// \begin{center}
// \begin{tikzpicture}
// \node at (-2,0) {$mat(
// ;
// ;
// ;
// a_(i 1),a_(i 2),dots.h.c ,a_(i n);
// ;
// ;
// )$};
// \node at (2,0) {$mat(
// ,,a_{1j},,,;
// ,,a_{2j},,,;
// ,,dots.v,,,;
// ,,a_{nj},,,;
// )$};
// \end{tikzpicture}
// \end{center}

// \begin{proof}[Proof of Theorem @(13:33-06/16/2022)]
// Note that row cofactor expansion of $A$ is the same as column cofactor expansion of $A^T$. Hence we can prove this inductively on the size of the matrix.
// \end{proof}

// #example[
// \begin{align*}
// ,\left|\begin{matrix}
// 1,2,3,0;
// 0,3,-1,0;
// -1,2,1,2;
// 2,-3,1,0
// \end{matrix}\right|\xequal{\text{cofactor expansion across last column}}2(-1)^{3+4}\left|\begin{matrix}
// 1,2,3;
// 0,3,-1;
// 2,-3,1
// \end{matrix}\right|;
// ,\xequal{#`R3`-> #`R3`-2#`R1`}(-2)\left|\begin{matrix}
// 1,2,3;
// 0,3,-1;
// 0,-7,-5
// \end{matrix}\right|\xequal{\text{cofactor expansion across first column}}(-2) dot.c 1(-1)^{1+1}\left|\begin{matrix}
// 3,-1;
// -7,-5
// \end{matrix}\right|;
// ,=(-2)(3(-5)-(-1)(-7))=44
// \end{align*}
// )

// #remark[
// When use the cofactor expansion, we want to apply it to rows/columns with more 0's
// ]

// #exercise[
// Suppose $A=mat(
// 1,-1,1;
// 2,0,-1;
// 1,1,1;
// )$. Please find the cofactor expansion of $A$ across the
// \begin{tasks}(2)
// \task 1st row
// \task 2nd column
// \end{tasks}
// And evaluate determinant of $A$.
// ]

// #solution[
// \begin{align*}
// \det A,=a_(11)C_(11)+a_(12)C_(12)+a_(13)C_(13);
// ,=a_(11)(-1)^{1+1}\det A_(1 1)+a_(12)(-1)^{1+2}\det A_(1 2)+a_(13)(-1)^{1+3}\det A_(1 3);
// ,=1 dot.c (-1)^{1+1}\left|\begin{matrix}
// 0,-1;1,1
// \end{matrix}\right|+(-1) dot.c (-1)^{1+2}\left|\begin{matrix}
// 2,-1;1,1
// \end{matrix}\right|+1 dot.c (-1)^{1+3}\left|\begin{matrix}
// 2,0;1,1
// \end{matrix}\right|;
// ,=1 dot.c (0 dot.c 1-(-1) dot.c 1)+(-1) dot.c (2 dot.c 1-(-1) dot.c 1)+1 dot.c (-1)(2 dot.c 1-(-1) dot.c 1);
// ,=6
// \end{align*}
// \begin{align*}
// \det A,=a_(12)C_(12)+a_(22)C_(22)+a_(32)C_(32);
// ,=a_(11)(-1)^{1+1}\det A_(1 1)+a_(12)(-1)^{1+2}\det A_(1 2)+a_(13)(-1)^{1+3}\det A_(1 3);
// ,=(-1) dot.c (-1)^{1+2}\left|\begin{matrix}
// 2,-1;1,1
// \end{matrix}\right|+0 dot.c (-1)^{2+2}\left|\begin{matrix}
// 1,1;1,1
// \end{matrix}\right|+1 dot.c (-1)^{3+2}\left|\begin{matrix}
// 1,1;2,-1
// \end{matrix}\right|;
// ,=(-1) dot.c (-1)(2 dot.c 1-(-1) dot.c 1)+0 dot.c (1 dot.c 1-1 dot.c 1)+1 dot.c (-1)(1 dot.c (-1)-1 dot.c 2);
// ,=6
// \end{align*}
// ]

// #exercise[
// Suppose $A=mat(
// 1,2,1;
// 1,0,-1;
// -1,2,1
// )$. Write out the cofactor expansion of $A$ across the second row, and evaluate the determinant $\det A$.
// ]

// #solution[
// \begin{align*}
// \det A,=a_(21)C_(21)+a_(22)C_(22)+a_(23)C_(23);
// ,=a_(21)(-1)^{2+1}\det A_(2 1)+a_(22)(-1)^{2+2}\det A_(2 2)+a_(23)(-1)^{2+3}\det A_(2 3);
// ,=1 dot.c (-1)^{2+1}\left|\begin{matrix}
// 2,1;2,1
// \end{matrix}\right|+0 dot.c (-1)^{2+2}\left|\begin{matrix}
// 1,1;-1,1
// \end{matrix}\right|+(-1) dot.c (-1)^{2+3}\left|\begin{matrix}
// 2,1;2,1
// \end{matrix}\right|;
// ,=1 dot.c (-1)(2 dot.c 1-1 dot.c 2)+0 dot.c (1 dot.c 1-1 dot.c (-1))+(-1) dot.c (-1)(1 dot.c 2-2 dot.c (-1));
// ,=4
// \end{align*}
// ]

// #remark[
// The REF of a square matrix $A$ is upper triangular, and $\det A=0$ if $A$ has less then $n$ pivots.
// ]

// #exercise[
// Suppose $A=mat(
// 2,-1,3,1;
// 0,-2,0,-1;
// 0,0,3,1;
// 0,0,0,1
// )$. Please find use cofactor expansion  to find the $\det A$
// ]

// #solution[
// Note that $A$ is upper triangular, so we could do cofactor expansions across first columns multiple times
// \begin{align*}
// \left|\begin{matrix}
// 2,-1,3,1;
// 0,-2,0,-1;
// 0,0,3,1;
// 0,0,0,1
// \end{matrix}\right|=2(-1)^{1+1}\left|\begin{matrix}
// -2,0,-1;
// 0,3,1;
// 0,0,1
// \end{matrix}\right|=2 dot.c (-2)(-1)^{1+1}\left|\begin{matrix}
// 3,1;
// 0,1
// \end{matrix}\right|=2 dot.c (-2) dot.c 3 dot.c (-1)^{1+1}1=-12
// \end{align*}
// ]

// #exercise[
// Consider $A=mat(
// a,b;c,d
// )$. What is $A_(1 1),A_(1 2),A_(2 1),A_(2 2)$? What is $C_(11),C_(12),C_(21),C_(22)$. Write down the cofactor expansion of $A$ across the
//
// - 1st row
// - 2nd row
// - 1st column
// - 2nd column
//
// ]

// #solution[
// $A_(1 1)=[d],A_(1 2)=[c],A_(2 1)=[b],A_(2 2)=[a]$ are all 1 by 1 matrices. $C_(11)=(-1)^{1+1}\det A_(1 1)=d,C_(12)=(-1)^{1+2}\det A_(2 1)=-c,C_(21)=(-1)^{2+1}\det A_(2 1)=-b,C_(22)=(-1)^{2+2}\det A_(2 2)=a$. So the cofactor expansions are
//
// - $\det A=aC_(11)+bC_(12)=ad-bc$
// - $\det A=cC_(21)+dC_(22)=-bc+ad$
// - $\det A=aC_(11)+cC_(21)=ad-bc$
// - $\det A=bC_(12)+dC_(22)=-bc+ad$
//
// Note that all of the above calculations show that $\det A=\detmat(
// a,b;c,d
// )=ad-bc$.
// ]

// ={Lecture 9 - Vector spaces and subspaces}

// =={Vector space}

// To motivate the definition of a vector space, let's consider the following example

// #example[\label{17:45-06/27/2022}
// Let $\mathbb P_n$ denote the set of (real) polynomials of degree less or equal to $n$. For example $\mathbb P_0=RR$ is just the set of real numbers, and
// \begin{align*}
// \mathbb P_1,=\{a_0+a_1t|a_0,a_1\inRR\} ;
// \mathbb P_2,=\{a_0+a_1t+a_2t^2|a_0,a_1,a_2\inRR\};
// \mathbb P_3,=\{a_0+a_1t+a_2t^2+a_3t^3|a_0,a_1,a_2,a_3\inRR\};
// ,dots.v;
// \mathbb P_n,=\{a_0+a_1t+a_2t^2+dots.h.c+a_nt^n|a_0,a_1,a_2,dots.h.c,a_n\inRR\}.
// \end{align*}
// You may soon realize that $\mathbb P_n$ can be identified with $RR^{n+1}$.
// \begin{center}
// \begin{tikzcd}
// \mathbb P_1 \arrow[r,equal,"tilde "]        , RR^2   ;
// \{a_0+a_1t\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_0;a_1)\right\} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// \mathbb P_2 \arrow[r,equal,"tilde "]        , RR^3;
// \{a_0+a_1t+a_2t^2\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_0;a_1;a_2)\right\} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// \mathbb P_n \arrow[r,equal,"tilde "]        , RR^{n+1}          ;
// \{a_0+a_1t+a_2t^2+dots.h.c+a_nt^n\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_0;a_1;dots.v;a_n)\right\} \arrow[u, equal]
// \end{tikzcd}
// \end{center}
// More concrete examples could be
// \begin{enumerate}
// - For $\mathbb P_1\congRR^2$, $1+2t\leftrightsquigarrowmat(
// 1;2
// )$
// - For $\mathbb P_2\congRR^3$, $3t^2-1\leftrightsquigarrowmat(
// -1;0;3
// )$
// \end{enumerate}
// If we consider addition and scalar multiplication, we have
// \begin{center}
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration={zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}}
// \node at (0,1) {$mat(
// 1;0;2
// )+mat(
// 2;1;0
// )=mat(
// 3;1;2
// )$};
// \node at (0,-1) {$(1+2t^2)+(2+t)=3+t+2t^2$};
// \draw[<-squig->] (-1.1,0.2)--(-1.8,-0.7);
// \draw[<-squig->] (0,0.2)--(-0.1,-0.7);
// \draw[<-squig->] (1.1,0.2)--(1.5,-0.7);
// \end{tikzpicture}
// \qquad
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration={zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}}
// \node at (0,1) {$2 dot.c mat(
// 1;0;2
// )=mat(
// 2;0;4
// )$};
// \node at (0,-1) {$2 dot.c (1+2t^2)=2+4t^2$};
// \draw[<-squig->] (-0.35,0.2)--(-0.6,-0.7);
// \draw[<-squig->] (0.8,0.2)--(1.1,-0.7);
// \end{tikzpicture}
// \end{center}
// So we may conclude that addition and scalar multiplication in $\mathbb P_n$ can be identically translated to addition and scalar multiplication in $RR^{n+1}$
// )

// #remark[
// We call $\{1,t,t^2,dots.h.c,t^n\}$ the _standard basis_ of $\mathbb P_n$, corresponding to the standard basis for $RR^{n+1}$
// ]

// #example[
// $\left\{1,t,t^2\right\}$ is the standard basis for $\mathbb P_2$, and
// \begin{align*}
// p(t),=a_0+a_1t+a_2t^2=a_0 dot.c  1+a_1 dot.c  t+a_2 dot.c  t^2
// \end{align*}
// )

// #example[\label{17:53-06/27/2022}
// Let's denote $M_{m times  n}(RR)$ the set of $m times  n$ matrices. For example
// \begin{align*}
// M_{2 times 2}(RR),=\left\{mat(
// a_(11),a_(12);
// a_(21),a_(22)
// )\middle|a_(11),a_(12),a_(21),a_(22)\inRR\right\};
// M_{3 times 2}(RR),=\left\{mat(
// a_(11),a_(12);
// a_(21),a_(22);
// a_(31),a_(32)
// )\middle|a_(11),a_(12),a_(21),a_(22),a_(31),a_(32)\inRR\right\};
// M_{2 times 3}(RR),=\left\{mat(
// a_(11),a_(12),a_(13);
// a_(21),a_(22),a_(23)
// )\middle|a_(11),a_(12),a_(13),a_(21),a_(22),a_(23)\inRR\right\};
// ,dots.v;
// M_{m times  n}(RR),=\left\{mat(
// a_(11),a_(12),dots.h.c,a_(1 n);
// a_(21),a_(22),dots.h.c,a_(2 n);
// dots.v,dots.v,,dots.v;
// a_(m 1),a_(m 2),dots.h.c,a_(m n);
// )\middle|a_(11),dots.h.c,a_(1 n),dots.h.c,a_(m 1),dots.h.c,a_(m n)\inRR\right\}.
// \end{align*}
// You may realize that $M_{m times  n}(RR)$ can be identified with $RR^{mn}$
// \begin{center}
// \begin{tikzcd}
// M_{2 times  2}(RR) \arrow[r,equal,"tilde "]        , RR^{4}   ;
// \left\{mat(
// a_(11),a_(12);
// a_(21),a_(22)
// )\right\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_(11);a_(12);a_(21);a_(22))\right\} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// M_{3 times  2}(RR) \arrow[r,equal,"tilde "]        , RR^{6}   ;
// \left\{mat(
// a_(11),a_(12);
// a_(21),a_(22);
// a_(31),a_(32)
// )\right\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_(11);a_(12);a_(21);a_(22);a_(31);a_(32))\right\} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// M_{2 times  3}(RR) \arrow[r,equal,"tilde "]        , RR^{6}   ;
// \left\{mat(
// a_(11),a_(12),a_(13);
// a_(21),a_(22),a_(23)
// )\right\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_(11);a_(12);a_(13);a_(21);a_(22);a_(23))\right\} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// M_{m times  n}(RR) \arrow[r,equal,"tilde "]        , RR^{mn}   ;
// \left\{mat(
// a_(11),a_(12),dots.h.c,a_(1 n);
// a_(21),a_(22),dots.h.c,a_(2 n);
// dots.v,dots.v,,dots.v;
// a_(m 1),a_(m 2),dots.h.c,a_(m n);
// )\right\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , \left\{mat(a_(11);dots.v;a_(1 n);dots.v;a_(m 1);dots.v;a_(m n))\right\} \arrow[u, equal]
// \end{tikzcd}
// \end{center}
// In more concrete terms, addition and scalar multiplication can be identified as the following
// \begin{center}
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration={zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}}
// \node at (0,1) {$mat(
// 1,0;1,1
// )+mat(
// -1,0;2,3
// )=mat(
// 0,0;4,6
// )$};
// \node at (0,-1) {$mat(
// 1;0;1;1
// )+mat(
// -1;0;2;3
// )=mat(
// 0;0;4;6
// )$};
// \draw[<-squig->] (-1.6,0.5)--(-1.2,-0.1);
// \draw[<-squig->] (0,0.5)--(0,-0.1);
// \draw[<-squig->] (1.6,0.5)--(1.2,-0.1);
// \end{tikzpicture}
// \qquad
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration={zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}}
// \node at (0,1) {$2 dot.c mat(
// -1,0;2,3
// )=mat(
// -2,0;4,6
// )$};
// \node at (0,-1) {$2 dot.c mat(
// -1;0;2;3
// )=mat(
// -2;0;4;6
// )$};
// \draw[<-squig->] (-0.6,0.5)--(-0.5,-0.1);
// \draw[<-squig->] (1.1,0.5)--(0.9,-0.1);
// \end{tikzpicture}
// \end{center}
// So we may conclude that addition and scalar multiplication in $M_{m times  n}(RR)$ can be identically translated to addition and scalar multiplication in $RR^{mn}$
// )

// #remark[
// We call $\{E_{ij}\}$ the _standard basis_ of $M_{m times  n}(RR)$, corresponding to the standard basis for $RR^{mn}$. Here $E_{ij}$ is the $m times  n$ matrix that only has a single 1 in the $(i,j)$-th spot, but 0's elsewhere.
// ]

// #example[
// $\left\{E_{11}=mat(
// 1,0;0,0
// ),E_{12}=mat(
// 0,1;0,0
// ),E_{21}=mat(
// 0,0;1,0
// ),E_{22}=mat(
// 0,0;0,1
// )\right\}$ is the standard basis for $M_{2 times 2}(RR)$, and
// \begin{align*}
// mat(
// a_(11),a_(12);a_(21),a_(22)
// ),=mat(
// a_(11),0;0,0
// )+mat(
// 0,a_(12);0,0
// )+mat(
// 0,0;a_(21),0
// )+mat(
// 0,0;0,a_(22)
// );
// ,=a_(11)mat(
// 1,0;0,0
// )+a_(12)mat(
// 0,1;0,0
// )+a_(21)mat(
// 0,0;1,0
// )+a_(22)mat(
// 0,0;0,1
// );
// ,=a_(11)E_{11}+a_(12)E_{12}+a_(21)E_{21}+a_(22)E_{22}
// \end{align*}
// )

// #definition[
// A #text(fill:blue)[(real) vector space]#index[vector space] is a set $V$ of objects, called _vectors_, on which are defined two operations, called _addition_ $\fatplus$ and _(left) scalar multiplication_ $\fatdot$, subject to axioms
// \begin{enumerate}\setcounter{enumi}{-1}
// - $\bm u\fatplus\bm v$ and $c\fatdot\bm v$ are still in $V$
// - $\bm u\fatplus\bm v=\bm v\fatplus\bm u$
// - $(\bm u\fatplus\bm v)\fatplus\bm w=\bm u\fatplus(\bm v\fatplus\bm w)$
// - There is a _zero vector_ $\bm 0$ such that $\bm u\fatplus\bm 0=\bm u$
// - For each $\bm u$ in $V$, there is a vector $\fatminus\bm u$ in $V$ such that $\bm u\fatplus(\fatminus\bm u)=\bm 0$
// - $c\fatdot(\bm u\fatplus\bm v)=c\fatdot\bm u\fatplus c\fatdot\bm v$
// - $(c+d)\fatdot\bm u=c\fatdot\bm u\fatplus d\fatdot\bm u$
// - $c\fatdot(d\fatdot\bm u)=(cd)\fatdot\bm u$
// - $1\fatdot\bm u=\bm u$
// \end{enumerate}
// ]

// #example[
// Set $V$ to be $RR^n$, $\fatplus$ to be addition $+$ for vectors, $\fatdot$ to be scalar multiplication $ dot.c $ for vectors, then this is a vector space
// )

// #example[[non-example]
// Suppose $V=RR$, $a\fatplus b=a+b+1$, $c\fatdot a=c dot.c  a=ca$, we can check
// \begin{enumerate}\setcounter{enumi}{-1}
// - $a\fatplus b=a+b+1\inRR$, $c\fatdot a=ca\inRR$
// - $a\fatplus b=a+b+1=b+a+1=b\fatplus a$
// - $(a\fatplus b)\fatplus c=(a+b+1)+c+1=a+(b+c+1)+1=a\fatplus(b\fatplus c)$
// - There is a _zero vector_ $\bm 0=-1$ such that $a\fatplus\bm 0=a+(-1)+1=a$
// - For each $a$, we have $\fatminus a=-a-2$ such that $a\fatplus(\fatminus a)=a+(-a-2)+1=-1=\bm 0$
// \end{enumerate}
// However $2\fatdot(a\fatplus b)=2(a+b+1)!= 2a+2b+1=2\fatdot a\fatplus 2\fatdot b$. Therefore, this is not a vector space
// )

// =={Subspace}

// #definition[
// Suppose $V$ is a vector space with addition $\fatplus$ and scalar multiplication $\fatdot$. A #text(fill:blue)[subspace]#index[subspace] $H$ is a non-empty subset which closed under addition and scalar multiplication, i.e. for any $\bm u,\bm v\in H$, $c\inRR$, $\bm u\fatplus\bm v,c\fatdot\bm u\in H$
// ]

// #remark[
// It is easy to check that a subspace $H$ is again a vector space.
// ]

// #exercise[\label{17:08-06/29/2022}
// Recall that $M_{2 times 2}(RR)$ is the set of 2 by 2 matrices, and that a square matrix $A$ is _symmetric_ if $A^T=A$. Consider a subset $V$ consists of 2 by 2 symmetric matrices, i.e. $V=\left\{A\in M_{2 times 2}(RR)\middle|A^T=A\right\}$
// \begin{enumerate}
// - Show that $V$ is a vector space.
// - Find a basis for $V$.
// \end{enumerate}
// ]

// #solution[
// \begin{enumerate}
// - For any $A,B\in V$, $c\inRR$, by definition we know that $A^T=A$, $B^T=B$, we want to show that $A+B\in V$, $cA\in V$ (condition for subspace), i.e. $(A+B)^T=A^T+B^T$, $(cA)^T=cA$. This is true because
//  $
// (A+B)^T=A^T+B^T=A+B,\qquad (cA)^T=cA^T=cA
//  $
// Therefore $V$ is a subspace of $M_{2 times 2}(RR)$, and thus a vector space
// - Suppose $A=mat(
// a_(11),a_(12);a_(21),a_(22)
// )\in M_{2 times 2}(RR)$, then $a_(12)=a_(21)$, so we may conclude that
//  $
// V=\left\{mat(
// a,b;b,c
// )\in M_{2 times 2}(RR)\middle|a,b,c\inRR\right\}
//  $
// Note that
// $ \label{17:01-06/24/2022}
// \begin{aligned}
// mat(
// a,b;b,c
// )=mat(
// a,0;0,0
// )+mat(
// 0,b;b,0
// )+mat(
// 0,0;0,c
// )=amat(
// 1,0;0,0
// )+bmat(
// 0,1;1,0
// )+cmat(
// 0,0;0,1
// )
// \end{aligned}
// $
// And that linear combination~\eqref{17:01-06/24/2022} is the zero matrix $<=> a=b=c=0$, thus $\mathcal B=\left\{mat(
// 1,0;0,0
// ),mat(
// 0,1;1,0
// ),mat(
// 0,0;0,1
// )\right\}$ is a basis for $V$
// \end{enumerate}
// ]

// #exercise[\label{ker T for T take sum of coef of poly}
// Suppose $H=\{p(t)=a_0+a_1t+a_2t^2\in\mathbb P_2|a_0+a_1+a_2=0\}$ is the set of polynomials of degree $\leq 2$ and sum of coefficients zero. Show that $H$ is a vector space.
// ]

// #example[\label{15:10-06/23/2022}
// Consider the vector space $V=RR^2$, and $H$ is the set of solutions to the linear equation $2x_1-x_2+2=0$, then $H$ is not a subspace. For example, if we choose $\mathbf u=mat(
// -1;0
// ),\mathbf v=mat(
// 0;2
// )$, then $\mathbf u+\mathbf v=mat(
// -1;2
// )$ is not in $H$, nor is $2\mathbf u=mat(
// -2;0
// )$
// \begin{center}
// \begin{tikzpicture}
// \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// \begin{scope}
// \clip(-\XMAX,-\YMAX) rectangle (\XMAX,\YMAX);
// \draw (-3,-4)--(3,8);
// \draw[blue] (-3,-6)--(3,6);
// \end{scope}
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (u) at (-1,0); \node at (u)[below right]{$\mathbf u$}; \draw[->,thick] (0,0)--(u);
// \coordinate (v) at (0,2); \node at (v)[below right]{$\mathbf v$}; \draw[->,thick] (0,0)--(v);
// \draw[->,thick,blue] (0,0)--(1,2);
// \node at ($2*(u)$)[below right]{$2\mathbf u$}; \draw[->] (0,0)--($2*(u)$);
// \node at ($(u)+(v)$)[below left]{$\mathbf u+\mathbf v$}; \draw[->] (0,0)--($(u)+(v)$);
// % \draw[dashed] (u)--($(u)+(v)$); \draw[dashed] (v)--($(u)+(v)$);
// \node at (-2,-2)[left] {$H$};
// \node at (1,2)[below right] {$H_1$};
// \end{tikzpicture}
// \end{center}
// The reason is that $H$ is not homogeneous. If we consider $H_1$ to be solution set of the homogeneous equation $2x_1-x_2=0$, we see that $H_1$ is a subspace as it is the span of a single vector $mat(
// 1;2
// )$.
// )

// ={Lecture 10 - Null spaces, Column spaces, Row spaces, Rank and Nullity}

// =={Null space, Column Space and Row space}

// #definition[
// Suppose $V$ is a vector space, $\{\bm v_1,\bm v_2,dots.h.c,\bm v_n\}\subseteq V$ is a set of linearly independent vectors that span $V$, we define the #text(fill:blue)[dimension]#index[dimension] of $V$ to be $\dim V=n$.
// ]

// #definition[
// Suppose $A$ is a $m times  n$ matrix, we define the #text(fill:blue)[null space]#index[null space] of $A$ to be
//  $
// \Nul A=\{\mathbf x\inRR^n|A\mathbf x=\mathbf0\}=\text{solution set of $A\mathbf x=\mathbf 0$}
//  $
// Note that the solution set to linear system $A\mathbf x=\mathbf0$ is the intersection of $m$ hyperplanes (one for each homogeneous equation) that pass through the origin.
// ]

// #example[
// $A=mat(
// 1,-3,2;
// -5,12,-1
// )$, the to find the $\Nul A$ is equivalent to solve $A\mathbf x=\mathbf 0$
// \begin{align*}
// mat(
// A,\mathbf 0
// )xarrow(#`R2`-> #`R2`+5#`R1`)mat(
// 1,-3,2,0;
// 0,-3,9,0
// )xarrow(#`R2`/(-3))mat(
// 1,-3,2,0;
// 0,1,-3,0
// )xarrow(#`R1`-> #`R1`+3#`R2`)mat(
// 1,0,-7,0;
// 0,1,-3,0
// )
// \end{align*}
// Hence the solution set is $#cases(
// x_1=7x_3;
// x_2=3x_3;
// x_3\text{ is free}
// )$, in parametric form, $mat(
// x_1;x_2;x_3
// )=x_3mat(
// 7;3;1
// )$, which describes a line in $RR^3$ of the direction $mat(
// 7;3;1
// )$ that passes through the origin, and this line is the intersection of planes $x_1-3x_2+2x_3=0$ and $-5x_1+12x_2-x_3=0$
// \begin{center}
// \begin{tikzpicture}
// \definecolor{color1}{rgb}{255,0,0}
// \definecolor{color2}{rgb}{0,0,255}
// \definecolor{color3}{rgb}{255,0,255}
// \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// \begin{scope}[blend mode=multiply]
// \draw [color1, fill=color1!20] plot (-2,-2,-2)--(-2,2,4)--(2,2,2)--(2,-2,-4)--cycle;
// \node at (2,-2,-4) [below right]{$x_1-3x_2+2x_3=0$};
// \draw [color2, fill=color2!20] plot (-2,-7/6,-4)--(-2,-1/2,4)--(2,7/6,4)--(2,1/2,-4)--cycle;
// \node at (2,1/2,-4) [above]{$-5x_1+12x_2-x_3=0$};
// \end{scope}
// \draw [purple, ultra thick](-2,-6/7,-2/7)--(2,6/7,2/7);
// \draw[->] (-\XMAX,0,0)--(\XMAX,0,0) node[right]{$x_1$};
// \draw[->] (0,-\YMAX,0)--(0,\YMAX,0) node[above]{$x_2$};
// \draw[->] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_3$};
// \end{tikzpicture}
// \end{center}
// )

// #remark[
// As discussed in Example @(15:10-06/23/2022), in general, the solution set of $A\mathbf x=bold(b)$ is not a subspace of $RR^n$ unless $bold(b)=\mathbf0$. And in fact, any subspace of $RR^n$ is the null space for some $m times  n$ matrix $A$, i.e. the intersection of hyperplanes passing through the origin
// ]

// #definition[
// Suppose $A=mat(
// \mathbf a_1,\mathbf a_2,dots.h.c,\mathbf a_n
// )$ is an $m times  n$ matrix, then the #text(fill:blue)[column space]#index[column space] (denote as $\Col A$) is the subspace $\Span\{\mathbf a_1,\mathbf a_2,dots.h.c,\mathbf a_n\}$ in $RR^m$. Suppose $A=mat(
// #`R1`;#`R2`;dots.v;Rm
// )$, then the #text(fill:blue)[row space]#index[row space] (denote as $\Row A$) is the subspace spaned by row vectors $\Span\{#`R1`,#`R2`,dots.h.c, Rm\}$ in $RR^n$ written horizontally.
// ]

// #theorem[
// Row reductions preserve $\Nul A, \Row A$, but not $\Col A$. However, row reductions preserve linear dependences of the column vectors.
// ]

// #remark[
// Suppose $A\mathbf x=\mathbf0$ is some linear dependence of the column vectors of $A$, after elementary row reduction $Atilde  EA$, $(EA)\mathbf x=E(A\mathbf x)=E\mathbf0=\mathbf0$ is again the same linear dependence of columns of $EA$. In other words, the linear dependence of columns of a matrix is preserved by row equivalence.
// ]

// #theorem[
// Suppose $A$ is a $m times  n$ matrix, $Atilde  U$ is of RREF form
//
// - The vectors in the parametric vector form of the solution set of $A\mathbf x=\mathbf0$ gives a basis for $\Nul A$. Note that $\dim\Nul A=$ the number of free variables.
// - A basis for $\Col A$ could be the set of pivot columns in $A$. Note that $\dim\Col A=$ the number of pivots.
// - A basis for $\Row A$ could be the set of non-zero row vectors in $U$ (Or any REF of $A$). Note that $\dim\Row A=$ the number of pivots.
//
// ]

// =={Rank and Nullity}

// #definition[
// $\dim\Nul A$ is also name the #text(fill:blue)[nullity]#index[nullity] of $A$. The number of pivots of $A$ (which is equal to both $\dim\Col A$ and $\dim\Row A$) is called the #text(fill:blue)[rank]#index[rank] of $A$
// ]

// #theorem[[Rank-Nullity theorem]\label{16:38-06/24/2022}
// Notice that the number of columns in $A$ (say a $m times  n$ matrix) is equal to the number of free variables and the number of pivot columns, thus we have
// \begin{center}
// $n=$ nullity + rank
// \end{center}
// ]

// #example[
// $A=mat(
// 1,-1,1;
// 2,0,-1;
// 1,1,-2
// )tilde mat(
// 1,-1,1;
// 0,2,-3;
// 0,0,0
// )tilde mat(
// 1,0,- 1 / 2 ;
// 0,1,- 3 / 2 ;
// 0,0,0
// )$, which is an REF and an RREF respectively. There is only one free variable $x_3$, so the nullity is 1, and the 1st, 2nd columns are pivot columns, so the rank is 2. We see that Theorem @(16:38-06/24/2022) holds as $3=1+2$, and
//  $
// \Nul A=\Span\left\{mat(
//  1 / 2 ; 3 / 2 ;1
// )\right\}
//  $
//  $
// \Col A=\Span\left\{mat(
// 1;2;1
// ),mat(
// -1;0;1
// )\right\}
//  $
//  $
// \Row A=\Span\left\{mat(
// 1,0,- 1 / 2
// ),mat(
// 0,1,- 3 / 2
// )\right\}\text{ or }\Span\left\{mat(
// 1,-1,1
// ),mat(
// 1,2,-3
// )\right\}
//  $
// )

// #exercise[
// $A=mat(
// 1,2,0,4,5;
// 0,0,5,-7,8;
// 0,0,0,0,-9;
// 0,0,0,0,0
// )tilde mat(
// 1,2,0,4,0;
// 0,0,1,- 7 / 5 ,0;
// 0,0,0,0,1;
// 0,0,0,0,0
// )$
// Note that here we have 2 free variables $x_2,x_4$, so the nullity is 2, and the 1st, 3rd, 5th columns are pivot columns, so the rank is 3. We see that Theorem @(16:38-06/24/2022) holds as $5=2+3$, and
//  $
// \Nul A=\Span\left\{mat(
// -2;1;0;0;0
// ),mat(
// -4;0; 7 / 5 ;1;
// )\right\}
//  $
//  $
// \Col A=\Span\left\{mat(
// 1;0;0;0
// ),mat(
// 0;5;0;0
// ),mat(
// 5;8;-9;0
// )\right\}
//  $
//  $
// \Row A=\Span\left\{mat(
// 1,2,0,4,5
// ),mat(
// 0,0,5,-7,8
// ),mat(
// 0,0,0,0,-9
// )\right\}
//  $
// ]

// #question[
// If you have a set $\mathcal S$ of vectors in $RR^m$, how do you find a subset of $\mathcal S$ that is a basis for $\Span\{\mathcal S\}$ (i.e. remove linear dependences)?
// ]

// #answer[
// Collect these vectors as the column vectors of a matrix, and then find its columns space.
// ]

// #exercise[
// Suppose $\mathbf v_1=mat(
// 1;2;1
// )$, $\mathbf v_2=mat(
// -1;0;1
// )$, $\mathbf v_3=mat(
// 1;-1;-2
// )$. Find a basis for $\Span\{\mathbf v_1, \mathbf v_2, \mathbf v_3\}$.
// ]

// #exercise[
// Suppose $A=mat(
// 1,-7,0,6,5;
// 0,0,1,-2,-3;
// -1,7,-4,2,7
// )$. Find $\Nul A,\Row A,\Col A$, and the nullity, rank of $A$.
// ]

// ={Lecture 11 - Linear transformations in general}

// =={Linear transformation}

// #definition[
// Suppose $V,W$ are vector spaces, a _linear transformation_ is a mapping $T:V-> W$ such that
//
// - $T(\bm u\fatplus\bm v)=T(\bm u)\fatplus T(\bm v)$
// - $T(c\fatdot u)=c\fatdot T(\bm u)$
//
// Just as before, we call $V$ the _domain_ of $T$, $W$ the _codomain_ of $T$, the _image_ of $\bm x$ under $T$ is $T(\bm x)$, the set of images $\{T(\bm x)|\bm x\in V\}$ the _range_ (denoted as $\Range T$), and the set $\{\bm x|T(\bm x)=\bm b\}$ the preimage of $\bm b$ under $T$. We still say that $T$ is _one-to-one_ if any $\bm b\in W$, there is at most one $\bm x\in V$ such that $T(\bm x)=\bm b$. $T$ is _onto_ the range is the codomain. $T$ is said to be _invertible_ if $T$ has a inverse (this happens if and only if $T$ is both one-to-one and onto, and we can easily check that $T^{-1}$ is also an linear transformation), in this case we also call $T$ an #text(fill:blue)[isomorphism]#index[isomorphism].
// ]

// #definition[
// We call $\{\bm x|T(\bm x)=\bm0\}$ the #text(fill:blue)[kernel]#index[kernel] (or #text(fill:blue)[null space]) of $T$, and denote it as $\ker T$.
// ]

// #remark[\label{14:24/06/30/2022}
// Suppose $T:RR^n->RR^m$, $T(\mathbf x)=A\mathbf x$ is a matrix transformation, then $\ker T=\Nul A$, $\Range T=\Col A$
// ]

// #example[
// The identification
//  $
// T:\mathbb P_2->RR^3,\qquad T(a_0+a_1t+a_2t^2)=mat(
// a_0;a_1;a_2
// )
//  $
// in Eaxmple @(17:45-06/27/2022) is an invertible linear transformation with inverse linear transformation
//  $
// T^{-1}:RR^3->\mathbb P_2,\qquad T^{-1}\left(mat(
// a_0;a_1;a_2
// )\right)=a_0+a_1t+a_2t^2
//  $
// )

// #example[
// The identification
//  $
// T:M_{2 times 2}(RR)->RR^4,\qquad
// T\left(mat(
// a,b;c,d
// )\right)=mat(
// a;b;c;d
// )
//  $
// in Eaxmple @(17:53-06/27/2022) is an invertible linear transformation with inverse linear transformation
//  $
// T^{-1}:RR^4-> M_{2 times 2}(RR),\qquad
// T^{-1}\left(mat(
// a;b;c;d
// )\right)=mat(
// a,b;c,d
// )
//  $
// )

// #theorem[\label{18:15-06/27/2022}
// Suppose $T:V-> W$ is a linear transformation between vector spaces, then
//
// - $\ker T$ is a subspace of $V$.
// - $\Range T$ is a subspace of $W$.
//
// ]

// \begin{proof}
//
//
// - Suppose $\bm u,\bm v\in\ker T$, then by definition $T(\bm u)=\bm0$, $T(\bm v)=\bm0$, so $T(\bm u\fatplus\bm v)=T(\bm u)\fatplus T(\bm v)=\bm0$. And for any $c\inRR$, $T(c\fatdot\bm u)=c\fatdot T(\bm u)=\bm0$. In other words, we have shown that $\bm u\fatplus\bm v, c\fatdot\bm u\in \ker T$, so $\ker T$ is a subspace.
// - For any $T(\bm u),T(\bm v)\in\Range T$, $T(\bm u)\fatplus T(\bm v)=T(\bm u\fatplus\bm v)\in\Range T$, and for any $c\inRR$, $c\fatdot T(\bm u)=T(c\fatdot\bm u)\in\Range T$, so $\Range T$ is a subspace
//
// \end{proof}

// #exercise[\label{17:52-06/29/2022}
// Suppose $T:\mathbb P_2->RR$ takes the sum of coefficients, i.e. $T(a_0+a_1t+a_2t^2)=a_0+a_1+a_2$. Show that $T$ is a linear transformation, and $H$ in Exercise @(ker T for T take sum of coef of poly) is a vector space.
// ]

// #solution[
// since for any $p(t)=a_0+a_1+a_2,q(t)=b_0+b_1t+b_2t^2\in\mathbb P_2$, $c\inRR$, we have
// \begin{align*}
// T(p+q),=T((a_0+b_0)+(a_1+b_1)t+(a_2+b_2)t^2)=(a_0+b_0)+(a_1+b_1)+(a_2+b_2);
// ,=(a_0+a_1+a_2)+(b_0+b_1+b_2)=T(p)+T(q)
// \end{align*}
//  $
// T(cp)=T((ca_0)+(ca_1)t+(ca_2)t^2)=(ca_0)+(ca_1)+(ca_2)=c(a_0+a_1+a_2)=cT(p)
//  $
// So $V=\ker T$ is a subspace of $V$ by Theorem @(18:15-06/27/2022)
// ]

// #exercise[
// Suppose $T:M_{2 times 2}(RR)->RR$ takes the sum of diagonal, i.e. $T\left(mat(
// a,b;c,d
// )\right)=a+d$. Show that $T$ is a linear transformation, and the set $H=\left\{mat(
// a,b;c,d
// )\middle|a+d=0\right\}$ of $2 times 2$ matrix with #text(fill:blue)[trace]#index[trace](sum of diagonal element) 0 is a vector space.
// ]

// =={Matrices of linear transformations}

// #question[
// Can we realize a general linear transformation $T$ as a matrix transformation?
// ]

// #answer[
// Just need to know its effect on any basis! Suppose $\mathbf v_1,\mathbf v_2,dots.h.c,\mathbf v_n$ is a basis of $RR^n$, then any vector $\mathbf v$ can be written as $c_1\mathbf v_1+c_2\mathbf v_2+dots.h.c+c_n\mathbf v_n$, and by linearality, we have
// $ \label{19:13-06/07/2022}
// T(\mathbf v)=T(c_1\mathbf v_1+c_2\mathbf v_2+dots.h.c+c_n\mathbf v_n)=c_1T(\mathbf v_1)+c_2T(\mathbf v_2)+dots.h.c+c_nT(\mathbf v_n)
// $
// ]

// #theorem[[Unique representation theorem]\label{12:53-06/28/2022}
// Suppose $\mathcal B=\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis of a vector sapce $V$, then any vector $\bm v\in V$ can be uniquely represented as a linear combination $x_1\fatdot\bm b_1\fatplusdots.h.c\fatplus x_n\fatdot\bm b_n$
// ]

// #remark[
// Here $[\bm v]_{\mathcal B}=mat(
// x_1;dots.v;x_n
// )$ is called the #text(fill:blue)[$\mathcal B$-coordinate vector]#index[coordinat vector] (or #text(fill:blue)[coordinate vector relative to the basis $\mathcal B$]) of $\bm v$
// ]

// \begin{proof}
// Suppose $\bm v=c_1\fatdot\bm b_1\fatplusdots.h.c\fatplus c_n\fatdot\bm b_n=d_1\fatdot\bm b_1\fatplusdots.h.c\fatplus d_n\fatdot\bm b_n$ are two linear combinations that express $\bm v$, then we have $(c_1-d_1)\fatdot\bm b_1\fatplusdots.h.c\fatplus(c_n-d_n)\fatdot\bm b_n=\bm0$, since $\{\bm b_1,dots.h.c,\bm b_n\}$ is linearly independent, we have $c_1=d_1,dots.h.c,c_n=d_n$. Therefore the expression is unique.
// \end{proof}

// #definition[
// We call $[\quad]_{\mathcal B}:V->RR^n$ the #text(fill:blue)[coordinate mapping]#index[coordinate mapping]
// ]

// #theorem[
// The coordinate mapping $[\quad]_{\mathcal B}:V->RR^n$ is an isomorphism
// ]

// #example[
// The identifications in Example @(17:45-06/27/2022) and Example @(17:53-06/27/2022) are coordinate mappings $[\quad]_{\mathcal E}:\mathbb P_2->RR^3$ with standard basis $\mathcal E=\{1,t,t^2\}$ and $[\quad]_{\mathcal E}:M_{2 times 2}(RR)->RR^4$ with standard basis $\mathcal E=\left\{mat(
// 1,0;0,0
// ),mat(
// 0,1;0,0
// ),mat(
// 0,0;1,0
// ),mat(
// 0,0;0,1
// )\right\}$, respectively
// )

// #example[
// $\mathcal B=\left\{bold(b)_1=mat(
// 1;0
// ), bold(b)_2=mat(
// 1;2
// )\right\}$ is a basis for $RR^2$, $\mathbf v=mat(
// 1;6
// )$. Solve linear system $\mathbf v=x_1bold(b)_1+x_2bold(b)_2=mat(
// bold(b)_1,bold(b)_2
// )mat(
// x_1;x_2
// )$ we get $[\mathbf v]_{\mathcal B}=mat(
// -2;3
// )$
// )

// #remark[
// $\mathbf x=[\mathbf x]_{\mathcal E}$ as $\mathbf x=x_1\mathbf e_1+dots.h.c+x_n\mathbf e_n$.
// ]

// % #exercise[

// % ]

// #question[
// How should we study linear transformations via matrices in general?
// ]

// Assume $T:V-> W$ is a linear transformation between vector spaces, $\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis for $V$ and $\{\bm c_1,dots.h.c,\bm c_m\}$ is a basis for $W$, then for any
// \begin{align*}
// \bm v=x_1\fatdot\bm b_1\fatplusdots.h.c\fatplus x_n\fatdot\bm b_n=mat(
// \bm b_1,dots.h.c,\bm b_n
// )mat(
// x_1;dots.v;x_n
// )=mat(
// \bm b_1,dots.h.c,\bm b_n
// )[\bm v]_{\mathcal B}
// \end{align*}
// We have
// \begin{align*}
// T(\bm v),=T(x_1\fatdot\bm b_1\fatplusdots.h.c\fatplus x_n\fatdot\bm b_n)=x_1\fatdot T(\bm b_1)\fatplusdots.h.c\fatplus x_n\fatdot T(\bm b_n)=x_1\fatdot T(\bm b_1)\fatplusdots.h.c\fatplus x_n\fatdot T(\bm b_n);
// ,=mat(
// T(\bm b_1),dots.h.c,T(\bm b_n)
// )mat(
// x_1;dots.v;x_n
// )=mat(
// T(\bm b_1),dots.h.c,T(\bm b_n)
// )[\bm v]_{\mathcal B}
// \end{align*}
// By Theorem @(12:53-06/28/2022), we can write
// \begin{align*}
// T(\bm b_1),=a_(11)\fatdot\bm c_1+a_(21)\fatdot\bm c_2+dots.h.c+a_(m 1)\fatdot\bm c_m;
// T(\bm b_2),=a_(12)\fatdot\bm c_1+a_(22)\fatdot\bm c_2+dots.h.c+a_(m 2)\fatdot\bm c_m;
// ,dots.v;
// T(\bm b_n),=a_(1 n)\fatdot\bm c_1+a_(2 n)\fatdot\bm c_2+dots.h.c+a_(m n)\fatdot\bm c_m
// \end{align*}
// Therefore we have
// $ \label{13:44-06/28/2022}
// mat(
// T(\bm b_1),dots.h.c,T(\bm b_n)
// )=mat(
// \bm c_1,dots.h.c,\bm c_m
// )mat(
// a_(11),a_(12),dots.h.c,a_(1 n);
// a_(21),a_(22),dots.h.c,a_(2 n);
// dots.v,dots.v,,dots.v;
// a_(m 1),a_(m 2),dots.h.c,a_(m n)
// )=mat(
// \bm c_1,dots.h.c,\bm c_m
// )A
// $
// Where
// $ \label{12:55-06/29/2022}
// A=mat(
// [T(\bm b_1))_{\mathcal C},dots.h.c,[T(\bm b_n)]_{\mathcal C}
// ]
// $
// is called the #text(fill:blue)[matrix of $T$ relative to bases $\mathcal B$ and $\mathcal C$], thus
//  $
// T(\bm v)=mat(
// \bm c_1,dots.h.c,\bm c_m
// )A[\bm v]_{\mathcal B}
//  $
// On the other hand, we should have
//  $ T(\bm v)=mat(
// \bm c_1,dots.h.c,\bm c_m
// )[T(\bm v)]_{\mathcal C} $
// So we may also conclude that
// $ \label{14:19-06/29/2022}
// [T(\bm v)]_{\mathcal C}=A[\bm v]_{\mathcal B}
// $
// The above discussion can be summerized by the following commutative diagram
// $ \label{16:03-06/29/2022}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{\mathcal B}}"'] , W \arrow[d, "{[\quad]_{\mathcal C}}"] ;
// RR^n \arrow[r, "A"]                            , RR^m
// \end{tikzcd}
// \quad
// \begin{tikzcd}
// \bm v \arrow[r, maps to] \arrow[d, maps to] , T(\bm v) \arrow[d, maps to]                     ;
// {[\bm v]_{\mathcal B}} \arrow[r, maps to]   , {A[\bm v]_{\mathcal B}=[T(\bm v)]_{\mathcal C}}
// \end{tikzcd}
// $

// #remark[
// The philosophy here is that any statement about a general linear transformation can be converted to a corresponding statement about matrix transformation.
// ]

// #example[
// Suppose $V=RR^n$, $W=RR^m$ with bases $\{\mathbf e_1,dots.h.c,\mathbf e_n\}$, $\{\mathbf e_1,dots.h.c,\mathbf e_m\}$, then \eqref{13:44-06/28/2022} reads $A=mat(
// T(\mathbf e_1),dots.h.c,T(\mathbf e_n)
// )$ is the standard matrix
// )

// #example[
// Consider linear transformation
//  $
// T:\mathbb P_2->RR^3,\qquad T(a_0+a_1t+a_2t^2)=mat(
// a_0;a_1;a_2
// )
//  $
// and $\mathcal B=\{1+t,t+t^2,1+t^2\}$ is a basis for $\mathbb P_2$, $\mathcal E$ is the standard basis for $RR^3$, then matrix of $T$ relative to bases $\mathcal B$ and $\mathcal E$ can be read from \eqref{12:55-06/29/2022} as
//  $
// A=mat(
// T(1+t),T(t+t^2),T(1+t^2)
// )=mat(
// 1,0,1;
// 1,1,0;
// 0,1,1
// )
//  $
// )

// #example[
// Consider linear transformation $T:RR^2->RR^2$ is defined by $T\left(mat(
// x_1;x_2
// )\right)=mat(
// x_1+2x_2;x_2
// )$, $\mathcal B=\left\{mat(
// 1;1
// ), mat(
// 1;-1
// )\right\}$, $\mathcal C=\left\{mat(
// -1;1
// ), mat(
// -1;-1
// )\right\}$ are bases for $RR^2$. Then the matrix of $T$ relative to bases $\mathcal B$ and $\mathcal C$ can be read from~\eqref{13:44-06/28/2022}
// \begin{align*}
// mat(
// -1,-1;1,-1
// )A=mat(
// 3,-1;1,-1
// ), =>  A=mat(
// -1,-1;1,-1
// )^{-1}mat(
// 3,-1;1,-1
// )=mat(
// -1,0;-2,1
// )
// \end{align*}
// )

// #exercise[

// ]

// #remark[\label{17:02-06/29/2022}
// Suppose $T:V-> W$ and $S:W-> U$ are linear transformations between vector spaces, $\mathcal B=\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis for $V$, $\mathcal C=\{\bm c_1,dots.h.c,\bm c_n\}$ is a basis for $W$ and $\mathcal D=\{\bm d_1,dots.h.c,\bm d_n\}$ is a basis for $U$, then the matrix of $S\circ T$ relative to bases $\mathcal B$, $\mathcal D$ is $BA$.
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{\mathcal B}}"'] \arrow[rr, "S\circ T", bend left, shift left=2] , W \arrow[d, "{[\quad]_{\mathcal C}}"] \arrow[r, "S"] , U \arrow[d, "{[\quad]_{\mathcal D}}"] ;
// RR^n \arrow[r, "A"] \arrow[rr, "BA", bend right, shift right=2]                                , RR^m \arrow[r, "B"]                           , RR^p
// \end{tikzcd}
// \quad
// \begin{tikzcd}
// \bm v \arrow[r, maps to] \arrow[d, maps to] , T(\bm v) \arrow[d, maps to] \arrow[r]                              , S(T(\bm v))=(S\circ T)(\bm v) \arrow[d, maps to]    ;
// {[\bm v]_{\mathcal B}} \arrow[r, maps to]   , {A[\bm v]_{\mathcal B}=[T(\bm v)]_{\mathcal C}} \arrow[r, maps to] , {BA[\bm v]_{\mathcal B}=[S(T(\bm v))]_{\mathcal D}}
// \end{tikzcd}
// \end{center}
// If $T$  is invertible, then the matrix of $T^{-1}$ relative to bases $\mathcal C$, $\mathcal B$ is $A^{-1}$
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{\mathcal B}}"'] , W \arrow[d, "{[\quad]_{\mathcal C}}"] \arrow[l, "T_{-1}", bend left] ;
// RR^n \arrow[r, "A"]                            , RR^m \arrow[l, "A^{-1}", bend left]
// \end{tikzcd}
// \end{center}
// ]

// #exercise[
// Suppose $T:\mathbb P_2->RR_3$ is evaluation at $2$, i.e. $T(p(t))=p(2)$ for $p(t)\in\mathbb P_2$. Show that $T$ is a linear transformation. Is $T$ onto? Is $T$ one-to-one? Is $T$ invertible? Find a basis for $\ker T$. Find a basis for $\Range T$.
// ]

// #exercise[
// Suppose $H$ is the set of 2 by 2 matrices that are symmetric with the sum of diagonal being zero. Show $H$ is a vector space. Find a basis of $H$.
// ]

// =={Change of basis}

// Now let's talk about change of basis. Suppose $V$ is a vector space with two basis $\mathcal B=\{\bm b_1,dots.h.c,\bm b_n\}$ and $\mathcal C=\{\bm c_1,dots.h.c,\bm c_n\}$, and $\id_V:V-> V$, $\id_V(\bm v)=\bm v$ is the #text(fill:blue)[identity mapping]#index[identity mapping]. Diagram~\eqref{16:03-06/29/2022} becomes
// $ \label{19:43-06/29/2022}
// \begin{tikzcd}
// V \arrow[r, "\id_V", equal] \arrow[d, "{[\quad]_{\mathcal B}}"']             , V \arrow[d, "{[\quad]_{\mathcal C}}"] ;
// RR^n \arrow[r, "\underset{\mathcal C\leftarrow\mathcal B}{P}"] , RR^n
// \end{tikzcd}
// $
// Where equation~\eqref{12:55-06/29/2022} and equation~\eqref{14:19-06/29/2022} become
//  $
// \underset{\mathcal C\leftarrow\mathcal B}{P}=mat(
// [\bm b_1)_{\mathcal C},dots.h.c,[\bm b_n]_{\mathcal C}
// ]
//  $
//  $
// [\bm v]_{\mathcal C}=\underset{\mathcal C\leftarrow\mathcal B}{P}[\bm v]_{\mathcal B}
//  $
// which is the matrix of $\id_V$ relative to basis $\mathcal B$ and $\mathcal C$, and we call this the #text(fill:blue)[change of coordinates matrix from $\mathcal B$ to $\mathcal C$]. Also remark @(17:02-06/29/2022) gives us
//  $
// \underset{\mathcal D\leftarrow\mathcal B}{P}=\left(\underset{\mathcal D\leftarrow\mathcal C}{P}\right)\left(\underset{\mathcal C\leftarrow\mathcal B}{P}\right),\quad \left(\underset{\mathcal C\leftarrow\mathcal B}{P}\right)^{-1}=\underset{\mathcal B\leftarrow\mathcal C}{P}
//  $

// #example[
// Continue Example @(17:08-06/29/2022), we have shown that $\mathcal B=\left\{mat(
// 1,0;0,0
// ),mat(
// 0,1;1,0
// ),mat(
// 0,0;0,1
// )\right\}=\left\{B_1,B_2,B_3\right\}$ is a basis for $V$. Let's show that $\mathcal C=\left\{mat(
// 1,1;1,0
// ),mat(
// 1,0;0,1
// ),mat(
// 0,1;1,1
// )\right\}=\left\{C_1,C_2,C_3\right\}$ is another basis for $V$. First note that
//  $
// C_1=mat(
// 1,1;1,0
// )=mat(
// 1,0;0,0
// )+mat(
// 0,1;1,0
// )=B_1+B_2
//  $
//  $
// C_2=mat(
// 1,0;0,1
// )=mat(
// 1,0;0,0
// )+mat(
// 0,0;0,1
// )=B_1+B_3
//  $
//  $
// C_3=mat(
// 0,1;1,1
// )=mat(
// 0,1;1,0
// )+mat(
// 0,0;0,1
// )=B_2+B_3
//  $
// So $\{[C_1]_{\mathcal B},[C_2]_{\mathcal B},[C_3]_{\mathcal B}\}=\left\{mat(
// 1;1;0
// ),mat(
// 1;0;1
// ),mat(
// 0;1;1
// )\right\}$, and it is easy to show that this is a basis for $RR^3$, hence $\mathcal C$ is a basis for $V$. Also we know that
//  $
// \underset{\mathcal B\leftarrow\mathcal C}{P}=mat(
// [C_1)_{\mathcal B},[C_2]_{\mathcal B},[C_3]_{\mathcal B}
// ]=mat(
// 1,1,0;
// 1,0,1;
// 0,1,1
// )
//  $
// And
//  $
// \underset{\mathcal C\leftarrow\mathcal B}{P}=\left(\underset{\mathcal B\leftarrow\mathcal C}{P}\right)^{-1}=mat(
//  1 / 2 , 1 / 2 ,- 1 / 2 ;
//  1 / 2 ,- 1 / 2 , 1 / 2 ;
// - 1 / 2 , 1 / 2 , 1 / 2
// )
//  $
// Note that here the diagram~\eqref{19:43-06/29/2022} becomes
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "\id_V", equal] \arrow[d, "{[\quad]_{\mathcal B}}"']             , V \arrow[d, "{[\quad]_{\mathcal C}}"] ;
// RR^3 \arrow[r, "\underset{\mathcal C\leftarrow\mathcal B}{P}"] , RR^3
// \end{tikzcd}
// \end{center}
// )

// #example[\label{10:24-07/01/2022}
// Continue Example @(17:52-06/29/2022), let's find a basis for $V=\ker T$ which is supposed to correspond to $\Nul A$, where $A$ is the matrix relative to both standard bases $\mathcal E=\{1,t,t^2\}$ for $\mathbb P_2$ and $\mathcal E=\left\{\mathbf e_1=mat(
// 1;0;0
// ),\mathbf e_2=mat(
// 0;1;0
// ),\mathbf e_3=mat(
// 0;0;1
// )\right\}$ which can be read from~\eqref{14:19-06/29/2022}
//  $
// A=mat(
// [T(1))_{\mathcal E},[T(t)]_{\mathcal E},[T(t^2)]_{\mathcal E}
// ]=mat(
// 1,1,1
// )
//  $
// So we get
//  $
// \Nul A=\Span\left\{mat(
// -1;1;0
// ),mat(
// -1;0;1
// )\right\}
//  $
// Which gives a basis $\{-1+t,-1+t^2\}$ for $V$. Note that here the diagram~\eqref{16:03-06/29/2022} becomes
// \begin{center}
// \begin{tikzcd}
// \mathbb P_2 \arrow[r, "T"] \arrow[d, "{[\quad]_{\mathcal E}}"'] , RR \arrow[d, equal, "{[\quad]_{\mathcal E}}"] ;
// RR^3 \arrow[r, "A"]                            , RR
// \end{tikzcd}
// \end{center}
// )

// An algorithm for computing $A^{-1}B$
//  $
// \left[\begin{array}{c|c}
// A,B
// \end{array}\right]tilde \left[\begin{array}{c|c}
// I,A^{-1}B
// \end{array}\right]
//  $

// #exercise[
// Suppose $\mathcal B=\{2t^2-1,3t+1-t^2,3-t\}$ and $\mathcal C=\{1+t,t^2,-t\}$ are both bases for $\mathbb P_2$. Please find the change of basis matrix form $\mathcal B$ to $\mathcal C$
// ]

// #solution[
// First let's find the change of basis matrices from $\mathcal B$ and $\mathcal C$ to the standard basis $\mathcal E=\{1,t,t^2\}$. We have
//  $
// \underset{\mathcal E\leftarrow\mathcal B}{P}=mat(
// [-1+2t^2)_{\mathcal E},[1+3t-t^2]_{\mathcal E},[3-t]_{\mathcal E}
// ]=mat(
// -1,1,3;
// 0,3,-1;
// 2,-1,0
// )
//  $
// And
//  $
// \underset{\mathcal E\leftarrow\mathcal C}{P}=mat(
// [1-t)_{\mathcal E},[t]_{\mathcal E},[t^2]_{\mathcal E}
// ]=mat(
// 1,0,0;
// 1,0,-1;
// 0,1,0
// )
//  $
// Hence we have
// \begin{align*}
// \underset{\mathcal C\leftarrow\mathcal B}{P}=\left(\underset{\mathcal C\leftarrow\mathcal E}{P}\right)\left(\underset{\mathcal E\leftarrow\mathcal B}{P}\right)=\left(\underset{\mathcal E\leftarrow\mathcal C}{P}\right)^{-1}\left(\underset{\mathcal E\leftarrow\mathcal B}{P}\right)
// \end{align*}
// Which can computed via the above algorithm
// \begin{align*}
// \left[\begin{array}{ccc|ccc}
// 1,0,0,-1,1,3;
// 1,0,-1,0,3,-1;
// 0,1,0,2,-1,0
// \end{array}\right]tilde \left[\begin{array}{ccc|ccc}
// 1,0,0,-1,1,3;
// 0,1,0,2,-1,0;
// 0,0,1,-1,-2,4
// \end{array}\right]
// \end{align*}
// \begin{center}
// \begin{tikzcd}
// \mathbb P_2 \arrow[r,equal, "\id_V"] \arrow[d, "{[\quad]_{\mathcal B}}"']                                                                                             , \mathbb P_2 \arrow[d, "{[\quad]_{\mathcal E}}"'] \arrow[r,equal, "\id_V"]               , \mathbb P_2 \arrow[d, "{[\quad]_{\mathcal C}}"]                       ;
// RR^3 \arrow[r, "\underset{\mathcal E\leftarrow\mathcal B}{P}"'] \arrow[rr, "\underset{\mathcal C\leftarrow\mathcal B}{P}", bend right=49, shift right=1] , RR^3 \arrow[r, "\underset{\mathcal C\leftarrow\mathcal E}{P}", bend left] , RR^3 \arrow[l, "\underset{\mathcal E\leftarrow\mathcal C}{P}"]
// \end{tikzcd}
// \end{center}
// ]

// #example[
// Suppose $RR^2$ has bases $\mathcal B=\left\{bold(b)_1=mat(
// 7;5
// ),bold(b)_2=mat(
// -3;-1
// )\right\}$, $\mathcal C=\left\{\mathbf c_1=mat(
// 1;-5
// ),\mathbf c_2=mat(
// -2;2
// )\right\}$. $\underset{\mathcal C\leftarrow\mathcal B}{P}=\left(\underset{\mathcal E\leftarrow\mathcal C}{P}\right)^{-1}\left(\underset{\mathcal E\leftarrow\mathcal B}{P}\right)$, which can be computed via
//  $
// \left[\begin{array}{cc|cc}
// 1,-2,7,-3;
// -5,2,5,-1
// \end{array}\right]tilde \left[\begin{array}{cc|cc}
// 1,0,-3,1;
// 0,1,-5,2
// \end{array}\right]
//  $
// So $\underset{\mathcal C\leftarrow\mathcal B}{P}=mat(
// -3,1;
// -5,2
// )$
// \begin{center}
// \begin{tikzcd}
// RR^2 \arrow[r,equal] \arrow[d, "{[\quad]_{\mathcal B}}"']                                                                                           , RR^2 \arrow[d, "{[\quad]_{\mathcal E}}"'] \arrow[r,equal]               , RR^2 \arrow[d, "{[\quad]_{\mathcal C}}"]                       ;
// RR^2 \arrow[r,"\underset{\mathcal E\leftarrow\mathcal B}{P}"'] \arrow[rr, "\underset{\mathcal C\leftarrow\mathcal B}{P}", bend right=49, shift right] , RR^2 \arrow[r, "\underset{\mathcal C\leftarrow\mathcal E}{P}", bend left] , RR^2 \arrow[l, "\underset{\mathcal E\leftarrow\mathcal C}{P}"]
// \end{tikzcd}
// \end{center}
// )

// #theorem[
// Let's generalize the rank-nullity theorem @(16:38-06/24/2022), with the remark @(14:24/06/30/2022), we have
//  $
// \dim V=\dim\Range T+\dim\ker T
//  $
// ]

// #definition[
// Suppose $T:V-> V$ is a linear transformation, and $\mathcal B=\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis for $V$, we can the matrix relative to $\mathcal B$ and $\mathcal B$ the #text(fill:blue)[$\mathcal B$-matrix of $T$]#index[$\mathcal B$-matrix] (denoted $[T]_{\mathcal B}$), i.e. \eqref{16:03-06/29/2022} becomes
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{\mathcal B}}"'] , V \arrow[d, "{[\quad]_{\mathcal B}}"] ;
// RR^n \arrow[r, "{[T]_{\mathcal B}}"]           , RR^n
// \end{tikzcd}
// \quad
// \begin{tikzcd}
// \bm v \arrow[r, maps to] \arrow[d, maps to] , T(\bm v) \arrow[d, maps to]                     ;
// {[\bm v]_{\mathcal B}} \arrow[r, maps to]   , {[T]_{\mathcal B}[\bm v]_{\mathcal B}=[T(\bm v)]_{\mathcal B}}
// \end{tikzcd}
// \end{center}
// And \eqref{12:55-06/29/2022} gives $[T]_{\mathcal B}=mat(
// [T(\bm b_1))_{\mathcal B},dots.h.c,[T(\bm b_n)]_{\mathcal B}
// ]$
// Suppose both $\mathcal B=\{\bm b_1,dots.h.c,\bm b_n\}$ and $\mathcal C=\{\bm c_1,dots.h.c,\bm c_n\}$ form bases for $V$, then
//  $
// [T]_{\mathcal B}=\underset{\mathcal B\leftarrow\mathcal C}{P}[T]_{\mathcal C}\underset{\mathcal C\leftarrow\mathcal B}{P}=\underset{\mathcal B\leftarrow\mathcal C}{P}[T]_{\mathcal C}\left(\underset{\mathcal B\leftarrow\mathcal C}{P}\right)^{-1}
//  $
// is similar via
// \begin{center}
// \begin{tikzcd}
// V \arrow[rrr, "T"] \arrow[rd, "{[\quad]_{\mathcal B}}"] \arrow[ddd, "\id"'] , , , V \arrow[ld, "{[\quad]_{\mathcal B}}"'] \arrow[ddd, "\id"] ;
// , RR^n \arrow[r, "{[T]_{\mathcal B}}"] , RR^n \arrow[d, "\underset{\mathcal C\leftarrow\mathcal B}{P}"'] , ;
// , RR^n \arrow[r, "{[T]_{\mathcal C}}"] \arrow[u, "\underset{\mathcal B\leftarrow\mathcal C}{P}"'] , RR^n , ;
// V \arrow[ru, "{[\quad]_{\mathcal C}}"'] \arrow[rrr, "T"'] , , , V \arrow[lu, "{[\quad]_{\mathcal C}}"]
// \end{tikzcd}
// \end{center}
// If $T:RR^n->RR^n$, $T(\mathbf x)=A\mathbf x$ is a matrix transformation, $\mathcal E$ is the standard basis, and $\mathcal C=\{\mathbf v_1,dots.h.c,\mathbf v_n\}$ is basis consists of eigenvectors, then $[T]_{\mathcal C}=D$ is diagonal with eigenvalues, as shown in Theorem @(09:52-07/07/2022).
// ]

// #remark[
// In fact, any two similar matrix can be realized as matrices of the same linear transformation in different basis.
// ]

// ={Lecture 12 - Eigendecomposition}

// =={Eigenvalues, eigenvectors and eigenspaces}

// #definition[
// Suppose $A$ is a square $n times  n$ matrix. A #text(fill:blue)[$\lambda$-eigenvector]#index[eigenvector] of an $n times  n$ matrix $A$ is a nonzero vector $\mathbf x$ such that $A\mathbf x = \lambda\mathbf x$ for some scalar $\lambda$. A scalar $\lambda$ is called an #text(fill:blue)[eigenvalue]#index[eigenvalue] of $A$ has $\lambda$-eigenvectors.
// ]

// #definition[
// We say that a vector space $V$ is #text(fill:blue)[trivial]#index[trivial vector space] if $V=\{0\}$ is the zero vector space.
// ]

// #question[
// How to decide whether a nonzero vector $\mathbf x$ is an eigenvector?
// ]

// #answer[
// We can evaluate $A\mathbf x$ and see if it is a multiple of $\mathbf x$
// ]

// #example[
// $A=mat(
// 1,6;5,2
// )$, determine whether $\mathbf u=mat(
// 6;-5
// )$, $\mathbf v=mat(
// 3;-2
// )$ are eigenvectors of $A$.
//  $
// A\mathbf u=mat(
// 1,6;5,2
// )mat(
// 6;-5
// )=mat(
// -24;20
// )=(-4)\mathbf u
//  $
// Hence $\mathbf u$ is a $(-4)$-eigenvector of $A$.
//  $
// A\mathbf v=mat(
// 1,6;5,2
// )mat(
// 3;-2
// )=mat(
// -9;11
// )
//  $
// Which is not a multiple of $\mathbf v$, so $\mathbf v$ is not an eigenvector.
// )

// #question[
// How to decide if $\lambda$ is an eigenvalue of $A$?
// ]

// #answer[
// By definition, we know that $\lambda$ is an eigenvalue of $A<=> A\mathbf x=\lambda\mathbf x$ has a nontrivial solution $<=> \lambda\mathbf x-A\mathbf x=\lambda I\mathbf x-A\mathbf x=(\lambda I-A)\mathbf x=\mathbf 0$ has a nontrivial solution $<=>\Nul(\lambda I-A)$ is nontrivial $<=> \lambda I-A$ is invertible $<=>\det(\lambda I-A)=0$
// ]

// #example[\label{12:54-07/01/2022}
// $A=mat(
// 4,-1,6;
// 2,1,6;
// 2,-1,8
// )$. Determine whether $\lambda=2$ is an eigenvalue of $A$
//  $
// \det(2I-A)=\det\left(2mat(
// 1,0,0;
// 0,1,0;
// 0,0,1
// )-mat(
// 4,-1,6;
// 2,1,6;
// 2,-1,8
// )\right)=\left|\begin{matrix}
// 2,-1,-6;
// 2,-1,-6;
// 2,-1,-6
// \end{matrix}\right|=0
//  $
// )

// #definition[
// From above criterion, we see that the set of $\lambda$-vectors is $\Nul(\lambda I-A)$ which is a subspace of $RR^n$, we call this the #text(fill:blue)[$\lambda$-eigenspace]#index[eigenspace].
// ]

// #example[
// Continue Example @(12:54-07/01/2022). Let's find a basis for the $2$-eigenspace of $A$, which is equivalent of finding a basis for $\Nul(2I-A)$, since $\left[\begin{array}{c|c}
// 2I-A,\mathbf 0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,- 1 / 2 ,3,0;
// 0,0,0,0;
// 0,0,0,0
// \end{array}\right]$
// Hence a basis could be $\left\{mat(
//  1 / 2 ;1;0
// ),mat(
// -3;0;1
// )\right\}$
// )

// =={Characteristic polynomials}

// #question[
// How could we find all the eigenvalues of $A$?
// ]

// #definition[
// From above discussion, we see that $\lambda$ is an eigenvalue of $A<=>\det(\lambda I-A)=0$, this motivates the following definition. We call $\det(tI-A)$ the #text(fill:blue)[characteristic polynomial]#index[characteristic polynomial] of $A$, and $\det(tI-A)=0$ the #text(fill:blue)[characteristic equation]#index[characteristic equation]. And the roots of the characteristic polynomial are the eigenvalues of $A$.
// ]

// #definition[
// We call the dimension of the $\lambda$-eigenspace ($\dim\Nul(\lambda I-A)$) the #text(fill:blue)[geometric multiplicity]#index[geometric multiplicity] of $\lambda$, and the multiplicity of $\lambda$ as a root in the charateristic polynomial $\det(tI-A)$ the #text(fill:blue)[algebraic multiplicity]#index[algebraic multiplicity] of $\lambda$.
// ]

// #example[
// Suppose $A=mat(
// 1,-4;4,2
// )$, then the characteristic polynomial of $A$ would be
//  $
// \det(tI-A)=\det\left(tmat(
// 1,0;0,1
// )-mat(
// 1,-4;4,2
// )\right)=\left|\begin{matrix}
// t-1,4;-4,t-2
// \end{matrix}\right|=(t-1)(t-2)-4 dot.c (-4)=t^2-3t+18
//  $
// And the characteristic equation is $t^2-3t+18=0$. Since $\Delta=(-3)^2-4 dot.c 1 dot.c 18=-63<0$, this equation has no (real) solutions, $A$ doesn't have (real) eigenvalues
// )

// \begin{note}
// Recall that the quadratic equation $ax^2+bx+c=0$ has no (real) solutions $<=>$ the discriminant $\Delta=b^2-4ac<0$.
// \end{note}

// #example[
// Suppose $A=mat(
// 3,-2;2,-1
// )$, then the characteristic polynomial of $A$ would be
//  $
// \det(tI-A)=\det\left(tmat(
// 1,0;0,1
// )-mat(
// 3,-2;2,-1
// )\right)=\left|\begin{matrix}
// t-3,2;-2,t+1
// \end{matrix}\right|=(t-3)(t+1)-2 dot.c (-2)=t^2-2t+1
//  $
// And the characteristic equation is $t^2-2t+1=(t-1)^2=0$. Hence the eigenvalues of $A$ is $2$ with algebraic multiplicity 2
// )

// #example[
// Suppose $A=mat(
// 3,-2,3;0,-1,0;6,7,-4
// )$, then the characteristic polynomial of $A$ would be
// \begin{align*}
// \det(tI-A),=\left|\begin{matrix}
// t-3,2,-3;
// 0,t+1,0;
// -6,-7,t+4
// \end{matrix}\right|\xequal{\text{cofactor expansion across the 2nd row}}(t+1)(-1)^{2+2}\left|\begin{matrix}
// t-3,-3;
// -6,t+4
// \end{matrix}\right|;
// ,=(t+1)((t-3)(t+4)-(-3) dot.c (-6))=(t+1)(t^2+t-30)=(t+1)(t+6)(t-5)
// \end{align*}
// So we see that the eigenvalues of $A$ are $-1, -6, -5$, all with algebraic multiplicities 1,1,1.
// )

// #example[
// Suppose $A=mat(
// 0,1,1;
// 1,0,1;
// 1,1,0
// )$, then characteristic polynomial is
// \begin{align*}
// \det(tI-A),=\left|\begin{matrix}
// t,-1,1;
// -1,t,-1;
// -1,-1,t
// \end{matrix}\right|\xequal{ #`R2`-> #`R1`+t dot.c  #`R2` \ #`R2`-> #`R2`-#`R3` }\left|\begin{matrix}
// 0,-1-t,1+t^2;
// 0,t+1,-1-t;
// -1,-1,t
// \end{matrix}\right|;
// ,\xequal{\text{cofactor expansion across the 1st column}}(-1)(-1)^{3+1}\left|\begin{matrix}
// -1-t,1+t^2;
// t+1,-1-t;
// \end{matrix}\right|;
// ,=(-1)((-1-t)^2-(1+t^2)(t+1))=(-1)(t-t^3)=t(t+1)(t-1)
// \end{align*}
// Thus the eigenvalues are $0,1,-1$, with algebraic multiplicities $1,1,1$.
// )

// #example[
// Suppose
//  $
// A=mat(
// \lambda_1,*,dots.h.c,*;
// 0,\lambda_2,dots.h.c,*;
// dots.v,dots.v,dots.down,dots.v;
// 0,0,dots.h.c,\lambda_n
// )
//  $
// is an $n times  n$ triangular matrix, then the characteristic polynomial of $A$ is
//  $
// \det(tI-A)=\left|\begin{matrix}
// t-\lambda_1,*,dots.h.c,*;
// 0,t-\lambda_2,dots.h.c,*;
// dots.v,dots.v,dots.down,dots.v;
// 0,0,dots.h.c,t-\lambda_n
// \end{matrix}\right|=(t-\lambda_1)(t-\lambda_2)dots.h.c(t-\lambda_n)
//  $
// so the eigenvalues are the diagonal elements $\lambda_1,\lambda_2,dots.h.c,\lambda_n$. Note that $\lambda_i$'s might not be distinct, so there might be some multiplicities.
// )

// #example[
// Suppose $A=mat(
// 1,2,0,-1;
// 0,2,1,3;
// 0,0,3,4;
// 0,0,0,1
// )$, then the characteristic polynomial is
//  $
// \det(tI-A)=\left|\begin{matrix}
// t-1,-2,0,1;
// 0,t-2,-1,-3;
// 0,0,t-3,-4;
// 0,0,0,t-1
// \end{matrix}\right|=(t-1)^2(t-2)(t-3)
//  $
// And the eigenvalues are $1,2,3$, with multiplicities $2,1,1$ respectively.
// )

// =={Similarity}

// #definition[
// $A$ and $B$ are said to be #text(fill:blue)[similar]#index[similar] if there exists an invertible matrix $P$ such that $A=PBP^{-1}$. Note that this definition is _symmetric_ in the sense that we also have $B=P^{-1}AP=(P^{-1})A(P^{-1})^{-1}$. Similarity is _transitive_ in the sense that if $A,B$ are similar, $B,C$ are similar, then so do $A,C$. The reason is that suppose $A=PBP^{-1}$, $B=RCR^{-1}$, we would have $A=PBP^{-1}=PRCR^{-1}P^{-1}=(PR)C(PR)^{-1}$.
// ]

// #definition[
// We can the mapping $A\mapsto PAP^{-1}$ a #text(fill:blue)[similar transformation]#index[similar transformation]
// ]

// #theorem[\label{10:10-07/07/2022}
// Similar matrices have the same
//
// - determinant
// - characteristic polynomial
//
// ]

// \begin{proof}
// Suppose $A,B$ are similar, $A=PBP^{-1}$, then
//
// - $\det(A)=\det(PBP^{-1})=\det(P)\det(B)\det(P^{-1})=\det(P)\det(B)\det(P)^{-1}=\det(B)$
// - Note that $tI-A=tPIP^{-1}-PBP^{-1}=P(tI-A)P^{-1}$, so $tI-A$ and $tI-B$ are similar, so they have the same determinant which is the characteristic polynomial.
//
// \end{proof}

// =={Eigendecomposition and diagonalization}

// #theorem[[diagonalization theorem]\label{09:52-07/07/2022}
// Suppose $\mathbf v_1,dots.h.c,\mathbf v_n$ are eigenvectors of $A$ with eigenvalues $\lambda_1,dots.h.c,\lambda_n$, then we have
// \begin{align*}
// Amat(
// \mathbf v_1, dots.h.c, \mathbf v_n
// ),=mat(
// A\mathbf v_1, dots.h.c,A \mathbf v_n
// )=mat(
// \lambda_1\mathbf v_1, dots.h.c,\lambda_n\mathbf v_n
// )=mat(
// \mathbf v_1, dots.h.c, \mathbf v_n
// )mat(
// \lambda_1,dots.h.c,0;
// dots.v,dots.down,dots.v;
// 0,dots.h.c,\lambda_n
// )
// \end{align*}
// Therefore we get a #text(fill:blue)[diagonalization]#index[diagonalization] of $A$, which reads $A=PDP^{-1}$, where $P=mat(
// \mathbf v_1, dots.h.c, \mathbf v_n
// )$ and $D=mat(
// \lambda_1,dots.h.c,0;
// dots.v,dots.down,dots.v;
// 0,dots.h.c,\lambda_n
// )$
// ]

// #theorem[\label{17:43-07/06/2022}
// If $\mathbf v_1,dots.h.c,\mathbf v_r$ are eigenvectors that correspond to distinct eigenvalues $\lambda_1,dots.h.c,\lambda_r$ of an $n times  n$ matrix $A$, then the set $\{\mathbf v_1,dots.h.c,\mathbf v_r\}$ is linearly independent.
// ]

// \begin{proof}
// Suppose $\{\mathbf v_1,dots.h.c,\mathbf v_n\}$ is linearly independent, up to reordering the indices, we may assume $\mathbf v_r=c_1\mathbf v_1+dots.h.c+c_{r-1}\mathbf v_{r-1}$
// \end{proof}

// #exercise[
// Diagonalize $A = mat(
// 1,3,3;
// -3,-5,-3;
// 3,3,1
// )$
// ]

// #solution[
// First we want to find all eigenvalues of $A$
// \begin{align*}
// \det(tI-A),=\left|\begin{matrix}
// t-1,-3,-3;
// 3,t+5,3;
// -3,-3,t-1
// \end{matrix}\right|\xequal{#`R3`-> #`R3`+#`R2`}\left|\begin{matrix}
// t-1,-3,-3;
// 3,t+5,3;
// 0,t+2,t+2
// \end{matrix}\right|;
// ,\xequal{\text{factor out $(t+2)$ from row 3}}(t+2)\left|\begin{matrix}
// t-1,-3,-3;
// 3,t+5,3;
// 0,1,1
// \end{matrix}\right|;
// ,\xequal{ #`R1`-> #`R1`+3#`R3` \ #`R2`-> #`R2`-3#`R3` }(t+2)\left|\begin{matrix}
// t-1,0,0;
// 3,t+2,0;
// 0,1,1
// \end{matrix}\right|=(t+2)(t-1)(t+2)(1)=(t+2)^2(t-1)
// \end{align*}
// So the eigenvalues of $A$ are $\lambda_1=1$ with algebraic multiplicity 1 and $\lambda_2=\lambda_3=-2$ which is of algebraic multiplicity 2. For a basis of the 1-eigenspace $\Nul(I-A)$, consider
// \begin{align*}
// \left[\begin{array}{c|c}
// I-A,\mathbf0
// \end{array}\right],=\left[\begin{array}{ccc|c}
// 0,-3,-3,0;
// 3,6,3,0;
// -3,-3,0,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,0,-1,0;
// 0,1,1,0;
// 0,0,0,0;
// \end{array}\right]
// \end{align*}
// So it could be $\left\{\mathbf v_1=mat(
// 1;-1;0
// )\right\}$
// For a basis of the $(-2)$-eigenspace $\Nul(-2I-A)$, consider
// \begin{align*}
// \left[\begin{array}{c|c}
// -2I-A,\mathbf0
// \end{array}\right],=\left[\begin{array}{ccc|c}
// -3,-3,-3,0;
// 3,3,3,0;
// -3,-3,-3,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,1,1,0;
// 0,0,0,0;
// 0,0,0,0;
// \end{array}\right]
// \end{align*}
// So it could be $\left\{\mathbf v_2=mat(
// -1;1;0
// ),\mathbf v_3=mat(
// -1;0;1
// )\right\}$. By Theorem @(17:43-07/06/2022), we know that $\{\mathbf v_1,\mathbf v_2,\mathbf v_3\}$ are linearly independent, thus forming a basis for $RR^3$. And we have a diagonalization
//  $
// A=PDP^{-1},\quad P=mat(
// \mathbf v_1,\mathbf v_2,\mathbf v_3
// )=mat(
// 1,-1,-1;
// -1,1,0;
// 0,0,1;
// ),\quad D=mat(
// \lambda_1,0,0;
// 0,\lambda_2,0;
// 0,0,\lambda_3
// )=mat(
// 1,0,0;
// 0,-2,0;
// 0,0,-2
// )
//  $
// ]

// #example[\label{09:29-07/07/2022}
// $A = mat(
// 2,4,3;
// -4,-6,-3;
// 3,3,1
// )$, the characteristic polynomial of $A$ is
// \begin{align*}
// \det(tI-A),=\left|\begin{matrix}
// t-2,-4,-3;
// 4,t+6,3;
// -3,-3,t-1
// \end{matrix}\right|\xequal{#`R1`-> #`R1`+#`R2`}\left|\begin{matrix}
// t+2,t+2,0;
// 4,t+6,3;
// -3,-3,t-1
// \end{matrix}\right|;
// ,\xequal{\text{factor $(t+2)$ from row 1}}(t+2)\left|\begin{matrix}
// 1,1,0;
// 4,t+6,3;
// -3,-3,t-1
// \end{matrix}\right|\xequal{ #`R2`-> #`R2`-4#`R1` \ #`R3`-> #`R3`+3#`R1` }(t+2)\left|\begin{matrix}
// 1,1,0;
// 0,t+2,3;
// 0,0,t-1
// \end{matrix}\right|;
// ,=(t-1)(t+2)^2
// \end{align*}
// So the eigenvalues of $A$ are $\lambda_1=1$ with algebraic multiplicity 1 and $\lambda_2=\lambda_3=-2$ which is of algebraic multiplicity 2. To find a basis for the 1-eigenspace, consider
// \begin{align*}
// \left[\begin{array}{c|c}
// I-A,\mathbf0
// \end{array}\right],=\left[\begin{array}{ccc|c}
// -1,-4,-3,0;
// 4,7,3,0;
// -3,-3,0,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// -1,-4,-3,0;
// 0,-9,-9,0;
// 0,9,9,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// -1,-4,-3,0;
// 0,1,1,0;
// 0,0,0,0
// \end{array}\right];
// ,tilde \left[\begin{array}{ccc|c}
// 1,0,-1,0;
// 0,1,1,0;
// 0,0,0,0
// \end{array}\right]
// \end{align*}
// It could be $\left\{\mathbf v_1=mat(
// 1;-1;1
// )\right\}$. To find a basis for the $(-2)$-eigenspace, consider
// \begin{align*}
// \left[\begin{array}{c|c}
// -2I-A,\mathbf0
// \end{array}\right],=\left[\begin{array}{ccc|c}
// -4,-4,-3,0;
// 4,4,3,0;
// -3,-3,-3,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// -4,-4,-3,0;
// 0,0,0,0;
// 1,1,1,0
// \end{array}\right];
// ,tilde \left[\begin{array}{ccc|c}
// 0,0,1,0;
// 0,0,0,0;
// 1,1,1,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,1,0,0;
// 0,0,1,0;
// 0,0,0,0;
// \end{array}\right]
// \end{align*}
// It could be $\left\{\mathbf v_2=mat(
// -1;1;0
// )\right\}$. Note that there is not enough eigenvectors ($2<3$!!!) for a basis for $RR^3$. The real reason that this failed to be a basis was that the geometric multiplicity of $-2$ (which is equal to 1) is less that the algebraic multiplicity of $-2$ (which is equal to 2)
// )

// #theorem[
// Supoose $A$ is an $n times  n$ matrix. Then the geometric multiplicity of an eigenvalue $\lambda$ is less or equal to the algebraic multiplicity of $\lambda$. $A$ is diagonalizable $<=> A$ has $n$ linearly independent eigenvectors $<=>$ geometric multiplicities are always the same as algebraic multiplicities.
// ]

// #theorem[\label{13:41-07/08/2022}
// Combining Theorem @(17:43-07/06/2022), we know that an $n times  n$ matrix with $n$ distinct eigenvalues is diagonalizable.
// ]

// #definition[
// By Theorem @(10:10-07/07/2022) we know that similar matrices have the same characteristic polynomials (hence the same eigenvalues) and determinants. So we may define notions like _eigenvalues_, _eigenvectors_, _characteristic polynomials_ and _determinants_ for a linear transformation $T:V-> V$.
// ]

// #example[
// Suppose $T=\dfrac{d}{dt}:\mathbb P_2->\mathbb P_2$, $T(a_0+a_1t+a_2t^2)=a_1+2a_2t$ is a linear transformation (verify this!), $\mathcal E=\{1,t,t^2\}$ is the standard basis, we have
//  $
// D=[T]_{\mathcal B}=mat(
// 0,0,0;
// 0,1,0;
// 0,0,2
// )
//  $
// so the characteristic polynomial of $T$ is $\det(tI-[T]_{\mathcal E})=t(t-1)(t-2)$, so the eigenvalues for $T$ will be $\lambda_1=0,\lambda_2=1,\lambda_3=2$, and the corresponding eigenvectors for $[T]_{\mathcal E}$ could be $\left\{\mathbf v_1=mat(
// 1;0;0
// ),\mathbf v_1=mat(
// 0;1;0
// ),\mathbf v_1=mat(
// 0;0;1
// )\right\}$, which in turn corresponds to eigenvectors $\{1,t,t^2\}$ for $T$. However if we choose basis $\mathcal C=\{1+t,t,t^2\}$ is the standard basis, we have
//  $
// P=\underset{\mathcal E\leftarrow\mathcal C}{P}=mat(
// 1,0,0;
// 1,1,0;
// 0,0,1
// ),\quad P^{-1}=\underset{\mathcal C\leftarrow\mathcal E}{P}=mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )
//  $
// and thus
// \begin{align*}
// A,=[T]_{\mathcal C}=\underset{\mathcal B\leftarrow\mathcal C}{P}[T]_{\mathcal C}\left(\underset{\mathcal B\leftarrow\mathcal C}{P}\right)^{-1}=PDP^{-1}=mat(
// 1,0,0;
// 1,1,0;
// 0,0,1
// )mat(
// 0,0,0;
// 0,1,0;
// 0,0,2
// )mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )=mat(
// 0,0,0;
// -1,1,0;
// 0,0,2
// )
// \end{align*}
// The determinant of $T$ is equal to either $\det([T]_{\mathcal B})$ or $\det([T]_{\mathcal C})$, which is zero.
// )

// #example[
// $A=mat(
// 2,1;
// 2,3
// )$, let's compute $A^{50}$. First we find the eigenvalues $\lambda_1=1$, $\lambda_2=4$. and we get corresponding eigenvectors $\mathbf v_1=mat(
// -1;1
// ),\mathbf v_2=mat(
// 1;2
// )$, so we have $D=mat(
// 1,0;0,4
// )$ and $P=mat(
// -1,1;1,2
// )$, so $P^{-1}= 1 / 3 mat(
// -2,1;1,1
// )$. So we have
// \begin{align*}
// A^{50} ,= \overbrace{(PDP^{-1})(PDP^{-1})(PDP^{-1})dots.h.c(PDP^{-1})}^{50};
// ,=\overbrace{(PD\cancel{P^{-1}})(\cancel PD\cancel{P^{-1}})(\cancel PD\cancel{P^{-1}})dots.h.c(\cancel PDP^{-1})}^{50};
// ,=PD^{50}P^{-1}= 1 / 3 mat(
// -1,1;1,2
// )mat(
// 1,0;0,4^{50}
// )mat(
// -2,1;1,1
// )
// \end{align*}
// )

// ={Lecture 13 - Orthogonalization}

// Recall for $\mathbf u=mat(
// u_1;u_2;dots.v;u_n
// ),\mathbf v=mat(
// v_1;v_2;dots.v;v_n
// )\inRR^n$, we can define the _dot product_ $\mathbf u dot.c \mathbf v$ to be $\mathbf u^T\mathbf v=mat(
// u_1,u_2,dots.h.c,u_n
// )mat(
// v_1;v_2;dots.v;v_n
// )=u_1v_1+u_2v_2+dots.h.c u_nv_n$. The #text(fill:blue)[length](or #text(fill:blue)[norm]) of a vector $\mathbf u$ can be expressed as $\|\mathbf u\|=\sqrt{\mathbf u dot.c \mathbf u}=\sqrt{u_1^2+dots.h.c+u_n^2}$. Geometrically, the dot product can interpreted as $\mathbf u dot.c \mathbf v=\|\mathbf u\|\|\mathbf v\|\cos\theta$, here $\theta$ is the angle between $\mathbf u$ and $\mathbf v$ (which could be between 0 and $\pi$)
//
// - If $\mathbf u dot.c \mathbf v<0$, then $\cos\theta<0$, $\theta$ is obtuse, if in addition $\mathbf u dot.c \mathbf v=\|\mathbf u\|\|\mathbf v\|$, then $\mathbf u,\mathbf v$ are of the opposite direction.
// - If $\mathbf u dot.c \mathbf v=0$, then $\cos\theta=0$, $\theta= \pi / 2 $, or $\mathbf u=\mathbf0$, or $\mathbf v=\mathbf0$. In this case, we say that $\mathbf u,\mathbf v$ are #text(fill:blue)[orthogonal]#index[orthogonal] (denoted $\mathbf u\perp\mathbf v$, $\perp$ stands for perpendicular).
// - If $\mathbf u dot.c \mathbf v>0$, then $\cos\theta>0$, $\theta$ is acute, if in addition $\mathbf u dot.c \mathbf v=\|\mathbf u\|\|\mathbf v\|$, then $\mathbf u,\mathbf v$ are of the same direction.
//

// =={Orthogonal and orthonormal basis}

// #definition[
// We say a vector $\mathbf u$ is of unit length (or a #text(fill:blue)[unit vector], or a #text(fill:blue)[normalized vector]) if $\|\mathbf u\|=1$
// ]

// #definition[
// $\mathcal B=\{\mathbf v_1,dots.h.c,\mathbf v_n\}$ is called an orthogonal set if $\mathbf v_i,\mathbf v_j$ ($i!= j$) are orthogonal. $\mathcal B$ is called an #text(fill:blue)[orthogonal] basis if $\mathcal B$ is in addition a basis. $\mathcal B$ is called an #text(fill:blue)[orthonormal]#index[orthonormal] basis if the basis vectors are in addition normalized.
// ]

// #remark[
// Suppose $\mathcal B=\{\mathbf v_1,dots.h.c,\mathbf v_n\}$, to test if $\mathcal B$ is an orthogonal (or orthonormal) set, we just need to write $A=mat(
// \mathbf v_1,dots.h.c,\mathbf v_n
// )$, and test if
//  $
// A^TA=mat(
// \mathbf v_1^T;\mathbf v_2^T;dots.v;\mathbf v_n^T
// )mat(
// \mathbf v_1,\mathbf v_2,dots.h.c,\mathbf v_n
// )=mat(
// \mathbf v_1^T\mathbf v_1,\mathbf v_1^T\mathbf v_2,dots.h.c,\mathbf v_1^T\mathbf v_n;
// \mathbf v_2^T\mathbf v_1,\mathbf v_2^T\mathbf v_2,dots.h.c,\mathbf v_2^T\mathbf v_n;
// dots.v,dots.v,dots.down,dots.v;
// \mathbf v_n^T\mathbf v_1,\mathbf v_n^T\mathbf v_2,dots.h.c,\mathbf v_n^T\mathbf v_n;
// )
//  $
// is diagonal (or if $A^TA=I$)
// ]

// #theorem[\label{01:12-07/15/2022}
// Suppose $\mathcal B=\{\mathbf v_1,dots.h.c,\mathbf v_p\}$ is an orthogonal set of non-zero vectors, then $\mathcal B$ is linearly independent
// ]

// \begin{proof}
// Suppose not, we may assume $\mathbf 0!=\mathbf v_p=c_1\mathbf v_1+dots.h.c+r_{p-1}\mathbf v_{p-1}$, but then
//  $
// 0<\|\mathbf v_p\|^2=\mathbf v_p dot.c (c_1\mathbf v_1+dots.h.c+r_{p-1}\mathbf v_{p-1})=0
//  $
// Which is a contradiction.
// \end{proof}

// =={Gram-Schmidt process}

// #question[
// Suppose you have two vectors $\mathbf u,\mathbf v$ (here $\mathbf v!=\mathbf0$), what is the orthogonal projection of $\mathbf u$ onto $\mathbf v$ (Which we denote as $\Proj_{\mathbf v}\mathbf u$)?
// ]

// #answer[
// First you realize that $\Proj_{\mathbf v}\mathbf u$ is parallel to $\mathbf v$, so we write it as $\lambda\mathbf v$, and we know $\|\Proj_{\mathbf v}\mathbf u\|=\lambda\|\mathbf v\|=\|\mathbf u\|\cos\theta$, so we may conclude that
//  $
// \lambda= \|\mathbf u\|\cos\theta / \|\mathbf v\| = \|\mathbf u\|\|\mathbf v\|\cos\theta / \|\mathbf v\|^2 = \mathbf u dot.c \mathbf v / \mathbf v dot.c \mathbf v
//  $
// Therefore we have derived the equation
// $ \label{13:10-07/14/2022}
// \Proj_{\mathbf v}\mathbf u= \mathbf u dot.c \mathbf v / \mathbf v dot.c \mathbf v \mathbf v
// $
// ]

// #question[
// If $W$ is a subspace of $RR^n$ with an orthogonal basis $\mathcal B=\{\mathbf u_1,dots.h.c,\mathbf u_p\}$, how could you express the orthogonal projection of a vector $\mathbf y\inRR^n$ onto $W$ (denoted by $\Proj_W\mathbf y$).
// ]

// Suppose $\Proj_W\mathbf y=\lambda_1\mathbf u_1+dots.h.c+\lambda_p\mathbf u_p$, then we should have for any $i$
//  $
// 0=(\mathbf y-\Proj_W\mathbf y) dot.c \mathbf u_i=(\mathbf y-\lambda_1\mathbf u_1+dots.h.c+\lambda_p\mathbf u_p) dot.c \mathbf u_i=\mathbf y dot.c \mathbf u-\lambda_i\mathbf u_1 dot.c \mathbf u_1 => \lambda_i= \mathbf y dot.c \mathbf u_i / \mathbf u_i dot.c \mathbf u_i
//  $
// There we have the equation
// $ \label{22:47-07/14/2022}
// \begin{aligned}
// \Proj_W\mathbf y,=\Proj_{\mathbf u_1}\mathbf y+dots.h.c+\Proj_{\mathbf u_p}\mathbf y;
// ,= \mathbf y dot.c \mathbf u_1 / \mathbf u_1 dot.c \mathbf u_1 \mathbf u_1+dots.h.c+ \mathbf y dot.c \mathbf u_p / \mathbf u_p dot.c \mathbf u_p \mathbf u_p
// \end{aligned}
// $

// If we further assume that $\mathcal B$ is an orthonormal basis, then $\mathbf u_1 dot.c \mathbf u_1=\|\mathbf u_i\|^2=1$. Let's write $U=mat(
// \mathbf u_1,dots.h.c,\mathbf u_p
// )$. \eqref{22:47-07/14/2022} becomes
// $ \label{22:51-07/14/2022}
// \Proj_W\mathbf y=(\mathbf y dot.c \mathbf u_1)\mathbf u_1+dots.h.c+(\mathbf y dot.c \mathbf u_p)\mathbf u_p=UU^T\mathbf y
// $

// #example[
// Consider $\mathcal B=\left\{\mathbf u_1=mat(
// 2;1;0
// ),\mathbf u_2=mat(
// -1;2;0
// )\right\}$, $\mathbf y=mat(
// 1;1;1
// )$, $W=\Span\{\mathbf u_1,\mathbf u_2\}$. Let $U=mat(
// \mathbf u_1,\mathbf u_2
// )=mat(
// 2,-1;
// 1,2;
// 0,0
// )$, then $A^TA=mat(
// 5,0;
// 0,5
// )$ is diagonal, hence $\mathcal B$ is an orthogonal set, the orthogonal projection of $\mathbf y$ onto $W$ is
// \begin{align*}
// \Proj_W\mathbf y,= \mathbf y dot.c \mathbf u_1 / \mathbf u_1 dot.c \mathbf u_1 \mathbf u_1+ \mathbf y dot.c \mathbf u_2 / \mathbf u_2 dot.c \mathbf u_2 \mathbf u_2;
// ,= 1 dot.c 2+1 dot.c 1+1 dot.c 0 / 2^2+1^2+0^2 \mathbf u_1+ 1 dot.c (-1)+1 dot.c 2+1 dot.c 0 / (-1)^2+2^2+0^2 \mathbf u_2;
// ,= 3 / 5 mat(
// 2;1;0
// )+ 1 / 5 mat(
// -1;2;0
// )=mat(
// 1;1;0
// )
// \end{align*}
// )

// #question[
// Suppose we are given arbitrary basis $\mathcal B=\{\mathbf v_1,dots.h.c,\mathbf v_p\}$ for a subspace $W$ of $RR^n$, how could we get a orthogonal (or orthonormal) basis $\mathcal U=\{\mathbf u_1,dots.h.c,\mathbf u_p\}$ from it
// ]

// #answer[
// We apply the #text(fill:blue)[Gram-Schmidt process]#index[Gram-Schmidt process]
//
// - $\mathbf u_1=\mathbf v_1$
// - $\mathbf u_2=\mathbf v_2-\Proj_{\mathbf u_1}\mathbf v_2$;
// $\hphantom{\mathbf u_2}=\mathbf v_2-\dfrac{\mathbf v_2 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1$
// - $\mathbf u_3=\mathbf v_3-\Proj_{\mathbf u_1}\mathbf v_3-\Proj_{\mathbf u_2}\mathbf v_3$;
// $\hphantom{\mathbf u_3}=\mathbf v_3-\dfrac{\mathbf v_3 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1-\dfrac{\mathbf v_3 dot.c \mathbf u_2}{\mathbf u_2 dot.c \mathbf u_2}\mathbf u_2$
// - $\hphantom{\mathbf u_4}dots.v$
// - $\mathbf u_p=\mathbf v_p-\Proj_{\mathbf u_1}\mathbf v_p-dots.h.c-\Proj_{\mathbf u_{p-1}}\mathbf v_p$;
// $\hphantom{\mathbf u_p}=\mathbf v_p-\dfrac{\mathbf v_p dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1-dots.h.c-\dfrac{\mathbf v_p dot.c \mathbf u_{p-1}}{\mathbf u_{p-1} dot.c \mathbf u_{p-1}}\mathbf u_{p-1}$
//
// Then $\{\mathbf u_1,dots.h.c,\mathbf u_p\}$ would be an orthogonal basis. To get an orthonormal basis, just normalize these vectors.
// ]

// #example[\label{00:47-07/15/2022}
// Consider $\left\{\mathbf v_1=mat(
// 1;1;1
// ),\mathbf v_2=mat(
// 1;2;2
// ),\mathbf v_3=mat(
// 3;-1;1
// )\right\}$. Let's use Gram-Schmidt process to find an orthogonal (and an orthonormal) basis from it.
//
// - First we choose $\mathbf u_1=\mathbf v_1=mat(
// 1;1;1
// )$
// - $\mathbf v_2-\dfrac{\mathbf v_2 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1=mat(
// 1;2;2
// )- 5 / 3 mat(
// 1;1;1
// )=mat(
// - 2 / 3 ; 1 / 3 ; 1 / 3
// )$. Let's instead take a multiple of this to be our $\mathbf u_2$, namely we set $\mathbf u_2=mat(
// -2;1;1
// )$
// - $\mathbf u_3=\mathbf v_3-\dfrac{\mathbf v_3 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1-\dfrac{\mathbf v_3 dot.c \mathbf u_2}{\mathbf u_2 dot.c \mathbf u_2}\mathbf u_2=mat(
// 3;-1;1
// )-mat(
// 1;1;1
// )-mat(
// -2;1;1
// )=mat(
// 0;-1;1
// )$
//
// Thus $\left\{\mathbf u_1=mat(
// 1;1;1
// ),\mathbf u_2=mat(
// -2;1;1
// ),\mathbf u_3=mat(
// 0;-1;1
// )\right\}$ is an orthogonal basis for $RR^3$. If we further normalize it, we have
//  $
// \mathbf w_1= \mathbf u_1 / \|\mathbf u_1\| = 1 / \sqrt3 mat(
// 1;1;1
// )=mat(
//  1 / \sqrt3 ; 1 / \sqrt3 ; 1 / \sqrt3
// ),\mathbf w_2= \mathbf u_2 / \|\mathbf u_2\| = 1 / \sqrt6 mat(
// -2;1;1
// )=mat(
// - 1 / \sqrt3 ; 1 / \sqrt6 ; 1 / \sqrt6
// ),\mathbf w_3= \mathbf u_3 / \|\mathbf u_3\| = 1 / \sqrt2 mat(
// 0;-1;1
// )=mat(
// 0;- 1 / \sqrt2 ; 1 / \sqrt2
// )
//  $
// is an orthonormal basis.
// )

// #exercise[
// Use Gram-Schmidt process to find an orthogonal and orthonormal basis of the following basis
// \begin{enumerate}
// - $\left\{mat(1;2),mat(3;1)\right\}$
// - $\left\{mat(1;1;-1),mat(2;1;0),mat(-2;-1;3)\right\}$
// \end{enumerate}
// ]

// =={Orthogonal matrix and QR factorization}

// #definition[
// A square matrix $U$ is called an #text(fill:blue)[orthogonal matrix]#index[orthogonal matrix] if  the columns of $U$ form an orthonormal basis $<=> U^TU=UU^T=I$. Note that in this particular case, $U^T=U^{-1}$
// ]

// #remark[
// The rows of $U$ also form an orthonormal basis.
// ]

// \begin{note}
// The name _orthogonal matrix_ is unfortunate since it is made out of orthonormal basis. It should really be called the orthonormal matrix. But since mathematicians has been using this for a long time. So we will stick to this usage.
// \end{note}

// The Gram-Schmidt process gives us the so-called $QR$-factorization. First we can rewrite the Gram-Schmidt process as
// \begin{align*}
// \mathbf v_1,=\mathbf u_1;
// \mathbf v_2,=\dfrac{\mathbf v_2 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1+\mathbf u_2;
// \mathbf v_3,=\dfrac{\mathbf v_3 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1+\dfrac{\mathbf v_3 dot.c \mathbf u_2}{\mathbf u_2 dot.c \mathbf u_2}\mathbf u_2+\mathbf u_3;
// ,dots.v;
// \mathbf v_n,=\dfrac{\mathbf v_n dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1+dots.h.c+\dfrac{\mathbf v_n dot.c \mathbf u_{n-1}}{\mathbf u_{n-1} dot.c \mathbf u_{n-1}}\mathbf u_{n-1}+\mathbf u_n
// \end{align*}
// After normalization (let's set $\mathbf u_i:= \mathbf u_i / \|\mathbf u_i\| $ to be unit vectors), we may write the above as the following set of equations with coefficients
// \begin{align*}
// \mathbf v_1,=r_{11}\mathbf u_1;
// \mathbf v_2,=r_{12}\mathbf u_1+r_{22}\mathbf u_2;
// \mathbf v_3,=r_{13}\mathbf u_1+r_{23}\mathbf u_2+r_{33}\mathbf u_3;
// ,dots.v;
// \mathbf v_n,=r_{1n}\mathbf u_1+dots.h.c+r_{n-1,n}\mathbf u_{n-1}+r_{nn}\mathbf u_n
// \end{align*}
// If we write $A=mat(
// \mathbf v_1,dots.h.c,\mathbf v_n
// )$, $Q=mat(
// \mathbf u_1,dots.h.c,\mathbf u_n
// )$ (this is an orthogonal matrix), then have
//  $
// A=mat(
// \mathbf v_1,dots.h.c,\mathbf v_n
// )=mat(
// \mathbf u_1,dots.h.c,\mathbf u_n
// )mat(
// r_{11},r_{12},r_{13},dots.h.c, r_{1n};
// 0,r_{22},r_{23},dots.h.c,r_{2n};
// 0,0,r_{33},dots.h.c,r_{3n};
// dots.v,dots.v,dots.v,dots.down,dots.v;
// 0,0,0,dots.h.c,r_{nn}
// )=QR
//  $
// It can be shown that $QR$-factorization always exists, even $A$ is not invertible (columns does not form a basis)

// #example[
// Continuing Example @(00:47-07/15/2022), we consider the $QR$-factorization of $A=mat(
// \mathbf v_1,\mathbf v_2,\mathbf v_3
// )=mat(
// 1,1,3;
// 1,2,-1;
// 1,2,1
// )$, we know that $Q=mat(
// \mathbf w_1,\mathbf w_2,\mathbf w_3
// )=mat(
//  1 / \sqrt3 ,- 1 / \sqrt3 ,0;
//  1 / \sqrt3 , 1 / \sqrt6 ,- 1 / \sqrt2 ;
//  1 / \sqrt3 , 1 / \sqrt6 , 1 / \sqrt2
// )$, so we know that
//  $
// R=Q^{-1}A=Q^TA=mat(
//  1 / \sqrt3 , 1 / \sqrt3 , 1 / \sqrt3 ;
// - 1 / \sqrt3 , 1 / \sqrt6 , 1 / \sqrt6 ;
// 0,- 1 / \sqrt2 , 1 / \sqrt2
// )mat(
// 1,1,3;
// 1,2,-1;
// 1,2,1
// )=mat(
// \sqrt3, 5 / \sqrt3 ,\sqrt3;
// 0, 2 / \sqrt6 ,-\sqrt6;
// 0,0,\sqrt2
// )
//  $
// Note that here we didn't actually use Gram-Schmidt process to evaluate $R$, instead we only used the existence of $QR$-factorization.
// )

// #definition[
// Suppose $W$ is a subspace of $RR^n$, the #text(fill:blue)[orthogonal complement]#index[orthogonal complement] $W^\perp=\{\mathbf v|\mathbf v\perp W\}$ is the set of vectors that are orthogonal to $W$
// ]

// #remark[
// It is easy to show that $W$ is a subspace of $RR^n$ and $(W^\perp)^\perp=W$. This is kind of a _duality_, take $RR^3$ for an example, the orthogonal complement of a line would be the perpendicular plane, the orthogonal complement of a plane would be the perpendicular line, the orthogonal complement of the origin (a point) would be the whole space ($RR^3$) and the orthogonal complement of $RR^3$ would be the origin $\{\mathbf 0\}$. From this we also see that $\dim W+\dim W^\perp=n$.
// ]

// We make the following crucial observation: $\mathbf x$ is in $\Nul A<=>\mathbf x$ is orthogonal all row vectors of $A<=> \mathbf x\perp\Row A$, so we may conclude that $(\Row A)^\perp=\Nul A$, and similarly we know that $(\Col A)^\perp=(\Row(A^T))^\perp=\Nul(A^T)$.

// #exercise[
// Suppose $W=\Span\left\{mat(
// 1;1;0;2;0;3
// ),mat(
// 0;0;1;-2;0;2
// ),mat(
// 0;0;0;0;1;1
// )\right\}$, find $(\Col A)^\perp$.
// ]

// ={Lecture 14 - Least-square problem}

// =={Least-square solutions}

// #question[
// linear system $A\mathbf x=bold(b)$ may not always be solvable, nonetheless, we still want to find the _best possible_ solution $\hat{\mathbf x}$
// ]

// #answer[
// According to Gauss, by best possible we mean the #text(fill:blue)[least-square solutions]#index[least-square]. In concrete terms, such $\hat{\mathbf x}$ stisfies that $\|A\hat{\mathbf x}-bold(b)\|\leq\|A\mathbf x-bold(b)\|$ for any other choice of $\mathbf x$.
// ]

// By a simple argument we can show that $A\hat{\mathbf x}$ must be the projection of $bold(b)$ onto $\Col A$, so we know that
// \begin{align*}
// (A\hat{\mathbf x}-bold(b))\perp\Col A<=>(A\hat{\mathbf x}-bold(b))\in(\Col A)^\perp=\Nul(A^T)<=> A^T(A\hat{\mathbf x}-bold(b))=\mathbf 0<=> A^TA\hat{\mathbf x}=A^Tbold(b)
// \end{align*}

// We call equation
// $ \label{00:08-07/15/2022}
// A^TA\mathbf x=A^Tbold(b)
// $
// the normal equation of $A\mathbf x=bold(b)$. And we have shown that the least square solutions of the linear system $A\mathbf x=bold(b)$ is the solution set to the normal equation~\eqref{00:08-07/15/2022}. The solution to the least square problem might not be unique.

// #theorem[
// $A^TA\mathbf x=A^Tbold(b)$ has a unique solution $<=>$ the columns of $A$ is linearly independent $<=> A^TA$ is invertible. And the unique solution would of course be $(A^TA)^{-1}A^Tbold(b)$
// ]

// #example[
// Suppoes $A=mat(
// 4,0;
// 0,2;
// 1,1
// )$, $bold(b)=mat(
// 2;0;11
// )$. It is easy to verify that the linear system $A\mathbf x=bold(b)$ is not linearly consistent. To solve for the least-square solution, we look at its normal equation
//  $
// mat(
// 17,1;1,5
// )mat(
// x_1;x_2
// )=mat(
// 4,0,1;
// 0,2,1
// )mat(
// 4,0;
// 0,2;
// 1,1
// )mat(
// x_1;x_2
// )=A^TA\mathbf x=A^Tbold(b)=mat(
// 4,0,1;
// 0,2,1
// )mat(
// 2;0;11
// )=mat(
// 19;11
// )
//  $
// And solve for $\mathbf x(A^TA)^{-1}A^Tbold(b)=(A^TA)^{-1}A^Tbold(b)=mat(
// 1;2
// )$
// )

// #exercise[
// Suppose $A=mat(
// 1,2;
// -1,4;
// 1,2
// )$, $bold(b)=mat(
// 3;-1;5
// )$, solve for the least square solution of $A\mathbf x=bold(b)$.
// ]

// =={Machine Learning and approximation}

// #question[
// Suppose you know a curve has the form
//  $
// y=\beta_1f_1(x_1,dots.h.c,x_k)+\beta_2f_2(x_1,dots.h.c,x_k)+dots.h.c+\beta_nf_n(x_1,dots.h.c,x_k)
//  $
// And you know what functions $f_1,f_2,dots.h.c,f_n$ should be (they could be linear functions, quadratic functions, polynomial functions, exponential functions, logarithmic function, trigonometry functions, etc.). You also have collected a bunch of data points $(x_1^{(1)},dots.h.c,x_k^{(1)},y^{(1)}),(x_1^{(2)},dots.h.c,x_k^{(2)},y^{(2)}),dots.h.c,(x_1^{(m)},dots.h.c,x_k^{(m)},y^{(m)})$. How do you find best fitting coefficients $\beta_1,\beta_2,dots.h.c,\beta_n$? First let's define the #text(fill:blue)[residual]#index[residual]
//  $
// \epsilon^{(i)}=y^{(i)}-\beta_1f_1(x_1^{(i)},dots.h.c,x_k^{(i)})-\beta_2f_2(x_1^{(i)},dots.h.c,x_k^{(i)})-dots.h.c-\beta_nf_n(x_1^{(i)},dots.h.c,x_k^{(i)})
//  $
// Our goal to minimize the residual. One might want to minimize the quantity $\sum_{i=1}^m|\epsilon^{(i)}|$, however, this is cumbersome, difficult to work with, and mathematically unsatisfactory. So Gauss instead considered the square sum $\sum_{i=1}^m|\epsilon^{(i)}|^2$, posed and solved the least square problem!!!
// ]

// #answer[
// We use normal equations.
// ]

// Let's write
//  $
// \mathbf y=mat(
// y^{(1)};dots.v;y^{(m)}
// ),\mathbf \beta=mat(
// \beta_1;dots.v;\beta_n
// ),\mathbf \epsilon=mat(
// \epsilon^{(1)};dots.v;\epsilon^{(m)}
// ),
// X=mat(
// f_1(x_1^{(1)},dots.h.c,x_k^{(1)}),dots.h.c,f_n(x_1^{(1)},dots.h.c,x_k^{(1)});
// dots.v,dots.down,dots.v;
// f_1(x_1^{(m)},dots.h.c,x_k^{(m)}),dots.h.c,f_n(x_1^{(m)},dots.h.c,x_k^{(m)});
// )
//  $
// Then have $\mathbf y=X\mathbf\beta=\mathbf\epsilon$. To minimize $\|\mathbf\epsilon\|^2$ will be the same as solving the normal equation $X^TX\mathbf\beta=X^T\mathbf y$ of $X\mathbf\beta=\mathbf y$.

// #example[
// Find the equation $y=\beta_0+\beta_1x$ of the least-squares line that best fits the data points $(2,1),(5,2),(7,3)$ and $(8,3)$.
// )


// ={Lecture 15 - Complex eigenvalues}

// =={Complex numbers}

// #theorem[
// Consider quadratic equation $at^2+bt+c=0$, the #text(fill:blue)[quadratic formula]#index[quadratic formula] reads $t=\frac{-b\pm\sqrt{\Delta}}{2a}$, where $\Delta=b^2-4ac$ is the discriminant.
// ]

// Let's review some general stuff about complex numbers.

// #definition[
// The set of complex numbers $\mathbb C$ is the defined to be $\{z=a+bi|a,b\inRR\}$, with $i=\sqrt{-1}$ so that $i^2=-1$. We call $\operatorname{Re}z=a$ the #text(fill:blue)[real part]#index[real part] of $z$ and $\operatorname{Im}z=b$ to be the #text(fill:blue)[imaginary part]#index[imaginary part] of $z$. We call $r=|z|=\sqrt{a^2+b^2}$ the #text(fill:blue)[modulus]#index[modulus] (or #text(fill:blue)[absolute value]) of $z$, and the angle $\varphi$ between $z$ and the real axis the #text(fill:blue)[argument]#index[argument] of $z$.
// ]

// #definition[
// There is a natural identification between the complex numbers and the plane $RR^2$ via $z=a+bi\leftrightsquigarrow(a,b)$ (this is why the set of complex numbers is often called the complex plane). We can define
//
// - Addition via $(a+bi)+(c+di)=(a+c)+(b+d)i$
// - Multiplication via $(a+bi)(c+di)=ac+adi+bci+bdi^2=(ac-bd)+(ad+bc)i$.
// - #text(fill:blue)[Conjugate]#index[conjugate] as $\overline z=a-bi$.
//
// ]

// #remark[
// Through this identification it is easy to see that $a=r\cos\varphi$, $b=r\sin\varphi$, and we have #text(fill:blue)[Euler's formula]#index[Euler's formula] $z=re^{i\varphi}=r\cos\varphi=i\sin\varphi$.
// ]

// #remark[
// If we have a complex-valued matrix $A$, then the conjugation is defined entrywise (Note that column vectors are matrices). If we write a complex valued matrix $A=\operatorname{Re}A+i\operatorname{Im}A$, then the conjugation would be $\overline A=\operatorname{Re}A-i\operatorname{Im}A$. For example, if $A=mat(
// 1+2i,3;
// -1-i,i
// )=mat(
// 1,3;
// -1,0
// )+imat(
// 2,0;
// -1,1
// )$, then $\overline A=mat(
// 1-2i,3;
// -1+i,-i
// )=mat(
// 1,3;
// -1,0
// )-imat(
// 2,0;
// -1,1
// )$. It is easy to check that $\overline{A+B}=\overline A+\overline B$, $\overline{cA}=\overline c\overline A$, $\overline{AB}=\overline A\overline B$.
// ]

// =={Eigen-decomposition over the complex numbers}

// #question[
// $A=mat(
// 1,-2;1,3
// )$, can we diagonalize it?
// ]

// #answer[
// First we compute its characteristic polynomial $t^2-4t+5$, an then we can solve the quadratic equation as follows
//  $
// \Delta=(-4)^2-4 dot.c 1 dot.c 5=-4,t=\frac{-(-4)\pm\sqrt{-4}}{2}= -(-4)\pm2i / 2 =2\pm i
//  $
// Hence the eigenvalues are $\lambda_1=2+i,\lambda_2=2-i$. The eigenvector for $\lambda_1$ can be computed via
//  $
// \left[\begin{array}{c|c}
// \lambda_1I-A,\mathbf0
// \end{array}\right]tilde \left[\begin{array}{cc|c}
// 1,1-i,0;
// 0,0,0
// \end{array}\right]
//  $
// So we get $\mathbf v_1=mat(
// -1+i;1
// )=mat(
// -1;1
// )+mat(
// i;0
// )=mat(
// -1;1
// )+mat(
// 1;0
// )i=\operatorname{Re}\mathbf v_1+i\operatorname{Im}\mathbf v_1$. The eigenvector for $\lambda_2$ can be computed via
//  $
// \left[\begin{array}{c|c}
// \lambda_2I-A,\mathbf0
// \end{array}\right]tilde \left[\begin{array}{cc|c}
// 1,1+i,0;
// 0,0,0
// \end{array}\right]
//  $
// So we get $\mathbf v_2=mat(
// -1-i;1
// )=mat(
// -1;1
// )+mat(
// -i;0
// )=mat(
// -1;1
// )+mat(
// -1;0
// )i=\operatorname{Re}\mathbf v_2+i\operatorname{Im}\mathbf v_2$. Now we may realize that we have $\lambda_1$ and $\lambda_2$ are conjugate of each other. $\mathbf v_1$ and $\mathbf v_2$ are conjugate of each other.
// ]

// #theorem[
// In general, if $A$ is a 2 by 2 real-valued matrix with complex eigenvalues (characteristic polynomial have complex roots, no real roots), then they are conjugate of each other, we can write them as $\lambda=a-bi$ and $\overline\lambda=a+bi$, suppose the eigenvector for $\lambda$ is $\mathbf v=\operatorname{Re}\mathbf v+i\operatorname{Im}\mathbf v$, then the eigenvector for $\overline\lambda$ will be $\overline{\mathbf v}=\operatorname{Re}\mathbf v-i\operatorname{Im}\mathbf v$. If we write $P=mat(
// \operatorname{Re}\mathbf v,\operatorname{Im}\mathbf v
// )$, and $C=mat(
// a,-b;
// b,a
// )$, then $AP=PC$, therefore we get decomposition $A=PCP^{-1}$.
// ]

// \begin{proof}
// We have $A\mathbf v=\lambda\mathbf v$ (and hence by conjugation we have $A\overline{\mathbf v}=A\overline{\mathbf v}=\overline A\overline{\mathbf v}=\overline{A\mathbf v}=\overline{\lambda}\overline{\mathbf v}$, note that here $A$ is real-valued, so $\overline A=A$), we can rewrite this as
//  $
// (A\operatorname{Re}\mathbf v)+i(A\operatorname{Im}\mathbf v)=A(\operatorname{Re}\mathbf v+i\operatorname{Im}\mathbf v)=A\mathbf v=\lambda\mathbf v=(a-bi)(\operatorname{Re}\mathbf v+i\operatorname{Im}\mathbf v)=(a\operatorname{Re}\mathbf v+b\operatorname{Im}\mathbf v)+i(a\operatorname{Im}\mathbf v-b\operatorname{Re}\mathbf v)
//  $
// Looking at its real and imaginary parts we conclude that
//  $
// A\operatorname{Re}\mathbf v=a\operatorname{Re}\mathbf v+b\operatorname{Im}\mathbf v,\qquad A\operatorname{Im}\mathbf v=a\operatorname{Im}\mathbf v-b\operatorname{Re}\mathbf v
//  $
// This is precisely $AP=PC$
// \end{proof}

// #remark[
// Matrix $C$ is special in the following sense (it can be decomposed as a composition of rotation and scaling)
//  $
// C=mat(
// a,-b;
// b,a
// )=mat(
// r\cos\varphi,-r\sin\varphi;
// r\sin\varphi,r\cos\varphi
// )=rmat(
// \cos\varphi,-\sin\varphi;
// \sin\varphi,\cos\varphi
// )
//  $
// Here we suppose $\overline\lambda=a+bi=re^{i\varphi}=r\cos\varphi+ir\sin\varphi$ so that $a=r\cos\varphi$, $b=r\sin\varphi$.
// ]

// #example[
// In the previous example, we could take $\lambda=2-i$ so that $a=2,b=1$, $\mathbf v=mat(
// -1;1
// )+imat(
// -1;0
// )$ so that $\operatorname{Re}\mathbf v=mat(
// -1;1
// )$, $\operatorname{Im}\mathbf v=mat(
// -1;0
// )$, and we have the decomposition
//  $
// A=mat(
// 1,-2;
// 1,3
// )=mat(
// -1,-1;
// 1,0
// )mat(
// 2,-1;
// 1,2
// )mat(
// 0,1;
// -1,-1
// )=PCP^{-1}
//  $
// )

// #exercise[
// Suppose $A=mat(
// -1,-1;5,-5
// )$. Find an invertible matrix $P$ and a matrix $C$ of the form $mat(
// a,-b;b,a
// )$ such that $A=PCP^{-1}$
// ]

// ={Lecture 16 - Orthogonal diagonalization}

// =={Orthogonal diagonalization}

// #theorem[\label{23:54-07/19/2022}
// Suppose $A$ is a symmetric ($A^T=A$) real-valued matrix, and $\mathbf v_1$, $\mathbf v_2$ are $\lambda_1$-eigenvector, $\lambda_2$-eigenvectors respectively. Then $\mathbf v_1 dot.c \mathbf v_2=0$
// ]

// \begin{proof}
// Consider
//  $
// \lambda_1(\mathbf v_1 dot.c \mathbf v_2)=(\lambda_1\mathbf v_1)^T\mathbf v_2=(A\mathbf v_1)^T\mathbf v_2=\mathbf v_1^TA^T\mathbf v_2=\mathbf v_1^TA\mathbf v_2=\mathbf v_1 dot.c (\lambda_2\mathbf v_2)=\lambda_2(\mathbf v_1 dot.c \mathbf v_2)
//  $
// We get $(\lambda_1-\lambda_2)(\mathbf v_1 dot.c \mathbf v_2)=0$, since $\lambda_1-\lambda_2!=0$, $\mathbf v_1 dot.c \mathbf v_2=0$
// \end{proof}

// #theorem[
// Suppose $A$ is a symmetric real-valued matrix, then the eigenvalues are also real.
// ]

// \begin{proof}
// Suppose $\lambda$ is an eigenvalue of $A$, then there exists some $\lambda$-eigenvector such that $A\mathbf v=\lambda\mathbf v$, and that the length of the complex vector $\mathbf v$ is $\|\mathbf v\|^2=\overline{\mathbf v} dot.c \mathbf v$ is a positive real number (Note that for a complex number $z=a+bi$, $|z|^2=a^2+b^2=(a+bi)(a-bi)=z\overline z$). Since $A$ is symmetric and real-valued, $\overline A^T=A$. We have
//  $
// \overline\lambda\|\mathbf v\|^2=\overline{(A\mathbf v)}^T\mathbf v=\overline{\mathbf v}^T\overline A^T\mathbf v=\overline{\mathbf v}^TA\mathbf v=\lambda\|\mathbf v\|^2
//  $
// Which implies that $(\lambda-\overline\lambda)\|\mathbf v\|^2=0$, so $\lambda=\overline\lambda$, i.e. $\lambda$ is real-valued.
// \end{proof}

// #fact[
// A symmetric real-valued matrix is diagonalizable.
// ]

// #theorem[
// Suppose $A$ is a symmetric real-valued matrix with eigenvalues $\lambda_1,dots.h.c,\lambda_n$ (maybe repeated). $A$ can be orthogonal diagonalized as $A=PDP^T$, where $D$ is the diagonal matrix $mat(
// \lambda_1,,;
// ,dots.down,;
// ,,\lambda_n
// )$, and $P$ is an orthogonal matrix.
// ]

// \begin{proof}
// To get an orthonormal basis for each eigenspace $\Nul(\lambda I-A)$, you just need to find an arbitrary basis, and then apply Gram-Schmidt process to get an orthonormal basis, then by Theorem @(23:54-07/19/2022), the set of eigenvectors form an orthonormal basis for $RR^n$, assume they are $\mathbf u_1,dots.h.c,\mathbf u_n$, in corresponds to eigenvalues $\lambda_1,dots.h.c,\lambda_n$, then we get orthogonal diagonalization
//  $
// A=PDP^{-1}=PDP^T
//  $
// Here $P=mat(
// \mathbf u_1,dots.h.c,\mathbf u_n
// )$ is an orthogonal basis and thus $P^{-1}=P^T$.
// \end{proof}

// #example[\label{12:47-07/20/2022}
// Suppose $A=mat(
// 7,2;
// 2,4
// )$, the characteristic polynomial is $(t-3)(t-8)$, so we have eigenvalues $\lambda_1=3$ and $\lambda_2=8$, we can then find the eigenvectors $\mathbf v_1=mat(
// -1;2
// )$ and $\mathbf v_2=mat(
// 2;1
// )$, we may realized that $\mathbf v_1 dot.c \mathbf v_2=0$, i.e. $\mathbf v_1$ is orthogonal to $\mathbf v_2$, we can further normalize them into $\mathbf u_1= \mathbf v_1 / \|\mathbf v_1\| =mat(
// - 1 / \sqrt5 ; 2 / \sqrt5
// )$ and $\mathbf u_2= \mathbf v_2 / \|\mathbf v_2\| =mat(
//  2 / \sqrt5 ; 1 / \sqrt5
// )$. So we have orthogonal diagonalization
//  $
// A=mat(
// 7,2;
// 2,4
// )=mat(
// - 1 / \sqrt5 , 2 / \sqrt5 ;
//  2 / \sqrt5 , 1 / \sqrt5
// )mat(
// 3,0;
// 0,8
// )mat(
// - 1 / \sqrt5 , 2 / \sqrt5 ;
//  2 / \sqrt5 , 1 / \sqrt5
// )=PDP^T
//  $
// )

// #example[
// Suppose $A=mat(
// 3,-2,4;
// -2,6,2;
// 4,2,3;
// )$, then characteristic polynomial is
// \begin{align*}
// \det(tI-A),=\left|\begin{matrix}
// t-3,2,-4;
// 2,t-6,-2;
// -4,-2,t-3
// \end{matrix}\right|\xequal{#`R3`-> #`R3`+2#`R2`}\left|\begin{matrix}
// t-3,2,-4;
// 2,t-6,-2;
// 0,2t-14,t-7
// \end{matrix}\right|;
// ,\xequal{\text{factor $(t-7)$ from 3rd row}}(t-7)\left|\begin{matrix}
// t-3,2,-4;
// 2,t-6,-2;
// 0,2,1
// \end{matrix}\right|\xequal{C2-> C2-C3}(t-7)\left|\begin{matrix}
// t-3,10,-4;
// 2,t-2,-2;
// 0,0,1
// \end{matrix}\right|;
// ,\xequal{\text{cofactor expansion on the 3rd row}}(t-7) dot.c 1 dot.c (-1)^{3+3}\left|\begin{matrix}
// t-3,10;
// 2,t-2
// \end{matrix}\right|;
// ,=(t-7)(t^2-5t-14)=(t-7)^2(t+2)
// \end{align*}
// Hence the eigenvalues are $\lambda_1=\lambda_2=7$, $\lambda_3=-2$
//  $
// \left[\begin{array}{c|c}
// 7I-A,\mathbf0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1, 1 / 2 ,-1,0;
// 0,0,0,0;
// 0,0,0,0
// \end{array}\right]
//  $
// so we may choose
//  $
// \mathbf v_1=2mat(
// - 1 / 2 ;1;0
// )=mat(
// -1;2;0
// ),\quad\mathbf v_2=mat(
// 1;0;1
// )
//  $
// as eigenvectors for $\lambda_1=\lambda_2=7$. We can use Gram-Schmidt process to get an orthogonal set: $\mathbf w_1=\mathbf v_1=mat(
// -1;2;0
// )$, $\mathbf v_2-\dfrac{\mathbf v_2 dot.c \mathbf w_1}{\mathbf w_1 dot.c \mathbf w_1}\mathbf w_1=mat(
//  4 / 5 ; 2 / 5 ;1
// )$, we can choose $\mathbf w_2=mat(
// 4;2;5
// )$. We can normalize them into
//  $
// \mathbf u_1= 1 / \sqrt5 mat(
// -1;2;0
// ),\quad\mathbf u_2= 1 / 3\sqrt5 mat(
// 4;2;5
// )
//  $
//  $
// \left[\begin{array}{c|c}
// -2I-A,\mathbf0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,0,1,0;
// 0,1, 1 / 2 ,0;
// 0,0,0,0
// \end{array}\right]
//  $
// so we may choose
//  $
// \mathbf v_3=2mat(
// -1;- 1 / 2 ;1
// )=mat(
// -2;-1;2
// )
//  $
// as the eigenvector for $\lambda_3=-2$. We can normalize it into
//  $
// \mathbf u_3= \mathbf v_3 / \|\mathbf v_3\| = 1 / 3 mat(
// -2;-1;2
// )
//  $
// Now we get the orthogonal decomposition
//  $
// A=mat(
// 3,-2,4;
// -2,6,2;
// 4,2,3;
// )=mat(
// - 1 / \sqrt5 , 4 / 3\sqrt5 ,- 2 / 3 ;
//  2 / \sqrt5 , 2 / 3\sqrt5 ,- 1 / 3 ;
// 0, 5 / 3\sqrt5 , 2 / 3
// )mat(
// 7,0,0;
// 0,7,0;
// 0,0,-2
// )mat(
// - 1 / \sqrt5 , 2 / \sqrt5 ,0;
//  4 / 3\sqrt5 , 2 / 3\sqrt5 , 5 / 3\sqrt5 ;
// - 2 / 3 ,- 1 / 3 , 2 / 3
// )=PDP^T
//  $
// )

// =={Spectral decomposition}

// #theorem[
// Suppose $A$ is a symmetric real-valued matrix, and $A=PDP^T$ is its orthogonal diagonalization, then we have the so-called spectral decomposition
//  $
// A=\lambda_1\mathbf u_1\mathbf u_1^T+dots.h.c+\lambda_n\mathbf u_n\mathbf u_n^T
//  $
// ]

// \begin{proof}
//  $
// A=PDP^T=mat(
// \mathbf u_1,dots.h.c,\mathbf u_n
// )mat(
// \lambda_1,,;
// ,dots.down,;
// ,,\lambda_n
// )mat(
// \mathbf u_1^T;dots.v;\mathbf u_n^T
// )=mat(
// \lambda_1\mathbf u_1,,;
// ,dots.down,;
// ,,\lambda_n\mathbf u_n
// )mat(
// \mathbf u_1^T;dots.v;\mathbf u_n^T
// )=\lambda_1\mathbf u_1\mathbf u_1^T+dots.h.c+\lambda_n\mathbf u_n\mathbf u_n^T
//  $
// \end{proof}

// #remark[
// Recall that if $\mathbf u$ is of unit length, then $\Proj_{\mathbf u}\mathbf x=\mathbf u\mathbf u^T\mathbf x$, so
//  $
// A\mathbf x=\lambda_1\mathbf u_1\mathbf u_1^T\mathbf x+dots.h.c+\lambda_n\mathbf u_n\mathbf u_n^T\mathbf x
//  $
// You can think of this as decompose the matrix transformation $\mathbf x\mapsto A\mathbf x$ into the sum of scaled orthogonal projections.
// ]

// % ={Lecture 21 - Quadratic forms}

// % Let's briefly talk about quadratic forms: $ax_1+2bx_1x_2+cx_2^2=mat(
// % x_1,x_2
// % )mat(
// % a,b;b,c
// % )mat(
// % x_1;x_2
// % )=\mathbf x^TA\mathbf x$. In Example @(12:47-07/20/2022), $\mathbf x^TA\mathbf x$ is the quadratic form $7x_1^2+4x_1x_2+4x_2^2$, note that $\mathbf y=P^T\mathbf x$ gives change of (orthonormal) coordinates (actually differ by a rotation) $#cases(
// % y_1,=- 1 / \sqrt5 x_1+ 1 / \sqrt5 x_2;
// % y_2,= 2 / \sqrt5 x_1+ 1 / \sqrt5 x_2
// % )$, then the quadratic form becomes $\mathbf x^TA\mathbf x=\mathbf x^TPDP^T\mathbf x=(P^T\mathbf x)^TD(P^T\mathbf x)=\mathbf y^TD\mathbf y=3y_1^2+8y_2^2$, note this is without cross term $y_1y_2$.

// % ={Lecture 22 - Singular value decomposition}

// ={Appendix}

// #theorem[
// The RREF of a matrix $A$ is unique.
// ]

// \begin{proof}
// The linear dependences of columns of $A$ is presevered under row elementary operations, thus the pivot columns are unique. And for the same reason, we know how all other entries look like.
// \end{proof}

// % \begin{lemma}\label{lem: det A lemma}
// % Suppose $A=mat(
// % B_1,*,B_2;
// % 0,h,0;
// % B_3,*,B_4
// % )$, where $h$ is the $(i,j)$-th entry. If we write $B=mat(
// % B_1,B_2;B_3,B_4
// % )$ then $\det A=(-1)^{i+j}h dot.c \det B$
// % \begin{center}
// % \begin{tikzpicture}
// % \def\XMAX{2.5};\def\YMAX{4.5};\def\ZMAX{3};
// % \begin{scope}[rotate around x=-90]
// % \coordinate (o) at (0,0,0);
// % \coordinate (v) at (1,1,2);
// % \coordinate (a) at (.5,1.2,0);
// % \coordinate (b) at (1.2,.5,0);
// % \coordinate (vpxy) at (1,1,0);
// % \coordinate (vpz) at (0,0,2);
// % \filldraw[color=pink!30] (-2,-4)--(-2,4)--(2,4)--(2,-4)--cycle;
// % \filldraw[blue!50] (o)--(a)--($(a)+(b)$)node[above]{$\det B$}--(b)--cycle;
// % \draw[color=gray!80] (-\XMAX,0,0)--(\XMAX,0,0);
// % \draw[color=gray!80] (0,-\YMAX,0)--(0,\YMAX,0);
// % \draw[->, color=gray!80] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_j$};
// % \draw[->] (o)--(v);
// % \draw[dashed] (o)--(vpxy)--(v);
// % \draw[dashed] (vpz)node[left]{$h$}--(v);
// % \end{scope}
// % \end{tikzpicture}
// % \end{center}
// % \end{lemma}

// ={Online Assignments}

// =={Online Assignment 1}

// \begin{problem}
// Rewrite the following linear systems as augmented matrices and then solve them, show all your work
// \begin{enumerate}
// - $#cases(
// 5x_1+x_2=2;
// 3x_1-x_2=6
// )$
// - $#cases(
// x_1+x_2+x_3=6;
// x_1-x_2+x_3=2;
// -x_1+x_2+x_3=4
// )$
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}
// - The augmented matrix is
// \begin{align*}
// ,mat(
// 5,1,2;
// 3,-1,6
// )xarrow(5#`R2`)mat(
// 5,1,2;
// 15,-5,30
// )xarrow(#`R2`-> #`R2`-3#`R1`)mat(
// 5,1,2;
// 0,-8,24
// )xarrow(#`R2`/(-8))mat(
// 5,1,2;
// 0,1,-3
// );
// ,xarrow(#`R1`-> #`R1`-#`R2`)mat(
// 5,0,5;
// 0,1,-3
// )xarrow(#`R1`/5)mat(
// 1,0,1;
// 0,1,-3
// )
// \end{align*}
// Thus the solution to this linear system is $#cases(
// x_1=1;x_2=-3
// )$
// - The augmented matrix is
// \begin{align*}
// ,mat(
// 1,1,1,6;
// 1,-1,1,2;
// -1,1,1,4
// )xarrow( #`R2`-> #`R2`-#`R1` \ #`R3`-> #`R3`+#`R1` )mat(
// 1,1,1,6;
// 0,-2,0,-4;
// 0,2,2,10
// )xarrow(#`R3`-> #`R3`+#`R2`)mat(
// 1,1,1,6;
// 0,-2,0,-4;
// 0,0,2,6
// );
// ,xarrow( #`R2`/(-2) \ #`R3`/3 )mat(
// 1,1,1,6;
// 0,1,0,2;
// 0,0,1,3
// )xarrow{\substack{#`R1`-> #`R1`-#`R2`-#`R3`}}mat(
// 1,0,0,1;
// 0,1,0,2;
// 0,0,1,3
// )
// \end{align*}
// Thus the solution to this linear system is $#cases(
// x_1=1;x_2=2;x_3=3
// )$
// \end{enumerate}
// ]

// \begin{problem}
// How many solutions does the following linear systems of equations have
// \begin{enumerate}
// - $#cases(
// 5x_1+7x_2=3;
// -10x_1-14x_2=-3
// )$
// - $#cases(
// 2x_1-x_2=4;
// x_1- 1 / 2 x_2=2
// )$
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}
// - The augmented matrix is
// \begin{align*}
// ,mat(
// 5,7,3;
// -10,-14,-3
// )xarrow(#`R2`-> #`R2`+2#`R1`)mat(
// 5,7,3;
// 0,0,3
// )
// \end{align*}
// Since the last column has pivot, by Theorem @(thm:sol-pivot), this linear system has no solutions
// - \begin{align*}
// ,mat(
// 2,-1,4;
// 1,- 1 / 2 ,2
// )xarrow(#`R2`-> #`R2`- 1 / 2 #`R1`)mat(
// 2,-1,4;
// 0,0,0
// )
// \end{align*}
// Since the last column has no pivot and there is a free variable $x_2$, by Theorem @(thm:sol-pivot), this linear system has infinitely solutions
// \end{enumerate}
// ]

// \begin{problem}
// Consider the following matrix
// $$
// A=mat(
// 1,2,2,3,1;
// 0,0,-1,2,1;
// 0,0,0,2,4;
// )
// $$
// \begin{enumerate}
// - Which columns are the pivot columns of $A$?
// - Write down the RREF of the this matrix
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}
// - The pivot columns of $A$ are columns 1,3,4.
// \item
// \begin{align*}
// ,Axarrow( #`R2`/(-1) \ #`R3`/2 )mat(
// 1,2,2,3,1;
// 0,0,1,-2,-1;
// 0,0,0,1,2;
// )xarrow( #`R1`-> #`R1`-3#`R3` \ #`R2`-> #`R2`+2#`R3` )mat(
// 1,2,2,0,-5;
// 0,0,1,0,3;
// 0,0,0,1,2;
// )xarrow(#`R1`-> #`R1`-2#`R2`)mat(
// 1,2,0,0,-11;
// 0,0,1,0,3;
// 0,0,0,1,2;
// )
// \end{align*}
// \end{enumerate}
// ]

// \begin{problem}
// Determine which of the following statements are true
// \begin{enumerate}
// - The following matrix is of row reduced echelon form
// $$
// mat(
// 1,2,2,3,1;
// 0,0,0,2,4;
// 0,0,-1,2,1;
// )
// $$
// - The following two matrices are equivalent
// $$
// mat(
// 1,-1,1,3,2;
// 2,4,1,2,4;
// 1,1,-3,2,1;
// )tilde
// mat(
// 1,2,2,3,1;
// 0,0,0,2,4;
// 0,0,-1,2,1;
// )
// $$
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}
// - False. $(3,3)$, $(2,4)$-th entries are pivots which breaks the ``staircase shape"
// \begin{tikzpicture}
// \node at (0,0) {$mat(
// #text(fill:red){1},2,2,3,1;
// 0,0,0,#text(fill:red){2},4;
// 0,0,#text(fill:red){-1},2,1;
// )$};
// \draw[thick, red] (-1.4,0.2)--(0.4,0.2)--(0.4,-0.2)--(-0.4,-0.2)--(-0.4,-0.6)--(1.4,-0.6);
// \end{tikzpicture}
// - False. Because
// \begin{align*}
// ,mat(
// 1,-1,1,3,2;
// 2,4,1,2,4;
// 1,1,-3,2,1;
// )xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-#`R1` )mat(
// 1,-1,1,3,2;
// 0,6,-1,-4,0;
// 0,2,-4,-1,-1;
// );
// ,xarrow(#`R2`-> #`R2`-3#`R3`)mat(
// 1,-1,1,3,2;
// 0,0,11,14,3;
// 0,2,-4,-1,-1;
// )xarrow(#`R2` arrow.l.r  #`R3`)mat(
// 1,-1,1,3,2;
// 0,2,-4,-1,-1;
// 0,0,11,14,3;
// )
// \end{align*}
// has pivot columns 1,2,3, and
// \begin{align*}
// mat(
// 1,2,2,3,1;
// 0,0,0,2,4;
// 0,0,-1,2,1;
// )xarrow(#`R2` arrow.l.r  #`R3`)mat(
// 1,2,2,3,1;
// 0,0,-1,2,1;
// 0,0,0,2,4;
// )
// \end{align*}
// has pivot columns 1,3,4. By Theorem @thm:unique-rref, they are not equivalent, otherwise they would have the same RREF, which implies same pivot columns.
// \end{enumerate}
// ]

// \begin{problem}
// Determine the value(s) of $h$ such that the matrix is the augmented matrix of a consistent linear system
// $
// mat(
// 1,h,1;
// 2,4,4;
// )
// $
// \end{problem}

// #solution[
// First consider
//  $
// mat(
// 1,h,1;
// 2,4,4;
// )xarrow(#`R2`-> #`R2`-2#`R1`)mat(
// 1,h,1;
// 0,4-2h,2;
// )
//  $
// By Theorem @(thm:sol-pivot), the linear system has solutions $<=>$ the last column is not a pivot column $<=> 4-2h!=0<=> h!=2$
// ]

// \begin{problem}
// Do the three lines $x_1-4x_2 = 1$, $2x_1-x_2 =-3$, and $-x_1 - 3x_2 = 4$ have a common point of intersection? Explain.
// \end{problem}

// #solution[
// Note that a common point of intersection would be a solution to the linear system cases(x_1-4x_2 = 1, 2x_1-x_2 =-3, -x_1 - 3x_2 = 4}, consider its augmented matrix
// \begin{align*}
// ,mat(
// 1,-4,1;
// 2,-1,-3;
// -1,-3,4
// )xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`+#`R1` )mat(
// 1,-4,1;
// 0,7,-5;
// 0,-7,5
// )xarrow(#`R3`-> #`R3`+#`R2`)mat(
// 1,-4,1;
// 0,7,-5;
// 0,0,0
// )
// \end{align*}
// By Theorem @(thm:sol-pivot), since the last column is not a pivot column, the linear system is consistent, i.e. these three lines has comon point(s) of intersection.
// ]

// =={Online Assignment 2}

// \begin{problem}
// Consider the following statements
// \begin{enumerate}
// - For any four distinct vectors $\mathbf v_1,\mathbf v_2,\mathbf v_3,\mathbf v_4$ in $RR^3$, $\operatorname{Span}\{\mathbf v_1,\mathbf v_2,\mathbf v_3,\mathbf v_4\}=RR^3$
// - Suppose we know that the augmented matrix of the linear system
//  $
// #cases(
// a_1x_1+a_2x_2+a_3x_3=d_1;
// b_1x_1+b_2x_2+b_3x_3=d_2;
// c_1x_1+c_2x_2+c_3x_3=d_3
// )
//  $
// has two pivot columns, then how many solutions could the linear system have?
// - Consider matrix equation $A\mathbf x=\mathbf 0$ where $A$ is a 3 by 4 matrix, then it always has more than one solution (obviously $\mathbf x=\mathbf0$ will be a solution)
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}
// - False. A counter-example would be $\mathbf v_1=mat(
// 1;0;0
// )$,$\mathbf v_2=mat(
// 0;1;0
// )$,$\mathbf v_3=mat(
// 1;1;0
// )$,$\mathbf v_4=mat(
// 1;-1;0
// )$, then $bold(b)=mat(
// 0;0;1
// )$ is not in $\Span\{\mathbf v_1,\mathbf v_2,\mathbf v_3,\mathbf v_4\}$ since
//  $
// mat(
// 1,0,1,1,0;
// 0,1,1,-1,0;
// 0,0,0,0,1
// )
//  $
// has pivot in the last row, and apply Theorem @(thm:sol-pivot)
// - The number of solutions could be none or infinitely many. There are in total 6 possible cases (apply Theorem @(thm:sol-pivot))
// \begin{enumerate}[label=Case \roman*:]
// - The pivot columns are 1,2, then augmented matrix is equivalent to the RREF matrix $mat(
// 1,0,*,*;
// 0,1,*,*;
// 0,0,0,0;
// )$, so the linear system have infinitely many solutions and $x_3$ is a free variable.
// - The pivot columns are 1,3, then augmented matrix is equivalent to the RREF matrix $mat(
// 1,*,0,*;
// 0,0,1,*;
// 0,0,0,0;
// )$, so the linear system have infinitely many solutions. and $x_2$ is a free variable.
// - The pivot columns are 1,4, then augmented matrix is equivalent to the RREF matrix $mat(
// 1,*,*,0;
// 0,0,0,1;
// 0,0,0,0;
// )$, so the linear system have no solutions.
// - The pivot columns are 2,3, then augmented matrix is equivalent to the RREF matrix $mat(
// 0,1,0,*;
// 0,0,1,*;
// 0,0,0,0;
// )$, so the linear system have infinitely many solutions. and $x_1$ is a free variable.
// - The pivot columns are 2,4, then augmented matrix is equivalent to the RREF matrix $mat(
// 0,1,*,0;
// 0,0,0,1;
// 0,0,0,0;
// )$, so the linear system have no solutions.
// - The pivot columns are 3,4, then augmented matrix is equivalent to the RREF matrix $mat(
// 0,0,1,0;
// 0,0,0,1;
// 0,0,0,0;
// )$, so the linear system have no solutions.
// \end{enumerate}
// \item
// \begin{align*}
// ,mat(
// *,*,*,*,0;
// *,*,*,*,0;
// *,*,*,*,0
// )=mat(
// A,\mathbf0
// )tilde mat(
// U,\mathbf0
// )
// \end{align*}
// Since it doesn't have a pivot in the last column, it must have a solution (indeed at least the trivial solution) by Theorem @(thm:sol-pivot), and since $A$ has more columns that rows, there must be a free variable, therefore it has infinitely many solutions
// \end{enumerate}
// ]

// \begin{problem}
// Answer the following questions
// \begin{enumerate}
// - Determine whether $bold(b)=mat(1;1;2)$ is in the span of $\left\{\mathbf v_1=mat(1;0;2),\mathbf v_2=mat(2;2;6),\mathbf v_3=mat(-1;-2;-4)\right\}$, why?
// - Assume $\mathbf w=mat(1;0;2)$, $\mathbf v_1=mat(1;1;0)$, $\mathbf v_2=mat(1;4;-4)$, $\mathbf v_3=mat(0;1;-1)$. Find constants $c_1,c_2$ such that $\mathbf w=c_1\mathbf v_1+c_2\mathbf v_2+2\mathbf v_3$. Show your work on how you found $c_1,c_2$.
// - Suppose
//  $
// A=mat(
// 1   ,  3    , 0,     3;
// -1   , -1  ,  -1 ,    1;
// 0    ,-4  ,   2   , -8;
// 2     ,0,     3   , -1
// )
//  $
// Is it true that for any vector $bold(b)$ in $RR^4$, matrix equation $A\mathbf x=bold(b)$ always has solution(s)? If it is, please give your reason. If it is not, please find one such $bold(b)$ and justify your answer.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}
// - Consider
// \begin{align*}
// ,mat(
// \mathbf v_1,\mathbf v_2,\mathbf v_3,bold(b)
// )=mat(
// A,bold(b)
// )=mat(
// 1,2,-1,1;
// 0,2,-2,1;
// 2,6,-4,2
// )xarrow(#`R3`-> #`R3`-2#`R1`)mat(
// 1,2,-1,1;
// 0,2,-2,1;
// 0,2,-2,0
// );
// ,xarrow(#`R3`-> #`R3`-#`R2`)mat(
// 1,2,-1,1;
// 0,2,-2,1;
// 0,0,0,-1
// )
// \end{align*}
// By Theorem @(thm:sol-pivot), $A\mathbf x=bold(b)$ has no solution, i.e. $bold(b)$ is not in $\Span\{\mathbf v_1,\mathbf v_2,\mathbf v_3\}$.
// - It is equivalent to solving $c_1\mathbf v_1+c_2\mathbf v_2=\mathbf w-2\mathbf v_3=mat(
// 1;-2;4
// )$. So we should consider augmented matrix
// \begin{align*}
// ,mat(
// 1,1,1;
// 1,4,-2;
// 0,-4,4
// )xarrow(#`R2`-> #`R2`-#`R1`)mat(
// 1,1,1;
// 0,3,-3;
// 0,-4,4
// )xarrow(#`R2`/3)mat(
// 1,1,1;
// 0,1,-1;
// 0,-4,4
// )xarrow( #`R3`-> #`R3`+4#`R2` \ #`R1`-> #`R1`-#`R2` )mat(
// 1,0,2;
// 0,1,-1;
// 0,0,0
// )
// \end{align*}
// Hence $c_1=2$, $c_2=-1$.
// \item
// \begin{align*}
// ,Axarrow( #`R2`-> #`R2`+#`R1` \ #`R4`-> #`R4`-2#`R1` )mat(
// 1   ,  3    , 0,     3;
// 0   , 2  ,  -1 ,    4;
// 0    ,-4  ,   2   , -8;
// 0     ,-6 ,     3   , -7
// )xarrow( #`R3`-> #`R3`+2#`R2` \ #`R4`-> #`R4`+3#`R2` )mat(
// 1   ,  3    , 0,     3;
// 0   , 2  ,  -1 ,    4;
// 0    ,0  ,   0   , 0;
// 0     ,0 ,    0  , 5
// )xarrow(#`R3` arrow.l.r  #`R4`)mat(
// 1   ,  3    , 0,     3;
// 0   , 2  ,  -1 ,    4;
// 0     ,0 ,    0  , 5;
// 0    ,0  ,   0   , 0
// )
// \end{align*}
// Which doesn't have pivot in the last row, so $A\mathbf x=bold(b)$ doesn't always have a solution by Theorem @(16:05-06/06/2022). To find one such $bold(b)$, you can just try (Since the range of the linear transformation $\mathbf x\mapsto A\mathbf x$ is the span of the columns of $A$ which is a hyperplane in $RR^4$, so choosing an arbitrary point is most likely not on that hyperplane, i.e. $A\mathbf x=bold(b)$ not solvable!). Here we just try $bold(b)=mat(
// 0;0;1;0
// )$, then
// \begin{align*}
// ,mat(
// A,bold(b)
// )=mat(
// 1   ,  3    , 0,     3,0;
// -1   , -1  ,  -1 ,    1,0;
// 0    ,-4  ,   2   , -8,1;
// 2     ,0,     3   , -1,0
// )xarrow( #`R2`-> #`R2`+#`R1` \ #`R4`-> #`R4`-2#`R1` )mat(
// 1   ,  3    , 0,     3,0;
// 0   , 2  ,  -1 ,    4,0;
// 0    ,-4  ,   2   , -8,1;
// 0     ,-6 ,     3   , -7,0
// );
// ,xarrow( #`R3`-> #`R3`+2#`R2` \ #`R4`-> #`R4`+3#`R2` )mat(
// 1   ,  3    , 0,     3,0;
// 0   , 2  ,  -1 ,    4,0;
// 0    ,0  ,   0   , 0,1;
// 0     ,0 ,    0  , 5,0
// )xarrow(#`R3` arrow.l.r  #`R4`)mat(
// 1   ,  3    , 0,     3,0;
// 0   , 2  ,  -1 ,    4,0;
// 0     ,0 ,    0  , 5,0;
// 0    ,0  ,   0   , 0,1
// )
// \end{align*}
// \end{enumerate}
// ]

// =={Online Assignment 3}

// \begin{problem}
// Suppose $\mathbf v_1,\mathbf v_2,\mathbf v_3$ are vectors in $RR^4$, if $\{\mathbf v_1,\mathbf v_2\}$ is linearly independent, $\{\mathbf v_2,\mathbf v_3\}$ is linearly independent, and $\{\mathbf v_1,\mathbf v_3\}$ is linearly independent, then $\{\mathbf v_1,\mathbf v_2,\mathbf v_3\}$ is linearly independent
// \end{problem}

// #solution[
// False. For example $\left\{\mathbf v_1=mat(
// 1;0;0;0
// ),\mathbf v_2=mat(
// 0;1;0;0
// ),\mathbf v_3=mat(
// 1;1;0;0
// )\right\}$
// ]

// \begin{problem}
// Suppose $A$ is a $m$ by $n$ matrix, and the matrix equation $A\mathbf x=bold(b)$ always has solution for any vector $bold(b)$ in $RR^m$, the columns of $A$ are linearly independent
// \end{problem}

// #solution[
// False. There could be free variables
// ]

// \begin{problem}
// Solve the linear system $#cases(
// x_1+x_2+x_3+x_4=1;
// 2x_1-x_2+x_3-x_4=-1;
// )$ and express its solution set in parametric vector form
// \end{problem}

// #solution[
// Write the augmented matrix
// \begin{align*}
// ,mat(
// 1,1,1,1,1;
// 2,-1,1,-1,-1
// )xarrow(#`R2`-> #`R2`-2#`R1`)mat(
// 1,1,1,1,1;
// 0,-3,-1,-3,-3
// )xarrow(#`R2`/(-3))mat(
// 1,1,1,1,1;
// 0,1, 1 / 3 ,1,1
// );
// ,xarrow(#`R1`-> #`R1`-#`R2`)mat(
// 1,0, 2 / 3 ,0,0;
// 0,1, 1 / 3 ,1,1
// )
// \end{align*}
// So the solution set is
//  $
// \systeme*{x_1+ 2 / 3 x_3=0, x_2+ 1 / 3 x_3+x_4=1} => #cases(
// x_1=- 2 / 3 x_3;
// x_2=1- 1 / 3 x_3-x_4;
// x_3\text{ is free};
// x_4\text{ is free}
// )
//  $
// Its parametric vector form is
//  $
// mat(
// x_1;x_2;x_3;x_4
// )=mat(
// - 2 / 3 x_3;1- 1 / 3 x_3-x_4;x_3;x_4
// )=mat(
// 0;1;0;0
// )+mat(
// - 2 / 3 x_3;- 1 / 3 x_3;x_3;0
// )+mat(
// 0;-x_4;0;x_4
// )=mat(
// 0;1;0;0
// )+x_3mat(
// - 2 / 3 ;- 1 / 3 ;1;0
// )+x_4mat(
// 0;-1;0;1
// )
//  $
// ]

// \begin{problem}
// Suppose $\mathbf v_1=mat(
// 1;0;1
// )$, $\mathbf v_2=mat(
// 0;-1;1
// )$, $\mathbf v_3=mat(
// -2;3;-11
// )$, $\mathbf v_4=mat(
// 0;0;-3
// )$. Is $\{\mathbf v_1,\mathbf v_2,\mathbf v_3,\mathbf v_4\}$ linearly independent? If so, please give your reason, if not, please find a linear dependence (i.e. some linear combination $c_1\mathbf v_1+c_2\mathbf v_2+c_2\mathbf v_3+c_4\mathbf v_4=0$, $c_1,c_2,c_3,c_4$ not all zero)
// \end{problem}

// #solution[
// Consider
// \begin{align*}
// ,mat(
// \mathbf v_1,\mathbf v_2,\mathbf v_3,\mathbf v_4,\mathbf0
// )=mat(
// 1,0,-2,0,0;
// 0,-1,3,0,0;
// 1,1,-11,-3,0
// )xarrow(#`R3`-> #`R3`-#`R1`)mat(
// 1,0,-2,0,0;
// 0,-1,3,0,0;
// 0,1,-9,-3,0
// );
// ,xarrow(#`R3`-> #`R3`+#`R2`)mat(
// 1,0,-2,0,0;
// 0,-1,3,0,0;
// 0,0,-6,-3,0
// )xarrow( (-1)#`R2` \ #`R3`/(-6) )mat(
// 1,0,-2,0,0;
// 0,1,-3,0,0;
// 0,0,1, 1 / 2 ,0
// )xarrow( #`R1`-> #`R1`+2#`R3` \ #`R2`-> #`R2`+3#`R3` )mat(
// 1,0,0,1,0;
// 0,1,0, 3 / 2 ,0;
// 0,0,1, 1 / 2 ,0
// )
// \end{align*}
// So the solution set is
//  $
// #cases(
// x_1=-x_4;x_2=- 3 / 2 x_4;x_3=- 1 / 2 x_4;x_4\text{ is free}
// )
//  $
// We can choose $x_4=-2$, then $x_1=2, x_2=3, x_3=1$ so that we know $2\mathbf v_1+3\mathbf v_2+\mathbf v_3-2\mathbf v_4=\mathbf0$ is a linear dependence.
// ]

// \begin{problem}
// Suppose linear transformation $T:RR^2->RR^2$ rotates the plane $RR^2$ counter-clockwise by $120^\circ$, what is the standard matrix for the this linear transformation?
// \end{problem}

// #solution[
// the standard matrix for $T$ is
//  $
// A=mat(
// T(\mathbf e_1),T(\mathbf e_2)
// )=mat(
// - 1 / 2 ,-\frac{\sqrt{3}}{2};
// \frac{\sqrt{3}}{2},- 1 / 2
// )
//  $
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \def\XMAX{1.5};\def\YMAX{1.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \draw[opacity=0.6, red, dashed] (0,0) circle (1);
// \coordinate (a) at (1,0); \node at (a)[below right]{$\mathbf e_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$\mathbf e_2$}; \draw[->, thick] (0,0)--(b);
// \coordinate (c) at ($cos(120)*(1,0)+sin(120)*(0,1)$); \node at (c)[above left]{\textcolor{purple}{$T(\mathbf e_1)$}}; \draw[->, purple, thick] (0,0)--(c);
// \coordinate (d) at ($cos(210)*(1,0)+sin(210)*(0,1)$); \node at (d)[below left]{#text(fill:blue)[$T(\mathbf e_2)$]}; \draw[->, blue, thick] (0,0)--(d);
// \draw[opacity=0.6, purple, dashed] (c)--($cos(120)*(1,0)$);
// \draw[opacity=0.6, purple, dashed] (c)--($sin(120)*(0,1)$);
// \draw[opacity=0.6, blue, dashed] (d)--($cos(210)*(1,0)$);
// \draw[opacity=0.6, blue, dashed] (d)--($sin(210)*(0,1)$);
// \end{tikzpicture}
// \end{center}
// ]

// \begin{problem}
// Suppose $T:RR^n->RR^m$ is a linear transformation and $T(\mathbf x)=A\mathbf x$, where $$A=mat(
// 1,2,3;
// 0,2,1
// ).$$
// What is $n$ and $m$? Find the preimage of $mat(
// 1;2
// )$ under $T$. Is $T$ one-to-one? Is $T$ onto?
// \end{problem}

// #solution[
// $m=2$, $n=3$, the preimage of $bold(b)=mat(
// 1;2
// )$ under $T$ will be the solution to $A\mathbf x=bold(b)$, so we have
// \begin{align*}
// ,mat(
// A,bold(b)
// )=mat(
// 1,2,3,1;
// 0,2,1,2
// )tilde mat(
// 1,0,2,-1;
// 0,1, 1 / 2 ,1
// )
// \end{align*}
// The solution set is given in parametric vector form
//  $
// mat(
// -1;1;0
// )+x_3mat(
// -2;- 1 / 2 ;1
// )
//  $
// Therefore $T$ is not one-to-one but onto.
// ]

// =={Online Assignment 4}

// \begin{problem}
// Suppose $A=mat(
// 1,2,1;
// 2,1,2;
// 0,2,1;
// )$.
//
// - Determine if $A$ is invertible, if not, explain why, if it is, find the inverse matrix $A^{-1}$
// - Find $A^T$, the transpose of $A$. Is $A^T$ invertible? If yes, please evaluate $(A^T)^{-1}$
//

// Please show all your work.
// \end{problem}

// #solution[
//
// - $A$ is invertible
// \begin{align*}
// ,\left[\begin{array}{ccc|ccc}
// 1,2,1,1,0,0;
// 2,1,2,0,1,0;
// 0,2,1,0,0,1
// \end{array}\right]xarrow(#`R2`-> #`R2`-2#`R1`)\left[\begin{array}{ccc|ccc}
// 1,2,1,1,0,0;
// 0,-3,0,-2,1,0;
// 0,2,1,0,0,1
// \end{array}\right];
// ,xarrow(#`R2`/(-3))\left[\begin{array}{ccc|ccc}
// 1,2,1,1,0,0;
// 0,1,0, 2 / 3 ,- 1 / 3 ,0;
// 0,2,1,0,0,1
// \end{array}\right]xarrow(#`R3`-> #`R3`-2#`R2`)\left[\begin{array}{ccc|ccc}
// 1,2,1,1,0,0;
// 0,1,0, 2 / 3 ,- 1 / 3 ,0;
// 0,0,1,- 4 / 3 , 2 / 3 ,1
// \end{array}\right];
// ,xarrow(#`R3`-> #`R3`-2#`R2`-#`R3`)\left[\begin{array}{ccc|ccc}
// 1,0,0,1,0,-1;
// 0,1,0, 2 / 3 ,- 1 / 3 ,0;
// 0,0,1,- 4 / 3 , 2 / 3 ,1
// \end{array}\right]
// \end{align*}
// Hence $A^{-1}=mat(
// 1,0,-1;
//  2 / 3 ,- 1 / 3 ,0;
// - 4 / 3 , 2 / 3 ,1;
// )$
// - $A^T=mat(
// 1,2,0;
// 2,1,2;
// 1,2,1;
// )$, and $(A^T)^{-1}=(A^{-1})^T=mat(
// 1, 2 / 3 ,- 4 / 3 ;
// 0,- 1 / 3 , 2 / 3 ;
// -1,0,1;
// )$
//
// ]

// \begin{problem}
// Suppose $A=mat(
// - 1 / 2 ,-\frac{\sqrt{3}}{2};\frac{\sqrt{3}}{2},- 1 / 2
// )$ is the standard matrix for the linear transformation of rotating $120^\circ$ counter-clockwise. Evaluate $A^{24}$ and explain why.
// \end{problem}

// #solution[
// Note that $A^{24}$ is the standard matrix for the composition of linear transformations $\overbrace{T\circ T\circdots.h.c\circ T}^{24}$ which is rotate $24 times 120^\circ=8 times  360^\circ$, which is the same as rotate $0^\circ$, so we should have $A^{24}=I$, the identity matrix.
// ]

// \begin{problem}
// We say $n$ is the #text(fill:blue)[order]#index[order] of a square matrix $A$ if $n$ is the smallest positive integer such that $A^n=I$, where $I$ is the identity matrix. Suppose $T:RR^2->RR^2$ is the linear transformation of reflecting over $x_1$-axis, and $A$ is the standard matrix of $T$, the order of $A$ is
// \end{problem}

// #solution[
// Note that $T\circ T$ is reflecting over $x_2$-axis twice, which amounts to doing nothing, so $A^2$ as the standard matrix of $T\circ T$ is the identity matrix, i.e. the order of $A$ is 2.
// ]

// \begin{problem}
// If $A,B$ are both invertible, then $A+B$ is also invertible
// \end{problem}

// #solution[
// False. For example we can take $B=-A=-I$, then $A+B=0$ which is not invertible.
// ]

// \begin{problem}
// We call $q(x_1,x_2)=ax_1^2+2bx_1x_2+cx_2^2$ a #text(fill:blue)[quadratic form]#index[quadratic form], $a,b,c$ are constants. Suppose $\mathbf x=mat(x_1;x_2)$, try to rewrite $q(x_1,x_2)$ as the form of a matrix multiplication $\mathbf x^TA\mathbf x$, where $A$ is a #text(fill:blue)[symmetric matrix]#index[symmetric matrix] (i.e. $A^T=A$). Please find $A$.
// \end{problem}

// #solution[
// We should choose $A=mat(
// a,b;b,c
// )$, then
//  $
// \mathbf x^TA\mathbf x=mat(
// x_1,x_2
// )mat(
// a,b;b,c
// )mat(
// x_1;x_2
// )=mat(
// ax_1+bx_2,bx_1+cx_2
// )mat(
// x_1;x_2
// )=ax_1^2+2bx_1x_2+cx_2^2=q(x_1,x_2)
//  $
// ]

// \begin{problem}
// Suppose $T:RR^3->RR^3$ is a linear transformation defined by $T\left(mat(x_1;x_2;x_3)\right)=mat(x_1-2x_2+x_3;2x_2+3x_3;x_1-x_3)$. Please find $T^{-1}$, then standard matrix for $T^{-1}$. Is $T^{-1}$ onto? Is $T^{-1}$ is one-to-one? Show all your work.
// \end{problem}

// #solution[
// Note that $T(\mathbf x)=A\mathbf x$, where $A=mat(
// 1,-2,1;
// 0,2,3;
// 1,0,-1
// )$, use the algorithm to find $A^{-1}$
// \begin{align*}
// ,\left[\begin{array}{ccc|ccc}
// 1,-2,1,1,0,0;
// 0,2,3,0,1,0;
// 1,0,-1,0,0,1
// \end{array}\right]xarrow(#`R3`-> #`R3`-#`R1`)\left[\begin{array}{ccc|ccc}
// 1,-2,1,1,0,0;
// 0,2,3,0,1,0;
// 0,2,-2,-1,0,1
// \end{array}\right];
// ,xarrow(#`R3`-> #`R3`-#`R2`)\left[\begin{array}{ccc|ccc}
// 1,-2,1,1,0,0;
// 0,2,3,0,1,0;
// 0,0,-5,-1,-1,1
// \end{array}\right]xarrow( #`R2`/2 \ #`R3`/(-5) )\left[\begin{array}{ccc|ccc}
// 1,-2,1,1,0,0;
// 0,1, 3 / 2 ,0, 1 / 2 ,0;
// 0,0,1, 1 / 5 , 1 / 5 ,- 1 / 5
// \end{array}\right];
// ,xarrow(#`R2`-> #`R2`- 3 / 2 #`R3`)\left[\begin{array}{ccc|ccc}
// 1,-2,1,1,0,0;
// 0,1,0,- 3 / 10 , 1 / 5 , 3 / 10 ;
// 0,0,1, 1 / 5 , 1 / 5 ,- 1 / 5
// \end{array}\right]xarrow(#`R1`-> #`R1`+2#`R2`-#`R3`)\left[\begin{array}{ccc|ccc}
// 1,-2,1, 1 / 5 , 1 / 5 , 4 / 5 ;
// 0,1,0,- 3 / 10 , 1 / 5 , 3 / 10 ;
// 0,0,1, 1 / 5 , 1 / 5 ,- 1 / 5
// \end{array}\right]
// \end{align*}
// Hence $A^{-1}=mat(
//  1 / 5 , 1 / 5 , 4 / 5 ;
// - 3 / 10 , 1 / 5 , 3 / 10 ;
//  1 / 5 , 1 / 5 ,- 1 / 5
// )$, so we have $T^{-1}\left(mat(y_1;y_2;y_3)\right)=mat(
//  1 / 5 y_1+ 1 / 5 y_2+ 4 / 5 y_3;
// - 3 / 10 y_1+ 1 / 5 y_2+ 3 / 10 y_3;
//  1 / 5 y_1+ 1 / 5 y_2- 1 / 5 y_3
// )$. $T^{-1}$ is both onto and one-to-one.
// ]

// \begin{problem}
// An #text(fill:blue)[affine transformation]#index[affine transformation] is a mapping $T:RR^2->RR^2$ defined by $T(\mathbf x)=A\mathbf x+bold(b)$, Note that $A\mathbf x+bold(b)=mat(A,bold(b))mat(\mathbf x;1)$. If we use partitioned matrix and deploying the trick of ``adding" 1 at the end of the coordinates, then $T$ may be interpreted as a matrix transformation $mat(T(\mathbf x);1)=mat(A\mathbf x+bold(b);1)=mat(A,bold(b);0,1)mat(\mathbf x;1)$
//
// \item
// Suppose $T_1(\mathbf x)=A_1\mathbf x+bold(b)_1$ and $T_2(\mathbf x)=A_2\mathbf x+bold(b)_2$ are both affine transformations. What is the composition $T_2\circ T_1$? How should you deploy the trick?
// - Suppose $T(\mathbf x)=A\mathbf x+bold(b)$ is an affine transformation and $A$ is invertible. What is $T^{-1}$? How should you deploy the trick?
//
// \end{problem}

// #solution[
//
// - $(T_2\circ T_1)(\mathbf x)=T_2(T_1(\mathbf x))=A_2(T_1(\mathbf x))+bold(b)_2=A_2(A_1\mathbf x+bold(b)_1)+bold(b)_2=A_2A_1\mathbf x+(A_2bold(b)_1+bold(b)_2)$, this can be explained use the trick as follows
//  $
// mat(A_2,bold(b)_2;0,1)mat(A_1,bold(b)_1;0,1)=mat(A_2A_1,A_2bold(b)_1+bold(b)_2;0,1)
//  $
// - The inverse should be $T^{-1}(\mathbf y)=A^{-1}\mathbf y-A^{-1}bold(b)$, via the trick we can interpreted it as
//  $
// mat(A,bold(b);0,1)^{-1}=mat(A^{-1},-A^{-1}bold(b);0,1)
//  $
// Since
//  $
// mat(A^{-1},-A^{-1}bold(b);0,1)mat(A,bold(b);0,1)=mat(I,\mathbf 0;0,1)=mat(A,bold(b);0,1)mat(A^{-1},-A^{-1}bold(b);0,1)
//  $
//
// ]

// =={Online Assignment 5}

// \begin{problem}
// Suppose $A=mat(
// 1,2,2;
// 2,1,3;
// -1,2,0
// )$. Use cofactor expansion of $A$ across the last row to evaluate the determinant of $A$
// \end{problem}

// #solution[
// \begin{align*}
// ,\left|\begin{matrix}
// 1,2,2;
// 2,1,3;
// -1,2,0
// \end{matrix}\right|=(-1) dot.c (-1)^{3+1}\left|\begin{matrix}
// 2,2;
// 1,3
// \end{matrix}\right|+2 dot.c (-1)^{3+2}\left|\begin{matrix}
// 1,2;
// 2,3;
// \end{matrix}\right|+0;
// ,=(-1)(2 dot.c 3-2 dot.c 1)+(-2)(1 dot.c 3-2 dot.c 2)=-2
// \end{align*}
// ]

// \begin{problem}
// Compute the determinant of $A=mat(
// 1,2,2,-1;
// 0,2,0,0;
// 3,5,2,3;
// 2,1,0,-1
// )$. Is $A$ invertible?
// \end{problem}

// #solution[
// \begin{align*}
// ,\left|\begin{matrix}
// 1,2,2,-1;
// 0,2,0,0;
// 3,5,2,3;
// 2,1,0,-1
// \end{matrix}\right|\xequal{\text{cofactor expansion second row}}2(-1)^{2+2}\left|\begin{matrix}
// 1,2,-1;
// 3,2,3;
// 2,0,-1
// \end{matrix}\right|\xequal{ #`R2`-> #`R3`-3#`R1` \ #`R3`-> #`R3`-2#`R1` }2\left|\begin{matrix}
// 1,2,-1;
// 0,-4,6;
// 0,-4,1
// \end{matrix}\right|;
// ,\xequal{#`R3`-> #`R3`-#`R2`}2\left|\begin{matrix}
// 1,2,-1;
// 0,-4,6;
// 0,0,-5
// \end{matrix}\right|=2 dot.c 1 dot.c (-4) dot.c (-5)=40
// \end{align*}
// $A$ is invertible since $\det A!=0$
// ]

// \begin{problem}
// Consider the parallelgram $P$ with vertices $(-2,-3),(-1,1),(2,4),(3,8)$, use determinants to evaluate the area of $P$
// \end{problem}

// #solution[
// Name these four points $p_1,p_2,p_3,p_4$, and the vectors $\mathbf a_1=mat(
// 1;4
// )$ and $\mathbf a_2=mat(
// 4;7
// )$. And we consider $A=mat(
// \mathbf a_1,\mathbf a_2
// )=mat(
// 1,4;
// 4,7
// )$, then area of $P$ would be
//  $
// \left|\det A\right|=\left|(1 dot.c 7-4 dot.c 4))\right|=9
//  $
// \begin{center}
// \begin{tikzpicture}[scale=0.4]
// \def\XMAX{3.5};\def\YMAX{8.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX+5) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX+5)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (p1) at (-2,-3); \node at (p1)[above left]{$p_1$};
// \coordinate (p2) at (-1,1); \node at (p2)[above left]{$p_2$};
// \coordinate (p3) at (2,4); \node at (p3)[below right]{$p_3$};
// \coordinate (p4) at (3,8); \node at (p4)[above left]{$p_4$};
// \draw[blue] (p1)--(p2)--(p4)--(p3)--cycle;
// \draw[->,ultra thick,blue] (p1)--(p2);
// \draw[->,ultra thick,blue] (p1)--(p3);
// \end{tikzpicture}
// \end{center}
// ]

// \begin{problem}
// $\det(A-B)=\det A-\det B$
// \end{problem}

// #solution[
// This is false, for example, we could just take $A=I=mat(
// 1,0;0,1
// )$, $B=-I$, then $4=\det(2I)=\det(A-B)!= \det A-\det B=1-1=0$
// ]

// \begin{problem}
// If $A$ is a 3 by 3 matrix, then $\det(2A)=8(\det A)$
// \end{problem}

// #solution[
// This is true.
// ]

// \begin{problem}
// Suppose $A,B$ are both 3 by 3 matrices, and $\det A=2$, $\det B= 1 / 3 $, then the determinant of $A^TB^{-1}$ is
// \end{problem}

// #solution[
// $\det(A^TB^{-1})=\det(A^T)\det(B^{-1})=(\det A)(\det B)^{-1}=2 dot.c  3=6$.
// ]

// \begin{problem}
// Suppose $A$ is a 3 by 3 matrix with entries integers, and $A^3=I$ is the identity matrix. Then the determinant of $A$ has to be
// \end{problem}

// #solution[
// $\det A$ must be some real number. $1=\det I=\det(A^3)=(\det A)^3 =>  \det A=\sqrt[3]{1}=1$.
// ]

// =={Online Assignment 6}

// \begin{problem}
// Suppose $A=mat(
// 1,2,1,2,-1,3;
// 0,0,0,0,1,-1;
// 0,0,1,3,1,-2;
// )$
// \begin{enumerate}[label=\alph*)]
// - Find a basis for the null space of $A$
// - Find a basis for the column space of $A$
// - Find a basis for the row space of $A$
// \end{enumerate}
// \end{problem}

// #solution[
// First realize
//  $
// Axarrow(#`R2` arrow.l.r  #`R3`)mat(
// 1,2,1,2,-1,3;
// 0,0,1,3,1,-2;
// 0,0,0,0,1,-1;
// )tilde mat(
// 1,2,0,-1,0,3;
// 0,0,1,3,0,-1;
// 0,0,0,0,1,-1;
// )
//  $
// Hence the solution in parametric form is $x_2mat(
// -2;1;0;0;0;0
// )+x_4mat(
// 1;0;-3;1;0;0
// )+x_6mat(
// -3;0;1;0;1;1
// )$. And the pivot columns are the 1st, 3rd and 5th columns
// \begin{enumerate}[label=\alph*)]
// - A basis for $\Nul A$ could be $\left\{mat(
// -2;1;0;0;0;0
// ),mat(
// 1;0;-3;1;0;0
// ),mat(
// -3;0;1;0;1;1
// )\right\}$
// - A basis for $\Col A$ could be $\left\{mat(
// 1;0;0
// ),mat(
// 1;0;1
// ),mat(
// -1;1;1
// )\right\}$
// - A basis for $\Row A$ could be
//  $
// \left\{mat(
// 1,2,0,-1,0,3
// ),mat(
// 0,0,1,3,0,-1
// ),mat(
// 0,0,0,0,1,-1
// )\right\}
//  $
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $A=mat(
// 3,-1,-5;
// 1,1,-1;
// -2,2,4;
// )$
// \begin{enumerate}[label=\alph*)]
// - Determine whether $\mathbf u=mat(
// -3;1;-2
// )$ is in the null space of $A$. Explain your reasoning.
// - Determine whether $bold(b)=mat(
// 1;-3;-4
// )$ is in the column space of $A$. Explain your reasoning.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - $\mathbf u\in\Nul A$ since $A\mathbf u=\mathbf0$
// - $bold(b)\in\Col A$ since linear system $A\mathbf x=bold(b)$ is consistent
// \end{enumerate}
// ]

// \begin{problem}
// Recall $\mathbb P_2=\{a_0+a_1t+a_2t^2|a_0,a_1,a_2\inRR\}$ is the set of polynomials of degree less or equal to 2. Let $V$ be the subset of $\mathbb P_2$ consists of polynomials that evalute to 0 at $t=1$ (i.e. polynomial $p(t)$ is in $V$ if $p(1)=0$ and of degree less or equal to 2). With the usual addition and scalar multiplication for polynomials
// \begin{enumerate}[label=\alph*)]
// - Show that $V$ is a subspace.
// - Find a basis of $V$.
// - Cosider $T:V->RR^2$ that maps polynomial $p(t)$ to $mat(
// p(-1);p(2)
// )$, show $T$ is a linear transformation
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - Realize that $V=\ker S$ for the linear transformation $S:\mathbb P_2->RR$, $S(a_0+a_1t+a_2t^2)=a_0+a_1+a_2$, thus $V$ is a subspace of $\mathbb P_2$
// - This is precisely Example @(10:24-07/01/2022)
// - For any $p(t),q(t)\in V$ and $c\inRR$, we have
//  $
// T(p+q)=mat(
// (p+q)(-1);(p+q)(2)
// )=mat(
// p(-1)+q(-1);p(2)+q(2)
// )=mat(
// p(-1);p(2)
// )+mat(
// q(-1);q(2)
// )=T(p)+T(q)
//  $
//  $
// T(cp)=mat(
// (cp)(-1);(cp)(2)
// )=mat(
// c dot.c  p(-1);c dot.c  p(2)
// )=cmat(
// p(-1);p(2)
// )=cT(p)
//  $
// Therefore $T:V->RR^2$ is a linear transformation
// \end{enumerate}
// ]

// \begin{problem}
// We say a square matrix $A$ is #text(fill:blue)[anti-symmetric]#index[anti-symmetric] if $A^T=-A$. Denote the set of $3 times 3$ anti-symmetric matrices $V$.
// \begin{enumerate}[label=\alph*)]
// - Show that $V$ is a vector space.
// - What is the dimension of $V$?
// - Find a basis of $V$.
// - Show that
//  $
// \mathcal B=\left\{B_1=mat(
// 0,-1,-1;
// 1,0,-1;
// 1,1,0;
// ),B_2=mat(
// 0,2,0;
// -2,0,-1;
// 0,1,0;
// ),B_3=mat(
// 0,-1,-2;
// 1,0,-3;
// 2,3,0;
// )\right\}
//  $
// form a basis for $V$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - For any $A,B\in V$ and $c\inRR$, by definition $A^T=-A, B^T=-B$, so
//  $
// (A+B)^T=A^T+B^T=-A-B=-(A+B)
//  $
//  $
// (cA)^T=cA^T=c(-A)=-(cA)
//  $
// hence $A+B,cA\in V$, i.e. $V$ is a closed under addition and scalar multiplication. Therefore $V$ is a subspace of $M_{3 times 2}(RR)$, and consequently a vector space.
// - It is not hard to realize
//  $
// V=\left\{mat(
// 0,-a,-b;
// a,0,-c;
// b,c,0
// )\in\ M_{3 times 3}(RR)\middle|a,b,c\inRR\right\}\congRR^3
//  $
// Thus $\dim V=3$
// - Note that
// $ \label{14:56-06/24/2022}
// \begin{aligned}
// mat(
// 0,-a,-b;
// a,0,-c;
// b,c,0
// ),=mat(
// 0,-a,0;
// a,0,0;
// 0,0,0
// )+mat(
// 0,0,-b;
// 0,0,0;
// b,0,0
// )+mat(
// 0,0,0;
// 0,0,-c;
// 0,c,0
// );
// ,=amat(
// 0,-1,0;
// 1,0,0;
// 0,0,0
// )+bmat(
// 0,0,-1;
// 0,0,0;
// 1,0,0
// )+cmat(
// 0,0,0;
// 0,0,-1;
// 0,1,0
// )
// \end{aligned}
// $
// So we know that
//  $
// \mathcal E=\{E_1,E_2,E_3\}=
// \left\{
// mat(
// 0,-1,0;
// 1,0,0;
// 0,0,0
// ),mat(
// 0,0,-1;
// 0,0,0;
// 1,0,0
// ),mat(
// 0,0,0;
// 0,0,-1;
// 0,1,0
// )\right\}
//  $
// is a basis for $V$, this is linearly independent since the linear combination \eqref{14:56-06/24/2022} is equal to zero $<=> a=b=c=0$
// - Check that the coordinate vectors $\{[B_1]_{\mathcal E},[B_2]_{\mathcal E},[B_3]_{\mathcal E}\}=\left\{mat(
// 1;1;1
// ),mat(
// -2;0;1
// ),mat(
// 1;2;3
// )\right\}$ form a basis for $RR^3$, so $\mathcal B$ form a basis for $V$.
// \end{enumerate}
// ]

// =={Online Assignment 7}

// \begin{problem}
// Suppose $\mathbf v$ is an eigenvector for matrices $A$ and $B$, then $\mathbf v$ is an eigenvector for $A+B$ and $AB$.
// \end{problem}

// #solution[
// This is true. Since $\mathbf v$ is an eigenvector for both $A$ and $B$, there exist eigenvalues $\lambda_1,\lambda_2$ such that $A\mathbf v=\lambda_1\mathbf v$, $B\mathbf v=\lambda_2\mathbf v$, so we have $(A+B)\mathbf v=A\mathbf v+B\mathbf v=\lambda_1\mathbf v+\lambda_2\mathbf v=(\lambda_1+\lambda_2)\mathbf v$. In other words, $\mathbf v$ is an eigenvector for $A+B$ with eigenvalue $\lambda_1+\lambda_2$. Similarly, we also have $AB\mathbf v=A(\lambda_1\mathbf v_1)=\lambda_2 A\mathbf v=\lambda_1\lambda_2\mathbf v$. In other words, $\mathbf v$ is an eigenvector for $AB$ with eigenvector $\lambda_1\lambda_2$
// ]

// \begin{problem}
// Suppose $t+3t^2-2t^3$ is the characteristic polynomial of a 3 by 3 matrix, then $A$ is not invertible.
// \end{problem}

// #solution[
// This is true. Note that $t=0$ is a root of the characteristic polynomial, so the null space of $A$ is not trivial, $A$ is not invertible.
// ]

// \begin{problem}
// Suppose $\mathcal B=\left\{1+t,1+2t^2,1-t+t^2\right\}$ and $\mathcal C=\left\{1-t,t,t^2\right\}$ are two bases for $\mathbb P_2$, What is the change of basis matrix $\underset{\mathcal C\leftarrow\mathcal B}{P}$ from $\mathcal B$ to $\mathcal C$. Please show all your work.
// \end{problem}

// #solution[
// First let's find the change of basis matrices from $\mathcal B$ and $\mathcal C$ to the standard basis $\mathcal E=\{1,t,t^2\}$. We have
//  $
// \underset{\mathcal E\leftarrow\mathcal B}{P}=mat(
// [1+t)_{\mathcal E},[1+2t^2]_{\mathcal E},[1-t+t^2]_{\mathcal E}
// ]=mat(
// 1,1,1;
// 1,0,-1;
// 0,2,1
// )
//  $
// And
//  $
// \underset{\mathcal E\leftarrow\mathcal C}{P}=mat(
// [1-t)_{\mathcal E},[t]_{\mathcal E},[t^2]_{\mathcal E}
// ]=mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )
//  $
// Hence we have
// \begin{align*}
// \underset{\mathcal C\leftarrow\mathcal B}{P}=\left(\underset{\mathcal C\leftarrow\mathcal E}{P}\right)\left(\underset{\mathcal E\leftarrow\mathcal B}{P}\right)=\left(\underset{\mathcal E\leftarrow\mathcal C}{P}\right)^{-1}\left(\underset{\mathcal E\leftarrow\mathcal B}{P}\right)=mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )^{-1}mat(
// 1,1,1;
// 1,0,-1;
// 0,2,1
// )=mat(
// 1       ,       1  ,            1       ;
// 2        ,      1 ,             0       ;
// 0         ,     2,              1
// )
// \end{align*}
// ]

// \begin{problem}
// If $Nul A$ is 2-dimensional, then $0$ is an eigenvalue of $A$.
// \end{problem}

// #solution[
// This is true. Since if $\Nul A$ is 2-dimensional, then $\Nul A$ is non-trivial, thus $0$ is an eigenvalue of $A$
// ]

// \begin{problem}
// Is $mat(0;0;1)$ an eigenvector of $mat(2,0,0;3,2,0;0,4,3)$? If so, find the corresponding eigenvalue, if not, please explain why.
// \end{problem}

// #solution[
// Note that $mat(2,0,0;3,2,0;0,4,3)mat(0;0;1)=mat(0;0;3)$. so $mat(0;0;1)$ is an eigenvector with eigenvalue 3
// ]

// \begin{problem}
// Find all eigenvalues of $A=mat(6,-2,0;-2,9,0;5,8,3)$. Please show all your work.
// \end{problem}

// #solution[
// \begin{align*}
// \left|tI-A\right|,=\left|\begin{matrix}
// t-6,2,0;
// 2,t-9,0;
// -5,-8,t-3
// \end{matrix}\right|\xequal{\text{cofator expansion across 3rd column}}(t-3)(-1)^{3+3}\left|\begin{matrix}
// t-6,2;
// 2,t-9
// \end{matrix}\right|;
// ,=(t-3)((t-6)(t-9)-2 dot.c  2)=(t-3)(t^2-5t+50)=(t-3)(t-5)(t-10)
// \end{align*}
// Therefore eigenvalues for $A$ are 3,5,10.
// ]

// \begin{problem}
// Assume that $A$ is similar to an upper triangular matrix $U$, then $\det A$ is the product of all its eigenvalues (counting multiplicity). Please explain why.
// \end{problem}

// #solution[
// Suppose the diagonal elements of $A$ are $\lambda_1,dots.h.c,\lambda_n$, then the charateristic polynomial of $A$ is the same the charateristic polynomial $U$ (Since they are similar) which would be $(t-\lambda_1)dots.h.c(t-\lambda_n)$, so $\lambda_1,dots.h.c,\lambda_n$ are the eigenvalues for $A$. And the determinant of $A$ is the same as the determinant of $U$ (Since they are similar) which is $\lambda_1dots.h.c\lambda_n$
// ]

// =={Online Assignment 8}

// \begin{problem}
// Suppose $A=mat(
// 2,2,1;
// 1,3,1;
// 1,2,2
// )$, determine whether $A$ is diagonalizable. If it is, please find a diagonalization. If not, please explain why.
// \end{problem}

// #solution[
// First we evaluate the characteristic polynomial of $A$
// \begin{align*}
// \det(tI-A),=\left|\begin{matrix}
// t-2,-2,-1;
// -1,t-3,-1;
// -1,-2,t-2
// \end{matrix}\right|\xequal{ #`R1`-> #`R1`+(t-2)#`R3` \ #`R2`-> #`R2`-#`R3` }\left|\begin{matrix}
// 0,-2(t-1),(t-1)(t-3);
// 0,t-1,-(t-1);
// -1,-2,t-2
// \end{matrix}\right|;
// ,\xequal{\text{factor out $(t-1)$ on row 1 and row 2}}(t-1)^2\left|\begin{matrix}
// 0,-2,(t-3);
// 0,1,-1;
// -1,-2,t-2
// \end{matrix}\right|=(t-1)^2(t-5)
// \end{align*}
// So the eigenvalues are $\lambda_1=\lambda_2=1$, $\lambda_3=5$. For the 1-eigenspace, we consider
// \begin{align*}
// \left[\begin{array}{c|c}
// I-A,\mathbf0
// \end{array}\right],=
// \left[\begin{array}{ccc|c}
// -1,-2,-1,0;
// -1,-2,-1,0;
// -1,-2,-1,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,2,1,0;
// 0,0,0,0;
// 0,0,0,0
// \end{array}\right]
// \end{align*}
// So we get two basis vectors $\left\{\mathbf v_1=mat(
// -2;1;0
// ),\mathbf v_2=mat(
// -1;0;1
// )\right\}$. For the 5-eigenspace, we consider
// \begin{align*}
// \left[\begin{array}{c|c}
// 5I-A,\mathbf0
// \end{array}\right],=
// \left[\begin{array}{ccc|c}
// 3,-2,-1,0;
// -1,2,-1,0;
// -1,-2,3,0
// \end{array}\right]tilde \left[\begin{array}{ccc|c}
// 1,0,-1,0;
// 0,1,-1,0;
// 0,0,0,0
// \end{array}\right]
// \end{align*}
// So we get a basis vector $\left\{\mathbf v_3=mat(
// 1;1;1
// )\right\}$
// - From above, we get the diagonalization
//  $
// A=PDP^{-1}=mat(
// -2,-1,1;
// 1,0,1;
// 0,1,1
// )mat(
// 1,0,0;
// 0,1,0;
// 0,0,5
// )mat(
// - 1 / 4 , 1 / 2 ,- 1 / 4 ;
// - 1 / 4 ,- 1 / 2 , 3 / 4 ;
//  1 / 4 , 1 / 2 , 1 / 4
// )
//  $
// ]

// \begin{problem}
// Suppose $A=mat(
// -6,8;
// -4,6
// )$, Please evaluate $A^{101}$, show all your work.
// \end{problem}

// #solution[
// First we can diagonalize $A$ as
//  $
// A=mat(
// 1,2;
// 1,1
// )mat(
// 2,0;
// 0,-2
// )mat(
// -1,2;
// 1,-1
// )
//  $
//  $
// A^{101}=PD^{101}P^{-1}=mat(
// 1,2;
// 1,1
// )mat(
// 2^{101},0;
// 0,-2^{101}
// )mat(
// -1,2;
// 1,-1
// )
//  $
// ]

// \begin{problem}
// Suppose $T:RR^3->RR^3$ is a linear transformation, $\mathcal B=\{bold(b)_1,bold(b)_2,bold(b)_3\}$, $\mathcal C=\{\mathbf c_1,\mathbf c_2,\mathbf c_3\}$ are two different bases for $RR^3$. Determine whether the following is possible.
// \begin{enumerate}[label=\alph*)]
// - $[T]_{\mathcal B}=mat(
// 1 ,2,4;
// 3 ,-1 ,-2;
// 2 ,-1, 3
// )$ and $[T]_{\mathcal C}=mat(
// 1, -3 ,1;
// 2 ,1, 6;
// 0 ,3 ,8
// )$
// - $[T]_{\mathcal B}=mat(
// 3,0,0;
// 2,2,0;
// 2,3,4
// )$ and $[T]_{\mathcal C}=mat(
// 1,-1,0;
// 2,4,0;
// 3,-2,4
// )$
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - This is not possible since these two matrices have different determinant.
// - This is possible since these two matrix has the same the characteristic polynomial $(t-2)(t-3)(t-4)$, hence they are similar to same diagonal matrix, and thus similar.
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $A$ is similar to $B$.
// \begin{enumerate}[label=\alph*)]
// - Could you conclude that $3A$ is similar to $3B$. If you can, please give your reasons, if not, please find a counter-example.
// - Could you conclude that $A^{-1}$ is similar to $B^{-1}$. If you can, please give your reasons, if not, please find a counter-example.
// \end{enumerate}
// \end{problem}

// #solution[
// Since $A$ is similar to $B$, we may assume $A=PBP^{-1}$.
// \begin{enumerate}[label=\alph*)]
// - $3A=3PBP^{-1}=P(3B)P^{-1}$ is similar.
// - $A^{-1}=(PBP^{-1})^{-1}=PB^{-1}P^{-1}$ is similar.
// \end{enumerate}
// ]

// =={Online Assignment 9}

// \begin{problem}
// Determine whether the following statements are true
// \begin{enumerate}[label=\alph*)]
// - $\|\mathbf u\|^2+\|\mathbf v\|^2=\|\mathbf u+\mathbf v\|^2$ if and only if $\mathbf u,\mathbf v$ are orthogonal.
// - If $W$ is a subspace of $RR^n$, and vector $\mathbf v$ is orthogonal to both $W$ and $W^\perp$, then $\mathbf v=\mathbf0$.
// - If $W = \Span\{\mathbf x_1, \mathbf x_2 ,\mathbf x_3\}$ with $\{\mathbf x_1, \mathbf x_2 ,\mathbf x_3\}$ linearly independent, and if $\{\mathbf v_1, \mathbf v_2 ,\mathbf v_3\}$ is an orthogonal set in $W$, then $\{\mathbf v_1, \mathbf v_2 ,\mathbf v_3\}$ is a basis for $W$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - This is true. $\|\mathbf u+\mathbf v\|^2=(\mathbf u+\mathbf v) dot.c (\mathbf u+\mathbf v)=\mathbf u dot.c \mathbf u+2\mathbf u dot.c \mathbf v+\mathbf v dot.c \mathbf v=\|\mathbf u\|^2+\|\mathbf v\|^2+2\mathbf u dot.c \mathbf v$. Thus the equality holds $<=>\mathbf u dot.c \mathbf v=0$, i.e. $\mathbf u,\mathbf v$ are orthogonal.
// - Consider $\mathbf v dot.c \mathbf v=\|\mathbf v\|^2$, it should be 0 since $\mathbf v$ is in both $W$ and $W^\perp$, so $\mathbf v=\mathbf 0$
// - This is true by Theorem @(01:12-07/15/2022)
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $A=mat(
// 1,2,3;
// 2,1,-1;
// 0,2,4;
// 3,5,-1
// )$, please find a basis for $(\Col A)^\perp$.
// \end{problem}

// #solution[
// Recall that $(\Col A)^\perp=\Nul(A^T)$. And we can find a basis for $\Nul(A^T)$ through
//  $
// \left[\begin{array}{c|c}
// A^T,\mathbf0
// \end{array}\right]=\left[\begin{array}{cccc|c}
// 1,2,0,3,0;
// 2,1,2,5,0;
// 3,-1,4,1,0
// \end{array}\right]tilde \left[\begin{array}{cccc|c}
// 1,0,0,-13,0;
// 0,1,0,8,0;
// 0,0,1, 23 / 2 ,0
// \end{array}\right]
//  $
// Thus
//  $
// (\Col A)^\perp=\Span\left\{mat(
// 13;-8;- 23 / 2 ;1
// )\right\}
//  $
// ]

// \begin{problem}
// Suppose we have $\mathcal B=\left\{\mathbf u_1=mat(1;1;0;-1),\mathbf u_2=mat(1;0;1;1),\mathbf u_3=mat(0;-1;1;-1)\right\}$, please justify that $\mathcal B$ is an orthogonal set, suppose $\mathbf y=mat(1;2;3;4)$, $L$ is the subspace spanned by $\mathcal B$, compute the projection $\Proj_L\mathbf y$ of $\mathbf y$ onto $L$.
// \end{problem}

// #solution[
// Let $A=mat(
// \mathbf u_1,\mathbf u_2,\mathbf u_3
// )=mat(
// 1,1,0;
// 1,0,-1;
// 0,1,1;
// -1,1,-1
// )$, we can check that $A^TA=I$ is the 3 by 3 identity matrix, so $\mathcal B$ is an orthogonal set. And therefore
// \begin{align*}
// \Proj_L\mathbf y,= \mathbf y dot.c \mathbf u_1 / \mathbf u_1 dot.c \mathbf u_1 \mathbf u_1+ \mathbf y dot.c \mathbf u_2 / \mathbf u_2 dot.c \mathbf u_2 \mathbf u_2+ \mathbf y dot.c \mathbf u_3 / \mathbf u_3 dot.c \mathbf u_3 \mathbf u_3;
// ,= -1 / 3 \mathbf u_1+ 8 / 3 \mathbf u_2+ -3 / 3 \mathbf u_3;
// ,=- 1 / 3 mat(
// 1;1;0;-1
// )+ 8 / 3 mat(
// 1;0;1;1
// )-mat(
// 0;-1;1;-1
// )=mat(
//  7 / 3 ; 2 / 3 ; 5 / 3 ;4
// )
// \end{align*}
// ]

// \begin{problem}
// Suppose $A=mat(
// -1,6,6;
// 3,-8,3;
// 1,-2,6;
// 1,-4,-3
// )$, please find an orthogonal basis for $\Col A$.
// \end{problem}

// #solution[
// We apply the Gram-Schmidt process here
//
// - $\mathbf u_1=\mathbf v_1=mat(
// -1;3;1;1
// )$
// - $\mathbf u_2=\mathbf v_2-\dfrac{\mathbf v_2 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1=mat(
// 6;-8;-2;-4
// )- -36 / 12 mat(
// -1;3;1;1
// )=mat(
// 3;1;1;-1
// )$
// - $\mathbf u_3=\mathbf v_3-\dfrac{\mathbf v_3 dot.c \mathbf u_1}{\mathbf u_1 dot.c \mathbf u_1}\mathbf u_1-\dfrac{\mathbf v_3 dot.c \mathbf u_2}{\mathbf u_2 dot.c \mathbf u_2}\mathbf u_2=mat(
// 6;3;6;-3
// )- 6 / 12 mat(
// -1;3;1;1
// )- 30 / 12 mat(
// 3;1;1;-1
// )=mat(
// -1;-1;3;-1
// )$
//
// So we have an orthogonal basis for $\Col A$
//  $
// \Col A=\Span\left\{mat(
// -1;3;1;1
// ),mat(
// 3;1;1;-1
// ),mat(
// -1;-1;3;-1
// )\right\}
//  $
// ]

// =={Online Assignment 10}

// \begin{problem}
// Determine whether the following statements are correct
// \begin{enumerate}[label=\alph*)]
// - If $A$ is symmetric and if vectors $\mathbf u$ and $\mathbf v$ such that $A\mathbf u = \mathbf u$ and $\mathbf v$ is in $\operatorname{Nul}A$, then $\mathbf u  dot.c \mathbf v = \mathbf0$.
// - $\operatorname{Nul}A=\operatorname{Nul}A^TA$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - The eigenvalues for eigenvectors $\mathbf u$ and $\mathbf v$ are 1 and 0, and $A$ is symmetric, by Theorem @(23:54-07/19/2022), $\mathbf u dot.c \mathbf v=0$.
// - If $\mathbf x\in\Nul A$, then $A\mathbf x=\mathbf0$, so $A^TA\mathbf x=\mathbf 0$. If $\mathbf x\in\Nul(A^TA)$, then $A^TA\mathbf x=\mathbf0$, so $0=\mathbf x^TA^TA\mathbf x=\|A\mathbf x\|^2$, so $A\mathbf x=0$.
// \end{enumerate}
// ]

// \begin{problem}
// Find the least-squares solution(s) to $mat(
// 1,5;
// 3,1;
// -2,4
// )mat(
// x_1;x_2
// )=mat(
// 4;-2;-3
// )$.
// \end{problem}

// #solution[
// Let's denote $A=mat(
// 1,5;
// 3,1;
// -2,
// )$, $bold(b)=mat(
// 4;-2;-3
// )$, then $A^TA=mat(
// 14,0;
// 0,42
// )$, and $A^Tbold(b)=mat(
// 4;6
// )$, then we get the least -square solution $\hat{\mathbf x}=(A^TA)^{-1}A^Tbold(b)=mat(
//  2 / 7 ; 1 / 7
// )$
// ]

// \begin{problem}
// Orthogonal diagonalize the matrix $mat(
// 3,4;
// 4,9
// )$.
// \end{problem}

// #solution[
// First note that $A=mat(
// 3,4;
// 4,9
// )$ is symmetric and real-valued, we can get its eigenvalues $\lambda_1=1$, $\lambda_2=11$, and normalized eigenvectors $\mathbf u_1=mat(
// - 2 / \sqrt5 ; 1 / \sqrt5
// )$, $\mathbf u_2=mat(
//  1 / \sqrt5 ; 2 / \sqrt5
// )$. Hence we have the orthogonal diganolization
//  $
// A=mat(
// 3,4;
// 4,9
// )=mat(
// - 2 / \sqrt5 , 1 / \sqrt5 ;
//  1 / \sqrt5 , 2 / \sqrt5
// )mat(
// 1,0;0,11
// )mat(
// - 2 / \sqrt5 , 1 / \sqrt5 ;
//  1 / \sqrt5 , 2 / \sqrt5
// )=PDP^T
//  $
// ]

// \begin{problem}
// Suppose $A=mat(
// 1,5;
// -2,3
// )$.
// \begin{enumerate}[label=\alph*)]
// - Please find the eigenvalues of $A$.
// - Please find the eigenvectors of $A$.
// - Please write $A$ as matrix multiplication $PCP^{-1}$, where $C$ is of the form $mat(
// a,-b;
// b,c
// )$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\alph*)]
// - The characteristic polynomial is $t^2-4t+13$, and so the eigenvalues are $\lambda=2-3i$, $\overline\lambda=2+3i$, so we have $a=2$, $b=3$ and $C=mat(
// 2,-3;3,2
// )$
// - The eigenvalues for $\lambda,\overline{\lambda}$ are $\mathbf v=mat(
// 1+3i;2
// )=mat(
// 1;2
// )+imat(
// 3;0
// )$, $\overline{\mathbf v}=mat(
// 1-3i;2
// )$. so $P=mat(
// 1,3;
// 2,0
// )$
// - From above computation we get decomposition
//  $
// A=mat(
// 1,3;
// 2,0
// )mat(
// 2,-3;3,2
// )mat(
// 0, 1 / 2 ;
//  1 / 3 ,- 1 / 6
// )=PCP^{-1}
//  $
// \end{enumerate}
// ]

// ={Exams}

// =={Exam 1}

// \begin{problem}
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(15 pt)} Write linear system
//  $
// cases(2x_1+4x_2+2x_3=2, x_1+3x_2-x_3+2x_4=1, -x_1+2x_2+3x_3+2x_4=-1}
//  $
// as a matrix equation, and then solve it, write your solution in parametric vector form.
// \item\textbf{(5 pt)} Is $\left\{\mathbf a_1=mat(
// 2;1;-1
// ),\mathbf a_2=mat(
// 4;3;2
// ),\mathbf a_3=mat(
// 2;-1;3
// ),\mathbf a_4=mat(
// 0;2;2
// )\right\}$ linearly independent? Why or why not.
// \item\textbf{(4 pt)} What is the span of $\{\mathbf a_1,\mathbf a_2,\mathbf a_3,\mathbf a_4\}$
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - We could rewrite the linear system as
//  $
// A\mathbf x=mat(
// 2,4,2,0;
// 1,3,-1,2;
// -1,2,3,2
// )mat(
// x_1;x_2;x_3;x_4
// )=mat(
// 2;1;-1
// )=bold(b)
//  $
// \begin{align*}
// ,mat(
// A,bold(b)
// )xarrow( #`R3`-> #`R3`+#`R2` \ #`R1`-> #`R1`-2#`R2` )mat(
// 0,-2,4,-4,0;
// 1,3,-1,2,1;
// 0,5,2,4,0
// )xarrow(#`R1` arrow.l.r  #`R2`)mat(
// 1,3,-1,2,1;
// 0,-2,4,-4,0;
// 0,5,2,4,0
// );
// ,xarrow(#`R2`-> #`R2`/(-2))mat(
// 1,3,-1,2,1;
// 0,1,-2,2,0;
// 0,5,2,4,0
// )xarrow( #`R1`-> #`R1`-3#`R2` \ #`R3`-> #`R3`-5#`R2` )mat(
// 1,0,5,-4,1;
// 0,1,-2,2,0;
// 0,0,12,-6,0
// );
// ,xarrow(#`R3`-> #`R3`/12)mat(
// 1,0,5,-4,1;
// 0,1,-2,2,0;
// 0,0,1,- 1 / 2 ,0
// )xarrow( #`R1`-> #`R1`-5#`R3` \ #`R2`-> #`R2`+2#`R3` )mat(
// 1,0,0,- 3 / 2 ,1;
// 0,1,0,1,0;
// 0,0,1,- 1 / 2 ,0
// )
// \end{align*}
// So the solution is
//  $
// #cases(
// x_1=1+ 3 / 2 x_4;
// x_2=-x_4;
// x_3= 1 / 2 x_4;
// x_4\text{ is free}
// ) => \,
// mat(
// x_1;x_2;x_3;x_4
// )=mat(
// 1;0;0;0
// )+x_4mat(
//  3 / 2 ;-1; 1 / 2 ;1
// )
//  $
// - Note $A=mat(
// \mathbf a_1,\mathbf a_2,\mathbf a_3,\mathbf a_4
// )$ has RREF $mat(
// 1,0,0,- 3 / 2 ;
// 0,1,0,1;
// 0,0,1,- 1 / 2
// )$. Since the fourth each column is not a pivot column, $\{\mathbf a_1,\mathbf a_2,\mathbf a_3,\mathbf a_4\}$ is linearly dependent.
// - Since the RREF $A$ has a pivot in each row, the columns of $A$ (i.e. $\{\mathbf a_1,\mathbf a_2,\mathbf a_3,\mathbf a_4\}$) span $RR^3$
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $T:RR^3->RR^3$ is a linear transformation defined by $T\left(mat(
// x_1;x_2;x_3
// )\right)=mat(
// x_1+2x_2+3x_3;2x_1+5x_3;2x_1+3x_2+6x_3
// )$. Denote the standard matrix for $T$ as $A$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(3 pt)} Evaluate $A$.
// \item\textbf{(4 pt)} Is $T$ is onto? Is $T$ one-to-one?
// \item\textbf{(17 pt)} Is $T$ is invertible? If so, what is the standard matrix for $T^{-1}$?
// \item\textbf{(15 pt)} Find $A^T$ ,$(A^T)^{-1}$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The standard matrix for $T$ is $A=mat(
// 1,2,3;
// 2,0,5;
// 2,3,6
// )$
// - $T$ is onto and one-to-to.
// - $T$ is invertible. And the standard matrix of $T^{-1}$ is $A^{-1}$
// \begin{align*}
// ,\left[\begin{array}{c|c}
// A,I
// \end{array}\right]=\left[\begin{array}{ccc|ccc}
// 1,2,3,1,0,0;
// 2,0,5,0,1,0;
// 2,3,6,0,0,1
// \end{array}\right]xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-2#`R1` )\left[\begin{array}{ccc|ccc}
// 1,2,3,1,0,0;
// 0,-4,-1,-2,1,0;
// 0,-1,0,-2,0,1
// \end{array}\right];
// ,xarrow( #`R2`-> #`R2`-4#`R3` \ #`R1`-> #`R1`+2#`R3` )\left[\begin{array}{ccc|ccc}
// 1,0,3,-3,0,2;
// 0,0,-1,6,1,-4;
// 0,-1,0,-2,0,1
// \end{array}\right]xarrow( #`R2`->(-1)#`R2` \ #`R3`->(-1)#`R3` )\left[\begin{array}{ccc|ccc}
// 1,0,3,-3,0,2;
// 0,0,1,-6,-1,4;
// 0,1,0,2,0,-1
// \end{array}\right];
// ,xarrow(#`R2` arrow.l.r  #`R3`)\left[\begin{array}{ccc|ccc}
// 1,0,3,-3,0,2;
// 0,1,0,2,0,-1;
// 0,0,1,-6,-1,4
// \end{array}\right]xarrow(#`R1`-> #`R1`-2#`R3`)\left[\begin{array}{ccc|ccc}
// 1,0,0,15,3,-10;
// 0,1,0,2,0,-1;
// 0,0,1,-6,-1,4
// \end{array}\right];
// ,=\left[\begin{array}{c|c}
// I,A^{-1}
// \end{array}\right]
// \end{align*}
// Hence $A^{-1}=mat(
// 15,3,-10;
// 2,0,-1;
// -6,-1,4
// )$
// - $A^T=mat(
// 1,2,2;
// 2,0,3;
// 3,5,6
// )$, $(A^T)^{-1}=(A^{-1})^T=mat(
// 15,2,-6;
// 3,0,-1;
// -10,-1,4
// )$
// \end{enumerate}
// ]

// \begin{problem}
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(5 pt)} Suppose $A=mat(
// 1,0,0,0,0,8;
// 0,0,h,0,k,-4;
// 0,0,0,0,1,0
// )$ is of reduced row echelon form (RREF), could we know what $h,k$ are? If not, please explain why, if so, please give their values.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $T:RR^3->RR^3$ is a one-to-one linear transformation, then it is also onto.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $A$ is a 3 by 3 matrix and $A^5$ is invertible, then so is $A$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $A$ is a 5 by 3 matrix, then $A\mathbf x=bold(b)$ cannot have non-trivial solution(s)
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - $h=1$, $k=0$. Since $h$ has be in a pivot position, and $k$ is in a pivot column.
// - \texttt{TRUE}. Since its standard matrix would have a pivot in each column, that is three pivots, so there must be a pivot in each row also, hence $T$ is also onto.
// - \texttt{TRUE}. Since $A^5$ is invertible, we may assume its inverse is $B=(A^5)^{-1}$, so that $A^5B=BA^5=I$. Let's show $A^{-1}=A^4B$, first we note that
//  $
// A^4B=IA^4B=(BA^5)A^4B=BA^9B=BA^4(A^5B)=BA^4I=BA^4
//  $
// then
//  $
// AA^{-1}=A(A^4B)=A^5B=I
//  $
//  $
// A^{-1}A=(A^4B)A=(BA^4)A=BA^5=I
//  $
// Alternatively, we could consider its determinant $0!=\det(A^5)=(\det A)^5 => \det A!=0$, hence $A$ is invertible.
// - \texttt{FALSE}. Take $A$ to be $mat(
// 1,1,1;
// 0,0,0;
// 0,0,0;
// 0,0,0;
// 0,0,0;
// )$, and $bold(b)=\mathbf 0$, and the linear system have two free variables.
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $T_1$, $T_2$, $T_3$ and $T$ are all linear transformations from the $xy$-plane to itself.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} $T_1$ takes a vector and rotates it \textbf{clockwise} around the origin through an angle $45^\circ$. Writes down its standard matrix $A_1$.
// \item\textbf{(6 pt)} $T_2$ reflects over the $x$-axis. Writes down its standard matrix $A_2$.
// \item\textbf{(6 pt)} $T_3$ switches $x,y$ coordinates. Writes down its standard matrix $A_3$.
// \item\textbf{(6 pt)} Suppose $T$ is such that $T(\mathbf x)=T_3(T_2(T_1(\mathbf x)))$. What the standard matrix of $T$?
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The standard matrix $A_1=mat(
// \cos(-45^\circ),\cos(45^\circ);\sin(-45^\circ),\sin(45^\circ)
// )=mat(
//  \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2 ;- \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2
// )$
// - The standard matrix $A_2=mat(
// 1,0;0,-1
// )$
// - The standard matrix $A_3=mat(
// 0,1;1,0
// )$
// - The standard matrix
// \begin{align*}
// A,=A_3A_2A_1=mat(
// 0,1;1,0
// )mat(
// 1,0;0,-1
// )mat(
//  \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2 ;- \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2
// );
// ,=mat(
// 0,-1;1,0
// )mat(
//  \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2 ;- \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2
// );
// ,=mat(
//  \sqrt2 / \sqrt2 ,- \sqrt2 / \sqrt2 ; \sqrt2 / \sqrt2 , \sqrt2 / \sqrt2
// )
// \end{align*}
// \end{enumerate}
// ]

// % \begin{problem}
// % Suppose $A=mat(
// % 1,0,3,0;
// % 2,0,6,1;
// % 2,1,2,-4;
// % 3,0,2,1
// % )$.
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item\textbf{(16 pt)} Evaluate $\det A$.
// % \item\textbf{(3 pt)} Is $A$ invertible?
// % \item\textbf{(4 pt)} What is $\det(-2A)$?
// % \end{enumerate}
// % \end{problem}

// % #solution[
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item
// % \begin{align*}
// % ,\left|\begin{matrix}
// % 1,0,3,0;
// % 2,0,6,1;
// % 2,1,2,-4;
// % 3,0,2,1
// % \end{matrix}\right|\xequal{\text{cofactor expansion across second column}}1(-1)^{3+2}\left|\begin{matrix}
// % 1,3,0;
// % 2,6,1;
// % 3,2,1
// % \end{matrix}\right|;
// % ,\xequal{ #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-3#`R1` }(-1)\left|\begin{matrix}
// % 1,3,0;
// % 0,0,1;
// % 0,-7,1
// % \end{matrix}\right|\xequal{#`R2` arrow.l.r  #`R3`}(-1)(-1)\left|\begin{matrix}
// % 1,3,0;
// % 0,-7,1;
// % 0,0,1;
// % \end{matrix}\right|=(-1)(-1)1(-7)1=-7
// % \end{align*}
// % - $A$ is invertible since $\det A=-7!= 0$
// % - Since $A$ is a 4 by 4 matrix, $\det(-2A)=(-2)^4\det A=16 dot.c (-7)=-112$
// % \end{enumerate}
// % ]

// =={Exam 2}

// \begin{problem}
// Suppose $A=mat(
// 1 , -1, 5, 1 ,6 ,0;
// 2 ,0, 3 ,5, 3, 6;
// 0 ,1 ,-4 ,2 ,-1 ,2;
// 3 ,-2 ,12 ,4, 10 ,4
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} Please find a basis for $\Col A$.
// \item\textbf{(6 pt)} Please find a basis for $\Row A$.
// \item\textbf{(6 pt)} Please find a basis for $\Nul A$.
// \item\textbf{(6 pt)} What is $\dim\Nul A^T$?
// \end{enumerate}
// \end{problem}

// #solution[
// First note that
//  $
// Atilde mat(
// 1        ,     -1       ,       5    ,          1    ,          6         ,     0    ;
// 0        ,      1       ,      -4     ,         2    ,         -1        ,      2  ;
// 0         ,     0       ,       1      ,       -1    ,         -7        ,      2   ;
// 0          ,    0        ,      0, 0, 0 ,0
// )tilde mat(
// 1         ,     0           ,   0         ,     4          ,   12   ,           0  ;
// 0         ,     1          ,    0        ,     -2          ,  -29      ,       10  ;
// 0          ,    0        ,      1       ,      -1           ,  -7       ,       2 ;
// 0          ,    0          ,  0         ,     0      ,        0       ,       0
// )
//  $
// So we may conclude that the pivot columns are the 1st, 2nd, 3rd column
// \begin{enumerate}[label=\textbf{\alph*)}]
// - A basis for $\Col A$ could be $\left\{mat(
// 1;2;0;3
// ),mat(
// -1;0;1;-2
// ),mat(
// 5;3; -4; 12
// )\right\}$
// - A basis for $\Row A$ could be
//  $
// \left\{mat(
// 1,-1,5,1,6,0
// ),mat(
// 0,1,-4,2,-1,2
// ),mat(
// 0,0,1,-1,-7,2
// )\right\}
//  $
// - A basis for $\Nul A$ could be $\left\{mat(
// -4;2;1;1;0;0
// ),mat(
// -12;29;7;0;1;0
// ),mat(
// 0;-10;-2;0;0;1
// )\right\}$
// - By the rank nullity theorem. we have $\dim\Nul A^T=4-\rank A^T=4-\rank A=4-3=1$
// \end{enumerate}
// ]

// % \begin{problem}
// % Suppose $A=mat(
// % 4, 2,-2;
// % 4,2,4;
// % -1,1,5
// % )$.
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item\textbf{(15 pt)} Find all eigenvalues and corresponding eigenvectors
// % \item\textbf{(8 pt)} Diagonalize $A$.
// % \item\textbf{(8 pt)} Evaluate $A^{77}$.
// % \end{enumerate}
// % \end{problem}

// % #solution[
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % - First we evaluate the characteristic polynomial of $A$
// % \begin{align*}
// % \det(tI-A),=\left|\begin{matrix}
// % t-4,-2,2;
// % -4,t-2,-4;
// % 1,-1,t-5
// % \end{matrix}\right|\xequal{ #`R1`-> #`R1`-(t-4)#`R3` \ #`R2`-> #`R2`+4#`R3` }\left|\begin{matrix}
// % 0,t-6,-t^2+9t-18;
// % 0,t-6,4t-24;
// % 1,-1,t-5
// % \end{matrix}\right|;
// % ,\xequal{#`R1`-> #`R1`-#`R2`}\left|\begin{matrix}
// % 0,0,-t^2+5t+6;
// % 0,t-6,4t-24;
// % 1,-1,t-5
// % \end{matrix}\right|=(t-6)^2(t+1)
// % \end{align*}
// % So the eigenvalues are $\lambda_1=\lambda_2=6$, $\lambda_3=-1$. For the 6-eigenspace, we consider
// % \begin{align*}
// % \left[\begin{array}{c|c}
// % 6I-A,\mathbf0
// % \end{array}\right],=
// % \left[\begin{array}{ccc|c}
// % 2,-2,2,0;
// % -4,4,-4,0;
// % 1,-1,1,0
// % \end{array}\right]tilde \left[\begin{array}{ccc|c}
// % 1,-1,1,0;
// % 0,0,0,0;
// % 0,0,0,0
// % \end{array}\right]
// % \end{align*}
// % So we get two basis vectors $\left\{\mathbf v_1=mat(
// % 1;1;0
// % ),\mathbf v_2=mat(
// % -1;0;1
// % )\right\}$. For the $(-1)$-eigenspace, we consider
// % \begin{align*}
// % \left[\begin{array}{c|c}
// % -I-A,\mathbf0
// % \end{array}\right],=
// % \left[\begin{array}{ccc|c}
// % -5,-2,2,0;
// % -4,-3,-4,0;
// % 1,-1,-6,0
// % \end{array}\right]tilde \left[\begin{array}{ccc|c}
// % 1,0,-2,0;
// % 0,1,4,0;
// % 0,0,0,0
// % \end{array}\right]
// % \end{align*}
// % So we get a basis vector $\left\{\mathbf v_3=mat(
// % 2;-4;1
// % )\right\}$
// % - From above, we get the diagonalization
// %  $
// % A=PDP^{-1}=mat(
// % 1,-1,2;
// % 1,0,-4;
// % 0,1,1
// % )mat(
// % 6,0,0;
// % 0,6,0;
// % 0,0,-1
// % )mat(
// %  4 / 7 , 3 / 7 , 4 / 7 ;
// % - 1 / 7 , 1 / 7 , 6 / 7 ;
// %  1 / 7 ,- 1 / 7 , 1 / 7
// % )
// %  $
// % \item
// %  $
// % A^{77}=PD^{77}P^{-1}=mat(
// % 1,-1,2;
// % 1,0,-4;
// % 0,1,1
// % )mat(
// % 6^{77},0,0;
// % 0,6^{77},0;
// % 0,0,-1
// % )mat(
// %  4 / 7 , 3 / 7 , 4 / 7 ;
// % - 1 / 7 , 1 / 7 , 6 / 7 ;
// %  1 / 7 ,- 1 / 7 , 1 / 7
// % )
// %  $
// % \end{enumerate}
// % ]

// \begin{problem}
// Suppose $A=mat(
// 1,0,3,0;
// 2,0,6,1;
// 2,1,2,-4;
// 3,0,2,1
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(8 pt)} Write down the cofactor expansion along a row or a column of your own choice. (No simplification needed)
// \item\textbf{(10 pt)} Evaluate $\det A$.
// \item\textbf{(4 pt)} Is $A$ invertible? If so, evaluate $\det(A^{-1})$, if not, explain why.
// \item\textbf{(4 pt)} What is $\det(-2A)$?
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - We choose second for the cofactor expansion.
// \begin{align*}
// \det A,=0C_(12)+0C_(22)+1C_(32)+0C_(42);
// ,=0(-1)^{1+2}\det A_(1 2)+0(-1)^{2+2}\det A_(2 2)+1(-1)^{3+2}\det A_(3 2)+0(-1)^{4+2}\det A_(42);
// ,=0(-1)^{1+2}\left|\begin{matrix}
// 2,6,1;
// 2,2,-4;
// 3,2,1
// \end{matrix}\right|+0(-1)^{2+2}\left|\begin{matrix}
// 1,3,0;
// 2,2,-4;
// 3,2,1
// \end{matrix}\right|+1(-1)^{3+2}\left|\begin{matrix}
// 1,3,0;
// 2,6,1;
// 3,2,1
// \end{matrix}\right|+0(-1)^{4+2}\left|\begin{matrix}
// 1,3,0;
// 2,6,1;
// 2,2,-4
// \end{matrix}\right|;
// ,=1(-1)^{3+2}\left|\begin{matrix}
// 1,3,0;
// 2,6,1;
// 3,2,1
// \end{matrix}\right|=(-1)\left|\begin{matrix}
// 1,3,0;
// 2,6,1;
// 3,2,1
// \end{matrix}\right|
// \end{align*}
// - Continue on the cofactor expansion
// \begin{align*}
// \det A,=(-1)\left|\begin{matrix}
// 1,3,0;
// 2,6,1;
// 3,2,1
// \end{matrix}\right|\xequal{ #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-3#`R1` }(-1)\left|\begin{matrix}
// 1,3,0;
// 0,0,1;
// 0,-7,1
// \end{matrix}\right|\xequal{#`R2` arrow.l.r  #`R3`}(-1)(-1)\left|\begin{matrix}
// 1,3,0;
// 0,-7,1;
// 0,0,1;
// \end{matrix}\right|;
// ,=(-1)(-1)1(-7)1=-7
// \end{align*}
// - Since $\det A!=0$, $A$ is invertible and $\det(A^{-1})=(\det A)^{-1}=- 1 / 7 $.
// - Since $A$ is 4 by 4, $\det(-2A)=(-2)^4\det A=16 dot.c (-7)=-112$.
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $V$ is the set of 2 by 2 matrices that diagonal elements sum to 0. for example $mat(
// 3, 7 ;
// 2, -3
// )$ is in $V$ since $3+(-3)=0$ while $mat(
// 3, 4;
// 2, -2
// )$ is not because $3+(-2)=1!=0$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(10 pt)} Show that $V$ is a vector space.
// \item\textbf{(10 pt)} Find a basis $\mathcal B$ (this cannot simply be $\mathcal C$) of $V$ and justify your choice.
// \item\textbf{(8 pt)} Explain why $\mathcal C=\left\{C_1=mat(
// 2, 1 ;
// 1, -2
// ),C_2=mat(
// 1, 2 ;
// -1, -1
// ),C_3=mat(
// 3, -3 ;
// 2, -3
// )\right\}$ also form a basis for $V$.
// \item\textbf{(8 pt)} Find the change-of-coordinates matrix $\underset{\mathcal C\leftarrow\mathcal B}{P}$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - Consider linear transformation $T:M_{2 times 2}(RR)->RR$, $mat(
// a,b;c,d
// )\mapsto a+d$, we see that $V=\ker T$ which is a subspace of $M_{2 times 2}(RR)$, thus a vector space.
// - Note that $V=\left\{mat(
// a,b;
// c,-a
// )\right\}$
// A basis for $V$ could be $\left\{B_1=mat(
// 1,0;
// 0,-1
// ),B_2=mat(
// 0, 1 ;
// 0, 0
// ),B_3=mat(
// 0, 0 ;
// 1, 0
// )\right\}$, this is spanning since
//  $
// mat(
// a,b;
// c,-a
// )=amat(
// 1,0;
// 0,-1
// )+bmat(
// 0, 1 ;
// 0, 0
// )+cmat(
// 0, 0 ;
// 1, 0
// )
//  $
// This is linearly independent because if a linear combination
//  $
// amat(
// 1,0;
// 0,-1
// )+b=mat(
// 0, 1 ;
// 0, 0
// )+cmat(
// 0, 0 ;
// 1, 0
// )=mat(
// a,b;
// c,-a
// )=mat(
// 0, 0 ;
// 0, 0
// )
//  $
// Then $a=b=c=0$.
// - The $\mathcal B$ coordinates of $\mathcal C$ is $\left\{[C_1]_{\mathcal B}=mat(
// 2;1 ;1
// ),[C_2]_{\mathcal B}=mat(
// 1;2 ;-1
// ),[C_3]_{\mathcal B}=mat(
// 3;-3 ;2
// )\right\}$, we can show that they are linearly independent and span $V$ since
// \begin{align*}
// mat(
// 2,1,3;
// 1,2,-3;
// 1,-1,2
// )tilde mat(
// 1,-1,2;
// 1,2,-3;
// 2,1,3
// )tilde mat(
// 1,-1,2;
// 0,1,-5;
// 0,-1,-1
// )tilde mat(
// 1,-1,2;
// 0,1,-5;
// 0,0,-6
// )
// \end{align*}
// has a pivot in each row and column.
// - From above we know
//  $
// \underset{\mathcal B\leftarrow\mathcal C}{P}=mat(
// [C_1)_{\mathcal B},[C_2]_{\mathcal B},[C_3]_{\mathcal B}
// ]=mat(
// 2,1,3;
// 1,2,-3;
// 1,-1,2
// )
//  $
// So we know
//  $
// \underset{\mathcal C\leftarrow\mathcal B}{P}=\left(\underset{\mathcal B\leftarrow\mathcal C}{P}\right)^{-1}=mat(
// 2,1,3;
// 1,2,-3;
// 1,-1,2
// )^{-1}=mat(
// - 1 / 12 , 5 / 12 , 3 / 4 ;
//  5 / 12 ,- 1 / 12 ,- 3 / 4 ;
//  1 / 4 ,- 1 / 4 ,- 1 / 4
// )
//  $
// \end{enumerate}
// ]

// \begin{problem}
// Answer the following questions.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $D$ is the unit disk and $T:RR^2->RR^2$ has a standard matrix $mat(1,2;0,1)$. Then the area of the image $T(D)=2\pi$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $A$ is a $2 times 2$ matrix with integer entries such that $A^{-1}=A^T$ and $A^2=A$, then we know that $\det A=1$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $T:RR->RR$ is the map that adds 1, then $T$ is a linear transformation of rank $1$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $V$ is the set of 2 by 2 matrices with all four entries sums to zero, and $T:V->\mathbb P_2$ is a linear transformation, then $T$ can never be one-to-one.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - \texttt{FALSE}. $\text{Area}(T(D))=\left|\detmat(1,2;0,1)\right| dot.c \text{Area}(D)=|1| dot.c \pi=\pi$.
// - \texttt{TRUE}. First we see that $\det(A^2)=\det(A)^2=\det(A) => \det(A)=1$ or $0$. Since $A^{-1}$ exists, $A$ is invertible, so $\det A!=0$, and $\det A=1$.
// - \texttt{FALSE}. $T$ is not a linear transformation, since $T(0)=0+1=1!=0$, but we are supposed to have $T(0)=T(0 dot.c 0)=0 dot.c  T(0)=0$, this is contradiction.
// - \texttt{FALSE}. $T$ can be an isomorphism(thus one-to-one) since $\dim\mathbb P_2=3$ and the $\dim V=4-1=3$, as $V$ is $\ker T$ for $T:M_{2 times 2}->RR$, $T\left(mat(
// a,b;
// c,d
// )\right)=a+b+c+d$.
// \end{enumerate}
// ]

// % \begin{problem}
// % Determine whether the following is true.
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If the eigenvalues for a 3 by 3 matrix $A$ are $1,-1,2$, then $A$ is diagonalizable.
// % \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If both $\mathbf v_1,\mathbf v_2$ are eigenvectors of a matrix $A$, then $\mathbf v_1+\mathbf v_2$ is again an eigenvector for $A$.
// % \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $A$ is similar to $mat(
// % 2,0,0;
// % 0,1,-1;
// % 0,0,1
// % )$, then $A$ is not diagonalizable.
// % \end{enumerate}
// % \end{problem}

// % #solution[
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % - \texttt{TRUE}. By Theorem @(13:41-07/08/2022)
// % - \texttt{FALSE}. Consider $A=mat(
// % 1,0;
// % 0,-1
// % )$, $\mathbf v_1=mat(
// % 1;0
// % )$ is eigenvector for $\lambda_1=1$ and $\mathbf v_2=mat(
// % 0;1
// % )$ is eigenvector for $\lambda_2=-1$, however $\mathbf v_1+\mathbf v_2=mat(
// % 1;1
// % )$ is not an eigenvector.
// % - \texttt{TRUE}. Since $mat(
// % 2,0,0;
// % 0,1,-1;
// % 0,0,1
// % )$ is not diagonalizable, the geometric multiplicity for eigenvalue 1 is only 1 which is less than its algebraic multiplicity, which is 2.
// % \end{enumerate}
// % ]

// =={Final}

// \begin{problem}
// Suppose $A=mat(
// 0,1,b,0,2;
// 0,0,a,0,-3;
// 0,0,0,1,1
// )$ is of reduced row echelon form (RREF).
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(4 pt)} Evaluate $a,b$.
// \item\textbf{(6 pt)} Find a basis for $\Col A$.
// \item\textbf{(8 pt)} Find a basis for $(\Row A)^\perp$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - $a=1,b=0$. Because pivots of an RREF must be 1 and pivot columns has zeros except the the pivot position.
// - A basis for $\Col A$ could be $\left\{mat(
// 1;0;0
// ),mat(
// 0;1;0
// ),mat(
// 0;0;1
// )\right\}$ because the pivot columns are the 2nd, 3rd and 4th columns.
// - A basis for $(\Row A)^\perp=\Nul A$ is $\left\{mat(
// 1;0;0;0;0
// ),mat(
// 0;-2;3;-1;1
// )\right\}$
// \end{enumerate}
// ]

// \begin{problem}
// Recall that $\mathcal E=\{1,t,t^2\}$ is the _standard basis_ for $\mathbb P_2$. Given that $\mathcal B=\{1+t,2-t^2,3-t+2t^2\}$, $\mathcal C=\{2, 1+t,-t^2\}$ are bases for $\mathbb P_2$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(15 pt)} Find the change-of-coordinate matrix $\underset{\mathcal C\leftarrow\mathcal B}{P}$.
// \item\textbf{(15 pt)} Suppose $T:\mathbb P_2->\mathbb P_2$ is a linear transformation with $\mathcal B$ matrix $[T]_{\mathcal B}=mat(
// 1,0,1;
// 0,-1,0;
// 1,0,1
// )$, please find the $\mathcal C$ matrix $[T]_{\mathcal C}$ for $T$.
// \item\textbf{(15 pt)} Suppose $p(t)$ is a polynomial in $\mathbb P_2$ such that $[p(t)]_{\mathcal B}=mat(
// 0;2;-1
// )$. Evalue polynomial $T(p(t))$ in $\mathbb P_2$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - First we evaluate matrices
//  $
// \underset{\mathcal E\leftarrow\mathcal B}{P}=mat(
// 1,2,3;
// 1,0,-1;
// 0,-1,2
// )
//  $
//  $
// \underset{\mathcal E\leftarrow\mathcal C}{P}=mat(
// 2,1,0;
// 0,1,0;
// 0,0,-1
// )
//  $
//  $
// \underset{\mathcal C\leftarrow\mathcal B}{P}=\left(\underset{\mathcal E\leftarrow\mathcal C}{P}\right)^{-1}\underset{\mathcal E\leftarrow\mathcal B}{P}=mat(
// 0,1,2;
// 1,0,-1;
// 0,1,-2
// )
//  $
// \item
//  $
// \underset{\mathcal B\leftarrow\mathcal C}{P}=\left(\underset{\mathcal C\leftarrow\mathcal B}{P}\right)^{-1}=mat(
//  1 / 4 ,1,- 1 / 4 ;
//  1 / 2 ,0, 1 / 2 ;
//  1 / 4 ,0,- 1 / 4
// )
//  $
//  $
// [T]_{\mathcal C}=\underset{\mathcal C\leftarrow\mathcal B}{P}[T]_{\mathcal B}\underset{\mathcal B\leftarrow\mathcal C}{P}=mat(
//  1 / 2 ,2,- 3 / 2 ;
// 0,0,0;
// - 3 / 2 ,-2, 1 / 2
// )
//  $
// - First note that
//  $
// [T(p(t))]_{\mathcal B}=[T]_{\mathcal B}[p(t)]_{\mathcal B}=mat(
// -1;-2;-1
// )
//  $
// So $T(p(t))=(-1)(1+t)+(-2)(2-t^2)+(-1)(3-t+2t^2)=-8$.
// \end{enumerate}
// ]

// \begin{problem}
// Consider linear transformation $T:RR^3->RR^3$ which is defined by $T\left(mat(
// x_1;x_2;x_3
// )\right)=mat(
// x_1+x_2-2x_3;-x_1+2x_2;x_1+4x_2-4x_3
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(5 pt)} Is $T$ onto? Explain why.
// \item\textbf{(5 pt)} Is $T$ one-to-one? Explain why.
// \item\textbf{(5 pt)} Is $T$ is invertible? If so, please find $T^{-1}$.
// \end{enumerate}
// \end{problem}

// #solution[
// The standard matrix for $T$ is $A=mat(
// 1,1,-2;
// -1,2,0;
// 1,4,-4
// )tilde mat(
// 1,1,-2;
// 0,3,-2;
// 0,0,0
// )$
// \begin{enumerate}[label=\textbf{\alph*)}]
// - $T$ is not onto since there is not a pivot on each row of $A$.
// - $T$ is not one-to-one since there is not a pivot on each column of $A$.
// - $T$ is not invertible, since $T$ is neither one-to-one nor onto.
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $A=mat(
// 3,-4;
// 2,-1
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(8 pt)} Please find the eigenvalues of $A$ (they may be complex).
// \item\textbf{(12 pt)} Please find the corresponding eigenvectors.
// \item\textbf{(6 pt)} Write down a factorization of the form $A=PCP^{-1}$, where $C$ is of the form $mat(
// a,-b;b,a
// )$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The eigenvalues of $A$ are $\lambda=1-2i$ and $\overline\lambda=1+2i$, so we have $a=1$, $b=2$.
// - The eigenvectors of $A$ are $\mathbf v=mat(
// 1-i;1
// )=mat(
// 1;1
// )+imat(
// -1;0
// )$ and $\overline{\mathbf v}=mat(
// 1;1
// )-imat(
// -1;0
// )$.
// \item
//  $
// A=mat(
// 3,-4;
// 2,-1
// )=mat(
// 1,-1;
// 1,0
// )mat(
// 1,-2;
// 2,1
// )mat(
// 0,1;
// -1,1
// )=PCP^{-1}
//  $
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $A=mat(
// 1,3;
// 2,2;
// 3,1
// )$, $bold(b)=mat(1;0;1)$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} Show that the linear system is linearly inconsistent.
// \item\textbf{(10 pt)} Find the least-square solution(s).
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item
//  $
// mat(
// 1,3,1;
// 2,2,0;
// 3,1,1
// )tilde mat(
// 1,3,1;
// 0,-4,-2;
// 0,0,2
// )
//  $
// Which has a pivot in the last column.
// - $A^TA=mat(
// 14,10;10,14
// )$, $A^Tbold(b)=mat(
// 4;4
// )$, then $\hat{\mathbf x}=(A^TA)^{-1}(A^Tbold(b))=mat(
//  1 / 6 ; 1 / 6
// )$ is the least-square solution.
// \end{enumerate}
// ]

// \begin{problem}
// Suppose $A=mat(
// 4,1,0;
// 1,4,0;
// 0,0,5
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} Please find the characteristic polynomial of $A$.
// \item\textbf{(4 pt)} Please find the eigenvalues of $A$.
// \item\textbf{(12 pt)} Please find an orthonormal basis for $RR^3$ consists of eigenvectors.
// \item\textbf{(8 pt)} Please orthogonal diagonalize $A$.
// \end{enumerate}
// \end{problem}

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The characteristic polynomial is $(t-3)(t-5)^2$.
// - The eigenvalues of $A$ are $\lambda_1=3$, $\lambda_2=\lambda_3=5$.
// - An orthonormal basis consists of eigenvectors could be $\left\{mat(
//  1 / \sqrt2 ;- 1 / \sqrt2 ;0
// ),mat(
//  1 / \sqrt2 ; 1 / \sqrt2 ;0
// ),mat(
// 0;0;1
// )\right\}$.
// \item
//  $
// A=mat(
// 4,1,0;
// 1,4,0;
// 0,0,5
// )=mat(
//  1 / \sqrt2 , 1 / \sqrt2 ,0;
// - 1 / \sqrt2 , 1 / \sqrt2 ,0;
// 0,0,1
// )mat(
// 3,0,0;
// 0,5,0;
// 0,0,5
// )mat(
//  1 / \sqrt2 ,- 1 / \sqrt2 ,0;
//  1 / \sqrt2 , 1 / \sqrt2 ,0;
// 0,0,1
// )=PDP^T
//  $
// \end{enumerate}
// ]

// \bibliography{Bibliography}

#pagebreak()
#columns(3)[
    #make-index(title: "Index", outlined: true, use-page-counter: true)
]
