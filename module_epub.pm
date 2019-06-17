package module_epub;
use lib '.';
use mise_en_page;
use LWP::Simple;
use utf8;
use EBook::EPUB::Lite;
use Data::Dumper;
use strict;


#use warnings;


# La sous-routine suivante permet de convertir une fanfiction (depuis fanfiction.net)
# dont l'URL est connue en format epub.

sub getepub {
   
# Définition des variables nécessaires à la création de l'epub. 

my @chapitres;
my $cover ;
my $resume= '';
my @titreschapitres;
my $titrechapitre= '';
my $auteur= '';
my $titrelivre= '';
my $rating = '';
my $langue = '';
my $genre = '';
my $personnage = '';
my $nombredemots;
my $nbdechapitres = 1; # On suppose qu'il existe au moins un chapitre et on incrémente cette variable quand d'autres chapitres sont détectés. 
my $datepublicationjourmois = '';
my $datepublicationannee = '';
my $datecomplete = '';
my $URL = 'https://www.fanfiction.net/s/'."$_[0]".'/';


# On parcourt les pages html correspondant à chacun des chapitres du livre et, pour chacune d'elles,
# on extrait du contenu : contenu du chapitre, titre du chapitre et des métadonnées.
my $n = 0;
my $continuer = 1;

my $page = '';

# Cette boucle while permet de capturer tous les chapitres disponibles de la fanfiction
# A partir de la première traversée de l'html, nous récupérons l'information du nombre de chapitre (nommé $n).
# Chaque chapitre se trouve sur une page HTML propre selon www.fanfiction.net/s/000000000/$n/Le-nom-de-la-fanfiction.
# tant que nous n'avons pas parcouru tous les chapitres, la boucle continue.

while ($n < $nbdechapitres){
   
   $page = get('https://www.fanfiction.net/s/'."$_[0]".'/'.($n+1).'/'."$_[1]");  # Nous reprenons ici les segments de l'URL
                                                                                 # qui nous intéresse obtenu depuis l'URL
                                                                                 # fournie par l'utilisateur.

   
   mise_en_page::correction_epub ($page);    # Nous corrigeons ici les irrégularités ou autres balises non reconnue par l'epub.
  
     
    
   my @lignes = split (/[\r\n]+/, $mise_en_page::page_corrige); # Mise en place d'un tableau constitué de chaque ligne de l'html.
   #print $mise_en_page::page_corrige;
 my $indiceInitial;
      my $indiceFinal;

    #foreach my $ligne (@lignes) {
      for(my $i=0; $i<scalar(@lignes); $i++) {
            
            # On récupère le titre du chapitre.   
            if ($lignes[$i] =~ /<title>.+Chapter\s[0-9]+:\s(.+), a harry potter fanfic/){ 
               $titreschapitres[$n] = $1 ;
            }
          
            # On récupère le contenu du chapitre.
            if ($lignes[$i] =~ /<div class='storytext xcontrast_txt nocopy' id='storytext'>/) {
               $indiceInitial = $i;   # Pour la capture du chapitre, et éviter les nombreuses différences
                                      # entre les pages html (chaque auteur possède sa propre convention)
                                      # nous initions un compteur qui (dans la boucle for qui suit)
                                      # s'enclanche ici et permettera de concaténer toutes les phrases récoltées.
            }
            if ($lignes[$i] =~ /<\/p>/) {
               $indiceFinal = $i;     # Le compteur s'arrête à la dernière balise </p>.
            }
               
            # On récupère l'URL de la couverture du livre si elle existe.
            if ($lignes[$i] =~ /(ff74.b-cdn.net\/image\/[0-9]+\/[0-9]+\/)/){ 
               $cover = "https://$1" ;                                  
            }
            
            # On récupère le nom/pseudo de l'auteur si nous ne l'avons pas encore récupéré.
            if ($auteur eq '' and $lignes[$i] =~ /href='\/u\/[0-9]+\/.*?.+?>(.+?)</){
               $auteur = $1;
            }
            
            # On récupère la description/résumé si nous ne l'avons pas encore récupéré.
            if ($resume eq '' and $lignes[$i] =~ /<div style='margin-top:2px' class='xcontrast_txt'>(.+)<\/div>/){
               $resume = $1;
            }
            
            # On récupère le titre du libre si nous ne l'avons pas encore récupéré.
            if ($titrelivre eq '' and $lignes[$i] =~ /<b class='xcontrast_txt'>(.+)<\/b>/){
               $titrelivre = $1;
            }
            
            # On récupère une série de métadonnée.
            if (my $n == 0 and $lignes[$i] =~ /'rating'>(.+?)<\/a>\s-\s(.+?)\s-(.+?)-\s+(.+?)\s-\s(.+?)-/){
               $rating = $1;
               $langue = $2;
               $genre = $3;
               $personnage = $4;
            }
            
             # On récupère le nombre de chapitre.
            if (my $n == 0 and $lignes[$i] =~ /'rating'>.+?<\/a>\s-\s.+?\s-.+?-\s+.+?\s-\sChap.+?:\s([0-9]+)/){
               $nbdechapitres = $1; 
            }
            
            # On récupère la jour et le mois de publication si nous ne les avons pas encore récupérés.
            if ($datepublicationjourmois eq '' and $lignes[$i] =~ /Published:\s<span\sdata-xutime='[0-9]+'>([0-9]+)\/([0-9]+)/){
               $datepublicationjourmois = $1.'/'.$2;
            }
            
            # On récupère la date de publication si nous ne l'avons pas encore récupérée.
            if ($datepublicationannee eq '' and $lignes[$i] =~ /Published:\s<span\sdata-xutime='[0-9]+'>[0-9]+\/[0-9]+\/([0-9]+)/){
               $datepublicationannee = $1;
            }
       }
         for(my $i=$indiceInitial; $i<=$indiceFinal; $i++)
           {
              $chapitres[$n] .= $lignes[$i];
           }
           
        $n++;  # Nous incrémentons le nombre de chapitre de 1.
}


# Vérification que la page de couverture existe, sinon téléchargement d'une page
# de couverture par défaut (réalisée pour ce projet).
if (!defined $cover) {
    $cover = 'http://i64.tinypic.com/5mybg9.jpg';
}
# Vérification que le nombre de chapitre existe,
# sinon nous indiquons qu'il n'y a qu'un chapitre
if (!defined $nbdechapitres) {
    $nbdechapitres = 1 ;
}


# Ici nous téléchargons la couverture du livre et la renommerons cover.jpeg ;
# ce qui aura opur effet d'écraser les covers précédentes

getstore("$cover","cover.jpeg");

# Avec toutes les données récupérées, nous pourons lancer la création de l'epub lui-même
# grâce au module EBook::EPUB::Lite disponible sur https://metacpan.org/
my $epub = EBook::EPUB::Lite->new();


EBook::EPUB::Lite::add_language( $epub, 'fr' );

# En fonction des informations récupérée via l'HTML nous connaissons
# la date complète ou incomplete de publication.
if ($datepublicationannee ne '') {
    $datecomplete = "$datepublicationjourmois.'/'.$datepublicationannee" ;
    
}

else {
    $datecomplete = "$datepublicationjourmois" ;
    
}

#print Dumper $epub;  # Pour voir la progression de la création de chaque Epub Dumper $epub est utile
                      # Pour garder l'interface de l'utilisateur le plus épuré possible, nous désactivons ceci.
                      

# On ajoute quelques métadonnées (facultatives) à l'EPUB
$epub->add_title(''.$titrelivre);                                  # titre
$epub->add_author(''.$auteur);                                     # auteur
$epub->add_language(''.$langue);                                   # langue
$epub->add_date(''.$datecomplete);                                 # date
$epub->add_description(''.$resume);                                # description
$epub->add_publisher('https://www.fanfiction.net');                # éditeur
$epub->add_type(''.$rating);                                       # type de récit selon https://www.fictionratings.com/    
$epub->add_identifier('Fanfiction au format pub grâce à Epub_Creator.pl');   # Information sur le programme

# On ajoute une image de couverture
my $cover_id = $epub->copy_image( 'cover.jpeg', 'cover.jpeg' );


# Et on fait en sorte qu'elle puisse être utilisée comme vignette
# par certains programmes
$epub->add_meta_item( 'cover', $cover_id );

# On ajoute une page de couverture
my $cover_page = '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
  "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head><title></title></head>
    <body>
      <img src="cover.jpeg"/>
    </body>
  </html>
';
my $cover_page_id = $epub->add_xhtml( 'cover.html', $cover_page );

# On ajoute un faux-titre
my $halftitle_page = '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
  "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head><title></title></head>
    <body>
      <center>
      <h1>'.$titrelivre.'&nbsp;</h1>
      <h2><i> By '."$auteur".'</i></h2>
      </center>
      <p>'."\n $resume\n".'</p>
      <p>'."Rating : $rating"." - Langue : $langue"." - Genre : $genre".
            " - Personnage(s) présent(s) : $personnage"." - Nombre de chapitre : $nbdechapitres".
            ' - URL : '.'<a href="'.$URL.'">'."$URL".'</a>'.'<\p>
    </body>
  </html>
';
my $halftitle_page_id = $epub->add_xhtml( 'halftitle.html', $halftitle_page );


# On ajoute une table des matières
$epub->add_navpoint(
    label      => "couverture",
    id         => $cover_page_id,
    content    => 'cover.html',
    play_order => 1
);


# On crée chacun des chapitres et on les ajoutes dans la table des matières.

foreach(my $m=0 ; $m < $nbdechapitres ; $m++) {
my $chapter_html  = '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
  "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head><title></title></head>
  <body>
  <center>
    <h2>Chapitre '.($m+1).' </h2>
    <h2>'.$titreschapitres[$m].'</h2>
    </center>
    '.$chapitres[$m].'
  </body>
</html>
';

my $chapitre_id = $epub->add_xhtml('chapter_'.($m+1).'.html', $chapter_html);

$epub->add_navpoint(
    label      => "Chapitre ".($m+1)."$titrechapitre",
    id         => $chapitre_id,
    content    => 'chapter_'.($m+1).'.html',
    play_order => $m+2
);
}
 # On génère l'EPUB
$epub->pack_zip("$titrelivre.epub");

 # Nous l'indiquons à l'utilisateur
 mise_en_page::livre_dispo ("$titrelivre");
 
}


# La sous-routine suivante ressemble à la précédente, si ce n'est qu'elle permet
# de convertir plusieurs fanfictions disponibles sur une page HTML.

my @urls;
my $partie_url;
my @partie_url_final;
my $j =0;
my $k = 0;

sub get_all_epub {

   
   my $URL = $_[0];
   my $nombreatelecharger = $_[1];
   my $nombreeffectif = int($nombreatelecharger/25);
    
   #ici URL complet récupéré depuis la navigation  (choix de l'utilisateur)   
   for ( my$i=1; $i<=$nombreeffectif+1; $i++){
   my $page = get("$URL".'&p='."$i"); 
   my @lignesURLgeneral = split (/[\r\n]+/, $page);
   
   
   foreach my $ligne (@lignesURLgeneral) {
     if ($ligne =~ /<a  class=stitle href="(\/s\/.+?)">/){
        if ($k < $nombreatelecharger){
          push (@urls , "https://www.fanfiction.net".$1.'/');         
          $partie_url = $1;
          $partie_url =~ /\/s\/(.+?)\/[0-9]+\/.+/;
          push (@partie_url_final , "$1");
          $k++;
          } 
         }
      }        
   }
   # Ici le tableau @urls possède chacun des liens vers les fanfictions récoltées.
   # Ce qui nous permet de répéter l'action de téléchargement par fanfiction.   

   foreach my $url (@urls){      
   
    my @chapitres;
    my $cover ;
    my $resume= '';
    my @titreschapitres;
    my $titrechapitre= '';
    my $auteur= '';
    my $titrelivre= '';
    my $rating = '';
    my $langue = '';
    my $genre = '';
    my $personnage = '';
    my $nombredemots;
    my $nbdechapitres = 1; # On suppose qu'il existe au moins un chapitre et on incrémente cette variable quand d'autres chapitres sont détectés. 
    my $datepublicationjourmois = '';
    my $datepublicationannee = '';
    my $datecomplete = '';
    my $url_local = 'https://www.fanfiction.net/s/'."$partie_url_final[$j]".'/';
    
    # On parcourt les pages html correspondant à chacun des chapitres du livre et, pour cahcune d'elles,
    # on extrait du contenu : contenu du chapitre, titre du chapitre et des métadonnées.
    my $n = 0;
    my $continuer = 1;
    
    while ($n < $nbdechapitres){
       my $page = get("$url");
    
       mise_en_page::correction_epub ($page);    # Nous corrigeons ici les irrégularités ou autres balises non reconnue par l'epub.
   
       my @lignes = split (/[\r\n]+/, $mise_en_page::page_corrige); # Mise en place d'un tableau constitué de chaque ligne de l'html.
       my $indiceInitial;
       my $indiceFinal;
    
        for(my $i=0; $i<scalar(@lignes); $i++) {
             
             # On récupère le titre du chapitre.   
             if ($lignes[$i] =~ /<title>.+Chapter\s[0-9]+:\s(.+), a harry potter fanfic/){ 
                $titreschapitres[$n] = $1 ;
             }
           
             # On récupère le contenu du chapitre.
             if ($lignes[$i] =~ /<div class='storytext xcontrast_txt nocopy' id='storytext'>/) {
                $indiceInitial = $i; # Pour la capture du chapitre, et éviter les nombreuses différences
                                     # entre les pages html (chaque auteur possède sa propre convention)
                                     # nous initions un compteur qui (dans la boucle for qui suit)
                                     # s'enclanche ici et permettera de concaténer toutes les phrases récoltées.
                            
             }
             if ($lignes[$i] =~ /<\/p>/) {
                $indiceFinal = $i;   # Le compteur s'arrête à la dernière balise </p>.
             }
                
             # On récupère l'URL de la couverture du livre si elle existe.
             if ($lignes[$i] =~ /(ff74.b-cdn.net\/image\/[0-9]+\/[0-9]+\/)/){ 
                $cover = "https://$1" ;                                  
             }
             
             # On récupère le nom/pseudo de l'auteur si nous ne l'avons pas encore récupéré.
             if ($auteur eq '' and $lignes[$i] =~ /href='\/u\/[0-9]+\/.*?.+?>(.+?)</){
                $auteur = $1;
             }
             
             # On récupère la description/résumé si nous ne l'avons pas encore récupéré.
             if ($resume eq '' and $lignes[$i] =~ /<div style='margin-top:2px' class='xcontrast_txt'>(.+)<\/div>/){
                $resume = $1;
             }
             
             # On récupère le titre du libre si nous ne l'avons pas encore récupéré.
             if ($titrelivre eq '' and $lignes[$i] =~ /<b class='xcontrast_txt'>(.+)<\/b>/){
                $titrelivre = $1;
             }
             
             # On récupère une série de métadonnée.
             if (my $n == 0 and $lignes[$i] =~ /'rating'>(.+?)<\/a>\s-\s(.+?)\s-(.+?)-\s+(.+?)\s-\s(.+?)-/){
                $rating = $1;
                $langue = $2;
                $genre = $3;
                $personnage = $4;
             }
             
              # On récupère le nombre de chapitre.
             if (my $n == 0 and $lignes[$i] =~ /'rating'>.+?<\/a>\s-\s.+?\s-.+?-\s+.+?\s-\sChap.+?:\s([0-9]+)/){
                $nbdechapitres = $1; 
             }
             
             # On récupère la jour et le mois de publication si nous ne les avons pas encore récupérés.
             if ($datepublicationjourmois eq '' and $lignes[$i] =~ /Published:\s<span\sdata-xutime='[0-9]+'>([0-9]+)\/([0-9]+)/){
                $datepublicationjourmois = $1.'/'.$2;
             }
             
             # On récupère la date de publication si nous ne l'avons pas encore récupérée.
             if ($datepublicationannee eq '' and $lignes[$i] =~ /Published:\s<span\sdata-xutime='[0-9]+'>[0-9]+\/[0-9]+\/([0-9]+)/){
                $datepublicationannee = $1;
             }
        }
     
        for(my $i=$indiceInitial; $i<=$indiceFinal; $i++){
           $chapitres[$n].= $lignes[$i];
        }          
        $n++;  # Nous incrémentons le nombre de chapitre de 1.
   }
  
    
   # Vérification que la page de couverture existe, sinon téléchargement d'une page
   # de couverture par défaut (réalisée pour ce projet).
   if (!defined $cover) {
       $cover = 'http://i64.tinypic.com/5mybg9.jpg';
   }
   
   # Vérification que le nombre de chapitre existe,
   # sinon nous indiquons qu'il n'y a qu'un chapitre
   if (!defined $nbdechapitres) {
       $nbdechapitres = 1 ;
   }


   
   # Ici nous téléchargons la couverture du livre et la renommerons cover.jpeg ;
   # ce qui aura opur effet d'écraser les covers précédentes   
   getstore("$cover","cover.jpeg");
   
   # On crée un objet EPUB
   my $epub = EBook::EPUB::Lite->new();
   
   
   EBook::EPUB::Lite::add_language( $epub, 'fr' );
   
   if ($datepublicationannee ne '') {
       $datecomplete = "$datepublicationjourmois.'/'.$datepublicationannee" ;
   }
   
   else {
       $datecomplete = "$datepublicationjourmois" ;   
   }
   
   # print Dumper $epub;      # Pour voir la progression de la création de chaque Epub Dumper $epub est utile
                              # Pour garder l'interface de l'utilisateur le plus épuré possible, nous désactivons ceci.
   
   # On ajoute quelques métadonnées (facultatives) à l'EPUB
   $epub->add_title(''.$titrelivre);                                  # titre
   $epub->add_author(''.$auteur);                                     # auteur
   $epub->add_language(''.$langue);                                   # langue
   $epub->add_date(''.$datecomplete);                                 # date
   $epub->add_description(''.$resume);                                # description
   $epub->add_publisher('https://www.fanfiction.net');                # éditeur
   $epub->add_type(''.$rating);                                       # type de récit selon https://www.fictionratings.com/    
   $epub->add_identifier('Fanfiction au format pub grâce à Epub_Creator.pl');   # Information sur le programme
   
   # On ajoute une image de couverture
   my $cover_id = $epub->copy_image( 'cover.jpeg', 'cover.jpeg' );
   
   
   # Et on fait en sorte qu'elle puisse être utilisée comme vignette
   # par certains programmes
   $epub->add_meta_item( 'cover', $cover_id );
   
   # On ajoute une page de couverture
   my $cover_page = '<?xml version="1.0" encoding="utf-8"?>
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
     "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
     <html xmlns="http://www.w3.org/1999/xhtml">
       <head><title></title></head>
       <body>
         <img src="cover.jpeg"/>
       </body>
     </html>
   ';
   my $cover_page_id = $epub->add_xhtml( 'cover.html', $cover_page );
   
   # On ajoute un faux-titre
   my $halftitle_page = '<?xml version="1.0" encoding="utf-8"?>
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
     "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
     <html xmlns="http://www.w3.org/1999/xhtml">
       <head><title></title></head>
       <body>
         <center>
         <h1>'.$titrelivre.'&nbsp;</h1>
         <h2><i> By '."$auteur".'</i></h2>
         </center>
         <p>'."\n $resume\n".'</p>
         <p>'."Rating : $rating"." - Langue : $langue"." - Genre : $genre".
            " - Personnage(s) présent(s) : $personnage"." - Nombre de chapitre : $nbdechapitres".
            ' - URL : '.'<a href="'.$url_local.'">'."$url_local".'</a>'.'<\p>
       </body>
     </html>
   ';
   my $halftitle_page_id = $epub->add_xhtml( 'halftitle.html', $halftitle_page );
   
 
   # On ajoute une table des matières
   $epub->add_navpoint(
       label      => "couverture",
       id         => $cover_page_id,
       content    => 'cover.html',
       play_order => 1
   );
   
   
   # On crée chacun des chapitres et on les ajoutes dans la table des matières.
   
   foreach(my $m=0 ; $m < $nbdechapitres ; $m++) {
   my $chapter_html  = '<?xml version="1.0" encoding="utf-8"?>
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
     "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
   <html xmlns="http://www.w3.org/1999/xhtml">
     <head><title></title></head>
     <body>
     <center>
       <h2>Chapitre '.($m+1).' </h2>
       <h2>'.$titreschapitres[$m].'</h2>
       </center>
       '.$chapitres[$m].'
     </body>
   </html>
   ';
   
   my $chapitre_id = $epub->add_xhtml('chapter_'.($m+1).'.html', $chapter_html);
   
   $epub->add_navpoint(
       label      => "Chapitre ".($m+1)."$titrechapitre",
       id         => $chapitre_id,
       content    => 'chapter_'.($m+1).'.html',
       play_order => $m+2);
   }
    # On génère l'EPUB
   if (! defined $titrelivre){
      $epub->pack_zip("livre_$j.epub");   
    }
   else {
      $epub->pack_zip("$titrelivre.epub");
   }
   
    # Nous l'indiquons à l'utilisateur
    # Il faut préalablement caster la variable
    my $nombrederesultats = $nombreatelecharger;
    my $nombrefinal = $nombrederesultats-$j;
    mise_en_page::livres_dispo ("$titrelivre", "$nombrefinal");
    $j++;
         
 }
}

1;

