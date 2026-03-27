Attribute VB_Name = "Mod_Declaraciones"
'Argentum Online 0.9.0.9
'
'Copyright (C) 2002 Marquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
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

Public nombrecuent As String
Public passcuent As String
Public EstadoLogin As E_MODO

Public Enum E_MODO
    Normal = 1
    CrearNuevoPj = 2
    Dados = 3
    CrearAccount = 4
    LoginAccount = 5
    BorrarPj = 6
    RecuperarPass = 7
End Enum

Public PJClickeado As String
 
Public rcvName As String
Public rcvHead As Long
Public rcvBody As Long
Public rcvShield As Long
Public rcvWeapon As Long
Public rcvCasco As Long
Public rcvIndex As Integer
Public rcvCrimi As Boolean
Public rcvBaned As Long
Public rcvLevel As Integer
Public rcvClase As String
Public rcvMuerto As Integer
 
Public PJSAmount As Integer

Public Type TileMap
    bloqueado As Byte
    grafs(1 To 4) As Long
    Trigger As Integer
    t1 As Integer 'espacio al pedo
End Type

Public RawServersList As String

Public Type tServerInfo
    Ip As String
    Puerto As Integer
    Desc As String
    PassRecPort As Integer
End Type

Public ServersLst() As tServerInfo
Public ServersRecibidos As Boolean

Public CurServer As Integer

Public CreandoClan As Boolean
Public ClanName As String
Public Site As String

Public UserCiego As Boolean
Public UserEstupido As Boolean

Public LastTime As Long
Public ItemElegido As Long

'[Alejo-21-5]
Public Type tConfEnviada
    ModoPaquetes As Long
    IntOk As Long 'tiempo de espera entre M
    IntOkCantPak As Long 'Cantidad de paketes a enviar para esperar un ok
End Type

Public ConfEnv As tConfEnviada

Public Type tFlagOk
    NumMagico As Long
    cant As Long
End Type

Public FlagOk As tFlagOk
Public PingInicio As Long, Ping As Long

'Timers de GetTickCount
Public Const tAt = 2000
Public Const tUs = 600

Public Const bCabeza = 1
Public Const bPiernaIzquierda = 2
Public Const bPiernaDerecha = 3
Public Const bBrazoDerecho = 4
Public Const bBrazoIzquierdo = 5
Public Const bTorso = 6

Public Const PrimerBodyBarco = 84
Public Const UltimoBodyBarco = 87


Public Enum E_Heading
    NORTH = 1
    EAST = 2
    SOUTH = 3
    WEST = 4
End Enum

'Posicion en un mapa
Public Type Position
    x As Long
    y As Long
End Type

'Posicion en el Mundo
Public Type WorldPos
    map As Integer
    x As Integer
    y As Integer
End Type

'Contiene info acerca de donde se puede encontrar un grh tamaño y animacion
Public Type GrhData
    sX As Integer
    sY As Integer
    
    FileNum As Long
    
    pixelWidth As Integer
    pixelHeight As Integer
    
    TileWidth As Single
    TileHeight As Single
    
    NumFrames As Integer
    Frames() As Long
    
    Speed As Single
End Type

'apunta a una estructura grhdata y mantiene la animacion
Public Type Grh
    grhindex As Long
    FrameCounter As Single
    Speed As Single
    Started As Byte
    Loops As Integer
End Type

'Lista de cuerpos
Public Type BodyData
    Walk(E_Heading.NORTH To E_Heading.WEST) As Grh
    HeadOffset As Position
End Type

'Lista de cabezas
Public Type HeadData
    head(E_Heading.NORTH To E_Heading.WEST) As Grh
End Type

'Lista de las animaciones de las armas
Public Type WeaponAnimData
    WeaponWalk(E_Heading.NORTH To E_Heading.WEST) As Grh
End Type

'Lista de las animaciones de los escudos
Public Type ShieldAnimData
    ShieldWalk(E_Heading.NORTH To E_Heading.WEST) As Grh
End Type

'Apariencia del personaje
Public Type Char
    active As Byte
    Heading As E_Heading
    Pos As Position

    iHead As Long
    iBody As Long
    body As BodyData
    head As HeadData
    Casco As HeadData
    Arma As WeaponAnimData
    Escudo As ShieldAnimData
    UsandoArma As Boolean

    fX As Grh
    FxIndex As Long

    Criminal As Byte

    nombre As String

    scrollDirectionX As Integer
    scrollDirectionY As Integer

    Moving As Byte
    MoveOffsetX As Single
    MoveOffsetY As Single

    pie As Boolean
    muertO As Boolean
    invisible As Boolean
    priv As Byte
End Type

'Info de un objeto
Public Type Obj
    OBJIndex As Long
    Amount As Integer
End Type

'Tipo de las celdas del mapa
Public Type MapBlock
    Graphic(1 To 4) As Grh
    CharIndex As Long
    ObjGrh As Grh

    light_value(3) As Long

    luz As Long
    color(3) As Long

    particle_group As Integer


    NPCIndex As Long
    OBJInfo As Obj
    TileExit As WorldPos
    Blocked As Byte

    Trigger As Long
End Type

Public Dialogos As New cDialogos
Public SurfaceDB As New clsSurfaceManDynDX8
Public Audio As New clsAudio
Public Inventario As New clsGraphicalInventory
Public NumEscudosAnims As Integer

Public ArmasHerrero(0 To 100) As Integer
Public ArmadurasHerrero(0 To 100) As Integer
Public ObjCarpintero(0 To 100) As Integer

'[KEVIN]
Public Const MAX_BANCOINVENTORY_SLOTS = 40
Public UserBancoInventory(1 To MAX_BANCOINVENTORY_SLOTS) As Inventory
'[/KEVIN]


Public Tips() As String * 255
Public Const LoopAdEternum = 999

Public Const NUMCIUDADES = 3



'Objetos
Public Const MAX_INVENTORY_OBJS = 10000
Public Const MAX_INVENTORY_SLOTS = 20
Public Const MAX_NPC_INVENTORY_SLOTS = 50
Public Const MAXHECHI = 35

Public Const NUMSKILLS = 22 '21+1 por la resistencia magica [Efestos]
Public Const NUMATRIBUTOS = 5
Public Const NUMCLASES = 20 '16+4 gladiador,arquero,chaman y aldeano [Neptuno]
Public Const NUMRAZAS = 7 '5+2 orcos y hobbits [Neptuno]

Public Const MAXSKILLPOINTS = 100

Public Const FLAGORO = 777

Public Const FOgata = 1521

Public UserSkills(1 To NUMSKILLS) As Integer
Public SkillsNames(1 To NUMSKILLS) As String

Public UserAtributos(1 To NUMATRIBUTOS) As Integer
Public AtributosNames(1 To NUMATRIBUTOS) As String

Public Ciudades(1 To NUMCIUDADES) As String
Public CityDesc(1 To NUMCIUDADES) As String

Public ListaRazas(1 To NUMRAZAS) As String
Public ListaClases(1 To NUMCLASES) As String

Public Const Suerte = 1
Public Const Magia = 2
Public Const Robar = 3
Public Const Tacticas = 4
Public Const Armas = 5
Public Const Meditar = 6
Public Const Apuaalar = 7
Public Const Ocultarse = 8
Public Const Supervivencia = 9
Public Const Talar = 10
Public Const Comerciar = 11
Public Const Defensa = 12
Public Const Pesca = 13
Public Const Mineria = 14
Public Const Carpinteria = 15
Public Const Herreria = 16
Public Const Curacion = 17
Public Const Domar = 18
Public Const Proyectiles = 19
Public Const Wresterling = 20
Public Const Navegacion = 21

Public Const FundirMetal = 88

'Inventario
Type Inventory
    OBJIndex As Integer
    Name As String
    grhindex As Long
    '[Alejo]: tipo de datos ahora es Long
    Amount As Long
    '[/Alejo]
    Equipped As Byte
    Valor As Long
    ObjType As Integer
    Def As Integer
    MaxHit As Integer
    MinHit As Integer
End Type

Type NpCinV
    OBJIndex As Integer
    Name As String
    grhindex As Long
    Amount As Integer
    Valor As Long
    ObjType As Integer
    Def As Integer
    MaxHit As Integer
    MinHit As Integer
    C1 As String
    C2 As String
    C3 As String
    C4 As String
    C5 As String
    C6 As String
    C7 As String
    
End Type

Type tReputacion 'Fama del usuario
    NobleRep As Long
    BurguesRep As Long
    PlebeRep As Long
    LadronesRep As Long
    BandidoRep As Long
    AsesinoRep As Long
    
    Promedio As Long
End Type

Public Nombres As Boolean

Public MixedKey As Long

'User status vars
Public UserInventory(1 To MAX_INVENTORY_SLOTS) As Inventory
Global OtroInventario(1 To MAX_INVENTORY_SLOTS) As Inventory

Public UserHechizos(1 To MAXHECHI) As Integer

Public NPCInventory(1 To MAX_NPC_INVENTORY_SLOTS) As NpCinV
Public NPCInvDim As Integer
Public UserMeditar As Boolean
Public UserName As String
Public UserPassword As String
Public UserMaxHP As Integer
Public UserMinHP As Integer
Public UserMaxMAN As Integer
Public UserMinMAN As Integer
Public UserMaxSTA As Integer
Public UserMinSTA As Integer
Public UserGLD As Long
Public UserLvl As Integer
Public UserPort As Integer
Public UserServerIP As String
Public UserCanAttack As Integer
Public UserPuedeRefrescar As Boolean
Public UserEstado As Byte '0 = Vivo & 1 = Muerto
Public UserPasarNivel As Long
Public UserExp As Long
Public UserReputacion As tReputacion
Public UserDescansar As Boolean
Public tipf As String
Public PrimeraVez As Boolean
Public FPSFLAG As Boolean
Public pausa As Boolean
Public IScombate As Boolean
Public ISseguro As Boolean
Public UserParalizado As Boolean
Public UserNavegando As Boolean
Public UserHogar As String

'<-------------------------NUEVO-------------------------->
Public Comerciando As Boolean
Public MD5HushYo As String * 16
Public MostrarIndexNombre As Integer
Public uPos As WorldPos
'<-------------------------NUEVO-------------------------->

Public UserClase As String
Public UserSexo As String
Public UserRaza As String
Public UserEmail As String

Public Musica As Byte
Public fX As Byte

Public SkillPoints As Integer
Public Alocados As Integer
Public flags() As Integer
Public Oscuridad As Integer
Public logged As Boolean
Public NoPuedeUsar As Boolean

Public UsingSkill As Integer


'Server stuff
Public RequestPosTimer As Integer 'Used in main loop
Public stxtbuffer As String 'Holds temp raw data from server
Public SendNewChar As Boolean 'Used during login
Public Connected As Boolean 'True when connected to server
Public DownloadingMap As Boolean 'Currently downloading a map from server
Public UserMap As Integer

'String contants
Public ENDC As String 'Endline character for talking with server
Public ENDL As String 'Holds the Endline character for textboxes

'Control
Public prgRun As Boolean 'When true the program ends
'Public finpres As Boolean

Public IPdelServidor As String
Public PuertoDelServidor As String

'********** FUNCIONES API ***********
Public Declare Function GetTickCount Lib "kernel32" () As Long

'para escribir y leer variables
Public Declare Function writeprivateprofilestring Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpfilename As String) As Long
Public Declare Function getprivateprofilestring Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpdefault As String, ByVal lpreturnedstring As String, ByVal nsize As Long, ByVal lpfilename As String) As Long

'Teclado
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

'Lista de cabezas
Public Type tIndiceCabeza
    head(1 To 4) As Long
End Type

Public Miscabezas() As tIndiceCabeza
Public MisCascos() As tIndiceCabeza

Public Type tIndiceCuerpo
    body(1 To 4) As Long
    HeadOffsetX As Integer
    HeadOffsetY As Integer
End Type

Public Type tIndiceFx
    Animacion As Long
    OffsetX As Integer
    OffsetY As Integer
End Type

'aCarga los txt de la web?
Public DescargarTxt(4) As Boolean


