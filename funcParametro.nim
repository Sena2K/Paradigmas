proc soma(a: int, b: int): int =
  return a + b

let minhaFuncao = soma
echo minhaFuncao(5, 3)  


proc aplicaFuncao(f: proc(x: int): int, valor: int): int =
  return f(valor)

proc quadrado(x: int): int =
  return x * x

echo aplicaFuncao(quadrado, 4) 
