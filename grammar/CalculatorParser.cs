using Antlr.Runtime;
using System;
namespace Calculator
{
    partial class CalculatorParser 
    {
        public override void ReportError(RecognitionException e)
        {
            base.ReportError(e);
            Console.WriteLine("Error in parser at line " + e.Line + ":" + e.CharPositionInLine);
        }
        partial void EnterRule_expr()
        {
            if (Debug)
            {
                Console.WriteLine("Enter expr");
            }
        }
        partial void LeaveRule_expr()
        {
            if (Debug)
            {
                Console.WriteLine("Leave expr");
            }
        }

        partial void EnterRule_addexpr()
        {
            if (Debug)
            {
                Console.WriteLine("Enter addexpr");
            }
        }
        partial void EnterRule_mulexpr()
        {
            if (Debug)
            {
                Console.WriteLine("Enter mulexpr");
            }
        }
        partial void LeaveRule_mulexpr()
        {
            if (Debug)
            {
                Console.WriteLine("Leave mulexpr");
            }
        }
        partial void LeaveRule_addexpr()
        {
            if (Debug)
            {
                Console.WriteLine("Leave addexpr");
            }
        }
        partial void EnterRule_expr_statement()
        {
            if (Debug)
            {
                Console.WriteLine("EnterRule_expr_statement");
            }
        }
        partial void LeaveRule_expr_statement()
        {
            if (Debug)
            {
                Console.WriteLine("LeaveRule_expr_statement");
            }
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
