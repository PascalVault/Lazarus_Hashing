unit CRC64_xz;
//CRC-64 XZ
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC64_xz = class(THasherBase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of QWord = (
$0000000000000000, $B32E4CBE03A75F6F, $F4843657A840A05B, $47AA7AE9ABE7FF34, $7BD0C384FF8F5E33, $C8FE8F3AFC28015C, $8F54F5D357CFFE68, $3C7AB96D5468A107,
$F7A18709FF1EBC66, $448FCBB7FCB9E309, $0325B15E575E1C3D, $B00BFDE054F94352, $8C71448D0091E255, $3F5F08330336BD3A, $78F572DAA8D1420E, $CBDB3E64AB761D61,
$7D9BA13851336649, $CEB5ED8652943926, $891F976FF973C612, $3A31DBD1FAD4997D, $064B62BCAEBC387A, $B5652E02AD1B6715, $F2CF54EB06FC9821, $41E11855055BC74E,
$8A3A2631AE2DDA2F, $39146A8FAD8A8540, $7EBE1066066D7A74, $CD905CD805CA251B, $F1EAE5B551A2841C, $42C4A90B5205DB73, $056ED3E2F9E22447, $B6409F5CFA457B28,
$FB374270A266CC92, $48190ECEA1C193FD, $0FB374270A266CC9, $BC9D3899098133A6, $80E781F45DE992A1, $33C9CD4A5E4ECDCE, $7463B7A3F5A932FA, $C74DFB1DF60E6D95,
$0C96C5795D7870F4, $BFB889C75EDF2F9B, $F812F32EF538D0AF, $4B3CBF90F69F8FC0, $774606FDA2F72EC7, $C4684A43A15071A8, $83C230AA0AB78E9C, $30EC7C140910D1F3,
$86ACE348F355AADB, $3582AFF6F0F2F5B4, $7228D51F5B150A80, $C10699A158B255EF, $FD7C20CC0CDAF4E8, $4E526C720F7DAB87, $09F8169BA49A54B3, $BAD65A25A73D0BDC,
$710D64410C4B16BD, $C22328FF0FEC49D2, $85895216A40BB6E6, $36A71EA8A7ACE989, $0ADDA7C5F3C4488E, $B9F3EB7BF06317E1, $FE5991925B84E8D5, $4D77DD2C5823B7BA,
$64B62BCAEBC387A1, $D7986774E864D8CE, $90321D9D438327FA, $231C512340247895, $1F66E84E144CD992, $AC48A4F017EB86FD, $EBE2DE19BC0C79C9, $58CC92A7BFAB26A6,
$9317ACC314DD3BC7, $2039E07D177A64A8, $67939A94BC9D9B9C, $D4BDD62ABF3AC4F3, $E8C76F47EB5265F4, $5BE923F9E8F53A9B, $1C4359104312C5AF, $AF6D15AE40B59AC0,
$192D8AF2BAF0E1E8, $AA03C64CB957BE87, $EDA9BCA512B041B3, $5E87F01B11171EDC, $62FD4976457FBFDB, $D1D305C846D8E0B4, $96797F21ED3F1F80, $2557339FEE9840EF,
$EE8C0DFB45EE5D8E, $5DA24145464902E1, $1A083BACEDAEFDD5, $A9267712EE09A2BA, $955CCE7FBA6103BD, $267282C1B9C65CD2, $61D8F8281221A3E6, $D2F6B4961186FC89,
$9F8169BA49A54B33, $2CAF25044A02145C, $6B055FEDE1E5EB68, $D82B1353E242B407, $E451AA3EB62A1500, $577FE680B58D4A6F, $10D59C691E6AB55B, $A3FBD0D71DCDEA34,
$6820EEB3B6BBF755, $DB0EA20DB51CA83A, $9CA4D8E41EFB570E, $2F8A945A1D5C0861, $13F02D374934A966, $A0DE61894A93F609, $E7741B60E174093D, $545A57DEE2D35652,
$E21AC88218962D7A, $5134843C1B317215, $169EFED5B0D68D21, $A5B0B26BB371D24E, $99CA0B06E7197349, $2AE447B8E4BE2C26, $6D4E3D514F59D312, $DE6071EF4CFE8C7D,
$15BB4F8BE788911C, $A6950335E42FCE73, $E13F79DC4FC83147, $521135624C6F6E28, $6E6B8C0F1807CF2F, $DD45C0B11BA09040, $9AEFBA58B0476F74, $29C1F6E6B3E0301B,
$C96C5795D7870F42, $7A421B2BD420502D, $3DE861C27FC7AF19, $8EC62D7C7C60F076, $B2BC941128085171, $0192D8AF2BAF0E1E, $4638A2468048F12A, $F516EEF883EFAE45,
$3ECDD09C2899B324, $8DE39C222B3EEC4B, $CA49E6CB80D9137F, $7967AA75837E4C10, $451D1318D716ED17, $F6335FA6D4B1B278, $B199254F7F564D4C, $02B769F17CF11223,
$B4F7F6AD86B4690B, $07D9BA1385133664, $4073C0FA2EF4C950, $F35D8C442D53963F, $CF273529793B3738, $7C0979977A9C6857, $3BA3037ED17B9763, $888D4FC0D2DCC80C,
$435671A479AAD56D, $F0783D1A7A0D8A02, $B7D247F3D1EA7536, $04FC0B4DD24D2A59, $3886B22086258B5E, $8BA8FE9E8582D431, $CC0284772E652B05, $7F2CC8C92DC2746A,
$325B15E575E1C3D0, $8175595B76469CBF, $C6DF23B2DDA1638B, $75F16F0CDE063CE4, $498BD6618A6E9DE3, $FAA59ADF89C9C28C, $BD0FE036222E3DB8, $0E21AC88218962D7,
$C5FA92EC8AFF7FB6, $76D4DE52895820D9, $317EA4BB22BFDFED, $8250E80521188082, $BE2A516875702185, $0D041DD676D77EEA, $4AAE673FDD3081DE, $F9802B81DE97DEB1,
$4FC0B4DD24D2A599, $FCEEF8632775FAF6, $BB44828A8C9205C2, $086ACE348F355AAD, $34107759DB5DFBAA, $873E3BE7D8FAA4C5, $C094410E731D5BF1, $73BA0DB070BA049E,
$B86133D4DBCC19FF, $0B4F7F6AD86B4690, $4CE50583738CB9A4, $FFCB493D702BE6CB, $C3B1F050244347CC, $709FBCEE27E418A3, $3735C6078C03E797, $841B8AB98FA4B8F8,
$ADDA7C5F3C4488E3, $1EF430E13FE3D78C, $595E4A08940428B8, $EA7006B697A377D7, $D60ABFDBC3CBD6D0, $6524F365C06C89BF, $228E898C6B8B768B, $91A0C532682C29E4,
$5A7BFB56C35A3485, $E955B7E8C0FD6BEA, $AEFFCD016B1A94DE, $1DD181BF68BDCBB1, $21AB38D23CD56AB6, $9285746C3F7235D9, $D52F0E859495CAED, $6601423B97329582,
$D041DD676D77EEAA, $636F91D96ED0B1C5, $24C5EB30C5374EF1, $97EBA78EC690119E, $AB911EE392F8B099, $18BF525D915FEFF6, $5F1528B43AB810C2, $EC3B640A391F4FAD,
$27E05A6E926952CC, $94CE16D091CE0DA3, $D3646C393A29F297, $604A2087398EADF8, $5C3099EA6DE60CFF, $EF1ED5546E415390, $A8B4AFBDC5A6ACA4, $1B9AE303C601F3CB,
$56ED3E2F9E224471, $E5C372919D851B1E, $A26908783662E42A, $114744C635C5BB45, $2D3DFDAB61AD1A42, $9E13B115620A452D, $D9B9CBFCC9EDBA19, $6A978742CA4AE576,
$A14CB926613CF817, $1262F598629BA778, $55C88F71C97C584C, $E6E6C3CFCADB0723, $DA9C7AA29EB3A624, $69B2361C9D14F94B, $2E184CF536F3067F, $9D36004B35545910,
$2B769F17CF112238, $9858D3A9CCB67D57, $DFF2A94067518263, $6CDCE5FE64F6DD0C, $50A65C93309E7C0B, $E388102D33392364, $A4226AC498DEDC50, $170C267A9B79833F,
$DCD7181E300F9E5E, $6FF954A033A8C131, $28532E49984F3E05, $9B7D62F79BE8616A, $A707DB9ACF80C06D, $14299724CC279F02, $5383EDCD67C06036, $E0ADA17364673F59 
);

constructor THasherCRC64_xz.Create;
begin
  inherited Create;
  FHash :=  $FFFFFFFFFFFFFFFF;
  Check := '995DC9BBDF1939FA';
end;

procedure THasherCRC64_xz.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Index: Cardinal;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shr 8) xor Table[Byte(FHash) xor Msg^];
    Inc(Msg);
  end;   
end;

function THasherCRC64_xz.Final: String;
begin
  FHash := FHash xor $FFFFFFFFFFFFFFFF;
  Result := IntToHex(FHash, 16); 
end;

initialization
  HasherList.RegisterHasher('CRC-64 xz', THasherCRC64_xz);

end.
