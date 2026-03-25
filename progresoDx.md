# Progreso Migración DirectX 8 (Rama: `aospainDX`)

Este documento registra el avance en la integración del motor gráfico DirectX 8 en AoSpain, sustituyendo al antiguo motor basado en DirectDraw 7 (GDI/HDC).

## 📅 Hitos Alcanzados (25 de Marzo 2026)

### 1. Sustitución del Motor Gráfico (DX7 -> DX8)
Se ha realizado el cambio estructural del motor de renderizado, pasando de un sistema basado en `BitBlt` (HDC) a uno de vértices y texturas real de DirectX 8.

*   **`TileEngine.bas`**: Sustituido por la versión de DX8 adaptada para 32 bits.
    *   *Soporte 32-bit:* Estructuras `Grh`, `MapBlock`, `Char`, `Obj` y `GrhData` ahora usan `Long`.
*   **`clsDX8Engine.cls`**: Vinculado al nuevo control `renderer` en `frmMain.frm`.
*   **`clsSurfaceManDynDX8.cls`**: Nuevo gestor de texturas dinámico optimizado para DX8 y PNG.

### 2. Compatibilidad PNG y 32-bit
*   **Carga de Gráficos**: Implementada `LoadGrhData` en `modDX8Fifo.bas` con soporte para índices ilimitados y formato binario original.
*   **Texturas PNG**: El motor carga exclusivamente archivos `.png`, aprovechando la transparencia nativa de DirectX 8.
*   **Refactorización de Métodos**: Se estandarizó el método de inicialización del gestor de superficies a `.Initialize`.

### 3. Modernización de la Interfaz
*   **Control Renderer**: Insertado `VB.PictureBox` (544x416 px) en `frmMain.frm`.
*   **Inicialización**: Centralizada en `Sub Main` (General.bas) llamando a `engine.Engine_Init` y `CargarDatos`.

---

## 🚀 Próximos Pasos (Hoja de Ruta DX8)

### Fase 3: Bucle de Juego y Renderizado (Actual)
- [x] Inicialización del Engine y Carga de Datos.
- [x] Compatibilidad total con texturas `.png`.
- [ ] **Bucle de Renderizado**: Activar `engine.Start` tras la selección de personaje.
- [ ] **Validación de Mapa**: Renderizar el primer mapa base en DX8.

### Fase 4: Renderizado de Entidades
- [ ] Dibujar personajes y objetos en el nuevo sistema de vértices.
- [ ] Migrar sistema de diálogos flotantes.

---
*Documento mantenido automáticamente por Gemini CLI.*
