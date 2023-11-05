class CriterioPedido{
	
	method puedeComer(comida)
}

class Vegetariano inherits CriterioPedido{
	
	override method puedeComer(unaComida) = not unaComida.esCarne()
}

class Histerico inherits CriterioPedido{
	
	override method quePasa(unaPersona, _unaCosa, _pedidor) = unaPersona.elementosCerca()
}

class Nomada inherits CriterioPedido{
	
	override method quePasa(unaPersona, _unaCosa, pedidor) = unaPersona.cambiaPosicionCon(pedidor)
}

class Inteligente inherits CriterioPedido{
	
	override method quePasa(unaPersona, unaCosa, _pedidor) = unaCosa
}