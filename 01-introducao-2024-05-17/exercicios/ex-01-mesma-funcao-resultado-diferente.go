package main

// Defina uma função f em uma linguagem qualquer de maneira que o resultado de f(1) + f(2) seja
// - diferente do resultado de f(2) + f(1). Que recurso da linguagem você utilizou para que isso fosse
// - possível?
// R: Utilizei uma variável global(compartilhamento de estado) para armazenar a quantidade de vezes que a função foi executada.
//    Cada execução incrementa essa variável(efeito colateral).

var count = 0

func main() {
	println(f(1) + f(2))
	println(f(2) + f(1))
}

func f(a int) int {
	count++
	return a + count
}
