import Data.List

-- PUnto 1 --

data Pais = Pais {
    ipc :: Float,
    poblacionActiva :: (Publica,Privada),
    recursosNaturales :: [Recurso],
    deuda :: Float
}

type Publica = Float
type Privada = Float
type Recurso = String


namibia = Pais 4140 (400000,650000) ["mineria","ecoculturismo"] 50000000

-- Punto 2 --
type Estrategia = Pais -> Pais

prestamo :: Float -> Estrategia
prestamo cantidad pais = pais { deuda = deuda pais + cantidad * 1.5}

reducir :: Float -> Estrategia
reducir cantidad pais = pais {ipc = reducirIpc pais, poblacionActiva = reducirPoblacionPublica cantidad pais}

reducirIpc :: Pais -> Float
reducirIpc pais
    |fst (poblacionActiva pais) > 100 = ipc pais * 0.8
    |otherwise = ipc pais * 0.85

reducirPoblacionPublica ::  Float -> Pais -> (Float,Float)
reducirPoblacionPublica n (Pais _ (publico,privado) _ _) = (publico - n, privado)

darleAUnaEmpresa :: Recurso -> Estrategia
darleAUnaEmpresa recurso pais = pais {recursosNaturales = sacarRecurso recurso pais, deuda = (deuda pais) - 2000000}

sacarRecurso :: Recurso -> Pais -> [Recurso]
sacarRecurso recurso (Pais _ _ recursos _) = filter (/=recurso) recursos

establecerBlindaje :: Estrategia
establecerBlindaje pais = pais {poblacionActiva = reducirPoblacionPublica 500 pais, deuda = deuda pais + (calculoPBI pais)}

calculoPBI :: Pais -> Float
calculoPBI (Pais ipc (publicos,privados) _ _) = ipc * (publicos + privados)

-- Punto 3 --
type Receta = [Estrategia]

receta :: Receta
receta = [darleAUnaEmpresa "mineria", prestamo 200000000]

recetasNamibia = aplicarReceta receta namibia

aplicarReceta receta pais = foldr ($) pais receta

-- Punto 4 --

zafar :: [Pais] -> [Pais]
zafar paises = filter tienePetroleo paises
    where
        tienePetroleo pais = elem "petroleo" $ recursosNaturales pais 

totalDeuda :: [Pais] -> Float
totalDeuda paises = sum . map deuda $ paises

-- Punto 5 --

recetasOrdenadas :: Receta -> Pais -> Bool
recetasOrdenadas recetas pais = ordenarRecetas recetas pais

ordenarRecetas :: Receta -> Pais -> Bool
ordenarRecetas [] _ = True
ordenarRecetas [receta] pais = pbiReceta receta pais >=  (calculoPBI pais)
ordenarRecetas (receta1:receta2:recetas) pais =
    pbiReceta receta1 pais >= pbiReceta receta2 pais &&
    ordenarRecetas (receta2:recetas) pais

pbiReceta :: Estrategia -> Pais -> Float
pbiReceta estrategia pais = calculoPBI . estrategia $ pais