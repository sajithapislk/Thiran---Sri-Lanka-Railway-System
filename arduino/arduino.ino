#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <Arduino_JSON.h>
#include <TinyGPS++.h>
#include <SoftwareSerial.h>

TinyGPSPlus gps;

const char* train_id = "1";

const char* ssid = "Dialog 4G 035";
const char* password = "Ashan93252";

unsigned long lastTime = 0;
unsigned long timerDelay = 10000;

String serverName = "http://192.168.8.181:8000/api/";

SoftwareSerial mygps(D1, D2);

double latitude, longitude;
double elevation;
double speed, direction;

void setup() {
  Serial.begin(9600);
  mygps.begin(9600);

  WiFi.begin(ssid, password);
  Serial.println("Connecting");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");

  Serial.println(WiFi.localIP());
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
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

          httpPOSTRequest("train-location", "latitude=" + String(latitude) + "&longitude=" + String(longitude) + "&status=MOVING");
        } else {
          Serial.println("Location is not moving");

          Serial.println("Latitude= " + String(latitude));
          Serial.println("Longitude= " + String(longitude));
          Serial.println("Elevation= " + String(elevation));
          Serial.println("Speed= " + String(speed));
          Serial.println("Direction= " + String(direction));

          httpPOSTRequest("train-location", "latitude=" + String(latitude) + "&longitude=" + String(longitude) + "&status=NOT_MOVING");
        }
      }
    }
  } else {
    Serial.println("WiFi Disconnected");
  }
}
String httpPOSTRequest(String route, String data) {
  if ((millis() - lastTime) > timerDelay) {
    WiFiClient client;
    HTTPClient http;
    http.begin(client, serverName + route);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    String httpRequestData = "key=tPmAT5Ab3j7F9&train_id=" + String(train_id) + "&" + data;
    int httpResponseCode = http.POST(httpRequestData);

    String payload = "{}";

    if (httpResponseCode > 0) {
      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode);
      payload = http.getString();
    } else {
      Serial.print("Error code: ");
      Serial.println(httpResponseCode);
    }
    http.end();
    Serial.println(payload);
    lastTime = millis();

    return payload;
  }else{
    return "";
  }
}