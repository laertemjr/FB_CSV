unit uMultiLanguage;

interface

// uses

//type

   procedure ptBR();
   procedure en();
// private


// public
// end;

// var

implementation

uses
   uFB_CSV;

procedure ptBR();
begin
   with frmFB_CSV do
   begin
      Caption := 'FB_CSV - Exportação/Importação de arquivos CSV de/para o banco de dados Firebird';
      StatusBar1.Panels[0].Text := 'Desenvolvido em Delphi 12.1, componentes FireDAC, versão ' + sVerInfo + ' (2025)';
      btnBrowse.Caption := '&Procurar';
      btnExport.Caption := '&Exportar';
      btnImport.Caption := '&Importar';
      btnSelectCSV.Caption := '&Procurar';
      btnCancel.Caption := '&Cancelar';

      if btnEdit.Caption = '&Edit' then
         btnEdit.Caption := '&Alterar'
      else if btnEdit.Caption = '&Save' then
         btnEdit.Caption := '&Gravar';

      Label1.Caption := 'Selecionar Banco de Dados Firebird';
      Label2.Caption := 'Banco de dados selecionado :';
      Label3.Caption := 'Selecione a tabela :';
      Label4.Caption := 'Exportar tabela Firebird selecionada para arquivo CSV';
      Label5.Caption := 'Importar arquivo CSV para tabela Firebird selecionada';
      Label6.Caption := 'Arquivo CSV selecionado :';
      Label7.Caption := 'Configuração Firebird';
      Label8.Caption := 'Porta :';

      OpenDialog1.Filter := 'Bancos de dados Firebird|*.GDB;*.FDB;';
      OpenDialog2.Filter := 'Arquivos Texto (*.txt)|*.txt';
   end;

   strngs[0]  := 'Não é um banco de dados Firebird.';
   strngs[1]  := 'Não há tabelas para exportar/importar';
   strngs[2]  := 'Não foi possível a conexão com o banco de dados';
   strngs[3]  := '&Gravar';
   strngs[4]  := '&Alterar';
   strngs[5]  := 'Não há dados para exportar: a tabela está vazia.';
   strngs[6]  := 'Tabela possui tipo(s) de campo(s) incompatível(veis) com o padrão FireDAC.';
   strngs[7]  := ' gravado com sucesso em ';
   strngs[8]  := 'Não é um arquivo texto válido.';
   strngs[9]  := 'Não foi possível importar os dados.';
   strngs[10] := 'Importação bem-sucedida.';
   strngs[11] := 'Banco de dados conectado.';
end;

procedure en();
begin
   with frmFB_CSV do
   begin
      Caption := 'FB_CSV - Export/Import CSV files to/from Firebird database';
      StatusBar1.Panels[0].Text := 'Developed in Delphi 12.1, FireDAC components, version '+ sVerInfo + ' (2025)';
      btnBrowse.Caption := '&Browse';
      btnExport.Caption := '&Export';
      btnImport.Caption := '&Import';
      btnSelectCSV.Caption := '&Browse';
      btnCancel.Caption := '&Cancel';

      if btnEdit.Caption = '&Alterar' then
         btnEdit.Caption := '&Edit'
      else if btnEdit.Caption = '&Gravar' then
         btnEdit.Caption := '&Save';

      Label1.Caption := 'Select Firebird Database';
      Label2.Caption := 'Selected database :';
      Label3.Caption := 'Select table :';
      Label4.Caption := 'Export selected Firebird table to CSV file';
      Label5.Caption := 'Import CSV file into selected Firebird table';
      Label6.Caption := 'Selected CSV file: ';
      Label7.Caption := 'Firebird settings';
      Label8.Caption := 'Port :';

      OpenDialog1.Filter := 'Firebird databases|*.GDB;*.FDB;';
      OpenDialog2.Filter := 'Text files (*.txt)|*.txt';
   end;

   strngs[0] := 'It is not a Firebird database.';
   strngs[1] := 'There are no tables to export/import';
   strngs[2] := 'Unable to connect to database';
   strngs[3] := '&Save';
   strngs[4] := '&Edit';
   strngs[5] := 'There is no data to export: the table is empty.';
   strngs[6] := 'Table has field type(s) incompatible with the FireDAC standard.';
   strngs[7] := ' successfully written to ';
   strngs[8] := 'It is not a valid text file.';
   strngs[9] := 'Unable to import data.';
   strngs[10] := 'Import successful.';
   strngs[11] := 'Database connected.';
end;

end.
