class Formacion {
	const property vagones = []
	const property locomotoras = []

	// Punto 1
	method agregarVagon(unVagon) {
		vagones.add(unVagon)
	}	

	// Punto 2
	method agregarLocomotora(unaLocomotora) {
		locomotoras.add(unaLocomotora)
	}
	
	// Punto 3
	method cantidadVagones() {
		return vagones.size()
	}
	
	// Punto 4
	method totalPasajeros() {
		return vagones.sum { vagon => vagon.cantidadPasajeros() }
	}
	
	// Punto 5
	method cantidadVagonesLivianos() {
		return vagones.count { vagon => vagon.esLiviano() }
	}
	
	// Punto 6
	method velocidadMaxima() {
		return locomotoras.map { locomotora => locomotora.velocidadMaxima() }.min()
	}
	
	// Punto 7
	method esEficiente() {
		return locomotoras.all { locomotora => locomotora.esEficiente() }
	}
	
	// Punto 8
	method puedeMoverse(){
		return locomotoras.arrastreUtilTotal() >= vagones.pesoMaximoVagones() 
	}
	
	method arrastreUtilTotal(){
		return locomotoras.sum { locomotora => locomotora.arrstreUtil() }
	}
	
	method pesoMaximoVagones(){
		return vagones. sum {vagon => vagon.pesoMaximo()}
	}
	
	//Punto 9
	method kilosDeEmpujeFaltantes(){
		return 	0.mas(vagones.pesoMaximoVagones() - locomotoras.arrastreUtilTotal()) //El maximo entre 0 y ese nro para que no de engativo
	}
	
	//Punto 10
	method vagonMasPesado(){
		return vagones.max {vagon => vagon.pesoMaximo()}
	}
	
	//Punto 11
	method esCompleja(){
		return self.tieneMuchasUnidades() || self.pesaMucho() 
	}
	
	method tieneMuchasUnidades(){
		return self.cantidadDeUnidades() > 20
	}
	
	method pesaMucho(){
		return self.pesoTotalMaximo() > 10000
	}
	
	method cantidadDeUnidades(){
		return locomotoras.size() + vagones.size()
	}
	
	method pesoTotalMaximo(){
		return self.pesoMaximoVagones() + self.pesoMaximoLocomotoras()
	}
	
	method pesoMaximoLocomotoras() {
		return locomotoras. sum {locomotora => locomotora.pesoMaximo()}
	}
}