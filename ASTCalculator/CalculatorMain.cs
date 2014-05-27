using System;
using System.IO;
using Antlr.Runtime;
using Antlr.Runtime.Tree;
using Antlr.Runtime.Misc;
 
namespace Calculator
{
    class Program
    {
        public static void Main(string[] args)
        {
            Stream inputStream = Console.OpenStandardInput();
            ANTLRInputStream input = new ANTLRInputStream(inputStream);
            CalculatorLexer lexer = new CalculatorLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            CalculatorParser parser = new CalculatorParser(tokens);
            var tree = parser.stat().Tree;
            Console.WriteLine(tree.ToStringTree());
            //DumpTree(tree, "", "  ");
        }
        public static void DumpTree(ITree tree, String indent, String step)
        {
            Console.WriteLine("{0}{1}({2})", indent , tree.ToString() , tree.Type.ToString());
            for (int i = 0; i < tree.ChildCount; ++i)
            {
                var child = tree.GetChild(i);
                DumpTree(child, indent + step, step);
            }
        }
    }
}
