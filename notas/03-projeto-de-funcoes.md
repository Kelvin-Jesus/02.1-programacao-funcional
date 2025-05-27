---
tags:
  - faculdade
  - computacao/funcao
  - computacao/funcional
date: 2025-04-22
---
# 03 - Projeto de Funções

## Processo de Projeto de Funções
Assim como na matéria de [[03 - Projeto de funções|algoritmos]], o seguinte processo será utilizado:
- **Análise**
- **Definição dos tipos de dados**
- **Especificação**
- **Implementação**
- **Verificação**
- **Revisão**
Inspirado no livro [How to Design Programs(Cap. 3)](https://htdp.org)

## Etapas
As etapas são dependentes e com objetivos próprios.
- **Análise**: Identificação do problema a ser resolvido
- **Definição dos tipos de dados**: Definição dos tipos primitivos(ou tipos definidos pelo usuário) que serão utilizados para representar as informações
- **Especificação**: Dizer com clareza e precisão o que a função deve fazer
- **Implementação**: Escrita do código baseado na ***especificação***
- **Verificação**: Verificar se a ***implementação*** está de acordo com a ***especificação***
- **Revisão**: Identificação e realização de melhorias na ***especificação*** e ***implementação***

\# Normal perceber que faltou algo na especificação enquanto está na implementação.
\# Evitar a implementação diretamente

### Esse processo serve para função, como projetar programas?
Programas são compostos de diversas funções, é necessário decompor o programa em funções menores e realizar o [[04 - Projeto de Funções#Processo de Projeto de Funções|processo de projetar funções]].

## Exemplo-01:
Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até 70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o carro com gasolina. Você pode ajudar a Márcia também?

### Análise
Alguns itens devem ser avaliados para a realização da análise
- Quais informações são relevantes e quais são descartáveis?
- Existência de omissão
- Existência de ambiguidade
- Quais os conhecimentos do domínio do problema são necessários?
- O que deve ser feito?

#### Resultado
Determinar o combustível que será utilizado. Se o preço do álcool for até 70% do preço da gasolina, então deve-se usar o álcool, senão a gasolina.

### Definição dos Tipos de Dados
- Quais são as informações envolvidas no problema?
- Como as informações serão representadas?

#### Resultado
Informações: Preço do litro e o tipo do combustível

##### Representações
Preço é um número positivo 
Combustível é um dos valores:
- "Álcool"
- "Gasolina"
```Gleam
/// Preço do litro do combustível, deve ser um número positivo
type Preco = Float

/// O tipo do combustível deve ser "álcool" ou "gasolina"
type Combustivel = String
```

## Especificação
Na especificação é preciso ter:
- Assinatura da função (nome da função, parâmetros e seus tipos e tipo da saída)
	- Apenas nome e os argumentos da função não são o suficiente para uma boa especificação. 
- Propósito
	- O que a função faz, ao invés do como.
- Exemplos de entrada e saída
	- Testar as principais possibilidades.
	- Um exemplo para cada possível mudança nos valores.

Na especificação é importante utilizar os nomes dos parâmetros, assim fica claro como a entrada(argumento) se associa com a saída.

Para saber se a especificação está boa o suficiente, perguntar se outro desenvolvedor entenderá mesmo sem possuir o contexto da sua criação.

Pensar em etapas é a melhor forma de chegar na resposta.

###### Resultado
```Gleam
/// Encontra o combustivel que deve ser utilizado no abastecimento. 
/// Produz "Alcool" se *preco_alcool* for até 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.

// Exemplos:
// Álcool 3.00, Gasolina 4.00, produz “Gasolina” (3.00 < 0.7 × 4.00 é 
// falso)
// Álcool 2.90, Gasolina 4.20, produz “Alcool” (2.90 < 0.7 × 4.20 é 
// verdadeiro)
// Álcool 3.50, Gasolina 5.00, não está claro na especificação o que fazer
// quando o preço do álcool é exatamente 70% (3.50 = 0.7 × 5.00)
	
fn seleciona_combustivel(preco_alcool: Preco, preco_alcool: Preco) -> Combustivel {
	todo
}
```

Na especificação não está claro o que deve ser feito quando preço do álcool for exatamente 70% ($3.50 = 0.7 \times 5.00$). Nesse caso, é necessário melhorar a especificação. Será definido que quando for 70%, resultado será álcool.

```Gleam
/// Encontra o combustivel que deve ser utilizado no abastecimento. 
/// Produz "Alcool" se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.
```

## Propósito
Descreve ***O QUE*** a função faz ao invés do ***COMO***(é a implementação).

### exemplos:
- ***Número é par***. O quê: Verifica se é par. Como: Resto da divisão por 2 e compara com 0.
- ***Ordenação***. O quê: Ordena. Como: com merge sort.

## Implementação
- É necessário algum conhecimento específico do Domínio? Se sim, listar os problemas
- Existência de casos distintos. Caso haja, listá-los
- É uma composição de funções? Pensar de forma "***Desejosa***"(supor que as funções já existem)
- Os dados tem autorreferência? Analisar os casos base e as chamadas recursivas

```Gleam
/// Encontra o combustivel que deve ser utilizado no abastecimento. 
/// Produz "Alcool" se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.

fn seleciona_combustivel(preco_alcool: Preco, preco_gasolina: Preco) -> Combustivel {
	case preco_alcool <=. {0.7 * preco_gasolina} {
		True -> "Alcool"
		False -> "Gasolina"
	}
}
```

## Verificação
A função produzir uma resposta correta para alguns exemplos não implica que ela esteja correta.

O objetivo dos exemplos é ajudar quem está projetando a função a entender como a saída se relaciona com a entrada e demonstrar o funcionamento da função, o que ajuda a ter uma especificação mais clara.

Fazer mais verificações, seja com testes de propriedades(`@TODO` - pesquisar), fuzzing, etc.

```Gleam
import sgleam/check

/// Preço do litro do combustível, deve ser um número positivo
type Preco = Float

/// O tipo do combustível deve ser "álcool" ou "gasolina"
type Combustivel = String

/// Encontra o combustivel que deve ser utilizado no abastecimento. 
/// Produz "Alcool" se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.
fn seleciona_combustivel(preco_alcool: Preco, preco_gasolina: Preco) -> Gasolina {
	case preco_alcool <=. {0.7 preco_gasolina} {
		True -> "Alcool"
		False -> "Gasolina"
	}
}

fn seleciona_combustivel_examples() {
	check.eq(seleciona_combustivel(3.0, 4.0), "Gasolina")
	check.eq(seleciona_combustivel(2.9, 4.2), "Alcool")
	check.eq(seleciona_combustivel(3.5, 5.0), "Alcool")
}
```

### Porque um teste pode falhar?
- Teste está errado
- Implementação errada
- Ambos

## Revisão
- É possível melhorar a especificação e o código?
- É possível simplificar eliminando casos especiais(generalizando)?
- Possível criar abstrações(definir constantes e funções)?
- Possível renomear algum objeto?

## Referências
• [Vídeos BSL](https://www.youtube.com/playlist?list=PL6NenTZG6Krqu5RRQi3TUGc605rrGGGWw)
• [Vídeos How to Design Functions](https://www.youtube.com/playlist?list=PL6NenTZG6KroMpbQDFNmv6YuydU1DTklw)

## Exercícios
[[03-exercicios|Exercícios]]
