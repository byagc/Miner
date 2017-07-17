object frmMain: TfrmMain
  Left = 271
  Top = 114
  Caption = 'frmMain'
  ClientHeight = 324
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 397
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 13
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object ButtonOpenBrowser: TButton
      Left = 216
      Top = 8
      Width = 107
      Height = 25
      Caption = 'Open Browser'
      TabOrder = 0
      OnClick = ButtonOpenBrowserClick
    end
    object ButtonStart: TButton
      Left = 105
      Top = 8
      Width = 51
      Height = 25
      Caption = 'Start'
      TabOrder = 1
      OnClick = ButtonStartClick
    end
    object ButtonStop: TButton
      Left = 159
      Top = 8
      Width = 51
      Height = 25
      Caption = 'Stop'
      TabOrder = 2
      OnClick = ButtonStopClick
    end
    object EditPort: TEdit
      Left = 47
      Top = 10
      Width = 56
      Height = 21
      Alignment = taCenter
      TabOrder = 3
      Text = '8082'
    end
    object CheckBox1: TCheckBox
      Left = 336
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Login'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 397
    Height = 283
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 375
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 176
    Top = 72
  end
end
