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
    puntosInvestigacion :: Int,
    esAlfa :: Bool
}

data Rango = Cielo | Estrella | Constelacion | Galaxia

type Item = Investigador -> Investigador

alfa :: Pokemon -> Pokemon
alfa unPokemon = unPokemon {puntosInvestigacion =(*2).puntosInvestigacion $ unPokemon , esAlfa = True}

akari :: Investigador
akari = Investigador "Akari" 1499 oshawott [] []

oshawott :: Pokemon
oshawott = Pokemon "Oshawott" "Nutria que pelea con el caparazon de su pecho" 5 3 False

-- Punto 2 --
saberRango :: Investigador -> Rango
saberRango = cantidadExperiencia  . experiencia

cantidadExperiencia :: Int -> Rango
cantidadExperiencia cantidad
    | cantidad < 100 = Cielo
    | cantidad < 500 = Estrella
    | cantidad < 2000 = Constelacion
    | otherwise = Galaxia

-- Punto 3 --
type Actividad = Investigador -> Investigador

obtenerUnItem :: Item -> Actividad
obtenerUnItem item = agregarItem item . item

agregarItem :: Item -> Investigador -> Investigador
agregarItem item unInvestigador = unInvestigador {mochila = item : mochila unInvestigador}

bayas :: Item
bayas unInvestigador = ganarExperiencia (experiencia unInvestigador) unInvestigador

ganarExperiencia :: Int -> Investigador -> Investigador
ganarExperiencia cantidad unInvestigador = unInvestigador {experiencia = experiencia unInvestigador + cantidad}

apricorns :: Item
apricorns unInvestigador = ganarExperiencia (experiencia unInvestigador * 0.5) unInvestigador

guijarros :: Item
guijarros = ganarExperiencia 2

fragmentosDeHierro :: Int -> Item
fragmentosDeHierro cantidad unInvestigador =unInvestigador {experiencia = div (experiencia $ unInvestigador) cantidad}

admirarElPaisaje :: Actividad 
admirarElPaisaje unInvestigador = ganarExperiencia (-((*0.5) .experiencia  $ unInvestigador )) unInvestigador

capturarUnPokemon :: Pokemon -> Actividad
capturarUnPokemon pokemon unInvestigador 
 | otorgaMasDe 20 pokemon = 
    agregarCompañero pokemon . agregarPokemon pokemon . ganarExperiencia (puntosInvestigacion pokemon) $ unInvestigador
 | otherwise = agregarPokemon pokemon . ganarExperiencia (puntosInvestigacion pokemon) $ unInvestigador

agregarPokemon :: Pokemon -> Investigador -> Investigador
agregarPokemon pokemon unInvestigador = unInvestigador {capturados = pokemon : capturados unInvestigador}

otorgaMasDe :: Int -> Pokemon -> Bool
otorgaMasDe cantidad (Pokemon _ _ _ experiencia _) = experiencia > cantidad

agregarCompañero :: Pokemon -> Investigador -> Investigador
agregarCompañero pokemon unInvestigador = unInvestigador {compañero = pokemon}

combatirUnPokemon :: Pokemon -> Actividad
combatirUnPokemon pokemon2 unInvestigador
    |leGana (compañero unInvestigador) pokemon2 = 
        ganarExperiencia ((*0.5) .puntosInvestigacion . compañero $ unInvestigador) unInvestigador 
    |otherwise = unInvestigador

leGana :: Pokemon -> Pokemon -> Bool
leGana pokemon1 pokemon2 = nivel pokemon1 > nivel pokemon2

-- Punto 4 --
type Expedicion = [Actividad]

nombreInvestigadores :: [Investigador] -> Expedicion -> [String]
nombreInvestigadores investigadores expedicion = 
    map nombre . filter ((>3). length . filtrarPorAlfa) . map (hacerExpedicion expedicion) $ investigadores 

filtrarPorAlfa :: Investigador -> [Pokemon]
filtrarPorAlfa = filter esAlfa . capturados

hacerExpedicion :: Expedicion -> Investigador -> Investigador
hacerExpedicion expedicion unInvestigador = foldr hacerActividad unInvestigador expedicion

hacerActividad :: Actividad -> Investigador -> Investigador
hacerActividad actividad = actividad

experienciaInvestigadores :: [Investigador] -> Expedicion -> [Int]
experienciaInvestigadores investigadores expedicion = 
    map experiencia . filtarPorRango (==Galaxia) . map (hacerExpedicion expedicion) $ investigadores

filtarPorRango :: (Rango -> Bool) -> [Investigador] -> [Investigador]
filtarPorRango condicion investigadores = filter (condicion . saberRango)  investigadores

almenosNivel10 :: [Investigador] -> Expedicion -> [Pokemon]
almenosNivel10 investigadores expedicion = 
    map compañero . filtrarPorNivel (>=10) . map capturados . map (hacerExpedicion expedicion) $ investigadores

filtrarPorNivel :: (Int -> Bool) -> [Pokemon] -> [Pokemon]
filtrarPorNivel condicion pokemons = filter (condicion . nivel) $ pokemons

ultimos3Pokemons :: [Investigador] -> Expedicion -> [Pokemon]
ultimos3Pokemons investigadores expedicion = map (take 3) . filtrarPorNivel even . capturados $ investigadores

-- Punto 5 --

-- Se podria hacer el 2do punto, ya que no es necesario utilizar la lista de pokemons capturados, sino que se utiliza unicamente la experiencia

