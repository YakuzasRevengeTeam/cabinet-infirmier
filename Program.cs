// See https://aka.ms/new-console-template for more information

using CabinetInfirmier;

XMLUtils.ValidateXmlFileAsync("http://www.univ-grenoble-alpes.fr/l3miage/medical", "./data/xml/cabinet.xml", "./data/xsd/cabinet.xsd");