inherited frmContentBrowser: TfrmContentBrowser
  Caption = 'Nova Aba'
  ClientHeight = 318
  ClientWidth = 534
  Font.Height = -19
  Font.Name = 'Consolas'
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 534
  ExplicitHeight = 318
  PixelsPerInch = 96
  TextHeight = 22
  object Splitter1: TSplitter
    Left = 0
    Top = 263
    Width = 534
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Visible = False
    ExplicitLeft = 529
    ExplicitTop = 28
    ExplicitWidth = 290
  end
  object CEFWindowParent1: TCEFWindowParent
    Left = 0
    Top = 28
    Width = 534
    Height = 235
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 529
    ExplicitHeight = 271
  end
  object NavControlPnl: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ShowCaption = False
    TabOrder = 1
    object NavButtonPnl: TPanel
      Left = 0
      Top = 0
      Width = 102
      Height = 28
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object BackBtn: TButton
        Left = 0
        Top = 0
        Width = 25
        Height = 28
        Align = alLeft
        Caption = '3'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = BackBtnClick
      end
      object ForwardBtn: TButton
        Left = 25
        Top = 0
        Width = 25
        Height = 28
        Align = alLeft
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = ForwardBtnClick
      end
      object ReloadBtn: TButton
        Left = 50
        Top = 0
        Width = 25
        Height = 28
        Align = alLeft
        Caption = 'q'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ReloadBtnClick
      end
      object StopBtn: TButton
        Left = 75
        Top = 0
        Width = 25
        Height = 28
        Align = alLeft
        Caption = '='
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = StopBtnClick
      end
    end
    object URLEditPnl: TPanel
      Left = 102
      Top = 0
      Width = 386
      Height = 28
      Align = alClient
      BevelKind = bkSoft
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 30
      Padding.Top = 1
      Padding.Right = 5
      Padding.Bottom = 1
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      ExplicitWidth = 366
      object editUrlAddress: TEdit
        Left = 30
        Top = 1
        Width = 347
        Height = 22
        Align = alClient
        AutoSize = False
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'www.google.com.br'
        OnKeyPress = editUrlAddressKeyPress
        ExplicitWidth = 327
      end
    end
    object ConfigPnl: TPanel
      Left = 488
      Top = 0
      Width = 46
      Height = 28
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object btnWebGo: TSpeedButton
        Left = 12
        Top = 0
        Width = 34
        Height = 28
        Align = alRight
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00B9B9B900A6A6A600C9C9C900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00B9B9B900608B7D0030886A00C0C7C500FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B9B9
          B900608B7D0026856500C0C7C500FF00FF00FF00FF00A2A2A200999999009999
          9900999999009999990099999900999999009999990099999900C9C9C900638B
          7D00006F4A00A6BCB400FF00FF00FF00FF00FF00FF00227D5F00008158000088
          5F00008D63000092680000986C00009C7100009F720000795000A6ADAB000A79
          540040967A00FF00FF00FF00FF00FF00FF00FF00FF00AAAFAD001A83650000D0
          A00000E3BC0000EBC50000F3CD0000FCD60000FFD90000734C0046877100008C
          5D0060988600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0091979400008E
          660000D9A60000E4B10000EFBC0000FBC80000FFD90000734C000A7852000099
          66003A806900B2B2B200C9C9C900FF00FF00C6C6C600A9A9A9003A8A70000086
          610000E5C20000E4B10000EFBC0000FBC80000FFD90000734C0000774F00009C
          690000A275004D81700090979500999999008695900030846800007D590000DD
          C20000E0B60000E4B10000EFBC0000FBC80000FFD90000734C0000774F000099
          660000C39000008D650000654300006A4600006C4800008B660000D7BD0000D8
          B00000D9A60000E4B10000EFBC0000FBC80000FFCC0000734C000D7B56000096
          6400009C690000BC890000C7940000C89B0000D1AF0000D5B80000CB9F0000CD
          9A0000D9A60000E4B10000DEAB00008E670000F5C30000734C004D967E000087
          5A0000996600009966000099660000A06D0000AB780000B7840000C28F0000CD
          9A0000D9A60000CE9C000D9C6E0091B3A8001E846500006D4800B3C1BC000077
          4F0000926100009966000099660000A06D0000AB780000B7840000C28F0000CD
          9A0000B281000D936600A6C1B800FF00FF00B7BDBB002F755D00FF00FF0080AC
          9D0000774F00008B5D000097640000A06D0000AB780000B3810000AB7A000090
          62004DA48700C0C8C600FF00FF00FF00FF00FF00FF00C4C4C400FF00FF00FF00
          FF00A6BCB4004090760000754E00007C5300007F55000D855D004D9F8400B3C3
          BE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = actWebGoExecute
        ExplicitLeft = 6
        ExplicitTop = 1
        ExplicitHeight = 27
      end
    end
  end
  object DevTools: TCEFWindowParent
    Left = 0
    Top = 268
    Width = 534
    Height = 50
    Align = alBottom
    TabOrder = 2
    Visible = False
    ExplicitTop = 318
  end
  object Chromium1: TChromium
    OnTextResultAvailable = Chromium1TextResultAvailable
    OnProcessMessageReceived = Chromium1ProcessMessageReceived
    OnLoadingStateChange = Chromium1LoadingStateChange
    OnBeforeContextMenu = Chromium1BeforeContextMenu
    OnContextMenuCommand = Chromium1ContextMenuCommand
    OnPreKeyEvent = Chromium1PreKeyEvent
    OnKeyEvent = Chromium1KeyEvent
    OnAddressChange = Chromium1AddressChange
    OnTitleChange = Chromium1TitleChange
    OnFullScreenModeChange = Chromium1FullScreenModeChange
    OnStatusMessage = Chromium1StatusMessage
    OnBeforePopup = Chromium1BeforePopup
    OnAfterCreated = Chromium1AfterCreated
    Left = 72
    Top = 64
  end
end
