type
  Metros = distinct float
  Centimetros = distinct float
proc `$`(c: Centimetros): string =
  return $(float(c)) & " cm"

proc metrosParaCentimetros(m: Metros): Centimetros =
  return Centimetros(float(m) * 100.0)

let m: Metros = Metros(1.75)
let cm: Centimetros = metrosParaCentimetros(m)
echo(cm)
