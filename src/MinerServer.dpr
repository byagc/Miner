program MinerServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uServerMain in 'uServerMain.pas' {frmMain},
  uServerMethods in 'uServerMethods.pas',
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  uServerWebModule in 'uServerWebModule.pas' {WebModule1: TWebModule},
  uServerDB in 'uServerDB.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
