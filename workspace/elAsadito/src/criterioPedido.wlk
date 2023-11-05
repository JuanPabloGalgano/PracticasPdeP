class CriterioPedido{
	method quePasa(unaPersona, unaCosa, pedidor)
}

class Sordos inherits CriterioPedido{
	
	override method quePasa(unaPersona, _unaCosa, _pedidor) = unaPersona.elementosQueTieneCerca().first()
}

class Histerico inherits CriterioPedido{
	
	override method quePasa(unaPersona, _unaCosa, _pedidor) = unaPersona.elementosQueTieneCerca()
}

class Nomada inherits CriterioPedido{
	
	override method quePasa(unaPersona, _unaCosa, pedidor) = unaPersona.cambiaPosicionCon(pedidor)
}

class Inteligente inherits CriterioPedido{
	
	override method quePasa(unaPersona, unaCosa, _pedidor) = unaCosa
}