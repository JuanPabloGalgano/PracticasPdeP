class Obstaculo{
	
	const ancho
	const tipo
	
	method resistencia() = tipo.multiplicador() * ancho 
}

object vidrio{
	const property multiplicador = 10
}

object madera{
	const property multiplicador = 25
}

object piedra{
	const property multiplicador = 50
}




