inherited frmNotepad: TfrmNotepad
  Caption = 'NotepadBB'
  ClientHeight = 408
  ClientWidth = 659
  ExplicitWidth = 659
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 13
  object SynEdit1: TSynEdit [0]
    Left = 0
    Top = 41
    Width = 659
    Height = 367
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Consolas'
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ShowLineNumbers = True
    Gutter.Gradient = True
    Highlighter = SynPHPSyn1
    Lines.Strings = (
      '<?php'
      '/*'
      '     Codigo inicial baseado em um template'
      ''
      '*/'
      ''
      '    echo "teste";'
      '    if ($test == 1) {'
      '        echo "test '#233' igual '#224' 1";'
      '    }'
      ''
      '/*'
      ''
      ''
      '*/'
      ''
      '?>'
      '')
    RightEdge = 120
    FontSmoothing = fsmNone
    ExplicitTop = 47
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 659
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 152
    ExplicitTop = 144
    ExplicitWidth = 185
  end
  object SynPHPSyn1: TSynPHPSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = clGreen
    KeyAttri.Foreground = clBlue
    StringAttri.Foreground = clSilver
    SymbolAttri.Foreground = clRed
    VariableAttri.Foreground = clPurple
    Left = 288
    Top = 176
  end
  object SynJScriptSyn1: TSynJScriptSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 312
    Top = 256
  end
end
