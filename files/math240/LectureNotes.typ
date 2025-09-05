#import "xarrow.typ": * // xarrow pacakge
#let xequal = xarrow.with(
  sym: sym.eq,
  position: top,
)

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

#let problem = thmbox(
  "problem",
  "Problem",
)

#let fact = thmbox(
	"fact",
	"Fact",
)

// Remarks, notes and questions are not numbered
#let remark = thmplain(
	"remark",
	"Remark",
	inset: 0em
).with(numbering: none)

#let note = thmplain(
	"note",
	"Note",
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

#example[
  In the previous Example @ex:number-of-solutions, @eq:unique-solution and @eq:inf-solutions are consistent, while @eq:no-solutions is inconsistent
]

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
  We say matrices $A,B$ are #text(fill:blue)[row equivalent]#index[row equivalence] ($A tilde B$ or $A -> B$) if $B$ can obtained by applying a sequence of elementary row operations to $A$ (or vise versa).
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
  b_(31),b_(32)
  ) \
  =&mat(
  a_(11)b_(11)+a_(12)b_(21)+a_(13)b_(31) , a_(11)b_(12)+a_(12)b_(22)+a_(13)b_(32);
  a_(21)b_(11)+a_(22)b_(21)+a_(23)b_(31) , a_(21)b_(12)+a_(22)b_(22)+a_(23)b_(32)
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

#fact[
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

#example[
  Suppose $3 times 3$ matrix $A$ can be partitioned into $mat(
  #`R1`;#`R2`;#`R3`
  )$ or $mat(
  bold(a)_1,bold(a)_2,bold(a)_3
  )$, then Example @ex:elementary-matrices reads
  - $E=mat(
  1,0,-3;
  0,1,0;
  0,0,1
  )$, $E A=mat(
  1,0,-3;
  0,1,0;
  0,0,1
  )mat(
  #`R1`;#`R2`;#`R3`
  )=mat(
  #`R1`-3#`R3`;#`R2`;#`R3`
  )$, $E A$ acts as subtracting 3 times row 3 from row 1.
  - $E=mat(
  1,0,0;
  0,1,0;
  2,0,1
  )$, $A E=mat(
  bold(a)_1,bold(a)_2,bold(a)_3
  )mat(
  1,0,0;
  0,1,0;
  2,0,1
  )=mat(
  bold(a)_1+2bold(a)_3,bold(a)_2,bold(a)_3
  )$, $A E$ acts as adding 2 times column 3 to column 1.
  - $E=mat(
  1,0,0;
  0,2,0;
  0,0,1
  )$, $E A=mat(
  1,0,0;
  0,2,0;
  0,0,1
  )mat(
  #`R1`;#`R2`;#`R3`
  )=mat(
  #`R1`;2#`R2`;#`R3`
  )$, $E A$ acts as scaling the third row by 2.
  - $E=mat(
  1,0,0;
  0,3,0;
  0,0,1
  )$, $A E=mat(
  bold(a)_1,bold(a)_2,bold(a)_3
  )mat(
  1,0,0;
  0,3,0;
  0,0,1
  )=mat(
  bold(a)_1,3bold(a)_2,bold(a)_3
  )$, $A E$ acts as scaling the third column by 3.
  - $E=mat(
  0,0,1;
  0,1,0;
  1,0,0
  )$, $E A=mat(
  0,0,1;
  0,1,0;
  1,0,0
  )mat(
  #`R1`;#`R2`;#`R3`
  )=mat(
  #`R3`;#`R2`;#`R1`
  )$, $E A$ acts as interchanging row 1 and row 3.
  - $E=mat(
  0,1,0;
  1,0,0;
  0,0,1
  )$, $A E=mat(
  bold(a)_1,bold(a)_2,bold(a)_3
  )mat(
  0,1,0;
  1,0,0;
  0,0,1
  )=mat(
  bold(a)_2,bold(a)_1,bold(a)_3
  )$, $A E$ acts as interchanging column 1 and column 2.
]

#definition[
Matrices $E$ in the previous example is called #text(fill:blue)[elementary matrices]#index[elementary matrices]. They describe row and column elementary operations.
]

#exercise[
If $A$ is a 4 by 5 matrix, what is the elementary matrix $E$ that acts as replacing the fourth row by adding twice of the second row.
]

#exercise[
Suppose $B=mat(
bold(b)_1,bold(b)_2,dots.h.c,bold(b)_n
)$, show that $A B=mat(
A bold(b)_1,A bold(b)_2,dots.h.c,A bold(b)_n
)$
]

#exercise[
Verify that $A^2=I_2$ where $A=mat(
1,0;3,-1
)$, and use partitioned matrices to show that $M^2=I_4$, where $M=mat(
1,0,0,0;
3,-1,0,0;
1,0,-1,0;
0,1,-3,1
)$
]

#exercise[
Suppose $mat(
A,bold(b)
)tilde mat(
U,bold(d)
)$ is the REF/RREF, then $U$ will also be the REF/RREF of $A$.
]

#solution[
Suppose the row elementary operations applied are $E_1,E_2,dots.h.c,E_k$, then
#figure(
    cetz.canvas(length: 1cm, {
        import cetz.draw: *
        content(
            (0.3,0),
            $mat( A,bold(b) )tilde  E_1mat( A,bold(b) )tilde  E_2E_1mat( A,bold(b) )tilde dots.h.c tilde  E_k dots.h.c E_2E_1mat( A,bold(b) )=mat( U,bold(d) )$,
            anchor: "south"
        )
        for (x,y,expr) in (
            (-3.2, -3.5, $mat( E_1A,E_1bold(b) )$),
            (-1, -1, $mat( E_2E_1A,E_2E_1bold(b) )$),
            (3.5, 3.5, $mat( E_k dots.h.c E_2 E_1 A,E_k dots.h.c E_2 E_1 bold(b) )$)
        ) {
            line((x -.05, 0), (y -.05,-0.5))
            line((x+.05,0), (y+.05,-0.5))
            content((), expr, anchor: "north")
        }
    }),
)<fig:proof-elem-rowop>
The same sequence of row elementary operations would reduce $A$ to $U$.
]

= Lecture 4 - Matrix equations and linear independence

== Vector and matrix equations

Recall a vector is a matrix with one column, the zero vector is a vector with all entries zero. For scalar (i.e. a number) $c$, and vectors $bold(a)=mat(
a_1;a_2;dots.v;a_n
)$, $bold(b)=mat(
b_1;b_2;dots.v;b_n
)$, we have

- Addition $bold(a)+bold(b)=mat(
a_1;a_2;dots.v;a_n
)+mat(
b_1;b_2;dots.v;b_n
)=mat(
a_1+b_1;a_2+b_2;dots.v;a_n+b_n
)$
- Scalar multiplication $c bold(a)=c mat(
a_1;a_2;dots.v;a_n
)=mat(
c a_1;c a_2;dots.v;c a_n
)$
- Subtraction $bold(a)-bold(b)=bold(a)+(-1)bold(b)=mat(
a_1;a_2;dots.v;a_n
)-mat(
b_1;b_2;dots.v;b_n
)=mat(
a_1-b_1;a_2-b_2;dots.v;a_n-b_n
)$

#remark[
In handwritings, we use $arrow(v)$ or $accent(v,harpoon.rt)$ to denote a vector, while in printing materials we often use the math bold font $bold(v)$.
]

#definition[
A #text(fill:blue)[vector equation]#index[vector equation] is of the form
$
x_1bold(a)_1+x_2bold(a)_2+dots.h.c+x_n bold(a)_n=bold(b)
$<eq:veceq>
We can also write the vector equation~\eqref{eq:veceq} as a #text(fill:blue)[matrix equation]#index[matrix equation] with partitioned matrix
 $
x_1bold(a)_1+x_2bold(a)_2+dots.h.c+x_n bold(a)_n=mat(
bold(a)_1,bold(a)_2,dots.h.c,bold(a)_n
)mat(
x_1;x_2;dots.v;x_n
)=A bold(x)=bold(b)
 $
Here $A=mat(
bold(a)_1,bold(a)_2,dots.h.c,bold(a)_n
)$ and $bold(x)=mat(
x_1;x_2;dots.v;x_n
)$
]

#example[
@eq:chicken-rabbit can be written as a vector equation
 $
x_1bold(a)_1+x_2bold(a)_2=
x_1mat(
1;2
)+x_2mat(
1;4
)=mat(
x_1;2x_1
)+mat(
x_2;4x_2
)=mat(
x_1+x_2;2x_1+4x_2
)=mat(
10;26
)=bold(b)
 $
Or a matrix equation
 $
A bold(x)=mat(
1,1;2,4
)mat(
x_1;x_2
)=mat(
10;26
)=bold(b)
 $
]

#example[
The corresponding vector equation of $ cases(x_1+x_3=1, 2x_2+x_3=2) $ is
 $
x_1mat(
1;0
)+x_2mat(
0;2
)+x_3mat(
1;1
)=mat(
1;2
)
 $
And the corresponding matrix equation is
 $
mat(
1,0,1;
0,2,1
)mat(
x_1;x_2;x_3
)=mat(
1;2
)
 $
]

% #question[
% Suppose $A$ is a $m times  n$ matrix, when does the matrix equation $A bold(x)=bold(b)$ always has a solution for any $bold(b)$ in $RR^n$
% ]

== Span

#definition[

- A #text(fill:blue)[linear combination]#index[linear combination] of $bold(a)_1,bold(a)_2,dots.h.c,bold(a)_n$ is a sum $c_1bold(a)_1+c_2bold(a)_2+dots.h.c+c_n bold(a)_n$ for some scalars $c_1,dots.h.c,c_n$.
- The #text(fill:blue)[span]#index[span] of $\{bold(v)_1,bold(v)_2,dots.h.c,bold(v)_n\}$ is the set of all its linear combinations, which we denote $"Span"{bold(v)_1, bold(v)_2,dots.h.c,bold(v)_n}$.

]

#theorem[
$x_1bold(a)_1+x_2bold(a)_2+dots.h.c+x_n bold(a)_n=bold(b)$ has solution(s) $<=>bold(b)$ is a linear combination of $bold(a)_1, bold(a)_2,dots.h.c,bold(a)_n$ $<=>$ $bold(b) in"Span"{bold(a)_1, bold(a)_2,dots.h.c,bold(a)_n}$
]

#exercise[
Let $bold(a)_1=mat(
1;2;1
)$, $bold(a)_2=mat(
-1;0;1
)$, $bold(a)_3=mat(
1;-1;-2
)$, $bold(b)=mat(
1;1;1
)$. Is $bold(b)$ in $"Span"{bold(a)_1, bold(a)_2,bold(a)_3}$?
]

#solution[
This is equivalent of asking if whether the vector equation $x_1bold(a)_1+x_2bold(a)_2+x_3bold(a)_3=bold(b)$ has solution(s), we find an REF of its augmented matrix
$
mat(
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
)
$
Since there is a pivot in the last column, by Theorem @thm:sol-pivot, the linear system is inconsistent, hence $bold(b) in.not"Span"{bold(a)_1, bold(a)_2,bold(a)_3}$
]

== Linear independence

#definition[
${bold(v)_1,dots.h.c,bold(v)_n}$ is #text(fill:blue)[linearly dependent]#index[linearly dependent] if some $bold(v)_i$ is in the span of the others (so it is somewhat redundant), or equivalently, if there is a non-trivial solution $c_1,dots.h.c,c_n$ (i.e. not all $c_i$'s are 0) to the vector equation
$
c_1bold(v)_1+dots.h.c+c_n bold(v)_n=bold(0)
$<eq:lindep>
@eq:lindep is referred to as a #text(fill:blue)[linear dependence]#index[linear dependence] between $\{bold(v)_1,dots.h.c,bold(v)_n\}$. If @eq:lindep has only the trivial solution (i.e. $c_1,dots.h.c, c_n$ are all 0, which is of course always a solution), $\{bold(v)_1,dots.h.c,bold(v)_n\}$ is said to be #text(fill:blue)[linearly independent]#index[linearly independent]
]

#remark[
Equivalence between two different definitions of linear dependence

- If $bold(v)_i=c_1bold(v)_1+dots.h.c+c_{i-1}bold(v)_{i-1}+c_{i+1}bold(v)_{i+1}+dots.h.c+c_n bold(v)_n$, then $c_1bold(v)_1+dots.h.c+(-1)bold(v)_i+dots.h.c+c_n bold(v)_n=bold(0)$
- If $c_1bold(v)_1+dots.h.c+c_i bold(v)_i+dots.h.c+c_n bold(v)_n=bold(0)$ and $c_i!=0$ (since not all $c_i$'s are zero, we may assume some $c_i$ is nonzero), then $bold(v)_i=- c_1 / c_i bold(v)_1-dots.h.c-c_(i-1)/c_i bold(v)_{i-1}-c_(i+1)/c_i bold(v)_{i+1}-dots.h.c- c_n / c_i bold(v)_n$

]

#question[
How do we determine and find linear dependence of $\{bold(v)_1,dots.h.c,bold(v)_n\}$?
]

#answer[
Let $A=mat(
bold(v)_1,dots.h.c,bold(v)_n
)$, then non-trivial solutions to $A bold(x)=x_1bold(v)_1+dots.h.c+x_n bold(v)_n=bold(0)$ would be the linear dependences of $\{bold(v)_1,dots.h.c,bold(v)_n\}$. Therefore it is linearly independent if it has only the trivial(zero) solution.
]

#theorem[
$\{bold(v)_1,dots.h.c,bold(v)_n\}$ is linearly independent $<=> A bold(x)=bold(0)$ has only the trivial(zero) solution $<=>$ each column of the RREF of $A$ is a pivot column.
]

#proof[
Consider the RREF of the augmented matrix $mat(
A,bold(0)
)$, it is necessarily $mat(
U,bold(0)
)$ for $A bold(x)=bold(0)$ to have only the trivial solution.
]

#example[
Suppose $bold(v)_1=mat(
1;-1
)$, $bold(v)_2=mat(
1;1
)$, $bold(e)_1=mat(
1;0
)$, $\{bold(v)_1,bold(v)_2,bold(e)_1\}$ is linearly dependent since
 $
mat(
bold(v)_1,bold(v)_2,bold(e)_1
)=mat(
1,1,1;
-1,1,0;
)tilde mat(
1,0, 1 / 2 ;
0,1, 1 / 2 ;
)
 $
The solution to this augmented matrix would be $ cases(
x_1=- 1 / 2 x_3,
x_2=- 1 / 2 x_3,
x_3" is free"
)$, by choosing any value nonzero value of $x_3$ (say 1) we get a linear dependence $- 1 / 2 bold(v)_1- 1 / 2 bold(v)_2+bold(e)_1=bold(0)$. On the other hand, $bold(v)_1,bold(v)_2$ are linearly independent since
 $
mat(
bold(v)_1,bold(v)_2
)=mat(
1,1;
-1,1
)tilde mat(
1,0;
0,1
)
 $
Where each column is a pivot column.
]<ex:example4>

#exercise[
Write the system $ cases(8x_1-x_2=4, 5x_1+4x_2=1,x_1-3x_2=2) $ first as a vector equation and then as a matrix equation.
]

#exercise[
Let $bold(v)_1=mat(
0;0;-2
)$, $bold(v)_2=mat(
0;-3;8
)$, $bold(v)_3=mat(
4;-1;-5
)$.

- Does $\{bold(v)_1,bold(v)_2,bold(v)_3\}$ span $RR^3$? Why or why not?
- Is $\{bold(v)_1,bold(v)_2,bold(v)_3\}$ linearly independent? Why or why not?

]

= Lecture 5 - Geometric interpretation of solutions of linear systems

== Geometric interpretation of vectors

We like to identify vectors in $M_{n times 1}(RR)$ with points in $RR^n$. And there are very nice geometric interpretation of vector additions and scalar multiplications.

#example[
Let $bold(a)=mat(
1;2
)$, $bold(b)=mat(
2;1
)$, then $bold(a)+bold(b)=mat(
3;3
)$, $2bold(a)=mat(
2;4
)$, $-bold(b)=(-1)bold(b)=mat(
-2;-1
)$, $bold(a)-bold(b)=bold(a)+(-bold(b))=mat(
-1;1
)$.
#figure(
    cetz.canvas(length: 1cm, {
        import cetz.draw: *
        grid((-5, -3), (5, 5), step: 1, stroke: (dash: "dashed", thickness:0.5pt, paint: gray))
        line((-5, 0), (5, 0), mark: (end: "straight"))
        content((), $x_1$, anchor: "west")
        line((0, -3), (0, 5), mark: (end: "straight"))
        content((), $x_2$, anchor: "south")
        let o = (0,0)
        let a = (1,2)
        let b = (2,1)
        line(o, a, mark: (end: "straight"))
        content((), $bold(a)$, anchor:"south-east")
        line(o, b, mark: (end: "straight"))
        content((), $bold(b)$, anchor:"north-west")
        let neg_b = b.map(x=>-x)
        line(o, neg_b, mark: (end: "straight"))
        content((), $-bold(b)$, anchor:"north-east")
        let two_a = a.map(x=>2*x)
        line(o, two_a, mark: (end: "straight"))
        content((), $2bold(a)$, anchor:"south")
        let a_add_b = (3,3)
        line(o, a_add_b, mark: (end: "straight"))
        content((), $bold(a) + bold(b)$, anchor:"south")
        let a_sub_b = (-1,1)
        line(o, a_sub_b, mark: (end: "straight"))
        content((), $bold(a) - bold(b)$, anchor:"south-east")
        line(a_sub_b, a_add_b, stroke:(dash:"dashed", paint:gray))
        line(a_sub_b, neg_b, stroke:(dash:"dashed", paint:gray))
        line(b, a_add_b, stroke:(dash:"dashed", paint:gray))
    }),
    caption: $"Vector-point correspondence when" n=2$,
)<fig:two-lines-intersect>
]

== Basis

#theorem[
Let $A$ be an $m times  n$ matrix. Then the following statements are logically equivalent. That is, for a particular $A$, either they are all true statements or they are all false.
- For each $bold(b)$ in $RR^m$, the equation $A bold(x) =bold(b)$ has a solution.
- Each $bold(b)$ in $RR^m$ is a linear combination of the columns of $A$.
- The columns of $A$ span $RR^m$.
- $A$ has a pivot position in every row. (Equivalently, in the last row)
]<thm:matsol>

#definition[
$\{bold(v)_1,bold(v)_2,dots.h.c,bold(v)_n\}$ is said to be a basis for $RR^n$ if it is linearly independent and spans all of $RR^n$
]

#theorem[
Let $A=mat(
bold(v)_1,bold(v)_2,dots.h.c,bold(v)_n
)$, then $\{bold(v)_1,bold(v)_2,dots.h.c,bold(v)_n\}$ forms basis of $RR^n<=> A tilde  I_n$, in other words, each row and each column of $A$ has a pivot.
]

#definition[
The #text(fill:blue)[standard basis]#index[standard basis] for $RR^n$ is the set of vectors $\{bold(e)_1,dots.h.c,bold(e)_n\}$, where
#align(center,
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    content((), $bold(e)_j=mat(0;dots.v;1;dots.v;0)$)
    line((1.5, 0.1), (.8, 0.1), mark: (end: "straight"), stroke: 0.4pt)
    content((1.6, 0.1), $j"-th entry"$, anchor: "west")
  })
)
]

#example[
${bold(e)_1=mat(
1;0;0
),bold(e)_2=mat(
0;1;0
),bold(e)_3=mat(
0;0;1
)}$ is the standard basis for $RR^3$, and
$
mat(
x_1;x_2;x_3
),=mat(
x_1;0;0
)+mat(
0;x_2;0
)+mat(
0;0;x_3
)=x_1mat(
1;0;0
)+x_2mat(
0;1;0
)+x_3mat(
0;0;1
) \ =x_1bold(e)_1+x_2bold(e)_2+x_3bold(e)_3
$
]

== Geometric meaning of spans

#example[
Consider Example @ex:example4 where $bold(v)_1=mat(
1;-1
)$, $bold(v)_2=mat(
1;1
)$, $bold(e)_1=mat(
1;0
)$, $bold(e)_2=mat(
0;1
)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \clip(-4.5,-4.5) rectangle (4.5,4.5);
// \draw[help lines, color=gray!30, dashed] (-4.5,-4.5) grid (4.5,4.5);
// \foreach \x in {-6,-4,-2,0,2,4,6} {\draw[help lines, color=purple!30, dashed] (-5+\x,-5)--++(10,10); \draw[help lines, color=purple!30, dashed] (-5+\x,5)--++(10,-10);}
// \draw[->, color=gray!80] (-4.5,0)--(4.5,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-4.5)--(0,4.5) node[above]{$x_2$};
// \coordinate (a) at (1,-1); \node at (a)[below left]{\textcolor{purple}{$bold(v)_1$}}; \draw[->, purple, thick] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[below right]{\textcolor{purple}{$bold(v)_2$}}; \draw[->, purple, thick] (0,0)--(b);
// \node at (1,0)[above]{$bold(e)_1$}; \draw[->, thick] (0,0)--(1,0);
// \node at (0,1)[above]{$bold(e)_2$}; \draw[->, thick] (0,0)--(0,1);
// \node at ($2*(a)+(b)$)[below]{\textcolor{orange}{$ 2bold(v)_1+bold(v)_2 \ =3bold(e)_1-bold(e)_2 $}}; \draw[->, orange, thick] (0,0)--($2*(a)+(b)$);
// \end{tikzpicture}
// \end{center}
$"Span"{bold(v)_1,bold(v)_2, bold(e)_1}$ and $"Span"{bold(v)_1,bold(v)_2}$ are both the plane $RR^2$, $bold(e)_1$ is in the span of $\{bold(v)_1,bold(v)_2\}$ because $bold(e)_1= 1 / 2 bold(v)_1+ 1 / 2 bold(v)_2$. The gray grids illustrate the span of $\{bold(e)_1,bold(e)_2\}$ and the purple grids illustrate the span of $\{bold(v)_1,bold(v)_2\}$.
]

#exercise[
Suppose $bold(a)_1=mat(
1;-3;0
)$, $bold(a)_2=mat(
2;-1;5
)$, $bold(a)_3=mat(
1;2;3
)$

- Determine whether $\{bold(a)_1, bold(a)_2, bold(a)_3\}$ forms a basis for $RR^3$.
- Without performing elementary row operations, how many solutions does $A bold(x)=bold(b)$ have? Where $bold(b)=mat(
1;45;-9
)$, what about $bold(b)=mat(
0;0;0
)$.

]

== Parametric vector form

#example[
In @ex:example3, the solution set can be written as #text(fill:blue)[parametric vector form]#index[parametric vector form]
$
mat(
x_1;x_2;x_3
)=mat(
 1 / 2 x_3+ 1 / 2 ; 3 / 2 x_3- 1 / 2 ;x_3
)=mat(
 1 / 2 x_3; 3 / 2 x_3;x_3
)+mat(
 1 / 2 ;- 1 / 2 ;0
)=x_3mat(
 1 / 2 ; 3 / 2 ;1
)+mat(
 1 / 2 ;- 1 / 2 ;0
)
$
In Example @exer:exercise1, the solution set can be written as
 $
mat(
x_1;x_2;x_3;x_4
)=mat(
2x_2+16;x_2; 5 / 2 ;- 9 / 2
)=mat(
2x_2;x_2;0;0
)+mat(
16;0; 5 / 2 ;- 9 / 2
)=x_2mat(
2;1;0;0
)+mat(
16;0; 5 / 2 ;- 9 / 2
)
 $
]

#exercise[
Suppose the augmented matrix of a linear system is equivalent to the following matrix
 $
mat(
1,1,0,2,0,3;
0,0,1,-2,0,2;
0,0,0,0,1,1;
)
 $
Write down the solution set in parametric vector form
]

#solution[
$ cases(x_1+x_2+2x_4=3, x_3-2x_4=2,x_5=1) => cases(
x_1=3-x_2-2x_4, x_2" is free",x_3=2+2x_4, x_4" is free", x_5=1
)
 $
So the solution in parametric vector form would be
 $
mat(
x_1;x_2;x_3;x_4;x_5
)=mat(
3-x_2-2x_4;x_2;2+2x_4;x_4;1
)=mat(
3;0;2;0;1
)+mat(
-x_2;x_2;0;0;0
)+mat(
-2x_4;0;2x_4;x_4;0
)=mat(
3;0;2;0;1
)+x_2mat(
-1;1;0;0;0
)+x_4mat(
-2;0;2;1;0
)
 $
]

== Geometric interpretation of solution set to linear system

#definition[
A linear system is #text(fill:blue)[homogeneous]#index[homogeneous] if it has matrix equation $A bold(x)=bold(0)$ (note that this always have the zero solution, called the #text(fill:blue)[trivial solution]#index[trivial solution]).
]

#theorem[
Suppose $mat(
A,bold(b)
)tilde mat(
U,bold(d)
)$ is the RREF, then $U$ will be the RREF of $A$. The solutions of $A bold(x)=bold(0)$ and $A bold(x)=bold(b)$ differs by $tilde(bold(d))$ ($tilde(bold(d))$ is $bold(d)$ with 0's inserted at the free variable positions), i.e.
 $
tilde(bold(d))+{"solutions of "A bold(x)=bold(0)}={"solutions of "A bold(x)=bold(b)}
 $
Geometrically speaking, the solution set of $A bold(x)=bold(b)$ is the hyperplane translated from the hyperplane through the origin (solution set of $A bold(x)=bold(0)$) by $bold(d)$.
]

#example[
$x_1-2x_2=2$ has augmented matrix $mat(
1,-2,2
)$ which is already an RREF, which has solution
 $
cases(
x_1=2+2x_2,
x_2" is free"
) => mat(
2;0
)+x_2mat(
2;1
)
 $
Its corresponding homogeneous equation $x_1-2x_2=0$ has solution
 $
cases(
x_1=2x_2,
x_2" is free"
) =>  x_2mat(
2;1
)
 $
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
]

#example[
Consider homogeneous linear system $3x_1+x_2-x_3=0$, and non-homogeneous linear system $3x_1+x_2-x_3=3$ .The parametric vector form of the solution sets to both are
 $
mat(
x_1;x_2;x_3
)=x_2mat(
- 1 / 3 ;1;0
)+x_3mat(
 1 / 3 ;0;1
)
 $
 $
mat(
x_1;x_2;x_3
)=x_2mat(
- 1 / 3 ;1;0
)+x_3mat(
 1 / 3 ;0;1
)+mat(
1;0;0
)
 $
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
// \draw[->, ultra thick, color1] (o)--(v1)node[above left]{$bold(v)_1$};
// \draw[->, ultra thick, color1] (o)--(v2)node[above]{$bold(v)_2$};
// \draw[->, ultra thick, color2] ($(o)+(d)$)--($(d)+(v1)$)node[above right]{$bold(v)_1$};
// \draw[->, ultra thick, color2] ($(o)+(d)$)--($(d)+(v2)$)node[above]{$bold(v)_2$};
// \draw[->, dotted, ultra thick] (o)--(d)node[below]{$tilde(bold(d))$};
// \end{scope}
// \end{tikzpicture}
// \end{center}
]

= Lecture 6 - Linear transformations

== Linear transformations and matrix transformations

#definition[
A #text(fill:blue)[Linear transformation] (or #text(fill:blue)[linear mapping])#index[linear transformation] $T$ from $RR^n$ to $RR^m$ is a mapping satisfying

- $T(bold(u)+bold(v))=T(bold(u))+T(bold(v))$ for any $bold(u),bold(v)$ in $RR^n$
- $T(c bold(u))=c T(bold(u))$ for any scalar $c$ and any $bold(u)$ in $RR^n$

]

#example[
Reflection, rotation and scaling are all linear transformations from $RR^2$ to $RR^2$.
]

#exercise[
Suppose $T:RR^2->RR^2$ is defined by $T(mat(
x;y
))=mat(
x+y;
y
)$. Is $T$ is a linear mapping?
]<ex:matrix-transformation>

#solution[
Suppose $bold(u)=mat(
u_1;u_2
)$, $bold(v)=mat(
v_1;v_2
)$, then

\item
$
T(bold(u)+bold(v)),=T(mat(
u_1+v_1;u_2+v_2
))=mat(
(u_1+v_1)+(u_2+v_2);u_2+v_2
);
,=mat(
(u_1+u_2)+(v_1+v_2);u_2+v_2
)=mat(
u_1+u_2;u_2
)+mat(
v_1+v_2;v_2
)=T(bold(u))+T(bold(v))
$
\item
 $
T(c bold(u))=T(mat(
c u_1;c u_2
))=mat(
c u_1+c u_2;c u_2
)=c mat(
u_1+u_2;u_2
)=c T(bold(u))
 $
]

#definition[
A #text(fill:blue)[matrix transformation]#index[matrix transformation] is the mapping defined via matrix multiplication, i.e. $T(bold(x))=A bold(x)$ for some $m times  n$ matrix $A$. It is a linear transformation thanks to Fact @fact:mat-alg c),d) since
- $T(bold(u)+bold(v))=A(bold(u)+bold(v))=A bold(u)+A bold(v)=T(bold(u))+T(bold(v))$
- $T(c bold(u))=A(c bold(u))=c(A bold(u))=c T(bold(u))$
]

#example[
In fact, $T$ in Exercise @ex:matrix-transformation is a matrix transformation
 $
T(mat(
x_1;x_2
))=mat(
x_1+x_2;
x_2
)=mat(
1,1;0,1
)mat(
x_1;x_2
)=A bold(x)
 $
]

#definition[
In general, if $T:RR^n->RR^m$ is a linear transformation, and ${bold(e)_1,bold(e)_2,dots.h.c,bold(e)_n}$ is the standard basis, then any $bold(x)=x_1bold(e)_1+dots.h.c+x_n bold(e)_n$, and
$
T(bold(x))=x_1T(bold(e)_1)+dots.h.c+x_n T(bold(e)_n)=mat(
T(bold(e)_1),dots.h.c ,T(bold(e)_n)
)mat(
x_1;dots.v;x_n
)
$<eq:stand-mat>
Denote $A=mat(
T(bold(e)_1),dots.h.c ,T(bold(e)_n)
)$ (which is called the #text(fill:blue)[standard matrix for the linear transformation $T$])#index[standard matrix], then $T(bold(x))=A bold(x)$, so every linear transformation $T$ from $RR^n->RR^m$ is a matrix transformation.
]

#example[
In Exercise @ex:matrix-transformation
 $
T(bold(e)_1)=T(mat(
1;0
))=mat(
1+0;0
)=mat(
1;0
),quad T(bold(e)_2)=T(mat(
0;1
))=mat(
0+1;1
)=mat(
1;1
)
 $
Therefore the standard matrix for $T$ is $mat(
1,1;0,1
)$.
]

#exercise[
Suppose $T:RR^2->RR^2$ is defined by $T(mat(
x_1;x_2
))=mat(
x_1+x_2+1;
x_2
)$. Is $T$ is a linear mapping?
]

#solution[
$T$ is not a linear transformation since
$T(bold(x))=mat(
1,1;0,1
)mat(
x_1;x_2
)+mat(
1;0
)=A bold(x)+bold(p)$ is not a matrix transformation @eq:stand-mat ($bold(p)!=0$)
]

#example[
Suppose $T:RR^2->RR^2$ is a linear transformation
- Suppose $T$ is the reflection over $x_2$-axis, then the standard matrix for $T$ is
 $
A=mat(
T(bold(e)_1),T(bold(e)_2)
)=mat(
-1,0;
0,1
)
 $
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(e)_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$bold(e)_2=T(bold(e)_2)$}; \draw[->, thick] (0,0)--(b);
// \draw[->, purple, thick] (0,0)--($(0,0)-(a)$) node[below left]{$T(bold(e)_1)$};
// \end{tikzpicture}
// \end{center}
- Suppose $T$ is the rotation by $60^circle.small$ counter-clockwise, then the standard matrix for $T$ is
 $
A=mat(
T(bold(e)_1),T(bold(e)_2)
)=mat(
 1 / 2 ,-sqrt(3)/2;
sqrt(3)/2, 1 / 2
)
 $
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \def\XMAX{1.5};\def\YMAX{1.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \draw[opacity=0.6, red, dashed] (0,0) circle (1);
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(e)_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$bold(e)_2$}; \draw[->, thick] (0,0)--(b);
// \coordinate (c) at ($cos(60)*(1,0)+sin(60)*(0,1)$); \node at (c)[above right]{\textcolor{purple}{$T(bold(e)_1)=mat(
//  cos 60^circle.small; sin 60^circle.small
// )$}}; \draw[->, purple, thick] (0,0)--(c);
// \coordinate (d) at ($cos(150)*(1,0)+sin(150)*(0,1)$); \node at (d)[above left]{#text(fill:blue){$mat(
//  cos 150^circle.small; sin 150^circle.small
// )=T(bold(e)_2)$}}; \draw[->, blue, thick] (0,0)--(d);
// \draw[opacity=0.6, purple, dashed] (c)--($cos(60)*(1,0)$);
// \draw[opacity=0.6, purple, dashed] (c)--($sin(60)*(0,1)$);
// \draw[opacity=0.6, blue, dashed] (d)--($cos(150)*(1,0)$);
// \draw[opacity=0.6, blue, dashed] (d)--($sin(150)*(0,1)$);
// \end{tikzpicture}
// \end{center}
]<ex:refl>

#exercise[
$T:RR^2->RR^2$ is the linear transformation that rotate $60^circle.small$ counter-clockwise and then reflects over $x_2$-axis, what is its standard matrix?
]<exer:rotate60deg-refl>

#solution[
The standard matrix for $T$ is
 $
A=mat(
T(bold(e)_1),T(bold(e)_2)
)=mat(
- 1 / 2 ,sqrt(3)/2;
sqrt(3)/2, 1 / 2
)
 $
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \def\XMAX{1.5};\def\YMAX{1.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \draw[opacity=0.6, red, dashed] (0,0) circle (1);
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(e)_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$bold(e)_2$}; \draw[->, thick] (0,0)--(b);
// \coordinate (c) at ($sin(60)*(0,1)-cos(60)*(1,0)$); \node at (c)[above left]{\textcolor{purple}{$T(bold(e)_1)=mat(
// - cos 60^circle.small; sin 60^circle.small
// )=mat(
//  cos 120^circle.small; sin 120^circle.small
// )$}}; \draw[->, purple, thick] (0,0)--(c);
// \coordinate (d) at ($sin(150)*(0,1)-cos(150)*(1,0)$); \node at (d)[above right]{#text(fill:blue){$T(bold(e)_2)=mat(
// - cos 150^circle.small; sin 150^circle.small
// )=mat(
//  cos 30^circle.small; sin 30^circle.small
// )$}}; \draw[->, blue, thick] (0,0)--(d);
// \draw[opacity=0.6, purple, dashed] (c)--($(0,0)-cos(60)*(1,0)$);
// \draw[opacity=0.6, purple, dashed] (c)--($sin(60)*(0,1)$);
// \draw[opacity=0.6, blue, dashed] (d)--($(0,0)-cos(150)*(1,0)$);
// \draw[opacity=0.6, blue, dashed] (d)--($sin(150)*(0,1)$);
// \end{tikzpicture}
// \end{center}
]

== Properties of linear transformations

#definition[
Suppose $T:RR^n->RR^m$ is a mapping. We call

- $RR^n$ the #text(fill:blue)[domain]#index[domain] of $T$
- $RR^m$ the #text(fill:blue)[codomain]#index[codomain] of $T$
- $T(bold(x))$ the #text(fill:blue)[image]#index[image] of $bold(x)$ under $T$
- $T^(-1)(bold(b))= bold(x)|T(bold(x))=bold(b)$ the set of #text(fill:blue)[preimages]#index[preimage] of $bold(b)$ under $T$
- the set of images ${T bold(x)|bold(x) in  RR^n}$ the #text(fill:blue)[range]#index[range] of $T$

]

#exercise[
Suppose the linear transformation $T:RR^3->RR^3$ is defined by $T(mat(
x_1;x_2;x_3
))=mat(
x_1-x_2+x_3; 2x_1-x_3; x_1+x_2+x_3
)$, what is the standard matrix of $T$? What is the image of $mat(
2;0;1
)$, what is the set of vectors with image $mat(
1;1;3
)$, what is the range?
]

#solution[
The standard matrix is $A=mat(
1,-1,1;
2,0,-1;
1,1,1
)$, the image $mat(
2;0;1
)$ under $T$ is
 $
T(mat(
2;0;1
))=mat(
1,-1,1;
2,0,-1;
1,1,1
)mat(
2;0;1
)=mat(
3;3;3
)
 $
The set of vectors with image $bold(b)=mat(
1;1;3
)$ under $T$ is the solution set to $T(bold(x))=A bold(x)=bold(b)$ (this is Example  @ex:example1), which is ${mat(
1;1;1
)}$. And since there is a pivot in each row, by Theorem @thm:matsol, the range of $T$ is $RR^3$
]

#definition[
A mapping $T$ is said to be #text(fill:blue)[onto] $RR^m$ if each $b in  RR^m$ is the image of at least one $x in RR^n$.
]

Codomain is larger than the range if $T$ is not onto

#definition[
A mapping $T$ is said to be #text(fill:blue)[one-to-one] if each $b in  RR^m$ is the image of at most one $x in RR^n$.
]

#theorem[
Suppose $A$ is the standard matrix for linear transformation $T$ (i.e. $T(bold(x))=A bold(x)$), then

- $T$ is one-to-one $<=> A bold(x)=bold(b)$ has at most one solution $<=> A bold(x)=bold(0)$ has the unique trivial solution $<=>$ RREF of $A$ has a pivot in each column $<=>$ columns of $A$ are linearly independent.
- $T$ is onto $<=> A bold(x)=bold(b)$ always has solution $<=>$ the columns of $A$ span $RR^m$ $<=>$ RREF of $A$ has a pivot in each row.

]<thm:1to1-onto-byeq>

#exercise[
Suppose the linear transformation $T:RR^3->RR^2$ is defined by $T(mat(
x_1;x_2;x_3
))=mat(
x_1-x_2+x_3; 2x_1-x_3
)$, Is $T$ onto? Is $T$ one-to-one?
]

#solution[
This is the Example @ex:example3. The standard matrix for $T$ is $A=mat(
1,-1,1;
2,0,-1
)xarrow(#`R2`-> #`R2`-2#`R1`)mat(
1,-1,1;
0,2,-3
)$, since there is a pivot in each row but not in each column, it is onto but not one-to-one
]

#exercise[
- If $T:RR^3->RR^2$ is a linear transformation, could it be one-to-one?
- If $T:RR^2->RR^3$ is a linear transformation, could it be onto?
]<exer:R2R3-1to1-onto>

#solution[
Both no! Due to Theorem @thm:1to1-onto-byeq

- Since $A$ is a $2 times 3$ matrix, there will be at most 2 pivots (only 2 rows), so there won't be enough pivots to fill all columns.
- Since $A$ is a $3 times 2$ matrix, there will be at most 2 pivots (only 2 columns), so there won't be enough pivots to fill all rows.

]

#exercise[
Suppose $T(mat(
x_1;x_2;x_3
))=mat(
x_1-x_2+x_3;2x_1-x_3;x_1+x_2-2x_3
)$.

- What is the domain of $T$?
- What is the codomain of $T$?
- What is the standard matrix of $T$?
- What is the image of $mat(
1;1;0
)$?
- What is the set of vectors with image being $mat(
1;1;1
)$?
- What is the set of vectors with image being $mat(
1;1;0
)$?
- Is $T$ onto?
- Is $T$ one-to-one?

]

== Composition of linear transformations

#definition[
Suppose

- $T_1:RR^p->RR^n$ is a linear transformation with standard matrix $A_1$ (which should be $n times  p$)
- $T_2:RR^n->RR^m$ is a linear transformation with standard matrix $A_2$ (which should be $m times  n$)

Define the #text(fill:blue)[composition]#index[composition] $T_2circle.small T_1$ of $T_1$ and $T_2$ as $(T_2circle.small T_1)(bold(x))=T_2(T_1(bold(x)))$
\begin{center}
\begin{tikzcd}
RR^p \arrow[r, "T_1"] \arrow[rr, "T_2circle.small T_1"', bend right] , RR^n \arrow[r, "T_2"] , RR^m
\end{tikzcd}
\end{center}
Then $T_2circle.small T_1:RR^p->RR^m$ is also a linear transformation (Why? Verify this). For $bold(x) in RR^p$,
 $
(T_2circle.small T_1)(bold(x))=T_2(T_1(bold(x)))=A_2(T_1(bold(x)))=A_2(A_1bold(x))=(A_2A_1)bold(x)
 $
So we have concluded that the standard matrix for $T_2circle.small T_1$ is the $m times  p$ matrix $A_2A_1$.
]

#note[
You should compose maps to the left.
]

#example[
Consider Example @ex:refl., If we let $T_1:RR^2->RR^2$ to denote the rotation by $60^circle.small$ counter-clockwise, $T_2:RR^2->RR^2$ to denote reflection over $x_2$-axis, and their standard matrices are
 $
mat(
 1 / 2 ,-sqrt(3)/2;sqrt(3)/2, 1 / 2
),quad mat(
-1,0;0,1
)
 $
Then look at Exercise @exer:rotate60deg-refl, this is the composition $T_2circle.small T_1$, which has the standard matrix
 $
A_2A_1=mat(
-1,0;0,1
)mat(
 1 / 2 ,-sqrt(3)/2;sqrt(3)/2, 1 / 2
)=mat(
- 1 / 2 ,sqrt(3)/2;
sqrt(3)/2, 1 / 2
)
 $
]

#question[
Suppose $A=mat(
 1 / 2 ,-sqrt(3)/2;sqrt(3)/2, 1 / 2
)$ is the standard matrix for the linear transformation of rotating $60^circle.small$ counter-clockwise (Example @ex:refl). What is $A^7$?
]

#answer[
$A^7=A A A A A A A$ is the standard matrix for composition of linear transformations $T circle.small T circle.small T circle.small T circle.small T circle.small T circle.small T$ which is rotate $7 times 60^circle.small=420^circle.small$, but that is the same as rotating $420^circle.small-360^circle.small=60^circle.small$ which is the same linear transformation as $T$, so $A^7=A$
// \begin{center}
// \begin{tikzcd}
// A^7=AAAAAAA \arrow[rr,equal]                                                                                                       ,  , A                                      ;
// T^{circle.small7}=T circle.small T circle.small T circle.small T circle.small T circle.small T circle.small T \arrow[rr,equal, ""same effect""'] \arrow[u, rightsquigarrow, ""Standard matrix""] ,  , T \arrow[u, rightsquigarrow, ""Standard matrix""']
// \end{tikzcd}
// \end{center}
]

#exercise[
Let $T$ be the linear transformation that rotate $RR^2$ counter-clockwise of angle $theta$, find the standard matrix for $T$. What about the standard matrix for $T^(circle.small 100)$
]

= Lecture 7 - Matrix transpose and matrix inverse

== Matrix transpose

#definition[
Suppose $A=mat(
a_(11),a_(12),dots.h.c,a_(1 n);
a_(21),a_(22),dots.h.c,a_(2 n);
dots.v,dots.v,,dots.v;
a_(m 1),a_(m 2),dots.h.c,a_(m n)
)$ is a $m times  n$ matrix, we define its #text(fill:blue)[transpose]#index[transpose] by flipping it over the diagonal, and this is the $n times  m$ matrix
 $
A^T=mat(
a_(11),a_(21),dots.h.c,a_(m 1);
a_(12),a_(22),dots.h.c,a_(m n);
dots.v,dots.v,,dots.v;
a_(1 n),a_(2 n),dots.h.c,a_(m n)
)
 $
]

#example[
Suppose $A=mat(
1,2,3;4,5,6
)$, then $A^T=mat(
1,4;2,5;3,6
)$
]

#theorem[
Here are some properties of matrix transpose

- $(A^T)^T=A$
- $(A+B)^T=A^T+B^T$
- $(c A)^T=c A^T$
- $(A B)^T=B^T A^T$

]

#definition[
For any $bold(v)=mat(
v_1;v_2;dots.v;v_n
),bold(w)=mat(
w_1;w_2;dots.v;w_n
) in RR^n$, we can define the #text(fill:blue)[dot product]#index[dot product] to be $bold(v) dot.c bold(w)=bold(v)^T bold(w)=v_1w_1+dots.h.c+v_n w_n$. $|bold(v)|=sqrt(bold(v)^T bold(v))=sqrt(v_1^2+dots.h.c+v_n^2)$ is the length $bold(v)$
]

#remark[
There is a nice geometric interpretation of dot product. Suppose the angle between $bold(v)$ and $bold(w)$ is $theta$, then $bold(v) dot.c bold(w)=|bold(v)||bold(w)| cos theta$.
% With a bit of trigonometry, we see it is the product of one vector and the projection of the other onto the first one.
// \begin{center}
// \begin{tikzpicture}[scale=3]
// \coordinate (a) at ($cos(30)*(1,0)+sin(30)*(0,1)$);
// \coordinate (b) at ($(1.2,0)$);
// \draw[->, thick] (0,0)--(a);
// \draw[->, thick] (0,0)--(b);
// % \draw[dotted] (a)--(a|-0,0);
// % \draw[->] (0,0)--(a|-0,0);
// \draw (0.2,0) arc (0:30:0.2);
// \node at (a)[right] {$bold(v)$};
// \node at (b)[right] {$bold(w)$};
// \node at (0.2,0)[above right] {$theta$};
// % \node at (a|-0,0)[below] {$bold(u)$};
// \end{tikzpicture}
// \end{center}
% Here $bold(u)$ is the projection of $bold(v)$ onto $bold(w)$
]

#exercise[
Let $bold(v)=mat(
1;-2;1
)$, $bold(w)=mat(
1;0;-1
)$.

- What is the length of $bold(v)$?
- What is $bold(v) dot.c bold(w)$?
- what is the angle between $bold(v)$ and $bold(w)$?

]

#question[
Have you wondered about how linear algebra would look like if we make the identification of row vectors $M_{1 times  n}(RR^n)$ and $RR^n$ instead of column vectors.
]

#answer[
The standard basis for $RR^n$ would be $\{bold(e)_1^T,bold(e)_2^T,dots.h.c,bold(e)_n^T\}$, where $bold(e)_j^T=mat(
0,dots.h.c,1,dots.h.c,0
)$, where every entry is 0 except the $j$-th entry being 1. For any $bold(x)^T in RR^n$ and any linear transformation $T:RR^n->RR^m$, we have
$
T(bold(x)^T),=T(bold(x))^T=(x_1T(bold(e)_1)+x_2T(bold(e)_2)+dots.h.c+x_n T(bold(e)_n))^T;
,=x_1T(bold(e)_1)^T+x_2T(bold(e)_2)^T+dots.h.c+x_n T(bold(e)_n)^T;
,=mat(
x_1,x_2,dots.h.c,x_n
)mat(
T(bold(e)_1)^T;T(bold(e)_2)^T;dots.v;T(bold(e)_n)^T
)=bold(x)^T A^T
$
Here $A=mat(
T(bold(e)_1),T(bold(e)_2),dots.h.c,T(bold(e)_n)
)$.

If you consider composition $T_2circle.small T_1$ where $T_1, T_2$ are linear transformations with standard matrices $A,B$, you would get
 $
(T_2circle.small T_1)(bold(x)^T)=T_2(T_1(bold(x)^T))=T_1(bold(x)^T)B^T=(bold(x)^T A^T)B^T=bold(x)^T(A^T B^T)
 $
On the other hand, we should know that $(T_2circle.small T_1)(bold(x)^T)=bold(x)^T(A^T B^T)$, so this implies $A^T B^T=(B A)^T$.
]

== Matrix inverse

#definition[
Suppose linear transformation $T:RR^n->RR^m$ is both onto and one-to-one (i.e. for each vector $bold(b)$ in the codomain $RR^m$ there is a unique preimage, which we denote as $T^(-1)(bold(b))$). Suppose $A$ is the standard matrix for $T$, then $m$ necessarily equal $n$ as shown in Exercise @exer:R2R3-1to1-onto, so $A$ must be a square matrix. We know $T(bold(x))=bold(b)$ always has a unique solution which should be $T^(-1)(bold(b))$, it can be shown that $T^(-1):RR^n->RR^n$ as mapping is actually also a linear transformation (Why? See if you can figure this out). Then the standard matrix of $T^(-1)$ is defined to be $A^(-1)$ (the #text(fill:blue)[inverse matrix]#index[inverse matrix] of $A$). Note that
$
,(T circle.small T^(-1))(bold(b))=T(T^(-1)(bold(b)))=T(bold(x))=bold(b);
,(T^(-1)circle.small T)(bold(x))=T^(-1)(T(bold(x)))=T^(-1)(bold(b))=bold(x)
$
Since $T circle.small T^(-1)$, $T^(-1)circle.small T$ work like the identity mappings, so $A A^(-1)=A^(-1)A=I$. In this case, we see that $A$ is equivalent to the identity matrix (because of Theorem @ex:example4, $A$ has a pivot in each row and column).
]

#remark[
Because we can write elementary row operations as left elementary matrix multiplications, so we know there are elementary matrices $E_1,E_2,dots.h.c,E_k$ such that
$
A,tilde  E_1A tilde  E_2E_1A tilde  E_3E_2E_1A tilde dots.h.c;
,tilde  E_k E_(k-1)dots.h.c E_2E_1A=I
$
If we multiply $A^(-1)$ on the right on both sides, we get $E_k E_(k-1)dots.h.c E_2E_1=A^(-1)$. Thanks to this observation, we introduce an algorithm for computing matrix inverses. Let's consider the RREF of the following partitioned matrix

$
mat(A,I; augment:#(-1)) &tilde mat(E_1A,E_1; augment:#(-1))tilde mat(E_2E_1A,E_2E_1; augment:#(-1))tilde dots.h.c \
&tilde mat(E_k E_(k-1)dots.h.c E_2E_1A,E_k E_(k-1)dots.h.c E_2E_1; augment:#(-1))=mat(I,A^(-1); augment:#(-1))
$
]

#exercise[
Find the inverse of the following matrices.
\begin{tasks}(3)
\task $A=mat(
-1,0;0,1
)$
\task $A=mat(
1,2;3,5
)$
\task $mat(
1,-1,1;
2,0,-1;
1,1,1;
)$
\end{tasks}
]<exer:inv-mat>

#solution[
-
$
&mat(
-1,0,1,0;
0,1,0,1;
augment:#(-1))xarrow(#`R1`->(-1)#`R1`)mat(
1,0,-1,0;
0,1,0,1;
augment:#(-1))
$
Hence $A^(-1)=mat(
-1,0;0,1
)$
- $
,mat(
1,2,1,0;
3,5,0,1; augment:#(-1))xarrow(#`R2`-> #`R2`-3#`R1`)mat(
1,2,1,0;
0,-1,-3,1; augment:#(-1));
,xarrow(#`R1`-> #`R1`+2#`R2`)mat(
1,0,-5,2;
0,-1,-3,1
; augment:#(-1))xarrow(#`R2`->(-1)#`R2`)mat(
1,0,-5,2;
0,1,3,-1
; augment:#(-1))
$
Hence $A^(-1)=mat(
-5,2;3,-1
)$
- $
&mat(
1,-1,1,1,0,0;
2,0,-1,0,1,0;
1,1,1,0,0,1;
augment:#(-1))xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-#`R1` )mat(
1,-1,1,1,0,0;
0,2,-3,-2,1,0;
0,2,0,-1,0,1;
augment:#(-1)) \
&xarrow(#`R3`-> #`R3`-#`R2`)mat(
1,-1,1,1,0,0;
0,2,-3,-2,1,0;
0,0,3,1,-1,1;
augment:#(-1))xarrow(#`R2`-> #`R2`+#`R3`)mat(
1,-1,1,1,0,0;
0,2,0,-1,0,1;
0,0,3,1,-1,1;
augment:#(-1)) \
&xarrow( #`R2`-> #`R2`/2 \ #`R3`-> #`R3`/3 )mat(
1,-1,1,1,0,0;
0,1,0,- 1 / 2 ,0, 1 / 2 ;
0,0,1, 1 / 3 ,- 1 / 3 , 1 / 3 ;
augment:#(-1))xarrow(#`R1`-> #`R1`+#`R2`-#`R3`)mat(
1,0,0, 1 / 6 , 1 / 3 , 1 / 6 ;
0,1,0,- 1 / 2 ,0, 1 / 2 ;
0,0,1, 1 / 3 ,- 1 / 3 , 1 / 3 ;
augment:#(-1))
$
Hence $A^(-1)=mat(
 1 / 6 , 1 / 3 , 1 / 6 ;
- 1 / 2 ,0, 1 / 2 ;
 1 / 3 ,- 1 / 3 , 1 / 3 ;
)$
]

== Properties of matrix transposes and inverses

#definition[
A square matrix $A$ is #text(fill:blue)[invertible] (or #text(fill:blue)[non-singular])#index[invertible] if it has an inverse $A^(-1)$ such that $A A^(-1)=A^(-1)A=I$. $A$ is called #text(fill:blue)[singular]#index[singular] if $A$ is not invertible.
]

#theorem[
Suppose $T$ is a linear transformation with standard matrix $A$, then
 $
T" is invertible with inverse "T^(-1)<=> A" is invertible with inverse "A^(-1)<=> A tilde  I
 $
]

#theorem[
$A=mat(
a,b;c,d
)$, $A^(-1)=1/(a d-b c)mat(
d,-b;-c,a
)$, here $"det "A=a d-b c$
]

#example[
If $A=mat(
 1 / 2 ,sqrt(3)/2;-sqrt(3)/2, 1 / 2
)$, then
 $
A^(-1)=\dfrac{1}{ 1 / 2  1 / 2 -sqrt(3)/2(-sqrt(3)/2)}mat(
 1 / 2 ,-sqrt(3)/2;sqrt(3)/2, 1 / 2
)=mat(
 1 / 2 ,-sqrt(3)/2;sqrt(3)/2, 1 / 2
)
 $
]

#theorem[
If $A$ is invertible, then the linear system $A bold(x)=bold(b)$ has a unique solution $bold(x)=A^(-1)bold(b)$
]

#proof[
Multiply $A^(-1)$ on the left on both sides
]

#example[
Let's consider~@eq:chicken-rabbit, in which case $A=mat(
1,1;2,4
)$, $bold(b)=mat(
10;26
)$, then $A^(-1)=1 / (1 dot.c 4-1 dot.c 2)mat(
4,-1;-2,1
)=mat(
2,- 1 / 2 ;-1, 1 / 2
)$, and
 $
bold(x)=A^(-1)bold(b)=mat(
2,- 1 / 2 ;-1, 1 / 2
)mat(
10;26
)=mat(
2 dot.c 10- 1 / 2  dot.c 26;-10+ 1 / 2  dot.c 26
)=mat(
7;3
)
 $
]

#theorem[
Here are some properties of matrix inverse

- $(A^(-1))^(-1)=A$
- $(A B)^(-1)=B^(-1)A^(-1)$
- $(A^T)^(-1)=(A^(-1))^T$

]<thm:invmat-property>

#exercise[
What is $(A^T)^(-1)$ in Exercise @exer:inv-mat, c)?
]

#solution[
Use Theorem @thm:invmat-property, we know
 $
(A^T)^(-1)=(A^(-1))^T=mat(
 1 / 6 , 1 / 3 , 1 / 6 ;
- 1 / 2 ,0, 1 / 2 ;
 1 / 3 ,- 1 / 3 , 1 / 3 ;
)^T=mat(
 1 / 6 ,- 1 / 2 , 1 / 3 ;
 1 / 3 ,0,- 1 / 3 ;
 1 / 6 , 1 / 2 , 1 / 3 ;
)
 $
]

#exercise[
Let $T:RR^n->RR^n$ be a linear transformation with standard matrix $A$.

- If $A$ is invertible, then $A$ has $n$ pivots. $checkmark$
- If $T$ is one-to-one, then $A$ is invertible. $checkmark$
- If columns of $A$ span $RR^n$, then $A$ is invertible. $checkmark$
- If $A$ is invertible, $A bold(x)=bold(0)$ only has the trivial solution. $checkmark$
- If $T$ is onto, then $T$ is one-to-one. $checkmark$
- If $T$ is one-to-one, then $T$ is onto. $checkmark$

]

#exercise[
Suppose $T:RR^3->RR^3$ is a linear transformation with standard matrix $A=mat(
1,2,3;
0,-1,-2;
0,0,1
)$. Is $A^(-1)$ invertible? Is $T$ one-to-one? Is $A^T$ invertible? If so, what is $(A^T)^(-1)$? If so, what is $(A^(-1))^(-1)$. Is $T$ invertible (i.e. does $T^(-1)$ exist)? What is the standard matrix of $T^(-1)$? Is $T$ onto?
]

#solution[
$
&mat(
A,I
; augment:#(-1))=mat(
1,2,3,1,0,0;
0,-1,-2,0,1,0;
0,0,1,0,0,1
; augment:#(-1))xarrow( #`R1`-> #`R1`-3#`R3` \ #`R2`-> #`R2`+2#`R3` )mat(
1,2,0,1,0,-3;
0,-1,0,0,1,2;
0,0,1,0,0,1
; augment:#(-1)) \
&xarrow(#`R2`-> (-1)#`R2`)mat(
1,2,0,1,0,-3;
0,1,0,0,-1,-2;
0,0,1,0,0,1
; augment:#(-1))xarrow(#`R1`-> #`R1`-2#`R2`)mat(
1,0,0,1,2,1;
0,1,0,0,-1,-2;
0,0,1,0,0,1
; augment:#(-1))=mat(
I,A^(-1)
; augment:#(-1))
$
So $A^(-1)=mat(
1,2,1;
0,-1,-2;
0,0,1
)$. By Theorem @thm:invmat-property, we know
 $
(A^(-1))^(-1)=A=mat(
1,2,3;
0,-1,-2;
0,0,1
)
 $
 $
(A^T)^(-1)=(A^(-1))^T=mat(
1,2,1;
0,-1,-2;
0,0,1
)^T=mat(
1,0,0;
2,-1,0;
1,-2,1
)
 $
Therefore we know $A^(-1)$ and $A^T$ are invertible. \
In general, if $T$ is invertible, then $A$ is invertible, so $A^(-1)$ will be the standard matrix for $T^(-1)$ as $T^(-1)(bold(x))=A^(-1)bold(x)$, in more explict terms, we have
 $
T^(-1)(mat(
x_1;x_2;x_3
))=mat(
1,2,1;
0,-1,-2;
0,0,1
)mat(
x_1;x_2;x_3
)=mat(
x_1+2x_2+x_3;-x_2-2x_2;x_3
)
 $
]

= Lecture 8 - Determinant

#definition[
We say a square matrix $A$ is #text(fill:blue)[upper triangular]#index[upper triangular] if it only has zeros to the left of the diagonal
 $
mat(
*,*,*,*,*,*;
0,*,*,*,*,*;
0,0,*,*,*,*;
0,0,0,*,*,*;
0,0,0,0,*,*;
0,0,0,0,0,*;
)
 $
$A$ is #text(fill:blue)[lower triangular]#index[lower triangular] if it only has zeros to the right of the diagonal
 $
mat(
*,0,0,0,0,0;
*,*,0,0,0,0;
*,*,*,0,0,0;
*,*,*,*,0,0;
*,*,*,*,*,0;
*,*,*,*,*,*;
)
 $
$A$ is #text(fill:blue)[diagonal] if $A$ only has nonzero entries on the diagonal
 $
mat(
*,0,0,0,0,0;
0,*,0,0,0,0;
0,0,*,0,0,0;
0,0,0,*,0,0;
0,0,0,0,*,0;
0,0,0,0,0,*
)
 $
A diagonal matrix is both upper triangular and lower triangular
]

== Geometric definition of determninants

Now let's introduce #text(fill:blue)[determinants] #index[determinant] (#text(fill:red)[ONLY for square matrices!!!]). Consider the parallelepiped $P$ with edges $bold(a)_1,dots.h.c,bold(a)_n$ in $RR^n$. We would like the following geometric definition of determinants.

#definition[
The determinant of $A=mat(
bold(a)_1,dots.h.c,bold(a)_n
)$ (Usually denoted $"det "A$ or $|A|=| mat( bold(a)_1,dots.h.c,bold(a)_n ) |$, replacing brackets with vertical lines) as _signed_ volumes of $P$ . Therefore we have $"Vol"(P)=|"det "A|$, i.e. actual volume is the absolute value of the determinant.
]

#example[[$n=1$]
Suppose $A=[a]$ is a 1 by 1 matrix, then $"det "A$ is the signed length of $a in RR^1$, which is $a$ itself! Namely $"det "A=a$.
// \begin{center}
// \begin{tikzpicture}
// \draw[->] (-2,0)--(2,0);
// \filldraw (0,0) circle (0.02);
// \draw[->, thick] (0,0)--(1,0) node[below] {$bold(a)$};
// \end{tikzpicture}
// \end{center}
]

#example[[$n=2$]
Suppose $A=mat(bold(a)_1,bold(a)_2)$ is a 2 by 2 matrix. $"det "A$ is the actual positive area of the parallelogram if $bold(a)_1$ turns counter-clockwise to $bold(a)_2$, otherwise the negative area.
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
// \node at (a1)[right] {$bold(a)_1$};
// \node at (a2)[above] {$bold(a)_2$};
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
// \node at (a1)[above] {$bold(a)_1$};
// \node at (a2)[right] {$bold(a)_2$};
// \node at ($0.5*(a1)+0.5*(a2)$){$-$};
// \end{scope}
// \end{tikzpicture}
// \end{center}
]

#example[[$n=3$]
Suppose $A=mat(bold(a)_1,bold(a)_2,bold(a)_3)$ is a 3 by 3 matrix. To decide the sign of the volume of the parallelepiped, we follow the #text(fill:blue)[right-hand rule].
// \begin{center}
//  in cludegraphics[scale=.3]{righthandrule.jpg}
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
]

Determinant has following three properties:

- Interchanging $bold(a)_1,bold(a)_2$ changes the sign of determinant. Namely $ "det" mat(bold(a)_2,bold(a)_1)=- "det" mat(bold(a)_1,bold(a)_2)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \begin{scope}[xshift=-5cm]
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(a)_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$bold(a)_2$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \node at (1,0.5) {$+$};
// \end{scope}
// \node at (0,0) {$\xrightarrow{"switch "bold(a)_1,bold(a)_2}$};
// \begin{scope}[xshift=5cm]
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(a)_2$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$bold(a)_1$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \node at (1,0.5) {$-$};
// \end{scope}
// \end{tikzpicture}
// \end{center}
// - Scaling $bold(a)_1$ scales the determinant. Namely $ "det" mat(c bold(a)_1,bold(a)_2)=c "det" mat(bold(a)_1,bold(a)_2)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \begin{scope}[xshift=-5cm]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(a)_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$bold(a)_2$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \end{scope}
// \node at (0,0) {$\xrightarrow{"double "bold(a)_1}$};
// \begin{scope}[xshift=5cm]
// \def\XMAX{3.5};\def\YMAX{3.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(a)_1$}; \draw[->] (0,0)--(a);
// \node at ($2*(a)$)[below right]{$2bold(a)_1$}; \draw[->] (0,0)--($2*(a)$);
// \coordinate (b) at (1,1); \node at (b)[above right]{$bold(a)_2$}; \draw[->] (0,0)--(b);
// \draw[blue] (0,0)--($2*(a)$)--($2*(a)+(b)$)--(b)--cycle;
// \draw[dashed] (a)--($(a)+(b)$);
// \end{scope}
// \end{tikzpicture}
// \end{center}
// - Adding a multiple of $bold(a)_1$ to $bold(a)_2$ doesn't change the determinant. Namely $ "det" mat(bold(a)_1,bold(a)_2+c bold(a)_1)= "det" mat(bold(a)_1,bold(a)_2)$
// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(a)_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (1,1); \node at (b)[above right]{$bold(a)_2$}; \draw[->] (0,0)--(b);
// \node at ($(b)-(a)$)[above left]{$bold(a)_2-bold(a)_1$}; \draw[->,red] (0,0)--($(b)-(a)$);
// \draw[blue] (0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \draw[red] (0,0)--(a)--(b)--($(b)-(a)$)--cycle;
// \end{tikzpicture}
// \end{center}

#remark[
If $\{bold(a)_1,dots.h.c,bold(a)_n\}$ is linearly dependent, then $A$ is singular, i.e. not invertible, then the determinant will be zero, since the parallelepiped will be constraint in a hyperplane which has zero volume. Take $n=2$ and $3$ for examples
// \begin{center}
// \begin{tikzpicture}
// \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(a)_1$}; \draw[->] (0,0)--(a);
// \coordinate (b) at (2,0); \node at (b)[below right]{$bold(a)_2$}; \draw[->] (0,0)--(b);
// \end{tikzpicture}quad
// \begin{tikzpicture}
// \def\XMAX{2.5};\def\YMAX{2.5};\def\ZMAX{4.5};
// % \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX,-\ZMAX) grid (\XMAX,\YMAX,\ZMAX);
// \draw[->, color=gray!80] (-\XMAX,0,0)--(\XMAX,0,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX,0)--(0,\YMAX,0) node[above]{$x_2$};
// \draw[->, color=gray!80] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_3$};
// \coordinate (a) at (2,0,0); \node at (a)[below right]{$bold(a)_1$}; \draw[->] (0,0,0)--(a);
// \coordinate (b) at (0,0,2); \node at (b)[below right]{$bold(a)_2$}; \draw[->] (0,0,0)--(b);
// \coordinate (c) at (-1,0,1); \node at (c)[below left]{$bold(a)_3$}; \draw[->] (0,0,0)--(c);
// \draw[blue] (0,0,0)--(a)--($(a)+(b)$)--(b)--cycle;
// \draw[blue] (0,0,0)--(a)--($(a)+(c)$)--(c)--cycle;
// \draw[blue] (0,0,0)--(b)--($(b)+(c)$)--(c)--cycle;
// \draw[blue] (a)--($(a)+(b)$)--($(a)+(b)+(c)$)--($(a)+(c)$)--cycle;
// \draw[blue] (b)--($(a)+(b)$)--($(a)+(b)+(c)$)--($(b)+(c)$)--cycle;
// \draw[blue] (c)--($(a)+(c)$)--($(a)+(b)+(c)$)--($(b)+(c)$)--cycle;
// \end{tikzpicture}
// \end{center}
]

== Properties of determinants

#theorem[
Suppose $A=mat(
h,0;
*,B
)$ or $mat(
h,*;
bold(0),B
)$ where $h$ is a scalar, $B$ is a $(n-1) times (n-1)$ submatrix, then $"det "A=h dot.c "det "B$.
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
// \filldraw[blue!50] (o)--(a)--($(a)+(b)$)node[above]{$"det "B$}--(b)--cycle;
// \draw[color=gray!80] (-\XMAX,0,0)--(\XMAX,0,0);
// \draw[color=gray!80] (0,-\YMAX,0)--(0,\YMAX,0);
// \draw[->, color=gray!80] (0,0,-\ZMAX)--(0,0,\ZMAX) node[below left]{$x_j$};
// \draw[->] (o)--(v);
// \draw[dashed] (o)--(vpxy)--(v);
// \draw[dashed] (vpz)node[left]{$h$}--(v);
// \end{scope}
// \end{tikzpicture}
// \end{center}
]<thm:det-A-theorem>

\begin{corollary}
Determinant of a triangular matrix is the product of the diagonal elements.
\end{corollary}

#proof[
Apply Theorem @thm:det-A-theorem repeatedly.
]

#theorem[
$"det"(A)="det"(A^T)$
]<thm:detAdetAT>

Thanks to Theorem @thm:detAdetAT, we can compute determinants via elementary row and column operations.

#example[
Use elementary row operations to evaluate the following (Note that we omit the backward phase (which are replacements) since it doesn't change the determinants)
+
$
&abs( mat(delim:#none,
1,-1,1;
2,0,-1;
1,2,1;
 ) )xequal( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-#`R1` )abs( mat(delim:#none,
1,-1,1;
0,2,-3;
0,3,0;
 ) )xequal("factor "#`R3`)3 abs( mat(delim:#none,
1,-1,1;
0,2,-3;
0,1,0;
 )) xequal(#`R2`-> #`R2`-2#`R3`)3 abs( mat(delim:#none,
1,-1,1;
0,0,-3;
0,1,0;
 ) ) \
&xequal(#`R2` arrow.l.r  #`R3`)(-1) dot.c 3 abs( mat(delim:#none,
1,-1,1;
0,1,0;
0,0,-3;
 ) )=(-1) dot.c 3 dot.c 1 dot.c 1 dot.c (-3)=9
$
+
$
&abs( mat(
1,2,1;
2,0,-1;
-1,2,2;
 ) )xequal( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`+#`R1` )abs( mat(delim:#none,
1,2,1;
0,-4,-3;
0,4,3;
 ) )xequal(#`R3`-> #`R3`+#`R2`)abs( mat(delim:#none,
1,2,1;
0,-4,-3;
0,0,0;
 ) ) \
 &=1 dot.c (-4) dot.c 0=0
$
+
 $
&abs( mat(delim:#none,
1,2,0,0;
2,8,0,0;
1,3,2,0;
-4,5,7,1
 ) )xequal(#`C2`-> #`C2`-2#`C1`)abs( mat(delim:#none,
1,0,0,0;
2,4,0,0;
1,1,2,0;
-4,13,7,1
 ) )xequal("transpose")abs( mat(delim:#none,
1,2,1,-4;
0,4,1,13;
0,0,2,7;
0,0,0,1
 ) ) \
 &=1 dot.c 4 dot.c 2 dot.c 1=8
 $
]

#exercise[
Suppose $I$ is the $n times  n$ identity matrix, what is $"det "I$, $"det"(-I)$, $"det"(2I)$ and $"det"(a I)$?
]

#solution[
Note that $I$ is a diagonal matrix. $"det "I=1$, $"det"(-I)=(-1)^n$, $"det"(2I)=2^n$, and in general $"det "(a I)=a^n$ by factoring each row.
]

#example[
Suppose $A=mat(
a,b;
c,d
)$
 $
abs( mat(delim: #none,
a,b;
c,d
 ) )xequal(#`R2`-> #`R2`- c / a #`R1`) abs( mat(delim: #none,
a,b;
0,d- b c / a
 ) )=a(d- b c / a )=a d-b c
 $
]

#definition[
Suppose $T:RR^n->RR^n$ is a linear transformation with standard matrix $A$, the determinant of $T$ is defined to be $"det "T="det "A$.
]

#question[
Suppose $T:RR^2->RR^2$ is a linear transformation with standard matrix $A=mat(
T(bold(e)_1),T(bold(e)_2)
)=mat(
2,1;1,2
)$. What is the area of the image of the unit circle under $T$?
]

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
// \coordinate (e1) at (1,0); \node at (e1)[above right]{$bold(e)_1$}; \draw[->] (0,0)--(e1);
// \coordinate (e2) at (0,1); \node at (e2)[above right]{$bold(e)_2$}; \draw[->] (0,0)--(e2);
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
// \coordinate (v1) at (2,1); \node at (v1)[above right]{$T(bold(e)_1)$}; \draw[->] (0,0)--(v1);
// \coordinate (v2) at (1,2); \node at (v2)[above]{$T(bold(e)_2)$}; \draw[->] (0,0)--(v2);
// \draw[rotate=45] (0,0) ellipse (5.1 and 1.8);
// \end{scope}
// \end{tikzpicture}
// \end{center}
// Since every small blue squares has been deformed into small parallelograms which are congruent to the gray square, parallelogram respectively and are of the same (signed) ratio $"det "A$, so any area gets scaled by $"det "A=2 dot.c 2-1 dot.c 1=3$ under $T$.
// ]

#remark[
In multi-variable calculus, this is known as the #text(fill:blue)[Jacobian].
]

#theorem[
Suppose $A,B$ are $n times  n$ matrices, then $"det"(A B)=("det "A)("det "B)$
]

#proof[
Suppose $T_1,T_2$ are linear transformations with standard matrices $A,B$, respectively. Consider $T_2circle.small T_1$ which should scale area by $"det"(B A)$. On the other hand, this should scale area by $"det "A$ and then $"det "B$
]

#theorem[
$A$ is invertible $<=>"det "A!=0$. In addition, $"det"(A^(-1))=\dfrac{1}{"det "A}$.
]

#proof[
If $A$ is invertible, then $A^(-1)$ is well-defined, then $1="det "I="det"(A A^(-1))=("det "A)("det"(A^(-1))) =>  "det"(A^(-1))=\dfrac{1}{"det "A}$, so $"det "A!=0$. Conversely, if $"det "A!=0$, $A$ would have $n$ pivots, so a pivot in each row and column, thus $A$ will be invertible.
]

#exercise[
Compute the determinants of the following matrices

- $mat(
1,-2;4,3
)$
- $mat(
1,5,-4;
-1,-4,5;
-2,-8,7
)$
- $mat(
0,0,0,1;
0,2,0,3;
0,7,-1,-8;
2,2,-5,1
)$

]

== Cofactor expansion

There is one more property of determinants. $ "det" mat(
bold(w),bold(u)+bold(v)
)= "det" mat(
bold(w),bold(u)
)+ "det" mat(
bold(w),bold(v)
)$

// \begin{center}
// \begin{tikzpicture}[scale=1]
// \def\XMAX{2.5};\def\YMAX{2.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \coordinate (o) at (0,0);
// \coordinate (w) at (1,0); \draw[->] (o)--(w)node[below right]{$bold(w)$};
// \coordinate (u) at (1,1); \draw[->,blue] (o)--(u)node[above right]{$bold(u)$};
// \coordinate (v) at (-0.5,1); \draw[->,red] (o)--($(u)+(v)$)node[above]{$bold(v)$};
// \draw[dashed,blue] (u)--($(u)+(w)$)--(w);
// \draw[dashed,blue] ($(u)+(v)$)--(u)--($(u)+(w)$)--($(u)+(w)+(v)$)--cycle;
// \draw[dashed,red] ($(u)+(v)$)--($(u)+(w)+(v)$)--(w);
// \end{tikzpicture}
// \end{center}

#definition[
We use $a_(i j)$ to be denote the $(i,j)$-th entry of the matrix $A$, and $A_(i j)$ to denote the submatrix of $A$ by deleting the $i$-th row and the $j$-th column
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
// \node at (0,0) {$A_(i j)=mat(
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
We define the #text(fill:blue)[$(i,j)$-cofactor]#index[cofactor] to be $C_(i j)=(-1)^{i+j}"det "A_(i j)$ (we also call $"det "A_(i j)$ a #text(fill:blue)[minor]#index[minor]).
]

For $n>=2$, with the help of Lemma "lemma:det-A-lemma", we derive cofactor expansion formula.

The #text(fill:blue)[cofactor expansion]#index[cofactor expansion] across the $i$-th row is
 $
"det "A=a_(i 1)C_(i 1)+a_(i 2)C_(i 2)+dots.h.c+a_(i n)C_(in)
 $
The cofactor expansion across the $j$-th column is
 $
"det "A=a_(1 j)C_(1j)+a_(2 j)C_(2j)+dots.h.c+a_(n j)C_(n j)
 $
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
// ,,a_(1 j),,,;
// ,,a_(2 j),,,;
// ,,dots.v,,,;
// ,,a_(n j),,,;
// )$};
// \end{tikzpicture}
// \end{center}

#proof[[Proof of Theorem @thm:detAdetAT]
Note that row cofactor expansion of $A$ is the same as column cofactor expansion of $A^T$. Hence we can prove this inductively on the size of the matrix.
]

#example[
$
&abs( mat(delim:#none,
1,2,3,0;
0,3,-1,0;
-1,2,1,2;
2,-3,1,0
 ) )xequal("cofactor expansion across last column")2(-1)^{3+4}abs( mat(delim:#none,
1,2,3;
0,3,-1;
2,-3,1
 ) ) \
&xequal(#`R3`-> #`R3`-2#`R1`)(-2)abs( mat(delim:#none,
1,2,3;
0,3,-1;
0,-7,-5
 ) )xequal("cofactor expansion across first column")(-2) dot.c 1(-1)^{1+1}abs( mat(delim:#none,
3,-1;
-7,-5
 ) ) \
&=(-2)(3(-5)-(-1)(-7))=44
$
]

#remark[
When use the cofactor expansion, we want to apply it to rows/columns with more 0's
]

#exercise[
  Suppose $A=mat(
  1,-1,1;
  2,0,-1;
  1,1,1;
  )$. Please find the cofactor expansion of $A$ across the
  \begin{tasks}(2)
  \task 1st row
  \task 2nd column
  \end{tasks}
  And evaluate determinant of $A$.
]

#solution[
$
"det "A&=a_(11)C_(11)+a_(12)C_(12)+a_(13)C_(13) \
&=a_(11)(-1)^{1+1}"det "A_(1 1)+a_(12)(-1)^{1+2}"det "A_(1 2)+a_(13)(-1)^{1+3}"det "A_(1 3) \
&=1 dot.c (-1)^{1+1}| mat(
0,-1;1,1
 ) |+(-1) dot.c (-1)^{1+2}| mat(
2,-1;1,1
 ) |+1 dot.c (-1)^{1+3}| mat(
2,0;1,1
 ) | \
&=1 dot.c (0 dot.c 1-(-1) dot.c 1)+(-1) dot.c (2 dot.c 1-(-1) dot.c 1)+1 dot.c (-1)(2 dot.c 1-(-1) dot.c 1) \
&=6
$
$
"det "A&=a_(12)C_(12)+a_(22)C_(22)+a_(32)C_(32) \
&=a_(11)(-1)^{1+1}"det "A_(1 1)+a_(12)(-1)^{1+2}"det "A_(1 2)+a_(13)(-1)^{1+3}"det "A_(1 3) \
&=(-1) dot.c (-1)^{1+2}| mat(
2,-1;1,1
 ) |+0 dot.c (-1)^{2+2}| mat(
1,1;1,1
 ) |+1 dot.c (-1)^{3+2}| mat(
1,1;2,-1
 ) | \
&=(-1) dot.c (-1)(2 dot.c 1-(-1) dot.c 1)+0 dot.c (1 dot.c 1-1 dot.c 1)+1 dot.c (-1)(1 dot.c (-1)-1 dot.c 2) \
&=6
$
]

#exercise[
Suppose $A=mat(
1,2,1;
1,0,-1;
-1,2,1
)$. Write out the cofactor expansion of $A$ across the second row, and evaluate the determinant $"det "A$.
]

#solution[
$
"det "A&=a_(21)C_(21)+a_(22)C_(22)+a_(23)C_(23) \
&=a_(21)(-1)^{2+1}"det "A_(2 1)+a_(22)(-1)^{2+2}"det "A_(2 2)+a_(23)(-1)^{2+3}"det "A_(2 3);
&=1 dot.c (-1)^{2+1}| mat(
2,1;2,1
 ) |+0 dot.c (-1)^{2+2}| mat(
1,1;-1,1
 ) |+(-1) dot.c (-1)^{2+3}| mat(
2,1;2,1
 ) | \
,=1 dot.c (-1)(2 dot.c 1-1 dot.c 2)+0 dot.c (1 dot.c 1-1 dot.c (-1))+(-1) dot.c (-1)(1 dot.c 2-2 dot.c (-1)) \
&=4
$
]

#remark[
The REF of a square matrix $A$ is upper triangular, and $"det "A=0$ if $A$ has less then $n$ pivots.
]

#exercise[
Suppose $A=mat(
2,-1,3,1;
0,-2,0,-1;
0,0,3,1;
0,0,0,1
)$. Please find use cofactor expansion  to find the $"det "A$
]

#solution[
Note that $A$ is upper triangular, so we could do cofactor expansions across first columns multiple times
$
| mat(
2,-1,3,1;
0,-2,0,-1;
0,0,3,1;
0,0,0,1
 ) |=2(-1)^{1+1}| mat(
-2,0,-1;
0,3,1;
0,0,1
 ) |=2 dot.c (-2)(-1)^{1+1}| mat(
3,1;
0,1
 ) |=2 dot.c (-2) dot.c 3 dot.c (-1)^{1+1}1=-12
$
]

#exercise[
Consider $A=mat(
a,b;c,d
)$. What is $A_(1 1),A_(1 2),A_(2 1),A_(2 2)$? What is $C_(11),C_(12),C_(21),C_(22)$. Write down the cofactor expansion of $A$ across the

- 1st row
- 2nd row
- 1st column
- 2nd column

]

#solution[
$A_(1 1)=[d],A_(1 2)=[c],A_(2 1)=[b],A_(2 2)=[a]$ are all 1 by 1 matrices. $C_(11)=(-1)^{1+1}"det "A_(1 1)=d,C_(12)=(-1)^{1+2}"det "A_(2 1)=-c,C_(21)=(-1)^{2+1}"det "A_(2 1)=-b,C_(22)=(-1)^{2+2}"det "A_(2 2)=a$. So the cofactor expansions are

- $"det "A=a C_(11)+b C_(12)=a d-b c$
- $"det "A=c C_(21)+d C_(22)=-b c+a d$
- $"det "A=a C_(11)+c C_(21)=a d-b c$
- $"det "A=b C_(12)+d C_(22)=-b c+a d$

Note that all of the above calculations show that $"det "A= "det" mat(
a,b;c,d
)=a d-b c$.
]

= Lecture 9 - Vector spaces and subspaces

== Vector space

To motivate the definition of a vector space, let's consider the following example

#example[
Let $PP_n$ denote the set of (real) polynomials of degree less or equal to $n$. For example $PP_0=RR$ is just the set of real numbers, and
$
PP_1,={a_0+a_1t|a_0,a_1 in RR} \
PP_2,={a_0+a_1t+a_2t^2|a_0,a_1,a_2 in RR} \
PP_3,={a_0+a_1t+a_2t^2+a_3t^3|a_0,a_1,a_2,a_3 in RR} \
,dots.v;
PP_n,={a_0+a_1t+a_2t^2+dots.h.c+a_n t^n|a_0,a_1,a_2,dots.h.c,a_n in RR}
$
You may soon realize that $PP_n$ can be identified with $RR^(n+1)$.
// \begin{center}
// \begin{tikzcd}
// PP_1 \arrow[r,equal,"tilde "]        , RR^2   ;
// \{a_0+a_1t\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_0;a_1)} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// PP_2 \arrow[r,equal,"tilde "]        , RR^3;
// \{a_0+a_1t+a_2t^2\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_0;a_1;a_2)} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// PP_n \arrow[r,equal,"tilde "]        , RR^(n+1)          ;
// \{a_0+a_1t+a_2t^2+dots.h.c+a_n t^n\} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_0;a_1;dots.v;a_n)} \arrow[u, equal]
// \end{tikzcd}
// \end{center}
More concrete examples could be
- For $PP_1 tilde.equiv RR^2$, $1+2t arrow.squiggly mat(
1;2
)$
- For $PP_2 tilde.equiv RR^3$, $3t^2-1 arrow.squiggly mat(
-1;0;3
)$
If we consider addition and scalar multiplication, we have
// \begin{center}
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration= zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}
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
// quad
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration= zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}
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
So we may conclude that addition and scalar multiplication in $PP_n$ can be identically translated to addition and scalar multiplication in $RR^(n+1)$
]<ex:P_n>

#remark[
We call ${1,t,t^2,dots.h.c,t^n}$ the _standard basis_ of $PP_n$, corresponding to the standard basis for $RR^(n+1)$
]

#example[
${1,t,t^2}$ is the standard basis for $PP_2$, and
$
p(t),=a_0+a_1t+a_2t^2=a_0 dot.c  1+a_1 dot.c  t+a_2 dot.c  t^2
$
]

#example[
Let's denote $M_(m times  n)(RR)$ the set of $m times  n$ matrices. For example
$
M_{2 times 2}(RR),={mat(
a_(11),a_(12);
a_(21),a_(22)
)mid(|)a_(11),a_(12),a_(21),a_(22) in RR}	\
M_{3 times 2}(RR),={mat(
a_(11),a_(12);
a_(21),a_(22);
a_(31),a_(32)
)mid(|)a_(11),a_(12),a_(21),a_(22),a_(31),a_(32) in RR}	\
M_{2 times 3}(RR),={mat(
a_(11),a_(12),a_(13);
a_(21),a_(22),a_(23)
)mid(|)a_(11),a_(12),a_(13),a_(21),a_(22),a_(23) in RR}	\
,dots.v;
M_(m times  n)(RR),={mat(
a_(11),a_(12),dots.h.c,a_(1 n);
a_(21),a_(22),dots.h.c,a_(2 n);
dots.v,dots.v,,dots.v;
a_(m 1),a_(m 2),dots.h.c,a_(m n);
)mid(|)a_(11),dots.h.c,a_(1 n),dots.h.c,a_(m 1),dots.h.c,a_(m n) in RR}.
$
You may realize that $M_(m times  n)(RR)$ can be identified with $RR^{m n}$
// \begin{center}
// \begin{tikzcd}
// M_{2 times  2}(RR) \arrow[r,equal,"tilde "]        , RR^{4}   ;
// {mat(
// a_(11),a_(12);
// a_(21),a_(22)
// )} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_(11);a_(12);a_(21);a_(22))} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// M_{3 times  2}(RR) \arrow[r,equal,"tilde "]        , RR^{6}   ;
// {mat(
// a_(11),a_(12);
// a_(21),a_(22);
// a_(31),a_(32)
// )} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_(11);a_(12);a_(21);a_(22);a_(31);a_(32))} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// M_{2 times  3}(RR) \arrow[r,equal,"tilde "]        , RR^{6}   ;
// {mat(
// a_(11),a_(12),a_(13);
// a_(21),a_(22),a_(23)
// )} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_(11);a_(12);a_(13);a_(21);a_(22);a_(23))} \arrow[u, equal]
// \end{tikzcd}
// \begin{tikzcd}
// M_(m times  n)(RR) \arrow[r,equal,"tilde "]        , RR^{m n}   ;
// {mat(
// a_(11),a_(12),dots.h.c,a_(1 n);
// a_(21),a_(22),dots.h.c,a_(2 n);
// dots.v,dots.v,,dots.v;
// a_(m 1),a_(m 2),dots.h.c,a_(m n);
// )} \arrow[r, leftrightsquigarrow] \arrow[u, equal] , {mat(a_(11);dots.v;a_(1 n);dots.v;a_(m 1);dots.v;a_(m n))} \arrow[u, equal]
// \end{tikzcd}
// \end{center}
// In more concrete terms, addition and scalar multiplication can be identified as the following
// \begin{center}
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration= zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}
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
// quad
// \begin{tikzpicture}
// \tikzset{<-squig->/.style={to-to, decorate, decoration= zigzag,segment length=5,amplitude=1,pre=lineto,post=lineto,post length=2pt,pre length=2pt}}
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
So we may conclude that addition and scalar multiplication in $M_(m times  n)(RR)$ can be identically translated to addition and scalar multiplication in $RR^{m n}$
]<ex:Mmn-as-vectsp>

#remark[
We call ${E_(i j)}$ the _standard basis_ of $M_(m times  n)(RR)$, corresponding to the standard basis for $RR^{m n}$. Here $E_(i j)$ is the $m times  n$ matrix that only has a single 1 in the $(i,j)$-th spot, but 0's elsewhere.
]

#example[
$ {E_(11)=mat(
1,0;0,0
),E_(12)=mat(
0,1;0,0
),E_(21)=mat(
0,0;1,0
),E_(22)=mat(
0,0;0,1
)} $ is the standard basis for $M_{2 times 2}(RR)$, and
$
mat(
a_(11),a_(12);a_(21),a_(22)
)&=mat(
a_(11),0;0,0
)+mat(
0,a_(12);0,0
)+mat(
0,0;a_(21),0
)+mat(
0,0;0,a_(22)
) \
&=a_(11)mat(
1,0;0,0
)+a_(12)mat(
0,1;0,0
)+a_(21)mat(
0,0;1,0
)+a_(22)mat(
0,0;0,1
) \
&=a_(11)E_(11)+a_(12)E_(12)+a_(21)E_(21)+a_(22)E_(22)
$
]

#definition[
A #text(fill:blue)[(real) vector space]#index[vector space] is a set $V$ of objects, called _vectors_, on which are defined two operations, called _addition_ $"fatplus"$ and _(left) scalar multiplication_ $"fatdot"$, subject to axioms
\begin{enumerate}\setcounter{enumi}{-1}
- $\bm u"fatplus"\bm v$ and $c"fatdot"\bm v$ are still in $V$
- $\bm u"fatplus"\bm v=\bm v"fatplus"\bm u$
- $(\bm u"fatplus"\bm v)"fatplus"\bm w=\bm u"fatplus"(\bm v"fatplus"\bm w)$
- There is a _zero vector_ $\bm 0$ such that $\bm u"fatplus"\bm 0=\bm u$
- For each $\bm u$ in $V$, there is a vector $"fatminus"\bm u$ in $V$ such that $\bm u"fatplus"("fatminus"\bm u)=\bm 0$
- $c"fatdot"(\bm u"fatplus"\bm v)=c"fatdot"\bm u"fatplus" c"fatdot"\bm v$
- $(c+d)"fatdot"\bm u=c"fatdot"\bm u"fatplus" d"fatdot"\bm u$
- $c"fatdot"(d"fatdot"\bm u)=(c d)"fatdot"\bm u$
- $1"fatdot"\bm u=\bm u$
]

#example[
Set $V$ to be $RR^n$, $"fatplus"$ to be addition $+$ for vectors, $"fatdot"$ to be scalar multiplication $ dot.c $ for vectors, then this is a vector space
]

#example[[non-example]
Suppose $V=RR$, $a"fatplus" b=a+b+1$, $c"fatdot" a=c dot.c  a=c a$, we can check
\begin{enumerate}\setcounter{enumi}{-1}
- $a"fatplus" b=a+b+1 in RR$, $c"fatdot" a=c a in RR$
- $a"fatplus" b=a+b+1=b+a+1=b"fatplus" a$
- $(a"fatplus" b)"fatplus" c=(a+b+1)+c+1=a+(b+c+1)+1=a"fatplus"(b"fatplus" c)$
- There is a _zero vector_ $\bm 0=-1$ such that $a"fatplus"\bm 0=a+(-1)+1=a$
- For each $a$, we have $"fatminus" a=-a-2$ such that $a"fatplus"("fatminus" a)=a+(-a-2)+1=-1=\bm 0$
However $2"fatdot"(a"fatplus" b)=2(a+b+1)!= 2a+2b+1=2"fatdot" a"fatplus" 2"fatdot" b$. Therefore, this is not a vector space
]

== Subspace

#definition[
Suppose $V$ is a vector space with addition $"fatplus"$ and scalar multiplication $"fatdot"$. A #text(fill:blue)[subspace]#index[subspace] $H$ is a non-empty subset which closed under addition and scalar multiplication, i.e. for any $\bm u,\bm v in  H$, $c in RR$, $\bm u"fatplus"\bm v,c"fatdot"\bm u in  H$
]

#remark[
It is easy to check that a subspace $H$ is again a vector space.
]

#exercise[
Recall that $M_{2 times 2}(RR)$ is the set of 2 by 2 matrices, and that a square matrix $A$ is _symmetric_ if $A^T=A$. Consider a subset $V$ consists of 2 by 2 symmetric matrices, i.e. $V={A in  M_{2 times 2}(RR) mid(|)A^T=A}$
- Show that $V$ is a vector space.
- Find a basis for $V$.
]<exer:2by2sym-as-vectsp>

#solution[
- For any $A,B in  V$, $c in RR$, by definition we know that $A^T=A$, $B^T=B$, we want to show that $A+B in  V$, $c A in  V$ (condition for subspace), i.e. $(A+B)^T=A^T+B^T$, $(c A)^T=c A$. This is true because
 $
(A+B)^T=A^T+B^T=A+B,quad (c A)^T=c A^T=c A
 $
Therefore $V$ is a subspace of $M_{2 times 2}(RR)$, and thus a vector space
- Suppose $A=mat(
a_(11),a_(12);a_(21),a_(22)
) in  M_{2 times 2}(RR)$, then $a_(12)=a_(21)$, so we may conclude that
 $
V={mat(
a,b;b,c
) in  M_{2 times 2}(RR) mid(|)a,b,c in RR}
 $
Note that
$
mat(
a,b;b,c
)=mat(
a,0;0,0
)+mat(
0,b;b,0
)+mat(
0,0;0,c
)=a mat(
1,0;0,0
)+b mat(
0,1;1,0
)+c mat(
0,0;0,1
)
$<eq:2by2mat-decomp>
And that linear combination~@eq:2by2mat-decomp is the zero matrix $<=> a=b=c=0$, thus $cal(B)={mat(
1,0;0,0
),mat(
0,1;1,0
),mat(
0,0;0,1
)}$ is a basis for $V$
]

#exercise[
Suppose $H=\{p(t)=a_0+a_1t+a_2t^2 in PP_2|a_0+a_1+a_2=0\}$ is the set of polynomials of degree $\leq 2$ and sum of coefficients zero. Show that $H$ is a vector space.
]<kerT-sum-coef-of-poly>

#example[
Consider the vector space $V=RR^2$, and $H$ is the set of solutions to the linear equation $2x_1-x_2+2=0$, then $H$ is not a subspace. For example, if we choose $bold(u)=mat(
-1;0
),bold(v)=mat(
0;2
)$, then $bold(u)+bold(v)=mat(
-1;2
)$ is not in $H$, nor is $2bold(u)=mat(
-2;0
)$
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
// \coordinate (u) at (-1,0); \node at (u)[below right]{$bold(u)$}; \draw[->,thick] (0,0)--(u);
// \coordinate (v) at (0,2); \node at (v)[below right]{$bold(v)$}; \draw[->,thick] (0,0)--(v);
// \draw[->,thick,blue] (0,0)--(1,2);
// \node at ($2*(u)$)[below right]{$2bold(u)$}; \draw[->] (0,0)--($2*(u)$);
// \node at ($(u)+(v)$)[below left]{$bold(u)+bold(v)$}; \draw[->] (0,0)--($(u)+(v)$);
// % \draw[dashed] (u)--($(u)+(v)$); \draw[dashed] (v)--($(u)+(v)$);
// \node at (-2,-2)[left] {$H$};
// \node at (1,2)[below right] {$H_1$};
// \end{tikzpicture}
// \end{center}
The reason is that $H$ is not homogeneous. If we consider $H_1$ to be solution set of the homogeneous equation $2x_1-x_2=0$, we see that $H_1$ is a subspace as it is the span of a single vector $mat(
1;2
)$.
]<ex:hyperplane-not-subsp>

= Lecture 10 - Null spaces, Column spaces, Row spaces, Rank and Nullity

== Null space, Column Space and Row space

#definition[
Suppose $V$ is a vector space, $\{\bm v_1,\bm v_2,dots.h.c,\bm v_n\} subset.eq V$ is a set of linearly independent vectors that span $V$, we define the #text(fill:blue)[dimension]#index[dimension] of $V$ to be $"dim" V=n$.
]

#definition[
Suppose $A$ is a $m times  n$ matrix, we define the #text(fill:blue)[null space]#index[null space] of $A$ to be
 $
"Nul"A=\{bold(x) in RR^n|A bold(x)=bold(0)\}="solution set of $A bold(x)=bold(0)$"
 $
Note that the solution set to linear system $A bold(x)=bold(0)$ is the intersection of $m$ hyperplanes (one for each homogeneous equation) that pass through the origin.
]

#example[
$A=mat(
1,-3,2;
-5,12,-1
)$, the to find the $"Nul"A$ is equivalent to solve $A bold(x)=bold(0)$
$
mat(
A,bold(0)
)xarrow(#`R2`-> #`R2`+5#`R1`)mat(
1,-3,2,0;
0,-3,9,0
)xarrow(#`R2`/(-3))mat(
1,-3,2,0;
0,1,-3,0
)xarrow(#`R1`-> #`R1`+3#`R2`)mat(
1,0,-7,0;
0,1,-3,0
)
$
Hence the solution set is $ cases(
x_1=7x_3,
x_2=3x_3,
x_3" is free",
) $, in parametric form, $mat(
x_1;x_2;x_3
)=x_3mat(
7;3;1
)$, which describes a line in $RR^3$ of the direction $mat(
7;3;1
)$ that passes through the origin, and this line is the intersection of planes $x_1-3x_2+2x_3=0$ and $-5x_1+12x_2-x_3=0$
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
]

#remark[
As discussed in Example @ex:hyperplane-not-subsp, in general, the solution set of $A bold(x)=bold(b)$ is not a subspace of $RR^n$ unless $bold(b)=bold(0)$. And in fact, any subspace of $RR^n$ is the null space for some $m times  n$ matrix $A$, i.e. the intersection of hyperplanes passing through the origin
]

#definition[
Suppose $A=mat(
bold(a)_1,bold(a)_2,dots.h.c,bold(a)_n
)$ is an $m times  n$ matrix, then the #text(fill:blue)[column space]#index[column space] (denote as $"Col"A$) is the subspace $"Span"{bold(a)_1,bold(a)_2,dots.h.c,bold(a)_n}$ in $RR^m$. Suppose $A=mat(
#`R1`;#`R2`;dots.v;#`Rm`
)$, then the #text(fill:blue)[row space]#index[row space] (denote as $"Row"A$) is the subspace spaned by row vectors $"Span"{#`R1`,#`R2`,dots.h.c, #`Rm`}$ in $RR^n$ written horizontally.
]

#theorem[
Row reductions preserve $"Nul"A, "Row"A$, but not $"Col"A$. However, row reductions preserve linear dependences of the column vectors.
]

#remark[
Suppose $A bold(x)=bold(0)$ is some linear dependence of the column vectors of $A$, after elementary row reduction $A tilde E A$, $(E A)bold(x)=E(A bold(x))=E bold(0)=bold(0)$ is again the same linear dependence of columns of $E A$. In other words, the linear dependence of columns of a matrix is preserved by row equivalence.
]

#theorem[
Suppose $A$ is a $m times  n$ matrix, $A tilde  U$ is of RREF form

- The vectors in the parametric vector form of the solution set of $A bold(x)=bold(0)$ gives a basis for $"Nul"A$. Note that $"dim""Nul"A=$ the number of free variables.
- A basis for $"Col"A$ could be the set of pivot columns in $A$. Note that $"dim" "Col"A=$ the number of pivots.
- A basis for $"Row"A$ could be the set of non-zero row vectors in $U$ (Or any REF of $A$). Note that $"dim" "Row"A=$ the number of pivots.

]

== Rank and Nullity

#definition[
$"dim""Nul"A$ is also name the #text(fill:blue)[nullity]#index[nullity] of $A$. The number of pivots of $A$ (which is equal to both $"dim" "Col"A$ and $"dim" "Row"A$) is called the #text(fill:blue)[rank]#index[rank] of $A$
]

#theorem[[Rank-Nullity theorem]
Notice that the number of columns in $A$ (say a $m times  n$ matrix) is equal to the number of free variables and the number of pivot columns, thus we have
$
n= "nullity + rank"
$
]<thm:rank-nul>

#example[
$A=mat(
1,-1,1;
2,0,-1;
1,1,-2
)tilde mat(
1,-1,1;
0,2,-3;
0,0,0
)tilde mat(
1,0,- 1 / 2 ;
0,1,- 3 / 2 ;
0,0,0
)$, which is an REF and an RREF respectively. There is only one free variable $x_3$, so the nullity is 1, and the 1st, 2nd columns are pivot columns, so the rank is 2. We see that Theorem @thm:rank-nul holds as $3=1+2$, and
 $
"Nul"A="Span"{mat(
 1 / 2 ; 3 / 2 ;1
)}
 $
 $
"Col"A="Span"{mat(
1;2;1
),mat(
-1;0;1
)}
 $
 $
"Row"A="Span"{mat(
1,0,- 1 / 2
),mat(
0,1,- 3 / 2
)}" or ""Span"{mat(
1,-1,1
),mat(
1,2,-3
)}
 $
]

#exercise[
$A=mat(
1,2,0,4,5;
0,0,5,-7,8;
0,0,0,0,-9;
0,0,0,0,0
)tilde mat(
1,2,0,4,0;
0,0,1,- 7 / 5 ,0;
0,0,0,0,1;
0,0,0,0,0
)$
Note that here we have 2 free variables $x_2,x_4$, so the nullity is 2, and the 1st, 3rd, 5th columns are pivot columns, so the rank is 3. We see that Theorem @thm:rank-nul holds as $5=2+3$, and
 $
"Nul"A="Span"{mat(
-2;1;0;0;0
),mat(
-4;0; 7 / 5 ;1;
)}
 $
 $
"Col"A="Span"{mat(
1;0;0;0
),mat(
0;5;0;0
),mat(
5;8;-9;0
)}
 $
 $
"Row"A="Span"{mat(
1,2,0,4,5
),mat(
0,0,5,-7,8
),mat(
0,0,0,0,-9
)}
 $
]

#question[
If you have a set $cal(S)$ of vectors in $RR^m$, how do you find a subset of $cal(S)$ that is a basis for $"Span"{cal(S)}$ (i.e. remove linear dependences)?
]

#answer[
Collect these vectors as the column vectors of a matrix, and then find its columns space.
]

#exercise[
Suppose $bold(v)_1=mat(
1;2;1
)$, $bold(v)_2=mat(
-1;0;1
)$, $bold(v)_3=mat(
1;-1;-2
)$. Find a basis for $"Span"{bold(v)_1, bold(v)_2, bold(v)_3}$.
]

#exercise[
Suppose $A=mat(
1,-7,0,6,5;
0,0,1,-2,-3;
-1,7,-4,2,7
)$. Find $"Nul"A,"Row"A,"Col"A$, and the nullity, rank of $A$.
]

= Lecture 11 - Linear transformations in general

== Linear transformation

#definition[
Suppose $V,W$ are vector spaces, a _linear transformation_ is a mapping $T:V-> W$ such that

- $T(\bm u"fatplus"\bm v)=T(\bm u)"fatplus" T(\bm v)$
- $T(c"fatdot" u)=c"fatdot" T(\bm u)$

Just as before, we call $V$ the _domain_ of $T$, $W$ the _codomain_ of $T$, the _image_ of $\bm x$ under $T$ is $T(\bm x)$, the set of images $\{T(\bm x)|\bm x in  V\}$ the _range_ (denoted as $"Range "T$), and the set $\{\bm x|T(\bm x)=\bm b\}$ the preimage of $\bm b$ under $T$. We still say that $T$ is _one-to-one_ if any $\bm b in  W$, there is at most one $\bm x in  V$ such that $T(\bm x)=\bm b$. $T$ is _onto_ the range is the codomain. $T$ is said to be _invertible_ if $T$ has a inverse (this happens if and only if $T$ is both one-to-one and onto, and we can easily check that $T^(-1)$ is also an linear transformation), in this case we also call $T$ an #text(fill:blue)[isomorphism]#index[isomorphism].
]

#definition[
We call $\{\bm x|T(\bm x)=bb(0)\}$ the #text(fill:blue)[kernel]#index[kernel] (or #text(fill:blue)[null space]) of $T$, and denote it as $"ker" T$.
]

#remark[\label{14:24/06/30/2022}
Suppose $T:RR^n->RR^m$, $T(bold(x))=A bold(x)$ is a matrix transformation, then $"ker" T="Nul"A$, $"Range "T="Col"A$
]

#example[
The identification
 $
T:PP_2->RR^3,quad T(a_0+a_1t+a_2t^2)=mat(
a_0;a_1;a_2
)
 $
in Eaxmple @ex:P_n is an invertible linear transformation with inverse linear transformation
 $
T^(-1):RR^3->PP_2,quad T^(-1)(mat(
a_0;a_1;a_2
))=a_0+a_1t+a_2t^2
 $
]

#example[
The identification
 $
T:M_{2 times 2}(RR)->RR^4,quad
T(mat(
a,b;c,d
))=mat(
a;b;c;d
)
 $
in Eaxmple @ex:Mmn-as-vectsp is an invertible linear transformation with inverse linear transformation
 $
T^(-1):RR^4-> M_{2 times 2}(RR),quad
T^(-1)(mat(
a;b;c;d
))=mat(
a,b;c,d
)
 $
]

#theorem[
Suppose $T:V-> W$ is a linear transformation between vector spaces, then

- $"ker" T$ is a subspace of $V$.
- $"Range "T$ is a subspace of $W$.

]<thm:ker-range-are-subsp>

#proof[


- Suppose $\bm u,\bm v in "ker" T$, then by definition $T(\bm u)=bb(0)$, $T(\bm v)=bb(0)$, so $T(\bm u"fatplus"\bm v)=T(\bm u)"fatplus" T(\bm v)=bb(0)$. And for any $c in RR$, $T(c"fatdot"\bm u)=c"fatdot" T(\bm u)=bb(0)$. In other words, we have shown that $\bm u"fatplus"\bm v, c"fatdot"\bm u in  "ker" T$, so $"ker" T$ is a subspace.
- For any $T(\bm u),T(\bm v) in "Range "T$, $T(\bm u)"fatplus" T(\bm v)=T(\bm u"fatplus"\bm v) in "Range "T$, and for any $c in RR$, $c"fatdot" T(\bm u)=T(c"fatdot"\bm u) in "Range "T$, so $"Range "T$ is a subspace

]

#exercise[
Suppose $T:PP_2->RR$ takes the sum of coefficients, i.e. $T(a_0+a_1t+a_2t^2)=a_0+a_1+a_2$. Show that $T$ is a linear transformation, and $H$ in Exercise @kerT-sum-coef-of-poly is a vector space.
]<exer:2degpoly-lintrans>

#solution[
since for any $p(t)=a_0+a_1+a_2,q(t)=b_0+b_1t+b_2t^2 in PP_2$, $c in RR$, we have
$
T(p+q),=T((a_0+b_0)+(a_1+b_1)t+(a_2+b_2)t^2)=(a_0+b_0)+(a_1+b_1)+(a_2+b_2);
,=(a_0+a_1+a_2)+(b_0+b_1+b_2)=T(p)+T(q)
$
 $
T(c p)=T((c a_0)+(c a_1)t+(c a_2)t^2)=(c a_0)+(c a_1)+(c a_2)=c(a_0+a_1+a_2)=c T(p)
 $
// So $V="ker" T$ is a subspace of $V$ by Theorem @(18:15-06/27/2022)
]

// #exercise[
// Suppose $T:M_{2 times 2}(RR)->RR$ takes the sum of diagonal, i.e. $T(mat(
// a,b;c,d
// ))=a+d$. Show that $T$ is a linear transformation, and the set $H={mat(
// a,b;c,d
// ) mid(|)a+d=0}$ of $2 times 2$ matrix with #text(fill:blue)[trace]#index[trace](sum of diagonal element) 0 is a vector space.
// ]

== Matrices of linear transformations

#question[
Can we realize a general linear transformation $T$ as a matrix transformation?
]

#answer[
Just need to know its effect on any basis! Suppose $bold(v)_1,bold(v)_2,dots.h.c,bold(v)_n$ is a basis of $RR^n$, then any vector $bold(v)$ can be written as $c_1bold(v)_1+c_2bold(v)_2+dots.h.c+c_n bold(v)_n$, and by linearality, we have
// $ \label{19:13-06/07/2022}
// T(bold(v))=T(c_1bold(v)_1+c_2bold(v)_2+dots.h.c+c_n bold(v)_n)=c_1T(bold(v)_1)+c_2T(bold(v)_2)+dots.h.c+c_nT(bold(v)_n)
// $
]

#theorem[[Unique representation theorem]\label{12:53-06/28/2022}
Suppose $cal(B)=\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis of a vector sapce $V$, then any vector $\bm v in  V$ can be uniquely represented as a linear combination $x_1"fatdot"\bm b_1"fatplus"dots.h.c"fatplus" x_n"fatdot"\bm b_n$
]

// #remark[
// Here $[\bm v]_{cal(B)}=mat(
// x_1;dots.v;x_n
// )$ is called the #text(fill:blue)[$cal(B)$-coordinate vector]#index[coordinat vector] (or #text(fill:blue)[coordinate vector relative to the basis $cal(B)$]) of $\bm v$
// ]

// #proof[
// Suppose $\bm v=c_1"fatdot"\bm b_1"fatplus"dots.h.c"fatplus" c_n"fatdot"\bm b_n=d_1"fatdot"\bm b_1"fatplus"dots.h.c"fatplus" d_n"fatdot"\bm b_n$ are two linear combinations that express $\bm v$, then we have $(c_1-d_1)"fatdot"\bm b_1"fatplus"dots.h.c"fatplus"(c_n-d_n)"fatdot"\bm b_n=bb(0)$, since $\{\bm b_1,dots.h.c,\bm b_n\}$ is linearly independent, we have $c_1=d_1,dots.h.c,c_n=d_n$. Therefore the expression is unique.
// ]

// #definition[
// We call $[\quad]_{cal(B)}:V->RR^n$ the #text(fill:blue)[coordinate mapping]#index[coordinate mapping]
// ]

// #theorem[
// The coordinate mapping $[\quad]_{cal(B)}:V->RR^n$ is an isomorphism
// ]

// #example[
// The identifications in Example @ex:P_n and Example @(ex:Mmn-as-vectsp) are coordinate mappings $[\quad]_{cal(E)}:PP_2->RR^3$ with standard basis $cal(E)=\{1,t,t^2\}$ and $[\quad]_{cal(E)}:M_{2 times 2}(RR)->RR^4$ with standard basis $cal(E)={mat(
// 1,0;0,0
// ),mat(
// 0,1;0,0
// ),mat(
// 0,0;1,0
// ),mat(
// 0,0;0,1
// )}$, respectively
// )

// #example[
// $cal(B)={bold(b)_1=mat(
// 1;0
// ), bold(b)_2=mat(
// 1;2
// )}$ is a basis for $RR^2$, $bold(v)=mat(
// 1;6
// )$. Solve linear system $bold(v)=x_1bold(b)_1+x_2bold(b)_2=mat(
// bold(b)_1,bold(b)_2
// )mat(
// x_1;x_2
// )$ we get $[bold(v)]_{cal(B)}=mat(
// -2;3
// )$
// )

// #remark[
// $bold(x)=[bold(x)]_{cal(E)}$ as $bold(x)=x_1bold(e)_1+dots.h.c+x_n bold(e)_n$.
// ]

// % #exercise[

// % ]

// #question[
// How should we study linear transformations via matrices in general?
// ]

// Assume $T:V-> W$ is a linear transformation between vector spaces, $\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis for $V$ and $\{\bm c_1,dots.h.c,\bm c_m\}$ is a basis for $W$, then for any
// $
// \bm v=x_1"fatdot"\bm b_1"fatplus"dots.h.c"fatplus" x_n"fatdot"\bm b_n=mat(
// \bm b_1,dots.h.c,\bm b_n
// )mat(
// x_1;dots.v;x_n
// )=mat(
// \bm b_1,dots.h.c,\bm b_n
// )[\bm v]_{cal(B)}
// $
// We have
// $
// T(\bm v),=T(x_1"fatdot"\bm b_1"fatplus"dots.h.c"fatplus" x_n"fatdot"\bm b_n)=x_1"fatdot" T(\bm b_1)"fatplus"dots.h.c"fatplus" x_n"fatdot" T(\bm b_n)=x_1"fatdot" T(\bm b_1)"fatplus"dots.h.c"fatplus" x_n"fatdot" T(\bm b_n);
// ,=mat(
// T(\bm b_1),dots.h.c,T(\bm b_n)
// )mat(
// x_1;dots.v;x_n
// )=mat(
// T(\bm b_1),dots.h.c,T(\bm b_n)
// )[\bm v]_{cal(B)}
// $
// By Theorem @(12:53-06/28/2022), we can write
// $
// T(\bm b_1),=a_(11)"fatdot"\bm c_1+a_(21)"fatdot"\bm c_2+dots.h.c+a_(m 1)"fatdot"\bm c_m;
// T(\bm b_2),=a_(12)"fatdot"\bm c_1+a_(22)"fatdot"\bm c_2+dots.h.c+a_(m 2)"fatdot"\bm c_m;
// ,dots.v;
// T(\bm b_n),=a_(1 n)"fatdot"\bm c_1+a_(2 n)"fatdot"\bm c_2+dots.h.c+a_(m n)"fatdot"\bm c_m
// $
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
// [T(\bm b_1))_{cal(C)},dots.h.c,[T(\bm b_n)]_{cal(C)}
// ]
// $
// is called the #text(fill:blue)[matrix of $T$ relative to bases $cal(B)$ and $cal(C)$], thus
//  $
// T(\bm v)=mat(
// \bm c_1,dots.h.c,\bm c_m
// )A[\bm v]_{cal(B)}
//  $
// On the other hand, we should have
//  $ T(\bm v)=mat(
// \bm c_1,dots.h.c,\bm c_m
// )[T(\bm v)]_{cal(C)} $
// So we may also conclude that
// $ \label{14:19-06/29/2022}
// [T(\bm v)]_{cal(C)}=A[\bm v]_{cal(B)}
// $
// The above discussion can be summerized by the following commutative diagram
// $ \label{16:03-06/29/2022}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{cal(B)}}"'] , W \arrow[d, "{[\quad]_{cal(C)}}"] ;
// RR^n \arrow[r, "A"]                            , RR^m
// \end{tikzcd}
// \quad
// \begin{tikzcd}
// \bm v \arrow[r, maps to] \arrow[d, maps to] , T(\bm v) \arrow[d, maps to]                     ;
// {[\bm v]_{cal(B)}} \arrow[r, maps to]   , {A[\bm v]_{cal(B)}=[T(\bm v)]_{cal(C)}}
// \end{tikzcd}
// $

// #remark[
// The philosophy here is that any statement about a general linear transformation can be converted to a corresponding statement about matrix transformation.
// ]

// #example[
// Suppose $V=RR^n$, $W=RR^m$ with bases $\{bold(e)_1,dots.h.c,bold(e)_n\}$, $\{bold(e)_1,dots.h.c,bold(e)_m\}$, then \eqref{13:44-06/28/2022} reads $A=mat(
// T(bold(e)_1),dots.h.c,T(bold(e)_n)
// )$ is the standard matrix
// )

#example[
Consider linear transformation
 $
T:PP_2->RR^3,quad T(a_0+a_1t+a_2t^2)=mat(
a_0;a_1;a_2
)
 $
and $cal(B)=\{1+t,t+t^2,1+t^2\}$ is a basis for $PP_2$, $cal(E)$ is the standard basis for $RR^3$, then matrix of $T$ relative to bases $cal(B)$ and $cal(E)$ can be read from \eqref{12:55-06/29/2022} as
 $
A=mat(
T(1+t),T(t+t^2),T(1+t^2)
)=mat(
1,0,1;
1,1,0;
0,1,1
)
 $
]

// #example[
// Consider linear transformation $T:RR^2->RR^2$ is defined by $T(mat(
// x_1;x_2
// ))=mat(
// x_1+2x_2;x_2
// )$, $cal(B)={mat(
// 1;1
// ), mat(
// 1;-1
// )}$, $cal(C)={mat(
// -1;1
// ), mat(
// -1;-1
// )}$ are bases for $RR^2$. Then the matrix of $T$ relative to bases $cal(B)$ and $cal(C)$ can be read from~\eqref{13:44-06/28/2022}
// $
// mat(
// -1,-1;1,-1
// )A=mat(
// 3,-1;1,-1
// ), =>  A=mat(
// -1,-1;1,-1
// )^(-1)mat(
// 3,-1;1,-1
// )=mat(
// -1,0;-2,1
// )
// $
// )

// #exercise[

// ]

// #remark[\label{17:02-06/29/2022}
// Suppose $T:V-> W$ and $S:W-> U$ are linear transformations between vector spaces, $cal(B)=\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis for $V$, $cal(C)=\{\bm c_1,dots.h.c,\bm c_n\}$ is a basis for $W$ and $cal(D)=\{\bm d_1,dots.h.c,\bm d_n\}$ is a basis for $U$, then the matrix of $Scircle.small T$ relative to bases $cal(B)$, $cal(D)$ is $BA$.
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{cal(B)}}"'] \arrow[rr, "Scircle.small T", bend left, shift left=2] , W \arrow[d, "{[\quad]_{cal(C)}}"] \arrow[r, "S"] , U \arrow[d, "{[\quad]_{cal(D)}}"] ;
// RR^n \arrow[r, "A"] \arrow[rr, "BA", bend right, shift right=2]                                , RR^m \arrow[r, "B"]                           , RR^p
// \end{tikzcd}
// \quad
// \begin{tikzcd}
// \bm v \arrow[r, maps to] \arrow[d, maps to] , T(\bm v) \arrow[d, maps to] \arrow[r]                              , S(T(\bm v))=(Scircle.small T)(\bm v) \arrow[d, maps to]    ;
// {[\bm v]_{cal(B)}} \arrow[r, maps to]   , {A[\bm v]_{cal(B)}=[T(\bm v)]_{cal(C)}} \arrow[r, maps to] , {BA[\bm v]_{cal(B)}=[S(T(\bm v))]_{cal(D)}}
// \end{tikzcd}
// \end{center}
// If $T$  is invertible, then the matrix of $T^(-1)$ relative to bases $cal(C)$, $cal(B)$ is $A^(-1)$
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{cal(B)}}"'] , W \arrow[d, "{[\quad]_{cal(C)}}"] \arrow[l, "T_{-1}", bend left] ;
// RR^n \arrow[r, "A"]                            , RR^m \arrow[l, "A^(-1)", bend left]
// \end{tikzcd}
// \end{center}
// ]

#exercise[
Suppose $T:PP_2->RR_3$ is evaluation at $2$, i.e. $T(p(t))=p(2)$ for $p(t) in PP_2$. Show that $T$ is a linear transformation. Is $T$ onto? Is $T$ one-to-one? Is $T$ invertible? Find a basis for $"ker" T$. Find a basis for $"Range "T$.
]

#exercise[
Suppose $H$ is the set of 2 by 2 matrices that are symmetric with the sum of diagonal being zero. Show $H$ is a vector space. Find a basis of $H$.
]

== Change of basis

// Now let's talk about change of basis. Suppose $V$ is a vector space with two basis $cal(B)=\{\bm b_1,dots.h.c,\bm b_n\}$ and $cal(C)=\{\bm c_1,dots.h.c,\bm c_n\}$, and $\id_V:V-> V$, $\id_V(\bm v)=\bm v$ is the #text(fill:blue)[identity mapping]#index[identity mapping]. Diagram~\eqref{16:03-06/29/2022} becomes
// $ \label{19:43-06/29/2022}
// \begin{tikzcd}
// V \arrow[r, "\id_V", equal] \arrow[d, "{[\quad]_{cal(B)}}"']             , V \arrow[d, "{[\quad]_{cal(C)}}"] ;
// RR^n \arrow[r, "\underset{cal(C)\leftarrowcal(B)}{P}"] , RR^n
// \end{tikzcd}
// $
// Where equation~\eqref{12:55-06/29/2022} and equation~\eqref{14:19-06/29/2022} become
//  $
// \underset{cal(C)\leftarrowcal(B)}{P}=mat(
// [\bm b_1)_{cal(C)},dots.h.c,[\bm b_n]_{cal(C)}
// ]
//  $
//  $
// [\bm v]_{cal(C)}=\underset{cal(C)\leftarrowcal(B)}{P}[\bm v]_{cal(B)}
//  $
// which is the matrix of $\id_V$ relative to basis $cal(B)$ and $cal(C)$, and we call this the #text(fill:blue)[change of coordinates matrix from $cal(B)$ to $cal(C)$]. Also remark @(17:02-06/29/2022) gives us
//  $
// \underset{cal(D)\leftarrowcal(B)}{P}=(\underset{cal(D)\leftarrowcal(C)}{P})(\underset{cal(C)\leftarrowcal(B)}{P}),\quad (\underset{cal(C)\leftarrowcal(B)}{P})^(-1)=\underset{cal(B)\leftarrowcal(C)}{P}
//  $

// #example[
// Continue Example @(exer:2by2sym-as-vectsp), we have shown that $cal(B)={mat(
// 1,0;0,0
// ),mat(
// 0,1;1,0
// ),mat(
// 0,0;0,1
// )}= B_1,B_2,B_3$ is a basis for $V$. Let's show that $cal(C)={mat(
// 1,1;1,0
// ),mat(
// 1,0;0,1
// ),mat(
// 0,1;1,1
// )}= C_1,C_2,C_3$ is another basis for $V$. First note that
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
// So $\{[C_1]_{cal(B)},[C_2]_{cal(B)},[C_3]_{cal(B)}\}={mat(
// 1;1;0
// ),mat(
// 1;0;1
// ),mat(
// 0;1;1
// )}$, and it is easy to show that this is a basis for $RR^3$, hence $cal(C)$ is a basis for $V$. Also we know that
//  $
// \underset{cal(B)\leftarrowcal(C)}{P}=mat(
// [C_1)_{cal(B)},[C_2]_{cal(B)},[C_3]_{cal(B)}
// ]=mat(
// 1,1,0;
// 1,0,1;
// 0,1,1
// )
//  $
// And
//  $
// \underset{cal(C)\leftarrowcal(B)}{P}=(\underset{cal(B)\leftarrowcal(C)}{P})^(-1)=mat(
//  1 / 2 , 1 / 2 ,- 1 / 2 ;
//  1 / 2 ,- 1 / 2 , 1 / 2 ;
// - 1 / 2 , 1 / 2 , 1 / 2
// )
//  $
// Note that here the diagram~\eqref{19:43-06/29/2022} becomes
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "\id_V", equal] \arrow[d, "{[\quad]_{cal(B)}}"']             , V \arrow[d, "{[\quad]_{cal(C)}}"] ;
// RR^3 \arrow[r, "\underset{cal(C)\leftarrowcal(B)}{P}"] , RR^3
// \end{tikzcd}
// \end{center}
// )

// #example[\label{10:24-07/01/2022}
// Continue Example @(exer:2degpoly-lintrans), let's find a basis for $V="ker" T$ which is supposed to correspond to $"Nul"A$, where $A$ is the matrix relative to both standard bases $cal(E)=\{1,t,t^2\}$ for $PP_2$ and $cal(E)={bold(e)_1=mat(
// 1;0;0
// ),bold(e)_2=mat(
// 0;1;0
// ),bold(e)_3=mat(
// 0;0;1
// )}$ which can be read from~\eqref{14:19-06/29/2022}
//  $
// A=mat(
// [T(1))_{cal(E)},[T(t)]_{cal(E)},[T(t^2)]_{cal(E)}
// ]=mat(
// 1,1,1
// )
//  $
// So we get
//  $
// "Nul"A="Span"{mat(
// -1;1;0
// ),mat(
// -1;0;1
// )}
//  $
// Which gives a basis $\{-1+t,-1+t^2\}$ for $V$. Note that here the diagram~\eqref{16:03-06/29/2022} becomes
// \begin{center}
// \begin{tikzcd}
// PP_2 \arrow[r, "T"] \arrow[d, "{[\quad]_{cal(E)}}"'] , RR \arrow[d, equal, "{[\quad]_{cal(E)}}"] ;
// RR^3 \arrow[r, "A"]                            , RR
// \end{tikzcd}
// \end{center}
// )

// An algorithm for computing $A^(-1)B$
//  $
// mat(
// A,B
// ; augment:#(-1))tilde mat(
// I,A^(-1)B
// ; augment:#(-1))
//  $

// #exercise[
// Suppose $cal(B)=\{2t^2-1,3t+1-t^2,3-t\}$ and $cal(C)=\{1+t,t^2,-t\}$ are both bases for $PP_2$. Please find the change of basis matrix form $cal(B)$ to $cal(C)$
// ]

// #solution[
// First let's find the change of basis matrices from $cal(B)$ and $cal(C)$ to the standard basis $cal(E)=\{1,t,t^2\}$. We have
//  $
// \underset{cal(E)\leftarrowcal(B)}{P}=mat(
// [-1+2t^2)_{cal(E)},[1+3t-t^2]_{cal(E)},[3-t]_{cal(E)}
// ]=mat(
// -1,1,3;
// 0,3,-1;
// 2,-1,0
// )
//  $
// And
//  $
// \underset{cal(E)\leftarrowcal(C)}{P}=mat(
// [1-t)_{cal(E)},[t]_{cal(E)},[t^2]_{cal(E)}
// ]=mat(
// 1,0,0;
// 1,0,-1;
// 0,1,0
// )
//  $
// Hence we have
// $
// \underset{cal(C)\leftarrowcal(B)}{P}=(\underset{cal(C)\leftarrowcal(E)}{P})(\underset{cal(E)\leftarrowcal(B)}{P})=(\underset{cal(E)\leftarrowcal(C)}{P})^(-1)(\underset{cal(E)\leftarrowcal(B)}{P})
// $
// Which can computed via the above algorithm
// $
// mat(
// 1,0,0,-1,1,3;
// 1,0,-1,0,3,-1;
// 0,1,0,2,-1,0
// ; augment:#(-1))tilde mat(
// 1,0,0,-1,1,3;
// 0,1,0,2,-1,0;
// 0,0,1,-1,-2,4
// ; augment:#(-1))
// $
// \begin{center}
// \begin{tikzcd}
// PP_2 \arrow[r,equal, "\id_V"] \arrow[d, "{[\quad]_{cal(B)}}"']                                                                                             , PP_2 \arrow[d, "{[\quad]_{cal(E)}}"'] \arrow[r,equal, "\id_V"]               , PP_2 \arrow[d, "{[\quad]_{cal(C)}}"]                       ;
// RR^3 \arrow[r, "\underset{cal(E)\leftarrowcal(B)}{P}"'] \arrow[rr, "\underset{cal(C)\leftarrowcal(B)}{P}", bend right=49, shift right=1] , RR^3 \arrow[r, "\underset{cal(C)\leftarrowcal(E)}{P}", bend left] , RR^3 \arrow[l, "\underset{cal(E)\leftarrowcal(C)}{P}"]
// \end{tikzcd}
// \end{center}
// ]

// #example[
// Suppose $RR^2$ has bases $cal(B)={bold(b)_1=mat(
// 7;5
// ),bold(b)_2=mat(
// -3;-1
// )}$, $cal(C)={bold(c)_1=mat(
// 1;-5
// ),bold(c)_2=mat(
// -2;2
// )}$. $\underset{cal(C)\leftarrowcal(B)}{P}=(\underset{cal(E)\leftarrowcal(C)}{P})^(-1)(\underset{cal(E)\leftarrowcal(B)}{P})$, which can be computed via
//  $
// mat(
// 1,-2,7,-3;
// -5,2,5,-1
// ; augment:#(-1))tilde mat(
// 1,0,-3,1;
// 0,1,-5,2
// ; augment:#(-1))
//  $
// So $\underset{cal(C)\leftarrowcal(B)}{P}=mat(
// -3,1;
// -5,2
// )$
// \begin{center}
// \begin{tikzcd}
// RR^2 \arrow[r,equal] \arrow[d, "{[\quad]_{cal(B)}}"']                                                                                           , RR^2 \arrow[d, "{[\quad]_{cal(E)}}"'] \arrow[r,equal]               , RR^2 \arrow[d, "{[\quad]_{cal(C)}}"]                       ;
// RR^2 \arrow[r,"\underset{cal(E)\leftarrowcal(B)}{P}"'] \arrow[rr, "\underset{cal(C)\leftarrowcal(B)}{P}", bend right=49, shift right] , RR^2 \arrow[r, "\underset{cal(C)\leftarrowcal(E)}{P}", bend left] , RR^2 \arrow[l, "\underset{cal(E)\leftarrowcal(C)}{P}"]
// \end{tikzcd}
// \end{center}
// )

// #theorem[
// Let's generalize the rank-nullity theorem @thm:rank-nul, with the remark @(14:24/06/30/2022), we have
//  $
// "dim" V="dim""Range "T+"dim""ker" T
//  $
// ]

// #definition[
// Suppose $T:V-> V$ is a linear transformation, and $cal(B)=\{\bm b_1,dots.h.c,\bm b_n\}$ is a basis for $V$, we can the matrix relative to $cal(B)$ and $cal(B)$ the #text(fill:blue)[$cal(B)$-matrix of $T$]#index[$cal(B)$-matrix] (denoted $[T]_{cal(B)}$), i.e. \eqref{16:03-06/29/2022} becomes
// \begin{center}
// \begin{tikzcd}
// V \arrow[r, "T"] \arrow[d, "{[\quad]_{cal(B)}}"'] , V \arrow[d, "{[\quad]_{cal(B)}}"] ;
// RR^n \arrow[r, "{[T]_{cal(B)}}"]           , RR^n
// \end{tikzcd}
// \quad
// \begin{tikzcd}
// \bm v \arrow[r, maps to] \arrow[d, maps to] , T(\bm v) \arrow[d, maps to]                     ;
// {[\bm v]_{cal(B)}} \arrow[r, maps to]   , {[T]_{cal(B)}[\bm v]_{cal(B)}=[T(\bm v)]_{cal(B)}}
// \end{tikzcd}
// \end{center}
// And \eqref{12:55-06/29/2022} gives $[T]_{cal(B)}=mat(
// [T(\bm b_1))_{cal(B)},dots.h.c,[T(\bm b_n)]_{cal(B)}
// ]$
// Suppose both $cal(B)=\{\bm b_1,dots.h.c,\bm b_n\}$ and $cal(C)=\{\bm c_1,dots.h.c,\bm c_n\}$ form bases for $V$, then
//  $
// [T]_{cal(B)}=\underset{cal(B)\leftarrowcal(C)}{P}[T]_{cal(C)}\underset{cal(C)\leftarrowcal(B)}{P}=\underset{cal(B)\leftarrowcal(C)}{P}[T]_{cal(C)}(\underset{cal(B)\leftarrowcal(C)}{P})^(-1)
//  $
// is similar via
// \begin{center}
// \begin{tikzcd}
// V \arrow[rrr, "T"] \arrow[rd, "{[\quad]_{cal(B)}}"] \arrow[ddd, "\id"'] , , , V \arrow[ld, "{[\quad]_{cal(B)}}"'] \arrow[ddd, "\id"] ;
// , RR^n \arrow[r, "{[T]_{cal(B)}}"] , RR^n \arrow[d, "\underset{cal(C)\leftarrowcal(B)}{P}"'] , ;
// , RR^n \arrow[r, "{[T]_{cal(C)}}"] \arrow[u, "\underset{cal(B)\leftarrowcal(C)}{P}"'] , RR^n , ;
// V \arrow[ru, "{[\quad]_{cal(C)}}"'] \arrow[rrr, "T"'] , , , V \arrow[lu, "{[\quad]_{cal(C)}}"]
// \end{tikzcd}
// \end{center}
// If $T:RR^n->RR^n$, $T(bold(x))=A bold(x)$ is a matrix transformation, $cal(E)$ is the standard basis, and $cal(C)=\{bold(v)_1,dots.h.c,bold(v)_n\}$ is basis consists of eigenvectors, then $[T]_{cal(C)}=D$ is diagonal with eigenvalues, as shown in Theorem @(09:52-07/07/2022).
// ]

// #remark[
// In fact, any two similar matrix can be realized as matrices of the same linear transformation in different basis.
// ]

= Lecture 12 - Eigendecomposition

== Eigenvalues, eigenvectors and eigenspaces

// #definition[
// Suppose $A$ is a square $n times  n$ matrix. A #text(fill:blue)[$ lambda $-eigenvector]#index[eigenvector] of an $n times  n$ matrix $A$ is a nonzero vector $bold(x)$ such that $A bold(x) =  lambda bold(x)$ for some scalar $ lambda $. A scalar $ lambda $ is called an #text(fill:blue)[eigenvalue]#index[eigenvalue] of $A$ has $ lambda $-eigenvectors.
// ]

// #definition[
// We say that a vector space $V$ is #text(fill:blue)[trivial]#index[trivial vector space] if $V=\{0\}$ is the zero vector space.
// ]

// #question[
// How to decide whether a nonzero vector $bold(x)$ is an eigenvector?
// ]

// #answer[
// We can evaluate $A bold(x)$ and see if it is a multiple of $bold(x)$
// ]

// #example[
// $A=mat(
// 1,6;5,2
// )$, determine whether $bold(u)=mat(
// 6;-5
// )$, $bold(v)=mat(
// 3;-2
// )$ are eigenvectors of $A$.
//  $
// A bold(u)=mat(
// 1,6;5,2
// )mat(
// 6;-5
// )=mat(
// -24;20
// )=(-4)bold(u)
//  $
// Hence $bold(u)$ is a $(-4)$-eigenvector of $A$.
//  $
// A bold(v)=mat(
// 1,6;5,2
// )mat(
// 3;-2
// )=mat(
// -9;11
// )
//  $
// Which is not a multiple of $bold(v)$, so $bold(v)$ is not an eigenvector.
// )

// #question[
// How to decide if $ lambda $ is an eigenvalue of $A$?
// ]

// #answer[
// By definition, we know that $ lambda $ is an eigenvalue of $A<=> A bold(x)= lambda bold(x)$ has a nontrivial solution $<=>  lambda bold(x)-A bold(x)= lambda  Ibold(x)-A bold(x)=( lambda  I-A)bold(x)=bold(0)$ has a nontrivial solution $<=>"Nul "( lambda  I-A)$ is nontrivial $<=>  lambda  I-A$ is invertible $<=>"det"( lambda  I-A)=0$
// ]

// #example[\label{12:54-07/01/2022}
// $A=mat(
// 4,-1,6;
// 2,1,6;
// 2,-1,8
// )$. Determine whether $ lambda =2$ is an eigenvalue of $A$
//  $
// "det"(2I-A)="det"(2mat(
// 1,0,0;
// 0,1,0;
// 0,0,1
// )-mat(
// 4,-1,6;
// 2,1,6;
// 2,-1,8
// ))=| mat(
// 2,-1,-6;
// 2,-1,-6;
// 2,-1,-6
//  ) |=0
//  $
// )

// #definition[
// From above criterion, we see that the set of $ lambda $-vectors is $"Nul "( lambda  I-A)$ which is a subspace of $RR^n$, we call this the #text(fill:blue)[$ lambda $-eigenspace]#index[eigenspace].
// ]

// #example[
// Continue Example @(12:54-07/01/2022). Let's find a basis for the $2$-eigenspace of $A$, which is equivalent of finding a basis for $"Nul "(2I-A)$, since $mat(
// 2I-A,bold(0)
// ; augment:#(-1))tilde mat(
// 1,- 1 / 2 ,3,0;
// 0,0,0,0;
// 0,0,0,0
// ; augment:#(-1))$
// Hence a basis could be ${mat(
//  1 / 2 ;1;0
// ),mat(
// -3;0;1
// )}$
// )

== Characteristic polynomials

// #question[
// How could we find all the eigenvalues of $A$?
// ]

// #definition[
// From above discussion, we see that $ lambda $ is an eigenvalue of $A<=>"det"( lambda  I-A)=0$, this motivates the following definition. We call $"det"(tI-A)$ the #text(fill:blue)[characteristic polynomial]#index[characteristic polynomial] of $A$, and $"det"(tI-A)=0$ the #text(fill:blue)[characteristic equation]#index[characteristic equation]. And the roots of the characteristic polynomial are the eigenvalues of $A$.
// ]

// #definition[
// We call the dimension of the $ lambda $-eigenspace ($"dim""Nul "( lambda  I-A)$) the #text(fill:blue)[geometric multiplicity]#index[geometric multiplicity] of $ lambda $, and the multiplicity of $ lambda $ as a root in the charateristic polynomial $"det"(tI-A)$ the #text(fill:blue)[algebraic multiplicity]#index[algebraic multiplicity] of $ lambda $.
// ]

// #example[
// Suppose $A=mat(
// 1,-4;4,2
// )$, then the characteristic polynomial of $A$ would be
//  $
// "det"(tI-A)="det"(tmat(
// 1,0;0,1
// )-mat(
// 1,-4;4,2
// ))=| mat(
// t-1,4;-4,t-2
//  ) |=(t-1)(t-2)-4 dot.c (-4)=t^2-3t+18
//  $
// And the characteristic equation is $t^2-3t+18=0$. Since $ Delta=(-3)^2-4 dot.c 1 dot.c 18=-63<0$, this equation has no (real) solutions, $A$ doesn't have (real) eigenvalues
// )

// #note[
// Recall that the quadratic equation $ax^2+bx+c=0$ has no (real) solutions $<=>$ the discriminant $ Delta=b^2-4ac<0$.
// ]

// #example[
// Suppose $A=mat(
// 3,-2;2,-1
// )$, then the characteristic polynomial of $A$ would be
//  $
// "det"(tI-A)="det"(tmat(
// 1,0;0,1
// )-mat(
// 3,-2;2,-1
// ))=| mat(
// t-3,2;-2,t+1
//  ) |=(t-3)(t+1)-2 dot.c (-2)=t^2-2t+1
//  $
// And the characteristic equation is $t^2-2t+1=(t-1)^2=0$. Hence the eigenvalues of $A$ is $2$ with algebraic multiplicity 2
// )

// #example[
// Suppose $A=mat(
// 3,-2,3;0,-1,0;6,7,-4
// )$, then the characteristic polynomial of $A$ would be
// $
// "det"(tI-A),=| mat(
// t-3,2,-3;
// 0,t+1,0;
// -6,-7,t+4
//  ) |xequal("cofactor expansion across the 2nd row")(t+1)(-1)^{2+2}| mat(
// t-3,-3;
// -6,t+4
//  ) |;
// ,=(t+1)((t-3)(t+4)-(-3) dot.c (-6))=(t+1)(t^2+t-30)=(t+1)(t+6)(t-5)
// $
// So we see that the eigenvalues of $A$ are $-1, -6, -5$, all with algebraic multiplicities 1,1,1.
// )

// #example[
// Suppose $A=mat(
// 0,1,1;
// 1,0,1;
// 1,1,0
// )$, then characteristic polynomial is
// $
// "det"(tI-A),=| mat(
// t,-1,1;
// -1,t,-1;
// -1,-1,t
//  ) |xequal( #`R2`-> #`R1`+t dot.c  #`R2` \ #`R2`-> #`R2`-#`R3` )| mat(
// 0,-1-t,1+t^2;
// 0,t+1,-1-t;
// -1,-1,t
//  ) |;
// ,xequal("cofactor expansion across the 1st column")(-1)(-1)^{3+1}| mat(
// -1-t,1+t^2;
// t+1,-1-t;
//  ) |;
// ,=(-1)((-1-t)^2-(1+t^2)(t+1))=(-1)(t-t^3)=t(t+1)(t-1)
// $
// Thus the eigenvalues are $0,1,-1$, with algebraic multiplicities $1,1,1$.
// )

// #example[
// Suppose
//  $
// A=mat(
//  lambda _1,*,dots.h.c,*;
// 0, lambda _2,dots.h.c,*;
// dots.v,dots.v,dots.down,dots.v;
// 0,0,dots.h.c, lambda_n
// )
//  $
// is an $n times  n$ triangular matrix, then the characteristic polynomial of $A$ is
//  $
// "det"(tI-A)=| mat(
// t- lambda _1,*,dots.h.c,*;
// 0,t- lambda _2,dots.h.c,*;
// dots.v,dots.v,dots.down,dots.v;
// 0,0,dots.h.c,t- lambda_n
//  ) |=(t- lambda _1)(t- lambda _2)dots.h.c(t- lambda_n)
//  $
// so the eigenvalues are the diagonal elements $ lambda _1, lambda _2,dots.h.c, lambda_n$. Note that $ lambda _i$'s might not be distinct, so there might be some multiplicities.
// )

// #example[
// Suppose $A=mat(
// 1,2,0,-1;
// 0,2,1,3;
// 0,0,3,4;
// 0,0,0,1
// )$, then the characteristic polynomial is
//  $
// "det"(tI-A)=| mat(
// t-1,-2,0,1;
// 0,t-2,-1,-3;
// 0,0,t-3,-4;
// 0,0,0,t-1
//  ) |=(t-1)^2(t-2)(t-3)
//  $
// And the eigenvalues are $1,2,3$, with multiplicities $2,1,1$ respectively.
// )

== Similarity

// #definition[
// $A$ and $B$ are said to be #text(fill:blue)[similar]#index[similar] if there exists an invertible matrix $P$ such that $A=P B P^(-1)$. Note that this definition is _symmetric_ in the sense that we also have $B=P^(-1)A P=(P^(-1))A(P^(-1))^(-1)$. Similarity is _transitive_ in the sense that if $A,B$ are similar, $B,C$ are similar, then so do $A,C$. The reason is that suppose $A=P B P^(-1)$, $B=RCR^(-1)$, we would have $A=P B P^(-1)=PRCR^(-1)P^(-1)=(PR)C(PR)^(-1)$.
// ]

// #definition[
// We can the mapping $A|-> PAP^(-1)$ a #text(fill:blue)[similar transformation]#index[similar transformation]
// ]

// #theorem[\label{10:10-07/07/2022}
// Similar matrices have the same
//
// - determinant
// - characteristic polynomial
//
// ]

// #proof[
// Suppose $A,B$ are similar, $A=P B P^(-1)$, then
//
// - $"det"(A)="det"(P B P^(-1))="det"(P)"det"(B)"det"(P^(-1))="det"(P)"det"(B)"det"(P)^(-1)="det"(B)$
// - Note that $tI-A=tPIP^(-1)-P B P^(-1)=P(tI-A)P^(-1)$, so $tI-A$ and $tI-B$ are similar, so they have the same determinant which is the characteristic polynomial.
//
// ]

== Eigendecomposition and diagonalization

// #theorem[[diagonalization theorem]\label{09:52-07/07/2022}
// Suppose $bold(v)_1,dots.h.c,bold(v)_n$ are eigenvectors of $A$ with eigenvalues $ lambda _1,dots.h.c, lambda_n$, then we have
// $
// Amat(
// bold(v)_1, dots.h.c, bold(v)_n
// ),=mat(
// A bold(v)_1, dots.h.c,A bold(v)_n
// )=mat(
//  lambda _1bold(v)_1, dots.h.c, lambda_n bold(v)_n
// )=mat(
// bold(v)_1, dots.h.c, bold(v)_n
// )mat(
//  lambda _1,dots.h.c,0;
// dots.v,dots.down,dots.v;
// 0,dots.h.c, lambda_n
// )
// $
// Therefore we get a #text(fill:blue)[diagonalization]#index[diagonalization] of $A$, which reads $A=P D P^(-1)$, where $P=mat(
// bold(v)_1, dots.h.c, bold(v)_n
// )$ and $D=mat(
//  lambda _1,dots.h.c,0;
// dots.v,dots.down,dots.v;
// 0,dots.h.c, lambda_n
// )$
// ]

// #theorem[\label{17:43-07/06/2022}
// If $bold(v)_1,dots.h.c,bold(v)_r$ are eigenvectors that correspond to distinct eigenvalues $ lambda _1,dots.h.c, lambda _r$ of an $n times  n$ matrix $A$, then the set $\{bold(v)_1,dots.h.c,bold(v)_r\}$ is linearly independent.
// ]

// #proof[
// Suppose $\{bold(v)_1,dots.h.c,bold(v)_n\}$ is linearly independent, up to reordering the indices, we may assume $bold(v)_r=c_1bold(v)_1+dots.h.c+c_{r-1}bold(v)_{r-1}$
// ]

// #exercise[
// Diagonalize $A = mat(
// 1,3,3;
// -3,-5,-3;
// 3,3,1
// )$
// ]

// #solution[
// First we want to find all eigenvalues of $A$
// $
// "det"(tI-A),=| mat(
// t-1,-3,-3;
// 3,t+5,3;
// -3,-3,t-1
//  ) |xequal(#`R3`-> #`R3`+#`R2`)| mat(
// t-1,-3,-3;
// 3,t+5,3;
// 0,t+2,t+2
//  ) |;
// ,xequal("factor out $(t+2)$ from row 3")(t+2)| mat(
// t-1,-3,-3;
// 3,t+5,3;
// 0,1,1
//  ) |;
// ,xequal( #`R1`-> #`R1`+3#`R3` \ #`R2`-> #`R2`-3#`R3` )(t+2)| mat(
// t-1,0,0;
// 3,t+2,0;
// 0,1,1
//  ) |=(t+2)(t-1)(t+2)(1)=(t+2)^2(t-1)
// $
// So the eigenvalues of $A$ are $ lambda _1=1$ with algebraic multiplicity 1 and $ lambda _2= lambda _3=-2$ which is of algebraic multiplicity 2. For a basis of the 1-eigenspace $"Nul "(I-A)$, consider
// $
// mat(
// I-A,bold(0)
// ; augment:#(-1)),=mat(
// 0,-3,-3,0;
// 3,6,3,0;
// -3,-3,0,0
// ; augment:#(-1))tilde mat(
// 1,0,-1,0;
// 0,1,1,0;
// 0,0,0,0;
// ; augment:#(-1))
// $
// So it could be ${bold(v)_1=mat(
// 1;-1;0
// )}$
// For a basis of the $(-2)$-eigenspace $"Nul "(-2I-A)$, consider
// $
// mat(
// -2I-A,bold(0)
// ; augment:#(-1)),=mat(
// -3,-3,-3,0;
// 3,3,3,0;
// -3,-3,-3,0
// ; augment:#(-1))tilde mat(
// 1,1,1,0;
// 0,0,0,0;
// 0,0,0,0;
// ; augment:#(-1))
// $
// So it could be ${bold(v)_2=mat(
// -1;1;0
// ),bold(v)_3=mat(
// -1;0;1
// )}$. By Theorem @(17:43-07/06/2022), we know that $\{bold(v)_1,bold(v)_2,bold(v)_3\}$ are linearly independent, thus forming a basis for $RR^3$. And we have a diagonalization
//  $
// A=P D P^(-1),\quad P=mat(
// bold(v)_1,bold(v)_2,bold(v)_3
// )=mat(
// 1,-1,-1;
// -1,1,0;
// 0,0,1;
// ),\quad D=mat(
//  lambda _1,0,0;
// 0, lambda _2,0;
// 0,0, lambda _3
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
// $
// "det"(tI-A),=| mat(
// t-2,-4,-3;
// 4,t+6,3;
// -3,-3,t-1
//  ) |xequal(#`R1`-> #`R1`+#`R2`)| mat(
// t+2,t+2,0;
// 4,t+6,3;
// -3,-3,t-1
//  ) |;
// ,xequal("factor $(t+2)$ from row 1")(t+2)| mat(
// 1,1,0;
// 4,t+6,3;
// -3,-3,t-1
//  ) |xequal( #`R2`-> #`R2`-4#`R1` \ #`R3`-> #`R3`+3#`R1` )(t+2)| mat(
// 1,1,0;
// 0,t+2,3;
// 0,0,t-1
//  ) |;
// ,=(t-1)(t+2)^2
// $
// So the eigenvalues of $A$ are $ lambda _1=1$ with algebraic multiplicity 1 and $ lambda _2= lambda _3=-2$ which is of algebraic multiplicity 2. To find a basis for the 1-eigenspace, consider
// $
// mat(
// I-A,bold(0)
// ; augment:#(-1)),=mat(
// -1,-4,-3,0;
// 4,7,3,0;
// -3,-3,0,0
// ; augment:#(-1))tilde mat(
// -1,-4,-3,0;
// 0,-9,-9,0;
// 0,9,9,0
// ; augment:#(-1))tilde mat(
// -1,-4,-3,0;
// 0,1,1,0;
// 0,0,0,0
// ; augment:#(-1));
// ,tilde mat(
// 1,0,-1,0;
// 0,1,1,0;
// 0,0,0,0
// ; augment:#(-1))
// $
// It could be ${bold(v)_1=mat(
// 1;-1;1
// )}$. To find a basis for the $(-2)$-eigenspace, consider
// $
// mat(
// -2I-A,bold(0)
// ; augment:#(-1)),=mat(
// -4,-4,-3,0;
// 4,4,3,0;
// -3,-3,-3,0
// ; augment:#(-1))tilde mat(
// -4,-4,-3,0;
// 0,0,0,0;
// 1,1,1,0
// ; augment:#(-1));
// ,tilde mat(
// 0,0,1,0;
// 0,0,0,0;
// 1,1,1,0
// ; augment:#(-1))tilde mat(
// 1,1,0,0;
// 0,0,1,0;
// 0,0,0,0;
// ; augment:#(-1))
// $
// It could be ${bold(v)_2=mat(
// -1;1;0
// )}$. Note that there is not enough eigenvectors ($2<3$!!!) for a basis for $RR^3$. The real reason that this failed to be a basis was that the geometric multiplicity of $-2$ (which is equal to 1) is less that the algebraic multiplicity of $-2$ (which is equal to 2)
// )

// #theorem[
// Supoose $A$ is an $n times  n$ matrix. Then the geometric multiplicity of an eigenvalue $ lambda $ is less or equal to the algebraic multiplicity of $ lambda $. $A$ is diagonalizable $<=> A$ has $n$ linearly independent eigenvectors $<=>$ geometric multiplicities are always the same as algebraic multiplicities.
// ]

// #theorem[\label{13:41-07/08/2022}
// Combining Theorem @(17:43-07/06/2022), we know that an $n times  n$ matrix with $n$ distinct eigenvalues is diagonalizable.
// ]

// #definition[
// By Theorem @(10:10-07/07/2022) we know that similar matrices have the same characteristic polynomials (hence the same eigenvalues) and determinants. So we may define notions like _eigenvalues_, _eigenvectors_, _characteristic polynomials_ and _determinants_ for a linear transformation $T:V-> V$.
// ]

// #example[
// Suppose $T=\dfrac{d}{dt}:PP_2->PP_2$, $T(a_0+a_1t+a_2t^2)=a_1+2a_2t$ is a linear transformation (verify this!), $cal(E)=\{1,t,t^2\}$ is the standard basis, we have
//  $
// D=[T]_{cal(B)}=mat(
// 0,0,0;
// 0,1,0;
// 0,0,2
// )
//  $
// so the characteristic polynomial of $T$ is $"det"(tI-[T]_{cal(E)})=t(t-1)(t-2)$, so the eigenvalues for $T$ will be $ lambda _1=0, lambda _2=1, lambda _3=2$, and the corresponding eigenvectors for $[T]_{cal(E)}$ could be ${bold(v)_1=mat(
// 1;0;0
// ),bold(v)_1=mat(
// 0;1;0
// ),bold(v)_1=mat(
// 0;0;1
// )}$, which in turn corresponds to eigenvectors $\{1,t,t^2\}$ for $T$. However if we choose basis $cal(C)=\{1+t,t,t^2\}$ is the standard basis, we have
//  $
// P=\underset{cal(E)\leftarrowcal(C)}{P}=mat(
// 1,0,0;
// 1,1,0;
// 0,0,1
// ),\quad P^(-1)=\underset{cal(C)\leftarrowcal(E)}{P}=mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )
//  $
// and thus
// $
// A,=[T]_{cal(C)}=\underset{cal(B)\leftarrowcal(C)}{P}[T]_{cal(C)}(\underset{cal(B)\leftarrowcal(C)}{P})^(-1)=P D P^(-1)=mat(
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
// $
// The determinant of $T$ is equal to either $"det"([T]_{cal(B)})$ or $"det"([T]_{cal(C)})$, which is zero.
// )

// #example[
// $A=mat(
// 2,1;
// 2,3
// )$, let's compute $A^{50}$. First we find the eigenvalues $ lambda _1=1$, $ lambda _2=4$. and we get corresponding eigenvectors $bold(v)_1=mat(
// -1;1
// ),bold(v)_2=mat(
// 1;2
// )$, so we have $D=mat(
// 1,0;0,4
// )$ and $P=mat(
// -1,1;1,2
// )$, so $P^(-1)= 1 / 3 mat(
// -2,1;1,1
// )$. So we have
// $
// A^{50} ,= \overbrace{(P D P^(-1))(P D P^(-1))(P D P^(-1))dots.h.c(P D P^(-1))}^{50};
// ,=\overbrace{(PD\cancel{P^(-1)})(\cancel PD\cancel{P^(-1)})(\cancel PD\cancel{P^(-1)})dots.h.c(\cancel P D P^(-1))}^{50};
// ,=PD^{50}P^(-1)= 1 / 3 mat(
// -1,1;1,2
// )mat(
// 1,0;0,4^{50}
// )mat(
// -2,1;1,1
// )
// $
// )

= Lecture 13 - Orthogonalization

// Recall for $bold(u)=mat(
// u_1;u_2;dots.v;u_n
// ),bold(v)=mat(
// v_1;v_2;dots.v;v_n
// ) in RR^n$, we can define the _dot product_ $bold(u) dot.c bold(v)$ to be $bold(u)^T bold(v)=mat(
// u_1,u_2,dots.h.c,u_n
// )mat(
// v_1;v_2;dots.v;v_n
// )=u_1v_1+u_2v_2+dots.h.c u_nv_n$. The #text(fill:blue)[length](or #text(fill:blue)[norm]) of a vector $bold(u)$ can be expressed as $|bold(u)|=sqrt(bold(u) dot.c bold(u)}=sqrt(u_1^2+dots.h.c+u_n^2}$. Geometrically, the dot product can interpreted as $bold(u) dot.c bold(v)=|bold(u)||bold(v)| cos theta$, here $theta$ is the angle between $bold(u)$ and $bold(v)$ (which could be between 0 and $\pi$)
//
// - If $bold(u) dot.c bold(v)<0$, then $ cos theta<0$, $theta$ is obtuse, if in addition $bold(u) dot.c bold(v)=|bold(u)||bold(v)|$, then $bold(u),bold(v)$ are of the opposite direction.
// - If $bold(u) dot.c bold(v)=0$, then $ cos theta=0$, $theta= \pi / 2 $, or $bold(u)=bold(0)$, or $bold(v)=bold(0)$. In this case, we say that $bold(u),bold(v)$ are #text(fill:blue)[orthogonal]#index[orthogonal] (denoted $bold(u)perpbold(v)$, $perp$ stands for perpendicular).
// - If $bold(u) dot.c bold(v)>0$, then $ cos theta>0$, $theta$ is acute, if in addition $bold(u) dot.c bold(v)=|bold(u)||bold(v)|$, then $bold(u),bold(v)$ are of the same direction.
//

== Orthogonal and orthonormal basis

#definition[
We say a vector $bold(u)$ is of unit length (or a #text(fill:blue)[unit vector], or a #text(fill:blue)[normalized vector]) if $|bold(u)|=1$
]

#definition[
$cal(B)=\{bold(v)_1,dots.h.c,bold(v)_n\}$ is called an orthogonal set if $bold(v)_i,bold(v)_j$ ($i!= j$) are orthogonal. $cal(B)$ is called an #text(fill:blue)[orthogonal] basis if $cal(B)$ is in addition a basis. $cal(B)$ is called an #text(fill:blue)[orthonormal]#index[orthonormal] basis if the basis vectors are in addition normalized.
]

#remark[
Suppose $cal(B)=\{bold(v)_1,dots.h.c,bold(v)_n\}$, to test if $cal(B)$ is an orthogonal (or orthonormal) set, we just need to write $A=mat(
bold(v)_1,dots.h.c,bold(v)_n
)$, and test if
 $
A^T A=mat(
bold(v)_1^T;bold(v)_2^T;dots.v;bold(v)_n^T
)mat(
bold(v)_1,bold(v)_2,dots.h.c,bold(v)_n
)=mat(
bold(v)_1^T bold(v)_1,bold(v)_1^T bold(v)_2,dots.h.c,bold(v)_1^T bold(v)_n;
bold(v)_2^T bold(v)_1,bold(v)_2^T bold(v)_2,dots.h.c,bold(v)_2^T bold(v)_n;
dots.v,dots.v,dots.down,dots.v;
bold(v)_n^T bold(v)_1,bold(v)_n^T bold(v)_2,dots.h.c,bold(v)_n^T bold(v)_n;
)
 $
is diagonal (or if $A^T A=I$)
]

// #theorem[\label{01:12-07/15/2022}
// Suppose $cal(B)=\{bold(v)_1,dots.h.c,bold(v)_p\}$ is an orthogonal set of non-zero vectors, then $cal(B)$ is linearly independent
// ]

// #proof[
// Suppose not, we may assume $bold(0)!=bold(v)_p=c_1bold(v)_1+dots.h.c+r_{p-1}bold(v)_{p-1}$, but then
//  $
// 0<|bold(v)_p|^2=bold(v)_p dot.c (c_1bold(v)_1+dots.h.c+r_{p-1}bold(v)_{p-1})=0
//  $
// Which is a contradiction.
// ]

== Gram-Schmidt process

#question[
Suppose you have two vectors $bold(u),bold(v)$ (here $bold(v)!=bold(0)$), what is the orthogonal projection of $bold(u)$ onto $bold(v)$ (Which we denote as $"Proj"_(bold(v))bold(u)$)?
]

#answer[
First you realize that $"Proj"_(bold(v))bold(u)$ is parallel to $bold(v)$, so we write it as $ lambda bold(v)$, and we know $|"Proj"_(bold(v))bold(u)|= lambda |bold(v)|=|bold(u)| cos theta$, so we may conclude that
 $
 lambda = |bold(u)| (cos theta) / (|bold(v)|) = |bold(u)||bold(v)| (cos theta) /  (|bold(v)|^2) = bold(u) dot.c bold(v) / bold(v) dot.c bold(v)
 $
Therefore we have derived the equation
$
"Proj"_(bold(v))bold(u)= (bold(u) dot.c bold(v)) / (bold(v) dot.c bold(v)) bold(v)
$
]

// #question[
// If $W$ is a subspace of $RR^n$ with an orthogonal basis $cal(B)=\{bold(u)_1,dots.h.c,bold(u)_p\}$, how could you express the orthogonal projection of a vector $bold(y) in RR^n$ onto $W$ (denoted by $"Proj"_W bold(y)$).
// ]

// Suppose $"Proj"_W bold(y)= lambda _1bold(u)_1+dots.h.c+ lambda _pbold(u)_p$, then we should have for any $i$
//  $
// 0=(bold(y)-"Proj"_W bold(y)) dot.c bold(u)_i=(bold(y)- lambda _1bold(u)_1+dots.h.c+ lambda _pbold(u)_p) dot.c bold(u)_i=bold(y) dot.c bold(u)- lambda _ibold(u)_1 dot.c bold(u)_1 =>  lambda _i= bold(y) dot.c bold(u)_i / bold(u)_i dot.c bold(u)_i
//  $
// There we have the equation
// $ \label{22:47-07/14/2022}
// \begin{aligned}
// "Proj"_W bold(y),="Proj"_{bold(u)_1}bold(y)+dots.h.c+"Proj"_{bold(u)_p}bold(y);
// ,= bold(y) dot.c bold(u)_1 / bold(u)_1 dot.c bold(u)_1 bold(u)_1+dots.h.c+ bold(y) dot.c bold(u)_p / bold(u)_p dot.c bold(u)_p bold(u)_p
// \end{aligned}
// $

// If we further assume that $cal(B)$ is an orthonormal basis, then $bold(u)_1 dot.c bold(u)_1=|bold(u)_i|^2=1$. Let's write $U=mat(
// bold(u)_1,dots.h.c,bold(u)_p
// )$. \eqref{22:47-07/14/2022} becomes
// $ \label{22:51-07/14/2022}
// "Proj"_W bold(y)=(bold(y) dot.c bold(u)_1)bold(u)_1+dots.h.c+(bold(y) dot.c bold(u)_p)bold(u)_p=UU^T bold(y)
// $

#example[
Consider $cal(B)={bold(u)_1=mat(
2;1;0
),bold(u)_2=mat(
-1;2;0
)}$, $bold(y)=mat(
1;1;1
)$, $W="Span"{bold(u)_1,bold(u)_2}$. Let $U=mat(
bold(u)_1,bold(u)_2
)=mat(
2,-1;
1,2;
0,0
)$, then $A^T A=mat(
5,0;
0,5
)$ is diagonal, hence $cal(B)$ is an orthogonal set, the orthogonal projection of $bold(y)$ onto $W$ is
$
"Proj"_W bold(y),= bold(y) dot.c bold(u)_1 / bold(u)_1 dot.c bold(u)_1 bold(u)_1+ bold(y) dot.c bold(u)_2 / bold(u)_2 dot.c bold(u)_2 bold(u)_2;
,= 1 dot.c 2+1 dot.c 1+1 dot.c 0 / 2^2+1^2+0^2 bold(u)_1+ 1 dot.c (-1)+1 dot.c 2+1 dot.c 0 / (-1)^2+2^2+0^2 bold(u)_2;
,= 3 / 5 mat(
2;1;0
)+ 1 / 5 mat(
-1;2;0
)=mat(
1;1;0
)
$
]

#question[
Suppose we are given arbitrary basis $cal(B)=\{bold(v)_1,dots.h.c,bold(v)_p\}$ for a subspace $W$ of $RR^n$, how could we get a orthogonal (or orthonormal) basis $cal(U)=\{bold(u)_1,dots.h.c,bold(u)_p\}$ from it
]

#answer[
We apply the #text(fill:blue)[Gram-Schmidt process]#index[Gram-Schmidt process]

// - $bold(u)_1=bold(v)_1$
// - $bold(u)_2=bold(v)_2-"Proj"_{bold(u)_1}bold(v)_2$;
// $\hphantom{bold(u)_2}=bold(v)_2-\dfrac{bold(v)_2 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1$
// - $bold(u)_3=bold(v)_3-"Proj"_{bold(u)_1}bold(v)_3-"Proj"_{bold(u)_2}bold(v)_3$;
// $\hphantom{bold(u)_3}=bold(v)_3-\dfrac{bold(v)_3 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1-\dfrac{bold(v)_3 dot.c bold(u)_2}{bold(u)_2 dot.c bold(u)_2}bold(u)_2$
// - $\hphantom{bold(u)_4}dots.v$
// - $bold(u)_p=bold(v)_p-"Proj"_{bold(u)_1}bold(v)_p-dots.h.c-"Proj"_{bold(u)_{p-1}}bold(v)_p$;
// $\hphantom{bold(u)_p}=bold(v)_p-\dfrac{bold(v)_p dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1-dots.h.c-\dfrac{bold(v)_p dot.c bold(u)_{p-1}}{bold(u)_{p-1} dot.c bold(u)_{p-1}}bold(u)_{p-1}$

Then ${bold(u)_1,dots.h.c,bold(u)_p}$ would be an orthogonal basis. To get an orthonormal basis, just normalize these vectors.
]

#example[
Consider ${bold(v)_1=mat(
1;1;1
),bold(v)_2=mat(
1;2;2
),bold(v)_3=mat(
3;-1;1
)}$. Let's use Gram-Schmidt process to find an orthogonal (and an orthonormal) basis from it.

- First we choose $bold(u)_1=bold(v)_1=mat(
1;1;1
)$
- $bold(v)_2-\dfrac{bold(v)_2 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1=mat(
1;2;2
)- 5 / 3 mat(
1;1;1
)=mat(
- 2 / 3 ; 1 / 3 ; 1 / 3
)$. Let's instead take a multiple of this to be our $bold(u)_2$, namely we set $bold(u)_2=mat(
-2;1;1
)$
- $bold(u)_3=bold(v)_3-\dfrac{bold(v)_3 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1-\dfrac{bold(v)_3 dot.c bold(u)_2}{bold(u)_2 dot.c bold(u)_2}bold(u)_2=mat(
3;-1;1
)-mat(
1;1;1
)-mat(
-2;1;1
)=mat(
0;-1;1
)$

Thus ${bold(u)_1=mat(
1;1;1
),bold(u)_2=mat(
-2;1;1
),bold(u)_3=mat(
0;-1;1
)}$ is an orthogonal basis for $RR^3$. If we further normalize it, we have
 $
bold(w)_1= bold(u)_1 / (|bold(u)_1|) = 1 / (sqrt(3)) mat(
1;1;1
)=mat(
 1 / (sqrt(3)) ; 1 / (sqrt(3)) ; 1 / (sqrt(3))
) \
bold(w)_2= bold(u)_2 / (|bold(u)_2|) = 1 / (sqrt(6)) mat(
-2;1;1
)=mat(
- 1 / (sqrt(3)) ; 1 / (sqrt(6)) ; 1 / (sqrt(6))
) \
bold(w)_3= bold(u)_3 / (|bold(u)_3|) = 1 / (sqrt(2)) mat(
0;-1;1
)=mat(
0;- 1 / (sqrt(2)) ; 1 / (sqrt(2))
)
 $
is an orthonormal basis.
]<ex:3by3-Gram>

#exercise[
Use Gram-Schmidt process to find an orthogonal and orthonormal basis of the following basis
- ${mat(1;2),mat(3;1)}$
- ${mat(1;1;-1),mat(2;1;0),mat(-2;-1;3)}$
]

== Orthogonal matrix and QR factorization

#definition[
A square matrix $U$ is called an #text(fill:blue)[orthogonal matrix]#index[orthogonal matrix] if  the columns of $U$ form an orthonormal basis $<=> U^T U=U U^T=I$. Note that in this particular case, $U^T=U^(-1)$
]

#remark[
The rows of $U$ also form an orthonormal basis.
]

#note[
The name _orthogonal matrix_ is unfortunate since it is made out of orthonormal basis. It should really be called the orthonormal matrix. But since mathematicians has been using this for a long time. So we will stick to this usage.
]

// The Gram-Schmidt process gives us the so-called $QR$-factorization. First we can rewrite the Gram-Schmidt process as
// $
// bold(v)_1,=bold(u)_1;
// bold(v)_2,=\dfrac{bold(v)_2 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1+bold(u)_2;
// bold(v)_3,=\dfrac{bold(v)_3 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1+\dfrac{bold(v)_3 dot.c bold(u)_2}{bold(u)_2 dot.c bold(u)_2}bold(u)_2+bold(u)_3;
// ,dots.v;
// bold(v)_n,=\dfrac{bold(v)_n dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1+dots.h.c+\dfrac{bold(v)_n dot.c bold(u)_{n-1}}{bold(u)_{n-1} dot.c bold(u)_{n-1}}bold(u)_{n-1}+bold(u)_n
// $
// After normalization (let's set $bold(u)_i:= bold(u)_i / |bold(u)_i| $ to be unit vectors), we may write the above as the following set of equations with coefficients
// $
// bold(v)_1,=r_(11)bold(u)_1;
// bold(v)_2,=r_(12)bold(u)_1+r_(22)bold(u)_2;
// bold(v)_3,=r_(13)bold(u)_1+r_(23)bold(u)_2+r_(33)bold(u)_3;
// ,dots.v;
// bold(v)_n,=r_{1n}bold(u)_1+dots.h.c+r_{n-1,n}bold(u)_{n-1}+r_{nn}bold(u)_n
// $
// If we write $A=mat(
// bold(v)_1,dots.h.c,bold(v)_n
// )$, $Q=mat(
// bold(u)_1,dots.h.c,bold(u)_n
// )$ (this is an orthogonal matrix), then have
//  $
// A=mat(
// bold(v)_1,dots.h.c,bold(v)_n
// )=mat(
// bold(u)_1,dots.h.c,bold(u)_n
// )mat(
// r_(11),r_(12),r_(13),dots.h.c, r_{1n};
// 0,r_(22),r_(23),dots.h.c,r_{2n};
// 0,0,r_(33),dots.h.c,r_{3n};
// dots.v,dots.v,dots.v,dots.down,dots.v;
// 0,0,0,dots.h.c,r_{nn}
// )=QR
//  $
// It can be shown that $QR$-factorization always exists, even $A$ is not invertible (columns does not form a basis)

// #example[
// Continuing Example @(ex:3by3-Gram), we consider the $QR$-factorization of $A=mat(
// bold(v)_1,bold(v)_2,bold(v)_3
// )=mat(
// 1,1,3;
// 1,2,-1;
// 1,2,1
// )$, we know that $Q=mat(
// bold(w)_1,bold(w)_2,bold(w)_3
// )=mat(
//  1 / (sqrt(3)) ,- 1 / (sqrt(3)) ,0;
//  1 / (sqrt(3)) , 1 / (sqrt(6)) ,- 1 / (sqrt(2)) ;
//  1 / (sqrt(3)) , 1 / (sqrt(6)) , 1 / (sqrt(2))
// )$, so we know that
//  $
// R=Q^(-1)A=Q^T A=mat(
//  1 / (sqrt(3)) , 1 / (sqrt(3)) , 1 / (sqrt(3)) ;
// - 1 / (sqrt(3)) , 1 / (sqrt(6)) , 1 / (sqrt(6)) ;
// 0,- 1 / (sqrt(2)) , 1 / (sqrt(2))
// )mat(
// 1,1,3;
// 1,2,-1;
// 1,2,1
// )=mat(
// (sqrt(3)), 5 / (sqrt(3)) ,(sqrt(3));
// 0, 2 / (sqrt(6)) ,-(sqrt(6));
// 0,0,(sqrt(2))
// )
//  $
// Note that here we didn't actually use Gram-Schmidt process to evaluate $R$, instead we only used the existence of $QR$-factorization.
// )

#definition[
Suppose $W$ is a subspace of $RR^n$, the #text(fill:blue)[orthogonal complement]#index[orthogonal complement] $W^perp=\{bold(v)|bold(v)perp W\}$ is the set of vectors that are orthogonal to $W$
]

#remark[
It is easy to show that $W$ is a subspace of $RR^n$ and $(W^perp)^perp=W$. This is kind of a _duality_, take $RR^3$ for an example, the orthogonal complement of a line would be the perpendicular plane, the orthogonal complement of a plane would be the perpendicular line, the orthogonal complement of the origin (a point) would be the whole space ($RR^3$) and the orthogonal complement of $RR^3$ would be the origin $\{bold(0)\}$. From this we also see that $"dim" W+"dim" W^perp=n$.
]

We make the following crucial observation: $bold(x)$ is in $"Nul"A<=>bold(x)$ is orthogonal all row vectors of $A<=> bold(x)perp"Row"A$, so we may conclude that $("Row"A)^perp="Nul"A$, and similarly we know that $("Col"A)^perp=("Row "(A^T))^perp="Nul "(A^T)$.

#exercise[
Suppose $W="Span"{mat(
1;1;0;2;0;3
),mat(
0;0;1;-2;0;2
),mat(
0;0;0;0;1;1
)}$, find $("Col"A)^perp$.
]

= Lecture 14 - Least-square problem

== Least-square solutions

#question[
linear system $A bold(x)=bold(b)$ may not always be solvable, nonetheless, we still want to find the _best possible_ solution $\hat{bold(x)}$
]

#answer[
According to Gauss, by best possible we mean the #text(fill:blue)[least-square solutions]#index[least-square]. In concrete terms, such $\hat{bold(x)}$ stisfies that $|A\hat{bold(x)}-bold(b)|\leq|A bold(x)-bold(b)|$ for any other choice of $bold(x)$.
]

By a simple argument we can show that $A\hat{bold(x)}$ must be the projection of $bold(b)$ onto $"Col"A$, so we know that
$
(A\hat{bold(x)}-bold(b))perp"Col"A<=>(A\hat{bold(x)}-bold(b)) in ("Col"A)^perp="Nul "(A^T)<=> A^T(A\hat{bold(x)}-bold(b))=bold(0)<=> A^T A\hat{bold(x)}=A^T bold(b)
$

// We call equation
// $ \label{00:08-07/15/2022}
// A^T A bold(x)=A^T bold(b)
// $
// the normal equation of $A bold(x)=bold(b)$. And we have shown that the least square solutions of the linear system $A bold(x)=bold(b)$ is the solution set to the normal equation~\eqref{00:08-07/15/2022}. The solution to the least square problem might not be unique.

// #theorem[
// $A^T A bold(x)=A^T bold(b)$ has a unique solution $<=>$ the columns of $A$ is linearly independent $<=> A^T A$ is invertible. And the unique solution would of course be $(A^T A)^(-1)A^T bold(b)$
// ]

// #example[
// Suppoes $A=mat(
// 4,0;
// 0,2;
// 1,1
// )$, $bold(b)=mat(
// 2;0;11
// )$. It is easy to verify that the linear system $A bold(x)=bold(b)$ is not linearly consistent. To solve for the least-square solution, we look at its normal equation
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
// )=A^T A bold(x)=A^T bold(b)=mat(
// 4,0,1;
// 0,2,1
// )mat(
// 2;0;11
// )=mat(
// 19;11
// )
//  $
// And solve for $bold(x)(A^T A)^(-1)A^T bold(b)=(A^T A)^(-1)A^T bold(b)=mat(
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
// )$, solve for the least square solution of $A bold(x)=bold(b)$.
// ]

== Machine Learning and approxi mation

#question[
Suppose you know a curve has the form
 $
y=beta_1f_1(x_1,dots.h.c,x_k)+beta_2f_2(x_1,dots.h.c,x_k)+dots.h.c+beta_n f_n(x_1,dots.h.c,x_k)
 $
And you know what functions $f_1,f_2,dots.h.c,f_n$ should be (they could be linear functions, quadratic functions, polynomial functions, exponential functions, logarithmic function, trigonometry functions, etc.). You also have collected a bunch of data points $(x_1^((1)),dots.h.c,x_k^((1)),y^((1))),(x_1^((2)),dots.h.c,x_k^((2)),y^((2))),dots.h.c,(x_1^((m)),dots.h.c,x_k^((m)),y^((m)))$. How do you find best fitting coefficients $beta_1,beta_2,dots.h.c,beta_n$? First let's define the #text(fill:blue)[residual]#index[residual]
 $
epsilon^((i))=y^((i))-beta_1f_1(x_1^((i)),dots.h.c,x_k^((i)))-beta_2f_2(x_1^((i)),dots.h.c,x_k^((i)))-dots.h.c-beta_n f_n(x_1^((i)),dots.h.c,x_k^((i)))
 $
Our goal to minimize the residual. One might want to minimize the quantity $sum_(i=1)^m|epsilon^((i))|$, however, this is cumbersome, difficult to work with, and mathematically unsatisfactory. So Gauss instead considered the square sum $sum_{i=1}^m|epsilon^((i))|^2$, posed and solved the least square problem!!!
]

#answer[
We use normal equations.
]

Let's write
 $
bold(y)=mat(
y^((1));dots.v;y^((m))
),bold(beta)=mat(
beta_1;dots.v;beta_n
),bold(epsilon)=mat(
epsilon^((1));dots.v;epsilon^((m))
),
X=mat(
f_1(x_1^((1)),dots.h.c,x_k^((1))),dots.h.c,f_n(x_1^((1)),dots.h.c,x_k^((1)));
dots.v,dots.down,dots.v;
f_1(x_1^((m)),dots.h.c,x_k^((m))),dots.h.c,f_n(x_1^((m)),dots.h.c,x_k^((m)));
)
 $
Then have $bold(y)=X bold(beta)=bold(epsilon)$. To minimize $| bold(epsilon)|^2$ will be the same as solving the normal equation $X^T X bold(beta)=X^T bold(y)$ of $X bold(beta)=bold(y)$.

#example[
Find the equation $y=beta_0+beta_1x$ of the least-squares line that best fits the data points $(2,1),(5,2),(7,3)$ and $(8,3)$.
]


= Lecture 15 - Complex eigenvalues

== Complex numbers

#theorem[
Consider quadratic equation $at^2+b t+c=0$, the #text(fill:blue)[quadratic formula]#index[quadratic formula] reads $t=(-b  plus.minus sqrt(Delta)) / (2a)$, where $ Delta=b^2-4a c$ is the discriminant.
]

Let's review some general stuff about complex numbers.

#definition[
The set of complex numbers $CC$ is the defined to be $\{z=a+b i|a,b in RR\}$, with $i=sqrt(-1)$ so that $i^2=-1$. We call $"Re"z=a$ the #text(fill:blue)[real part]#index[real part] of $z$ and $"Im"z=b$ to be the #text(fill:blue)[imaginary part]#index[imaginary part] of $z$. We call $r=|z|=sqrt(a^2+b^2)$ the #text(fill:blue)[modulus]#index[modulus] (or #text(fill:blue)[absolute value]) of $z$, and the angle $ phi $ between $z$ and the real axis the #text(fill:blue)[argument]#index[argument] of $z$.
]

#definition[
There is a natural identification between the complex numbers and the plane $RR^2$ via $z=a+b i arrow.squiggly (a,b)$ (this is why the set of complex numbers is often called the complex plane). We can define

- Addition via $(a+b i)+(c+d i)=(a+c)+(b+d)i$
- Multiplication via $(a+b i)(c+d i)=a c+a d i+b c i+b d i^2=(a c-b d)+(a d+b c)i$.
- #text(fill:blue)[Conjugate]#index[conjugate] as $#overline[z]=a-b i$.

]

#remark[
Through this identification it is easy to see that $a=r cos  phi $, $b=r sin  phi $, and we have #text(fill:blue)[Euler's formula]#index[Euler's formula] $z=r e^{i phi }=r cos  phi =i sin  phi $.
]

#remark[
If we have a complex-valued matrix $A$, then the conjugation is defined entrywise (Note that column vectors are matrices). If we write a complex valued matrix $A="Re"A+i"Im"A$, then the conjugation would be $#overline[A]="Re"A-i"Im"A$. For example, if $A=mat(
1+2i,3;
-1-i,i
)=mat(
1,3;
-1,0
)+i mat(
2,0;
-1,1
)$, then $#overline[A]=mat(
1-2i,3;
-1+i,-i
)=mat(
1,3;
-1,0
)-i mat(
2,0;
-1,1
)$. It is easy to check that $#overline[A+B]=#overline[A]+#overline[B]$, $#overline[c A]=#overline[c #overline[A]]$, $#overline[A B]=#overline[A]#overline[B]$.
]

== Eigen-decomposition over the complex numbers

#question[
$A=mat(
1,-2;1,3
)$, can we diagonalize it?
]

#answer[
First we compute its characteristic polynomial $t^2-4t+5$, an then we can solve the quadratic equation as follows
 $
 Delta=(-4)^2-4 dot.c 1 dot.c 5=-4,t=(-(-4)  plus.minus sqrt(-4)) / 2= -(-4)  plus.minus (2i) / 2 =2  plus.minus  i
 $
Hence the eigenvalues are $ lambda _1=2+i, lambda _2=2-i$. The eigenvector for $ lambda _1$ can be computed via
//  $
// mat(
//  lambda _1I-A,bold(0)
// ; augment:#(-1))tilde mat(
// 1,1-i,0;
// 0,0,0
// ; augment:#(-1))
//  $
So we get $bold(v)_1=mat(
-1+i;1
)=mat(
-1;1
)+mat(
i;0
)=mat(
-1;1
)+mat(
1;0
)i="Re"bold(v)_1+i"Im"bold(v)_1$. The eigenvector for $ lambda _2$ can be computed via
//  $
// mat(
//  lambda _2I-A,bold(0)
// ; augment:#(-1))tilde mat(
// 1,1+i,0;
// 0,0,0
// ; augment:#(-1))
//  $
So we get $bold(v)_2=mat(
-1-i;1
)=mat(
-1;1
)+mat(
-i;0
)=mat(
-1;1
)+mat(
-1;0
)i="Re"bold(v)_2+i"Im"bold(v)_2$. Now we may realize that we have $ lambda _1$ and $ lambda _2$ are conjugate of each other. $bold(v)_1$ and $bold(v)_2$ are conjugate of each other.
]

#theorem[
In general, if $A$ is a 2 by 2 real-valued matrix with complex eigenvalues (characteristic polynomial have complex roots, no real roots), then they are conjugate of each other, we can write them as $ lambda =a-b i$ and $#overline[lambda] =a+b i$, suppose the eigenvector for $ lambda $ is $bold(v)="Re"bold(v)+i"Im"bold(v)$, then the eigenvector for $#overline[lambda] $ will be $#overline[bold(v)]="Re"bold(v)-i"Im"bold(v)$. If we write $P=mat(
"Re"bold(v),"Im"bold(v)
)$, and $C=mat(
a,-b;
b,a
)$, then $A P=P C$, therefore we get decomposition $A=P C P^(-1)$.
]

#proof[
We have $A bold(v)= lambda bold(v)$ (and hence by conjugation we have $A#overline[bold(v)]=A#overline[bold(v)]=#overline[A]#overline[bold(v)]=#overline[A bold(v)]=#overline[lambda]#overline[bold(v)]$, note that here $A$ is real-valued, so $#overline[A]=A$), we can rewrite this as
 $
(A"Re"bold(v))+i(A"Im"bold(v))=A("Re"bold(v)+i"Im"bold(v))=A bold(v)= lambda bold(v)=(a-b i)("Re"bold(v)+i"Im"bold(v))=(a"Re"bold(v)+b"Im"bold(v))+i(a"Im"bold(v)-b"Re"bold(v))
 $
Looking at its real and imaginary parts we conclude that
 $
A"Re"bold(v)=a"Re"bold(v)+b"Im"bold(v),quad A"Im"bold(v)=a"Im"bold(v)-b"Re"bold(v)
 $
This is precisely $A P=P C$
]

#remark[
Matrix $C$ is special in the following sense (it can be decomposed as a composition of rotation and scaling)
 $
C=mat(
a,-b;
b,a
)=mat(
r cos  phi ,-r sin  phi ;
r sin  phi ,r cos  phi
)=r mat(
 cos  phi ,- sin  phi ;
 sin  phi , cos  phi
)
 $
Here we suppose $#overline[lambda] =a+b i=r e^{i phi }=r cos  phi +i r sin  phi $ so that $a=r cos  phi $, $b=r sin  phi $.
]

#example[
In the previous example, we could take $ lambda =2-i$ so that $a=2,b=1$, $bold(v)=mat(
-1;1
)+i mat(
-1;0
)$ so that $"Re"bold(v)=mat(
-1;1
)$, $"Im"bold(v)=mat(
-1;0
)$, and we have the decomposition
 $
A=mat(
1,-2;
1,3
)=mat(
-1,-1;
1,0
)mat(
2,-1;
1,2
)mat(
0,1;
-1,-1
)=P C P^(-1)
 $
]

#exercise[
Suppose $A=mat(
-1,-1;5,-5
)$. Find an invertible matrix $P$ and a matrix $C$ of the form $mat(
a,-b;b,a
)$ such that $A=P C P^(-1)$
]

= Lecture 16 - Orthogonal diagonalization

== Orthogonal diagonalization

#theorem[
Suppose $A$ is a symmetric ($A^T=A$) real-valued matrix, and $bold(v)_1$, $bold(v)_2$ are $ lambda _1$-eigenvector, $ lambda _2$-eigenvectors respectively. Then $bold(v)_1 dot.c bold(v)_2=0$
]<thm:symmat-eigenvec-ortho>

#proof[
Consider
 $
 lambda _1(bold(v)_1 dot.c bold(v)_2)=( lambda _1bold(v)_1)^T bold(v)_2=(A bold(v)_1)^T bold(v)_2 \
 =bold(v)_1^T A^T bold(v)_2=bold(v)_1^T A bold(v)_2=bold(v)_1 dot.c ( lambda _2bold(v)_2)= lambda _2(bold(v)_1 dot.c bold(v)_2)
 $
We get $( lambda _1- lambda _2)(bold(v)_1 dot.c bold(v)_2)=0$, since $ lambda _1- lambda _2!=0$, $bold(v)_1 dot.c bold(v)_2=0$
]

#theorem[
Suppose $A$ is a symmetric real-valued matrix, then the eigenvalues are also real.
]

#proof[
Suppose $ lambda $ is an eigenvalue of $A$, then there exists some $ lambda $-eigenvector such that $A bold(v)= lambda bold(v)$, and that the length of the complex vector $bold(v)$ is $|bold(v)|^2=#overline[bold(v)] dot.c bold(v)$ is a positive real number (Note that for a complex number $z=a+b i$, $|z|^2=a^2+b^2=(a+b i)(a-b i)=z#overline[z]$). Since $A$ is symmetric and real-valued, $#overline[A]^T=A$. We have
 $
#overline[lambda] |bold(v)|^2=#overline[A bold(v)]^T bold(v)=#overline[bold(v)]^T#overline[A]^T bold(v)=#overline[bold(v)]^T A bold(v)= lambda |bold(v)|^2
 $
Which implies that $( lambda -#overline[lambda] )|bold(v)|^2=0$, so $ lambda =#overline[lambda] $, i.e. $ lambda $ is real-valued.
]

#fact[
A symmetric real-valued matrix is diagonalizable.
]

#theorem[
Suppose $A$ is a symmetric real-valued matrix with eigenvalues $ lambda _1,dots.h.c, lambda_n$ (maybe repeated). $A$ can be orthogonal diagonalized as $A=P D P^T$, where $D$ is the diagonal matrix $mat(
 lambda _1,,;
,dots.down,;
,, lambda_n
)$, and $P$ is an orthogonal matrix.
]

#proof[
To get an orthonormal basis for each eigenspace $"Nul "( lambda  I-A)$, you just need to find an arbitrary basis, and then apply Gram-Schmidt process to get an orthonormal basis, then by Theorem @thm:symmat-eigenvec-ortho, the set of eigenvectors form an orthonormal basis for $RR^n$, assume they are $bold(u)_1,dots.h.c,bold(u)_n$, in corresponds to eigenvalues $ lambda _1,dots.h.c, lambda_n$, then we get orthogonal diagonalization
 $
A=P D P^(-1)=P D P^T
 $
Here $P=mat(
bold(u)_1,dots.h.c,bold(u)_n
)$ is an orthogonal basis and thus $P^(-1)=P^T$.
]

#example[
Suppose $A=mat(
7,2;
2,4
)$, the characteristic polynomial is $(t-3)(t-8)$, so we have eigenvalues $ lambda _1=3$ and $ lambda _2=8$, we can then find the eigenvectors $bold(v)_1=mat(
-1;2
)$ and $bold(v)_2=mat(
2;1
)$, we may realized that $bold(v)_1 dot.c bold(v)_2=0$, i.e. $bold(v)_1$ is orthogonal to $bold(v)_2$, we can further normalize them into $bold(u)_1= bold(v)_1 / |bold(v)_1| =mat(
- 1 / sqrt(5) ; 2 / sqrt(5)
)$ and $bold(u)_2= bold(v)_2 / |bold(v)_2| =mat(
 2 / sqrt(5) ; 1 / sqrt(5)
)$. So we have orthogonal diagonalization
 $
A=mat(
7,2;
2,4
)=mat(
- 1 / sqrt(5) , 2 / sqrt(5) ;
 2 / sqrt(5) , 1 / sqrt(5)
)mat(
3,0;
0,8
)mat(
- 1 / sqrt(5) , 2 / sqrt(5) ;
 2 / sqrt(5) , 1 / sqrt(5)
)=P D P^T
 $
]<ex:2by2-charpoly>

// #example[
// Suppose $A=mat(
// 3,-2,4;
// -2,6,2;
// 4,2,3;
// )$, then characteristic polynomial is
// $
// "det"(tI-A),=| mat(
// t-3,2,-4;
// 2,t-6,-2;
// -4,-2,t-3
//  ) |xequal(#`R3`-> #`R3`+2#`R2`)| mat(
// t-3,2,-4;
// 2,t-6,-2;
// 0,2t-14,t-7
//  ) |;
// ,xequal("factor $(t-7)$ from 3rd row")(t-7)| mat(
// t-3,2,-4;
// 2,t-6,-2;
// 0,2,1
//  ) |xequal(C2-> C2-C3)(t-7)| mat(
// t-3,10,-4;
// 2,t-2,-2;
// 0,0,1
//  ) |;
// ,xequal("cofactor expansion on the 3rd row")(t-7) dot.c 1 dot.c (-1)^{3+3}| mat(
// t-3,10;
// 2,t-2
//  ) |;
// ,=(t-7)(t^2-5t-14)=(t-7)^2(t+2)
// $
// Hence the eigenvalues are $ lambda _1= lambda _2=7$, $ lambda _3=-2$
//  $
// mat(
// 7I-A,bold(0)
// ; augment:#(-1))tilde mat(
// 1, 1 / 2 ,-1,0;
// 0,0,0,0;
// 0,0,0,0
// ; augment:#(-1))
//  $
// so we may choose
//  $
// bold(v)_1=2mat(
// - 1 / 2 ;1;0
// )=mat(
// -1;2;0
// ),\quadbold(v)_2=mat(
// 1;0;1
// )
//  $
// as eigenvectors for $ lambda _1= lambda _2=7$. We can use Gram-Schmidt process to get an orthogonal set: $bold(w)_1=bold(v)_1=mat(
// -1;2;0
// )$, $bold(v)_2-\dfrac{bold(v)_2 dot.c bold(w)_1}{bold(w)_1 dot.c bold(w)_1}bold(w)_1=mat(
//  4 / 5 ; 2 / 5 ;1
// )$, we can choose $bold(w)_2=mat(
// 4;2;5
// )$. We can normalize them into
//  $
// bold(u)_1= 1 / sqrt(5) mat(
// -1;2;0
// ),\quadbold(u)_2= 1 / 3sqrt(5) mat(
// 4;2;5
// )
//  $
//  $
// mat(
// -2I-A,bold(0)
// ; augment:#(-1))tilde mat(
// 1,0,1,0;
// 0,1, 1 / 2 ,0;
// 0,0,0,0
// ; augment:#(-1))
//  $
// so we may choose
//  $
// bold(v)_3=2mat(
// -1;- 1 / 2 ;1
// )=mat(
// -2;-1;2
// )
//  $
// as the eigenvector for $ lambda _3=-2$. We can normalize it into
//  $
// bold(u)_3= bold(v)_3 / |bold(v)_3| = 1 / 3 mat(
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
// - 1 / sqrt(5) , 4 / 3sqrt(5) ,- 2 / 3 ;
//  2 / sqrt(5) , 2 / 3sqrt(5) ,- 1 / 3 ;
// 0, 5 / 3sqrt(5) , 2 / 3
// )mat(
// 7,0,0;
// 0,7,0;
// 0,0,-2
// )mat(
// - 1 / sqrt(5) , 2 / sqrt(5) ,0;
//  4 / 3sqrt(5) , 2 / 3sqrt(5) , 5 / 3sqrt(5) ;
// - 2 / 3 ,- 1 / 3 , 2 / 3
// )=P D P^T
//  $
// )

== Spectral decomposition

#theorem[
Suppose $A$ is a symmetric real-valued matrix, and $A=P D P^T$ is its orthogonal diagonalization, then we have the so-called spectral decomposition
 $
A= lambda _1bold(u)_1bold(u)_1^T+dots.h.c+ lambda_n bold(u)_n bold(u)_n^T
 $
]

#proof[
 $
A=P D P^T=mat(
bold(u)_1,dots.h.c,bold(u)_n
)mat(
 lambda _1,,;
,dots.down,;
,, lambda_n
)mat(
bold(u)_1^T;dots.v;bold(u)_n^T
)=mat(
 lambda _1bold(u)_1,,;
,dots.down,;
,, lambda_n bold(u)_n
)mat(
bold(u)_1^T;dots.v;bold(u)_n^T
)= lambda _1bold(u)_1bold(u)_1^T+dots.h.c+ lambda_n bold(u)_n bold(u)_n^T
 $
]

#remark[
Recall that if $bold(u)$ is of unit length, then $"Proj"_(bold(u))bold(x)=bold(u)bold(u)^T bold(x)$, so
 $
A bold(x)= lambda _1bold(u)_1bold(u)_1^T bold(x)+dots.h.c+ lambda_n bold(u)_n bold(u)_n^T bold(x)
 $
You can think of this as decompose the matrix transformation $bold(x)|-> A bold(x)$ into the sum of scaled orthogonal projections.
]

= Lecture 21 - Quadratic forms

Let's briefly talk about quadratic forms: $a x_1+2b x_1x_2+c x_2^2=mat(
x_1,x_2
)mat(
a,b;b,c
)mat(
x_1;x_2
)=bold(x)^T A bold(x)$. In Example @ex:2by2-charpoly, $bold(x)^T A bold(x)$ is the quadratic form $7x_1^2+4x_1x_2+4x_2^2$, note that $bold(y)=P^T bold(x)$ gives change of (orthonormal) coordinates (actually differ by a rotation) $ cases(
y_1&=- 1 / sqrt(5) x_1+ 1 / sqrt(5) x_2,
y_2&= 2 / sqrt(5) x_1+ 1 / sqrt(5) x_2
)$, then the quadratic form becomes $bold(x)^T A bold(x)=bold(x)^T P D P^T bold(x)=(P^T bold(x))^T D(P^T bold(x))=bold(y)^T D bold(y)=3y_1^2+8y_2^2$, note this is without cross term $y_1y_2$.

= Lecture 22 - Singular value decomposition

= Appendix

#theorem[
The RREF of a matrix $A$ is unique.
]

#proof[
The linear dependences of columns of $A$ is presevered under row elementary operations, thus the pivot columns are unique. And for the same reason, we know how all other entries look like.
]

// % \begin{lemma}\label{lem: det A lemma}
// % Suppose $A=mat(
// % B_1,*,B_2;
// % 0,h,0;
// % B_3,*,B_4
// % )$, where $h$ is the $(i,j)$-th entry. If we write $B=mat(
// % B_1,B_2;B_3,B_4
// % )$ then $"det "A=(-1)^{i+j}h dot.c "det "B$
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
// % \filldraw[blue!50] (o)--(a)--($(a)+(b)$)node[above]{$"det "B$}--(b)--cycle;
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

= Online Assignments

== Online Assignment 1

#problem[
Rewrite the following linear systems as augmented matrices and then solve them, show all your work
- $ cases(
5x_1+x_2=2,
3x_1-x_2=6
) $
- $ cases(
x_1+x_2+x_3=6,
x_1-x_2+x_3=2,
-x_1+x_2+x_3=4
) $
]

// #solution[
// // - The augmented matrix is
// $
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
// $
// Thus the solution to this linear system is $#cases(
// x_1=1;x_2=-3
// )$
// - The augmented matrix is
// $
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
// $
// Thus the solution to this linear system is $#cases(
// x_1=1;x_2=2;x_3=3
// )$
// // ]

#problem[
How many solutions does the following linear systems of equations have
- $ cases(
5x_1+7x_2=3,
-10x_1-14x_2=-3
) $
- $ cases(
2x_1-x_2=4,
x_1- 1 / 2 x_2=2
) $
]

// #solution[
// // - The augmented matrix is
// $
// ,mat(
// 5,7,3;
// -10,-14,-3
// )xarrow(#`R2`-> #`R2`+2#`R1`)mat(
// 5,7,3;
// 0,0,3
// )
// $
// Since the last column has pivot, by Theorem @thm:sol-pivot, this linear system has no solutions
// - $
// ,mat(
// 2,-1,4;
// 1,- 1 / 2 ,2
// )xarrow(#`R2`-> #`R2`- 1 / 2 #`R1`)mat(
// 2,-1,4;
// 0,0,0
// )
// $
// Since the last column has no pivot and there is a free variable $x_2$, by Theorem @thm:sol-pivot, this linear system has infinitely solutions
// // ]

#problem[
Consider the following matrix
$
A=mat(
1,2,2,3,1;
0,0,-1,2,1;
0,0,0,2,4;
)
$
- Which columns are the pivot columns of $A$?
- Write down the RREF of the this matrix
]

// #solution[
// // - The pivot columns of $A$ are columns 1,3,4.
// \item
// $
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
// $
// // ]

#problem[
Determine which of the following statements are true
- The following matrix is of row reduced echelon form
$
mat(
1,2,2,3,1;
0,0,0,2,4;
0,0,-1,2,1;
)
$
- The following two matrices are equivalent
$
mat(
1,-1,1,3,2;
2,4,1,2,4;
1,1,-3,2,1;
)tilde
mat(
1,2,2,3,1;
0,0,0,2,4;
0,0,-1,2,1;
)
$
]

// #solution[
// // - False. $(3,3)$, $(2,4)$-th entries are pivots which breaks the ``staircase shape"
// \begin{tikzpicture}
// \node at (0,0) {$mat(
// #text(fill:red){1},2,2,3,1;
// 0,0,0,#text(fill:red){2},4;
// 0,0,#text(fill:red){-1},2,1;
// )$};
// \draw[thick, red] (-1.4,0.2)--(0.4,0.2)--(0.4,-0.2)--(-0.4,-0.2)--(-0.4,-0.6)--(1.4,-0.6);
// \end{tikzpicture}
// - False. Because
// $
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
// $
// has pivot columns 1,2,3, and
// $
// mat(
// 1,2,2,3,1;
// 0,0,0,2,4;
// 0,0,-1,2,1;
// )xarrow(#`R2` arrow.l.r  #`R3`)mat(
// 1,2,2,3,1;
// 0,0,-1,2,1;
// 0,0,0,2,4;
// )
// $
// has pivot columns 1,3,4. By Theorem @thm:unique-rref, they are not equivalent, otherwise they would have the same RREF, which implies same pivot columns.
// // ]

#problem[
Determine the value(s) of $h$ such that the matrix is the augmented matrix of a consistent linear system
$
mat(
1,h,1;
2,4,4;
)
$
]

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
// By Theorem @thm:sol-pivot, the linear system has solutions $<=>$ the last column is not a pivot column $<=> 4-2h!=0<=> h!=2$
// ]

#problem[
Do the three lines $x_1-4x_2 = 1$, $2x_1-x_2 =-3$, and $-x_1 - 3x_2 = 4$ have a common point of intersection? Explain.
]

// #solution[
// Note that a common point of intersection would be a solution to the linear system cases(x_1-4x_2 = 1, 2x_1-x_2 =-3, -x_1 - 3x_2 = 4}, consider its augmented matrix
// $
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
// $
// By Theorem @thm:sol-pivot, since the last column is not a pivot column, the linear system is consistent, i.e. these three lines has comon point(s) of intersection.
// ]

== Online Assignment 2

#problem[
Consider the following statements
- For any four distinct vectors $bold(v)_1,bold(v)_2,bold(v)_3,bold(v)_4$ in $RR^3$, $"Span"\{bold(v)_1,bold(v)_2,bold(v)_3,bold(v)_4\}=RR^3$
- Suppose we know that the augmented matrix of the linear system
 $
cases(
a_1x_1+a_2x_2+a_3x_3=d_1,
b_1x_1+b_2x_2+b_3x_3=d_2,
c_1x_1+c_2x_2+c_3x_3=d_3
)
 $
has two pivot columns, then how many solutions could the linear system have?
- Consider matrix equation $A bold(x)=bold(0)$ where $A$ is a 3 by 4 matrix, then it always has more than one solution (obviously $bold(x)=bold(0)$ will be a solution)
]

// #solution[
// // - False. A counter-example would be $bold(v)_1=mat(
// 1;0;0
// )$,$bold(v)_2=mat(
// 0;1;0
// )$,$bold(v)_3=mat(
// 1;1;0
// )$,$bold(v)_4=mat(
// 1;-1;0
// )$, then $bold(b)=mat(
// 0;0;1
// )$ is not in $"Span"{bold(v)_1,bold(v)_2,bold(v)_3,bold(v)_4}$ since
//  $
// mat(
// 1,0,1,1,0;
// 0,1,1,-1,0;
// 0,0,0,0,1
// )
//  $
// has pivot in the last row, and apply Theorem @thm:sol-pivot
// - The number of solutions could be none or infinitely many. There are in total 6 possible cases (apply Theorem @thm:sol-pivot)
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
// // \item
// $
// ,mat(
// *,*,*,*,0;
// *,*,*,*,0;
// *,*,*,*,0
// )=mat(
// A,bold(0)
// )tilde mat(
// U,bold(0)
// )
// $
// Since it doesn't have a pivot in the last column, it must have a solution (indeed at least the trivial solution) by Theorem @thm:sol-pivot, and since $A$ has more columns that rows, there must be a free variable, therefore it has infinitely many solutions
// // ]

#problem[
Answer the following questions
- Determine whether $bold(b)=mat(1;1;2)$ is in the span of ${bold(v)_1=mat(1;0;2),bold(v)_2=mat(2;2;6),bold(v)_3=mat(-1;-2;-4)}$, why?
- Assume $bold(w)=mat(1;0;2)$, $bold(v)_1=mat(1;1;0)$, $bold(v)_2=mat(1;4;-4)$, $bold(v)_3=mat(0;1;-1)$. Find constants $c_1,c_2$ such that $bold(w)=c_1bold(v)_1+c_2bold(v)_2+2bold(v)_3$. Show your work on how you found $c_1,c_2$.
- Suppose
 $
A=mat(
1   ,  3    , 0,     3;
-1   , -1  ,  -1 ,    1;
0    ,-4  ,   2   , -8;
2     ,0,     3   , -1
)
 $
Is it true that for any vector $bold(b)$ in $RR^4$, matrix equation $A bold(x)=bold(b)$ always has solution(s)? If it is, please give your reason. If it is not, please find one such $bold(b)$ and justify your answer.
]

// #solution[
// // - Consider
// $
// ,mat(
// bold(v)_1,bold(v)_2,bold(v)_3,bold(b)
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
// $
// By Theorem @thm:sol-pivot, $A bold(x)=bold(b)$ has no solution, i.e. $bold(b)$ is not in $"Span"{bold(v)_1,bold(v)_2,bold(v)_3}$.
// - It is equivalent to solving $c_1bold(v)_1+c_2bold(v)_2=bold(w)-2bold(v)_3=mat(
// 1;-2;4
// )$. So we should consider augmented matrix
// $
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
// $
// Hence $c_1=2$, $c_2=-1$.
// \item
// $
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
// $
// Which doesn't have pivot in the last row, so $A bold(x)=bold(b)$ doesn't always have a solution by Theorem @thm:matsol. To find one such $bold(b)$, you can just try (Since the range of the linear transformation $bold(x)|-> A bold(x)$ is the span of the columns of $A$ which is a hyperplane in $RR^4$, so choosing an arbitrary point is most likely not on that hyperplane, i.e. $A bold(x)=bold(b)$ not solvable!). Here we just try $bold(b)=mat(
// 0;0;1;0
// )$, then
// $
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
// $
// // ]

== Online Assignment 3

#problem[
Suppose $bold(v)_1,bold(v)_2,bold(v)_3$ are vectors in $RR^4$, if $\{bold(v)_1,bold(v)_2\}$ is linearly independent, $\{bold(v)_2,bold(v)_3\}$ is linearly independent, and $\{bold(v)_1,bold(v)_3\}$ is linearly independent, then $\{bold(v)_1,bold(v)_2,bold(v)_3\}$ is linearly independent
]

#solution[
False. For example ${bold(v)_1=mat(
1;0;0;0
),bold(v)_2=mat(
0;1;0;0
),bold(v)_3=mat(
1;1;0;0
)}$
]

#problem[
Suppose $A$ is a $m$ by $n$ matrix, and the matrix equation $A bold(x)=bold(b)$ always has solution for any vector $bold(b)$ in $RR^m$, the columns of $A$ are linearly independent
]

#solution[
False. There could be free variables
]

#problem[
Solve the linear system $ cases(
x_1+x_2+x_3+x_4=1,
2x_1-x_2+x_3-x_4=-1,
)$ and express its solution set in parametric vector form
]

// #solution[
// Write the augmented matrix
// $
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
// $
// So the solution set is
//  $
// \systeme*{x_1+ 2 / 3 x_3=0, x_2+ 1 / 3 x_3+x_4=1} => #cases(
// x_1=- 2 / 3 x_3;
// x_2=1- 1 / 3 x_3-x_4;
// x_3" is free";
// x_4" is free"
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

#problem[
Suppose $bold(v)_1=mat(
1;0;1
)$, $bold(v)_2=mat(
0;-1;1
)$, $bold(v)_3=mat(
-2;3;-11
)$, $bold(v)_4=mat(
0;0;-3
)$. Is $\{bold(v)_1,bold(v)_2,bold(v)_3,bold(v)_4\}$ linearly independent? If so, please give your reason, if not, please find a linear dependence (i.e. some linear combination $c_1bold(v)_1+c_2bold(v)_2+c_2bold(v)_3+c_4bold(v)_4=0$, $c_1,c_2,c_3,c_4$ not all zero)
]

// #solution[
// Consider
// $
// ,mat(
// bold(v)_1,bold(v)_2,bold(v)_3,bold(v)_4,bold(0)
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
// $
// So the solution set is
//  $
// #cases(
// x_1=-x_4;x_2=- 3 / 2 x_4;x_3=- 1 / 2 x_4;x_4" is free"
// )
//  $
// We can choose $x_4=-2$, then $x_1=2, x_2=3, x_3=1$ so that we know $2bold(v)_1+3bold(v)_2+bold(v)_3-2bold(v)_4=bold(0)$ is a linear dependence.
// ]

#problem[
Suppose linear transformation $T:RR^2->RR^2$ rotates the plane $RR^2$ counter-clockwise by $120^circle.small$, what is the standard matrix for the this linear transformation?
]

// #solution[
// the standard matrix for $T$ is
//  $
// A=mat(
// T(bold(e)_1),T(bold(e)_2)
// )=mat(
// - 1 / 2 ,-sqrt(3)/2;
// sqrt(3)/2,- 1 / 2
// )
//  $
// \begin{center}
// \begin{tikzpicture}[scale=2]
// \def\XMAX{1.5};\def\YMAX{1.5};
// \draw[help lines, color=gray!30, dashed] (-\XMAX,-\YMAX) grid (\XMAX,\YMAX);
// \draw[->, color=gray!80] (-\XMAX,0)--(\XMAX,0) node[right]{$x_1$};
// \draw[->, color=gray!80] (0,-\YMAX)--(0,\YMAX) node[above]{$x_2$};
// \draw[opacity=0.6, red, dashed] (0,0) circle (1);
// \coordinate (a) at (1,0); \node at (a)[below right]{$bold(e)_1$}; \draw[->, thick] (0,0)--(a);
// \coordinate (b) at (0,1); \node at (b)[above right]{$bold(e)_2$}; \draw[->, thick] (0,0)--(b);
// \coordinate (c) at ($cos(120)*(1,0)+sin(120)*(0,1)$); \node at (c)[above left]{\textcolor{purple}{$T(bold(e)_1)$}}; \draw[->, purple, thick] (0,0)--(c);
// \coordinate (d) at ($cos(210)*(1,0)+sin(210)*(0,1)$); \node at (d)[below left]{#text(fill:blue)[$T(bold(e)_2)$]}; \draw[->, blue, thick] (0,0)--(d);
// \draw[opacity=0.6, purple, dashed] (c)--($cos(120)*(1,0)$);
// \draw[opacity=0.6, purple, dashed] (c)--($sin(120)*(0,1)$);
// \draw[opacity=0.6, blue, dashed] (d)--($cos(210)*(1,0)$);
// \draw[opacity=0.6, blue, dashed] (d)--($sin(210)*(0,1)$);
// \end{tikzpicture}
// \end{center}
// ]

#problem[
Suppose $T:RR^n->RR^m$ is a linear transformation and $T(bold(x))=A bold(x)$, where $ A=mat(
1,2,3;
0,2,1
).$
What is $n$ and $m$? Find the preimage of $mat(
1;2
)$ under $T$. Is $T$ one-to-one? Is $T$ onto?
]

// #solution[
// $m=2$, $n=3$, the preimage of $bold(b)=mat(
// 1;2
// )$ under $T$ will be the solution to $A bold(x)=bold(b)$, so we have
// $
// ,mat(
// A,bold(b)
// )=mat(
// 1,2,3,1;
// 0,2,1,2
// )tilde mat(
// 1,0,2,-1;
// 0,1, 1 / 2 ,1
// )
// $
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

== Online Assignment 4

#problem[
Suppose $A=mat(
1,2,1;
2,1,2;
0,2,1;
)$.

- Determine if $A$ is invertible, if not, explain why, if it is, find the inverse matrix $A^(-1)$
- Find $A^T$, the transpose of $A$. Is $A^T$ invertible? If yes, please evaluate $(A^T)^(-1)$


Please show all your work.
]

// #solution[
//
// - $A$ is invertible
// $
// ,mat(
// 1,2,1,1,0,0;
// 2,1,2,0,1,0;
// 0,2,1,0,0,1
// ; augment:#(-1))xarrow(#`R2`-> #`R2`-2#`R1`)mat(
// 1,2,1,1,0,0;
// 0,-3,0,-2,1,0;
// 0,2,1,0,0,1
// ; augment:#(-1));
// ,xarrow(#`R2`/(-3))mat(
// 1,2,1,1,0,0;
// 0,1,0, 2 / 3 ,- 1 / 3 ,0;
// 0,2,1,0,0,1
// ; augment:#(-1))xarrow(#`R3`-> #`R3`-2#`R2`)mat(
// 1,2,1,1,0,0;
// 0,1,0, 2 / 3 ,- 1 / 3 ,0;
// 0,0,1,- 4 / 3 , 2 / 3 ,1
// ; augment:#(-1));
// ,xarrow(#`R3`-> #`R3`-2#`R2`-#`R3`)mat(
// 1,0,0,1,0,-1;
// 0,1,0, 2 / 3 ,- 1 / 3 ,0;
// 0,0,1,- 4 / 3 , 2 / 3 ,1
// ; augment:#(-1))
// $
// Hence $A^(-1)=mat(
// 1,0,-1;
//  2 / 3 ,- 1 / 3 ,0;
// - 4 / 3 , 2 / 3 ,1;
// )$
// - $A^T=mat(
// 1,2,0;
// 2,1,2;
// 1,2,1;
// )$, and $(A^T)^(-1)=(A^(-1))^T=mat(
// 1, 2 / 3 ,- 4 / 3 ;
// 0,- 1 / 3 , 2 / 3 ;
// -1,0,1;
// )$
//
// ]

#problem[
Suppose $A=mat(
- 1 / 2 ,-sqrt(3)/2;sqrt(3)/2,- 1 / 2
)$ is the standard matrix for the linear transformation of rotating $120^circle.small$ counter-clockwise. Evaluate $A^{24}$ and explain why.
]

// #solution[
// Note that $A^{24}$ is the standard matrix for the composition of linear transformations $\overbrace{T circle.small T circle.smalldots.h.ccircle.small T}^{24}$ which is rotate $24 times 120^circle.small=8 times  360^circle.small$, which is the same as rotate $0^circle.small$, so we should have $A^{24}=I$, the identity matrix.
// ]

#problem[
We say $n$ is the #text(fill:blue)[order]#index[order] of a square matrix $A$ if $n$ is the smallest positive integer such that $A^n=I$, where $I$ is the identity matrix. Suppose $T:RR^2->RR^2$ is the linear transformation of reflecting over $x_1$-axis, and $A$ is the standard matrix of $T$, the order of $A$ is
]

#solution[
Note that $T circle.small T$ is reflecting over $x_2$-axis twice, which amounts to doing nothing, so $A^2$ as the standard matrix of $T circle.small T$ is the identity matrix, i.e. the order of $A$ is 2.
]

#problem[
If $A,B$ are both invertible, then $A+B$ is also invertible
]

#solution[
False. For example we can take $B=-A=-I$, then $A+B=0$ which is not invertible.
]

#problem[
We call $q(x_1,x_2)=a x_1^2+2b x_1x_2+c x_2^2$ a #text(fill:blue)[quadratic form]#index[quadratic form], $a,b,c$ are constants. Suppose $bold(x)=mat(x_1;x_2)$, try to rewrite $q(x_1,x_2)$ as the form of a matrix multiplication $bold(x)^T A bold(x)$, where $A$ is a #text(fill:blue)[symmetric matrix]#index[symmetric matrix] (i.e. $A^T=A$). Please find $A$.
]

#solution[
We should choose $A=mat(
a,b;b,c
)$, then
 $
bold(x)^T A bold(x)=mat(
x_1,x_2
)mat(
a,b;b,c
)mat(
x_1;x_2
)=mat(
a x_1+b x_2,b x_1+c x_2
)mat(
x_1;x_2
)=a x_1^2+2b x_1x_2+c x_2^2=q(x_1,x_2)
 $
]

#problem[
Suppose $T:RR^3->RR^3$ is a linear transformation defined by $T(mat(x_1;x_2;x_3))=mat(x_1-2x_2+x_3;2x_2+3x_3;x_1-x_3)$. Please find $T^(-1)$, then standard matrix for $T^(-1)$. Is $T^(-1)$ onto? Is $T^(-1)$ is one-to-one? Show all your work.
]

// #solution[
// Note that $T(bold(x))=A bold(x)$, where $A=mat(
// 1,-2,1;
// 0,2,3;
// 1,0,-1
// )$, use the algorithm to find $A^(-1)$
// $
// ,mat(
// 1,-2,1,1,0,0;
// 0,2,3,0,1,0;
// 1,0,-1,0,0,1
// ; augment:#(-1))xarrow(#`R3`-> #`R3`-#`R1`)mat(
// 1,-2,1,1,0,0;
// 0,2,3,0,1,0;
// 0,2,-2,-1,0,1
// ; augment:#(-1));
// ,xarrow(#`R3`-> #`R3`-#`R2`)mat(
// 1,-2,1,1,0,0;
// 0,2,3,0,1,0;
// 0,0,-5,-1,-1,1
// ; augment:#(-1))xarrow( #`R2`/2 \ #`R3`/(-5) )mat(
// 1,-2,1,1,0,0;
// 0,1, 3 / 2 ,0, 1 / 2 ,0;
// 0,0,1, 1 / 5 , 1 / 5 ,- 1 / 5
// ; augment:#(-1));
// ,xarrow(#`R2`-> #`R2`- 3 / 2 #`R3`)mat(
// 1,-2,1,1,0,0;
// 0,1,0,- 3 / 10 , 1 / 5 , 3 / 10 ;
// 0,0,1, 1 / 5 , 1 / 5 ,- 1 / 5
// ; augment:#(-1))xarrow(#`R1`-> #`R1`+2#`R2`-#`R3`)mat(
// 1,-2,1, 1 / 5 , 1 / 5 , 4 / 5 ;
// 0,1,0,- 3 / 10 , 1 / 5 , 3 / 10 ;
// 0,0,1, 1 / 5 , 1 / 5 ,- 1 / 5
// ; augment:#(-1))
// $
// Hence $A^(-1)=mat(
//  1 / 5 , 1 / 5 , 4 / 5 ;
// - 3 / 10 , 1 / 5 , 3 / 10 ;
//  1 / 5 , 1 / 5 ,- 1 / 5
// )$, so we have $T^(-1)(mat(y_1;y_2;y_3))=mat(
//  1 / 5 y_1+ 1 / 5 y_2+ 4 / 5 y_3;
// - 3 / 10 y_1+ 1 / 5 y_2+ 3 / 10 y_3;
//  1 / 5 y_1+ 1 / 5 y_2- 1 / 5 y_3
// )$. $T^(-1)$ is both onto and one-to-one.
// ]

#problem[
An #text(fill:blue)[affine transformation]#index[affine transformation] is a mapping $T:RR^2->RR^2$ defined by $T(bold(x))=A bold(x)+bold(b)$, Note that $A bold(x)+bold(b)=mat(A,bold(b))mat(bold(x);1)$. If we use partitioned matrix and deploying the trick of ``adding" 1 at the end of the coordinates, then $T$ may be interpreted as a matrix transformation $mat(T(bold(x));1)=mat(A bold(x)+bold(b);1)=mat(A,bold(b);0,1)mat(bold(x);1)$

\item
Suppose $T_1(bold(x))=A_1bold(x)+bold(b)_1$ and $T_2(bold(x))=A_2bold(x)+bold(b)_2$ are both affine transformations. What is the composition $T_2circle.small T_1$? How should you deploy the trick?
- Suppose $T(bold(x))=A bold(x)+bold(b)$ is an affine transformation and $A$ is invertible. What is $T^(-1)$? How should you deploy the trick?

]

#solution[

- $(T_2circle.small T_1)(bold(x))=T_2(T_1(bold(x)))=A_2(T_1(bold(x)))+bold(b)_2=A_2(A_1bold(x)+bold(b)_1)+bold(b)_2=A_2A_1bold(x)+(A_2bold(b)_1+bold(b)_2)$, this can be explained use the trick as follows
 $
mat(A_2,bold(b)_2;0,1)mat(A_1,bold(b)_1;0,1)=mat(A_2A_1,A_2bold(b)_1+bold(b)_2;0,1)
 $
- The inverse should be $T^(-1)(bold(y))=A^(-1)bold(y)-A^(-1)bold(b)$, via the trick we can interpreted it as
 $
mat(A,bold(b);0,1)^(-1)=mat(A^(-1),-A^(-1)bold(b);0,1)
 $
Since
 $
mat(A^(-1),-A^(-1)bold(b);0,1)mat(A,bold(b);0,1)=mat(I,bold(0);0,1)=mat(A,bold(b);0,1)mat(A^(-1),-A^(-1)bold(b);0,1)
 $

]

== Online Assignment 5

#problem[
Suppose $A=mat(
1,2,2;
2,1,3;
-1,2,0
)$. Use cofactor expansion of $A$ across the last row to evaluate the determinant of $A$
]

#solution[
$
,| mat(
1,2,2;
2,1,3;
-1,2,0
 ) |=(-1) dot.c (-1)^{3+1}| mat(
2,2;
1,3
 ) |+2 dot.c (-1)^{3+2}| mat(
1,2;
2,3;
 ) |+0;
,=(-1)(2 dot.c 3-2 dot.c 1)+(-2)(1 dot.c 3-2 dot.c 2)=-2
$
]

#problem[
Compute the determinant of $A=mat(
1,2,2,-1;
0,2,0,0;
3,5,2,3;
2,1,0,-1
)$. Is $A$ invertible?
]

// #solution[
// $
// ,| mat(
// 1,2,2,-1;
// 0,2,0,0;
// 3,5,2,3;
// 2,1,0,-1
//  ) |xequal("cofactor expansion second row")2(-1)^{2+2}| mat(
// 1,2,-1;
// 3,2,3;
// 2,0,-1
//  ) |xequal( #`R2`-> #`R3`-3#`R1` \ #`R3`-> #`R3`-2#`R1` )2| mat(
// 1,2,-1;
// 0,-4,6;
// 0,-4,1
//  ) |;
// ,xequal(#`R3`-> #`R3`-#`R2`)2| mat(
// 1,2,-1;
// 0,-4,6;
// 0,0,-5
//  ) |=2 dot.c 1 dot.c (-4) dot.c (-5)=40
// $
// $A$ is invertible since $"det "A!=0$
// ]

#problem[
Consider the parallelgram $P$ with vertices $(-2,-3),(-1,1),(2,4),(3,8)$, use determinants to evaluate the area of $P$
]

#solution[
Name these four points $p_1,p_2,p_3,p_4$, and the vectors $bold(a)_1=mat(
1;4
)$ and $bold(a)_2=mat(
4;7
)$. And we consider $A=mat(
bold(a)_1,bold(a)_2
)=mat(
1,4;
4,7
)$, then area of $P$ would be
 $
|"det "A|=|(1 dot.c 7-4 dot.c 4))|=9
 $
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
]

#problem[
$"det"(A-B)="det "A-"det "B$
]

#solution[
This is false, for example, we could just take $A=I=mat(
1,0;0,1
)$, $B=-I$, then $4="det"(2I)="det"(A-B)!= "det "A-"det "B=1-1=0$
]

#problem[
If $A$ is a 3 by 3 matrix, then $"det"(2A)=8("det "A)$
]

#solution[
This is true.
]

#problem[
Suppose $A,B$ are both 3 by 3 matrices, and $"det "A=2$, $"det "B= 1 / 3 $, then the determinant of $A^T B^(-1)$ is
]

#solution[
$"det"(A^T B^(-1))="det"(A^T)"det"(B^(-1))=("det "A)("det "B)^(-1)=2 dot.c  3=6$.
]

#problem[
Suppose $A$ is a 3 by 3 matrix with entries integers, and $A^3=I$ is the identity matrix. Then the determinant of $A$ has to be
]

#solution[
$"det "A$ must be some real number. $1="det "I="det"(A^3)=("det "A)^3 =>  "det "A=sqrt[3]{1}=1$.
]

== Online Assignment 6

#problem[
Suppose $A=mat(
1,2,1,2,-1,3;
0,0,0,0,1,-1;
0,0,1,3,1,-2;
)$
- Find a basis for the null space of $A$
- Find a basis for the column space of $A$
- Find a basis for the row space of $A$
]

#solution[
First realize
 $
A xarrow(#`R2` arrow.l.r  #`R3`)mat(
1,2,1,2,-1,3;
0,0,1,3,1,-2;
0,0,0,0,1,-1;
)tilde mat(
1,2,0,-1,0,3;
0,0,1,3,0,-1;
0,0,0,0,1,-1;
)
 $
Hence the solution in parametric form is $x_2mat(
-2;1;0;0;0;0
)+x_4mat(
1;0;-3;1;0;0
)+x_6mat(
-3;0;1;0;1;1
)$. And the pivot columns are the 1st, 3rd and 5th columns
- A basis for $"Nul"A$ could be ${mat(
-2;1;0;0;0;0
),mat(
1;0;-3;1;0;0
),mat(
-3;0;1;0;1;1
)}$
- A basis for $"Col"A$ could be ${mat(
1;0;0
),mat(
1;0;1
),mat(
-1;1;1
)}$
- A basis for $"Row"A$ could be
 $
{mat(
1,2,0,-1,0,3
),mat(
0,0,1,3,0,-1
),mat(
0,0,0,0,1,-1
)}
 $
]

#problem[
Suppose $A=mat(
3,-1,-5;
1,1,-1;
-2,2,4;
)$
- Determine whether $bold(u)=mat(
-3;1;-2
)$ is in the null space of $A$. Explain your reasoning.
- Determine whether $bold(b)=mat(
1;-3;-4
)$ is in the column space of $A$. Explain your reasoning.
]

#solution[
- $bold(u) in "Nul"A$ since $A bold(u)=bold(0)$
- $bold(b) in "Col"A$ since linear system $A bold(x)=bold(b)$ is consistent
]

// #problem[
// Recall $PP_2=\{a_0+a_1t+a_2t^2|a_0,a_1,a_2 in RR\}$ is the set of polynomials of degree less or equal to 2. Let $V$ be the subset of $PP_2$ consists of polynomials that evalute to 0 at $t=1$ (i.e. polynomial $p(t)$ is in $V$ if $p(1)=0$ and of degree less or equal to 2). With the usual addition and scalar multiplication for polynomials
// \begin{enumerate}[label=\alph*)]
// - Show that $V$ is a subspace.
// - Find a basis of $V$.
// - Cosider $T:V->RR^2$ that maps polynomial $p(t)$ to $mat(
// p(-1);p(2)
// )$, show $T$ is a linear transformation
// // ]

// #solution[
// \begin{enumerate}[label=\alph*)]
// - Realize that $V="ker" S$ for the linear transformation $S:PP_2->RR$, $S(a_0+a_1t+a_2t^2)=a_0+a_1+a_2$, thus $V$ is a subspace of $PP_2$
// - This is precisely Example @(10:24-07/01/2022)
// - For any $p(t),q(t) in  V$ and $c in RR$, we have
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
// T(c p)=mat(
// (c p)(-1);(c p)(2)
// )=mat(
// c dot.c  p(-1);c dot.c  p(2)
// )=cmat(
// p(-1);p(2)
// )=c T(p)
//  $
// Therefore $T:V->RR^2$ is a linear transformation
// // ]

#problem[
We say a square matrix $A$ is #text(fill:blue)[anti-symmetric]#index[anti-symmetric] if $A^T=-A$. Denote the set of $3 times 3$ anti-symmetric matrices $V$.
- Show that $V$ is a vector space.
- What is the dimension of $V$?
- Find a basis of $V$.
- Show that
 $
cal(B)={B_1=mat(
0,-1,-1;
1,0,-1;
1,1,0;
),B_2=mat(
0,2,0;
-2,0,-1;
0,1,0;
),B_3=mat(
0,-1,-2;
1,0,-3;
2,3,0;
)}
 $
form a basis for $V$.
]

// #solution[
// \begin{enumerate}[label=\alph*)]
// - For any $A,B in  V$ and $c in RR$, by definition $A^T=-A, B^T=-B$, so
//  $
// (A+B)^T=A^T+B^T=-A-B=-(A+B)
//  $
//  $
// (c a)^T=c a^T=c(-A)=-(c a)
//  $
// hence $A+B,c a in  V$, i.e. $V$ is a closed under addition and scalar multiplication. Therefore $V$ is a subspace of $M_{3 times 2}(RR)$, and consequently a vector space.
// - It is not hard to realize
//  $
// V={mat(
// 0,-a,-b;
// a,0,-c;
// b,c,0
// ) in \ M_{3 times 3}(RR) mid(|)a,b,c in RR} 	tilde.equiv RR^3
//  $
// Thus $"dim" V=3$
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
// cal(E)=\{E_1,E_2,E_3\}=
// {
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
// )}
//  $
// is a basis for $V$, this is linearly independent since the linear combination \eqref{14:56-06/24/2022} is equal to zero $<=> a=b=c=0$
// - Check that the coordinate vectors $\{[B_1]_{cal(E)},[B_2]_{cal(E)},[B_3]_{cal(E)}\}={mat(
// 1;1;1
// ),mat(
// -2;0;1
// ),mat(
// 1;2;3
// )}$ form a basis for $RR^3$, so $cal(B)$ form a basis for $V$.
// // ]

== Online Assignment 7

#problem[
Suppose $bold(v)$ is an eigenvector for matrices $A$ and $B$, then $bold(v)$ is an eigenvector for $A+B$ and $A B$.
]

#solution[
This is true. Since $bold(v)$ is an eigenvector for both $A$ and $B$, there exist eigenvalues $ lambda _1, lambda _2$ such that $A bold(v)= lambda _1bold(v)$, $B bold(v)= lambda _2bold(v)$, so we have $(A+B)bold(v)=A bold(v)+B bold(v)= lambda _1bold(v)+ lambda _2bold(v)=( lambda _1+ lambda _2)bold(v)$. In other words, $bold(v)$ is an eigenvector for $A+B$ with eigenvalue $ lambda _1+ lambda _2$. Similarly, we also have $A B bold(v)=A( lambda _1bold(v)_1)= lambda _2 A bold(v)= lambda _1 lambda _2bold(v)$. In other words, $bold(v)$ is an eigenvector for $A B$ with eigenvector $ lambda _1 lambda _2$
]

#problem[
Suppose $t+3t^2-2t^3$ is the characteristic polynomial of a 3 by 3 matrix, then $A$ is not invertible.
]

#solution[
This is true. Note that $t=0$ is a root of the characteristic polynomial, so the null space of $A$ is not trivial, $A$ is not invertible.
]

#problem[
// Suppose $cal(B)= 1+t,1+2t^2,1-t+t^2$ and $cal(C)= 1-t,t,t^2$ are two bases for $PP_2$, What is the change of basis matrix $\underset{cal(C)\leftarrowcal(B)}{P}$ from $cal(B)$ to $cal(C)$. Please show all your work.
]

// #solution[
// First let's find the change of basis matrices from $cal(B)$ and $cal(C)$ to the standard basis $cal(E)=\{1,t,t^2\}$. We have
//  $
// \underset{cal(E)\leftarrowcal(B)}{P}=mat(
// [1+t)_{cal(E)},[1+2t^2]_{cal(E)},[1-t+t^2]_{cal(E)}
// ]=mat(
// 1,1,1;
// 1,0,-1;
// 0,2,1
// )
//  $
// And
//  $
// \underset{cal(E)\leftarrowcal(C)}{P}=mat(
// [1-t)_{cal(E)},[t]_{cal(E)},[t^2]_{cal(E)}
// ]=mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )
//  $
// Hence we have
// $
// \underset{cal(C)\leftarrowcal(B)}{P}=(\underset{cal(C)\leftarrowcal(E)}{P})(\underset{cal(E)\leftarrowcal(B)}{P})=(\underset{cal(E)\leftarrowcal(C)}{P})^(-1)(\underset{cal(E)\leftarrowcal(B)}{P})=mat(
// 1,0,0;
// -1,1,0;
// 0,0,1
// )^(-1)mat(
// 1,1,1;
// 1,0,-1;
// 0,2,1
// )=mat(
// 1       ,       1  ,            1       ;
// 2        ,      1 ,             0       ;
// 0         ,     2,              1
// )
// $
// ]

#problem[
If $"Nul"A$ is 2-dimensional, then $0$ is an eigenvalue of $A$.
]

#solution[
This is true. Since if $"Nul"A$ is 2-dimensional, then $"Nul"A$ is non-trivial, thus $0$ is an eigenvalue of $A$
]

#problem[
Is $mat(0;0;1)$ an eigenvector of $mat(2,0,0;3,2,0;0,4,3)$? If so, find the corresponding eigenvalue, if not, please explain why.
]

#solution[
Note that $mat(2,0,0;3,2,0;0,4,3)mat(0;0;1)=mat(0;0;3)$. so $mat(0;0;1)$ is an eigenvector with eigenvalue 3
]

#problem[
Find all eigenvalues of $A=mat(6,-2,0;-2,9,0;5,8,3)$. Please show all your work.
]

#solution[
// $
// |t I-A|,=| mat(
// t-6,2,0;
// 2,t-9,0;
// -5,-8,t-3
//  ) |xequal("cofator expansion across 3rd column")(t-3)(-1)^{3+3}| mat(
// t-6,2;
// 2,t-9
//  ) |;
// ,=(t-3)((t-6)(t-9)-2 dot.c  2)=(t-3)(t^2-5t+50)=(t-3)(t-5)(t-10)
// $
Therefore eigenvalues for $A$ are 3,5,10.
]

#problem[
Assume that $A$ is similar to an upper triangular matrix $U$, then $"det "A$ is the product of all its eigenvalues (counting multiplicity). Please explain why.
]

// #solution[
// Suppose the diagonal elements of $A$ are $ lambda _1,dots.h.c, lambda_n$, then the charateristic polynomial of $A$ is the same the charateristic polynomial $U$ (Since they are similar) which would be $(t- lambda _1)dots.h.c(t- lambda_n)$, so $ lambda _1,dots.h.c, lambda_n$ are the eigenvalues for $A$. And the determinant of $A$ is the same as the determinant of $U$ (Since they are similar) which is $ lambda _1dots.h.c lambda_n$
// ]

== Online Assignment 8

#problem[
Suppose $A=mat(
2,2,1;
1,3,1;
1,2,2
)$, determine whether $A$ is diagonalizable. If it is, please find a diagonalization. If not, please explain why.
]

// #solution[
// First we evaluate the characteristic polynomial of $A$
// $
// "det"(tI-A),=| mat(
// t-2,-2,-1;
// -1,t-3,-1;
// -1,-2,t-2
//  ) |xequal( #`R1`-> #`R1`+(t-2)#`R3` \ #`R2`-> #`R2`-#`R3` )| mat(
// 0,-2(t-1),(t-1)(t-3);
// 0,t-1,-(t-1);
// -1,-2,t-2
//  ) |;
// ,xequal("factor out $(t-1)$ on row 1 and row 2")(t-1)^2| mat(
// 0,-2,(t-3);
// 0,1,-1;
// -1,-2,t-2
//  ) |=(t-1)^2(t-5)
// $
// So the eigenvalues are $ lambda _1= lambda _2=1$, $ lambda _3=5$. For the 1-eigenspace, we consider
// $
// mat(
// I-A,bold(0)
// ; augment:#(-1)),=
// mat(
// -1,-2,-1,0;
// -1,-2,-1,0;
// -1,-2,-1,0
// ; augment:#(-1))tilde mat(
// 1,2,1,0;
// 0,0,0,0;
// 0,0,0,0
// ; augment:#(-1))
// $
// So we get two basis vectors ${bold(v)_1=mat(
// -2;1;0
// ),bold(v)_2=mat(
// -1;0;1
// )}$. For the 5-eigenspace, we consider
// $
// mat(
// 5I-A,bold(0)
// ; augment:#(-1)),=
// mat(
// 3,-2,-1,0;
// -1,2,-1,0;
// -1,-2,3,0
// ; augment:#(-1))tilde mat(
// 1,0,-1,0;
// 0,1,-1,0;
// 0,0,0,0
// ; augment:#(-1))
// $
// So we get a basis vector ${bold(v)_3=mat(
// 1;1;1
// )}$
// - From above, we get the diagonalization
//  $
// A=P D P^(-1)=mat(
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

#problem[
Suppose $A=mat(
-6,8;
-4,6
)$, Please evaluate $A^{101}$, show all your work.
]

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
// A^{101}=PD^{101}P^(-1)=mat(
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

#problem[
Suppose $T:RR^3->RR^3$ is a linear transformation, $cal(B)=\{bold(b)_1,bold(b)_2,bold(b)_3\}$, $cal(C)=\{bold(c)_1,bold(c)_2,bold(c)_3\}$ are two different bases for $RR^3$. Determine whether the following is possible.
- $[T]_{cal(B)}=mat(
1 ,2,4;
3 ,-1 ,-2;
2 ,-1, 3
)$ and $[T]_{cal(C)}=mat(
1, -3 ,1;
2 ,1, 6;
0 ,3 ,8
)$
- $[T]_{cal(B)}=mat(
3,0,0;
2,2,0;
2,3,4
)$ and $[T]_{cal(C)}=mat(
1,-1,0;
2,4,0;
3,-2,4
)$
]

// #solution[
// \begin{enumerate}[label=\alph*)]
// - This is not possible since these two matrices have different determinant.
// - This is possible since these two matrix has the same the characteristic polynomial $(t-2)(t-3)(t-4)$, hence they are similar to same diagonal matrix, and thus similar.
// // ]

#problem[
Suppose $A$ is similar to $B$.
- Could you conclude that $3A$ is similar to $3B$. If you can, please give your reasons, if not, please find a counter-example.
- Could you conclude that $A^(-1)$ is similar to $B^(-1)$. If you can, please give your reasons, if not, please find a counter-example.
]

#solution[
Since $A$ is similar to $B$, we may assume $A=P B P^(-1)$.
- $3A=3P B P^(-1)=P(3B)P^(-1)$ is similar.
- $A^(-1)=(P B P^(-1))^(-1)=P B^(-1)P^(-1)$ is similar.
]

== Online Assignment 9

#problem[
Determine whether the following statements are true
- $|bold(u)|^2+|bold(v)|^2=|bold(u)+bold(v)|^2$ if and only if $bold(u),bold(v)$ are orthogonal.
- If $W$ is a subspace of $RR^n$, and vector $bold(v)$ is orthogonal to both $W$ and $W^perp$, then $bold(v)=bold(0)$.
- If $W = "Span"{bold(x)_1, bold(x)_2 ,bold(x)_3}$ with $\{bold(x)_1, bold(x)_2 ,bold(x)_3\}$ linearly independent, and if $\{bold(v)_1, bold(v)_2 ,bold(v)_3\}$ is an orthogonal set in $W$, then $\{bold(v)_1, bold(v)_2 ,bold(v)_3\}$ is a basis for $W$.
]

// #solution[
// \begin{enumerate}[label=\alph*)]
// - This is true. $|bold(u)+bold(v)|^2=(bold(u)+bold(v)) dot.c (bold(u)+bold(v))=bold(u) dot.c bold(u)+2bold(u) dot.c bold(v)+bold(v) dot.c bold(v)=|bold(u)|^2+|bold(v)|^2+2bold(u) dot.c bold(v)$. Thus the equality holds $<=>bold(u) dot.c bold(v)=0$, i.e. $bold(u),bold(v)$ are orthogonal.
// - Consider $bold(v) dot.c bold(v)=|bold(v)|^2$, it should be 0 since $bold(v)$ is in both $W$ and $W^perp$, so $bold(v)=bold(0)$
// - This is true by Theorem @(01:12-07/15/2022)
// // ]

#problem[
Suppose $A=mat(
1,2,3;
2,1,-1;
0,2,4;
3,5,-1
)$, please find a basis for $("Col"A)^perp$.
]

// #solution[
// Recall that $("Col"A)^perp="Nul "(A^T)$. And we can find a basis for $"Nul "(A^T)$ through
//  $
// mat(
// A^T,bold(0)
// ; augment:#(-1))=mat(
// 1,2,0,3,0;
// 2,1,2,5,0;
// 3,-1,4,1,0
// ; augment:#(-1))tilde mat(
// 1,0,0,-13,0;
// 0,1,0,8,0;
// 0,0,1, 23 / 2 ,0
// ; augment:#(-1))
//  $
// Thus
//  $
// ("Col"A)^perp="Span"{mat(
// 13;-8;- 23 / 2 ;1
// )}
//  $
// ]

#problem[
Suppose we have $cal(B)= bold(u)_1=mat(1;1;0;-1),bold(u)_2=mat(1;0;1;1),bold(u)_3=mat(0;-1;1;-1)$, please justify that $cal(B)$ is an orthogonal set, suppose $bold(y)=mat(1;2;3;4)$, $L$ is the subspace spanned by $cal(B)$, compute the projection $"Proj"_L bold(y)$ of $bold(y)$ onto $L$.
]

// #solution[
// Let $A=mat(
// bold(u)_1,bold(u)_2,bold(u)_3
// )=mat(
// 1,1,0;
// 1,0,-1;
// 0,1,1;
// -1,1,-1
// )$, we can check that $A^T A=I$ is the 3 by 3 identity matrix, so $cal(B)$ is an orthogonal set. And therefore
// $
// "Proj"_L bold(y),= bold(y) dot.c bold(u)_1 / bold(u)_1 dot.c bold(u)_1 bold(u)_1+ bold(y) dot.c bold(u)_2 / bold(u)_2 dot.c bold(u)_2 bold(u)_2+ bold(y) dot.c bold(u)_3 / bold(u)_3 dot.c bold(u)_3 bold(u)_3;
// ,= -1 / 3 bold(u)_1+ 8 / 3 bold(u)_2+ -3 / 3 bold(u)_3;
// ,=- 1 / 3 mat(
// 1;1;0;-1
// )+ 8 / 3 mat(
// 1;0;1;1
// )-mat(
// 0;-1;1;-1
// )=mat(
//  7 / 3 ; 2 / 3 ; 5 / 3 ;4
// )
// $
// ]

#problem[
Suppose $A=mat(
-1,6,6;
3,-8,3;
1,-2,6;
1,-4,-3
)$, please find an orthogonal basis for $"Col"A$.
]

// #solution[
// We apply the Gram-Schmidt process here
//
// - $bold(u)_1=bold(v)_1=mat(
// -1;3;1;1
// )$
// - $bold(u)_2=bold(v)_2-\dfrac{bold(v)_2 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1=mat(
// 6;-8;-2;-4
// )- -36 / 12 mat(
// -1;3;1;1
// )=mat(
// 3;1;1;-1
// )$
// - $bold(u)_3=bold(v)_3-\dfrac{bold(v)_3 dot.c bold(u)_1}{bold(u)_1 dot.c bold(u)_1}bold(u)_1-\dfrac{bold(v)_3 dot.c bold(u)_2}{bold(u)_2 dot.c bold(u)_2}bold(u)_2=mat(
// 6;3;6;-3
// )- 6 / 12 mat(
// -1;3;1;1
// )- 30 / 12 mat(
// 3;1;1;-1
// )=mat(
// -1;-1;3;-1
// )$
//
// So we have an orthogonal basis for $"Col"A$
//  $
// "Col"A="Span"{mat(
// -1;3;1;1
// ),mat(
// 3;1;1;-1
// ),mat(
// -1;-1;3;-1
// )}
//  $
// ]

== Online Assignment 10

#problem[
Determine whether the following statements are correct
- If $A$ is symmetric and if vectors $bold(u)$ and $bold(v)$ such that $A bold(u) = bold(u)$ and $bold(v)$ is in $"Nul"A$, then $bold(u)  dot.c bold(v) = bold(0)$.
- $"Nul"A="Nul"A^T A$.
]

#solution[
- The eigenvalues for eigenvectors $bold(u)$ and $bold(v)$ are 1 and 0, and $A$ is symmetric, by Theorem @thm:symmat-eigenvec-ortho, $bold(u) dot.c bold(v)=0$.
- If $bold(x) in "Nul"A$, then $A bold(x)=bold(0)$, so $A^T A bold(x)=bold(0)$. If $bold(x) in "Nul "(A^T A)$, then $A^T A bold(x)=bold(0)$, so $0=bold(x)^T A^T A bold(x)=|A bold(x)|^2$, so $A bold(x)=0$.
]

#problem[
Find the least-squares solution(s) to $mat(
1,5;
3,1;
-2,4
)mat(
x_1;x_2
)=mat(
4;-2;-3
)$.
]

#solution[
Let's denote $A=mat(
1,5;
3,1;
-2,
)$, $bold(b)=mat(
4;-2;-3
)$, then $A^T A=mat(
14,0;
0,42
)$, and $A^T bold(b)=mat(
4;6
)$, then we get the least -square solution $\hat{bold(x)}=(A^T A)^(-1)A^T bold(b)=mat(
 2 / 7 ; 1 / 7
)$
]

#problem[
Orthogonal diagonalize the matrix $mat(
3,4;
4,9
)$.
]

// #solution[
// First note that $A=mat(
// 3,4;
// 4,9
// )$ is symmetric and real-valued, we can get its eigenvalues $ lambda _1=1$, $ lambda _2=11$, and normalized eigenvectors $bold(u)_1=mat(
// - 2 / sqrt(5) ; 1 / sqrt(5)
// )$, $bold(u)_2=mat(
//  1 / sqrt(5) ; 2 / sqrt(5)
// )$. Hence we have the orthogonal diganolization
//  $
// A=mat(
// 3,4;
// 4,9
// )=mat(
// - 2 / sqrt(5) , 1 / sqrt(5) ;
//  1 / sqrt(5) , 2 / sqrt(5)
// )mat(
// 1,0;0,11
// )mat(
// - 2 / sqrt(5) , 1 / sqrt(5) ;
//  1 / sqrt(5) , 2 / sqrt(5)
// )=P D P^T
//  $
// ]

#problem[
Suppose $A=mat(
1,5;
-2,3
)$.
- Please find the eigenvalues of $A$.
- Please find the eigenvectors of $A$.
- Please write $A$ as matrix multiplication $P C P^(-1)$, where $C$ is of the form $mat(
a,-b;
b,c
)$.
]

// #solution[
// \begin{enumerate}[label=\alph*)]
// - The characteristic polynomial is $t^2-4t+13$, and so the eigenvalues are $ lambda =2-3i$, $#overline[lambda] =2+3i$, so we have $a=2$, $b=3$ and $C=mat(
// 2,-3;3,2
// )$
// - The eigenvalues for $ lambda ,\overline{ lambda }$ are $bold(v)=mat(
// 1+3i;2
// )=mat(
// 1;2
// )+i mat(
// 3;0
// )$, $#overline[bold(v)]=mat(
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
// )=P C P^(-1)
//  $
// // ]

= Exams

== Exam 1

#problem[
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(15 pt)} Write linear system
//  $
// cases(2x_1+4x_2+2x_3=2, x_1+3x_2-x_3+2x_4=1, -x_1+2x_2+3x_3+2x_4=-1)
//  $
// as a matrix equation, and then solve it, write your solution in parametric vector form.
// \item\textbf{(5 pt)} Is ${bold(a)_1=mat(
// 2;1;-1
// ),bold(a)_2=mat(
// 4;3;2
// ),bold(a)_3=mat(
// 2;-1;3
// ),bold(a)_4=mat(
// 0;2;2
// )}$ linearly independent? Why or why not.
// \item\textbf{(4 pt)} What is the span of $\{bold(a)_1,bold(a)_2,bold(a)_3,bold(a)_4\}$
]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - We could rewrite the linear system as
//  $
// A bold(x)=mat(
// 2,4,2,0;
// 1,3,-1,2;
// -1,2,3,2
// )mat(
// x_1;x_2;x_3;x_4
// )=mat(
// 2;1;-1
// )=bold(b)
//  $
// $
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
// $
// So the solution is
//  $
// #cases(
// x_1=1+ 3 / 2 x_4;
// x_2=-x_4;
// x_3= 1 / 2 x_4;
// x_4" is free"
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
// bold(a)_1,bold(a)_2,bold(a)_3,bold(a)_4
// )$ has RREF $mat(
// 1,0,0,- 3 / 2 ;
// 0,1,0,1;
// 0,0,1,- 1 / 2
// )$. Since the fourth each column is not a pivot column, $\{bold(a)_1,bold(a)_2,bold(a)_3,bold(a)_4\}$ is linearly dependent.
// - Since the RREF $A$ has a pivot in each row, the columns of $A$ (i.e. $\{bold(a)_1,bold(a)_2,bold(a)_3,bold(a)_4\}$) span $RR^3$
// // ]

// #problem[
// Suppose $T:RR^3->RR^3$ is a linear transformation defined by $T(mat(
// x_1;x_2;x_3
// ))=mat(
// x_1+2x_2+3x_3;2x_1+5x_3;2x_1+3x_2+6x_3
// )$. Denote the standard matrix for $T$ as $A$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(3 pt)} Evaluate $A$.
// \item\textbf{(4 pt)} Is $T$ is onto? Is $T$ one-to-one?
// \item\textbf{(17 pt)} Is $T$ is invertible? If so, what is the standard matrix for $T^(-1)$?
// \item\textbf{(15 pt)} Find $A^T$ ,$(A^T)^(-1)$.
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The standard matrix for $T$ is $A=mat(
// 1,2,3;
// 2,0,5;
// 2,3,6
// )$
// - $T$ is onto and one-to-to.
// - $T$ is invertible. And the standard matrix of $T^(-1)$ is $A^(-1)$
// $
// ,mat(
// A,I
// ; augment:#(-1))=mat(
// 1,2,3,1,0,0;
// 2,0,5,0,1,0;
// 2,3,6,0,0,1
// ; augment:#(-1))xarrow( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-2#`R1` )mat(
// 1,2,3,1,0,0;
// 0,-4,-1,-2,1,0;
// 0,-1,0,-2,0,1
// ; augment:#(-1));
// ,xarrow( #`R2`-> #`R2`-4#`R3` \ #`R1`-> #`R1`+2#`R3` )mat(
// 1,0,3,-3,0,2;
// 0,0,-1,6,1,-4;
// 0,-1,0,-2,0,1
// ; augment:#(-1))xarrow( #`R2`->(-1)#`R2` \ #`R3`->(-1)#`R3` )mat(
// 1,0,3,-3,0,2;
// 0,0,1,-6,-1,4;
// 0,1,0,2,0,-1
// ; augment:#(-1));
// ,xarrow(#`R2` arrow.l.r  #`R3`)mat(
// 1,0,3,-3,0,2;
// 0,1,0,2,0,-1;
// 0,0,1,-6,-1,4
// ; augment:#(-1))xarrow(#`R1`-> #`R1`-2#`R3`)mat(
// 1,0,0,15,3,-10;
// 0,1,0,2,0,-1;
// 0,0,1,-6,-1,4
// ; augment:#(-1));
// ,=mat(
// I,A^(-1)
// ; augment:#(-1))
// $
// Hence $A^(-1)=mat(
// 15,3,-10;
// 2,0,-1;
// -6,-1,4
// )$
// - $A^T=mat(
// 1,2,2;
// 2,0,3;
// 3,5,6
// )$, $(A^T)^(-1)=(A^(-1))^T=mat(
// 15,2,-6;
// 3,0,-1;
// -10,-1,4
// )$
// // ]

// #problem[
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(5 pt)} Suppose $A=mat(
// 1,0,0,0,0,8;
// 0,0,h,0,k,-4;
// 0,0,0,0,1,0
// )$ is of reduced row echelon form (RREF), could we know what $h,k$ are? If not, please explain why, if so, please give their values.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $T:RR^3->RR^3$ is a one-to-one linear transformation, then it is also onto.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $A$ is a 3 by 3 matrix and $A^5$ is invertible, then so is $A$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $A$ is a 5 by 3 matrix, then $A bold(x)=bold(b)$ cannot have non-trivial solution(s)
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - $h=1$, $k=0$. Since $h$ has be in a pivot position, and $k$ is in a pivot column.
// - \texttt{TRUE}. Since its standard matrix would have a pivot in each column, that is three pivots, so there must be a pivot in each row also, hence $T$ is also onto.
// - \texttt{TRUE}. Since $A^5$ is invertible, we may assume its inverse is $B=(A^5)^(-1)$, so that $A^5B=BA^5=I$. Let's show $A^(-1)=A^4B$, first we note that
//  $
// A^4B=IA^4B=(BA^5)A^4B=BA^9B=BA^4(A^5B)=BA^4I=BA^4
//  $
// then
//  $
// A A^(-1)=A(A^4B)=A^5B=I
//  $
//  $
// A^(-1)A=(A^4B)A=(BA^4)A=BA^5=I
//  $
// Alternatively, we could consider its determinant $0!="det"(A^5)=("det "A)^5 => "det "A!=0$, hence $A$ is invertible.
// - \texttt{FALSE}. Take $A$ to be $mat(
// 1,1,1;
// 0,0,0;
// 0,0,0;
// 0,0,0;
// 0,0,0;
// )$, and $bold(b)=bold(0)$, and the linear system have two free variables.
// // ]

// #problem[
// Suppose $T_1$, $T_2$, $T_3$ and $T$ are all linear transformations from the $xy$-plane to itself.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} $T_1$ takes a vector and rotates it \textbf{clockwise} around the origin through an angle $45^circle.small$. Writes down its standard matrix $A_1$.
// \item\textbf{(6 pt)} $T_2$ reflects over the $x$-axis. Writes down its standard matrix $A_2$.
// \item\textbf{(6 pt)} $T_3$ switches $x,y$ coordinates. Writes down its standard matrix $A_3$.
// \item\textbf{(6 pt)} Suppose $T$ is such that $T(bold(x))=T_3(T_2(T_1(bold(x))))$. What the standard matrix of $T$?
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The standard matrix $A_1=mat(
//  cos (-45^circle.small), cos (45^circle.small); sin (-45^circle.small), sin (45^circle.small)
// )=mat(
//  (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2)) ;- (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2))
// )$
// - The standard matrix $A_2=mat(
// 1,0;0,-1
// )$
// - The standard matrix $A_3=mat(
// 0,1;1,0
// )$
// - The standard matrix
// $
// A,=A_3A_2A_1=mat(
// 0,1;1,0
// )mat(
// 1,0;0,-1
// )mat(
//  (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2)) ;- (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2))
// );
// ,=mat(
// 0,-1;1,0
// )mat(
//  (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2)) ;- (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2))
// );
// ,=mat(
//  (sqrt(2)) / (sqrt(2)) ,- (sqrt(2)) / (sqrt(2)) ; (sqrt(2)) / (sqrt(2)) , (sqrt(2)) / (sqrt(2))
// )
// $
// // ]

// % #problem[
// % Suppose $A=mat(
// % 1,0,3,0;
// % 2,0,6,1;
// % 2,1,2,-4;
// % 3,0,2,1
// % )$.
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item\textbf{(16 pt)} Evaluate $"det "A$.
// % \item\textbf{(3 pt)} Is $A$ invertible?
// % \item\textbf{(4 pt)} What is $"det"(-2A)$?
// % // % ]

// % #solution[
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item
// % $
// % ,| mat(
// % 1,0,3,0;
// % 2,0,6,1;
// % 2,1,2,-4;
// % 3,0,2,1
// %  ) |xequal("cofactor expansion across second column")1(-1)^{3+2}| mat(
// % 1,3,0;
// % 2,6,1;
// % 3,2,1
// %  ) |;
// % ,xequal( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-3#`R1` )(-1)| mat(
// % 1,3,0;
// % 0,0,1;
// % 0,-7,1
// %  ) |xequal(#`R2` arrow.l.r  #`R3`)(-1)(-1)| mat(
// % 1,3,0;
// % 0,-7,1;
// % 0,0,1;
// %  ) |=(-1)(-1)1(-7)1=-7
// % $
// % - $A$ is invertible since $"det "A=-7!= 0$
// % - Since $A$ is a 4 by 4 matrix, $"det"(-2A)=(-2)^4"det "A=16 dot.c (-7)=-112$
// % // % ]

== Exam 2

// #problem[
// Suppose $A=mat(
// 1 , -1, 5, 1 ,6 ,0;
// 2 ,0, 3 ,5, 3, 6;
// 0 ,1 ,-4 ,2 ,-1 ,2;
// 3 ,-2 ,12 ,4, 10 ,4
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} Please find a basis for $"Col"A$.
// \item\textbf{(6 pt)} Please find a basis for $"Row"A$.
// \item\textbf{(6 pt)} Please find a basis for $"Nul"A$.
// \item\textbf{(6 pt)} What is $"dim""Nul"A^T$?
// // ]

// #solution[
// First note that
//  $
// A tilde mat(
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
// - A basis for $"Col"A$ could be ${mat(
// 1;2;0;3
// ),mat(
// -1;0;1;-2
// ),mat(
// 5;3; -4; 12
// )}$
// - A basis for $"Row"A$ could be
//  $
// {mat(
// 1,-1,5,1,6,0
// ),mat(
// 0,1,-4,2,-1,2
// ),mat(
// 0,0,1,-1,-7,2
// )}
//  $
// - A basis for $"Nul"A$ could be ${mat(
// -4;2;1;1;0;0
// ),mat(
// -12;29;7;0;1;0
// ),mat(
// 0;-10;-2;0;0;1
// )}$
// - By the rank nullity theorem. we have $"dim""Nul"A^T=4-\rank A^T=4-\rank A=4-3=1$
// // ]

// % #problem[
// % Suppose $A=mat(
// % 4, 2,-2;
// % 4,2,4;
// % -1,1,5
// % )$.
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item\textbf{(15 pt)} Find all eigenvalues and corresponding eigenvectors
// % \item\textbf{(8 pt)} Diagonalize $A$.
// % \item\textbf{(8 pt)} Evaluate $A^{77}$.
// % // % ]

// % #solution[
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % - First we evaluate the characteristic polynomial of $A$
// % $
// % "det"(tI-A),=| mat(
// % t-4,-2,2;
// % -4,t-2,-4;
// % 1,-1,t-5
// %  ) |xequal( #`R1`-> #`R1`-(t-4)#`R3` \ #`R2`-> #`R2`+4#`R3` )| mat(
// % 0,t-6,-t^2+9t-18;
// % 0,t-6,4t-24;
// % 1,-1,t-5
// %  ) |;
// % ,xequal(#`R1`-> #`R1`-#`R2`)| mat(
// % 0,0,-t^2+5t+6;
// % 0,t-6,4t-24;
// % 1,-1,t-5
// %  ) |=(t-6)^2(t+1)
// % $
// % So the eigenvalues are $ lambda _1= lambda _2=6$, $ lambda _3=-1$. For the 6-eigenspace, we consider
// % $
// % mat(
// % 6I-A,bold(0)
// % ; augment:#(-1)),=
// % mat(
// % 2,-2,2,0;
// % -4,4,-4,0;
// % 1,-1,1,0
// % ; augment:#(-1))tilde mat(
// % 1,-1,1,0;
// % 0,0,0,0;
// % 0,0,0,0
// % ; augment:#(-1))
// % $
// % So we get two basis vectors ${bold(v)_1=mat(
// % 1;1;0
// % ),bold(v)_2=mat(
// % -1;0;1
// % )}$. For the $(-1)$-eigenspace, we consider
// % $
// % mat(
// % -I-A,bold(0)
// % ; augment:#(-1)),=
// % mat(
// % -5,-2,2,0;
// % -4,-3,-4,0;
// % 1,-1,-6,0
// % ; augment:#(-1))tilde mat(
// % 1,0,-2,0;
// % 0,1,4,0;
// % 0,0,0,0
// % ; augment:#(-1))
// % $
// % So we get a basis vector ${bold(v)_3=mat(
// % 2;-4;1
// % )}$
// % - From above, we get the diagonalization
// %  $
// % A=P D P^(-1)=mat(
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
// % A^{77}=PD^{77}P^(-1)=mat(
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
// % // % ]

// #problem[
// Suppose $A=mat(
// 1,0,3,0;
// 2,0,6,1;
// 2,1,2,-4;
// 3,0,2,1
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(8 pt)} Write down the cofactor expansion along a row or a column of your own choice. (No simplification needed)
// \item\textbf{(10 pt)} Evaluate $"det "A$.
// \item\textbf{(4 pt)} Is $A$ invertible? If so, evaluate $"det"(A^(-1))$, if not, explain why.
// \item\textbf{(4 pt)} What is $"det"(-2A)$?
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - We choose second for the cofactor expansion.
// $
// "det "A,=0C_(12)+0C_(22)+1C_(32)+0C_(42);
// ,=0(-1)^{1+2}"det "A_(1 2)+0(-1)^{2+2}"det "A_(2 2)+1(-1)^{3+2}"det "A_(3 2)+0(-1)^{4+2}"det "A_(42);
// ,=0(-1)^{1+2}| mat(
// 2,6,1;
// 2,2,-4;
// 3,2,1
//  ) |+0(-1)^{2+2}| mat(
// 1,3,0;
// 2,2,-4;
// 3,2,1
//  ) |+1(-1)^{3+2}| mat(
// 1,3,0;
// 2,6,1;
// 3,2,1
//  ) |+0(-1)^{4+2}| mat(
// 1,3,0;
// 2,6,1;
// 2,2,-4
//  ) |;
// ,=1(-1)^{3+2}| mat(
// 1,3,0;
// 2,6,1;
// 3,2,1
//  ) |=(-1)| mat(
// 1,3,0;
// 2,6,1;
// 3,2,1
//  ) |
// $
// - Continue on the cofactor expansion
// $
// "det "A,=(-1)| mat(
// 1,3,0;
// 2,6,1;
// 3,2,1
//  ) |xequal( #`R2`-> #`R2`-2#`R1` \ #`R3`-> #`R3`-3#`R1` )(-1)| mat(
// 1,3,0;
// 0,0,1;
// 0,-7,1
//  ) |xequal(#`R2` arrow.l.r  #`R3`)(-1)(-1)| mat(
// 1,3,0;
// 0,-7,1;
// 0,0,1;
//  ) |;
// ,=(-1)(-1)1(-7)1=-7
// $
// - Since $"det "A!=0$, $A$ is invertible and $"det"(A^(-1))=("det "A)^(-1)=- 1 / 7 $.
// - Since $A$ is 4 by 4, $"det"(-2A)=(-2)^4"det "A=16 dot.c (-7)=-112$.
// // ]

// #problem[
// Suppose $V$ is the set of 2 by 2 matrices that diagonal elements sum to 0. for example $mat(
// 3, 7 ;
// 2, -3
// )$ is in $V$ since $3+(-3)=0$ while $mat(
// 3, 4;
// 2, -2
// )$ is not because $3+(-2)=1!=0$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(10 pt)} Show that $V$ is a vector space.
// \item\textbf{(10 pt)} Find a basis $cal(B)$ (this cannot simply be $cal(C)$) of $V$ and justify your choice.
// \item\textbf{(8 pt)} Explain why $cal(C)={C_1=mat(
// 2, 1 ;
// 1, -2
// ),C_2=mat(
// 1, 2 ;
// -1, -1
// ),C_3=mat(
// 3, -3 ;
// 2, -3
// )}$ also form a basis for $V$.
// \item\textbf{(8 pt)} Find the change-of-coordinates matrix $\underset{cal(C)\leftarrowcal(B)}{P}$.
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - Consider linear transformation $T:M_{2 times 2}(RR)->RR$, $mat(
// a,b;c,d
// )|-> a+d$, we see that $V="ker" T$ which is a subspace of $M_{2 times 2}(RR)$, thus a vector space.
// - Note that $V={mat(
// a,b;
// c,-a
// )}$
// A basis for $V$ could be ${B_1=mat(
// 1,0;
// 0,-1
// ),B_2=mat(
// 0, 1 ;
// 0, 0
// ),B_3=mat(
// 0, 0 ;
// 1, 0
// )}$, this is spanning since
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
// - The $cal(B)$ coordinates of $cal(C)$ is ${[C_1]_{cal(B)}=mat(
// 2;1 ;1
// ),[C_2]_{cal(B)}=mat(
// 1;2 ;-1
// ),[C_3]_{cal(B)}=mat(
// 3;-3 ;2
// )}$, we can show that they are linearly independent and span $V$ since
// $
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
// $
// has a pivot in each row and column.
// - From above we know
//  $
// \underset{cal(B)\leftarrowcal(C)}{P}=mat(
// [C_1)_{cal(B)},[C_2]_{cal(B)},[C_3]_{cal(B)}
// ]=mat(
// 2,1,3;
// 1,2,-3;
// 1,-1,2
// )
//  $
// So we know
//  $
// \underset{cal(C)\leftarrowcal(B)}{P}=(\underset{cal(B)\leftarrowcal(C)}{P})^(-1)=mat(
// 2,1,3;
// 1,2,-3;
// 1,-1,2
// )^(-1)=mat(
// - 1 / 12 , 5 / 12 , 3 / 4 ;
//  5 / 12 ,- 1 / 12 ,- 3 / 4 ;
//  1 / 4 ,- 1 / 4 ,- 1 / 4
// )
//  $
// // ]

// #problem[
// Answer the following questions.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $D$ is the unit disk and $T:RR^2->RR^2$ has a standard matrix $mat(1,2;0,1)$. Then the area of the image $T(D)=2\pi$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $A$ is a $2 times 2$ matrix with integer entries such that $A^(-1)=A^T$ and $A^2=A$, then we know that $"det "A=1$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $T:RR->RR$ is the map that adds 1, then $T$ is a linear transformation of rank $1$.
// \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. Suppose $V$ is the set of 2 by 2 matrices with all four entries sums to zero, and $T:V->PP_2$ is a linear transformation, then $T$ can never be one-to-one.
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - \texttt{FALSE}. $"Area"(T(D))=| "det" mat(1,2;0,1)| dot.c "Area"(D)=|1| dot.c \pi=\pi$.
// - \texttt{TRUE}. First we see that $"det"(A^2)="det"(A)^2="det"(A) => "det"(A)=1$ or $0$. Since $A^(-1)$ exists, $A$ is invertible, so $"det "A!=0$, and $"det "A=1$.
// - \texttt{FALSE}. $T$ is not a linear transformation, since $T(0)=0+1=1!=0$, but we are supposed to have $T(0)=T(0 dot.c 0)=0 dot.c  T(0)=0$, this is contradiction.
// - \texttt{FALSE}. $T$ can be an isomorphism(thus one-to-one) since $"dim"PP_2=3$ and the $"dim" V=4-1=3$, as $V$ is $"ker" T$ for $T:M_{2 times 2}->RR$, $T(mat(
// a,b;
// c,d
// ))=a+b+c+d$.
// // ]

// % #problem[
// % Determine whether the following is true.
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If the eigenvalues for a 3 by 3 matrix $A$ are $1,-1,2$, then $A$ is diagonalizable.
// % \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If both $bold(v)_1,bold(v)_2$ are eigenvectors of a matrix $A$, then $bold(v)_1+bold(v)_2$ is again an eigenvector for $A$.
// % \item\textbf{(3 pt)} \texttt{TRUE} or \texttt{FALSE}. If $A$ is similar to $mat(
// % 2,0,0;
// % 0,1,-1;
// % 0,0,1
// % )$, then $A$ is not diagonalizable.
// % // % ]

// % #solution[
// % \begin{enumerate}[label=\textbf{\alph*)}]
// % - \texttt{TRUE}. By Theorem @(13:41-07/08/2022)
// % - \texttt{FALSE}. Consider $A=mat(
// % 1,0;
// % 0,-1
// % )$, $bold(v)_1=mat(
// % 1;0
// % )$ is eigenvector for $ lambda _1=1$ and $bold(v)_2=mat(
// % 0;1
// % )$ is eigenvector for $ lambda _2=-1$, however $bold(v)_1+bold(v)_2=mat(
// % 1;1
// % )$ is not an eigenvector.
// % - \texttt{TRUE}. Since $mat(
// % 2,0,0;
// % 0,1,-1;
// % 0,0,1
// % )$ is not diagonalizable, the geometric multiplicity for eigenvalue 1 is only 1 which is less than its algebraic multiplicity, which is 2.
// % // % ]

== Final

// #problem[
// Suppose $A=mat(
// 0,1,b,0,2;
// 0,0,a,0,-3;
// 0,0,0,1,1
// )$ is of reduced row echelon form (RREF).
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(4 pt)} Evaluate $a,b$.
// \item\textbf{(6 pt)} Find a basis for $"Col"A$.
// \item\textbf{(8 pt)} Find a basis for $("Row"A)^perp$.
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - $a=1,b=0$. Because pivots of an RREF must be 1 and pivot columns has zeros except the the pivot position.
// - A basis for $"Col"A$ could be ${mat(
// 1;0;0
// ),mat(
// 0;1;0
// ),mat(
// 0;0;1
// )}$ because the pivot columns are the 2nd, 3rd and 4th columns.
// - A basis for $("Row"A)^perp="Nul"A$ is ${mat(
// 1;0;0;0;0
// ),mat(
// 0;-2;3;-1;1
// )}$
// // ]

// #problem[
// Recall that $cal(E)=\{1,t,t^2\}$ is the _standard basis_ for $PP_2$. Given that $cal(B)=\{1+t,2-t^2,3-t+2t^2\}$, $cal(C)=\{2, 1+t,-t^2\}$ are bases for $PP_2$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(15 pt)} Find the change-of-coordinate matrix $\underset{cal(C)\leftarrowcal(B)}{P}$.
// \item\textbf{(15 pt)} Suppose $T:PP_2->PP_2$ is a linear transformation with $cal(B)$ matrix $[T]_{cal(B)}=mat(
// 1,0,1;
// 0,-1,0;
// 1,0,1
// )$, please find the $cal(C)$ matrix $[T]_{cal(C)}$ for $T$.
// \item\textbf{(15 pt)} Suppose $p(t)$ is a polynomial in $PP_2$ such that $[p(t)]_{cal(B)}=mat(
// 0;2;-1
// )$. Evalue polynomial $T(p(t))$ in $PP_2$.
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - First we evaluate matrices
//  $
// \underset{cal(E)\leftarrowcal(B)}{P}=mat(
// 1,2,3;
// 1,0,-1;
// 0,-1,2
// )
//  $
//  $
// \underset{cal(E)\leftarrowcal(C)}{P}=mat(
// 2,1,0;
// 0,1,0;
// 0,0,-1
// )
//  $
//  $
// \underset{cal(C)\leftarrowcal(B)}{P}=(\underset{cal(E)\leftarrowcal(C)}{P})^(-1)\underset{cal(E)\leftarrowcal(B)}{P}=mat(
// 0,1,2;
// 1,0,-1;
// 0,1,-2
// )
//  $
// \item
//  $
// \underset{cal(B)\leftarrowcal(C)}{P}=(\underset{cal(C)\leftarrowcal(B)}{P})^(-1)=mat(
//  1 / 4 ,1,- 1 / 4 ;
//  1 / 2 ,0, 1 / 2 ;
//  1 / 4 ,0,- 1 / 4
// )
//  $
//  $
// [T]_{cal(C)}=\underset{cal(C)\leftarrowcal(B)}{P}[T]_{cal(B)}\underset{cal(B)\leftarrowcal(C)}{P}=mat(
//  1 / 2 ,2,- 3 / 2 ;
// 0,0,0;
// - 3 / 2 ,-2, 1 / 2
// )
//  $
// - First note that
//  $
// [T(p(t))]_{cal(B)}=[T]_{cal(B)}[p(t)]_{cal(B)}=mat(
// -1;-2;-1
// )
//  $
// So $T(p(t))=(-1)(1+t)+(-2)(2-t^2)+(-1)(3-t+2t^2)=-8$.
// // ]

// #problem[
// Consider linear transformation $T:RR^3->RR^3$ which is defined by $T(mat(
// x_1;x_2;x_3
// ))=mat(
// x_1+x_2-2x_3;-x_1+2x_2;x_1+4x_2-4x_3
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(5 pt)} Is $T$ onto? Explain why.
// \item\textbf{(5 pt)} Is $T$ one-to-one? Explain why.
// \item\textbf{(5 pt)} Is $T$ is invertible? If so, please find $T^(-1)$.
// // ]

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
// // ]

// #problem[
// Suppose $A=mat(
// 3,-4;
// 2,-1
// )$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(8 pt)} Please find the eigenvalues of $A$ (they may be complex).
// \item\textbf{(12 pt)} Please find the corresponding eigenvectors.
// \item\textbf{(6 pt)} Write down a factorization of the form $A=P C P^(-1)$, where $C$ is of the form $mat(
// a,-b;b,a
// )$.
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The eigenvalues of $A$ are $ lambda =1-2i$ and $#overline[lambda] =1+2i$, so we have $a=1$, $b=2$.
// - The eigenvectors of $A$ are $bold(v)=mat(
// 1-i;1
// )=mat(
// 1;1
// )+i mat(
// -1;0
// )$ and $#overline[bold(v)]=mat(
// 1;1
// )-i mat(
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
// )=P C P^(-1)
//  $
// // ]

// #problem[
// Suppose $A=mat(
// 1,3;
// 2,2;
// 3,1
// )$, $bold(b)=mat(1;0;1)$.
// \begin{enumerate}[label=\textbf{\alph*)}]
// \item\textbf{(6 pt)} Show that the linear system is linearly inconsistent.
// \item\textbf{(10 pt)} Find the least-square solution(s).
// // ]

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
// - $A^T A=mat(
// 14,10;10,14
// )$, $A^T bold(b)=mat(
// 4;4
// )$, then $\hat{bold(x)}=(A^T A)^(-1)(A^T bold(b))=mat(
//  1 / 6 ; 1 / 6
// )$ is the least-square solution.
// // ]

// #problem[
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
// // ]

// #solution[
// \begin{enumerate}[label=\textbf{\alph*)}]
// - The characteristic polynomial is $(t-3)(t-5)^2$.
// - The eigenvalues of $A$ are $ lambda _1=3$, $ lambda _2= lambda _3=5$.
// - An orthonormal basis consists of eigenvectors could be ${mat(
//  1 / (sqrt(2)) ;- 1 / (sqrt(2)) ;0
// ),mat(
//  1 / (sqrt(2)) ; 1 / (sqrt(2)) ;0
// ),mat(
// 0;0;1
// )}$.
// \item
//  $
// A=mat(
// 4,1,0;
// 1,4,0;
// 0,0,5
// )=mat(
//  1 / (sqrt(2)) , 1 / (sqrt(2)) ,0;
// - 1 / (sqrt(2)) , 1 / (sqrt(2)) ,0;
// 0,0,1
// )mat(
// 3,0,0;
// 0,5,0;
// 0,0,5
// )mat(
//  1 / (sqrt(2)) ,- 1 / (sqrt(2)) ,0;
//  1 / (sqrt(2)) , 1 / (sqrt(2)) ,0;
// 0,0,1
// )=P D P^T
//  $
// // ]

// \bibliography{Bibliography}

#pagebreak()
#columns(3)[
    #make-index(title: "Index", outlined: true, use-page-counter: true)
]
