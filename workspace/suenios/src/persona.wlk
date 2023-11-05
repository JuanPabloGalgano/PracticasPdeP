class Persona{
	
	const suenios
	var hijos
	var lugaresVisitados
	var carrerasEstudiadas
	var carrerasQueQuiereEstudiar	
	
	method cumplirUnSuenio(suenio){
		if(!self.sueniosPendientes().contains(suenio)){
			self.error("ya esta cumplido")
		}
		suenio.cumplir(self)
	}
	
	method sueniosPendientes() = suenios.filter{suenio => suenio.estaPendiente()}
	
	method tieneUnHijo() = not hijos.isEmpty()
	
	method adoptar(hijosAAdoptar) {hijos += hijosAAdoptar}
	
	method viajarA(unLugar) {lugaresVisitados.add(unLugar)}
	
	method estudio(unaCarrera) = carrerasEstudiadas.contains(unaCarrera)
	
	method quiereEstudiar(unaCarrera) = carrerasQueQuiereEstudiar.contains(unaCarrera)
	
	method recibirseDe(unaCarrera) {carrerasEstudiadas.add(unaCarrera)} 
}