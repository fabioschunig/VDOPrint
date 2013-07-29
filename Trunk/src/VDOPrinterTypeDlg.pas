{ *********************************************************************** }
{                                                                         }
{                          VDO Print Components                           }
{                          TfrmVDOPrinterTypeDlg                          }
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
{  The Original Code is VDOPrinterTypeDlg.pas                             }
{                                                                         }
{  The Initial Developer of the Original Code is Vinicius de Oliveira.    }
{  All Rights Reserved.                                                   }
{                                                                         }
{  Contact :                                                              }
{     vncsoliveira@yahoo.com.br                                           }
{     http://vdo.sourceforge.net                                          }
{ *********************************************************************** }

{$D-}

unit VDOPrinterTypeDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmVDOPrinterTypeDlg = class(TForm)
    gbxMain: TGroupBox;
    imgCanvasIcon: TImage;
    imgDotMatrixIcon: TImage;
    rbtCanvas: TRadioButton;
    rbtDotMatrix: TRadioButton;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    CloseOK: Boolean;
  public
    { Public declarations }
    SelectedType: Byte;
  end;

var
  frmVDOPrinterTypeDlg: TfrmVDOPrinterTypeDlg;

implementation

uses VDOPrintConsts;

{$R *.dfm}

procedure TfrmVDOPrinterTypeDlg.FormCreate(Sender: TObject);
begin
  SelectedType := 0;
  { **** }
  Caption := SPrinterSelection;
  gbxMain.Caption := SPrinterTypeSelect;
  rbtCanvas.Caption := SPrinterCanvas;
  rbtDotMatrix.Caption := SPrinterDotMatrix;
  btnOK.Caption := SPrinterSelectionOK;
end;

procedure TfrmVDOPrinterTypeDlg.FormShow(Sender: TObject);
begin
  case SelectedType of
    0: rbtCanvas.Checked := True;
    1: rbtDotMatrix.Checked := True;
  end;
end;

procedure TfrmVDOPrinterTypeDlg.btnOKClick(Sender: TObject);
begin
  CloseOK := True;
  Close;
end;

procedure TfrmVDOPrinterTypeDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not CloseOK then Action := caNone;
  if rbtCanvas.Checked then
    SelectedType := 0
  else SelectedType := 1;
end;

end.
