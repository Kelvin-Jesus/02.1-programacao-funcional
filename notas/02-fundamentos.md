---
date: 2025-04-08
tags:
  - faculdade
  - programacao-funcional
  - fundamentos
  - algoritmos
  - expressao
  - matematica
  - tipos-primitivos
  - funcoes-primitivas
  - "#modelo-de-substituição"
  - gleam
---
# 03 - Fundamentos

## Introdução
O paradigma se baseia na aplicação e definição de funções assim como na [[01 - O que são funções|matemática]].
- Cada função é um conjunto de expressões que mapeia valores de entrada a valores de saída.
## O que são expressões?
- Uma entidade sintática que ao ser avaliada gera um valor.
- De forma mais simples, é uma instrução que quando executada gera um valor.
# Definição de Expressão (v0.1)
- Um literal; ou
- Uma função primitiva.

## Literais de Tipos Primitivos
Um **literal** é representado diretamente no código e são usados para criar valores de tipos primitivos.

Um **Tipo Primitivo** é um tipo suportado diretamente pela linguagem.

Uma **Função Primitiva** é uma função suportada/implementada diretamente pela linguagem

### Tipos em Gleam
#### Números Inteiros (`Int`)
- 1234
- 9_234

#### Booleanos (`Bool`)
- `True`
- `False`

###### Números de ponto flutuante (`Float`)
- 2.65
- 2.0e12
- 7.4e-10
###### Strings (`String`)
- "Kelvin Jesus"
- "din uem"

## Funções Primitivas
### Operações com inteiros
#### Operações com inteiros:
- + (int.add)
- - (int.subtract)
- * / % > >= < <= == !=
- int.to_float

#### Operações com strings:
- <> (string.append)
- == !=
- string.slice

#### Operações com floats:
- \*. (float.product)
- /. (float.divide)
- +. -. >. >=. <. <=. == !=
- float.truncate

#### Operações com booleanos
- ! (bool.negate)
- == !=

# Processo de Avaliação de Expressões (v0.1)
###### Uma expressão consiste de
- Um literal; ou
- Uma função primitiva.
###### Regra para avaliação de expressão
- Literal -> valor que o literal representa.
- Função Primitiva -> Sequência de instruções de máquina associada com a função.

Esta forma de definir uma expressão é limitada, ainda falta uma maneira de combinar expressões para formar novas expressões mais complexas.

```rust
> True
True

> 231
231

> "Banana"
"Banana"

> int.add
// fn(a, b) {...}
```

# Combinações
-> Exemplos de combinações em Racket:
```rust
{12 + 56} * 5
70

> "Gol" <> string.repeat("!", 4)
"Gol!!!!"

> 10 / 0 // Divisão por zero
0

> int.multiply(int.add(2, 12), 5)
70

> string.append(
	 "Gol",
	 string.repeat("!", 4)
)
"Gol!!!!"

> int.divide(10, 0)
0
```


Uma combinação é uma lista não vazia de expressões entre parênteses.
- Expressão mais a esquerda é o ***operador***
- O resto é ***operando***

Uma chamada de função consiste em uma expressão seguida por uma sequência de expressões
entre parênteses separadas por vírgula

Qual é o valor produzido pela avaliação de uma combinação?
- Resultado de aplicar a ***função*** do ***operador*** aos ***operandos***.

## Notação Prefixa e Expressões S (old - racket)
São utilizadas para expressar listas aninhadas (ou árvores). Também conhecida como [sexp](https://en.wikipedia.org/wiki/S-expression)
##### Vantagens
- Operadores aritméticos são avaliados como funções comuns e podem receber $n$ argumentos.
- 
```lisp
(* 2 8 10 1)
160

```
- Aninhamento de combinações sem se preocupar com prioridades de operações
```lisp
(+ (* 3 5) (- 10 6) 5)
24

(+ (* 3
		(+ (* 2 4)
			(+ 3 5)))
	(+ (- 10 7)
		6 ))
57
```
- Um programa é representado com uma sequência de ***sexp*** e com isso é possível fazer programas que processam outros programas([linguagens homoicônas](https://en.wikipedia.org/wiki/Homoiconicity)).

##### Desvantagens
- Requer muitos parênteses

# Processo de Avaliação de Expressões (v0.2)
###### Uma *expressão* consiste de
- Um literal; ou
- Uma função primitiva; ou
- ==Uma combinação (lista não vazia de ***expressões*** entre parênteses)==
###### Regra para avaliação de expressão
- Literal -> valor que o literal representa.
- Função Primitiva -> Sequência de instruções de máquina associada com a função.
- ==Combinação==
	- ==Avaliar cada expressão da combinação (reduzir cada expressão para um valor)==
	- ==-> Resultado da aplicação da função aos argumentos.==

###### Observações
- Expressão é definida em 3 casos e a regras de avaliação também
- Se uma expressão é uma combinação, ela contém outras expressões internas. Quando a definição refere-se a ela mesma, é chamado de ***Autorreferência***, permitindo expressões de tamanhos arbitrários.
- Avaliar expressões que contenham expressões requer a utilização de recursão
- Uma autorreferência em uma definição implicada (geralmente) em uma recursão para
processar os elementos que seguem a definição.

```rust title:"Exemplo de avaliação de expressão"
import gleam/int.{add, multiply as mul, subtract as sub}
3 * { 2 * 4 + { 3 + 5 } } + { { 10 - 7 } + 6 }
add(mul(3, add(mul(2, 4), add(3, 5))), add(sub(10, 7), 6)) // mul(2, 4) -> 8
add(mul(3, add(8, add(3, 5))), add(sub(10, 7), 6)) // add(3, 5) -> 8
add(mul(3, add(8, 8)), add(sub(10, 7), 6)) // add(8, 8) -> 16
add(mul(3, 16), add(sub(10, 7), 6)) // mul(3, 16) -> 48
add(48, add(sub(10, 7), 6)) // sub(10, 7) -> 3
add(48, add(3, 6)) // add(3, 6) -> 9
add(48, 9) // add(48, 9) -> 57
57

```

## Definições
### Qual o propósito?
Nomear objetos computacionais como dados ou funções.
- Forma de abstração mais elementar.
- ex: ```{js}let x = "Hello, World!"```

### Definições de constantes
Forma geral:
```Rust
[pub] const nome [: Tipo] = literal

// Exemplos
const idade: Int = 23
pub const y = 18

> x
10

> y
20
```

### Definições de funções
Forma geral para definição de novas funções(funções compostas) é:
```Rust
[pub] fn nome(parametro1 [: Tipo], parametro2 [: Tipo], ...) [-> Tipo] {
	// expressão...
}

// Exemplos 
fn quadrado(x: Int) -> Int {
	x * x
}

pub fn soma_quadrados(a: Int, b) {
	quadrado(a) + quadrado(b)
}

> soma_quadrados(3, 4)
25
```

## Processo de Avaliação de Expressões (v0.3)
###### Uma *expressão* consiste de
- Um literal; ou
- Uma função primitiva; ou
- ==Um nome; ou==
- Uma combinação (lista não vazia de ***expressões*** entre parênteses)
###### Regra para avaliação de expressão
- Literal -> valor que o literal representa.
- Função Primitiva -> Sequência de instruções de máquina associada com a função.
- ==Nome -> Valor associado com o nome no ambiente (memória que guarda as associações de nome -> valor)==
- Combinação/chamada de função
	- ***Avaliar cada expressão*** da combinação (reduzir cada expressão para um valor)
	- Se o operador é uma função primitiva, aplicar os argumentos.
	- Senão (operador é uma função composta), ***avalie*** o corpo da função ***substituindo*** cada ocorrência do parâmetro pelo argumento

\# Essa forma de calcular o resultado da aplicação de funções compostas é chamada de #modelo-de-substituição.

```Rust
fn quadrado(x) { x * x }
fn soma_quadrados(a, b) { quadrado(a) + quadrado(b) }
fn f(a) { soma_quadrados(a + 1, a * 2) }
f(5) // Substitui f(5) pelo corpo de f com as ocorrências
// do parâmetro a substituídas pelo argumento 5
soma_quadrados(5 + 1, 5 * 2) // Reduz 5 + 1 para o valor 6
soma_quadrados(6, 5 * 2) // Reduz 5 * 2 para o valor 10
soma_quadrados(6, 10) // Substitui soma_quadrados(6, 10) pelo corpo ...
quadrado(6) + quadrado(10) // Substitui quadrado(6) pelo corpo ...
{ 6 * 6 } + quadrado(10) // Reduz 6 * 6 para 36
36 + quadrado(10) // Substitui quadrado(10) pelo corpo ...
36 + { 10 * 10 } // Reduz 10 * 10 para 100
36 + 100 // Reduz 36 + 100 para 136
136
```

O método de avaliação padrão do Gleam é em ***ordem aplicativa***(avaliação ansiosa). Mas também existe a ***ordem normal***(avaliação preguiçosa) que primeiro substitui e só então avalia quando e se necessário.

#### Exercício Custo
##### Ex. 1 
O seu amigo Alan está planejando uma viagem pro final do ano com a família e está considerando diversos destinos. Uma das coisas que ele está levando em consideração é o custo da viagem, que inclui, entre outras coisas, hospedagem, combustível e o pedágio. Para o cálculo do combustível ele pediu a sua ajuda, ele disse que sabe a distância que vai percorrer, o preço do litro do combustível e o rendimento do carro (quantos quilômetros o carro anda com um litro de combustível), mas que é muito chato ficar fazendo o cálculo manualmente, então ele quer que você faça um programa para calcular o custo do combustível em uma viagem.

O que de fato precisa ser feito?
Calcular o preço do combustível, sabendo a distância, preço do litro e rendimento do carro

Como determinar o processo(forma) que a saída é computada a partir da entrada?
Fazendo exemplos específicos e generalizando o processo.

##### Exemplo de entrada
- Distância: 400km
- Preço do litro: R$ 5.00
- Rendimento: 10.0 Km/l
##### Saída
- Quantidade de litros(Distância / Rendimento): ```{rust} 400.0 /. 10.0 -> 40.0```
- Custo (Quantidade de litros * Preço do litro): ```{rust}40.0 *. 5.0 -> 200.0```

###### Implementação
```Rust
fn custo_combustivel(
	distancia: Float, 
	preco_do_litro: Float, 
	rendimento: Float
) -> Float {
	{distancia /. rendimento} *. preco_do_litro
}
```

##### Verificação
Como verificar se a implementação faz o esperado?
testando os exemplos
```{Rust}> custo_combustivel(400.0, 5.0, 10.0) -> 200.0```

##### Ex. 2
Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube
que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da
Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer
o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até
70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o
carro com gasolina. Você pode ajudar a Márcia também?

O problema é que a forma de avaliar expressões, atualmente não possui uma forma de condicional.

Solução após condicionais:
```Rust

```

## Condicional
A maioria das linguagens tem `if` para realizar condicionais, mas Gleam não o possui, ao invés disso, usa-se o `case` que é uma forma mais genérica de seleção. Suponde que Gleam tem if, a sua forma geral seria:
```Rust
if expressão {
	expressão...
} else {
	expressão...
}

// Exemplos
if 4 > 2 { 10 + 2 } else { 7 * 3 }
12

if 10 == 12 { 10 + 2 } else { 7 * 3 }
21
```

### Diferença `if` em relação a outras linguagens
O `if` anterior **produz** um valor. Na maioria das outras linguagens, um `if` é uma sentença que não produz resultado, mas altera o estado do programa.

### Fazendo Seleção Usando Case
Forma inicial de um case:
```Rust
case expressão {
	True -> expressão
	False ->
}
```

### Regra de avaliação do `Case`
- Avalie a expressão examinada
	- ```{Rust} if x > y {}``` 
	- `x > y` é a expressão
- Se o valor da expressão for `True`, substituir toda a expressão do case pela expressão do caso `True`
- senão, substituir toda a expressão pelo caso `False`

Exemplo Valor Absoluto:
```math
||{"id":1678858376614}||
 \text{abs}(x) = \begin{cases} x & \text{se } x \geq 0 \\ -x & \text{caso contrário} \end{cases} 
```

```Rust
fn abs(x) {
	case x >= 0 {
		True -> x
		False -> -x
	}
}

abs(-4) // Substitui abs(-4) pelo corpo ...
case -4 >= 0 { // A expressão examinada é avaliada
	True -> -4
	False -> - { -4 }
}
case False { // Como a expressão examinada é False
	True -> -4 // o case é substituido pela expressão
	False -> - { -4 } // do caso False
}
- { -4 } // Reduz - { -4 } para 4
4
```

## Processo de Avaliação de Expressões (v1.0)
###### Uma *expressão* consiste de
- Um literal; ou
- Uma função primitiva; ou
- Um nome; ou
- ==Um case(forma especial); ou==
- Uma combinação (lista não vazia de ***expressões*** entre parênteses)
###### Regra para avaliação de expressão
- Literal -> valor que o literal representa.
- Função Primitiva -> Sequência de instruções de máquina associada com a função.
- Nome -> Valor associado com o nome no ambiente (memória que guarda as associações de nome -> valor)
- ==Forma especial -> Avaliar a forma especial utilizando sua regra específica de avaliação==
- Combinação/chamada de função
	- ***Avaliar cada expressão*** da combinação (reduzir cada expressão para um valor)
	- Se o operador é uma função primitiva, aplicar os argumentos.
	- Senão (operador é uma função composta), ***avalie*** o corpo da função ***substituindo*** cada ocorrência do parâmetro pelo argumento
##### Ex. do Sinal
Defina a função sinal que determina o sinal de um número inteiro. Ela deve funcionar para os seguintes casos:
```Rust
> sinal(4)
1
> sinal(0)
0
> sinal(-7)
-1
```
Resposta
```Rust
fn sinal(x) {
	case x > 0 {
		True -> 1
		False ->
			case x == 0 {
				True -> 0
				False -> -1
			}
	}
}
```

##### Ex. do and
Defina a função and que recebe os argumentos booleanos x e y e produz como resposta o e lógico entre eles, isto é
```Rust
> and(False, False)
False
> and(False, True)
False
> and(True, False)
False
> and(True, True)
True
```
Resposta:
```Rust
pub fn and(x: Bool, y: Bool) -> Bool {
   case x {
		False -> False
		True -> y
   }
}
```

##### Ex. or
Defina a função or que recebe os argumentos booleanos x e y e produz como resposta o ou lógico entre eles, isto é:
```Rust
> or(False, False)
False
> or(False, True)
True
> or(True, False)
True
> or(True, True)
True
```
Resposta:
```Rust
pub fn or(x: Bool, y: Bool) -> Bool {
   case x {
     True -> True
     False -> y
   }
}
```

###### Problemas ao definir 'ou' e 'e' como funções
Serão avaliados como funções, logo perdem as otimizações já implementadas na maioria das linguagens. no `E`, caso o primeiro seja falso, o segundo não precisa ser avaliado. Já no `OU`, se o primeiro for ```{lisp}#t``` não precisa avaliar o resto. Essa otimização é chamada de **avaliação em curto-circuito** que é um tipo de #avaliação-preguiçosa ou #lazy-evaluation

#### Curto-Circuito
Essas otimizações são conhecidas como ***Curto-Circuito***, muito utilizadas para condições dependentes, ex: ```{js} x != 0 && 10 / x == 2```. 

# Operadores Lógicos
Predicados podem utilizar as formas especiais ```{Rust} &&(and) ||(or) !(not)```
- Negação tem prioridade menor que os operadores relacionais.
- Operador && tem maior prioridade do que ||.

```Rust
// Not
!True
False

bool.negate(2 == 4)
True

!{ 3 > 4 }
True

// And
3 > 4 && 2 == 1 + 1
False

// Or
> 3 > 4 || 2 == 1 + 1
True
```

###### and
```lisp title:"Forma geral do AND"
(and <e1> ... <en>)
```
###### Avaliação do and &&
- Avalie a expressão a esquerda de &&, se o valor for `False`, substitua toda a expressão &&
por `False`
- Senão, substitua toda a expressão && pela expressão à direita de &&

###### Avaliação do or ||
- Avalie a expressão a esquerda de `||`, se o valor for True, substitua toda a expressão `||` por True
- Senão, substitua toda a expressão `||` pela expressão à direita de `||`

# Igualdade
Conceito que diz se dois valores são "iguais"

Em Gleam, dois valores são iguais se eles são estruturalmente iguais.
O operador de diferente (negação da igualdade) é !=.
Exemplos:
```Rust
// Igualdade
> 10 == 9 + 1
True
> 3.0 + 1.0 == 4.0
True
> 10 == 10.0
error: Type mismatch

> ["a", "c", "b"] == ["a", "c", "b"]
True
> [[], [1, 2]] == [[], [1, 2]]
True
> [[], [1, 2]] != [[], [1, 2]]
False
```

___

## Referências

- Seção 1.1 - [The Elements of Programming](https://web.mit.edu/6.001/6.037/sicp.pdf#section.1.1) do livro SICP
- [Tour da Linguagem Gleam](https://tour.gleam.run/)
- [Biblioteca Padrão Gleam](https://hexdocs.pm/gleam_stdlib/)
