converte :: Int -> String
converte n
    | n <= 9 = unidades !! n
    | n <= 19 = dezDezanove !! (n - 10)
    | n <= 100 = dezenas !! (div n 10 - 2) ++ " e " ++ unidades !! mod n 10
    | n == 100 = "cem"
    | n <= 999 = centenas !! (div n 100 - 1) ++ " e " ++ converte (mod n 100)
    | n == 1000 = "mil"
    | n <= 1999 = "mil " ++ converte (mod n 1000)
    | n <= 9999 = unidades !! div n 1000 ++ " mil " ++ converte (mod n 1000)
    | n <= 999999 = converte (div n 1000) ++ " mil " ++ converte (mod n 1000)
    | otherwise = "um milhao"

unidades = ["zero", "um", "dois", "tres", "quatro", "cinco", "seis", "sete", "oito", "nove"]
dezDezanove = ["dez", "onze", "doze", "treze", "catorze", "quinze", "dezasseis", "dezassete", "dezoito", "dezanove"]
dezenas = ["vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]
centenas = ["cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"]