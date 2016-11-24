'use strict';
// require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
// On importe index.html pour qu'il soit intégré au *dist*
var Elm = require('./MainEdition.elm');

var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode,  window.options);
app.ports.loadData.subscribe(function(data){
    dataManager.loadDataFromJson(data,global.drawnItems )
});
