Es largo, así que bueno empiezo...
Cliente:
el contenido esta en e:\xampp\htdocs\AoSpain\Sistemadecuentas\

Y agregan en su proyecto, y los gráficos en la carpeta /Graficos/principal
Graficos y formulario y modulo agregado ya al aospain
slo queda la implantación del código

Van al frmmain
Abajo del todo ponen
Visual Basic:
Private Sub Socket1_Connect()
    Dim ServerIp As String
    Dim Temporal1 As Long
    Dim Temporal As Long
   
   
    ServerIp = Socket1.PeerAddress
    Temporal = InStr(1, ServerIp, ".")
    Temporal1 = ((mid$(ServerIp, 1, Temporal - 1) Xor &H65) And &H7F) * 16777216
    ServerIp = mid$(ServerIp, Temporal + 1, Len(ServerIp))
    Temporal = InStr(1, ServerIp, ".")
    Temporal1 = Temporal1 + (mid$(ServerIp, 1, Temporal - 1) Xor &HF6) * 65536
    ServerIp = mid$(ServerIp, Temporal + 1, Len(ServerIp))
    Temporal = InStr(1, ServerIp, ".")
    Temporal1 = Temporal1 + (mid$(ServerIp, 1, Temporal - 1) Xor &H4B) * 256
    ServerIp = mid$(ServerIp, Temporal + 1, Len(ServerIp)) Xor &H42
    MixedKey = (Temporal1 + ServerIp)
   
    Second.Enabled = True
   
    'If frmCrearPersonaje.Visible Then
    If EstadoLogin = E_MODO.CrearNuevoPj Then
        Call Login
 
    ElseIf EstadoLogin = E_MODO.Normal Then
        Call Login
 
    ElseIf EstadoLogin = E_MODO.Dados Then
   frmCrearPersonaje.Show vbModal
   
   ElseIf EstadoLogin = E_MODO.CrearAccount Then
   frmCrearAccount.Show vbModal
   
   ElseIf EstadoLogin = E_MODO.LoginAccount Then
   Call Login
   
   ElseIf EstadoLogin = E_MODO.BorrarPj Then
   Call Login
 
    End If
End Sub
 
Private Sub Socket1_Disconnect()
    Dim I As Long
    
    
    Second.Enabled = False
    logged = False
    Connected = False
    
    Socket1.Cleanup
    
    frmConnect.MousePointer = vbNormal
    
    If frmCrearPersonaje.Visible = True Then frmConnect.Visible = True
    
    On Local Error Resume Next
    For I = 0 To Forms.Count - 1
        If Forms(I).Name <> Me.Name And Forms(I).Name <> frmConnect.Name Then
            Unload Forms(I)
        End If
    Next I
    On Local Error GoTo 0
    
    frmMain.Visible = False
 
    pausa = False
    UserMeditar = False
    
#If SegudidadAlkon Then
    LOGGING = False
    LOGSTRING = False
    LastPressed = 0
    LastMouse = False
    LastAmount = 0
#End If
 
    UserClase = ""
    UserSexo = ""
    UserRaza = ""
    UserEmail = ""
    
    For I = 1 To NUMSKILLS
        UserSkills(I) = 0
    Next I
 
    For I = 1 To NUMATRIBUTOS
        UserAtributos(I) = 0
    Next I
 
    SkillPoints = 0
    Alocados = 0
 
End Sub
 
Private Sub Socket1_LastError(ErrorCode As Integer, ErrorString As String, Response As Integer)
    '*********************************************
    'Handle socket errors
    '*********************************************
    If ErrorCode = 24036 Then
    frmMensaje.Show
        frmMensaje.msg.Caption = "Por favor espere, intentando completar conexion."
        Exit Sub
    End If
    frmMensaje.Show
    frmMensaje.msg.Caption = "Conexión rechazada por el Servidor"
    frmConnect.MousePointer = 1
    Response = 0
 
    Second.Enabled = False
 
    frmMain.Socket1.Disconnect
    
    If frmConnect.Visible Then
        frmConnect.Visible = False
    End If
 
    If Not frmCrearPersonaje.Visible Then
        If Not frmCambiarPass.Visible Then
            frmConnect.Show
        End If
    Else
        frmCrearPersonaje.MousePointer = 0
    End If
End Sub
Si ya los tienen, los reemplazan
Si no tienen el Socket1 creado en el Frmmain, lo crean

Y esto seguro que ya lo tienen, entonces los reemplazan (Abajo del todo el frmmain)
Visual Basic:
'
' -------------------
'    W I N S O C K
' -------------------
'
 
#If UsarWrench <> 1 Then
 
Private Sub Winsock1_Close()
    Dim I As Long
    
    Debug.Print "WInsock Close"
    
    LastSecond = 0
    Second.Enabled = False
    logged = False
    Connected = False
    
    If Winsock1.State <> sckClosed Then _
        Winsock1.Close
    
    frmConnect.MousePointer = vbNormal
    
    If frmPasswdSinPadrinos.Visible = True Then frmPasswdSinPadrinos.Visible = False
    frmCrearPersonaje.Visible = False
    frmConnect.Visible = True
    
    On Local Error Resume Next
    For I = 0 To Forms.Count - 1
        If Forms(I).Name <> Me.Name And Forms(I).Name <> frmConnect.Name Then
            Unload Forms(I)
        End If
    Next I
    On Local Error GoTo 0
    
    frmMain.Visible = False
 
    pausa = False
    UserMeditar = False
 
    UserClase = ""
    UserSexo = ""
    UserRaza = ""
    UserEmail = ""
    
    For I = 1 To NUMSKILLS
        UserSkills(I) = 0
    Next I
 
    For I = 1 To NUMATRIBUTOS
        UserAtributos(I) = 0
    Next I
 
    SkillPoints = 0
    Alocados = 0
 
    Dialogos.UltimoDialogo = 0
    Dialogos.CantidadDialogos = 0
End Sub
 
Private Sub Winsock1_Connect()
    Dim ServerIp As String
    Dim Temporal1 As Long
    Dim Temporal As Long
   
    Debug.Print "Winsock Connect"
   
    ServerIp = Winsock1.RemoteHostIP
    Temporal = InStr(1, ServerIp, ".")
    Temporal1 = ((mid$(ServerIp, 1, Temporal - 1) Xor &H65) And &H7F) * 16777216
    ServerIp = mid$(ServerIp, Temporal + 1, Len(ServerIp))
    Temporal = InStr(1, ServerIp, ".")
    Temporal1 = Temporal1 + (mid$(ServerIp, 1, Temporal - 1) Xor &HF6) * 65536
    ServerIp = mid$(ServerIp, Temporal + 1, Len(ServerIp))
    Temporal = InStr(1, ServerIp, ".")
    Temporal1 = Temporal1 + (mid$(ServerIp, 1, Temporal - 1) Xor &H4B) * 256
    ServerIp = mid$(ServerIp, Temporal + 1, Len(ServerIp)) Xor &H42
    MixedKey = (Temporal1 + ServerIp)
   
    Second.Enabled = True
   
    'If frmCrearPersonaje.Visible Then
    If EstadoLogin = E_MODO.CrearNuevoPj Then
        Call Login
 
    ElseIf EstadoLogin = E_MODO.Normal Then
        Call Login
 
    ElseIf EstadoLogin = E_MODO.Dados Then
   frmCrearPersonaje.Show vbModal
   
   ElseIf EstadoLogin = E_MODO.CrearAccount Then
   frmCrearAccount.Show vbModal
   
   ElseIf EstadoLogin = E_MODO.LoginAccount Then
   Call Login
   
   ElseIf EstadoLogin = E_MODO.BorrarPj Then
   Call Login
 
    End If
End Sub
 
Private Sub Winsock1_DataArrival(ByVal BytesTotal As Long)
    Dim LoopC As Integer
 
    Dim RD As String
    Dim rBuffer(1 To 500) As String
    Static TempString As String
 
    Dim CR As Integer
    Dim tChar As String
    Dim sChar As Integer
    Dim Echar As Integer
    Dim aux$
    Dim nfile As Integer
 
    Debug.Print "Winsock DataArrival"
    
    'Socket1.Read RD, DataLength
    Winsock1.GetData RD
 
    'Check for previous broken data and add to current data
    If TempString <> "" Then
        RD = TempString & RD
        TempString = ""
    End If
 
    'Check for more than one line
    sChar = 1
    For LoopC = 1 To Len(RD)
 
        tChar = mid$(RD, LoopC, 1)
 
        If tChar = ENDC Then
            CR = CR + 1
            Echar = LoopC - sChar
            rBuffer(CR) = mid$(RD, sChar, Echar)
            sChar = LoopC + 1
        End If
 
    Next LoopC
 
    'Check for broken line and save for next time
    If Len(RD) - (sChar - 1) <> 0 Then
        TempString = mid$(RD, sChar, Len(RD))
    End If
 
    'Send buffer to Handle data
    For LoopC = 1 To CR
        Call HandleData(rBuffer(LoopC))
    Next LoopC
End Sub
 
Private Sub Winsock1_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
    '*********************************************
    'Handle socket errors
    '*********************************************
    frmMensaje.Show
    frmMensaje.msg.Caption = Description
    frmConnect.MousePointer = 1
    LastSecond = 0
    Second.Enabled = False
 
    If Winsock1.State <> sckClosed Then _
        Winsock1.Close
    
    If frmOldPersonaje.Visible Then
        frmOldPersonaje.Visible = False
    End If
 
    If Not frmCrearPersonaje.Visible Then
        If Not frmCambiarPass.Visible Then
            frmConnect.Show
        End If
    Else
        frmCrearPersonaje.MousePointer = 0
    End If
End Sub
 
#End If
Buscar
Visual Basic:
'User status vars
Global OtroInventario(1 To MAX_INVENTORY_SLOTS) As Inventory
Arriba
Visual Basic:
Public MixedKey As Long

Buscar
Visual Basic:
Function CheckUserData(ByVal checkemail As Boolean) As Boolean

Reemplazar todo por
Visual Basic:
Function CheckUserData(ByVal checkemail As Boolean) As Boolean
    'Validamos los datos del user
    Dim LoopC As Long
    Dim CharAscii As Integer
    
    If checkemail And UserEmail = "" Then
        frmMensaje.Show
        frmMensaje.msg.Caption = ("Dirección de email invalida")
        Exit Function
    End If
    
    For LoopC = 1 To Len(UserPassword)
        CharAscii = Asc(mid$(UserPassword, LoopC, 1))
        If Not LegalCharacter(CharAscii) Then
            MsgBox ("Password inválido. El caractér " & Chr$(CharAscii) & " no está permitido.")
            Exit Function
        End If
    Next LoopC
    
    If nombrecuent = "" Then
        Call MsgBox("Ingrese un nombre de cuenta.")
        Exit Function
    End If
    
    If UserPassword = "" Then
        Call MsgBox("Ingrese un password.")
        Exit Function
    End If
    If Len(nombrecuent) > 30 Then
        Call MsgBox("La cuenta debe tener menos de 30 letras.")
        Exit Function
    End If
    
    For LoopC = 1 To Len(nombrecuent)
        CharAscii = Asc(mid$(nombrecuent, LoopC, 1))
        If Not LegalCharacter(CharAscii) Then
            Call MsgBox("Cuenta inválida. El caractér " & Chr$(CharAscii) & " no está permitido.")
            Exit Function
        End If
    Next LoopC
    
    CheckUserData = True
End Function
Van al frmconnect
Y el image que tiene para crear personaje (Seria el case 0)
reemplazar todo por
Visual Basic:
        
       EstadoLogin = CrearAccount
#If UsarWrench = 1 Then
       If frmMain.Socket1.Connected Then
            frmMain.Socket1.Disconnect
            frmMain.Socket1.Cleanup
            DoEvents
        End If
        frmMain.Socket1.HostAddress = CurServerIp
        frmMain.Socket1.RemotePort = CurServerPort
        frmMain.Socket1.Connect
#Else
        If frmMain.Winsock1.State <> sckClosed Then
            frmMain.Winsock1.Close
            DoEvents
        End If
        frmMain.Winsock1.Connect CurServerIp, CurServerPort
#End If
 
        
 
Y el image que tienen para loguear ponen (Sería el Case 1 del index del image)
Visual Basic:
        
    Case 1
        nombrecuent = NameTxt.Text
        passcuent = PasswordTxt.Text
#If UsarWrench = 1 Then
        If frmMain.Socket1.Connected Then
        frmMain.Socket1.Disconnect
        frmMain.Socket1.Cleanup
        DoEvents
        End If
#Else
        If frmMain.Winsock1.State <> sckClosed Then _
            frmMain.Winsock1.Close
#End If
      '  If frmConnect.MousePointer = 99 Then
      '      Exit Sub
     '   End If
        
        
        'update user info
        nombrecuent = NameTxt.Text
        Dim aux As String
        aux = PasswordTxt.Text
#If SeguridadAlkon Then
        UserPassword = md5.GetMD5String(aux)
        Call md5.MD5Reset
#Else
        UserPassword = aux
#End If
        If CheckUserData(False) = True Then
            EstadoLogin = LoginAccount
            Me.MousePointer = 99
#If UsarWrench = 1 Then
            frmMain.Socket1.HostAddress = CurServerIp
            frmMain.Socket1.RemotePort = CurServerPort
            frmMain.Socket1.Connect
    
#Else
            'If frmMain.Winsock1.State <> sckClosed Then _
               ' frmMain.Winsock1.Close
            frmMain.Winsock1.Connect CurServerIp, CurServerPort
#End If
 
        End If
        
 
End Select
Exit Sub
 
En el frmconnect crean un image con name
Image2
Y dentro ponen
Visual Basic:
Private Sub Image2_Click()
            frmMain.Socket1.HostAddress = CurServerIp
            frmMain.Socket1.RemotePort = CurServerPort
            frmMain.Socket1.Connect
            
            
            frmRecuperar.Visible = True
 
End Sub

Vann al frmcrearpersonaje y el image que tienen en crear personaje, sería el Case 0
Visual Basic:
    Case 0
        
        Dim I As Integer
        Dim k As Object
        I = 1
        For Each k In Skill
            UserSkills(I) = k.Caption
            I = I + 1
        Next
        
        UserName = txtNombre.Text
        
        If Right$(UserName, 1) = " " Then
                UserName = RTrim$(UserName)
                MsgBox "Nombre invalido, se han removido los espacios al final del nombre"
        End If
        
        UserRaza = lstRaza.List(lstRaza.ListIndex)
        UserSexo = lstGenero.List(lstGenero.ListIndex)
        UserClase = lstProfesion.List(lstProfesion.ListIndex)
        
        UserAtributos(1) = Val(lbFuerza.Caption)
        UserAtributos(2) = Val(lbInteligencia.Caption)
        UserAtributos(3) = Val(lbAgilidad.Caption)
        UserAtributos(4) = Val(lbCarisma.Caption)
        UserAtributos(5) = Val(lbConstitucion.Caption)
        
        UserHogar = lstHogar.List(lstHogar.ListIndex)
        
        'Barrin 3/10/03
        If CheckData() Then
            frmMain.Socket1.HostName = CurServerIp
    frmMain.Socket1.RemotePort = CurServerPort
    
    Me.MousePointer = 11
    EstadoLogin = CrearNuevoPj
 
    If Not frmMain.Socket1.Connected Then
        
        frmMensaje.Show
            frmMensaje.msg.Caption = "Error: Se ha perdido la conexion con el server."
        Unload Me
    Else
        Call Login
    End If
        End If
        
 

Buscan el sub login y reemplazan por
Visual Basic:
 
Sub Login()
    If EstadoLogin = Normal Then
        SendData ("OOLOGI" & PJClickeado & "," & nombrecuent)
    ElseIf EstadoLogin = CrearNuevoPj Then
        SendData ("NLOGIN" & UserName & "," & UserRaza & "," & UserSexo & "," & UserSexo & "," & UserClase & "," & UserHogar _
                & "," & UserSkills(1) & "," & UserSkills(2) _
                & "," & UserSkills(3) & "," & UserSkills(4) _
                & "," & UserSkills(5) & "," & UserSkills(6) _
                & "," & UserSkills(7) & "," & UserSkills(8) _
                & "," & UserSkills(9) & "," & UserSkills(10) _
                & "," & UserSkills(11) & "," & UserSkills(12) _
                & "," & UserSkills(13) & "," & UserSkills(14) _
                & "," & UserSkills(15) & "," & UserSkills(16) _
                & "," & UserSkills(17) & "," & UserSkills(18) _
                & "," & UserSkills(19) & "," & UserSkills(20) _
                & "," & UserSkills(21) & "," & nombrecuent)
     ElseIf EstadoLogin = CrearAccount Then
     With frmCrearAccount
        SendData ("NACCNT" & .nombre & "," & .Pass & "," & .Mail & "," & .pregunta & "," & .respuesta)
End With
 
    ElseIf EstadoLogin = BorrarPj Then
        SendData ("BORR" & PJClickeado)
    ElseIf EstadoLogin = LoginAccount Then
        SendData ("ALOGIN" & nombrecuent & "," & UserPassword & "," & App.Major & "." & App.Minor & "." & App.Revision & "," & MD5HushYo)
    End If
End Sub
 
 

Buscar
Visual Basic:
Public Enum E_MODO
reemplazar todo por
Visual Basic:
Public Enum E_MODO
    Normal = 1
    CrearNuevoPj = 2
    Dados = 3
    CrearAccount = 4
    LoginAccount = 5
    BorrarPj = 6
End Enum

En el módulo declaraciones ponen, abajo de option explicit
Visual Basic:
 Public nombrecuent As String
Public passcuent As String

Buscan
Visual Basic:
    'Load main form
    frmMain.Visible = True
Y abajo ven algo como
Visual Basic:
frmMain.Label8.Caption =
Reemplaza todo eso por
Visual Basic:
frmMain.label8.Caption = PJClickeado

Buscar
Visual Basic:
Case "NSEGUE"

Arriba
Visual Basic:
        Case "GENPAS" 'GENERAR PASSWORD PARA RECUPERAR CUENTA [Dylan.-]
        Rdata = Right$(Rdata, Len(Rdata) - 6)
        Dim PassGenerada As String
        PassGenerada = Rdata
        'frmMensaje.Show
        MsgBox "Su nueva contraseña es: " & PassGenerada & ". Asegúrate de cambiar la contraseña antes de entrar en un personaje, de lo contrario no podrás acceder a tus personajes."
        Unload frmRecuperar
        Exit Sub
        Case "PEDPRE" 'ENVIO DE PREGUNTA SECRETA [Dylan.-]
        Rdata = Right$(Rdata, Len(Rdata) - 6)
        If frmCambiarPass.Visible = True Then
        frmCambiarPass.pregunta.Caption = Rdata
        Exit Sub
        End If
        If frmRecuperar.Visible = True Then
        frmRecuperar.height = 4980
        frmRecuperar.txtMail.Locked = True
        frmRecuperar.txtNombre.Locked = True
        frmRecuperar.txtPregunta.Visible = True
        frmRecuperar.txtRespuesta.Visible = True
        frmRecuperar.txtRespuesta.SetFocus
        frmRecuperar.Recuperar.Visible = True
        frmRecuperar.Picture = LoadPicture(App.path & "\Graficos\Principal\Recuperar2Fin.jpg")
        frmRecuperar.Siguiente.Visible = False
        frmRecuperar.Cancelar.Visible = False
        frmRecuperar.Picture = LoadPicture(App.path & "\Graficos\Principal\Recuperar2.jpg")
        frmRecuperar.txtPregunta.Caption = Rdata
        Exit Sub
        End If

Buscar
Visual Basic:
Case "ZMOTD"
Abajo de todo ese case poner
Visual Basic:
        Case "INIAC"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
            frmCuent.Label3.Caption = ReadField(1, Rdata, 44)
            frmCuent.Show
            Unload frmConnect
            'frmCuent.SetFocus
            Exit Sub
        Case "ADDPJ"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
            
            rcvName = ReadField(1, Rdata, 44)
            rcvIndex = ReadField(2, Rdata, 44)
            rcvHead = ReadField(3, Rdata, 44)
            rcvBody = ReadField(4, Rdata, 44)
            rcvWeapon = ReadField(5, Rdata, 44)
            rcvShield = ReadField(6, Rdata, 44)
            rcvCasco = ReadField(7, Rdata, 44)
            rcvCrimi = ReadField(8, Rdata, 44)
            rcvBaned = ReadField(9, Rdata, 44)
            rcvLevel = ReadField(10, Rdata, 44)
            rcvClase = ReadField(11, Rdata, 44)
            rcvMuerto = ReadField(12, Rdata, 44)
            
            If rcvCrimi = True Then frmCuent.Nombre(rcvIndex).ForeColor = vbWhite
            If rcvCrimi = False Then frmCuent.Nombre(rcvIndex).ForeColor = vbWhite
            
            Call DibujarTodo(rcvIndex - 1, rcvBody, rcvHead, rcvCasco, rcvShield, rcvWeapon, rcvBaned, rcvName, rcvLevel, rcvClase, rcvMuerto)
            Exit Sub
 

Buscar
Visual Basic:
'Objetos públicos
Arriba poner
Visual Basic:
Public PJClickeado As String
 
Public rcvName As String
Public rcvHead As Integer
Public rcvBody As Integer
Public rcvShield As Integer
Public rcvWeapon As Integer
Public rcvCasco As Integer
Public rcvIndex As Integer
Public rcvCrimi As Boolean
Public rcvBaned As Integer
Public rcvLevel As Integer
Public rcvClase As String
Public rcvMuerto As Integer
 
Public PJSAmount As Integer
Creo que estaría el cliente

Van al FrmCuent y buscan Cuentapj = 0 y lo borran (Gracias zaiko)

Servidor
Arriba de
Visual Basic:
Sub ConnectNewUser(UserIndex As Integer, name As String, UserRaza As String, UserSexo As String, UserClase As String, Hogar As String, _
 
poner
Visual Basic:
Public Function IsYourChr(ByVal Account As String, ByVal PJ As String)
 
Dim i As Integer
Dim NumPjs As Integer
Dim ChrToView As String
 
 
 
NumPjs = GetVar(App.Path & "\Accounts\" & Account & ".act", "PJS", "NumPjs")
 
IsYourChr = False
 
For i = 1 To NumPjs
    ChrToView = GetVar(App.Path & "\Accounts\" & Account & ".act", "PJS", "PJ" & i)
    If ChrToView = PJ Then IsYourChr = True
Next i
 
End Function
 
Sub ConnectAccount(ByVal UserIndex As Integer, name As String, Password As String)
 
Dim i As Integer
Dim Pjjj As String
Dim NumPjs As Integer
Dim ArchivodeUser As String
Dim Pos() As String
Dim Oro() As Long
Dim Nivel() As String
Dim PuntosdeCanje() As Integer
Dim OroBanco() As Byte
Dim cosa As Integer
 
 
If Password <> GetVar(App.Path & "\Accounts\" & name & ".act", name, "password") Then
    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRPassword incorrecto.")
    Call CloseSocket(UserIndex)
    Exit Sub
End If
 
UserList(UserIndex).Accounted = name
UserList(UserIndex).AccountedPass = Password
 
NumPjs = GetVar(App.Path & "\Accounts\" & name & ".act", "PJS", "NumPjs")
 
If TienePjs(name) = True Then
    Call SendData(SendTarget.ToIndex, UserIndex, 0, "INIAC" & name & "," & NumPjs + 1)
Else
    Call SendData(SendTarget.ToIndex, UserIndex, 0, "INIAC0")
End If
ArchivodeUser = App.Path & "\charfile\"
For i = 1 To NumPjs
    Pjjj = GetVar(App.Path & "\Accounts\" & name & ".act", "PJS", "PJ" & i)
    If Pjjj = "" Then Exit Sub
    Call LoadUserAccount(Pjjj & ".chr")
    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ADDPJ" & Pjjj & "," & i & "," & PJEnCuenta & PJEnCuentaB)
Next i
End Sub
Sub ChrToAccount(ByVal Accounted As String, tName As String)
 
Dim NumPjs As Integer
Dim N As Integer
 
NumPjs = GetVar(App.Path & "\Accounts\" & Accounted & ".act", "PJS", "NumPjs")
 
If NumPjs = 1 And GetVar(App.Path & "\Accounts\" & Accounted & ".act", "PJS", "PJ" & NumPjs) = "" Then
    Call WriteVar(App.Path & "\Accounts\" & Accounted & ".act", "PJS", "NumPjs", NumPjs)
    Call WriteVar(App.Path & "\Accounts\" & Accounted & ".act", "PJS", "PJ" & NumPjs, tName)
    Exit Sub
End If
 
NumPjs = NumPjs + 1
 
Call WriteVar(App.Path & "\Accounts\" & Accounted & ".act", "PJS", "NumPjs", NumPjs)
Call WriteVar(App.Path & "\Accounts\" & Accounted & ".act", "PJS", "PJ" & NumPjs, tName)
 
 
End Sub
Sub CreateAccount(ByVal Account As String, Password As String, Mail As String, pregunta As String, Respuesta As String, UserIndex As Integer)
 
On Error GoTo errhandler
 
If FileExist(App.Path & "\Accounts\" & Account & ".act", vbNormal) = True Then
Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERREl nombre de la cuenta ya está siendo utilizado por otro usuario.")
    Exit Sub
End If
 
Dim N As Integer
Dim i As Integer
 
 
N = FreeFile()
 
Open App.Path & "\Accounts\" & Account & ".act" For Output As N
    Print #N, "[" & Account & "]"
    Print #N, "password=" & Password
    Print #N, "mail=" & Mail
    Print #N, "Pregunta=" & pregunta
    Print #N, "Respuesta=" & Respuesta
    Print #N, "ban=0"
    Print #N, "[PJS]"
    Print #N, "NumPjs=0"
    Print #N, "PJ1="
    Print #N, "PJ2="
    Print #N, "PJ3="
    Print #N, "PJ4="
    Print #N, "PJ5="
    Print #N, "PJ6="
    Print #N, "PJ7="
    Print #N, "PJ8="
Close N
 
DoEvents
 
Call CloseSocket(UserIndex)
 
Call SendData(SendTarget.ToIndex, UserIndex, 0, "HLQ")
 
Exit Sub
 
errhandler:
 
Call LogError("NewAccount - Error = " & Err.Number & " - Descripción = " & Err.Description)
 
End Sub
 
Public Function TienePjs(ByVal Account As String) As Boolean
 
Dim frstPj As String
 
frstPj = GetVar(App.Path & "\Accounts\" & Account & ".act", "PJS", "PJ0")
 
If frstPj <> "" Then
    TienePjs = True
Else
    TienePjs = False
End If
 
End Function

BORRAR TODOS LOS PAQUETES DE LOGUEO Y CREAR PERSONAJES (OLOGIN, NLOGIN PREDETERMINADAMENTE)
Buscar
Visual Basic:
Case "TIRDAD"
Al final del Case "TIRDAD" PONEN
Visual Basic:
end select
Arriba del CASE "TIRDAD" poner todo esto:
Visual Basic:
 
        'Declaraciones
        Dim CuentaName As String
        Dim mailName As String
        Dim preguntapedida As String
        Dim Respuesta As String
        'Comienzo de paquetes [Dylan.-]
        
        Case "REECUU" 'Segunda parte de recuperar cuenta. [Dylan.-]
        rData = Right$(rData, Len(rData) - 6)
        CuentaName = ReadField(1, rData, Asc(","))
        Respuesta = ReadField(2, rData, Asc(","))
    If Respuesta <> GetVar(App.Path & "\Accounts\" & CuentaName & ".act", CuentaName, "Respuesta") Then
        Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa respuesta es incorrecta.")
        CloseSocket (UserIndex)
    Exit Sub
    Else
        Dim PasswordGen As Integer
        PasswordGen = RandomNumber(100, 999)
        Call SendData(ToIndex, UserIndex, 0, "GENPAS" & PasswordGen)
        Call WriteVar(App.Path & "\Accounts\" & CuentaName & ".act", CuentaName, "Password", PasswordGen)
            Dim PersonajeAsd As String
            For i = 1 To val(GetVar(App.Path & "\Accounts\" & CuentaName & ".act", "PJS", "NumPjs"))
        PersonajeAsd = GetVar(App.Path & "\Accounts\" & CuentaName & ".act", "PJS", "pj" & i)
        Call WriteVar(App.Path & "\charfile\" & PersonajeAsd & ".chr", "INIT", "Password", PasswordGen)
            Next i
        Exit Sub
    End If
        
        
        Case "RECCUU" 'primera parte de recuperar cuenta. [Dylan.-]
        rData = Right$(rData, Len(rData) - 6)
        CuentaName = ReadField(1, rData, Asc(","))
        mailName = ReadField(2, rData, Asc(","))
        preguntapedida = GetVar(App.Path & "\Accounts\" & CuentaName & ".act", CuentaName, "Pregunta")
            If Not CuentaExiste(CuentaName) Then
                    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa cuenta no existe.")
                    CloseSocket (UserIndex)
            Exit Sub
            End If
        If mailName <> GetVar(App.Path & "\Accounts\" & CuentaName & ".act", CuentaName, "mail") Then
        Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRE-mail Incorrecto.")
        CloseSocket (UserIndex)
        Exit Sub
        End If
        Call SendData(ToIndex, UserIndex, 0, "PEDPRE" & preguntapedida)
        Exit Sub
        
        Case "PEDPRE" 'ENVIO DE LA PREGUNTA SECRETA
        rData = Right$(rData, Len(rData) - 6)
        
        CuentaName = UCase$(ReadField(1, rData, Asc(",")))
        preguntapedida = GetVar(App.Path & "\Accounts\" & CuentaName & ".act", CuentaName, "Pregunta")
        Call SendData(ToIndex, UserIndex, 0, "PEDPRE" & preguntapedida)
        Exit Sub
                            
        Case "REPASS"
                        '[Dylan.-] - Cambio de Pass
                        rData = Right$(rData, Len(rData) - 6)
                        Dim PassName As String
                        Dim pregunta As String
                        Dim PassActual As String
                        Dim Newpass As String
                        
                        PassName = ReadField(1, rData, Asc(","))
                        pregunta = ReadField(2, rData, Asc(","))
                        Respuesta = ReadField(3, rData, Asc(","))
                        PassActual = ReadField(4, rData, Asc(","))
                        Newpass = ReadField(5, rData, Asc(","))
                        
                        
                        If pregunta <> GetVar(App.Path & "\Accounts\" & PassName & ".act", PassName, "Pregunta") Then
                            Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa pregunta secreta que nos proporciono, no coincide con la del registro.")
                        Exit Sub
                        End If
                        
                        If Respuesta <> GetVar(App.Path & "\Accounts\" & PassName & ".act", PassName, "Respuesta") Then
                            Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa respuesta secreta que nos proporciono, no coincide con la del registro.")
                        Exit Sub
                        End If
                        
                        If PassActual <> GetVar(App.Path & "\Accounts\" & PassName & ".act", PassName, "password") Then
                            Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa Password actual que nos proporciono, no coincide con la del registro.")
                        Exit Sub
                        End If
                            Call WriteVar(App.Path & "\Accounts\" & PassName & ".act", PassName, "Password", Newpass)
                            For i = 1 To val(GetVar(App.Path & "\Accounts\" & PassName & ".act", "PJS", "NumPjs"))
                        PersonajeAsd = GetVar(App.Path & "\Accounts\" & PassName & ".act", "PJS", "pj" & i)
                        Call WriteVar(App.Path & "\charfile\" & PersonajeAsd & ".chr", "INIT", "Password", Newpass)
                        Next i
                        Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa password de su cuenta fue cambiada con exito. Ahora para logear debera de utilizar la nueva.")
                        
                        Exit Sub
        
        
        Case "OOLOGI"
                rData = Right$(rData, Len(rData) - 6)
 Dim Personaje As String
 Dim Acc As String
 
 Personaje = ReadField(1, rData, Asc(","))
 Acc = ReadField(2, rData, Asc(","))
               
               If Not PersonajeExiste(Personaje) Then
                    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERREl personaje no existe.")
                    Call CloseSocket(UserIndex, True)
                    Exit Sub
                End If
                
             If Not BANCheck(Personaje) Then
                    Call ConnectUser(UserIndex, Personaje, UserList(UserIndex).AccountedPass, Acc)
                Else
                    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRSe te ha prohibido la entrada a Lhirus AO debido a tu mal comportamiento. Consulta en aocp.alkon.com.ar/est para ver el motivo de la prohibición.")
                End If
                Exit Sub
                
        
        Case "ALOGIN"
                rData = Right$(rData, Len(rData) - 6)
                
                If Not AsciiValidos(ReadField(1, rData, 44)) Then
                    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRNombre invalido.")
                    Call CloseSocket(UserIndex, True)
                    Exit Sub
                End If
               
                If Not CuentaExiste(ReadField(1, rData, 44)) Then
                    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRLa cuenta no existe.")
                    Call CloseSocket(UserIndex, True)
                    Exit Sub
                End If
                
                Call ConnectAccount(UserIndex, ReadField(1, rData, 44), ReadField(2, rData, 44))
                Exit Sub
                
        
        
        Case "NACCNT"
            
                rData = Right$(rData, Len(rData) - 6)
                
                Dim NCuenta As String
                Dim Passw As String
                Dim Mail As String
            
 
                'cuentas
                NCuenta = ReadField(1, rData, Asc(","))
                Passw = ReadField(2, rData, Asc(","))
                Mail = ReadField(3, rData, Asc(","))
                pregunta = ReadField(4, rData, Asc(","))
                Respuesta = ReadField(5, rData, Asc(","))
 
               Call CreateAccount(NCuenta, Passw, Mail, pregunta, Respuesta, UserIndex)
 
                
            Exit Sub
 
 

REEMPLAZAN EL CASE BORR POR
Visual Basic:
 
    Select Case Left$(rData, 4)
        
        
        Case "BORR" ' <<< borra personajes
                        On Error GoTo ExitErr1:
                        'LwK - borrado de pj
                        rData = Right$(rData, Len(rData) - 4)
                        Dim UserName As String
                        Dim limitPJ As Byte
                        Dim NumPjs As Byte
                        Dim archivo As String
                        
                        UserName = UCase$(ReadField(2, rData, Asc(",")))
                        rData = ReadField(1, rData, Asc(","))
                        archivo = App.Path & "\Accounts\" & UserName & ".act"
                        NumPjs = CByte(val(GetVar(archivo, "PJS", "NumPjs")))
                        
                        For i = 1 To val(GetVar(archivo, "PJS", "NumPjs"))
                            If UCase$(GetVar(archivo, "PJS", "PJ" & i)) = UCase$(rData) Then
                            Call WriteVar(archivo, "PJS", "PJ" & i, "")
                                limitPJ = i + 1
                                BorrarUsuario (rData)
                                If i = 0 Then
                                Exit For
                                Else
                                Call WriteVar(archivo, "PJS", "NumPjs", val(GetVar(archivo, "PJs", "NumPjs")) - 1)
                                
                                Exit For
                            End If
                            End If
                        Next i
                      
                        For i = limitPJ To NumPjs
                            UserName = GetVar(archivo, "PJS", "PJ" & i)
                            Call WriteVar(archivo, "PJS", "PJ" & i, "")
                            Call WriteVar(archivo, "PJS", "PJ" & i - 1, UserName)
                        Next i
                        
                Call SendData(SendTarget.ToIndex, UserIndex, 0, "BORROK")
                        Exit Sub


Buscar
Visual Basic:
Sub ConnectNewUser(UserIndex As Integer, name As String, UserRaza As String, UserSexo As String, UserClase As String, Hogar As String, _
                    US1 As String, US2 As String, US3 As String, US4 As String, US5 As String, _
                    US6 As String, US7 As String, US8 As String, US9 As String, US10 As String, _
                    US11 As String, US12 As String, US13 As String, US14 As String, US15 As String, _
                    US16 As String, US17 As String, US18 As String, US19 As String, US20 As String, _
                    US21 As String)
Reemplazar por
Visual Basic:
Sub ConnectNewUser(UserIndex As Integer, name As String, UserRaza As String, UserSexo As String, UserClase As String, Hogar As String, _
                    US1 As String, US2 As String, US3 As String, US4 As String, US5 As String, _
                    US6 As String, US7 As String, US8 As String, US9 As String, US10 As String, _
                    US11 As String, US12 As String, US13 As String, US14 As String, US15 As String, _
                    US16 As String, US17 As String, US18 As String, US19 As String, US20 As String, _
                    US21 As String, Cuenta As String)
Buscar
Visual Basic:
UserList(UserIndex).Hogar = Hogar
Abajo
Visual Basic:
UserList(UserIndex).Password = UserList(UserIndex).AccountedPass

Buscar
Visual Basic:
Call SaveUser(UserIndex, CharPath & UCase$(name) & ".chr")
 

Reemplazamos por
Visual Basic:
UserList(UserIndex).Char.Account = Cuenta
 
Call SaveUser(UserIndex, CharPath & UCase$(name) & ".chr")
 
Call ChrToAccount(Cuenta, name)

Buscar
Visual Basic:
 
'Open User
hay una linea de ConnectUser y reemplazarla por
Visual Basic:
Call ConnectUser(UserIndex, name, UserList(UserIndex).AccountedPass, Cuenta)

Ahora vamos al SaveUser
y buscamos
Visual Basic:
Call WriteVar(UserFile, "INIT", "Clase", UserList(UserIndex).Clase)
Abajo
Visual Basic:
Call WriteVar(UserFile, "INIT", "Password", UserList(UserIndex).AccountedPass)

Buscamos
Visual Basic:
Call WriteVar(UserFile, "INIT", "Position", UserList(UserIndex).Pos.Map & "-" & UserList(UserIndex).Pos.X & "-" & UserList(UserIndex).Pos.Y)
 

Abajo
Visual Basic:
Call WriteVar(UserFile, "CHAR", "Cuenta", UserList(UserIndex).Char.Account)

Ahora al sub loaduserinit
Buscamos
Visual Basic:
UserList(UserIndex).email = UserFile.GetValue("CONTACTO", "Email")
 
Abajo
Visual Basic:
UserList(UserIndex).Char.Account = UserFile.GetValue("CHAR", "Cuenta")
 

Buscamos
Visual Basic:
Sub ConnectUser(ByVal UserIndex As Integer, name As String, Password As String
Reemplazamos por
Visual Basic:
Sub ConnectUser(ByVal UserIndex As Integer, name As String, Password As String, Cuenta As String)

Buscamos
Visual Basic:
'¿Existe el personaje?
If Not FileExist(CharPath & UCase$(name) & ".chr", vbNormal) Then
    Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERREl personaje no existe.")
    Call CloseSocket(UserIndex)
    Exit Sub
End If

Abajo
Visual Basic:
'¿Es el passwd valido?
If UCase$(Password) <> UCase$(GetVar(CharPath & UCase$(name) & ".chr", "INIT", "Password")) Then
    Call SendData(ToIndex, UserIndex, 0, "ERRPassword incorrecto.")
    Call CloseSocket(UserIndex)
    Exit Sub
End If

Buscamos
Visual Basic:
'¿Ya esta conectado el personaje?
If CheckForSameName(UserIndex, name) Then
    If UserList(NameIndex(name)).Counters.Saliendo Then
        Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERREl usuario está saliendo.")
    Else
        Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRPerdon, un usuario con el mismo nombre se há logeado.")
    End If
    Call CloseSocket(UserIndex)
    Exit Sub
End If

Abajo
Visual Basic:
'¿Loguió mas de un personaje por cuenta? - Dylan.-
Dim j As Long
 
For j = 1 To LastUser
 
If LastUser <> 0 Then
If UserList(UserIndex).Char.Account = UserList(j).Char.Account And UserList(j).flags.UserLogged = True Then
Call SendData(SendTarget.ToIndex, UserIndex, 0, "ERRNo se puede logear mas de un usuario por cuenta.")
CloseSocket UserIndex
Exit Sub
End If
End If
 
Next j
 

Buscar
Visual Basic:
Public Type Char
Abajo poner
Visual Basic:
    Account As String

Buscamos
Visual Basic:
ComUsu As tCOmercioUsuario
Abajo
Visual Basic:
    Accounted As String
    AccountedPass As String

Buscar
Visual Basic:
Public Sub CargarSpawnList()
arriba
Visual Basic:
Sub LoadUserAccount(ByVal PJinit As String)
On Error Resume Next
PJEnCuenta = GetVar(CharPath & "\" & PJinit, "INIT", "Head") & "," & GetVar(CharPath & "\" & PJinit, "INIT", "Body") & "," & _
GetVar(CharPath & "\" & PJinit, "INIT", "Arma") & "," & GetVar(CharPath & "\" & PJinit, "INIT", "Escudo") & ","
PJEnCuentaB = GetVar(CharPath & "\" & PJinit, "INIT", "Casco") & "," & UserAccountEsCrimi(PJinit) & "," & GetVar(CharPath & "\" & PJinit, "FLAGS", "Ban") & "," & GetVar(CharPath & "\" & PJinit, "STATS", "ELV") & "," & GetVar(CharPath & "\" & PJinit, "INIT", "Clase") & "," & GetVar(CharPath & "\" & PJinit, "FLAGS", "Muerto")
End Sub
Function UserAccountEsCrimi(ByVal PJinit As String) As Integer
 
'On Error Resume Next
 
Dim AsesinoRep As Double
Dim BurguesRep As Double
Dim NobleRep As Double
Dim PlebeRep As Double
Dim LadronRep As Double
Dim BandidoRep As Double
Dim L As Long
 
AsesinoRep = GetVar(CharPath & "\" & PJinit, "REP", "Asesino")
BurguesRep = GetVar(CharPath & "\" & PJinit, "REP", "Burguesia")
NobleRep = GetVar(CharPath & "\" & PJinit, "REP", "Nobles")
LadronRep = GetVar(CharPath & "\" & PJinit, "REP", "Ladrones")
PlebeRep = GetVar(CharPath & "\" & PJinit, "REP", "Plebe")
BandidoRep = GetVar(CharPath & "\" & PJinit, "REP", "Bandido")
 
L = (-AsesinoRep) + (-BandidoRep) + BurguesRep + (-LadronRep) + NobleRep + PlebeRep
L = L / 6
 
If (L < 0) = False Then UserAccountEsCrimi = 0
If (L < 0) = True Then UserAccountEsCrimi = 1
 
End Function

En módulo declaraciones abajo de option explicit poner:
Visual Basic:
Public PJEnCuenta As String
Public PJEnCuentaB As String
Public totalAccounts As Long
Public totalPjs As Long

Buscar
Visual Basic:
UserList(UserIndex).email = UserEmail
Y lo borran
Buscar
Visual Basic:
UserList(UserIndex).Password = Password
Y lo borran
Buscar
Visual Basic:
Public Function UnBan(ByVal name As String) As Boolean

Arriba poner
Visual Basic:
 
Public Function CuentaExiste(ByVal Cuenta As String) As Boolean
 
CuentaExiste = FileExist(App.Path & "\Accounts\" & UCase$(Cuenta) & ".act", vbNormal)
 
End Function

En el servidor crear una carpeta que se llame "Accounts".