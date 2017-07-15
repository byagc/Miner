unit uMain;

{$I cef.inc}

interface

uses
{$IFDEF DELPHI16_UP}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Menus,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Types, Vcl.ComCtrls, Vcl.ClipBrd,
  System.UITypes, Vcl.AppEvnts,
{$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Menus,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Types, ComCtrls, ClipBrd,
  AppEvnts,
{$ENDIF}
  uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFApplication, uCEFTypes,
  uCEFConstants,
  System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI

    , IOUtils, Vcl.Grids, Vcl.DBGrids, Vcl.Shell.ShellCtrls,
  uCEFChromiumWindow, Vcl.Buttons,
  System.Win.Registry,

  adpMRU, uContentBase, uContentHTML, uContentBrowser,
  ChromeTabs, ChromeTabsTypes, ChromeTabsUtils, ChromeTabsControls, ChromeTabsThreadTimer, ChromeTabsClasses,
  uBase, DwmApi;

type

  TMyData = class(TComponent)
  private
    FDir: String;
    FString2: String;
    FInteger1: Integer;
  published
    property Dir: String read FDir write FDir;
    property String2: String read FString2 write FString2;
    property Integer1: Integer read FInteger1 write FInteger1;
  end;

  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    ConfigBtn: TButton;
    PopupMenu1: TPopupMenu;
    DevTools1: TMenuItem;
    N1: TMenuItem;
    Preferences1: TMenuItem;
    N2: TMenuItem;
    PrintinPDF1: TMenuItem;
    Print1: TMenuItem;
    N3: TMenuItem;
    Zoom1: TMenuItem;
    Inczoom1: TMenuItem;
    Deczoom1: TMenuItem;
    Resetzoom1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ApplicationEvents1: TApplicationEvents;
    Memo1: TMemo;
    Tabs: TChromeTabs;
    PanelMainContainer: TPanel;
    ActionManager1: TActionManager;
    actHome: TAction;
    actFileExit: TAction;
    actNewEditor: TAction;
    actWebGo: TAction;
    actNewBrowser: TAction;
    PanelMainTop: TPanel;
    Panel5: TPanel;
    Notepad1: TMenuItem;
    PanelMainLeft: TPanel;
    Panel9: TPanel;
    cbAllow: TCheckBox;
    Button1: TButton;
    miShowLeftPainel: TMenuItem;
    actShowLeftPainel: TAction;
    Timer1: TTimer;
    Sair1: TMenuItem;
    PanelMain: TPanel;
    TreeView1: TTreeView;
    Splitter1: TSplitter;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

    procedure PopupMenu1Popup(Sender: TObject);
    procedure Preferences1Click(Sender: TObject);
    procedure ConfigBtnClick(Sender: TObject);
    procedure PrintinPDF1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure btnADDClick(Sender: TObject);

    procedure TabsActiveTabChanged(Sender: TObject; ATab: TChromeTab);
    procedure TabsButtonAddClick(Sender: TObject; var Handled: Boolean);
    procedure TabsButtonCloseTabClick(Sender: TObject; ATab: TChromeTab; var Close: Boolean);
    procedure TabsActiveTabChanging(Sender: TObject; AOldTab, ANewTab: TChromeTab; var Allow: Boolean);

    procedure actNewBrowserExecute(Sender: TObject);
    procedure actNewEditorExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure actShowLeftPainelExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
  protected
    procedure AddURL(const aURL: string);
    procedure BrowserCreatedMsg(var aMessage: TMessage); message MINIBROWSER_CREATED;
    procedure ShowDevToolsMsg(var aMessage: TMessage); message MINIBROWSER_SHOWDEVTOOLS;
    procedure HideDevToolsMsg(var aMessage: TMessage); message MINIBROWSER_HIDEDEVTOOLS;
    procedure CopyHTMLMsg(var aMessage: TMessage); message MINIBROWSER_COPYHTML;
    procedure VisitDOMMsg(var aMessage: TMessage); message MINIBROWSER_VISITDOM;
    procedure WMMove(var aMessage: TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage: TMessage); message WM_MOVING;
    procedure WMResize(var aMessage: TWMSIZE); message WM_SIZE;
    // procedure WMResizing(var aMessage: TWMSize); //  message WM_SIZING;

    // procedure CreateParams(var Params: TCreateParams); override;

  private
    FMsgHwnd: HWND;
    FMRU: TadpMRU;
    FWndFrameSize: Integer;
    FHome: TfrmContentHTML;
    FSettings: TfrmContentHTML;
    ContentActive: TfrmContentBase;
    procedure OnInputQuery_Close(const AValues: array of string);
    procedure MasterSearch(sQuery: String);
    procedure Terminate;
    procedure SaveState;
    procedure LoadState;
    class procedure CheckForInstance; static;
    procedure OpenFromCmd(ACmd: String);
    procedure WndMethod(var Msg: TMessage);
    procedure WndProc(var Message: TMessage);
    procedure RefreshActions;
    procedure RefreshCaption;
    procedure DisplayContent(AContent: TfrmContentBase);
  public
    SHARED_DRIVE_DIR: String; // = 'D:\bkp\Arlon\OneDrive\soft\agcWork\';
    ActiveTab: Integer;
    OpenPopup: String;
    property MRU: TadpMRU read FMRU;
    procedure Navegar(sPage: uString);
    procedure CallNewBrowser(sPage: uString);
    procedure CallContentHTML(sPage: String);
    procedure HandleKeyUp(const aMsg: TMsg; var aHandled: Boolean);
    procedure HandleKeyDown(const aMsg: TMsg; var aHandled: Boolean);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uCEFProcessMessage, uCEFSchemeHandlerFactory, uContentNotepad;

procedure TfrmMain.OnInputQuery_Close(const AValues: array of string);
begin
end;

procedure TfrmMain.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYUP:
      HandleKeyUp(Msg, Handled);
    WM_KEYDOWN:
      HandleKeyDown(Msg, Handled);
  end;
end;

procedure TfrmMain.HandleKeyUp(const aMsg: TMsg; var aHandled: Boolean);
var
  TempMessage: TMessage;
  TempKeyMsg: TWMKey;
begin
  TempMessage.Msg := aMsg.Message;
  TempMessage.WParam := aMsg.WParam;
  TempMessage.lParam := aMsg.lParam;
  TempKeyMsg := TWMKey(TempMessage);

  if (TempKeyMsg.CharCode = VK_F12) then
  begin
    aHandled := True;
    Memo1.Lines.Add('F12');
    if Assigned(ContentActive) then
    begin
      if ContentActive.DevToolsVisible then
        PostMessage(ContentActive.Handle, MINIBROWSER_HIDEDEVTOOLS, 0, 0)
      else
        PostMessage(ContentActive.Handle, MINIBROWSER_SHOWDEVTOOLS, 0, 0);
    end;
  end;
  if (TempKeyMsg.CharCode = VK_F5) then
  begin
    aHandled := True;
    if Assigned(ContentActive) then
    begin
      PostMessage(ContentActive.Handle, MINIBROWSER_REFRESH, 0, 0);
      Memo1.Lines.Add('Atualizado');
    end;
  end;
end;

procedure TfrmMain.HandleKeyDown(const aMsg: TMsg; var aHandled: Boolean);
var
  TempMessage: TMessage;
  TempKeyMsg: TWMKey;
begin
  TempMessage.Msg := aMsg.Message;
  TempMessage.WParam := aMsg.WParam;
  TempMessage.lParam := aMsg.lParam;
  TempKeyMsg := TWMKey(TempMessage);

  if (TempKeyMsg.CharCode = VK_F12) then
    aHandled := True;
end;

procedure TfrmMain.DisplayContent(AContent: TfrmContentBase);
begin
  AContent.Parent := PanelMainContainer;
  AContent.BorderStyle := bsNone;
  AContent.Show;
  AContent.BringToFront;
  AContent.Align := alClient;
end;

procedure TfrmMain.SaveState;
var
  R: TRegistry;
begin
  R := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey(REG_KEY, True) then
    begin
      try
        R.WriteInteger('WindowState', Integer(WindowState));
        if (WindowState <> TWindowState.wsMaximized) then // sen�o salva dimensoes de uma janela maximizada
        begin
          R.WriteInteger('WindowWidth', Width);
          R.WriteInteger('WindowHeight', Height);
          R.WriteInteger('WindowLeft', Left);
          R.WriteInteger('WindowTop', Top);
        end;
        if (Splitter1.Left >= Splitter1.MinSize) then
        begin
          R.WriteBool('pLeft.Visible', PanelMainLeft.Visible);
          R.WriteInteger('pLeft.Width', PanelMainLeft.Width);
        end;
        // R.WriteBool('ShowLinesAffected', FShowLinesAffected);
      finally
        R.CloseKey;
      end;
    end
    else
    begin
      // Failed to open registry key
    end;
  finally
    R.Free;
  end;
end;

procedure TfrmMain.RefreshCaption;
var
  s: String;
  T: TChromeTab;
  C: TfrmContentBase;
begin
  s := 'agcMiner'; // SQL Script Executer
  T := Tabs.ActiveTab;
  if Assigned(T) then
  begin
    C := TfrmContentBase(T.Data);
    if Assigned(C) then
    begin
      s := s + ' - ' + C.caption;
    end;
  end;
  caption := s;
end;

procedure TfrmMain.RefreshActions;
// var
// Svr: TServerConnection;
// S: TfrmContentScriptExec;
begin
  {
    Svr := SelectedServer;
    actServerDisconnect.Enabled := Assigned(Svr);
    S := CurScript;
    if Assigned(S) then
    begin
    actFileSave.Enabled := S.actSave.Enabled;
    actFileSaveAs.Enabled := S.actSaveAs.Enabled;
    actEditUndo.Enabled := S.actUndo.Enabled;
    actCloseScript.Enabled := True;
    actScriptFont.Enabled := S.actFont.Enabled;
    actScriptExec.Enabled := S.actExecSql.Enabled;
    end
    else
    begin
    actFileSave.Enabled := False;
    actFileSaveAs.Enabled := False;
    actCloseScript.Enabled := False;
    actEditUndo.Enabled := False;
    actCloseScript.Enabled := False;
    actScriptFont.Enabled := False;
    actScriptExec.Enabled := False;
    end;
  }
  RefreshCaption;
end;

procedure TfrmMain.LoadState;
var
  R: TRegistry;
  iWindowState: Integer;
begin
  R := TRegistry.Create(KEY_READ);
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.KeyExists(REG_KEY) then
    begin
      if R.OpenKey(REG_KEY, False) then
      begin
        try
          if R.ValueExists('WindowState') then
          begin
            iWindowState := R.ReadInteger('WindowState');
            WindowState := TWindowState(iWindowState);
            if TWindowState(iWindowState) <> wsMaximized then
            begin
              if R.ValueExists('WindowWidth') then
                Width := R.ReadInteger('WindowWidth')
              else
                Width := 1200;

              if R.ValueExists('WindowHeight') then
                Height := R.ReadInteger('WindowHeight')
              else
                Height := 800;

              if R.ValueExists('WindowLeft') then
                Left := R.ReadInteger('WindowLeft')
              else
                Left := (Screen.Width div 2) - (Width div 2);

              if R.ValueExists('WindowTop') then
                Top := R.ReadInteger('WindowTop')
              else
                Top := (Screen.Height div 2) - (Height div 2);
            end;
          end;

          {
            if R.ValueExists('pMessages.Height') then
            pMessages.Height:= R.ReadInteger('pMessages.Height')
            else
            pMessages.Height:= 200;
          }

          if R.ValueExists('pLeft.Visible') then
          begin
            PanelMainLeft.Visible := R.ReadBool('pLeft.Visible');
            actShowLeftPainel.Checked := R.ReadBool('pLeft.Visible');
          end
          else
            PanelMainLeft.Visible := True;

          if R.ValueExists('pLeft.Width') then
            PanelMainLeft.Width := R.ReadInteger('pLeft.Width')
          else
            PanelMainLeft.Width := 250;

          {
            if R.ValueExists('pMessages.Visible') then
            pMessages.Visible:= R.ReadBool('pMessages.Visible')
            else
            pmessages.Visible:= True;

            if R.ValueExists('ED.Font.Color') then
            ED.Font.Name:= R.ReadString('ED.Font.Name');

            if R.ValueExists('ED.Font.Size') then
            ED.Font.Size:= R.ReadInteger('ED.Font.Size');

            if R.ValueExists('ShowLinesAffected') then
            FShowLinesAffected := R.ReadBool('ShowLinesAffected')
            else
            FShowLinesAffected := False;
          }

        finally
          R.CloseKey;
        end;
      end
      else
      begin
        // Failed to open registry key

      end;
    end
    else
    begin
      // Registry key does not exist

    end;
  finally
    R.Free;
  end;
end;

procedure TfrmMain.MasterSearch(sQuery: String);
begin

end;

procedure TfrmMain.WndMethod(var Msg: TMessage);
var
  X: Integer;
  C: TfrmContentBase;
begin
  for X := 0 to Tabs.Tabs.Count - 1 do
  begin
    C := TfrmContentBase(Tabs.Tabs[X].Data);
    C.WndMethod(Msg);
  end;

  {
    if Msg.Msg = MSG_CONNECTION_ADD then begin
    C:= TServerConnection(Msg.WParam);
    if Assigned(C) then begin

    end;
    end else
    if Msg.Msg = MSG_CONNECTION_DEL then begin

    end else begin
    Msg.Result := DefWindowProc(frmSqlExec2.Wnd, Msg.Msg, Msg.wParam, Msg.lParam);
    end;
  }
end;

procedure TfrmMain.WndProc(var Message: TMessage);
var
  s: PChar;
begin
  case Message.Msg of
    WM_REUSE_INSTANCE:
      begin
        s := PChar(Message.WParam);
        OpenFromCmd(s);
      end;
    WM_REFRESH_RECENTS:
      begin

      end;
  end;

  inherited;
end;

type
  TFNWndEnumProc = function(HWND: HWND; lParam: lParam): Bool; stdcall;

function EnumWindows(lpEnumFunc: TFNWndEnumProc; lParam: lParam): Bool; stdcall; external user32;

function GetWindows(Handle: HWND; Info: lParam): Bool; stdcall;
var
  L: TList;
begin
  Result := True;
  L := TList(Info);
  L.Add(Pointer(Handle));
end;

class procedure TfrmMain.CheckForInstance;
{$IFDEF USE_V3}
var
  L: TList;
  H: HWND;
  Dest: array [0 .. 80] of Char;
  i: Integer;
  s: String;
{$ENDIF}
begin

{$IFDEF USE_V3}
  if CreateMutex(nil, True, '2F23F63E-FADE-4F67-8C50-CF72354C17BB') = 0 then
    RaiseLastOSError;

  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    L := TList.Create;
    try
      EnumWindows(GetWindows, lParam(L));
      for i := 0 to L.Count - 1 do
      begin
        GetWindowText(HWND(L[i]), Dest, sizeof(Dest) - 1);
        s := Dest;
        if ContainsText(s, 'SQL Script Executer') then
        begin
          H := HWND(L[i]);
          if IsWindow(H) then
          begin
            SendMessage(H, WM_REUSE_INSTANCE, NativeUInt(@GetCommandLine), 0);
          end;
        end;
      end
    finally
      L.Free;
    end;
    Application.Terminate;
  end;
{$ENDIF}
end;

procedure TfrmMain.OpenFromCmd(ACmd: String);
begin
  //
end;

procedure TfrmMain.Terminate();
begin
  FreeAndNil(FHome);
  FreeAndNil(FSettings);

  SaveState;
  DeallocateHWnd(FMsgHwnd);
  // FConnections.Clear;
  // FConnections.Free;
  FMRU.Free;

end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  CallNewBrowser(OpenPopup);
end;

procedure TfrmMain.TreeView1Click(Sender: TObject);
var
  Node: TTreeNode;
begin
  if Assigned(TreeView1.Selected) then
  begin
    Node := TreeView1.Selected;
    if Node.Level = 1 then
    begin // The first Level is 0
      Memo1.Lines.Add(IntToStr(Node.AbsoluteIndex));
      case Node.AbsoluteIndex of
        1:
          Navegar('http://www.globo.com');
        2:
          Navegar('http://www.uol.com.br/');
        4:
          Navegar('https://mail.google.com/mail/u/0/?tab=wm#inbox');
        5:
          Navegar('https://www.google.com/');
        6:
          Navegar('http://www.youtube.com/');
        8:
          Navegar('http://shrek.voxbras.com.br/voxapps');
      end;
    end;
  end;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Terminate;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  R: TRect;
begin
  {
    if DwmCompositionEnabled then
    begin
    SetRectEmpty(R);
    AdjustWindowRectEx(R, GetWindowLong(Handle, GWL_STYLE), False, GetWindowLong(Handle, GWL_EXSTYLE));
    FWndFrameSize := R.Right;
    GlassFrame.Top := -R.Top;
    GlassFrame.Enabled := True;
    SetWindowPos(Handle, 0, Left, Top, Width, Height, SWP_FRAMECHANGED);
    DoubleBuffered := True;
    end;
  }
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := False; // True  ;
{$ENDIF}
  FMsgHwnd := AllocateHWnd(WndMethod);

  SHARED_DRIVE_DIR := 'D:\bkp\Arlon\OneDrive\soft\agcWork\';
  AddURL(SHARED_DRIVE_DIR + 'html\chart\index.html');
  AddURL('http://localhost:778/datasnap/rest/TSMContato/GetContatos/test');
  // tvDirectory.LoadFromFile(SHARED_DRIVE_DIR + 'data\struct.dat');

  actHome.Execute; // Show home content tab
  LoadState; // Window size / position, options, etc.
  TreeView1.FullExpand;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Terminate;
end;

procedure TfrmMain.BrowserCreatedMsg(var aMessage: TMessage);
begin
end;

procedure TfrmMain.btnADDClick(Sender: TObject);
begin
  // OnInputQuery_Close(['Item: ' + FormatDateTime('dd/MM/yy hh:mm', Now)]);
end;

procedure TfrmMain.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actHomeExecute(Sender: TObject);
begin
  CallContentHTML('HOME');
end;

procedure TfrmMain.CallContentHTML(sPage: String);
var
  T: TChromeTab;
  C: TfrmContentBase;
  D: Boolean;

  procedure doFind(Page: TfrmContentHTML);
  var
    X: Integer;
  begin
    for X := 0 to Tabs.Tabs.Count - 1 do
    begin
      T := Tabs.Tabs[X];
      C := TfrmContentBase(T.Data);
      if C = Page then
      begin
        Tabs.ActiveTabIndex := X;
        D := True;
        Break;
      end;
    end;
  end;

begin
  // Show Home Page
  D := False;

  if sPage = 'HOME' then
  begin
    if Assigned(FHome) then
    begin
      doFind(FHome);
    end
    else
    begin
      FHome := TfrmContentHTML.Create(nil);
      FHome.Homepage := SHARED_DRIVE_DIR + 'html\dashboard.html';
    end;

    if not D then
    begin
      T := Tabs.Tabs.Add;
      T.Data := FHome;
      ContentActive := FHome;
      T.caption := 'Home';
      T.ImageIndex := 43;
      T.Index := 0;
      T.Pinned := True;
      T.HideCloseButton := True;
    end;
    Self.DisplayContent(FHome);
  end
  else if sPage = 'SETTINGS' then
  begin
    if Assigned(FSettings) then
    begin
      doFind(FSettings);
    end
    else
    begin
      FSettings := TfrmContentHTML.Create(nil);
      FSettings.Homepage := 'miner://settings/';
      FSettings.FormType := FormBrowser;
    end;

    if not D then
    begin
      T := Tabs.Tabs.Add;
      T.Data := FSettings;
      ContentActive := FSettings;
      T.caption := 'Settings';
      T.ImageIndex := 17;
      // T.Index := 0;
      T.Pinned := False;
      T.HideCloseButton := False;
    end;

    // for I := 0 to 1000 do
    // Application.ProcessMessages;
    Self.DisplayContent(FSettings);

  end;


  // DisplayContent(FHome);

  {
    C := TfrmContentHTML.Create(nil);
    T := Tabs.Tabs.Add;
    T.Data := C;
    C.Tab := T;
    T.ImageIndex := 38;
    Self.DisplayContent(C);

    {
    PreferencesFrm.ProxyTypeCbx.ItemIndex := Chromium1.ProxyType;
    PreferencesFrm.ProxyServerEdt.Text := Chromium1.ProxyServer;
    PreferencesFrm.ProxyPortEdt.Text := inttostr(Chromium1.ProxyPort);
    PreferencesFrm.ProxyUsernameEdt.Text := Chromium1.ProxyUsername;
    PreferencesFrm.ProxyPasswordEdt.Text := Chromium1.ProxyPassword;
    PreferencesFrm.ProxyScriptURLEdt.Text := Chromium1.ProxyScriptURL;
    PreferencesFrm.ProxyByPassListEdt.Text := Chromium1.ProxyByPassList;
    PreferencesFrm.HeaderNameEdt.Text := Chromium1.CustomHeaderName;
    PreferencesFrm.HeaderValueEdt.Text := Chromium1.CustomHeaderValue;

    if (PreferencesFrm.ShowModal = mrOk) then
    begin
    Chromium1.ProxyType := PreferencesFrm.ProxyTypeCbx.ItemIndex;
    Chromium1.ProxyServer := PreferencesFrm.ProxyServerEdt.Text;
    Chromium1.ProxyPort := strtoint(PreferencesFrm.ProxyPortEdt.Text);
    Chromium1.ProxyUsername := PreferencesFrm.ProxyUsernameEdt.Text;
    Chromium1.ProxyPassword := PreferencesFrm.ProxyPasswordEdt.Text;
    Chromium1.ProxyScriptURL := PreferencesFrm.ProxyScriptURLEdt.Text;
    Chromium1.ProxyByPassList := PreferencesFrm.ProxyByPassListEdt.Text;
    Chromium1.CustomHeaderName := PreferencesFrm.HeaderNameEdt.Text;
    Chromium1.CustomHeaderValue := PreferencesFrm.HeaderValueEdt.Text;

    Chromium1.UpdatePreferences;
    end;
  }

end;

procedure TfrmMain.actNewBrowserExecute(Sender: TObject);
begin
  // CallNewBrowser('');
end;

procedure TfrmMain.Navegar(sPage: uString);
var
  C: TfrmContentBrowser; // TfrmBrowser;
  T: TChromeTab;
begin
  if (GetKeyState(VK_CONTROL) < 0) or (ContentActive.FormType <> FormBrowser) then
  begin
    CallNewBrowser(sPage);
  end
  else
  begin
    if (ContentActive.FormType = FormBrowser) then
    begin
      C := TfrmContentBrowser(ContentActive);
      C.Chromium1.LoadURL(sPage);
      // DisplayContent(C);
    end;
  end;
end;

procedure TfrmMain.CallNewBrowser(sPage: uString);
var
  C: TfrmContentBrowser; // TfrmBrowser;
  T: TChromeTab;
begin
  C := TfrmContentBrowser.Create(nil);
  ContentActive := C;
  T := Tabs.Tabs.Add;
  T.Data := C;
  C.Tab := T;
  C.FormType := FormBrowser;
  C.Homepage := sPage;
  T.ImageIndex := 38;
  MakeDelay(300);
  Self.DisplayContent(C);
end;

procedure TfrmMain.actNewEditorExecute(Sender: TObject);
var
  // C: TChildForm; // TfrmBrowser;
  C: TfrmNotepad; // TfrmBrowser;
  T: TChromeTab;
begin
  // New Script Window
  C := TfrmNotepad.Create(nil);
  T := Tabs.Tabs.Add;
  T.Data := C;
  C.Tab := T;
  C.FormType := FormEditor;
  // C.Homepage := 'www.uol.com.br'; // 'about:blank';
  T.ImageIndex := actNewEditor.ImageIndex;
  Self.DisplayContent(C);
end;

procedure TfrmMain.actShowLeftPainelExecute(Sender: TObject);
begin
  if actShowLeftPainel.Checked then
  begin
    PanelMainLeft.Visible := False;
    PanelMainLeft.Width := 200;
    actShowLeftPainel.Checked := False;
  end
  else
  begin
    PanelMainLeft.Visible := True;
    PanelMainLeft.Width := 200;
    actShowLeftPainel.Checked := True;
  end;

end;

procedure TfrmMain.AddURL(const aURL: string);
begin
end;

procedure TfrmMain.TabsActiveTabChanged(Sender: TObject; ATab: TChromeTab);
var
  C: TfrmContentBase;
begin
  // TODO: Display corresponding tab data
  C := TfrmContentBase(ATab.Data);
  if Assigned(C) then
  begin
    Self.DisplayContent(C);
    if C.FormType = FormBrowser then
    begin
      ContentActive := TfrmContentBrowser(ATab.Data);
    end;
    if C.FormType = FormHTML then
    begin
      ContentActive := TfrmContentHTML(ATab.Data);
    end;
  end;
  RefreshActions;
end;

procedure TfrmMain.TabsActiveTabChanging(Sender: TObject; AOldTab, ANewTab: TChromeTab; var Allow: Boolean);
begin
  {
    Memo1.Lines.Add('Tab Changing: ');
    if cbAllow.Checked then
    begin
    Memo1.Lines.Add('Tab Changing: ' + AOldTab.caption + ' To > ' + ANewTab.caption);
    end;
  }
end;

procedure TfrmMain.TabsButtonAddClick(Sender: TObject; var Handled: Boolean);
begin
  Handled := True;
  CallNewBrowser(''); // CallNewBrowser('http://www.google.com/'); // //Self.actNewBrowser.Execute;
end;

procedure TfrmMain.TabsButtonCloseTabClick(Sender: TObject; ATab: TChromeTab; var Close: Boolean);
var
  C: TfrmContentBase;
  B: TfrmContentBrowser;
begin
  C := TfrmContentBase(ATab.Data);
  if Assigned(C) then
  begin
    Self.Memo1.Lines.Add(C.caption);
    if C.FormType = FormBrowser then
    begin
      B := TfrmContentBrowser(ATab.Data);
      B.Close;
    end;
  end;
end;

procedure TfrmMain.ShowDevToolsMsg(var aMessage: TMessage);
var
  TempPoint: TPoint;
begin
  TempPoint.X := (aMessage.WParam shr 16) and $FFFF;
  TempPoint.Y := aMessage.WParam and $FFFF;
  // ShowDevTools(TempPoint);
end;

procedure TfrmMain.Splitter1Moved(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := Splitter1.Left.ToString()
end;

procedure TfrmMain.HideDevToolsMsg(var aMessage: TMessage);
begin
  // HideDevTools;
end;

procedure TfrmMain.PopupMenu1Popup(Sender: TObject);
begin
  {
    if DevTools.Visible then
    DevTools1.caption := 'Hide DevTools'
    else
    DevTools1.caption := 'Show DevTools';
  }
end;

procedure TfrmMain.Preferences1Click(Sender: TObject);
begin
  CallContentHTML('SETTINGS');
end;

procedure TfrmMain.Print1Click(Sender: TObject);
begin
  // Chromium1.Print;
end;

procedure TfrmMain.PrintinPDF1Click(Sender: TObject);
begin
  {
    SaveDialog1.DefaultExt := 'pdf';
    SaveDialog1.Filter := 'PDF files (*.pdf)|*.PDF';

    if SaveDialog1.Execute and (Length(SaveDialog1.FileName) > 0) then
    Chromium1.PrintToPDF(SaveDialog1.FileName, Chromium1.DocumentURL, Chromium1.DocumentURL);
  }
end;

procedure TfrmMain.ConfigBtnClick(Sender: TObject);
var
  TempPoint: TPoint;
  pnt: TPoint;
begin
  if GetCursorPos(pnt) then
    PopupMenu1.Popup(pnt.X, pnt.Y);

  // TempPoint.X := ConfigBtn.Left;
  // TempPoint.y := ConfigBtn.Top + ConfigBtn.Height;
  // TempPoint := ConfigPnl.ClientToScreen(TempPoint);
  //
  // PopupMenu1.Popup(TempPoint.X, TempPoint.y);
end;

procedure TfrmMain.CopyHTMLMsg(var aMessage: TMessage);
begin
  // Chromium1.RetrieveHTML;
end;

procedure TfrmMain.VisitDOMMsg(var aMessage: TMessage);
var
  TempMsg: ICefProcessMessage;
begin
  // Only works using a TCefCustomRenderProcessHandler. See MiniBrowser demo.
  // Use the ArgumentList property if you need to pass some parameters.
  TempMsg := TCefProcessMessageRef.New('retrievedom');
  // Same name than TCefCustomRenderProcessHandler.MessageName
  // SystemBrowser.SendProcessMessage(PID_RENDERER, TempMsg);
end;

{
  procedure TfrmMain.CreateParams(var Params: TCreateParams);
  begin
  BorderStyle := bsNone;
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_STATICEDGE;
  Params.Style := Params.Style or WS_SIZEBOX;
  end;
}

procedure TfrmMain.WMMove(var aMessage: TWMMove);
var
  C: TfrmContentBase;
  B: TfrmContentBrowser;
begin
  inherited;
  {
    if Assigned(Tabs.ActiveTab) then
    begin
    if Assigned(Tabs.ActiveTab.Data) then
    begin
    C := TfrmContentBase(Tabs.ActiveTab.Data);
    if Assigned(C) then
    begin
    //Self.Memo1.Lines.Add(C.caption);
    if C.FormType = FormBrowser then
    begin
    B := TfrmContentBrowser(Tabs.ActiveTab.Data);
    if (B.Chromium1 <> nil) then
    B.Chromium1.NotifyMoveOrResizeStarted;
    end;
    end;
    end;
    end;
    Caption := 'Move ' + IntToStr(Left);
  }
end;

procedure TfrmMain.WMMoving(var aMessage: TMessage);
var
  C: TfrmContentBase;
  B: TfrmContentBrowser;
begin
  inherited;
  {
    if Assigned(Tabs.ActiveTab) or Assigned(Tabs.ActiveTab.Data) then
    begin
    C := TfrmContentBase(Tabs.ActiveTab.Data);
    if Assigned(C) then
    begin
    //Self.Memo1.Lines.Add(C.caption);
    if C.FormType = FormBrowser then
    begin
    B := TfrmContentBrowser(Tabs.ActiveTab.Data);

    if (B.Chromium1 <> nil) then
    B.Chromium1.NotifyMoveOrResizeStarted;
    end;
    end;
    end;
    Caption := 'Moving ' + IntToStr(Left);
  }
end;

procedure TfrmMain.WMResize(var aMessage: TWMSIZE);
var
  C: TfrmContentBase;
  B: TfrmContentBrowser;
begin
  inherited;
  {
    if Assigned(Tabs.ActiveTab) or Assigned(Tabs.ActiveTab.Data) then
    begin
    C := TfrmContentBase(Tabs.ActiveTab.Data);
    if Assigned(C) then
    begin
    //Self.Memo1.Lines.Add(C.caption);
    if C.FormType = FormBrowser then
    begin
    B := TfrmContentBrowser(Tabs.ActiveTab.Data);

    if (B.Chromium1 <> nil) then
    B.Chromium1.NotifyMoveOrResizeStarted;
    end;
    end;
    end;
  }
end;

end.
