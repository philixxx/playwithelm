'use strict';
// require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
// On importe index.html pour qu'il soit intégré au *dist*
var Elm = require('./Main.elm');

var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);

app.ports.setView.subscribe(function(data){
    console.log(data);
    global.map.setView.apply(global.map, data);
});
app.ports.loadData.subscribe(function(data){
    console.log("InLoadData", data);
    L.brocante.load(1);
});

app.ports.selectPlace.subscribe(function(data){
    var emplacement = global.dataManager.getEmplacementById(data.replace(/\"/g,''));
    console.log("Select e ", emplacement);
    global.selectManager.selectForReservation(emplacement)
    emplacement.refreshDisplay();
});
