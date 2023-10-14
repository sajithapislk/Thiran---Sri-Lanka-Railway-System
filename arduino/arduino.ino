#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <Arduino_JSON.h>
#include <TinyGPS++.h>

TinyGPSPlus gps;

const char* train_id = "1";

const char* ssid = "Apis_Technologies";
const char* password = "APIS1998";

unsigned long lastTime = 0;
unsigned long timerDelay = 60000;

String serverName = "http://192.168.1.141:8000/api/";

SoftwareSerial mygps(D1,D2);

void setup() {
  Serial.begin(115200);
  mygps.begin(9600);

  WiFi.begin(ssid, password);
  Serial.println("Connecting");

  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");

  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
}

void loop() {
  if ((millis() - lastTime) > timerDelay) {
    if(WiFi.status()== WL_CONNECTED){
      
      String gpsData = gpsRead();
      Serial.println(gpsData);
      if(gpsData!=""){
        httpPOSTRequest(serverName,gpsData);
      }
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }
}

int gpsRead(){
  while (mygps.available() > 0){
    gps.encode(mygps.read());
    if (gps.location.isUpdated()){
      Serial.print("Latitude= "); 
      Serial.print(gps.location.lat(), 6);
      Serial.print(" Longitude= "); 
      Serial.println(gps.location.lng(), 6);
      return "latitude="+gps.location.lat()+"&longitude="+gps.location.lng())
    } 
  }
  return "";
}

String httpPOSTRequest(String serverName, String data) {
  WiFiClient client;
  HTTPClient http;

  http.begin(client, serverName + "train_location");
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  String httpRequestData = "key=tPmAT5Ab3j7F9&train_id=" + train_id + "&" + data;       

  int httpResponseCode = http.POST(httpRequestData);
  
  String payload = "{}"; 
  
  if (httpResponseCode>0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    payload = http.getString();
  }
  else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }

  http.end();

  Serial.println(payload);

  return payload;
}