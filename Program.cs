// See https://aka.ms/new-console-template for more information

using CabinetInfirmier;


XMLUtils.ValidateXmlFileAsync("http://www.univ-grenoble-alpes.fr/l3miage/medical", "./data/xml/cabinet.xml", "./data/xsd/cabinet.xsd");

Console.WriteLine("Nombre de actes comptés :" + Cabinet.CountActes("./xml/cabinet.xml"));
HashSet<string> nominfirs = Cabinet.GetNom("./xml/cabinet.xml");

Console.WriteLine("Liste des noms des infirmiers récupérés :");
foreach (var nom in nominfirs)
{
    Console.WriteLine(" -> " + nom);
}

DOM2XPath cabinetDOM = new DOM2XPath("./xml/cabinet.xml");


// • 3 infirmiers
String verifierNbInfirmiers = "//";
// • 4 patients
String verifierNbPatients = "//";
// • une adresse complète pour le cabinet
String verifierAddCabinet = "//";
// • une adresse complète pour chaque patient
String verifierAddPatient = "//";
// • qu’un numéro de sécurité sociale est valide par rapport aux informations fournies (date de naissance,
// et sexe, mais aussi vérifier à l’intérieur du numéro de sécu si la clef est valide).
String verifierNumSecu = "//";
// • que l’ensemble des numéros de sécurité sociale sont valides par rapport aux informations fournies
String verifierEnsembleNumSecu = "//";

