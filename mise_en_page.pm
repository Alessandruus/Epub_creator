package mise_en_page;
use strict;
use Win32::Console;              # Utile pour afficher les symboles inconnus 
Win32::Console::OutputCP(65001); # sur le terminal windows !

sub ligne {
    print "////////////////////////////////////////////////////////////////////////////////////////////////";
}

sub espace {
    
    print "\n\n\n\n\n\n\n\n\n\n\n\n\n";
}

sub petit_espace {
    print "\n\n\n\n\n\n"
}

sub affichage_resultats{
    my ($resultats) = $_[0];
    my ($langue)    = $_[1];
    my ($genre1)    = $_[2];
    my ($genre2)    = $_[3];
    my ($rating)    = $_[4];
    my ($status)    = $_[5];
    my ($taille)    = $_[6]; 
    print "\n\n======================================================================";
    print   "\n======================================================================";
    print   "\n                                 $resultats                           ";
    print   "\n                résultats correspondent à vos critères                ";
    print   "\n======================================================================";
    print   "\n======================================================================";
    print   "\n                      Vos critères actuels :                          ";
    print   "\n   Langue : $langue     -    Genre 1 : $genre1   -  Genre 2 : $genre2 ";
    print   "\n   Rating : $rating     -    Status  : $status   -                    ";
    print   "\n                       Taille : $taille                               ";
    print   "\n======================================================================";
}

sub afficher_zero {
    
    my ($langue)    = $_[0];
    my ($genre1)    = $_[1];
    my ($genre2)    = $_[2];
    my ($rating)    = $_[3];
    my ($status)    = $_[4];
    my ($taille)    = $_[5]; 
    
    print "\n\n======================================================================";
    print   "\n======================================================================";
    print   "\n           Aucun résultat n'a été trouvé avec vos critères            ";
    print   "\n                Veuillez élargir votre sélection                      ";
    print   "\n======================================================================";
    print   "\n======================================================================";
    print   "\n                      Vos critères actuels :                          ";
    print   "\n   Langue : $langue     -    Genre 1 : $genre1   -  Genre 2 : $genre2 ";
    print   "\n   Rating : $rating     -    Status  : $status   -                    ";
    print   "\n                       Taille : $taille                               ";
    print   "\n======================================================================";
    
}

sub finderecherche {
    
    my ($resultats) = $_[0];
    
    print "\n\n======================================================================";
    print   "\n                                 $resultats                           ";
    print   "\n                résultats correspondent à vos critères                ";
    print   "\n======================================================================";
    
    
}


sub dessin_intro {
    print '
 ________                      __                                    
|        \                    |  \                                   
| $$$$$$$$  ______   __    __ | $$____                               
| $$__     /      \ |  \  |  \| $$    \                              
| $$  \   |  $$$$$$\| $$  | $$| $$$$$$$\                             
| $$$$$   | $$  | $$| $$  | $$| $$  | $$                             
| $$_____ | $$__/ $$| $$__/ $$| $$__/ $$                             
| $$     \| $$    $$ \$$    $$| $$    $$                             
 \$$$$$$$$| $$$$$$$   \$$$$$$  \$$$$$$$                              
          | $$                            __                         
          | $$                           |  \                        
  _______  \______    ______    ______  _| $$_     ______    ______  
 /       \ /      \  /      \  |      \|   $$ \   /      \  /      \ 
|  $$$$$$$|  $$$$$$\|  $$$$$$\  \$$$$$$\\$$$$$$  |  $$$$$$\|  $$$$$$\
| $$      | $$   \$$| $$    $$ /      $$ | $$ __ | $$  | $$| $$   \$$
| $$_____ | $$      | $$$$$$$$|  $$$$$$$ | $$|  \| $$__/ $$| $$      
 \$$     \| $$       \$$     \ \$$    $$  \$$  $$ \$$    $$| $$      
  \$$$$$$$ \$$        \$$$$$$$  \$$$$$$$   \$$$$   \$$$$$$  \$$      
                                                                     
                                                                     
                                                                     
';
}

sub dessin_fin {
    print "\n".'
 /$$$$$$$                                                /$$                       /$$                                         /$$      
| $$__  $$                                              | $$                      | $$                                        | $$      
| $$  \ $$  /$$$$$$  /$$$$$$$  /$$$$$$$   /$$$$$$       | $$  /$$$$$$   /$$$$$$$ /$$$$$$   /$$   /$$  /$$$$$$   /$$$$$$       | $$      
| $$$$$$$  /$$__  $$| $$__  $$| $$__  $$ /$$__  $$      | $$ /$$__  $$ /$$_____/|_  $$_/  | $$  | $$ /$$__  $$ /$$__  $$      | $$      
| $$__  $$| $$  \ $$| $$  \ $$| $$  \ $$| $$$$$$$$      | $$| $$$$$$$$| $$        | $$    | $$  | $$| $$  \__/| $$$$$$$$      |__/      
| $$  \ $$| $$  | $$| $$  | $$| $$  | $$| $$_____/      | $$| $$_____/| $$        | $$ /$$| $$  | $$| $$      | $$_____/                
| $$$$$$$/|  $$$$$$/| $$  | $$| $$  | $$|  $$$$$$$      | $$|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$/| $$      |  $$$$$$$       /$$      
|_______/  \______/ |__/  |__/|__/  |__/ \_______/      |__/ \_______/ \_______/   \___/   \______/ |__/       \_______/      |__/      
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
';


sub livre_dispo {
    my $nomdulivre = $_[0];
    espace ();
    print "\n\n======================================================================\n";
    print "\n                             La fanfiction :                            ";
    print "\n                            $nomdulivre                                 ";
    print "\n                     est téléchargée au format epub                     ";
    print "\n\n======================================================================\n\n";
    espace ();
}

sub livres_dispo {
    my $nomdulivre = $_[0];
    my $reste = $_[1];
    
    espace ();
    print "\n\n======================================================================\n";
    print "\n                             La fanfiction :                            ";
    print "\n                            $nomdulivre                                 ";
    print "\n                     est téléchargée au format epub                     ";
    print "\n\n======================================================================\n\n";
    print "\n               Il reste : $reste fanfiction(s) à télécharger            ";
    print "\n\n======================================================================\n";
    espace ();
    
}


sub fini {
  espace ();
    print "\n\n======================================================================\n";
    print "\n                         Toutes les fanfictions                           ";
    print "\n                          ont été téléchargées !                           ";
    print "\n\n======================================================================\n\n";

    espace ();
 
}
 
 sub resume{
    my $resume = $_[0];
    my $perso = $_[1];
    my $titre = $_[2];
    $resume =~ s/\.\s/\.\n/g;
    $resume =~ s/,\s/,\n/g;
    $titre =~ s/-/ /g;
    espace ();
    print "\n\n======================================================================\n";
    print "\n                         $titre                                           ";
    print "\n\n======================================================================\n";
    print "\n $resume                                                                 ";
    print "\n\n======================================================================\n\n";
    print "\n        Personnages présents : $perso                                   ";
    print "\n\n======================================================================\n";
   
  
 }
    
}

# Nous profitons de ce module "mise en page" pour corriger l'HTML.
# Il y a de nombreuses variations sur le site fanfiction.net à capturer et uniformiser.
# Cette sous-routine modifie les balises HTML pour qu'elles soient lisibles par notre epub.
# Il est possible que des variations que nous n'avons pas rencontrées
# lors de la réalisation de ce programme subsistent.
#
# En voici les symptômes : epub contenant des chapitres incomplets, ou des phrases qui s'arrêtent
# en cours de route.
#
# Si ce genre d'irrégularités subsiste, en rajoutant des conditions ici le problème disparaitra.
sub correction_epub {
    my $page = $_[0];
        
    # Remplacer les majuscules en minuscules dans les balises.
    $page =~ s/<P>/<p>/g;
    $page =~ s/<\/P>/<\/p>/g;
    $page =~ s/<\/P><P>/<\/p><p>/g;
    $page =~ s/<EM>/<em>/g;
    $page =~ s/<\/EM>/<\/em>/g;
    $page =~ s/<STRONG>/<strong>/g;
    $page =~ s/<\/STRONG>/<\/strong>/g;
    $page =~ s/<br>/<p>/g;
    $page =~ s/<\/br>/<\/p>/g;
    $page =~ s/<BR>/<p>/g;
    $page =~ s/<\/BR>/<\/p>/g;
  
    
    # le code html <hr size=1 noshade> représente une ligne de séparation 
    # Elle crée des problèmes une fois convertie en epub.
    # Nous les remplaçons donc par trois ✦ bien centrés
    
    $page =~ s/<hr size=1 noshade>/<center>*****<\/center>/g; 
    
    # Pour rajouter des modifications supplémentaires :
    # $page =~ s/LA BALISE PROBLEMATIQUE/soit une balise compatible, soit rien : ''/g;
    
    our $page_corrige = $page;
    return $page_corrige;
    
}


1;
