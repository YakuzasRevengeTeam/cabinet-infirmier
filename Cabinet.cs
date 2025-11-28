using System.Xml;
using System.Xml.Schema;

namespace CabinetInfirmier;

public class Cabinet
{
 //Une méthode void AnalyseGlobale(string filepath) qui :
 // • parse un fichier avec un XmlReader
 // • détecte le type de noeud et l’utilise comme switch
 // • Affiche un message quand on entre dans le document
 // • Affiche un message quand on entre dans un élement ; ce message doit afficher le nom de l’élément
 // et le nombre d’attributs qu’il contient
 // • Affiche un message quand on sort d’un élément
 // • Affiche un message quand on rencontre du texte (le texte doit être affiché)
 // • Affiche un message quand on rencontre un attribut (en affichant le nom et le contenu de l’attribut).

  public static void Analyze(string filepath)
  {
      var settings = new XmlReaderSettings();
      using (var reader = XmlReader.Create(filepath, settings))
      {
          reader.MoveToContent();
          while (reader.Read())
          {
              switch (reader.NodeType)
              {
                  case XmlNodeType.XmlDeclaration:
                      // instructions à executer quand le prompt est détecté
                      Console.Write("Found XML declaration (<?xml version='1.0' encoding='utf-8'?> )");
                      break;
                  
                  case XmlNodeType.Document:
                      // instructions à executer quand on entre dans le document
                      Console.Write("Entering the document");
                      break;
              }
          }
      }
  }
}