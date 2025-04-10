#!/bin/bash

#Affichage de la version si demandé
if [[ $1 == "-v" || $1 == "--version" ]]; then
	echo -e "\nNuméro de Version: 1.0 "
	echo -e  "Nom de l'auteur: Gregory FUENTES"
	exit 0
fi

#Affichage de la version si demandé
if [[ $1 == "-h" || $1 == "--help" ]]; then
	echo -e "usage: bash gestion.sh [-h help | -v version] "
	echo -e "Avant lancement du script, s'assurer d'avoir les droits d'execution: ( chmod +x gestion.sh )"
	exit 0
fi




#Affichage du menu 
echo -e "\n \n"
echo -e "Choix 1: Lister tous les fichiers du dossier courant\n"
echo -e "Choix 2: Créer un nouveau fichier\n"
echo -e "Choix 3: Supprimer un fichier\n" 
echo -e "Choix 4: Afficher le contenu d’un fichier\n"
echo -e "Choix 5: Quitter le script\n"

read -p "Veuiller faire un choix entre 1 et 5: " choix



case "$choix" in

	#Choix 1: Lister tous les fichiers du dossier courant

	1) 
		echo -e "Choix 1: Lister tous les fichiers du dossier courant\n"

		#Récupération du dossier courant
		dossier_courant=$(pwd)
		echo "Le dossier courant est : ${dossier_courant}"
		for file in "$dossier_courant"/*; do 
			if [ -f "$file" ]; then
				echo "$(basename "$file")"
			fi
		done
	;;
		


	#Choix 2: Créer un nouveau fichier (nom demandé à l’utilisateur)

	2)

		echo -e "Choix 2: Créer un nouveau fichier\n"
		creation_fichier="non"

		while [[ "$creation_fichier" == "non" ]]; do

			#On demande le nom du nouveau fichier
			while [ -z "${new_file}" ]; do  # TANT QUE NEW FILE EST VIDE ALORS JE REDEMANDE DE SAISIR LE NOM DU NOUVEAU FICHIER
			    read -p "SAISIR LE NOM DU NOUVEAU FICHIER: " new_file a
			done 

			# On affiche le nom du nouveau fichier
			echo -e "Le nom du nouveau fichier est : ${new_file} \n" 


			#On demande si cela est correct
			while [ -z "${correct}" ]; do # TANT QUE CORRECT EST VIDE ALORS JE REDEMANDE LA SAISIE DE L UTILISATEUR (Y / N)
				    read -p "Est ce que c'est correct ? (Y / N): " correct a
			done

			# Si le nouveau nom du fichier est correct alors je le créer
			if [[ "$correct" == "Y" || "$correct" == "y" ]]; then # SI c'est correct alors je crée le fichier et création fichier = oui

				# Vérifier si le fichier existe déjà
				        if [[ -e "$new_file" ]]; then
				            echo -e "Le fichier ${new_file} existe déjà.\n"
				            creation_fichier="non" 
				            break
				        else
				            echo -e "Création du fichier\n"
				            sleep 1 
				            touch "$new_file"
				            echo -e "LE fichier a été créé \n"
				            creation_fichier="oui"  # Le fichier est créé, on sort de la boucle
				        fi


			# Si le nouveau nom du fichier est incorrect alors je redemande le nom du fichier

			elif [[ "$correct" == "N" || "$correct" == "n"  ]]; then
				echo -e "LE fichier n a pas ete cree\n"
				new_file=""
				correct=""

			# Si l'utilisateur n'as pas entrer Y ou N alors je redemande la saisi de Y ou N	
			else
				echo -e "Merci de saisir Y ou N \n"
				correct=""
			fi


		done
	;;	

	# Choix3: Supprimer un fichier (avec vérification d’existence)
	3)
		
		echo -e "Choix3: Supprimer un fichier (avec vérification d’existence)\n"
		suppression_fichier="non"

		while [[ "$suppression_fichier" == "non" ]]; do #TANT QUE SUPPRESSION DE FICHIER EGAL NON

			#On demande le nom du fichier à supprimer
			while [ -z "${rm_file}" ]; do  # TANT QUE RM FILE EST VIDE ALORS JE REDEMANDE DE SAISIR LE NOM du FICHIER A SUPPRIMER
			    read -p "SAISIR LE NOM DU FICHIER A SUPPRIMER: " rm_file a
			done 

			# On affiche le nom du fichier a supprimer
			echo -e "Le nom du fichier a supprimer est : ${rm_file} \n" 


			#On demande si cela est correct
			while [ -z "${correct}" ]; do # TANT QUE CORRECT EST VIDE ALORS JE REDEMANDE LA SAISIE DE L UTILISATEUR (Y / N)
				    read -p "Est ce que c'est correct ? (Y / N): " correct a
			done

			# Si le nom du fichier a supprimer est correct alors je le supprime
			if [[ "$correct" == "Y" || "$correct" == "y" ]]; then # SI c'est correct alors je crée le fichier et supression fichier = oui

				# Vérifier si le fichier existe déjà
				        if [[ -e "$rm_file" ]]; then
				            echo -e "Le fichier ${rm_file} est en cours de supression...\n"
				            rm -f "$rm_file"
				            echo -e "Le fichier est supprimé\n"
				            supression_fichier="oui" 
				            break
				        else
				            echo -e "le fichier n'existe pas"
				            break
				         fi


			# Si le nouveau nom du fichier est incorrect alors je redemande le nom du fichier

			elif [[ "$correct" == "N" || "$correct" == "n"  ]]; then
				echo -e "LE fichier n a pas ete supprimé\n"
				rm_file=""
				correct=""

			# Si l'utilisateur n'as pas entrer Y ou N alors je redemande la saisi de Y ou N	
			else
				echo -e "Merci de saisir Y ou N \n"
				correct=""
			fi


		done
	;;	

	4)
		echo -e "Choix 4: Afficher le contenu d’un fichier "

		affichage_fichier="non"

		while [[ "$affichage_fichier" == "non" ]]; do #TANT QUE AFFICHAGE DU FICHIER EGAL NON

			#On demande le nom du fichier à afficher
			while [ -z "${cat_file}" ]; do  # TANT QUE CAT FILE EST VIDE ALORS JE REDEMANDE DE SAISIR LE NOM du FICHIER A lire
			    read -p "SAISIR LE NOM DU FICHIER A Afficher: " cat_file a
			done 

			# On affiche le nom du fichier a afficher
			echo -e "Le nom du fichier a afficher est : ${cat_file} \n" 


			#On demande si cela est correct
			while [ -z "${correct}" ]; do # TANT QUE CORRECT EST VIDE ALORS JE REDEMANDE LA SAISIE DE L UTILISATEUR (Y / N)
				    read -p "Est ce que c'est correct ? (Y / N): " correct a
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


	;;


	5)
		echo -e "A bientôt !!!! \n"
		exit 0
	;;	

	*)
		echo -e "\n Choix incorrect \n"
		exit 1
	;;	

esac


