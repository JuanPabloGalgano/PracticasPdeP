import nave.*

class Sabotaje{
	
	
	method esRealizado(unImpostor) { unImpostor.aumentarSospecha(5)}
}

object reducirOxigeno inherits Sabotaje{
	
	override method esRealizado(unImpostor){
		not nave.alguienTieneUnTubo()
		nave.reducirOxigeno(10)
		nave.oxigenoCritico()
	}
}

object impugnarUnJugador inherits Sabotaje{
	
	override method esRealizado(unImpostor){
		//how?
	}
}