import descuentos.*

class Juego{
	
	const precio
	var descuento
	const caracteristicas
	var criticas
	
	method precioEnDolares(){
		descuento.aplicarDescuento(precio)
	}
	
	method aplicarDescuentoDirecto(unMontoFijo){
		const descuentoDirecto = new Directo(porcentaje = unMontoFijo)
		self.aplicarDescuento(descuentoDirecto)
	}
	
	method aplicarDescuento(unDescuento){
		descuento = unDescuento
	}
	
	method esAptoParaMenoresEn(unPais){
		unPais.esAptoAca(self)
	}
	
	method contieneAlguna(caracteristicasProhibidas){
		return caracteristicas.any{caracteristica => caracteristicasProhibidas.contains(caracteristica)}
	}

	method pasaElUmbralDe(unaCantidad) = self.cantidadDeCriticasPositivas() > unaCantidad
	
	method cantidadDeCriticasPositivas() = criticas.filter{critica => critica.esCriticaPositiva()}
	
	method esGalardonado() = criticas.all{critica => critica.esCriticaPositiva()}
	
	method tieneCriticosLiterarios() = criticas.any{critica => critica.tieneMasDeCaracteres(100)}
}