unit fAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, shellapi, ComCtrls;

type
  TfrmAbout = class(TForm)
    cmdOK: TButton;
    lblHomepage: TLabel;
    pgcAbout: TPageControl;
    tshAbout: TTabSheet;
    tshSpecialThanksGreetings: TTabSheet;
    lblThanks: TLabel;
    lblDescription: TLabel;
    tshTripnSlipProgInfo: TTabSheet;
    lblComponents: TLabel;
    lblGreetings: TLabel;
    lblCompiled: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses uResourcestrings, uToday;

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  Caption := 'About ' + APPLICATIONTITLE + ' [Build: ' + COMPILETIME + ']';
end;

procedure TfrmAbout.lblHomepageClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar('http://dan.panicus.org'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.lblHomepageMouseEnter(Sender: TObject);
begin
  lblHomepage.Font.Style := [fsUnderline];
end;

procedure TfrmAbout.lblHomepageMouseLeave(Sender: TObject);
begin
  lblHomepage.Font.Style := [];
end;

end.
