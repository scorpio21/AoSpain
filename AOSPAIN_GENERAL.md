# AoSpain - Compendio General del Proyecto

Este documento centraliza el estado actual, la arquitectura técnica y el progreso del proyecto AoSpain hasta el 24 de marzo de 2026.

## 📌 Visión del Proyecto
AoSpain es una modernización del motor clásico de Argentum Online (VB6), migrando estructuras críticas de 16-bit (Integer) a 32-bit (Long). Esto permite superar el límite de 32,767 registros en gráficos, objetos, NPCs y mapas.

---

## 👥 Sistema de Cuentas (Estado: Fase 2 Finalizada - Estable)
Se ha implementado un sistema multicharacter completo (1 cuenta -> N personajes).

### Funcionalidades Implementadas:
- **Login de Cuenta (`ALOGIN`):** Validación de credenciales y envío de lista de personajes.
- **Creación de Personajes (`NLOGIN`):** Selección de raza, clase, atributos, habilidades y **cabeza dinámica**, vinculados al email de la cuenta.
- **Sistema de Cabezas y Cuerpos Dinámico (Fase 1 - Marzo 2026):**
    - **Visual:** Carrusel de 5 cabezas en `frmCrearPersonaje` con rotación 360 (4 direcciones).
    - **Vista Previa:** Implementada la renderización del **PJ Completo** (Cuerpo + Cabeza) en tiempo real mediante `UpdatePJPreview`, vinculando automáticamente el cuerpo inicial según la raza y el sexo (mapeo `GetBodyByRaceSex`).
    - **Visibilidad Inteligente:** Los controles de personalización (flechas, cabezas, vista previa) solo se muestran tras una selección válida de raza y sexo, mejorando la limpieza visual.
    - **Configuración:** Rangos cargados desde `Cabezas.ini` por `RAZA-SEXO`, eliminando el hardcoding.
- **Refactorización del Panel de Cuentas (Fase 2 - Marzo 2026):**
    - **Capacidad:** Estandarizado el soporte para **10 slots de personajes** (0-9) en toda la lógica del cliente y renderizado.
    - **UX/Feedback:** Implementado resaltado visual mediante un **borde dorado doble** en tiempo real sobre el personaje seleccionado.
    - **Arquitectura de Conexión:** Centralizada la lógica de entrada al mundo en `EntrarAlMundo()`, eliminando código redundante en clics y dobles clics.
- **Borrado de Personajes (`BORR`):** 
    - Borrado físico con backup automático en `Servidor/ChrBackUp/`.
    - Reordenamiento automático de la lista en el archivo `.act`.
    - Refresco en tiempo real en el cliente sin desconexión.
- **Interfaz del Cliente:** Limpieza automática de slots (`LimpiarPJsCuentas`) para evitar duplicados visuales.

### Paquetes Clave:
- `INIAC`: Inicializa la lista de personajes.
- `ADDPJ`: Agrega los datos de un personaje al slot correspondiente.
- `BORROK`: Confirmación de borrado exitoso.

### Hallazgos y Soluciones (Marzo 2026):
- **Problema de Persistencia de `frmCuent`:**
    - *Solución:* Añadido `Unload frmCuent` en `TCP.bas` (`LOGGED`) y en el timer de FPS de `frmMain.frm`.
- **Comando `/salir` (Vuelta a Selección de PJ):**
    - *Solución (Servidor):* Modificado `/SALIR` para llamar a `CloseUser` y reenviar la lista de personajes si el usuario pertenece a una cuenta.
    - *Solución (Cliente):* Modificado `Case "FINOK"` para evitar la desconexión del socket si `EstadoLogin = LoginAccount`.

---

## 🏗️ Arquitectura Técnica (Motor de 32 bits)
La migración a `Long` asegura la escalabilidad del juego a largo plazo.

### Cambios Críticos:
- **Índices Gráficos:** Soporte para IDs de gráficos ilimitados.
- **Sistema de Oro:** Solucionado el desbordamiento de 32k al comerciar.
- **Renderizado HDC:** Implementada la lógica para dibujar personajes directamente en PictureBoxes del cliente usando `BitBlt` y el motor gráfico de 32-bit.

---

## 🚀 Próximos Pasos (Hoja de Ruta)
1. **Migración a DirectX 8 (Fase 3):** Implementar el renderizado por hardware manteniendo la compatibilidad con los índices de 32 bits.
2. **Refactorización de Interfaz:** Unificar el estilo visual de los nuevos formularios de cuenta con la estética clásica del juego.
3. **Optimización de Base de Datos:** Limpieza de personajes huérfanos y optimización de archivos `.chr`.

---
*Última actualización: 24 de marzo de 2026*
