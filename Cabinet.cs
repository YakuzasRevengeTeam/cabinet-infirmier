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
                      Console.WriteLine(" Entering the XML document");
                      break;
                  
                  case XmlNodeType.Document:
                      // instructions à executer quand on entre dans le document
                      Console.Write("Entering the document");
                      break;
                  
                  case XmlNodeType.Element:
                      // instructions à executer quand on entre dans un élement;
                      // Ce message doit afficher le nom de l'élement 
                      Console.WriteLine("Starts the element {0}", reader.Name);
                      // et le nombre d'attributs qu'il contient 
                      Console.WriteLine("Nombre d'attributs {0}", reader.AttributeCount);
                      break;
                  
                  case XmlNodeType.EndElement:
                      // instructions à executer quand on sort d'un élément
                      Console.WriteLine("Ends the element {0}", reader.Name);
                      break;
                  
                  case XmlNodeType.Text:
                      // instructions à executer quand on trouve du texte
                      Console.WriteLine("Text node value = {0}", reader.GetValueAsync());
                      break;
                  
                  case XmlNodeType.Attribute:
                      // instructions à executer quand on trouve un attribut
                      Console.WriteLine("Attribute {0}", reader.Name);
                      // contenu de l'attribut
                      Console.WriteLine("Attribute node value = {0}", reader.ReadElementContentAsString());
                      break;
                  
                  default:
                      // instructions à executer sinon
                      Console.WriteLine("Other node of type {0} with value {1}", reader.NodeType, reader.Value);
                      break;
              }
          }
      }
  }
  
  // Ecrivez une autre fonction qui permet de récupérer le texte d’éléments particuliers (par exemple tous les noms, ou tous les noms des infirmiers).
  // Idéalement, votre recherche doit être passée en paramètre de la fonction.
  public static HashSet<String> GetNom(String filename)
  {
      XmlReader reader =  XmlReader.Create(filename);
      HashSet<string> noms = new HashSet<string>();
      
      while (reader.Read())
          switch (reader.NodeType)
          {
              case XmlNodeType.Element:
                  if (reader.Name == "cabinet")
                      Console.WriteLine("Commence à explorer la cabinet");
                  
                  // Quand on trouve un élément <nom>, lire son contenu texte
                  if (reader.Name == "nom")
                  {
                      // Lire le texte à l'intérieur de <nom>
                      string nomValue = reader.ReadElementContentAsString();
                      Console.WriteLine($"Nom trouvé: {nomValue}");
                      noms.Add(nomValue);
                  }
                  break;
              
              case XmlNodeType.EndElement:
                  if (reader.Name == "cabinet")
                      Console.WriteLine("Ending the element {0}", reader.Name);
                  break;
          }
      return noms;
  }
  
  // Version améliorée: récupérer uniquement les noms des infirmiers
  public static HashSet<string> GetNomsInfirmiers(string filename)
  {
      XmlReader reader = XmlReader.Create(filename);
      HashSet<string> noms = new HashSet<string>();
      bool dansInfirmiers = false;
      
      while (reader.Read())
      {
          switch (reader.NodeType)
          {
              case XmlNodeType.Element:
                  // Détecter quand on entre dans la section infirmiers
                  if (reader.Name == "infirmiers")
                      dansInfirmiers = true;
                    
                  // Si on est dans <infirmiers> et qu'on trouve un <nom>
                  if (dansInfirmiers && reader.Name == "nom")
                  {
                      string nomValue = reader.ReadElementContentAsString();
                      Console.WriteLine($"  ️ Infirmier: {nomValue}");
                      noms.Add(nomValue);
                  }
                  break;
                    
              case XmlNodeType.EndElement:
                  // Détecter quand on sort de la section infirmiers
                  if (reader.Name == "infirmiers")
                      dansInfirmiers = false;
                  break;
          }
      }
      return noms;
  }
  
  // Créez une autre fonction utilisant le XmlReader pour compter combien d’actes différents devront être
  // effectués, tous patients confondus.
  public static int CountActes(String filename)
  {
      XmlReader reader = XmlReader.Create(filename);
      int actesTotal = 0;
      
      reader.MoveToContent();
      while (reader.Read())
          if (reader.NodeType == XmlNodeType.Element && reader.Name == "acte")
          {
              actesTotal++;
              Console.WriteLine($"  Acte #{actesTotal}");
          }
      return actesTotal;
  }
}