# --- PARTIE 2 --- # 

# --- CHARGEMENT DU FICHIER EMPLOYEES --- #

function chargement_donnees {
    # OBJECTIF: IMPORTE LE FICHIER CSV
    param (
        [string]$fichier_csv
        )

    Write-Host "Chargement du fichier '$fichier_csv'..."

        $donnees = Import-Csv -Path $fichier_csv
        Write-Host "Chargement terminé."
        return $donnees 
}


# --- PARTIE 1 : CREATION ET UTILISATION DES FONCTIONS ---

# Etape 1:Creation de la fonction Afficher-Employe

function Afficher-Employe {
    param (
        $Employe,
        [string]$Prefix = ""
    )

    if (-not [string]::IsNullOrEmpty($Prefix)) {
        Write-Host "$Prefix "
    }

    # Afficher le nom, le service et le salaire de l'employé
    Write-Host "Nom: $($Employe.Nom), Service: $($Employe.Service), Salaire: $($Employe.Salaire)"
}



# --- Étape 3 : Création de la fonction Calculer-RatioSalaire ---
function Calculer-RatioSalaire {
    param (
        [Parameter(Mandatory=$true)]
        [double]$Salaire1, 

        [Parameter(Mandatory=$true)]
        [double]$Salaire2  
    )

    try {
        # Vérifier explicitement si le deuxième salaire est zéro pour gérer l'erreur
        if ($Salaire2 -eq 0) {
            # Générer une erreur spécifique pour la division par zéro
            throw "Erreur: Impossible de calculer le ratio car le deuxième salaire est zéro."
        }

        # Calculer le ratio
        $ratio = $Salaire1 / $Salaire2
        return $ratio
    }
    catch {
        # Gérer l'erreur et afficher un message explicite
        Write-Error "Une erreur s'est produite lors du calcul du ratio: $($_.Exception.Message)"
        return $null # Retourne $null en cas d'erreur
    }
}


# --- Étape 4 : Création de la fonction Filtrer-Employes ---
function Filtrer-Employes {
    param (
        [string]$ServiceCible, 
        [array]$EmployesList # La liste complète des employés à filtrer
    )

    Write-Host "Filtrage des employés pour le service : '$ServiceCible'..."

    $employesFiltres = $EmployesList | Where-Object { $_.Service -eq $ServiceCible }

    if ($employesFiltres.Count -gt 0) {
        Write-Host "Trouvé $($employesFiltres.Count) employé(s) dans le service '$ServiceCible'."
    } else {
        Write-Host "Aucun employé trouvé dans le service '$ServiceCible'."
    }

    return $employesFiltres # Retourne la liste des employés filtrés
}



# ----- MAIN -----

#Définition du chemin vers le fichier employes.csv
$fichierCSV = "employes.csv"


#Chargement du fichier csv dans la variable donneesEmployes
$donneesEmployes = chargement_donnees -fichier_csv $fichierCSV
Write-Host "Les données sont chargées dans la variable 'donneesEmployes' !!!"

# PARTIE 1 : Appelez la fonction pour chaque employé du fichier employes.csv
foreach ($employe in $donneesEmployes) {
    Afficher-Employe -Employe $employe
    }

Write-Host "Affichage des employés terminé !!! "


# PARTIE 2: Ajouter des paramètres avec valeurs par défaut

$prefix = "salarié"

Write-Host "`nAffichage des employés (avec le préfixe $prefix ') :" 

foreach ($employe in $donneesEmployes) {
    Afficher-Employe -Employe $employe -Prefix $prefix
}

# Etape 3 Testez la fonction avec des valeurs valides et une division par zéro

Write-Host "`n--- Test de la fonction Calculer-RatioSalaire ---"

# Test avec des valeurs valides
$salaireA = 42000
$salaireB = 36000
Write-Host "Test 1: Ratio de $salaireA sur $salaireB"
$ratioValide = Calculer-RatioSalaire -Salaire1 $salaireA -Salaire2 $salaireB
Write-Host "Le ratio est : $($ratioValide.ToString("N2"))" 


# Test avec une division par zéro
$salaireC = 500000
$salaireD = 0
Write-Host "`nTest 2: Ratio de $salaireC sur $salaireD (division par zéro attendue)"
$ratioZero = Calculer-RatioSalaire -Salaire1 $salaireC -Salaire2 $salaireD


Write-Host "--- Fin des tests de Calculer-RatioSalaire ---"



#ETAPE 4 : 

# --- Test de la fonction Filtrer-Employes (Étape 4) ---
Write-Host "`n--- Test de la fonction Filtrer-Employes ---"

# Test avec le service "Informatique"
$serviceInformatique = "Informatique"
Write-Host "`nFiltrage par service : '$serviceInformatique'"
$employesInformatique = Filtrer-Employes -ServiceCible $serviceInformatique -EmployesList $donneesEmployes

if ($employesInformatique) {
    foreach ($employe in $employesInformatique) {
        Write-Host "Nom: $($employe.Nom)"
    }
} else {
    Write-Host "Aucun employé trouvé pour le service '$serviceInformatique'."
}

# Test avec le service "Marketing"
$serviceMarketing = "Marketing"
Write-Host "`nFiltrage par service : '$serviceMarketing'"
$employesMarketing = Filtrer-Employes -ServiceCible $serviceMarketing -EmployesList $donneesEmployes

if ($employesMarketing) {
    foreach ($employe in $employesMarketing) {
        Write-Host "Nom: $($employe.Nom)"
    }
} else {
    Write-Host "Aucun employé trouvé pour le service '$serviceMarketing'."
}

# Test avec un service inexistant
$serviceInexistant = "Ventes"
Write-Host "`nFiltrage par service : '$serviceInexistant'"
$employesInexistants = Filtrer-Employes -ServiceCible $serviceInexistant -EmployesList $donneesEmployes
Write-Host "--- Fin des tests de Filtrer-Employes ---"


#ETAPE 5: 
$ModulePath = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "EmployeTools.psm1"
Import-Module $ModulePath -Force

Write-Host "`n--- Employés du service RH avec préfixe personnalisé (via module) ---"
# Utilisation de $donneesEmployes qui a été chargée depuis le CSV
$EmployesRH = Filtrer-Employes -EmployesList $donneesEmployes -ServiceCible "RH"
foreach ($employe in $EmployesRH) {
    Afficher-Employe -Employe $employe -Prefix "RH >>"
}