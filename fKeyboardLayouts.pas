unit fKeyboardLayouts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmKeyboardLayout = class(TForm)
    mmoKeyboardLayout: TMemo;
    cmdOk: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyboardLayout: TfrmKeyboardLayout;

implementation

{$R *.dfm}

end.
