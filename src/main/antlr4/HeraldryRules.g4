grammar HeraldryRules;

@ header
{
package ch.heraldica;
}
import HeraldryVocabulary;

blason
   : (partitioned_blason | simple_blason) DOT? EOF
   ;


partitioned_blason
   : COUPE ((COMMA? numbered_field COMMA? numbered_field) | binary_partition_body)
   | PARTI ((COMMA? numbered_field COMMA? numbered_field) | binary_partition_body)
   | ECARTELE (quartered_partition_body)
   | (TRANCHE | TAILLE) (binary_partition_body)
   ;


binary_partition_body
   : COMMA? simple_blason (COMMA? ET simple_blason)? (COMMA AU meuble_desc DE_L_UN_A_L_AUTRE)?
   ;

numbered_field
   : AU CHIFFRE simple_blason
   ;

quartered_partition_body
   : COMMA? multi_numbered_field (separator multi_numbered_field)*
   ;

separator
   : COMMA
   | SEMICOLON
   ;

multi_numbered_field
   : (AU | AUX) number_list COMMA? simple_blason
   ;

number_list
   : CHIFFRE (ET CHIFFRE)*
   ;


simple_blason
   : (field (charge_description)*)
   | meuble_desc
   ;


charge_description
   : (AU | A | A LA) meuble_desc
   ;

field
   : (DE_PREP? couleur)
   ;

meuble_desc
   : (number)? charge (modifier (ET? modifier)*)? (arrangement)?
   ;


modifier
   : attributes
   | (charge_modifier_link (number | LA)? charge)
   | action_phrase
   ;

positional_stmt
   : EN_CHEF_POS
   | EN_POINTE_POS
   ;

action_phrase
   : action (positional_stmt)? (DE_PREP)? sub_meuble_desc
   ;

sub_meuble_desc
   : (number)? charge (sub_modifier)* (arrangement)?
   ;

sub_modifier
   : attributes
   | (charge_modifier_link (number | LA)? charge)
   ;

tincture_spec
   : DE_PREP couleur
   | DU_MEME
   ;

charge_modifier_link
   : DE_PREP
   | SUR
   | ENTRE number
   ;

attributes
   : tincture_spec position?
   | position tincture_spec?
   ;

partition_type
   : COUPE
   | PARTI
   | TRANCHE
   | TAILLE
   | ECARTELE
   ;

number
   : UN_E
   | DEUX
   | TROIS
   | QUATRE
   | CINQ
   ;

arrangement
   : LPAREN CHIFFRE COMMA CHIFFRE RPAREN
   ;

couleur
   : metal
   | email
   | fourrure
   ;

metal
   : OR
   | ARGENT
   ;

email
   : AZUR
   | GUEULES
   | SABLE
   | SINOPLE
   | POURPRE
   ;

fourrure
   : HERMINE
   | VAIR
   ;

position
   : RAMPANT
   | PASSANT
   | ISSANT
   | ARME
   | LAMPASSE
   | POSE_EN_BANDE
   | MOUVANT
   | POSE
   ;

action
   : TENANT
   | ACCOMPAGNE
   ;

charge
   : meuble
   | piece
   ;

meuble
   : LION
   | CHEVRON
   | COUPE_M
   | FERS_DE_LANCE
   | ETOILE
   | TOUR
   | MONTAGNE
   | COUPEAU
   | ARC_EN_CIEL
   | POINTE
   | COEUR
   | CROISETTE
   ;

piece
   : FASCE
   | PAL
   | BANDE
   | BARRE
   | SAUTOIR
   | CHEF
   | BORDURE
   | CROIX
   | VERGETTE
   ;

