# Heraldica parser

### Current Capabilities

The parser can currently interpret and deconstruct the structure of simple and partitioned blazons according to French heraldic rules.

**Simple Blazons:**
*   **Fields:** It recognizes a simple color field, including metals (*métaux*) like `or` and `argent`; enamels (*émaux*) like `azur`, `gueules`, `sable`, `sinople`, and `pourpre`; and furs (*fourrures*) like `hermine` and `vair`.
*   **Charges:** It can identify a primary charge, whether it is an ordinary (*pièce*) such as a `fasce`, `pal`, `croix`, `chef`, or `bande`, or a common charge (*meuble*) like a `lion`, `tour`, `étoile`, or `chevron`.
*   **Charge Attributes:** It can parse basic characteristics for charges, such as:
    *   Tincture (`un lion de gueules`).
    *   Position or attitude (`un lion rampant`).
    *   Specific details like the color of claws or tongue (`armé`, `lampassé`).

**Partitioned Blazons:**
The parser handles fundamental partitions:
*   **Binary Partitions:** `Parti`, `Coupé`, `Tranché`, and `Taillé`. It supports the classic description using `et` (e.g., `Parti d'or et d'azur`) as well as descriptions by numbered fields (`Parti, au 1 d'or, au 2 d'azur`).
*   **Quartering:** It can interpret `Écartelé` blazons with descriptions for the four quarters (`Écartelé, au 1... au 2...`).

### Next Steps

Future development will focus on enriching the grammar to cover more complex and detailed heraldic descriptions.

**1. Enriching Partitions:**
*   **Complex Partitions:** Integration of more elaborate partitions such as `Tiercé` (en pal, en fasce, en bande), `Gironné`, and compound fields like `Palé`, `Fascé`, `Burelé`, etc.
*   **Counter-Partitions:** Adding the ability to parse `contre-écartelés` and other nested partitions.

**2. Expanding Charge Descriptions:**
*   **Multiple Charges:** Allowing the description of several different charges within the same field (e.g., `d'azur au chevron d'or accompagné de trois étoiles du même`).
*   **Advanced Attributes:** Adding a wider range of positions (`contourné`, `issant`, `naissant`), attributes (`couronné`, `becqué`, `membré`), and actions (`brochant sur le tout`).
*   **Arrangements:** Improving the description of how charges are arranged on the field (`posés en fasce`, `en pal`, `en orle`, etc.).

**3. Modified Ordinaries:**
*   Integrating modifications applied to ordinaries, such as `bretessé`, `crénelé`, `engrêlé`, `denticulé`, and others.

### Technical Overview

This project implements a blazon parser using ANTLR4 (ANother Tool for Language Recognition), a powerful parser generator. The build system is managed by Apache Maven, which automates the compilation, dependency management, and plugin execution, including the generation of parser components. The project is designed for Java environments, specifically targeting Java 14 for compilation.

**Core Components:**

*   **ANTLR4 Grammars (`.g4` files):** The `HeraldryRules.g4` grammar defines the formal syntax of the blazon language, including lexical rules (tokens) and parsing rules (how tokens form meaningful structures). The `HeraldryVocabulary.g4` lexer grammar defines the individual tokens, such as colors (`AZUR`, `OR`), partitions (`COUPE`, `PARTI`), and charges (`LION`, `FASCE`).
*   **Generated Parser & Lexer:** The ANTLR4 Maven Plugin automatically processes these `.g4` files during the build. It generates Java source files, specifically `HeraldryRulesLexer.java` and `HeraldryRulesParser.java` (along with a `BaseListener` and `Visitor`), which are then compiled into bytecode. These generated classes are the core components responsible for recognizing and parsing blazon strings.
*   **Maven (`pom.xml`):** The Project Object Model (`pom.xml`) configures the build process:
    *   **`antlr4-maven-plugin`:** This plugin is crucial. It invokes the ANTLR4 tool to generate the lexer and parser classes from the grammar files. The `<libDirectory>` configuration points to where the grammar files are located.
    *   **`antlr4-runtime` dependency:** The generated parser and lexer code depend on the ANTLR4 runtime library, which is included as a Maven dependency.
    *   **`maven-compiler-plugin`:** Configures the Java compiler. In this setup, it's set to compile source and target bytecode for Java 14.
    *   **`spotless-maven-plugin`:** This plugin enforces code formatting standards, specifically for ANTLR4 grammar files (`.g4`), ensuring consistency in the grammar's syntax and style.

### How to Build and Run

To build and run this blazon parser, you will need Java Development Kit (JDK) 14 or higher and Apache Maven installed on your system.

**1. Clone the Repository (Conceptual):**
Assuming this project resides in a version control system, you would first clone it:
```bash
git clone <repository-url>
cd heraldry-project
```

**2. Build the Project:**
Navigate to the root directory of the project (where `pom.xml` is located) and execute the Maven build command:
```bash
mvn clean install
```
This command performs several steps:
*   `clean`: Removes any previously compiled classes and build artifacts.
*   `install`: Compiles the project, runs tests (if any), and packages the compiled classes into a JAR file, which is then installed into your local Maven repository.
    *   Crucially, during the `generate-sources` phase, the `antlr4-maven-plugin` will read the `.g4` files and generate the Java source code for the lexer and parser in `target/generated-sources/antlr4/ch/heraldica/`.
    *   The `maven-compiler-plugin` then compiles these generated sources along with any other application code.

**3. Integrate and Run the Parser:**

Once the `mvn clean install` command successfully completes, the generated parser and lexer classes are available for use. You would typically create a main application class (`App.java` or similar) that utilizes these generated components to parse blazon strings.

**Conceptual Example of Usage in Java:**

```java
package ch.heraldica; // Assuming this package structure from your grammar header

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

public class BlazonParserApp {
    public static void main(String[] args) throws Exception {
        String blazonText = "Coupé, au 1 d'azur au lion d'or, au 2 de gueules à la tour d'argent.";

        // 1. Create a CharStream from the input string
        CharStream input = CharStreams.fromString(blazonText);

        // 2. Create a lexer that feeds off the CharStream
        HeraldryVocabulary lexer = new HeraldryVocabulary(input); // Corrected to use HeraldryVocabulary
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // 3. Create a parser that feeds off the tokens
        HeraldryRules parser = new HeraldryRules(tokens);

        // 4. Begin parsing at the 'blason' rule
        ParseTree tree = parser.blason();

        // Print the parse tree (for debugging/demonstration)
        System.out.println(tree.toStringTree(parser));

        // You would typically use a custom Visitor or Listener here to
        // traverse the parse tree and extract structured heraldic data.
        // For example:
        // HeraldryVisitor visitor = new MyHeraldryVisitor();
        // visitor.visit(tree);
    }
}
```