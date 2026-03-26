# Progreso Migración DirectX 8 (Rama: `aospainDX`)

Este documento registra el avance en la integración del motor gráfico DirectX 8 en AoSpain, sustituyendo al antiguo motor basado en DirectDraw 7 (GDI/HDC).

## 📅 Hitos Alcanzados (25 de Marzo 2026)

### 1. Sustitución del Motor Gráfico (DX7 -> DX8)
- **Motor DX8 Real**: Integración de `clsDX8Engine.cls` y `TileEngine.bas` (DX8) con soporte completo de 32 bits (`Long`).
- **Limpieza de Dependencias**: Se eliminaron los módulos obsoletos de DirectX 7 (`DX_InIt.bas`, `MODOS_DE_VIDEO.bas`, `Modulo_DibujarInventario.bas`, `Mod_Lighting.bas`) del proyecto para evitar conflictos de tipos como `DDSURFACEDESC2`.

### 2. Estabilización de la Compilación
- **Centralización de Tipos**: Se eliminaron las **dependencias circulares** moviendo todas las estructuras globales (`Grh`, `MapBlock`, `Char`, `Position`, `E_Heading`) a `Declares.bas`.
- **Registro de Clases**: Se registraron oficialmente en `Client.vbp` las clases `clsSurfaceManDynDX8`, `clsAudio` y la nueva `clsGraphicalInventory`.

### 3. Inventario Gráfico DX8
- **Nueva Clase**: Implementación de `clsGraphicalInventory.cls` para renderizar los items del inventario usando el motor de vértices y texturas de DX8.
- **Integración en Bucle**: Activada la llamada a `Inventario.DrawInventory` en el motor principal, sustituyendo al antiguo sistema basado en HDC.

### 4. Compatibilidad PNG y 32-bit
- **Texturas PNG**: El gestor de superficies ahora carga exclusivamente archivos `.png` con canal alpha.
- **Carga de Datos**: Corregida la función `LoadGrhData` para soportar índices de 32 bits y el formato binario original de AO.

---

## 🚀 Próximos Pasos (Hoja de Ruta DX8)

### Fase 3: Integración de Red y HUD (Siguiente)
- [ ] **Sincronización TCP**: Actualizar `TCP.bas` para que los paquetes de items (`CSI`, `NPCI`) utilicen `Inventario.SetItem`.
- [ ] **Bucle de Juego**: Validar la transición fluida desde el panel de cuentas al mapa.
- [ ] **Primer Mapa DX8**: Renderizado masivo de tiles y personajes en el mundo.

### Fase 4: Renderizado de Entidades
- [ ] Dibujar diálogos y nombres flotantes con el sistema de fuentes DX8.
- [ ] Implementar efectos de clima (lluvia) y luces dinámicas nativas.

---
*Documento mantenido automáticamente por Gemini CLI.*
