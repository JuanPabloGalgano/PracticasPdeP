class Arma{
	method usarCon(unaPersona) {
		unaPersona.morir()
	}
	
	method esSutil() = false
}

class Revolver inherits Arma{
	var cantidadBalas
	
	override method usarCon(unaPersona){
		super(unaPersona)
		cantidadBalas -= 1
	}
	
	method recargar(){
		cantidadBalas = 6
	}
	
	override method esSutil() = cantidadBalas == 1
}

class Escopeta inherits Arma{
	
	override method usarCon(unaPersona){
		unaPersona.meDispararon()
	}
}

class CuerdaDePiano inherits Arma{
	
	const calidad 
	
	override method usarCon(unaPersona){
		calidad.mata()
		super(unaPersona)
	}
	
	override method esSutil() = true
}

object buenaCalidad{ method mata() = true }

object malaCalidad{ method mata() = false }