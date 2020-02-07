# Perfect paper passwords

Esta aplicación está desarrollada para implementar la generación de tarjetas con *passcodes*.

Para generar la tarjeta se emplea **CryptoKit**. Con esta biblioteca se implementa un cifrador **AES**, y para hacerlo se utiliza una *llave simétrica de 256 bits*. Con el resultado del *cifrador* se llevan a cabo divisiones sucesivas de 128 bits tomando en cuenta el tamaño deseado para cada celda de la columna haciendo las veces de *divisor*. Con el residuo de cada operación se mapea el *Passcode character set* para obtener la cadena para cada una de las celdas de la tarjeta de *passcodes*

Cabe mencionar que **CryptoKit** hasta el momento no permite al programador establecer el vector de inicialización lo que en consecuencia hace imposible replicar las contraseñas de la tarjeta generadas en la app.

Para más información con respecto al algoritmo se puede consultar la siguiente liga:

[https://www.grc.com/ppp/algorithm.htm](GRC)

Para las operaciones con números de 128 bits se usa la siguiente biblioteca: 

[https://github.com/Jitsusama/UInt128]


## Consideraciones

Esta app funciona para teléfonos de iPhone 8 en adelante  con iOS 13.2 en adelante debido al uso de la biblioteca **Cryptokit**