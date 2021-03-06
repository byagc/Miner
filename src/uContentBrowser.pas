unit uContentBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Buttons, SynEdit, Vcl.ExtCtrls, Vcl.ClipBrd,
  SynEditHighlighter, SynHighlighterSQL, System.Actions,
  Vcl.ActnList,
  Vcl.ExtDlgs,
  ChromeTabs,
  ChromeTabsTypes,
  ChromeTabsUtils,
  ChromeTabsControls,
  ChromeTabsThreadTimer,
  ChromeTabsClasses, Vcl.OleCtrls, SHDocVw,
  uCEFChromiumWindow, uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFApplication, uCEFTypes, uCEFConstants,
  Vcl.Menus, uBase;

type
  TfrmContentBrowser = class(TfrmContentBase)
    CEFWindowParent1: TCEFWindowParent;
    Chromium1: TChromium;
    btnWebGo: TSpeedButton;
    NavControlPnl: TPanel;
    NavButtonPnl: TPanel;
    BackBtn: TButton;
    ForwardBtn: TButton;
    ReloadBtn: TButton;
    StopBtn: TButton;
    URLEditPnl: TPanel;
    ConfigPnl: TPanel;
    editUrlAddress: TEdit;
    DevTools: TCEFWindowParent;
    Splitter1: TSplitter;

    procedure FormShow(Sender: TObject);

    procedure editUrlAddressKeyPress(Sender: TObject; var Key: Char);
    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure ReloadBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure actWebGoExecute(Sender: TObject);

    procedure Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1StatusMessage(Sender: TObject; const browser: ICefBrowser; const value: ustring);
    procedure Chromium1AddressChange(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
    procedure Chromium1BeforeContextMenu(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
    procedure Chromium1ContextMenuCommand(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; commandId: Integer; eventFlags: TCefEventFlags; out Result: Boolean);
    procedure Chromium1FullScreenModeChange(Sender: TObject; const browser: ICefBrowser; fullscreen: Boolean);
    procedure Chromium1KeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out Result: Boolean);
    procedure Chromium1PreKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out isKeyboardShortcut, Result: Boolean);
    procedure Chromium1ProcessMessageReceived(Sender: TObject; const browser: ICefBrowser; sourceProcess: TCefProcessId; const message: ICefProcessMessage; out Result: Boolean);
    procedure Chromium1TextResultAvailable(Sender: TObject; const aText: string);
    procedure Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser; const title: ustring);
    procedure Chromium1LoadingStateChange(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
    procedure Chromium1BeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess: Boolean; out Result: Boolean);
    procedure FormCreate(Sender: TObject);
  protected
  private
    FHomepage: string;
    procedure BrowserCreatedMsg(var aMessage: TMessage); message MINIBROWSER_CREATED;
    procedure BrowserRefresh(var aMessage: TMessage); message MINIBROWSER_REFRESH;

    procedure ShowDevToolsMsg(var aMessage: TMessage); message MINIBROWSER_SHOWDEVTOOLS;
    procedure HideDevToolsMsg(var aMessage: TMessage); message MINIBROWSER_HIDEDEVTOOLS;
    procedure CopyHTMLMsg(var aMessage: TMessage); message MINIBROWSER_COPYHTML;
    procedure VisitDOMMsg(var aMessage: TMessage); message MINIBROWSER_VISITDOM;

    procedure AddURL(const aURL: string);
    procedure HideDevTools;
    procedure ShowDevTools(aPoint: TPoint); overload;
    procedure ShowDevTools; overload;
    procedure ViewSource;

  public
    property Homepage: string read FHomepage write FHomepage;

  end;

var
  frmContentBrowser: TfrmContentBrowser;

implementation

uses
  // ceflib,
  uDataModule, uMain, uCEFProcessMessage, uCEFSchemeHandlerFactory, uMinerScheme;

{$R *.dfm}

procedure TfrmContentBrowser.ViewSource();
var
  data: tstringlist;
  CefStringVisitor: ICefStringVisitor;
begin
  data := tstringlist.create;
  Chromium1.browser.MainFrame.GetSource(CefStringVisitor);
  // data.text := Chromium1.browser.MainFrame.;
  // data.free;
end;

procedure TfrmContentBrowser.ShowDevToolsMsg(var aMessage: TMessage);
begin
  ShowDevTools();
end;

procedure TfrmContentBrowser.HideDevToolsMsg(var aMessage: TMessage);
begin
  HideDevTools();
end;

procedure TfrmContentBrowser.ShowDevTools(aPoint: TPoint);
begin
  Splitter1.Visible := True;
  DevTools.Visible := True;
  DevTools.Height := Height div 4;
  Chromium1.ShowDevTools(aPoint, DevTools);
  DevToolsVisible := True;
end;

procedure TfrmContentBrowser.ShowDevTools;
var
  TempPoint: TPoint;
begin
  TempPoint.x := low(Integer);
  TempPoint.y := low(Integer);
  ShowDevTools(TempPoint);
end;

procedure TfrmContentBrowser.HideDevTools;
begin
  Chromium1.CloseDevTools(DevTools);
  Splitter1.Visible := False;
  DevTools.Visible := False;
  DevTools.Height := 0;
  DevToolsVisible := False;
end;

procedure TfrmContentBrowser.CopyHTMLMsg(var aMessage: TMessage);
begin
  Chromium1.RetrieveHTML;
end;

procedure TfrmContentBrowser.VisitDOMMsg(var aMessage: TMessage);
var
  TempMsg: ICefProcessMessage;
begin
  // Only works using a TCefCustomRenderProcessHandler. See MiniBrowser demo.
  // Use the ArgumentList property if you need to pass some parameters.
  TempMsg := TCefProcessMessageRef.new('retrievedom');
  // Same name than TCefCustomRenderProcessHandler.MessageName
  Chromium1.SendProcessMessage(PID_RENDERER, TempMsg);
end;

procedure TfrmContentBrowser.actWebGoExecute(Sender: TObject);
begin
  inherited;
  Chromium1.LoadURL(editUrlAddress.text);
end;

procedure TfrmContentBrowser.Chromium1AddressChange(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
begin
  inherited;
  AddURL(url);
  // frmMain.Caption := url;
end;

procedure TfrmContentBrowser.Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
begin
  inherited;
  PostMessage(Handle, MINIBROWSER_CREATED, 0, 0);
end;

procedure TfrmContentBrowser.Chromium1BeforeContextMenu(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
begin
  inherited;
  model.AddItem(MINIBROWSER_CONTEXTMENU_REFRESH, 'Atualizar');
  model.AddSeparator;
  model.AddItem(MINIBROWSER_CONTEXTMENU_SHOWJSALERT, 'Show JS Alert');
  model.AddItem(MINIBROWSER_CONTEXTMENU_SETJSEVENT, 'Set mouseover event');
  model.AddItem(MINIBROWSER_CONTEXTMENU_COPYHTML, 'Copiar HTML para Clipboard');
  model.AddItem(MINIBROWSER_CONTEXTMENU_VISITDOM, 'Visit DOM');
  model.AddItem(MINIBROWSER_CONTEXTMENU_JSWRITEDOC, 'Modificar HTML');
  model.AddItem(MINIBROWSER_CONTEXTMENU_JSPRINTDOC, 'Imprimir usando Javascript');
  // model.AddItem(MINIBROWSER_CONTEXTMENU_REGSCHEME, 'Registrar Scheme');
  // model.AddItem(MINIBROWSER_CONTEXTMENU_CLEARFACT, 'Limpar Schemes');

  if DevToolsVisible then
    model.AddItem(MINIBROWSER_CONTEXTMENU_HIDEDEVTOOLS, 'Hide DevTools')
  else
    model.AddItem(MINIBROWSER_CONTEXTMENU_SHOWDEVTOOLS, 'Show DevTools');

end;

procedure TfrmContentBrowser.Chromium1BeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
  var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess: Boolean; out Result: Boolean);
begin
  inherited;
  browser.StopLoad;
  Result := True;
  frmMain.OpenPopup := targetUrl;
  frmMain.Timer1.Enabled := True;
end;

procedure TfrmContentBrowser.Chromium1ContextMenuCommand(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; commandId: Integer; eventFlags: TCefEventFlags; out Result: Boolean);
var
  TempParam: WParam;
  TempFactory: ICefSchemeHandlerFactory;
begin
  inherited;
  Result := False;

  case commandId of
    MINIBROWSER_CONTEXTMENU_HIDEDEVTOOLS:
      PostMessage(Handle, MINIBROWSER_HIDEDEVTOOLS, 0, 0);

    MINIBROWSER_CONTEXTMENU_SHOWDEVTOOLS:
      begin
        TempParam := ((params.XCoord and $FFFF) shl 16) or (params.YCoord and $FFFF);
        PostMessage(Handle, MINIBROWSER_SHOWDEVTOOLS, TempParam, 0);
      end;

    MINIBROWSER_CONTEXTMENU_SHOWJSALERT:
      if (browser <> nil) and (browser.MainFrame <> nil) then
        browser.MainFrame.ExecuteJavaScript('alert(''JavaScript execute works!'');', 'about:blank', 0);

    MINIBROWSER_CONTEXTMENU_SETJSEVENT:
      if (browser <> nil) and (browser.MainFrame <> nil) then
        browser.MainFrame.ExecuteJavaScript('document.body.addEventListener("mouseover", function(evt){' + 'function getpath(n){' + 'var ret = "<" + n.nodeName + ">";' + 'if (n.parentNode){return getpath(n.parentNode) + ret} else ' + 'return ret' + '};' +
          'myextension.mouseover(getpath(evt.target))}' + ')', 'about:blank', 0);

    MINIBROWSER_CONTEXTMENU_COPYHTML:
      PostMessage(Handle, MINIBROWSER_COPYHTML, 0, 0);

    MINIBROWSER_CONTEXTMENU_VISITDOM:
      PostMessage(Handle, MINIBROWSER_VISITDOM, 0, 0);

    MINIBROWSER_CONTEXTMENU_JSWRITEDOC:
      if (browser <> nil) and (browser.MainFrame <> nil) then
        browser.MainFrame.ExecuteJavaScript('var css = ' + chr(39) + '@page {size: A4; margin: 0;} @media print {html, body {width: 210mm; height: 297mm;}}' + chr(39) + '; ' + 'var style = document.createElement(' + chr(39) + 'style' + chr(39) + '); ' + 'style.type = ' + chr(39) + 'text/css' +
          chr(39) + '; ' + 'style.appendChild(document.createTextNode(css)); ' + 'document.head.appendChild(style);', 'about:blank', 0);

    MINIBROWSER_CONTEXTMENU_JSPRINTDOC:
      if (browser <> nil) and (browser.MainFrame <> nil) then
        browser.MainFrame.ExecuteJavaScript('window.print();', 'about:blank', 0);

    MINIBROWSER_CONTEXTMENU_REGSCHEME:
      if (browser <> nil) and (browser.host <> nil) and (browser.host.RequestContext <> nil) then
      begin
        // You can register the Scheme Handler Factory in the DPR file or later, for example in a context menu command.
        TempFactory := TCefSchemeHandlerFactoryOwn.create(TMinerScheme);
        if not(browser.host.RequestContext.RegisterSchemeHandlerFactory('hello', '', TempFactory)) then
          MessageDlg('RegisterSchemeHandlerFactory error !', mtError, [mbOk], 0);
      end;

    MINIBROWSER_CONTEXTMENU_CLEARFACT:
      if (browser <> nil) and (browser.host <> nil) and (browser.host.RequestContext <> nil) then
      begin
        if not(browser.host.RequestContext.ClearSchemeHandlerFactories) then
          MessageDlg('ClearSchemeHandlerFactories error !', mtError, [mbOk], 0);
      end;
    MINIBROWSER_CONTEXTMENU_REFRESH:
      if (browser <> nil) and (browser.host <> nil) and (browser.host.RequestContext <> nil) then
      begin
        browser.Reload;
      end;
  end;

end;

procedure TfrmContentBrowser.Chromium1FullScreenModeChange(Sender: TObject; const browser: ICefBrowser; fullscreen: Boolean);
begin
  inherited;
  if fullscreen then
  begin
    NavControlPnl.Visible := False;
    if (WindowState = wsMaximized) then
      WindowState := wsNormal;
    BorderIcons := [];
    BorderStyle := bsNone;
    WindowState := wsMaximized;
  end
  else
  begin
    BorderIcons := [biSystemMenu, biMinimize, biMaximize];
    BorderStyle := bsSizeable;
    WindowState := wsNormal;
    NavControlPnl.Visible := True;
  end;
end;

procedure TfrmContentBrowser.Chromium1KeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out Result: Boolean);
var
  TempMsg: TMsg;
begin
  inherited;
  Result := False;
  if (event <> nil) and (osEvent <> nil) then
    case osEvent.message of
      WM_KEYUP:
        begin
          TempMsg := osEvent^;
          frmMain.HandleKeyUp(TempMsg, Result);
        end;

      WM_KEYDOWN:
        begin
          TempMsg := osEvent^;
          frmMain.HandleKeyDown(TempMsg, Result);
        end;
    end;
end;

procedure TfrmContentBrowser.Chromium1PreKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out isKeyboardShortcut, Result: Boolean);
begin
  inherited;
  Result := False;
  if (event <> nil) and (event.kind in [KEYEVENT_KEYDOWN, KEYEVENT_KEYUP]) and ((event.windows_key_code = VK_F12) or (event.windows_key_code = VK_F5)) then
    isKeyboardShortcut := True;
end;

procedure TfrmContentBrowser.Chromium1LoadingStateChange(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
begin
  inherited;
  BackBtn.Enabled := canGoBack;
  ForwardBtn.Enabled := canGoForward;
  ReloadBtn.Enabled := not(isLoading);
  StopBtn.Enabled := isLoading;
end;

procedure TfrmContentBrowser.Chromium1ProcessMessageReceived(Sender: TObject; const browser: ICefBrowser; sourceProcess: TCefProcessId; const message: ICefProcessMessage; out Result: Boolean);
begin
  inherited;
  if (message <> nil) and (message.Name = 'mouseover') and (message.ArgumentList <> nil) then
  begin
    // Message received from the extension
    frmMain.StatusBar1.Panels[2].text := message.ArgumentList.GetString(0);
    Result := True;
  end
  else
    Result := False;

end;

procedure TfrmContentBrowser.Chromium1StatusMessage(Sender: TObject; const browser: ICefBrowser; const value: ustring);
begin
  inherited;
  frmMain.StatusBar1.Panels[2].text := value;
end;

procedure TfrmContentBrowser.Chromium1TextResultAvailable(Sender: TObject; const aText: string);
begin
  inherited;
  clipboard.AsText := aText;
end;

procedure TfrmContentBrowser.Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser; const title: ustring);
begin
  inherited;
  if (title <> '') then
    Caption := title
  else
    Caption := 'agcMiner';

end;

procedure TfrmContentBrowser.FormCreate(Sender: TObject);
begin
  inherited;
  DevTools.Height := 0;
end;

procedure TfrmContentBrowser.FormShow(Sender: TObject);
var
  I: Integer;
begin
  inherited;

  MakeDelay(1000);
  Chromium1.CreateBrowser(CEFWindowParent1, '');
  MakeDelay(1000);
  PostMessage(self.Handle, WM_SIZE, 0, 0);
  Chromium1.NotifyMoveOrResizeStarted;
end;

procedure TfrmContentBrowser.ForwardBtnClick(Sender: TObject);
begin
  inherited;
  Chromium1.GoForward;
end;

procedure TfrmContentBrowser.ReloadBtnClick(Sender: TObject);
begin
  inherited;
  Chromium1.Reload;
end;

procedure TfrmContentBrowser.StopBtnClick(Sender: TObject);
begin
  inherited;
  Chromium1.StopLoad;
end;

procedure TfrmContentBrowser.editUrlAddressKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    actWebGoExecute(Sender);
  end;

end;

procedure TfrmContentBrowser.BackBtnClick(Sender: TObject);
begin
  inherited;
  Chromium1.GoBack;
end;

procedure TfrmContentBrowser.AddURL(const aURL: string);
begin
  // if (URLCbx.Items.IndexOf(aURL) < 0) then
  // URLCbx.Items.Add(aURL);
  editUrlAddress.text := aURL;
end;

procedure TfrmContentBrowser.BrowserCreatedMsg(var aMessage: TMessage);
begin
  NavControlPnl.Enabled := True;
  if Homepage <> '' then
  begin
    AddURL(Homepage); // MINIBROWSER_HOMEPAGE
    if Homepage <> '' then
      Chromium1.LoadURL(Homepage);
  end;
end;

procedure TfrmContentBrowser.BrowserRefresh(var aMessage: TMessage);
begin
  if Homepage <> '' then
  begin
    Chromium1.Reload;
  end;
end;

end.
