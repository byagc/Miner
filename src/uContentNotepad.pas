unit uContentNotepad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ExtCtrls,
  SynEdit, System.Actions, Vcl.ActnList, SynEditHighlighter,
  SynHighlighterPHP, SynHighlighterJScript;

type
  TfrmNotepad = class(TfrmContentBase)
    SynEdit1: TSynEdit;
    Panel1: TPanel;
    SynPHPSyn1: TSynPHPSyn;
    SynJScriptSyn1: TSynJScriptSyn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotepad: TfrmNotepad;

implementation

{$R *.dfm}

end.