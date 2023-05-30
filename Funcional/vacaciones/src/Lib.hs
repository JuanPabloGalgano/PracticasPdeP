import Data.List

-- Punto 1 --
data Turista = Turista {
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [Idioma]
}
type Idioma = String
type Excursion = Turista -> Turista

ana :: Turista
ana = Turista 0 21 False ["Español"]

beto :: Turista
beto = Turista 15 15 True ["Aleman"]

cathi :: Turista
cathi = Turista 15 15 True ["Aleman", "Catalan"]

-- Punto 2 --

irALaPlaya :: Excursion
irALaPlaya unTurista
    |viajaSolo unTurista = reducirCansancio 5 unTurista
    |otherwise = reducirStress 1 unTurista

reducirCansancio :: Int -> Turista -> Turista
reducirCansancio cantidad unTurista = unTurista {cansancio = cansancio unTurista - cantidad}

reducirStress :: Int -> Turista -> Turista
reducirStress cantidad unTurista = unTurista {stress = stress unTurista - cantidad}

apreciarPaisaje :: String -> Excursion
apreciarPaisaje paisaje unTurista = reducirStress (length paisaje) unTurista

hablarUnIdioma :: Idioma -> Excursion
hablarUnIdioma idioma unTurista = unTurista { viajaSolo = True, idiomas = idioma : idiomas unTurista}

caminar :: Int -> Excursion
caminar minutos unTurista = reducirCansancio (div minutos 4). reducirStress (div minutos 4) $ unTurista

paseoEnBarco :: String -> Excursion
paseoEnBarco estadoMarea unTurista 
    |estadoMarea == "fuerte" = reducirCansancio (-10). reducirStress (-6) $ unTurista
    |estadoMarea == "tranquila" = caminar 10 . apreciarPaisaje "mar" . hablarUnIdioma "Aleman" $ unTurista
    |estadoMarea == "moderada" = unTurista
    |otherwise = error "No esta definido"

hacerExcursion :: Excursion -> Turista -> Turista
hacerExcursion excursion = reducirStressPorcentaje (-10) . excursion 

reducirStressPorcentaje porcentaje unTurista = reducirStress (div (porcentaje * stress unTurista) 100) unTurista

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Int) -> Turista -> Excursion -> Int
deltaExcursionSegun indice unTurista excursion = deltaSegun indice (hacerExcursion excursion unTurista) unTurista

esEducativa :: Turista -> Excursion -> Bool
esEducativa unTurista excursion = deltaExcursionSegun (length . idiomas) unTurista excursion > 0

esDesestresante :: Turista -> Excursion -> Bool
esDesestresante unTurista excursion = deltaExcursionSegun stress unTurista excursion <= (-3)

-- Punto 3 --

type Tour = [Excursion]

completo :: Tour
completo = [caminar 20, apreciarPaisaje "cascada", caminar 40, irALaPlaya, hablarUnIdioma "melmaquiano"]

ladoB :: Excursion -> Tour
ladoB unaExcursion = [paseoEnBarco "tranquila", unaExcursion ,caminar 120]

islaVecina :: String -> Tour
islaVecina mareaVecina = [paseoEnBarco mareaVecina, excursionEnislaVecina mareaVecina, paseoEnBarco mareaVecina ]

excursionEnislaVecina :: String -> Excursion
excursionEnislaVecina "fuerte" = apreciarPaisaje "Lago"
excursionEnislaVecina _ = irALaPlaya

hacerTour :: Turista -> Tour -> Turista
--hacerTour unTurista tours = foldl (flip hacerExcursion) (reducirStress (length tours) unTurista) tours
hacerTour unTurista tours = reducirStress (0 - length tours) . foldr hacerExcursion unTurista $ tours

type Tours = [Tour]

propuestaConvincente :: Turista -> Tours -> Bool
propuestaConvincente unTurista = any (esConvincente unTurista)

esConvincente :: Turista -> Tour -> Bool
esConvincente unTurista = any (dejaAcompaniado unTurista) . excursionesDesestresantes unTurista

excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes unTurista = filter (esDesestresante unTurista)

dejaAcompaniado :: Turista -> Excursion -> Bool
dejaAcompaniado unTurista = not . viajaSolo . flip hacerExcursion unTurista

efectividad :: Tour -> [Turista] -> Int
efectividad tour = sum . map (espiritualidadAportada tour) . filter (flip esConvincente tour)

espiritualidadAportada :: Tour -> Turista -> Int
espiritualidadAportada tour = negate . deltaRutina tour

deltaRutina :: Tour -> Turista -> Int
deltaRutina tour unTurista = deltaSegun nivelDeRutina (hacerTour unTurista tour) unTurista

nivelDeRutina :: Turista -> Int
nivelDeRutina unTurista = cansancio unTurista + stress unTurista