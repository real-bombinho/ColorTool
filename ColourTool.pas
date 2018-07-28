unit ColourTool;

//////////////////////////////////////////////////////////////////////////////
//
// Colour Tool, 2018 bombinho
//
//////////////////////////////////////////////////////////////////////////////

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts;

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
    SpeedButton1: TSpeedButton;
    Edit5: TEdit;
    Label13: TLabel;
    procedure Layout1Resize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
  private
    Spot: TAlphaColor;
    CRec: TColorRec;
    ARec: TAlphaColorRec;
    x, y: single;
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

type ColorScheme = (Aero, Classic);

function GetSysColor(const Value: integer; const Scheme: ColorScheme): TColorRec; forward;
function ColorToAlphaColor(const value: TColor): TAlphaColor; forward;
function AlphaColorName(const value: TAlphaColor): string; forward;

procedure TTool.fillColor;
begin
  x := PaintBox1.Position.X;
  y := PaintBox1.Position.Y;
  PaintBox1.Repaint;
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
var s: AnsiString;
begin
  Label7.Text := inttostr(ARec.A);
  Label8.Text := inttostr(ARec.R);
  Label9.Text := inttostr(ARec.G);
  Label10.Text := inttostr(ARec.B);
  Edit1.Text := inttostr(ARec.Color);
  Edit3.Text := inttostr(CRec.Color);
  edit2.Text := '$' + inttohex(ARec.Color, 1);
  edit4.Text := '$' + inttohex(CRec.Color, 1);
  edit5.Text := AlphaColorName(Spot);
  fillColor;
end;

procedure TTool.ShowColor(const color: TColor; const message: string = '');
begin
  CRec.Color := color;
  ARec.A := CRec.A;
  ARec.B := CRec.B;
  ARec.G := CRec.G;
  ARec.R := CRec.R;
  spot := ColorToAlphaColor(color);
  process;
  Label12.Text := message;
  Tool.ShowModal;
end;

procedure TTool.ShowColor(const color: TAlphaColor; const message: string = '');
begin
  ARec.Color := color;
  CRec.A := 0;
  CRec.B := ARec.B;
  CRec.G := ARec.G;
  CRec.R := ARec.R;
  spot := color;
  process;
  Label12.Text := message;
  Tool.ShowModal;
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

function GetSysColor(const Value: integer; const Scheme: ColorScheme): TColorRec;
begin
  if Scheme = ColorScheme.Aero then       //Aero
  begin
     if Value = $0 then  // cSCROLLBAR = 0;
    begin
    	result.r := 200;
      result.G := 200;
      result.B := 200;
    end;
    if Value = $1 then   // cBACKGROUND = 1;
    begin
    	result.r := 0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $2 then   // cACTIVECAPTION = 2;
    begin
    	result.r := 153;
      result.G := 180;
      result.B := 209;
    end;
    if Value = $3 then   // cINACTIVECAPTION = 3;
    begin
      result.R :=	191;
      result.G := 205;
      result.B := 219;
    end;
    if Value = $4 then   // cMENU = 4;
    begin
      result.R :=	240;
      result.G := 240;
      result.B := 240;
    end;
    if Value = $5 then   // cWINDOW = 5;
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $6 then   // cWINDOWFRAME = 6;
    begin
      result.R :=	100;
      result.G := 100;
      result.B := 100;
    end;
    if Value = $7 then   // cMENUTEXT = 7;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $8 then   // cWINDOWTEXT = 8;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $9 then   // cCAPTIONTEXT = 9;     .
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $A then   // cACTIVEBORDER = 10;
    begin
      result.R :=	180;
      result.G := 180;
      result.B := 180;
    end;
    if Value = $B then   // cINACTIVEBORDER = 11;
    begin
      result.R :=	244;
      result.G := 247;
      result.B := 252;
    end;
    if Value = $C then   // cAPPWORKSPACE = 12;
    begin
      result.R :=	171;
      result.G := 171;
      result.B := 171;
    end;
    if Value = $D then   // cHIGHLIGHT = 13;
    begin
      result.R :=	 51;
      result.G := 153;
      result.B := 255;
    end;
    if Value = $E then   // cHIGHLIGHTTEXT = 14;
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $F then   // cBTNFACE = 15; / Controlbrush
    begin     //15
      result.R :=	240;
      result.G := 240;
      result.B := 240;
    end;
    if Value = $10 then  // cBTNSHADOW = 16; /ControlDark
    begin
      result.R :=	160;
      result.G := 160;
      result.B := 160;
    end;
    if Value = $11 then  // cGRAYTEXT = 17;
    begin
      result.R :=	109;
      result.G := 109;
      result.B := 109;
    end;
    if Value = $12 then  // cBTNTEXT = 18;
    begin
      result.R :=	 0;
      result.G :=  0;
      result.B :=  0;
    end;
    if Value = $13 then  // cINACTIVECAPTIONTEXT = 19;
    begin
      result.R :=	67;
      result.G := 78;
      result.B := 84;
    end;
    if Value = $14 then  // cBTNHIGHLIGHT = 20;
    begin     //20
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $15 then  // c3DDKSHADOW = 21;   /ControlDarkDark
    begin
      result.R :=	105;
      result.G := 105;
      result.B := 105;
    end;
    if Value = $16 then  // c3DLIGHT = 22;
    begin
      result.R :=	227;
      result.G := 227;
      result.B := 227;
    end;
    if Value = $17 then  //  cINFOTEXT = 23;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $18 then  // cINFOBK = 24;   cINFOBK = 24;
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $19 then  // no definition
    begin     //25
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $1A then  // cHOTLIGHT = 26;
    begin
      result.R :=	0;
      result.G := 102;
      result.B := 204;
    end;
    if Value = $1B then  // cGRADIENTACTIVECAPTION = 27;
    begin
      result.R :=	185;
      result.G := 209;
      result.B := 234;
    end;
    if Value = $1C then  //  cGRADIENTINACTIVECAPTION = 28;
    begin
      result.R :=	215;
      result.G := 228;
      result.B := 242;
    end;
    if Value = $1D then  // cMENUHILIGHT = 29;
    begin
      result.R :=	51;
      result.G := 153;
      result.B := 255;
    end;
    if Value = $1E then  // cMENUBAR = 30;
    begin
      result.R :=	240;
      result.G := 240;
      result.B := 240;
    end;
  end;

  if Scheme = ColorScheme.Classic then      //Classic
  begin
     if Value = $0 then  // cSCROLLBAR = 0;
    begin
    	result.r := 212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $1 then   // cBACKGROUND = 1;
    begin
    	result.r := 0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $2 then   // cACTIVECAPTION = 2;
    begin
    	result.r := 10;
      result.G := 36;
      result.B := 106;
    end;
    if Value = $3 then   // cINACTIVECAPTION = 3;
    begin
      result.R :=	128;
      result.G := 128;
      result.B := 128;
    end;
    if Value = $4 then   // cMENU = 4;
    begin
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $5 then   // cWINDOW = 5;
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $6 then   // cWINDOWFRAME = 6;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $7 then   // cMENUTEXT = 7;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $8 then   // cWINDOWTEXT = 8;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $9 then   // cCAPTIONTEXT = 9;     .
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $A then   // cACTIVEBORDER = 10;
    begin
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $B then   // cINACTIVEBORDER = 11;
    begin
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $C then   // cAPPWORKSPACE = 12;
    begin
      result.R :=	128;
      result.G := 128;
      result.B := 128;
    end;
    if Value = $D then   // cHIGHLIGHT = 13;
    begin
      result.R :=	10;
      result.G := 36;
      result.B := 106;
    end;
    if Value = $E then   // cHIGHLIGHTTEXT = 14;
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $F then   // cBTNFACE = 15; / Controlbrush
    begin     //15
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $10 then  // cBTNSHADOW = 16; /ControlDark
    begin
      result.R :=	128;
      result.G := 128;
      result.B := 128;
    end;
    if Value = $11 then  // cGRAYTEXT = 17;
    begin
      result.R :=	128;
      result.G := 128;
      result.B := 128;
    end;
    if Value = $12 then  // cBTNTEXT = 18;
    begin
      result.R :=	 0;
      result.G :=  0;
      result.B :=  0;
    end;
    if Value = $13 then  // cINACTIVECAPTIONTEXT = 19;
    begin
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $14 then  // cBTNHIGHLIGHT = 20;
    begin     //20
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $15 then  // c3DDKSHADOW = 21;   /ControlDarkDark
    begin
      result.R :=	64;
      result.G := 64;
      result.B := 64;
    end;
    if Value = $16 then  // c3DLIGHT = 22;
    begin
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
    if Value = $17 then  //  cINFOTEXT = 23;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $18 then  // cINFOBK = 24;
    begin
      result.R :=	255;
      result.G := 255;
      result.B := 255;
    end;
    if Value = $19 then  // no definition
    begin     //25
      result.R :=	0;
      result.G := 0;
      result.B := 0;
    end;
    if Value = $1A then  // cHOTLIGHT = 26;
    begin
      result.R :=	0;
      result.G := 0;
      result.B := 128;
    end;
    if Value = $1B then  // cGRADIENTACTIVECAPTION = 27;
    begin
      result.R :=	166;
      result.G := 202;
      result.B := 240;
    end;
    if Value = $1C then  //  cGRADIENTINACTIVECAPTION = 28;
    begin
      result.R :=	192;
      result.G := 192;
      result.B := 192;
    end;
    if Value = $1D then  // cMENUHILIGHT = 29;
    begin
      result.R :=	10;
      result.G := 36;
      result.B := 106;
    end;
    if Value = $1E then  // cMENUBAR = 30;
    begin
      result.R :=	212;
      result.G := 208;
      result.B := 200;
    end;
  end;
  result.A := 255;
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

end.
