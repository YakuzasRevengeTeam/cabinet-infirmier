<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.univ-grenoble-alpes.fr/l3miage/medical"
        version="1.0">
    
    <!-- Type de sortie -->
    <xsl:output method="html"/>

    <!-- Modèle de sortie -->
    <xsl:template match="/">
        <!-- Paramètres -->
        <xsl:param name="infirmierId"/>
        
        <html lang="en">
            <head>
                <link rel="stylesheet" href="style.css"/>
                <meta charset="UTF-8"/>
                <title>Title</title>
            </head>
            <body>
                <h1>Service <xsl:value-of select="/cabinet/@nom"/></h1>
                Bonjour <xsl:value-of select="/cabinet/infirmiers/infirmier[@id = $infirmierId]/nom"/>

                Aujourd'hui, vous avez <xsl:value-of select="count(/cabinet/patients/patient[visites/visite/@intervenant = $infirmierId])"/> patients.

                <!-- A la suite de la phrase d’accueil, on souhaite lister pour chaque patient à visiter (et dans l’ordre de visite), 
               son nom, son adresse correctement mise en forme et la liste des soins à effectuer -->

                <table>  
                    <xsl:for-each select="/cabinet/patients/patient[visites/visite/@intervenant = $infirmierId]">
                        <tr>
                            <td><xsl:value-of select="nom"/></td>
                            <td><xsl:value-of select="prenom"/></td>
                            <xsl:for-each select="visites/visite[@intervenant = $infirmierId]">  
                                <td colspan="2">
                                    Visite du <xsl:value-of select="@date"/>
                                    <table>
                                        <xsl:for-each select="actes/acte">
                                            <tr>
                                                <td>Type : <xsl:value-of select="type"/></td>
                                                <td>Coef : <xsl:value-of select="coef"/></td>
                                            </tr>
                                        </xsl:for-each>
                                    </table>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </table>  
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

