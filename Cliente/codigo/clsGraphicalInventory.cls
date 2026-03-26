VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGraphicalInventory"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'**************************************************************
' clsGraphicalInventory.cls - Re-implementacion de inventario para DX8
'**************************************************************

Option Explicit

Dim InventoryOffset As Long
'Number of lines we scrolled down from topmost

Dim InvSelectedItem As Long
'Currently selected item

Dim UserInventory(1 To 25) As Inventory    'User's inventory (25 slots)

Dim WithEvents InventoryWindow As PictureBox    'Placeholder where to render the inventory
Attribute InventoryWindow.VB_VarHelpID = -1

Public Property Get SelectedItem() As Long
    SelectedItem = InvSelectedItem
End Property

Public Property Let SelectedItem(ByVal slot As Long)
    InvSelectedItem = slot
End Property

Public Property Get MaxHit(ByVal slot As Long) As Integer
    If slot < 1 Or slot > 25 Then Exit Property
    MaxHit = UserInventory(slot).MaxHit
End Property

Public Property Get MinHit(ByVal slot As Long) As Integer
    If slot < 1 Or slot > 25 Then Exit Property
    MinHit = UserInventory(slot).MinHit
End Property

Public Property Get Def(ByVal slot As Long) As Integer
    If slot < 1 Or slot > 25 Then Exit Property
    Def = UserInventory(slot).Def
End Property

Public Property Get grhindex(ByVal slot As Long) As Long
    If slot < 1 Or slot > 25 Then Exit Property
    grhindex = UserInventory(slot).grhindex
End Property

Public Property Get Valor(ByVal slot As Long) As Long
    If slot < 1 Or slot > 25 Then Exit Property
    Valor = UserInventory(slot).Valor
End Property

Public Property Get Amount(ByVal slot As Long) As Long
    If slot < 1 Or slot > 25 Then Exit Property
    Amount = UserInventory(slot).Amount
End Property

Public Property Get OBJIndex(ByVal slot As Long) As Long
    If slot < 1 Or slot > 25 Then Exit Property
    OBJIndex = UserInventory(slot).OBJIndex
End Property

Public Property Get OBJType(ByVal slot As Long) As Long
    If slot < 1 Or slot > 25 Then Exit Property
    OBJType = UserInventory(slot).OBJType
End Property

Public Property Get ItemName(ByVal slot As Long) As String
    If slot < 1 Or slot > 25 Then Exit Property
    ItemName = UserInventory(slot).Name
End Property

Public Property Get Equipped(ByVal slot As Long) As Byte
    If slot < 1 Or slot > 25 Then Exit Property
    Equipped = UserInventory(slot).Equipped
End Property

'Sets all data for a given inventory slot
Public Sub SetItem(ByVal slot As Long, ByVal OBJIndex As Long, ByVal Name As String, ByVal Amount As Long, ByVal Equipped As Byte, ByVal grhindex As Long, ByVal ObjType As Integer, ByVal MaxHit As Integer, ByVal MinHit As Integer, ByVal Def As Integer, ByVal Valor As Long)
    If slot < 1 Or slot > 25 Then Exit Sub
    
    With UserInventory(slot)
        .OBJIndex = OBJIndex
        .Name = Name
        .Amount = Amount
        .Equipped = Equipped
        .grhindex = grhindex
        .OBJType = ObjType
        .MaxHit = MaxHit
        .MinHit = MinHit
        .Def = Def
        .Valor = Valor
    End With
End Sub

Public Function ClickItem(ByVal x As Integer, ByVal y As Integer) As Long
    Dim temp_x As Long
    Dim temp_y As Long
    Dim TempItem As Long
    
    temp_x = x \ 32
    temp_y = y \ 32
    
    TempItem = temp_x + (temp_y + InventoryOffset) * (InventoryWindow.ScaleWidth \ 32) + 1
    
    If TempItem <= 25 Then
        ClickItem = TempItem
    End If
End Function

Public Sub SelectGold()
    InvSelectedItem = 777 ' FLAGORO
End Sub

Public Sub DrawInventory()
    Dim i As Long
    Dim x As Long
    Dim y As Long
    
    'Bucle de dibujo del inventario sobre el PictureBox usando el motor DX8
    For i = 1 To 25
        If UserInventory(i).grhindex Then
            x = ((i - 1) Mod (InventoryWindow.ScaleWidth \ 32)) * 32
            y = ((i - 1) \ (InventoryWindow.ScaleWidth \ 32)) * 32
            
            ' Dibuja el item usando el motor DX8
            ' NOTA: En DX8 el dibujo es sobre el dispositivo, no sobre el DC del picturebox
            ' Pero usamos las coordenadas relativas al picturebox
            
            ' Renderizado de item
            Call engine.Device_Box_Textured_Render(UserInventory(i).grhindex, x + InventoryWindow.Left, y + InventoryWindow.Top, 32, 32, 0, 0, False)
            
        End If
    Next i
End Sub

Public Sub InitializeInvent(ByRef InvPic As PictureBox)
    'Asociar el PictureBox del formulario
    Set InventoryWindow = InvPic
    
    'Configurar PictureBox para que no interfiera con DX8 pero mantenga el hWnd
    InventoryWindow.AutoRedraw = False
    InventoryWindow.ScaleMode = 3 'Pixel
    
    InvSelectedItem = 1
End Sub

Private Sub InventoryWindow_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    'Gestionar click en el inventario
    If x < 0 Or y < 0 Or x > InventoryWindow.ScaleWidth Or y > InventoryWindow.ScaleHeight Then Exit Sub
    
    InvSelectedItem = ClickItem(CInt(x), CInt(y))
    
    'Actualizar visualmente tras el click
    ' En DX8, el MainLoop redibuja todo, asique no hace falta forzar aqui
End Sub
