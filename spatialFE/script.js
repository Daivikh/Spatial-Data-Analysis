
// Initialize the Leaflet map
var map = L.map('map').setView([40.7112562,-74.0077561], 13);

// Add the OpenStreetMap tile layer
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);


fetch('http://localhost:8000/query')
  .then(response => response.json())
  .then(data => {
    data.forEach(place => {
      let marker = L.marker([place.latitude, place.longitude]).addTo(map);
      
      marker.bindPopup(place.amenity);
    });
  })
  .catch(error => {
    console.error('Error:', error);
  });
