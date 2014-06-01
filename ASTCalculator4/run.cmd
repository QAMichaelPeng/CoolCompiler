cls
set ANTLRTOOL4_TOOL_PATH=..\tool\Antlr4.4.2.2-alpha001\tools
set ANTLRTOOL4_RUNTIME_PATH=..\tool\Antlr4.Runtime.4.2.2-alpha001\lib\net40
set ANTLRTOOL4_JAR=%ANTLRTOOL4_TOOL_PATH%\antlr4-csharp-4.2.2-SNAPSHOT-complete.jar
set OUT=out
set GENERATED=generated
for %%i in (%OUT% %GENERATED%) do (
if exist %%i rmdir %%i /q /s
    if not exist %%i mkdir %%i
)

java -cp %ANTLRTOOL4_JAR% org.antlr.v4.CSharpTool  -listener -visitor -Dlanguage=CSharp_v4_0 Calculator.g4 -o %GENERATED% 2> Calculator.err

if ERRORLEVEL 0 (
rem cls
csc /debug /out:out\CalculatorMain.exe /define:ANTLR_DEBU /r:%ANTLRTOOL4_RUNTIME_PATH%\Antlr4.Runtime.v4.0.dll  CalculatorMain.cs %GENERATED%\CalculatorLexer.cs %GENERATED%\CalculatorParser.cs  %GENERATED%\CalculatorBaseListener.cs %GENERATED%\CalculatorBaseVisitor.cs %GENERATED%\CalculatorListener.cs %GENERATED%\CalculatorVisitor.cs >> Calculator.err
copy /d %ANTLRTOOL4_RUNTIME_PATH%\* %OUT%

    if exist %OUT%\CalculatorMain.exe (
        cls
        %OUT%\CalculatorMain.exe < test.txt > test.log
    )
)
