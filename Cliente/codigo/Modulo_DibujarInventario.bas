Attribute VB_Name = "DibujarInventario"
'Argentum Online 0.9.0.9
'
'Copyright (C) 2002 Marquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
'Copyright (C) 2002 Mataas Fernando Pequeao
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the GNU General Public License as published by
'the Free Software Foundation; either version 2 of the License, or
'any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'GNU General Public License for more details.
'
'You should have received a copy of the GNU General Public License
'along with this program; if not, write to the Free Software
'Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 namero 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'Cadigo Postal 1900
'Pablo Ignacio Marquez



Option Explicit

'[CODE]:MatuX
'
'  Casi todo recodeado menos los calculos
'
'[END]'

Public Const XCantItems = 5

Public OffsetDelInv As Long
Public ItemElegido As Long
Public mx As Long
Public my As Long

' [CODE] - AoSpain DX8 Inventory Rendering
' Private AuxSurface   As DirectDrawSurface7
' Private BoxSurface   As DirectDrawSurface7
' Private SelSurface   As DirectDrawSurface7
Private bStaticInit  As Boolean   'Se inicializaron las Statics?
Private r1           As RECT, r2 As RECT, auxr As RECT
Private rBox         As RECT  'Pos del cuadradito rojo
Private rBoxFrame(2) As RECT
Private iFrameMod    As Integer


Function ClicEnItemElegido(x As Integer, Y As Integer) As Boolean
bInvMod = True
mx = x \ 32 + 1
my = Y \ 32 + 1
If ItemElegido = 0 Or FLAGORO Then
    ClicEnItemElegido = False
Else
    ClicEnItemElegido = (UserInventory(ItemElegido).OBJIndex > 0) And (ItemElegido = (mx + (my - 1) * 5) + OffsetDelInv)
End If
End Function

Sub ItemClick(x As Integer, Y As Integer)
Dim lPreItem As Long

bInvMod = False
mx = x \ 32 + 1
my = Y \ 32 + 1

lPreItem = (mx + (my - 1) * 5) + OffsetDelInv

If lPreItem <= MAX_INVENTORY_SLOTS Then _
If UserInventory(lPreItem).GrhIndex > 0 Then _
    ItemElegido = lPreItem: bInvMod = True
End Sub

'[CODE]:MatuX'
Public Sub DibujarInvBox()
    On Error Resume Next
    If bStaticInit And ItemElegido <> 0 Then
        Call BoxSurface.BltColorFill(auxr, vbBlack)
        Call BoxSurface.BltFast(0, 0, SelSurface, auxr, DDBLTFAST_SRCCOLORKEY)
        
        'inline hardcoded DDrawTransGrhToSurface()
       '{
        With Grh(1)
            '.FrameCounter = .FrameCounter + iFrameMod
            'If (.FrameCounter >= GrhData(.GrhIndex).NumFrames) Then
            '    iFrameMod = -1
            'ElseIf (.FrameCounter <= 1) Then
            '    iFrameMod = 1
            'End If
            .FrameCounter = 2
            Call BoxSurface.BltFast(0, 0, SurfaceDB(GrhData(GrhData(.GrhIndex).Frames(.FrameCounter)).FileNum), rBoxFrame(.FrameCounter - 1), DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT)
        End With
       '}
        Call BoxSurface.BltToDC(frmMain.picInv.Hdc, auxr, rBox)
        Call frmMain.picInv.Refresh
    End If
End Sub
'[END]'

Sub DibujarInv()
' [CODE] - AoSpain DX8: Renderizado de Inventario acelerado por hardware
On Error Resume Next

Dim iX As Integer
Dim ScreenX As Integer
Dim ScreenY As Integer
Dim tempGrh As Grh

' Inicio de escena sobre el PictureBox del inventario
' Nota: picInv debe tener AutoRedraw = False para DX8
If Not engine.Device_Begin_Scene(frmMain.picInv.hWnd) Then Exit Sub

ScreenX = 0
ScreenY = 0

For iX = OffsetDelInv + 1 To UBound(UserInventory)
    If UserInventory(iX).GrhIndex > 0 Then
        ' Dibujamos el Item
        Call InitGrh(tempGrh, UserInventory(iX).GrhIndex, 0)
        Call engine.Draw_Grh(tempGrh, ScreenX * 32, ScreenY * 32, 0, 1)

        ' Dibujamos la cantidad
        If UserInventory(iX).Amount > 1 Then
            Call engine.Text_Render(ScreenX * 32, ScreenY * 32, CStr(UserInventory(iX).Amount), vbWhite)
        End If

        ' Indicador de Equipado (+)
        If UserInventory(iX).Equipped Then
            Call engine.Text_Render(ScreenX * 32 + 20, ScreenY * 32 + 20, "+", vbYellow)
        End If

        ' Recuadro de Selección (Item Elegido)
        If ItemElegido = iX Then
            ' Por ahora el motor DX8 gestiona la selección visual mediante lógica de mouse o resaltado
        End If
    End If

    ' Incrementamos posiciones de la rejilla (5xN)
    ScreenX = ScreenX + 1
    If ScreenX >= 5 Then
        ScreenX = 0
        ScreenY = ScreenY + 1
    End If
    
    ' Límite visual del PictureBox
    If ScreenY >= 5 Then Exit For
Next iX

' Fin de escena y presentación
engine.Device_End_Scene
engine.Device_Present(frmMain.picInv.hWnd)

bInvMod = False

If ItemElegido = 0 Then
    Call ItemClick(2, 2)
End If

End Sub

Private Sub InitMem()
    Dim ddck        As DDCOLORKEY
    Dim SurfaceDesc As DDSURFACEDESC2
    
    'Back Buffer Surface
    r1.Right = 32: r1.Bottom = 32
    r2.Right = 32: r2.Bottom = 32
    
    With SurfaceDesc
        .lFlags = DDSD_CAPS Or DDSD_HEIGHT Or DDSD_WIDTH
        .ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN Or DDSCAPS_SYSTEMMEMORY
        .lHeight = r1.Bottom
        .lWidth = r1.Right
    End With

    ' Create surface
    Set AuxSurface = DirectDraw.CreateSurface(SurfaceDesc)
    Set BoxSurface = DirectDraw.CreateSurface(SurfaceDesc)
    Set SelSurface = DirectDraw.CreateSurface(SurfaceDesc)

    'Set color key
    AuxSurface.SetColorKey DDCKEY_SRCBLT, ddck
    BoxSurface.SetColorKey DDCKEY_SRCBLT, ddck
    SelSurface.SetColorKey DDCKEY_SRCBLT, ddck

    auxr.Right = 32: auxr.Bottom = 32

    AuxSurface.SetFontTransparency True
    AuxSurface.SetFont frmMain.Font
    SelSurface.SetFontTransparency True
    SelSurface.SetFont frmMain.Font

    'RedBox Frame Position List
    With rBoxFrame(0): .Left = 0:  .Top = 0: .Right = 32: .Bottom = 32: End With
    With rBoxFrame(1): .Left = 32: .Top = 0: .Right = 64: .Bottom = 32: End With
    With rBoxFrame(2): .Left = 64: .Top = 0: .Right = 96: .Bottom = 32: End With
    iFrameMod = 1

    bStaticInit = True
End Sub

