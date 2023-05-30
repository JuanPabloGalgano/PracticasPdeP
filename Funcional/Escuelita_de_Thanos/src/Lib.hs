
import Data.List

-------------
-- Punto 1 --
-------------
type Universo = [Personaje]
data Personaje = Personaje { nombre :: String, edad  :: Int, energia :: Float, habilidades :: [Habilidad], planeta :: String} deriving (Show)
data Guantelete = Guantelete {material :: String, gemas ::[Gema]}
type Habilidad = String 


-------------
--Punto 1.5--
-------------
chasquear :: Guantelete -> Universo -> Universo
chasquear guantelete universo
    |puedeUsarse guantelete = reducirMitad universo
    |otherwise = universo
    
reducirMitad :: Universo -> Universo
reducirMitad universo = take (length universo `div` 2) universo 

puedeUsarse:: Guantelete -> Bool
puedeUsarse guantelete = ((==6).length.gemas) guantelete && ((=="uru").material) guantelete

-------------
-- Punto 2 --
-------------
universoApto :: Universo -> Bool
universoApto universo = any (>45) (map edadPersonaje universo)

edadPersonaje :: Personaje -> Int
edadPersonaje = edad 

energiaTotal :: Universo -> Float
energiaTotal universo = sum (map energiaPersonaje universo)

energiaPersonaje :: Personaje -> Float
energiaPersonaje = energia

-------------
-- Punto 3 --
-------------
type Gema = Personaje -> Personaje

mente :: Float -> Gema
mente = quitarEnergia

quitarEnergia :: Float -> Gema
quitarEnergia valor personaje = personaje { energia = energia personaje - valor}

alma :: String -> Gema
alma habilidad personaje = quitarEnergia 10 personaje {habilidades = filter (/=habilidad) (habilidades personaje)}

espacio :: String -> Gema
espacio planeta personaje = quitarEnergia 20 personaje {planeta = planeta}

poder :: Gema
poder personaje = quitarEnergia (energia personaje) personaje {habilidades = habilidades (desecharHabilidades personaje)}

tiempo :: Gema
tiempo personaje =quitarEnergia 500 personaje {edad = edad (reducirEdad personaje)}

gemaLoca :: Gema -> Gema
gemaLoca gema  = gema.gema

desecharHabilidades:: Personaje -> Personaje
desecharHabilidades personaje 
    |length (habilidades personaje) > 2 = personaje
    |otherwise = personaje {habilidades = []}

reducirEdad :: Personaje -> Personaje
reducirEdad personaje = personaje {edad = (max 18.div (edad personaje)) 2}

-------------
-- Punto 4 --
-------------
guantelete = Guantelete "goma" [tiempo, alma "usar mjolnir", gemaLoca (alma "programacion en Haskell")]

-------------
-- Punto 5 --
-------------
utilizar :: [Gema] ->  Gema
utilizar gemas enemigo = foldr ($) enemigo $ gemas

-------------
-- Punto 6 --
-------------
gemaMasPoderosa :: Personaje -> Guantelete -> Gema
gemaMasPoderosa personaje guantelete = gemaMasPoderosaDe personaje $ gemas guantelete

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema
gemaMasPoderosaDe personaje (gema1:gema2:gemas) 
    | (energia.gema1) personaje < (energia.gema2) personaje = gemaMasPoderosaDe personaje (gema1:gemas)
    | otherwise = gemaMasPoderosaDe personaje (gema2:gemas)

-------------
-- Punto 7 --
-------------
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas tiempo)

punisher:: Personaje 
punisher = Personaje "The Punisher" 38 350.0 ["Disparar con de todo","golpear"] "Tierra"  

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete