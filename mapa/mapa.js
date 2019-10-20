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
var usuario,vehiculo,tipo;

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
    habla("Start");
    estado_indicaciones=true;

}

function terminar_indicaciones()
{
    estado_indicaciones=false;
    habla("End")
    segmento_actual=-1;
    segmento_siguiente=-1;
    segmentos_siguientes=[];
    document.getElementById("log").innerHTML="";
    log=0;
}

function success(pos) {
    var crd = pos.coords;

    console.log('Posicion Actual:');
    console.log('Latitud: ' + crd.latitude);
    console.log('Longitud: ' + crd.longitude);
    console.log('Al rededor de ' + crd.accuracy + ' meters.');

    map = L.map('mapid').setView([crd.latitude, crd.longitude], 17);
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a>',
            maxZoom: 19
        }).addTo(map);

    persona = L.marker([crd.latitude, crd.longitude],
        {
            icon: personaIcon,
            alt: "Rastreo de Persona"
        }).addTo(map);
    persona.bindPopup("<a href='javascript:iniciar_indicaciones();'><butom> Inicio </butom></a>").openPopup();

    map.locate({ setView: true, maxZoom: 19, enableHighAccuracy: true });

};

//carga el error en caso de no ponder capturar la posicion actual
function error(err) {
    console.warn('ERROR(' + err.code + '): ' + err.message);
};

function marca(pos) {
    let crd = pos.coords;
    let vehiculo = this.vehiculo;
    let usuario = this.usuario;
    let tipo = this.tipo;

    console.log(crd.latitude, crd.longitude);
    // map.removeLayer(persona);
    // persona.setLatLng(new L.LatLng(crd.latitude, crd.longitude));
    // persona.addTo(map);
    console.log("entra1");
    if (true)
    {
        console.log("entra2");
        let xhttp =new XMLHttpRequest ();
        xhttp.onreadystatechange= function()
        {
            if (this.readyState==4 && this.status==200)
            {    
                console.log(this.responseText); 
            }
        }; 
        
        let url="guardar_ruta.php?x="+crd.latitude+"&y="+crd.longitude+
                "&vehiculo="+vehiculo+"&usuario="+usuario+"&tipo="+tipo;
        xhttp.open("GET",url,true);  
        xhttp.send(); 
    }
    
};



function mapa(tipo,usuario,vehiculo) 
{ 
    this.tipo = tipo;
    this.usuario = usuario;
    this.vehiculo = vehiculo;
    options =
        {
            enableHighAccuracy: true,
            timeout: 5000,
            maximumAge: 0
        };

    personaIcon = L.icon(
        {
            iconUrl: 'imagenes/poro.png', 
            iconSize: [60, 60], // size of the icon
            iconAnchor: [0, 40], // point of the icon which will correspond to marker's location
            popupAnchor: [0, -40] // point from which the popup should open relative to the iconAnchor
        });

        navigator.geolocation.getCurrentPosition(success, error, options);
        navigator.geolocation.watchPosition(marca, error, options);
}