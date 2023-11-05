object poniente{
	const casas = []
	
	method casaMasPobre(){
		return casas.min{casa => casa.patrimonio()}
	}
}