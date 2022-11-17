unit CRC16_LJ1200;
//CRC-16 LJ1200
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_LJ1200 = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $6F63, $DEC6, $B1A5, $D2EF, $BD8C, $0C29, $634A,
$CABD, $A5DE, $147B, $7B18, $1852, $7731, $C694, $A9F7,
$FA19, $957A, $24DF, $4BBC, $28F6, $4795, $F630, $9953,
$30A4, $5FC7, $EE62, $8101, $E24B, $8D28, $3C8D, $53EE,
$9B51, $F432, $4597, $2AF4, $49BE, $26DD, $9778, $F81B,
$51EC, $3E8F, $8F2A, $E049, $8303, $EC60, $5DC5, $32A6,
$6148, $0E2B, $BF8E, $D0ED, $B3A7, $DCC4, $6D61, $0202,
$ABF5, $C496, $7533, $1A50, $791A, $1679, $A7DC, $C8BF,
$59C1, $36A2, $8707, $E864, $8B2E, $E44D, $55E8, $3A8B,
$937C, $FC1F, $4DBA, $22D9, $4193, $2EF0, $9F55, $F036,
$A3D8, $CCBB, $7D1E, $127D, $7137, $1E54, $AFF1, $C092,
$6965, $0606, $B7A3, $D8C0, $BB8A, $D4E9, $654C, $0A2F,
$C290, $ADF3, $1C56, $7335, $107F, $7F1C, $CEB9, $A1DA,
$082D, $674E, $D6EB, $B988, $DAC2, $B5A1, $0404, $6B67,
$3889, $57EA, $E64F, $892C, $EA66, $8505, $34A0, $5BC3,
$F234, $9D57, $2CF2, $4391, $20DB, $4FB8, $FE1D, $917E,
$B382, $DCE1, $6D44, $0227, $616D, $0E0E, $BFAB, $D0C8,
$793F, $165C, $A7F9, $C89A, $ABD0, $C4B3, $7516, $1A75,
$499B, $26F8, $975D, $F83E, $9B74, $F417, $45B2, $2AD1,
$8326, $EC45, $5DE0, $3283, $51C9, $3EAA, $8F0F, $E06C,
$28D3, $47B0, $F615, $9976, $FA3C, $955F, $24FA, $4B99,
$E26E, $8D0D, $3CA8, $53CB, $3081, $5FE2, $EE47, $8124,
$D2CA, $BDA9, $0C0C, $636F, $0025, $6F46, $DEE3, $B180,
$1877, $7714, $C6B1, $A9D2, $CA98, $A5FB, $145E, $7B3D,
$EA43, $8520, $3485, $5BE6, $38AC, $57CF, $E66A, $8909,
$20FE, $4F9D, $FE38, $915B, $F211, $9D72, $2CD7, $43B4,
$105A, $7F39, $CE9C, $A1FF, $C2B5, $ADD6, $1C73, $7310,
$DAE7, $B584, $0421, $6B42, $0808, $676B, $D6CE, $B9AD,
$7112, $1E71, $AFD4, $C0B7, $A3FD, $CC9E, $7D3B, $1258,
$BBAF, $D4CC, $6569, $0A0A, $6940, $0623, $B786, $D8E5,
$8B0B, $E468, $55CD, $3AAE, $59E4, $3687, $8722, $E841,
$41B6, $2ED5, $9F70, $F013, $9359, $FC3A, $4D9F, $22FC
);

constructor THasherCRC16_LJ1200.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := 'BDF4';
end;

procedure THasherCRC16_LJ1200.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_LJ1200.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 LJ1200', THasherCRC16_LJ1200);

end.
