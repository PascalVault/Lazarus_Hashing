unit HasherBase;
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, Classes, FGL;

type

  { THasherBase }

  THasherBase = class
  public
    Check: String; //hash of '123456789'
    constructor Create; virtual;
    procedure Update(Msg: PByte; Length: Integer); virtual; abstract;
    function Final: String; virtual; abstract;
  end;

  { THasherList }

  THasherClass = class of THasherBase;
  THasherMap = specialize TFPGmap<string, THasherClass>;

  THasherList = class
  private
    FList: THasherMap;
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    function GetName(Index: Integer): String;
    function FindClass(Name: String; out AClass: THasherClass): Boolean;
    procedure RegisterHasher(Name: String; AClass: THasherClass);
  end;

  var HasherList: THasherList;

implementation

{ THasherBase }

constructor THasherBase.Create;
begin
  inherited Create;
end;

{ THasherList }

constructor THasherList.Create;
begin
  inherited Create;
  FList := THasherMap.Create;
end;

destructor THasherList.Destroy;
begin
  FList.Free;
  inherited;
end;

function THasherList.Count: Integer;
begin
  Result := FList.Count;
end;

function THasherList.GetName(Index: Integer): String;
begin
  if (Index > FList.Count-1) or (Index < 0) then Result := ''
  else                                           Result := FList.Keys[Index];
end;

function THasherList.FindClass(Name: String; out AClass: THasherClass): Boolean;
var Index: Integer;
begin
  Name := LowerCase(Name);
  Index := FList.IndexOf(Name);

  if Index < 0 then begin
    Result := False;
    Exit;
  end;

  AClass := FList.Data[Index];
  Result := True;
end;

procedure THasherList.RegisterHasher(Name: String; AClass: THasherClass);
begin
  FList.Add(LowerCase(Name), AClass);
end;

initialization
  HasherList := THasherList.Create;

finalization
  HasherList.Free;

end.
