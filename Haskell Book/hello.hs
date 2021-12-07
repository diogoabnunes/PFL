main = do
  putStrLn "Hello, World!\n"

{-
  (To compile) ghc hello.hs
  (To execute) ./hello

  Hello, World!
-}

  print ((+) 22 1)

{-
DEBUGGING
ghci -ddump-splices -XTemplateHaskell
\$([| expression |])

example: $([|1+1*2|])
<interactive >:6:3-11: Splicing expression
[| 1 + 1 * 2 |] ======>(1 + (1 * 2))
3
-}

{-
FUNCTIONS
<function name> <argument 1> <argument 2> ... = <expression>
-}