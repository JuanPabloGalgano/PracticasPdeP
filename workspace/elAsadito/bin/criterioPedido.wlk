class CriterioComida{
	method quePasa(unaPersona, unaCosa, pedidor)
}

class Sordos inherits CriterioComida{
	
	override method quePasa(unaPersona, _unaCosa, _pedidor) = unaPersona.elementosCerca().first()
}

class Histerico inherits CriterioComida{
	
	override method quePasa(unaPersona, _unaCosa, _pedidor) = unaPersona.elementosCerca()
}

class Nomada inherits CriterioComida{
	
	override method quePasa(unaPersona, _unaCosa, pedidor) = unaPersona.cambiaPosicionCon(pedidor)
}

class Inteligente inherits CriterioComida{
	
	override method quePasa(unaPersona, unaCosa, _pedidor) = unaCosa
}