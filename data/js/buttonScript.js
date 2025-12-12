// Tarif de base AMI (en euros)
var TARIF_AMI = 3.15;

function openFacture(prenom, nom, adresse, numeroSS, acteIds, coefs) {
    var width = 600;
    var height = 500;
    if (window.innerWidth) {
        var left = (window.innerWidth - width) / 2;
        var top = (window.innerHeight - height) / 2;
    } else {
        var left = (document.body.clientWidth - width) / 2;
        var top = (document.body.clientHeight - height) / 2;
    }
    var factureWindow = window.open('', 'facture',
        'menubar=yes, scrollbars=yes, top=' + top +
        ', left=' + left + ', width=' + width +
        ', height=' + height);
    var factureText = afficherFacture(prenom, nom, adresse, numeroSS, acteIds, coefs);
    factureWindow.document.write(factureText);
}

function afficherFacture(prenom, nom, adresse, numeroSS, acteIds, coefs) {
    var ids = acteIds ? acteIds.split(',') : [];
    var coefficients = coefs ? coefs.split(',') : [];
    
    var html = '<!DOCTYPE html><html><head><meta charset="UTF-8"/>';
    html += '<title>Facture</title>';
    html += '<style>';
    html += 'body { font-family: Arial, sans-serif; padding: 20px; }';
    html += 'h1 { color: #333; border-bottom: 2px solid #333; }';
    html += 'table { width: 100%; border-collapse: collapse; margin-top: 20px; }';
    html += 'th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }';
    html += 'th { background-color: #f0f0f0; }';
    html += '.total { font-weight: bold; background-color: #e0e0e0; }';
    html += '.info { margin-bottom: 5px; }';
    html += '</style></head><body>';
    
    // En-tête
    html += '<h1>Facture</h1>';
    
    // Identité du patient
    html += '<h2>Patient</h2>';
    html += '<p class="info"><strong>Nom :</strong> ' + prenom + ' ' + nom + '</p>';
    html += '<p class="info"><strong>Adresse :</strong> ' + adresse + '</p>';
    html += '<p class="info"><strong>N° Sécurité Sociale :</strong> ' + numeroSS + '</p>';
    
    // Tableau des actes
    html += '<h2>Actes réalisés</h2>';
    html += '<table>';
    html += '<thead><tr><th>Code Acte</th><th>Coefficient</th><th>Tarif (€)</th></tr></thead>';
    html += '<tbody>';
    
    var total = 0;
    for (var i = 0; i < ids.length; i++) {
        var coef = parseFloat(coefficients[i]) || 0;
        var tarif = coef * TARIF_AMI;
        total += tarif;
        html += '<tr>';
        html += '<td>' + ids[i] + '</td>';
        html += '<td>' + coef + '</td>';
        html += '<td>' + tarif.toFixed(2) + '</td>';
        html += '</tr>';
    }
    
    // Ligne total
    html += '<tr class="total">';
    html += '<td colspan="2">TOTAL</td>';
    html += '<td>' + total.toFixed(2) + ' €</td>';
    html += '</tr>';
    
    html += '</tbody></table>';
    html += '</body></html>';
    
    return html;
}