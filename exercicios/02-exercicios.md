# 02 - exercicios
## Começando

**1) O que é um literal?**  
Um valor que representa ele mesmo, exemplo um inteiro 10, que representa o próprio valor 10. 
É uma expressão que não necessita de avaliação, ele produz o próprio valor .

**2) O que é uma função primitiva?**  
Função definida pela linguagem

**3) O que é uma expressão?**  
É a combinação de elementos computacionais(números, variáveis, operadores, funções...) e que ao ser avaliada produz algum valor

**4) O que significa avaliar uma expressão?**  
R: Seguir as regras da linguagem para reduzir os componentes da expressão a um valor

**5) Qual é a regra de avaliação para uma chamada de função?**  
Avaliar cada expressão da chamada de função, reduzindo cada expressão a um valor e então aplicar os valores de cada expressão no operador(função).

5) Qual é a regra de avaliação para uma expressão case?
6) Qual é o propósito de uma definição?
7) O que é uma função?
	R: Instruçõe do computador que mapeiam valores de entrada para valores de saida
8) A ordem que as expressões em uma chamada de função são avaliadas pode alterar o valor da chamada da função? Explique.
9) O que é uma definição com autorreferência? E um processo recursivo?

## Praticando
**11) Faça uma função chamada `area_retangulo` que recebe dois argumentos, a `largura` e a `altura` de um retângulo, e calcula a sua área. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo.**  
```gleam
> area_retangulo(3.0, 5.0)
15.0
> area_retangulo(2.0, 2.5)
5.0

pub fn area_retangulo(x: Float, y: Float) -> Float {
  x *. y
}
```

**12) Faça uma função chamada produto_anterior_posterior que recebe um número inteiro `n` e calcula o produto de `n`, `n + 1` e `n - 1`. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo.**  
```gleam
> produto_anterior_posterior(3)
24
> produto_anterior_posterior(1)
0
> produto_anterior_posterior(-2)
-6

pub fn produto_anterior_posterior(n: Int) -> Int {
  n * {n + 1} * {n - 1}
}
```

**13) Faça uma função chamada eh_par que recebe um número natural `n` e indica se `n` é par. Um número é par se o resto da divisão dele por 2 é igual a zero. Não use case e nem a função pré-definida `int.is_even`. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo**  
```gleam 
> eh_par(3)
False
> eh_par(6)
True

pub fn eh_par(n: Int) -> Bool {
  n % 2 == 0
}
```

**14) Faça uma função chamada `tem_tres_digitos` que recebe um número natural n e verifica se n tem exatamente 3 dígitos. Não use case. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo.**
```gleam
> tem_tres_digitos(99)
False
> tem_tres_digitos(100)
True
> tem_tres_digitos(999)
True
> tem_tres_digitos(1000)
False

pub fn tem_tres_digitos(n: Int) -> Bool {
  n >= 100 && n <= 999
}
```

**15) Faça uma função maximo que encontre o máximo entre dois inteiros. Não use a função int.max. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo.**  
```gleam
> maximo(3, 5)
5
> maximo(8, 4)
8
> maximo(6, 6)
6

pub fn maximo(x: Int, y: Int) -> Int {
  case x > y {
    True -> x
    False -> y
  }
}
```

**16) Faça uma função chamada ordem que recebe três inteiros distintos, a, b e c e determina se a sequencia a, b, c está em ordem crescente, decrescente ou não está em ordem. Use os operadores relacionas com três argumentos. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo.**  
```gleam
> ordem(3, 8, 12)
"crescente"
> ordem(3, 1, 4)
"sem ordem"
> ordem(3, 1, 0)
"decrescente"

pub fn ordem(a: Int, b: Int, c: Int) -> String {
  case a > b {
    True -> 
      case b > c {
        True -> "decrescente"
        False -> "sem ordem"
      }
    False -> 
      case b < c {
        True -> "crescente"
        False -> "sem ordem" 
      } 
  }
}
```

## Avançando

**17. Faça uma função chamada `so_primeira_maiuscula` que recebe uma palavra não vazia (string) como parâmetro e crie uma nova string convertendo a primeira letra da palavra para maiúscula e o restante da palavra para minúscula. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas no modo interativo. Veja as funções `string.slice, string.uppercase e string.lowercase`.**  
```gleam
> so_primeira_maiuscula("paula")
"Paula"
> so_primeira_maiuscula("ALFREDO")
"Alfredo"

pub fn so_primeira_maiuscula(palavra: String) -> String {
  string.concat(
    [
      string.uppercase(
        string.slice(
          from: palavra, 
          at_index: 0, 
          length: 1
        )
      ),
      string.lowercase(
        string.slice(
          from: palavra,
          at_index: 1,
          length: string.length(palavra) - 1
        )
      )
    ]
  )
}
```

**18) [sicp 1.4] O modelo de avaliação visto em sala permite que os operadores em chamadas de funções sejam expressões compostas. Use esta observação para descrever o comportamento do seguinte procedimento:**  
```gleam
fn a_plus_abs_b(a, b) {
	case b > 0 {
		True -> int.add
		False -> int.subtract
	}(a, b)
}
```
Gleam avalia o case, que retorna uma função `int.add` ou `int.subtract`. Então substitui o valor do case pela função e usa a expressão `(a, b)` como argumento para a função produzida pelo case. 

**19. [sicp 1.5] Ben Bitdiddle inventou um método para determinar se um interpretador está usando avaliação com ordem aplicativa ou avaliação com ordem normal. Ele definiu os seguintes procedimentos:**  
```gleam
fn p() {
	p()
}

fn teste(x, y) {
	case x == 0 {
		True -> 0
		False -> y
	}
}
```
Então avaliou a seguinte expressão
`teste(0, p())`
Qual é o comportamento que Ben irá observar com um interpretador que usa avaliação com ordem aplicativa? Qual é o comportamento que ele irá observar com um interpretador que usa avaliação com ordem normal? Explique a sua resposta.

Ordem aplicativa provavelmente terá um estouro de pilha ou o famoso #stackoverflow , pois independente do valor de x, o interpretador tentará avaliar o valor de y e isso causará uma recursão infinita. Já em um interpretador com ordem normal o resultado depende do valor de x, caso x seja 0, y jamais será avaliado.
