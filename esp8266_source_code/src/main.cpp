#include <Arduino.h>

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

// SSID & Password
const char *ssid = "NodeMCU";
const char *password = "123456789";

// server is gonna listen on port 80
ESP8266WebServer server(80);

// led pins
#define RED_PIN D4
#define GREEN_PIN D5
#define BLUE_PIN D6

// led statates
bool redLedOn = false;
bool blueLedOn = false;
bool greenLedOn = false;

void handle_on_connect();
void handle_led_red_on();
void handle_led_red_off();
void handle_led_green_on();
void handle_led_green_off();
void handle_led_blue_on();
void handle_led_blue_off();
void handle_not_found();

void setup()
{
  Serial.begin(115200);
  // ports for the leds
  pinMode(D4, OUTPUT);
  pinMode(D5, OUTPUT);
  pinMode(D6, OUTPUT);

  WiFi.softAP(ssid, password);

  IPAddress myIP = WiFi.softAPIP();
  Serial.print("Access Point IP:");
  Serial.println(myIP);

  server.on("/", handle_on_connect);
  server.on("/red_on", handle_led_red_on);
  server.on("/red_off", handle_led_red_off);
  server.on("/green_on", handle_led_green_on);
  server.on("/green_off", handle_led_green_off);
  server.on("/blue_on", handle_led_blue_on);
  server.on("/blue_off", handle_led_blue_off);
  server.onNotFound(handle_not_found);

  server.begin();
  Serial.println("HTTP Server Started...");
}

void loop()
{
  server.handleClient();

  if (redLedOn)
  {
    digitalWrite(RED_PIN, HIGH);
  }
  else
  {
    digitalWrite(RED_PIN, LOW);
  }

  if (greenLedOn)
  {
    digitalWrite(GREEN_PIN, HIGH);
  }
  else
  {
    digitalWrite(GREEN_PIN, LOW);
  }

  if (blueLedOn)
  {
    digitalWrite(BLUE_PIN, HIGH);
  }
  else
  {
    digitalWrite(BLUE_PIN, LOW);
  }
}

void handle_on_connect()
{
  Serial.println("All leds off");
  server.send(200, "application/json", "done!");
}

void handle_led_red_on()
{
  redLedOn = true;
  Serial.println("RED LED: ON");
  server.send(200, "application/json", "RED LED ON");
}

void handle_led_red_off()
{
  redLedOn = false;
  Serial.println("RED LED: OFF");
  server.send(200, "application/json", "RED LED OFF");
}

void handle_led_green_on()
{
  greenLedOn = true;
  Serial.println("GREEN LED: ON");
  server.send(200, "application/json", "GREEN LED ON");
}

void handle_led_green_off()
{
  greenLedOn = false;
  Serial.println("green LED: OFF");
  server.send(200, "application/json", "GREEN LED OFF");
}

void handle_led_blue_on()
{
  blueLedOn = true;
  Serial.println("BLUE LED: ON");
  server.send(200, "application/json", "BLUE LED ON");
}

void handle_led_blue_off()
{
  blueLedOn = false;
  Serial.println("BLUE LED: OFF");
  server.send(200, "application/json", "BLUE LED OFF");
}

void handle_not_found()
{
  server.send(404, "application/json", "Not found");
}
