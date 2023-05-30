import Data.List

-- Punto 1 --
data Heroe = Heroe {
    epiteto        :: String,
    artefactos     :: [Artefacto],
    reconocimiento :: Int
    tareas         :: [Tarea]
}

data Artefacto = Artefacto {
    nombre :: String,
    rareza :: Int
}

type Tarea = Heroe -> Heroe

-- Punto 2 --
pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria unHeroe 
    |reconocimiento unHeroe > 1000 = cambiarEpiteto "El mitico" unHeroe
    |reconocimiento unHeroe >= 500 = cambiarEpiteto "El maginifico" . agregarArtefacto lanzaDelOlimpo $ unHeroe
    |reconocimiento unHeroe >  100 = cambiarEpiteto "Hoplita" . agregarArtefacto xiphos $ unHeroe
    |otherwise                     = unHeroe

cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto nuevoEpiteto unHeroe = unHeroe {epiteto = nuevoEpiteto}

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto artefacto unHeroe = unHeroe { artefactos = artefacto : artefactos unHeroe }

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "Lanza del olimpo" 100

xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50

-- Punto 3 --
encontrarUnArtefacto :: Artefacto -> Tarea
encontrarUnArtefacto artefacto = ganarReconocimiento (rareza artefacto) . agregarArtefacto artefacto $ unHeroe

ganarReconocimiento :: Int -> Heroe -> Heroe
ganarReconocimiento unReconocimiento unHeroe = unHeroe {reconocimiento = reconocimiento unHeroe + unReconocimiento}

escalarElOlimpo :: Tarea
escalarElOlimpo = ganarReconocimiento 500 . agregarArtefacto relampagoDeZeuz. desecharArtefactosComunes . triplicarRareza

triplicarRareza :: Artefacto -> Artefacto
triplicarRareza unArtefacto = unArtefacto {rareza = rareza unArtefacto * 3}

desecharArtefactosComunes :: Heroe -> Heroe
desecharArtefactosComunes = mapArtefactosHeroe (filter ((>= 1000) . rareza))

ayudarACruzarLaCalle :: Int -> Tarea
ayudarACruzarLaCalle cuadras unHeroe = cambiarEpiteto ("Gros" ++ replicate cuadras 'o')

matarALaBestia :: Bestia -> Tarea
matarALaBestia unaBestia unHeroe
    |debilidad unaBestia unHeroe = cambiarEpiteto ("El asesido de " ++ nombreBestia unaBestia) unHeroe
    |otherwise = mapArtefactosHeroe (drop 1) . cambiarEpiteto "El cobarde" $ unHeroe

type Debilidad = Heroe -> Bool

data Bestia = Bestia {
    nombreBestia = String,
    debilidad = Debilidad
}

-- Punto 4 -- 
heracles :: Heroe
heracles = Heroe "Guardian del olimpo" [pistola, relampagoDeZeuz] 700 [matarAlLeonDeNemea]

pistola :: Artefacto
pistola = Artefacto "Pistola" 1000

-- punto 5 -- 
matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea = matarALaBestia leonDeNemea

leonDeNemea :: Bestia
leonDeNemea = Betia "Leon de Nemea" ((>=20) . length . epiteto)

-- punto 6 -- 
hacerTarea :: Tarea -> Heroe -> Heroe
hacerTarea unatarea unHeroe = (unatarea unHeroe) {tareas = unatarea : tareas unHeroe}

-- Punto 7 --
presumir :: Heroe -> Heroe -> (Heroe, Heroe)
presumir heroe1 heroe2 
    |leGana heroe1 heroe2 = (hero1,heroe2)
    |leGana heroe2 heroe1 = (heroe2,heroe1)
    |otherwise = presumir (realizarTareas (tareas heroe2) heroe1) (ralizarTarea (tareas heroe1) heroe2)

sumatoriaRarezaArtefactos :: Heroe -> Int
sumatoriaRarezaArtefactos = sum . map rareza . artefactos

realizarTareas :: [Tarea] -> Heroe -> Heroe
realizarTareas tareas unHeroe = foldl (flip hacerTarea) unHeroe tareas

leGana :: Heroe -> Heroe -> Bool
leGana hero1 heroe2 
    |(reconocimiento heroe1 >  reconocimiento heroe2) ||
    |(reconocimiento heroe1 == reconocimiento heroe2&&
    sumatoriaRarezaArtefactos heroe1 > sumatoriaRarezaArtefactos heroe2)

-- Punto 9 --
relizarLabor :: [Tarea] -> Heroe -> Heroe
relizarLabor = realizarTareas