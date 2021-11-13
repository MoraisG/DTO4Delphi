object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 429
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 193
    Height = 57
    Caption = 'Instanciar DTO'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 88
    Width = 193
    Height = 57
    Caption = 'DataSet to List'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 264
    Width = 385
    Height = 157
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object btDataSetToObj: TButton
    Left = 8
    Top = 160
    Width = 193
    Height = 57
    Caption = 'DataSet to Object'
    TabOrder = 3
    OnClick = btDataSetToObjClick
  end
  object Button3: TButton
    Left = 207
    Top = 8
    Width = 195
    Height = 57
    Caption = 'Heranca'
    TabOrder = 4
  end
  object cdsIndustrias: TClientDataSet
    PersistDataPacket.Data = {
      250100009619E0BD010000001800000003000700000003000000710008494E44
      5F434F4445020001001000000008494E445F4E414D4501004900100001000557
      49445448020002000500094C4F4E475F4E414D45010049001000010005574944
      54480200020014000100044C4349440200010009040000FB0D05536F66745711
      436F6D707574657220536F66747761726500007E0E044175746F0C4175746F20
      2620547275636B0000880E044165726F114165726F73706163652F446566656E
      73650000581B05486F74656C0C486F74656C2F47616D696E670000401F034D65
      64104D65646963616C2053657276696365730000F50D04436F6D7011436F6D70
      757465722048617264776172650000CA120454656C651254656C65636F6D6D75
      6E69636174696F6E73}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 184
    object cdsIndustriasIND_CODE: TSmallintField
      FieldName = 'IND_CODE'
    end
    object cdsIndustriasIND_NAME: TStringField
      FieldName = 'IND_NAME'
      Size = 5
    end
    object cdsIndustriasLONG_NAME: TStringField
      FieldName = 'LONG_NAME'
    end
  end
  object dsIndustrias: TDataSource
    DataSet = cdsIndustrias
    Left = 344
    Top = 184
  end
end
