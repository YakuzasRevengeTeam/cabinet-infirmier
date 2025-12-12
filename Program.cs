// See https://aka.ms/new-console-template for more information

using System;
using System.Collections.Generic;
using System.Xml;
using CabinetInfirmier;

// Validation XSD de cabinet.xml
XMLUtils.ValidateXmlFileAsync("http://www.univ-grenoble-alpes.fr/l3miage/medical", "./data/xsd/cabinet.xsd", "./data/xml/cabinet.xml").Wait();

Console.WriteLine($"cwd: {Directory.GetCurrentDirectory()}");

// Nom du patient à extraire
string patientName = "Pien";

// Génération de la fiche patient XML: cabinet.xml -> NOMPATIENT.xml
var xsltArgs = new System.Xml.Xsl.XsltArgumentList();
xsltArgs.AddParam("destinedName", "", patientName);
string outputXmlPath = $"./data/xml/{patientName}.xml";
XMLUtils.XslTransform("./data/xml/cabinet.xml", "./data/xslt/patient_xml.xsl", outputXmlPath, xsltArgs);
Console.WriteLine($"Fichier XML généré: {outputXmlPath}");

// Génération de la page HTML patient: NOMPATIENT.xml -> patient.html
string outputHtmlPath = "./data/html/patient.html";
XMLUtils.XslTransform(outputXmlPath, "./data/xslt/patient_html.xsl", outputHtmlPath);
Console.WriteLine($"Fichier HTML généré: {outputHtmlPath}");

// Partie 3 (optionnelle) : vérifications DOM/XPath et parcours du document
bool runPart3Checks = true;

if (runPart3Checks)
{
	Console.WriteLine("\n" + new string('═', 50) + "\n");
	Console.WriteLine("TEST 1: ANALYSE GLOBALE");
	Console.WriteLine(new string('-', 50));
	Cabinet.Analyze("./data/xml/cabinet.xml");

	Console.WriteLine("\n" + new string('═', 50) + "\n");
	Console.WriteLine("TEST 2: TOUS LES NOMS");
	Console.WriteLine(new string('-', 50));
	HashSet<string> tousLesNoms = Cabinet.GetNom("./data/xml/cabinet.xml");
	Console.WriteLine("Liste complète:");
	foreach (var nom in tousLesNoms)
	{
		Console.WriteLine($"  {nom}");
	}

	Console.WriteLine("\n" + new string('═', 50) + "\n");
	Console.WriteLine("TEST 3: NOMS DES INFIRMIERS UNIQUEMENT");
	Console.WriteLine(new string('-', 50));
	HashSet<string> nomsInfirmiers = Cabinet.GetNomsInfirmiers("./data/xml/cabinet.xml");
	Console.WriteLine("Liste des infirmiers:");
	foreach (var nom in nomsInfirmiers)
	{
		Console.WriteLine($"  {nom}");
	}

	Console.WriteLine("\n" + new string('═', 50) + "\n");
	Console.WriteLine("TEST 4: COMPTAGE DES ACTES");
	Console.WriteLine(new string('-', 50));
	int nbActesTotal = Cabinet.CountActes("./data/xml/cabinet.xml");
	Console.WriteLine(" Résumé:");
	Console.WriteLine($"   • Actes totaux à effectuer: {nbActesTotal}");

	Console.WriteLine("\n" + new string('═', 50) + "\n");
	Console.WriteLine("TEST 5: VÉRIFICATIONS DOM/XPATH");
	Console.WriteLine(new string('-', 50));

	Dom2XPath cabinetDom = new Dom2XPath("./data/xml/cabinet.xml");
	string nsUri = "http://www.univ-grenoble-alpes.fr/l3miage/medical";

	XmlNodeList? nlNbInfirmiersDom = cabinetDom.GetXPath("med", nsUri, "//med:infirmiers/med:infirmier");
	Console.WriteLine($" Nombre d'infirmiers: {nlNbInfirmiersDom?.Count ?? 0}");

	XmlNodeList? nlNbPatientsDom = cabinetDom.GetXPath("med", nsUri, "//med:patients/med:patient");
	Console.WriteLine($" Nombre de patients: {nlNbPatientsDom?.Count ?? 0}");

	XmlNodeList? nlAddCabinetDom = cabinetDom.GetXPath("med", nsUri, "//med:cabinet/med:adresse[med:rue and med:codePostal and med:ville]");
	Console.WriteLine($" Adresse cabinet complète: {(nlAddCabinetDom != null && nlAddCabinetDom.Count > 0 ? "OUI" : "NON")}");

	XmlNodeList? nlAddPatientsDom = cabinetDom.GetXPath("med", nsUri, "//med:patient/med:adresse[med:rue and med:codePostal and med:ville]");
	int nbAddPatients = nlAddPatientsDom?.Count ?? 0;
	int nbPatientsTotal = nlNbPatientsDom?.Count ?? 0;
	Console.WriteLine($" Patients avec adresse complète: {nbAddPatients}/{nbPatientsTotal}");
}
