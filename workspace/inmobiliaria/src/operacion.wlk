import empleado.*
import inmueble.*

class Operacion{
	
	const property inmueble
	const property zona
	const property empleadoACargo
		
	method comision()
}

class Alquiler inherits Operacion{
	
	const cantidadDeMeses

	
	override method comision(){
		return (cantidadDeMeses * inmueble.valor()) / 50000
	}
	
}

class Compra inherits Operacion{
	
	const porcentajeComision
	
	override method comision(){
		return inmueble.valor() * porcentajeComision
	}
}