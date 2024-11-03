import sugar, sequtils, strutils

proc somaComum(a, b, c: int): int =
  a + b + c

proc somaCurried(a: int): proc(b: int): proc(c: int): int =
  return proc(b: int): proc(c: int): int =
    return proc(c: int): int =
      return a + b + c

let soma5 = somaCurried(5)
let soma5e3 = soma5(3)
let resultadoFinal = soma5e3(2)
echo "Resultado do currying: ", resultadoFinal

proc multiplicador(x: int): proc(y: int): int =
  return proc(y: int): int = x * y

let multiplicaPor5 = multiplicador(5)
echo "5 * 3 = ", multiplicaPor5(3)
echo "5 * 4 = ", multiplicaPor5(4)

proc compor[T](f, g: proc(x: T): T): proc(x: T): T =
  return proc(x: T): T = f(g(x))

let dobra = proc(x: int): int = x * 2
let soma10 = proc(x: int): int = x + 10

let dobraESoma10 = compor(soma10, dobra)
let soma10EDbora = compor(dobra, soma10)

echo "Dobra e soma 10 (5): ", dobraESoma10(5)
echo "Soma 10 e dobra (5): ", soma10EDbora(5)

proc calcularPreco(desconto: float, taxa: float, preco: float): float =
  (preco * (1.0 - desconto)) * (1.0 + taxa)

proc precoComDesconto(desconto: float): proc(taxa: float): proc(preco: float): float =
  return proc(taxa: float): proc(preco: float): float =
    return proc(preco: float): float =
      return (preco * (1.0 - desconto)) * (1.0 + taxa)

let comDesconto10Porcento = precoComDesconto(0.10)
let comDesconto10ETaxa5 = comDesconto10Porcento(0.05)

echo "Preço final (100): ", comDesconto10ETaxa5(100.0)

proc stringParaInt(s: string): int = parseInt(s)
proc intParaFloat(i: int): float = float(i)

proc stringParaFloat(s: string): float =
  let intermediario = stringParaInt(s)
  intParaFloat(intermediario)

echo "String para float: ", stringParaFloat("42")

let numeros = @[1, 2, 3, 4, 5]
  .map(x => x * 2)
  .filter(x => x > 5)
  .map(x => x + 1)

echo "Resultado do pipeline: ", numeros

type Calculadora = object
  fator: int

proc novaCalculadora(fator: int): Calculadora =
  result.fator = fator

proc aplicar(calc: Calculadora, valor: int): int =
  calc.fator * valor

let calc5 = novaCalculadora(5)
echo "Calculadora * 3: ", calc5.aplicar(3)