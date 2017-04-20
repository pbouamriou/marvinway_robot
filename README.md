# marvinway
Source du projet Marvin Way (le segway depressif O_o)

## Programme de test ##

### Installation de la chaine de compilation Teensy ###

Suivre les instructions [Débuter avec teensy](https://openclassrooms.com/courses/debuter-dans-l-informatique-embarquee-avec-teensy).

Installer tout de meme la toolchain Arduino dans le répertoire /opt car ça permettra à cmake de trouver automatiquement la toolchain.

### Installation de teensy_loader_cli

Pour permettre à cmake d'installer votre programme sur la teensy

Executez simplement les commandes suivantes depuis le dépot marvin

_Installation de teensy_loader_cli
~~~{.sh}
cd src/teensyLoaderCli/
chmod 755 teensyLoaderCli.sh # si nécéssaire
./teensyLoaderCli.sh
~~~

### Compilation ###

_Compilation du programme de test blink sous linux_

~~~{.sh}
cd src/test_blink
./configure
(cd build && cmake )
~~~

Voila c'est compilé, un fichier blink.hex est disponible sous build/blink

il est meme possible de produire et installer le programme grâce à cmake (programme test_blink par example) :

~~~{.sh}
cd src/test_blink
./configure
(cd build && cmake blink-upload )
~~~


### Test du programme ###

Suivre les memes instructions décrites par le site [Débuter avec teensy](https://openclassrooms.com/courses/debuter-dans-l-informatique-embarquee-avec-teensy).
