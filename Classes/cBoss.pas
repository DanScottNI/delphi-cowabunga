unit cBoss;

interface

uses contnrs, iNESImage;

type
  /// <summary>
  /// An object to store the boss information within the ROM,
  /// in a usuable format.
  /// </summary>
  TBoss = class(TiNESImageAccessor)
  private
    procedure SetSpriteID(pSpriteID : byte);
    function GetSpriteID : Byte;
    procedure LoadData();
  public
    /// <summary>
    ///  The offset in the ROM where the boss object is.
    ///  </summary>
    Offset : Integer;
    ScreenY : Byte;
    ScreenX : Byte;
    X : Byte;
    Y : Byte;
    ID : Byte;
    WorldBoss : Boolean;
    WorldBossIndex : byte;
    property SpriteID : Byte read GetSpriteID write SetSpriteID;
    procedure SaveData(pOffset : Integer);
    constructor Create(pOffset : Integer);
  end;

  /// <summary>
  /// A descendant of TObjectList, to give a type-safe container that
  /// stores TBoss objects. 
  /// </summary>
  TBossList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TBoss;
    procedure SetItem(Index: Integer; const Value: TBoss);
  public
    function Add(AObject: TBoss) : Integer;
    property Items[Index: Integer] : TBoss read GetItem write SetItem;default;
    function Last : TBoss;
  end;

implementation

{ TBoss }
procedure TBoss.SaveData(pOffset: Integer);
begin
  { TODO : Add SaveData in TBoss }
end;

procedure TBoss.SetSpriteID(pSpriteID : byte);
begin
  { TODO : Add SetSpriteID in TBoss }
end;

constructor TBoss.Create(pOffset: Integer);
begin
  Offset := pOffset;
  LoadData;
end;

function TBoss.GetSpriteID : Byte;
begin
  result := ID and $7;
end;

procedure TBoss.LoadData;
begin
  self.ScreenY := ROM[Offset];
  self.ScreenX := ROM[Offset + 1];
  self.X := ROM[Offset + 2];
  self.Y := ROM[Offset + 3] - $10;
  self.ID := ROM[Offset + 4];
  if (ROM[Offset + 5] and $F0 = $F0) and (ROM[Offset + 5] <> $FF) then
  begin
    self.WorldBoss := True;
    self.WorldBossIndex := ROM[Offset + 5] and $0F;
  end;
end;

{ TBossList }

function TBossList.Add(AObject: TBoss): Integer;
begin
  Result := inherited Add(AObject);
end;

function TBossList.GetItem(Index: Integer): TBoss;
begin
  Result := TBoss(inherited Items[Index]);
end;

procedure TBossList.SetItem(Index: Integer; const Value: TBoss);
begin
  inherited Items[Index] := Value;
end;

function TBossList.Last : TBoss;
begin
  result := TBoss(inherited Last);
end;

end.
