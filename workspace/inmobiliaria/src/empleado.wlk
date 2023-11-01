import operacion.* 
import inmueble.*

class Empleado{
	
	const operacionesCerradas = #{}
	
	method totalComisiones() = operacionesCerradas.sum({operacion => operacion.comision()})
	
	method cantidadOperacionesCerradas() = operacionesCerradas.size()
	
	method vaATenerProblemasCon(unEmpleado) =
		self.cerroOperacionesEnElMismoLugarQue(unEmpleado) and 
		(self.concretoOperacionDe(unEmpleado) or unEmpleado.concretoOperacionDe(self))
	
	
	method cerroOperacionesEnElMismoLugarQue(unEmpleado) = 
	self.lugaresOperaciones().any{lugar => unEmpleado.lugaresOperaciones().contains(lugar)}
	
	method lugaresOperaciones(){
		return operacionesCerradas.map{operacion => operacion.zona()}
	}
	
	method concretoOperacionDe(unEmpleado) = self.empleadosACargoDeLasOperaciones().contains(unEmpleado)
	
	method empleadosACargoDeLasOperaciones(){
		return operacionesCerradas.map{operacion => operacion.empleadoACargo()}
	}
}