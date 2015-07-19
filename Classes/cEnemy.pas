unit cEnemy;

interface

uses contnrs, iNESImage;

type
  TSideScrollEnemy = class(TiNESImageAccessor)
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
    constructor Create(pOffset : Integer;pIndex : SmallInt);
    procedure SaveData(pOffset : Integer);
    procedure IncrementID();
    property UnknownBit1 : Boolean read GetUnknownBit1 write SetUnknownBit1;
    property UnknownBit2 : Boolean read GetUnknownBit2 write SetUnknownBit2;
    property UnknownBit3 : Boolean read GetUnknownBit3 write SetUnknownBit3;
    property UnknownBit4 : Boolean read GetUnknownBit4 write SetUnknownBit4;
    property UnknownBit5 : Boolean read GetUnknownBit5 write SetUnknownBit5;
    property SpriteID : Byte read GetID write SetID;
  end;

  TSideScrollEnemyList = class(TObjectList)
  protected
    function GetEnemyItem(Index: Integer) : TSideScrollEnemy;
    procedure SetEnemyItem(Index: Integer; const Value: TSideScrollEnemy);
  public
    function Add(AObject: TSideScrollEnemy) : Integer;
    property Items[Index: Integer] : TSideScrollEnemy read GetEnemyItem write SetEnemyItem;default;
    function Last : TSideScrollEnemy;
  end;

implementation

{ TEnemy }
constructor TSideScrollEnemy.Create(pOffset: Integer;pIndex : SmallInt);
begin
  // Set the initial default ID for the enemy.
  ID := $80;
  // Set the offset to the one provided to the constructor.
  Offset := pOffset;
  // If the offset is greater than -1, then load the enemy data.
  if Offset > -1 then LoadData(pIndex);
end;

procedure TSideScrollEnemy.SaveData(pOffset: Integer);
begin
  ROM[pOffset] := X;
  ROM[pOffset + 1] := Y +  $10;
  ROM[pOffset + 2] := ID;
end;

procedure TSideScrollEnemy.LoadData(pIndex : SmallInt);
begin
  X := ROM[Offset];
  Y := ROM[Offset + 1] - $10;
  ID := ROM[Offset + 2];
  ScreenID := pIndex;
end;

function TSideScrollEnemy.GetID : Byte;
begin
  result := ID and 7;
end;

procedure TSideScrollEnemy.SetID (pByte : Byte);
begin
  ID := (ID and $F8) + (pByte and 7);
  ROM.Changed := True;
end;

procedure TSideScrollEnemy.SetUnknownBit1 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit1 in TEnemy }
  ROM.Changed := True;
end;

function TSideScrollEnemy.GetUnknownBit1 : Boolean;
begin
  if ID and $80 = $80 then
    result := true
  else
    result := false;

end;

procedure TSideScrollEnemy.SetUnknownBit2 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit2 in TEnemy }
  ROM.Changed := True;
end;

function TSideScrollEnemy.GetUnknownBit2 : Boolean;
begin
  if ID and $40 = $40 then
    result := true
  else
    result := false;
end;

procedure TSideScrollEnemy.SetUnknownBit3 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit3 in TEnemy }
  ROM.Changed := True;
end;

function TSideScrollEnemy.GetUnknownBit3 : Boolean;
begin
  if ID and $20 = $20 then
    result := true
  else
    result := false;
end;

procedure TSideScrollEnemy.SetUnknownBit4 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit4 in TEnemy }
  ROM.Changed := True;
end;

function TSideScrollEnemy.GetUnknownBit4 : Boolean;
begin
  if ID and $10 = $10 then
    result := true
  else
    result := false;

end;

procedure TSideScrollEnemy.SetUnknownBit5 (pByte : Boolean);
begin
  { TODO : Add SetUnknownBit5 in TEnemy }
  ROM.Changed := True;
end;

function TSideScrollEnemy.GetUnknownBit5 : Boolean;
begin
  if ID and $8 = $8 then
    result := true
  else
    result := false;
end;

procedure TSideScrollEnemy.IncrementID;
begin
  if SpriteID = 5 then
    SpriteID := 0
  else
    SpriteID := SpriteID + 1;

  ROM.Changed := true;
end;

{ TEnemyList }
{$REGION 'TEnemyList'}
  function TSideScrollEnemyList.Add(AObject: TSideScrollEnemy): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TSideScrollEnemyList.GetEnemyItem(Index: Integer): TSideScrollEnemy;
  begin
    Result := TSideScrollEnemy(inherited Items[Index]);
  end;
  
  procedure TSideScrollEnemyList.SetEnemyItem(Index: Integer; const Value: TSideScrollEnemy);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TSideScrollEnemyList.Last : TSideScrollEnemy;
  begin
    result := TSideScrollEnemy(inherited Last);
  end;
{$ENDREGION}

end.
