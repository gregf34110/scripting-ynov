param (
    [Parameter(Mandatory=$true)]
    [string]$ServiceCible
)

function chargement_donnees {
    param (
        [string]$fichier_csv
        )

    Write-Host "Chargement du fichier '$fichier_csv'..."

        $donnees = Import-Csv -Path $fichier_csv
        Write-Host "Chargement terminé."
        return $donnees
}


# --- MAIN SCRIPT LOGIC ---

Write-Host "--- Démarrage du rapport d'employés ---"

#Importation du module avec gestion des erreurs
$ModulePath = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "EmployeTools.psm1"
try {
    Import-Module $ModulePath -Force -ErrorAction Stop
    Write-Host "Module 'EmployeTools.psm1' importé avec succès."
}
catch {
    Write-Error "Erreur lors de l'importation du module 'EmployeTools.psm1': $($_.Exception.Message)"
    exit 1 # Quitte le script en cas d'erreur d'importation
}



# Chargement du fichier CSV
$fichierCSV = "employes.csv" # Nom du fichier CSV
try {
    $donneesEmployes = chargement_donnees -fichier_csv $fichierCSV
    if (-not $donneesEmployes) {
        Write-Warning "Le fichier CSV a été chargé, mais aucune donnée n'a été trouvée."
    }
}
catch {
    Write-Error "Erreur lors du chargement du fichier CSV '$fichierCSV': $($_.Exception.Message)"
    exit 1 # Quitte le script en cas d'erreur de chargement
}

# 3. Filtre les employés d’un service passé en argument
Write-Host "`nFiltrage des employés pour le service : '$ServiceCible'..."
$employesFiltres = Filtrer-Employes -EmployesList $donneesEmployes -ServiceCible $ServiceCible

# 4. Affiche les informations de chaque employé filtré avec le préfixe [Employé]
if ($employesFiltres.Count -gt 0) {
    Write-Host "`n--- Employés trouvés dans le service '$ServiceCible' ---"
    foreach ($employe in $employesFiltres) {
        Afficher-Employe -Employe $employe -Prefix "[Employé]"
    }
} else {
    Write-Host "`nAucun employé trouvé pour le service '$ServiceCible'."
}

Write-Host "`n--- Rapport d'employés terminé ---"