import Data.List

-- Punto 1 --
--A

data Persona = Persona {
    habilidades :: [Habilidad],
    esBuena :: Bool
}

type Habilidad = String

persona1 :: Persona
persona1 = Persona ["habilidad"] True

data PowerRanger = PowerRanger {
    color :: Color,
    habilidadesR :: [Habilidad],
    pelea :: Int 
}

data Color = Rojo | Amarillo | Verde | Azul | Negro | Rosa | Metalico

powerRanger1 :: PowerRanger
powerRanger1 = PowerRanger Azul ["Habilidad"] 100

-- Punto 2 --

convertirEnPoweRanger :: Color -> Persona -> PowerRanger
convertirEnPoweRanger color persona= PowerRanger color (agregarHabilidades persona) (nivelDePelea persona)

agregarHabilidades :: Persona -> [Habilidad]
agregarHabilidades = map  ("Super" ++). habilidades

nivelDePelea :: Persona -> Int
nivelDePelea = length . concat . habilidades

-- Punto 3 --

formarEquipoRanger :: [Color] -> [Persona] -> [PowerRanger]
formarEquipoRanger colores personas =  zipWith convertirEnPoweRanger colores (filtrarPersonasBuenas personas)

filtrarPersonasBuenas :: [Persona] -> [Persona]
filtrarPersonasBuenas = filter esBuena

-- Punto 4 --
-- A

findOrElse :: ( a -> Bool) -> a -> [a] -> c
findOrElse condicion valor lista 
    |condicion valor = head . filter condicion lista
    |otherwise       = valor

-- B

rangerLider :: [PowerRanger] -> PowerRanger
rangerLider equipo = findOrElse (\ranger -> color ranger == Rojo) (head equipo) equipo

-- Punto 5 --
-- A

maximumBy :: [a] -> ( a -> Ord b ) -> b
maximumBy lista funcion = max . map funcion $ lista

-- B

rangerMasPoderoso :: [PowerRanger] -> PowerRanger
rangerMasPoderoso equipo = maximumBy equipo pelea

-- Punto 6 --

rangerHabilidoso :: PowerRanger -> Bool
rangerHabilidoso = (>5) . length . habilidadesR

-- Punto 7 --
alfa5 :: PowerRanger
alfa5 = PowerRanger Metalico (["Reparar cosas"] ++ repeat "ay") 0

-- La funcion rangerLider, si alfa5 esta en un equipo si terminaria ya que no se utiliza la lista infnita, pero
-- la funcion rangerHabilidoso no se podria hacer, ya que la funcion length, necesita que la lsita este termianda para devovler el resultado

-- Punto 8 --
data ChicaSuperPoderosa = ChicaSuperPoderosa {
    color :: Color,
    cantidadDePelo :: Int
}

chicaLider :: [ChicaSuperPoderosa] -> ChicaSuperPoderosa
chicaLider = rangerLider