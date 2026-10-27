#import "tubaf_template.typ" as tubaf


#show: tubaf.presentation.with(
  title: "Projektseminar Robotik",
  subtitle: "Anforderung Zwischenpräsentation",
  author: "Prof. Dr.-Ing. Dr. h.c. Nick Nayme, Shorton Kreditz",
  bottom-text: tubaf.longdate(datetime.today()),
  lang: "de"
)

#outline(depth: 1)

= Einleitung Projektseminar
#grid(
  columns: 2,
  column-gutter: 1cm,
  lorem(60),
  lorem(40)
)
