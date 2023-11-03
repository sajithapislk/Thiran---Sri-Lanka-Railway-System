#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <Arduino_JSON.h>
#include <TinyGPS++.h>
#include <SoftwareSerial.h>

TinyGPSPlus gps;

const char* train_id = "1";

const char* ssid = "Apis_Technologies";
const char* password = "APIS1998";

unsigned long lastTime = 0;
unsigned long timerDelay = 60000;

String serverName = "http://192.168.1.141:8000/api/";

SoftwareSerial mygps(D1,D2);

double latitude, longitude;
double elevation;
double speed, direction;

void setup() {
  Serial.begin(9600);
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
}

void loop() {
  // if ((millis() - lastTime) > timerDelay) {
    if(WiFi.status()== WL_CONNECTED){
      while (mygps.available() > 0) {
        gps.encode(mygps.read());
        if (gps.location.isUpdated()) {
          latitude = gps.location.lat();
          longitude = gps.location.lng();
          elevation = gps.altitude.feet();
          speed = gps.speed.mph();
          direction = gps.course.deg();
          if (speed > 10) {
            Serial.println("Location is moving");
            
            Serial.println("Latitude= " + String(latitude));
            Serial.println("Longitude= " + String(longitude));
            Serial.println("Elevation= " + String(elevation));
            Serial.println("Speed= " + String(speed));
            Serial.println("Direction= " + String(direction));

          } else {
            Serial.println("Location is stable");
          }
        }
      }
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    // lastTime = millis();
  // }
}

String httpPOSTRequest(String route, String data) {
  WiFiClient client;
  HTTPClient http;

  http.begin(client, serverName + route);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  String httpRequestData = "key=tPmAT5Ab3j7F9&train_id=" +  String(train_id) + "&" + data;       

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