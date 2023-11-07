import plato.*

class Cocinero{
	
	var posicion
	
	method catar(unPlato) = posicion.catar(unPlato)
	
	method cambiarPosicion(unaPosicion){
		posicion = unaPosicion
	}
	
	method crearPlato()
	
}

class Pastelero{
	
	const nivelDeseado
	
	method catar(unPlato) = 5 * unPlato.cantidadAzucar() / nivelDeseado
	
	method crearPlato() = new Postre(cantidadDeColores = nivelDeseado / 50, azucares = 120)
	
}

class Chef{
	
	var cantidadCalorias
	
	method catar(unPlato){
		if(not unPlato.esBonito() and unPlato.calorias() == cantidadCalorias){
			return 10
		}
		return 0
	}
	
	method crearPlato() = new Principal(esBonito = true, azucares = cantidadCalorias)
	
}
	
class Souschef inherits Chef{
	
	override method catar(unPlato){
			if(unPlato.esBonito() and unPlato.calorias() == cantidadCalorias){
			return 10
		}
		return unPlato.calorias() / 100
	
	}
	
	override method crearPlato() = new Entrada(azucares = 0)
	
}