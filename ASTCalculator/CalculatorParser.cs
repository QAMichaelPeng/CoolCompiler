using Antlr.Runtime;
using Antlr.Runtime.Debug;
using System;
using System.Diagnostics;
namespace Calculator
{
    partial class CalculatorParser 
    {
        
        private IDebugEventListener debugEventListener = null;

        public override IDebugEventListener DebugListener
        {
            get
            {
                return debugEventListener;
            }
        }

        [Conditional("ANTLR_DEBUG")]
        partial void OnCreated()
        {
            Console.WriteLine("OnCreated");
            debugEventListener = new TraceDebugEventListenerEx(TreeAdaptor);
        }

        [Conditional("ANTLR_DEBUG")]
        partial void EnterRule(string ruleName, int ruleIndex)
        {
            Console.WriteLine("Enter {0}", ruleName);
        }

        [Conditional("ANTLR_DEBUG")]
        partial void LeaveRule(string ruleName, int ruleIndex)
        {
            Console.WriteLine("Leave {0}", ruleName);
        }

        public override void ReportError(RecognitionException e)
        {
            base.ReportError(e);
            Console.WriteLine("Error in parser at line " + e.Line + ":" + e.CharPositionInLine);
        }

        [Conditional("ANTLR_DEBUG")]
        public void DumpSymbol(object currentSymbol)
        {
            Console.WriteLine(currentSymbol);
        }

        public override object Match(IIntStream input, int ttype, BitSet follow)
        {
            object currentInputSymbol = this.GetCurrentInputSymbol(input);
            DumpSymbol(currentInputSymbol);
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
