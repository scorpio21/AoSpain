# Repaso para Mañana - AoSpain

## ✅ Estado Actual (Commit ce4344d)
- **Arquitectura:** Migración base a 32-bit (Long) realizada.
- **Servidor:** Lógica original 100% restaurada (facciones, razas, logs intactos).
- **Cliente:** Versión estable en DirectX 7.
- **GitHub:** Sincronizado y limpio.

## 🚀 Pendientes
1. *mejora carga de mapas es muy lenta.
```powershell
	Sub CargarBackUp_Nuevo2()

'Call LogTarea("Sub CargarBackUp")

If frmMain.Visible Then frmMain.txStatus.Caption = "Cargando backup."

Dim Map As Integer
Dim LoopC As Integer
Dim X As Integer
Dim Y As Integer
Dim DummyInt As Integer
Dim TempInt As Integer
Dim SaveAs As String
Dim npcfile As String
Dim Porc As Long
Dim FileNamE As String
Dim c$
    
On Error GoTo man

 
NumMaps = val(GetVar(DatPath & "Map.dat", "INIT", "NumMaps"))
frmCargando.cargar.Min = 0
frmCargando.cargar.max = NumMaps
frmCargando.cargar.Value = 0

MapPath = GetVar(DatPath & "Map.dat", "INIT", "MapPath")

ReDim MapData(1 To NumMaps, XMinMapSize To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock
ReDim MapInfo(1 To NumMaps) As MapInfo

Dim buffer(1 To ((YMaxMapSize - YMinMapSize + 1) * (XMaxMapSize - XMinMapSize + 1))) As TileMap
Dim buffer2(1 To ((YMaxMapSize - YMinMapSize + 1) * (XMaxMapSize - XMinMapSize + 1))) As TileInf
Dim idx As Integer

For Map = 1 To NumMaps
    
    FileNamE = App.Path & "\WorldBackUp\Map" & Map & ".map"
    
    If FileExist(FileNamE, vbNormal) Then
        Open App.Path & "\WorldBackUp\Map" & Map & ".map" For Binary As #1
        Open App.Path & "\WorldBackUp\Map" & Map & ".inf" For Binary As #2
        c$ = App.Path & "\WorldBackUp\Map" & Map & ".dat"
    Else
        Open App.Path & MapPath & "Mapa" & Map & ".map" For Binary As #1
        Open App.Path & MapPath & "Mapa" & Map & ".inf" For Binary As #2
        c$ = App.Path & MapPath & "Mapa" & Map & ".dat"
    End If
    
    Seek #1, 1
    Seek #2, 1
    'map Header
    Get #1, , MapInfo(Map).MapVersion
    Get #1, , MiCabecera
    Get #1, , TempInt
    Get #1, , TempInt
    Get #1, , TempInt
    Get #1, , TempInt
    'inf Header
    Get #2, , TempInt
    Get #2, , TempInt
    Get #2, , TempInt
    Get #2, , TempInt
    Get #2, , TempInt
    'Load arrays
                   
    Get #1, , buffer
    Get #2, , buffer2
    
    
    idx = 1
    For Y = YMinMapSize To YMaxMapSize
        For X = XMinMapSize To XMaxMapSize
            
            MapData(Map, X, Y).Blocked = buffer(idx).bloqueado
            MapData(Map, X, Y).Graphic(1) = buffer(idx).grafs(1)
            MapData(Map, X, Y).Graphic(2) = buffer(idx).grafs(2)
            MapData(Map, X, Y).Graphic(3) = buffer(idx).grafs(3)
            MapData(Map, X, Y).Graphic(4) = buffer(idx).grafs(4)
            MapData(Map, X, Y).trigger = buffer(idx).trigger
            
            MapData(Map, X, Y).TileExit.Map = buffer2(idx).dest_mapa
            MapData(Map, X, Y).TileExit.X = buffer2(idx).dest_x
            MapData(Map, X, Y).TileExit.Y = buffer2(idx).dest_y
            
            MapData(Map, X, Y).NpcIndex = buffer2(idx).npc
            If MapData(Map, X, Y).NpcIndex > 0 Then
                
                If MapData(Map, X, Y).NpcIndex > 499 Then
                        npcfile = DatPath & "NPCs-HOSTILES.dat"
                Else
                        npcfile = DatPath & "NPCs.dat"
                End If
                
                'Si el npc debe hacer respawn en la pos
                'original la guardamos
                If val(GetVar(npcfile, "NPC" & MapData(Map, X, Y).NpcIndex, "PosOrig")) = 1 Then
                    MapData(Map, X, Y).NpcIndex = OpenNPC(MapData(Map, X, Y).NpcIndex)
                    Npclist(MapData(Map, X, Y).NpcIndex).Orig.Map = Map
                    Npclist(MapData(Map, X, Y).NpcIndex).Orig.X = X
                    Npclist(MapData(Map, X, Y).NpcIndex).Orig.Y = Y
                Else
                    MapData(Map, X, Y).NpcIndex = OpenNPC(MapData(Map, X, Y).NpcIndex)
                End If
                
                Npclist(MapData(Map, X, Y).NpcIndex).Pos.Map = Map
                Npclist(MapData(Map, X, Y).NpcIndex).Pos.X = X
                Npclist(MapData(Map, X, Y).NpcIndex).Pos.Y = Y
                
                Call MakeNPCChar(ToNone, 0, 0, MapData(Map, X, Y).NpcIndex, Map, X, Y)
            End If

            If buffer2(idx).obj_ind > 0 And buffer2(idx).obj_ind <= UBound(ObjData) Then
                MapData(Map, X, Y).OBJInfo.ObjIndex = buffer2(idx).obj_ind
                MapData(Map, X, Y).OBJInfo.Amount = buffer2(idx).obj_cant
            Else
                MapData(Map, X, Y).OBJInfo.ObjIndex = 0
                MapData(Map, X, Y).OBJInfo.Amount = 0
            End If
            
            idx = idx + 1
        Next X
    Next Y

    Close #1
    Close #2
    MapInfo(Map).Name = GetVar(c$, "Mapa" & Map, "Name")
    MapInfo(Map).Music = GetVar(c$, "Mapa" & Map, "MusicNum")
'    MapInfo(Map).MinLevel = val(GetVar(c$, "Mapa" & Map, "MinLevel"))
'    MapInfo(Map).PuedeMascotas = CByte(val(GetVar(c$, "Mapa" & Map, "PuedeMascotas")))

'    MapInfo(Map).MagiaSinEfecto = val(GetVar(c$, "Mapa" & Map, "MagiaSinEfecto"))
    Dim tmps As String
    tmps = GetVar(c$, "Mapa" & Map, "StartPos")
If (tmps <> "") Then
    MapInfo(Map).StartPos.Map = val(ReadField(1, tmps, 45))
    MapInfo(Map).StartPos.X = val(ReadField(2, tmps, 45))
    MapInfo(Map).StartPos.Y = val(ReadField(3, tmps, 45))
End If

    If val(GetVar(c$, "Mapa" & Map, "Pk")) = 0 Then
          MapInfo(Map).Pk = True
    Else
          MapInfo(Map).Pk = False
    End If
    MapInfo(Map).Restringir = GetVar(c$, "Mapa" & Map, "Restringir")
    MapInfo(Map).BackUp = val(GetVar(c$, "Mapa" & Map, "BackUp"))
    MapInfo(Map).Terreno = GetVar(c$, "Mapa" & Map, "Terreno")
    MapInfo(Map).Zona = GetVar(c$, "Mapa" & Map, "Zona")
    frmCargando.cargar.Value = frmCargando.cargar.Value + 1
    
    DoEvents
Next Map

FrmStat.Visible = False

Exit Sub

man:
    MsgBox ("Error durante la carga de mapas.")
    Call LogError(Date & " " & Err.Description & " " & Err.HelpContext & " " & Err.HelpFile & " " & Err.Source)

  

End Sub
```text
se puede mejorar este código para que la carga sea mas rápida.
2. **Migración DX8 (Con Cuidado):**
   - Integrar módulos de DX8 uno a uno.
   - NO borrar archivos antiguos hasta que el nuevo motor renderice.
   - Adaptar `TileEngine.bas` y `clsAudio.cls` sin perder lógicas de AoSpain.
3. **Sistema de Cuentas:**
   - Estudiar `Sistemacuentas_implantar.txt`.
   - Implementar la carpeta `Accounts` en el servidor.
   - Cambiar protocolo de Login tradicional por el sistema de multicuentas.

## ⚠️ Lecciones Aprendidas
- No realizar reemplazos masivos en `General.bas` o `FileIO.bas` sin verificar la longitud del archivo para no perder código original.
- Validar los índices de mapas (191/192) para evitar el "Error 9" si el `Map.dat` es corto.
