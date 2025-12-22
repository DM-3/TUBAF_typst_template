// references:
// https://tu-freiberg.de/zuv/dezernat-5-universitaetskommunikation/corporate-design
// https://tu-freiberg.de/zuv/d5/corporate-design/markenlogo
// https://tu-freiberg.de/corporate-design/typografie
// https://tu-freiberg.de/zuv/d5/corporate-design/farbdefinition

#let colors = (
  Uniblau:    rgb("#0069b4"),
  Dunkelblau: rgb("#00497f"),
  Schwarz:    rgb("#000000"),
  Weiß:       rgb("#ffffff"),
  Geo:        rgb("#8b7530"),
  Material:   rgb("#007b99"),
  Energie:    rgb("#b71e3f"),
  Umwelt:     rgb("#15882e"),
)

#let sizes = (
  title: 20pt,
  subtitle: 16pt,
  subsubtitle: 14pt,
  large: 12pt,
  normal: 10pt,
  small: 8pt,
)

#let translation = (
  "en": (
    section: "section",
    supervisor: "Supervisor",
    examiner: "Examiner",
    theorem: "Theorem",
    corollary: "Corollary",
    definition: "Definition",
    example: "Example",
    proof: "Proof",
    studentID: "Student-ID",
    bibliography: "Bibliography",
    table_of_figures: "Table of Figures",
    table_of_tables: "Table of Tables",
    declaration_of_authenticity: "Declaration of Authenticity",
    months: (
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    )
  ),
  "de": (
    section: "Abschnitt",
    supervisor: "Betreuer",
    examiner: "Prüfer",
    theorem: "Satz",
    corollary: "Folgerung",
    definition: "Definition",
    example: "Beispiel",
    proof: "Beweis",
    studentID: "Matrikelnummer",
    bibliography: "Literatur",
    table_of_figures: "Abbildungsverzeichnis",
    table_of_tables: "Tabellenverzeichnis",
    declaration_of_authenticity: "Eigenständigkeitserklärung",
    months: (
      "Januar",
      "Februar",
      "März",
      "April",
      "Mai",
      "Juni",
      "July",
      "August",
      "September",
      "Oktober",
      "November",
      "Dezember",
    )
  ),
)

#let longdate(
  lang: "en",
  datetime,
) = [
  #datetime.day(). 
  #translation.at(lang).months.at(datetime.month() - 1) 
  #datetime.year()
]

#let declaration_of_authenticity(
  authors,
  datetime,
  location,
  lang: "en",
) = {
  set page(header: none, footer: none)
  v(1fr)
  text(size: sizes.large, weight: "bold")[#translation.at(lang).declaration_of_authenticity]
  v(1em)
  if lang == "en" {
    [#if authors.len() == 1 [I] else [We] hereby declare that #if authors.len() == 1 [I] else [we] have written this term paper independently and without outside assistance, that #if authors.len() == 1 [I] else [we] did not use any other sources apart from the ones stated in the bibliography and that #if authors.len() == 1 [I] else [we] have clearly cited all passages in #if authors.len() == 1 [my] else [our] work that were taken from other sources. This term paper has never been previously submitted in its current or similar form in any other course and/or degree programme.]
  }
  if lang == "de" {
    [Hiermit #if authors.len() == 1 [versichere ich] else [versichern wir], dass #if authors.len() == 1 [ich] else [wir] die vorliegende Arbeit ohne unzulässige Hilfe Dritter und ohne Benutzung anderer als der angegebenen Hilfsmittel angefertigt #if authors.len() == 1 [habe] else [haben]. Die aus fremden Quellen direkt oder indirekt übernommenen Gedanken sind als solche kenntlich gemacht.]
  }
  v(2cm)
  line(length: 6cm, stroke: 0.5pt)
  for author in authors {
    author.name
    linebreak()
    [#location, #longdate(datetime, lang: lang)]
  }
  v(1fr)
}

#let report(
  type: "",
  title: "",
  authors: (
    (
      title: "", 
      name: "", 
      birth-date: "", 
      email: "",
      studentID: "",
    )
  ),
  supervisors: (
    (
      title: "",
      name: "",
    )
  ),
  examiners: (
    (
      title: "",
      name: "",
    )
  ),
  location: "Freiberg",
  lang: "en",
  decl_authenticity: true,
  extra_outlines: (),
  references: "",
  body,
) = {
  // general (1)
  set page(paper: "a4", margin: (left: 4cm, top: 25mm, bottom: 20mm))
  set text(font: "Arial", lang: lang, bottom-edge: "descender", top-edge: "cap-height")
  set par(justify: true, leading: .5em)   // 1.5 line spacing


  // cover page
  counter(page).update(1)
  {
    set par(justify: false)
    image("TUBAF_Logo_blau.svg", width: 42mm)
    v(5mm)
    text(fill: colors.Dunkelblau, size: sizes.small)[*Fakultät für Mathematik und Informatik*\ Institut für Informatik]
    v(1fr)
    text(size: sizes.subtitle)[#type]
    v(0pt)
    text(size: sizes.title)[*#title*]
    v(1cm)
    for author in authors {
      text(size: sizes.large)[#author.name]
      linebreak()
      text(size: sizes.small)[#translation.at(lang).studentID: #author.studentID]
    }
    v(1fr)
    text(size: sizes.large)[#translation.at(lang).supervisor #linebreak()]
    for supervisor in supervisors {
      text(size: sizes.large, weight: "semibold")[#supervisor.title #supervisor.name #linebreak()]
    }
    v(1cm)
    text(size: sizes.large)[#translation.at(lang).examiner #linebreak()]
    for examiner in examiners {
      text(size: sizes.large, weight: "semibold")[#examiner.title #examiner.name #linebreak()]
    }
    v(1cm)
  }


  // declaration of authenticity
  if decl_authenticity {
    declaration_of_authenticity(authors, datetime.today(), location, lang: lang)
  }
  

  // general (2)
  show heading: set block(below: 1em, above: 2.5em)
  set heading(numbering: "1.1.1")
  set heading(supplement: translation.at(lang).section)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: sizes.title)
    v(3em)
    it
    v(1em, weak: true)
    line(length: 100%, stroke: 0.5pt)
    v(1em)
  }
  show heading.where(level: 2): set text(size: sizes.subtitle)
  show heading.where(level: 3): set text(size: sizes.subsubtitle)

  set page(footer: context {              // left-right page counter
    if calc.even(here().page()) [
      #counter(page).display()
    ] else [
      #h(1fr)
      #counter(page).display()
    ]
  })

  set math.equation(numbering: "(1)")
  set math.mat(delim: "[")


  // list of contents
  set page(numbering: "I")
  outline(indent: 0.5cm)
  pagebreak()


  // list of images
  let image-outline() = {
    show outline: set heading(outlined: true)
    outline(title: translation.at(lang).table_of_figures, target: figure.where(kind: image))
  }
  image-outline()


  // list of tables
  let table-outline() = {
    show outline: set heading(outlined: true)
    outline(title: translation.at(lang).table_of_tables, target: figure.where(kind: table))
  }
  table-outline()


  // additional outlines
  for outline in extra_outlines [#outline()]

  // body
  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "1")
  set text(size: sizes.normal)
  body


  // bibliography
  if references != "" {
    bibliography(references, title: translation.at(lang).bibliography)
  }
}
