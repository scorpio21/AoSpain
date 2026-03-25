VERSION 5.00
Begin VB.Form frmCrearAccount 
   BorderStyle     =   0  'None
   ClientHeight    =   4560
   ClientLeft      =   0
   ClientTop       =   60
   ClientWidth     =   6615
   ControlBox      =   0   'False
   Icon            =   "frmCrearAccount.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4560
   ScaleWidth      =   6615
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   600
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   8
      Text            =   "frmCrearAccount.frx":000C
      Top             =   6000
      Width           =   3615
   End
   Begin VB.TextBox respuesta 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      Left            =   360
      TabIndex        =   6
      Top             =   5400
      Width           =   3100
   End
   Begin VB.TextBox pregunta 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      Left            =   360
      TabIndex        =   5
      Top             =   5040
      Width           =   3100
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   195
      Left            =   4920
      MaskColor       =   &H00004080&
      TabIndex        =   7
      Top             =   5040
      UseMaskColor    =   -1  'True
      Width           =   170
   End
   Begin VB.TextBox Mail2 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      Left            =   360
      TabIndex        =   4
      Top             =   4680
      Width           =   3100
   End
   Begin VB.TextBox Nombre 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      Left            =   2640
      MaxLength       =   25
      TabIndex        =   0
      Top             =   1440
      Width           =   3100
   End
   Begin VB.TextBox Pass 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      IMEMode         =   3  'DISABLE
      Left            =   2640
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   2520
      Width           =   3100
   End
   Begin VB.TextBox RePass 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      IMEMode         =   3  'DISABLE
      Left            =   2640
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   3000
      Width           =   3100
   End
   Begin VB.TextBox Mail 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      BeginProperty Font 
         Name            =   "Candara"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   340
      Left            =   2640
      TabIndex        =   3
      Top             =   1920
      Width           =   3100
   End
   Begin VB.Image Image1 
      Height          =   255
      Left            =   600
      Top             =   3840
      Width           =   1305
   End
   Begin VB.Image Image2 
      Height          =   360
      Left            =   4560
      Top             =   3840
      Width           =   1170
   End
End
Attribute VB_Name = "frmCrearAccount"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
Me.Picture = LoadPicture(App.Path & "\Graficos\Principal\CuentaNueva.jpg")
'Image1.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BAtrasN.jpg")
'Image2.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BCrearN.jpg")
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
'Image1.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BAtrasN.jpg")
'Image2.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BCrearN.jpg")
End Sub

Private Sub Image1_Click()
Unload Me

End Sub

Private Sub Image1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
'Image1.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BAtrasA.jpg")
End Sub

Private Sub Image1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
'Image1.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BAtrasI.jpg")
End Sub

Private Sub Image2_Click()
    ' [CODE] - AoSpain: Creación de cuenta simplificada

    If Len(Nombre.Text) < 5 Then
        MsgBox "El nombre de la cuenta debe tener más de 4 caracteres.", vbCritical
        Exit Sub
    End If

    If Len(Pass.Text) < 6 Then
        MsgBox "El password de la cuenta debe tener más de 6 caracteres.", vbCritical
        Exit Sub
    End If

    If Pass.Text <> RePass.Text Then
        MsgBox "Las contraseñas no coinciden.", vbCritical
        Exit Sub
    End If

    ' Validacion basica de Mail (opcional segun pedido de anular verificacion, pero mantenemos estructura)
    If Mail.Text = "" Then
        MsgBox "Debes ingresar un correo electrónico.", vbCritical
        Exit Sub
    End If

    ' Enviamos solo los datos necesarios al servidor
    ' Paquete: NACCNT [Nombre],[Pass],[Mail]
    Call SendData("NACCNT" & Nombre.Text & "," & Pass.Text & "," & Mail.Text)

    Unload Me
    MsgBox "Solicitud de creación enviada con éxito.", vbInformation
End Sub

Private Sub Image2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Image2.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BCrearA.jpg")
End Sub

Private Sub Image2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Image2.Picture = LoadPicture(App.Path & "\Graficos\Principal\CrearCuenta_BCrearI.jpg")
End Sub
