class Suenio{
	var cumplido = false
	var felicidonios
	
	method cumplirPara(unaPersona){
		self.validar(unaPersona)
		self.realizar(unaPersona)
		self.cumplir()
		unaPersona.sumarFelcidad(felicidonios)
	}
	method cumplir() {cumplido = true}
	method estaPendiente() = not cumplido
	method validar(unaPersona)
	method realizar(unaPersona)
}

class Adoptar inherits Suenio{
	
	const hijosAAdoptar
	
	override method validar(unaPersona) = not unaPersona.tieneUnHijo()
	
	override method realizar(unaPersona) {
		unaPersona.adoptar(hijosAAdoptar)
	}
}

class ViajarA inherits Suenio{
	
	var lugarSoniado
	
	override method validar(unaPersona){}
	
	override method realizar(unaPersona){
		unaPersona.viajarA(lugarSoniado)
	}
}

class RecibirseDe inherits Suenio{
	
	var carrera
	
	override method validar(unaPersona) = not unaPersona.estudio(carrera) and unaPersona.quiereEstudiar(carrera)
	
	override method realizar(unaPersona) {
		unaPersona.recibirseDe(carrera)
	}
}