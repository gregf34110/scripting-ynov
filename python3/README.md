# Objectif du projet

Ce projet est une petite application en ligne de commande (CLI) développée en Python. Elle utilise la bibliothèque `Click` pour créer une interface interactive et démontre la modularité du code avec des fonctions utilitaires organisées dans un module séparé.

---

## Objectif du Script

Le script `main.py` offre deux fonctionnalités principales via des commandes CLI :

1.  **`capitaliser <texte>`** : Prend une chaîne de caractères en entrée et la convertit entièrement en majuscules.
2.  **`somme <nombre1> <nombre2> ...`** : Prend une liste de nombres en entrée et calcule leur somme totale.

Ces fonctionnalités sont implémentées dans le fichier `utils/helpers.py`. De plus, toutes les fonctions de ce module sont décorées avec `log_execution`, ce qui affiche automatiquement des messages au début et à la fin de leur exécution pour faciliter le suivi.

---

## Installation de l'Environnement et Exécution du Script

Ce projet utilise [**Poetry**](https://python-poetry.org/) pour gérer les dépendances et l'environnement virtuel.

### Prérequis

* **Python 3.12** ou une version compatible (selon `pyproject.toml`).
* **Poetry** installé sur votre système. Si ce n'est pas le cas, suivez les instructions officielles d'installation de Poetry :
    * **macOS / Linux / WSL :**
        ```bash
        curl -sSL [https://install.python-poetry.org](https://install.python-poetry.org) | python3 -
        ```
    * **Windows (PowerShell) :**
        ```powershell
        (Invoke-WebRequest -Uri [https://install.python-poetry.org](https://install.python-poetry.org) -UseBasicParsing).Content | python -
        ```
    Après l'installation de Poetry, il peut être nécessaire de fermer et rouvrir votre terminal.

### Installation des Dépendances

1.  **Clonez le dépôt** (si applicable) ou naviguez vers le dossier racine de votre projet.
2.  **Installez les dépendances du projet** : Poetry va créer un environnement virtuel et y installer toutes les dépendances listées dans `pyproject.toml`.
    ```bash
    poetry install
    ```
    *(Note : Les dépendances `click` et `requests` sont listées dans `pyproject.toml`.)*
3. apt install click

### Exécution du Script

Une fois les dépendances installées, vous pouvez exécuter le script via Poetry.

1.  **Afficher l'aide générale et les commandes disponibles :**
    ```bash
    poetry run python main.py --help
    ```

2.  **Utiliser la commande `capitaliser` :**
    ```bash
    poetry run python main.py capitaliser "votre texte a capitaliser"
    ```
    *Exemple :*
    ```bash
    poetry run python main.py capitaliser "bonjour la cli"
    ```

3.  **Utiliser la commande `somme` :**
    ```bash
    poetry run python main.py somme 10 20 5.5 1.5
    ```
    *Exemple :*
    ```bash
    poetry run python main.py somme 7 3 15
    ```

---

N'hésitez pas à explorer le code dans `utils/helpers.py` pour comprendre comment les fonctions sont définies et décorées.























#Mise en place un environnement virtuel avec Poetry ou Pipenv

#Création d'un environnement virtuel python .venv
greg@VM-Greg:~/scripting/python3$ python3 -m venv .venv

#Activation de l'environnement virtuel 
greg@VM-Greg:~/scripting/python3$ source .venv/bin/activate

#Installation de l'outil poetry
(.venv) greg@VM-Greg:~/scripting/python3$ pip install poetry

#Initialisation de poetry 
(.venv) greg@VM-Greg:~/scripting/python3$ poetry init

This command will guide you through creating your pyproject.toml config.

Package name [python3]:  python3_projet
Version [0.1.0]:  1.0.0
Description []:  Script d'initiation à Python 3
Author [gregf34110 <gregoryf34110@gmail.com>, n to skip]:  
License []:  
Compatible Python versions [>=3.12]:  

Would you like to define your main dependencies interactively? (yes/no) [yes] 
        You can specify a package in the following forms:
          - A single name (requests): this will search for matches on PyPI
          - A name and a constraint (requests@^2.23.0)
          - A git url (git+https://github.com/python-poetry/poetry.git)
          - A git url with a revision         (git+https://github.com/python-poetry/poetry.git#develop)
          - A file path (../my-package/my-package.whl)
          - A directory (../my-package/)
          - A url (https://example.com/packages/my-package-0.1.0.tar.gz)
        
Package to add or search for (leave blank to skip): 

Would you like to define your development dependencies interactively? (yes/no) [yes] 
Package to add or search for (leave blank to skip): 

Generated file

[project]
name = "python3-projet"
version = "1.0.0"
description = "Script d'initiation à Python 3"
authors = [
    {name = "gregf34110",email = "gregoryf34110@gmail.com"}
]
readme = "README.md"
requires-python = ">=3.12"
dependencies = [
]


[build-system]
requires = ["poetry-core>=2.0.0,<3.0.0"]
build-backend = "poetry.core.masonry.api"


Do you confirm generation? (yes/no) [yes] y


