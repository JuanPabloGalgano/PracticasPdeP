class Descuento{
	method aplicarDescuento(unPrecio)
}

class Directo inherits Descuento{
	
	const porcentaje
	
	override method aplicarDescuento(unPrecio){
		return unPrecio * porcentaje / 100		
	}
}

class Fijo inherits Descuento{
	const monto
	
	override method aplicarDescuento(unPrecio){
		const mitadDelPrecio = unPrecio/2
		return mitadDelPrecio.max(unPrecio - monto)
	}
}

object gratis inherits Descuento{
	
	override method aplicarDescuento(_unPrecio){ return 0}
}

object descuentoNulo inherits Descuento{
	override method aplicarDescuento(_unPrecio){}
}