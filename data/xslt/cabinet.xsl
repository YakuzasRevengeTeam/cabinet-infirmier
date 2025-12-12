<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:med="http://www.univ-grenoble-alpes.fr/l3miage/medical"
        xmlns:act="http://www.univ-grenoble-alpes.fr/l3miage/actes"
        version="1.0">

    <!-- Type de sortie -->
    <xsl:output method="html" indent="yes"/>

    <!-- Paramètre: identifiant de l'infirmier -->
    <xsl:param name="infirmierId">001</xsl:param>

    <!-- Variable pour accéder aux actes depuis actes.xml -->
    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>

    <!-- Template racine -->
    <xsl:template match="/">
        <html lang="fr">
            <head>
                <meta charset="UTF-8"/>
                <link rel="stylesheet" href="../css/infirmierPage.css"/>
                <title>Page Infirmier</title>
                <script type="text/javascript" src="../js/buttonScript.js"> </script>
            </head>
            <body>
                <h1>Service <xsl:value-of select="/med:cabinet/med:nom"/></h1>

                <!-- Message d'accueil -->
                <p>
                    Bonjour <xsl:value-of select="/med:cabinet/med:infirmiers/med:infirmier[@id = $infirmierId]/med:prenom"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="/med:cabinet/med:infirmiers/med:infirmier[@id = $infirmierId]/med:nom"/>,
                </p>
                <p>
                    Aujourd'hui, vous avez
                    <strong>
                        <xsl:value-of select="count(/med:cabinet/med:patients/med:patient[med:visites/med:visite/@intervenant = $infirmierId])"/>
                    </strong>
                    patient(s).
                </p>

                <!-- Tableau des patients à visiter -->
                <table border="1">
                    <thead>
                        <tr>
                            <th>Patient</th>
                            <th>Adresse</th>
                            <th>Actes à effectuer</th>
                            <th>Date visite</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="/med:cabinet/med:patients/med:patient[med:visites/med:visite/@intervenant = $infirmierId]"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- Template pour un patient -->
    <xsl:template match="med:patient">
        <xsl:apply-templates select="med:visites/med:visite[@intervenant = $infirmierId]">
            <xsl:with-param name="patientNom" select="med:nom"/>
            <xsl:with-param name="patientPrenom" select="med:prenom"/>
            <xsl:with-param name="adresse" select="med:adresse"/>
            <xsl:with-param name="numeroSS" select="med:numéro"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- Template pour une visite -->
    <xsl:template match="med:visite">
        <xsl:param name="patientNom"/>
        <xsl:param name="patientPrenom"/>
        <xsl:param name="adresse"/>
        <xsl:param name="numeroSS"/>
        <tr>
            <!-- Nom du patient -->
            <td>
                <xsl:value-of select="$patientPrenom"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$patientNom"/>
            </td>
            <!-- Adresse formatée -->
            <td>
                <xsl:if test="$adresse/med:numero">
                    <xsl:value-of select="$adresse/med:numero"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="$adresse/med:rue"/><br/>
                <xsl:value-of select="$adresse/med:codePostal"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$adresse/med:ville"/>
            </td>
            <!-- Liste des actes -->
            <td>
                <ul>
                    <xsl:apply-templates select="med:actes/med:acte"/>
                </ul>
            </td>
            <!-- Date de visite -->
            <td><xsl:value-of select="@date"/></td>
            <!-- Bouton facture -->
            <td>
                <xsl:element name="button">
                    <xsl:attribute name="onclick">
                        <xsl:text>openFacture('</xsl:text>
                        <xsl:value-of select="$patientPrenom"/>
                        <xsl:text>','</xsl:text>
                        <xsl:value-of select="$patientNom"/>
                        <xsl:text>','</xsl:text>
                        <xsl:if test="$adresse/med:numero">
                            <xsl:value-of select="$adresse/med:numero"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="$adresse/med:rue"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="$adresse/med:codePostal"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$adresse/med:ville"/>
                        <xsl:text>','</xsl:text>
                        <xsl:value-of select="$numeroSS"/>
                        <xsl:text>','</xsl:text>
                        <xsl:apply-templates select="med:actes/med:acte" mode="ids"/>
                        <xsl:text>','</xsl:text>
                        <xsl:apply-templates select="med:actes/med:acte" mode="coefs"/>
                        <xsl:text>')</xsl:text>
                    </xsl:attribute>
                    Facture
                </xsl:element>
            </td>
        </tr>
    </xsl:template>

    <!-- Template pour générer la liste des IDs d'actes (pour le bouton facture) -->
    <xsl:template match="med:acte" mode="ids">
        <xsl:value-of select="@id"/>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Template pour générer la liste des coefficients (pour le bouton facture) -->
    <xsl:template match="med:acte" mode="coefs">
        <xsl:value-of select="med:coef"/>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Template pour un acte: affiche le libellé depuis actes.xml -->
    <xsl:template match="med:acte">
        <xsl:variable name="acteId" select="@id"/>
        <xsl:variable name="acteRef" select="$actes/act:acte[@id = $acteId]"/>
        <li>
            <xsl:choose>
                <xsl:when test="$acteRef">
                    <xsl:value-of select="normalize-space($acteRef)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="med:type"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text> (coef: </xsl:text>
            <xsl:value-of select="med:coef"/>
            <xsl:text>)</xsl:text>
        </li>
    </xsl:template>

</xsl:stylesheet>
