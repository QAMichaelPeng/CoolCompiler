using Antlr.Runtime;
using System;
namespace Calculator
{
    partial class CalculatorLexer {
        public override void ReportError(RecognitionException e)
        {
            base.ReportError(e);
            Console.WriteLine("Error in lexer at line " + e.Line + ":" + e.CharPositionInLine);
        }
    }

}
