# Trabalho Prático 1

1. [x] Crie um ficheiro chamado **Fib.hs**.
   1. [x] Função recursiva **fibRec** :: (Integral a) => a -> a
   2. [x] Versão otimizada de **fibLista**, usando uma lista de resultados parciais tal que (lista !! i) contém o nº de Fibonnaci de ordem i (programação dinâmica)
   3. [x] **fibListaInfinita**, para gerar uma lista infinita com todos os nºs de Fibonacci e retornar o elemento de ordem n

2. [ ] **(Mais valorizada do trabalho)** Módulo de aritmética para big-numbers para implementar novas versões das funções já definidas para este novo tipo. Definir este módulo em **BigNumber.hs**. Um big-number é representado por uma lista dos seus dígitos. O objetivo do módulo é representar estruturas para big-numbers (ex. listas) e implementar as funções básicas de aritmética para big-numbers.
   1. [x] Definição do tipo BigNumber (usando a keyword __data__)
   2. [x] **somaBN** :: BigNumber -> BigNumber -> BigNumber
   3. [x] **subBN** :: BigNumber -> BigNumber -> BigNumber
   4. [x] **mulBN** :: BigNumber -> BigNumber -> BigNumber
   5. [x] **divBN** (divisão inteira e deve retornar um par (quociente, resto)) :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
Para facilitar as operações, assuma que os dígitos podem estar na lista por ordem inversa, chamando inicialmente uma função de reverse.
Ex.: 123 + 49 = 172 -> [3,2,1] + [9,4] = [2,7,1]

3. [x] Em Fib.hs, incluir o módulo dos big-numbers e implementar
   1. [x] **fibRecBN**
   2. [x] **fibListaBN**
   3. [x] **fibListaInfinitaBN**

4. [x] Comparar resoluções das alíneas 1 e 3 com tipos (Int -> Int), (Integer -> Integer) e (BigNumber-> BigNumber), comparando a aplicação a nºs grandes e verificando qual o maior número que cada uma aceita como argumento

5. [x] Acrescentar ao módulo de big-numbers a capacidade de detetar divisões por zero em compile-time -> função divisão deverá retornar monads do tipo **Maybe**. **safeDivBN** :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)

## Instruções

- Entrega: PFL_TP1_G7_07.zip
  - README.pdf
    - descrição de vários casos de teste para todas as funções
    - explicação sucinta do funcionamento de cada função
    - estratégias utilizadas na implementação das funções na alínea 2
    - resposta à alínea 4
  - Código-fonte **devidamente comentado** e todos na root