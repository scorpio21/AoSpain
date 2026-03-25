# Progreso Migración DirectX 8 (Rama: `aospainDX`)

Este documento registra el avance en la integración del motor gráfico DirectX 8 en AoSpain, sustituyendo al antiguo motor basado en DirectDraw 7 (GDI/HDC).

## 📅 Hitos Alcanzados (25 de Marzo 2026)

### 1. Sustitución del Motor Gráfico (DX7 -> DX8)
Se ha realizado el cambio estructural del motor de renderizado, pasando de un sistema basado en `BitBlt` (HDC) a uno de vértices y texturas real de DirectX 8.

*   **`TileEngine.bas`**: Sustituido por la versión de DX8 adaptada para 32 bits.
    *   *Soporte 32-bit:* Se modificaron las estructuras `Grh`, `MapBlock`, `Char`, `Obj` y `GrhData` para usar `Long` en todos los índices gráficos y de objetos.
    *   *Referencia:* El antiguo motor se conserva como `TileEngine_DX7.bas`.
*   **`clsDX8Engine.cls`**: Actualizado para vincular el dispositivo Direct3D al nuevo control `renderer`.
    *   Se corrigió `Engine_Init` para usar `frmMain.renderer.hWnd` y `ScaleWidth/Height`.
*   **`clsSurfaceManDynDX8.cls`**: Integrado como el nuevo gestor de texturas dinámico para DX8.

### 2. Modernización de la Interfaz (`frmMain.frm`)
*   **Control `renderer`**: Se insertó un `VB.PictureBox` dedicado con el nombre `renderer` (544x416 px) para servir como superficie de dibujo de DirectX 8, eliminando el renderizado directo sobre el formulario.

### 3. Carga de Gráficos y Compatibilidad PNG
*   **`modDX8Fifo.bas`**: Se implementó una nueva función `LoadGrhData` y `CargarDatos` optimizada para 32 bits.
    *   *Formato AO:* Se corrigió el bucle de lectura para que sea compatible con el formato binario de `Graficos.ind`.
    *   *Dimensiones:* Se añadió una segunda pasada para calcular las dimensiones de las animaciones basándose en sus frames.
*   **`clsSurfaceManDynDX8.cls`**: Se actualizó el cargador de texturas para buscar archivos **`.png`** en lugar de `.bmp`.
    *   Se adaptaron los índices de archivos a `Long` para evitar desbordamientos.
*   **`General.bas`**: Se integró la llamada a `Call CargarDatos` en el `Sub Main` tras la inicialización del motor.

### 4. Sincronización de Declaraciones (`Declares.bas`)
*   Se añadieron las instancias globales necesarias para el nuevo ecosistema DX8: `SurfaceDB`, `Audio` y `engine`.

---

## 🚀 Próximos Pasos (Hoja de Ruta DX8)

### Fase 3: Estabilidad y Renderizado (Actual)
- [x] Inicialización del Engine en el control `renderer`.
- [x] Carga robusta de gráficos de 32 bits (`.ind`).
- [x] Compatibilidad total con texturas `.png`.
- [ ] **Bucle de Renderizado:** Implementar la transición limpia al bucle `engine.Start` tras la selección de personaje en `frmCuent`.
- [ ] **Primer Mapa DX8:** Renderizar el mapa inicial y validar que los tiles, personajes y objetos se dibujen correctamente.

### Fase 4: Renderizado de Entidades
- [ ] Validar el renderizado de personajes (Cuerpo + Cabeza) en el nuevo `TileEngine`.
- [ ] Migrar el sistema de diálogos y nombres flotantes al nuevo `engine.Text_Render`.

### Fase 5: Optimización y Limpieza
- [ ] Eliminar definitivamente `TileEngine_DX7.bas` y `DX_InIt.bas`.
- [ ] Implementar luces dinámicas y partículas DX8.

---
*Documento mantenido automáticamente por Gemini CLI.*
