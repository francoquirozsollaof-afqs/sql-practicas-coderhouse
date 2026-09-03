# Práctica: Lenguaje M en el Editor Avanzado

## 1. ¿Qué hace exactamente el bloque `let...in` en lenguaje M? ¿Por qué cada paso puede referenciar al anterior?

El bloque `let...in` permite definir una serie de pasos para transformar los datos. Cada paso tiene un nombre y puede utilizar el resultado de un paso anterior.

Por ejemplo, `LimpiarEspacios` utiliza como entrada el resultado de `#"Tipo de columna cambiado"`, y después `EstandarizarCategoria` utiliza el resultado de `LimpiarEspacios`.

La parte `in` indica cuál de los pasos será el resultado final de la consulta. En este caso, `in TiparColumnas` devuelve la tabla después de aplicar todas las transformaciones.

## 2. ¿Por qué M es Case Sensitive y qué consecuencia práctica tiene? Da un ejemplo de un error que esto puede causar.

M es Case Sensitive, es decir, diferencia entre mayúsculas y minúsculas. Por eso hay que respetar exactamente los nombres de las funciones, columnas y pasos.

Por ejemplo, `Table.TransformColumns` funciona correctamente, pero escribir `table.transformcolumns` genera un error porque M no reconoce ese nombre como la función correspondiente.

También puede afectar a las comparaciones de texto. `"Prueba"` y `"PRUEBA"` son valores diferentes para M.

## 3. ¿Cuál es la diferencia entre usar `Text.Trim` y `Text.Clean` en M?

`Text.Trim` elimina los espacios que aparecen al principio y al final de un texto. Por ejemplo:

```m
Text.Trim(" Laptop ")
```

devuelve `"Laptop"`.

`Text.Clean`, en cambio, elimina caracteres de control o caracteres no imprimibles que pueden aparecer en los datos.

Por lo tanto, `Text.Trim` sirve principalmente para limpiar espacios sobrantes, mientras que `Text.Clean` se utiliza para eliminar caracteres no imprimibles.

## 4. ¿Por qué filtraste los registros "PRUEBA" después de estandarizar la categoría y no antes?

Primero estandaricé la categoría con `Text.Proper` para que todas las variantes tuvieran el mismo formato.

Por ejemplo:

```text
"PRUEBA" → "Prueba"
"prueba" → "Prueba"
"Prueba" → "Prueba"
```

Después pude utilizar `Table.SelectRows` para eliminar las filas donde la categoría fuera exactamente `"Prueba"`.

De esta manera, el filtro es más consistente y evita que alguna variante de escritura quede sin eliminar.
