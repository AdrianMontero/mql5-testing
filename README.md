Bienvenidos al repositorio MQL5 de AdrianMontero
----
En este repositorio puedes encontrar todos los Bot de inversion en MQL5 que vaya creando. El codigo es libre, pero no me hago responsable de las perdidas o funcionamientos incorrectos que puedan tener. Si usas cualquier codigo de este repositorio es bajo tu propia responsabilidad.

Dicho lo obligatorio/coñazo, aqui vais a tener Bots que estan testeados en Metatrader 5. Todos ellos (o en principio) van a estar creados para Forex. A continuacion tendreis una lista indicando para que sirve cada arquivo del repositorio:

Tools:
----
- mainTestingTheory.java
  --> Este archivo sirve para comprobar que cantidad de inversion haria falta para mantener una posicion X(depende de los parametros introducidos) en el bot de TheLastYear.
- SimplePositionInfo
  --> Ejemplo de codigo que simplemente muestra informacion sobre una posicion abierta
- SimplePriceInfo
  --> Ejemplo de codigo que simplemente muestra informacion sobre la direccion del precio

Bots:
----
-TheLastYear
  --> Robot de inversion para operar entradas y salidas cada X pips. La logica tras el es que el precio en la bolsa se mueve en ondas,         de modo que es posible que si abres posiciones cada X pips, sin importar que el precio suba o baje y no cierras la operacion hasta       que tenga beneficios nunca podras tener peridas.
      Hay que tener en cuenta que nadie sabe si el precio ba a subir o bajar, pero con este metodo puedes generar buenos beneficios con       una inversion baja. Esta probado en los pares EUR/USD y JPY/USD.
      Al no usar StopLoss tienes que asumir que puedes perder el 100% de tu inversion (o mejor dicho, especulacion).
  Variables
  ****
    - myLotSize: Tamaño del lotaje que vamos a "apostar" en cada trade que se abra
    - myMeshDistance: Distancia entre cada apuesta que se vaya a abrir
    - myTP: Margen de beneficio que vamos a tener en cada trade
    - myBalanceSecurity: Opcion con la que, cuando la equidad baja de X deja de hacer entradas al mercado el bot
    - myReinversionSecurity: Indica cuanto dinero necesita alcancar la equidad de tu cuenta para multiplicar el lotaje de cada trade, por ejemplo, un 2 indica que tendria que tener el doble mas un 50% para doblar el lotaje, un 3 seria el doble mas un 33% un 5 seria el doble mas un 20%...
    - tradeInLong: Con true abres operaciones en Largo, en false se deshabilita
    - tradeInShort: Con true abres operaciones en corto, en false se deshabilita
    - riskForce: Habilita la opcion de doblar inversion dependiendo del lo alejada que este la equidad de tu cuenta del balance de la misma.
    
    
-RSI Bot - Comming soon
  --> Este bot estara configurado para poder hacer entradas en largo cuando entra en sobre-compra y salir cuando sale de sobre-compra y       hacer entradas en corto cuando entra en sobre-venta y cerrarlas cuando sale de sobre-venta. Este indicador no se usa de esta forma       exacta pero con temporalidad 30min en graficos EUR/USD y sobre todo JPY/USD resulta interesante el bot.
