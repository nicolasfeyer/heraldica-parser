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
   : COUPE (((COMMA | COLON)? numbered_field COMMA? numbered_field) | binary_partition_body)
   | PARTI (((COMMA | COLON)? numbered_field COMMA? numbered_field) | binary_partition_body)
   | TAILLE (((COMMA | COLON)? numbered_field COMMA? numbered_field) | binary_partition_body)
   | TRANCHE (((COMMA | COLON)? numbered_field COMMA? numbered_field) | binary_partition_body)
   | ECARTELE (quartered_partition_body)
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
   : (number | CHIFFRE)? charge (modifier (ET? modifier)*)? (arrangement)?
   ;

modifier
   : attributes
   | (charge_modifier_link ((number | CHIFFRE) | LA)? charge)
   | action_phrase
   ;

positional_stmt
   : EN_BANDE
   | EN_POINTE
   | EN_PAL
   | EN_CHEF
   ;

action_phrase
   : action (positional_stmt)? (DE_PREP)? sub_meuble_desc
   ;

sub_meuble_desc
   : (number | CHIFFRE)? charge (sub_modifier)* (arrangement)?
   ;

sub_modifier
   : attributes
   | (charge_modifier_link ((number | CHIFFRE) | LA)? charge)
   ;

tincture_spec
   : DE_PREP couleur
   | DU_MEME
   | PLEIN
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
   | CHIFFRE ET CHIFFRE
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
   : situation
   | disposition
   ;

position_descr
   : EN_BANDE
   | EN_POINTE
   ;

action
   : TENANT
   ;

disposition
   : ABAISSE
   | ADOSSE
   | AFFRONTE
   | ARME
   | EMPOIGNE
   | NAISSANT
   | ISSANT
   | MOUVANT
   | LAMPASSE
   | RAMPANT
   | PASSANT
   ;

situation
   : ABOUTE
   | ACCOLE
   | ACCOMPAGNE
   | ACCOSTE
   | ADEXTRE
   | APPOINTE
   | BROCHANT
   | CHARGE
   | COTOTE
   | HAUSSE
   | POSE
   | SENEXTRE
   | SOMME
   | SURMONTE
   ;

charge
   : meuble
   | piece
   ;

meuble
   : ABEILLE
   | AIGLE
   | ALERION
   | AGNEAU
   | ANCRE_MARINE
   | ANGUILLE
   | ARAIGNEE
   | BAR
   | BELIER
   | BELETTE
   | BROCHET
   | CANARD
   | CERF
   | CHAUVE_SOURIS
   | CHEVAL
   | CHEVRE
   | CHIEN
   | CHOUETTE
   | CIGOGNE
   | COQ
   | CORBEAU
   | COUCOU
   | DAUPHIN
   | DRAGON
   | ECUREUIL
   | ELEPHANT
   | FAUCON
   | GRENOUILLE
   | GRIFFON
   | HERISSON
   | HERMINE
   | HIBOU
   | LEOPARD
   | LEVRIER
   | LICORNE
   | LION
   | LOUP
   | MERLETTE
   | MOUTON
   | OURS
   | PANTHERE
   | PAON
   | POISSON
   | SANGLIER
   | SERPENT
   | SINGE
   | TAUREAU
   | ARBRE
   | CHARDON
   | CHENE
   | FEUILLE
   | FLEUR_DE_LYS
   | QUINTEFEUILLE
   | ROSE
   | SAPIN
   | TREFLE
   | ANNELET
   | ARC
   | ARC_EN_CIEL
   | CLEF
   | CLOCHE
   | CLOU
   | COEUR
   | COR
   | COUPE_MEUBLE
   | COUPEAU
   | COURONNE
   | CROISETTE
   | CROISSANT
   | EPEE
   | EPERON
   | ETOILE
   | FER_DE_LANCE
   | FLAMME
   | FLECHE
   | HACHE
   | LANCE
   | MAIN
   | MARTEAU
   | MONTAGNE
   | ROUE
   | SOLEIL
   | TOUR
   | ANGE
   | HOMME_SAUVAGE
   | MAURE
   | SIRENE
   ;

piece
   : BANDE
   | BARRE
   | BATON
   | BESANT
   | BILLETTE
   | BORDURE
   | BURELLE
   | CANTON
   | CARREAU
   | CHAMPAGNE
   | CHAPE
   | CHAUSSE
   | CHEF
   | CHEVRON
   | COMBLE
   | COTICE
   | CROIX
   | DEVISE
   | ECOT
   | ECUSSON
   | FASCE
   | FILET
   | FLANC
   | FRANC_QUARTIER
   | GIRON
   | GOUSSET
   | LAMBEL
   | LOSANGE
   | MACLE
   | ORLE
   | PAL
   | PAIRLE
   | POINT
   | POINTE
   | RUSTRE
   | SAUTOIR
   | TIERCE
   | TOURTEAU
   | TRECHEUR
   | VERGETTE
   ;

