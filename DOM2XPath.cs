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
 
public class Dom2XPath
{
    private XmlDocument _doc;
    
    public Dom2XPath(String filename) 
    {
        _doc = new XmlDocument();
        _doc.Load(filename);
    }

    public XmlNodeList GetXPath(String nsPrefix, String nsUri, String expression)
    {
        XmlNode root = _doc.DocumentElement;
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(_doc.NameTable);
        nsmgr.AddNamespace(nsPrefix, nsUri);
        return root.SelectNodes(expression, nsmgr); 
    }
}