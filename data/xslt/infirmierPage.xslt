<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:med="http://www.univ-grenoble-alpes.fr/l3miage/medical"
        xmlns:act="http://www.univ-grenoble-alpes.fr/l3miage/actes"
        version="1.0">
    
    <!-- Type de sortie -->
    <xsl:output method="html"/>

    <!-- Variable pour accéder aux actes -->
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    <!-- Modèle de sortie -->
    <xsl:template match="/">
        <!-- Paramètres -->
        <xsl:param name="infirmierId"/>
        
        <html lang="en">
            <head>
                <link rel="stylesheet" href="style.css"/>
                <meta charset="UTF-8"/>
                <title>Infirmier Page</title>

                <!-- Script pour la facture -->
                <script type="text/javascript" src="js/facture.js"> </script>
            </head>
            <body>
                <h1>Service <xsl:value-of select="/med:cabinet/med:nom"/></h1>
                Bonjour <xsl:value-of select="/med:cabinet/med:infirmiers/med:infirmier[@id = $infirmierId]/med:nom"/>

                Aujourd'hui, vous avez <xsl:value-of select="count(/med:cabinet/med:patients/med:patient[med:visites/med:visite/@intervenant = $infirmierId])"/> patients.

                <!-- A la suite de la phrase d’accueil, on souhaite lister pour chaque patient à visiter (et dans l’ordre de visite), 
               son nom, son adresse correctement mise en forme et la liste des soins à effectuer -->

                <!-- Il faut essayer d'afficher les patients sans utiliser for each ici -->

                <table>  
                    <xsl: select="/med:cabinet/med:patients/med:patient[med:visites/med:visite/@intervenant = $infirmierId]">
                        <tr>
                            <td><xsl:value-of select="med:nom"/></td>
                            <td><xsl:value-of select="med:prenom"/></td>
                            <xsl: select="med:visites/med:visite[@intervenant = $infirmierId]">  
                                <td colspan="2">
                                    Visite du <xsl:value-of select="@date"/>
                                    <table>
                                        <xsl: select="med:actes/med:acte">
                                            <tr>
                                                <!-- Récupérer l'ID de l'acte actuel -->
                                                <xsl:variable name="acteId" select="@id"/>

                                                <!-- Chercher le libellé dans actes.xml -->
                                                <td>
                                                    <xsl:value-of select="$actes/act:actes/act:acte[@id = $acteId]"/>
                                                </td>
                                                
                                                <td>Coef : <xsl:value-of select="med:coef"/></td>
                                            </tr>
                                        </xsl:>
                                    </table>

                                    <!-- Bouton Facture -->
                                    <xsl:element name="button">
                                        <xsl:attribute name="onclick">
                                            openFacture(
                                            '<xsl:value-of select="../../med:prenom"/>',
                                            '<xsl:value-of select="../../med:nom"/>',
                                            '<xsl:value-of select="med:actes/med:acte/@id"/>'
                                            )
                                        </xsl:attribute>
                                        Facture
                                    </xsl:element>
                                    
                                </td>
                            </xsl:>
                        </tr>
                    </xsl:>
                </table>  
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

