class Traje{
	
	method esAtacadoPor(atacante, defensor)
}

class Comun inherits Traje{
	
	const porcentaje
	
	override method esAtacadoPor(atacante, defensor){
		defensor.disminuirDanioRecibido(porcentaje)
	}
}

class Entrenamiento inherits Traje{
	
}