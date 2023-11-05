import criterioPedido.*
import criterioComida.*
import comida.*
import posicion.*

class Comensal{
	
	var property posicion = null
	//var property elementosCerca = []
	var criterioPedido = null
	var criterioComida = null
	var property comio = []
	
	method pedir(unaPersona, unaCosa){
		unaPersona.puedePasar(unaCosa)
		const cosaQuePasa = criterioPedido.quePasa(self, unaCosa, unaPersona)
		unaPersona.pasaA(self,cosaQuePasa)
	}
	
	method elementosQueTieneCerca() = posicion.elementosCerca()
	
	method puedePasar(unaCosa){
		posicion.tieneCerca(unaCosa)
	}
	
	method pasaA(pedidor, unaCosa) {
		pedidor.agregarElemento(unaCosa)
		self.alejarElemento(unaCosa)
	}
		
	method agregarElemento(unaCosa){ posicion.acercarElemento(unaCosa)}
	method alejarElemento(unaCosa){ posicion.alejarElemento(unaCosa)}
	
	method cambiaPosicionCon(pedidor){
		self.cambiarPosicionA(pedidor.posicion())
		pedidor.cambiarPosicionA(self.posicion())
	}
	
	method cambiarPosicionA(unaPosicion){ posicion = unaPosicion}
	
	method cambiarCriterioPedido(nuevoCriterio){ criterioPedido = nuevoCriterio}
	method cambiarCriterioComida(nuevoCriterio){ criterioComida = nuevoCriterio}
	
	method elegirComida(comida){
		criterioComida.puedeComer(comida)
		comio.add(comida)
	}
	
	method estaPipon() = comio.any{comida => comida.esPesada()}
	
	method laEstaPasandoBien()
	
}

object osky inherits Comensal{
	
	override method laEstaPasandoBien() = true
}

object moni inherits Comensal{
	
	override method laEstaPasandoBien() = self.posicion() == 1
}

object facu inherits Comensal{
	
	override method laEstaPasandoBien() = comio.any{comida => comida.esCarne()}
}

object vero inherits Comensal{
	
	override method laEstaPasandoBien() = posicion.cantidadDeElementosCerca() < 3
} 