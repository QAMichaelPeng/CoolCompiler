using Antlr.Runtime;
using Antlr.Runtime.Debug;
using System;
using ITreeAdaptor = Antlr.Runtime.Tree.ITreeAdaptor;
namespace Calculator
{
    public class TraceDebugEventListenerEx : TraceDebugEventListener
    {

        public TraceDebugEventListenerEx(ITreeAdaptor adaptor)
            :base(adaptor)
        {
        }

        public override void EnterDecision(int decisionNumber, bool couldBacktrack)
        {
            Console.Out.WriteLine( "enterDecision {0}:{1}", decisionNumber, couldBacktrack);
        }
        public override void ExitDecision(int decisionNumber)
        {
            Console.Out.WriteLine( "exitDecision {0}:", decisionNumber);
        }
        public override void EnterAlt(int alt)
        {
            Console.Out.WriteLine( "enterAlt {0}", alt);
        }
    }
}
