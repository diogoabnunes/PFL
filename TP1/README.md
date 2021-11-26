# PFL TP1 2021 2022

## Descrição de casos de teste para todas as funções

### \<Ficheiro>.hs
- \<Função>(, \<Função2>, ...)
  - \<Input> -> \<Output>

### Fib.hs
| função | arg | resultado |
| -- | -- | -- |
| fibRec | 10 | 55 |
| fibRec | 20 | 6765 |
| fibRec | 30 | 832040 |
| fibLista | 10 | 55 |
| fibLista | 20 | 6765 |
| fibLista | 30 | 832040 |
| fibListaInfinita | 10 | 55 |
| fibListaInfinita | 20 | 6765 |
| fibListaInfinita | 30 | 832040 |
| fibRecBN | (Positive [1,0]) | Positive [5,5] |
| fibRecBN | (Positive [2,0]) | Positive [6,7,6,5] |
| fibRecBN | (Positive [3,0]) | Positive [8,3,2,0,4,0] |
| fibListaBN | 10 | 55 |
| fibListaBN | 20 | 6765 |
| fibListaBN | 30 | 832040 |
| fibListaInfinitaBN | 10 | 55 |
| fibListaInfinitaBN | 20 | 6765 |
| fibListaInfinitaBN | 30 | 832040 |
- fibRecBN, fibListaBN, fibListaInfinitaBN:
  - (Positive [1,0]) -> Positive [5,5]
  - (Positive [2,0]) -> Positive [6,7,6,5]
  - (Positive [3,0]) -> Positive [8,3,2,0,4,0]
- fibs -> [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,...]
- fibsBN -> [Positive [0],Positive [1],Positive [1],Positive [2],Positive [3],Positive [5],Positive [8],Positive [1,3],Positive [2,1],Positive [3,4],Positive [5,5],...]

### BigNumber.hs
  
| função | arg1 | arg2 | resultado |
| -- | -- | -- | -- |
| somaBN | (Positive [1,2,3]) | (Positive [4,5,6]) | Positive [5,7,9] |
| somaBN | (Positive [1,2,3]) | (Negative [4,5,6]) | Negative [3,3,3] |
| somaBN | (Negative [1,2,3]) | (Positive [4,5,6]) | Positive [3,3,3] |
| somaBN | (Negative [1,2,3]) | (Negative [4,5,6]) | Negative [5,7,9] |
| -- | -- | -- | -- |
| subBN | (Positive [1,2,3]) | (Positive [4,5,6]) | Negative [3,3,3] |
| subBN | (Positive [1,2,3]) | (Negative [4,5,6]) | Positive [5,7,9] |
| subBN | (Negative [1,2,3]) | (Positive [4,5,6]) | Negative [5,7,9] |
| subBN | (Negative [1,2,3]) | (Negative [4,5,6]) | Positive [3,3,3] |
| -- | -- | -- | -- |
| mulBN | (Positive [1,2,3]) | (Positive [4,5,6]) | TODO:  |
| mulBN | (Positive [1,2,3]) | (Negative [4,5,6]) | TODO:  |
| mulBN | (Negative [1,2,3]) | (Positive [4,5,6]) | TODO:  |
| mulBN | (Negative [1,2,3]) | (Negative [4,5,6]) | TODO:  |
| -- | -- | -- | -- |
| divBN | (Positive [1,2,0]) | (Positive [1,0,0]) | (Positive [1],Positive [2,0]) |
| divBN | (Positive [1,2,0]) | (Negative [1,0,0]) | (Negative [1],Negative [2,0]) |
| divBN | (Negative [1,2,0]) | (Negative [1,0,0]) | (Positive [1],Positive [2,0]) |
| divBN | (Positive [1,2,0]) | (Positive [0]) | Exception: Infinity |
| -- | -- | -- | -- |
| safeDivBN | (Positive [1,2,0]) | (Positive [1,0,0]) | Just (Positive [1],Positive [2,0]) |
| safeDivBN | (Positive [1,2,0]) | (Positive [0]) | Nothing |

## Explicação sucinta do funcionamento de cada função

No ficheiro **Fib.hs**, todas as funções pedidas têm o resultado esperado (o número de Fibonacci no índice passado por argumento). As listas infinitas criadas para as alíneas 1. e 3. foram feitas com o recurso à função *zipWith*. Temos ainda uma função auxiliar *indexAtBN*, que, tal como o nome indica, retorna o índice de um dado elemento (BigNumber) numa lista (de BigNumber's).

No ficheiro **BigNumber.hs**, o processo de cálculo é sempre feito na função aux\<Operação>BN, onde é tratado o problema do carry. As funções pedidas limitam-se a "ver" o sinal do BigNumber (no nosso caso, representamos com o sinal - antes do primeiro algarismo na lista) e a chamar a operação correta. Tal como fui sugerido no enunciado, o cálculo é feito com 2 listas na ordem inversa, começando pelo cálculo do algarismo das unidades, das dezenas, e por aí adiante. Na função pedida na alínea 5, limitamo-nos a verificar se o segundo argumento (denominador) é 0: se for, retorna Nothing, caso contrário, faz a divisão normalmente (Just (divBN a b)). A nossa função divBN também não permite a divisão por zero, retornando neste caso uma exceção (Exception: Infinity).

Temos ainda mais 6 funções auxiliares, que nos permitem simplificar o código das funções pedidas:
- removerZerosEsquerdaBN, onde apenas retiramos os zeros iniciais num BigNumber;
- mudarSinalBN: mudamos o sinal do primeiro elemento de um BigNumber;
- mudarSinalDivBN: mudamos o sinal dos 2 elementos de um par de BigNumber's (usado para divBN onde um dos elementos é negativo);
- negativoBN: função que retorna True se um BigNumber é negativo;
- maiorBN (e auxMaiorBN): função que retorna True se um BigNumber for maior que outro.
- carryBN (e auxCarryBN): usado em mulBN e divBN, é usado para formatar o BigNumber. Ex.: carryBN [1,2,3,45] retorna [1,2,7,5]: o algarismo 4 soma com o 3 das "dezenas", e assim o BigNumber fica bem formatado.

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

