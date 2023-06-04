import Data.List

data Personaje = Personaje {
      nombre :: String,
      puntaje :: Int,
      inventario :: [Material]
}

-- Craft --
-- Punto 1 --

type Material = String

data Receta = Receta {
      materiales :: [Material],
      tiempo     :: Int,
      resultado  :: Material
}

craftear :: Receta -> Personaje -> Personaje
craftear receta = 
      agregarAInventario (resultado receta) . aumentarExperiencia (10 * tiempo receta) . usarMateriales receta

agregarAInventario :: Material -> Personaje -> Personaje
agregarAInventario material unPersonaje = unPersonaje {inventario = material : inventario unPersonaje}

aumentarExperiencia :: Int -> Personaje -> Personaje
aumentarExperiencia aumento unPersonaje = unPersonaje {puntaje = puntaje unPersonaje + aumento}

usarMateriales :: Receta -> Personaje -> Personaje
usarMateriales receta unPersonaje
      |tieneMateriales receta unPersonaje = unPersonaje {inventario = foldr quitarUnaVez (inventario unPersonaje) (materiales receta)}
      |otherwise                          = aumentarExperiencia (-100) unPersonaje

quitarUnaVez:: Eq a => a -> [a] -> [a]
quitarUnaVez _ [] = []
quitarUnaVez material (m:ms)  
 | material == m = ms
 | otherwise = m:quitarUnaVez material ms 

tieneMateriales :: Receta -> Personaje -> Bool
tieneMateriales  receta unPersonaje = all (flip tieneMaterial unPersonaje) (materiales receta)

tieneMaterial :: Material -> Personaje -> Bool
tieneMaterial material  = elem material . inventario


-- Punto 2 --

crafteablesDuplicadores :: [Receta] -> Personaje -> [Material]
crafteablesDuplicadores recetas unPersonaje = map resultado . filter (duplicaLuegoDeCraftear unPersonaje) $ recetas

duplicaLuegoDeCraftear ::  Personaje -> Receta -> Bool
duplicaLuegoDeCraftear unPersonaje receta = puntaje (craftear receta unPersonaje ) > 2 * puntaje unPersonaje

craftearSucesivamente :: [Receta] -> Personaje -> Personaje
craftearSucesivamente recetas unPersonaje = foldr craftear unPersonaje recetas

masPuntosAlReves :: Personaje -> [Receta] -> Bool
masPuntosAlReves unPersonaje listaDeRecetas = 
      puntosFinal (reverse listaDeRecetas) unPersonaje > puntosFinal listaDeRecetas unPersonaje

puntosFinal ::[Receta] -> Personaje -> Int
puntosFinal listaDeRecetas = puntaje . craftearSucesivamente  listaDeRecetas

-- Mine --
-- Punto 1 --
data Bioma = Bioma{
    materialesPresentes :: [Material],
    materialNecesario :: Material
}

type Herramienta = [Material] -> Material

minar :: Herramienta -> Personaje -> Bioma -> Personaje
minar herramienta unPersonaje bioma  
      |tieneMaterial (materialNecesario bioma) unPersonaje = agregarAInventario (herramienta . materialesPresentes $ bioma) . aumentarExperiencia 50 $ unPersonaje
      |otherwise                                           = unPersonaje

hacha :: Herramienta
hacha = last

espada :: Herramienta
espada = head 

pico :: Int -> Herramienta
pico = flip (!!) 

posicionMitad :: Herramienta
posicionMitad lista = pico (div (length lista) 2) lista

lambda :: Herramienta
lambda = head . filter (\m -> m == "lambda" ) 

