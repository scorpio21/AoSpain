# Documentación de Herramientas - AoSpain

Esta carpeta contiene las herramientas auxiliares para el mantenimiento y desarrollo del proyecto AoSpain.

## 1. ConversorGrh (.NET 8)

Es una herramienta moderna desarrollada en C# para la gestión, conversión y visualización de archivos de índices y mapas del juego. Está diseñada para trabajar con formatos estándar de Argentum Online, permitiendo la migración de datos de 16-bit a 32-bit (IDs extendidos).

### Características Principales

*   **Selección de Origen:** Permite elegir una carpeta que contenga los archivos `.ind` y `.map` originales.
*   **Conversión de Índices (32-bit):** Procesa los archivos principales de configuración de gráficos y animaciones para soportar IDs de mayor rango.
    *   Archivos soportados: `Graficos.ind`, `Cabezas.ind`, `Cascos.ind`, `Personajes.ind`, `Fxs.ind`.
*   **Conversión de Mapas (32-bit):** Adapta los archivos `.map` para que sean compatibles con el motor de 32 bits, ajustando la lectura de capas y Grhs.
*   **Visualizador de Gráficos:** Incluye una interfaz para abrir archivos `Graficos.ind` (detectando automáticamente si son 16 o 32 bits) y ver su contenido en una tabla.
*   **Exportador a .DAT:** Permite exportar la información de los índices a un archivo `Graficos.dat` compatible con herramientas antiguas, utilizando codificación **ANSI (Windows-1252)** y saltos de línea **CRLF**.

### Requisitos Técnicos

*   Runtime de **.NET 8.0**.
*   Sistema Operativo Windows (WinForms).

### Uso de la Herramienta

1.  Ejecutar `ConversorGrh.exe`.
2.  Hacer clic en **"1. SELECCIONAR ORIGEN"** y buscar la carpeta donde están los archivos `.ind`.
3.  Utilizar los botones de **"CONVERTIR"** según la necesidad. Los resultados se guardarán en carpetas automáticas (`Init_Convertido` o `Map_Convertidos`) dentro del directorio del proyecto.
4.  Para visualizar o generar un `.dat`, usar el botón **"VISUALIZADOR / EXPORTADOR .DAT"**.

---

*Documentación generada el 19 de marzo de 2026.*
