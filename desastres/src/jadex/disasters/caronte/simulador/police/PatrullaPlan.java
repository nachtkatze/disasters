package disasters.caronte.simulador.police;

import disasters.Position;
import disasters.caronte.Entorno;
import jadex.bdi.runtime.Plan;

/**
 * Plan del POLICIA para mover de forma aleatoria un agente.
 * @author Nuria Siguero y Juan Luis Molina
 */
public class PatrullaPlan extends Plan{

	/**
	 * Cuerpo del plan
	 * Falta mover el agente a esa posicion.
	 */
	public void body(){
		//Obtenemos un objeto de la clase entorno para poder usar sus metodos.
		Entorno env = (Entorno)getBeliefbase().getBelief("env").getFact();
		//Necesito mi posicion y la nueva posicion a la que andara si no hay desastre que atender

		Position oldPos = (Position)getBeliefbase().getBelief("pos").getFact();

		//Creamos una nueva posicion aleatoria
		Position newPos = (Position)env.getRandomPosition();
		
		env.printout("PP police: Estoy patrullando porque no hay desastres activos... ", 2, 0);
		try{
			env.go(getComponentName(), newPos);
			env.pinta(env.getAgent(getComponentName()).getId(), 0, newPos.getLat(), newPos.getLng());

		}catch (Exception e){
			System.out.println("PP police: Error metodo andar: " + e);
		}
		waitFor(1000);
	}
}