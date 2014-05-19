using Antlr.Runtime;
using System;
partial class CalculatorParser {
    public override void ReportError(RecognitionException e)
    {
        base.ReportError(e);
        Console.WriteLine("Error in parser at line " + e.Line + ":" + e.CharPositionInLine);
    }
}

