function getRadioButtonSelectedValuePrender() {
    var elementos = document.getElementsByName("option");
    var estado = document.getElementById("fstate").value

    for(var i=0; i<elementos.length; i++) {
        alert("Seleccionado: " + elementos[i].checked + "\n" + "Si la instancia ya esta PRENDIDA simplemente no sucedera nada :)");
    }
}


function getRadioButtonSelectedValueApagar() {
    var elementos = document.getElementsByName("option");

    for(var i=0; i<elementos.length; i++) {
        alert("Seleccionado: " + elementos[i].checked + "\n" + "Si la instancia ya esta APAGADA simplemente no sucedera nada :)");
    }
}