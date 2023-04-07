//ProyectoArduino-Processing-SQL
#include "DHT.h"
DHT dht(2, DHT11);
void setup() {
  Serial.begin(9600);
  dht.begin();
}
void loop() {
  delay(2000);
  float humedad = dht.readHumidity();
  float centigrados = dht.readTemperature();
   Serial.print(humedad);
   Serial.print(",");
   Serial.println(centigrados);
}
