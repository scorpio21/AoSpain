# Progreso Migración DirectX 8 (Rama: `aospainDX`)

Este documento registra el avance en la integración del motor gráfico DirectX 8 en AoSpain, sustituyendo al antiguo motor basado en DirectDraw 7 (GDI/HDC).

## 📅 Hitos Alcanzados (26 de Marzo 2026)

### 1. Sustitución del Motor Gráfico (DX7 -> DX8)
- **Motor DX8 Real**: Integración de `clsDX8Engine.cls` y `TileEngine.bas` (DX8) con soporte completo de 32 bits (`Long`).
- **Limpieza de Dependencias**: Se eliminaron los módulos obsoletos de DirectX 7 (`DX_InIt.bas`, `MODOS_DE_VIDEO.bas`, `Modulo_DibujarInventario.bas`, `Mod_Lighting.bas`) del proyecto.

### 2. Estabilización de la Compilación (Finalizada ✅)
- **Eliminación de Referencias Obsoletas**: Corregidas las llamadas a `BackBufferSurface`, `PrimarySurface`, `InitTileEngine`, `LiberarObjetosDX`, `CargarAnimsExtra` y cálculos manuales de rectángulos en `General.bas`.
- **Centralización de Tipos**: Se eliminaron las **dependencias circulares** y **nombres ambiguos** centralizando todas las estructuras en `Declares.bas`.
- **Corrección de Audio**: Migración completa de `frmMain.Play` y `frmMain.StopSound` al nuevo motor `clsAudio`.
- **Sintaxis VB6**: Corregida la ubicación de declaraciones de variables en `frmMain.frm` para cumplir con el estándar de compilación.

### 3. Modernización del Ciclo de Vida y Renderizado
- **Bucle de Juego Centralizado**: El bucle principal en `Sub Main` (`General.bas`) ahora utiliza `engine.Render` como punto único de dibujado.
- **Integración HUD**: Se integraron `DibujarCartel`, `Inventario.DrawInventory`, `Dialogos.Render` y `IScombate` directamente en el flujo de `engine.Render`.
- **Efecto de Ceguera DX8**: Implementada lógica de `UserCiego` en `clsDX8Engine.ShowNextFrame`.

### 4. Inventario Gráfico DX8
- **Nueva Clase**: Implementación de `clsGraphicalInventory.cls` para renderizar los items del inventario.
- **Integración en Bucle**: Activada la llamada a `Inventario.DrawInventory` en el motor principal.

### 5. Compatibilidad PNG y 32-bit
- **Texturas PNG**: El gestor de superficies ahora carga exclusivamente archivos `.png`.
- **Seguridad de Tipos**: Actualizado `InitGrh` y `DrawGrhtoHdc` para usar `Long` en `grhindex`.

---

## 🚀 Próximos Pasos (Hoja de Ruta DX8)

### Fase 3: Integración de Red y HUD (Siguiente)
- [x] **Sincronización TCP**: Actualizar `TCP.bas` para que los paquetes de items (`CSI`, `NPCI`) utilicen `Inventario.SetItem`.
- [ ] **Bucle de Juego**: Validar la transición fluida desde el panel de cuentas al mapa.
- [ ] **Primer Mapa DX8**: Renderizado masivo de tiles y personajes en el mundo.

### Fase 4: Renderizado de Entidades
- [ ] Dibujar diálogos y nombres flotantes con el sistema de fuentes DX8.
- [ ] Implementar efectos de clima (lluvia) y luces dinámicas nativas.

---
*Documento mantenido automáticamente por Gemini CLI.*
