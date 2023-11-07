class Riley{
	var felicidad = 1000
	var emocionDominante
	var recuerdosDelDia
	
	method vivirUnEvento(unEvento){
		unEvento.serVividoPor(self)
	}
	
	method agregarRecuerdo(unRecuerdo){
		recuerdosDelDia.add(unRecuerdo)
	}
	
	method asentarRecuerdo(unRecuerdo){
		unRecuerdo.Asentarse(self)
	}
}