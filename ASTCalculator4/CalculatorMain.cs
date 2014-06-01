using System;
using System.IO;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
 
namespace Calculator
{
    class Program
    {
        public static void Main(string[] args)
        {
            Stream inputStream = Console.OpenStandardInput();
            AntlrInputStream input = new AntlrInputStream(inputStream);
            CalculatorLexer lexer = new CalculatorLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            CalculatorParser parser = new CalculatorParser(tokens);
        }
    }
}
