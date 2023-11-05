class Caracteristica{
	
	method puntajePara(unaPersona)
}

class Gracioso inherits Caracteristica{
	
	const nivelDeGracia
	
	override method puntajePara(unaPersona){
		if(unaPersona.esMayor()){
			return nivelDeGracia * 3
		}
		return nivelDeGracia
	} 
}

class Tobara inherits Caracteristica{
	
	const diaDeCompra
	
	override method puntajePara(unaPersona){
		if(self.diasDesdeLaCompra() >= 2){
			return 5
		}
		return 3
	} 
	
	method diasDesdeLaCompra() = new Date().day() - diaDeCompra
}

class Careta inherits Caracteristica{
	
	const puntaje
	
	override method puntajePara(unaPersona) = puntaje 
}

class Sexy inherits Caracteristica{
	
	override method puntajePara(unaPersona){
		if(unaPersona.esSexy()){
			return 15
		}
		return 2
	}
}