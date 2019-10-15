package core;
//Movimiento medio al mes 0.01 aprox
public class main {
private static double appeceament = 30;             // Apalancamiento del broker
private static double numberOfPositionForTrade = 2; // Una en corto y otra en largo
private static double meshLotPrice = 33;           // Precio de cada Lot - Si se abre en compra y en venta x2 al precio
	public static void main(String[] args) {
		double meshMaxSize = 1.3;           // Precio maximo que puede alcanzar la malla en la que vamos a trabajar
		double meshMinSize = 1.1;           // Precio minimo que puede alcanzar la malla en la que vamos a trabajar
		double meshLotSize = 0.01;          // Lote que queremos comprar (0.01 es el lote mas pequeño)
		double meshTradeRange = 0.005;     // Cada cuanto queremos abrir una posicion nueva (distancia en Pips)
		calculadoraInversionMallaMontero(meshMaxSize, meshMinSize, meshLotSize, meshTradeRange, meshLotPrice);
	}

	public static double calculadoraInversionMallaMontero(double meshMaxSize, double meshMinSize, double meshLotSize, double meshTradeRange, double meshLotPrice) {
		double meshSize = meshMaxSize - meshMinSize;
		double numberOfNeededTrades = meshSize / meshTradeRange; //Numero de trades necesarias para llenar la malla
		double moneyInGame = numberOfNeededTrades * (meshLotPrice * numberOfPositionForTrade); // Numero de operaciones * precio por operacion
		/**El precio solo puede causarnos perdidas si se aleja mucho por arriba o por abajo pero una de la dos direcciones
		 * de nuestra operativa siempre va a ser positiva, asi que no es necesario caclular el riesgo teniendo en cuenta
		 * todas las posiciones abiertas, solo la mitad de ellas que son las que estaran en negativo, ademas, se divide otra
		 * vez el deposito necesario entre dos por que hay que calcular la media de las perdidas de las apuestas de la malla.
		 * Ej: Mientras que la primera apuesta que hicimos puede tener perdidas de 1000€ la ultima seguramente tenga perdidas de 1€
		 * De este modo al dividir entre 2 obtenemos la media (muy aproximada) del dinero de mantenimiento aproximado**/
		double depositNecesary = ((moneyInGame / numberOfPositionForTrade) * appeceament) / 2;
		
		System.out.println("Dinero en inversiones: " + moneyInGame);
		System.out.println("Dinero necesario para cubrir posiciones en los extremos de la maya: " + depositNecesary);
		return 0;
	}
}
