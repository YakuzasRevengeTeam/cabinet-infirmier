// See https://aka.ms/new-console-template for more information

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
