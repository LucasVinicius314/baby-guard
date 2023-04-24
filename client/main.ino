#include <SoftwareSerial.h>

SoftwareSerial esp8266(3, 4);

String ssid = "";
String password = "";

String host = "192.168.15.35";
String port = "3000";

void awaitResponse(String stopFlag)
{
  while (true)
  {
    int b = 0;

    int responseCounter = 0;

    while (esp8266.available() > 0)
    {
      if (responseCounter == 0)
      {
        Serial.println("Response Received:");
      }

      String response = esp8266.readStringUntil('\n');

      response.trim();

      Serial.println(response);

      responseCounter++;

      if (response.equals(stopFlag))
      {
        b = 1;

        break;
      }
    }

    if (b)
    {
      break;
    }
  }
}

void printResponse()
{
  while (esp8266.available())
  {
    Serial.println(esp8266.readStringUntil('\n'));
  }
}

void setupConnection()
{
  // WiFi connection setup.

  esp8266.println("AT");
  awaitResponse("OK");
  Serial.println("======== 1 - AT DONE");

  esp8266.println("AT+CWMODE=1");
  awaitResponse("OK");
  Serial.println("======== 2 - CWMODE DONE");

  esp8266.println("AT+CWJAP=\"" + ssid + "\",\"" + password + "\"");
  awaitResponse("WIFI GOT IP");
  Serial.println("======== 3 - CWJAP DONE");
}

void sendRequest()
{
  esp8266.println("AT+CIPMUX=1");
  awaitResponse("OK");

  esp8266.println("AT+CIPSTART=4,\"TCP\",\"" + host + "\"," + port);
  delay(100);
  printResponse();

  String cmd = "POST /api/v1/event/detection HTTP/1.1";
  esp8266.println("AT+CIPSEND=4," + String(cmd.length() + 4));
  delay(100);

  esp8266.println(cmd);
  delay(100);
  esp8266.println("");

  // while (true)
  // {
  //   if (esp8266.available())
  //   {
  //     String a = "";

  //     while (esp8266.available())
  //     {
  //       char j = esp8266.read();

  //       a += j;
  //     }

  //     Serial.println("================");
  //     Serial.println(a);
  //   }

  //   delay(10);
  // }
}

void setup()
{
  Serial.begin(9600);
  esp8266.begin(9600);

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(2, INPUT);

  // Fix baud rate.
  // esp8266.begin(115200);
  // Serial.println("=== SETUP");
  // esp8266.println("AT+UART_DEF=9600,8,1,0,0");
  // Serial.println("=== SETUP DONE");

  setupConnection();
}

void loop()
{
  int in = digitalRead(2);

  digitalWrite(LED_BUILTIN, in);

  if (in == 1)
  {
    Serial.println(">>> triggering detection");

    sendRequest();

    delay(1000);
  }

  delay(100);
}
