class EnfermedadAutoinmune {
	var property celulasQueAmenaza
	
	method efecto(unaPersona){
			unaPersona.destruirCelulas(celulasQueAmenaza)
	}
	
	method esAgresiva(unaPersona){
		return "Afecto a la persona por mas de un mes"
	}

}