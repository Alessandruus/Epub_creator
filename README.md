# Epub_creator

Ce programme assure deux fonctions :

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

```
cpan install LWP::Simple
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

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
