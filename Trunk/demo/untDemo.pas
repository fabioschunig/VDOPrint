unit untDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VDOPrinter, VDODmPrinter, ExtCtrls, VDOCaPrinter, Buttons
  {$IFNDEF VER120}
    {$IFNDEF VER130}
      {$IFNDEF VER140}
        , XPMan, VDOBasePrinter
      {$ENDIF}
    {$ENDIF}
  {$ENDIF};
  
type
  TfrmDemo = class(TForm)
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Bevel1: TBevel;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    Bevel3: TBevel;
    Button1: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    Label6: TLabel;
    VDOCaPrinter1: TVDOCaPrinter;
    VDODmPrinter1: TVDODmPrinter;
    VDOPrinter1: TVDOPrinter;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemo: TfrmDemo;

implementation

{$R *.DFM}

procedure TfrmDemo.SpeedButton1Click(Sender: TObject);
var
  I: Byte;
begin
  with VDOCaPrinter1 do
  begin
    { Inicia o Documento }
    BeginDoc;
    { Altera o fonte para escrita de um t�tulo }
    Font.Size := 14;
    { Imprime o t�tulo e avan�a para linha seguinte }
    Print(00,'T�tulo do Relat�rio', True);
    { Altero o fonte para o tamanho default }
    Font.Size := 8;
    { Imprime um tra�o e avan�a para linha seguinte }
    Replicate(00, 80);
    { Imprime um cabe�alho de detail e avan�a para
      para linha seguinte apenas quando imprimir a
      �ltima coluna }
    Print(00,'C�digo');
    Print(10,'Nome');
    Print(26,'E-mail');
    Print(54,'Linha', True);
    { Imprime um tra�o e avan�a para linha seguinte }
    Replicate(00, 80);
    { Imprime os detalhes... simulando um loop em um dataset}
    for I := 1 to 10 do
    begin
      Print(00, Format('%6.6d',[I]));
      Print(10, 'TVDOCaPrinter');
      Print(26, 'seuemail@seuservidor.com');
      Print(54, 'Esta � a linha numero: ' + Format('%3.3d', [CurrentLine]), True);
    end;
    { Avan�a + duas linhas e imprime o n�mero da p�gina }
    NewLine(2);
    Print(00,'P�gina ' + Format('%3.3d', [CurrentPage]), True);
    { Passa � pr�xima p�gina apenas para exemplificar }
    NewPage;
    { Inicio outra paginca para exemplificar o uso das fontes e alinhamento }
    Font.Size := 8;
    Font.Align := taLeftJustify;
    Print(00, 'Fonte padrao e alinhada � esquerda', True);
    Font.Align := taCenter;
    Print(00, 'Fonte padrao e alinhada ao centro', True);
    Font.Align := taRightJustify;
    Print(00, 'Fonte padrao e alinhada � direita', True);
    Font.Size := 14;
    Font.Align := taLeftJustify;
    Print(00, 'Fonte tamanho 14 e alinhada � esquerda', True);
    Font.Size := 8;
    Font.Align := taLeftJustify;
    Font.Style := [fsBold];
    Print(00, 'Fonte padrao em "negrito"', True);
    Font.Style := [fsStrikeOut];
    Print(00, 'Fonte padrao em "tachado"', True);
    Font.Style := [fsItalic];
    Print(00, 'Fonte padrao em "italico"', True);
    Font.Style := [fsUnderline];
    Print(00, 'Fonte padrao em "sublinhado"', True);
    Font.Style := [fsBold, fsItalic];
    Print(00, 'Fonte padrao em "negrito" E "italico"', True);
    Font.Style := [];
    Font.Name := 'Courier New';
    Print(00, 'Fonte "Courier New" em tamanho padrao', True);
    { Avan�a + duas linhas e imprime o n�mero da p�gina }
    NewLine(2);
    Print(00,'P�gina ' + Format('%3.3d', [CurrentPage]), True);
    { Finalizo o Documento, ejetando a p�gina }
    EndDoc;
  end;

end;

procedure TfrmDemo.SpeedButton2Click(Sender: TObject);
var
  I: Byte;
begin
  with VDODmPrinter1 do
  begin
    { Inicia o Documento }
    BeginDoc;
    { Altera o fonte para escrita de um t�tulo }
    Font.Size := fsLargeCondensed;
    { Imprime o t�tulo e avan�a para linha seguinte }
    Print(00,'T�tulo do Relat�rio', True);
    { Altero o fonte para o tamanho default }
    Font.Size := fsCondensed;
    { Imprime um tra�o e avan�a para linha seguinte }
    Replicate(00, 80);
    { Imprime um cabe�alho de detail e avan�a para
      para linha seguinte apenas quando imprimir a
      �ltima coluna }
    Print(00,'C�digo');
    Print(10,'Nome');
    Print(26,'E-mail');
    Print(54,'Linha', True);
    { Imprime um tra�o e avan�a para linha seguinte }
    Replicate(00, 80);
    { Imprime os detalhes... simulando um loop em um dataset}
    for I := 1 to 10 do
    begin
      Print(00, Format('%6.6d',[I]));
      Print(10, 'TVDODmPrinter');
      Print(26, 'seuemail@seuservidor.com');
      Print(54, 'Esta � a linha numero: ' + Format('%3.3d', [CurrentLine]), True);
    end;
    { Avan�a + duas linhas e imprime o n�mero da p�gina }
    NewLine(2);
    Print(00,'P�gina ' + Format('%3.3d', [CurrentPage]), True);
    { Passa � pr�xima p�gina apenas para exemplificar }
    NewPage;
    { Inicio outra paginca para exemplificar o uso das fontes e alinhamento }
    Font.Size := fsDefault;
    Font.Align := faLeft;
    Print(00, 'Fonte padrao, com 10cpp e alinhada a esquerda', True);
    Font.Size := fsCondensed;
    Font.Align := faCenter;
    Print(00, 'Fonte condensada, com 10cpp e alinhada ao centro', True);
    Font.Size := fsLargeCondensed;
    Font.Align := faRight;
    Print(00, 'Fonte condensada expandida, c/10cpp e alinhada a direita', True);
    Font.Size := fsLarge;
    Font.Align := faLeft;
    Print(00, 'Fonte expandida, c/10cpp e al. esquerda', True);
    Font.Size := fsDefault;
    Font.Align := faLeft;
    Font.Style := [fsDmBold];
    Print(00, 'Fonte padrao, com 10cpp em "negrito"', True);
    Font.Style := [fsDmDoubleStrike];
    Print(00, 'Fonte padrao, com 10cpp em "passada-dupla"', True);
    Font.Style := [fsDmItalic];
    Print(00, 'Fonte padrao, com 10cpp em "italico"', True);
    Font.Style := [fsDmSuperScript];
    Print(00, 'Fonte padrao, com 10cpp em "sobrescrito"', True);
    Font.Style := [fsDmSubScript];
    Print(00, 'Fonte padrao, com 10cpp em "subrescrito"', True);
    Font.Style := [fsDmUnderline];
    Print(00, 'Fonte padrao, com 10cpp em "sublinhado"', True);
    Font.Style := [fsDmBold, fsDmItalic];
    Print(00, 'Fonte padrao, com 10cpp em "negrito" E "italico"', True);
    Font.Style := [];
    Font.Pitch := fp12cpp;
    Print(00, 'Fonte padrao, com 12cpp', True);
    Font.Size := fsCondensed;
    Print(00, 'Fonte condensada, com 12cpp', True);
    Font.Pitch := fp10cpp;
    Font.Size := fsDefault;
    Font.FontType := ftNLQ;
    Font.NLQFont := ntSansSerif;
    Print(00, 'Fonte padrao, com 10cpp e utilizando o tipo NLQ "Sans-Serif"', True);
    Font.NLQFont := ntRoman;
    Print(00, 'Fonte padrao, com 10cpp e utilizando o tipo NLQ "Roman"', True);
    { Avan�a + duas linhas e imprime o n�mero da p�gina }
    NewLine(2);
    Print(00,'P�gina ' + Format('%3.3d', [CurrentPage]), True);
    { Finalizo o Documento, ejetando a p�gina }
    EndDoc;
  end;

end;

procedure TfrmDemo.SpeedButton3Click(Sender: TObject);
var
  I: Byte;
begin
  with VDOPrinter1 do
  begin
    { Inicia o Documento }
    BeginDoc;
    { Altera o fonte para escrita de um t�tulo.
      Note que ser� imposta uma condi��o de acordo
      com o tipo de impressora selecionada}
    if PrinterType = ptCanvas then CanvasSets.Font.Size := 14
      else DotMatrixSets.Font.Size:= fsLargeCondensed;
    { Imprime o t�tulo e avan�a para linha seguinte }
    Print(00,'T�tulo do Relat�rio', True);
    { Altero o fonte para o tamanho default }
    if PrinterType = ptCanvas then CanvasSets.Font.Size := 8
      else DotMatrixSets.Font.Size:= fsCondensed;
    { Imprime um tra�o e avan�a para linha seguinte }
    Replicate(00, 80);
    { Imprime um cabe�alho de detail e avan�a para
      para linha seguinte apenas quando imprimir a
      �ltima coluna }
    Print(00,'C�digo');
    Print(10,'Nome');
    Print(26,'E-mail');
    Print(54,'Linha', True);
    { Imprime um tra�o e avan�a para linha seguinte }
    Replicate(00, 80);
    { Imprime os detalhes... simulando um loop em um dataset}
    for I := 1 to 10 do
    begin
      Print(00, Format('%6.6d',[I]));
      Print(10, 'TVDOPrinter');
      Print(26, 'seuemail@seuservidor.com');
      Print(54, 'Esta � a linha numero: ' + Format('%3.3d', [CurrentLine]), True);
    end;
    { Avan�a + duas linhas e imprime o n�mero da p�gina }
    NewLine(2);
    Print(00,'P�gina ' + Format('%3.3d', [CurrentPage]), True);
    { Finalizo o Documento }
    EndDoc;
  end;
end;

procedure TfrmDemo.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
