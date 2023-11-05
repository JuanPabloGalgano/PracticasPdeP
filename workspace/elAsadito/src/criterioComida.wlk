import oms.*

class CriterioComida{
	method puedeComer(comida)
}

class Vegetariano inherits CriterioComida{
	
	override method puedeComer(comida) = not comida.esCarne()
}

class Dietetico inherits CriterioComida{
	
	override method puedeComer(comida) = comida.calorias() < oms.caloriasRecomendadas() 
}

class Alternado inherits CriterioComida{
	
	var estado
	
	override method puedeComer(comida) {
		if(estado.yaComio()){
			estado = noComido
			return false
			}
		estado = comido
		return true		
		}
}

object noComido{
	
	method yaComio() = false
}

object comido{
	
	method yaComio() = true
}


class Pesado inherits CriterioComida{
	
	const condiciones
	
	override method puedeComer(comida) = condiciones.all{condicion => condicion.puedeComer(comida)} 
}

