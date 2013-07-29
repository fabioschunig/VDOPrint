{ *********************************************************************** }
{                                                                         }
{                          VDO Print Components                           }
{                             TfrmVDOPreview                              }
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
{  The Original Code is VDOPreview.pas                                    }
{                                                                         }
{  The Initial Developer of the Original Code is Vinicius de Oliveira.    }
{  All Rights Reserved.                                                   }
{                                                                         }
{  Contact :                                                              }
{     vncsoliveira@yahoo.com.br                                           }
{     http://vdo.sourceforge.net                                          }
{ *********************************************************************** }

{$D-}

unit VDOPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, ToolWin, ImgList, 
  VDODmPrinter, VDOCaPrinter;

type
  TVDOPreviewPage = class
  private
    FStream: TStream;
    FDmStream: TStream;
  public
    constructor Create;
    destructor Destroy; override;
    property Stream: TStream read FStream write FStream;
    property DmStream: TStream read FDmStream write FDmStream;
  end;
  { **** }
  TVDOPreviewFont = packed record
    Color: TColor;
    Name: string;
    Size: Byte;
    Style: TFontStyles;
  end;
  { **** }
  TVDOTextBlock = class
  private
    FIsCRLF: Boolean;
    FFont: TVDOPreviewFont;
    FPage, FLine, FColumn, FLen: Word;
    FStart: Longword;
  public
    property IsCRLF: Boolean read FIsCRLF write FIsCRLF;
    property Font: TVDOPreviewFont read FFont write FFont;
    property Page: Word read FPage write FPage;
    property Line: Word read FLine write FLine;
    property Column: Word read FColumn write FColumn;
    property Start: Longword read FStart write FStart;
    property Len: Word read FLen write FLen;
  end;
  { **** }
  TfrmVDOPreview = class(TForm)
    cbxGoToPage: TComboBox;
    redPreviewPage: TRichEdit;
    cobMain: TCoolBar;
    tobMain: TToolBar;
    tbtPrint: TToolButton;
    tbtSave: TToolButton;
    tbtSeparator1: TToolButton;
    tbtPageFirst: TToolButton;
    tbtPagePrior: TToolButton;
    tbtPageNext: TToolButton;
    tbtPageLast: TToolButton;
    tbtSeparator3: TToolButton;
    tbtClose: TToolButton;
    tbtPDF: TToolButton;
    imlMaiOn: TImageList;
    imlMainOff: TImageList;
    tbtSeparator2: TToolButton;
    tbtMail: TToolButton;
    stbMain: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxGoToPageChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtPDFClick(Sender: TObject);
    procedure tbtMailClick(Sender: TObject);
    procedure tbtPageFirstClick(Sender: TObject);
    procedure tbtPagePriorClick(Sender: TObject);
    procedure tbtPageNextClick(Sender: TObject);
    procedure tbtPageLastClick(Sender: TObject);
    procedure tbtCloseClick(Sender: TObject);
  private
    { Variáveis internas }
    Page: TVDOPreviewPage;
    PageList: TList;
    TextBlock: TVDOTextBlock;
    TextBlockList: TList;
    { Procedures e Functions internas }
    procedure CreatePage;
    procedure LoadPage(APageNum: Integer);
    procedure ParseFont;
    procedure GoToPage(APageNum: Integer);
    procedure GoToFirstPage;
    procedure GoToPriorPage;
    procedure GoToNextPage;
    procedure GoToLastPage;
    procedure UpdateButtons;
    procedure Print;
    procedure SaveToTxt;
  public
    { Variáveis públicas  }
    DmPrinter: TVDODmPrinter;
    CaPrinter: TVDOCaPrinter;
    CurrentLine: Integer;
    CurrentPage: Integer;
    PageCount: Integer;
    { Métodos }
    procedure BeginDoc;
    procedure EndDoc;
    procedure NewLine(ALines: Integer = 1);
    procedure NewPage(APages: Integer = 1);
    procedure Write(AText: string); overload;
    procedure Write(AText: string; AColumn: Integer; AFont: TVDOPreviewFont); overload;
    procedure Write(AText, ADmText: string; AFont: TVDOPreviewFont); overload;
  end;

var
  frmVDOPreview: TfrmVDOPreview;

implementation

uses VDOPrintConsts;

{$R *.dfm}

{ *********************************************************************** }
{                                                                         }
{                           TVDOPreviewPage                               }
{                                                                         }
{ *********************************************************************** }

constructor TVDOPreviewPage.Create;
begin
  inherited;
  FStream := TMemoryStream.Create;
  FDmStream := TMemoryStream.Create;
end;

destructor TVDOPreviewPage.Destroy;
begin
  FStream.Free;
  FDmStream.Free;
  inherited;
end;

{ *********************************************************************** }
{                                                                         }
{                            TfrmVDOPreview                               }
{                                                                         }
{ *********************************************************************** }

{ *********************************************************************** }
{                     Procedures e functions internas                     }
{ *********************************************************************** }

procedure TfrmVDOPreview.CreatePage;
begin
  Inc(PageCount);
  Inc(CurrentPage);
  CurrentLine := 1;
  Page := TVDOPreviewPage.Create;
  PageList.Add(Page);
  cbxGoToPage.Items.Add(IntToStr(CurrentPage));
end;

procedure TfrmVDOPreview.LoadPage(APageNum: Integer);
begin
  try
    Screen.Cursor := crHourGlass;
    Page := PageList[APageNum];
    with redPreviewPage do
    begin
      Visible := False;
      Lines.Clear;
      Page.Stream.Position := 0;
      Lines.LoadFromStream(Page.Stream);
      CurrentPage := APageNum;
      ParseFont;
      Visible := True;
      UpdateButtons;
      stbMain.Panels[0].Text := Format(SPreviewPages, [(CurrentPage + 1), PageCount]);
      cbxGoToPage.ItemIndex := CurrentPage;
   end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmVDOPreview.ParseFont;
var
  I: Integer;
begin
  for I := 0 to (TextBlockList.Count - 1) do
  begin
    TextBlock := TextBlockList[I];
    if TextBlock.Page = (CurrentPage + 1) then
    begin
      with redPreviewPage, TextBlock do
      begin
        SelStart := Start;
        SelLength := Len;
        SelAttributes.Color := Font.Color;
        SelAttributes.Name := Font.Name;
        SelAttributes.Size := Font.Size + 1;
        SelAttributes.Style := Font.Style;
      end;
    end;
  end;
  redPreviewPage.SelStart := 0;
  redPreviewPage.SelLength := 0;
end;

procedure TfrmVDOPreview.GoToPage(APageNum: Integer);
begin
  LoadPage(APageNum);
end;

procedure TfrmVDOPreview.GoToFirstPage;
begin
  GoToPage(0);
end;

procedure TfrmVDOPreview.GoToPriorPage;
begin
  if CurrentPage = 0 then Exit;
  GoToPage(CurrentPage - 1);
end;

procedure TfrmVDOPreview.GoToNextPage;
begin
  if CurrentPage = (PageCount - 1) then Exit;
  GoToPage(CurrentPage + 1);
end;

procedure TfrmVDOPreview.GoToLastPage;
begin
  GoToPage(PageCount - 1);
end;

procedure TfrmVDOPreview.UpdateButtons;
begin
  tbtPageFirst.Enabled := (CurrentPage > 0);
  tbtPagePrior.Enabled := (CurrentPage > 0);
  tbtPageNext.Enabled := (CurrentPage < (PageCount - 1));
  tbtPageLast.Enabled := (CurrentPage < (PageCount - 1));
end;

procedure TfrmVDOPreview.Print;
var
  I: Integer;
  S: string;
begin
  { **** Dot Matrix **** }
  if not (DmPrinter = nil) then
  begin
    with DmPrinter do
    begin
      ShowPreview := False;
      FromPreview := True;
      BeginDoc;
      if IsPrinting then
      begin
        for I := 0 to (PageList.Count - 1) do
        begin
          Page := PageList[I];
          Page.DmStream.Position := 0;
          SetString(S, nil, Page.DmStream.Size);
          Page.DmStream.Read(Pointer(S)^, Page.DmStream.Size);
          WriteStr(S);
        end;
        EndDoc(False);
      end;
      FromPreview := False;
      ShowPreview := True;
    end;
  end;
  { **** Canvas **** }
  if not (CaPrinter = nil) then
  begin
    with CaPrinter do
    begin
      ShowPreview := False;
      FromPreview := True;
      BeginDoc;
      if IsPrinting then
      begin
        Page := PageList[0];
        for I := 0 to (TextBlockList.Count - 1) do
        begin
          TextBlock := TextBlockList[I];
          if not(TextBlock.Page = CaPrinter.CurrentPage) then
          begin
            CaPrinter.NewPage;
            Page := PageList[TextBlock.Page - 1];
          end;
          if not (TextBlock.Line = CaPrinter.CurrentLine) then
            CaPrinter.NewLine;
          if not TextBlock.IsCRLF then
          begin
            with Font, TextBlock do
            begin
              Color := Font.Color;
              Name := Font.Name;
              Size := Font.Size;
              Style := Font.Style;
            end;
            Page.Stream.Position := TextBlock.Start;
            SetString(S, nil, TextBlock.Len);
            Page.Stream.Read(Pointer(S)^, TextBlock.Len);
            Print(TextBlock.Column, S);
          end;
        end;
        EndDoc;
      end;
      FromPreview := False;
      ShowPreview := True;
    end;
  end;
end;

procedure TfrmVDOPreview.SaveToTxt;
var
  SaveDlg: TSaveDialog;
  FS: TFileStream;
  I: Integer;
begin
  SaveDlg := TSaveDialog.Create(nil);
  try
    with SaveDlg do
    begin
      DefaultExt := 'txt';
      Filter :=  SPreviewSaveFilter  + ' (*.txt)|*.txt';
      FilterIndex := 1;
      Title := SPreviewSaveTitle;
      Options := Options + [ofOverwritePrompt, ofPathMustExist];
      if Execute then
      begin
        Screen.Cursor := crHourGlass;
        FS := TFileStream.Create(SaveDlg.FileName, fmCreate or fmShareDenyWrite);
        try
          for I := 0 to (PageList.Count - 1) do
          begin
            Page := PageList[I];
            Page.Stream.Position := 0;
            FS.CopyFrom(Page.Stream, Page.Stream.Size);
          end;
        finally
          FS.Free;
          Screen.Cursor := crDefault;
        end;
      end;
    end;
  finally
    SaveDlg.Free;
  end;
end;

{ *********************************************************************** }
{                                 Métodos                                 }
{ *********************************************************************** }

procedure TfrmVDOPreview.BeginDoc;
begin
  Screen.Cursor := crHourGlass;
  CreatePage;
end;

procedure TfrmVDOPreview.EndDoc;
begin
  Screen.Cursor := crDefault;
end;

procedure TfrmVDOPreview.NewLine(ALines: Integer = 1);
var
  I: Integer;
begin
  for I := 1 to ALines do
  begin
    TextBlock := TVDOTextBlock.Create;
    with TextBlock do
    begin
      IsCRLF := True;
      Page := CurrentPage;
      Line := CurrentLine;
    end;
    TextBlockList.Add(TextBlock);
    { **** }
    Write(#13#10);
  end;
  Inc(CurrentLine, ALines);
end;

procedure TfrmVDOPreview.NewPage(APages: Integer = 1);
var
  I: Integer;
begin
  for I := 1 to APages do
    CreatePage;
end;

procedure TfrmVDOPreview.Write(AText: string);
begin
  Page.Stream.Write(PChar(AText)^, Length(AText));
end;

procedure TfrmVDOPreview.Write(AText: string; AColumn: Integer; AFont: TVDOPreviewFont);
begin
  TextBlock := TVDOTextBlock.Create;
  with TextBlock do
  begin
    Font := AFont;
    Page := CurrentPage;
    Line := CurrentLine;
    Column := AColumn;
    Start := Self.Page.Stream.Position;
    Len := Length(AText);
  end;
  TextBlockList.Add(TextBlock);
  { **** }
  Page.Stream.Write(PChar(AText)^, Length(AText));
end;

procedure TfrmVDOPreview.Write(AText, ADmText: string; AFont: TVDOPreviewFont);
begin
  TextBlock := TVDOTextBlock.Create;
  with TextBlock do
  begin
    IsCRLF := False;
    Font := AFont;
    Page := CurrentPage;
    Line := CurrentLine;
    Start := Self.Page.Stream.Position;
    Len := Length(AText);
  end;
  TextBlockList.Add(TextBlock);
  { **** }
  Page.Stream.Write(PChar(AText)^, Length(AText));
  Page.DmStream.Write(PChar(ADmText)^, Length(ADmText));
end;

{ *********************************************************************** }
{                                   Form                                  }
{ *********************************************************************** }

procedure TfrmVDOPreview.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  { **** }
  redPreviewPage.Anchors := [akLeft, akTop, akRight, akBottom];
  WindowState := wsMaximized;
  { **** }
  Caption := SPreviewTitle;
  tbtPrint.Hint := SPreviewPrintHint;
  tbtSave.Hint := SPreviewSaveHint;
  tbtPDF.Hint := SPreviewPDFHint;
  tbtMail.Hint := SPreviewMailHint;
  tbtPageFirst.Hint := SPreviewFirstHint;
  tbtPagePrior.Hint := SPreviewPriorHint;
  tbtPageNext.Hint := SPreviewNextHint;
  tbtPageLast.Hint := SPreviewLastHint;
  cbxGoToPage.Hint := SPreviewGoToHint;
  tbtClose.Hint := SPreviewCloseHint;
  { **** }
  redPreviewPage.MaxLength := $7FFFFFF0;
  PageList := TList.Create;
  TextBlockList := TList.Create;
  CurrentPage := 0;
  PageCount := 0;
end;

procedure TfrmVDOPreview.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to (PageList.Count - 1) do
  begin
    Page := PageList[I];
    Page.Free;
    Page := nil;
  end;
  PageList.Free;
  { **** }
  for I := 0 to (TextBlockList.Count - 1) do
  begin
    TextBlock := TextBlockList[I];
    TextBlock.Free;
    TextBlock := nil;
  end;
  TextBlockList.Free;
end;

procedure TfrmVDOPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
  begin
    if Application.MessageBox(PChar(SPreviewClose), PChar(SConfirm),
      mb_IconQuestion + mb_YesNo + mb_DefButton1) = idYes then
      Close;
  end;
  if Shift = [ssCtrl] then
  begin
    case Key of
      VK_HOME : GoToFirstPage;
      VK_END  : GoToLastPage;
      VK_PRIOR: GoToPriorPage;
      VK_NEXT : GoToNextPage;
    end;
  end;
  if Shift = [ssAlt] then
  begin
    case Key of
      80 {P}: Print;
      69 {E}: {ExportToPDF};
      77 {M}: {SendMail};
      83 {S}: SaveToTxt;
      88 {X}: Close;
    end;
  end;
end;

procedure TfrmVDOPreview.FormPaint(Sender: TObject);
var
  R: TRect;
begin
  with redPreviewPage do
  begin
    R.Top     := Top - 8;
    R.Left    := Left - 8;
    R.Bottom  := Top + Height + 8;
    R.Right   := Left + Width + 8;
  end;
  with Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(R);
    Brush.Color := clBlack;
    FrameRect(R);
    Pen.Color := clBlack;
    Pen.Width := 2;
    MoveTo(R.Left + 2, R.Bottom + 1);
    LineTo(R.Right + 1, R.Bottom + 1);
    LineTo(R.Right + 1 , R.Top + 2);
  end;
end;

procedure TfrmVDOPreview.FormResize(Sender: TObject);
begin
  Repaint;
end;

procedure TfrmVDOPreview.FormShow(Sender: TObject);
begin
  if PageCount > 0 then
    GoToFirstPage;
  redPreviewPage.SetFocus;
end;

procedure TfrmVDOPreview.cbxGoToPageChange(Sender: TObject);
begin
  GoToPage(cbxGoToPage.ItemIndex);
  redPreviewPage.SetFocus;
end;

procedure TfrmVDOPreview.tbtPrintClick(Sender: TObject);
begin
  Print;
end;

procedure TfrmVDOPreview.tbtSaveClick(Sender: TObject);
begin
  SaveToTxt;
end;

procedure TfrmVDOPreview.tbtPDFClick(Sender: TObject);
begin
  {to-do: ExportToPDF}
end;

procedure TfrmVDOPreview.tbtMailClick(Sender: TObject);
begin
 {to-do: SendMail}
end;

procedure TfrmVDOPreview.tbtPageFirstClick(Sender: TObject);
begin
  GoToFirstPage;
end;

procedure TfrmVDOPreview.tbtPagePriorClick(Sender: TObject);
begin
 GoToPriorPage;
end;

procedure TfrmVDOPreview.tbtPageNextClick(Sender: TObject);
begin
  GoToNextPage;
end;

procedure TfrmVDOPreview.tbtPageLastClick(Sender: TObject);
begin
  GoToLastPage;
end;

procedure TfrmVDOPreview.tbtCloseClick(Sender: TObject);
begin
  Close;
end;

end.
