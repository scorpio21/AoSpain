# AoSpain - Compendio General del Proyecto

Este documento centraliza el estado actual, la arquitectura técnica y el progreso del proyecto AoSpain hasta el 23 de marzo de 2026.

## 📌 Visión del Proyecto
AoSpain es una modernización del motor clásico de Argentum Online (VB6), migrando estructuras críticas de 16-bit (Integer) a 32-bit (Long). Esto permite superar el límite de 32,767 registros en gráficos, objetos, NPCs y mapas.

---

## 👥 Sistema de Cuentas (Estado: Finalizado y Estable)
Se ha implementado un sistema multicharacter completo (1 cuenta -> N personajes).

### Funcionalidades Implementadas:
- **Login de Cuenta (`ALOGIN`):** Validación de credenciales y envío de lista de personajes.
- **Creación de Personajes (`NLOGIN`):** Selección de raza, clase, atributos y habilidades, vinculados al email de la cuenta.
- **Borrado de Personajes (`BORR`):** 
    - Borrado físico con backup automático en `Servidor/ChrBackUp/`.
    - Reordenamiento automático de la lista en el archivo `.act`.
    - Refresco en tiempo real en el cliente sin desconexión.
- **Seguridad:** Validación de pertenencia del PJ a la cuenta antes de borrar.
- **Interfaz del Cliente:** Limpieza automática de slots (`LimpiarPJsCuentas`) para evitar duplicados visuales.

### Paquetes Clave:
- `INIAC`: Inicializa la lista de personajes.
- `ADDPJ`: Agrega los datos de un personaje al slot correspondiente.
- `BORROK`: Confirmación de borrado exitoso.

---

## 🏗️ Arquitectura Técnica (Motor de 32 bits)
La migración a `Long` asegura la escalabilidad del juego a largo plazo.

### Cambios Críticos:
- **Índices Gráficos:** Soporte para IDs de gráficos ilimitados.
- **Sistema de Oro:** Solucionado el desbordamiento de 32k al comerciar.
- **Renderizado HDC:** Implementada la lógica para dibujar personajes directamente en PictureBoxes del cliente usando `BitBlt` y el motor gráfico de 32-bit.

---

## 📁 Estructura de Archivos Relevantes
- `Cliente/codigo/Cuentas/frmCuent.frm`: Formulario principal de selección de personajes.
- `Cliente/codigo/Cuentas/DrawPJenPicture.bas`: Motor de renderizado de personajes en la interfaz.
- `Cliente/codigo/TCP.bas`: Manejo de protocolo de red (INIAC, ADDPJ, BORROK).
- `Servidor/Codigo/Modulos/TCP.bas`: Lógica de negocio, gestión de cuentas y persistencia.
- `Servidor/Accounts/*.act`: Archivos de configuración de cuentas.

---

## 🚀 Próximos Pasos (Hoja de Ruta)
1. **Migración a DirectX 8:** Implementar el renderizado por hardware manteniendo la compatibilidad con los índices de 32 bits.
2. **Refactorización de Interfaz:** Unificar el estilo visual de los nuevos formularios de cuenta con la estética clásica del juego.
3. **Optimización de Base de Datos:** Limpieza de personajes huérfanos y optimización de archivos `.chr`.

---
*Última actualización: 23 de marzo de 2026*
