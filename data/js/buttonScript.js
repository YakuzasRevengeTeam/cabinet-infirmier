function openFacture(prenom, nom, actes) {
    var width = 500;
    var height = 300;
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
    var factureText = "Facture pour : " + prenom + " " + nom + "<br>";
    if (actes && actes.length > 0) {
        factureText += "Actes : <ul>";
        for (var i = 0; i < actes.length; i++) {
            factureText += "<li>" + actes[i] + "</li>";
        }
        factureText += "</ul>";
    }
    factureWindow.document.write(factureText);
}

// Fonction pour afficher les détails du patient
function showPatientDetails(patientId) {
    // Simule l'ouverture d'une page patient
    window.open('patient.html?id=' + patientId, '_blank');
}

// Fonction pour marquer une visite comme terminée
function markVisitDone(visitId) {
    // Simule la mise à jour (en réalité, enverrait à un serveur)
    alert('Visite ' + visitId + ' marquée comme terminée.');
}
