class Aliado{
	method esPeligroso()
}

class Personaje inherits Aliado{
	
	var conyuges
	const property casa
	var estaVivo
	var property acompaniante
	
	method tienePareja() = not conyuges.isEmpty()
	
	method sePuedenCasar(otroPersonaje) = 
	self.mePuedoCasarCon(otroPersonaje) and self.mePuedoCasarCon(self)
	
	method intentaCasarteCon(otroPersonaje){
		if (self.mePuedoCasarCon(otroPersonaje)){
			self.casarseCon(otroPersonaje)
			otroPersonaje.casarseCon(self)
		}else{
			self.error("este matrimonio no se puede hacer")
		}
		
	}
	
	method mePuedoCasarCon(otroPersonaje) = self.casa().sePuedeCasan(self,otroPersonaje)
	
	method casarseCon(otroPersonaje){
		conyuges.add(otroPersonaje)
	}
	
	method patrimonio(){
		casa.patrimonioPorMiembro()
	}
	
	method estaSolo() = acompaniante.isEmpty()
	
	method aliados(){
		return conyuges + acompaniante + casa.miembros() 
	}
	
	override method esPeligroso() = estaVivo and
	(self.patrimonioAliados() > 10000 or self.conyugesRicos() or self.tieneAlianzaPeligrosa())
	
	method patrimonioAliados(){
		const patrimonioPorAliado = self.aliados().map{aliado => aliado.patrimonio()}
		return patrimonioPorAliado.sum()
	}
	
	method conyugesRicos() = conyuges.all{conyuge => conyuge.esDeCasaRica()}
	
	method esDeCasaRica() = casa.esRica()
	
	method tieneAlianzaPeligrosa() = self.aliados().any{aliado => aliado.esPeligroso()}
	
	method esAlidadoDe(otroPersonaje) = otroPersonaje.aliados().contains(self)
	
	method morir(){estaVivo = false}
	
	method derrocharFortuna(unPorcentaje){casa.perderFortuna(unPorcentaje)}
}