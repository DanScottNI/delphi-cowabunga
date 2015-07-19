unit cSolidity;

interface

uses contnrs, iNESImage;

type
  TSolidity = class(TiNESImageAccessor)
  private
    procedure LoadData();
  public
    Offset : Integer;
    UpToTile : Byte;
    TileType : Byte;
    constructor Create(pOffset : Integer);
    procedure SaveData(pOffset : Integer);
  end;

  TSolidityList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TSolidity;
    procedure SetItem(Index: Integer; const Value: TSolidity);
  public
    function Add(AObject: TSolidity) : Integer;
    property Items[Index: Integer] : TSolidity read GetItem write SetItem;default;
    function Last : TSolidity;
  end;

implementation

{ TSolidity }

constructor TSolidity.Create(pOffset: Integer);
begin
  Offset := pOffset;
  LoadData;
end;

procedure TSolidity.LoadData;
begin
  self.UpToTile := ROM[offset];
  self.TileType := ROM[offset + 1];
end;

procedure TSolidity.SaveData(pOffset: Integer);
begin
  ROM[pOffset] := self.UpToTile;
  ROM[pOffset + 1] := self.TileType;
end;

{ TSolidityList }
{$REGION 'TSolidityList'}
  function TSolidityList.Add(AObject: TSolidity): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TSolidityList.GetItem(Index: Integer): TSolidity;
  begin
    Result := TSolidity(inherited Items[Index]);
  end;
  
  procedure TSolidityList.SetItem(Index: Integer; const Value: TSolidity);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TSolidityList.Last : TSolidity;
  begin
    result := TSolidity(inherited Last);
  end;
  
{$ENDREGION}

end.
