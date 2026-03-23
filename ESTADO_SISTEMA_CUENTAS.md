# Estado de Implantación: Sistema de Cuentas

Este documento detalla el progreso de la migración del sistema de personajes individuales al sistema de cuentas unificado en **AoSpain**.

## ✅ Tareas Completadas (Servidor)

### 1. Definiciones y Estructuras (`Declares.bas`)
- [x] Añadido `Account As String` al `Type Char`.
- [x] Añadido `Accounted As String` y `AccountedPass As String` al `Type User`.
- [x] Variables globales `PJEnCuenta`, `PJEnCuentaB`, `totalAccounts`, `totalPjs` declaradas.

### 2. Gestión de Archivos (`FileIO.bas`)
- [x] Implementada función `UserAccountEsCrimi`.
- [x] Implementada función `LoadUserAccount`.
- [x] Actualizado `Sub SaveUser` para guardar la contraseña de la cuenta y el nombre de la cuenta en los archivos `.chr`.
- [x] `LoadUserInit` carga `AccountedPass` y `Char.Account` desde el `.chr`.
  - Evidencia: `Servidor/Codigo/Modulos/FileIO.bas` líneas 872-873, 1808-1809.

### 3. Protocolo y Conexión (`TCP.bas`)
- [x] Actualizada `Sub ConnectUser` para aceptar el parámetro `Cuenta` y verificar logs duplicados por cuenta.
- [x] Actualizada `Sub ConnectNewUser` para aceptar el parámetro `Cuenta` y pasarla a `ConnectUser`.
- [x] Implementada `Sub ConnectAccount` para manejar el login de cuentas y envío de lista de personajes (`INIAC`, `ADDPJ`).
- [x] Implementada `Sub CreateAccount` para la creación física de archivos `.act`.
- [x] Implementadas funciones de soporte: `IsYourChr`, `ChrToAccount`, `TienePjs`.
- [x] Implementada `Function CuentaExiste` para verificar existencia de cuentas.
- [x] **HandleData**:
    - [x] Implementado `Case "OOLOGI"` (Login de personaje desde cuenta).
    - [x] Implementado `Case "ALOGIN"` (Login de cuenta).
    - [x] Implementado `Case "NACCNT"` (Creación de cuenta).
    - [x] **REEMPLAZADO COMPLETAMENTE** `Case "BORR"` para eliminar PJ de la cuenta (.act) y reordenar lista.
    - [x] Implementado `Case "NLOGIN"` (Creación de personaje vinculado a cuenta + vinculación en `.act`).
    - [x] **CORREGIDO**: Desajuste de campos por género duplicado y falta de atributos/skills en el servidor.
    - [x] **CORREGIDO**: Herencia automática del email real de la cuenta vinculada (eliminado email genérico).

      Evidencia: `Servidor/Codigo/Modulos/TCP.bas` (`Case "NLOGIN"` lee 32 campos incluyendo atributos y skills, recupera mail con `GetVar` del `.act`).

### 4. Recuperación y cambio de contraseña (paquetes)

- [x] Implementados paquetes de recuperación/cambio de pass a nivel protocolo.
  - Evidencia: `Servidor/Codigo/Modulos/TCP.bas` (`Case "RECCUU"`, `Case "REECUU"`, `Case "PEDPRE"`, `Case "REPASS"`).

### 5. Infraestructura

- [x] Carpeta `Accounts` creada en servidor para almacenar archivos `.act`.
- [x] `.gitignore` actualizado para ignorar `Servidor/Accounts/*.act`.

## ✅ Tareas Completadas (Cliente)

### 1. Interfaz y Formularios
- [x] Integrado `frmCuent` como pantalla posterior al login de cuenta.
  - Evidencia: `Cliente/codigo/TCP.bas` (`Case "INIAC"` hace `frmCuent.Show` y `Unload frmConnect`).
- [x] Formularios de cuentas presentes:
  - `Cliente/codigo/Cuentas/frmCuent.frm`
  - `Cliente/codigo/Cuentas/frmCrearAccount.frm`
  - `Cliente/codigo/Cuentas/frmRecuperar.frm`
  - `Cliente/codigo/Cuentas/frmBorrar.frm` (en realidad es `frmCambiarPass`)

### 2. Módulos y Lógica
- [x] `TCP.bas` envía los paquetes de cuentas.
  - Evidencia: `Cliente/codigo/TCP.bas` (`Sub Login()` envía `OOLOGI`, `NLOGIN`, `NACCNT`, `ALOGIN`).
- [x] Recepción de `INIAC` y `ADDPJ`.
  - Evidencia: `Cliente/codigo/TCP.bas` (`Case "INIAC"` / `Case "ADDPJ"`).
- [x] `Declares.bas` cliente actualizado con `E_MODO`, `nombrecuent`, `passcuent`, `PJClickeado` y variables `rcv*`.
  - Evidencia: `Cliente/codigo/Declares.bas`.
- [x] Recuperación/cambio de password de cuenta desde cliente.
  - Evidencia:
    - `Cliente/codigo/Cuentas/frmRecuperar.frm` envía `RECCUU` / `REECUU`.
    - `Cliente/codigo/Cuentas/frmCuent.frm` envía `PEDPRE`.
    - `Cliente/codigo/Cuentas/frmBorrar.frm` (form `frmCambiarPass`) envía `REPASS`.

## 🎉 Estado Final: COMPLETADO

El sistema de cuentas ha sido **completamente implantado** según `Sistemacuentas_implantar.txt`. Todos los requisitos han sido implementados:

- Servidor: Firma de funciones actualizadas, `Case "BORR"` reemplazado, `CuentaExiste` añadida.
- Cliente: Formularios funcionales y paquetes implementados.
- Persistencia: Archivos `.act` gestionados correctamente.
- Seguridad: Validación de un solo PJ por cuenta.

## 📋 Notas de Implementación
- Se ha corregido la llamada a `ConnectUser` para incluir el parámetro `Cuenta`.
- Se ha añadido seguridad para evitar que se logueen dos personajes de la misma cuenta simultáneamente.
- El `Case "BORR"` ahora elimina correctamente el PJ del archivo `.act` y reordena la lista.
- Se mantiene la codificación original incluyendo caracteres `ñ`.
