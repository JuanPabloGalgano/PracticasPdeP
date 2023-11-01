import juego.*

class Pais{
	const legislacionVigente 
	const convercionAMonedaLocal
	
	method esAptoAca(unJuego) = not unJuego.contieneAlguna(legislacionVigente)
	
	method juegosAptosAca(juegos){
		return juegos.filter{juego => juego.esAptoParaMenoresEn(self)}
	}
	
	method valoresJuegosAptosAca(juegos){
		return self.juegosAptosAca(juegos).map{juego => self.convertirAMonedaLocalJuego(juego)}
	}
	
	method convertirAMonedaLocalJuego(unJuego){
		return unJuego.precioEnDolares() * convercionAMonedaLocal
	}
		
}