import Data.List

-- Postres --
-- Punto A --
data Postre = Postre {
    sabor :: [String],
    peso  :: Float,
    temperatura :: Int
} deriving Eq

-- Punto B --
type Hechizo = Postre -> Postre

incendio :: Hechizo
incendio unPostre = calentarPostre 1 . perderPeso (peso unPostre * 0.05) $ unPostre

calentarPostre :: Int -> Postre -> Postre
calentarPostre aumento unPostre =unPostre {temperatura = (+aumento) . temperatura $ unPostre}

perderPeso :: Float -> Postre -> Postre
perderPeso perdida unPostre = unPostre {peso = peso unPostre - perdida}

immobulous :: Hechizo
immobulous unPostre = perderPeso (peso unPostre) unPostre

wingardiumLeviosa :: Hechizo
wingardiumLeviosa unPostre = agregarSabor "concentrado" . perderPeso (peso unPostre * 0.10) $ unPostre

agregarSabor :: String -> Postre -> Postre
agregarSabor saborNuevo unPostre = unPostre {sabor = saborNuevo : sabor unPostre}

diffindo :: Float -> Hechizo
diffindo porcentaje unPostre = perderPeso (peso unPostre * porcentaje) unPostre

riddikulus :: String -> Hechizo
riddikulus saborNuevo = agregarSabor saborNuevo . revertirSabores

revertirSabores :: Postre -> Postre
revertirSabores unPostre =  unPostre { sabor = reverse $ sabor unPostre}

avadaKedavra :: Hechizo
avadaKedavra = elminarSabores . immobulous

elminarSabores :: Postre -> Postre
elminarSabores unPostre = unPostre {sabor = []}

-- Punto C --
estanListos :: Hechizo -> [Postre]-> Bool
estanListos hechizo = all estaListo . aplicarHechizo hechizo

estaListo :: Postre -> Bool
estaListo unPostre = ((>0) . peso $ unPostre) && ((>0) . length . sabor $ unPostre) && ((/= 0) . temperatura $ unPostre)

aplicarHechizo :: Hechizo -> [Postre] -> [Postre]
aplicarHechizo = map

-- Punto D   --
promedioPesoListos :: Hechizo -> [Postre] -> Float
promedioPesoListos hechizo postres = (sum . map peso . filtrarListos hechizo $ postres) / fromIntegral (length postres)

filtrarListos :: Hechizo -> [Postre] -> [Postre]
filtrarListos hechizo postres= filter estaListo . aplicarHechizo hechizo $ postres

-- Magos -- 
-- Punto A --
data Mago = Mago {
    hechizos :: [Hechizo],
    horrorcruxes :: Int
}

practicarHechizo :: Postre -> Hechizo -> Mago -> Mago
practicarHechizo postre hechizo unMago 
    |esLoMismo hechizo postre = sumarHorrocruxes . agregarHechizo hechizo $ unMago
    |otherwise = agregarHechizo hechizo unMago

esLoMismo ::  Hechizo -> Postre -> Bool
esLoMismo hechizo postre = hechizo postre == avadaKedavra postre

agregarHechizo :: Hechizo -> Mago -> Mago
agregarHechizo hechizo unMago = unMago {hechizos = hechizo : hechizos unMago}

sumarHorrocruxes :: Mago -> Mago
sumarHorrocruxes unMago = unMago {horrorcruxes = (+1) . horrorcruxes $ unMago}

-- Punto B --

mejorHechizoV1 :: Postre -> Mago -> Hechizo
mejorHechizoV1 postre mago = elMejor postre (hechizos mago)

elMejor :: Postre -> [Hechizo] -> Hechizo
elMejor postre [hechizo] = hechizo
elMejor postre (primer:segundo:restohechizos) 
    | esMejor postre primer segundo = elMejor postre (primer:restohechizos)
    | otherwise = elMejor postre (segundo:restohechizos)

esMejor :: Postre -> Hechizo -> Hechizo -> Bool
esMejor postre hechizo1 hechizo2 = (length . sabor . hechizo1) postre > (length . sabor . hechizo2) postre

-- Magia infinita --
-- Punto A --
infinitosPostres :: Postre -> [Postre]
infinitosPostres postre = (postre : infinitosPostres postre)

magoInfinitosHechizos :: Hechizo -> Mago -> Mago
magoInfinitosHechizos hechizo unMago = unMago {hechizos = (infinitosHechizos hechizo) ++ (hechizos unMago)}

infinitosHechizos :: Hechizo -> [Hechizo]
infinitosHechizos hechizo = (hechizo : infinitosHechizos hechizo)

-- No se puede encotnra el mejor hechizo ya que la lista seria infinita y siempre esta evaluando un siguiente hechizo 

