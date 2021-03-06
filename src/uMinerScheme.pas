unit uMinerScheme;

{$I cef.inc}

interface

uses
{$IFDEF DELPHI16_UP}
  System.Classes, WinApi.Windows, System.SysUtils,
{$ELSE}
  Classes, Windows, SysUtils,
{$ENDIF}
  uCEFInterfaces, uCEFTypes, uCEFResourceHandler;

type
  TMinerScheme = class(TCefResourceHandlerOwn)
  private
    FStream: TMemoryStream;
    FMimeType: string;
    FStatusText: string;
    FStatus: Integer;

  protected
    function ProcessRequest(const request: ICefRequest; const callback: ICefCallback): Boolean; override;
    procedure GetResponseHeaders(const response: ICefResponse; out responseLength: Int64; out redirectUrl: ustring); override;
    function ReadResponse(const dataOut: Pointer; bytesToRead: Integer; var bytesRead: Integer; const callback: ICefCallback): Boolean; override;

  public
    constructor Create(const browser: ICefBrowser; const frame: ICefFrame; const schemeName: ustring; const request: ICefRequest); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
  end;

implementation

constructor TMinerScheme.Create(const browser: ICefBrowser; const frame: ICefFrame; const schemeName: ustring; const request: ICefRequest);
begin
  inherited Create(browser, frame, schemeName, request);

  FStream := nil;
  FStatus := 0;
  FMimeType := '';
  FStatusText := '';
end;

destructor TMinerScheme.Destroy;
begin
  if (FStream <> nil) then
    FreeAndNil(FStream);

  inherited Destroy;
end;

procedure TMinerScheme.AfterConstruction;
begin
  inherited AfterConstruction;

  FStream := TMemoryStream.Create;
end;

procedure TMinerScheme.GetResponseHeaders(const response: ICefResponse; out responseLength: Int64; out redirectUrl: ustring);
begin
  if (response <> nil) then
  begin
    response.Status := FStatus;
    response.StatusText := FStatusText;
    response.MimeType := FMimeType;
  end;

  if (FStream <> nil) then
    responseLength := FStream.Size
  else
    responseLength := 0;
end;

function TMinerScheme.ProcessRequest(const request: ICefRequest; const callback: ICefCallback): Boolean;
var
  Titulo, TempString: string;
  TempUTF8String: AnsiString;
begin
  Result := True;
  FStatus := 200;
  FStatusText := 'OK';
  FMimeType := 'text/html';

  if (FStream <> nil) and (request <> nil) then
  begin
    if request.URL = 'miner://settings/' then
    begin
      Titulo := '';
      TempString := '<html><head> <meta http-equiv="content-type" content="text/html; charset=UTF-8"/> <title>Configura��es</title></head>' + '<body><H3>Configura��es</H3><br>Ol� Tudo bem!<hr /><br /><p>' + request.URL + '</p></body></html>';
    end;
    if request.URL = 'miner://help/' then
    begin
      Titulo := '';
      TempString := '<html><head><meta http-equiv="content-type" content="text/html; charset=UTF-8"/><title>Ajuda</title></head>' + '<body><H3>Ajuda</H3><br>Ol� Tudo bem!<hr /><br /><p>' + request.URL + '</p></body></html>';
    end;


    TempUTF8String := UTF8Encode(TempString);

    FStream.Clear;
    FStream.WriteData(@TempUTF8String[1], length(TempUTF8String));
    FStream.Seek(0, soFromBeginning);
  end;

  if (callback <> nil) then
    callback.Cont;
end;

function TMinerScheme.ReadResponse(const dataOut: Pointer; bytesToRead: Integer; var bytesRead: Integer; const callback: ICefCallback): Boolean;
begin
  if (FStream <> nil) and (dataOut <> nil) then
  begin
    FStream.Seek(0, soFromBeginning);
    bytesRead := FStream.Read(dataOut^, bytesToRead);
    Result := True;
  end
  else
    Result := False;
end;

end.
