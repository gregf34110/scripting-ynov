#!/bin/bash

########################################
# Variables globales
########################################

SCRIPT_VERSION="2.2"
SCRIPT_AUTHOR="Gregory FUENTES"










########################################
# Fonctions
########################################

# --- Fonction pour afficher le menu contextuel --- #
#Objectif: Afficher le menu contextuel 
affichage_menu () {
echo -e "----------------------------------------------------------------\n"
echo -e "----------------------------------------------------------------\n"
echo -e "Choix 1: Lister tous les fichiers du dossier courant\n"
        echo -e "Choix 2: Créer un nouveau fichier\n"
        echo -e "Choix 3: Supprimer un fichier\n" 
        echo -e "Choix 4: Afficher le contenu d’un fichier\n"
        echo -e "Choix 5: Quitter le script\n"
echo -e "----------------------------------------------------------------\n"

}





# --- Fonction pour lister les fichiers présents dans le répertoire courant --- #
# Objectif: Lister les fichiers du dossier courant
lister_fichier() {
	#Récupération du dossier courant
	local dossier_courant=$(pwd)
        echo -e "Le dossier courant est : ${dossier_courant}"
        echo -e "les fichier présent dans le dossier courant sont: \n"
        for file in "$dossier_courant"/*; do 
        	if [ -f "$file" ]; then
                	basename "$file"
                fi
        done
}


# --- Fonction pour demander une confirmation (Oui/Non) ---
# Objectif: Demande à l'utilisateur si ce qu il a rentré est correct ou pas
# Retourne 0 pour Oui (succès), 1 pour Non (échec)
confirm_action() {
    local question="$1" # Récupère la question passée en premier argument
    local reponse=""   # Initialise une variable pour stocker la réponse de l'utilisateur

    while true; do
        read -r -p "${question} (Y/N): " reponse # Affiche la question et attend la saisie.

        case "$reponse" in
            [Yy]* ) return 0 ;; # Si la réponse commence par 'Y' ou 'y', la fonction retourne 0 (succès)
            [Nn]* ) return 1 ;; # Si la réponse commence par 'N' ou 'n', la fonction retourne 1 (échec)
            * ) echo "Veuillez répondre par Y ou N." ;; 
        esac
    done
}

# --- Fonction pour créer un nouveau fichier ---
creer_fichier() {
    local new_file="" # Déclare la variable new_file

    while true; do # 
        # 1.1 Demander le nom du nouveau fichier
        while [ -z "${new_file}" ]; do
            read -r -p "SAISIR LE NOM DU NOUVEAU FICHIER: " new_file

	#1.2 On s'assure que l'utilisateur saisit bien quelque chose
            if [ -z "${new_file}" ]; then
                echo "Le nom du fichier ne peut pas être vide. Veuillez réessayer."
            fi
        done

        # 2. Afficher le nom du fichier et demander confirmation
        echo -e "Le nom du nouveau fichier est : ${new_file}\n"
        if confirm_action "Est-ce que le nom du fichier est correct ?"; then #3.0 Si le nom du fichier est correct alors je le crée

	#3.1. Vérification que le nom du fichier n'existe pas
            if [ -e "$new_file" ]; then
                echo -e "Le fichier ${new_file} existe déjà.\n"

       #3.1.2. Si le nom du fichier existe, on donne le choix à l'utilisateur : annuler ou essayer un autre nom
                if confirm_action "Voulez-vous choisir un autre nom de fichier ?"; then
                    new_file="" # Réinitialise pour redemander un nom
                    continue    # Retourne au début de la boucle'
                else
                    echo "Création du fichier annulée."
                    return 1 # Sort de la fonction si l'utilisateur ne veut pas changer de nom
                fi
            else
                echo -e "Création du fichier...\n"
                sleep 1
                touch "$new_file"
                echo -e "Le fichier '${new_file}' a été créé avec succès.\n"
                break
            fi
        else
            # 4. Sinon (si le nom n'est pas correct), je lui redemande le nom du fichier
            echo -e "Le fichier n'a pas été créé.\n"
            new_file="" # Réinitialise new_file pour que la boucle redemande un nom
        fi
    done
}


#--- Fonction pour supprimer un fichier ---#
supression_fichier () {
    local rm_file="" 
    while true; do 

        # 1. Demander le nom du fichier à supprimer
        while [ -z "${rm_file}" ]; do
            read -r -p "SAISIR LE NOM DU FICHIER À SUPPRIMER: " rm_file

            #1.1 Vérification de la saisit
            if [ -z "${rm_file}" ]; then
                echo "Le nom du fichier ne peut pas être vide. Veuillez réessayer."
            fi
        done

        # 2. Afficher le nom du fichier et demander confirmation
        echo "Le nom du fichier à supprimer est : ${rm_file}"
        if confirm_action "Confirmez-vous la suppression de '${rm_file}' ?"; then
            echo "coucou"

            # 3. Vérifier si le fichier existe avant de tenter la suppression
            if [ -e "$rm_file" ]; then # Vérifie si le fichier existe
                echo "Le fichier '${rm_file}' est en cours de suppression..."
                sleep 1
                if rm -f "$rm_file"; then 
                    echo "Le fichier '${rm_file}' a été supprimé avec succès."
                    break 
                
                fi
            else
                echo "Le fichier '${rm_file}' n'existe pas."
                # Demander à l'utilisateur s'il veut choisir un autre nom
                if confirm_action "Voulez-vous choisir un autre fichier à supprimer ?"; then
                    rm_file="" # Réinitialise pour redemander un nom
                    continue   # Retourne au début de la boucle 'while true'
                else
                    echo "Suppression du fichier annulée."
                    return 1 # Sort de la fonction si l'utilisateur ne veut pas changer de nom
                fi
            fi
        fi
    done
}






#######################
# Code Principal #
#######################

# --- Gestion des options d'aide et version --- #
while getopts "hv" opt; do
	case $opt in
	h)
		echo -e "Usage: bash gestion.sh [-h help] [-v version]"
		echo -e 
		exit 0
	;;
	v)
		echo -e "Numéro de Version: ${SCRIPT_VERSION} "
		echo -e  "Nom de l'auteur: ${SCRIPT_AUTHOR}"
		exit 0
	;;
	*)
		echo "Option invalide"
		exit 1
	;;
	esac
done

# --- Affichage du menu ---

while true; do
	affichage_menu

# --- Demande le choix de l'utilisateur ---#
	read -r -p "Veuiller faire un choix entre 1 et 5: " choix

        case "$choix" in





# -- L'utilisateur a fait le choix 1 --- #
#Objectif: Lister tous les fichiers du dossier courant
                1) 
                        echo -e "Choix 1 : Lister tous les fichiers du dossier courant\n"
			lister_fichier
			sleep 2
                ;;





# --- L'utilisateur a fait le choix 2 --- #
# Objectif: Créer un nouveau fichier (nom demandé à l’utilisateur)
                2)
                        echo -e "Choix 2: Créer un nouveau fichier\n"
			creer_fichier
		sleep 2
        ;;


# --- L'utilisateur a fait le choix 3 --- #
#Objectif: Supprimer le fichier (nom demandé par l'utilisateur)

# Choix3: Supprimer un fichier (avec vérification d’existence)
        3)

                echo -e "Choix3: Supprimer un fichier (avec vérification d’existence)\n"
                supression_fichier
                sleep 2
        ;;

4)
                echo -e "Choix 4: Afficher le contenu d’un fichier "

                affichage_fichier="non"

                while [[ "$affichage_fichier" == "non" ]]; do #TANT QUE AFFICHAGE DU FICHIER EGAL NON

                        #On demande le nom du fichier à afficher
                        while [ -z "${cat_file}" ]; do  # TANT QUE CAT FILE EST VIDE ALORS JE REDEMANDE DE SAISIR LE NOM du FICHIER A lire
                            read -r -p "SAISIR LE NOM DU FICHIER A Afficher: " cat_file 
                        done 

                        # On affiche le nom du fichier a afficher
                        echo -e "Le nom du fichier a afficher est : ${cat_file} \n" 


                        #On demande si cela est correct
                        while [ -z "${correct}" ]; do # TANT QUE CORRECT EST VIDE ALORS JE REDEMANDE LA SAISIE DE L UTILISATEUR (Y / N)
                                    read -r -p "Est ce que c'est correct ? (Y / N): " correct 
                        done

                        # Si le nom du fichier a afficher est correct alors on l'affiche
                        if [[ "$correct" == "Y" || "$correct" == "y" ]]; then # SI c'est correct alors je crée le fichier et supression fichier = oui
# Vérifier si le fichier existe déjà
                                        if [[ -e "$cat_file" ]]; then
                                            echo -e "Le fichier ${cat_file} est en cours d ouverture ...\n"
                                            sleep 2
                                            cat "$cat_file"
                                            affichage_fichier="oui" 
                                            break
                                        else
                                            echo -e "le fichier n'existe pas"
                                            break
                                         fi


                        # Si le nouveau nom du fichier est incorrect alors je redemande le nom du fichier

                        elif [[ "$correct" == "N" || "$correct" == "n"  ]]; then
                                echo -e "LE fichier n a pas ete supprimé\n"
                                cat_file=""
                                correct=""
                        # Si l'utilisateur n'as pas entrer Y ou N alors je redemande la saisi de Y ou N 
                        else
                                echo -e "Merci de saisir Y ou N \n"
                                correct=""
                        fi


                done
		sleep 2


        ;;
5)
                echo -e "A bientôt !!!! \n"
                break
        ;;      

        *)
                echo -e "\n Choix incorrect \n"
                exit 1
        ;;      

esac
done
