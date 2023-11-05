class Persona{
	
	var property elementosCerca
	var criterioPedido
	var criterioComida
	var comio
	
	method pedir(unaPersona, unaCosa){
		unaPersona.puedePasar(unaCosa)
		const cosaQuePasa = criterioPedido.quePasa(self, unaCosa, unaPersona)
		unaPersona.pasaA(self,cosaQuePasa)
	}
	
	method puedePasar(unaCosa){
		elementosCerca.contains(unaCosa)
	}
	
	method pasaA(pedidor, unaCosa) {
		pedidor.agregarAElementos(unaCosa)
		self.alejarElementos(unaCosa)
		}
		
	method agregarAElementos(unaCosa){ elementosCerca.add(unaCosa)}
	method alejarElementos(cosas){elementosCerca.remove(cosas)}
	
	method cambiaPosicionCon(pedidor){
		self.pasaA(pedidor, self.elementosCerca())
		pedidor.pasaA(self, pedidor.elementosCerca())
	}
	
	method cambiarCriterioPedido(nuevoCriterio){ criterioPedido = nuevoCriterio}
	method cambiarCriterioComida(nuevoCriterio){ criterioComida = nuevoCriterio}
	
	method elegirComida(comida){
		criterioComida.puedeComer(comida)
		comio.add(comida)
	}
	
}