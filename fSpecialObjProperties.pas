unit fSpecialObjProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DanHexEdit;

type
  TfrmSpecialObjProperties = class(TForm)
    lblRoom: TLabel;
    lblID: TLabel;
    lblUnknownX: TLabel;
    lblUnknownY: TLabel;
    lblUnknown1: TLabel;
    lblUnknown2: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    txtX1: TDanHexEdit;
    txtUnknownY: TDanHexEdit;
    txtUnknown1: TDanHexEdit;
    txtUnknown2: TDanHexEdit;
    cbID: TComboBox;
    cbRoom: TComboBox;
    lblX: TLabel;
    lblY: TLabel;
    cmdScreenSelect: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    procedure LoadSpecialObj;
    procedure SaveSpecialObj;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSpecialObjProperties: TfrmSpecialObjProperties;

implementation

{$R *.dfm}

procedure TfrmSpecialObjProperties.cmdOKClick(Sender: TObject);
begin
  SaveSpecialObj;
end;

procedure TfrmSpecialObjProperties.FormShow(Sender: TObject);
begin
  LoadSpecialObj;
end;

procedure TfrmSpecialObjProperties.LoadSpecialObj;
begin
  { TODO : LoadSpecialObj in TfrmSpecialObjProperties }
end;

procedure TfrmSpecialObjProperties.SaveSpecialObj;
begin
  { TODO : SaveSpecialObj in TfrmSpecialObjProperties }
end;

end.
