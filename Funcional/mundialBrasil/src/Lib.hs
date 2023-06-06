module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

data Jugador = Jugador {
    nombre :: String,
    edad :: Int,
    promedioDeGol :: Float,
    habilidad :: Int,
    cansancio :: Float
}

data Equipo = Equipo {
    seleccion :: String,
    grupo :: Char,
    plantel :: [Jugador]
}

martin = Jugador "Martin" 26 0.0 50 35.0
juan = Jugador "Juancho" 30 0.2 50 40.0
maxi = Jugador "Maxi Lopez" 27 0.4 68 30.0

jonathan = Jugador "Chueco" 20 1.5 80 99.0
lean = Jugador "Hacha" 23 0.01 50 35.0
brian = Jugador "Panadero" 21 5 80 15.0

garcia = Jugador "Sargento" 30 1 80 13.0
messi = Jugador "Pulga" 26 10 99 43.0
aguero =Jugador "Aguero" 24 5 90 5.0

equipo1 = Equipo "Lo Que Vale Es El Intento" 'F' [martin, juan, maxi]
losDeSiempre = Equipo  "Los De Siempre" 'F' [jonathan, lean, brian]
restoDelMundo = Equipo "Resto del Mundo" 'A' [garcia, messi, aguero]

quickSort :: (a -> Bool) -> [a] -> [a]
quickSort _ [] = [] 
quickSort criterio (x:xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs 

-- Punto 1 --

figuras :: Equipo -> [Jugador]
figuras = filter esFigura . plantel

esFigura :: Jugador -> Bool
esFigura unJugador = ((>75).habilidad $ unJugador) && ((>0).promedioDeGol $ unJugador)

-- Punto 2 --
tieneFaranduleo :: Equipo -> Bool
tieneFaranduleo = any farandula . plantel

farandula :: Jugador -> Bool
farandula = flip elem jugadoresFaranduleros . nombre 

jugadoresFaranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

-- Punto 3 --
figuritaDificil :: Char -> [Equipo] -> [String]
figuritaDificil grupo = map nombre . filter esDificil . concat . map plantel . filter (esDelGrupo grupo) 

esDificil :: Jugador -> Bool
esDificil unJugador = esFigura unJugador && ((<27). edad $ unJugador) &&  not (farandula unJugador)

esDelGrupo :: Char -> Equipo -> Bool
esDelGrupo letra equipo = grupo equipo == letra

-- Punto 4 --

jugarPartido :: Equipo -> Equipo
jugarPartido unEquipo = unEquipo {plantel = map cansarIf $ plantel unEquipo} 

cansarIf :: Jugador -> Jugador
cansarIf jugador
	| esDificil jugador = cansarJugador ((+50). (-cansancio jugador)) jugador
	| esJoven jugador   = cansarJugador (*1.1)                        jugador
	| esFigura jugador  = cansarJugador (+20)                         jugador
	| otherwise         = cansarJugador (*2)                          jugador

esJoven :: Jugador -> Bool
esJoven = ((<27)) . edad

cansarJugador :: (Int -> Int) -> Jugador -> Jugador
cansarJugador funcion unJugador = unJugador {cansancio = funcion (cansancio unJugador)}

-- Punto 5 --

ganarElPartido :: Equipo -> Equipo -> Equipo
ganarElPartido equipo1 equipo2 
    |gana equipo1 equipo2 = equipo1
    |otherwise            = equipo2

gana :: Equipo -> Equipo -> Bool
gana ganador perdedor = sumGoles (plantel (jugarPartido ganador)) > sumGoles (plantel (jugarPartido perdedor))

sumGoles :: [Jugador] -> Float
sumGoles = sum . map promedioDeGol

onceMenosCansados :: Equipo -> [Jugador]
onceMenosCansados unEquipo = take 11. quickSort menosCansado . plantel $ unEquipo

menosCansado :: Jugador -> Jugador -> Bool
menosCansado jugador1 jugador2 = cansancio jugador1 < cansancio jugador2

-- Punto 6 --
-- Forma 1 --
campeon :: [Equipo] -> Equipo
campeon [equipo] = equipo
campeon (equipo1:equipo2:resto)
    |gana equipo1 equipo2 = campeon (equipo1:resto)
    |otherwise            = campeon (equipo2:resto)

-- Forma 2 --
jugarTorneo :: [Equipo] -> Equipo
jugarTorneo equipos = foldl ganarElPartido (head equipos) (tail equipos)

-- Punto 7 --
elGroso :: [Equipo] -> Jugador
elGroso = head . filter esFigura . plantel . campeon 