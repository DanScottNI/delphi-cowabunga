unit fWorldScreenNumbers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cROMData;

type
  TfrmWorldScreenCount = class(TForm)
    lblWorld1: TLabel;
    lblWorld2: TLabel;
    lblWorld3: TLabel;
    lblWorld4: TLabel;
    lblWorld5: TLabel;
    lblWorld6: TLabel;
    scrWorld1: TScrollBar;
    scrWorld2: TScrollBar;
    scrWorld3: TScrollBar;
    scrWorld4: TScrollBar;
    scrWorld5: TScrollBar;
    scrWorld6: TScrollBar;
    lblWorld1Count: TLabel;
    lblWorld3Count: TLabel;
    lblWorld2Count: TLabel;
    lblWorld4Count: TLabel;
    lblWorld5Count: TLabel;
    lblWorld6Count: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    procedure LoadSettings;
    procedure SaveSettings;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    { Public declarations }
  end;

var
  frmWorldScreenCount: TfrmWorldScreenCount;

implementation

{$R *.dfm}

procedure TfrmWorldScreenCount.LoadSettings;
begin

  scrWorld1.Position := _ROMData.GetHighestScreenNumber(0);
  scrWorld2.Position := _ROMData.GetHighestScreenNumber(1);
  scrWorld3.Position := _ROMData.GetHighestScreenNumber(2);
  scrWorld4.Position := _ROMData.GetHighestScreenNumber(3);
  scrWorld5.Position := _ROMData.GetHighestScreenNumber(4);
  scrWorld6.Position := _ROMData.GetHighestScreenNumber(5);

  lblWorld1Count.Caption := IntToStr(scrWorld1.Position);
  lblWorld2Count.Caption := IntToStr(scrWorld2.Position);
  lblWorld3Count.Caption := IntToStr(scrWorld3.Position);
  lblWorld4Count.Caption := IntToStr(scrWorld4.Position);
  lblWorld5Count.Caption := IntToStr(scrWorld5.Position);
  lblWorld6Count.Caption := IntToStr(scrWorld6.Position);

end;

procedure TfrmWorldScreenCount.SaveSettings;
begin
  { TODO : SaveSettings in TfrmWorldScreenCount }
end;

procedure TfrmWorldScreenCount.FormShow(Sender: TObject);
begin
  LoadSettings;
end;

constructor TfrmWorldScreenCount.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
