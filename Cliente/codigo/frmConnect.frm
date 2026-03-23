VERSION 5.00
Begin VB.Form frmConnect 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   0  'None
   Caption         =   "Argentum Online"
   ClientHeight    =   9000
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   11985
   ClipControls    =   0   'False
   FillColor       =   &H00000040&
   Icon            =   "frmConnect.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MousePointer    =   99  'Custom
   Moveable        =   0   'False
   ScaleHeight     =   471.094
   ScaleMode       =   0  'User
   ScaleWidth      =   799
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   225
      Left            =   840
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   2520
      Width           =   2895
   End
   Begin VB.ListBox lst_servers 
      BackColor       =   &H00000000&
      ForeColor       =   &H0000FF00&
      Height          =   450
      ItemData        =   "frmConnect.frx":000C
      Left            =   720
      List            =   "frmConnect.frx":0013
      TabIndex        =   7
      Top             =   2040
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00000000&
      ForeColor       =   &H0000FF00&
      Height          =   555
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1080
      Visible         =   0   'False
      Width           =   6015
   End
   Begin VB.TextBox DescTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   225
      Left            =   4440
      Locked          =   -1  'True
      TabIndex        =   3
      Text            =   "AOSpain Primario"
      Top             =   840
      Width           =   2895
   End
   Begin VB.TextBox IPTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   225
      Left            =   2160
      TabIndex        =   5
      Text            =   "localhost"
      Top             =   720
      Visible         =   0   'False
      Width           =   2895
   End
   Begin VB.TextBox PortTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   225
      Left            =   120
      TabIndex        =   4
      Text            =   "7666"
      Top             =   720
      Visible         =   0   'False
      Width           =   1875
   End
   Begin VB.TextBox PasswordTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Georgia"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   284
      IMEMode         =   3  'DISABLE
      Left            =   4920
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   5970
      Width           =   2325
   End
   Begin VB.TextBox NameTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Georgia"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   249
      Left            =   4080
      TabIndex        =   1
      Top             =   5254
      Width           =   3735
   End
   Begin VB.Image RecupPersonaje 
      Height          =   373
      Left            =   7800
      MousePointer    =   99  'Custom
      Top             =   7164
      Visible         =   0   'False
      Width           =   2205
   End
   Begin VB.Image Conectar 
      BorderStyle     =   1  'Fixed Single
      Height          =   405
      Index           =   1
      Left            =   4560
      MousePointer    =   99  'Custom
      Top             =   7080
      Width           =   2925
   End
   Begin VB.Image CrearPersonaje 
      Height          =   316
      Left            =   2040
      MousePointer    =   99  'Custom
      Top             =   7164
      Width           =   2205
   End
   Begin VB.Label version 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   195
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   555
   End
End
Attribute VB_Name = "frmConnect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
'
'Mataas Fernando Pequeao
'matux@fibertel.com.ar
'www.noland-studios.com.ar
'Acoyte 678 Piso 17 Dto B
'Capital Federal, Buenos Aires - Republica Argentina
'Cadigo Postal 1405

Option Explicit

Public Sub CargarLst()

Dim i As Integer

lst_servers.Clear

For i = 1 To UBound(ServersLst)
    lst_servers.AddItem ServersLst(i).desc
Next i

End Sub

Private Sub Command1_Click()
CurServer = 0
IPdelServidor = IPTxt
PuertoDelServidor = PortTxt
End Sub


Private Sub Form_Activate()
Dim nDirectorio As String
If CurServer <> 0 Then
    IPTxt = ServersLst(CurServer).Ip
    PortTxt = ServersLst(CurServer).Puerto
Else
    IPTxt = IPdelServidor
    PortTxt = PuertoDelServidor
End If

Call CargarLst
DescTxt.Text = ServersLst(CurServer).desc
nDirectorio = Dir(App.Path & "\Web", vbDirectory)
If nDirectorio <> "Web" Then MkDir (App.Path & "\Web")

End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
        frmCargando.Show
        frmCargando.Refresh
        AddtoRichTextBox frmCargando.status, "Cerrando Argentum Online.", 0, 0, 0, 1, 0, 1
        
        Call SaveGameini
        frmConnect.MousePointer = 1
        frmMain.MousePointer = 1
        prgRun = False
        
        AddtoRichTextBox frmCargando.status, "Liberando recursos..."
        frmCargando.Refresh
        LiberarObjetosDX
        AddtoRichTextBox frmCargando.status, "Hecho", 0, 0, 0, 1, 0, 1
        AddtoRichTextBox frmCargando.status, "aaGracias por jugar Argentum Online!!", 0, 0, 0, 1, 0, 1
        frmCargando.Refresh
        Call UnloadAllForms
End If
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

'Make Server IP and Port box visible
If KeyCode = vbKeyI And Shift = vbCtrlMask Then
    
    'Port
    PortTxt.Visible = True
    'Label4.Visible = True
    
    'Server IP
    IPTxt.Text = "localhost"
    IPTxt.Visible = True
    'Label5.Visible = True
    
    KeyCode = 0
    Exit Sub
End If

End Sub

Private Sub Form_Load()
    '[CODE 002]:MatuX
    EngineRun = False
    '[END]
Dim d As Integer
Dim j
For Each j In Conectar()
   j.Tag = "0"
Next
PortTxt.Text = Config_Inicio.Puerto
 
'frmConnect.Picture = LoadPicture(App.Path & "\Graficos\Conectar.jpg")
'[Efestos]
Do While d <> 5
DescargarTxt(d) = True
d = d + 1
Loop
'[Efestos]
 '[CODE]:MatuX
 '
 '  El cadigo para mostrar la versian se genera aca para
 ' evitar que por X razones luego desaparezca, como suele
 ' pasar a veces :)
    version.Caption = "v" & App.Major & "." & App.Minor & " Beta: 1"
 '[END]'

End Sub

Private Sub CrearPersonaje_Click()
    frmCrearAccount.Visible = True
End Sub


Private Sub Conectar_Click(Index As Integer)
Dim Archivo As String
Dim cadena As String
Dim nArchivo As String
Dim eArchivo As String

If Not IsIp(IPTxt) And CurServer <> 0 Then
    If MsgBox("Atencion, esta intentando conectarse a un servidor no oficial, NoLand Studios no se hace responsable de los posibles problemas que estos servidores presenten. aDesea continuar?", vbYesNo) = vbNo Then
        If CurServer <> 0 Then
            IPTxt = ServersLst(CurServer).Ip
            PortTxt = ServersLst(CurServer).Puerto
        Else
            IPTxt = IPdelServidor
            PortTxt = PuertoDelServidor
        End If
        Exit Sub
    End If
    CurServer = 0
    IPdelServidor = IPTxt
    PuertoDelServidor = PortTxt
End If


Call PlayWaveDS(SND_CLICK)

    Select Case Index
    Case 0
        EstadoLogin = CrearAccount
        'MsgBox "Intentando conectar a: " & CurServerIp() & ":" & CurServerPort()
        If frmMain.Socket1.Connected Then
             frmMain.Socket1.Disconnect
             frmMain.Socket1.Cleanup
             DoEvents
         End If
         frmMain.Socket1.HostAddress = CurServerIp
         frmMain.Socket1.RemotePort = CurServerPort
         frmMain.Socket1.Connect
    Case 1
        nombrecuent = NameTxt.Text
        passcuent = PasswordTxt.Text
        'MsgBox "Intentando conectar a: " & CurServerIp() & ":" & CurServerPort()
        If frmMain.Socket1.Connected Then
        frmMain.Socket1.Disconnect
        frmMain.Socket1.Cleanup
        DoEvents
        End If
      '  If frmConnect.MousePointer = 99 Then
      '      Exit Sub
     '   End If
        
        
        'update user info
        nombrecuent = NameTxt.Text
        Dim aux As String
        aux = PasswordTxt.Text
#If SeguridadAlkon Then
        UserPassword = MD5.GetMD5String(aux)
        Call MD5.MD5Reset
#Else
        UserPassword = aux
#End If
        If CheckUserData(False) = True Then
            EstadoLogin = LoginAccount
            Me.MousePointer = 99
            frmMain.Socket1.HostAddress = CurServerIp
            frmMain.Socket1.RemotePort = CurServerPort
            frmMain.Socket1.Connect
 
        End If
    Case 2
        frmBorrar.Show vbModal
    Case 3
        lst_servers.Visible = True
        Text1.Visible = False
    Case 4
        lst_servers.Visible = False
        Text1.Visible = True
        Text1.Text = ""
        eArchivo = Dir(App.Path & "\Web\soynuevo.txt")
        If eArchivo <> "soynuevo.txt" Or DescargarTxt(1) = True Then
            Text2.Text = "Descargando Reglamento..."
            frmMain.Inet1.URL = "http://www.caratula2000.net/power/soynuevo.txt"
            Archivo = frmMain.Inet1.OpenURL
            nArchivo = App.Path & "/Web/soynuevo.txt"
            Open nArchivo For Output As #1
                Print #1, Archivo
            Close
            Text2.Text = "Descarga Finalizada"
            DescargarTxt(1) = False
        End If
        eArchivo = App.Path & "\Web\soynuevo.txt"
        Open eArchivo For Input As #1
            While Not EOF(1)
                Line Input #1, cadena
                Text1.Text = Text1.Text + cadena + vbCrLf
            Wend
        Close
        Text1.SetFocus
    Case 5
        lst_servers.Visible = False
        Text1.Visible = True
        Text1.Text = ""
        eArchivo = Dir(App.Path & "\Web\reglamento.txt")
        If eArchivo <> "reglamento.txt" Or DescargarTxt(2) = True Then
            Text2.Text = "Descargando Reglamento..."
            frmMain.Inet1.URL = "http://www.caratula2000.net/power/reglamento.txt"
            Archivo = frmMain.Inet1.OpenURL
            nArchivo = App.Path & "/Web/reglamento.txt"
            Open nArchivo For Output As #1
                Print #1, Archivo
            Close
            Text2.Text = "Descarga Finalizada"
            DescargarTxt(2) = False
        End If
        eArchivo = App.Path & "\Web\reglamento.txt"
        Open eArchivo For Input As #1
            While Not EOF(1)
                Line Input #1, cadena
                Text1.Text = Text1.Text + cadena + vbCrLf
            Wend
        Close
        Text1.SetFocus
    Case 6
        lst_servers.Visible = False
        Text1.Visible = True
        Text1.Text = ""
        eArchivo = Dir(App.Path & "\Web\historia.txt")
        If eArchivo <> "historia.txt" Or DescargarTxt(3) = True Then
            Text2.Text = "Descargando Historia..."
            frmMain.Inet1.URL = "http://www.caratula2000.net/power/historia.txt"
            Archivo = frmMain.Inet1.OpenURL
            nArchivo = App.Path & "/Web/historia.txt"
            Open nArchivo For Output As #1
                Print #1, Archivo
            Close
            Text2.Text = "Descarga Finalizada"
            DescargarTxt(3) = False
        End If
        eArchivo = App.Path & "\Web\historia.txt"
        Open eArchivo For Input As #1
            While Not EOF(1)
                Line Input #1, cadena
                Text1.Text = Text1.Text + cadena + vbCrLf
            Wend
        Close
        Text1.SetFocus
    Case 7
        'abre la pagina de AOSpain.com
        'ShellExecute frmMain.hwnd, vbNullString, "http://www.caratula2000.net", vbNullString, vbNullString, vbNormalFocus
End Select
End Sub

Private Sub RecupPersonaje_Click()
    Call PlayWaveDS(SND_CLICK)
    Call frmRecuperarpj.Show(vbModal, frmConnect)

End Sub
Private Sub lst_servers_Click()
CurServer = lst_servers.ListIndex + 1
DescTxt = ServersLst(CurServer).desc
IPTxt = ServersLst(CurServer).Ip
PortTxt = ServersLst(CurServer).Puerto
End Sub
