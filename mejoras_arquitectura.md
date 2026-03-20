# Mejoras de Arquitectura: Migración a 32-bit (Long)

Este documento detalla los cambios realizados para migrar el motor de AoSpain de 16-bit (`Integer`) a 32-bit (`Long`), permitiendo superar el límite histórico de 32,767 en IDs de gráficos, objetos y mapas.

## Resumen del Cambio (Integer ➔ Long)

### 1. Cliente (`Cliente\codigo`)
*   **`Declares.bas`**: Las estructuras fundamentales (`Grh`, `Obj`) ahora utilizan `Long` para sus índices principales (`GrhIndex`, `ObjIndex`).
*   **`TileEngine.bas`**: El motor de renderizado procesa los `GrhIndex` como `Long`, permitiendo visualizar gráficos con IDs superiores a 32k.
*   **`Mod_TCP (HandleData)`**: 
    *   **Variables de Datos**: Los valores de Grh e ItemIndex se procesan como `Long`.
    *   **Variables de Control**: Coordenadas (`X`, `Y`), índices de personajes (`CharIndex`) e índices de bucles (`i`, `k`) se mantienen como `Integer` para garantizar compatibilidad `ByRef` con las funciones del motor y optimizar el uso de memoria.
*   **`Modulo_DibujarInventario.bas`**: La lógica de dibujo soporta la indexación de objetos de 32-bit.

### 2. Servidor (`Servidor\Codigo\Modulos`)
*   **`Declares.bas`**: Las definiciones de `User`, `NPC` y `Obj` utilizan `Long` para `GrhIndex` y `ObjIndex`.
*   **`FileIO.bas / mdlLeeMapas.bas`**: 
    *   **Lectura Binaria**: La estructura `TileMap` se ha actualizado para leer 4 bytes (`Long`) por cada capa de gráfico en el archivo `.map`. Esto evita el desalineamiento de datos al cargar mapas.
    *   **CargarBackUp_Nuevo2**: Se implementaron validaciones de seguridad para asegurar que los índices de NPCs y Objetos leídos del mapa estén dentro de los límites de los arrays antes de su asignación.
*   **`mdlCOmercioConUsuario.bas`**: Soporte de `Long` para cantidades de oro y IDs de objetos, eliminando bugs de desbordamiento en transacciones grandes.

### 3. Herramientas de Soporte
*   **`ConversorGrh (.NET 8)`**: Herramienta externa que transforma los archivos `.ind` y `.dat` de 16-bit a la nueva estructura de 32-bit compatible con este motor.

## Notas de Estabilidad
La decisión de mantener ciertas variables (como coordenadas e índices de bucle) en `Integer` responde a la arquitectura interna de Visual Basic 6, donde las llamadas por referencia (`ByRef`) requieren coincidencia exacta de tipos. Esto previene errores de ejecución sin limitar la capacidad de usar miles de nuevos gráficos y objetos.

---
*Última actualización: 20 de marzo de 2026 (Corrección de estabilidad ByRef).*
