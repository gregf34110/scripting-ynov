#Fonction 3:
#Objectif: Une fonction décorée (ex: log_execution) qui affiche un message avant et après l'appel d'une autre fonction. 
import functools
def log_execution(func):

    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        print(f"--- Début de l'exécution de '{func.__name__}' ---")
        result = func(*args, **kwargs)
        print(f"--- Fin de l'exécution de '{func.__name__}' ---")
        return result
    return wrapper


# Fonction 1: 
# Objectif: Une fonction de formatage de texte (ex: capitalize_all) qui met en majuscules toutes les lettres d'une phrase.
@log_execution
def capitalize_all(text):
    return text.upper()

#Fonction 2: 
#Objectif: fonction add_numbers qui prend une liste de nombres et retourne la somme.
@log_execution
def add_numbers (liste_nombre):
    somme_total = 0
    for number in liste_nombre:
        somme_total += number
    return somme_total

#Fonction 3:
#Objectif: Une fonction décorée (ex: log_execution) qui affiche un message avant et après l'appel d'une autre fonction. 
import functools
def log_execution(func):

    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        print(f"--- Début de l'exécution de '{func.__name__}' ---")
        result = func(*args, **kwargs)
        print(f"--- Fin de l'exécution de '{func.__name__}' ---")
        return result
    return wrapper
