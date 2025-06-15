/* define the project */

#let project(title: "", authors: (), date: none, body) = {
  // stying of the document
  set document(author: authors, title: title, date: date)
  // stying of the text
  set text(font: (name: "New Computer Modern"), lang: "en")
  // stying of the heading
  set heading(numbering: "1.")
  // stying of the math equations
  set math.equation(numbering: "(1)")
  // stretch lines to make them align well
  set par(justify: true)

  // insert spaces between heading # and heading text
  show heading: it => block(counter(heading).display(it.numbering) + h(1em) + it.body)

  // styling for reference
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      link(
        el.location(),
        numbering(
          el.numbering,
          ..counter(eq).at(el.location()),
        ),
      )
    } else {
      // Other references as usual.
      it
    }
  }

  // display the title, author, and date
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #block(text(weight: 200, 1em, authors))
    #block(text(weight: 200, 1em, date.display()))
  ]

  body
}

/* Document starts here */

#show: project.with(
  title: "MATH240 - Syllabus",
  authors: "Haoran Li",
  date: datetime(year: 2024, month: 5, day: 31),
)

= Contact Information
*Instructor:* Haoran(Harrison) Li \
*Email:* #link("mailto:haoranli@umd.edu", "haoranli@umd.edu") \
*Office Hours:* Wednesday 12:30-2:30pm with Zoom link 7636616227

= ELMS/Canvas
ELMS/Canvas will be used extensively throughout the course. This syllabus, along with assignments and grades, will be posted in ELMS. You will submit some of your assignments through ELMS (via Gradescope). Our ELMS course page will essentially function as the course website. To access ELMS, go to #link("http://myelms.umd.edu", "myelms.umd.edu"), and log in using your UMD username and password.

= Lecture Notes
We shall follow the Lecture Notes under Files in ELMS. The reference is _Linear Algebra and its Applications_ by Lay and McDonald, 6th edition. A day-to-day schedule is posted in ELMS.

= Class Format
The class meets on M/Tu/W/Th/F, 11:00am-12:22pm. You are *expected* to attend every class, though attendance will not be formally taken. There will be review and practice sessions during lectures.

= Lecture Videos
The lecture videos can be found under "Zoom/Cloud Recordings" in ELMS. Please consider watching them if you miss a class or want to review a topic.

= Online Assignments
There will be 10 assignments within Gradescope that *will be graded*. They will be posted days before they are due. Some problems will require you to submit your handwritten work electronically. There will be late penalties, and you are welcome to reach out if you are having technical issues with the online submissions.

= MATLAB Projects
There will be two MATLAB projects due at *11:59 pm* on the following dates:
- *MATLAB Project 1 - due Sunday, June 23rd*
- *MATLAB Project 2 - due Sunday, July 14th*

= Exams
There will be two one-hour midterm exams and a final exam, given during lectures:
- *Exam 1 - Friday, June 14th, 11:00-12:00pm*
- *Exam 2 - Tuesday, July 2nd, 11:00-12:00pm*
- *Final Exam - Friday, July 19th, 11:00-1:00pm*

In case of an excused absence (see the link in “University Policies”), notify the instructor in advance (or ASAP in the case of illness or emergency). Provide documentation justifying the absence.

= Calculators
Calculators and all electronic devices may *NOT* be used during exams.

= Grades
Final grade breakdown:
- *Online Assignments* - 22% (2.2% each)
- *MATLAB Projects* - 8% (4% each)
- *Midterm Exams* - 40% (20% each)
- *Final Exam* - 30%

#align(center)[
  #table(
    columns: (auto, auto),
    table.header(
      [*Letter Grade*],
      [*Percent Score*],
    ),

    [A+], $>=97%$,
    [A], $>=93%$,
    [A-], $>=90%$,
    [B+], $>=87%$,
    [B], $>=83%$,
    [B-], $>=80%$,
    [C+], $>=77%$,
    [C], $>=73%$,
    [C-], $>=70%$,
    [D], $>=60%$,
    [F], $<60%$,
  )
]

The instructor reserves the right to *lower* these cutoffs at semester end if appropriate. Curving will never raise cutoffs, only lower them.

= University Policies
General policies: #link("http://ugst.umd.edu/courserelatedpolicies.html", "ugst.umd.edu/courserelatedpolicies.html")

Topics include academic integrity, conduct, accommodations, absences, grading, and copyright.

= Disability Support
Students requiring accommodations must register with Accessibility and Disability Service (ADS). ADS will provide an Accommodation Letter to instructors. Present the letter by the end of the drop/add period.
