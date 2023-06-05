https://www.cs.us.es/~jalonso/cursos/i1m/doc/Funciones_basicas.html

-- Como hacer un Fold, el hacerActividad lo puedo reemplazar por el $, o poner foldl y poner (flip ($))
hacerExpedicion :: Expedicion -> Investigador -> Investigador
hacerExpedicion expedicion unInvestigador = foldr hacerActividad unInvestigador expedicion
--hacerExpedicion expedicion unInvestigador = foldr ($) unInvestigador expedicion --Porque la funcion pesos aplica
hacerActividad :: Actividad -> Investigador -> Investigador
hacerActividad actividad = actividad

-- Hacer un tipo de dato en vez de repetir muchas veces lo mismo, el a significa q devuelve
type Reporte a = (Investigador -> a ) -> (Investigador -> Bool ) -> Expedicion -> [Investigador]-> [a]
reporte :: Reporte
reporte  transformacion condicion unaExpedicion = 
    map transformacion . filter condicion . map (hacerExpedicion unaExpedicion) 
nombreInvestigadores :: Reporte String
nombreInvestigadores = reporte nombre ((>3) . length . filtrarPorAlfa)

-- Inferenciad e datos de esta funcion
f :: (Eq t1, Num t2) => (t1 -> a1 -> (a2, a2)) -> (t2 -> t1) -> t1 -> [a1] -> [a2]
f x y z
    | y 0 == z = map (fst.x z)
    | otherwise = map (snd.x (y 0))

-- Recursividad
elMejor :: Postre -> [Hechizo] -> Hechizo
elMejor postre [hechizo] = hechizo
elMejor postre (primer:segundo:restohechizos) 
    | esMejor postre primer segundo = elMejor postre (primer:restohechizos)
    | otherwise = elMejor postre (segundo:restohechizos)

-- Nose
filtrarConsitucionales :: CorteSuprema -> [Ley] -> [Ley]
filtrarConsitucionales corte = filter (votoCorteSuprema juces)
votoCorteSuprema :: CorteSuprema -> Ley  -> Bool
votoCorteSuprema jueces ley  = cuantosVotosPositivos ley jueces >= mayoria jueces
cuantosVotosPositivos ::  Ley -> CorteSuprema -> Number
cuantosVotosPositivos ley = length.filter ($ ley) 

-- Nose
juezCoincideCon :: Juez -> String -> [Ley] -> Bool
juezCoincideCon juez sector leyes = all (elSectorApoyaLaLey sector) (leyesQueVota juez leyes)
elSectorApoyaLaLey :: String -> Ley -> Bool
elSectorApoyaLaLey partido ley = elem partido (apoyadoPor ley)
leyesQueVota :: Juez -> [Ley] -> [Ley]
leyesQueVota = filter

-- Saber cual es la mejor estrategia de las 2 dadas, por un parametro de la flota luego de aplicar lae strategia
type Mision a = Nave -> Flota -> Estrategia -> Estrategia -> a
type Estrategia = Nave -> Bool
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
misionSopresa :: Nave -> Flota -> Estrategia -> Flota
misionSopresa unaNave flotaEnemiga estrategia = map (atacarNave unaNave) $ filtrarFlotaEnemiga flotaEnemiga estrategia
filtrarFlotaEnemiga :: Flota -> Estrategia -> Flota
filtrarFlotaEnemiga flotaEnemiga estrategia = filter estrategia flotaEnemiga
atacarNave :: Nave -> Nave -> Nave
atacarNave atacante defensor = aumentarDurabilidad (-(diferenciaAtaqueEscudo (activarPoder atacante) (activarPoder defensor))) defensor
diferenciaAtaqueEscudo :: Nave -> Nave -> Int
diferenciaAtaqueEscudo (Nave _ _ _ ataque _) (Nave _ _ escudo _ _) = max 0 (ataque - escudo)
activarPoder :: Nave -> Nave
activarPoder unaNave = (poder unaNave) unaNave

-- Para ver si todos los elementos de una lista son iguales
iguales :: [Palabra] -> Bool
iguales [] = False 
iguales [palabra:palabras] = all (==palabra) palabrasç

-- Quitar una vez, tipo delete
quitarUnaVez:: Eq a => a -> [a] -> [a]
quitarUnaVez _ [] = []
quitarUnaVez material (m:ms)  
 | material == m = ms
 | otherwise = m:quitarUnaVez material ms 

 
