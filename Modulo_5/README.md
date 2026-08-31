M5-Ejercicio Practico 1

## Consulta 1 — LEFT JOIN
Utilicé LEFT JOIN porque necesito mostrar todos los productos del catálogo, incluso aquellos que no tienen ninguna venta asociada.
La tabla productos se encuentra a la izquierda del JOIN:
productos p
LEFT JOIN ventas v
El LEFT JOIN conserva todas las filas de la tabla izquierda y busca coincidencias en la tabla derecha.
En este ejercicio, los productos 108 (Hub USB-C 7p) y 109 (Parlante Bluetooth) nunca fueron vendidos. Por eso aparecen en el resultado, pero las columnas correspondientes a ventas tienen valores NULL.
Si utilizara un INNER JOIN, solamente aparecerían los productos que tienen al menos una venta. Los productos 108 y 109 se perderían del resultado.

## Consulta 2 — RIGHT JOIN
Utilicé RIGHT JOIN porque quiero conservar todas las ventas registradas y comprobar si cada una tiene un producto correspondiente en el catálogo.
En esta consulta, productos está a la izquierda y ventas está a la derecha:
productos p
RIGHT JOIN ventas v
El RIGHT JOIN conserva todas las filas de la tabla derecha, que en este caso es ventas.
La venta número 10 tiene producto_id = 999, pero no existe ningún producto con producto_id = 999 en la tabla productos.
Por eso, las columnas provenientes de productos aparecen como NULL para esta venta. Esto permite identificarla como un registro huérfano y como un posible error de carga de datos.
## ¿Qué representan los NULL?
En la Consulta 1, un NULL en venta_id significa que el producto existe en el catálogo pero no tiene ninguna venta asociada.
Por ejemplo, el producto 108, Hub USB-C 7p, aparece en productos pero no tiene ninguna fila correspondiente en ventas. Por eso su venta_id aparece como NULL.
En la Consulta 2, un NULL en las columnas de productos significa que existe una venta, pero no existe el producto correspondiente en el catálogo.

Por ejemplo, la venta 10 tiene producto_id = 999. Como el producto 999 no existe en productos, las columnas de productos aparecen como NULL.

## Consulta 3 — FULL OUTER JOIN
Utilicé FULL OUTER JOIN para realizar una auditoría completa entre productos y ventas.
Este tipo de JOIN conserva todas las filas de ambas tablas, tanto las que tienen coincidencias como las que no.
De esta manera puedo identificar:
- Productos que tienen ventas.
- Productos que nunca fueron vendidos.
- Ventas asociadas a productos existentes.
- Ventas asociadas a productos que no existen en el catálogo.
En este ejercicio, los productos 108 y 109 aparecen con NULL en las columnas de ventas, mientras que la venta 10 aparece con NULL en las columnas de productos.
## ¿Cuándo usaría FULL OUTER JOIN en un caso real?
Utilizaría FULL OUTER JOIN cuando necesitara comparar dos fuentes de información y detectar registros que existen solamente en una de ellas.
Por ejemplo, podría utilizarlo para comparar un catálogo de productos con un sistema de ventas y detectar productos que no tienen ventas, ventas que hacen referencia a productos inexistentes o diferencias entre ambos sistemas.
Esto resulta especialmente útil para realizar auditorías y controles de calidad de datos.
