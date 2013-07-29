{ *********************************************************************** }
{                                                                         }
{                          VDO Print Components                           }
{                             VDOPrintConsts                              }
{              Copyright (C) 2003-2006 Vinicius de Oliveira               }
{                                                                         }
{                       Version 3.1.0 - 07/06/2006                        }
{                                                                         }
{ *********************************************************************** }

{ *********************************************************************** }
{  License Agreement:                                                     }
{                                                                         }
{  The contents of this file are subject to the Mozilla Public License    }
{  Version 1.1 (the "License"); you may not use this file except in       }
{  compliance with the License. You may obtain a copy of the License at   }
{  http://www.mozilla.org/MPL/                                            }
{                                                                         }
{  Software distributed under the License is distributed on an "AS IS"    }
{  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See    }
{  the License for the specific language governing rights and limitations }
{  under the License.                                                     }
{                                                                         }
{  The Original Code is VDOPrintConsts.pas                                }
{                                                                         }
{  The Initial Developer of the Original Code is Vinicius de Oliveira.    }
{  All Rights Reserved.                                                   }
{                                                                         }
{  Contact :                                                              }
{     vncsoliveira@yahoo.com.br                                           }
{     http://vdo.sourceforge.net                                          }
{ *********************************************************************** }

{$D-}

unit VDOPrintConsts;

interface

resourcestring
  SVDOPrintVersion    = '3.1.0';

{ Defini��o de idioma. Alterne entre EN_US e PT_BR. }
{$DEFINE PT_BR}

{$IFDEF EN_US}
  SConfirm            = 'Confirm';
  SWarning            = 'Warning';
  SError              = 'Error';
  { **** }
  SInvalidPrinter     = 'Printer selected ( %s ) is not valid';
  SNoInstalledPrinter = 'There is no installed printer';
  SNoDefaultPrinter   = 'There is no default printer currently selected';
  SNotPrinting        = 'The printer %s is not currently printing';
  SPrinting           = 'Printing in progress in the printer %s';
  SOpenPrinterError   = 'Unable to open printer %s';
  SClosePrinterError  = 'Unable to close printer %s';
  SAbortPrinterError  = 'Unable to abort the job in the printer %s';
  SStartDocError      = 'Unable to start the document %s in the printer %s';
  SEndDocError        = 'Unable to end the document %s in the printer %s';
  SStartPageError     = 'Unable to start the page in the printer %s';
  SEndPageError       = 'Unable to end the page in the printer %s';
  SWriteError         = 'Unable to send data to printer %s';
  { **** }
  SPrinterSelection   = 'Printer selection';
  SPrinterTypeSelect  = ' Select the printer type: ';
  SPrinterCanvas      = 'InkJet or Laser';
  SPrinterDotMatrix   = 'Dot Matrix';
  SPrinterSelectionOK = 'OK';
  { **** }
  SPrintProgress      = 'Printing. Please, wait..';
  { **** }
  SPreviewTitle       = 'Print preview';
  SPreviewSaveTitle   = 'Save';
  SPreviewSaveFilter  = 'Text document';
  SPreviewPrintHint   = 'Print' + #13 + 'Alt + P';
  SPreviewSaveHint    = 'Save to text file' + #13 + 'Alt + S';
  SPreviewMailHint    = 'Send mail' + #13 + 'Alt + M'; 
  SPreviewPDFHint     = 'Export to Adobe PDF' + #13 + 'Alt + E';
  SPreviewFirstHint   = 'Go to first page' + #13 + 'Ctrl + Home';
  SPreviewPriorHint   = 'Go to prior page' + #13 + 'Ctrl + PageUp';
  SPreviewNextHint    = 'Go to next page' + #13 + 'Ctrl + PageDown';
  SPreviewLastHint    = 'Go to last page' + #13 + 'Ctrl + End';
  SPreviewGoToHint    = 'Go to page...';
  SPreviewCloseHint   = 'Close preview' + #13 + 'Alt + X';
  SPreviewClose       = 'Close preview?';
  SPreviewPages       = 'Page %d of %d';
  { **** }
  SPDFSave            = 'Save PDF File';
  SPDFSaveFilter      = 'Adobe files PDF';
  SPDFNoFileName      = 'No file name to save PDF.';
{$ENDIF}

{$IFDEF PT_BR}
  SConfirm            = 'Confirma��o';
  SWarning            = 'Advert�ncia';
  SError              = 'Erro';
  { **** }
  SInvalidPrinter     = 'A impressora selecionada ( %s ) n�o � v�lida';
  SNoInstalledPrinter = 'Nenhuma impressora est� instalada';
  SNoDefaultPrinter   = 'Nenhuma impressora padr�o selecionada';
  SNotPrinting        = 'A impressora %s n�o est� imprimindo';
  SPrinting           = 'Impress�o em andamento na impressora %s';
  SOpenPrinterError   = 'N�o foi poss�vel abrir a impressora %s';
  SClosePrinterError  = 'N�o foi poss�vel fechar a impressora %s';
  SAbortPrinterError  = 'N�o foi poss�vel abortar o trabalho na impressora %s';
  SStartDocError      = 'N�o foi poss�vel iniciar o documento %s na impressora %s';
  SEndDocError        = 'N�o foi poss�vel finalizar o documento %s na impressora %s';
  SStartPageError     = 'N�o foi poss�vel iniciar a p�gina na impressora %s';
  SEndPageError       = 'N�o foi poss�vel finalizar a p�gina na impressora %s';
  SWriteError         = 'N�o foi poss�vel enviar dados para a impressora %s';
  { **** }
  SPrinterSelection   = 'Sele��o de impressora';
  SPrinterTypeSelect  = ' Selecione o tipo de impressora: ';
  SPrinterCanvas      = 'Jato de tinta ou Laser';
  SPrinterDotMatrix   = 'Matricial';
  SPrinterSelectionOK = 'OK';
  { **** }
  SPrintProgress      = 'Imprimindo. Por favor, aguarde...';
  { **** }
  SPreviewTitle       = 'Visualizar impress�o';
  SPreviewSaveTitle   = 'Salvar';
  SPreviewSaveFilter  = 'Documento de texto';
  SPreviewPrintHint   = 'Imprimir' + #13 + 'Alt + P';
  SPreviewSaveHint    = 'Salvar para arquivo texto' + #13 + 'Alt + S';
  SPreviewPDFHint     = 'Exportar para Adobe PDF' + #13 + 'Alt + E';
  SPreviewMailHint    = 'Enviar e-mail' + #13 + 'Alt + M';
  SPreviewFirstHint   = 'Ir para a primeira p�gina' + #13 + 'Ctrl + Home';
  SPreviewPriorHint   = 'Ir para a p�gina anterior' + #13 + 'Ctrl + PageUp' ;
  SPreviewNextHint    = 'Ir para a pr�xima p�gina' + #13 + 'Ctrl + PageDown';
  SPreviewLastHint    = 'Ir para a �ltima p�gina' + #13 + 'Ctrl + End';
  SPreviewGoToHint    = 'Ir para a p�gina...';
  SPreviewCloseHint   = 'Fechar visualiza��o' + #13 + 'Alt + X';
  SPreviewClose       = 'Fechar visualiza��o?';
  SPreviewPages       = 'P�gina %d de %d';
  { **** }
  SPDFSave            = 'Salvar arquivo PDF';
  SPDFSaveFilter      = 'Arquivos Adobe PDF';
  SPDFNoFileName      = 'Sem nome de arquivo para salvar o PDF.';
{$ENDIF}

const
  { **** Escapes Epson **** }
  { Controle de caracteres }
  EscDraft          = #27+'x'+'0';    // Modo Draft
  EscNLQ            = #27+'x'+'1';    // Modo NLQ
  EscNLQRoman       = #27+'k'+'0';    // Fonte NLQ "Roman"
  EscNLQSansSerif   = #27+'k'+'1';    // Fonte NLQ "SansSerif"
  Esc10cpp          = #27+'P';        // Espa�amento horizontal em 10cpp
  Esc12cpp          = #27+'M';        // Espa�amento horizontal em 12cpp
  EscCondensedOn    = #15;            // Ativa o modo condensado
  EscCondensedOff   = #18;            // Desativa o modo condensado
  EscLargeOn        = #27+'W'+'1';    // Ativa o modo expandido
  EscLargeOff       = #27+'W'+'0';    // Desativa o modo expandido
  EscBoldOn         = #27+'E';        // Ativa o modo negrito
  EscBoldOff        = #27+'F';        // Desativa o modo negrito
  EscItalicOn       = #27+'4';        // Ativa o modo it�lico
  EscItalicOff      = #27+'5';        // Desativa o modo it�lico
  EscUnderlineOn    = #27+'-'+'1';    // Ativa o modo sublinhado
  EscUnderlineOff   = #27+'-'+'0';    // Desativa o modo sublinhado
  EscDblStrikeOn    = #27+'G';        // Ativa o modo de passada dupla
  EscDblStrikeOff   = #27+'H';        // Desativa o modo de passada dupla
  EscSupScriptOn    = #27+'S1';       // Ativa o modo sobrescrito
  EscSubScriptOn    = #27+'S0';       // Ativa o modo subescrito
  EscScriptOff      = #27+'T';        // Desativa os modos sobrescrito e subescrito
  { Controle de p�gina }
  Esc6lpp           = #27+'2';        // Espa�amento vertical de 6 linhas por polegada
  Esc8lpp           = #27+'0';        // Espa�amento vertical de 8 linhas por polegada
  EscCustomLS       = #27+'3';        // Espa�amento vertical de n/216 linhas por polegadas
  EscMarginLeft     = #27+'l';        // Margem esquerda
  EscMarginRight    = #27+'Q';        // Margem direita
  EscPaperSize      = #27+'C';        // Tamanho da p�gina
  EscAutoNewPageOn  = #27+'N';        // Ativa o salto sobre o picote
  EscAutoNewPageOff = #27+'O';        // Desativa o salto sobre o picote
  { Controle da impressora }
  EscReset          = #27+'@';        // Inicializa a impressora (Reset)
  EscBS             = #8;             // Retorna o carro em uma posi��o
  EscLF             = #10;            // Avan�a uma linha
  EscFF             = #12;            // Avan�a uma p�gina
  EscCR             = #13;            // Retorno do carro

implementation

end.
