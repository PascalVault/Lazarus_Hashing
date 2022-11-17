unit CRC16_T10DIF;
//CRC-16 T10-DIF
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_T10DIF = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $8BB7, $9CD9, $176E, $B205, $39B2, $2EDC, $A56B,
$EFBD, $640A, $7364, $F8D3, $5DB8, $D60F, $C161, $4AD6,
$54CD, $DF7A, $C814, $43A3, $E6C8, $6D7F, $7A11, $F1A6,
$BB70, $30C7, $27A9, $AC1E, $0975, $82C2, $95AC, $1E1B,
$A99A, $222D, $3543, $BEF4, $1B9F, $9028, $8746, $0CF1,
$4627, $CD90, $DAFE, $5149, $F422, $7F95, $68FB, $E34C,
$FD57, $76E0, $618E, $EA39, $4F52, $C4E5, $D38B, $583C,
$12EA, $995D, $8E33, $0584, $A0EF, $2B58, $3C36, $B781,
$D883, $5334, $445A, $CFED, $6A86, $E131, $F65F, $7DE8,
$373E, $BC89, $ABE7, $2050, $853B, $0E8C, $19E2, $9255,
$8C4E, $07F9, $1097, $9B20, $3E4B, $B5FC, $A292, $2925,
$63F3, $E844, $FF2A, $749D, $D1F6, $5A41, $4D2F, $C698,
$7119, $FAAE, $EDC0, $6677, $C31C, $48AB, $5FC5, $D472,
$9EA4, $1513, $027D, $89CA, $2CA1, $A716, $B078, $3BCF,
$25D4, $AE63, $B90D, $32BA, $97D1, $1C66, $0B08, $80BF,
$CA69, $41DE, $56B0, $DD07, $786C, $F3DB, $E4B5, $6F02,
$3AB1, $B106, $A668, $2DDF, $88B4, $0303, $146D, $9FDA,
$D50C, $5EBB, $49D5, $C262, $6709, $ECBE, $FBD0, $7067,
$6E7C, $E5CB, $F2A5, $7912, $DC79, $57CE, $40A0, $CB17,
$81C1, $0A76, $1D18, $96AF, $33C4, $B873, $AF1D, $24AA,
$932B, $189C, $0FF2, $8445, $212E, $AA99, $BDF7, $3640,
$7C96, $F721, $E04F, $6BF8, $CE93, $4524, $524A, $D9FD,
$C7E6, $4C51, $5B3F, $D088, $75E3, $FE54, $E93A, $628D,
$285B, $A3EC, $B482, $3F35, $9A5E, $11E9, $0687, $8D30,
$E232, $6985, $7EEB, $F55C, $5037, $DB80, $CCEE, $4759,
$0D8F, $8638, $9156, $1AE1, $BF8A, $343D, $2353, $A8E4,
$B6FF, $3D48, $2A26, $A191, $04FA, $8F4D, $9823, $1394,
$5942, $D2F5, $C59B, $4E2C, $EB47, $60F0, $779E, $FC29,
$4BA8, $C01F, $D771, $5CC6, $F9AD, $721A, $6574, $EEC3,
$A415, $2FA2, $38CC, $B37B, $1610, $9DA7, $8AC9, $017E,
$1F65, $94D2, $83BC, $080B, $AD60, $26D7, $31B9, $BA0E,
$F0D8, $7B6F, $6C01, $E7B6, $42DD, $C96A, $DE04, $55B3
);

constructor THasherCRC16_T10DIF.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := 'D0DB';
end;

procedure THasherCRC16_T10DIF.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_T10DIF.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 T10-DIF', THasherCRC16_T10DIF);

end.
