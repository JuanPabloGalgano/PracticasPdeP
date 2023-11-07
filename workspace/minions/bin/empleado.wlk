 import fruta.*
 import tarea.*
 
 class Empleado{
	
	var property estamina
	var tareasRealizadas
	var rol
	
	method comerFruta(unaFruta) {self.recuperarEstamina(unaFruta.estaminaRecuperada())}
	
	method recuperarEstamina(unaCantidad){ estamina += unaCantidad}
	
	method experiencia() = tareasRealizadas.size() * self.dificultadTareas()
	
	method dificultadTareas() = tareasRealizadas.sum{tarea => tarea.dificultadPara(self)}
	
	method realizarTarea(unaTarea) {
		unaTarea.laRealiza(self)
		self.agregarATareas(unaTarea)	
	}
	method agregarATareas(unaTarea) { tareasRealizadas.add(unaTarea)}
	
	method tieneEstasHerramientas(unasHerramientas) = rol.tieneHerramientasNecesarias(unasHerramientas)
	
	method perderEstamina(unaCantidad) { estamina -= unaCantidad}
	
	method fuerza() = estamina / 2 + 2 + rol.fuerza()
	
	method esMucama() = rol.esMucama()
	
	method defenderUnSector(unSector) = rol.defiendoUnSector(self)
	
	method dificultadDeSector(unSector)
	
	method limpiaUnSector(unSector) { rol.limpioUnSector(self, unSector)}
}

class Biclope inherits Empleado{
	
	override method dificultadDeSector(unSector) = unSector.gradoAmenaza()
	
}

class Ciclope inherits Empleado{
	
	override method fuerza() = super() / 2
	
		override method dificultadDeSector(unSector) = unSector.gradoAmenaza() * 2
	

}