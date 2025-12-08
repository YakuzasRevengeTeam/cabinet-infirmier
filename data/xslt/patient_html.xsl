<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html lang="fr">
            <head>
                <meta charset="UTF-8"/>
                <title>Fiche Patient</title>
                <link rel="stylesheet" href="../css/style.css"/>
                <link rel="stylesheet" href="../css/pagePatient.css"/>
            </head>
            <body>
                <header>
                    <h1>Fiche Patient</h1>
                </header>
                <main class="container">
                    <xsl:apply-templates select="patient"/>
                </main>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="patient">
        <div class="patient-header">
            <h2><xsl:value-of select="prénom"/><xsl:text> </xsl:text><xsl:value-of select="nom"/></h2>
        </div>
        <section>
            <h3>Informations personnelles</h3>
            <xsl:if test="sexe"><p><strong>Sexe :</strong> <xsl:value-of select="sexe"/></p></xsl:if>
            <p><strong>Naissance :</strong> <xsl:value-of select="naissance"/></p>
            <p><strong>Numéro SS :</strong> <xsl:value-of select="numéroSS"/></p>
            <xsl:apply-templates select="adresse"/>
        </section>
        <section>
            <h3>Visites</h3>
            <table class="patient-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Intervenant</th>
                        <th>Actes</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="visite"/>
                </tbody>
            </table>
        </section>
    </xsl:template>

    <xsl:template match="adresse">
        <p><strong>Adresse :</strong> <xsl:value-of select="rue"/>, <xsl:value-of select="codePostal"/><xsl:text> </xsl:text><xsl:value-of select="ville"/></p>
    </xsl:template>

    <xsl:template match="visite">
        <tr>
            <td><xsl:value-of select="@date"/></td>
            <td><xsl:value-of select="intervenant/prénom"/><xsl:text> </xsl:text><xsl:value-of select="intervenant/nom"/></td>
            <td>
                <ul>
                    <xsl:apply-templates select="acte"/>
                </ul>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="acte">
        <li><xsl:value-of select="."/> (coef: <xsl:value-of select="@coef"/>)</li>
    </xsl:template>
</xsl:stylesheet>