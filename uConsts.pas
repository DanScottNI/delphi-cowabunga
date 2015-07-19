unit uConsts;

interface

uses GR32;

type
  TObjDetect = record
    ObjType : integer;
    ObjIndex : Integer;
  end;

const
  DEBUG : Boolean = True;
  CRLF : String = Chr(13) + Chr(10);
{  SolidityColours : Array [0..15] of TColor32 = (clBlue32,clLightGray32,
    clYellow32,clMaroon32,clGreen32,clOlive32,clNavy32,clPurple32,clTeal32,
    clRed32,clLime32,clBlue32,clFuchsia32,clAqua32,$FFD09EF6,$FFA7F5F0);}
  // The editing modes.
  MAPEDITINGMODE : Byte = 0;
  OBJECTEDITINGMODE : Byte = 1;
  // The various types of objects.
  OBJENEMY : Integer = 1;
  OBJSPECIAL : Integer =2;
  OBJENTRANCE : Integer = 3;
  OBJBOSS : Integer = 4;
  // Used in list loading
  UNKNOWNENEMY : String = 'N\A';
  // View Options
  VIEWENEMIES : Byte = 1;
  VIEWSPECIALOBJECTS : Byte = 2;
  VIEWBOSSDATA : Byte = 4;
  VIEWEXITDATA : Byte = 8;
  VIEWENTRANCEDATA : Byte =16;
  // The type of open dialog to use
  USECUSTOMOPENDIALOG : Byte = 0;
  USESTANDARDOPENDIALOG : Byte = 1;
  // The size of the level map blocks
  LEVELMAPBLOCKSIZE : Byte = 12;
implementation

end.
