# Perfect paper passwords

Esta aplicación está desarrollada para implementar la generación de tarjetas con *passcodes*.

Para generar la tarjeta se emplea **CryptoKit**. Con esta biblioteca se implementa un cifrador **AES**, y para hacerlo se utiliza una *llave simétrica de 256 bits*. Con el resultado del *cifrador* se llevan a cabo divisiones sucesivas de 128 bits tomando en cuenta el tamaño deseado para cada celda de la columna haciendo las veces de *divisor*. Con el residuo de cada operación se mapea el *Passcode character set* para obtener la cadena para cada una de las celdas de la tarjeta de *passcodes*

Cabe mencionar que **CryptoKit** hasta el momento no permite al programador establecer el vector de inicialización lo que en consecuencia hace imposible replicar las contraseñas de la tarjeta generadas en la app.

Para más información con respecto al algoritmo se puede consultar la siguiente liga:

[GRC](https://www.grc.com/ppp/algorithm.htm)

Para las operaciones con números de 128 bits se usa la siguiente biblioteca: 

[UInt128](https://github.com/Jitsusama/UInt128)


## Consideraciones

- Esta app **sólo funciona para teléfonos de iPhone 8 en adelante con iOS 13.2 o superior** debido al uso de _cryptokit_.
- La app funciona para un pass code length igual a 11.
- El character set debe ser al menos de 16 caracteres.


## Instalación
 
 1. Tener instalado Xcode al menos la versión 11.3.1(11C504)
 2. [Clonar el repositorio](https://help.github.com/es/github/creating-cloning-and-archiving-repositories/cloning-a-repository) de la siguiente liga [Perfect Paper Password](https://github.com/JulesLeGrand/PerfectPassword.git).
 3. Abrir el archivo PerfectPassword.xcodeproj con _Xcode_
 4. Seleccionar un emulador (Se recomienda iPhone 8) o algún otro con iOS 13.3.
 5. En _Xcode_ en el menú Product elegir la opción Run
 6. Esperar a que construya (_Build_) e inicie la app.
