import Data.List


type Palabra = String
type Verso = String
type Estrofa = [Verso]
type Artista = String -- Nombre

esVocal :: Char -> Bool
esVocal = flip elem "aeiou"

tieneTilde :: Char -> Bool
tienTilde = flip elem "áéíóú"

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen f comp v1 v2 = comp (f v1) (f v2)

-- Rimas --
-- Punto A --
riman :: Palabra -> Palabra -> Bool
riman palabra1 palabra2 = palabra1 /= palabra2 && esAsonante palabra1 palabra2 || esConsonante palabra1 palabra2

esAsonante :: Palabra -> Palabra -> Bool
esAsonante palabra1 palabra2 = tomarUltimas 2 palabra1 == tomarUltimas 2 palabra2

esConsonante :: Palabra -> Palabra -> Bool
esConsonante palabra1 palabra2 = tomarUltimas 3 palabra1 == tomarUltimas 3 palabra2

tomarUltimas :: Int -> Palabra -> Palabra
tomarUltimas cantidad = reverse . take cantidad . reverse

-- Punto B --
-- ?

-- Conjugaciones --

type Conjugacion = Verso -> Verso -> Bool

porRimas :: Conjugacion
porRimas verso1 verso2 = rima (ultimaPalabra verso1) (ultimaPalabra verso2)

ultimaPalabra :: Verso -> Palabra
ultimaPalabra = last . words

anadipolis :: Conjugacion
anadipolis verso1 verso2 = ultimaPalabra verso1 == primeraPalabra verso2

primeraPalabra :: Verso -> Palabra
primeraPalabra = head . words

-- Patrones --
type Patron = Estrofa -> Bool
type Par = (Int,Int)

simple :: Par -> Patron
simple (n1,n2) estrofa = rima (versoAt n1 estrofa) (versoAt n2 estrofa)

versoAt ::  Int -> Estrofa -> Verso
versoAt posicion estrofa = estrofa !! (posicion - 1)

esdrujula :: Patron 
esdrujula estrofa = all (esEsdrujula . ultimaPalabra)
 
esEsdrujula :: Palabra -> Bool
esEsdrujula = tieneTilde . head . ultimasVocales 3

ultimasVocales :: Number -> Palabra -> String
ultimasVocales n = ultimasLetras n . filter vocal

vocal :: Char -> Bool
vocal letra = esVocal letra || tieneTilde letra

anafora :: Patron
anafora = iguales . map primeraPalabra

iguales :: [Palabra] -> Bool
iguales [] = False 
iguales [palabra:palabras] = all (==palabra) palabras

cadena :: Conjugacion -> Patron
cadena _ [] = False -- (?)
cadena _ [_] = True
cadena conjugacion (verso1:verso2:versos) =
 conjugacion verso1 verso2 && cadena conjugacion (verso2 : versos)

combinaDos :: Estrofa -> Patron -> Patron -> Bool
combinaDos estrofa patron1 patron2 = patron1 estrofa && patron2 estrofa

-- Punto B --
aabb :: Patron
aabb = simple (1,2) && simple (3,4)

abab :: Patron
abab = simple (1,3) && simple (2,4)

abba :: Patron
abba = simple (1,4) && simple (2,3)

hardcore :: Patron
hardcore = cadena rima && esdrujula

-- Pustas en escena --
data PuestaEnEscena = PuestaEnEscena { 
   artista         :: Artista,
   freestyle       :: Estrofa,
   potencia        :: Number,
   publicoExaltado :: Bool
 }
 
puestaBase :: Artista -> Estrofa -> PuestaEnEscena
puestaBase mc estrofa = PuestaEnEscena "mc" estrofa 1 False

type Estilo = PuestaEnEscena -> PuestaEnEscena
 
gritar :: Estilo
gritar = aumentarPotencia 0.5

aumentarPotencia :: Number -> PuestaEnEscena -> PuestaEnEscena
aumentarPotencia factor puesta = puesta {potencia = potencia puesta * (1 + factor)}

respuesta :: Bool -> Estilo
respuesta efectiva = exaltarPublico efectiva. aumentarPotencia 0.2

exaltarPublico :: Bool -> PuestaEnEscena -> PuestaEnEscena
exaltarPublico efectiva puesta = puesta {publicoExaltado = efectiva}
 
tirarSkills :: Patron -> Estilo
tirarSkills patron = exaltarPublicoSiCumple patron . aumentarPotencia 0.1

exaltarPublicoSiCumple :: Patron -> PuestaEnEscena -> PuestaEnEscena
exaltarPublicoSiCumple patron puesta = exaltarPublico (cumplePatron puesta patron) puesta
 
cumplePatron :: PuestaEnEscena -> Patron -> Bool
cumplePatron puesta patron = patron (freestyle puesta)

tirarFreestyle :: Artista -> Estrofa -> Estilo -> PuestaEnEscena
tirarFreestyle mc estrofa estilo = estilo (puestaBase mc estrofa)
   
-- 5) Jurado.
type Jurado = [Criterio]
 
type Criterio = (PuestaEnEscena -> Bool, Number)
 
puntaje :: PuestaEnEscena -> Jurado -> Number
puntaje puesta = puntajeFinal . valoraciones . cirteriosNumbereresantes puesta
 
puntajeFinal :: [Number] -> Number
puntajeFinal = max 3 . sum
 
valoraciones :: [Criterio] -> [Number]
valoraciones = map snd
 
cirteriosNumbereresantes :: PuestaEnEscena -> Jurado -> [Criterio]
cirteriosNumbereresantes puesta = filter (($ puesta) . fst)
 
-- 6) BONUS: 3, 2, 1... tiempo!
type Performance = [PuestaEnEscena] -- Todas del mismo artista
 
type Batalla = Performance -- Tiene el mismo tipo pero están todos los artistas mezclados, según el orden cronológico
 
seLlevaElCNumbero :: [Jurado] -> Batalla -> Artista
seLlevaElCNumbero jurados =
 artistaPerformance . performanceGanadora jurados . separarPorArtistas
 
artistaPerformance :: Performance -> Artista
artistaPerformance = artista . head
 
performanceGanadora :: [Jurado] -> (Performance, Performance) -> Performance
performanceGanadora jurados (performance1, performance2)
 | puntajeTotal jurados performance1 > puntajeTotal jurados performance2 =
   performance1
 | puntajeTotal jurados performance1 < puntajeTotal jurados performance2 =
   performance2
 | otherwise = error "REPLICA"
 
separarPorArtistas :: Batalla -> (Performance, Performance)
separarPorArtistas batalla =
 splitBy ((artistaPerformance batalla ==) . artista) batalla
 
puntajeTotal :: [Jurado] -> Performance -> Number 
puntajeTotal jurados = sum . map (flip puntajeTotalDePuesta jurados)
 
puntajeTotalDePuesta :: PuestaEnEscena -> [Jurado] -> Number
puntajeTotalDePuesta puesta = sum . map (puntaje puesta)
 
splitBy :: (a -> Bool) -> [a] -> ([a], [a])
splitBy cond lista = (filter cond lista, filter (not . cond) lista)


