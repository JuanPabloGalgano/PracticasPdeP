import personaje.*
import casa.*
import poniente.*

class Conspiracion{
	
	var personajeObjetivo
	var complotados
	
	method crearConspiracion(otroPersonaje, involucrados){
		otroPersonaje.esPeligoroso()
		personajeObjetivo = otroPersonaje
		complotados = involucrados
	}
	
	method cuantosTridoreshay(unaConspiracion){
		complotados.count{complotado => complotado.esAliadoDe(personajeObjetivo)}
	}
	
	method ejecutarConspiracion(){
		complotados.forEach{complotado => complotado.complotarContra(personajeObjetivo)}	
	}		
	
	method objetivoCumplio() = not personajeObjetivo.esPeligroso()
}

class Complotado{
	method complotarContra(otroPersonaje){}
}

class Sutil inherits Complotado{
	
	override method complotarContra(otroPersonaje){
		const casaMasPobre = poniente.casaMasPobre()
		const personasSolasYVivas = casaMasPobre.miembrosVivosYSolteros()
		otroPersonaje.intentaCasarteCon(personasSolasYVivas.anyOne())
	}
}

class Asesino inherits Complotado{
	
	override method complotarContra(otroPersonaje){ otroPersonaje.morir()}
}

class AsesinoPrecavido inherits Asesino{
	
	override method complotarContra(otroPersonaje){
		otroPersonaje.estaSolo()
		super(otroPersonaje)
	}
}

class Disipado inherits Complotado{
	const porcentajeADerrochar
	
	override method complotarContra(otroPersonaje){
		otroPersonaje.derrocharFortuna(porcentajeADerrochar)
	}
}

class Miedoso inherits Complotado{
	
}