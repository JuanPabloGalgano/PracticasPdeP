class Critica{
	var property critica
	
	method esCriticaPositiva(unJuego)
	
	method tieneMasDeCaracteres(unaCantidad) = critica.size() > unaCantidad
}

class CriticaUsuario inherits Critica{
	
	override method esCriticaPositiva(unJuego) = critica == "si"
}

class CriticoPago inherits Critica{
	
	var property juegosQueLePagaron
		
	override method esCriticaPositiva(unJuego) = juegosQueLePagaron.contains(unJuego)
	
	method lePagaUnJuego(unJuego) {
		juegosQueLePagaron.add(unJuego)
	}
	
	method leDejaDePagarUnJuego(unJuego){
		juegosQueLePagaron.remove(unJuego)
	}
}

class Revista inherits Critica{
	const criticos
	
	override method esCriticaPositiva(unJuego) = self.criticaronPositivamente(unJuego) > (self.cantidadDeCriticos() / 2)
	
	method cantidadDeCriticos() = criticos.size()
	
	method criticaronPositivamente(unJuego){
		return criticos.filter{critico => critico.esCriticaPositiva(unJuego)}
	}	
	
	method incorporarCritico(unCritico){ criticos.add(unCritico) }
	
	method perderCritico(unCritico){ criticos.remove(unCritico) }
	
	method textoDeLaCritica(unJuego){
		critica =  criticos.map{critico => critico.critica()}
	}
	
}