class Persona{
	var cantidadDeCelulas
	var temperatura
	var enfermedades = []
	
	method aumentaTemperatura(cantidad){
			temperatura += cantidad
	}
	
	method destruirCelulas(cantidad){
		cantidadDeCelulas -= cantidad
	}
	
	method cantidadDeCelulas(){
		return cantidadDeCelulas
	}
	
	method enfermedades(){
		return enfermedades
	}
	
	method contraerEnfermedad(unaEnfermedad){
		enfermedades.add(unaEnfermedad)
	}
	
	method estaEnComa(){
		return temperatura > 45 || cantidadDeCelulas < 1000000
	}
}