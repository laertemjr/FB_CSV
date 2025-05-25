unit uFB_CSV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, StrUtils,
  Vcl.ComCtrls, ShellAPI, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.IniFiles,
  FireDAC.Phys.IBBase, FireDAC.Comp.UI, System.ImageList, Vcl.ImgList,
  Vcl.Buttons;

type
  TfrmFB_CSV = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    OpenDialog1: TOpenDialog;
    btnBrowse: TButton;
    edtBD: TEdit;
    cbbTable: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnExport: TButton;
    Label5: TLabel;
    btnSelectCSV: TButton;
    edtCSV: TEdit;
    Label6: TLabel;
    ProgressBar1: TProgressBar;
    btnImport: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    edtPort: TEdit;
    StatusBar1: TStatusBar;
    Label7: TLabel;
    Label8: TLabel;
    btnEdit: TButton;
    btnCancel: TButton;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    btn_ptBR: TSpeedButton;
    btn_en: TSpeedButton;
    ImageList1: TImageList;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    OpenDialog2: TOpenDialog;
    procedure btnBrowseClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnSelectCSVClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure cbbTableExit(Sender: TObject);
    procedure conectParams();
    procedure FormActivate(Sender: TObject);
    procedure clean();
    function FileIsEmpty(const FileName: String): Boolean;
    procedure SetIniValue(pLocal, pSession, pSubSession, pValue:string);
    function GetIniValue(pLocal, PSession, pSubSession:string):string;
    procedure loadConfigINI();
    procedure btnEditClick(Sender: TObject);
    procedure btn_ptBRClick(Sender: TObject);
    procedure btn_enClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmFB_CSV : TfrmFB_CSV;
  path, path2 : string;
  iniconf : TIniFile;
  strngs : array[0..11] of string = ('','','','','','','','','','','','');
  sVerInfo : string;

implementation

uses
   uMultiLanguage, uGlobal;

{$R *.dfm}

procedure TfrmFB_CSV.FormActivate(Sender: TObject);
begin
   btnExport.Enabled    := False;
   btnImport.Enabled    := False;
   btnSelectCSV.Enabled := False;
   cbbTable.Enabled     := False;
   btnCancel.Enabled    := False;
   path  := EmptyStr;
   path2 := EmptyStr;

   clean;
   iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
   loadConfigINI;
   edtPort.Enabled := False;
   sVerInfo := GetVersionInfo(Application.ExeName);
   ptBR;
end;

procedure TfrmFB_CSV.btnBrowseClick(Sender: TObject);
var s:string;
begin
   clean;
   if path <> EmptyStr then
      OpenDialog1.InitialDir := path;

   if OpenDialog1.Execute then
   begin
      edtBD.Text := OpenDialog1.FileName;
      s := UpperCase(RightStr(edtBD.Text,3));
      if (s <> 'GDB') and (s <> 'FDB')then
      begin
        ShowMessage(strngs[0]); // 'It is not a Firebird database.'
        clean;
        Exit;
      end;

      path :=   ExtractFilePath(OpenDialog1.FileName);

      try
         FDConnection1.Connected := False;
         conectParams;
         FDConnection1.Params.Add('Database=' + edtBD.Text);
         FDConnection1.Params.Add('Port=' + edtPort.Text);
         FDConnection1.Connected := True;
         ShowMessage(strngs[11]);
         FDConnection1.GetTableNames('', '', '', cbbTable.Items);
         cbbTable.ItemIndex := 0;
         cbbTable.Enabled := True;
         if cbbTable.Text = EmptyStr then
         begin
            ShowMessage(strngs[1]); // There are no tables to export/import
            clean;
         end
         else
            begin
               FDTable1.TableName := cbbTable.Text;
               btnExport.Enabled    := True;
               btnSelectCSV.Enabled := True;
            end;
      except
         ShowMessage(strngs[2]); // Unable to connect to database
         clean;
      end;
   end
end;

procedure TfrmFB_CSV.btnExportClick(Sender: TObject);
var
   arqTXT:TextFile;
   i,c:Integer;
begin
   try
      FDTable1.Open;
      FDTable1.Last;
      FDTable1.First;
      if FDTable1.RecordCount = 0 then
      begin
         ShowMessage(strngs[5]);  // There is no data to export: the table is empty.
         FDTable1.Close;
         Exit;
      end;
   except
      ShowMessage(strngs[6]); // Table has field type(s) incompatible with the FireDAC standard.
      FDTable1.Close;
      Exit;
   end;

   AssignFile(arqTXT, ExtractFilePath(Application.ExeName)+Trim(cbbTable.Text)+'.txt');
   Rewrite(arqTXT);
   FDTable1.Last;
   FDTable1.First;
   ProgressBar1.Min := 0;
   ProgressBar1.Max := FDTable1.RecordCount -1;
   c := 0;

   while not FDTable1.EOF do
   begin
      for i:=0 to FDTable1.Fields.Count -1 do
         Write(arqTXT, FDTable1.Fields[i].AsString + ';');

      Writeln(arqTXT, '|'); { '|' : end of record (could be another character as long as it is of the "visible" type)
                              and different from the field delimiter ';'}
      ProgressBar1.Position := c;
      FDTable1.Next;
      Inc(c);
   end;

   CloseFile(arqTXT);
   ShowMessage(cbbTable.Text+'.txt'+strngs[7]+ExtractFilePath(Application.ExeName));  // 'successfully written to'
   // Open File Explorer in the folder where the .TXT file was saved
   ShellExecute(Application.Handle, 'open', PChar(ExtractFilePath(Application.ExeName)),nil, nil, SW_SHOWDEFAULT);
   FDTable1.Close;
   ProgressBar1.Position := 0;
end;

procedure TfrmFB_CSV.btnSelectCSVClick(Sender: TObject);
var s:string;
begin

   if path2 <> EmptyStr then
      OpenDialog2.InitialDir := path;

   OpenDialog2.FileName := EmptyStr;

   if OpenDialog2.Execute Then
   begin
      edtCSV.Text := OpenDialog2.FileName;
      s := UpperCase(RightStr(edtCSV.Text,3));

      if (s <> 'TXT') or FileIsEmpty(edtCSV.Text) then
      begin
         ShowMessage(strngs[8]);  // It is not a valid text file.
         edtCSV.Clear;
         btnImport.Enabled := False;
         Exit;
      end;
      btnImport.Enabled := True;
   end;
end;

procedure TfrmFB_CSV.btnImportClick(Sender: TObject);
var
   saveit, readit :TStrings;
   i,c:Integer;
   erro:Boolean;
begin
   saveit := TStringList.Create;
   readit    := TStringList.Create;
   erro   := False;

   try
      try
         readit.LoadFromFile(edtCSV.Text);
         saveit.Delimiter := ';';
         saveit.StrictDelimiter := True;
         ProgressBar1.Min := 0;
         ProgressBar1.Max := readit.count-1;
         FDTable1.Open;

         for i := 0 to Pred(readit.count) do
         begin
            saveit.DelimitedText := readit.Strings[i];

            with FDTable1 do
            begin
               Append;

               for c := 0 to FDTable1.Fields.Count-1 do
                  Fields[c].AsString := saveit.Strings[c];

               ProgressBar1.Position := i;
               Post;
            end;
         end;

         FDTable1.Refresh;
         except
            erro := True;
      end;
   finally
      if erro then
        ShowMessage(strngs[9]) // Unable to import data
      else
        ShowMessage(strngs[10]); // Import successful

      ProgressBar1.Position := 0;
      FDTable1.Close;
      saveit.Free;
      readit.Free;
  end;
end;

procedure TfrmFB_CSV.conectParams;
begin
   FDConnection1.Params.Clear;
   // DriverName
   FDConnection1.DriverName := 'FB';
   // DriverID
   FDConnection1.Params.Add('DriverID=FB');
   // Usuário
   FDConnection1.Params.Add('User_Name=SYSDBA');
   // PassWord
   FDConnection1.Params.Add('Password=masterkey');
   // Protocolo
   FDConnection1.Params.Add('Protocol=TCPIP');
   // Servidor
   FDConnection1.Params.Add('Server=127.0.0.1');
   // CharacterSet
   //FDConnection1.Params.Add('CharacterSet=WIN1252');
   // Login Prompt
   FDConnection1.LoginPrompt := False;
   // SQL Dialect
   //FDConnection1.Params.Add('SQLDialect=3');
end;

  procedure TfrmFB_CSV.cbbTableExit(Sender: TObject);
begin
  FDTable1.TableName := cbbTable.Text;
end;

procedure TfrmFB_CSV.clean;
begin
   edtBD.Text := EmptyStr;
   cbbTable.Clear;
   cbbTable.Enabled      := False;
   btnExport.Enabled     := False;
   btnSelectCSV.Enabled  := False;
   edtCSV.Clear;
   btnImport.Enabled     := False;
   ProgressBar1.Position := 0;
   OpenDialog1.FileName  := EmptyStr;
   OpenDialog2.FileName  := EmptyStr;
end;

function TfrmFB_CSV.FileIsEmpty(const FileName: String): Boolean;
var
   fad: TWin32FileAttributeData;
begin
   Result := GetFileAttributesEx(PChar(FileName), GetFileExInfoStandard, @fad) and
             (fad.nFileSizeLow = 0) and (fad.nFileSizeHigh = 0);
end;

procedure TfrmFB_CSV.SetIniValue(pLocal, pSession, pSubSession, pValue:string);
var vArquivo:TIniFile;
begin
   vArquivo:=TIniFile.Create(pLocal);
   vArquivo.WriteString(pSession, pSubSession, pValue);
   vArquivo.Free;
end;

function TfrmFB_CSV.GetIniValue(pLocal, PSession, pSubSession:string):string;
var vArquivo:TIniFile;
begin
   vArquivo:=TIniFile.Create(plocal);
   Result:=vArquivo.ReadString(pSession, pSubSession, '');
   vArquivo.Free;
end;

procedure TfrmFB_CSV.loadConfigINI;
begin
   edtPort.Text := iniconf.ReadString('FB', 'Port', '');
end;

procedure TfrmFB_CSV.btnCancelClick(Sender: TObject);
begin
   loadConfigINI;
   btnCancel.Enabled := False;
   btnEdit.Caption := strngs[4]; // Edit
   edtPort.Enabled := False;
end;

procedure TfrmFB_CSV.btnEditClick(Sender: TObject);
begin
   if btnEdit.Caption = strngs[3] then // &Save
   begin
      iniconf.WriteString('FB','Port',edtPort.Text);
      btnCancel.Enabled := False;
      btnEdit.Caption := strngs[4]; // Edit
      edtPort.Enabled       := False;
      loadConfigINI;
      Exit;
   end;

   btnEdit.Caption   := strngs[3]; // &Save
   btnCancel.Enabled := True;
   edtPort.Enabled   := True;
   edtPort.SetFocus;
   edtPort.SelStart  := Length(edtPort.Text);
end;

procedure TfrmFB_CSV.btn_ptBRClick(Sender: TObject);
begin
   ptBR;
end;

procedure TfrmFB_CSV.btn_enClick(Sender: TObject);
begin
   en;
end;
procedure TfrmFB_CSV.FormDestroy(Sender: TObject);
begin
   iniconf.Free;
end;

end.
