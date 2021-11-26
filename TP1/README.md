# PFL TP1 2021 2022

Trabalho realizado por:
|    |    |
| -- | -- |
| Diogo André Barbosa Nunes | up201808546 |
| Margarida Alves Pinho | up201704599 |

## Descrição de casos de teste para todas as funções

### Fib.hs
| função | arg | resultado |
| -- | -- | -- |
| fibRec | 10 | 55 |
| fibLista | 20 | 6765 |
| fibListaInfinita | 30 | 832040 |
| fibRecBN | (Positive [2,0]) | Positive [6,7,6,5] |
| fibListaBN | (Positive [3,0]) | Positive [8,3,2,0,4,0] |
| fibListaInfinitaBN | (Positive [1,0]) | Positive [5,5] |

| função | resultado |
| -- | -- |
| fibs | [0,1,1,2,3,5,8,13,21,34,55,...] |
| fibsBN | [Positive [0],Positive [1],Positive [1],Positive [2],Positive [3],Positive [5],Positive [8],Positive [1,3],Positive [2,1],Positive [3,4],Positive [5,5],...] |

### BigNumber.hs

Funções pedidas:
| função | arg | resultado |
| -- | -- | -- |
| scanner | "123" | Positive [1,2,3] |
| scanner | "-123" | Negative [1,2,3] |
| scanner | "0" | Positive [0] |
| output | (Positive [1,2,3]) | "123" |
| output | (Negative [1,2,3]) | "-123" |

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

Funções auxiliares de 1 argumento:
| função | arg | resultado |
| -- | -- | -- |
| removerZerosEsquerdaBN | (Positive [0,0,0,1,2,3]) | Positive [1,2,3] |
| mudarSinalBN | (Positive [1,2,3]) | Negative [1,2,3] |
| mudarSinalDivBN | (Positive [1,2,3],Positive [4,5,6]) | (Negative [1,2,3],Negative [4,5,6]) |
| reverseBN | (Positive [1,2,3]) | Positive [3,2,1] |

Funções auxiliares de 2 argumentos:
| função | arg1 | arg2 | resultado |
| -- | -- | -- | -- |
| maiorBN | (Positive [1,2,3]) | (Positive [4,5,6]) | False |
| maiorBN | (Positive [1,2,3]) | (Negative [4,5,6]) | True |
| maiorBN | (Negative [1,2,3]) | (Positive [4,5,6]) | False |
| maiorBN | (Positive [1,2,3]) | (Positive [4,5]) | True |
| maiorBN | (Positive [1,2,3]) | (Positive [0,0,0,0,4,5]) | True |
| maiorBN | (Positive [1,2,3]) | (Positive [1,2,3]) | False |
| removeBN | "-123" | '-' | "123" |
| appendBN | 1 | (Positive [2,3,4]) | Positive [1,2,3,4] |


## Explicação sucinta do funcionamento de cada função

Na nossa implementação, um BigNumber é composto por:
- *Positive* (se for positivo) ou *Negative* (se for negativo);
- Lista de algarismos do número em questão.
```haskell
data BigNumber = Positive [Int] | Negative [Int] deriving (Show)
```

No ficheiro **Fib.hs**, todas as funções pedidas têm o resultado esperado (o número de Fibonacci no índice passado por argumento). As listas infinitas criadas para as alíneas 1. e 3. foram feitas com o recurso à função *zipWith*. Temos ainda uma função auxiliar *indexAtBN*, que, tal como o nome indica, retorna o índice de um dado elemento (BigNumber) numa lista (de BigNumber's). Nas chamadas às funções de Fibonacci, caso coloquemos como input um BigNumber negativo, o resultado é "Exception: There is no negative index".

No ficheiro **BigNumber.hs**, as operações são sempre realizadas na função aux\<Operação>BN, com exceção da divisão (como o cálculo é mais complexo, temos ainda as funções carryBN, auxCarryBN e carryPairBN para nos ajudar no mesmo), onde é tratado o problema do carry.

As funções do enunciado limitam-se a "ver" o sinal dos operadores e a chamar a respetiva operação:
- caso sejam 2 operadores positivos, a função auxiliar respetiva é chamada para efetuar o cálculo;
- caso contrário, mudam-se os sinais necessários e chama-se uma operação equivalente para realizar o cálculo.

Tal como fui sugerido no enunciado, o cálculo é feito com 2 listas na ordem inversa, começando pelo cálculo do algarismo das unidades, das dezenas, e por aí adiante.

Na função pedida na alínea 5, limitamo-nos a verificar se o denominador é 0: se for, retorna *Nothing*, caso contrário, chama a função da divisão da alínea 2 dentro de *Just* (Just (divBN a b)). Apesar de não ter sido pedido, a nossa função divBN também não permite a divisão por zero, retornando, nesse caso, uma exceção (Exception: Infinity).

Temos ainda mais 7 funções auxiliares:
- removerZerosEsquerdaBN: remoção dos zeros iniciais ("à esquerda") de um BigNumber;
- mudarSinalBN: mudança do prefixo de sinal de um BigNumber;
- mudarSinalDivBN: mudança de sinal dos 2 elementos de um par de BigNumber's (usado para divBN onde um dos elementos é negativo);
- maiorBN (e auxMaiorBN): função que retorna True se um BigNumber for maior que outro;
- removeBN: remoção de um elemento/caractere de uma lista/string (usado no scanner, para remover o sinal "menos" numa string);
- appendBN: função a:b mas adaptada a BigNumber's (para ter em conta o prefixo de sinal);
- reverseBN: função reverse mas adaptada a BigNumber's (para ter em conta o prefixo de sinal);

## Estratégias utilizadas na implementação das funções da alínea 2

Seguindo a ordem do enunciado, a nossa função *scanner* recebe uma string e a primeira verificação que faz é confirmar que o primeiro caractere dessa string é ou não o sinal "-". Se for, vai ser construído um BigNumber negativo com a lista de algarismos que vão sendo lidos (usando a função map), mas a string a ser usada no map precisa da remoção do caractere "-". Caso não tenha esse caractere, não precisa desta remoção e apenas cria um BigNumber positivo usando a função map com a string inicial.

A nossa função output é provavelmente a mais trivial em todo o nosso projeto: caso seja dado como argumento um BigNumber positivo, usamos a função concatMap, que percorre a lista de algarismos e concatena-os numa string através da função show. Caso o argumento seja um BigNumber negativo, apenas concatena um sinal "-" antes da mesma chamada à função concatMap.

Tal como já foi aqui dito, as funções da alínea 2 limitam-se a verificar o sinal dos argumentos para chamar a respetiva operação que tem que fazer. 

Pegando no exemplo da soma, podem acontecer 3 cenários:
- 1 BigNumber positivo e 1 negativo: muda o sinal do BigNumber negativo e faz a respetiva subtração;
- 2 BigNumber's negativos: muda o sinal de ambos e faz a respetiva soma, mudando novamente o sinal no fim da operação.
- 2 BigNumber's positivos: inverte os BigNumber's e procede com o cálculo da soma;

Para o real cálculo da soma, temos a realçar o processo de Carry, onde na soma de 2 algarismos (mais o Carry anterior, se for o caso) for excedido o valor de 10, o valor do Carry passa 1 e chama recursivamente o cálculo dos algarismos da ordem seguinte.

A estratégia usada na subtração é a mesma usada na soma, com o caso especial de ambos os BigNumber's serem iguais, retornando imediatamente [0].

TODO: Multiplicação

Na divisão, a estratégia é semelhante às anteriores, também com o caso especial da divisão por zero, que retorna "Exception: Infinity". 
Para o verdadeiro cálculo da divisão (auxDivBN), começamos por verificar se o primeiro argumento é maior que o segundo. Se assim for, chamamos novamente a função auxDivBN com o dividendo atualizado (valor de a substraído por b), com o divisor b (mantém-se o mesmo, obviamente) e com o quociente incrementado por 1. Isto é feito recursivamente até que o divisor é maior que o dividendo, retornando o quociente naquele momento e o resto (dividendo naquele momento).

## Resposta à alínea 4

- Int -> Int
- Integer -> Integer
- BigNumber -> BigNumber

TODO: maybe tabelas com limit ranges?