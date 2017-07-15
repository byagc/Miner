program Miner;

{$I cef.inc}

uses
  {$IFDEF DELPHI16_UP}
  Vcl.Forms,
  {$ELSE}
  Forms,
  {$ENDIF }
  uCEFApplication,
  uCEFMiscFunctions,
  uCEFSchemeRegistrar,
  uCEFRenderProcessHandler,
  uCEFv8Handler,
  uCEFInterfaces,
  uCEFDomVisitor,
  uCEFConstants,
  uCEFTypes,
  uCEFTask,
  uMain in 'uMain.pas' {frmMain},
  uTestExtension in 'uTestExtension.pas',
  uPreferences in 'uPreferences.pas' {PreferencesFrm},
  uContentBase in 'uContentBase.pas' {frmContentBase},
  uDataModule in 'uDataModule.pas' {dmDataModule: TDataModule},
  uContentNotepad in 'uContentNotepad.pas' {frmNotepad},
  uContentBrowser in 'uContentBrowser.pas' {frmContentBrowser},
  uContentHTML in 'uContentHTML.pas' {frmContentHTML},
  uMinerScheme in 'uMinerScheme.pas',
  uBase in 'uBase.pas';

{$R *.res}
// CEF3 needs to set the LARGEADDRESSAWARE flag which allows 32-bit processes to use up to 3GB of RAM.
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  TempProcessHandler: TCefCustomRenderProcessHandler;

procedure DOMVisitor_OnDocAvailable(const document: ICefDomDocument);
begin
  // This function is called from a different process.
  // document is only valid inside this function.
  // As an example, this function only writes the document title to the 'debug.log' file.
  CefLog('CEF4Delphi', 1, CEF_LOG_SEVERITY_ERROR, 'document.Title : ' + document.Title);
end;

procedure ProcessHandler_OnCustomMessage(const browser: ICefBrowser; sourceProcess: TCefProcessId; const message: ICefProcessMessage);
var
  TempFrame: ICefFrame;
  TempVisitor: TCefFastDomVisitor;
begin
  if (browser <> nil) then
  begin
    TempFrame := browser.MainFrame;

    if (TempFrame <> nil) then
    begin
      TempVisitor := TCefFastDomVisitor.Create(DOMVisitor_OnDocAvailable);
      TempFrame.VisitDom(TempVisitor);
    end;
  end;
end;

procedure ProcessHandler_OnWebKitReady;
begin
{$IFDEF DELPHI14_UP}
  // Registering the extension. Read this document for more details :
  // https://bitbucket.org/chromiumembedded/cef/wiki/JavaScriptIntegration.md
  TCefRTTIExtension.Register('myextension', TTestExtension);
{$ENDIF}
end;

procedure GlobalCEFApp_OnRegCustomSchemes(const registrar: TCefSchemeRegistrarRef);
begin
  registrar.AddCustomScheme('miner', True, True, False, False, False, False);
end;

begin
  // This ProcessHandler is used for the extension and the DOM visitor demos.
  // It can be removed if you don't want those features.
  TempProcessHandler := TCefCustomRenderProcessHandler.Create;
  TempProcessHandler.MessageName := 'retrievedom';
  // same message name than TMiniBrowserFrm.VisitDOMMsg
  TempProcessHandler.OnCustomMessage := ProcessHandler_OnCustomMessage;
  TempProcessHandler.OnWebKitReady := ProcessHandler_OnWebKitReady;

  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.RemoteDebuggingPort := 9000;
  GlobalCEFApp.RenderProcessHandler := TempProcessHandler as ICefRenderProcessHandler;
  GlobalCEFApp.OnRegCustomSchemes := GlobalCEFApp_OnRegCustomSchemes;

  // In case you want to use custom directories for the CEF3 binaries, cache, cookies and user data.
  {
    GlobalCEFApp.FrameworkDirPath     := 'cef';
    GlobalCEFApp.ResourcesDirPath     := 'cef';
    GlobalCEFApp.LocalesDirPath       := 'cef\locales';
    GlobalCEFApp.UserDataPath         := 'cef\User Data';
  }
  GlobalCEFApp.cache := 'cache';
  GlobalCEFApp.cookies := 'cookies';

  // Enabling the debug log file for then DOM visitor demo.
  // This adds lots of warnings to the console, specially if you run this inside VirtualBox.
  // Remove it if you don't want to use the DOM visitor
  GlobalCEFApp.LogFile := 'debug.log';
  GlobalCEFApp.LogSeverity := LOGSEVERITY_ERROR;

  // Examples of command line switches.
  // **********************************
  //
  // Uncomment the following line to see an FPS counter in the browser.
  // GlobalCEFApp.AddCustomCommandLine('--show-fps-counter');
  //
  // Uncomment the following line to change the user agent string.
  // GlobalCEFApp.AddCustomCommandLine('--user-agent', 'MiniBrowser');

  if GlobalCEFApp.StartMainProcess then
  begin
    // You can register the Scheme Handler Factory here or later, for example in a context menu command.
    CefRegisterSchemeHandlerFactory('miner', '', TMinerScheme);

    Application.Initialize;
{$IFDEF DELPHI11_UP}
    Application.MainFormOnTaskbar := True;
{$ENDIF}
    Application.CreateForm(TdmDataModule, dmDataModule);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TPreferencesFrm, PreferencesFrm);
  Application.CreateForm(TfrmContentBase, frmContentBase);
  Application.CreateForm(TfrmContentHTML, frmContentHTML);
  // Application.CreateForm(TfrmContentHome, frmContentHome);
    // Application.CreateForm(TfrmNotepad, frmNotepad);
    // Application.CreateForm(TfrmContentBrowser, frmContentBrowser);
    Application.Run;
  end;

  GlobalCEFApp.Free;

end.
