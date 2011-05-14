package jadex.desastres.caronte.police;

import jadex.bdi.runtime.*;
import jadex.desastres.*;

/**
 * Plan de la POLICIA para esperar un aviso en la comisaria.
 *
 * @author Juan Luis Molina
 *
 */
public class ComisariaPlan extends Plan {

	/**
	 * Cuerpo del plan.
	 */
	public void body() {
		// Obtenemos un objeto de la clase entorno para poder usar sus metodos
		Environment env = (Environment) getBeliefbase().getBelief("env").getFact();

		// Posicion del hospital que le corresponde
		Position posicionComisaria = (Position) getBeliefbase().getBelief("Comisaria").getFact();

		// Posicion actual de la ambulancia
		Position pos = (Position) getBeliefbase().getBelief("pos").getFact();

		waitFor(1000);
	}
}
