let
  Origen = Csv.Document(File.Contents("C:\Users\franc\Downloads\table.csv"), [Delimiter = ",", Columns = 5, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"id_venta", Int64.Type}, {"nombre_producto", type text}, {"categoria", type text}, {"precio", Int64.Type}, {"fecha_venta", type date}}, "es"),

LimpiarEspacios = Table.TransformColumns(
        #"Tipo de columna cambiado",
        {{"nombre_producto", Text.Trim, type text}}
),

  // Paso 3: Estandarizar categoria usando Title Case
  EstandarizarCategoria = Table.TransformColumns(
    LimpiarEspacios,
    {{"categoria", Text.Proper, type text}}
),
// Paso 4: Eliminar los registros de prueba
  // Conservamos solamente las filas cuya categoria no sea "Prueba"
  EliminarPruebas = Table.SelectRows(
    EstandarizarCategoria,
    each [categoria] <> "Prueba"
),
// Paso 5: Definir los tipos de datos correctos
TiparColumnas = Table.TransformColumnTypes(
    EliminarPruebas,
    {
        {"id_venta", Int64.Type},
        {"nombre_producto", type text},
        {"categoria", type text},
        {"precio", type number},
        {"fecha_venta", type date}
    }
)
in
  TiparColumnas
