import Data.List

-- Punto 1 --

data Ladron = Ladron {
    nombre :: String,
    habilidades :: [Habilidad],
    armas :: [Arma]
}

data Rehen = Rehen {
    nombreRehen :: String,
    complot :: Int,
    miedo :: Int,
    plan :: [Plan]
}

type Habilidad = String
type Arma = Rehen -> Rehen
type Plan = Ladron -> Ladron

tokio :: Ladron
tokio = Ladron "Tokio" ["Hacer el trabajo psicologico", "Entrar en moto"] [pistola 9, pistola 9, ametralladora 30]

pistola :: Int -> Arma
pistola calibre unRehen = reducirComplot (calibre * 5) . aumentarMiedo (triplicarCantidadDeLetras unRehen) $ unRehen

aumentarMiedo :: Int -> Rehen -> Rehen
aumentarMiedo aumento unRehen = unRehen {miedo = miedo unRehen + aumento}

triplicarCantidadDeLetras :: Rehen -> Int
triplicarCantidadDeLetras = (*3) . length . nombreRehen 

reducirComplot :: Int -> Rehen -> Rehen
reducirComplot aReducir unRehen = unRehen {complot = complot unRehen - aReducir}

ametralladora :: Int -> Arma
ametralladora balas unRehen= reducirComplot (div (complot unRehen) 2) . aumentarMiedo balas $ unRehen

profesor :: Ladron
profesor = Ladron "Profesor" ["Disfrazarse de linyera", "Disfrazarse de payaso", "Estar siempre un paso adelante"] []

pablo :: Rehen
pablo = Rehen "Pablo" 40 30 [esconderse]

arturito :: Rehen
arturito = Rehen "Arturito" 70 50 [esconderse, atacarAUnLadron pablo]

esconderse :: Plan
esconderse unLadron = perderArmas (length . armas $ unLadron) unLadron 

perderArmas :: Int -> Ladron -> Ladron
perderArmas cantidad unLadron = unLadron {armas = drop cantidad . armas $ unLadron}

atacarAUnLadron :: Rehen -> Plan
atacarAUnLadron = perderArmas . length . nombreRehen 

-- Punto 2 --

esInteligente :: Ladron -> Bool
esInteligente = (>2) . length . habilidades

-- Punto 3 --
conseguirUnArma :: Arma -> Ladron -> Ladron
conseguirUnArma arma unLadron = unLadron {armas = arma : armas unLadron}

-- Punto 4 --
{-intimidarA :: Ladron -> Rehen
intimidarA 

disparos :: Ladron -> Arma
disparos =  
-}
-- Punto 5 --
calmeLasAguas :: [Rehen] -> [Rehen]
calmeLasAguas = filter estaCalmado

estaCalmado :: Rehen -> Bool
estaCalmado = (>60) . complot

-- Punto 6 --
puedeEscaparse :: Ladron -> Bool
puedeEscaparse = tieneHabilidadDe "Disfrasarse de"

tieneHabilidadDe :: String -> Ladron -> Bool
tieneHabilidadDe condicion (Ladron _ habilidades _ ) = any (isPrefixOf condicion) habilidades

-- Punto 7 --

pintaMal :: [Rehen] -> [Ladron] -> Bool
pintaMal rehenes ladrones = promediocomplot rehenes > miedoPromedio rehenes * length ladrones

promediocomplot :: [Rehen] -> Int
promediocomplot rehenes = div (sum $ map complot rehenes) (length rehenes)

miedoPromedio :: [Rehen] -> Int
miedoPromedio rehenes = div (sum $ map miedo rehenes) (length rehenes)

-- Punto 8 -- 

seRebelan :: [Rehen] -> [Ladron] -> [Ladron]
seRebelan rehenes = map (seRebela $ map (reducirComplot 10) rehenes) 

seRebela :: Rehen -> Ladron -> Ladron
seRebela unRehen = ejecutarPlan unRehen

ejecutarPlan :: Rehen -> Ladron -> Ladron
ejecutarPlan 

-- Punto 9 --

planValencia :: [Rehen] -> [Ladron] -> [Ladron]
planValencia rehenes = seRebelan rehenes . conseguirUnArma (ametralladora 9) 

multiplicarDinero :: [Ladron] -> Int
multiplicarDinero = (*1000000). length . concatMap armas





