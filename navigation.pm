package navigation;
use strict;
use lib '.';
use mise_en_page;
use LWP::Simple;
use module_epub;

my $URL = "";
my $nombrederesultats;
my $univers;
my $critere1 = 'À définir';
my $langue;
my $genre1 = '&g1=0';
my $critere2 = 'À définir';
my $genre2 = '&g2=0';
my $critere3 = 'À définir';
my $rating = '&r=10';
my $critere4 = 'À définir';
my $status = '&s=0';
my $critere5 = 'À définir';
my $taille = '&len=0';
my $critere6 = 'À définir';


my $etape = -1;
my $etape_en_cours;
my $continuer = 1;

sub question {
# Cette sous-routine même si longue est assez simple et répétitive :   
# une série de questions est posée à l'utilisateur, et en fonction le programme 
# va récupérer le nombre de fanfictions correspondant disponibles.

# En fonction des critères l'URL se modifie et permet de préciser la recherche.
# la sélection aboutie il est possible de soit :
# 1 - télécharger "à l'aveugle" un nombre choisi de fanfiction. (Attention que la manoeuvre peut prendre un certain temps.)
# 2 - Découvrir une description pour les 25 premières fanfictions correspondant
#     aux critères et de là choisir de les télécharger ou non.
    
while ($etape < 10){
        
    if ($etape == -1){
        # Nous proposons à l'utilisateur de choisir son univers    
        mise_en_page::petit_espace; 
            
        print "\nChoisissez l'univers de votre choix.\n";
        print "\nTapez le nombre correspondant\n";
        print "\n  1 Harry Potter         --     2 Twilight                --     3 Lord of the Rings     --     4 Percy Jackson and the Olympians";
        print "\n  5 Hunger Games         --     6 Warriors                --     7 Mortal Instruments    --     8 Maximum Ride";
        print "\n  9 Hobbit               --    10 Chronicles of Narnia    --    11 Phantom of the Opera  --    12 Gossip Girl";
        print "\n 13 Outsiders            --    14 A song of Ice and Fire  --    15 Vampire Academy       --    16 Divergent Trilogy";
        print "\n 17 Song of the Lioness  --    18 Inheritance Cycle       --    19 Silmarillion          --    20 Artemis Fowl";
        print "\n 21 Fairy Tales          --    22 Animorphs               --    23 Janet Evanovich       --    24 Pride and Prejudice";
        print "\n 25 Gallagher Girls      --    26 Les Misérables          --    27 Bible                 --    28 Sherlock Holmes";
        print "\n 29 Alex Rider           --    30 Clique                  --    31 Vampires              --    32 Fifty Shades Trilogy";

        mise_en_page::espace;
        print "Votre réponse : ";
        
        my $reponse =<STDIN>;
  
        chomp ($reponse);

        if ($reponse eq 1){
            $univers = 'Harry-Potter';
            $etape++;
        }
        elsif ($reponse eq 2) {
            $univers = 'Twilight';
            $etape++;
        }
        elsif ($reponse eq 3) {
            $univers = 'Lord-of-the-Rings';
            $etape++;
        }
        elsif ($reponse eq 4) {
            $univers = 'Percy-Jackson-and-the-Olympians';
            $etape++;
        }
        elsif ($reponse eq 5) {
            $univers = 'Hunger-games';
            $etape++;
        }
        elsif ($reponse eq 6) {
            $univers = 'Warriors';
            $etape++;
        }
        elsif ($reponse eq 7) {
            $univers = 'Mortal-Instruments';
            $etape++;
        }
        elsif ($reponse eq 8) {
            $univers = 'Maximum-Ride';
            $etape++;
        }
        elsif ($reponse eq 9) {
            $univers = 'Hobbit';
            $etape++;
        }
        elsif ($reponse eq 10) {
            $univers = 'Chronicles-of-Narnia';
            $etape++;
        }
        elsif ($reponse eq 11) {
            $univers = 'Phantom-of-the-Opera';
            $etape++;
        }
        elsif ($reponse eq 12) {
            $univers = 'Gossip-Girl ';
            $etape++;
        }
        elsif ($reponse eq 13) {
            $univers = 'Outsiders';
            $etape++;
        }
        elsif ($reponse eq 14) {
            $univers = 'A-song-of-Ice-and-Fire';
            $etape++;
        }
        elsif ($reponse eq 15) {
            $univers = 'Vampire-Academy';
            $etape++;
        }
        elsif ($reponse eq 16) {
            $univers = 'Divergent-trilogy';
            $etape++;
        }
        elsif ($reponse eq 17) {
            $univers = 'Song-of-the-Lioness';
            $etape++;
        }
        elsif ($reponse eq 19) {
            $univers = 'Inheritance-Cycle';
            $etape++;
        }
        elsif ($reponse eq 20) {
            $univers = 'Artemis-Fowl';
            $etape++;
        }
        elsif ($reponse eq 21) {
            $univers = 'Fairy-Tales';
            $etape++;
        }
        elsif ($reponse eq 18) {
            $univers = 'Silmarillion';
            $etape++;
        }
        elsif ($reponse eq 22) {
            $univers = 'Animorphs';
            $etape++;
        }
        elsif ($reponse eq 23) {
            $univers = 'Janet-Evanovich';
            $etape++;
        }
        elsif ($reponse eq 24) {
            $univers = 'Pride-and-Prejudice';
            $etape++;
        }
        elsif ($reponse eq 25) {
            $univers = 'Gallagher-Girls';
            $etape++;
        }
        elsif ($reponse eq 26) {
            $univers = 'Les-Miserables';
            $etape++;
        }
        elsif ($reponse eq 27) {
            $univers = 'Bible';
            $etape++;
        }
        elsif ($reponse eq 28) {
            $univers = 'Sherlock-Holmes';
            $etape++;
        }
        elsif ($reponse eq 29) {
            $univers = 'Alex-Rider';
            $etape++;
        }
        elsif ($reponse eq 30) {
            $univers = 'Clique';
            $etape++;
        }
        elsif ($reponse eq 31) {
            $univers = 'Vampires';
            $etape++;
        }
        elsif ($reponse eq 32) {
            $univers = 'Fifty-Shades-Trilogy';
            $etape++;
        }
        else {
        print "Votre réponse est incorrect, veuillez recommencer.\n";
        $etape = -1; 
        }
            
            
    }
            
    if ($etape == 0){
        $langue = '';
        $critere1 = '';
        # Nous proposons à l'utilisateur de choisir la langue de la lecture.    
        # Malheureusement les caractères multinlangues comme עברית ou 日本語
        # n'apparaissent pas dans la console avec la police Consolas, nous les traduisons en anglais.
        print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n\n";
        print "\nDans quelle langue désirez-vous lire votre fanfiction ?\n\n";
        print "\n  1 English        --     2 Español           --     3 Français         --     4 Deutsch";
        print "\n  5 Chinese        --     6 Japanese          --     7 Nederlands       --     8 Português";
        print "\n  9 Italiano       --    10 Język polski      --    11 Magyar           --    12 Abrit";
        print "\n 13 Svenska        --    14 Norsk             --    15 Dansk            --    16 Suomi";
        print "\n 17 Filipino       --    18 Esperanto         --    19 Hindi            --    20 Ελληνικά";
        print "\n 21 Română         --    22 Shqip             --    23 српски           --    24 Türkçe ";
        print "\n 25 čeština        --    26 Bahasa Indonesia  --    27 Hrvatski jezik   --    28 Català ";
        print "\n 29 LINGUA LATINA  --    30 Korean            --    31 Tiếng Việt       --    32 Thai Language";
        print "\n 33 Íslenska       --    34 Eesti             --    35 Bahasa Melayu    --    36 Slovenčina";
        print "\n 37 Українська     --    38 Afrikaans         --    39 Persian          --    39 AUCUN CHOIX\n\n";
        mise_en_page::espace;
        print "Votre réponse : ";
        
        my $reponse =<STDIN>;
        chomp ($reponse);

        if ($reponse eq 'retour' or $reponse eq '!'){
            $etape = 0;
            $langue = '';
            $etape--;
        }
        
        elsif ($reponse eq 1) {
           $langue = '&lan=1';
           $critere1 = 'English';
           $etape++;
       }
         elsif ($reponse eq 2) {
           $langue = '&lan=2';
           $critere1 = 'Español';
           $etape++;
       }
          elsif ($reponse eq 3) {
           $langue = '&lan=3';
           $critere1 = 'Français';
           $etape++;
       }
           elsif ($reponse eq 4) {
           $langue = '&lan=4';
           $critere1 = 'Deutsch';
           $etape++;
       }
           elsif ($reponse eq 5) {
           $langue = '&lan=5';
           $critere1 ='Chinese';
           $etape++;
       }
           elsif ($reponse eq 6) {
           $langue = '&lan=6';
           $critere1 ='Japanese';
           $etape++;
       }
           elsif ($reponse eq 7) {
           $langue = '&lan=7';
           $critere1 ='Nederlands';
           $etape++;
       }
           elsif ($reponse eq 8) {
           $langue = '&lan=8';
           $critere1 ='Português';
           $etape++;
       }
           elsif ($reponse eq 9) {
           $langue = '&lan=11';
           $critere1 ='Italiano';
           $etape++;
       }
           elsif ($reponse eq 10) {
           $langue = '&lan=13';
           $critere1 ='Język polski';
           $etape++;
       }
           elsif ($reponse eq 11) {
           $langue = '&lan=14';
           $critere1 ='Magyar';
           $etape++;
       }
           elsif ($reponse eq 12) {
           $langue = '&lan=15';
           $critere1 ='Abrit';
           $etape++;
       }
           elsif ($reponse eq 13) {
           $langue = '&lan=17';
           $critere1 ='Svenska';
           $etape++;
       }
           elsif ($reponse eq 14) {
           $langue = '&lan=18';
           $critere1 ='Norsk';
           $etape++;
       }
           elsif ($reponse eq 15) {
           $langue = '&lan=19';
           $critere1 ='Dansk';
           $etape++;
       }
           elsif ($reponse eq 16) {
           $langue = '&lan=20';
           $critere1 ='Suomi';
           $etape++;
       }
           elsif ($reponse eq 17) {
           $langue = '&lan=21';
           $critere1 ='Filipino';
           $etape++;
       }
           elsif ($reponse eq 18) {
           $langue = '&lan=22';
           $critere1 ='Esperanto';
           $etape++;
       }
           elsif ($reponse eq 19) {
           $langue = '&lan=23';
           $critere1 ='Hindi';
           $etape++;
       }
           elsif ($reponse eq 20) {
           $langue = '&lan=26';
           $critere1 ='Ελληνικά';
           $etape++;
       }
           elsif ($reponse eq 21) {
           $langue = '&lan=27';
           $critere1 ='Română';
           $etape++;
       }
           elsif ($reponse eq 22) {
           $langue = '&lan=28';
           $critere1 ='Shqip';
           $etape++;
       }
           elsif ($reponse eq 23) {
           $langue = '&lan=29';
           $critere1 ='српски';
           $etape++;
       }
           elsif ($reponse eq 24) {
           $langue = '&lan=30';
           $critere1 ='Türkçe';
           $etape++;
       }
           elsif ($reponse eq 25) {
           $langue = '&lan=31';
           $critere1 ='čeština';
           $etape++;
       }
           elsif ($reponse eq 26) {
           $langue = '&lan=32';
           $critere1 ='Bahasa Indonesia';
           $etape++;
       }
           elsif ($reponse eq 27) {
           $langue = '&lan=33';
           $critere1 ='Hrvatski jezik';
           $etape++;
       }
           elsif ($reponse eq 28) {
           $langue = '&lan=34';
           $critere1 ='Català';
           $etape++;
       }
           elsif ($reponse eq 29) {
           $langue = '&lan=35';
           $critere1 ='LINGUA LATINA';
           $etape++;
       }
           elsif ($reponse eq 30) {
           $langue = '&lan=36';
           $critere1 ='Korean';
           $etape++;
       }
           elsif ($reponse eq 31) {
           $langue = '&lan=37';
           $critere1 ='Tiếng Việt ';
           $etape++;
       }
           elsif ($reponse eq 32) {
           $langue = '&lan=38';
           $critere1 ='Thai Language';
           $etape++;
       }
           elsif ($reponse eq 33) {
           $langue = '&lan=40';
           $critere1 ='Íslenska';
           $etape++;
       }
           elsif ($reponse eq 34) {
           $langue = '&lan=41';
           $critere1 ='Eetsi';
           $etape++;
       }
           elsif ($reponse eq 35) {
           $langue = '&lan=42';
           $critere1 ='Bahasa Melayu';
           $etape++;
       }
           elsif ($reponse eq 36) {
           $langue = '&lan=43';
           $critere1 ='Slovenčina';
           $etape++;
       }
           elsif ($reponse eq 37) {
           $langue = '&lan=44';
           $critere1 ='Українська';
           $etape++;
       }
           elsif ($reponse eq 38) {
           $langue = '&lan=45';
           $critere1 ='Afrikaans';
           $etape++;
       }
           elsif ($reponse eq 39) {
           $langue = '&lan=25';
           $critere1 ='Persian';
           $etape++;
       }
           elsif ($reponse eq 40) {
           $langue = '';
           $critere1 ='Toutes les langues';
           $etape++;
       }
           else {
        print "Votre réponse est incorrect, veuillez recommencer.\n";
        $etape = 0; 
        }
    }          
    if ($etape == 1){
      $genre1 = '&g1=0';
      $critere2 = '';
      
      $URL = "https://www.fanfiction.net/book/$univers/".'?&srt=3'."$genre1"."$genre2"."$langue"."$rating"."$status"."$taille";
     

      nombre_de_resultats();
      if ($etape == 1){
        # Nous proposons à l'utilisateur de choisir son premier genre de fanfiction.
                   
        print "\n\nVous pouvez ajouter un second genre de fanfiction si vous le désirez.\n";
        print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n";
        print "\n  0 AUCUN CHOIX      --  1 Romance     --  2 Humour       --  3 Drame";
        print "\n  4 Poésie           --  5 Aventure    --  6 Mystère      --  7 Horreur";
        print "\n  8 Parodie          --  9 Angoisse    -- 10 Supernaturel -- 11 Suspense";
        print "\n 12 Science-fiction  -- 13 Fantastique -- 14 Spirituel    -- 15 Tragédie";
        print "\n 16 Western          -- 17 Crime       -- 18 Famille      -- 19 Hurt/Comfort (contenu explicit)";
        print "\n 20 Amitié           -- 21 Général \n\n";
        mise_en_page::espace;
        print "Votre réponse : ";
            
        my  $reponse =<STDIN>;
        chomp($reponse);
                
        if ($reponse eq 'retour' or $reponse eq '!'){               
            $etape--;
        }
        elsif ($reponse eq 21) {
           $genre1 = '&g1=1';
           $critere2 = 'Général';
           $etape++;
       }
        elsif ($reponse eq 1) {
           $genre1 = '&g1=2';
           $critere2 = 'Romance';
           $etape++;
       }
        elsif ($reponse eq 2) {
            $genre1 = '&g1=3';
            $critere2 = 'Humour';
            $etape++;
            
        }
        elsif ($reponse eq 3) {
            $genre1 = '&g1=4';
            $critere2 = 'Drame';
            $etape++;
            
        }
        elsif ($reponse eq 4) {
            $genre1 = '&g1=5';
            $critere2 = 'Poésie';
            $etape++;
            
        }
        elsif ($reponse eq 5) {
            $genre1 = '&g1=6';
            $critere2 = 'Aventure';
            $etape++;
            
        }
        elsif ($reponse eq 6) {
            $genre1 = '&g1=7';
            $critere2 = 'Mystère';
            $etape++;
            
        }
        elsif ($reponse eq 7) {
            $genre1 = '&g1=8';
            $critere2 = 'Horreur';
            $etape++;
            
        }
        elsif ($reponse eq 8) {
            $genre1 = '&g1=9';
            $critere2 = 'Parodie';
            $etape++;
            
        }
        elsif ($reponse eq 9) {
            $genre1 = '&g1=10';
            $critere2 = 'Angoisse';
            $etape++;
            
        }
        elsif ($reponse eq 10) {
            $genre1 = '&g1=11';
            $critere2 = 'Supernaturel';
            $etape++;
            
        }
        elsif ($reponse eq 11) {
            $genre1 = '&g1=12';
            $critere2 = 'Suspense';
            $etape++;
            
        }
        elsif ($reponse eq 12) {
            $genre1 = '&g1=13';
            $critere2 = 'Science-fiction';
            $etape++;
            
        }
        elsif ($reponse eq 13) {
            $genre1 = '&g1=14';
            $critere2 = 'Fantastique';
            $etape++;
            
        }
        elsif ($reponse eq 14) {
            $genre1 = '&g1=15';
            $critere2 = 'Spirituel';
            $etape++;
            
        }
        elsif ($reponse eq 15) {
            $genre1 = '&g1=16';
            $critere2 = 'Tragédie';
            $etape++;
            
        }
        elsif ($reponse eq 16) {
            $genre1 = '&g1=17';
            $critere2 = 'Western';
            $etape++;
            
        }
        elsif ($reponse eq 17) {
            $genre1 = '&g1=18';
            $critere2 = 'Crime';
            $etape++;
            
        }
        elsif ($reponse eq 18) {
            $genre1 = '&g1=19';
            $critere2 = 'Famille';
            $etape++;
            
        }
         elsif ($reponse eq 19) {
             $genre1 = '&g1=20';
             $critere2 = 'Hurt/Comfort';
             $etape++;
             
         }
         elsif ($reponse eq 20) {
             $genre1 = '&g1=21';
             $critere2 = 'Amitié';
             $etape++;
             
         }
         elsif ($reponse eq 0) {
             $genre1 = '&g1=0';
             $genre2 = '&g2=0';
             $critere2 = 'Pas de genre spécifique';
             $critere3 = 'Pas de genre spécifique';
             $etape = 3; # Nous sautons à l'étape 3 car nous estimons que si l'utilisateur
                         # ne possède pas de préférence de genre ici, ce sera le cas pour la question suivant aussi.
         }
         else {
              print "Votre réponse est incorrect, veuillez recommencer.\n"; 
          }
        }
    }
    if ($etape == 2){
    $genre2 = '&g2=0';
    $critere3 = '';
    
    $URL = "https://www.fanfiction.net/book/$univers/".'?&srt=3'."$genre1"."$genre2"."$langue"."$rating"."$status"."$taille"; 
    nombre_de_resultats();
    if ($etape == 2){
        # Nous proposons à l'utilisateur de choisir son second genre de fanfiction.
        print "\n\nVous pouvez ajouter un second genre de fanfiction si vous le désirez.\n";
        print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n";
        print "\n  0 AUCUN CHOIX      --  1 Romance     --  2 Humour       --  3 Drame";
        print "\n  4 Poésie           --  5 Aventure    --  6 Mystère      --  7 Horreur";
        print "\n  8 Parodie          --  9 Angoisse    -- 10 Supernaturel -- 11 Suspense";
        print "\n 12 Science-fiction  -- 13 Fantastique -- 14 Spirituel    -- 15 Tragédie";
        print "\n 16 Western          -- 17 Crime       -- 18 Famille      -- 19 Hurt/Comfort (contenu explicit)";
        print "\n 20 Amitié           -- 21 Général \n\n";
       
        mise_en_page::espace;
        print "Votre réponse : ";
           
        my   $reponse =<STDIN>;
        chomp $reponse;
        if ($reponse eq 'retour' or $reponse eq '!'){
            $etape--;
        }
        elsif ($reponse eq 21) {
            $genre2 = '&g2=1';
            $critere3 = 'Général';
            $etape++;              
       }
        elsif ($reponse eq 1) {
           $genre2 = '&g2=2';
           $critere3 = 'Romance';
           $etape++;   
       }
        elsif ($reponse eq 2) {
            $genre2 = '&g2=3';
            $critere3 = 'Humour';
            $etape++;
        }
        elsif ($reponse eq 3) {
            $genre2 = '&g2=4';
            $critere3 = 'Drame';
            $etape++;
        }
        elsif ($reponse eq 4) {
            $genre2 = '&g2=5';
            $critere3 = 'Poésie';
            $etape++;   
        }
        elsif ($reponse eq 5) {
            $genre2 = '&g2=6';
            $critere3 = 'Aventure';
            $etape++;
        }
        elsif ($reponse eq 6) {
            $genre2 = '&g2=7';
            $critere3 = 'Mystère';
            $etape++;   
        }
        elsif ($reponse eq 7) {
            $genre2 = '&g2=8';
            $critere3 = 'Horreur';
            $etape++;
        }
        elsif ($reponse eq 8) {
            $genre2 = '&g2=9';
            $critere3 = 'Parodie';
            $etape++;
        }
        elsif ($reponse eq 9) {
            $genre2 = '&g2=10';
            $critere3 = 'Angoisse';
            $etape++;
        }
        elsif ($reponse eq 10) {
            $genre2 = '&g2=11';
            $critere3 = 'Supernaturel';
            $etape++;        
        }
        elsif ($reponse eq 11) {
            $genre2 = '&g2=12';
            $critere3 = 'Suspense';
            $etape++;             
        }
        elsif ($reponse eq 12) {
            $genre2 = '&g2=13';
            $critere3 = 'Science-fiction';
            $etape++;             
        }
        elsif ($reponse eq 13) {
            $genre2 = '&g2=14';
            $critere3 = 'Fantastique';
            $etape++;             
        }
        elsif ($reponse eq 14) {
            $genre2 = '&g2=15';
            $critere3 = 'Spirituel';
            $etape++;              
        }
        elsif ($reponse eq 15) {
            $genre2 = '&g2=16';
            $critere3 = 'Tragédie';
            $etape++;            
        }
        elsif ($reponse eq 16) {
            $genre2 = '&g2=17';
            $critere3 = 'Western';
            $etape++;             
        }
        elsif ($reponse eq 17) {
            $genre2 = '&g2=18';
            $critere3 = 'Crime';
            $etape++;           
        }
        elsif ($reponse eq 18) {
            $genre2 = '&g2=19';
            $critere3 = 'Famille';
            $etape++;   
        }
        elsif ($reponse eq 19) {
            $genre2 = '&g2=20';
            $critere3 = 'Hurt/Comfort';
            $etape++;   
        }
        elsif ($reponse eq 20) {
            $genre2 = '&g2=21';
            $critere3 = 'Amitié';
            $etape++;       
        }
        elsif ($reponse eq 0) {
            $genre2 = '';
            $critere3 = 'Pas de second genre spécifique';
            $etape++;
        }
        else {
         print "Votre réponse est incorrect, veuillez recommencer.\n";
         }
    }
 }
    if ($etape == 3){
        # Nous proposons à l'utilisateur de choisir le rating des fanfictions de son choix.
        $rating ='&r=10';
        $critere4 = '';
        $URL = "https://www.fanfiction.net/book/$univers/".'?&srt=3'."$genre1"."$genre2"."$langue"."$rating"."$status"."$taille";
        nombre_de_resultats();
        if ($etape == 3){ 
            print "\n\nQuelle catégorie de fanfiction cherchez-vous?\n";
            print "\nIl existe des catégories en fonction du contenu de la fanfiction";
            print "\npar exemple : si la fanfiction contient du contenu violant";
            print "\nelle ne sera pas recommandée aux enfants (-16 ans).";
            print "\n\nPlus d'information ici : https://www.fictionratings.com/.";
        
            print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n";
            print "\n0 Pas de choix de rating.";
            print "\n1 Rating K  : convient à tous les âges.";
            print "\n2 Rating K+ : convient à partir de 9 ans et +.";
            print "\n3 Rating T  : convient à partir de 13 ans et +.";
            print "\n4 Rating M  : convient à partir de 16 ans et +.";
            print "\n5 Du rating K à T.";
            print "\n6 Du rating K à K+.";
            
            mise_en_page::petit_espace;
            print "\nVotre réponse : ";
            
            my  $reponse =<STDIN>;
            chomp $reponse;
            if ($reponse eq 'retour' or $reponse eq '!'){
                $etape--;
            }
            elsif ($reponse eq 1) {
                $rating = '&r=1';
                $critere4 = 'Rating K';
                $etape++;
           }
            elsif ($reponse eq 2) {
                $rating = '&r=2';
                $critere4 = 'Rating K+';
                $etape++;
           }
            elsif ($reponse eq 3) {
                $rating = '&r=3';
                $critere4 = 'Rating T';
                $etape++;
           }
            elsif ($reponse eq 4) {
                $rating = '&r=4';
                $critere4 = 'Rating M';
                $etape++;
           }
            elsif ($reponse eq 5) {
                $rating = '&r=103';
                $critere4 = 'Rating K à T';
                $etape++;
           }
            elsif ($reponse eq 6) {
                $rating = '&r=102';
                $critere4 = 'Rating K à K+';
                $etape++;
           }
            elsif ($reponse eq 0) {
                $rating = '&r=10';
                $critere4 = 'Tous les ratings';
                $etape++;
           }
            else {
                print "Votre réponse est incorrect, veuillez recommencer.\n";
            }
        }
    }      
    if ($etape == 4){
        # Nous proposons à l'utilisateur de choisir le status des fanfictions de son choix.
        $status ='&s=0';
        $critere5 ='';

        $URL = "https://www.fanfiction.net/book/$univers/".'?&srt=3'."$genre1"."$genre2"."$langue"."$rating"."$status"."$taille";

        nombre_de_resultats();
        if ($etape ==4){

            print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n";
            
            print "\nIntégrer dans la recherche :";
            print "\n\n 1 Les fanfictions terminées --- 2 Les fanfictions en cours d'écriture --- 3 Toutes les fanfictions disponibles";
            mise_en_page::espace;
            print "\n\nVotre réponse : "; 
            my   $reponse =<STDIN>;
            chomp $reponse;
            if ($reponse eq 'retour' or $reponse eq '!'){
                $etape--;
            }
            elsif ($reponse eq 1) {
                $status = '&s=2';
                $critere5 = 'terminées';
                $etape++;
           }
            elsif ($reponse eq 2) {
                $status = '&s=1';
                $critere5 = 'en cours d\'écriture';
                $etape++;
           }
            elsif ($reponse eq 3) {
                $status = '&s=0';
                $critere5 = 'toutes les fanfictions disponibles';
                $etape++;
           }
            else {
                print "Votre réponse est incorrect, veuillez recommencer.\n";
            }
        }            
    }          
    if ($etape == 5){
        $taille = '&len=0';
        $critere6 = '';
    
        $URL = "https://www.fanfiction.net/book/$univers/".'?&srt=3'."$genre1"."$genre2"."$langue"."$rating"."$status"."$taille";
    
        nombre_de_resultats();
        if ($etape == 5){
        # Nous proposons à l'utilisateur de choisir la taille des fanfictions de son choix.
            print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n";
            print "\nChoisissez la taille de votre choix.\n";
            print "\n 1 Moins de   1000 mots    --   2 Moins de  5000 mots   --   3 Plus de   1000 mots  --  4 Plus de   5000 mots";
            print "\n 5 Plus de  10 000 mots    --   6 Plus de 20 000 mots   --   7 Plus de 40 000 mots  --  8 Plus de 60 000 mots";
            print "\n 9 Plus de 100 000 mots    --  10 Toutes les tailles. \n\n";
            mise_en_page::espace;
            print "\nVotre réponse : ";
            my  $reponse =<STDIN>;
            chomp ($reponse);
          
            if ($reponse eq 'retour' or $reponse eq '!'){
                $etape--;
            }
            elsif ($reponse eq 1) {
                $taille = '&len=11';
                $critere6 = 'Moins de 1000 mots';
                $etape++;
           }
            elsif ($reponse eq 2) {
                $taille = '&len=51';
                $critere6 = 'Moins de 5000 mots';
                $etape++;
           }
            elsif ($reponse eq 3) {
                $taille = '&len=1';
                $critere6 = 'Plus de 1000 mots';
                $etape++;
           }
            elsif ($reponse eq 4) {
                $taille = '&len=5';
                $critere6 = 'Plus de 5000 mots';
                $etape++;
           }
            elsif ($reponse eq 5) {
                $taille = '&len=10';
                $critere6 = 'Plus de 10 000 mots';
                $etape++;
           }
            elsif ($reponse eq 6) {
                $taille = '&len=20';
                $critere6 = 'Plus de 20 000 mots';
                $etape++;
           }
            elsif ($reponse eq 7) {
                $taille = '&len=40';
                $critere6 = 'Plus de 40 000 mots';
                $etape++;
           }
            elsif ($reponse eq 8) {
                $taille = '&len=60';
                $critere6 = 'Plus de 60 000 mots';
                $etape++;
           }
            elsif ($reponse eq 9) {
                $taille = '&len=100';
                $critere6 = 'Plus de 100 000 mots';
                $etape++;
           }
            elsif ($reponse eq 10) {
                $taille = '&len=0';
                $critere6 = 'Toutes les tailles.';
                $etape++;
           }
            
            else {
                print "Votre réponse est incorrect, veuillez recommencer.\n";
            }
        }
    }
     
    if ($etape == 6){
        # Ici l'utilisateur choisi ce qu'il désire faire de la sélection personnelle de fanfictions trouvées.
        $URL = "https://www.fanfiction.net/book/$univers/".'?&srt=3'."$genre1"."$genre2"."$langue"."$rating"."$status"."$taille";
        nombre_de_resultats();
        if ($etape == 6) {
        
            print "\n\nTapez le nombre correspondant ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.\n";
            print "\nNous pouvons convertir le nombre de fanfictions de votre choix au format epub,";
            print "\nou bien vous pouvez choisir celles qui vous plaisent le plus à partir";
            print "\nd'une courte description pour chaque fanfiction\n";
            
            
            print "\n 1 Télécharger les fanfictions disponibles -- 2 Découvrir les descriptions de chaque fanfiction";
            
            mise_en_page::espace;
            print "\nVotre réponse : ";
            my   $reponse =<STDIN>;
            chomp $reponse;
            if ($reponse eq 'retour' or $reponse eq '!'){
                $etape--;
            }
            elsif ($reponse eq 1) {
                mise_en_page::petit_espace;
                mise_en_page::finderecherche ($nombrederesultats);
                mise_en_page::petit_espace;
                print "Combien de fanfiction voulez-vous télécharger de fanfictions?\n";
                print "\nTapez le nombre de votre choix ou bien écrivez \"retour\" ou \"!\" pour revenir au choix précédent.";
                mise_en_page::espace;
                print "\nVotre réponse : ";
                
                my   $reponse =<STDIN>; # L'utilisateur introduit le nombre de fanfiction à téléchargerqui
                                        # correspond à ses critères
                chomp $reponse;
                if ($reponse =~ /[0-9]+/) {               
                    mise_en_page::petit_espace;
                    print "\nLancement des téléchargements des epubs.";
                    print "\nAttention, cette étape peut prendre un certain temps.";
                    mise_en_page::petit_espace;
                    module_epub::get_all_epub ("$URL", "$reponse"); # Lancement des téléchargement au format epub.
                    mise_en_page::fini;
                    $etape = 10;
               }
                elsif ($reponse eq 'retour' or $reponse eq '!'){
                    $etape = 6;
                }
                           
                else {
                    print "Votre réponse est incorrect, veuillez recommencer.\n";
                    $etape = 6;
                }
            }
            elsif ($reponse eq 2) {
                # A partir d'ici, nous offrons à l'utilisateur la possibilité de découvrir une courte description
                # pour les 25 premières fanfictions qui correspondant à pes critères.
                print "\nDécouvrez les descriptions disponibles pour chaque fanfiction. (Jusqu'au 25 premières.)\n\n";
                resume ();
                if ($continuer ==3 ){
                    $etape = 6;
                }
                else {
                    last;    # le cas échéant, nous sortons de la boucle.  
                } 
            }
            else {
                print "Votre réponse est incorrect, veuillez recommencer.\n";
             
             }
          }            
        }    
    }
  }          
            
    if ($etape == 9){
                      
    print "\n\nTapez \"retour\" ou \"!\" pour revenir au choix précédent. \nOu bien tapez \"remise à zero\" ou \"0\" pour reprendre depuis le début. ";            
    mise_en_page::espace;
    print "\n\n\n\nVotre réponse : ";
    my   $reponse =<STDIN>;
    chomp $reponse;     
    if ($reponse eq 'retour' or $reponse eq '!'){       
        $etape = $etape_en_cours-1;
    }
    elsif ($reponse eq 'remise à zero' or $reponse eq '0'){
        print "remise à zero";
        $etape = 0;
    }
    else {
        print "Votre réponse est incorrect, veuillez recommencer.\n";
    }
   }
        

# Cette fonction s'occupe d'afficher le nombre de résultats restant ou
# d'indiquer qu'il n'y a plus de résultats disponibles
sub  nombre_de_resultats {
    
    my $page = get($URL);
    my @lignes = split (/[\r\n]+/, $page);
    
    foreach my $ligne (@lignes) {
                       
        $ligne =~ /live_counter\sclass='badge'\sstyle='margin-top:5px'>(.+?)</;                
        $nombrederesultats = $1; 
    }
         
    if ($nombrederesultats ne "0"){
        mise_en_page::affichage_resultats ("$nombrederesultats","$critere1","$critere2","$critere3","$critere4","$critere5","$critere6"); 
    }
          
    if ($nombrederesultats eq "0"){      
        $etape_en_cours = $etape;
        $etape = 9 ;  
        mise_en_page::afficher_zero ("$critere1","$critere2","$critere3","$critere4","$critere5","$critere6");
    }   
}

# Nous rendons disponibles les 25 premières description des URLs ici. 
sub resume{
    my $resume;
    my $auteur;
    my $personnage;
    my $titrelivre;
    my $genre;
    my $rating;
    my $liendulivre;
   
    my $page = get("$URL");
   
    my @lignes = split (/[\r\n]+/, $page);


    my $infosTrouvees1 = 0;
    my $infosTrouvees2 = 0;
    
    foreach my $ligne (@lignes) {
    if($continuer == 1){
        if ($ligne =~ /<a  class=stitle href="(\/s\/[0-9]+\/\d\/(.+?))"/){
            $liendulivre = "https://www.fanfiction.net".$1.'/';
            $titrelivre = $2;
            $infosTrouvees1 = 1;
        }
         
        if ($ligne =~ /<div class='z-indent z-padtop'>(.+?)<div class='z-padtop2 xgray'>Rated:(.+?)-(.+?)-(.+?)-.+<\/span> -(.+?) (- Complete|<\/div>)/){
            $resume = $1;
            $rating = $2;      
            $genre = $3;
            $personnage = $5;
            if ($personnage =~ /Published(?s).+/) {
                $personnage = "Pas précisés"
            }
            $infosTrouvees2 = 1;
        }
      
         if($infosTrouvees1 * $infosTrouvees2 == 1){
            $infosTrouvees1 = 0;
            $infosTrouvees2 = 0;
            $continuer = -1;
            while($continuer == -1)
            {
                mise_en_page::resume ("$resume","$personnage" ,"$titrelivre");
                
                print "\nTapez 0 pour convertir la fanfiction ou 1 pour continuer à parcourir les descriptions.
                \nOu bien \"retour\" ou \"!\" pour revenir en arrière.\n";
                
                mise_en_page::espace;
                print "\nVotre choix = ";
                $continuer = <>;
                chomp ($continuer);
                if($continuer eq 0){
                    $liendulivre =~ /\/s\/(.+?)\/[0-9]+\/(.+)/;
                    my $premierePartie = $1;
                    my $deuxiemePartie = $2;
                    module_epub::getepub ("$premierePartie" , "$deuxiemePartie");
                    $continuer = 1;
                }
                elsif ($continuer eq 'retour' or $continuer eq '!') {
                    $continuer = 3;
                    last;
                }
                elsif($continuer ne 1){
                   print "Votre choix est incorrect, veuillez recommencer.\n";
                   $continuer = -1;
                }
            }
        }
     }
   }
}


1;
