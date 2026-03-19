# AoSpain - Proyecto Argentum Online (32-bit Engine)

![AoSpain Logo](Servidor/Logo.jpg)

**AoSpain** es un proyecto basado en el motor clásico de **Argentum Online**, profundamente optimizado y modernizado para soportar arquitecturas de **32 bits (Long)**. Esta mejora rompe los límites históricos de 16 bits (32k), permitiendo bases de datos de objetos, gráficos y mapas virtualmente ilimitadas.

## 🚀 Características Principales

### 🏗️ Motor de 32 bits (Migración Long)
Se ha realizado una migración quirúrgica en el Cliente y el Servidor, cambiando los índices críticos de `Integer` a `Long`.
- **Gráficos e Índices:** Soporte para más de 2 mil millones de IDs de gráficos y animaciones.
- **Objetos y Comercio:** Solución definitiva al bug de pérdida de oro al comerciar más de 32,767 monedas.
- **Renderizado (DirectX 7):** Optimización del `TileEngine` para evitar desbordamientos en mapas de alta densidad.

### 🛠️ Herramientas Modernas
Incluye la herramienta **ConversorGrh** desarrollada en **.NET 8**, diseñada para:
- Convertir índices (`.ind`) y mapas (`.map`) de 16 bits a 32 bits.
- Visualizar y exportar datos a formato `.dat` con codificación ANSI (Windows-1252).

### 🛡️ Seguridad y Red
- **Protocolo de Red:** Comunicación optimizada con sistema de CRC dinámico para prevenir bots.
- **Seguridad:** Hashing de contraseñas mediante MD5 y clave de aplicación secreta.
- **Handshake:** Sistema de desafío/respuesta (`ValCoDe`) para asegurar que solo el cliente oficial pueda conectarse.

## 📁 Estructura del Proyecto

- `/Cliente`: Código fuente en Visual Basic 6 (Engine de 32 bits).
- `/Servidor`: Lógica central, gestión de usuarios y NPCs (.bas).
- `/Herramientas`: Utilidades de desarrollo en .NET 8.
- `/mejoras_arquitectura.md`: Documentación detallada de la migración técnica.

## 🛠️ Requisitos de Instalación

1.  **Cliente/Servidor:** Visual Basic 6.0 con librerías registradas (`CSWSK32.OCX`, `MSINET.OCX`, etc.).
2.  **Librerías de Sonido:** `dx7vb.dll` y `Bass.bas`.
3.  **Herramientas:** Runtime de **.NET 8.0**.

## ⚖️ Licencia

Este proyecto está bajo la licencia **GNU General Public License v3.0**. Consulta el archivo `LICENSE` para más detalles.

---
*Desarrollado y mantenido por la comunidad de AoSpain.*
