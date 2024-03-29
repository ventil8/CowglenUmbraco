$(function () {
    loadMap();
    
});

function loadMap() {
  var mapId = "map";

  if(document.getElementById(mapId) == null) {
    return;
  }
  
  var mapsElement = document.getElementById(mapId);
  var coords = mapsElement.innerHTML.split(",");
  if (coords.length != 3) {
    mapsElement.display = "none";
    return;
  }

  var latlng = new google.maps.LatLng(parseFloat(coords[0]),parseFloat(coords[1]));
  var myOptions = {
    zoom: parseFloat(coords[2]),
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    disableDefaultUI: true,
    mapTypeControl: true,
    zoomControl: true,
    zoomControlOptions: {
      style: google.maps.ZoomControlStyle.SMALL
    }
  };
  
  var map = new google.maps.Map(document.getElementById(mapId), myOptions);
  
  var marker = new google.maps.Marker({
    position: latlng,
    map: map
  });   
}
