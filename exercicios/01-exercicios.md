# 02.1 - exercicios
## Começando
1) O que é programação imperativa?
	Programação baseada em sentenças que alteram o estado do programa
2) O que é programação funcional?
	Forma diferente de programar, baseada no aplicação de funções assim como na matemática, toda função mapeia dados de entrada para dados de saída, evitando mudança de estado.
3) O que é efeito colateral?
	Toda mudança externa à entrada e saída da função, io, modificar uma variável global, ler e escrever em um arquivo, tudo isso são exemplos de efeitos colaterais
4) O que é um REPL?
	Read -> Eval -> Print -> Loop. Basicamente um ambiente interativo de programação.
5) O Alberto disse que não tem interesse em aprender programação funcional em Gleam pois “ninguém” usa Gleam na prática. Explique para o Alberto porque esse argumento não faz sentido.
	A importância da matéria está em aprender os conceitos do paradigma e que podem vir a ser utilizados em diversas outras linguagens.

## 02 - Praticando
6) Abra o [playgroud do sgleam](https://malbarbo.pro.br/sgleam/play.html) no navegador e teste os exemplos do material.
7) Instale o sgleam no seu computador e teste os exemplos do material.
8) Veja o conteúdo básico do tour do Gleam
9) Qual a sua primeira impressão da linguagem Gleam?

## 03 - Avançando
10) Defina uma função f em uma linguagem qualquer de maneira que o resultado de f(1) + f(2) seja diferente do resultado de f(2) + f(1). Que recurso da linguagem você utilizou para que isso fosse possível
	Utilizei uma variável global(compartilhamento de estado) para armazenar a quantidade de vezes que a função foi executada. Cada execução incrementa essa variável(efeito colateral).
```Go
package main

var count = 0

func f(x int) int {
	count++
	return a + count
}

func main() {
	println(f(1) + f(2))
	println(f(2) + f(1))
}
```
11) Que dificuldades os efeitos colaterais podem gerar no desenvolvimento de um programa?
	Dificulta pensar localmente, forçando a toda vez precisar ler o código fonte de cada função para garantir que ela não altere um valor que você pode estar utilizando
12) Que dificuldades a ausência de mudança de estado podem gerar no desenvolvimento de um programa?
	Programas mais complexos, uso maior de memória e implementação de algoritmos que normalmente são imperativos
