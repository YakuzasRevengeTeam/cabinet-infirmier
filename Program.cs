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