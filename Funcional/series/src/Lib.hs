module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Punto 1 --
data Serie = Serie {
    nombre      :: String,
    actores     :: [Actor],
    presupuesto :: Int,
    temporadas  :: Int,
    rating      :: Float,
    cancelada   :: Bool
}

data Actor = Actor {
    nombreA       :: String,
    sueldo        :: Int,
    restricciones :: [Restriccion]
}

type Restriccion = String

estaEnRojo :: Serie -> Bool
estaEnRojo unaSerie = presupuesto unaSerie - sumaSueldos unaSerie > 0

sumaSueldos :: Serie -> Int
sumaSueldos = sum . map sueldo . actores

esProblematica :: Serie -> Bool
esProblematica = (>3) . length .  actoresConRestricciones 1 

actoresConRestricciones :: Int -> Serie -> [Actor]
actoresConRestricciones cantidad unaSerie = filter ((>cantidad) . length . restricciones) (actores unaSerie)

-- Punto 2 --
type Productor = Serie -> Serie

conFavoritismo :: Actor -> Actor -> Productor
conFavoritismo actor1 actor2 = reemplazarActores actor1 actor2

reemplazarActores :: Actor -> Actor -> Serie -> Serie
reemplazarActores actor1 actor2 unaSerie = unaSerie {actores = actor1 : actor2 : drop 2 (actores unaSerie)}

timBurton :: Productor
timBurton = conFavoritismo johnnyDepp helenaBonhman

johnnyDepp :: Actor
johnnyDepp = Actor "Johnny Depp" 20000000 []

helenaBonhman :: Actor
helenaBonhman = Actor "Helena Bonhman" 15000000 []

gatopardeitor :: Productor
gatopardeitor unaSerie = unaSerie

estireitor :: Productor
estireitor unaSerie = unaSerie {temporadas = temporadas unaSerie * 2} 

desespereitor :: Actor -> Actor -> Productor
desespereitor = estireitor . conFavoritismo

canceleitor :: Float ->Productor
canceleitor ratingMinimo unaSerie = cancelable ratingMinimo unaSerie

cancelable :: Float -> Serie -> Serie
cancelable ratingMinimo unaSerie
    |estaEnRojo unaSerie || rating unaSerie < ratingMinimo = cancelarSerie unaSerie

cancelarSerie :: Serie -> Serie
cancelarSerie unaSerie = unaSerie {cancelada = True}

-- Punto 3 --

calcularBienestar :: Serie -> Int
calcularBienestar unaSerie
    |cancelada unaSerie = 0
    |otherwise          = bienestarTemporadas unaSerie + bienestarActores unaSerie

bienestarTemporadas :: Serie -> Int
bienestarTemporadas unaSerie
    |temporadas unaSerie > 4 = 5
    |otherwise               = (*2) . (10 -) . temporadas $ unaSerie 

bienestarActores :: Serie -> Int
bienestarActores unaSerie
    |length (actores unaSerie) < 10 = 3
    |otherwise                    = max 2 (10 - length (actores unaSerie))

-- Punto 4 --

productorMasEfectivo :: [Serie] ->[Productor] -> [Serie]
productorMasEfectivo series productores = map (masEfectivo productores) series

masEfectivo :: [Productor] -> Serie -> Serie
masEfectivo (x:[]) serie = x serie 
masEfectivo (x:xs) serie
  | calcularBienestar (x serie) > calcularBienestar (head xs $ serie) = x serie
  | otherwise = masEfectivo xs serie

-- Punto 5 --
-- A) Si se puede ya que devuelve la misma serie, y no se traba la consola 
-- como la funcion es la funcion id (identidad) devuelve infinitamente la serie que le paso, con la lista infinita de actores.
-- wl problema es que como tiene que mostrar una lista infinita de actores, nunca llego a ver los demas
-- atributos de la serie (temporadas, rating, etc).
-- si bien funciona en consola, no cumple con el proposito de la funcion.

-- B) al aplicar conFavoritismo no hay problema al hacer el drop de los primero 2 elementos.
-- cuando se quiere agregar los favoritos a la lista puede ocurrir el problema: si se agregan al principio de la lista
-- no hay problema alguno, pero sí lo hay si se agregan al final de la lista (ya que nunca encontrara el final
-- de una lista infinita). 
-- por lo que depende de si agregamos a los actores al principio o al final

-- Punto 6 --

esControvertida :: Serie -> Bool
esControvertida serie = not $ cobraMasQueElSiguiente (actores serie)

cobraMasQueElSiguiente :: [Actor] -> Bool
cobraMasQueElSiguiente (x:[]) = True
cobraMasQueElSiguiente (x:xs) = (sueldo x) > (sueldo $ head xs) 

-- Punto 7 --
--funcionLoca :: (Int b, Foldable t) => (Int -> b) -> (a1 -> t a2) -> [a1] -> [Int]
funcionLoca :: (Int -> Int) -> (a -> [b]) -> [a] -> [Int]
funcionLoca x y = filter (even.x) . map (length.y)
