unit cNameTable;

interface

uses sysutils, classes, iNESImage;

type
  TNameTableSetting = record
    // The pointer where to start loading the data from
    NTPointer : Integer;
    // The offset to start writing data to.
    StartOffset : Integer;
    // The offset that we are not allowed to go over.
    EndOffset : Integer;
    // The nametable in which to load it the title screen data.
    NameTableAddress : Integer;
    // The bank in which the data is stored.
    Bank : Byte;
  end;

  TNameTable = class(TiNESImageAccessor)
  private
    NameTableSettings : TNameTableSetting;
    _CompressedBuffer : Array [0..1023] Of Byte;
    _UnCompressedBuffer : Array [0..1050] of Byte;
    _PatternTable : Array [0.. 4095] of Byte;
    procedure DecompressData;
    procedure CompressData;
  public
    constructor Create(pNameTableSettings : TNameTableSetting);
    procedure DumpDecompressedData(pFilename : String);
  end;

implementation

constructor TNameTable.Create(pNameTableSettings : TNameTableSetting);
begin
  NameTableSettings := pNameTableSettings;
  DecompressData;
end;

procedure TNameTable.DecompressData;
var
  offset, i,num: Integer;
  startaddress : Integer;
begin
  // Decompression data.
  // First, we have the nametable pointer at which to start loading the data at.
  // Then, we have the number of bytes to load. If you AND this value by $80
  // and get a $80 back, then it doesn't use RLE compression. If you and it, and get
  // nothing back, it uses RLE. This means that you can
  // only ever have $7F number of tiles in one segment. If the number of bytes to
  // load is $FF, then exit the subroutine.

  // First, we need to work out where the data is, so we load the pointer.
  offset := ROM.PointerToOffset( NameTableSettings.NTPointer,(NameTableSettings.Bank * $4000) + $10);

  // Load in the nametable pointer, and work out where to start
  // writing into the uncompressed buffer.
  startaddress := StrToInt('$' + IntToHex(ROM[offset+1],2) + IntToHex(ROM[offset],2))
    - NameTableSettings.NameTableAddress;

  inc(offset,2);

  while (ROM[offset] <> $FF) do
  begin

    if ROM[offset] and $80 = $80 then
    begin
      num := ROM[offset] and $7F;
      for i := 0 to num -1 do
      begin
        _UncompressedBuffer[startaddress] := ROM[offset + 1 + i];
        inc(startaddress);
      end;
      inc(offset,num+1);
    end
    else
    begin
      num := ROM[offset] and $7f;
      for i := 0 to num -1 do
      begin
        _UncompressedBuffer[startaddress] := ROM[offset + 1];
        inc(startaddress);
      end;

      inc(offset,2);

    end;
  end;

end;

procedure TNameTable.CompressData;
begin

end;


procedure TNameTable.DumpDecompressedData(pFilename : String);
var
  Mem : TMemoryStream;
  i : Integer;
begin

  Mem := TMemoryStream.Create;
  try
    Mem.SetSize(high(self._UnCompressedBuffer));

    Mem.Position :=0;

    for i := 0 to mem.Size do
      Mem.Write(self._UnCompressedBuffer[i],1);

    Mem.SaveToFile(pFilename);
  finally
    FreeAndNil(Mem);
  end;


end;


end.
