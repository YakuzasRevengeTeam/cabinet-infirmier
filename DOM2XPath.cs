using System.Xml;

namespace CabinetInfirmier;

//Ecrivez une fonction qui, appliquant un chemin XPath à un document XML, renvoie ainsi une NodeList.
// Utilisez ce programme pour vérifier que votre document contient :
// • 3 infirmiers
// • 4 patients
// • une adresse complète pour le cabinet
// • une adresse complète pour chaque patient
// • qu’un numéro de sécurité sociale est valide par rapport aux informations fournies (date de naissance,
// et sexe, mais aussi vérifier à l’intérieur du numéro de sécu si la clef est valide).
// • que l’ensemble des numéros de sécurité sociale sont valides par rapport aux informations fournies
 
public class DOM2XPath
{
    private XmlDocument doc;
    
    public DOM2XPath(String filename) 
    {
        doc = new XmlDocument();
        doc.Load(filename);
    }

    public XmlNodeList GetXPath(String nsPrefix, String nsURI, String expression)
    {
        XmlNode root = doc.DocumentElement;
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
        nsmgr.AddNamespace(nsPrefix, nsURI);
        return root.SelectNodes(expression, nsmgr); 
    }
}