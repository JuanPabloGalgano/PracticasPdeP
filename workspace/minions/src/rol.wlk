class Rol{
	
	method fuerza()
	
	method esMucama() = false
	
	method defenderUnSector(unEmpleado){
		unEmpleado.perderEstamina(unEmpleado.estamina() / 2)	
	}
	
	method tieneHerramientasNecesarias(unasHerramientas) = false
	
	method limpioUnSector(unEmpleado, unSector) { unEmpleado.perderEstamina(unSector.estaminaRequerida()) } 
}

class Soldado inherits Rol{
	
	var danioArma
	var vecesQDefendio
	
	override method fuerza() = danioArma + 2 * vecesQDefendio 
	
	method practicar() { vecesQDefendio += 1}
	
	override method defenderUnSector(unEmpleado){}

}

class Mucama inherits Rol{
	
	override method esMucama() = true
	
	override method limpioUnSector(unEmpleado, unSector) { unEmpleado.perderEstamina(unSector.estaminaRequerida()) } 
	
}

class Obrero inherits Rol{
	
	var herramientas
	
	override method tieneHerramientasNecesarias(unasHerramientas) = herramientas.contains(unasHerramientas)
	
}

class Capataz inherits Rol{
	
	var property empleadosACargo
	
	method delegarA(unaTarea) // me cagaron aca, nose que hacer
}