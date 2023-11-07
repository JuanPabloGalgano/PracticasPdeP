class Guerrero{
	
	var property potencial
	var experiencia
	var energia
	var traje
	
	method atacar(otroGuerrero){
		otroGuerrero.esAtacadoPor(self)
	}
	
	method disminuirEnergia(unaCantidad) { energia -= unaCantidad}
	method aumentarExperiencia(unaCantidad) { experiencia += unaCantidad}
	
	method esAtacadoPor(atacante) { traje.esAtacadoPor(atacante, self)}
	
	method disminuirDanioRecibido()
	
}