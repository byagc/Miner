inherited frmContentHTML: TfrmContentHTML
  Caption = 'Navegar'
  ClientHeight = 318
  ClientWidth = 474
  Font.Height = -19
  Font.Name = 'Consolas'
  OnShow = FormShow
  ExplicitWidth = 474
  ExplicitHeight = 318
  PixelsPerInch = 96
  TextHeight = 22
  object CEFWindowParent1: TCEFWindowParent
    Left = 0
    Top = 0
    Width = 474
    Height = 318
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 299
  end
  object Chromium1: TChromium
    OnTextResultAvailable = Chromium1TextResultAvailable
    OnBeforeContextMenu = Chromium1BeforeContextMenu
    OnContextMenuCommand = Chromium1ContextMenuCommand
    OnPreKeyEvent = Chromium1PreKeyEvent
    OnKeyEvent = Chromium1KeyEvent
    OnAddressChange = Chromium1AddressChange
    OnTitleChange = Chromium1TitleChange
    OnFullScreenModeChange = Chromium1FullScreenModeChange
    OnBeforePopup = Chromium1BeforePopup
    OnAfterCreated = Chromium1AfterCreated
    Left = 72
    Top = 64
  end
end
