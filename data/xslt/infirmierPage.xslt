<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:med="http://www.univ-grenoble-alpes.fr/l3miage/medical"
        version="1.0">

    <!-- Type de sortie -->
    <xsl:output method="html"/>

    <!-- Variable pour accéder aux actes -->
    <!-- Modèle de sortie -->
    <xsl:template match="/">
        <!-- Paramètres -->
        <xsl:param name="infirmierId">001</xsl:param>

        <html lang="en">
            <head>
                <link rel="stylesheet" href="../css/style.css"/>
                <meta charset="UTF-8"/>
                <title>Infirmier Page</title>

                <!-- Script pour la facture -->
                <script type="text/javascript" src="../js/facture.js"> </script>
            </head>
            <body>
                <h1>Service
                    <xsl:value-of select="/med:cabinet/med:nom"/>
                </h1>
                Bonjour
                <xsl:value-of select="/med:cabinet/med:infirmiers/med:infirmier[@id = $infirmierId]/med:nom"/>
                
                Aujourd'hui, vous avez
                <xsl:value-of
                        select="count(/med:cabinet/med:patients/med:patient[med:visites/med:visite/@intervenant = $infirmierId])"/>
                patients.

                <!-- A la suite de la phrase d’accueil, on souhaite lister pour chaque patient à visiter (et dans l’ordre de visite), 
               son nom, son adresse correctement mise en forme et la liste des soins à effectuer -->

                <table>
                    <xsl:apply-templates select="/med:cabinet/med:patients/med:patient[med:visites/med:visite/@intervenant = $infirmierId]">
                        <xsl:with-param name="infirmierId" select="$infirmierId"/>
                    </xsl:apply-templates>
                </table>
                </body>
            </html>
    </xsl:template>

    <xsl:template match="med:patient">
        <xsl:param name="infirmierId"/>
        <tr>
            <td>
                <xsl:value-of select="med:nom"/>
            </td>
            <td>
                <xsl:value-of select="med:prenom"/>
            </td>
            <xsl:apply-templates select="med:visites/med:visite[@intervenant = $infirmierId]">
                <xsl:with-param name="nom" select="med:nom"/>
                <xsl:with-param name="prenom" select="med:prenom"/>
            </xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="med:visite">
        <xsl:param name="nom"/>
        <xsl:param name="prenom"/>
        <td colspan="2">
            Visite du
            <xsl:value-of select="@date"/>
            <table>
                <tr>
                    <td>Coef :
                        <xsl:apply-templates select="med:actes/med:acte/med:coef"/>
                    </td>
                </tr>
            </table>

            <!-- Bouton Facture -->
            <xsl:element name="button">
                <xsl:attribute name="onclick">
                    openFacture(
                    '<xsl:value-of select="$prenom"/>',
                    '<xsl:value-of select="$nom"/>',
                    '<xsl:value-of select="med:actes/med:acte/@id"/>'
                    )
                </xsl:attribute>
                Facture
            </xsl:element>
        </td>
    </xsl:template>
</xsl:stylesheet>
