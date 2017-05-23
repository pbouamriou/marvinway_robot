# Teensy CMake

## Informations
Cette toolchain est compatible avec Arduino 1.8.2 et teensyduino 1.36.

Ce projet est conçus pour être utilisé en tant que [sous module git](https://git-scm.com/book/fr/v2/Utilitaires-Git-Sous-modules) dans votre projet.

## Prérequis
### Installer Arduino 1.8.2
Vous devez installer [Arduino 1.8.2](https://git-scm.com/book/fr/v2/Utilitaires-Git-Sous-modules)
dans **/opt/arduino/** pour que le SDK arduino ainsi la toolchain pourra détecter le SDK arduino

Si vous ne savez pas comment installer Arduino je vous conseille de suivre cette [procédure] 
(https://www.hackster.io/strasserpatrick/install-arduino-ide-1-8-2-on-linux-8ef105) fonctionnelle sous debian 8

### Installer Teensyduino 1.36
Pour installer Teensyduino v1.36 suivre la procédure décrite sur le site de 
[teensy](https://www.pjrc.com/teensy/td_download.html)

### Compiler et Installer Teensyloader
Après avoir compilé le **teensyloader_cli** copier le dans **/opt/teensyloader_cli**
ainsi la toolchain pourra détecter le teensyloader_cli

Voici les [étapes](https://github.com/PaulStoffregen/teensy_loader_cli) pour compiler **teensy_loader_cli**

## Utilisation de Teensy CMake
- Créez votre projet git
- Ajouter ce dépot en tant que sous module 

```bash
git submodule add git@gitlab.42pillistreet.com:marvin/teensy_cmake.git
```

- Créez votre fichier CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 2.8)
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/teensy_cmake/teensy-arm.toolchain.cmake")

project(blink C CXX)

macro(use_cxx11)
  if (CMAKE_VERSION VERSION_LESS "3.1")
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
      set (CMAKE_CXX_FLAGS "--std=gnu++11 ${CMAKE_CXX_FLAGS}")
    endif ()
  else ()
    set (CMAKE_CXX_STANDARD 11)
  endif ()
endmacro(use_cxx11)

use_cxx11()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/teensy_cmake)
set(TEENSY_USB_MODE SERIAL)
add_teensy_executable(blink blink.cpp)
configure_teensy_upload(blink mk20dx256) # you must specify the sane name than the executable mk20dx256 Teensy 3.1
```

- Voici le fichier blink.cpp d'exemple

```c++
/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
  Example uses a static library to show off generate_arduino_library().
 
  This example code is in the public domain.
*/
#if ARDUINO >= 100
    #include "Arduino.h"
#else
    #include "WProgram.h"
#endif

const int led = LED_BUILTIN;

void setup() {                
  pinMode(led, OUTPUT);
}

void loop() {
  digitalWrite(led, HIGH);
  delay(1000);
  digitalWrite(led, LOW);
  delay(1000);
}
```

- Initialisez votre projet puis compilez le

```bash
mkdir build
cd build
cmake ..
make
make upload
```

- Maintenant appuyez sur le bouton reset de votre teensy et voilà ! :D
