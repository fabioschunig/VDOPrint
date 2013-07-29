{ *********************************************************************** }
{                                                                         }
{                          VDO Print Components                           }
{                          TfrmVDOPrintProgress                           }
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
{  The Original Code is VDOPrintProgress.pas                              }
{                                                                         }
{  The Initial Developer of the Original Code is Vinicius de Oliveira.    }
{  All Rights Reserved.                                                   }
{                                                                         }
{  Contact :                                                              }
{     vncsoliveira@yahoo.com.br                                           }
{     http://vdo.sourceforge.net                                          }
{ *********************************************************************** }

{$D-}

unit VDOPrintProgress;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls;

type
  TfrmVDOPrintProgress = class(TForm)
    timPrinting: TTimer;
    bvlMain: TBevel;
    lblPrinting: TLabel;
    ptbPrinting: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timPrintingTimer(Sender: TObject);
    procedure ptbPrintingPaint(Sender: TObject);
  private
    { Private declarations }
    Frames: TBitmap;
    FrameIndex: Byte;
  public
    { Public declarations }
    CanClose: Boolean;
  end;

var
  frmVDOPrintProgress: TfrmVDOPrintProgress;

implementation

uses VDOPrintConsts;

{$R *.dfm}
{$R VDOPrintProgress.res}

procedure TfrmVDOPrintProgress.FormCreate(Sender: TObject);
begin
  lblPrinting.Caption := SPrintProgress;
  { **** }
  Frames := TBitmap.Create;
  Frames.LoadFromResourceName(HInstance,'PRINTING');
  FrameIndex := 0;
end;

procedure TfrmVDOPrintProgress.FormShow(Sender: TObject);
begin
  DoubleBuffered := True;
  timPrinting.Enabled := True;
end;

procedure TfrmVDOPrintProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not CanClose then
    Action := caNone
  else Frames.Free;
end;

procedure TfrmVDOPrintProgress.timPrintingTimer(Sender: TObject);
begin
  ptbPrinting.Refresh;
  FrameIndex := Succ(FrameIndex) mod 6;
end;

procedure TfrmVDOPrintProgress.ptbPrintingPaint(Sender: TObject);
begin
  with ptbPrinting.Canvas do
  begin
    Brush.Color := Color;
    FillRect(Bounds(0, 0, 32, 32));
    BrushCopy(Bounds(0, 0, 32, 32), Frames, Bounds(FrameIndex * 32, 0, 32, 32), clFuchsia);
  end;
end;


end.
