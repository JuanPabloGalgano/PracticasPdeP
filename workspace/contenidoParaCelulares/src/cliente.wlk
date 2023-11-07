import empresaDeComercializacion.*
import descarga.*

class Cliente{
	
	var compania
	var plan
	var productosDescargados
	
	method precioDescarga(unProducto) = 
	(unProducto.montoPorDerecho() + 
	compania.impuesto(unProducto) + 
	empresaDeComercializacion.montoASumar(unProducto)) * plan.adicional()
	
	method puedeDescargar(unProducto) = plan.puedeDescargar(unProducto,self)
	
	method registrarDescargaDe(unProducto){
		self.aniadirADescargas(unProducto)
	}
	
	method tienePlanSuficiente(unProducto) = plan.leAlcanza(self.precioDescarga(unProducto))
	
	method aniadirADescargas(unProducto) { productosDescargados.add(unProducto)}
	
	method totalGastadoEnElMes() = productosDescargados.sum{descarga => self.precioDescarga(descarga)}
	
	method esColgado() = self.productosDescargados().size() < self.productosDescargados().asSet().size()
	
	method productosDescargados() = productosDescargados
	
	
}
