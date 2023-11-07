object nave{
	
	var property tripulantes = []
	var impostores = []
	var property jugadores = []
	var property tareasPendientes = []
	var oxigeno
	
	method laTareaEstaCompletada(unaTarea) = not tareasPendientes.contains(unaTarea)
	
	method seRealizo(unaTarea){ 
		tareasPendientes.remove(unaTarea)
		if(tareasPendientes.isEmpty())
			self.error("Ganaron los tripulantes")
	}
	
	method aumentarOxigeno(unaCantidad) {oxigeno += unaCantidad}
	method reducirOxigeno(unaCantidad) {oxigeno -= unaCantidad}
	
	method oxigenoCritico(){
		if(oxigeno <= 0)
		self.error("Ganaros los impostores")
	}
	
	method alguienTieneUnTubo() = tripulantes.any{tripulante => tripulante.tiene("tuboDeOxigeno")}
	
	method jugadoresNoSospechosos() = jugadores.filter{jugador => not jugador.esSospechoso()}
	
	method jugadorConMayorSospecha() = jugadores.max{jugador => jugador.nivelDeSospecha()}
	
	method jugadoresSinMateriales() = jugadores.filter{jugador => jugador.noTieneItems()}
	
	method realizarVotacion() = jugadores.map{jugador => jugador.votar()}
}