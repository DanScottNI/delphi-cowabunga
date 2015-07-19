unit fGoToLevel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cROMData;

type
  TfrmGoToLevel = class(TForm)
    lstLevels: TListBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    { Private declarations }
  public
    Level : Integer;
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    { Public declarations }
  end;

var
  frmGoToLevel: TfrmGoToLevel;

implementation

{$R *.dfm}

procedure TfrmGoToLevel.FormShow(Sender: TObject);
var
  i : Integer;
begin
  lstLevels.Items.BeginUpdate;
  lstLevels.Clear;

  for i := 0 to _ROMData.CurrLevel.SideScroll.Count -1 do
    lstLevels.Items.Add(IntToStr(_ROMData.CurrentLevel+1) + '-' + IntToStr(i+1));
  
  lstLevels.Items.EndUpdate;
  lstLevels.ItemIndex := _ROMData.CurrentLevel;
end;

procedure TfrmGoToLevel.cmdOKClick(Sender: TObject);
begin
  Level := lstLevels.ItemIndex;
end;

constructor TfrmGoToLevel.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
