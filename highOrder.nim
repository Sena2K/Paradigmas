import sequtils, sugar, strutils

proc aplicaDuasVezes[T](x: T, f: proc(x: T): T): T =
  result = f(f(x))

echo aplicaDuasVezes(2, proc(x: int): int = x * 2)
echo aplicaDuasVezes(2.5, proc(x: float): float = x + 1.0)

let numeros = @[1, 2, 3, 4, 5]

let dobrados = numeros.map(x => x * 2)
echo "Números dobrados: ", dobrados

let aoQuadrado = numeros.map(proc(x: int): int = x * x)
echo "Números ao quadrado: ", aoQuadrado

let pares = numeros.filter(x => x mod 2 == 0)
echo "Números pares: ", pares

let maioresQueTres = numeros.filter(proc(x: int): bool = x > 3)
echo "Números maiores que 3: ", maioresQueTres

let soma = numeros.foldl(a + b)
echo "Soma total: ", soma

let maximo = numeros.foldl(if a > b: a else: b)
echo "Valor máximo: ", maximo

let resultadoFinal = numeros
  .filter(x => x mod 2 == 0)
  .map(x => x * x)
  .foldl(a + b)
echo "Soma dos quadrados dos números pares: ", resultadoFinal

proc compor[T](f, g: proc(x: T): T): proc(x: T): T =
  return proc(x: T): T = f(g(x))

let adicionaUm = proc(x: int): int = x + 1
let multiplicaPorDois = proc(x: int): int = x * 2
let funcaoComposta = compor(adicionaUm, multiplicaPorDois)
echo "Resultado da composição: ", funcaoComposta(5)

proc mapearTipos[T, U](dados: seq[T], f: proc(x: T): U): seq[U] =
  result = newSeq[U]()
  for item in dados:
    result.add(f(item))

let textos = @["1", "2", "3"]
let inteiros = textos.map(x => parseInt(x))
echo "Convertido para inteiros: ", inteiros