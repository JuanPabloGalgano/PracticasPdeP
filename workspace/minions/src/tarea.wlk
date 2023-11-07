import cientifico.*

class Tarea{
	
	method laRealiza(unEmpleado){}
	
	method puedeRealizarLaTarea(unEmpleado)
	
	method dificultadPara(unEmpleado)
}

class ArreglarUnaMaquina inherits Tarea{
	
	const complejidad
	const herramientasNecesarias
	
	override method puedeRealizarLaTarea(unEmpleado) = 
		unEmpleado.estamina() and self.tieneHerramientasNecesarias(unEmpleado)
	
	method tieneHerramientasNecesarias(unEmpleado) = unEmpleado.tieneEstasHerramientas(herramientasNecesarias)
	
	override method laRealiza(unEmpleado){
		self.puedeRealizarLaTarea(unEmpleado)
		unEmpleado.perderEstamina(complejidad)
	} 
	
	override method dificultadPara(unEmpleado) = complejidad * 2
}

class DefenderUnSector inherits Tarea{
	
	const property gradoAmenaza
	
	override method puedeRealizarLaTarea(unEmpleado) = 
		not unEmpleado.esMucama() and unEmpleado.fuerza() >= gradoAmenaza
		
	override method laRealiza(unEmpleado){
		self.puedeRealizarLaTarea(unEmpleado)
		unEmpleado.defenderUnSector(self)
	}
	
	override method dificultadPara(unEmpleado) = unEmpleado.dificultadDeSector(self)
}

class LimpiarUnSector inherits Tarea{
		
	const tamanio
		
	override method dificultadPara(_unEmpelado) = cientifico.dificultadParaLimpiar()
	
	override method puedeRealizarLaTarea(unEmpleado) = unEmpleado.estamina() > tamanio.estaminaRequerida()
	
	override method laRealiza(unEmpleado){
		self.puedeRealizarLaTarea(unEmpleado)
		unEmpleado.limpiaUnSector(self)
	}
	
	method estaminaRequerida() = tamanio.estaminaRequerida()
	
}

class Tamanio{
	method estaminaRequerida() = 1
}
object grande inherits Tamanio{
	override method estaminaRequerida() = 4
}
