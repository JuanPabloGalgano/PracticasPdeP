class Fiesta{
	
	const invitados = []
	
	method esUnBodrio() = invitados.all{invitado => invitado.estaDesconforme()}
	
	method mejorDisfraz() = invitados.max{invitado => invitado.puntajeDisfraz()}
	
	method puedenIntercambiar(persona1, persona2) = 
		self.ambosEstanEnLaFiesta(persona1, persona2) and
		self.algunoEstaDisconforme(persona1, persona2) and
		self.ambosSatisfechosSiCambian(persona1, persona2)
		
	method ambosEstanEnLaFiesta(persona1, persona2) = self.estaEnLaFiesta(persona1) and self.estaEnLaFiesta(persona2)
	
	method estaEnLaFiesta(unaPersona) = invitados.contains(unaPersona) 
	
	method algunoEstaDisconforme(unaPersona, otraPersona) = unaPersona.estaDesconforme() or otraPersona.estaDesconforme()
	
	method ambosSatisfechosSiCambian(unaPersona, otraPersona) = 
	unaPersona.satisfechoSiCambiaCon(otraPersona) and otraPersona.satisfechoSiCambiaCon(unaPersona)
	
	method agregarAsistente(asistente){
		self.puedeEntrar(asistente)
		invitados.add(asistente)
	}
	
	method puedeEntrar(asistente) = asistente.tieneDisfraz() and not invitados.contains(asistente)
	
}

object fiestaInolvidable inherits Fiesta{
	
	override method puedeEntrar(asistente) = asistente.esSexy() and not asistente.estaDesconforme()
}

