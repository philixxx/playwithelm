'use strict';
// require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
// On importe index.html pour qu'il soit intégré au *dist*
var Elm = require('./MainEdition.elm');

var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode,  window.options);
global.dataObserver = {
  newSpotAdded : function(spot){
      app.ports.spotAdded.send(spot);
  },
  spotRemoved : function(spotId){
      app.ports.spotRemoved.send(spotId);
  }

}
global.mapObserver = {zoomLevelChanged : function(level){
      app.ports.zoomLevelChanged.send(level);
  },
  centerChanged : function(lat,lng){
       app.ports.centerChanged.send({"lat": lat,"lng": lng});
  }
}       


global.selectObserver = {select : function(id){
      app.ports.spotActionOn.send(["SELECTED",id]);
  },
  unselect : function(id){
      app.ports.spotActionOn.send(["UNSELECTED",id]);
    }
}

app.ports.updateSpotSelectStateTo.subscribe(function(data){
  var state = data [1];
  var spotId = data[0];
  if(state === "UNSELECTED")
  {
    selectManager.unselectById(spotId)
  }
  //Currently only unselect


});

app.ports.setView.subscribe(function(data){
    global.map.setView.apply(global.map, data);
});

app.ports.loadData.subscribe(function(data){
    dataManager.loadDataFromJson(data,global.drawnItems )
});

app.ports.spotPropertiesHasBeenUpdated.subscribe(function(data){
  global.dataManager.updateEmplacementProperties(data.Id,data)

});
