class Invitado{
	
	var property disfraz
	var personalidad
	const property edad
	
	method estaDesconforme() = disfraz.puntaje() < 10 and self.condicionPor()
	
	method condicionPor()
	
	method puntajeDisfraz() = disfraz.puntaje()
	
	method satisfechoSiCambiaCon(otraPersona){
		self.cambiarCon(otraPersona)
		return self.estaDesconforme()
	}
	
	method cambiarCon(otraPersona){
		disfraz = otraPersona.disfraz()
	}
	
	method tieneDisfraz() = not disfraz.isEmpty()
	
	method esSexy() = personalidad.esSexy(self)
}

class Caprichoso inherits Invitado{
	
	override method condicionPor() = disfraz.nombreLargo()
}

class Pretencioso inherits Invitado{
	
	override method condicionPor() = disfraz.esModerno()
}

class Numerologo inherits Invitado{
	
	const numeroDeLaSuerte
	
	override method condicionPor() = disfraz.nombreExactamendeDe(numeroDeLaSuerte)
}