
grammar HeraldryRules;

@header {
package ch.heraldica;
}

import HeraldryVocabulary;

blason:
  simple |
  partition
;

simple:
  champ (AU_A_LA meuble_desc)?
;

partition:
    coupe
;

coupe:
    COUPE COMMA? simple COMMA? ET simple (COMMA AU_A_LA meuble_desc DE_L_UN_A_L_AUTRE)?
;

meuble_desc: 
    charge position? (DE_PREP couleur)? (action UN_E charge (DE_PREP couleur | DU_MEME)?)?
;

champ:
  DE_PREP (email | metal)
;

metal   : OR | ARGENT;
email  : AZUR | GUEULES | SABLE | SINOPLE | POURPRE;
fourrure : HERMINE | VAIR;
couleur : metal | email | fourrure;
position : RAMPANT|PASSANT|ISSANT|ARME|LAMPASSE;
action : TENANT;


meuble : LION | CHEVRON | COUPE_M;
piece : FASCE  |
        PAL    |
        BANDE  |
        BARRE  |
        SAUTOIR|
        CHEF   |
        CHEVRON|
        BORDURE|
        CROIX  ;

charge : meuble | piece;