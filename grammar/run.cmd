cls
set ANTLR_PATH=..\tool\antlr-dotnet-csharpbootstrap-3.5.0.2
set PATH=%PATH%;%ANTLR_PATH%
set OUT=out
set GENERATED=generated
for %%i in (%OUT% %GENERATED%) do (
    if exist %%i rmdir %%i /q /s
    if not exist %%i mkdir %%i
)

%ANTLR_PATH%\Antlr3.exe Calculator.g -o %GENERATED% 2> Calculator.err

if ERRORLEVEL 0 (
cls
csc /out:out\CalculatorMain.exe /r:%ANTLR_PATH%\Antlr3.Runtime.dll CalculatorMain.cs %GENERATED%\CalculatorLexer.cs %GENERATED%\CalculatorParser.cs  CalculatorLexer.cs CalculatorParser.cs
copy /d %ANTLR_PATH%\* %OUT%
    if exist %OUT%\CalculatorMain.exe (
        %OUT%\CalculatorMain.exe
    )
)
