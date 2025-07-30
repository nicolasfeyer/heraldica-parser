grammar HeraldryRules;

@header {
package ch.heraldica;
}

import HeraldryVocabulary;

// --- PARSER RULES ---

blason:
  (partitioned_blason | simple_blason) EOF;

partitioned_blason:
  partition_type (quartered_partition_body | binary_partition_body);

quartered_partition_body:
  COMMA? numbered_field (COMMA? numbered_field)*;

binary_partition_body:
  COMMA? simple_blason (COMMA? ET simple_blason)? (COMMA AU meuble_desc DE_L_UN_A_L_AUTRE)?;

numbered_field:
  AU CHIFFRE simple_blason;

simple_blason:
  field (charge_description)*;

charge_description:
  (AU | A | A LA) meuble_desc;

field:
  (DE_PREP? couleur);


meuble_desc:
  (number)? charge attributes?
  (action UN_E charge (DE_PREP couleur | DU_MEME)?)?
  (arrangement)?;

attributes:
  (DE_PREP couleur) position? |
  position (DE_PREP couleur)?;

// --- DEFINITIONS ---

partition_type:
  COUPE | PARTI | TRANCHE | TAILLE | ECARTELE;

number:
  UN_E | DEUX | TROIS | QUATRE;

arrangement:
  LPAREN CHIFFRE COMMA CHIFFRE RPAREN;

// --- VOCABULARY MAPPING ---
couleur   : metal | email | fourrure;
metal     : OR | ARGENT;
email     : AZUR | GUEULES | SABLE | SINOPLE | POURPRE;
fourrure  : HERMINE | VAIR;
position  : RAMPANT | PASSANT | ISSANT | ARME | LAMPASSE | POSE_EN_BANDE;
action    : TENANT;
charge    : meuble | piece;
meuble    : LION | CHEVRON | COUPE_M | FERS_DE_LANCE | ETOILE;
piece     : FASCE | PAL | BANDE | BARRE | SAUTOIR | CHEF | BORDURE | CROIX;