# My Mathematical Universe: Typst Edition

## Build

From this directory, using Typst 0.14.2 or newer:

```sh
typst compile MyMathematicalUniverse.typ MyMathematicalUniverse.pdf
```

`main.typ` is an alternative entry point for the same book. Edit the topic
files beside their original TeX counterparts; the entry point includes them.
The first build may download the pinned Fletcher 0.5.8 package. No LaTeX,
Pandoc, or conversion scripts are needed to build the Typst edition.

## Organization

- All 70 content sources are included, even those omitted by the original
  master documents. All 73 original TeX files remain unchanged.
- The Polylogarithm and Miscellaneous directories have their own Typst
  collection wrappers, included by the complete book.
- `universe-style.typ` supplies the shared layout, theorem and equation
  numbering, proofs, cross-references, fitted display equations, and index.
- The 154 commuting diagrams use editable Fletcher nodes and edges.
- `universe-drawings.typ` embeds all 41 original TikZ sketches as SVG vectors.
  These preserve their geometry but are not editable native Typst drawings.
- The existing bibliography, pictures, and license are retained.
  `LICENSE.typ` reproduces the existing license notice.

## Source Gaps

Unfinished statements and draft calculations remain unfinished rather than
being completed with invented mathematics. Four references absent from the
original collection are explicitly marked in the book:

- Baire category theorem, in Differential Geometry.
- `AV<=V <=> e^tAV<=V`, in Harmonic Analysis.
- Identity principle, in Riemann Surfaces.
- Zhao's *Multiple Zeta Functions, Multiple Polylogarithms and Their Special
  Values*, in Iterated Integrals; its bibliography entry is missing.

## Verification

The full book compiles without Typst warnings. A source comparison verified
every statement, proof, solution, label, and diagram, including all 30 cases
environments. The original TeX files were verified unchanged by SHA-256.
Representative rendered pages were visually checked, and a full PDF text
bounds audit found no text outside the content margins.