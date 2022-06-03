unit TestmXML;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  Classes, SysUtils, mXML, mUtility, mFloatsManagement, mXMLFormatter, mXMLFormatterAsTxt, mXMLFormatterAsPdf
  {$IFNDEF FPC}, IOUtils, TestFramework
  {$ELSE}
  ,fpcunit, testutils, testregistry, FileUtil
  {$ENDIF};

type
  // Test methods for class TmXmlDocument

  { TestTmXmlDocument }

  TestTmXmlDocument = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSimpleSaveAndLoad;
    procedure TestEncryptedSaveAndLoad;
    procedure TestCursor;
    procedure TestCursorMultipleLevels;
    procedure TestText;
  end;

  { TestTXmlFormatterAsText }

  TestTXmlFormatterAsText = class (TTestCase)
  strict private
    FSamplesFolder : String;
    FOutputFolder : String;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    procedure Test (const aFileName : String);
  published
    procedure TestSimple;
    procedure TestComments;
    procedure TestCarriageReturns;
    procedure TestNoProlog;
    procedure TestProcessingInstructions;
    procedure TestSelfClosed;
    procedure TestCDATA;
    procedure TestCDATA2;
  end;

  { TestTXmlFormatterAsPdf }

  TestTXmlFormatterAsPdf = class (TTestCase)
  strict private
    FSamplesFolder : String;
    FOutputFolder : String;
    FFontsFolder : String;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    procedure Test (const aFileName : String);
  published
    procedure TestSimple;
    procedure TestComments;
    procedure TestCarriageReturns;
    procedure TestNoProlog;
    procedure TestProcessingInstructions;
    procedure TestSelfClosed;
    procedure TestCDATA;
    procedure TestCDATA2;
  end;

implementation

{ TestTXmlFormatterAsPdf }

procedure TestTXmlFormatterAsPdf.SetUp;
begin
  FSamplesFolder:= IncludeTrailingPathDelimiter(GetCurrentDir) + 'samples';
  FFontsFolder:= IncludeTrailingPathDelimiter(GetCurrentDir) + 'fonts';
  FOutputFolder:= IncludeTrailingPathDelimiter(GetCurrentDir) + 'xml_output';
  if not DirectoryExists(FOutputFolder) then
    CreateDir(FOutputFolder);
end;

procedure TestTXmlFormatterAsPdf.TearDown;
begin
  inherited TearDown;
end;

procedure TestTXmlFormatterAsPdf.Test(const aFileName: String);
var
  list : TStringList;
  error : String;
begin
  list := TStringList.Create;
  try
    list.LoadFromFile(IncludeTrailingPathDelimiter(FSamplesFolder) + aFileName + '.xml');
    //CheckTrue(TXmlFormatterAsPdf.XMLToPdfFile(list.Text, IncludeTrailingPathDelimiter(FOutputFolder) + aFileName + '.pdf', ExtractFileName(aFileName), 'Test suite', 'mXMLFormatter',
    //  IncludeTrailingPathDelimiter(FFontsFolder) + 'LiberationMono-MW1v.ttf', 'Liberation Mono', error), error);

    // https://www.fontsquirrel.com/fonts/Bitstream-Vera-Sans-Mono
    CheckTrue(TXmlFormatterAsPdf.XMLToPdfFile(list.Text, IncludeTrailingPathDelimiter(FOutputFolder) + aFileName + '.pdf', ExtractFileName(aFileName), 'Test suite', 'mXMLFormatter',
      IncludeTrailingPathDelimiter(FFontsFolder) + 'VeraMono.ttf', 'Bitstream Vera Sans Mono', IncludeTrailingPathDelimiter(FFontsFolder) + 'VeraMono-Bold.ttf', 'Bitstream Vera Sans Mono Bold', error), error);
  finally
    list.Free;
  end;
end;

procedure TestTXmlFormatterAsPdf.TestSimple;
begin
  Test('test_simple');
end;

procedure TestTXmlFormatterAsPdf.TestComments;
begin
  Test('test_comments');
end;

procedure TestTXmlFormatterAsPdf.TestCarriageReturns;
begin
  Test('test_cr');
end;

procedure TestTXmlFormatterAsPdf.TestNoProlog;
begin
  Test('test_no_prolog');
end;

procedure TestTXmlFormatterAsPdf.TestProcessingInstructions;
begin
  Test('test_pi');
end;

procedure TestTXmlFormatterAsPdf.TestSelfClosed;
begin
  Test('test_self_closed');
end;

procedure TestTXmlFormatterAsPdf.TestCDATA;
begin
  Test('test_cdata');
end;

procedure TestTXmlFormatterAsPdf.TestCDATA2;
begin
  Test('test_cdata_2');
end;

{ TestTXmlFormatterAsText }

procedure TestTXmlFormatterAsText.SetUp;
begin
  FSamplesFolder:= IncludeTrailingPathDelimiter(GetCurrentDir) + 'samples';
  FOutputFolder:= IncludeTrailingPathDelimiter(GetCurrentDir) + 'xml_output';
  if not DirectoryExists(FOutputFolder) then
    CreateDir(FOutputFolder);
end;

procedure TestTXmlFormatterAsText.TearDown;
begin
  inherited TearDown;
end;

procedure TestTXmlFormatterAsText.Test(const aFileName: String);
var
  list : TStringList;
  error : String;
begin
  list := TStringList.Create;
  try
    list.LoadFromFile(IncludeTrailingPathDelimiter(FSamplesFolder) + aFileName + '.xml');
    CheckTrue(TXmlFormatterAsText.XMLToTxtFile(list.Text, IncludeTrailingPathDelimiter(FOutputFolder) + aFileName + '.txt', error), error);
  finally
    list.Free;
  end;
end;

procedure TestTXmlFormatterAsText.TestSimple;
begin
  Test('test_simple');
end;

procedure TestTXmlFormatterAsText.TestComments;
begin
  Test('test_comments');
end;

procedure TestTXmlFormatterAsText.TestCarriageReturns;
begin
  Test('test_cr');
end;

procedure TestTXmlFormatterAsText.TestNoProlog;
begin
  Test('test_no_prolog');
end;

procedure TestTXmlFormatterAsText.TestProcessingInstructions;
begin
  Test('test_pi');
end;

procedure TestTXmlFormatterAsText.TestSelfClosed;
begin
  Test('test_self_closed');
end;

procedure TestTXmlFormatterAsText.TestCDATA;
begin
  Test('test_cdata');
end;

procedure TestTXmlFormatterAsText.TestCDATA2;
begin
  Test('test_cdata_2');
end;

procedure TestTmXmlDocument.SetUp;
begin
end;

procedure TestTmXmlDocument.TearDown;
begin
end;

procedure TestTmXmlDocument.TestCursor;
var
  tempCursor : TmXmlElementCursor;
  FmXmlDocument : TmXmlDocument;
  TempFileName : string;
  i : integer;
begin
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.CreateRootElement('root');
    for i := 0 to 9 do
    begin
      FmXmlDocument.RootElement.AddElement('subitem').SetAttribute('key', IntToStr(i));
    end;
    {$IFDEF FPC}
    TempFileName := SysUtils.GetTempFileName;
    {$ELSE}
    TempFileName := TPath.GetTempFileName;
    {$ENDIF}
    FmXMLDocument.SaveToFile(TempFileName);
    {$IFNDEF FPC}
    Status(TempFileName);
    {$ENDIF}
  finally
    FmXmlDocument.Free;
  end;
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.LoadFromFile(TempFileName);
    tempCursor := TmXmlElementCursor.Create(FmXmlDocument.RootElement, 'subitem');
    try
      CheckEquals(tempCursor.Count, 10);
      for I := 0 to tempCursor.Count - 1 do
      begin
        CheckEquals(tempCursor.Elements[i].GetAttribute('key'), IntToStr(i));
      end;
    finally
      tempCursor.Free;
    end;

    for i := 0 to 9 do
    begin
      FmXmlDocument.RootElement.AddElement('subitem').SetAttribute('key', IntToStr(i));
    end;
  finally
    FmXmlDocument.Free;
  end;
end;

procedure TestTmXmlDocument.TestCursorMultipleLevels;
var
  tempCursor : TmXmlElementCursor;
  FmXmlDocument : TmXmlDocument;
  TempFileName : string;
  i, k : integer;
  subElement : TmXmlElement;
begin
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.CreateRootElement('root');
    for i := 0 to 9 do
    begin
      subElement := FmXmlDocument.RootElement.AddElement('subitem');
      subElement.SetAttribute('key', IntToStr(i));
      subElement.AddElement('subsubitem');
    end;
    {$IFDEF FPC}
    TempFileName := SysUtils.GetTempFileName;
    {$ELSE}
    TempFileName := TPath.GetTempFileName;
    {$ENDIF}
    FmXMLDocument.SaveToFile(TempFileName);
    {$IFNDEF FPC}
    Status(TempFileName);
    {$ENDIF}
  finally
    FmXmlDocument.Free;
  end;
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.LoadFromFile(TempFileName);
    tempCursor := TmXmlElementCursor.Create(FmXmlDocument.RootElement, 'subitem');
    try
      CheckEquals(tempCursor.Count, 10);
      for I := 0 to tempCursor.Count - 1 do
      begin
        CheckEquals(tempCursor.Elements[i].GetAttribute('key'), IntToStr(i));
      end;
    finally
      tempCursor.Free;
    end;

    for i := 0 to 9 do
    begin
      FmXmlDocument.RootElement.AddElement('subitem').SetAttribute('key', IntToStr(i));
    end;
  finally
    FmXmlDocument.Free;
  end;
end;

procedure TestTmXmlDocument.TestText;
var
  FmXmlDocument : TmXmlDocument;
  TempFileName : string;
begin
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.CreateRootElement('root_element').SetValue('高大的绿叶树'); //'@@ABC$$');
    {$IFDEF FPC}
    TempFileName := SysUtils.GetTempFileName;
    {$ELSE}
    TempFileName := TPath.GetTempFileName;
    {$ENDIF}
    FmXMLDocument.SaveToFile(TempFileName);
  finally
    FmXmlDocument.Free;
  end;
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.LoadFromFile(TempFileName);
    CheckTrue(FmXmlDocument.RootElement <> nil);
    CheckEquals('高大的绿叶树', FmXmlDocument.RootElement.GetValue); // @@ABC$$
  finally
    FmXmlDocument.Free;
  end;

end;

procedure TestTmXmlDocument.TestSimpleSaveAndLoad;
var
  FmXmlDocument : TmXmlDocument;
  TempFileName : string;
  DateTimeValue : TDateTime;
begin
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.CreateRootElement('root_element').SetAttribute('key', 'value');
    CheckTrue(FmXmlDocument.RootElement <> nil);
    CheckTrue(FmXMLDocument.RootElement.HasAttribute('key'));
    CheckEquals('value', FmXmlDocument.RootElement.GetAttribute('key'));
    DateTimeValue := Now;
    FmXmlDocument.RootElement.SetDateTimeAttribute('time', DateTimeValue);
    CheckTrue(DoublesAreEqual(DateTimeValue, FmXmlDocument.RootElement.GetDateTimeAttribute('time'), 4),
      FloatToStr(DateTimeValue) + ' is not ' + FloatToStr(FmXmlDocument.RootElement.GetDateTimeAttribute('time')));
    FmXmlDocument.RootElement.AddElement('child1').SetAttribute('key1', 'value1');
    FmXmlDocument.RootElement.AddElement('child2').SetAttribute('key2', 'value2');
    {$IFDEF FPC}
    TempFileName := SysUtils.GetTempFileName;
    {$ELSE}
    TempFileName := TPath.GetTempFileName;
    {$ENDIF}
    FmXMLDocument.SaveToFile(TempFileName);
    {$IFNDEF FPC}
    Status(TempFileName);
    {$ENDIF}
  finally
    FmXmlDocument.Free;
  end;
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.LoadFromFile(TempFileName);
    CheckTrue(FmXmlDocument.RootElement <> nil);
    CheckTrue(FmXMLDocument.RootElement.HasAttribute('key'));
    CheckEquals('value', FmXmlDocument.RootElement.GetAttribute('key'));
    CheckTrue(DoublesAreEqual(DateTimeValue, FmXmlDocument.RootElement.GetDateTimeAttribute('time'),4));
  finally
    FmXmlDocument.Free;
  end;

end;

procedure TestTmXmlDocument.TestEncryptedSaveAndLoad;
var
  FmXmlDocument : TmXmlDocument;
  TempFileName : string;
  DateTimeValue : TDateTime;
begin
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.CreateRootElement('root_element').SetAttribute('key', 'value');
    CheckTrue(FmXmlDocument.RootElement <> nil);
    CheckTrue(FmXMLDocument.RootElement.HasAttribute('key'));
    CheckEquals('value', FmXmlDocument.RootElement.GetAttribute('key'));
    DateTimeValue := Now;
    FmXmlDocument.RootElement.SetDateTimeAttribute('time', DateTimeValue);
    CheckTrue(DoublesAreEqual(DateTimeValue, FmXmlDocument.RootElement.GetDateTimeAttribute('time'), 4),
      FloatToStr(DateTimeValue) + ' is not ' + FloatToStr(FmXmlDocument.RootElement.GetDateTimeAttribute('time')));
    FmXmlDocument.RootElement.AddElement('child1').SetAttribute('key1', 'value1');
    FmXmlDocument.RootElement.AddElement('child2').SetAttribute('key2', 'value2');
    {$IFDEF FPC}
    TempFileName := SysUtils.GetTempFileName;
    {$ELSE}
    TempFileName := TPath.GetTempFileName;
    {$ENDIF}
    FmXMLDocument.SaveToFileEncrypted(TempFileName, 'password');
    {$IFNDEF FPC}
    Status(TempFileName);
    {$ENDIF}
  finally
    FmXmlDocument.Free;
  end;
  FmXmlDocument := TmXmlDocument.Create;
  try
    FmXmlDocument.LoadFromFileEncrypted(TempFileName, 'password');
    CheckTrue(FmXmlDocument.RootElement <> nil);
    CheckTrue(FmXMLDocument.RootElement.HasAttribute('key'));
    CheckEquals('value', FmXmlDocument.RootElement.GetAttribute('key'));
    CheckTrue(DoublesAreEqual(DateTimeValue, FmXmlDocument.RootElement.GetDateTimeAttribute('time'),4));
  finally
    FmXmlDocument.Free;
  end;
end;

initialization
  // Register any test cases with the test runner
  {$IFDEF FPC}
  RegisterTest(TestTmXmlDocument);
  RegisterTest(TestTXmlFormatterAsText);
  RegisterTest(TestTXmlFormatterAsPdf);
  {$ELSE}
  RegisterTest(TestTmXmlDocument.Suite);
  RegisterTest(TestTXmlFormatterAsText.Suite);
  {$ENDIF}
end.

