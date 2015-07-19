unit cEntrance;

interface

uses contnrs, sysutils, iNESImage;

type
  TEntrance = class(TiNESImageAccessor)
  private
    function GetDestScreenNumberX : Byte;
    function GetDestScreenNumberY : Byte;
    procedure SetDestScreenNumberX (pScreenNumber : Byte);
    procedure SetDestScreenNumberY (pScreenNumber : Byte);
    procedure LoadData;
  public
    Offset : Integer;
    SourceScreen : Byte;
    SourceX : SmallInt;
    SourceY : SmallInt;
    EntranceToLevel : Byte;
    DestID : Byte;
    DestX : SmallInt;
    DestY : SmallInt;
    DestScreenX1 : Byte;
    DestScreenX2 : Byte;
    DestScreenY1 : Byte;
    DestScreenY2 : Byte;
    procedure SaveData(pOffset : Integer);
    constructor Create(pOffset : integer);
    property DestScreenNumberX : Byte read GetDestScreenNumberX write SetDestScreenNumberX;
    property DestScreenNumberY : Byte read GetDestScreenNumberY write SetDestScreenNumberY;
  end;
  
  TEntranceList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TEntrance;
    procedure SetItem(Index: Integer; const Value: TEntrance);
  public
    function Add(AObject: TEntrance) : Integer;
    property Items[Index: Integer] : TEntrance read GetItem write SetItem;default;
    function Last : TEntrance;
  end;

implementation

{TEntrance }

constructor TEntrance.Create(pOffset: integer);
begin
  Offset := pOffset;
  LoadData();
end;

function TEntrance.GetDestScreenNumberX : Byte;
begin
  if (EntranceToLevel = 1) and (DestScreenX2 <> $00) then
  begin
{ TODO : Make the code that alters the destination X1/X2 part of this property. }
  end;

  result := StrToInt('$' + IntToHex(self.DestScreenX1,2));
end;

function TEntrance.GetDestScreenNumberY : Byte;
begin
  result := StrToInt('$' + IntToHex(self.DestScreenY1,2) + IntToHex(self.DestScreenY2,2)) div $C0;
end;

procedure TEntrance.LoadData;
begin
  SourceScreen := ROM[offset];
  SourceX := ROM[offset+1];
  SourceY := ROM[offset+2];
  EntranceToLevel := ROM[offset+3];
  DestID := ROM[offset+4];
  DestX := ROM[offset+5];
  DestY := ROM[offset+6];
  DestScreenX1 := ROM[offset+7];
  DestScreenX2 := ROM[offset+8];

  if (DestScreenX2 <> $00) and (EntranceToLevel = 1) then
  begin
    DestScreenX1 := DestScreenX1 + 1;
    DestX := DestX - ($100 - DestScreenX2);
    DestScreenX2 := $00;
  end;

  DestScreenY1 := ROM[offset+9];
  DestScreenY2 := ROM[offset+10];
end;

procedure TEntrance.SaveData(pOffset: Integer);
begin
  { TODO : SaveData in TEntrance }
end;

procedure TEntrance.SetDestScreenNumberX(pScreenNumber : Byte);
begin
  { TODO : Add SetScreenX in TEntrance }
end;

procedure TEntrance.SetDestScreenNumberY(pScreenNumber : Byte);
begin
  { TODO : Add SetScreenY in TEntrance }
end;

{ TEntranceList }
{$REGION 'TEntranceList'}
  function TEntranceList.Add(AObject: TEntrance): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TEntranceList.GetItem(Index: Integer): TEntrance;
  begin
    Result := TEntrance(inherited Items[Index]);
  end;
  
  procedure TEntranceList.SetItem(Index: Integer; const Value: TEntrance);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TEntranceList.Last : TEntrance;
  begin
    result := TEntrance(inherited Last);
  end;
{$ENDREGION}

end.
