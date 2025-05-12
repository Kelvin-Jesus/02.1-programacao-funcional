---
date: 2025-04-03
tags:
  - 2-ano
  - faculdade
  - programacao-funcional
  - paradigma
  - imperative-funcional
---
# 02 - Introdução

## O que é?
### O que é Programação Imperativa?
Um [[Programming Paradigm|paradigma]] em que o código é escrito com sentenças ( #axiomas, máximas, proposições, provérbios) que tem como finalidade alterar o estado do programa
### O que é programação Funcional?
- Um [[Programming Paradigm|paradigma]] onde os programas são descritos com aplicação e composição de funções
- Evita mudança de estado
- Evita [[04 - areas/computer science/Efeitos Colaterais|efeitos colaterais]]

## Por quê?
- Paradigmas são apenas ferramentas
- Conhecer múltiplas permite utilizar a mais adequada para o problema
- Compartilhamento de dados junto com mudança de estado é difícil

## Mudança de Estado
###### Qual valor de `lista`?
```python
lista = [0] * 3
print(lista) # [0, 0, 0]

lista[1] = 10
print(lista) # [0, 10, 0]
```
###### Qual o valor de `lista`?
```python
lista = [[0]] * 3
print(lista) # [[], [], []]

lista[1].append(2)
print(lista) # [[2], [2], [2]]
```

```python
def adicionaTodos(destino: list[int], fonte: list[int]) -> None:
	'''
	Adiciona todos os elementos
	de *fonte* no final
	de *dest*.
	'''
	for x in fonte:
		destino.append(x)
```
###### Qual o valor de `lista`?
```python
lista = [4, 3, 1]
adicionaTodos(lista, [6, 2])
print(lista) # [4, 3, 1, 6, 2]

adicionaTodos(lista, lista)
print(lista) # Loop infinito
```
###### Essas duas definições são equivalente?
```python
def somaIndices(lista: list[int], a: int, b: int) -> int:
	return indice(lista, b) + indice(lista, a)

def somaIndices(lista, list[int], a: int, b: int) -> int:
	return indice(lista, a) + indice(lista, b)
```
Depende da função `indice`.

\# Testar um código com efeitos colaterais é mais difícil, pois há a necessidade de olhar o que foi modificado pelo efeito colateral.

### Pensar Localmente
Usar ***mudança de estado*** e ***efeitos colaterais*** dificulta ***pensar localmente*** sobre o funcionamento de um trecho de código

Mas, utilizando um código sem mudança de estado e sem efeitos colaterais, é possível ***pensar localmente***

## Como
1. Escolhendo uma linguagem
2. Estudando as construções do paradigma e as referências da linguagem 
3. Praticar lendo e escrevendo código

## Como faremos uso da Programação Funcional?
1. Escolhendo uma linguagem
	- <mark class="purp">Student Gleam</mark> (Variante do [[Gleam|Gleam]])
	- Simples
	- Bom suporte ao paradigma funcional
	- Inferência de tipo
	- Fácil Instalação
2. Estudando seus paradigmas e referências da linguagem
	- [A Tutorial Introduction to the Lambda Calculus](https://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)
	- Livro [How to Desing Programs](https://htdp.org/)
	- [Tour da Linguagem Gleam](https://tour.gleam.run)
	- Livro [Structure and Interpretation of Computer Programs](https://web.mit.edu/6.001/6.037/sicp.pdf)
	- [Documentação](https://hexdocs.pm/gleam_stdlib/) da biblioteca padrão de Gleam
3. Praticar escrevendo e lendo muito código
	- Muitos exemplos
	- Muitos exercícios

```rust title:"Código racket"
import gleam/io

pub fn dobro(x: Int) -> Int {
	x * 2
}

pub fn main() {
	io.debug(dobro(4))
}
```

O código define uma expressão chamada `dobro` que declara `x` como parâmetro e retorna `x * 2`.

Para testar as definições, utilizar o <mark class="purp">REPL</mark> (Read Eval Print Loop)
- Expressão de entrada (Read)
- Expressão é avalida (Eval)
- O resultado da expressão é impresso (Print)
- Repete o processo (Loop)
___
## Leitura Recomendada
Tour da Linguagem Gleam: https://tour.gleam.run/
Programação Funcional: https://en.wikipedia.org/wiki/Functional_programming

###### Extra
The Python Paradox: http://www.paulgraham.com/pypar.html
Revenge of the Nerds: http://www.paulgraham.com/icad.html
Beating the Averages: http://www.paulgraham.com/avg.html