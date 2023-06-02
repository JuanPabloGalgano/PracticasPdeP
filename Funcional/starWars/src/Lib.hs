import Data.List

-- Punto 1 --

data Nave = Nave {
    nombre :: String,
    durabilidad :: Int,
    escudo :: Int,
    ataque :: Int,
    poder :: Poder
}

type Poder = Nave -> Nave

data TipoDeMov = Turbo | SuperTurbo

tieFighter :: Nave
tieFighter = Nave "Tie fighter" 200 100 50 (haceUnMovimiento Turbo)

xWing :: Nave
xWing = Nave "X Wing" 300 150 100 reparacionDeEmergencia

naveDeDarthVader :: Nave
naveDeDarthVader = Nave "Nave de Darth Vader" 500 300 200 (haceUnMovimiento SuperTurbo)

millenniumFalcon :: Nave
millenniumFalcon = Nave "Millennium Falcon" 1000 500 50 (reparacionDeEmergencia. incrementarEscudos 100)

haceUnMovimiento :: TipoDeMov -> Poder
haceUnMovimiento Turbo = aumentarAtaque 25
haceUnMovimiento SuperTurbo = haceUnMovimiento Turbo . haceUnMovimiento Turbo . haceUnMovimiento Turbo . aumentarDurabilidad (-45)

reparacionDeEmergencia :: Poder
reparacionDeEmergencia = aumentarDurabilidad 50 . aumentarAtaque (-30)

incrementarEscudos :: Int -> Nave -> Nave
incrementarEscudos cantidad unaNave = unaNave {escudo = (+cantidad) . escudo $ unaNave}

aumentarDurabilidad :: Int -> Nave -> Nave
aumentarDurabilidad cantidad unaNave = unaNave {durabilidad = (+cantidad) . durabilidad $ unaNave}

aumentarAtaque :: Int -> Nave -> Nave
aumentarAtaque cantidad unaNave = unaNave {ataque = (+cantidad). ataque $ unaNave}

nuevaNave :: Nave
nuevaNave = Nave "Nueva Nave" 300 200 400 (camuflaje nuevaNave)

camuflaje :: Nave -> Poder
camuflaje nuevoCamuflaje = cambiarNombre (nombre nuevoCamuflaje) . aumentarAtaque (ataque nuevoCamuflaje) . aumentarDurabilidad (-100)

cambiarNombre :: String -> Nave -> Nave
cambiarNombre nuevoNombre unaNave = unaNave {nombre = nuevoNombre}

--modificarNave :: Int -> (Nave -> Int) -> Nave -> Nave
--modificarNave cantidad funcion unaNave = (+cantidad) . funcion $ unaNave

-- Punto 2 --
type Flota = [Nave]

durabilidadTotal :: Flota -> Int
durabilidadTotal = sum . map durabilidad

-- Punto 3 --

consecuencias :: Nave -> Nave -> Nave
consecuencias = atacarNave 

atacarNave :: Nave -> Nave -> Nave
atacarNave atacante defensor = aumentarDurabilidad (-(diferenciaAtaqueEscudo (activarPoder atacante) (activarPoder defensor))) defensor

diferenciaAtaqueEscudo :: Nave -> Nave -> Int
diferenciaAtaqueEscudo (Nave _ _ _ ataque _) (Nave _ _ escudo _ _) 
    | ataque < escudo = 0
    | otherwise = ataque - escudo

activarPoder :: Nave -> Nave
activarPoder unaNave = (poder unaNave) unaNave

-- Punto 4 --

fueraDeCombate :: Nave -> Bool
fueraDeCombate = (==0). durabilidad

-- Punto 5 --
type Estrategia = Nave -> Bool

misionSopresa :: Nave -> Flota -> Estrategia -> Flota
misionSopresa unaNave flotaEnemiga estrategia = map (atacarNave unaNave) $ filtrarFlotaEnemiga flotaEnemiga estrategia

filtrarFlotaEnemiga :: Flota -> Estrategia -> Flota
filtrarFlotaEnemiga flotaEnemiga estrategia = filter estrategia flotaEnemiga

navesDebiles :: Estrategia 
navesDebiles = (<200) . escudo

navesConCiertaPeligrosidad :: Int -> Estrategia
navesConCiertaPeligrosidad maximoAtaque = (>maximoAtaque) . ataque 

quedarianFueraDeCombate :: Estrategia
quedarianFueraDeCombate = fueraDeCombate

menosDe15Letras :: Estrategia
menosDe15Letras = (<15) . length . nombre

-- Punto 6 --
type Mision a = Nave -> Flota -> Estrategia -> Estrategia -> a

usarMejorEstrategia :: Mision Flota
usarMejorEstrategia unaNave flotaEnemiga estrategia1 = 
    misionSopresa unaNave flotaEnemiga . mejorEstrategia unaNave flotaEnemiga estrategia1

mejorEstrategia :: Mision Estrategia
mejorEstrategia unaNave flotaEnemiga estrategia1 estrategia2 
    |esMejor unaNave flotaEnemiga estrategia1 estrategia2 = estrategia1
    |otherwise                                            = estrategia2

esMejor :: Mision Bool
esMejor unaNave flotaEnemiga estrategia1 estrategia2 =
    (durabilidadTotal . misionSopresa unaNave flotaEnemiga $ estrategia1) < (durabilidadTotal . misionSopresa unaNave flotaEnemiga $ estrategia2)

-- Punto 7 --

flotaInfinita :: Nave -> Flota
flotaInfinita unaNave= (unaNave : flotaInfinita unaNave)

-- No es posible determinar la durabilidad total ya que se necesitaria sumar la durabilidad de todas las naves de la flota, y al ser inifnita esto no se puede
-- 




