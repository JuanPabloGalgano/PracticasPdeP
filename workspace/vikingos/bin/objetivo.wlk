import expedicion.*
import vikingo.*
import casta.*

class Objetivo{
	const property botin
	
	method valeLaPenaPara(unaExpedicion)
	method botinConseguido(unaExpedicion)
	
	method serInvadidoPor(unaExpedicion){
		unaExpedicion.repartirBotin(self.botinConseguido(unaExpedicion.cantidadIntegrantes()))
		self.destruirse(unaExpedicion.cantidadIntegrantes())
	}
	method destruirse(unaExpedicion)
}

class Aldea inherits Objetivo{
	
	var property cantidadDeCrucifijos 
	
	override method valeLaPenaPara(unaExpedicion) = self.botinConseguido(unaExpedicion) >= 15
	
	override method botinConseguido(unaExpedicion) = cantidadDeCrucifijos
	
	override method destruirse(cantInvasores){
		cantidadDeCrucifijos = 0
	}
}

class AldeaAmurallada inherits Aldea{
	const cantidadMinima
	
	override method valeLaPenaPara(unaExpedicion) = unaExpedicion.tripulacion() >= cantidadMinima and super(unaExpedicion)
}

class Capital inherits Objetivo{
	
	const property factorRiqueza
	var property defensores  
		
	override method valeLaPenaPara(unaExpedicion) = self.botinConseguido(unaExpedicion) > 3
	
	override method botinConseguido(unaExpedicion){
		return self.defensoresDerrotados(unaExpedicion) * factorRiqueza
	}
	
	method defensoresDerrotados(unaExpedicion) = defensores.min(unaExpedicion.tripulacion())
	
	override method destruirse(unaExpedicion){
		defensores -= self.defensoresDerrotados(unaExpedicion.tripulacion())
	}
	override method serInvadidoPor(unaExpedicion){
		unaExpedicion.aumentarVidasCobradasEn(self.defensoresDerrotados(unaExpedicion.tripulacion()))
		super(unaExpedicion)
	}
}


