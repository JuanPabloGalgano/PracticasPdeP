import Data.List

-- Punto 1 --
data Elemento = Elemento { 
            tipo :: String,
	      ataque :: (Personaje-> Personaje),
	      defensa :: (Personaje-> Personaje) 
      }

data Personaje = Personaje { 
            nombre :: String,
	      salud :: Float,
	      elementos :: [Elemento],
	      anioPresente :: Int 
      }

mandarAlAnio :: Int -> Personaje -> Personaje
mandarAlAnio anio unPersonaje = unPersonaje {anioPresente = anio}

meditar :: Personaje -> Personaje
meditar unPersonaje = modificarSalud (*1.5)

causarDanio :: Int -> Personaje -> Personaje
causarDanio danioCausado unPersonaje = modificarSalud (max 0 . flip (-) danioCausado)

modificarSalud :: (Float -> Float) -> Personaje -> Personaje
modificarSalud transformacion personaje = personaje { salud = (transformacion . salud) personaje }

-- Punto 2 --
esMalvado :: Personaje -> Bool
esMalvado personaje = any (esDeTipo "Maldad") . elementos $ personaje

esDeTipo :: String -> Elemento -> Bool
esDeTipo unTipo elemento = tipo elemento == unTipo

danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce unPersonaje elemento = salud unPersonaje - salud (ataque elemento unPersonaje)

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales personaje enemigos = filter (esEnemigoMortal personaje) enemigos

esEnemigoMortal :: Personaje -> Personaje -> Bool
esEnemigoMortal personaje enemigo = any (tieneAtaqueMortal personaje) . elementos $ enemigo

tieneAtaqueMortal :: Personaje -> Elemento -> Bool
tieneAtaqueMortal personaje elemento = danioQueProduce personaje elemento == salud personaje

-- Punto 3 --
concentracion :: Int -> Elemento
concentracion nivelDeConcentracion = Elemento "Magia" noHacerNada ((!! nivelDeConcentracion). iterate meditar)

esbirrosMalvados :: Int -> [Elemento]
esbirrosMalvados cantidadDeEsbirros = replicate cantidadDeEsbirros esbirro

esbirro :: Elemento
esbirro = Elemento "Maldad" (causarDanio 1) noHacerNada

jack :: Personaje
jack = Personaje "Jack" 300 [concentracion 3, katanaMagica] 200

katanaMagica :: Elemento
katanaMagica = Elemento "Magia" (causarDanio 1000) noHacerNada

aku :: Int -> Float -> Personaje
aku anio cantidadDeSalud = Personaje "Aku" cantidadDeSalud (concentracion 4 : replicate (anio * 100) esbirro : portalAlFuturo) anio

portalAlFuturo :: Int -> Elemento
portalAlFuturo anio = Elemento "Magia" (mandarAlAnio anioFuturo) (aku anioFuturo . salud)
      where
            anioFuturo = anio + 2800

-- Punto 4 --
luchar :: Personaje -> Personaje -> (Personaje,Personaje)
luchar atacante defensor 
      |estaMuerto atacante = (defensor, atacante)
      |otherwise = luchar proximoAtacante proximoDefensor
      where
            proximoAtacante = usarElementos ataque defensor (elementos atacante)
            proximoDefensor = usarElementos defensa atacante (elementos atacante)

estaMuerto :: Personaje -> Bool
estaMuerto = ((==0).salud)

usarElementos :: (Elemento -> Personaje -> Personaje) -> Personaje -> [Elemento] -> Personaje
usarElementos funcion personaje elementos = foldr $ personaje (map funcion elementos)

afectar personaje funcion = funcion personaje

-- Punto 5 --
f :: (Eq t1, Num t2) => (t1 -> a1 -> (a2, a2)) -> (t2 -> t1) -> t1 -> [a1] -> [a2]
f x y z
    | y 0 == z = map (fst.x z)
    | otherwise = map (snd.x (y 0))



