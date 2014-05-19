using System;
using System.IO;
using Antlr.Runtime;
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
            parser.expr_statement();
        }
    }
}
