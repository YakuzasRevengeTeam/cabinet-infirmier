<?xml version="1.0" encoding="UTF-8"?>
<!--
  Extraction de la fiche patient depuis cabinet.xml
  Entrée: cabinet.xml (namespace med)
  Paramètre: destinedName (nom du patient à extraire)
  Sortie: NOMPATIENT.xml
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:med="http://www.univ-grenoble-alpes.fr/l3miage/medical"
				version="1.0">
	<xsl:output method="xml" indent="yes"/>

	<!-- Paramètre: nom du patient ciblé -->
	<xsl:param name="destinedName">Pien</xsl:param>

	<!-- Racine: délègue au template patient ciblé -->
	<xsl:template match="/">
		<xsl:apply-templates select="/med:cabinet/med:patients/med:patient[normalize-space(med:nom)=$destinedName]"/>
	</xsl:template>

	<!-- Patient sélectionné: construire la fiche -->
	<xsl:template match="med:patient">
		<patient>
			<nom><xsl:value-of select="normalize-space(med:nom)"/></nom>
			<prénom><xsl:value-of select="normalize-space(med:prenom)"/></prénom>
			<naissance><xsl:value-of select="normalize-space(med:naissance)"/></naissance>
			<numéroSS><xsl:value-of select="normalize-space(med:numéro)"/></numéroSS>
			<xsl:apply-templates select="med:adresse"/>
			<!-- Visites triées par date décroissante -->
			<xsl:apply-templates select="med:visites/med:visite">
				<xsl:sort select="@date" data-type="text" order="descending"/>
			</xsl:apply-templates>
		</patient>
	</xsl:template>

	<!-- Adresse -->
	<xsl:template match="med:adresse">
		<adresse>
			<xsl:if test="string(med:rue)"><rue><xsl:value-of select="normalize-space(med:rue)"/></rue></xsl:if>
			<xsl:if test="string(med:codePostal)"><codePostal><xsl:value-of select="normalize-space(med:codePostal)"/></codePostal></xsl:if>
			<xsl:if test="string(med:ville)"><ville><xsl:value-of select="normalize-space(med:ville)"/></ville></xsl:if>
		</adresse>
	</xsl:template>

	<!-- Visite: intervenant + actes -->
	<xsl:template match="med:visite">
		<visite>
			<xsl:attribute name="date"><xsl:value-of select="@date"/></xsl:attribute>
			<intervenant>
				<xsl:variable name="iid" select="@intervenant"/>
				<xsl:variable name="inf" select="/med:cabinet/med:infirmiers/med:infirmier[@id=$iid]"/>
				<nom><xsl:value-of select="normalize-space($inf/med:nom)"/></nom>
				<prénom><xsl:value-of select="normalize-space($inf/med:prenom)"/></prénom>
			</intervenant>
			<xsl:apply-templates select="med:actes/med:acte"/>
		</visite>
	</xsl:template>

	<!-- Acte: attribut coef + libellé en contenu -->
	<xsl:template match="med:acte">
		<acte>
			<xsl:attribute name="coef"><xsl:value-of select="med:coef"/></xsl:attribute>
			<xsl:value-of select="normalize-space(med:type)"/>
		</acte>
	</xsl:template>
</xsl:stylesheet>
