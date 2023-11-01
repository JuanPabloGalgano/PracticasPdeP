class Inmueble{
	const property tamanio
	const property ambientes
	const property zona
	
	method valor() = self.valorParticular() * zona.aumento()
	method valorParticular()
	
	method puedeSerVendida(){}
}

class Casa inherits Inmueble{
	const property valorParticular
	
	override method valorParticular() = valorParticular
		
}

class PH inherits Inmueble{
	
	override method valorParticular() = 500000.max(tamanio * 14000)
}

class Departamento inherits Inmueble{
	
	override method valorParticular() = 350000 * ambientes
}
