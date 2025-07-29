lexer grammar HeraldryVocabulary;

// Prépositions, conjonctions et articles.
DE_PREP      : [Dd] 'e' | [Dd] ('\'' | '’');
ET           : [Ee] 't';
UN_E         : [Uu] 'n' | [Uu] 'ne';
A_PREP       : [Àà];
AU_PREMIER   : 'au premier' | 'au 1er';
AU_DEUXIEME  : 'au deuxième' | 'au 2d' | 'au 2e';
AU_TROISIEME : 'au troisième' | 'au 3e';
AU_QUATRIEME : 'au quatrième' | 'au 4e';
AU_A_LA           : [Aa] 'u' | [Àà] WS 'la';
AUX          : [Aa] 'ux';
LE           : [Ll] 'e';
LA           : [Ll] 'a';
LES          : [Ll] 'es';
COMMA        : ',';
COLON        : ':';
SEMI_COLON   : ';';

// --- VOCABULAIRE HÉRALDIQUE ---

// 1a. Émaux
AZUR         : [Aa] 'zur';
GUEULES      : [Gg] 'ueules';
SABLE        : [Ss] 'able';
SINOPLE      : [Ss] 'inople';
POURPRE      : [Pp] 'ourpre';

// 1b. metaux
OR           : [Oo] 'r';
ARGENT       : [Aa] 'rgent';

// 1c. fourrures
HERMINE      : [Hh] 'ermine';
VAIR         : [Vv] 'air';

// 2. Partitions
PARTI        : [Pp] 'arti';
COUPE        : [Cc] 'oupé';
TRANCHE      : [Tr] 'anché';
TAILLE       : [Tt] 'aillé';
ECARTELE     : [Éé] 'cartelé';
PALE         : [Pp] 'alé';
GIRONNE      : [Gg] 'ironné';

// 3. Pièces (formes géométriques)
FASCE        : [Ff] 'asce';
PAL          : [Pp] 'al';
BANDE        : [Bb] 'ande' [sS]?;
BARRE        : [Bb] 'arre';
SAUTOIR      : [Ss] 'autoir';
CHEF         : [Cc] 'hef';
CHEVRON      : [Cc] 'hevron';
BORDURE      : [Bb] 'ordure';
CROIX        : [Cc] 'roix';

// 4. Meubles (objets - les mots composés en premier)
FLEUR_DE_LYS : 'fleur de lys';
MARQUE_DE_MAISON : [Mm] 'arque' WS 'de' WS 'maison';
LION         : [Ll] 'ion';
AIGLE        : [Aa] 'igle';
TOUR         : [Tt] 'our';
LETTRE       : [Ll] 'ettre' [sS]?;
ETOILE       : [Éé] 'toile' [sS]?;
GLAND        : [Gg] 'land';
MONT         : [Mm] 'ont';
COEUR        : [Cc] 'oeur' [sS]? | [Cc] 'œur' [sS]?;
TETE         : [Tt] 'ête' [sS]?;
LICORNE      : [Ll] 'icorne';
CROSSE       : [Cc] 'rosse';
EPISCOPALE   : [Éé] 'piscopale';
BESANT       : [Bb] 'esant' [sS]?;
ECUSSON      : [Éé] 'cusson';
BELIER       : [Bb] 'élier';
COUPE_M      : [Cc] 'oupe';

// 5. Nombres
CHIFFRE      : [1-9]; // Uniquement les chiffres de 1 à 9 pour les quartiers
UN           : [Uu] 'n' | [Uu] 'ne';
DEUX         : [Dd] 'eux';
TROIS        : [Tt] 'rois';
QUATRE       : [Qq] 'uatre';
CINQ         : [Cc] 'inq';
SIX          : [Ss] 'ix';
SEPT         : [Ss] 'ept';
HUIT         : [Hh] 'uit';

// 6. Attributs, positions et expressions spécifiques
RAMPANT      : [Rr] 'ampant';
PASSANT      : [Pp] 'assant';
ISSANT       : [Ii] 'ssant';
ARME         : [Aa] 'rmé';
LAMPASSE     : [Ll] 'ampassé';

TENANT        :[Tt] 'enant';


COURONNE     : [Cc] 'ouronn' ('é' | 'ée' | 'e' | 'ées');
ENTRELACE    : [Ee] 'ntrelacé' [sS]?;
ACCOMPAGNE   : [Aa] 'ccompagné';
DU_PREMIER   : [Dd] 'u' WS 'premier';
EN_POINTE    : [Ee] 'n' WS 'pointe';
COUPEAU      : [Cc] 'oupeau' ([xX])?;
CHARGE       : [Cc] 'hargé';
SOMME        : [Ss] 'ommé';
BECQUE       : [Bb] 'ecqué' [eE]?[sS]?;
LANGUE       : [Ll] 'angué' [eE]?[sS]?;
SUR          : [Ss] 'ur';
COTICEE      : [Cc] 'oticée';
EMANCHE      : [Éé] 'manché';
PIECE_DESC   : [Pp] 'ièce' [sS]?;
REPARTI      : [Rr] 'eparti';
EMMANCHE     : [Ee] 'mmanché';
FASCE_PATTERN: [Ff] 'ascé'; // Nom différent de FASCE (pièce) pour éviter conflit
PLAIN        : [Pp] 'lain';
ALPHA_ENUM   : [a-z] ')'; // Reconnaît a), b), c), etc.
POSEE        : [Pp] 'osée';
EN_PAL       : [Ee] 'n' WS 'pal';
ENFILANT     : [Ee] 'nfilant';
ECHIQETEE    : [Éé] 'chiqueté' [eE]?;
EN_CHEF      : [Ee] 'n' WS 'chef';
NAISSANT     : [Nn] 'aissant';
OVALE        : [Oo] 'vale';
// Ajout de l'expression la plus importante
SUR_LE_TOUT  : [Ss] 'ur' WS 'le' WS 'tout';
// Ajout de la ponctuation finale
DOT          : '.';

// Règle spéciale pour ignorer les noms entre parenthèses
NOMENCLATURE : '(' [a-zA-Zà-üÀ-Ü \t]+ ')' -> skip;

// Expression complexe traitée comme un seul token
DE_L_UN_A_L_AUTRE : [Dd] 'e' WS ( 'l\'' | 'l’' ) 'un' WS 'à' WS ( 'l\'' | 'l’' ) 'autre';
DU_MEME      : [Dd] 'u' WS 'même';

// Ignorer les espaces, tabulations et retours à la ligne entre les tokens.
WS : [ \t\r\n]+ -> skip;