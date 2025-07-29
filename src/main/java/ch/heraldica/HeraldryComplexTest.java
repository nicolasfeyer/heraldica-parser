package ch.heraldica;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.TerminalNode;

public class HeraldryComplexTest {
  public static void main(String[] args) {
    String[] examples = {
        "coupé, d'or au lion issant de gueules, et d'azur au chevron d'or",
        "coupé de gueules et d'or, au lion de l'un à l'autre",
        "De gueules au lion d'or tenant une coupe du même",
        "coupé, de gueules au lion d'or, et d'azur",
        "Coupé de sable et d'argent",
        "coupé, d'argent au lion de gueules, et d'azur",
        "coupé, d'or au lion issant de gueules, et de sable à la fasce d'or"
    };

    for (var input : examples) {
      System.out.println("Analyse de : " + input);
      try {
        var lexer = new ch.heraldica.HeraldryRulesLexer(CharStreams.fromString(input));
        var parser = new ch.heraldica.HeraldryRulesParser(new CommonTokenStream(lexer));
        // parser.removeErrorListeners();
        // lexer.removeErrorListeners();
        var tree = parser.blason();
        System.out.println(tree.toStringTree(parser));
        printSemantic(tree, parser, 0);
      } catch (Exception e) {
        System.err.println("Erreur lors de l'analyse : " + e.getMessage());
      }
      System.out.println("-------------------------------------------------");
    }
  }

  public static void printSemantic(
      ParseTree tree, ch.heraldica.HeraldryRulesParser parser, int indent) {
    var indentString = "  ".repeat(indent);

    if (tree instanceof TerminalNode) {
      // For terminals, show the token text
      System.out.println(indentString + "💬 \"" + tree.getText() + "\"");
    } else {
      var ruleName =
          parser.getRuleNames()[((org.antlr.v4.runtime.RuleContext) tree).getRuleIndex()];

      // Add semantic icons based on rule type
      var icon =
          switch (ruleName) {
            case "blason" -> "🛡️";
            case "partition" -> "🍕";
            case "coupe" -> "✂️";
            case "champ" -> "🏞️";
            case "meuble" -> "🪑";
            case "meuble_desc" -> "🦁";
            case "metal" -> "🪙";
            case "email" -> "🔴";
            default -> "📝";
          };

      System.out.println(indentString + icon + " " + ruleName);

      for (var i = 0; i < tree.getChildCount(); i++) {
        printSemantic(tree.getChild(i), parser, indent + 1);
      }
    }
  }
}
