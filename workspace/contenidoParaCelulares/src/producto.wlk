class Producto{
	
	method montoPorDerecho() 
}

class Ringtone inherits Producto{
	
	var duracion
	var autor
	
	override method montoPorDerecho() = duracion * autor.precioPorMinuto()
}

class Autor{
	const property precioPorMinuto
}

class Chiste inherits Producto{
	
	var caracteres
	const montoFijo = 1
	
	override method montoPorDerecho() = caracteres * montoFijo 
}

class Juego inherits Producto{
	
	var monto
	
	override method montoPorDerecho() = monto
}
