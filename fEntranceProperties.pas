unit fEntranceProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cROMData;

type
  TfrmEntranceProperties = class(TForm)
    lblEntranceID: TLabel;
    lblScreen: TLabel;
    cbScreen: TComboBox;
    chkFollow: TCheckBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    cmdScreenSelect: TButton;
    procedure FormShow(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    _ID : Integer;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    property ID : Integer read _ID write _ID;
    { Public declarations }
  end;

var
  frmEntranceProperties: TfrmEntranceProperties;

implementation

{$R *.dfm}

procedure TfrmEntranceProperties.FormShow(Sender: TObject);
begin
  lblEntranceID.Caption := 'Entrance ID: ' + IntToStr(_ID);

end;

constructor TfrmEntranceProperties.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
