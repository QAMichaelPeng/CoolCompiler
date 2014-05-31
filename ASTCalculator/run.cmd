cls
set ANTLR_PATH=..\tool\antlr-dotnet-csharpbootstrap-3.5.0.2
set OUT=out
set GENERATED=generated
for %%i in (%OUT% %GENERATED%) do (
if exist %%i rmdir %%i /q /s
    if not exist %%i mkdir %%i
)

%ANTLR_PATH%\Antlr3.exe -trace -verbose Calculator.g -o %GENERATED% 2> Calculator.err

if ERRORLEVEL 0 (
cls
csc /debug /out:out\CalculatorMain.exe /define:ANTLR_DEBU /r:%ANTLR_PATH%\Antlr3.Runtime.dll  /r:%ANTLR_PATH%\Antlr3.Runtime.Debug.dll CalculatorMain.cs %GENERATED%\CalculatorLexer.cs %GENERATED%\CalculatorParser.cs  CalculatorLexer.cs CalculatorParser.cs TraceDebugEventListenerEx.cs >> Calculator.err
copy /d %ANTLR_PATH%\* %OUT%

    if exist %OUT%\CalculatorMain.exe (
        cls
        %OUT%\CalculatorMain.exe < test.txt > test.log
    )
)
