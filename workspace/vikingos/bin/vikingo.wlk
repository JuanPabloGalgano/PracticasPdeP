import expedicion.*
import casta.*

class Vikingo{
	var property casta
	var property armas
	var property oro
	
	method sePuedeSubir() = self.esProductivo() and casta.puedeIr(self)
	
	method esProductivo()
	method tieneArmas() = armas > 0
	
	method convertirseEnThrall(){
		casta = thrall
	}
	
	method convertirseEnKarl(){
		casta = karl
	}
	
	method premioPorAscenso(){}
	
	method sumarArmas(unaCantidad){
		armas += unaCantidad
	}
	
	method ganar(unaCantidad){
		oro += unaCantidad
	}

}

class Soldado inherits Vikingo{
	var property vidasCobradas
	
	override method esProductivo() = vidasCobradas > 20 and self.tieneArmas()
	
	override method premioPorAscenso(){
		self.sumarArmas(10)
	}
	
}

class Granjero inherits Vikingo{
	var property cantidadHijos
	var property hectareas
	
	override method esProductivo() = self.hectareasPorHijo() > 2
	
	method hectareasPorHijo() = hectareas / cantidadHijos
	
	override method premioPorAscenso(){
		self.sumarHijos(2)
		self.sumarHectareas(2)
	}
		
	method sumarHijos(unaCantidad){
		cantidadHijos += unaCantidad
	}
	
	method sumarHectareas(unaCantidad){
		hectareas += unaCantidad
	}
	
	
}


