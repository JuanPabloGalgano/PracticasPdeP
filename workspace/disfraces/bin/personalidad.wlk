class Personalidad{
	method esSexy(unaPersona)
}

object alegre inherits Personalidad{
	
	override method esSexy(unaPersona) = false
}

object taciturna inherits Personalidad{
	
	override method esSexy(unaPersona) = unaPersona.edad() < 30
}

class Cambiante inherits Personalidad{
	
	var personalidadActual
	
	override method esSexy(unaPersona) = personalidadActual.esSexy(unaPersona)
	
	method cambiarPersonalidad(nuevaPersonalidad) { personalidadActual = nuevaPersonalidad }  
}
