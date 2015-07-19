unit cWorldEnemy;

interface

uses iNESImage, contnrs;

type
  TWorldEnemy = class(TiNESImageAccessor)
  private
    procedure SetID (pByte : Byte);
    function GetID : Byte;
    procedure SetUnknownBit1 (pByte : Boolean);
    function GetUnknownBit1 : Boolean;
    procedure SetUnknownBit2 (pByte : Boolean);
    function GetUnknownBit2 : Boolean;
    procedure SetUnknownBit3 (pByte : Boolean);
    function GetUnknownBit3 : Boolean;
    procedure SetUnknownBit4 (pByte : Boolean);
    function GetUnknownBit4 : Boolean;
    procedure SetUnknownBit5 (pByte : Boolean);
    function GetUnknownBit5 : Boolean;
    procedure LoadData(pIndex : SmallInt);
  public
    Offset : Integer;
    X : SmallInt;
    Y : SmallInt;
    ID : Byte;
    ScreenID : SmallInt;
    constructor Create();overload;
    constructor Create(pOffset : Integer;pIndex : Smallint);overload;
    procedure SaveData(pOffset : Integer);
    property UnknownBit1 : Boolean read GetUnknownBit1 write SetUnknownBit1;
    property UnknownBit2 : Boolean read GetUnknownBit2 write SetUnknownBit2;
    property UnknownBit3 : Boolean read GetUnknownBit3 write SetUnknownBit3;
    property UnknownBit4 : Boolean read GetUnknownBit4 write SetUnknownBit4;
    property UnknownBit5 : Boolean read GetUnknownBit5 write SetUnknownBit5;
    property SpriteID : Byte read GetID write SetID;
  end;

  TWorldEnemyList = class(TObjectList)
  protected
    function GetEnemyItem(Index: Integer) : TWorldEnemy;
    procedure SetEnemyItem(Index: Integer; const Value: TWorldEnemy);
  public
    function Add(AObject: TWorldEnemy) : Integer;
    property Items[Index: Integer] : TWorldEnemy read GetEnemyItem write SetEnemyItem;default;
    function Last : TWorldEnemy;
  end;

implementation

{ TWorldEnemy }
constructor TWorldEnemy.Create(pOffset: Integer;pIndex : Smallint);
begin
  Offset := pOffset;
  LoadData(pIndex);
end;

procedure TWorldEnemy.SaveData(pOffset: Integer);
begin
  ROM[pOffset] := X;
  ROM[pOffset + 1] := Y;
  ROM[pOffset + 2] := ID;
end;

procedure TWorldEnemy.LoadData(pIndex : SmallInt);
begin
  X := ROM[Offset];
  Y := ROM[Offset + 1];
  ID := ROM[Offset + 2];
  ScreenID := pIndex;
end;

constructor TWorldEnemy.Create;
begin
  inherited;
end;

function TWorldEnemy.GetID : Byte;
begin
  result := ID and 7;
end;

procedure TWorldEnemy.SetID (pByte : Byte);
begin
  ID := (ID and $F8) + (pByte and 7);
  ROM.Changed := True;
end;

procedure TWorldEnemy.SetUnknownBit1 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit1 in TEnemy }
  ROM.Changed := True;
end;

function TWorldEnemy.GetUnknownBit1 : Boolean;
begin
  if ID and $80 = $80 then
    result := true
  else
    result := false;

end;

procedure TWorldEnemy.SetUnknownBit2 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit2 in TEnemy }
  ROM.Changed := True;
end;

function TWorldEnemy.GetUnknownBit2 : Boolean;
begin
  if ID and $40 = $40 then
    result := true
  else
    result := false;
end;

procedure TWorldEnemy.SetUnknownBit3 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit3 in TEnemy }
  ROM.Changed := True;
end;

function TWorldEnemy.GetUnknownBit3 : Boolean;
begin
  if ID and $20 = $20 then
    result := true
  else
    result := false;
end;

procedure TWorldEnemy.SetUnknownBit4 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit4 in TEnemy }
  ROM.Changed := True;
end;

function TWorldEnemy.GetUnknownBit4 : Boolean;
begin
  if ID and $10 = $10 then
    result := true
  else
    result := false;

end;

procedure TWorldEnemy.SetUnknownBit5 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit5 in TEnemy }
  ROM.Changed := True;
end;

function TWorldEnemy.GetUnknownBit5 : Boolean;
begin
  if ID and $8 = $8 then
    result := true
  else
    result := false;
end;



{ TWorldEnemyList }
{$REGION 'TWorldEnemyList'}
  function TWorldEnemyList.Add(AObject: TWorldEnemy): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TWorldEnemyList.GetEnemyItem(Index: Integer): TWorldEnemy;
  begin
    Result := TWorldEnemy(inherited Items[Index]);
  end;
  
  procedure TWorldEnemyList.SetEnemyItem(Index: Integer; const Value: TWorldEnemy);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TWorldEnemyList.Last : TWorldEnemy;
  begin
    result := TWorldEnemy(inherited Last);
  end;
{$ENDREGION}
end.
