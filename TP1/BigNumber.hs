{-
Um big-number é representado por uma lista dos seus dígitos.
O objetivo deste módulo é representar estruturas para big-numbers (por 
exemplo listas) e implementar as funções básicas de aritmética para big-numbers.
O módulo deverá conter as seguintes definições:

2.1) Uma definição do tipo BigNumber (usando a keyword “data”).
2.2) A função somaBN, para somar dois big-numbers.
2.3) A função subBN, para subtrair dois big-numbers.
2.4) A função mulBN, para multiplicar dois big-numbers.
O tipo das três funções anteriores é: BigNumber -> BigNumber -> BigNumber
2.5)A função divBN, para efetuar a divisão inteira de dois big-numbers.
A divisão deverá retornar um par “(quociente, resto)”. O tipo desta função é:
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

Para facilitar estas operações, assuma que os dígitos podem estar na lista por
ordem inversa, chamando inicialmente uma função de reverse.
Exemplo: 123 + 49 = 172 é representado por: [3, 2, 1] + [9, 4] = [2, 7, 1]


Capacidade de detetar divisões por zero em compile-time. Para isso, a 
função divisão deverá retornar monads do tipo Maybe. A função alternativa
para a divisão inteira deverá se chamar safeDivBN e ter otipo: 
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)

Mais informações sobre o monad Maybe em: https://en.wikibooks.org/wiki/Haskell/Understanding_monads/Maybe
-}