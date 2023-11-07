import nave.*

class Tarea{
	
	method laPuedeHacer(unJugador)
	method laRealiza(unJugador)
}

object arreglarTablero inherits Tarea{
	
	override method laPuedeHacer(unJugador) = unJugador.tiene("llaveInglesa")
	
	override method laRealiza(unJugador)  {unJugador.aumentarSospecha(10)}
}

object sacarLaBasura inherits Tarea{
	
	override method laPuedeHacer(unJugador) = unJugador.tiene("escoba") and unJugador.tiene("bolsaDeConsorcio")
	
	override method laRealiza(unJugador)  {unJugador.disminuirSospecha(4)}
}

object ventilarLaNave inherits Tarea{
	
	override method laPuedeHacer(unJugador) = true
	
	override method laRealiza(_unJugador) {nave.aumentarOxigeno(4)}
}


