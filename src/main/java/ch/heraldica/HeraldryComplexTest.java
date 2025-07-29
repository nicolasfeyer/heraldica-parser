package ch.heraldica;

import ch.heraldica.HeraldryRulesParser;
import ch.heraldica.HeraldryRulesLexer;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.TerminalNode;

public class HeraldryComplexTest {
    public static void main(String[] args) {
        String[] examples = {
                "D'azur, au lion d'or, armé et lampassé de gueules",
                "D'or au chevron de gueules, accompagné de trois étoiles du même",
                "de gueules à un gland d'or accompagné en pointe d'un mont de trois coupeaux du même",
                "de gueules au pal d'or chargé d'un coeur de gueules sommé d'une marque de maison de sable",
                "de gueules au pal d'or chargé de deux coeurs du premier",
                "D’azur à trois têtes d’aigle d’argent becquées d’or et languées de gueules",
                "Taillé de gueules sur argent, à la licorne de l’un à l’autre sur un mont de trois coupeaux du premier",
                "Écartelé: aux 1 et 4 d’argent à la fasce coticée d’argent et de gueules; aux 2 et 3 d’argent au chef émanché de trois pièces de gueules",
                "Parti: au 1 reparti emmanché d’argent et de gueules (Landas) au 2 coupé a) fascé d’or et d’azur de huit pièces (Harbacq) b) de gueules plain",
                "Écartelé: aux 1 et 4 d’or à deux bandes d’azur, au 2 de sable, à une crosse épiscopale d’argent, posée en pal, enfilant une couronne d’or, au 3 d’argent à la fasce échiquetée de sable et d’argent, accompagné en chef de deux besants d’or et en pointe d’une étoile d’azur. Sur le tout un écusson ovale d’argent couronné d’or, chargé d’un bélier naissant de gueules, couronné d’or"
        };

        for (var input : examples) {
            System.out.println("Analyse de : " + input);
            try {
                var lexer = new HeraldryRulesLexer(CharStreams.fromString(input));
                var parser = new HeraldryRulesParser(new CommonTokenStream(lexer));
                parser.removeErrorListeners();
                lexer.removeErrorListeners();
                var tree = parser.blason();            
                printSemantic(tree, parser, 0);
            } catch (Exception e) {
                System.err.println("Erreur lors de l'analyse : " + e.getMessage());
            }
            System.out.println("-------------------------------------------------");
        }
    }

    public static void printSemantic(ParseTree tree, ch.heraldica.HeraldryRulesParser parser, int indent) {
        var indentString = "  ".repeat(indent);

        if (tree instanceof TerminalNode) {
            // For terminals, show the token text
            System.out.println(indentString + "💬 \"" + tree.getText() + "\"");
        } else {
            var ruleName = parser.getRuleNames()[((org.antlr.v4.runtime.RuleContext) tree).getRuleIndex()];

            // Add semantic icons based on rule type
            var icon = switch (ruleName) {
                case "blason" -> "🛡️";
                case "partition" -> "✂️";
                case "description_quartier" -> "🔲";
                case "email_uni", "email" -> "🎨";
                case "charge" -> "⚡";
                case "objet" -> "🏺";
                case "piece" -> "📐";
                case "meuble" -> "🦁";
                case "attribut" -> "✨";
                case "accompagnement" -> "👥";
                case "nombre" -> "🔢";
                case "metal" -> "⚪";
                case "couleur" -> "🔴";
                default -> "📝";
            };

            System.out.println(indentString + icon + " " + ruleName);

            for (var i = 0; i < tree.getChildCount(); i++) {
                printSemantic(tree.getChild(i), parser, indent + 1);
            }
        }
    }

}
