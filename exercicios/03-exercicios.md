# 04.1-exercicios

## Começando

**1) Quais são as etapas do processo de projeto de funções?**

- Análise
- Definição dos tipos de dados
- Especificação
- Implementação
- Verificação
- Revisão

**2) Qual é o propósito da análise?**  
Encontrar o problema a ser resolvido

**3) Qual é o propósito da definição dos tipos de dados?**  
Definir como serão representado as informações dentro do programa

**4) Quais são as partes que compõem a especificação de uma função?**  
Assinatura, propósito e exemplos de entrada e saída

**5) Qual é a principal propriedade que uma especificação deve ter para ser considerada adequada?**  
Outros desenvolvedores consigam olhar e realizar a implementação e verificação inicial

**6) O que é a assinatura de uma função?**  
O nome da função, os parâmetros e seus tipos, e que tipo de dado ela produz como saída

**7) Qual é o objetivo inicial dos exemplos no projeto de uma função? E os demais objetivos?**  
Demonstrar como a função mapeia os dados de entrada para os dados de saída. Checar se a função retorna os valores esperados. Demonstrar a outros programadores, como utilizar a função.

**8) Se não forem encontrados erros na verificação para os exemplos da especificação, é possível afirmar que a função está isenta de erros? Explique.**  
Não, é impossível afirmar, já que não será testados todos os valores de entrada possíveis, a ideia é cobrir os casos principais.

**9) A implementação é a fase mais importante do projeto de funções, verdadeiro ou falso? Explique.**  
Falso, pois as outras etapas auxiliam a chegar na corretude esperada da implementação, ir diretamente para a implementação provavelmente levará mais tempo

**10) Como proceder quando um teste falha?**  
Verificar se a especificação está correta e caso esteja, corrigi-la. Verificar se o código está correto

**11) Qual é o objetivo da revisão?**  
Encontrar possíveis melhorias para a implementação ou especificação

**12) Qual é a diferença do resultado da análise e a descrição do propósito da função?**  
A análise descreve o problema a ser resolvido, a descrição do propósito diz o que a função faz

## Praticando

**13) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.**

```Gleam
/// Produz True se uma pessoa com *idade* é isento da
/// tarifa de transporte público, isto é, tem menos
/// que 18 anos ou 65 ou mais. Produz False caso contrário.
pub fn isento_tarifa(idade: Int) -> Bool {
	False
}

pub fn isento_tarifa_examples() {
	check.eq(isento_tarifa(17), True)
	check.eq(isento_tarifa(18), True)
	check.eq(isento_tarifa(50), False)
	check.eq(isento_tarifa(65), True)
	check.eq(isento_tarifa(70), True)
}
```

Os testes continham um erro, quando a idade é 18 ele esperava que desse True, mas, a especificação diz que se tem 17 ou menos, é isento, entre 18 e 64 deve pagar.

Resultado:

```Gleam
import sgleam/check

/// Produz True se uma pessoa com *idade* é isento da
/// tarifa de transporte público, isto é, tem menos
/// que 18 anos ou 65 ou mais. Produz False caso contrário.
pub fn isento_tarifa(idade: Int) -> Bool {
  idade < 18 || idade >= 65
}

pub fn isento_tarifa_examples() {
  check.eq(isento_tarifa(17), True)
  check.eq(isento_tarifa(18), False)
  check.eq(isento_tarifa(50), False)
  check.eq(isento_tarifa(65), True)
  check.eq(isento_tarifa(70), True)
}
```

**10) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.**

```Gleam
/// Conta a quantidade de dígitos de *n*.
/// Se *n* é 0, então devolve zero.
/// Se *n* é menor que zero, então devolve a quantidade
/// de dígitos do valor absoluto de *n*.
pub fn quantidade_digitos(n: Int) -> Int {
	0
}
pub fn quantidade_digitos_examples() {
	check.eq(quantidade_digitos(123), 3)
	check.eq(quantidade_digitos(0), 1)
	check.eq(quantidade_digitos(-1519), 4)
}
```

Discordo da especificação, como o zero faz parte dos naturais, considerei ele como um dígito. agora, quando a função receber 0, devolve 1.

Resultado

```Gleam
import gleam/int
import gleam/string
import sgleam/check

/// Conta a quantidade de dígitos de *n*.
/// Se *n* é 0, então devolve um.
/// Se *n* é menor que zero, então devolve a quantidade
/// de dígitos do valor absoluto de *n*.
pub fn quantidade_digitos(n: Int) -> Int {
  string.length(int.to_string(int.absolute_value(n)))
}

pub fn quantidade_digitos_examples() {
  check.eq(quantidade_digitos(123), 3)
  check.eq(quantidade_digitos(0), 1)
  check.eq(quantidade_digitos(-1519), 4)
}
```

**11) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.**

```Gleam
/// Produz True se uma pessoa com *idade* é supercentenária,
/// isto é, tem 110 anos ou mais, False caso contrário.
pub fn supercentenario(idade: Int) -> Bool {
	False
}
pub fn supercentenario_examples() {
	check.eq(supercentenario(101), False)
	check.eq(supercentenario(110), False)
	check.eq(supercentenario(112), True)
}
```

Contém um erro na especificação(testes), onde ao aplicar o valor 110 a função deve produzir True, pois para ser considerada supercentenária deve ter 110 ou mais, ou seja, o 110 está incluso.

Resultado

```Gleam
import sgleam/check

// Produz True se uma pessoa com *idade* é supercentenária,
/// isto é, tem 110 anos ou mais, False caso contrário.
pub fn supercentenario(idade: Int) -> Bool {
  idade >= 110
}

pub fn supercentenario_examples() {
  check.eq(supercentenario(101), False)
  check.eq(supercentenario(110), True)
  check.eq(supercentenario(112), True)
}
```

12. Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

```Gleam
/// Transforma a string *data* que está no formato "dia/mes/ano"
/// para o formato "ano/mes/dia".
///
/// Requer que o dia e o mês tenham dois dígitos e que
/// o ano tenha quatro dígitos.
pub fn dma_para_amd(data: String) -> String {
	data
}
pub fn dma_para_amd_examples() {
	check.eq(dma_para_amd("19/07/2023"), "2023/07/19")
	check.eq(dma_para_amd("01/01/1980"), "1980/01/01")
	check.eq(dma_para_amd("02/02/2002"), "2002/02/20")
}
```

Erro na especificação(teste), onde `{Gleam}check.eq(dma_para_amd("02/02/2002"), "2002/02/02")` o dia esperado estava incorreto.

Resultado

```Gleam
import gleam/string
import sgleam/check

// Transforma a string *data* que está no formato "dia/mes/ano"
/// para o formato "ano/mes/dia".
///
/// Requer que o dia e o mês tenham dois dígitos e que
/// o ano tenha quatro dígitos.
pub fn dma_para_amd(data: String) -> String {
  string.concat([
    string.slice(data, 6, 4),
    "/",
    string.slice(data, 3, 2),
    "/",
    string.slice(data, 0, 2),
  ])
}

pub fn dma_para_amd_examples() {
  check.eq(dma_para_amd("19/07/2023"), "2023/07/19")
  check.eq(dma_para_amd("01/01/1980"), "1980/01/01")
  check.eq(dma_para_amd("02/02/2002"), "2002/02/02")
}
```

**13) Escreva a especificação para a seguinte implementação de função. Avalie se a sua especificação está
boa, verificando se ela sozinha é suficiente para um desenvolvedor fazer uma implementação da função.**

```Gleam
pub fn aumenta(valor: Float, porcentagem: Float) -> Float {
	valor *. { 1.0 +. porcentagem /. 100.0 }
}
```

14. Escreva a especificação para a seguinte implementação de função. Avalie se a sua especificação está
    boa, verificando se ela sozinha é suficiente para um desenvolvedor fazer uma implementação da função.

```Gleam
pub fn tamanho_nome(nome: String) -> Int {
    case string.length(nome) <= 4 {
        True -> "curto"
        False ->
            case string.length(nome) <= 10 {
                True -> "médio"
                False -> "longo"
            }
    }
}
```

15. Projete uma função que adicione um ponto final a uma frase se ela não acabar com um.

```Gleam
import gleam/string
import sgleam/check

/// Devolve *str* com um ponto final caso não tenha
pub fn adiciona_ponto_final(str: String) -> String {
  let tamanho = string.length(str)
  let ultimo: String = string.slice(str, tamanho - 1, 1)
  case ultimo == "." {
    True -> str
    False -> str <> "."
  }
}

pub fn adiciona_ponto_final_examples() {
  check.eq(adiciona_ponto_final("teste"), "teste.")
  check.eq(adiciona_ponto_final("teste."), "teste.")
  check.eq(adiciona_ponto_final(""), ".")
}
```

16. Projete uma função que determine se uma palavra tem um traço ("-") no meio, como por exemplo,
    "lero-lero". Não use nenhum condicional na implementação.

```Gleam
import gleam/string
import sgleam/check

/// Produz True se uma *palavra* contém "-"
/// exatamente no meio
pub fn contem_traco_no_meio(palavra: String) -> Bool {
  palavra != "" && string.contains(palavra, "-")
}

pub fn contem_traco_no_meio_examples() {
  check.eq(contem_traco_no_meio("lero-lero"), True)
  check.eq(contem_traco_no_meio(""), False)
  check.eq(contem_traco_no_meio("ler-olero"), False)
  check.eq(contem_traco_no_meio("oi-oi-oioio"), True)
}
```

17. Projete uma função que encontre o máximo entre três números dados.

```Gleam
import sgleam/check

/// Devolve o maior entre *n1*, *n2* e *n3*
pub fn maximo3(n1: Int, n2: Int, n3: Int) -> Int {
  case n1 >= n2 && n1 >= n3 {
    True -> n1
    False ->
      case n2 >= n3 {
        True -> n2
        False -> n3
      }
  }
}

pub fn maximo_examples() {
  check.eq(maximo3(1, 2, 3), 3)
  check.eq(maximo3(2, 5, 0), 5)
  check.eq(maximo3(8, 0, 1), 8)
}
```

18. Projete uma função que receba como parâmetro uma string e um número natural n e substitua os
    primeiros n caracteres da string por n letras x.

```Gleam
import gleam/string
import sgleam/check

/// Devolve uma string com os *n* primeiros caracteres
/// de *str* substituidos pela letra "x" *n* vezes
pub fn troca_por_x_n_vezes(str: String, n: Int) -> String {
  case str, n > 0 {
    "", False -> ""
    _, False -> ""
    _, _ -> string.repeat("x", n) <> string.slice(str, n, string.length(str))
  }
}

pub fn troca_por_x_n_vezes_examples() {
  check.eq(troca_por_x_n_vezes("Corinthians", 1), "xorinthians")
  check.eq(troca_por_x_n_vezes("Vasco", 5), "xxxxx")
  check.eq(troca_por_x_n_vezes("yvideos", 1), "xvideos")
  check.eq(troca_por_x_n_vezes("KAJOTA", 2), "xxJOTA")
  check.eq(troca_por_x_n_vezes("", 0), "")
  check.eq(troca_por_x_n_vezes("teste", 0), "")
  check.eq(troca_por_x_n_vezes("", -2), "")
  check.eq(troca_por_x_n_vezes("Teste", -2), "")
}
```

## Resolvendo problemas

19. Você está fazendo um programa e precisa verificar se um texto digitado pelo usuário está de acordo
    com algumas regras. A regra “sem espaços extras” requer que o texto não comece e não termine com
    espaços. Projete uma função que verifique se um texto qualquer está de acordo com a regra “sem
    espaços extras”.
20. Cada cidadão de um país, cuja moeda chama-se dinheiro, tem que pagar imposto sobre a sua renda.
    Cidadãos que recebem até 1000 dinheiros pagam 5% de imposto. Cidadãos que recebem entre 1000 e
    5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros e 10% sobre o que passar de 1000. Cidadãos
    que recebem mais de 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros, 10% de imposto sobre
    4000 dinheiros e 20% sobre o que passar de 5000. Projete uma função que calcule o imposto que um
    cidadão deve pagar dada a sua renda.

```Gleam
import sgleam/check

/// Representa a renda de um cidadão
/// Assume-se que o cidadão tenha renda maior que 0.
pub type Renda =
  Float

/// Calcula o valor de imposto que um cidadão tem de pagar
/// baseado em sua *renda*
///
/// Imposto a pagar:
/// - Até 1000 dinheiros, paga-se 5%
/// - Entre 1000 e 5000 dinheiros, paga-se 5% sobre 1000
/// e 10% do excedente de 1000
/// - Mais de 5000 dinheiros, paga-se 5% de imposto sobre 1000, 10%
/// sobre 4000 e 20% sobre o excedente de 5000
pub fn calcula_imposto(renda: Renda) -> Renda {
  case renda <=. 1000.0 {
    True -> renda *. 0.05
    False ->
      case renda <=. 5000.0 {
        True -> 50.0 +. { { renda -. 1000.0 } *. 0.1 }
        False ->
          450.0 +. { { renda -. 5000.0 } *. 0.2 }
      }
  }
}

pub fn calcula_imposto_examples() {
  check.eq(calcula_imposto(100.0), 5.0)
  check.eq(calcula_imposto(1000.0), 50.0)
  check.eq(calcula_imposto(4000.0), 350.0)
  check.eq(calcula_imposto(5000.0), 450.0)
  check.eq(calcula_imposto(10_000.0), 1450.0)
}
```

21. Uma palavra duplicada é formada pela ocorrência de duas partes iguais, separadas ou não por hífen.
    Por exemplo, as palavras xixi, mimi, lero-lero e mata-mata são palavras duplicadas. Projete uma
    função que verifique se uma palavra é duplicada.

```Gleam
import gleam/string
import sgleam/check

/// Devolve True se uma palavra é duplicada, ou seja,
/// tem duas partes iguais, podendo ou não ser
/// separadas por hífen. Caso não seja duplicada, produz False
pub fn palavra_duplicada(palavra: String) -> Bool {
  let tamanho = string.length(palavra)
  case palavra {
    "" -> False
    _ ->
      case string.contains(palavra, "-") {
        True ->
          string.slice(palavra, 0, tamanho / 2)
          == string.slice(palavra, tamanho / 2 + 1, tamanho)
        False ->
          string.slice(palavra, 0, tamanho / 2)
          == string.slice(palavra, tamanho / 2, tamanho)
      }
  }
}

pub fn palavra_duplicada_examples() {
  check.eq(palavra_duplicada(""), False)
  check.eq(palavra_duplicada("mimi"), True)
  check.eq(palavra_duplicada("lero-lero"), True)
  check.eq(palavra_duplicada("-"), True)
}
```

22. Um construtor precisa calcular a quantidade de azulejos necessários para azulejar uma determinada
    parede. Cada azulejo é quadrado e tem 20cm de lado. Ajude o construtor e defina uma função que
    receba como entrada o comprimento e a altura em metros de uma parede e calcule a quantidade de
    azulejos inteiros necessários para azulejar a parede. Considere que o construtor nunca perde um azulejo
    e que recortes de azulejos não são reaproveitados.
23. Rotacionar uma string n posições à direita significa mover os últimos n caracteres da string para as
    primeiras n posições da string. Por exemplo, rotacionar a string "marcelio" 5 posições à direita
    produz a string "celiomar". Projete uma função que receba como entrada uma string e um número
    n e produza uma nova string rotacionando a string de entrada n posições à direita.

```Gleam
import sgleam/check
import gleam/string

/// Produz um string após rotacionar os últimos *n* caracteres
/// para o início da string *str*
pub fn rotaciona(str: String, n: Int) -> String {
    let tamanho = string.length(str)

    case tamanho, n > -1 {
        0, _ -> ""
        _, _ ->
            string.slice(str, tamanho - n, tamanho)
            <> string.slice(str, 0, tamanho - n)
    }
}

pub fn rotaciona_examples() {
    check.eq(rotaciona("marcelio", 5), "celiomar")
    check.eq(rotaciona("", 10), "")
    check.eq(rotaciona("", -2), "")
    check.eq(rotaciona("", 0), "")
    check.eq(rotaciona("Leonardo", 5), "nardoLeo")
    check.eq(rotaciona("Kelvin", 0), "Kelvin")
    check.eq(rotaciona("Sthephany", -2), "Sthephany")
}
```

24. No período de 2015 à 2016 todos os números de telefones celulares no Brasil passaram a ter nove dígitos.
    Na época, os números de telefones que tinham apenas oito dígitos foram alterados, adicionando-se o
    9 na frente do número. Embora oficialmente todos os número de celulares tenham nove dígitos, na
    agenda de muitas pessoas ainda é comum encontrar números registrados com apenas oito dígitos.
    Projete uma função que adicione o nono dígito em um dado número de telefone celular caso ele ainda
    não tenha o nono dígito. Considere que os números de entrada são dados com o DDD entre parênteses
    e com um hífen separando os últimos quatro dígitos. Exemplos de entradas: (44) 9787-1241, (51)
    95872-9989, (41) 8876-1562. A saída deve ter o mesmo formato, mas garantindo que o número do
    telefone tenha 9 dígitos.
    Desafios
25. Muitos letreiros exibem mensagens que têm mais caracteres do que eles podem exibir, para isso, eles
    exibem apenas uma porção da mensagem que é alterada com o passar do tempo. Por exemplo, em um
    letreiro de 20 caracteres, a mensagem "Promoção de sorvetes, pague 2 leve 3!" é exibida como
    Promoção de sorvetes no momento 0, como "romoção de sorvetes," no momento 1, "omoção de
    sorvetes, ", no momento 3, e assim por diante até que no momento 17 é exibido "tes, pague 2
    3
    leve 3!". O momento sempre aumenta, e após chegar no final da mensagem ela começa a ser exibida
    novamente, nesse caso, no momento 18 é exibido "es, pague 2 leve 3! " e no momento 19 é exibido
    "s, pague 2 leve 3! P", onde o P é o início da mensagem. Projete uma função que determine os
    caracteres de uma mensagem que devem ser exibidos em um determinado momento em um letreiro que
    pode exibir um determinado número de caracteres. Assuma que o número de caracteres da mensagem
    é maior do que o do letreiro.
26. Um número inteiro positivo é palíndromo se quando lido da direita para a esquerda ou da esquerda
    para a direita é idêntico. Ex: 9119, 1221, 5665, 7337. Projete uma função que verifique se um dado
    número inteiro de 4 dígitos é palíndromo, considere que o valor de entrada é o próprio número e não os
    quatro dígitos que compõem o número. É possível modificar a sua função de maneira que ela funcione
    para qualquer número de entrada e não apenas para números de 4 dígitos?
