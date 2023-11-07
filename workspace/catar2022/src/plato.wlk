class Plato{
	var azucares
	
	method calorias() = 3 * azucares + 100
	method serCatadoPor(unCatador) = unCatador.catar(self)
	method cantidadAzucar() = azucares
	method esBonito()
}

class Entrada inherits Plato{
	
	override method esBonito() = true
}

class Principal inherits Plato{
	
	var esBonito
	
	override method esBonito() = esBonito
	
}

class Postre inherits Plato{
	
	var cantidadDeColores
	
	override method esBonito() = cantidadDeColores > 3

}