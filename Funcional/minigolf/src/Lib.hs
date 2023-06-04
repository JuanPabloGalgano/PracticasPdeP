import Data.List

-- Punto 1 --
data Jugador = Jugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = Jugador "Bart" "Homero" (Habilidad 25 60)
todd = Jugador "Todd" "Ned" (Habilidad 15 80)
rafa = Jugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = Tiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = Tiro 10 (precisionJugador habilidad * 2) 0

madera :: Palo
madera habilidad = Tiro 100 (precisionJugador habilidad / 2) 5

hierros :: Int -> Palo
hierros numero habilidad = Tiro (fuerzaJugador habilidad * numero) (precisionJugador habilidad / numero) (numero - 3)

type Palos = [Palo]

palos :: Palos
palos = [putter, madera] ++ map hierros [1..10]

-- Punto 2 --

golpe :: Palo -> Jugador-> Tiro
golpe unPalo = unPalo . habilidad 

-- Punto 3 --
type Obstaculo = Tiro -> Tiro

tunelConRampita :: (Tiro ->Bool) -> Obstaculo
tunelConRampita condicion unTtiro 
    |condicion unTiro = unTiro {velocidad = velocidad unTiro *2, precision = 100}
    |otherwise                 = error "No supera el obstaculo"                                        =




