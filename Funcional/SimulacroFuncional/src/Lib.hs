module Lib () where
import Data.List

-- Acá agregá las funciones

-- Punto 1 --

data Investigador = Investigador {
    nombre :: String,
    experiencia :: Int,
    compañero :: Pokemon,
    capturados :: [Pokemon],
    mochila :: [Item]
}

data Pokemon = Pokemon {
    mote :: String,
    descripcion :: String,
    nivel :: Int,
    puntosInvestigacion :: Int
}

data Rango = Cielo | Estrella | Constelacion | Galaxia

type Item = Int -> Int

akari :: Investigador
akari = Investigador "Akari" 1499 oshawott [] []

oshawott :: Pokemon
oshawott = Pokemon "Oshawott" "Nutria que pelea con el caparazon de su pecho" 5 3 False

-- Punto 2 --
saberRango :: Investigador -> Rango
saberRango = cantidadExperiencia  . experiencia

cantidadExperiencia :: Int -> Rango
cantidadExperiencia cantidad
    | cantidad <  100 = Cielo
    | cantidad <  500 = Estrella
    | cantidad < 2000 = Constelacion
    | otherwise       = Galaxia

-- Punto 3 --
type Actividad = Investigador -> Investigador

obtenerUnItem :: Item -> Actividad
obtenerUnItem item = cambiarMochila (item:) . cambiarExperiencia item

baya :: Item
baya = (^2) . (+1)

apricorns :: Item
apricorns = (*1.5)

guijarro :: Item
guijarro = (+2)

fragmentosDeHierro :: Int -> Item
fragmentosDeHierro cantidad = (/cantidad)
--fragmentosDeHierro cantidad = (flip div cantidad)

admirarElPaisaje :: Actividad 
admirarElPaisaje = cambiarExperiencia (*0.95) . cambiarMochila (drop 3)
    
cambiarMochila :: ([Item] -> [Item]) -> Investigador -> Investigador
cambiarMochila funcion unInvestigador = 
    unInvestigador {
    mochila = funcion . mochila $ unInvestigador
    } 

cambiarExperiencia :: (Int -> Int) -> Investigador -> Investigador
cambiarExperiencia funcion unInvestigador =
    unInvestigador {
        experiencia = funcion . experiencia $ unInvestigador
    }

capturarUnPokemon :: Pokemon -> Actividad
capturarUnPokemon pokemon = agregarPokemon pokemon . cambiarExperiencia (+ puntosQueOtorga pokemon)

agregarPokemon :: Pokemon -> Investigador -> Investigador
agregarPokemon pokemon unInvestigador = 
    unInvestigador {
        compañero = mejorCompañero pokemon (compañero unInvestigador),
        capturados = pokemon : capturados unInvestigador
        }

mejorCompañero :: Pokemon -> Pokemon -> Pokemon
mejorCompañero nuevoPokemon compañero
    |nivel nuevoPokemon > 20 = nuevoPokemon
    |otherwise = compañero

puntosQueOtorga :: Pokemon -> Int
puntosQueOtorga pokemon 
    | esAlfa = puntosInvestigacion * 2
    | otherwise = puntosInvestigacion

esAlfa :: Pokemon -> Bool
esAlfa unPokemon = empiezaConAlfa (unPokemon) || tieneTodasLasVocales (mote unPokemon)

empiezaConAlfa :: String -> Bool
empiezaConAlfa = isPrefixOf "Alfa"

tieneTodasLasVocales :: String -> Bool
tieneTodasLasVocales unMote = all (flip elem unMote) "aeiou"

combatirUnPokemon :: Pokemon -> Actividad
combatirUnPokemon unPokemon unInvestigador
    |leGana (compañero unInvestigador) unPokemon = cambiarExperiencia ((puntosQueOtorga unPokemon/2)+) unInvestigador 
    |otherwise                                   = unInvestigador

leGana :: Pokemon -> Pokemon -> Bool
leGana pokemon1 pokemon2 = nivel pokemon1 > nivel pokemon2

-- Punto 4 --
type Expedicion = [Actividad]
{-
nombreInvestigadores :: [Investigador] -> Expedicion -> [String]
nombreInvestigadores investigadores expedicion = 
    map nombre . filter ((>3). length . filtrarPorAlfa) . map (hacerExpedicion expedicion) $ investigadores 

ultimos3Pokemons :: [Investigador] -> Expedicion -> [Pokemon]
ultimos3Pokemons investigadores expedicion = map (take 3) . filtrarPorNivel even . capturados $ investigadores

experienciaInvestigadores :: [Investigador] -> Expedicion -> [Int]
experienciaInvestigadores investigadores expedicion = 
    map experiencia . filtarPorRango (==Galaxia) . map (hacerExpedicion expedicion) $ investigadores

almenosNivel10 :: [Investigador] -> Expedicion -> [Pokemon]
almenosNivel10 investigadores expedicion = 
    map compañero . filtrarPorNivel (>=10) . map capturados . map (hacerExpedicion expedicion) $ investigadores
-}
-- Todos los reportes hacel lo mismo, un map y dsp una condicion entonces se puede hacer asi =

type Reporte a = (Investigador -> a ) -> (Investigador -> Bool ) -> Expedicion -> [Investigador]-> [a]

reporte :: Reporte
reporte  transformacion condicion unaExpedicion = 
    map transformacion . filter condicion . map (hacerExpedicion unaExpedicion) 

nombreInvestigadores :: Reporte String
nombreInvestigadores = reporte nombre ((>3) . length . filtrarPorAlfa)

experienciaInvestigadores :: Reporte Int
experienciaInvestigadores = reporte experiencia ((==Galaxia) . saberRango)

almenosNivel10 :: Reporte Pokemon
almenosNivel10 = reporte compañero ((>=10) . nivel . compañero) 

ultimos3Pokemons :: Reporte [Pokemon]
ultimos3Pokemons = reporte (take 3) (all (odd . nivel) . capturados)

filtrarPorAlfa :: Investigador -> [Pokemon]
filtrarPorAlfa = filter esAlfa . capturados

hacerExpedicion :: Expedicion -> Investigador -> Investigador
hacerExpedicion expedicion unInvestigador = foldr hacerActividad unInvestigador expedicion
--hacerExpedicion expedicion unInvestigador = foldr ($) unInvestigador expedicion --Porque la funcion pesos aplica

hacerActividad :: Actividad -> Investigador -> Investigador
hacerActividad actividad = actividad

-- Punto 5 --

-- Se podria hacer el 2do punto, ya que no es necesario utilizar la lista de pokemons capturados, sino que se utiliza unicamente la experiencia

