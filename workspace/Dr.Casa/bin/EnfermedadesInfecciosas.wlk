class EnfermedadInfecciosa {
	var property celulasQueAmenaza
	var property seReprodujo = false
	
	method efecto(unaPersona){
		if (seReprodujo){
			unaPersona.aumentaTemperatura((celulasQueAmenaza * 2) * 0,001)
		}else{
			unaPersona.aumentaTemperatura(celulasQueAmenaza * 0,001)
		}
	}
	method reproducirse(){
		seReprodujo = true
	}
	
	method esAgresiva(unaPersona){
		return celulasQueAmenaza > unaPersona.cantidadDeCelulas() * 0.1
	}
	
	method seReprodujo(){
		return seReprodujo
	}
}