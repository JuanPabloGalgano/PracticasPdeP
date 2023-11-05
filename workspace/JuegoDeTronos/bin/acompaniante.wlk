import personaje.*

class Acompaniante inherits Aliado{
	
}

object dragon inherits Acompaniante{
	override method esPeligroso() = true
}

class Loco inherits Acompaniante{
	
	const esHuargo
	
	override method esPeligroso() = esHuargo
}