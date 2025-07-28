import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class HeraldryComplexTest {
    public static void main(String[] args) {
        // Exemples de descriptions héraldiques
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

        for (String input : examples) {
            System.out.println("Analyse de : " + input);
            try {
                HeraldryRulesLexer lexer = new HeraldryRulesLexer(CharStreams.fromString(input));
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                HeraldryRulesParser parser = new HeraldryRulesParser(tokens);
                ParseTree tree = parser.blason();
                System.out.println(tree.toStringTree(parser));
            } catch (Exception e) {
                System.err.println("Erreur lors de l'analyse : " + e.getMessage());
            }
            System.out.println("-------------------------------------------------");
        }
    }
}
