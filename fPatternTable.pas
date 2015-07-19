unit fPatternTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32,GR32_Image, ComCtrls, ExtCtrls;

type
  TfrmPatternTableSettings = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPatternTableSettings: TfrmPatternTableSettings;

implementation

{$R *.dfm}

uses unit_global;

end.
