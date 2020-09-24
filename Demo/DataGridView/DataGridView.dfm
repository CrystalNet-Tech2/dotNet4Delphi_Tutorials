object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'DataGridView'
  ClientHeight = 409
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    550
    409)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 257
    Top = 383
    Width = 53
    Height = 13
    Caption = 'TableName'
  end
  object ClrContainer1: TClrContainer
    Left = 8
    Top = 8
    Width = 534
    Height = 345
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'ClrContainer1'
    TabOrder = 0
    ExplicitHeight = 313
  end
  object ButtonLoadData: TButton
    Left = 467
    Top = 377
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Load Data'
    TabOrder = 1
    OnClick = ButtonLoadDataClick
  end
  object cboTableName: TComboBox
    Left = 316
    Top = 379
    Width = 145
    Height = 21
    Style = csDropDownList
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
end
