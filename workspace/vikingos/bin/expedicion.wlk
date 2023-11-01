import vikingo.*
import objetivo.*

class Expedicion{
	const property tripulacion
	const objetivos
	
	method subirVikingo(vikingo){
		if (not vikingo.sePuedeSubir())
			self.error("No cumple las condiciones para subirse")
		tripulacion.add(vikingo)
	}
	
	method valeLaPena(){
		objetivos.all{objetivo => objetivo.valeLaPenaPara(self)}
	}
	
	method realizarExpedicion(){
		objetivos.forEach{objetivo => objetivo.serInvadidoPor(self)}
	}
	method repartirBotin(botin){
		tripulacion.forEach{vikingo => 
			vikingo.ganar(botin / self.tripulacion())
		}
	}
	
	method aumentarVidasCobradasEn(cantidad) { 
		tripulacion.take(cantidad).forEach{int => 
			int.cobrarVida()
		}
	}
}