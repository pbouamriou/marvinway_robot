# marvinway
Source du projet Marvin Way (le segway depressif O_o)

## Programme de test ##

### Installation de la chaine de compilation Teensy ###

Suivre les instructions [Débuter avec teensy](https://openclassrooms.com/courses/debuter-dans-l-informatique-embarquee-avec-teensy).

Installer tout de meme la toolchain Arduino dans le répertoire /opt car ça permettra à cmake de trouver automatiquement la toolchain.

### Compilation ###

_Compilation du programme de test sous linux_

~~~{.sh}
cd src/test
./configure
(cd build && cmake )
~~~

Voila c'est compilé, un fichier blink.hex est disponible sous build/blink

### Test du programme ###

Suivre les memes instructions décrites par le site [Débuter avec teensy](https://openclassrooms.com/courses/debuter-dans-l-informatique-embarquee-avec-teensy).
