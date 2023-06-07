module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Punto 1 --
data Auto = Auto {
    color     :: String,
    velocidad :: Int,
    distancia :: Int
} deriving Eq

type Carrera = [Auto]

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = sonDistintos auto1 auto2 && (distanciaEntreEllos auto1 auto2 < 10)

sonDistintos :: Auto -> Auto -> Bool
sonDistintos auto1 auto2 = color auto1 /= color auto2

distanciaEntreEllos :: Auto -> Auto -> Int
distanciaEntreEllos auto1 auto2 = abs (distancia auto1 - distancia auto2)

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo unAuto carrera = (not $ all (estaCerca unAuto) carrera) && all (masDistancia unAuto) carrera

masDistancia :: Auto -> Auto -> Bool
masDistancia auto1 auto2 = distancia auto1 > distancia auto2

puesto :: Auto -> Carrera -> Int
puesto unAuto = (+1) . length . filter (masDistancia unAuto)

-- Punto 2 --

corra :: Int -> Auto -> Auto 
corra tiempo unAuto = unAuto {distancia = distancia unAuto + tiempo * velocidad unAuto}

type Modificador = Int -> Int

alterarVelocidad :: Modificador -> Auto -> Auto
alterarVelocidad modifacion unAuto = unAuto {velocidad = modifacion $ velocidad unAuto}

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad disminucion unAuto = alterarVelocidad (\v -> max 0 (v - disminucion)) unAuto

-- Punto 3 --

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista


type PowerUp = Auto -> Carrera -> Carrera

terremoto :: PowerUp
terremoto unAuto = afectarALosQueCumplen (estaCerca unAuto) (bajarVelocidad 50) 

miguelitos :: Int -> PowerUp
miguelitos cantidad unAuto = afectarALosQueCumplen (masDistancia unAuto) (bajarVelocidad cantidad)

jetPack :: Int -> PowerUp
jetPack tiempo unAuto = afectarALosQueCumplen (==unAuto) (corra tiempo. alterarVelocidad (*2)) 

-- Punto 4 --

simularCarrera :: Carrera -> [Carrera -> Carrera] -> [(Int, String)]
simularCarrera carrera eventos = obtenerTablaPosiciones (foldl aplicarEventos carrera eventos) 1
  where
    obtenerTablaPosiciones autos posicion = zip [posicion..] (map color autos)

aplicarEventos :: Carrera -> (Carrera -> Carrera) -> Carrera
aplicarEventos carrera evento = evento carrera

correnTodos :: Int -> Carrera -> Carrera
correnTodos tiempo = map (corra tiempo)

usaPowerUp :: PowerUp -> String -> Carrera -> Carrera
usaPowerUp powerUp colorAuto carrera = afectarALosQueCumplen (\auto -> color auto == colorAuto) (flip powerUp) carrera

carrera1 :: [(Int, String)]
carrera1 = simularCarrera [Auto "blanco" 120 0,Auto "Rojo" 120 0,Auto "Negro" 120 0,Auto "Azul" 120 0]
                          [correnTodos 10,
                          usaPowerUp (jetPack 6) "Negro",
                          usaPowerUp (miguelitos 20) "blanco",
                          correnTodos 40,
                          usaPowerUp terremoto "blanco",
                          usaPowerUp (jetPack 3) "azul",
                          correnTodos 30]

-- Punto 5 --

-- Si se podria agregar uun misil teledirigido, dem la siguiente forma
-- misilTeledirigido :: String -> PowerUp
-- misilTeledirigido color = afectarALosQueCumplen (\auto -> color auto == colorAuto) efectoDelMisil carrera

-- No se podrian hacer ya que se necesita que la lsita este completa para saber si ninguno de los autos que
-- componen la carrera esta cerca del auto ingresado, y con respecto al punto c, para obtener el length de una lista,
-- se necesita que la lista este terminada, y la funcion filter masDistancia iteraria infinitamente el siguiente 
-- auto hasta que termine
