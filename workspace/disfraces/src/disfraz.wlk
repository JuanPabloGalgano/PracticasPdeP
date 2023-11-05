class Disfraz{
	
	const caracteristicas
	const nombre
	const diaDeSuCreacion
	
	method puntajeDisfraz(unaPersona) = caracteristicas.sum{caracteristica => caracteristica.puntajePara(unaPersona)}
	
	method nombreLargo() = nombre.size() > 10
	
	method esModerno() = new Date().day() - diaDeSuCreacion < 30
	
	method nombreExactamendeDe(unaCantidad) = nombre.size() == unaCantidad
}



