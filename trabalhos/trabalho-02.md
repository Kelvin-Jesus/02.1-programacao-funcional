## Obs. do professor: Você pode consultar o material da página https://malbarbo.pro.br/ensino/2025/11917/

# Trabalho 02

1) Em um campeonato de atletismo os atletas são separados nas categorias: Menores, Sub23 e Adultos. O custo de
inscrição de uma equipe depende da categoria da equipe e da quantidade de atletas. Para os Menores, a inscrição
de cada atleta custa R$ 30, para os Sub23, R$ 40, e para os Adultos, R$ 50. A inscrição para equipes com mais de
10 atletas tem 10% de desconto.  

a) Projete um tipo de dado para representar a categoria de uma equipe.
b) Projete um tipo de dado para representar a inscrição de uma equipe.
c) Projete uma função que calcule o custo de inscrição de uma equipe.  

2) Para implementar um editor de linha (um editor de texto que permite editar apenas uma linha por vez), é preciso
representar o estado do editor, isto é, qual é a linha que está sendo editada e qual é a posição do cursor na linha.
Para evitar estados inválidos (a posição do cursor ficar fora da linha), você desenvolveu a seguinte representação:  
```Gleam
/// O estado de um editor de linha.
/// - esquerda é o conteúdo da linha a esquerda do cursor
/// - direita é o conteúdo da linha a direita do cursor
type Editor {
  Editor(esquerda: String, direita: String)
}
```

A partir essa representação é possível implementar diversos comandos de edição. Por exemplo, o comando para inse-
rir o caractere “o” transformaria o estado `Editor("Exempl", " de teste")` para `Editor("Exemplo", " de teste")`,
e o comando para mover o cursor para o início da linha transformaria `Editor("Exemplo", " de teste")` para
`Editor("", "Exemplo de teste")`.
a) Projete um tipo de dado para representar um comando de edição que pode ser: mover o cursor uma posição para
a direita, mover o cursor uma posição para a esquerda ou inserir um caractere qualquer após o cursor.  
b) Implemente uma função que receba como entrada o estado do editor e um comando de edição, e atualize o estado
do editor executando o comando.  

## Referência

```Gleam
/// Devolve uma substring de *s* começando em *inicio* e pegando os próximos
/// *tam* caracteres ou até o fim de *s*, o que vier primeiro.
/// Se *inicio* é negativo, começa a partir do fim de *s*.
/// Se *tam* é negativo, devolve "".
fn string.slice(s: String, inicio: Int, tam: Int) -> Int

fn string_slice_examples() {
  check.eq(string.slice("funcional", 3, 3), "nci")
  check.eq(string.slice("funcional", 2, -1), "")
  check.eq(string.slice("funcional", 3, 50), "cional")
  check.eq(string.slice("funcional", -3, 2), "na")
}
```

## Resoluções

```Gleam
import sgleam/check
import gleam/string
import gleam/int

/// Representa a Categoria de um atleta
pub type Categoria {
    Menores
    Sub23
    Adultos
}

/// Representa a inscricao de uma *Equipe*
pub type Inscricao {
    Inscricao(categoria: Categoria)
}

/// Representa uma equipe
pub type Equipe {
    Equipe(
        inscricao: Inscricao, 
        // Assume-se que a equipe tenha ao menos 1 atleta
        quantidade_atletas: Int
    )
}

/// Deve produzir o custo de incrição da *equipe*,
/// para atletas com da categoria *Menores* o custo de inscricao é R$30.00,
/// para atletas da categoria *Sub23*, o custo é R$40.00,
/// já para atletas da categoria *Adultos*, o custo será R$50.00.
/// Além disso, caso uma *equipe* tenha mais de 10 atletas,
/// recebe 10% de desconto
pub fn custo_de_inscricao(equipe: Equipe) -> Float {
    case equipe.inscricao.categoria, equipe.quantidade_atletas > 10 {
        Menores, True -> aplica_desconto_de_10(int.to_float(equipe.quantidade_atletas) *. 30.0)
        Menores, False -> int.to_float(equipe.quantidade_atletas) *. 30.0
        Sub23, True -> aplica_desconto_de_10(int.to_float(equipe.quantidade_atletas) *. 40.0)
        Sub23, False -> int.to_float(equipe.quantidade_atletas) *. 40.0
        Adultos, True -> aplica_desconto_de_10(int.to_float(equipe.quantidade_atletas) *. 50.0)
        Adultos, False -> int.to_float(equipe.quantidade_atletas) *. 50.0
    }
}

pub fn custo_de_inscricao_examples() {
    check.eq(
        custo_de_inscricao(
            Equipe(
                inscricao: Inscricao(categoria: Menores),
                quantidade_atletas: 10
            ),
        ),
        300.0
    )

    check.eq(
        custo_de_inscricao(
            Equipe(
                inscricao: Inscricao(categoria: Menores),
                quantidade_atletas: 12
            )
        ),
        324.0
    )    

    check.eq(
        custo_de_inscricao(
            Equipe(
                inscricao: Inscricao(categoria: Sub23),
                quantidade_atletas: 5
            )
        ),
        200.0
    )

    check.eq(
        custo_de_inscricao(
            Equipe(
                inscricao: Inscricao(categoria: Sub23),
                quantidade_atletas: 11
            )
        ),
        396.0
    )

    check.eq(
        custo_de_inscricao(
            Equipe(
                inscricao: Inscricao(categoria: Adultos),
                quantidade_atletas: 3
            )
        ),
        150.0
    )

    check.eq(
        custo_de_inscricao(
            Equipe(
                inscricao: Inscricao(categoria: Adultos),
                quantidade_atletas: 20
            )
        ),
        900.0
    )
}

/// Produz o *custo* aplicado 10% de desconto
pub fn aplica_desconto_de_10(custo: Float) -> Float {
    custo -. {custo *. 0.10}
}

pub fn aplica_desconto_de_10_examples() {
    check.eq(aplica_desconto_de_10(100.0), 90.0)
}

/// O estado de um editor de linha.
/// - esquerda é o conteúdo da linha a esquerda do cursor
/// - direita é o conteúdo da linha a direita do cursor
pub type Editor {
    Editor(esquerda: String, direita: String)
}

/// Representa os possíveis comando de um editor
pub type Comando {
    MoverUmEsquerda
    MoverUmDireita
    InserirAposCursor(caractere: String)
}

/// Deve produzir o novo *estado_editor* após a execuçaão de um *comando* 
pub fn executa_comando(estado_editor: Editor, comando: Comando) -> Editor {
    case comando {
        MoverUmDireita -> Editor(
            esquerda: {estado_editor.esquerda <> string.slice(estado_editor.direita, 0, 1)},
            direita: string.slice(estado_editor.direita, 1, string.length(estado_editor.direita))
        )
        MoverUmEsquerda -> Editor(
            esquerda: string.slice(estado_editor.esquerda, 0, string.length(estado_editor.esquerda) - 1),
            direita: string.slice(
                estado_editor.esquerda, 
                string.length(estado_editor.esquerda) - 1, 
                1
            ) <> estado_editor.direita
        )
        InserirAposCursor(caractere) -> Editor(
            esquerda: estado_editor.esquerda <> caractere,
            direita: estado_editor.direita
        )
    }
}

pub fn executa_comando_examples() {
    check.eq(
        executa_comando(
            Editor("Exempl", " de teste"), 
            InserirAposCursor("o")
        ), 
        Editor("Exemplo", " de teste")
    )

    check.eq(
        executa_comando(
            Editor("Exemplo", " de teste"),
            MoverUmDireita
        ),
        Editor("Exemplo ", "de teste")
    )

    check.eq(
        executa_comando(
            Editor("Exemplo", " de teste"),
            MoverUmEsquerda
        ),
        Editor("Exempl", "o de teste")
    )
}
```

