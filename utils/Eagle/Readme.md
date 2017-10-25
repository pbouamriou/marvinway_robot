# Configuration de Eagle

## Ajouter une librairie

- Aller dans le `Control Panel -> Directories`
   ![ControlPanel](https://cdn.sparkfun.com/assets/7/3/a/7/0/51f6d989ce395fd16d000004.png)
- Dans le premier champ ajouter le répertoire où se trouve les librairies
  (Le répertoire Libs contient des exemples de librairies utilisées dans des projets de Marvin)
- Pour Utiliser la librairie dans Eagle 
  - Il faut l'activer en affichant la liste `Libraries`

  - Cliquez droit sur la librairie Sparkfun puis appuyez sur use all

    ![Utilisation d'une librairie](https://cdn.sparkfun.com/assets/3/3/f/4/a/51f6ea91ce395f8269000004.png)




## Configurer l'interface de création de la carte

Depuis l'interface de création de carte (board)  cliquez sur l'icones de script ![scr](https://cdn.sparkfun.com/assets/3/c/6/8/5/51f7ee2e757b7fbe1c83a90f.png) puis chargez le fichiers ConfigurationScript/spk.scr

## Informations Utiles

### Design Rule Check

Pour vérifier que la carte conçu respecte les bonnes pratiques de l'imprimeur il faut utiliser les Design Rules du constructeur. Sparkfun fourni ses propres règles de design de cartes  vous pouvez les trouver dans le répertoire EagleDesignRules.

Pour charger les règles de design il faut appuyer sur l'icône ![DRC icon](https://cdn.sparkfun.com/assets/6/1/d/4/e/52054ea2757b7f5f11191e82.png) DRC icon une interface va apparaitre appuyer sur Load

![DRC](https://cdn.sparkfun.com/assets/1/f/2/7/2/52054f04757b7f1d12530335.png)

### Synchronisation entre schéma et board

Pour conserver la synchronisation entre le fichier board et le fichier schematic penser à bien les garder ouvert en même temps


## Sources

https://github.com/sparkfun/SparkFun-Eagle-Libraries

https://learn.sparkfun.com/tutorials/how-to-install-and-setup-eagle

https://learn.sparkfun.com/tutorials/using-eagle-schematic

https://learn.sparkfun.com/tutorials/using-eagle-board-layout