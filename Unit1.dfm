object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 
    'FB_CSV - Exporta'#231#227'o/Importa'#231#227'o de arquivos CSV de/para o banco d' +
    'e dados Firebird'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 209
    Align = alTop
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 269
      Height = 21
      Caption = 'Selecionar Banco de Dados Firebird'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 109
      Width = 160
      Height = 15
      Caption = 'Banco de dados selecionado :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 159
      Width = 106
      Height = 15
      Caption = 'Selecione a tabela :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 43
      Width = 206
      Height = 15
      Caption = 'Informe a porta do servidor Firebird :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSelecBD: TButton
      Left = 8
      Top = 64
      Width = 145
      Height = 25
      Caption = 'Localizar banco de dados'
      TabOrder = 0
      OnClick = btnSelecBDClick
    end
    object edtBD: TEdit
      Left = 8
      Top = 130
      Width = 609
      Height = 23
      ReadOnly = True
      TabOrder = 1
    end
    object cbbTabela: TComboBox
      Left = 8
      Top = 180
      Width = 154
      Height = 23
      Style = csDropDownList
      TabOrder = 2
      OnExit = cbbTabelaExit
    end
    object edtPort: TEdit
      Left = 220
      Top = 35
      Width = 65
      Height = 23
      Alignment = taCenter
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 272
    Width = 624
    Height = 148
    Color = 10930928
    ParentBackground = False
    TabOrder = 1
    object Label5: TLabel
      Left = 8
      Top = 7
      Width = 412
      Height = 21
      Caption = 'Importar arquivo CSV para tabela Firebird selecionada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 75
      Width = 137
      Height = 15
      Caption = 'Arquivo CSV selecionado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSelectCSV: TButton
      Left = 8
      Top = 44
      Width = 137
      Height = 25
      Caption = 'Localizar arquivo CSV'
      TabOrder = 0
      OnClick = btnSelectCSVClick
    end
    object edtCSV: TEdit
      Left = 8
      Top = 96
      Width = 609
      Height = 23
      ReadOnly = True
      TabOrder = 1
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 125
      Width = 626
      Height = 28
      TabOrder = 2
    end
    object btnImport: TButton
      Left = 279
      Top = 44
      Width = 75
      Height = 25
      Caption = 'Importar'
      TabOrder = 3
      OnClick = btnImportClick
    end
  end
  object Panel3: TPanel
    Left = -4
    Top = 208
    Width = 628
    Height = 64
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 7
      Width = 410
      Height = 21
      Caption = 'Exportar tabela Firebird selecionada para arquivo CSV'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnExport: TButton
      Left = 276
      Top = 34
      Width = 75
      Height = 25
      Caption = 'Exportar'
      TabOrder = 0
      OnClick = btnExportClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 418
    Width = 624
    Height = 23
    Align = alBottom
    Caption = 
      'Desenvolvido em Delphi 12.1, componentes FireDAC, vers'#227'o  0.1 (2' +
      '025)'
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Left = 560
    Top = 288
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 560
    Top = 64
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 560
    Top = 136
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 560
    Top = 216
  end
end
