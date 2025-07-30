lexer grammar HeraldryVocabulary;

// Prépositions, conjonctions et articles.
DE_PREP      : [Dd] ('e' | '\'' | '’');
ET           : [Ee] 't';
UN_E         : [Uu] 'n' | [Uu] 'ne';
AU           : [Aa] 'u';
A            : [Àà];
LA           : 'la'; // Make 'la' its own token for 'à la'
COMMA        : ',';
LPAREN       : '(';
RPAREN       : ')';

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
TRANCHE      : [Tt] 'ranché';
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
FERS_DE_LANCE : [Ff] 'ers' WS 'de' WS 'lance';  // Added spear points
LION         : [Ll] 'ion';
COUPE_M      : [Cc] 'oupe';
ETOILE       : [EeÉé] 'toile' [sS]?;

// 5. Nombres
DEUX         : [Dd] 'eux';
TROIS        : [Tt] 'rois';
QUATRE       : [Qq] 'uatre';
CHIFFRE      : [1-9][0-9]*;

// 6a. positions
RAMPANT      : [Rr] 'ampant';
PASSANT      : [Pp] 'assant';
ISSANT       : [Ii] 'ssant';
ARME         : [Aa] 'rmé';
LAMPASSE     : [Ll] 'ampassé';
POSE_EN_BANDE : [Pp] 'osé' ('e' 's'? | 's')? WS 'en' WS 'bande';

// 6b. actions
TENANT       : [Tt] 'enant';

// Expression complexe traitée comme un seul token
DE_L_UN_A_L_AUTRE : [Dd] 'e' WS ( 'l\'' | 'l’' ) 'un' WS 'à' WS ( 'l\'' | 'l’' ) 'autre';
DU_MEME      : [Dd] 'u' WS 'même';

WS : [ \t\r\n]+ -> skip;