class Plan{
	
	method impuesto()
	method registrarMonto(montoAPagar)
	method puedeDescargar(unProducto, unaPersona) = true
	method leAlcanza(unMonto) = true
}

class Prepago inherits Plan{
	
	var saldo 
	
	override method impuesto() = 1.1
	
	override method puedeDescargar(unProducto, unaPersona) = unaPersona.tienePlanSuficiente(unProducto)
	
	override method leAlcanza(unMonto) = unMonto <= saldo 
	
	override method registrarMonto(unMonto) {
		saldo -= unMonto
	} 
}

class Facturado inherits Plan{
	
	var factura
	
	override method impuesto() = 1
	
	override method registrarMonto(unMonto) { factura += unMonto}
}