//this.criteriosSet = new Set();

function agregarCriterio() {
    var criterio = document.getElementById("nuevoCriterio");
    var table = document.getElementById("myTableData");
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);

    //if (!this.criteriosSet.has(criterio)) {
    //  this.criteriosSet.push(criterio);
    row.insertCell(0).innerHTML = criterio.value;
    row.insertCell(1).innerHTML = '<button class="btn btn-danger" onClick="Javacsript:borrarCriterio(this)"><i class="fa fa-trash-o" aria-hidden="true"></i>   Quitar</button>';
    // }
}

function borrarCriterio(obj) {
    var index = obj.parentNode.parentNode.rowIndex;
    var table = document.getElementById("myTableData");
    table.deleteRow(index);
}