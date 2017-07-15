unit uBase;

interface

uses
  Winapi.Windows, Vcl.Forms
  ,Winapi.Messages
  ,uCEFConstants
  //,System.SysUtils
  //,System.Variants
  //,System.Classes
  //,Vcl.Graphics
  //,System.UITypes

//  ,Vcl.Controls, Vcl.Dialogs, Vcl.StdCtrls
//  ,Vcl.ComCtrls, Vcl.Buttons, SynEdit, Vcl.ExtCtrls, Vcl.ClipBrd
//  ,SynEditHighlighter, SynHighlighterSQL, System.Actions
//  ,Vcl.ActnList
//  ,Vcl.ExtDlgs
//  ,ChromeTabs
//  ,ChromeTabsTypes
//  ,ChromeTabsUtils
//  ,ChromeTabsControls
//  ,ChromeTabsThreadTimer
//  ,ChromeTabsClasses, Vcl.OleCtrls, SHDocVw
//  ,uCEFChromiumWindow, uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFApplication, uCEFTypes
//  ,Vcl.Menus

  ;

const
  MINIBROWSER_CREATED = WM_APP + $100;
  MINIBROWSER_SHOWDEVTOOLS = WM_APP + $101;
  MINIBROWSER_HIDEDEVTOOLS = WM_APP + $102;
  MINIBROWSER_COPYHTML = WM_APP + $103;
  MINIBROWSER_VISITDOM = WM_APP + $104;
  MINIBROWSER_REFRESH = WM_APP + $105;

  MINIBROWSER_CONTEXTMENU_SHOWDEVTOOLS = MENU_ID_USER_FIRST + 1;
  MINIBROWSER_CONTEXTMENU_HIDEDEVTOOLS = MENU_ID_USER_FIRST + 2;
  MINIBROWSER_CONTEXTMENU_SHOWJSALERT = MENU_ID_USER_FIRST + 3;
  MINIBROWSER_CONTEXTMENU_SETJSEVENT = MENU_ID_USER_FIRST + 4;
  MINIBROWSER_CONTEXTMENU_COPYHTML = MENU_ID_USER_FIRST + 5;
  MINIBROWSER_CONTEXTMENU_VISITDOM = MENU_ID_USER_FIRST + 6;
  MINIBROWSER_CONTEXTMENU_JSWRITEDOC = MENU_ID_USER_FIRST + 7;
  MINIBROWSER_CONTEXTMENU_JSPRINTDOC = MENU_ID_USER_FIRST + 8;
  MINIBROWSER_CONTEXTMENU_REGSCHEME = MENU_ID_USER_FIRST + 9;
  MINIBROWSER_CONTEXTMENU_CLEARFACT = MENU_ID_USER_FIRST + 10;
  MINIBROWSER_CONTEXTMENU_REFRESH = MENU_ID_USER_FIRST + 11;

  //MINIBROWSER_HOMEPAGE = 'about:blank';

  REG_KEY = 'Software\ByAGC\agcMiner\';
  WM_REUSE_INSTANCE = WM_USER + 101;
  WM_REFRESH_RECENTS = WM_USER + 102;


type

  TFormType = (FormOnly, FormHTML, FormBrowser, FormEditor);

procedure MakeDelay(msecs: integer);

implementation

procedure MakeDelay(msecs: integer);
var
  FirstTickCount: longint;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((GetTickCount - FirstTickCount) >= longint(msecs));
  //  test git
end;

end.
