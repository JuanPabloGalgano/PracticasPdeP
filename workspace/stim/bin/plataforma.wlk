import juego.*

class Plataforma{
	
	const juegos
	
	method juegoMasCaro(){
		return juegos.max{juego => juego.precioEnDolares()}
	} 
	
	method aplicarDescuentos(unPorcentaje){
		const juegosADescontar = juegos.filter{juego => juego.esMasCaroQue(0.75 * self.juegoMasCaro().precioEnDolares())}
		juegosADescontar.forEach{juego => juego.aplicarDescuentoDirecto(unPorcentaje)}	
	}
	
	method promedioPrecioJuegosAptosEn(unPais){
		const valoresJuegosAptosEn = unPais.valoresJuegosAptosAca(juegos)
		return valoresJuegosAptosEn.sum() / valoresJuegosAptosEn.size() 
	}
	
	method tieneUnJuegoGalardonado() = juegos.any{juego => juego.esGalardonado()}
}