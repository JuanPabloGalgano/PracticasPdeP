import Data.List

-- Punto 1 --

data Chofer = Chofer {
    nombre :: String,
    kilometraje :: Int,
    viajes :: [Viaje],
    condicion :: Condicion    
}

data Viaje = Viaje {
    fecha :: (Int,Int,Int),
    cliente :: Cliente,
    costo :: Int
}

data Cliente = Cliente{
    nombreCliente :: String,
    domicilio :: String
}

type Condicion = Viaje -> Bool

-- Punto 2 --

cualquierViaje :: Condicion
cualquierViaje _ = True

mayorA200 :: Condicion
mayorA200  = (> 200) . costo

mayorNLetras :: Int -> Condicion
mayorNLetras minimoLetras = (> minimoLetras) . length . nombreCliente . cliente

clienteNoViveEn :: String -> Condicion
clienteNoViveEn zona = (/= zona) . domicilio . cliente

-- Punto 3 --

lucas :: Cliente
lucas = Cliente "Lucas" "victoria"

daniel :: Chofer
daniel = Chofer "Daniel" 23500 [Viaje (20,04,2017) lucas 150] (clienteNoViveEn "olivos") 

alejandra :: Chofer
alejandra = Chofer "Alejandra" 180000 [] cualquierViaje

-- Punto 4 --

puedeTomarElViaje :: Viaje -> Chofer -> Bool
puedeTomarElViaje viaje (Chofer _ _ _ condicion) = condicion viaje

-- Punto 5 --

liquidacion :: Chofer -> Int
liquidacion = sum . map costo . viajes

-- Punto 6 --

realizarUnViaje :: Viaje -> [Chofer] -> Chofer
realizarUnViaje viaje = hacerViaje viaje . choferConMenosViajes . filter (puedeTomarElViaje viaje)

choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes [chofer] = chofer
choferConMenosViajes (chofer1 : chofer2 : choferes) = 
    choferConMenosViajes ((elQueMenosViajesHizo chofer1  chofer2) : choferes)

elQueMenosViajesHizo :: Chofer -> Chofer -> Chofer
elQueMenosViajesHizo chofer1 chofer2
    | cantidadViajes chofer1 > cantidadViajes chofer2 = chofer2
    | otherwise = chofer1

cantidadViajes :: Chofer -> Int
cantidadViajes (Chofer _ _ viajes _) = length viajes

hacerViaje :: Viaje -> Chofer -> Chofer
hacerViaje viaje chofer = chofer { viajes = viaje : viajes chofer}

-- Punto 7 --
repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

nitoInfy :: Chofer
nitoInfy = Chofer "Nito Infy" 70000 (repetirViaje viajeLucas) (mayorNLetras 2)

viajeLucas :: Viaje
viajeLucas = Viaje (11,03,2017) lucas 50

-- No se puede calcular la liquidacion de Nito no terminaria nunca, no s epodria calcular, ya que la lista es infinita
-- Si se puede, ya que no involuca la lista de viajes, por ende evalua unicamente la condicion

-- Punto 8 --
gongNeng ::  Ord a => a -> (a -> Bool) -> (b -> a) -> [b] -> a
gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3
