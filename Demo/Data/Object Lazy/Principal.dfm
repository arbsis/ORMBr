object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 242
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    527
    242)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 374
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Executar Teste Lazy<>'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 47
    Width = 527
    Height = 195
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Cria Tabelas'
    TabOrder = 2
    OnClick = Button2Click
  end
end
