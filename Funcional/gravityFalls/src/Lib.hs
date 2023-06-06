module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Las Rarezas --
-- Punto 1 --

data Persona = Persona {
    edad        :: Int,
    items       :: [Item],
    experiencia :: Int
}

data Criatura = Criatura {
    peligrosidad   :: Int,
    comoDeshacerse :: Item,
    requerimiento  :: Persona -> Bool
}

type Item = String

siempreDetras :: Criatura
siempreDetras =  Criatura 0 "" undefined

gnomo :: Int -> Criatura
gnomo cantidad = Criatura (2^cantidad) "Soplador de hojas" undefined

fantasma :: Int -> String -> (Persona -> Bool) -> Criatura
fantasma categoria itemNecesario requerimiento = Criatura (categoria * 20) itemNecesario requerimiento

-- Punto 2 --

deshacerse :: Criatura -> Persona -> Persona
deshacerse unaCriatura unaPersona 
    |puedeDeshacerse unaCriatura unaPersona = ganarExperiencia (peligrosidad unaCriatura) unaPersona
    |otherwise                              = ganarExperiencia 1 unaPersona

puedeDeshacerse :: Criatura -> Persona -> Bool
puedeDeshacerse unaCriatura = elem (comoDeshacerse unaCriatura) . items

ganarExperiencia :: Int -> Persona -> Persona
ganarExperiencia cantidad unaPersona = unaPersona {experiencia = experiencia unaPersona + cantidad}

-- Punto 3 --
experienciaGanable :: [Criatura] -> Persona -> Int
experienciaGanable criaturas unaPersona = experienciafinal unaPersona . foldl (flip deshacerse) unaPersona $ criaturas

experienciafinal :: Persona -> Persona -> Int
experienciafinal antes despues = experiencia despues - experiencia antes

criaturasEjemplo = [siempreDetras, gnomo 10, fantasma 3 "Disfraz de oveja" ((<13). edad), fantasma 1 "" ((>10).edad)]

-- Mensajes ocultos --
-- Punto 1 --
zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _ [] _ = []
zipWithIf _ _ _ [] = []
zipWithIf f cond (x:xs) (y:ys)
    | cond y     = f x y : zipWithIf f cond xs ys
    | otherwise  = y : zipWithIf f cond xs ys

-- Punto 2 --
abecedarioDesde :: Char -> [Char]
abecedarioDesde c = reverse . delete c . reverse $ [c..'z'] ++ ['a'.. c]

desencriptarLetra :: Char -> Char -> Char
desencriptarLetra clave letra = ['a'..'z'] !! (mod (indexLetra - indexClave) 26)
  where
    indexLetra = getIndex letra
    indexClave = getIndex clave
    getIndex c = length (takeWhile (/= c) ['a'..'z'])   

cesar :: Char -> String -> String
cesar clave mensaje = zipWithIf (desencriptarLetra clave) isLetter mensaje 
  where 
    isLetter c = elem c ['a'..'z'] || elem c ['A'..'Z']


