package ch.heraldica;

import java.util.List;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ConsoleErrorListener;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.TerminalNode;

class CustomErrorListener extends ConsoleErrorListener {

    private final String prefix;

    CustomErrorListener(String prefix) {
        this.prefix = prefix;
    }

    @Override
    public void syntaxError(
            Recognizer<?, ?> recognizer,
            Object offendingSymbol,
            int line,
            int charPositionInLine,
            String msg,
            RecognitionException e) {
        System.err.println(prefix + "line " + line + ":" + charPositionInLine + " " + msg);
    }
}

public class HeraldryComplexTest {
    public static void main(String[] args) {
        var examples =
                List.of(
                        "coupé, d'or au lion issant de gueules, et d'azur au chevron d'or",
                        "coupé de gueules et d'or, au lion de l'un à l'autre",
                        "De gueules au lion d'or tenant une coupe du même",
                        "coupé, de gueules au lion d'or, et d'azur",
                        "Coupé de sable et d'argent",
                        "coupé, d'argent au lion de gueules, et d'azur",
                        "coupé, d'or au lion issant de gueules, et de sable à la fasce d'or",
                        "coupé, au 1 d'or au lion issant de gueules, au 2 d'azur à trois fers de lance d'argent (2,1)",
                        "tranché, d'or au lion de gueules, et de gueules à trois étoiles d'or posées en bande",
                        "Parti, au 1 de sinople à la fasce d'argent, au 2 de gueules à trois étoiles d'or posées en bande.",
                        "Écartelé, au 1 d'or à la croix de gueules, au 2 d'azur au lion d'argent, au 3 de sable à une tour d'or.",
                        "écartelé, aux 1 et 4 un lion issant d'une montagne de cinq coupeaux posée sur un arc-en-ciel mouvant de la pointe ; aux 2 et 3, trois bandes",
                        "écartelé, aux 1 et 4 d'azur au sautoir accompagné de quatre croisettes, aux 2 et 3 de gueules à un coeur posé entre deux vergettes et accompagné en pointe d'une montagne de trois coupeaux"
                );

        for (var input : examples) {
            var idx = examples.indexOf(input) + 1;
            System.out.println("Analyse " + idx + " : " + input);
            try {
                var lexer = new ch.heraldica.HeraldryRulesLexer(CharStreams.fromString(input));
                var parser = new ch.heraldica.HeraldryRulesParser(new CommonTokenStream(lexer));
                var customErrorListener = new CustomErrorListener("Analyse " + idx + ". ");
                parser.removeErrorListeners();
                lexer.removeErrorListeners();
                parser.addErrorListener(customErrorListener);
                lexer.addErrorListener(customErrorListener);
                var tree = parser.blason();
                System.out.println(tree.toStringTree(parser));
                printSemantic(tree, parser, 0);
            } catch (Exception e) {
                System.err.println("Erreur lors de l'analyse : " + e.getMessage());
            }
            System.out.println("-------------------------------------------------");
        }
    }

    /**
     * Prints a semantic, emoji-annotated representation of the parse tree.
     */
    public static void printSemantic(
            ParseTree tree, ch.heraldica.HeraldryRulesParser parser, int indent) {
        var indentString = "  ".repeat(indent);

        if (tree instanceof TerminalNode) {
            // For terminals, show the token text in quotes
            System.out.println(indentString + "💬 \"" + tree.getText() + "\"");
        } else {
            // For rules, find the name and assign a semantic icon
            var ruleName =
                    parser.getRuleNames()[((org.antlr.v4.runtime.RuleContext) tree).getRuleIndex()];

            var icon =
                    switch (ruleName) {
                        // --- Top Level ---
                        case "blason" -> "🛡️"; // The entire coat of arms

                        // --- Partitioning Logic ---
                        case "partitioned_blason" -> "➗"; // A blason that is divided
                        case "partition_type" -> "🔪"; // NEW: The type of partition (coupé, parti, etc.)
                        case "binary_partition_body" -> "⚖️"; // The "... et ..." structure for two parts
                        case "quartered_partition_body" -> "🔢"; // The "au 1... au 2..." structure for quartering
                        case "multi_numbered_field" -> "📑"; // Multiple numbered fields, e.g., "aux 1 et 3"
                        case "numbered_field" -> "🏷️"; // A single numbered field "au X..."
                        case "separator" -> "↔️"; // A separator like a comma or semicolon
                        case "number_list" -> "🧮"; // A list of numbers, e.g., "1 et 3"

                        // --- Composition ---
                        case "simple_blason" -> "🖼️"; // A complete, single composition (field + charges)
                        case "field" -> "🏞️"; // The background of a field
                        case "charge_description" -> "📜"; // The full description of charges on a field

                        // --- Charge Details ---
                        case "meuble_desc" -> "✍️"; // The specific details of one charge
                        case "sub_meuble_desc" ->
                                "📄"; // NEW: A nested charge description (e.g., for an item being held)
                        case "modifier" -> "✨"; // A modifier for a charge (e.g., color, action)
                        case "sub_modifier" -> "🔸"; // NEW: A nested modifier
                        case "attributes" -> "🖌️"; // Specific attributes like color and position
                        case "charge_modifier_link" -> "🔗"; // A linking word like 'de' or 'sur'
                        case "positional_stmt" -> "📍"; // NEW: A positional phrase like 'en pointe'
                        case "action_phrase" ->
                                "🗣️"; // NEW: A complex action phrase (e.g., 'accompagné de trois étoiles')

                        // --- Core Components ---
                        case "charge" -> "⚜️"; // A generic charge (Fleur-de-lis icon)
                        case "meuble" -> "🦁"; // A specific animate/inanimate charge (e.g., a lion)
                        case "piece" -> "➕"; // A specific geometric charge (e.g., a cross)
                        case "position" -> "🤸"; // The attitude or posture of a charge
                        case "action" -> "✊"; // An action, like 'tenant' (holding)
                        case "number" -> "#️⃣"; // A number like 'trois'
                        case "arrangement" -> "♟️"; // The layout of multiple charges, e.g., (2,1)

                        // --- Tinctures (Colors) ---
                        case "tincture_spec" -> "🔖"; // NEW: A tincture specification (e.g., 'd'or' or 'du même')
                        case "couleur" -> "🌈"; // Any color
                        case "metal" -> "🪙"; // Gold or Silver
                        case "email" -> "🎨"; // Enamels (blue, red, etc.)
                        case "fourrure" -> "🐾"; // Furs (ermine, vair)

                        default -> "📝"; // Default for any other rule
                    };

            System.out.println(indentString + icon + " " + ruleName);

            // Recursively print children
            for (var i = 0; i < tree.getChildCount(); i++) {
                printSemantic(tree.getChild(i), parser, indent + 1);
            }
        }
    }
}
