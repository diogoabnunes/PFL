# PFL TP1 2021 2022

## Descrição de casos de teste para todas as funções

### Fib.hs
- fibRec, fibLista, fibListaInfinita:
  - 10 -> 55
  - 20 -> 6765
  - 30 -> 832040
- fibRecBN, fibListaBN, fibListaInfinitaBN:
  - [1,0] -> [5,5]
  - [2,0] -> [6,7,6,5]
  - [3,0] -> [8,3,2,0,4,0]
- fibs -> [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,...]
- fibsBN -> [[0],[1],[1],[2],[3],[5],[8],[1,3],[2,1],[3,4],[5,5],[8,9],[1,4,4],[2,3,3],[3,7,7],[6,1,0],[9,8,7],[1,5,9,7],[2,5,8,4],[4,1,8,1],[6,7,6,5],[1,0,9,4,6],[1,7,7,1,1],[2,8,6,5,7],[4,6,3,6,8],[7,5,0,2,5],[1,2,1,3,9,3],[1,9,6,4,1,8],[3,1,7,8,1,1],[5,1,4,2,2,9],[8,3,2,0,4,0],...]

### BigNumber.hs
- somaBN:
  - [1,2,3] [4,5,6] -> [5,7,9]
  - [1,2,3] [-4,5,6] -> [-3,3,3]
  - [-1,2,3] [4,5,6] -> [3,3,3]
  - [-1,2,3] [-4,5,6] -> [-5,7,9]
- subBN:
  - [1,2,3] [4,5,6] -> [-3,3,3]
  - [1,2,3] [-4,5,6] -> [5,7,9]
  - [-1,2,3] [4,5,6] -> [-5,7,9]
  - [-1,2,3] [-4,5,6] -> [3,3,3]
- mulBN: TODO:
- divBN:
  - [1,2,0] [1,0,0] -> ([1], [2,0])
  - [1,0,0] [0] -> Error: Infinity
- safeDivBN:
  - [1,2,0] [1,0,0] -> Just ([1], [2,0])
  - [1,0,0] [0] -> Nothing
- removerZerosEsquerdaBN:
  - [0,0,0,1,2,3] -> [1,2,3]
- mudarSinalBN:
  - [1,2,3] -> [-1,2,3]
  - [-1,2,3] -> [1,2,3]
- negativoBN:
  - [1,2,3] -> False
  - [-1,2,3] -> True
- maiorBN:
  - [1] [-1,2,3] -> True
  - [-9,9,9] [0] -> False

## Explicação sucinta do funcionamento de cada função

No ficheiro **Fib.hs**, todas as funções pedidas têm o resultado esperado (o número de Fibonacci no índice passado por argumento). As listas infinitas criadas para as alíneas 1. e 3. foram feitas com o recurso à função *zipWith*. Temos ainda uma função auxiliar *indexAtBN*, que, tal como o nome indica, retorna o índice de um dado elemento (BigNumber) numa lista (de BigNumber's).

No ficheiro **BigNumber.hs**, o processo de cálculo é sempre feito na função aux\<Operação>BN, onde é tratado o problema do carry. As funções pedidas limitam-se a "ver" o sinal do BigNumber (no nosso caso, representamos com o sinal - antes do primeiro algarismo na lista) e a chamar a operação correta. Tal como fui sugerido no enunciado, o cálculo é feito com 2 listas na ordem inversa, começando pelo cálculo do algarismo das unidades, das dezenas, e por aí adiante. Na função pedida na alínea 5, limitamo-nos a verificar se o segundo argumento (denominador) é 0: se for, retorna Nothing, caso contrário, faz a divisão normalmente (Just (divBN a b)). A nossa função divBN também não permite a divisão por zero, retornando neste caso uma exceção (Exception: Infinity).

Temos ainda mais 5 funções auxiliares, que nos permitem simplificar o código das funções pedidas:
- removerZerosEsquerdaBN, onde apenas retiramos os zeros iniciais num BigNumber;
- mudarSinalBN: mudamos o sinal do primeiro elemento de um BigNumber;
- mudarSinalDivBN: mudamos o sinal dos 2 elementos de um par de BigNumber's (usado para divBN onde um dos elementos é negativo);
- negativoBN: função que retorna True se um BigNumber é negativo;
- maiorBN (e auxMaiorBN): função que retorna True se um BigNumber for maior que outro.

## Estratégias utilizadas na implementação das funções da alínea 2

Tal como já foi aqui dito, as funções da alínea 2 limitam-se a verificar o sinal dos argumentos para chamar a respetiva operação que tem que fazer. 

Pegando no exemplo da soma, podem acontecer 3 cenários:
- 2 BigNumber's positivos: inverte os BigNumber's e procede com o cálculo da soma;
- 1 BigNumber positivo e 1 negativo: muda o sinal do BigNumber negativo e faz a respetiva subtração;
- 2 BigNumber's negativos: muda o sinal de ambos e faz a respetiva soma, mudando novamente o sinal no fim da operação.

Para o real cálculo da soma, temos a realçar o processo de Carry, onde na soma de 2 algarismos (mais o Carry anterior, se for o caso) for excedido o valor de 10, o valor do Carry passa 1 e chama recursivamente o cálculo dos algarismos seguintes.

A estratégia usada na subtração é a mesma usada na soma, com o caso especial de ambos os BigNumber's serem iguais, retornando imediatamente [0].

TODO: Multiplicação

Na divisão, a estratégia é semelhante às anteriores, também com o caso especial da divisão por zero, retornando a exceção "Exception: Infinity". 
Para o verdadeiro cálculo da divisão (auxDivBN), começamos por verificar se o primeiro argumento é maior que o segundo. Se assim for, chamamos novamente a função auxDivBN com o dividendo atualizado (valor de a substraído por b), com o divisor b (mantém-se o mesmo, obviamente) e com o quociente incrementado por 1. Isto é feito recursivamente até que o divisor é maior que o dividendo, retornando o quociente naquele momento e o resto (dividendo naquele momento).

## Resposta à alínea 4

