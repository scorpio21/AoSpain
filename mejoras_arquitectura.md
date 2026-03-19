# Mejoras de Arquitectura: Migración a 32-bit (Long)

Este documento detalla los cambios realizados para migrar el motor de AoSpain de 16-bit (`Integer`) a 32-bit (`Long`), permitiendo superar el límite histórico de 32,767 en IDs de gráficos, objetos y mapas.

## Resumen del Cambio (Integer ➔ Long)

### 1. Cliente (`Cliente\codigo`)
*   **`Declares.bas`**: Las estructuras fundamentales (`Grh`, `Obj`, `Char`) ahora utilizan `Long` para sus índices (`GrhIndex`, `ObjIndex`).
*   **`TileEngine.bas`**: Las funciones de renderizado se actualizaron a `Long` para evitar el "Error 6: Overflow" al procesar mapas extensos o con gran densidad de capas.
*   **`Mod_TCP (HandleData)`**: Se migraron las variables de control del flujo de paquetes (`Slot`, `CharIndex`, `X`, `Y`, `tempint`, `i`, `k`, `Index`) a `Long`. Esto asegura que el procesamiento de ítems del inventario y el banco soporte IDs superiores a 32k.
*   **`Modulo_DibujarInventario.bas`**: Las variables de control de la interfaz de inventario (`OffsetDelInv`, `ItemElegido`, `mx`, `my`) se cambiaron a `Long` para garantizar la selección correcta de objetos en el inventario extendido.

### 2. Servidor (`Servidor\Codigo\Modulos`)
*   **`Declares.bas`**: Las definiciones de `User`, `NPC` y `Obj` ahora utilizan `Long` para sus índices únicos, permitiendo una base de datos de objetos prácticamente ilimitada.
*   **`FileIO.bas`**: Ajuste en la lectura de archivos binarios `.ind` y `.dat` para leer 4 bytes en lugar de 2 por cada ID gráfico/objeto.
*   **`mdlCOmercioConUsuario.bas`**: Se actualizó el tipo `tCOmercioUsuario` y la lógica de intercambio para usar `Long` en los índices de objetos y las cantidades de oro. Esto erradica los bugs de pérdida de oro al comerciar más de 32,767 monedas.
*   **`Modulo_InventANDobj.bas` (InvNpc)**: Las funciones de gestión de inventario de NPCs (`QuedanItems`, `EncontrarCant`, `QuitarNpcInvItem`) ahora operan con `Long` para ser compatibles con los nuevos límites de objetos.
*   **`SistemaCombate.bas`**: El cálculo de daño y experiencia acumulada ahora es seguro contra desbordamientos.

### 3. Herramientas de Soporte
*   **`ConversorGrh (.NET 8)`**: Actúa como el puente de compatibilidad. Convierte los archivos originales de 16 bits del juego a una estructura de 32 bits que el nuevo motor puede interpretar correctamente.

---
*Última actualización: 19 de marzo de 2026.*
