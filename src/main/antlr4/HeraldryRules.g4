grammar HeraldryRules;

@header {
package ch.heraldica;
}

import HeraldryVocabulary;

// --- PARSER RULES ---

blason:
  (partitioned_blason | simple_blason) DOT? EOF;

partitioned_blason:
  COUPE (
    (COMMA? numbered_field COMMA? numbered_field) | // Must have exactly two numbered fields
    binary_partition_body                          // Or the classic 'et' syntax
  )
  |
  PARTI (
    (COMMA? numbered_field COMMA? numbered_field) | // Also must have two
    binary_partition_body
  )
  |
  ECARTELE (quartered_partition_body) // An écartelé can have 1, 2, 3, or 4 fields
  |
  (TRANCHE | TAILLE) (binary_partition_body) // Tranché/Taillé usually use 'et'
;

separator:
  COMMA | SEMICOLON;
  
multi_numbered_field:
(AU | AUX) number_list COMMA? simple_blason;
  
number_list:
  CHIFFRE (ET CHIFFRE)*;

quartered_partition_body:
  COMMA? multi_numbered_field (separator multi_numbered_field)*;

binary_partition_body:
  COMMA? simple_blason (COMMA? ET simple_blason)? (COMMA AU meuble_desc DE_L_UN_A_L_AUTRE)?;
  
numbered_field:
  AU CHIFFRE simple_blason;

simple_blason:
  (field (charge_description)*) | meuble_desc;
  
charge_description:
  (AU | A | A LA) meuble_desc;

field:
  (DE_PREP? couleur);


meuble_desc:
  (number)? charge (modifier)* (arrangement)?;
  
modifier:
  attributes |
  (charge_modifier_link (number | LA)? charge) |
  (action (number)? charge (DE_PREP couleur | DU_MEME)?);


charge_modifier_link:
  DE_PREP | SUR;
  
attributes:
  (DE_PREP couleur) position? |
  position (DE_PREP couleur)?;


// --- DEFINITIONS ---

partition_type:
  COUPE | PARTI | TRANCHE | TAILLE | ECARTELE;

number:
  UN_E | DEUX | TROIS | QUATRE | CINQ;

arrangement:
  LPAREN CHIFFRE COMMA CHIFFRE RPAREN;

// --- VOCABULARY MAPPING ---
couleur   : metal | email | fourrure;
metal     : OR | ARGENT;
email     : AZUR | GUEULES | SABLE | SINOPLE | POURPRE;
fourrure  : HERMINE | VAIR;
position  : RAMPANT | PASSANT | ISSANT | ARME | LAMPASSE | POSE_EN_BANDE | MOUVANT | POSE;
action    : TENANT;
charge    : meuble | piece;
meuble    : LION | CHEVRON | COUPE_M | FERS_DE_LANCE | ETOILE | TOUR | MONTAGNE | COUPEAU | ARC_EN_CIEL | POINTE;
piece     : FASCE | PAL | BANDE | BARRE | SAUTOIR | CHEF | BORDURE | CROIX;