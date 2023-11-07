

class Nacional{
	
	method impuesto(unProducto) = unProducto.montoPorDerecho() * 5 / 100
}

object extranjera inherits Nacional{
	
	
	override method impuesto(unProducto) = super(unProducto) + impuestoDePrestacion.impuesto()
}

object impuestoDePrestacion{
	
	const impuesto = 0
	
	method impuesto() = impuesto
}