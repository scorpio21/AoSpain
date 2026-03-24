VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSurfaceManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' [CODE] - AoSpain DX8 Surface Manager
' Basado en el trabajo de Juan Martin Sotuyo Dodero
' Adaptado para DirectX 8 y archivos .png por Gemini CLI

Option Explicit
 
Private Const BYTES_PER_MB As Long = 1048576                        '1Mb = 1024 Kb = 1024 * 1024 bytes = 1048576 bytes
 
Private Type SURFACE_ENTRY_DYN
    fileIndex As Long
    lastAccess As Long
    texture As Direct3DTexture8
    Width As Long
    Height As Long
End Type
 
Private surfaceList() As SURFACE_ENTRY_DYN
Private surfaceCount As Long
 
Private surfaceIndexes() As Long
Private surfaceIndexCount As Long
 
Private D3DDevice As Direct3DDevice8
Private D3DX As D3DX8
 
Private usedBytes As Long
 
Private Declare Function GetTickCount Lib "kernel32" () As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef dest As Any, ByRef source As Any, ByVal byteCount As Long)

Private Sub Class_Initialize()
    usedBytes = 0
    surfaceCount = 0
    surfaceIndexCount = 0
    ReDim surfaceList(0) As SURFACE_ENTRY_DYN
    ReDim surfaceIndexes(0) As Long
End Sub
 
Private Sub Class_Terminate()
    Dim i  As Long
    For i = 0 To surfaceCount - 1
        Set surfaceList(i).texture = Nothing
    Next i
    Erase surfaceList
    Erase surfaceIndexes
End Sub
 
Public Sub Initialize(ByRef D3D_X As D3DX8, ByRef Device As Direct3DDevice8, ByVal RAM_Bytes As Long)
    Set D3DX = D3D_X
    Set D3DDevice = Device
End Sub
 
Public Function GetTexture(ByVal fileIndex As Long, ByRef Width As Long, ByRef Height As Long) As Direct3DTexture8
    Dim index As Long
    index = BinarySearch(fileIndex)
   
    If index < 0 Then
        index = LoadSurface(fileIndex, Not index)
    End If
   
    With surfaceList(surfaceIndexes(index))
        .lastAccess = GetTickCount
        Width = .Width
        Height = .Height
        Set GetTexture = .texture
    End With
End Function
 
Private Function BinarySearch(ByVal fileIndex As Long) As Long
    Dim min As Long, max As Long, mid As Long
    min = 0
    max = surfaceIndexCount - 1
    Do While min <= max
        mid = (min + max) \ 2
        If surfaceList(surfaceIndexes(mid)).fileIndex < fileIndex Then
            min = mid + 1
        ElseIf surfaceList(surfaceIndexes(mid)).fileIndex > fileIndex Then
            max = mid - 1
        Else
            BinarySearch = mid
            Exit Function
        End If
    Loop
    BinarySearch = Not min
End Function
 
Private Function LoadSurface(ByVal fileIndex As Long, ByVal listIndex As Long) As Long
On Error GoTo ErrHandler
 
    Dim newSurface As SURFACE_ENTRY_DYN
    Dim filePath As String
    Dim texInfo As D3DXIMAGE_INFO
   
    ' Buscamos archivo .png (AoSpain DX8 Standard)
    filePath = DirGraficos & CStr(fileIndex) & ".png"
   
    With newSurface
        .fileIndex = fileIndex
        .lastAccess = GetTickCount
       
        ' Cargamos textura DX8 desde PNG
        Set .texture = D3DX.CreateTextureFromFileEx(D3DDevice, filePath, D3DX_DEFAULT, D3DX_DEFAULT, _
                        D3DX_DEFAULT, 0, D3DFMT_A8R8G8B8, D3DPOOL_MANAGED, D3DX_FILTER_POINT, _
                        D3DX_FILTER_NONE, &HFF000000, texInfo, ByVal 0)
        
        .Width = texInfo.Width
        .Height = texInfo.Height
    End With
   
    Call InsertSurface(newSurface, listIndex)
    
    ' Simulacion de uso de memoria (aproximado 4 bytes por pixel en A8R8G8B8)
    usedBytes = usedBytes + (newSurface.Width * newSurface.Height * 4)
   
    Dim removedFile As Integer
    Do While usedBytes > BYTES_PER_MB * 64 And surfaceCount > 1
        removedFile = RemoveLRU
        If removedFile = 0 Then
            Exit Do
        ElseIf removedFile < listIndex Then
            listIndex = listIndex - 1
        End If
    Loop
   
    LoadSurface = listIndex
Exit Function
 
ErrHandler:
    ' Si no existe PNG, podriamos intentar BMP como fallback (opcional)
    MsgBox "Error al cargar grafico " & filePath & ". " & Err.Description, vbCritical
    End
End Function
 
Private Sub InsertSurface(ByRef Surface As SURFACE_ENTRY_DYN, ByVal listIndex As Long)
On Error GoTo ErrHandler
    Dim i As Long
    For i = 0 To surfaceCount - 1
        If surfaceList(i).texture Is Nothing Then Exit For
    Next i
    If i = surfaceCount Then
        ReDim Preserve surfaceList(surfaceCount) As SURFACE_ENTRY_DYN
        surfaceCount = surfaceCount + 1
    End If
    surfaceList(i) = Surface
    ReDim Preserve surfaceIndexes(surfaceIndexCount) As Long
    If surfaceIndexCount > listIndex Then
        Dim tempList() As Long
        ReDim tempList(surfaceIndexCount - listIndex) As Long
        CopyMemory tempList(0), surfaceIndexes(listIndex), (surfaceIndexCount - listIndex) * 4
        surfaceIndexes(listIndex) = i
        CopyMemory surfaceIndexes(listIndex + 1), tempList(0), (surfaceIndexCount - listIndex) * 4
    Else
        surfaceIndexes(listIndex) = i
    End If
    surfaceIndexCount = surfaceIndexCount + 1
Exit Sub
ErrHandler:
    End
End Sub
 
Private Function RemoveLRU() As Integer
    Dim LRU As Long, i As Long
    If surfaceCount = 0 Then Exit Function
    LRU = 0
    For i = 1 To surfaceIndexCount - 1
        If surfaceList(surfaceIndexes(LRU)).lastAccess > surfaceList(surfaceIndexes(i)).lastAccess Then
            LRU = i
        End If
    Next i
    RemoveLRU = LRU
    usedBytes = usedBytes - (surfaceList(surfaceIndexes(LRU)).Width * surfaceList(surfaceIndexes(LRU)).Height * 4)
    Set surfaceList(surfaceIndexes(LRU)).texture = Nothing
    surfaceList(surfaceIndexes(LRU)).fileIndex = 0
    If LRU < surfaceIndexCount - 1 Then
        CopyMemory surfaceIndexes(LRU), surfaceIndexes(LRU + 1), (surfaceIndexCount - LRU - 1) * 4
    End If
    ReDim Preserve surfaceIndexes(surfaceIndexCount - 1) As Long
    surfaceIndexCount = surfaceIndexCount - 1
End Function
