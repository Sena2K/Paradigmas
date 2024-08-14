type
  Centimetros = distinct float
  Polegadas = distinct float
  Jardas = distinct float
  TipoForma = enum
    circulo, retangulo, triangulo

proc `$`(cm: Centimetros): string =
  $(cm.float)

proc `$`(pol: Polegadas): string =
  $(pol.float)

proc `$`(jar: Jardas): string =
  $(jar.float)

proc paraPolegadas(cm: Centimetros): Polegadas =
  Polegadas(cm.float * 0.393701)

proc paraJardas(pol: Polegadas): Jardas =
  Jardas(pol.float / 36)

proc calcularArea(tipo: TipoForma, dimensoes: seq[float]): float =
  case tipo
  of TipoForma.circulo:
    return 3.14159 * dimensoes[0] * dimensoes[0]
  of TipoForma.retangulo:
    return dimensoes[0] * dimensoes[1]
  of TipoForma.triangulo:
    return 0.5 * dimensoes[0] * dimensoes[1]

proc imprimirMedidas(cm: Centimetros) =
  let polegadas = paraPolegadas(cm)
  let jardas = paraJardas(polegadas)
  echo "Centímetros: ", cm, ", Polegadas: ", polegadas, ", Jardas: ", jardas

proc main() =
  echo "Convertendo 100 centímetros para polegadas e jardas:"
  let comprimentoCm = Centimetros(100.0)
  imprimirMedidas(comprimentoCm)

  echo "\nCalculando áreas de diferentes formas:"
  let raioCirculo = @[10.0] 
  let dimensoesRetangulo = @[5.0, 3.0] 
  let dimensoesTriangulo = @[6.0, 4.0] 

  echo "Área do círculo (raio 10 cm): ", calcularArea(TipoForma.circulo, raioCirculo)
  echo "Área do retângulo (5x3 cm): ", calcularArea(TipoForma.retangulo, dimensoesRetangulo)
  echo "Área do triângulo (base 6, altura 4 cm): ", calcularArea(TipoForma.triangulo, dimensoesTriangulo)

  echo "\nIterando por uma sequência de comprimentos:"
  var comprimentos = @[Centimetros(10.0), Centimetros(20.0), Centimetros(50.0)]
  for comprimento in comprimentos:
    imprimirMedidas(comprimento)

main()
