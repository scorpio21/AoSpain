# Repaso para Mañana - AoSpain

## ✅ Estado Actual (Commit 24cf267 + Estabilidad Cuentas)
- **Arquitectura:** Migración 32-bit (Long) consolidada en renderizado y lógica de dibujo (HDC).
- **Sistema de Cuentas:** 100% funcional y estable. Login, creación de personajes con atributos/skills reales y vinculación de email automatizada.
- **Red:** Reconexión limpia en `frmCuent` y corrección de errores de socket asíncronos.
- **Cliente:** Reparado el renderizado de personajes en el panel de cuentas y el flujo del comando `/salir`.

## 🚀 Pendientes
1. **Migración DX8 (Siguiente Fase):**
   - Integrar módulos de DX8 uno a uno.
   - NO borrar archivos antiguos hasta que el nuevo motor renderice.
   - Adaptar `TileEngine.bas` y `clsAudio.cls` sin perder lógicas de AoSpain.
2. **Interfaz y Pulido:**
   - Revisar controles inexistentes en formularios antiguos (ej. `OptTrans`).
   - Unificar estilo visual del panel de cuentas con el resto del juego.
3. **Limpieza de Datos:**
   - Purgar archivos `.chr` huérfanos que no pertenezcan a ninguna cuenta real.

## ⚠️ Lecciones Aprendidas
- El paquete `NLOGIN` debe ser exacto entre cliente y servidor (32 campos); cualquier desajuste corrompe los datos del personaje.
- Las funciones `CurServerIp` y `CurServerPort` necesitan validación de carga de formularios para evitar errores de referencia nula tras un `Unload`.
- `BitBlt` es el método más fiable para renderizado de interfaz en VB6 cuando se trabaja con el motor en 32-bit.
