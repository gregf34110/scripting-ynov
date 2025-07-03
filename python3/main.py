# Importation des modules 
import click
from utils.helpers import capitalize_all
from utils.helpers import add_numbers
from utils.helpers import log_execution


#Fonction CLI
@click.group()
def cli():
    """
    Bienvenue dans votre programme CLI !
    Utilisez les commandes ci-dessous pour interagir avec les fonctions de helpers.py.
    """
    pass

@cli.command()
@click.argument('texte')
def capitaliser(texte):
    """
    Met une phrase en majuscules en utilisant la fonction de helpers.py.

    Exemple: python main.py capitaliser "bonjour le monde"
    """
    try:
        resultat = capitalize_all(texte)
        click.echo(f"Phrase originale: {texte}")
        click.echo(f"Phrase transformée: {resultat}")
    except TypeError as e:
        click.echo(f"Erreur: {e}", err=True)

@cli.command()
@click.argument('nombres', nargs=-1, type=float)
def somme(nombres):
    """
    Calcule la somme d'une liste de nombres en utilisant la fonction de helpers.py.

    Exemple: python main.py somme 10 20 5.5
    """
    try:
        liste_nombres = list(nombres)
        if not liste_nombres:
            click.echo("Veuillez fournir au moins un nombre à additionner.", err=True)
            return

        resultat = add_numbers(liste_nombres)
        click.echo(f"Nombres: {liste_nombres}")
        click.echo(f"Somme: {resultat}")
    except TypeError as e:
        click.echo(f"Erreur: {e}", err=True)


# Fonction Principal
cli()


"""
# FONCTION 1: capitalize_all
print ("Transformation de la phrase en majuscule ...")
ma_phrase = "hello word !"
phrase_transformee = capitalize_all(ma_phrase)
print(f"Phrase originale : {ma_phrase}")
print(f"Phrase transformée : {phrase_transformee}")
print ("transformation finie !!!")

# FONCTION 2: add_numbers
print ("\ncalcul de la somme de la liste de nombre ...")
liste_nombre = [2, 5, 6, 7] #20
somme = add_numbers(liste_nombre)
print(f"La somme des nombres {liste_nombre} est : {somme}")
"""




