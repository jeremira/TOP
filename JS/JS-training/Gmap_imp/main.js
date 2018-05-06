//to do :
//add validation for form
//style baby !

var map;
var infoWindow;

document.getElementById('submit').addEventListener('click', submitForm);



//Init function
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: -34.397, lng: 150.644},
		zoom: 8
	});
	infoWindow = new google.maps.InfoWindow({content: 'You should have said something...'});
};

//Submit Long/Lag/message form
function submitForm(event) {
	event.preventDefault();
	infoWindow.close();
	var longitude = parseInt(document.getElementById('longitude').value);
	var latitude  = parseInt(document.getElementById('latitude').value);
	var message   = document.getElementById('message').value;
	var markerCoord = { lat: latitude, lng: longitude};
	//place marker
	var marker = new google.maps.Marker({
		position: markerCoord,
		map: map,
		title: longitude +':'+ latitude
	});
	//add click listener to the marker
	marker.addListener('click', function(){
		infoWindow.setContent('<p>' + message + '</p>');
		infoWindow.open(map, marker);
	});
	//move map to the marker
	map.setZoom(5);
	map.setCenter(markerCoord);

};