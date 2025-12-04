using System.Xml.Serialization;

// Les champs de ces 2 classes (ex: numéro, rue, codePostal, ...)
// peuvent être amenés à être modifiés depuis le programme C#, par exemple via
// un formulaire. Cela signifie que, si aucune précaution n’est prise, une personne mal informée ou mal
// intentionnée pourrait saisir n’importe quelle valeur (par exemple un code postal abérant comme 38ex79
// ou un numéro de rue négatif). En utilisant des propriétés C#, vous pouvez via le setter (set) contraindre
// , en C#, les valeurs à des expressions (un code postal doit correspondre à une expression régulière
// particulière) ou valeurs spécifiques (un numéro de rue doit être positif et non nul). Modifiez les classes
// Adresse et Infirmier en leur ajoutant des propriétés (qui deviennent les attributs de classe sérialisés) de
// telle manière que leurs setters contraignent les valeurs possibles, en accord avec le schéma que vous avez
// écrit.
[XmlRoot ("infirmier", Namespace = "http://www.univ-grenoble-alpes.fr/l3miage/medical")]
[Serializable]
public class Infirmier
{
    // <infirmier id="001">
    // <nom>Luu</nom>
    // <prenom>Loc</prenom>
    // <photo>loc.png</photo>
    // </infirmier>
    [XmlAttribute ("nom")] public String Nom { get; set; }
    [XmlAttribute ("prenom")] public String Prenom { get; set; }
    [XmlAttribute ("photo")] public String Photo { get; set; }
    
    public override string ToString()
    {
        string s = "";
        s += Nom + " , " + Prenom + " , " ;
        return s;
    }

    public Infirmier(string nom, string prenom, string photo)
    {
        Nom = nom;
        Prenom = prenom;
        Photo = photo;
    } 
    
}