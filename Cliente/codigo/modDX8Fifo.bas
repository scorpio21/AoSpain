Attribute VB_Name = "modDX8Fifo"
Option Explicit



Sub CargarCabezas()
    Dim N As Integer
    Dim i As Long
    Dim Numheads As Integer
    Dim Miscabezas() As tIndiceCabeza
    
    N = FreeFile()
    Open App.path & "\init\Cabezas.ind" For Binary Access Read As #N
    
    'cabecera
    Get #N, , MiCabecera
    
    'num de cabezas
    Get #N, , Numheads
    
    'Resize array
    ReDim HeadData(0 To Numheads) As HeadData
    ReDim Miscabezas(0 To Numheads) As tIndiceCabeza
    
    For i = 1 To Numheads
        Get #N, , Miscabezas(i)
        
        If Miscabezas(i).head(1) Then
            Call InitGrh(HeadData(i).head(1), Miscabezas(i).head(1), 0)
            Call InitGrh(HeadData(i).head(2), Miscabezas(i).head(2), 0)
            Call InitGrh(HeadData(i).head(3), Miscabezas(i).head(3), 0)
            Call InitGrh(HeadData(i).head(4), Miscabezas(i).head(4), 0)
        End If
    Next i
    
    Close #N
End Sub

Sub CargarCascos()
    Dim N As Integer
    Dim i As Long
    Dim NumCascos As Integer

    Dim Miscabezas() As tIndiceCabeza
    
    N = FreeFile()
    Open App.path & "\init\Cascos.ind" For Binary Access Read As #N
    
    'cabecera
    Get #N, , MiCabecera
    
    'num de cabezas
    Get #N, , NumCascos
    
    'Resize array
    ReDim CascoAnimData(0 To NumCascos) As HeadData
    ReDim Miscabezas(0 To NumCascos) As tIndiceCabeza
    
    For i = 1 To NumCascos
        Get #N, , Miscabezas(i)
        
        If Miscabezas(i).head(1) Then
            Call InitGrh(CascoAnimData(i).head(1), Miscabezas(i).head(1), 0)
            Call InitGrh(CascoAnimData(i).head(2), Miscabezas(i).head(2), 0)
            Call InitGrh(CascoAnimData(i).head(3), Miscabezas(i).head(3), 0)
            Call InitGrh(CascoAnimData(i).head(4), Miscabezas(i).head(4), 0)
        End If
    Next i
    
    Close #N
End Sub

Sub CargarCuerpos()
    Dim N As Integer
    Dim i As Long
    Dim NumCuerpos As Integer
    Dim MisCuerpos() As tIndiceCuerpo
    
    N = FreeFile()
    Open App.path & "\init\Personajes.ind" For Binary Access Read As #N
    
    'cabecera
    Get #N, , MiCabecera
    
    'num de cabezas
    Get #N, , NumCuerpos
    
    'Resize array
    ReDim BodyData(0 To NumCuerpos) As BodyData
    ReDim MisCuerpos(0 To NumCuerpos) As tIndiceCuerpo
    
    For i = 1 To NumCuerpos
        Get #N, , MisCuerpos(i)
        
        If MisCuerpos(i).body(1) Then
            InitGrh BodyData(i).Walk(1), MisCuerpos(i).body(1), 0
            InitGrh BodyData(i).Walk(2), MisCuerpos(i).body(2), 0
            InitGrh BodyData(i).Walk(3), MisCuerpos(i).body(3), 0
            InitGrh BodyData(i).Walk(4), MisCuerpos(i).body(4), 0
            
            BodyData(i).HeadOffset.X = MisCuerpos(i).HeadOffsetX
            BodyData(i).HeadOffset.Y = MisCuerpos(i).HeadOffsetY
        End If
    Next i
    
    Close #N
End Sub

Sub CargarFxs()
    Dim N As Integer
    Dim i As Long
    Dim NumFxs As Integer
    
    N = FreeFile()
    Open App.path & "\init\Fxs.ind" For Binary Access Read As #N
    
    'cabecera
    Get #N, , MiCabecera
    
    'num de cabezas
    Get #N, , NumFxs
    
    'Resize array
    ReDim FxData(1 To NumFxs) As tIndiceFx
    
    For i = 1 To NumFxs
        Get #N, , FxData(i)
    Next i
    
    Close #N
End Sub

Sub CargarTips()
    Dim N As Integer
    Dim i As Long
    Dim NumTips As Integer
    
    N = FreeFile
    Open App.path & "\init\Tips.ayu" For Binary Access Read As #N
    
    'cabecera
    Get #N, , MiCabecera
    
    'num de cabezas
    Get #N, , NumTips
    
    'Resize array
    ReDim Tips(1 To NumTips) As String * 255
    
    For i = 1 To NumTips
        Get #N, , Tips(i)
    Next i
    
    Close #N
End Sub

Sub CargarArrayLluvia()
    Dim N As Integer
    Dim i As Long
    Dim Nu As Integer
    
    N = FreeFile()
    Open App.path & "\init\fk.ind" For Binary Access Read As #N
    
    'cabecera
    Get #N, , MiCabecera
    
    'num de cabezas
    Get #N, , Nu
    
    'Resize array
    ReDim bLluvia(1 To Nu) As Byte
    
    For i = 1 To Nu
        Get #N, , bLluvia(i)
    Next i
    
    Close #N
End Sub

Public Sub CargarDatos()
    '**************************************************************
    ' Centraliza la carga de todos los datos del juego
    '**************************************************************
    On Error Resume Next
    Call LoadGrhData
    Call CargarCabezas
    Call CargarCascos
    Call CargarCuerpos
    Call CargarFxs
    Call CargarTips
    Call CargarArrayLluvia
End Sub

Public Function LoadGrhData() As Boolean
'**************************************************************
' Author: Gemini CLI (Adaptado para AoSpain 32-bit)
' Last Modify Date: 25/03/2026
'**************************************************************
On Error GoTo ErrorHandler
    Dim Grh As Long
    Dim Frame As Long
    Dim handle As Integer
    Dim tempint As Integer
    
    ' Resize arrays al limite maximo (Config_Inicio.NumeroDeBMPs o 32000)
    ' Usamos 32000 como base o lo que diga el .ini
    ReDim GrhData(1 To 32000) As GrhData
    
    ' Open files
    handle = FreeFile()
    Open App.path & "\init\Graficos.ind" For Binary Access Read As #handle
    Seek #handle, 1
    
    ' Leer Cabecera (MiCabecera es global en Declares.bas)
    Get #handle, , MiCabecera
    
    ' Saltamos los 5 integers de relleno del formato original
    Get #handle, , tempint: Get #handle, , tempint: Get #handle, , tempint
    Get #handle, , tempint: Get #handle, , tempint
    
    ' Leer primer numero de Grh
    Get #handle, , Grh
    
    Do Until Grh <= 0
        With GrhData(Grh)
            ' Get number of frames
            Get #handle, , .NumFrames
            If .NumFrames <= 0 Then GoTo ErrorHandler
            
            ' Redimensionar matriz de frames
            ReDim .Frames(1 To .NumFrames)
            
            If .NumFrames > 1 Then
                ' Es una animacion
                For Frame = 1 To .NumFrames
                    Get #handle, , .Frames(Frame)
                    If .Frames(Frame) <= 0 Or .Frames(Frame) > 32000 Then
                        GoTo ErrorHandler
                    End If
                Next Frame
                
                Get #handle, , .Speed
                If .Speed <= 0 Then GoTo ErrorHandler
                
                ' Las dimensiones se calculan en la segunda pasada
            Else
                ' Es un GRH simple
                Get #handle, , .FileNum
                If .FileNum <= 0 Then GoTo ErrorHandler
                
                Get #handle, , .sX
                If .sX < 0 Then GoTo ErrorHandler
                
                Get #handle, , .sY
                If .sY < 0 Then GoTo ErrorHandler
                
                Get #handle, , .pixelWidth
                If .pixelWidth <= 0 Then GoTo ErrorHandler
                
                Get #handle, , .pixelHeight
                If .pixelHeight <= 0 Then GoTo ErrorHandler
                
                ' Calcular tiles (32x32 px)
                .TileWidth = .pixelWidth / 32
                .TileHeight = .pixelHeight / 32
                
                ' El frame 1 es el propio Grh
                .Frames(1) = Grh
            End If
        End With
        
        ' Leer siguiente numero de Grh
        Get #handle, , Grh
    Loop
    
    Close #handle
    
    ' Segunda pasada: Calcular dimensiones para animaciones
    For Grh = 1 To 32000
        If GrhData(Grh).NumFrames > 1 Then
            Dim firstFrame As Long
            firstFrame = GrhData(Grh).Frames(1)
            If firstFrame > 0 And firstFrame <= 32000 Then
                GrhData(Grh).pixelWidth = GrhData(firstFrame).pixelWidth
                GrhData(Grh).pixelHeight = GrhData(firstFrame).pixelHeight
                GrhData(Grh).TileWidth = GrhData(firstFrame).TileWidth
                GrhData(Grh).TileHeight = GrhData(firstFrame).TileHeight
            End If
        End If
    Next Grh
    
    LoadGrhData = True
Exit Function

ErrorHandler:
    Close #handle
    LoadGrhData = False
End Function

