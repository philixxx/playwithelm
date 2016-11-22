'use strict';
// require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
// On importe index.html pour qu'il soit intégré au *dist*
var Elm = require('./MainReservation.elm');

var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode,  window.options);

global.selectObserver = {select : function(id){
      app.ports.spotActionOn.send(["SELECTED",id]);
  },
  unselect : function(id){
      app.ports.spotActionOn.send(["UNSELECTED",id]);
    }
}

app.ports.setView.subscribe(function(data){
    global.map.setView.apply(global.map, data);
});
app.ports.loadData.subscribe(function(data){
    dataManager.loadDataFromJson(data,global.drawnItems )
});


app.ports.spotPropertiesHasBeenUpdated.subscribe(function(data){
  global.dataManager.updateEmplacementProperties(data.Id,data)

});

app.ports.callReservation.subscribe(function(data){
  //delegate the next stuff to php/standard js

  if (typeof  preReserveButtonAction === "function")
  {
    preReserveButtonAction(data);
  }else{
    console.log("Unable to call preReserveButtonAction action ", data)
  }

})
