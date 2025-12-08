<?xml version="1.0" encoding="UTF-8"?>
<!--
  Partie 2 – Extraction de la fiche patient depuis cabinet.xml
  - Entrée: cabinet.xml (namespace med)
  - Paramètre: destinedName (nom du patient à extraire)
  - Sortie: NOMPATIENT.xml
  - Contraintes: utiliser xsl:apply-templates + xsl:template (pas de for-each)
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:med="http://www.univ-grenoble-alpes.fr/l3miage/medical"
				version="1.0">
	<xsl:output method="xml" indent="yes"/>

	<!-- Paramètre: nom du patient ciblé (modifiable plus tard par le WebService) -->
	<xsl:param name="destinedName">Pien</xsl:param>

	<!-- Racine: délègue au template patient ciblé -->
	<xsl:template match="/">
		<xsl:apply-templates select="/med:cabinet/med:patients/med:patient[normalize-space(med:nom)=$destinedName]"/>
	</xsl:template>

	<!-- Patient sélectionné: construire la fiche demandée -->
	<xsl:template match="med:patient">
		<patient>
			<nom><xsl:value-of select="normalize-space(med:nom)"/></nom>
			<prénom><xsl:value-of select="normalize-space(med:prenom)"/></prénom>
			<!-- Champs optionnels, s'ils existent dans votre schéma/données -->
			<xsl:if test="string(med:sexe)"><sexe><xsl:value-of select="normalize-space(med:sexe)"/></sexe></xsl:if>
			<naissance><xsl:value-of select="normalize-space(med:naissance)"/></naissance>
			<numéroSS><xsl:value-of select="normalize-space(med:numéro)"/></numéroSS>
			<xsl:apply-templates select="med:adresse"/>
			<!-- Visites triées par date (ordre décroissant comme l'exemple) -->
			<xsl:apply-templates select="med:visites/med:visite">
				<xsl:sort select="@date" data-type="text" order="descending"/>
			</xsl:apply-templates>
		</patient>
	</xsl:template>

	<!-- Adresse mise en clair -->
	<xsl:template match="med:adresse">
		<adresse>
			<xsl:if test="string(med:rue)"><rue><xsl:value-of select="normalize-space(med:rue)"/></rue></xsl:if>
			<xsl:if test="string(med:codePostal)"><codePostal><xsl:value-of select="normalize-space(med:codePostal)"/></codePostal></xsl:if>
			<xsl:if test="string(med:ville)"><ville><xsl:value-of select="normalize-space(med:ville)"/></ville></xsl:if>
		</adresse>
	</xsl:template>

	<!-- Visite: intervenant (nom/prénom) + libellé complet des actes -->
	<xsl:template match="med:visite">
		<visite>
			<xsl:attribute name="date"><xsl:value-of select="@date"/></xsl:attribute>
			<intervenant>
				<!-- Recherche de l'infirmier par id -->
				<xsl:variable name="iid" select="@intervenant"/>
				<xsl:variable name="n" select="/med:cabinet/med:infirmiers/med:infirmier[@id=$iid]/med:nom"/>
				<xsl:variable name="p" select="/med:cabinet/med:infirmiers/med:infirmier[@id=$iid]/med:prenom"/>
				<nom><xsl:value-of select="normalize-space($n)"/></nom>
				<prénom><xsl:value-of select="normalize-space($p)"/></prénom>
			</intervenant>
			<!-- Un élément <acte> par acte (libellé exact = med:type) -->
			<xsl:apply-templates select="med:actes/med:acte"/>
		</visite>
	</xsl:template>

	<xsl:template match="med:acte">
		<acte>
			<xsl:attribute name="coef"><xsl:value-of select="med:coef"/></xsl:attribute>
			<xsl:value-of select="normalize-space(med:type)"/>
		</acte>
	</xsl:template>
</xsl:stylesheet>
