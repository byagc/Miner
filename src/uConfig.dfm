inherited frmSettings: TfrmSettings
  Caption = 'frmSettings'
  ClientHeight = 526
  ClientWidth = 918
  ExplicitWidth = 918
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 918
    Height = 526
    ActivePage = tsBrowser
    Align = alClient
    DoubleBuffered = True
    MultiLine = True
    ParentDoubleBuffered = False
    TabOrder = 0
    TabPosition = tpBottom
    object tsBrowser: TTabSheet
      Caption = 'Sistema'
      DoubleBuffered = False
      ParentDoubleBuffered = False
      object Splitter5: TSplitter
        Left = 241
        Top = 41
        Width = 4
        Height = 459
        AutoSnap = False
        Color = clSkyBlue
        ParentColor = False
        ResizeStyle = rsUpdate
        ExplicitLeft = 209
        ExplicitHeight = 511
      end
      object NavControlPnl: TPanel
        Left = 0
        Top = 0
        Width = 910
        Height = 41
        Align = alTop
        Enabled = False
        ShowCaption = False
        TabOrder = 0
      end
      object PanelMainLeft: TPanel
        Left = 0
        Top = 41
        Width = 241
        Height = 459
        Align = alLeft
        Caption = 'PanelMainLeft'
        ShowCaption = False
        TabOrder = 1
        object PanelLeftTop: TPanel
          Left = 1
          Top = 1
          Width = 239
          Height = 88
          Align = alTop
          ShowCaption = False
          TabOrder = 0
          object SpeedButton2: TSpeedButton
            Left = 7
            Top = 5
            Width = 146
            Height = 30
            Caption = 'Painel de Cont'
            Flat = True
            OnClick = SpeedButton2Click
          end
          object Button2: TButton
            Left = 160
            Top = 8
            Width = 42
            Height = 25
            TabOrder = 0
          end
          object Button1: TButton
            Left = 44
            Top = 41
            Width = 75
            Height = 25
            Caption = 'Button1'
            TabOrder = 1
            OnClick = Button1Click
          end
        end
      end
      object PanelContainer: TPanel
        Left = 245
        Top = 41
        Width = 665
        Height = 459
        Align = alClient
        ShowCaption = False
        TabOrder = 2
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 663
          Height = 37
          Align = alTop
          Caption = 'Panel7'
          Padding.Left = 8
          Padding.Top = 2
          Padding.Bottom = 2
          ShowCaption = False
          TabOrder = 0
        end
      end
    end
    object tsMyStuff: TTabSheet
      Caption = 'Minhas Coisas'
      ImageIndex = 1
      object Splitter2: TSplitter
        Left = 441
        Top = 27
        Width = 4
        Height = 473
        Color = clSkyBlue
        ParentColor = False
        ResizeStyle = rsUpdate
        ExplicitLeft = 185
        ExplicitHeight = 590
      end
      object ListView1: TListView
        Left = 445
        Top = 27
        Width = 465
        Height = 473
        Align = alClient
        Columns = <
          item
            Caption = 'Item'
            Width = 300
          end
          item
            Alignment = taCenter
            Caption = 'Data'
          end
          item
            Alignment = taCenter
            Caption = 'Nota'
            Width = 200
          end>
        TabOrder = 0
        ViewStyle = vsReport
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 910
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
        object btnADD: TButton
          Left = 1
          Top = 0
          Width = 67
          Height = 25
          Caption = 'Novo Item'
          TabOrder = 0
        end
        object btnDelete: TButton
          Left = 69
          Top = 0
          Width = 86
          Height = 25
          Caption = 'TreeView2File'
          TabOrder = 1
          OnClick = btnDeleteClick
        end
        object Button3: TButton
          Left = 163
          Top = 0
          Width = 87
          Height = 23
          Caption = 'bd2Treeview'
          TabOrder = 2
          OnClick = Button1Click
        end
      end
      object Panel2: TPanel
        Left = 200
        Top = 27
        Width = 241
        Height = 473
        Align = alLeft
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 2
        object Splitter3: TSplitter
          Left = 1
          Top = 42
          Width = 239
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ResizeStyle = rsUpdate
          ExplicitTop = 285
          ExplicitWidth = 230
        end
        object tvDirectory: TTreeView
          Left = 1
          Top = 45
          Width = 239
          Height = 427
          Align = alClient
          Indent = 19
          TabOrder = 0
          OnChange = tvDirectoryChange
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 239
          Height = 41
          Align = alTop
          Caption = 'Panel3'
          ShowCaption = False
          TabOrder = 1
          object btnRefreshHardDrivers: TButton
            Left = 0
            Top = 5
            Width = 153
            Height = 25
            Caption = 'Escanear Pastas'
            TabOrder = 0
            OnClick = btnRefreshHardDriversClick
          end
        end
      end
      object CategoryPanelGroup1: TCategoryPanelGroup
        Left = 0
        Top = 27
        Height = 473
        VertScrollBar.Tracking = True
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        TabOrder = 3
        object CategoryPanel1: TCategoryPanel
          Top = 0
          Caption = 'CategoryPanel1'
          TabOrder = 0
        end
      end
    end
  end
end
