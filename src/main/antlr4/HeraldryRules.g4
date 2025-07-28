// 1. Assurez-vous que le nom de la grammaire correspond à celui utilisé en Java
//    et que ce fichier est enregistré en UTF-8.
grammar HeraldryRules;

// On importe tout le vocabulaire (les mots en MAJUSCULES) depuis un fichier séparé.
import HeraldryVocabulary;

/*
 * =============================================================================
 * RÈGLES DU PARSEUR (Parser Rules) - La structure de la langue
 * =============================================================================
 * Ces règles définissent la "syntaxe" du langage héraldique.
 * Elles sont écrites en minuscule. La règle principale est "blason".
 */

/**
 * @desc Règle racine. Sépare un blason en deux types exclusifs pour lever les ambiguïtés.
 *       Un blason est SOIT une partition complexe, SOIT un champ simple avec des charges.
 */
blason
    // Le corps principal du blason, qui est soit une partition complexe, soit un champ simple avec des charges.
    : ( partition | (email_uni | champ_pattern) (COMMA? charge)* )
      // La partie optionnelle "Sur le tout", qui peut être précédée par une ponctuation.
      ( (DOT | COMMA)? sur_le_tout_charge )?
      // La toute dernière ponctuation optionnelle avant la fin du fichier.
      (DOT)? EOF
    ;

sur_le_tout_charge
    : SUR_LE_TOUT (nombre | article)? description_charge
    ;

/**
 * @desc Le "fond" de l'écu. C'est le concept de "toile de fond" utilisé DANS les descriptions.
 *       C'est cette règle qui permet à un quartier d'être lui-même une partition.
 */
champ
    : email_uni
    | partition
    | champ_pattern
    ;

/**
 * @desc Décrit un champ de couleur ou de fourrure unie.
 * @example "de gueules", "d'hermine", "de gueules plain" (plain = uni)
 */
email_uni
    : DE_PREP email (PLAIN)?
    ;

/**
 * @desc Décrit les divisions géométriques de l'écu. VERSION FINALE ET ROBUSTE.
 */
partition
    // CAS 1: La forme simple. Inchangé.
    : (type_partition DE_PREP email (ET | SUR) (DE_PREP)? email)

    // CAS 2: La forme complexe. C'est ici que la correction a lieu.
    | ((ECARTELE | PARTI) COLON?
        description_quartier
        // CORRECTION : Le groupe de séparateurs est rendu optionnel avec un '?'
        ( (SEMI_COLON | { _input.LT(2).getType() == AU || _input.LT(2).getType() == AUX }? COMMA)?
          description_quartier
        )*
      )

    // CAS 3: La forme de sous-partition. Inchangé.
    | (type_partition (ALPHA_ENUM champ)+)
    ;


/**
 * @desc Décrit un champ non-uni, composé d'un motif répétitif de bandes.
 * @example "fascé d’or et d’azur de huit pièces"
 */
champ_pattern
    : FASCE_PATTERN DE_PREP email ET DE_PREP email DE_PREP nombre PIECE_DESC
    ;

/**
 * @desc Décrit le contenu d'un seul quartier au sein d'une partition complexe.
 *       C'est un "mini-blason" : il a une position, suivi d'un champ complet qui peut
 *       lui-même être une partition (c'est la clé de la récursivité).
 * @example "aux 1 et 4 d’argent à la fasce..."
 * @example "coupé a) fascé d’or et d’azur..."
 */
description_quartier
    : (position_groupee | position_simple) champ (COMMA? charge)*
    ;

/**
 * @desc Une "charge" est tout ce qui est ajouté SUR le champ. C'est le concept central après le champ.
 * @example "au lion d'or", "à trois fasces d'argent"
 */
charge
    : charge_preposition (nombre | article)? description_charge
    ;

/**
 * @desc Le coeur de la grammaire. Décrit un objet et toutes ses modifications, dans un ordre précis:
 *       1. 'objet': De quoi s'agit-il ? (un lion, une fasce)
 *       2. 'email': Quelle est sa couleur principale ? (d'or)
 *       3. 'attribut': Comment est-il ? (couronné, armé, chargé d'un autre objet)
 *       4. 'support': Sur quoi est-il posé ? (sur un mont)
 *       5. 'accompagnement': Qu'y a-t-il à côté ? (accompagné de trois étoiles)
 * @example "lion d'or, armé et lampassé, sur un mont, accompagné de trois étoiles"
 */
description_charge
    : objet
      ( (COMMA | ET)? (attribut | DE_PREP email | support | accompagnement) )*
    ;


/**
 * @desc Décrit un meuble composé, comme un mont avec un nombre défini de sommets.
 * @example "mont de trois coupeaux"
 */
description_meuble
    : DE_PREP nombre COUPEAU
    ;

/**
 * @desc Un attribut qui est lui-même une charge. Décrit un objet posé SUR un autre.
 * @example "chargé d'un coeur de gueules", "sommé d'une couronne d'or"
 */
attribut_complexe
    : (CHARGE | SOMME | ENFILANT) (DE_PREP)? (nombre | article)? objet (DE_PREP email | DU_MEME | DU_PREMIER)?
    ;


/**
 * @desc Le concept général d'attribut. C'est un 'hub' qui redirige vers des types plus spécifiques.
 *       Un attribut peut être:
 *       1. 'qualificatif': Un adjectif simple. Ex: "rampant"
 *       2. 'type_attribut ...': Un adjectif avec une couleur. Ex: "armé de gueules"
 *       3. 'DE_L_UN_A_L_AUTRE': Une couleur alternée qui dépend du fond.
 *       4. 'attribut_complexe': Une sous-charge. Ex: "chargé d'un coeur"
 */
attribut
    : qualificatif
    | type_attribut (ET type_attribut)* DE_PREP email
    | DE_L_UN_A_L_AUTRE
    | attribut_complexe
    ;

/**
 * @desc Un attribut qui ne s'applique qu'à une pièce géométrique, pas à un animal ou une plante.
 * @example "fasce coticée d’argent et de gueules", "chef émanché de trois pièces"
 */
attribut_de_piece
    : (COTICEE DE_PREP email ET DE_PREP email)
    | (EMANCHE DE_PREP nombre PIECE_DESC DE_PREP email)
    | (ECHIQETEE DE_PREP email ET (DE_PREP)? email) // <-- AJOUT
    ;

accompagnement_part
    : (EN_CHEF | EN_POINTE)? DE_PREP nombre objet (DE_PREP email | DU_MEME | DU_PREMIER)?
    ;

/**
 * @desc Décrit des charges secondaires placées "à côté" de la charge principale de manière conventionnelle.
 *       Relation de VOISINAGE.
 * @example "accompagné de trois étoiles"
 */
accompagnement
    : ACCOMPAGNE accompagnement_part (ET accompagnement_part)*
    ;

/**
 * @desc Décrit ce sur quoi la charge principale est posée.
 *       Relation de SUPERPOSITION.
 * @example "sur un mont de trois coupeaux"
 */
support
    : SUR (nombre | article)? objet (DE_PREP email | DU_MEME | DU_PREMIER)?
    ;

/**
 * @desc Décrit un objet qui est une partie d'un autre (souvent un animal).
 * @example "tête d'aigle", "une tête" (seule)
 */
objet_partitif
    : TETE (DE_PREP meuble)?
    ;

/**
 * @desc Définit la position des quartiers décrits quand ils sont groupés.
 * @example "aux 1 et 4"
 */
position_groupee
    : AUX CHIFFRE (ET CHIFFRE)*
    ;

/**
 * @desc Définit la position d'un quartier quand il est seul.
 * @example "au 1", "au 2"
 */
position_simple
    : (AU | AUX) CHIFFRE
    ;


/*
 * =============================================================================
 * RÈGLES "PASSERELLES" (Helpers) - Regroupement du vocabulaire
 * =============================================================================
 * Ces règles ne créent pas de nouveaux concepts, elles regroupent les tokens
 * du vocabulaire (Lexer) en catégories logiques pour simplifier les règles ci-dessus.
 */

// Un émail est soit un métal, soit une couleur, soit une fourrure.
email    : metal | couleur | fourrure;
metal    : OR | ARGENT;
couleur  : GUEULES | AZUR | SABLE | SINOPLE;
fourrure : HERMINE | VAIR;

// Un objet est soit une pièce géométrique (piece), soit un objet figuratif (meuble), soit une partie d'objet.
objet
    : piece (attribut_de_piece)?
    | meuble (description_meuble)?
    | objet_partitif
    | meuble_compose
    ;

// Les nombres cardinaux utilisés.
nombre : UN | DEUX | TROIS | QUATRE | CINQ | SIX | HUIT;

// Les types de divisions de l'écu.
type_partition    : PARTI | COUPE | TRANCHE | TAILLE | ECARTELE | PALE | GIRONNE | REPARTI (EMMANCHE)?;

// Les pièces "honorables" : formes géométriques de base.
piece             : FASCE | PAL | BANDE | BARRE| SAUTOIR | CHEF | CHEVRON | BORDURE | CROIX;

// Les "meubles" : objets, animaux, plantes, etc.
meuble            : LICORNE | LION | AIGLE | FLEUR_DE_LYS | TOUR | LETTRE | ETOILE | GLAND | MONT | COEUR | MARQUE_DE_MAISON | BESANT | ECUSSON | BELIER | COURONNE;

// Les attributs simples qui prennent une couleur.
type_attribut     : ARME | LAMPASSE | COURONNE | BECQUE | LANGUE;

// Les qualificatifs : adjectifs simples qui décrivent une posture ou un état.
qualificatif      : RAMPANT | PASSANT | ENTRELACE | POSEE (EN_PAL)? | NAISSANT | OVALE;

// Les positions nommées des quartiers (pour les écartelés simples).
position_quartier : AU_PREMIER | AU_DEUXIEME | AU_TROISIEME | AU_QUATRIEME;

meuble_compose
    : CROSSE EPISCOPALE
    ;

// Prépositions et articles courants.
DE_PREP            : DE | D_APOSTROPHE;
charge_preposition : A_PREP | AU | A_LA | AUX;
article            : LE | LA | LES;