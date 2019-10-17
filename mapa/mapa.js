var log=0;
var map;
var options = {};
var persona;
var personaIcon;
var available_voices;
var myvoice = '';
var marker;
var synth;
var segmento_actual=-1;
var segmento_siguiente=-1;
var segmentos_siguientes=[];
var txt_indicaciones="Iniciaremos tu recorrido";
var estado_indicaciones=false;
var usuario,bus;

function openFullscreen(id) {
    let e = document.getElementById(id);
    if (e.requestFullscreen) {
        e.requestFullscreen();
    }
    else if (e.mozRequestFullScreen) { /* Firefox */
        e.mozRequestFullScreen();
    }
    else if (e.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
        e.webkitRequestFullscreen();
    }
    else if (e.msRequestFullscreen) { /* IE/Edge */
        e.msRequestFullscreen();
    }
};

function iniciar_indicaciones()
{
    habla("Iniciaremos tu recorrido");
    estado_indicaciones=true;

}

function terminar_indicaciones()
{
    estado_indicaciones=false;
    habla("Hemos Terminado")
    segmento_actual=-1;
    segmento_siguiente=-1;
    segmentos_siguientes=[];
    document.getElementById("log").innerHTML="";
    log=0;
}

usuario=window.prompt("Nombre de usuario");
bus=window.prompt("Nombre del bus");

function main() 
{   
    cargar_rutas();

    options =
        {
            enableHighAccuracy: true,
            timeout: 5000,
            maximumAge: 0
        };

    personaIcon = L.icon(
        {
            iconUrl: 'person.png',
            shadowUrl: 'person-shadow.png', 

            iconSize: [40, 40], // size of the icon
            shadowSize: [40, 40], // size of the shadow
            iconAnchor: [0, 40], // point of the icon which will correspond to marker's location
            shadowAnchor: [0, 40],  // the same for the shadow
            popupAnchor: [0, -40] // point from which the popup should open relative to the iconAnchor
        });

        navigator.geolocation.getCurrentPosition(success, error, options);
        navigator.geolocation.watchPosition(marca, error, options);
}