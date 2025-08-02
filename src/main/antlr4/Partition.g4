lexer grammar Partition;
// --- Partitions principales ---

COUPE
   : 'coupé'
   ;

PARTI
   : 'parti'
   ;

TRANCHE
   : 'tranché'
   ;

TAILLE
   : 'taillé'
   ;

ECARTELE
   : 'écartelé'
   ;
   // --- Partitions combinées ---
   
ECARTELE_EN_SAUTOIR
   : 'écartelé en sautoir'
   ;

GIRONNE
   : 'gironné'
   ;

COUPE_PARTI // Coupé et parti, etc.
   : 'coupé-parti'
   ;

CONTRE_ECARTELE
   : 'contre-écartelé'
   ;
   // --- Repartitions (qui sont des partitions multiples) ---
   
FASCE // Alias pour 'coupé de N traits'
   : 'fascé'
   ;

PAL // Alias pour 'parti de N traits'
   : 'palé'
   ;

VERGETTE // Diminutif de palé
   : 'vergetté'
   ;

BANDE // Alias pour 'tranché de N traits'
   : 'bandé'
   ;

COTICE_REPARTITION // Diminutif de bandé
   : 'coticé'
   ;

BARRE // Alias pour 'taillé de N traits'
   : 'barré'
   ;

CHEVRONNE
   : 'chevronné'
   ;
   // --- Partitions courbes ou spécifiques ---
   
CHAPE
   : 'chapé'
   ;

CHAUSSE
   : 'chaussé'
   ;

EMBRASSE
   : 'embrassé'
   ;

MANCHE
   : 'manché'
   ;

ECHIQUETE
   : [eé] 'chiquetée' ('e' | 's' | 'es')?
   ;

