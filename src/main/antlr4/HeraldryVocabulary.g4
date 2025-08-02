lexer grammar HeraldryVocabulary;

DE_PREP
   : [Dd] ('e' | '\'' | '’')
   ;

ET
   : [Ee] 't'
   ;

UN_E
   : [Uu] 'n'
   | [Uu] 'ne'
   ;

AU
   : [Aa] 'u'
   ;

A
   : [Àà]
   ;

AUX
   : [Aa] 'ux'
   ;

LA
   : 'la'
   ;

COMMA
   : ','
   ;

LPAREN
   : '('
   ;

RPAREN
   : ')'
   ;

DOT
   : '.'
   ;

SEMICOLON
   : ';'
   ;

COLON
   : ':'
   ;
   // 1a. Émaux
   
AZUR
   : [Aa] 'zur'
   ;

GUEULES
   : [Gg] 'ueules'
   ;

SABLE
   : [Ss] 'able'
   ;

SINOPLE
   : [Ss] 'inople'
   ;

POURPRE
   : [Pp] 'ourpre'
   ;
   // 1b. metaux
   
OR
   : [Oo] 'r'
   ;

ARGENT
   : [Aa] 'rgent'
   ;
   // 1c. fourrures
   
HERMINE
   : [Hh] 'ermine'
   ;

VAIR
   : [Vv] 'air'
   ;
   // 2. Partitions
   
PARTI
   : [Pp] 'arti'
   ;

COUPE
   : [Cc] 'oupé'
   ;

TRANCHE
   : [Tt] 'ranché'
   ;

TAILLE
   : [Tt] 'aillé'
   ;

ECARTELE
   : [Éé] 'cartelé'
   ;

PALE
   : [Pp] 'alé'
   ;

GIRONNE
   : [Gg] 'ironné'
   ;
   // 3. Pièces (formes géométriques)
   
FASCE
   : [Ff] 'asce'
   ;

PAL
   : [Pp] 'al'
   ;

VERGETTE
   : [Vv] 'ergette' [Ss]?
   ;

BANDE
   : [Bb] 'ande' [sS]?
   ;

BARRE
   : [Bb] 'arre'
   ;

SAUTOIR
   : [Ss] 'autoir'
   ;

CHEF
   : [Cc] 'hef'
   ;

CHEVRON
   : [Cc] 'hevron'
   ;

BORDURE
   : [Bb] 'ordure'
   ;

CROIX
   : [Cc] 'roix'
   ;
   // 4. Meubles (objets - les mots composés en premier)
   
CROISETTE
   : [Cc] 'roisette' [sS]?
   ;

COEUR
   : [Cc] 'oeur'
   | [Cc] 'œur'
   ;

FERS_DE_LANCE
   : [Ff] 'er' [sS]? WS 'de' WS 'lance'
   ;

CROSSE_EPISCOPALE
   : ('crosse' WS 'épiscopale')
   | ('crosses' WS 'épiscopale')
   ;

COURONNE
   : [Cc] 'ouronne' [sS]?
   ;

BESANT
   : [Bb] 'esant' [sS]?
   ;

LION
   : [Ll] 'ion' [sS]?
   ;

COUPE_M
   : [Cc] 'oupe' [sS]?
   ;

ETOILE
   : [EeÉé] 'toile' [sS]?
   ;

TOUR
   : [Tt] 'our' [sS]?
   ;

MONTAGNE
   : [Mm] 'ontagne' [sS]?
   ;

COUPEAU
   : [Cc] 'oupeau' [xX]?
   ;

ARC_EN_CIEL
   : [Aa] 'rc-en-ciel'
   ;

POINTE
   : [Pp] 'ointe' [sS]?
   ;
   // 5. Nombres
   
DEUX
   : [Dd] 'eux'
   ;

TROIS
   : [Tt] 'rois'
   ;

QUATRE
   : [Qq] 'uatre'
   ;

CINQ
   : [Cc] 'inq'
   ;

CHIFFRE
   : [1-9] [0-9]*
   ;
   // 6a. positions
   
RAMPANT
   : [Rr] 'ampant'
   ;

PASSANT
   : [Pp] 'assant'
   ;

ISSANT
   : [Ii] 'ssant'
   ;

ARME
   : [Aa] 'rmé'
   ;

LAMPASSE
   : [Ll] 'ampassé'
   ;

POSE_EN_BANDE
   : [Pp] 'osé' ('e' 's'? | 's')? WS 'en' WS 'bande'
   ;

MOUVANT
   : [Mm] 'ouvant'
   ;

POSE
   : [Pp] 'osé' ('e' | 's' | 'es')?
   ;

SUR
   : [Ss] 'ur'
   ;

ENTRE
   : [Ee] 'ntre'
   ;

ECHIQUE_TE
   : [EeÉé] 'chiquetée' ('e' | 's' | 'es')?
   ;

POSE_EN_PAL
   : [Pp] 'osé' ('e' | 's' | 'es')? WS 'en' WS [Pp] 'al'
   ;

EN_CHEF_POS
   : [Ee] 'n' WS [Cc] 'hef'
   ;

EN_POINTE_POS
   : [Ee] 'n' WS [Pp] 'ointe'
   ;
   // 6b. actions
   
TENANT
   : [Tt] 'enant'
   ;

ENFILANT
   : [Ee] 'nfilant' ('e' | 's' | 'es')?
   ;

ACCOMPAGNE
   : [Aa] 'ccompagné' ('e' | 's' | 'es')?
   ;
   // Expression complexe traitée comme un seul token
   
DE_L_UN_A_L_AUTRE
   : [Dd] 'e' WS ('l\'' | 'l’') 'un' WS 'à' WS ('l\'' | 'l’') 'autre'
   ;

DU_MEME
   : [Dd] 'u' WS 'même'
   ;

WS
   : [ \t\r\n]+ -> skip
   ;

