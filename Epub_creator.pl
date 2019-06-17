#======================================================================
# Programme | Epub_creator.pl
# Auteur    | Alessandro Cierro <Alessandro.Cierro@uclouvain.be>
# Date      | 2019-06-12
#======================================================================
# Ce programme permet de télécharger des fanfictions depuis le site
# www.fanfiction.net directement au format epub (format de livre numérique).
# Deux utilisations sont possibles :
# 1 - Directement depuis l'URL de la fanfiction.
# 2 - En opérant une navigation des critères de sélections des fanfictions disponibles
#======================================================================
# Usage     | perl Epub_creator.pl depuis l'invite de commande
#======================================================================
# Ce programme fonctionne grâce à 3 modules complémentaires :
# 1 - mise_en_page.pm : responsable de la mise en page et du design général du programme
# 2 - navigation.pm : assure la deuxième fonction du programme,
#                   la navigation entre les différents critères de sélections et
#                   la proposition des fanfictions correspondantes.
# 3 - module_epub.pm : permet la récupération des éléments depuis le site web et
#                      la conversion en livre numérique                
#======================================================================
use strict;
use lib '.';
use module_epub;
use mise_en_page;
use navigation;
use Win32::Console; # Utile pour afficher les symboles inconnus 
Win32::Console::OutputCP(65001); # sur le terminal windows !
use LWP::Simple;

mise_en_page::ligne;
mise_en_page::dessin_intro;

print "
Bienvenue dans ce module de création d'epub basé sur le site https://www.fanfiction.net. \n
Grâce à ce petit programme vous pourrez faire deux choses :\n";

# Ce programme demande l'interaction de l'utilisateur pour avancer.
# Nous proposons ici les deux options d'utilisation du programme.
# l'option 1 renvoit au module_epub.pm et plus spécifiquement à la fonction getepub.
# l'option 2 renvoit à navigation.pm qui lui-même renvoit au module_epub.pm et la fonction get_all_epub.

my $loop = 0;

while($loop <2){
    
    while ($loop <1){
    

       print "
       option 1) Télécharger un epub de la fanfiction de votre choix grâce à son URL. \n
       option 2) Naviguer dans la base de donnée du site www.fanfiction.net et séléctionner d'ici quel(s) fanfiction(s) vous souhaitez télécharger au format epub. \n
       ";
       
       mise_en_page::ligne;
       
       print "\n
       Quelle option choisissez-vous ? \n
       Tapez : 1 ou 2. \n
       ";
       print 'Votre réponse : ';
       my $choix1 = <STDIN>;
       chomp $choix1;

       # Nous demandons à l'utilisateur d'intégrer l'URL de son choix et vérifions qu'elle respecte le format attendu.
       if ($choix1 == 1){
            mise_en_page::ligne;
            mise_en_page::espace;
            print "\n\n\nTrès bien !\nEntrez l'URL de votre choix respectant le format suivant :\n\n".'"https://www.fanfiction.net/s/xxxxxxxxx/1/le-nom-de-la-fanfiction-de-votre-choix"'."\n\n\n\n\n";
            mise_en_page::espace;
            print 'L\'URL de votre choix : ';
            my  $URL = <STDIN>;
                while ($URL  !~ /https:\/\/www.fanfiction.net\/s\/.+?\/[0-9]+\/.+\s/){
                    print "\nAttention, le format de l'URL n'est pas respecté, veuillez recommencer.\n\n";
                    print 'Votre réponse :';
                    $URL = <STDIN>;
                    }         
            $URL =~ /\/s\/(.+?)\/[0-9]+\/(.+)/;   # Nous en profitons pour récupérer depuis l'URL founie les deux parties
            my $premierepartie = $1;              # qui seront nécessaire à getepub et nous la donnons en argumentd de la fonction.
            my $deuxiemepartie = $2;
            
            
            module_epub::getepub ("$premierepartie" , "$deuxiemepartie");
            $loop++;
            # Fin de la première partie, il est demandé à l'utilisateur
            # s'il désire convertir une autre fanfiction, si pas, le programme s'arrête ici.
        }
       
        # la deuxième utilisation possible débute ici. L'utilisateur répond à des questions et en fonction,
        # le programme exclu les fanfictions qui ne respectent pas les critères de sélection.
        # Cette sélection s'opère grâce au module navigation.pm
        elsif ($choix1 == 2) {
           
            mise_en_page::ligne;
            print "\n\nOk, découvrons ce qui pourrait vous plaire... \nJe vous pose des questions et grâce à vos réponses je choisis pour vous les meilleures sélections \n\n";
            navigation::question;
            last;
            
            
        }
        else {
            print "Tapez 1 ou 2, aucune autre réponse n'est prise en compte \n";   
        }
    }
    
  mise_en_page::ligne;

  # Nous proposons à l'utilisateur une nouvelle conversion, ou arrêtons le programme après lui avoir souhaiter une bonne lecture.
  print "\n\nEncore envie de créer des epubs ? \nTapez oui : pour convertir de nouvelle fanfiction en epub.\n";
  mise_en_page::espace;
 
  print 'Votre réponse : ';
  my $choix1bis = <STDIN>;
  chomp($choix1bis);
 
  if ($choix1bis eq 'oui') {
        $loop =0;
        mise_en_page::espace;
    }
   else {
        $loop= 4;
    }
}


mise_en_page::ligne;
mise_en_page::dessin_fin; # Bonne lecture ici.
mise_en_page::ligne;