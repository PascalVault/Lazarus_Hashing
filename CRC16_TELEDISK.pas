unit CRC16_TELEDISK;
//CRC-16 TELEDISK
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_TELEDISK = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $A097, $E1B9, $412E, $63E5, $C372, $825C, $22CB,
$C7CA, $675D, $2673, $86E4, $A42F, $04B8, $4596, $E501,
$2F03, $8F94, $CEBA, $6E2D, $4CE6, $EC71, $AD5F, $0DC8,
$E8C9, $485E, $0970, $A9E7, $8B2C, $2BBB, $6A95, $CA02,
$5E06, $FE91, $BFBF, $1F28, $3DE3, $9D74, $DC5A, $7CCD,
$99CC, $395B, $7875, $D8E2, $FA29, $5ABE, $1B90, $BB07,
$7105, $D192, $90BC, $302B, $12E0, $B277, $F359, $53CE,
$B6CF, $1658, $5776, $F7E1, $D52A, $75BD, $3493, $9404,
$BC0C, $1C9B, $5DB5, $FD22, $DFE9, $7F7E, $3E50, $9EC7,
$7BC6, $DB51, $9A7F, $3AE8, $1823, $B8B4, $F99A, $590D,
$930F, $3398, $72B6, $D221, $F0EA, $507D, $1153, $B1C4,
$54C5, $F452, $B57C, $15EB, $3720, $97B7, $D699, $760E,
$E20A, $429D, $03B3, $A324, $81EF, $2178, $6056, $C0C1,
$25C0, $8557, $C479, $64EE, $4625, $E6B2, $A79C, $070B,
$CD09, $6D9E, $2CB0, $8C27, $AEEC, $0E7B, $4F55, $EFC2,
$0AC3, $AA54, $EB7A, $4BED, $6926, $C9B1, $889F, $2808,
$D88F, $7818, $3936, $99A1, $BB6A, $1BFD, $5AD3, $FA44,
$1F45, $BFD2, $FEFC, $5E6B, $7CA0, $DC37, $9D19, $3D8E,
$F78C, $571B, $1635, $B6A2, $9469, $34FE, $75D0, $D547,
$3046, $90D1, $D1FF, $7168, $53A3, $F334, $B21A, $128D,
$8689, $261E, $6730, $C7A7, $E56C, $45FB, $04D5, $A442,
$4143, $E1D4, $A0FA, $006D, $22A6, $8231, $C31F, $6388,
$A98A, $091D, $4833, $E8A4, $CA6F, $6AF8, $2BD6, $8B41,
$6E40, $CED7, $8FF9, $2F6E, $0DA5, $AD32, $EC1C, $4C8B,
$6483, $C414, $853A, $25AD, $0766, $A7F1, $E6DF, $4648,
$A349, $03DE, $42F0, $E267, $C0AC, $603B, $2115, $8182,
$4B80, $EB17, $AA39, $0AAE, $2865, $88F2, $C9DC, $694B,
$8C4A, $2CDD, $6DF3, $CD64, $EFAF, $4F38, $0E16, $AE81,
$3A85, $9A12, $DB3C, $7BAB, $5960, $F9F7, $B8D9, $184E,
$FD4F, $5DD8, $1CF6, $BC61, $9EAA, $3E3D, $7F13, $DF84,
$1586, $B511, $F43F, $54A8, $7663, $D6F4, $97DA, $374D,
$D24C, $72DB, $33F5, $9362, $B1A9, $113E, $5010, $F087
);

constructor THasherCRC16_TELEDISK.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := '0FB3';
end;

procedure THasherCRC16_TELEDISK.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_TELEDISK.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 TELEDISK', THasherCRC16_TELEDISK);

end.
