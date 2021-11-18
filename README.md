# Hackathon : application bureau

La conception et le développement de ce projet s'est effectué dans le cadre de la formation de Simplon. Il s'agit ici de la partie application bureau nécessaire à l'obtention du titre.

## Technologie

On utilise ici la technologie suivante :

- Flutter

## Initialisation du projet

Après avoir fait un git clone de ce projet, vous devez utiliser les commandes citées ci-dessous.

<br>

Cette ligne de commande permettra de s'assurer que les dépendances nécessaires au bon fonctionnement de l'application sont bien installées

- flutter pub get

Cette ligne de commande permet de lancer l'application mobile en mode debug :

- flutter run -d windows --no-sound-null-safety

## Pour générer l'application desktop :

Il faut utiliser une des commandes listées ci-dessous suivant votre environnement :

- flutter build windows --no-sound-null-safety
- flutter build macos --no-sound-null-safety
- flutter build linux --no-sound-null-safety