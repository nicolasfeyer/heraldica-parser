
grammar HeraldryRules;

@header {
package ch.heraldica;
}

import HeraldryVocabulary;

/**
 * Règle racine du blason français.
 * 
 * Reflète la distinction fondamentale en héraldique française entre :
 * - Blason simple : un champ uni avec des charges (ex: "D'azur au lion d'or")
 * - Blason partitionné : l'écu est divisé géométriquement (ex: "Parti d'or et de gueules")
 * 
 * Cette dualité structurelle correspond aux deux grandes familles de composition
 * héraldique : la simplicité noble du champ uni versus la complexité géométrique
 * des partitions qui permettent de combiner plusieurs armoiries.
 */
blason
    : blason_avec_partition EOF
    | blason_simple EOF
    ;

/**
 * Blason avec partition géométrique.
 * 
 * Les partitions sont les divisions géométriques de l'écu qui permettent
 * de combiner plusieurs champs ou d'intégrer des armoiries d'alliance.
 * Une conclusion optionnelle peut ajouter un "sur le tout" qui domine
 * l'ensemble du blason.
 */
blason_avec_partition
    : partition conclusion_blason?
    ;

/**
 * Blason sur champ unique.
 * 
 * Structure classique : champ (couleur/motif de fond) + charges optionnelles.
 * Cette forme respecte la hiérarchie descriptive française :
 * 1. Description du champ (obligatoire)
 * 2. Énumération des charges (facultative, séparées par des virgules)
 * 3. Conclusion spéciale optionnelle (sur le tout)
 * 
 * Exemple : "D'azur au lion d'or, accompagné de trois étoiles d'argent"
 */
blason_simple  
    : (email_uni | champ_pattern) (COMMA? charge)* conclusion_blason?
    ;

/**
 * Conclusion du blason.
 * 
 * Gère deux cas spéciaux de fin de description :
 * 1. "Sur le tout" : petit écu central qui se superpose à l'ensemble
 *    (marque d'alliance, héritage ou dignité spéciale)
 * 2. Point final simple pour terminer la description
 * 
 * Le "sur le tout" est l'expression la plus noble - il "domine" littéralement
 * le reste du blason avec une autorité visuelle et symbolique particulière.
 */
conclusion_blason
     : (DOT | COMMA)? sur_le_tout_charge (DOT)?
     | DOT
     ;

/**
 * Charge "sur le tout".
 * 
 * Le "sur le tout" est un petit écu central qui se superpose à tout le blason.
 * C'est l'expression la plus prestigieuse de l'héraldique française :
 * - Marque d'alliance matrimoniale
 * - Héritage de dignité particulière  
 * - Signe de souveraineté ou de fonction
 * 
 * Il peut être précédé d'un nombre/article pour sa propre description.
 */
sur_le_tout_charge
    : SUR_LE_TOUT (nombre | article)? description_charge
    ;

/**
 * Définition générale d'un champ héraldique.
 * 
 * Un champ peut être :
 * - Email uni : couleur, métal ou fourrure pure
 * - Partition : division géométrique de l'écu
 * - Pattern : motif répétitif (fascé, palé, etc.)
 * 
 * Cette règle unifie les différents types de fonds possibles.
 */
champ
    : email_uni
    | partition
    | champ_pattern
    ;

/**
 * Email uniforme (couleur pure).
 * 
 * Forme canonique : "De [préposition] [email] [plain optionnel]"
 * Exemples : "d'or", "de gueules", "d'azur plain"
 * 
 * Le "plain" optionnel insiste sur l'uniformité du champ,
 * souvent utilisé pour clarifier l'absence de motifs.
 */
email_uni
    : DE_PREP email (PLAIN)?
    ;

/**
 * Partitions de l'écu.
 * 
 * Gère les trois grandes familles de divisions géométriques :
 * 
 * 1. Partitions binaires simples : "parti de gueules et d'or"
 *    - Divisent l'écu en deux parties avec la syntaxe "DE email ET/SUR email"
 *    - "ET" pour les divisions symétriques, "SUR" pour les superpositions
 * 
 * 2. Écartelé (4 quartiers) et Parti complexe : avec numérotation spécifique
 *    - Écartelé : virgules entre quartiers, numérotation 1-4 (diagonal)
 *    - Parti : points-virgules entre parties
 * 
 * 3. Partitions complexes : énumération alphabétique a), b), c)...
 *    - Pour les divisions multiples ou irrégulières
 */
partition
    : type_partition DE_PREP email (ET | SUR) (DE_PREP)? email
    
    | ECARTELE COLON? quartiers_ecartele
    | PARTI COLON? quartiers_parti
    
    | type_partition (ALPHA_ENUM champ)+
    ;

/**
 * Quartiers d'un écartelé.
 * 
 * L'écartelé divise l'écu en 4 quartiers numérotés :
 * 1 (haut-gauche) | 2 (haut-droite)
 * 3 (bas-gauche)  | 4 (bas-droite)
 * 
 * Ponctuation traditionnelle : virgules entre les quartiers.
 * Les quartiers 1&4 et 2&3 sont souvent groupés (diagonalement opposés).
 */
quartiers_ecartele
    : description_quartier (COMMA description_quartier)*
    ;

/**
 * Parties d'un parti complexe.
 * 
 * Partition verticale avec plusieurs subdivisions possibles.
 * Ponctuation traditionnelle française : points-virgules entre les parties
 * (distinction claire avec les virgules de l'écartelé).
 */
quartiers_parti
    : description_quartier (SEMI_COLON description_quartier)*
    ;

/**
 * Motif répétitif sur le champ.
 * 
 * Gère les patterns géométriques comme "fascé de gueules et d'or de huit pièces".
 * Structure : PATTERN + de + couleur1 + et + de + couleur2 + de + nombre + pièces
 * 
 * Ces motifs alternent régulièrement deux émaux selon une géométrie fixe.
 */
champ_pattern
    : FASCE_PATTERN DE_PREP email ET DE_PREP email DE_PREP nombre PIECE_DESC
    ;

/**
 * Description d'un quartier ou d'une partie.
 * 
 * Structure complète d'une section de l'écu partitionné :
 * 1. Position (au 1er, aux 2 et 3, etc.) - optionnelle si implicite
 * 2. Champ (fond de cette section)
 * 3. Charges optionnelles (objets posés sur ce champ)
 * 
 * Cette règle encapsule la logique récursive : chaque quartier
 * peut être décrit comme un mini-blason complet.
 */
description_quartier
    : (position_groupee | position_simple) champ (COMMA? charge)*
    ;

/**
 * Charge héraldique (objet posé sur le champ).
 * 
 * Structure canonique française :
 * 1. Préposition obligatoire ("à", "au", "aux") - marque grammaticale
 * 2. Nombre/Article optionnel ("trois", "une", "le")  
 * 3. Description de l'objet (avec tous ses attributs)
 * 
 * Cette hiérarchie respecte la syntaxe française traditionnelle
 * et permet une description précise et non-ambiguë.
 */
charge
    : charge_preposition (nombre | article)? description_charge
    ;

/**
 * Description complète d'un objet héraldique.
 * 
 * Hiérarchie descriptive française (du général au particulier) :
 * 1. Objet principal (obligatoire) : lion, fasce, étoile...
 * 2. Attributs multiples (optionnels) :
 *    - Qualités intrinsèques (rampant, passant...)
 *    - Couleurs spécifiques (armé de..., lampassé de...)
 *    - Support (sur un mont...)
 *    - Accompagnement (accompagné de...)
 * 
 * Cette structure respecte l'ordre logique de perception visuelle.
 */
description_charge
    : objet
      ( (COMMA | ET)? (attribut | DE_PREP email | support | accompagnement) )*
    ;

/**
 * Description d'un meuble complexe.
 * 
 * Gère les compléments descriptifs spécifiques à certains meubles,
 * comme "mont de trois coupeaux" où "coupeaux" précise la forme du mont.
 */
description_meuble
    : DE_PREP nombre COUPEAU
    ;

/**
 * Attribut complexe avec objet incorporé.
 * 
 * Expressions sophistiquées qui intègrent un objet dans l'attribut :
 * - "chargé de trois étoiles" (objet porte d'autres objets)
 * - "sommé d'une couronne" (objet surmonté d'un autre)
 * - "enfilant une bague" (objet traverse un autre)
 * 
 * Ces constructions permettent de décrire des compositions élaborées
 * tout en gardant la hiérarchie grammaticale claire.
 */
attribut_complexe
    : (CHARGE | SOMME | ENFILANT) (DE_PREP)? (nombre | article)? objet (DE_PREP email | DU_MEME | DU_PREMIER)?
    ;

/**
 * Attributs descriptifs d'un objet.
 * 
 * Quatre catégories d'attributs :
 * 1. Qualificatifs simples : "rampant", "passant", "naissant"...
 * 2. Attributs colorés : "armé et lampassé de gueules" (parties colorées différemment)
 * 3. Alternance coloriste : "de l'un à l'autre" (utilise les couleurs du champ)
 * 4. Attributs complexes : avec objets incorporés
 * 
 * Cette diversité permet une description précise de tous les détails visuels.
 */
attribut
    : qualificatif
    | type_attribut (ET type_attribut)* DE_PREP email
    | DE_L_UN_A_L_AUTRE
    | attribut_complexe
    ;

/**
 * Attributs spécifiques aux pièces géométriques.
 * 
 * Les pièces (formes géométriques) ont leurs propres modifications :
 * - "coticée" : bordée de bandes étroites alternées
 * - "émanchée" : bord découpé en créneaux
 * - "échiquetée" : à motif d'échiquier
 * 
 * Ces attributs modifient l'apparence des contours ou des surfaces.
 */
attribut_de_piece
    : (COTICEE DE_PREP email ET DE_PREP email)
    | (EMANCHE DE_PREP nombre PIECE_DESC DE_PREP email)
    | (ECHIQETEE DE_PREP email ET (DE_PREP)? email)
    ;

/**
 * Partie d'un accompagnement.
 * 
 * Décrit un groupe d'objets accompagnants avec :
 * - Position optionnelle : "en chef" (haut), "en pointe" (bas)
 * - Nombre et type d'objets
 * - Couleur : spécifique, "du même" (que l'objet principal), "du premier" (que le champ)
 * 
 * Cette structure permet de placer précisément les objets secondaires.
 */
accompagnement_part
    : (EN_CHEF | EN_POINTE)? DE_PREP nombre objet (DE_PREP email | DU_MEME | DU_PREMIER)?
    ;

/**
 * Accompagnement complet.
 * 
 * "Accompagné" introduit les objets secondaires qui entourent l'objet principal.
 * Plusieurs groupes peuvent être spécifiés avec "et" :
 * "accompagné en chef de deux étoiles et en pointe d'un croissant"
 * 
 * Cette règle gère la complexité des compositions à plusieurs niveaux.
 */
accompagnement
    : ACCOMPAGNE accompagnement_part (ET accompagnement_part)*
    ;

/**
 * Support d'un objet.
 * 
 * "Sur" indique que l'objet principal repose sur un autre objet :
 * "lion sur un mont", "aigle sur une branche"...
 * 
 * Le support peut avoir sa propre couleur ou reprendre celle
 * de l'objet principal ou du champ (du même, du premier).
 */
support
    : SUR (nombre | article)? objet (DE_PREP email | DU_MEME | DU_PREMIER)?
    ;

/**
 * Objet partitif (partie d'un objet).
 * 
 * Permet de ne représenter qu'une partie d'un meuble :
 * "tête de lion", "tête d'aigle"...
 * 
 * Cette règle capture les représentations partielles,
 * courantes quand l'espace est limité ou pour des raisons esthétiques.
 */
objet_partitif
    : TETE (DE_PREP meuble)?
    ;

/**
 * Position groupée (plusieurs quartiers).
 * 
 * "Aux 1 et 4", "aux 2 et 3"...
 * Utilisé dans les écartelés pour désigner plusieurs quartiers
 * qui portent la même description.
 * 
 * Souvent les quartiers diagonalement opposés (1&4, 2&3)
 * pour créer une symétrie visuelle harmonieuse.
 */
position_groupee
    : AUX CHIFFRE (ET CHIFFRE)*
    ;

/**
 * Position simple (un seul quartier).
 * 
 * "Au 1er", "au 2e"...
 * Désigne un quartier unique dans une partition.
 */
position_simple
    : AU CHIFFRE
    ;

/**
 * Émaux - la classification fondamentale de l'héraldique.
 * 
 * Cette règle respecte parfaitement la règle d'or héraldique :
 * - Métaux (or, argent) = tons clairs, représentent la noblesse
 * - Couleurs (gueules, azur, sable, sinople) = tons foncés, représentent les vertus
 * - Fourrures (hermine, vair) = catégorie spéciale, noblesse et dignité
 * 
 * RÈGLE FONDAMENTALE : On ne pose jamais couleur sur couleur,
 * ni métal sur métal (contraste obligatoire pour la lisibilité).
 */
email    : metal | couleur | fourrure;

/**
 * Métaux héraldiques.
 * 
 * OR et ARGENT - les deux métaux nobles.
 * Représentent traditionnellement :
 * - Or : richesse, générosité, éclat du soleil
 * - Argent : pureté, sincérité, éclat de la lune
 */
metal    : OR | ARGENT;

/**
 * Couleurs héraldiques.
 * 
 * Les quatre couleurs principales :
 * - Gueules (rouge) : courage, ardeur au combat
 * - Azur (bleu) : loyauté, justice, beauté du ciel
 * - Sable (noir) : sagesse, constance, affliction
 * - Sinople (vert) : espoir, joie, abondance de la nature
 */
couleur  : GUEULES | AZUR | SABLE | SINOPLE;

/**
 * Fourrures héraldiques.
 * 
 * Catégorie spéciale issue des fourrures d'apparat :
 * - Hermine : pureté, souveraineté (mouchetures noires sur blanc)
 * - Vair : alternance de cloches bleues et blanches
 * 
 * Ces émaux marquent souvent la haute noblesse.
 */
fourrure : HERMINE | VAIR;

/**
 * Objets héraldiques généraux.
 * 
 * Classification complète des éléments représentables :
 * - Pièces : formes géométriques (fasce, pal, chevron...) - "architecture" du blason
 * - Meubles : objets figuratifs (lion, aigle, tour...) - "décoration" du blason  
 * - Objets partitifs : parties d'objets (tête d'aigle...)
 * - Meubles composés : objets complexes (crosse épiscopale...)
 * 
 * Cette hiérarchie respecte la tradition héraldique française.
 */
objet
    : piece (attribut_de_piece)?
    | meuble (description_meuble)?
    | objet_partitif
    | meuble_compose
    ;

/**
 * Nombres héraldiques.
 * 
 * Limités aux nombres couramment utilisés en héraldique.
 * Au-delà de huit, on utilise souvent "plusieurs" ou "semé de"
 * (pour éviter l'encombrement visuel).
 */
nombre : UN | DEUX | TROIS | QUATRE | CINQ | SIX | HUIT;

/**
 * Types de partitions géométriques.
 * 
 * Les grands modes de division de l'écu :
 * - PARTI : division verticale
 * - COUPÉ : division horizontale  
 * - TRANCHÉ/TAILLÉ : divisions diagonales
 * - ÉCARTELÉ : division en quatre quartiers
 * - PALÉ/GIRONNÉ : divisions multiples radiales
 * - REPARTI : redivision d'une partie
 * 
 * Chaque type crée une géométrie spécifique avec ses règles propres.
 */
type_partition    : PARTI | COUPE | TRANCHE | TAILLE | ECARTELE | PALE | GIRONNE | REPARTI (EMMANCHE)?;

/**
 * Pièces héraldiques (formes géométriques).
 * 
 * Les éléments architecturaux du blason :
 * - FASCE : bande horizontale
 * - PAL : bande verticale
 * - BANDE : diagonale ↗
 * - BARRE : diagonale ↖  
 * - CHEVRON : angle vers le haut ∧
 * - CHEF : bande en haut de l'écu
 * - BORDURE : cadre intérieur
 * - CROIX/SAUTOIR : croix droite/diagonale
 * 
 * Ces formes structurent l'espace héraldique selon des proportions codifiées.
 */
piece             : FASCE | PAL | BANDE | BARRE| SAUTOIR | CHEF | CHEVRON | BORDURE | CROIX;

/**
 * Meubles héraldiques (objets figuratifs).
 * 
 * Les éléments décoratifs représentant :
 * - Animaux : lion, aigle, licorne... (force, noblesse)
 * - Végétaux : fleur de lys, gland... (beauté, fertilité)
 * - Objets : tour, couronne, étoile... (pouvoir, dignité)
 * - Symboles : cœur, lettre... (sentiment, identité)
 * 
 * Chaque meuble porte sa symbolique traditionnelle.
 */
meuble            : LICORNE | LION | AIGLE | FLEUR_DE_LYS | TOUR | LETTRE | ETOILE | GLAND | MONT | COEUR | MARQUE_DE_MAISON | BESANT | ECUSSON | BELIER | COURONNE;

/**
 * Types d'attributs spécialisés.
 * 
 * Qualificatifs pour certaines parties spécifiques des meubles :
 * - ARMÉ : griffes, cornes (couleur des armes naturelles)
 * - LAMPASSÉ : langue (couleur de la langue)
 * - BECQUÉ : bec (couleur du bec des oiseaux)
 * - LANGUÉ : langue (variante de lampassé)
 * - COURONNÉ : portant une couronne
 * 
 * Ces détails permettent une description précise des couleurs partielles.
 */
type_attribut     : ARME | LAMPASSE | COURONNE | BECQUE | LANGUE;

/**
 * Qualificatifs de position et d'attitude.
 * 
 * Décrivent la posture et l'orientation des meubles :
 * - RAMPANT : lion dressé sur pattes arrière (attitude de combat)
 * - PASSANT : animal marchant de profil (attitude de paix)
 * - NAISSANT : qui émerge du bas de l'écu
 * - POSÉ : simplement posé (attitude neutre)
 * - ENTRELACÉ : entremêlé avec d'autres objets
 * 
 * Ces qualificatifs donnent vie et mouvement aux figures.
 */
qualificatif      : RAMPANT | PASSANT | ENTRELACE | POSEE (EN_PAL)? | NAISSANT | OVALE;

/**
 * Positions dans les quartiers.
 * 
 * Numérotation traditionnelle des quartiers d'un écartelé :
 * 1er (haut-gauche) - 2e (haut-droite) - 3e (bas-gauche) - 4e (bas-droite)
 * 
 * Cette numérotation suit le sens de lecture héraldique.
 */
position_quartier : AU_PREMIER | AU_DEUXIEME | AU_TROISIEME | AU_QUATRIEME;

/**
 * Meubles composés (objets complexes).
 * 
 * Objets formés de plusieurs éléments indissociables :
 * "crosse épiscopale" (insigne d'évêque)
 * 
 * Ces meubles représentent des dignités ou fonctions spécifiques.
 */
meuble_compose
    : CROSSE EPISCOPALE
    ;

/**
 * Prépositions "de" avec ses variantes.
 * 
 * Gère l'élision française : "de" devient "d'" devant voyelle.
 * Cette règle respecte parfaitement la grammaire française
 * dans le contexte héraldique spécialisé.
 */
DE_PREP            : DE | D_APOSTROPHE;

/**
 * Prépositions pour introduire les charges.
 * 
 * Prépositions obligatoires qui introduient grammaticalement les objets :
 * - À : "d'azur à trois fleurs de lys"
 * - AU : "d'or au lion" (contraction de à + le)
 * - À LA : "de gueules à la fasce"
 * - AUX : "d'argent aux trois étoiles" (contraction de à + les)
 * 
 * Cette variété respecte les accords grammaticaux français.
 */
charge_preposition : A_PREP | AU | A_LA | AUX;

/**
 * Articles définis français.
 * 
 * LE, LA, LES - utilisés pour désigner des objets spécifiques
 * ou des éléments déjà mentionnés dans la description.
 */
article            : LE | LA | LES;