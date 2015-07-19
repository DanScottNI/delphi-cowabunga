unit cSpecobj;

interface

uses contnrs, iNESImage;

type

  TSpecialObject = class
  private
    _X : SmallInt;
    _Y : SmallInt;
    procedure SetX (pX : SmallInt);
    procedure SetY (pY : SmallInt);
    procedure LoadData();
  public
    Offset : Integer;
    ScreenID : Byte;
    UnknownX: Byte;
    UnknownY : Byte;
    ID : Byte;
    Unknown1 : Byte;
    Unknown2 : Byte;
    constructor Create(pOffset : Integer);
    procedure SaveData(pOffset : Integer);
    property X : SmallInt read _X write SetX;
    property Y : SmallInt read _Y write SetY;
    procedure IncrementID;
  end;

  TSpecialObjectList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TSpecialObject;
    procedure SetItem(Index: Integer; const Value: TSpecialObject);
  public
    function Add(AObject: TSpecialObject) : Integer;
    property Items[Index: Integer] : TSpecialObject read GetItem write SetItem;default;
    function Last : TSpecialObject;
  end;

implementation

{ TSpecObj }

constructor TSpecialObject.Create(pOffset: Integer);
begin
  Offset := pOffset;
  LoadData;
end;

procedure TSpecialObject.IncrementID;
begin
  { TODO : IncrementID in TSpecialObject }
end;

procedure TSpecialObject.LoadData;
begin
{ TODO : LoadData in TSpecObj }
end;

procedure TSpecialObject.SaveData(pOffset: Integer);
begin
{ TODO : SaveData in TSpecObj }
end;

procedure TSpecialObject.SetX (pX : SmallInt);
begin
  if Unknown1 = _X then Unknown1 := pX;
  self._X := pX;
end;

procedure TSpecialObject.SetY (pY : SmallInt);
begin

  if pY > $EF then
  begin
    if Unknown2 = _Y then Unknown2 := $EF;
    self._Y := $EF
  end
  else
  begin
    if Unknown2 = _Y then Unknown2 := pY;
    self._Y := pY;
  end;
end;

{ TSpecObjList }
{$REGION 'TSpecObjList'}
  function TSpecialObjectList.Add(AObject: TSpecialObject): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TSpecialObjectList.GetItem(Index: Integer): TSpecialObject;
  begin
    Result := TSpecialObject(inherited Items[Index]);
  end;
  
  procedure TSpecialObjectList.SetItem(Index: Integer; const Value: TSpecialObject);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TSpecialObjectList.Last : TSpecialObject;
  begin
    result := TSpecialObject(inherited Last);
  end;
{$ENDREGION}

end.
