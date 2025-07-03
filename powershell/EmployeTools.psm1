# --- PARTIE 1 : CREATION ET UTILISATION DES FONCTIONS ---

# Creation de la fonction Afficher-Employe

function Afficher-Employe {
    param (
        $Employe,
        [string]$Prefix = ""
    )
    # Affichage du prefix si pas vide

    if (-not [string]::IsNullOrEmpty($Prefix)) {
        Write-Host "$Prefix "
    }

    # Afficher le nom, le service et le salaire de l'employé
    Write-Host "Nom: $($Employe.Nom), Service: $($Employe.Service), Salaire: $($Employe.Salaire)"
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


