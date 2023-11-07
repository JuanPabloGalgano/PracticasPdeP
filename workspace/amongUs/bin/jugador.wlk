import nave.*

class Jugador{
	
	var property nivelDeSospecha = 40
	var mochila = []
	var tareasPendientes = nave.tareasPendientes()
	var personalidad
	
	method esSopechoso() = nivelDeSospecha > 50
	
	method buscarUnItem(unItem){ mochila.add(unItem)}
	
	method completoSusTareas() = tareasPendientes.all{tarea => nave.laTareaEstaCompletada(tarea)}
	
	method realizarTarea(){
		self.realizar(self.tareasQuePuedeRealizar().anyOne())		
	}
	
	method realizar(unaTarea){
		unaTarea.laRealiza(self)
		tareasPendientes.remove(unaTarea)
		self.informarANave(unaTarea)
	}
	

	method informarANave(unaTarea){
		nave.seRealizo(unaTarea)
	}
	
	method tareasQuePuedeRealizar() = tareasPendientes.filter{tarea => tarea.laPuedeHacer(self)}
	
	method aumentarSospecha(unaCantidad) { nivelDeSospecha += unaCantidad}
	method disminuirSospecha(unaCantidad) { nivelDeSospecha -= unaCantidad}
	
	method tiene(unItem) = mochila.contains(unItem)
	
	method llamarAUnaReunion() = nave.realizarVotacion()
	
	method votar() = personalidad.votar()
	
	method noTieneItems() = mochila.isEmpty()
}

class Impostor inherits Jugador{
	
	override method completoSusTareas() = true
	
	override method realizarTarea(){
	
	}
	
	method sabotear(unSabotaje){ unSabotaje.esRealizado(self)}
	
	override method votar() = nave.jugadores().anyOne()
}