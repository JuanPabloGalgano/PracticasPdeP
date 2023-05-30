import Data.List

-- Punto 1 --
data Raton = Raton {
      nombre :: String,
      edad :: Float,
      peso :: Float,
      enfermedades :: [Enfermedad]
}
type Enfermedad = String

cerebro :: Raton
cerebro = Raton "Cerebro" 9 0.2 ["tuberculosis", "sarampion", "brucelosis"]

bicenterrata :: Raton
bicenterrata = Raton "Bicenterrata" 256 0.2 []

huesudo :: Raton 
huesudo = Raton "Huesudo" 4 10 ["alta obesidad", "sinusitis"]

-- Punto 2 --
type Hierba = Raton -> Raton

hierbaBuena :: Hierba
hierbaBuena unRaton = unRaton {edad = sqrt . edad $ unRaton} 

hierbaVerde :: String -> Hierba
hierbaVerde sufijo unRaton = enfermedadesTerminaEn sufijo unRaton

enfermedadesTerminaEn :: String -> Raton -> Raton
enfermedadesTerminaEn sufijo unRaton = unRaton { enfermedades = filter (isSuffixOf sufijo) . enfermedades $ unRaton}

alcachofa :: Hierba
alcachofa = reducirPesoRaizCuadrada

reducirPesoRaizCuadrada :: Raton -> Raton
reducirPesoRaizCuadrada unRaton
      |peso unRaton > 2 = unRaton {peso = peso unRaton * 0.9}
      |otherwise        = unRaton {peso = peso unRaton * 0.95}

hierbaZort :: Hierba 
hierbaZort unRaton = Raton "Pinky" 0 (peso unRaton) []

hierbaDelDiablo :: Hierba 
hierbaDelDiablo = reducirPeso 0.1 . eliminarEnfermedades 10

reducirPeso ::  Float -> Raton -> Raton
reducirPeso pesoAReducir unRaton = unRaton {peso = peso unRaton - pesoAReducir}

eliminarEnfermedades ::Int -> Raton -> Raton
eliminarEnfermedades cantidad unRaton = unRaton {enfermedades = filter ((<cantidad) . length ) . enfermedades $ unRaton}

-- Punto 3 --
type Medicamento = [Hierba]

pondsAntiAge :: Medicamento
pondsAntiAge = [hierbaBuena, hierbaBuena, hierbaBuena, alcachofa]

reduceFatFast :: Int -> Medicamento
reduceFatFast potencia = [hierbaVerde "Obesidad"] ++ replicate potencia alcachofa 

pdepCilina :: Medicamento
pdepCilina = map hierbaVerde sufijosInfecciosas
  
sufijosInfecciosas = [ "sis", "itis", "emia", "cocos"]

-- Punto 4 --
cantidadIdeal :: (Int -> Bool) -> Int
cantidadIdeal condicion = head (filter condicion [1..])

lograEstabilizar :: Medicamento -> [Raton] -> Bool
lograEstabilizar medicamento ratones = 
      ningunoConSobrepeso  (medicarRatones medicamento ratones) && 
      menosDe3Enfermedades (medicarRatones medicamento ratones)

medicarRatones :: Medicamento -> [Raton] -> [Raton]
medicarRatones medicamento ratones = map (componerMedicamento medicamento) ratones

componerMedicamento :: Medicamento -> (Raton -> Raton)
componerMedicamento [] = id
componerMedicamento (x:xs) = x . componerMedicamento xs

ningunoConSobrepeso :: [Raton] -> Bool
ningunoConSobrepeso ratones = all ((<1) . peso) ratones

menosDe3Enfermedades :: [Raton] -> Bool
menosDe3Enfermedades ratones = all ((<3) . length . enfermedades) ratones





