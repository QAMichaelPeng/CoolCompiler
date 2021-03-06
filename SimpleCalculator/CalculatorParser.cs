using Antlr.Runtime;
using Antlr.Runtime.Debug;
using System;
namespace Calculator
{
    partial class CalculatorParser 
    {
        partial void EnterRule(string ruleName, int ruleIndex)
        {
            if (Debug)
            {
                Console.WriteLine("Enter {0}", ruleName);
            }
        }
        partial void LeaveRule(string ruleName, int ruleIndex)
        {
            if (Debug)
            {
                Console.WriteLine("Leave {0}", ruleName);
            }
        }
        public override void ReportError(RecognitionException e)
        {
            base.ReportError(e);
            Console.WriteLine("Error in parser at line " + e.Line + ":" + e.CharPositionInLine);
        }
        public override object Match(IIntStream input, int ttype, BitSet follow)
        {
            object currentInputSymbol = this.GetCurrentInputSymbol(input);
            if (Debug)
            {
                Console.WriteLine(currentInputSymbol);
            }
            if (input.LA(1) == ttype)
            {
                input.Consume();
                this.state.errorRecovery = false;
                this.state.failed = false;
                return currentInputSymbol;
            }
            else
            {
                if (this.state.backtracking <= 0)
                    return this.RecoverFromMismatchedToken(input, ttype, follow);
                this.state.failed = true;
                return currentInputSymbol;
            }
        }

    }
}
