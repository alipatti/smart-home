#include <WiFi.h>
#include <WiFiClient.h>
#include <WebServer.h>
#include <ESPmDNS.h>

// ---------
// CONSTANTS
// ---------

const int relay_pin_number = 13;

// TODO connect to raspberry pi network
const char *wifi_ssid = "........";
const char *wifi_password = "........";

WebServer server(80); // http server on port 80

// ----------------------
// ARDUINO CORE FUNCTIONS
// ----------------------

void setup(void)
{
    // serial
    Serial.print("Setting up serial... ");
    Serial.begin(115200);
    Serial.println("done");

    // gpio
    Serial.print("Setting up gpio... ");
    pinMode(relay_pin_number, OUTPUT);
    digitalWrite(relay_pin_number, 0); // TODO
    Serial.println("done");

    // wifi
    Serial.print("Setting up wifi... ");
    WiFi.mode(WIFI_STA);
    WiFi.begin(wifi_ssid, wifi_password);

    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
    }

    Serial.print("done (");
    Serial.println(WiFi.localIP());
    Serial.print(" @ ");
    Serial.print(wifi_ssid);
    Serial.println(")");

    // mdns
    Serial.print("Setting up mDNS... ");
    if (!MDNS.begin("esp32-relay"))
    {
        Serial.println("failed, restarting...");
        ESP.restart();
    }
    Serial.println("done");

    // server
    Serial.print("Setting up server... ");
    server.on("/on", handleOn);
    server.on("/off", handleOff);
    server.begin();
    Serial.println("done");

    // setup complete!
    Serial.println("---------------");
    Serial.println("Setup complete.");
    Serial.println("---------------");
    Serial.println("");
}

void loop(void)
{
    server.handleClient();
    delay(2); // allow the cpu to switch to other tasks
}

// -------------
// HTTP HANDLERS
// -------------

void handleOn()
{
    digitalWrite(relay_pin_number, 1);
    Serial.println("Relay activated");
    server.send(200, "text/plain", "");
}

void handleOff()
{
    digitalWrite(relay_pin_number, 0);
    Serial.println("Relay deactivated");
    server.send(200, "text/plain", "");
}
