package jadex.desastres.caronte.police;

import jadex.bdi.runtime.*;
import jadex.desastres.*;

/**
 * Plan de la POLICIA
 * 
 * @author Nuria y Juan Luis Molina
 * 
 */
public class LlegaDesastrePlan extends EnviarMensajePlan {

	private Environment env;

	/**
	 * Cuerpo del plan
	 */
	public void body() {
		String recibido = enviarRespuesta("ack_aviso", "Aviso recibido");
		Environment.printout("PP police: Ack mandado",0);

		//Obtenemos un objeto de la clase Environment para poder usar sus metodos
		env = (Environment) getBeliefbase().getBelief("env").getFact();
		//Obtengo mi posicion
		Position oldPos = (Position) getBeliefbase().getBelief("pos").getFact();

		Position posicionComisaria = (Position) getBeliefbase().getBelief("Comisaria").getFact();

		//id del Desastre atendiendose
		int idDes = new Integer(recibido);

		//Espero a que se borre el desastre (lo borra el bombero) para irme a otra cosa...
		Disaster des = env.getEvent(idDes);
		Position positionDesastre = new Position(des.getLatitud(), des.getLongitud());
		Environment.printout("PP police: Estoy destinado al desastre " + idDes,0);

		try {
			env.andar(getComponentName(), oldPos, positionDesastre, env.getAgent(getComponentName()).getId(), 0);
		} catch (Exception e) {
			System.out.println("PP police: Error metodo andar: " + e);
		}

		String recibido2 = esperarYEnviarRespuesta("terminado", "Terminado recibido");

		Environment.printout("PP police: Desastre " + idDes + " solucionado",0);
		Environment.printout("PP police: Vuelvo a la comisaria",0);
		
		try {
			env.andar(getComponentName(), oldPos, posicionComisaria, env.getAgent(getComponentName()).getId(), 0);
		} catch (Exception e) {
			System.out.println("PP police: Error metodo andar: " + e);
		}
		Environment.printout("PP police: En la comisaria",0);
	}
}
