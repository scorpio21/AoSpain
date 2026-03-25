Attribute VB_Name = "Mod_Wav"
' [CODE] - AoSpain DX8 Audio Module (Refactored)
' Se mantienen las constantes de sonido, pero se anula la lógica DX7.
' El audio ahora es gestionado por el motor DX8 o librerías externas.

Option Explicit

' Constantes de archivos WAV
Public Const SND_CLICK = "click.Wav"
Public Const SND_PASOS1 = "23.Wav"
Public Const SND_PASOS2 = "24.Wav"
Public Const SND_NAVEGANDO = "50.wav"
Public Const SND_OVER = "click2.Wav"
Public Const SND_DICE = "cupdice.Wav"

Public Sub PlayWaveDS(ByVal File As String)
    ' [CODE] - Redirigir a engine.PlayWave o similar en el futuro
    ' Por ahora silenciado para evitar dependencia de DX7VB.DLL
End Sub

' Function LoadWavetoDSBuffer(DS As DirectSound, DSB As DirectSoundBuffer, sFile As String) As Boolean
'     ' Lógica de DX7 eliminada
' End Function
