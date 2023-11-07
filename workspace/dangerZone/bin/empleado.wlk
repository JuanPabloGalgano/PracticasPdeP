class Empleado{
	
	var salud
	var habilidades
	var misionesHechas
	var rol
	
	method estaIncapacitado() = salud < rol.saludCritica()
		
	method puedeUsarHabilidad(unaHabilidad) = not self.estaIncapacitado() and self.tieneHabilidad(unaHabilidad)
	
	method tieneHabilidad(unaHabilidad) = habilidades.contains(unaHabilidad)
	
	method cumplirMision(unaMision){
		self.puedoCumplir(unaMision)
		self.recibirDanio(unaMision.peligrosidad())
		rol.registrarMision(unaMision)
	}
	
	method puedoCumplir(unaMision) = unaMision.laPuedeCumplir(self)
	
	method recibirDanio(unaCantidad){salud -= unaCantidad}
	
	method registrarMision(unaMision){ 
		misionesHechas.add(unaMision)
		rol.registrarMision(unaMision, self)
	}
	
	method aprenderHabilidad(unaHabilidad){
		habilidades.add(unaHabilidad)
	}
}

class Rol{
	
}

object espia inherits Rol{
	
	method saludCritica() = 15
	
	method registrarMision(unaMision, empleado){
		unaMision.enseniarHabilidadesA(empleado)
	}

}

object oficinista {
	
	var cantEstrellas = 0
	
	method saludCritica() = 40 - 5 * cantEstrellas
	
	method completarMision(unaMision, unEmpleado) {
		cantEstrellas += 1
		if (cantEstrellas == 3) {
			unaMision.puesto(espia)
		}
	}
}

class Jefe inherits Empleado{
	
	var subordinados
	
	override method tieneHabilidad(unaHabilidad) = 
	subordinados.any{subordinado => subordinado.tieneHabilidad(unaHabilidad)} ||
	super(unaHabilidad)
}