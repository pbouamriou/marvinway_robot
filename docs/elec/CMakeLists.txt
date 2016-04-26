cmake_minimum_required(VERSION 2.6)
  

#Déclaration du projet
project(elechronique NONE)

SET(LATEX_OUTPUT_PATH build)
#http://public.kitware.com/Wiki/images/d/d7/UseLATEX.pdf
INCLUDE(UseLATEX.cmake)

#Génération de la liste des fichiers sources
add_latex_document(elec.tex)
