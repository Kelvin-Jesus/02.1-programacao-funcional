#functional-programming #functions #programacao-funcional #faculdade 
___

# 05 - Tipos de Dados

## Introdução

Esta é a segunda etapa do [[04 - Projeto de Funções|Projeto de Funções]], nesta etapa trata-se da definição dos tipos de dados, que pode ser resumido como:
- Identificação das informações do problema
- Como representar essas informações dentro do programa.

Em muitos casos, o tipo guiará o restante das etapas.

A necessidade de definir corretamente a forma de representação de uma informação, está ligada aos erros não previstos que um tipo incorreto pode causar. Uma boa definição evita bugs, eliminando toda uma classe de erros.

## Definição

O ***tipo de um dado*** se dá pelo conjunto de possíveis valores que esse dados podem representar.

Exemplos:
- Booleano = $\{\text{verdadeiro, falso}\}$
- Combustível = $\{\text{alcool, gasolina}\}$
- Natural = $\{0, 1, 2, ...\}$
- Inteiro = $\{..., -2, -1, 0, 1, 2, ...\}$
- String = $\{'', 'a', 'b', ...\}$
- String que começa com a = $\{'a', 'aa', 'ab', ...\}$

## Requisitos

Como definir corretamente se um **tipo** é **adequado/ideal** para aquela **informação**?

O tipo  ```{C icon}unsigned int```***C*** é ideal para representar a quantidade de pessoas em um planeta?
- Não, pois um inteiro pode representar negativos, ou seja, permite valores inválidos.
- Não, pois um inteiro sem sinal em C é de 32bits, não consegue representar todos os valores válidos, cerca de *4.294.967.296* possibilidades.
- O tipo `natural` seria o ideal, pois representa todos as possibilidades e não permite valores negativos.

Diretrizes a seguir para definir um tipo de dado:
- Fazer os valores válidos serem representáveis.
- Fazer os valores inválidos serem irrepresentáveis.

Fazer valores inválidos serem irrepresentáveis elimina toda uma classe de erros relacionados ao tipo escolhido.

### Exemplo Combustível
No exemplo do [[04 - Projeto de Funções#Verificação|Combustível]], os tipos definidos foram:
```Rust
/// O preço do litro do combustível, deve ser um número positivo.
type Preco = Float

/// O tipo do combustível, deve ser "Álcool" ou "Gasolina"
type combustivel = String
```

Mas esses tipos estão de acordo com as diretrizes? Não.

## Enumerações

Um tipo enumerado deve ser utilizado quando todos os possíveis valores podem ser listados.

Forma geral de um Enum em Gleam:
```Rust
[pub] type NomeDoTipo {
	Valor1
	Valor2
	...
}
```

O Enum pode 0 ou mais valores possíveis.

\# OBS: O nome do tipo e dos valores deve começar com letra maiúscula.

Tipo enumerado do Combustível:
```Rust
pub type Combustivel {
	Alcool
	Gasolina
}
```

Assim como valores booleanos é possível utilizar o `case` em tipos enumerados
```Rust
pub fn msg_combustivel(
	combustivel: Combustivel
) -> String {
	case combustivel {
		Alcool -> "Use álcool"
		Gasolina -> "Use gasolina"
	}
}
```

Análise de case em enumerações é exaustiva, sempre deve-se checar todos os possíveis valores

### Exemplo Tíquete do RU da UEM

O RU da UEM cobra um valor por tíquete que depende da relação do usuário com a universidade.
Para alunos e servidores que recebem até 3 salários mínimos o tíquete custa R$ 5,00, para
servidores que recebem acima de 3 salários mínimos e docentes, R$ 10,00, para pessoas da
comunidade externa, R$ 19,00. Como parte de um sistema de cobrança você deve projetar uma
função que determine quanto deve ser cobrado de um usuário por um quantidade de tíquetes.  

Análise:
- Determinar quanto deve ser cobrado de um usuário por uma quantidade de tíquetes
- O usuário pode ser aluno ou servidor (até 3 sal) - R$ 5, servidor (acima de 3 sal) ou docente - R$ 10, ou externo - R$ 19.  

Definição de tipos de dados:
- As informações são a quantidade, o tipo de usuário e o valor que deve ser cobrado.

```Rust
/// O tipo de usuário do RU da UEM.
pub type Usuario {
	Aluno
	// Servidor que recebe até 3 salários mínimos.
	ServidorAte3
	// Servidor que recebe mais do que 3 salários mínimos.
	ServidorMais3
	Docente
	Externo
}

/// Determina o custo de *quantidade* tíquetes para um usuário do tipo *usuario*.
/// O custo de um tíquete é
/// - Aluno          5.0
/// - ServidorAte3   5.0
/// - ServidorMais3 10.0
/// - Docente       10.0
/// - Externo       19.0
pub fn custo_tiquetes(usuario: Usuario, quantidade: Int) -> Float {
	let quantidade_em_float = int.to_float(quantidade)
	case usuario {
		Aluno, ServidorAte3 -> 5.0 *. quantidade_em_float
		ServidorMais3, Docente -> 10.0 *. quantidade_em_float
		Externo -> 19.0 *. quantidade_em_float
	}
}

pub fn custo_tiquetes_examples() {
	check.eq(custo_tiquetes(Aluno, 3), 15.0)
	check.eq(custo_tiquetes(ServidorAte3, 2), 10.0)
	check.eq(custo_tiquetes(ServidorMais3, 2), 20.0)
	check.eq(custo_tiquetes(Docente, 3), 30.0)
	check.eq(custo_tiquetes(Externo, 4), 76.0)
}
```

Para os testes, quantos exemplos são necessários?
- No mínimo um para cada possível valor do tipo enumerado.

Qual a forma padrão para uma função que processa um tipo enumerado?
- Um case para cada valor do Enum.

## Estruturas

Até aqui só foram utilizados os tipos #atomicos(que não podem ser decompostos).

Quando dois ou mais valores **devem** ficar juntos, o tipo a ser utilizado será `estrutura` ou `dados compostos`.

Exemplos:
- Registro de um aluno.
- Placar de um jogo de futebol.
- Informações de um produto.

São conhecidos como ***dados compostos*** ou ***estruturas***.

Forma geral de uma **estrutura**:
```Rust
[pub] type NomeDoTipo {
	NomeDoTipo([campo1:] Tipo1, [campo2:] Tipo2, ...)
}
```

Exemplos citados acima:
```Rust
import sgleam/check

pub type Placar {
  Placar(time_da_casa: Int, time_de_fora: Int)
}

pub fn devolve_placar() -> Placar {
  Placar(10, 2)
}

pub fn devolve_placar_examples() {
  check.eq(devolve_placar(), Placar(10, 2))
}

pub type Aluno {
  Aluno(ra: String, nota: Int)
}

pub fn aluno(ra: String, nota: Int) -> Aluno {
  Aluno(ra, nota)
}

pub fn aluno_examples() {
  check.eq(aluno("RA118252", 80), Aluno("RA118252", 80))
}

pub type Produto {
  Produto(nome: String, descricao: String, preco: Float)
}

pub fn novo_produto(nome: String, descricao: String, preco: Float) -> Produto {
  Produto(nome, descricao, preco)
}

pub fn novo_produto_examples() {
  check.eq(
    novo_produto("Teclado Aula F75", "Teclado Mecânico Tri-Mode", 270.5),
    Produto("Teclado Aula F75", "Teclado Mecânico Tri-Mode", 270.5),
  )
}
```

Quando usar?
- Quando a informação é basicamente dois ou mais itens que juntos descrevem uma entidade.

Utilizando um ponto em um plano cartesiano como exemplo.

### Operações

```Rust
/// Definição
type Ponto {
	Ponto(x: Int, y: int)
}

/// Construção
> let p1: Ponto = Ponto(x: 2, y: 5)
> let p2 = Ponto(8, 2)
> p2
Ponto(x: 8, y: 2)

/// Acesso aos campos
> p1.x + p1.y
4

/// Desestruturação
// Pela posição
let Ponto(x, y) = p2
> x
8
> y
2

// Pelo rótulo
> let Ponto(y: a, ..) = p2
> a
2
> let Ponto(y:, ..) = p2
> y
2

/// Comparação
> p1 == Ponto(3, 4)
False
> p1 != p1
False
> p1 != p2
True

/// Inspeção
> string.inspect(p1)
"Ponto(x: 2, y: 5)
```

### Definindo Estruturas

Sempre descrever o propósito da estrutura e dos campos
```Rust
/// Um ponto no plano cartesiano.
type Ponto {
	// x e y são as coordenadas dos pontos.
	Ponto(x: Int, y: Int)
}
```

### Atualizando campos

A forma correta é criando uma nova instância com o campo alterado.
```Rust
> let p1 = Ponto(3, 4)
> let p2 = Ponto(p1.x, 5)
> p2
Ponto(X: 3, y: 5)
```

Quais as limitações desse método?
- Caso haja muitos campo, todos precisam ser especificados
- Se a alteração for de adicionar ou remover um campo, então todas as operações de "cópia" devem ser atualizadas.

Gleam tem uma sintax especial para isso:
```Rust
> let p1 = Ponto(3, 4)
> let p2 = Ponto(..p1, y: 5)
p2
Ponto(x: 3, y: 5)

> let p3 = Ponto(..p1, x: 7)
> p3
Ponto(x: 7, y: 4)

// Mais que um campo(não faz sentido nesse exemplo pois há somente 2 campos)
> Ponto(..p1, x: 1, y: 2)
Ponto(x: 1, y: 2)
```

### Exemplo - Campo Minado


## Uniões

Projete uma função que exiba uma mensagem sobre o estado de uma tarefa. Uma tarefa pode
estar em execução, ter sido concluída em uma duração específica e com um mensagem de
sucesso, ou ter falhado com um código e uma mensagem de erro.

Como representar o estado de uma tarefa?

Tentando com uma estrutura.

```Rust
/// O estado de uma tarefa.
type EstadoTarefa {
	EstadoTarefa(
		// True se a tarefa está em execução, False caso contrário.
		executando: Bool,
		// Em caso de sucesso
		duracao: Int,
		msg_sucesso: String,
		// Em caso de erro
		codigo_erro: Int,
		msg_erro: String
	)
}
```

Essa implementação tem um problema...
Possibilidade de representar estados inválidos.

- Exemplo:
```Rust
EstadoTarefa(True, 10, "Ótimo desempenho", 123, "Falha na conexão")
```
Qual o significado do estado acima? Não há como saber.

Como evitar?

Separando os estados em casos únicos:
- Em execução
- Sucesso, com uma mensagem e uma duração
- Erro, com uma mensagem e um código

Esses casos são excludentes, ou seja, se a tarefa se enquadra em um deles, não devemos
armazenar informações sobre os outros (caso contrário, seria possível criar um estado
inconsistente).

Para representar esse tipo de dados o correto é utilizar União de Tipos.

### Tipos de dados como Conjunto de Valores
Um tipo de dado pode ser pensado como um "conjunto de possíveis valores". Exemplo:
- Tipo ```{Rust} Bool``` é um conjunto que tem apenas dois valores: ```{Rust}{True, False}```.
- Tipo ```{Rust}Int``` é um conjunto que inclui todos os números inteiros: `{Rust}{..., -3, -2, -1, 0, 1, 2, 3, ...}`.

### Estrutura - Tipo Produto (Produto Cartesiano de Conjuntos)
Combinação de múltiplos tipos em um só, essa combinação forma pares ou tuplas de valores.
Imagine dois conjunto, A e B:
A = {1, 2}
B = {x, y}

O produto cartesiano A x B é o conjunto de todos os pares possíveis (a, b), onde a é de A e b é de B. Portanto, A x B = {(1, x), (1, y), (2, x), (2, y)}.

### União - Tipo Soma (União de Conjuntos)
Representa uma escolha entre diferentes tipos, o valor será de um tipo ou de outro tipo.

Imagine dois conjuntos, C e D:
C = {red, blue}
D = {circle, square}
A união C $\cup$ D é um conjunto que pode ser qualquer valor de C ou de D, ou seja, {red, blue, circle, square}

### Tipo Algébrico de Dado (Tipo Soma de Tipos Produtos)
Combina tipo soma e tipo produto. é um tipo que pode ser construído de diversas formas, cada forma é um tipo produto.

#### Exemplo antigo
Imagine um exemplo de um tipo de dado que representa uma **forma geométrica**. Essa forma pode ser:

• Um Círculo com um raio (r).
• Um Retângulo com largura (w) e altura (h).

Cada forma é um tipo produto (por exemplo, Círculo com um campo raio e Retângulo com campos largura e altura), e o tipo Forma é um tipo soma que pode ser **um Círculo ou um Retângulo**.

Exemplo em Python:
```python
from typing import Union, NamedTuple

class Circulo(NamedTuple):
    raio: float

class Retangulo(NamedTuple):
    largura: float
    altura: float

Forma = Union[Circulo, Retangulo]
```
Aqui, Forma é um **tipo algébrico de dado**:

• É um tipo soma (Union) de:
	• Um tipo produto Circulo.
	• Outro tipo produto Retangulo.

1. **Tipo Produto**: Combina múltiplos tipos em um só, como pares ou tuplas. Representa um conjunto de todas as combinações possíveis de valores desses tipos.

2. **Tipo Soma**: Representa uma escolha entre múltiplos tipos. Pode ser um valor de um tipo ou de outro.

3. **Tipo Algébrico de Dado**: Combina tipos soma e tipos produto para modelar dados complexos de maneira flexível.

Entender essa relação ajuda a definir os tipos de dados.

### Forma geral para definições de tipos de dados em Gleam
```Rust
[pub | pub opaque] type NomeDoTipo {
	Caso1[([campo1:] Tipo1, [campo2:] Tipo2, ...)]
	Case2[([campo1:] Tipo1, [campo2:] Tipo2, ...)]
	...
}

[pub] type NomeDoTipo {
	Valor1
	...
}

[pub] type NomeDoTipo {
	NomeDoTipo([campo1:] Tipo1, [campo2:] Tipo2, ...)
}
```

Voltando ao exemplo do Estado da Tarefa:
```Rust
/// O estado de uma tarefa
type EstadoTarefa {
	// A tarefa está em execução
	Executando
	// A tarefa finalizou com sucesso
	Sucesso(duracao: Int, msg: String)
	// A tarefa finalizou com falha
	Falha(codigo: Int, msg: String)
}

// Impossível acessar as formas vistas anteriormente
> let tarefa: EstadoTarefa = Executado
> tarefa.msg
> 1 │ tarefa.msg
    │ ^^^^ This field does not exist
```

Como acessar? Usando casamento de padrão com case
```Rust
/// Devolve -1 se não tem duracao.
> pub fn duracao(tarefa: EstadoTarefa) -> Int {
	case tarefa {
		Sucesso(duracao, _) -> duracao
		_ -> -1
	}
}
> duracao(Executando)
-1
> duracao(Sucesso(10, "Recuperação exitosa."))
10
> duracao(Falha(-23, "Arquivo não existente."))
-1
```

#### Especificação
```Rust
/// Produz uma string amigável para o usuário para descrever o estado da tarefa.
pub fn msg(tarefa: EstadoTarefa) -> String
```

#### Exemplos
Ao menos um para cada possível valor
```Rust
pub fn msg_examples() {
	check.eq(
		mensagem(Executando),
		"A tarefa está em execução."
	)
	check.eq(
		mensagem(Sucesso(12, "Os resultados estão corretos.")),
		"Tarefa concluída (12s): Os resultados estão corretos."
	)
	check.eq(
		mensagem(Erro(123, "Número inválido '12a'.")),
		"A tarefa falhou (erro 123): Número inválido '12a'."
	)
}
```

#### Resultado
```Rust
pub fn mensagem(estado: EstadoTarefa) -> String {
	case estado {
		Executando ->
		"A tarefa está em execução."
		Sucesso(duracao, msg) ->
		"Tarefa concluída (" <> int.to_string(duracao) <> "s): " <> msg
		Erro(codigo, msg) ->
		"A tarefa falhou (erro " <> int.to_string(codigo) <> "): " <> msg
	}
}
```

Foi discutido aqui como os tipos de dados guiam o processo de projetar programas:
- Um tipo soma com **N** casos sugere pelo menos **N** exemplos;
- Um tipo soma com N casos sugere um corpo com uma análise de **N** casos.

## Valores Opcionais e Erros
Ainda há alguns problemas a serem resolvidos e que não foram abordados nos exemplos anteriores.

- No problema do combustível, usar `{Rust}Float` não garante que o preço é maior que zero.
- No estado da tarefa usar `{Rust}Int` não garante que a duração é maior que zero.

### Resolvendo essas questões
No caso da duração, como representar um valor inteiro que pode ou não existir? Há apenas duas possibilidades, existe ou não existe, o ideal então é usar um **tipo união**.
```Rust
type Opcional {
	Nenhum
	Algum(Int)
}
```

Utilizando valores opcionais o código ficará:
```Rust
pub fn duracao(tarefa: EstadoTarefa) -> Opcional {
	case tarefa {
		Sucesso(duracao, _) -> Algum(duracao)
		_ -> Nenhum
	}
}

> duracao(Executando)
Nenhum
> duracao(Sucesso(10, "Recuperação exitosa."))
Algum(10)
> duracao(Falha(-23, "Arquivo não existente."))
Nenhum
```

Essa abordagem favorece a clareza do código e ajuda a evitar erros "acidentais".

#### Função Soma Um
Projete uma função que receba um opcional e some 1 ao valor se ele estiver presente.
```Rust
/// Soma 1 ao *valor* opcional
pub fn soma1(valor: Opcional) -> Opcional {
	case valor {
		Nenhum -> Nenhum
		Algum(n) -> Algum(n + 1)
	}
}

pub fn soma1_examples() {
	check.eq(soma1(Nenhum), Nenhum)
	check.eq(soma1(Algum(1)), 2)
}
```

#### Primeiro String
Projete uma função que devolva o primeiro caractere de uma string.
```Rust
type Opcional {
	Nenhum
	Algum(String)
}

/// Devolve o primeiro caractere da *str*
/// ou Nenhum se *str* for vazia.
pub fn primeiro(str: String) -> Opcional {
	case str {
	    "" -> Nenhum
	    _ -> Algum(string.slice(str, 0, 1))
	}
}

pub fn primeiro_examples() {
	check.eq(primeiro(""), Nenhum)
	check.eq(primeiro("a"), Algum("a"))
	check.eq(primeiro("teste"), Algum("t"))
	check.eq(primeiro("UMA STRING"), Algum("U"))
	check.eq(primeiro("Uma outra string"), Algum("U"))
}
```

O problema é que mesmo com o `Opcional` ainda é possível ter uma string vazia, que é basicamente o mesmo problema do preço e da idade.

Gleam tem o `{Rust} Optional` na stdlib como a forma de representar valores opcionais
```Rust
type Option(a) {
	None
	Some(a)
}
```

Esse "a" é chamado de parâmetro de tipo e são escritos com letra minúscula. É a mesma ideia de um "Generic", podendo receber qualquer tipo.

```Rust
import gleam/option.{type Option, Some, None}

pub fn soma1(valor: Option(Int)) -> Option(Int) {
	case valor {
		None -> None
		Some(n) -> Some(n + 1)
	}
}

pub fn primeiro(s: String) -> Option(String) {
	case s {
		"" -> None
		_ -> Some(string.slice(s, 0, 1))
	}
}
```

Em #rust o mais comum seria utilizar o #option mas em Gleam é mais comum utilizar o `Result`.

## Lidando com Erros

Como lidar funções que podem falhar?

Exemplo, uma função que converte uma string para um número pode falhar(nem toda string é um número válido), como resolver?

Abordagens comuns:
- Finalizar o programa
- Lançar exceção (Python, Java)
- ...
- Devolver um valor indicando erro

Em linguagens funcionais, a melhor opção é a última

O Tipo [[05 - Tipos de Dados#Valores Opcionais e Erros|Opcional]] poderia ser utilizado?
Sim, mas isso acaba limitando as possibilidades. Se há múltiplas maneiras(mais que duas) de uma função falhar, o tipo opcional não poderá cobrir todas.

Se uma função tentar escrever em um arquivo, existem diversas possíveis falhas, como: o arquivo não existe, usuário sem permissão, disco cheio, etc.

### Como resolver?
Definindo uma enumeração com dois casos, um caso para o quando resultar em sucesso e outro para o erro, ambos com um valor associado

Em Gleam existe o tipo `Result`:
```Rust
type Result(ok, error) {
	Ok(ok)
	Error(error)
}
```

Ler a documentação do Gleam sobre `Optional` x `Result`:
https://hexdocs.pm/gleam_stdlib/gleam/option.html

Resumindo, todas as funções que podem falhar, deverão retornar `Result` e o valor `Nil` será utilizado caso não exista nenhum detalhe extra a ser devolvido.
### Exemplos
```Rust
> int.parse("10.1")
Error(Nil)

> int.parse("241")
Ok(241)

> int.divide(12, 0)
Error(Nil)

> float.square_root(25.0)
Ok(5.0)

> float.square_root(-1.0)
Error(Nil)

> string.first("")
Error(Nil)

> string.first("case")
Ok("c")
```

### Exemplo Soma de String
Projete uma função que receba como parâmetro duas strings, e se as duas representarem
inteiros, devolva a soma dos valores em forma de string.

```Rust
/// Devolve o resultado da soma de *a* com *b*
/// e caso não tenha um inteiro válido, devolve um erro
pub fn soma(a: String, b: String) -> Result(String, Nil) {
	case int.parse(a), int.parse(b) {
		Ok(a), Ok(b) -> Ok(int.to_string(a + b))
		_, _ -> Error(Nil)
	}
}

pub fn soma_examples() {
	check.eq(soma("31", "4"), Ok("35"))
	check.eq(soma("31", "a"), Error(Nil))
	check.eq(soma("a", "4"), Error(Nil))
	check.eq(soma("a", "b"), Error(Nil))
}
```

### Validação

Como utilizar o `Result` para lidar com o preço que deve ser positivo?

Validando que o preço e devolvendo `Error` se um preço não positivo

## Referências
[Tipos de dados - notas de aula - Malbarbo](https://malbarbo.pro.br/arquivos/2024/11917/04-tipos-de-dados-notas-de-aula.pdf)
[Vídeos Compound Data](https://www.youtube.com/playlist?list=PL6NenTZG6KrpA-ww35EwcaxY-tgh82TAh)
[Videos Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)
[Making Impossible States Impossible](https://www.youtube.com/watch?v=IcgmSRJHu_8)
[Seções 5.1 a 5.5 do Guia Racket](http://docs.racket-lang.org/guide/define-struct.html)
