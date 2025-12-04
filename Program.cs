using System.Xml;
using CabinetInfirmier;


// Validation du fichier XML
Console.WriteLine(" Validation du fichier XML...\n");
XMLUtils.ValidateXmlFileAsync(
    "http://www.univ-grenoble-alpes.fr/l3miage/medical", 
    "./data/xml/cabinet.xml", 
    "./data/xsd/cabinet.xsd"
);

Console.WriteLine("\n" + new string('═', 50) + "\n");

// Test 1: Analyse globale du document
Console.WriteLine("TEST 1: ANALYSE GLOBALE");
Console.WriteLine(new string('-', 50));
Cabinet.Analyze("./data/xml/cabinet.xml");

Console.WriteLine("\n" + new string('═', 50) + "\n");

// Test 2: Récupération de tous les noms
Console.WriteLine(" TEST 2: TOUS LES NOMS");
Console.WriteLine(new string('-', 50));
HashSet<string> tousLesNoms = Cabinet.GetNom("./data/xml/cabinet.xml");
Console.WriteLine("Liste complète:");
foreach (var nom in tousLesNoms)
{
    Console.WriteLine($"  {nom}");
}

Console.WriteLine("\n" + new string('═', 50) + "\n");

// Test 3: Récupération uniquement des noms d'infirmiers
Console.WriteLine("TEST 3: NOMS DES INFIRMIERS UNIQUEMENT");
Console.WriteLine(new string('-', 50));
HashSet<string> nomsInfirmiers = Cabinet.GetNomsInfirmiers("./data/xml/cabinet.xml");
Console.WriteLine("Liste des infirmiers:");
foreach (var nom in nomsInfirmiers)
{
    Console.WriteLine($"  {nom}");
}

Console.WriteLine("\n" + new string('═', 50) + "\n");

// Test 4: Comptage des actes différents
Console.WriteLine("TEST 4: COMPTAGE DES ACTES");
Console.WriteLine(new string('-', 50));
int nbActesTotal = Cabinet.CountActes("./data/xml/cabinet.xml");
Console.WriteLine($" Résumé:");
Console.WriteLine($"   • Actes totaux à effectuer: {nbActesTotal}");

Console.WriteLine("\n" + new string('═', 50) + "\n");

// Test 5: Vérifications avec DOM et XPath
Console.WriteLine(" TEST 5: VÉRIFICATIONS DOM/XPATH");
Console.WriteLine(new string('-', 50));

Dom2XPath cabinetDom = new Dom2XPath("./data/xml/cabinet.xml");

// Vérification du nombre d'infirmiers 
String verifNbInfirmiersExpression = "//med:infirmiers/med:infirmier";
XmlNodeList nlNbInfirmiersDom = cabinetDom.GetXPath("med", 
    "http://www.univ-grenoble-alpes.fr/l3miage/medical", verifNbInfirmiersExpression);
Console.WriteLine($" Nombre d'infirmiers: {nlNbInfirmiersDom.Count}");

// Vérification du nombre de patients
String verifNbPatientsExpression = "//med:patients/med:patient";
XmlNodeList nlNbPatientsDom = cabinetDom.GetXPath("med", 
    "http://www.univ-grenoble-alpes.fr/l3miage/medical", verifNbPatientsExpression);
Console.WriteLine($" Nombre de patients: {nlNbPatientsDom.Count}");

// Vérification adresse du cabinet
String verifAddCabinetExpression = "//med:cabinet/med:adresse[med:rue and med:codePostal and med:ville]";
XmlNodeList nlAddCabinetDom = cabinetDom.GetXPath("med", 
    "http://www.univ-grenoble-alpes.fr/l3miage/medical", verifAddCabinetExpression);
Console.WriteLine($" Adresse cabinet complète: {(nlAddCabinetDom.Count > 0 ? " OUI" : " NON")}");

// Vérification adresses des patients
String verifAddPatientExpression = "//med:patient/med:adresse[med:rue and med:codePostal and med:ville]";
XmlNodeList nlAddPatientsDom = cabinetDom.GetXPath("med", 
    "http://www.univ-grenoble-alpes.fr/l3miage/medical", verifAddPatientExpression);
Console.WriteLine($" Patients avec adresse complète: {nlAddPatientsDom.Count}/{nlNbPatientsDom.Count}");

