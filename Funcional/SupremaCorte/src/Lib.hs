import Data.List

-- Punto A --
-- Punto 1 --

data Ley = Ley {
    tema :: String,
    presupuesto :: Int,
    apoyadoPor :: [String]
}

sonCompatibles :: Ley -> Ley -> Bool
sonCompatibles ley1 ley2 = sectoresEnComun ley1 ley2 && mismoTema ley1 ley2

sectoresEnComun :: Ley -> Ley -> Bool
sectoresEnComun ley1 ley2 = hayElementosEnComun (apoyadoPor ley1) (apoyadoPor ley2)

hayElementosEnComun :: [String] -> [String] -> Bool
hayElementosEnComun sectores1 sectores2 = any (flip elem sectores1) sectores2

mismoTema :: Ley -> Ley -> Bool
mismoTema (Ley tema1 _ _) (Ley tema2 _ _) = isInfixOf tema1 tema2 || isInfixOf tema2 tema1

-- Punto B --
type Juez = Ley -> Bool
type CorteSuprema = [Juez]

juezPublica :: Juez
juezPublica ley = elem (tema ley) agenda

juezAntiFinanciero :: Juez
juezAntiFinanciero ley = not . elem "Sector financiero" . apoyadoPor $ ley

juezPesupuesto10 :: Juez
juezPesupuesto10 = (>10) . presupuesto

juezPesupuesto20 :: Juez
juezPesupuesto20 = (>20) . presupuesto

juezConservador :: Juez
juezConservador = elem "Partido conservador" . apoyadoPor

esConstitucional :: Ley -> CorteSuprema -> Bool
esConstitucional ley jueces = cuantosVotosPositivos ley jueces >= mayoria jueces

mayoria :: CorteSuprema -> Int
mayoria jueces = length jueces / 2

cuantosVotosPositivos :: Ley -> CorteSuprema -> Int
cuantosVotosPositivos ley = length . filter ($ ley)

-- Punto 2 --
juezVerdadero :: Juez
juezVerdadero _ = True

juezInventado :: Juez
juezInventado = (isInfixOf "deporte") . tema

juezPresupuesto2 :: Juez
juezPresupuesto2 = (<5) . presupuesto

-- Punto 3 --

filtrarConsitucionales :: [Ley] -> CorteSuprema -> [Ley]
filtrarConsitucionales leyes =



