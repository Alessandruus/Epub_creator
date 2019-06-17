# Epub_creator

Ce programme écrit en perl assure deux fonctions :

    1) Télécharger une fanfiction depuis le site www.fanfiction.net 
    directement au format epub depuis l'URL de la fanfiction de votre choix.

    2) Parcourir au travers d'une série de questions les critères de sélections
    des fanfictions disponibles sur le site www.fanfiction.net et télécharger
    la ou les fanfictions correspondant aux choix de l'utilisateur.

Ce programme s'utilise depuis l'invite de commande.

## Bien démarrer

Télécharger ce projet github dans son ensemble et/ou dézipper l'archive dans un dossier de votre choix. 
Attention, tous les éléments de l'archive : Epub_creator.pl, navigation.pm, mise_en_page.pm et module_epub.pm 
doivent être dans le même dossier pour que le programme puisse fonctionner.   

### Prérequis

Il est nécessaire de télécharger un module supplémentaire pour faire fonctionner ce programme.
Le module LWP::Simple est disponible depuis le site web www.metacpan.org précisément à l'adresse suivante :
https://metacpan.org/pod/LWP::Simple.

Pour télécharger le module LWP::Simple suivez les étapes suivantes.

Sur Windows : ouvrez l'invite de commande 
(depuis la barre de cherche en bas à gauche tapez cmd et cliquer sur l'application Invite de commande).

Ecrivez sur l'invite de commande la ligne suivante :

```
cpan install LWP::Simple
```
Attendez que l'installation ce termine.

Sur mac : ouvrez l'invite de commande (ou Terminal)
(depuis la barre de recherche en haut à droite tapez Terminal et cliquer sur l'application pour l'ouvrir).

Ecrivez la ligne suivante :

```
cpan LWP::Simple
```
Attendez que l'installation ce termine.

Sur Linux : ouvrez l'invite de commande via le raccourci Ctrl+Alt+T 
ou bien cliquer dans vos programme sur l'application Terminal.

Ecrivez la ligne suivante :

```
cpan LWP::Simple
```
Attendez que l'installation ce termine.

## Lancez Epub_creator

Avant de lancer le programme assurez-vous d'avoir dans le dossier de votre choix 
l'ensemble des éléments nécessaires (Epub_creator.pl, navigation.pm, mise_en_page.pm et module_epub.pm).

Assurez-vous aussi de savoir où se trouve ce dossier dans votre ordinateur, il sera nécessaire 
depuis l'invite de commande (ou Terminal) d'y accéder.

Nous prendrons pour exemple un dossier créer sur le bureau (depuis windows).

Ouvrez l'invite de commande (ou Terminal) et localiser le dossier en question.

Dans notre cas, l'invite de commande au démarrage indique :

```
C:\Users\aless>
```
Pour trouver le dossier en question, nous utiliserons la commande cd (pour change directory).

Nous écrivons : cd desktop
```
C:\Users\aless>cd desktop
```

Puis : cd Epub_creator-master (nom de notre archive dézippée).
```
C:\Users\aless\Desktop>cd Epub_creator-master
```

Enfin nous pouvons lancer le programme avec la fonction : perl Epub_creator.pl
```
C:\Users\aless\Desktop\Epub_creator-master>perl Epub_creator.pl
```

Si le programme est correctement lancé [la page d'accueil](/Images/acceuil.png) doit être apparue.

Vous pouvez commencer à utiliser le programme.

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Alessandro Cierro** - *LFIAL2630 - Méthodologie du traitement automatique des données textuelles* - Alessandro.Cierro@uclouvain.be

## Licence

Ce programme est sous "licence artistique" (the Artistic License) - les informations complètes sont disponibles ici : https://dev.perl.org/licenses/artistic.html

Voici des extraits de la licence artistique : 

1. You may make and give away verbatim copies of the source form of the
Standard Version of this Package without restriction, provided that you
duplicate all of the original copyright notices and associated disclaimers.

4. You may distribute the programs of this Package in object code or
executable form, provided that you do at least ONE of the following:

    a) distribute a Standard Version of the executables and library files,
    together with instructions (in the manual page or equivalent) on where
    to get the Standard Version.

    b) accompany the distribution with the machine-readable source of
    the Package with your modifications.

    c) give non-standard executables non-standard names, and clearly
    document the differences in manual pages (or equivalent), together
    with instructions on where to get the Standard Version.

    d) make other distribution arrangements with the Copyright Holder.

6. The scripts and library files supplied as input to or produced as
output from the programs of this Package do not automatically fall
under the copyright of this Package, but belong to whoever generated
them, and may be sold commercially, and may be aggregated with this
Package.  If such scripts or library files are aggregated with this
Package via the so-called "undump" or "unexec" methods of producing a
binary executable image, then distribution of such an image shall
neither be construed as a distribution of this Package nor shall it
fall under the restrictions of Paragraphs 3 and 4, provided that you do
not represent such an executable image as a Standard Version of this
Package.

10. THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
