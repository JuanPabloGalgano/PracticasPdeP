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

filtrarConsitucionales :: CorteSuprema -> [Ley] -> [Ley]
filtrarConsitucionales corte = filter (votoCorteSuprema juces)

votoCorteSuprema :: CorteSuprema -> Ley  -> Bool
votoCorteSuprema jueces ley  = cuantosVotosPositivos ley jueces >= mayoria jueces

cuantosVotosPositivos ::  Ley -> CorteSuprema -> Number
cuantosVotosPositivos ley = length.filter ($ ley) 

ahoraSiSonConstitucionales :: [Ley] -> CorteSuprema -> CorteSuprema -> [Ley]
ahoraSiSonConstitucionales leyes corteSuprema nuevosJueces = 
    filter (antesNoPeroAhoraSi corteSuprema nuevosJueces) leyes

antesNoPeroAhoraSi :: CorteSuprema -> CorteSuprema -> Ley -> Bool
antesNoPeroAhoraSi corteSuprema nuevosJueces ley = 
     not (votoCorteSuprema corteSuprema ley) && votoCorteSuprema (corteSuprema ++ nuevosJueces) ley

ahoraSiSonConstitucionales' :: [Ley] -> CorteSuprema -> CorteSuprema -> [Ley]
ahoraSiSonConstitucionales' leyes corteSuprema nuevosJueces = 
  leyesConstitucionales (corteSuprema ++ nuevosJueces) (leyesInconstitucionales corteSuprema leyes) 

leyesInconstitucionales :: CorteSuprema -> [Ley] -> [Ley]
leyesInconstitucionales corteSuprema leyes = leyesPorConstitucionalidad not corteSuprema leyes

leyesConstitucionales :: CorteSuprema -> [Ley] -> [Ley]
leyesConstitucionales corteSuprema leyes = leyesPorConstitucionalidad id corteSuprema leyes

leyesPorConstitucionalidad :: (a->a) -> CorteSuprema -> [Ley] -> [Ley]
leyesPorConstitucionalidad funcion corteSuprema leyes = filter ((funcion.(votoCorteSuprema corteSuprema))) leyes

-- Cuestion de principios --
-- Punto 1 --
borocotizar :: CorteSuprema -> CorteSuprema
borocotizar = map borocotizarJuez

borocotizarJuez :: Juez -> Juez
borocotizarJuez = not

-- Punto 2 --
juezCoincideCon :: Juez -> String -> [Ley] -> Bool
juezCoincideCon juez sector leyes = all (elSectorApoyaLaLey sector) (leyesQueVota juez leyes)

elSectorApoyaLaLey :: String -> Ley -> Bool
elSectorApoyaLaLey partido ley = elem partido (apoyadoPor ley)

leyesQueVota :: Juez -> [Ley] -> [Ley]
leyesQueVota = filter
leyesQueVota' juez = filter (\ley -> juez ley)
leyesQueVota'' juez = filter juez
