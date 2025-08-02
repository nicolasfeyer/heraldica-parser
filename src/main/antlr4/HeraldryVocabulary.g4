lexer grammar HeraldryVocabulary;

import Placement , Attribute , Piece , Meuble , Couleur , Partition;
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

SUR
   : [Ss] 'ur'
   ;

ENTRE
   : [Ee] 'ntre'
   ;

TENANT
   : [Tt] 'enant'
   ;

DE_L_UN_A_L_AUTRE
   : [Dd] 'e' WS ('l\'' | 'l’') 'un' WS 'à' WS ('l\'' | 'l’') 'autre'
   ;

DU_MEME
   : [Dd] 'u' WS 'même'
   ;

PLEIN
   : 'plein'
   ;

WS
   : [ \t\r\n]+ -> skip
   ;

