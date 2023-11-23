<template>
    <GMapMap
      :center="center"
      :zoom="10"
      map-type-id="terrain"
      style="width: 20vw; height: 20rem"
      @click="handleMapClick"
      :options="mapOptions"
    >
      <!-- Other map components here -->
    </GMapMap>
  </template>

  <script setup>
  import { ref } from 'vue';

  const center = ref({ lat:7.466878843230555, lng: 80.62544710311586 });

  const handleMapClick = (event) => {
    const clickedLatLng = {
      lat: event.latLng.lat(),
      lng: event.latLng.lng(),
    };
    console.log('Clicked Latitude:', clickedLatLng.lat);
    console.log('Clicked Longitude:', clickedLatLng.lng);
    // You can use the clickedLatLng data as needed
  };

  const mapOptions = {
    styles: [
      {
        featureType: 'all',
        elementType: 'geometry',
        stylers: [
          {
            visibility: 'on',
          },
        ],
      },
      {
        featureType: 'all',
        elementType: 'labels',
        stylers: [
          {
            visibility: 'on',
          },
        ],
      },
    ],
    gestureHandling: 'cooperative',
    draggableCursor: 'crosshair', // Change the mouse icon to a crosshair
  };
  </script>
