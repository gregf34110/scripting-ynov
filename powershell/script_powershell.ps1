#PARTIE 1: 

# Étape 1 — Chargement des données

#Récupération du fichier employes.csv
$fichierCSV = "employes.csv"

#Chargement du fichier CSV dans la variable données
Write-Host "Chargement du fichier '$fichierCSV' dans la variable `$donnees..."

$donnees = Import-Csv -Path $fichierCSV

Write-Host "Chargement terminé."


#Affichage des deux premièrs éléments
Write-Host "Aperçu des 2 premiers éléments chargés :"

$donnees | Select-Object -First 2 | Out-Host 

Write-Host "L'aperçu des deux premiers éléments est terminé."

#----------------------------------------------------------------------------

# Étape 2 — Exploration et accès aux attributs

#Affichage uniquement des noms des employées:

Write-Host "Affichage du nom des employes"

$donnees | Select-Object -ExpandProperty Nom

Write-Host "L'affichage du nom des employés est terminé"


# Calcul de l'age moyen des employés
Write-host "Calcul de l'âge moyen des employés"
$ageMoyen = ($donnees | Measure-Object -Property Age -Average).Average
Write-Host "L'âge moyen des employés est de : $($ageMoyen) ans."


#affiche tous les employés du service Informatique
Write-Host "Affichage de tous les employés du service informatique"
$donnees | Where-Object { $_.Service -eq "Informatique" } | Out-Host
Write-Host "Affichage des employés de l'informatique terminé"



#------------------------------------------------------------------------------------

# Étape 3 — Utilisation de conditions

#Affichage des employés de plus de 40 ans
Write-Host "Affichage des employés de plus de 40 ans"
$donnees | Where-Object { $_.Age -gt 40 } | Out-Host
Write-Host "Affichage des employés de plus de 40 terminé"

# Evaluation de l'age des employés
Write-Host "Evaluation de l'age des employés"

$donnees | ForEach-Object {
    $employe = $_ 
    $evaluation = ""

    if ($employe.Age -lt 35) {
        $evaluation = "Jeune"
    } elseif ($employe.Age -ge 35 -and $employe.Age -le 49) {
        $evaluation = "Expérimenté"
    } else { # L'âge est >= 50
        $evaluation = "Senior"
    }

    Write-Host "$($employe.Nom) : $($employe.Age) ans - $($evaluation)"
}

Write-Host "L'evaluation de l'age des employés est terminé"

#-------------------------------------------------------------------------------------------------------------------------------------
# Etape 4 - Boucles

# Affiche le service et le salaire de l'employé
Write-Host "Affichage du service et du salaire de l'employé"
foreach ($employe in $donnees) {
    Write-Host "$($employe.Nom) travaille dans le service $($employe.Service) avec un salaire de $($employe.Salaire) €"
}
Write-Host "L'affichage du service et du salaire de l'employé est terminé"


# Affiche le nom des 3 premiers employés
Write-Host "`nAffichage du nom des 3 premiers employés"
for ($i = 0; $i -lt 3; $i++) {
        Write-Host "Employé $($i+1) : $($donnees[$i].Nom)"
}

Write-Host "L'affichage du nom des 3 premiers employés est terminé"


#-----------------------------------------------------------------------------------------------------------------------------------------

#Etape 5: Switch

# Affichage des types de services

Write-Host "`nAffichage des types de service pour chaque service"
$donnees | ForEach-Object {
    $employe = $_ 

    $typeService = ""

    switch ($employe.Service) {
        "Informatique" {
            $typeService = "Technique"
        }
        "RH" {
            $typeService = "Support"
        }
        "Comptabilité" {
            $typeService = "Support"
        }
        "Marketing" {
            $typeService = "Client"
        }
        Default { 
            $typeService = "Autre"
        }
    }
    Write-Host "$($employe.Nom) --->  $($typeService)"
}

Write-Host "L'affichage du type de service pour chaque employe est terminé"


# Etape 6: Rapport final

#Affichage du nombre d'employé total
Write-Host "Nombre total d'employés : $($donnees.Count)"


#Affichage du salaire moyen
$salaireMoyen = ($donnees | Measure-Object -Property Salaire -Average).Average
Write-Host "Salaire moyen : $($salaireMoyen) €"


#Affichage du salarié avec le plus gros salaire
$employeRiche = $donnees | Sort-Object -Property Salaire -Descending | Select-Object -First 1
Write-Host "L'employe qui va payer le resto car il a le meilleur salaire est : $($employeRiche.Nom) ($($employeRiche.Salaire) €)"

