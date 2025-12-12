# Cabinet Infirmier

Application C# de gestion d'un cabinet infirmier utilisant XML, XSD et XSLT.

## Description

Ce projet permet de :
- **Valider** des fichiers XML avec des schémas XSD
- **Transformer** des données XML en fichiers HTML via XSLT
- **Générer** des fiches patients personnalisées

## Structure du projet

```
cabinet-infirmier/
├── Program.cs          # Point d'entrée de l'application
├── XMLUtils.cs         # Utilitaires XML (validation XSD, transformation XSLT)
├── data/
│   ├── xml/            # Fichiers de données XML
│   │   ├── cabinet.xml # Données du cabinet (patients, infirmiers, visites)
│   │   └── actes.xml   # Référentiel des actes médicaux
│   ├── xsd/            # Schémas de validation XSD
│   │   ├── cabinet.xsd # Schéma pour cabinet.xml
│   │   ├── patient.xsd # Schéma pour le XML patient généré
│   │   └── actes.xsd   # Schéma pour actes.xml
│   ├── xslt/           # Feuilles de style XSLT
│   │   ├── patient_xml.xsl  # Extraction patient → XML
│   │   ├── patient_html.xsl # XML patient → HTML
│   │   └── cabinet.xsl      # Affichage cabinet pour infirmier
│   ├── html/           # Pages HTML
│   │   ├── cabinet.html        # Page d'accueil du cabinet
│   │   ├── patient.html        # Fiche patient générée (OUTPUT)
│   │   ├── CVprogrammeurs1.html # CV programmeur 1
│   │   └── CVprogrammeurs2.html # CV programmeur 2
│   ├── css/            # Styles CSS
│   └── js/             # Scripts JavaScript
│       └── buttonScript.js     # Génération facture popup
```

## Prérequis

- .NET 8.0 ou supérieur

## Utilisation

```bash
dotnet run
```

L'application va :
1. Valider `cabinet.xml` avec le schéma `cabinet.xsd`
2. Extraire les données du patient spécifié via `patient_xml.xsl`
3. Transformer ce XML en page HTML via `patient_html.xsl`
4. Générer le fichier de sortie `data/html/patient.html`

## Fichiers de sortie (OUTPUT)

| Fichier | Description |
|---------|-------------|
| `data/html/patient.html` | Fiche HTML du patient avec ses visites et actes |
| `data/html/cabinet.html` | Page infirmier avec liste des patients et bouton facture |

## Fonctionnalités

- **Validation XSD** : Vérification de la conformité des fichiers XML
- **Facture dynamique** : Popup JavaScript affichant le détail des actes et le total

## Tests Partie 3 (optionnel)

Pour activer les tests de la partie 3, modifier dans `Program.cs` :

```csharp
bool runPart3Checks = true;  // false par défaut
```

Les tests vérifient :

| Test | Description |
|------|-------------|
| **TEST 1** | Analyse globale - Parcours complet du XML avec XmlReader |
| **TEST 2** | Extraction de tous les noms du document |
| **TEST 3** | Extraction des noms d'infirmiers uniquement |
| **TEST 4** | Comptage du nombre total d'actes à effectuer |
| **TEST 5** | Vérifications DOM/XPath (nb infirmiers, patients, adresses complètes) |

### Classes C# ajoutées

| Fichier | Description |
|---------|-------------|
| `Cabinet.cs` | Fonctions d'analyse XML (Analyze, GetNom, GetNomsInfirmiers, CountActes) |
| `DOM2XPath.cs` | Utilitaire pour évaluer des expressions XPath sur un document XML |
| `Adresse.cs` | Classe sérialisable représentant une adresse |
| `Infirmier.cs` | Classe sérialisable représentant un infirmier |

### Exemple de sortie des tests

```
══════════════════════════════════════════════════

TEST 1: ANALYSE GLOBALE
--------------------------------------------------
Starts the element nom
Nombre d'attributs 0
Text node value = Soins à Grenoble
Ends the element nom
Starts the element adresse
Nombre d'attributs 0
Starts the element etage
Nombre d'attributs 0
Text node value = string
Ends the element etage
Starts the element numero
Nombre d'attributs 0
Text node value = 10
Ends the element numero
... (parcours complet du XML)

══════════════════════════════════════════════════

TEST 2: TOUS LES NOMS
--------------------------------------------------
Commence à explorer le cabinet
Nom trouvé: Soins à Grenoble
Nom trouvé: Orouge
Nom trouvé: Pien
Nom trouvé: Kapoëtla
Nom trouvé: Annie
Nom trouvé: Martin
Nom trouvé: Sarah
Ending the element cabinet
Liste complète:
  Soins à Grenoble
  Orouge
  Pien
  Kapoëtla
  Annie
  Martin
  Sarah

══════════════════════════════════════════════════

TEST 3: NOMS DES INFIRMIERS UNIQUEMENT
--------------------------------------------------
  Infirmier: Annie
  Infirmier: Martin
  Infirmier: Sarah
Liste des infirmiers:
  Annie
  Martin
  Sarah

══════════════════════════════════════════════════

TEST 4: COMPTAGE DES ACTES
--------------------------------------------------
  Acte #1
  Acte #2
  Acte #3
  Acte #4
 Résumé:
   • Actes totaux à effectuer: 4

══════════════════════════════════════════════════

TEST 5: VÉRIFICATIONS DOM/XPATH
--------------------------------------------------
 Nombre d'infirmiers: 3
 Nombre de patients: 3
 Adresse cabinet complète: OUI
 Patients avec adresse complète: 3/3
```

## Captures d'écran

### Page Cabinet (liste des patients pour l'infirmier)
![Cabinet](output/Cabinet.png)

### Fiche Patient
![Patient](output/Patient.png)

### Facture (popup JavaScript)
![Facture](output/Facture.png)

