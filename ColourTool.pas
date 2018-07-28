unit ColourTool;

//////////////////////////////////////////////////////////////////////////////
//
// Colour Tool,  2018 bombinho
//
//////////////////////////////////////////////////////////////////////////////

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Menus;

type
  TTool = class(TForm)
    Layout1: TLayout;
    Edit1: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    Label11: TLabel;
    Edit2: TEdit;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Label12: TLabel;
    Edit5: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    procedure Layout1Resize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label14MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure MenuItem5Click(Sender: TObject);
  private
    Spot: TAlphaColor;
    CRec: TColorRec;
    ARec: TAlphaColorRec;
    x, y: single;
    wasTColor: boolean;
    FColor :TColor;
    procedure process;
    procedure fillColor;
  public
    procedure ShowColor(const color: TAlphaColor; const message: string = ''); overload;
    procedure ShowColor(const color: TColor; const message: string = ''); overload;
  end;

var
  Tool: TTool;

implementation

{$R *.fmx}

type
  ColorScheme = (Aero, Classic);

  CSchemes = Array[0..29] of TColor;

  CScheme = record
    Name: String;
    Scheme: CSchemes;
  end;

  TWin8_1Schemes = array[0..4] of CScheme;
  TWin7Schemes = array[0..5] of CScheme;
  TWinVisSchemes = array[0..6] of CScheme;
  TWinXPSchemes = array[0..28] of CScheme;

Const
  Win8_1_Windows: CSchemes = ($B4B4B4, $99B4D1, $000000, $ABABAB,
                $F0F0F0, $A0A0A0, $696969, $E3E3E3, $FFFFFF, $000000,
                $000000, $B9D1EA, $D7E4F2, $6D6D6D, $3399FF, $FFFFFF,
                $0066CC, $F4F7FC, $BFCDDB, $000000, $FFFFE1, $000000,
                $F0F0F0, $F0F0F0, $3399FF, $000000, $C8C8C8, $FFFFFF,
                $646464, $000000);
  Win8_1_HighCont1: CSchemes = ($0000FF, $0000FF, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $0000FF, $00FFFF, $00FF00, $008000, $FFFFFF,
                $8080FF, $00FFFF, $00FFFF, $000000, $000000, $FFFF00,
                $000000, $000000, $008000, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFF00);
  Win8_1_HighCont2: CSchemes = ($00FFFF, $00FFFF, $000000, $FFFFFF,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $00FFFF, $0000FF, $C0C0C0, $0000FF, $FFFFFF,
                $8080FF, $0000FF, $000040, $FFFFFF, $FFFF00, $000000,
                $000000, $000000, $0000FF, $00FF00, $000000, $000000,
                $FFFFFF, $00FF00);
  Win8_1_HighContBlk: CSchemes = ($FFFF00, $37006E, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $800080, $008000, $3FF23F, $1AEBFF, $000000,
                $FFFF00, $008000, $00002F, $FFFFFF, $000000, $FFFFFF,
                $000000, $000000, $800080, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFFFF);
  Win8_1_HighContWht: CSchemes = ($808080, $000000, $FFFFFF, $808080,
                $FFFFFF, $808080, $000000, $C0C0C0, $C0C0C0, $000000,
                $FFFFFF, $000000, $FFFFFF, $600000, $37006E, $FFFFFF,
                $00009F, $C0C0C0, $FFFFFF, $000000, $FFFFFF, $000000,
                $FFFFFF, $FFFFFF, $000000, $000000, $FFFFFF, $FFFFFF,
                $000000, $000000);
  Win7_Aero: CSchemes = ($B4B4B4, $99B4D1, $000000, $ABABAB,
                $F0F0F0, $A0A0A0, $696969, $E3E3E3, $FFFFFF, $000000,
                $000000, $B9D1EA, $D7E4F2, $6D6D6D, $3399FF, $FFFFFF,
                $0066CC, $F4F7FC, $BFCDDB, $434E54, $FFFFE1, $000000,
                $F0F0F0, $F0F0F0, $3399FF, $000000, $C8C8C8, $FFFFFF,
                $646464, $000000);
  Win7_Classic: CSchemes = ($D4D0C8, $0A246A, $FFFFFF, $808080,
                $D4D0C8, $808080, $404040, $D4D0C8, $FFFFFF, $000000,
                $3A6EA5, $A6CAF0, $C0C0C0, $808080, $0A246A, $FFFFFF,
                $000080, $D4D0C8, $808080, $D4D0C8, $FFFFE1, $000000,
                $D4D0C8, $D4D0C8, $0A246A, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  Win7_HighCont1: CSchemes = ($0000FF, $0000FF, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $0000FF, $00FFFF, $00FF00, $008000, $FFFFFF,
                $8080FF, $00FFFF, $00FFFF, $000000, $000000, $FFFF00,
                $000000, $000000, $008000, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFF00);
  Win7_HighCont2: CSchemes = ($00FFFF, $00FFFF, $000000, $FFFFFF,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $00FF00,
                $000000, $00FFFF, $0000FF, $C0C0C0, $0000FF, $FFFFFF,
                $8080FF, $0000FF, $0000FF, $FFFFFF, $FFFF00, $000000,
                $000000, $000000, $0000FF, $00FF00, $000000, $000000,
                $FFFFFF, $00FF00);
  Win7_HighContBlk: CSchemes = ($FFFF00, $800080, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $800080, $008000, $00FF00, $800080, $FFFFFF,
                $8080FF, $008000, $008000, $FFFFFF, $000000, $FFFFFF,
                $000000, $000000, $800080, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFFFF);
  Win7_HighContWht: CSchemes = ($808080, $000000, $FFFFFF, $808080,
                $FFFFFF, $808080, $000000, $C0C0C0, $C0C0C0, $000000,
                $FFFFFF, $000000, $FFFFFF, $008000, $000000, $FFFFFF,
                $000000, $C0C0C0, $FFFFFF, $000000, $FFFFFF, $000000,
                $FFFFFF, $FFFFFF, $000000, $000000, $FFFFFF, $FFFFFF,
                $000000, $000000);
  WinVis_Aero: CSchemes = ($B4B4B4, $99B4D1, $000000, $ABABAB,
                $F0F0F0, $A0A0A0, $696969, $E3E3E3, $FFFFFF, $000000,
                $000000, $B9D1EA, $D7E4F2, $808080, $3399FF, $FFFFFF,
                $0066CC, $F4F7FC, $BFCDDB, $434E54, $FFFFE1, $000000,
                $F0F0F0, $F0F0F0, $3399FF, $000000, $C8C8C8, $FFFFFF,
                $646464, $000000);
  WinVis_ClassicStd: CSchemes = ($D4D0C8, $0A246A, $FFFFFF, $808080,
                $D4D0C8, $808080, $404040, $D4D0C8, $FFFFFF, $000000,
                $3A6EA5, $A6CAF0, $C0C0C0, $808080, $0A246A, $FFFFFF,
                $0066CC, $D4D0C8, $808080, $D4D0C8, $FFFFE1, $000000,
                $D4D0C8, $F0F0F0, $3399FF, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinVis_ClassicCla: CSchemes = ($C0C0C0, $000080, $FFFFFF, $808080,
                $C0C0C0, $808080, $000000, $C0C0C0, $FFFFFF, $000000,
                $3A6EA5, $1084D0, $B5B5B5, $808080, $000080, $FFFFFF,
                $000080, $C0C0C0, $808080, $C0C0C0, $FFFFE1, $000000,
                $C0C0C0, $C0C0C0, $000080, $000000, $C0C0C0, $FFFFFF,
                $000000, $000000);
  WinVis_HighCont1: CSchemes = ($0000FF, $0000FF, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $0000FF, $00FFFF, $00FF00, $008000, $FFFFFF,
                $8080FF, $00FFFF, $00FFFF, $000000, $000000, $FFFF00,
                $000000, $000000, $008000, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFF00);
  WinVis_HighCont2: CSchemes = ($00FFFF, $00FFFF, $000000, $FFFFFF,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $00FF00,
                $000000, $00FFFF, $0000FF, $C0C0C0, $0000FF, $FFFFFF,
                $8080FF, $0000FF, $0000FF, $FFFFFF, $FFFF00, $000000,
                $000000, $000000, $0000FF, $00FF00, $000000, $000000,
                $FFFFFF, $00FF00);
  WinVis_HighContBlk: CSchemes = ($FFFF00, $800080, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $800080, $008000, $00FF00, $800080, $FFFFFF,
                $8080FF, $008000, $008000, $FFFFFF, $000000, $FFFFFF,
                $000000, $000000, $800080, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFFFF);
  WinVis_HighContWht: CSchemes = ($808080, $000000, $FFFFFF, $808080,
                $FFFFFF, $808080, $000000, $C0C0C0, $C0C0C0, $000000,
                $FFFFFF, $000000, $FFFFFF, $00FF00, $000000, $FFFFFF,
                $000000, $C0C0C0, $FFFFFF, $000000, $FFFFFF, $000000,
                $FFFFFF, $FFFFFF, $000000, $000000, $FFFFFF, $FFFFFF,
                $000000, $000000);
  WinXP_Luna: CSchemes = ($D4D0C8, $0054E3, $FFFFFF, $808080,
                $ECE9D8, $ACA899, $716F64, $F1EFE2, $FFFFFF, $000000,
                $004E98, $3D95FF, $9DB9EB, $ACA899, $316AC5, $FFFFFF,
                $000080, $D4D0C8, $7A96DF, $D8E4F8, $FFFFE1, $000000,
                $FFFFFF, $ECE9D8, $316AC5, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_LunaSilver: CSchemes = ($D4D0C8, $C0C0C0, $0E1010, $808080,
                $E0DFE3, $9D9DA1, $716F64, $F1EFE2, $FFFFFF, $000000,
                $585768, $C8C8C8, $EEEFF7, $ACA899, $B2B4BF, $000000,
                $648BCB, $D4D0C8, $FFFFFF, $A2A1A1, $FFFFE1, $000000,
                $FFFFFF, $E0E2EB, $BBB7C7, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_LunaOlive: CSchemes = ($D4D0C8, $8BA169, $FFFFFF, $808080,
                $ECE9D8, $ACA899, $716F64, $F1EFE2, $FFFFFF, $000000,
                $9DACBD, $C6D2A2, $D4D6BA, $ACA899, $93A070, $FFFFFF,
                $000080, $D4D0C8, $D4D6BA, $FFFFFF, $FFFFE1, $000000,
                $FFFFFF, $ECE9D8, $93A070, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_Royal: CSchemes = ($D4D0C8, $335EA8, $FFFFFF, $808080,
                $EBE9ED, $A7A6AA, $85878C, $DCDFE4, $FFFFFF, $000000,
                $000040, $70B1EB, $83B7E3, $A7A6AA, $335EA8, $FFFFFF,
                $000080, $D4D0C8, $6FA1D9, $FFFFFF, $FFFFE1, $000000,
                $FFFFFF, $EBE9ED, $335EA8, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_RoyalNoir: CSchemes = ($D4D0C8, $5E81BC, $FFFFFF, $808080,
                $EBE9ED, $A7A6AA, $85878C, $DCDFE4, $FFFFFF, $000000,
                $101A26, $70B1EB, $83B7E3, $A7A6AA, $5E81BC, $FFFFFF,
                $000080, $D4D0C8, $6FA1D9, $FFFFFF, $FFFFE1, $000000,
                $FFFFFF, $EBE9ED, $5E81BC, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_Zune: CSchemes = ($D4D0C8, $343434, $FFFFFF, $808080,
                $E2E2E2, $B4B4B4, $878787, $E2E2E2, $FFFFFF, $000000,
                $1A1A1A, $747474, $C8C8C8, $646464, $BEBEBE, $000000,
                $000080, $D4D0C8, $747474, $F4F4F4, $FFFFE1, $000000,
                $FFFFFF, $DCDCDC, $BEBEBE, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_Embedded: CSchemes = ($D4D0C8, $3E9DE8, $FFFFFF, $808080,
                $EBE9ED, $B5B4B8, $85878C, $DCDFE4, $FFFFFF, $000000,
                $000040, $70B1EB, $83B7E3, $B5B4B8, $3E9DE8, $FFFFFF,
                $000080, $D4D0C8, $6FA1D9, $FFFFFF, $FFFFE1, $000000,
                $FFFFFF, $EBE9ED, $3E9DE8, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_ClassicStd: CSchemes = ($D4D0C8, $0A246A, $FFFFFF, $808080,
                $D4D0C8, $808080, $404040, $D4D0C8, $FFFFFF, $000000,
                $3A6EA5, $A6CAF0, $C0C0C0, $808080, $0A246A, $FFFFFF,
                $000080, $D4D0C8, $808080, $D4D0C8, $FFFFE1, $000000,
                $D4D0C8, $D4D0C8, $0A246A, $000000, $D4D0C8, $FFFFFF,
                $000000, $000000);
  WinXP_ClassicClas: CSchemes = ($C0C0C0, $000080, $FFFFFF, $808080,
                $C0C0C0, $808080, $000000, $C0C0C0, $FFFFFF, $000000,
                $3A6EA5, $1084D0, $B5B5B5, $808080, $000080, $FFFFFF,
                $000080, $C0C0C0, $808080, $C0C0C0, $FFFFE1, $000000,
                $C0C0C0, $C0C0C0, $000080, $000000, $C0C0C0, $FFFFFF,
                $000000, $000000);
  WinXP_Brick: CSchemes = ($C2BFA5, $800000, $E1E0D2, $E1E0D2,
                $C2BFA5, $8D8961, $000000, $C2BFA5, $E1E0D2, $000000,
                $420000, $B07440, $C8B870, $8D8961, $8D8961, $FFFFFF,
                $800000, $C2BFA5, $8D8961, $E1E0D2, $E1E0D2, $800000,
                $C2BFA5, $C2BFA5, $8D8961, $000000, $E1E0D2, $FFFFFF,
                $000000, $000000);
  WinXP_Desert: CSchemes = ($D5CCBB, $008080, $FFFFFF, $A28D68,
                $D5CCBB, $A28D68, $000000, $D5CCBB, $EAE6DD, $000000,
                $A28D68, $84BDAA, $E8D080, $A28D68, $008080, $FFFFFF,
                $008080, $D5CCBB, $A28D68, $FFFFFF, $FFFFFF, $000000,
                $D5CCBB, $D5CCBB, $008080, $000000, $EAE6DD, $FFFFFF,
                $000000, $000000);
  WinXP_EggPlant: CSchemes = ($90B0A8, $588078, $FFFFFF, $808080,
                $90B0A8, $588078, $000000, $90B0A8, $C8D8D8, $000000,
                $400040, $834B83, $CBBDD2, $588078, $588078, $FFFFFF,
                $588078, $90B0A8, $90B0A8, $588078, $FFFFFF, $800080,
                $90B0A8, $90B0A8, $588078, $000000, $90B0A8, $FFFFFF,
                $000000, $000000);
  WinXP_Lilac: CSchemes = ($AEA8D9, $5A4EB1, $FFFFFF, $5A4EB1,
                $AEA8D9, $5A4EB1, $000000, $AEA8D9, $D8D5EC, $000000,
                $000000, $B68FCB, $B8B4D0, $5A4EB1, $5A4EB1, $FFFFFF,
                $5A4EB1, $AEA8D9, $808080, $FFFFFF, $FFFFFF, $000000,
                $AEA8D9, $AEA8D9, $5A4EB1, $000000, $AEA8D9, $FFFFFF,
                $000000, $000000);
  WinXP_Maple: CSchemes = ($E6D8AE, $800000, $FFFFFF, $C6A646,
                $E6D8AE, $C6A646, $000000, $E6D8AE, $F2ECD7, $000000,
                $000000, $C09C38, $E0C888, $C6A646, $C6A646, $000000,
                $C6A646, $E6D8AE, $C6A646, $F2ECD7, $FFFFFF, $000000,
                $E6D8AE, $E6D8AE, $C6A646, $000000, $F2ECD7, $FFFFFF,
                $000000, $000000);
  WinXP_Marine: CSchemes = ($88C0B8, $000080, $FFFFFF, $4B8D84,
                $88C0B8, $489088, $000000, $88C0B8, $C8E0D8, $000000,
                $2C4E47, $18B4C0, $78CCD8, $489088, $000080, $FFFFFF,
                $000080, $88C0B8, $489088, $C0C0C0, $C8E0D8, $000000,
                $88C0B8, $88C0B8, $000080, $000000, $C8E0D8, $C8E0D8,
                $000000, $000000);
  WinXP_Plum: CSchemes = ($A89890, $484060, $FFFFFF, $74635A,
                $A89890, $786058, $000000, $A89890, $D8D0C8, $000000,
                $402840, $A084B8, $A89878, $786058, $008080, $D8D0C8,
                $484060, $A89890, $786058, $A89890, $D5CCC8, $300058,
                $A89890, $A89890, $008080, $000000, $D8D0C8, $D8D0C8,
                $000000, $000000);
  WinXP_Pumpkin: CSchemes = ($ECD59D, $D7A52F, $FFFFFF, $F5EACF,
                $ECD59D, $D7A52F, $000000, $ECD59D, $F5EACF, $000000,
                $420042, $E0CC88, $D0CC90, $D7A52F, $800080, $FFFFFF,
                $D7A52F, $ECD59D, $A0A0A4, $F5EACF, $FFFFFF, $800080,
                $ECD59D, $ECD59D, $800080, $000000, $F5EACF, $FFFFFF,
                $000000, $000000);
  WinXP_RainyDay: CSchemes = ($8399B1, $4F657D, $FFFFFF, $808080,
                $8399B1, $4F657D, $000000, $8399B1, $C1CCD9, $000000,
                $000000, $80B4D0, $B0BCD0, $4F657D, $4F657D, $FFFFFF,
                $4F657D, $8399B1, $808080, $C1CCD9, $FFFFFF, $000000,
                $8399B1, $8399B1, $4F657D, $000000, $C1CCD9, $FFFFFF,
                $000000, $000000);
  WinXP_RedWhtBlue: CSchemes = ($C0C0C0, $800000, $FFFFFF, $FFFFFF,
                $C0C0C0, $808080, $000000, $C0C0C0, $FFFFFF, $000000,
                $000042, $0010A8, $BABEC9, $808080, $800000, $FFFFFF,
                $800000, $C0C0C0, $808080, $C0C0C0, $FFFFFF, $000080,
                $C0C0C0, $C0C0C0, $800000, $000000, $C0C0C0, $FFFFFF,
                $000000, $000000);
  WinXP_Rose: CSchemes = ($CFAFB7, $9F6070, $FFFFFF, $9F6070,
                $CFAFB7, $9F6070, $000000, $CFAFB7, $E7D8DC, $000000,
                $808080, $D8CCD0, $D0D4D0, $9F6070, $9F6070, $FFFFFF,
                $9F6070, $CFAFB7, $A0A0A4, $7D7D7D, $FFFFFF, $000000,
                $CFAFB7, $CFAFB7, $9F6070, $000000, $CFAFB7, $FFFFFF,
                $000000, $000000);
  WinXP_Slate: CSchemes = ($9DB9C8, $558097, $FFFFFF, $424242,
                $9DB9C8, $558097, $000000, $9DB9C8, $CEDCE3, $000000,
                $414141, $88B8D8, $A0BCC8, $558097, $558097, $FFFFFF,
                $558097, $9DB9C8, $808080, $C0C0C0, $FFFFFF, $000000,
                $9DB9C8, $9DB9C8, $558097, $000000, $CEDCE3, $FFFFFF,
                $000000, $000000);
  WinXP_Spruce: CSchemes = ($A2C8A9, $599764, $FFFFFF, $D0E3D3,
                $A2C8A9, $599764, $000000, $A2C8A9, $D0E3D3, $000000,
                $213F21, $98C8E8, $A8CCB0, $599764, $599764, $FFFFFF,
                $599764, $A2C8A9, $808080, $D0E3D3, $FFFFFF, $000000,
                $A2C8A9, $A2C8A9, $599764, $000000, $D0E3D3, $FFFFFF,
                $000000, $000000);
  WinXP_Storm: CSchemes = ($C0C0C0, $800080, $FFFFFF, $808080,
                $C0C0C0, $808080, $000000, $C0C0C0, $FFFFFF, $000000,
                $000000, $388CB0, $A8ACA8, $808080, $800080, $FFFFFF,
                $800080, $C0C0C0, $808080, $C0C0C0, $FFFFFF, $800080,
                $C0C0C0, $C0C0C0, $800080, $000000, $C0C0C0, $FFFFFF,
                $000000, $000000);
  WinXP_Teal: CSchemes = ($C0C0C0, $008080, $FFFFFF, $808080,
                $C0C0C0, $808080, $000000, $C0C0C0, $FFFFFF, $000000,
                $004040, $00CCD8, $98C8B8, $808080, $008080, $FFFFFF,
                $008080, $C0C0C0, $808080, $FFFBF0, $FFFFFF, $000000,
                $C0C0C0, $C0C0C0, $008080, $000000, $C0C0C0, $FFFFFF,
                $000000, $000000);
  WinXP_Wheat: CSchemes = ($DEDEA0, $808000, $FFFFFF, $BCBC41,
                $DEDEA0, $BCBC41, $000000, $DEDEA0, $EEEED0, $000000,
                $00401D, $C8B048, $B8B880, $BCBC41, $808000, $FFFFFF,
                $808000, $DEDEA0, $BCBC41, $FFFFFF, $FFFFFF, $000000,
                $DEDEA0, $DEDEA0, $808000, $000000, $EEEED0, $FFFFFF,
                $000000, $000000);
  WinXP_HighCont1: CSchemes = ($0000FF, $0000FF, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $0000FF, $00FFFF, $00FF00, $008000, $FFFFFF,
                $800080, $00FFFF, $00FFFF, $000000, $000000, $FFFF00,
                $000000, $000000, $008000, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFF00);
  WinXP_HighCont2: CSchemes = ($00FFFF, $00FFFF, $000000, $FFFFFF,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $00FF00,
                $000000, $00FFFF, $0000FF, $00FF00, $0000FF, $FFFFFF,
                $800080, $0000FF, $0000FF, $FFFFFF, $FFFF00, $000000,
                $000000, $000000, $0000FF, $00FF00, $000000, $000000,
                $FFFFFF, $00FF00);
  WinXP_HighContBlk: CSchemes = ($FFFF00, $800080, $FFFFFF, $000000,
                $000000, $808080, $FFFFFF, $FFFFFF, $C0C0C0, $FFFFFF,
                $000000, $800080, $008000, $00FF00, $800080, $FFFFFF,
                $800080, $008000, $008000, $FFFFFF, $000000, $FFFFFF,
                $000000, $000000, $800080, $FFFFFF, $000000, $000000,
                $FFFFFF, $FFFFFF);
  WinXP_HighContWht: CSchemes = ($808080, $000000, $FFFFFF, $808080,
                $FFFFFF, $808080, $000000, $C0C0C0, $C0C0C0, $000000,
                $FFFFFF, $000000, $FFFFFF, $00FF00, $000000, $FFFFFF,
                $000000, $C0C0C0, $FFFFFF, $000000, $FFFFFF, $000000,
                $FFFFFF, $FFFFFF, $000000, $000000, $FFFFFF, $FFFFFF,
                $000000, $000000);
var
  Win8Schemes: TWin8_1Schemes;
  Win7Schemes: TWin7Schemes;
  WinVisSchemes: TWinVisSchemes;
  WinXPSchemes: TWinXPSchemes;
  SC: CSchemes;

function GetSysColor(const Value: integer; const Scheme: ColorScheme): TColorRec; forward;
function ColorToAlphaColor(const value: TColor): TAlphaColor; forward;
function AlphaColorName(const value: TAlphaColor): string; forward;
function TColorName(const value: TAlphaColor): string; forward;

procedure TTool.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TTool.fillColor;
begin
  x := PaintBox1.Position.X;
  y := PaintBox1.Position.Y;
  PaintBox1.Repaint;
end;

procedure TTool.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 0 to 4 do
  begin
    popupmenu1.Items[0].Items[i].Text:= Win8Schemes[i].Name;
    popupMenu1.Items[0].Items[i].OnClick := MenuItem5Click;
    popupMenu1.Items[0].Items[i].Name := 'Win8' + inttostr(i);
  end;
  for i := 0 to 5 do
  begin
    popupmenu1.Items[1].Items[i].Text:= Win7Schemes[i].Name;
    popupMenu1.Items[1].Items[i].OnClick := MenuItem5Click;
    popupMenu1.Items[1].Items[i].Name := 'Win7' + inttostr(i);
  end;
  for i := 0 to 6 do
  begin
    popupmenu1.Items[2].Items[i].Text:= WinVisSchemes[i].Name;
    popupMenu1.Items[2].Items[i].OnClick := MenuItem5Click;
    popupMenu1.Items[2].Items[i].Name := 'WinV' + inttostr(i);
  end;
  for i := 0 to 28 do
  begin
    popupmenu1.Items[3].Items[i].Text:= WinXPSchemes[i].Name;
    popupMenu1.Items[3].Items[i].OnClick := MenuItem5Click;
    popupMenu1.Items[3].Items[i].Name := 'WinX' + inttostr(i);
  end;
end;

procedure TTool.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
var r: TRectF;
begin
  r := PaintBox1.ClipRect;
//  R.Create(x, y, x + PaintBox1.Width, y + PaintBox1.Height);
  Canvas.Fill.Kind := TBrushKind.Solid;
  Canvas.Fill.Color := Spot;
  Canvas.FillRect(r, 0, 0, AllCorners, 100);
end;

procedure TTool.process;
begin
  Label7.Text := inttostr(ARec.A);
  Label8.Text := inttostr(ARec.R);
  Label9.Text := inttostr(ARec.G);
  Label10.Text := inttostr(ARec.B);
  Edit1.Text := inttostr(ARec.Color);
  Edit3.Text := inttostr(CRec.Color);
  edit2.Text := '$' + inttohex(ARec.Color, 1);
  edit4.Text := '$' + inttohex(CRec.Color, 1);
  fillColor;
end;

procedure TTool.ShowColor(const color: TColor; const message: string = '');
begin
  CRec.Color := color;
  ARec.A := CRec.A;
  ARec.B := CRec.B;
  ARec.G := CRec.G;
  ARec.R := CRec.R;
  wasTColor := true;
  FColor := color;
  spot := ColorToAlphaColor(color);
  process;
  edit5.Text := TColorName(color);
  Label12.Text := message;
  if color  < 0 then label14.Visible := true;

  Tool.ShowModal;
end;

procedure TTool.ShowColor(const color: TAlphaColor; const message: string = '');
begin
  ARec.Color := color;
  CRec.A := 0;
  CRec.B := ARec.B;
  CRec.G := ARec.G;
  CRec.R := ARec.R;
  wasTColor := false;
  spot := color;
  process;
  edit5.Text := AlphaColorName(color);
  Label12.Text := message;
  Label14.Visible := false;
  Tool.ShowModal;
end;


procedure TTool.Label14MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  popupMenu1.Popup(paintBox1.ClipRect.BottomRight.X, paintBox1.ClipRect.BottomRight.y);
end;

procedure TTool.Layout1Resize(Sender: TObject);
var x, y: single;
begin
  Layout1.Height := Height;
  x := width / 408;
  y := height / 280;
  if x > y then x := y;
  Layout1.Scale.X := x;
  Layout1.Scale.y := x;

end;

procedure TTool.MenuItem5Click(Sender: TObject);
var s: string;
begin
  s := TMenuItem(Sender).Name;
  if copy(s, 0, 4) = 'Win8' then
    sc := Win8Schemes[strtointdef(copy(s,5), 0)].Scheme;
  if copy(s, 0, 4) = 'Win7' then
    sc := Win7Schemes[strtointdef(copy(s,5), 0)].Scheme;
  if copy(s, 0, 4) = 'WinV' then
    sc := WinVisSchemes[strtointdef(copy(s,5), 0)].Scheme;
  if copy(s, 0, 4) = 'WinX' then
    sc := WinXPSchemes[strtointdef(copy(s,5), 0)].Scheme;
  if wasTColor then
  begin
    spot := ColorToAlphaColor(FColor);
    fillColor;
  end;

end;

function GetSysColor(const Value: integer; const Scheme: ColorScheme): TColorRec;
var i: integer;
begin
  case value of
    0:  result.Color := sc[26];     // 'clScrollBar';
    1:  result.Color := sc[10];     // 'clBackground';
    2:  result.Color := sc[1 ];     // 'clActiveCaption';
    3:  result.Color := sc[18];     // 'clInactiveCaption';
    4:  result.Color := sc[22];     // 'clMenu';
    5:  result.Color := sc[27];     // 'clWindow';
    6:  result.Color := sc[28];     // 'clWindowFrame';
    7:  result.Color := sc[25];     // 'clMenuText';
    8:  result.Color := sc[29];     // 'clWindowText';
    9:  result.Color := sc[2 ];     // 'clCaptionText';
    10: result.Color := sc[0 ];     // 'clActiveBorder';
    11: result.Color := sc[17];     // 'clInactiveBorder';
    12: result.Color := sc[3 ];     // 'clAppWorkSpace';
    13: result.Color := sc[14];     // 'clHighlight';
    14: result.Color := sc[15];     // 'clHighlightText';
    15: result.Color := sc[4 ];     // 'clBtnFace';
    16: result.Color := sc[5 ];     // 'clBtnShadow';
    17: result.Color := sc[13];     // 'clGrayText';
    18: result.Color := sc[9 ];     // 'clBtnText';
    19: result.Color := sc[19];     // 'clInactiveCaptionText';
    20: result.Color := sc[8 ];     // 'clBtnHighlight';
    21: result.Color := sc[6 ];     // 'cl3DDkShadow';
    22: result.Color := sc[7 ];     // 'cl3DLight';
    23: result.Color := sc[21];     // 'clInfoText';
    24: result.Color := sc[20];     // 'clInfoBk';
    26: result.Color := sc[16];     // 'clHotLight';
    27: result.Color := sc[11];     // 'clGradientActiveCaption';
    28: result.Color := sc[12];     // 'clGradientInactiveCaption';
    29: result.Color := sc[24];     // 'clMenuHighlight';
    30: result.Color := sc[23];     // 'clMenuBar';
  end;
  i := result.Color;
  result.A := i shr 24;
  result.R := (i shr 16) and $FF;
  result.G := (i shr 8) and $FF;
  result.B := i and $FF;
  //result.A := 255;
end;

function ColorToAlphaColor(const value: TColor): TAlphaColor;
var
   CRec: TColorRec;
   ARec: TAlphaColorRec;
begin
  if value = 0 then
    result := TAlphaColors.Black
  else
  begin
    CRec.Color := Value;
    if CRec.Color < 0 then
      CRec := GetSysColor(CRec.Color and $FF, ColorScheme.Aero);
    ARec.A := 255;
    ARec.B := CRec.B;
    ARec.G := CRec.G;
    ARec.R := CRec.R;
    Result := ARec.Color;
  end;
end;

function AlphaColorName(const value: TAlphaColor): string;
begin
  case value of
    $FFF0F8FF: result := 'claAliceblue';
    $FFFAEBD7: result := 'claAntiquewhite';
    $FF00FFFF: result := 'claAqua';
    $FF7FFFD4: result := 'claAquamarine';
    $FFF0FFFF: result := 'claAzure';
    $FFF5F5DC: result := 'claBeige';
    $FFFFE4C4: result := 'claBisque';
    $FF000000: result := 'claBlack';
    $FFFFEBCD: result := 'claBlanchedalmond';
    $FF0000FF: result := 'claBlue';
    $FF8A2BE2: result := 'claBlueviolet';
    $FFA52A2A: result := 'claBrown';
    $FFDEB887: result := 'claBurlywood';
    $FF5F9EA0: result := 'claCadetblue';
    $FF7FFF00: result := 'claChartreuse';
    $FFD2691E: result := 'claChocolate';
    $FFFF7F50: result := 'claCoral';
    $FF6495ED: result := 'claCornflowerblue';
    $FFFFF8DC: result := 'claCornsilk';
    $FFDC143C: result := 'claCrimson';
 //   $FF00FFFF: result := 'claCyan';
    $FF00008B: result := 'claDarkblue';
    $FF008B8B: result := 'claDarkcyan';
    $FFB8860B: result := 'claDarkgoldenrod';
    $FFA9A9A9: result := 'claDarkgray';
    $FF006400: result := 'claDarkgreen';
 //   $FFA9A9A9: result := 'claDarkgrey';
    $FFBDB76B: result := 'claDarkkhaki';
    $FF8B008B: result := 'claDarkmagenta';
    $FF556B2F: result := 'claDarkolivegreen';
    $FFFF8C00: result := 'claDarkorange';
    $FF9932CC: result := 'claDarkorchid';
    $FF8B0000: result := 'claDarkred';
    $FFE9967A: result := 'claDarksalmon';
    $FF8FBC8F: result := 'claDarkseagreen';
    $FF483D8B: result := 'claDarkslateblue';
    $FF2F4F4F: result := 'claDarkslategray';
//    $FF2F4F4F: result := 'claDarkslategrey';
    $FF00CED1: result := 'claDarkturquoise';
    $FF9400D3: result := 'claDarkviolet';
    $FFFF1493: result := 'claDeeppink';
    $FF00BFFF: result := 'claDeepskyblue';
    $FF696969: result := 'claDimgray';
//    $FF696969: result := 'claDimgrey';
    $FF1E90FF: result := 'claDodgerblue';
    $FFB22222: result := 'claFirebrick';
    $FFFFFAF0: result := 'claFloralwhite';
    $FF228B22: result := 'claForestgreen';
    $FFFF00FF: result := 'claFuchsia';
    $FFDCDCDC: result := 'claGainsboro';
    $FFF8F8FF: result := 'claGhostwhite';
    $FFFFD700: result := 'claGold';
    $FFDAA520: result := 'claGoldenrod';
    $FF808080: result := 'claGray';
    $FF008000: result := 'claGreen';
    $FFADFF2F: result := 'claGreenyellow';
//    $FF808080: result := 'claGrey';
    $FFF0FFF0: result := 'claHoneydew';
    $FFFF69B4: result := 'claHotpink';
    $FFCD5C5C: result := 'claIndianred';
    $FF4B0082: result := 'claIndigo';
    $FFFFFFF0: result := 'claIvory';
    $FFF0E68C: result := 'claKhaki';
    $FFE6E6FA: result := 'claLavender';
    $FFFFF0F5: result := 'claLavenderblush';
    $FF7CFC00: result := 'claLawngreen';
    $FFFFFACD: result := 'claLemonchiffon';
    $FFADD8E6: result := 'claLightblue';
    $FFF08080: result := 'claLightcoral';
    $FFE0FFFF: result := 'claLightcyan';
    $FFFAFAD2: result := 'claLightgoldenrodyellow';
    $FFD3D3D3: result := 'claLightgray';
    $FF90EE90: result := 'claLightgreen';
//    $FFD3D3D3: result := 'claLightgrey';
    $FFFFB6C1: result := 'claLightpink';
    $FFFFA07A: result := 'claLightsalmon';
    $FF20B2AA: result := 'claLightseagreen';
    $FF87CEFA: result := 'claLightskyblue';
    $FF778899: result := 'claLightslategray';
//    $FF778899: result := 'claLightslategrey';
    $FFB0C4DE: result := 'claLightsteelblue';
    $FFFFFFE0: result := 'claLightyellow';
    $FF00FF00: result := 'claLime';
    $FF32CD32: result := 'claLimegreen';
    $FFFAF0E6: result := 'claLinen';
 //   $FFFF00FF: result := 'claMagenta';
    $FF800000: result := 'claMaroon';
    $FF66CDAA: result := 'claMediumaquamarine';
    $FF0000CD: result := 'claMediumblue';
    $FFBA55D3: result := 'claMediumorchid';
    $FF9370DB: result := 'claMediumpurple';
    $FF3CB371: result := 'claMediumseagreen';
    $FF7B68EE: result := 'claMediumslateblue';
    $FF00FA9A: result := 'claMediumspringgreen';
    $FF48D1CC: result := 'claMediumturquoise';
    $FFC71585: result := 'claMediumvioletred';
    $FF191970: result := 'claMidnightblue';
    $FFF5FFFA: result := 'claMintcream';
    $FFFFE4E1: result := 'claMistyrose';
    $FFFFE4B5: result := 'claMoccasin';
    $FFFFDEAD: result := 'claNavajowhite';
    $FF000080: result := 'claNavy';
            0: result := 'claNull';
    $FFFDF5E6: result := 'claOldlace';
    $FF808000: result := 'claOlive';
    $FF6B8E23: result := 'claOlivedrab';
    $FFFFA500: result := 'claOrange';
    $FFFF4500: result := 'claOrangered';
    $FFDA70D6: result := 'claOrchid';
    $FFEEE8AA: result := 'claPalegoldenrod';
    $FF98FB98: result := 'claPalegreen';
    $FFAFEEEE: result := 'claPaleturquoise';
    $FFDB7093: result := 'claPalevioletred';
    $FFFFEFD5: result := 'claPapayawhip';
    $FFFFDAB9: result := 'claPeachpuff';
    $FFCD853F: result := 'claPeru';
    $FFFFC0CB: result := 'claPink';
    $FFDDA0DD: result := 'claPlum';
    $FFB0E0E6: result := 'claPowderblue';
    $FF800080: result := 'claPurple';
    $FFFF0000: result := 'claRed';
    $FFBC8F8F: result := 'claRosybrown';
    $FF4169E1: result := 'claRoyalblue';
    $FF8B4513: result := 'claSaddlebrown';
    $FFFA8072: result := 'claSalmon';
    $FFF4A460: result := 'claSandybrown';
    $FF2E8B57: result := 'claSeagreen';
    $FFFFF5EE: result := 'claSeashell';
    $FFA0522D: result := 'claSienna';
    $FFC0C0C0: result := 'claSilver';
    $FF87CEEB: result := 'claSkyblue';
    $FF6A5ACD: result := 'claSlateblue';
    $FF708090: result := 'claSlategray';
//    $FF708090: result := 'claSlategrey';
    $FFFFFAFA: result := 'claSnow';
    $FF00FF7F: result := 'claSpringgreen';
    $FF4682B4: result := 'claSteelblue';
    $FFD2B48C: result := 'claTan';
    $FF008080: result := 'claTeal';
    $FFD8BFD8: result := 'claThistle';
    $FFFF6347: result := 'claTomato';
    $FF40E0D0: result := 'claTurquoise';
    $FFEE82EE: result := 'claViolet';
    $FFF5DEB3: result := 'claWheat';
    $FFFFFFFF: result := 'claWhite';
    $FFF5F5F5: result := 'claWhitesmoke';
    $FFFFFF00: result := 'claYellow';
    $FF9ACD32: result := 'claYellowgreen';
    else
      result := 'unknown';
  end;
end;

function TColorName(const value: TAlphaColor): string;
begin
  case value of
    $1FFFFFFF: result := 'clNone';
    $FFFF00: result := 'clAqua';
    $000000: result := 'clBlack';
    $FF0000: result := 'clBlue';
    $F0FBFF: result := 'clCream';
    $808080: result := 'clDkGray';
    $FF00FF: result := 'clFuchsia';
//    $808080: result := 'clGray';
    $008000: result := 'clGreen';
    $00FF00: result := 'clLime';
    $C0C0C0: result := 'clLtGray';
    $000080: result := 'clMaroon';
    $A4A0A0: result := 'clMedGray';
    $C0DCC0: result := 'clMoneyGreen';
    $800000: result := 'clNavy';
    $008080: result := 'clOlive';
    $800080: result := 'clPurple';
    $0000FF: result := 'clRed';
//    $C0C0C0: result := 'clSilver';
    $F0CAA6: result := 'clSkyBlue';
    $808000: result := 'clTeal';
    $FFFFFF: result := 'clWhite';
    $00FFFF: result := 'clYellow';

    $FAFAFF: result := 'clWebSnow';
    $F0FAFF: result := 'clWebFloralWhite';
    $F5F0FF: result := 'clWebLavenderBlush';
    $E6F5FD: result := 'clWebOldLace';
    $F0FFFF: result := 'clWebIvory';
    $DCF8FF: result := 'clWebCornSilk';
    $DCF5F5: result := 'clWebBeige';
    $D7EBFA: result := 'clWebAntiqueWhite';
    $B3DEF5: result := 'clWebWheat';
    $FFF8F0: result := 'clWebAliceBlue';
    $FFF8F8: result := 'clWebGhostWhite';
    $FAE6E6: result := 'clWebLavender';
    $EEF5FF: result := 'clWebSeashell';
    $E0FFFF: result := 'clWebLightYellow';
    $D5EFFF: result := 'clWebPapayaWhip';
    $ADDEFF: result := 'clWebNavajoWhite';
    $B5E4FF: result := 'clWebMoccasin';
    $87B8DE: result := 'clWebBurlywood';
    $FFFFF0: result := 'clWebAzure';
    $FAFFF5: result := 'clWebMintcream';
    $F0FFF0: result := 'clWebHoneydew';
    $E6F0FA: result := 'clWebLinen';
    $CDFAFF: result := 'clWebLemonChiffon';
    $CDEBFF: result := 'clWebBlanchedAlmond';
    $C4E4FF: result := 'clWebBisque';
    $B9DAFF: result := 'clWebPeachPuff';
    $8CB4D2: result := 'clWebTan';
//    $00FFFF: result := 'clWebYellow';
    $008CFF: result := 'clWebDarkOrange';
//    $0000FF: result := 'clWebRed';
    $00008B: result := 'clWebDarkRed';
//    $000080: result := 'clWebMaroon';
    $5C5CCD: result := 'clWebIndianRed';
    $7280FA: result := 'clWebSalmon';
    $507FFF: result := 'clWebCoral';
    $00D7FF: result := 'clWebGold';
    $4763FF: result := 'clWebTomato';
    $3C14DC: result := 'clWebCrimson';
    $2A2AA5: result := 'clWebBrown';
    $1E69D2: result := 'clWebChocolate';
    $60A4F4: result := 'clWebSandyBrown';
    $7AA0FF: result := 'clWebLightSalmon';
    $8080F0: result := 'clWebLightCoral';
    $00A5FF: result := 'clWebOrange';
    $0045FF: result := 'clWebOrangeRed';
    $2222B2: result := 'clWebFirebrick';
    $13458B: result := 'clWebSaddleBrown';
    $2D52A0: result := 'clWebSienna';
    $3F85CD: result := 'clWebPeru';
    $7A96E9: result := 'clWebDarkSalmon';
    $8F8FBC: result := 'clWebRosyBrown';
    $AAE8EE: result := 'clWebPaleGoldenrod';
    $D2FAFA: result := 'clWebLightGoldenrodYellow';
//    $008080: result := 'clWebOlive';
    $228B22: result := 'clWebForestGreen';
    $2FFFAD: result := 'clWebGreenYellow';
    $00FF7F: result := 'clWebChartreuse';
    $90EE90: result := 'clWebLightGreen';
    $D4FF7F: result := 'clWebAquamarine';
    $578B2E: result := 'clWebSeaGreen';
    $20A5DA: result := 'clWebGoldenRod';
    $8CE6F0: result := 'clWebKhaki';
    $238E6B: result := 'clWebOliveDrab';
//    $008000: result := 'clWebGreen';
    $32CD9A: result := 'clWebYellowGreen';
    $00FC7C: result := 'clWebLawnGreen';
    $98FB98: result := 'clWebPaleGreen';
    $AACD66: result := 'clWebMediumAquamarine';
    $71B33C: result := 'clWebMediumSeaGreen';
    $0B86B8: result := 'clWebDarkGoldenRod';
    $6BB7BD: result := 'clWebDarkKhaki';
    $2F6B55: result := 'clWebDarkOliveGreen';
    $006400: result := 'clWebDarkgreen';
    $32CD32: result := 'clWebLimeGreen';
//    $00FF00: result := 'clWebLime';
    $7FFF00: result := 'clWebSpringGreen';
    $9AFA00: result := 'clWebMediumSpringGreen';
    $8FBC8F: result := 'clWebDarkSeaGreen';
    $AAB220: result := 'clWebLightSeaGreen';
    $EEEEAF: result := 'clWebPaleTurquoise';
    $FFFFE0: result := 'clWebLightCyan';
    $E6D8AD: result := 'clWebLightBlue';
    $FACE87: result := 'clWebLightSkyBlue';
    $ED9564: result := 'clWebCornFlowerBlue';
    $8B0000: result := 'clWebDarkBlue';
    $82004B: result := 'clWebIndigo';
    $CCD148: result := 'clWebMediumTurquoise';
    $D0E040: result := 'clWebTurquoise';
//    $FFFF00: result := 'clWebCyan';
//    $FFFF00: result := 'clWebAqua';
    $E6E0B0: result := 'clWebPowderBlue';
    $EBCE87: result := 'clWebSkyBlue';
    $E16941: result := 'clWebRoyalBlue';
    $CD0000: result := 'clWebMediumBlue';
    $701919: result := 'clWebMidnightBlue';
    $D1CE00: result := 'clWebDarkTurquoise';
    $A09E5F: result := 'clWebCadetBlue';
    $8B8B00: result := 'clWebDarkCyan';
//    $808000: result := 'clWebTeal';
    $FFBF00: result := 'clWebDeepskyBlue';
    $FF901E: result := 'clWebDodgerBlue';
//    $FF0000: result := 'clWebBlue';
//    $800000: result := 'clWebNavy';
    $D30094: result := 'clWebDarkViolet';
    $CC3299: result := 'clWebDarkOrchid';
//    $FF00FF: result := 'clWebMagenta';
//    $FF00FF: result := 'clWebFuchsia';
    $8B008B: result := 'clWebDarkMagenta';
    $8515C7: result := 'clWebMediumVioletRed';
    $9370DB: result := 'clWebPaleVioletRed';
    $E22B8A: result := 'clWebBlueViolet';
    $D355BA: result := 'clWebMediumOrchid';
    $DB7093: result := 'clWebMediumPurple';
//    $800080: result := 'clWebPurple';
    $9314FF: result := 'clWebDeepPink';
    $C1B6FF: result := 'clWebLightPink';
    $EE82EE: result := 'clWebViolet';
    $D670DA: result := 'clWebOrchid';
    $DDA0DD: result := 'clWebPlum';
    $D8BFD8: result := 'clWebThistle';
    $B469FF: result := 'clWebHotPink';
    $CBC0FF: result := 'clWebPink';
    $DEC4B0: result := 'clWebLightSteelBlue';
    $EE687B: result := 'clWebMediumSlateBlue';
    $998877: result := 'clWebLightSlateGray';
//    $FFFFFF: result := 'clWebWhite';
    $D3D3D3: result := 'clWebLightgrey';
//    $808080: result := 'clWebGray';
    $B48246: result := 'clWebSteelBlue';
    $CD5A6A: result := 'clWebSlateBlue';
    $908070: result := 'clWebSlateGray';
    $F5F5F5: result := 'clWebWhiteSmoke';
//    $C0C0C0: result := 'clWebSilver';
    $696969: result := 'clWebDimGray';
    $E1E4FF: result := 'clWebMistyRose';
    $8B3D48: result := 'clWebDarkSlateBlue';
    $4F4F2F: result := 'clWebDarkSlategray';
    $DCDCDC: result := 'clWebGainsboro';
    $A9A9A9: result := 'clWebDarkGray';
//    $000000: result := 'clWebBlack';

    $FF000000: result := 'clScrollBar';
    $FF000001: result := 'clBackground';
    $FF000002: result := 'clActiveCaption';
    $FF000003: result := 'clInactiveCaption';
    $FF000004: result := 'clMenu';
    $FF000005: result := 'clWindow';
    $FF000006: result := 'clWindowFrame';
    $FF000007: result := 'clMenuText';
    $FF000008: result := 'clWindowText';
    $FF000009: result := 'clCaptionText';
    $FF00000A: result := 'clActiveBorder';
    $FF00000B: result := 'clInactiveBorder';
    $FF00000C: result := 'clAppWorkSpace';
    $FF00000D: result := 'clHighlight';
    $FF00000E: result := 'clHighlightText';
    $FF00000F: result := 'clBtnFace';
    $FF000010: result := 'clBtnShadow';
    $FF000011: result := 'clGrayText';
    $FF000012: result := 'clBtnText';
    $FF000013: result := 'clInactiveCaptionText';
    $FF000014: result := 'clBtnHighlight';
    $FF000015: result := 'cl3DDkShadow';
    $FF000016: result := 'cl3DLight';
    $FF000017: result := 'clInfoText';
    $FF000018: result := 'clInfoBk';
    $FF00001A: result := 'clHotLight';
    $FF00001B: result := 'clGradientActiveCaption';
    $FF00001C: result := 'clGradientInactiveCaption';
    $FF00001D: result := 'clMenuHighlight';
    $FF00001E: result := 'clMenuBar';
  end;
end;

initialization

Win8Schemes[0].Scheme := Win8_1_Windows;
Win8Schemes[0].Name := 'Windows';
Win8Schemes[1].Scheme := Win8_1_HighCont1;
Win8Schemes[1].Name := 'High Contrast 1';
Win8Schemes[2].Scheme := Win8_1_HighCont2;
Win8Schemes[2].Name := 'High Contrast 2';
Win8Schemes[3].Scheme := Win8_1_HighContBlk;
Win8Schemes[3].Name := 'High Contrast Black';
Win8Schemes[4].Scheme := Win8_1_HighContWht;
Win8Schemes[4].Name := 'High Contrast White';
Win7Schemes[0].Scheme := Win7_Aero;
Win7Schemes[0].Name := 'Aero';
Win7Schemes[1].Scheme := Win7_Classic;
Win7Schemes[1].Name := 'Classic';
Win7Schemes[2].Scheme := Win7_HighCont1;
Win7Schemes[2].Name := Win8Schemes[1].Name; //High Contrast 1
Win7Schemes[3].Scheme := Win7_HighCont2;
Win7Schemes[3].Name := Win8Schemes[2].Name; //High Contrast 2
Win7Schemes[4].Scheme := Win7_HighContBlk;
Win7Schemes[4].Name := Win8Schemes[3].Name; //High Contrast Black
Win7Schemes[5].Scheme := Win7_HighContWht;
Win7Schemes[5].Name := Win8Schemes[4].Name; //High Contrast White
WinVisSchemes[0].Scheme := WinVis_Aero;
WinVisSchemes[0].Name := Win7Schemes[0].Name; //Aero
WinVisSchemes[1].Scheme := WinVis_ClassicStd;
WinVisSchemes[1].Name := 'Classic (Std)';
WinVisSchemes[2].Scheme := WinVis_ClassicCla;
WinVisSchemes[2].Name := 'Classic (Class)';
WinVisSchemes[3].Scheme := WinVis_HighCont1;
WinVisSchemes[3].Name := Win8Schemes[1].Name; //High Contrast 1
WinVisSchemes[4].Scheme := WinVis_HighCont2;
WinVisSchemes[4].Name := Win8Schemes[2].Name; //High Contrast 2
WinVisSchemes[5].Scheme := WinVis_HighContBlk;
WinVisSchemes[5].Name := Win8Schemes[3].Name; //High Contrast Black
WinVisSchemes[6].Scheme := WinVis_HighContWht;
WinVisSchemes[6].Name := Win8Schemes[4].Name; //High Contrast White
WinXPSchemes[0].Scheme := WinXP_Luna;
WinXPSchemes[0].Name := 'Luna';
WinXPSchemes[1].Scheme := WinXP_LunaSilver;
WinXPSchemes[1].Name := 'Luna Silver';
WinXPSchemes[2].Scheme := WinXP_LunaOlive;
WinXPSchemes[2].Name := 'Luna Olive';
WinXPSchemes[3].Scheme := WinXP_Royal;
WinXPSchemes[3].Name := 'Royal';
WinXPSchemes[4].Scheme := WinXP_RoyalNoir;
WinXPSchemes[4].Name := 'Royal Noir';
WinXPSchemes[5].Scheme := WinXP_Zune;
WinXPSchemes[5].Name := 'Zune';
WinXPSchemes[6].Scheme := WinXP_Embedded;
WinXPSchemes[6].Name := 'Embedded';
WinXPSchemes[7].Scheme := WinXP_ClassicStd;
WinXPSchemes[7].Name := WinVisSchemes[1].Name; // 'Classic (Std)';
WinXPSchemes[8].Scheme := WinXP_ClassicClas;
WinXPSchemes[8].Name := WinVisSchemes[2].Name; // 'Classic (Class)';
WinXPSchemes[9].Scheme := WinXP_Brick;
WinXPSchemes[9].Name := 'Brick';
WinXPSchemes[10].Scheme := WinXP_Desert;
WinXPSchemes[10].Name := 'Desert';
WinXPSchemes[11].Scheme := WinXP_EggPlant;
WinXPSchemes[11].Name := 'EggPlant';
WinXPSchemes[12].Scheme := WinXP_Lilac;
WinXPSchemes[12].Name := 'Lilac';
WinXPSchemes[13].Scheme := WinXP_Maple;
WinXPSchemes[13].Name := 'Maple';
WinXPSchemes[14].Scheme := WinXP_Marine;
WinXPSchemes[14].Name := 'Marin';
WinXPSchemes[15].Scheme := WinXP_Plum;
WinXPSchemes[15].Name := 'Plum';
WinXPSchemes[16].Scheme := WinXP_Pumpkin;
WinXPSchemes[16].Name := 'Pumpkin';
WinXPSchemes[17].Scheme := WinXP_RainyDay;
WinXPSchemes[17].Name := 'Rainy Day';
WinXPSchemes[18].Scheme := WinXP_RedWhtBlue;
WinXPSchemes[18].Name := 'Red White Blue';
WinXPSchemes[19].Scheme := WinXP_Rose;
WinXPSchemes[19].Name := 'Rose';
WinXPSchemes[20].Scheme := WinXP_Slate;
WinXPSchemes[20].Name := 'Slate';
WinXPSchemes[21].Scheme := WinXP_Spruce;
WinXPSchemes[21].Name := 'Spruce';
WinXPSchemes[22].Scheme := WinXP_Storm;
WinXPSchemes[22].Name := 'Storm';
WinXPSchemes[23].Scheme := WinXP_Teal;
WinXPSchemes[23].Name := 'Teal';
WinXPSchemes[24].Scheme := WinXP_Wheat;
WinXPSchemes[24].Name := 'Wheat';
WinXPSchemes[25].Scheme := WinXP_HighCont1;
WinXPSchemes[25].Name := Win8Schemes[1].Name; //High Contrast 1
WinXPSchemes[26].Scheme := WinXP_HighCont2;
WinXPSchemes[26].Name := Win8Schemes[2].Name; //High Contrast 2
WinXPSchemes[27].Scheme := WinXP_HighContBlk;
WinXPSchemes[27].Name := Win8Schemes[3].Name; //High Contrast Black
WinXPSchemes[28].Scheme := WinXP_HighContWht;
WinXPSchemes[28].Name := Win8Schemes[4].Name; //High Contrast White
sc := Win7Schemes[0].Scheme;
end.
