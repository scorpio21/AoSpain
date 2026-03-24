# Bug: Visibilidad de frmCuent tras /salir

## Estado: SOLUCIONADO ✅

### Problema
Cuando el usuario utiliza el comando `/salir`, se pierde el foco de `frmCuent` y el formulario no se ve en pantalla, aunque la música sigue sonando.

### Causa
1. **Descarga en Desconexión**: El evento `Socket1_Disconnect` en `frmMain.frm` descargaba todos los formularios excepto `frmMain` y `frmConnect`. Si el servidor cerraba la conexión después de enviar los datos de la cuenta (`INIAC`), `frmCuent` era descargado de la memoria.
2. **Falta de Foco**: Al recibir el paquete `INIAC`, se llamaba a `frmCuent.Show` pero no se aseguraba el foco explícito, lo que podía dejar el formulario detrás de otros componentes.

### Solución Aplicada
1. **Modificación en `frmMain.frm`**:
   - Se añadió `frmCuent.Name` a la lista de exclusión del bucle de descarga en `Socket1_Disconnect`.
   ```vbnet
   If Forms(i).Name <> Me.Name And Forms(i).Name <> frmConnect.Name And Forms(i).Name <> frmCuent.Name Then
       Unload Forms(i)
   End If
   ```
2. **Modificación en `TCP.bas`**:
   - Se añadió `frmCuent.SetFocus` tras `frmCuent.Show` en el procesamiento del paquete `INIAC`.
   ```vbnet
   Case "INIAC"
       ' ...
       frmCuent.Show
       frmCuent.SetFocus
       ' ...
   ```

### Verificación
- [x] El formulario `frmCuent` no se descarga al desconectar el socket si está en modo cuenta.
- [x] Se fuerza el foco sobre `frmCuent` al recibir la lista de personajes.
