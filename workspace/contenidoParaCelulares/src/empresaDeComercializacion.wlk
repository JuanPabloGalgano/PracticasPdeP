import descarga.*

object empresaDeComercializacion{
	
	const descargas = [] 
	
	method montoASumar(unProducto) = unProducto.montoPorDerecho() * 25 / 100
	
	method registrarDescarga(unProducto, unCliente){
		unCliente.puedeDescargar(unProducto)
		self.registrar(unProducto)
	}
	
	method registrar(unProducto){
		descargas.add(new Descarga(producto = unProducto, fecha = new Date()))
	}
	
	method productoTop(unaFecha) = 
		self.productosEnUnaFecha(unaFecha).max{producto => self.productosEnUnaFecha(unaFecha).ocurrencesOf(producto)}
	
	method productosEnUnaFecha(unaFecha) = descargas.filter{descarga => descarga.fecha() == unaFecha} 
}