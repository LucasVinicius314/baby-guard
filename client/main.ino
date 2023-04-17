#include <SoftwareSerial.h>

SoftwareSerial esp8266(3, 4);

String ssid = "";
String password = "";

String host = "192.168.15.35";
String port = "5500";

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

// void printResponse()
// {
//   while (esp8266.available())
//   {
//     Serial.println(esp8266.readStringUntil('\n'));
//   }
// }

void setup()
{
  Serial.begin(9600);
  esp8266.begin(9600);

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(2, INPUT);

  Serial.println("=== 0");

  // WiFi connection setup.

  esp8266.println("AT");
  awaitResponse("OK");

  Serial.println("=== 1");

  esp8266.println("AT+CWMODE=1");
  awaitResponse("OK");

  Serial.println("=== 2");

  esp8266.println("AT+CWJAP=\"" + ssid + "\",\"" + password + "\"");
  awaitResponse("WIFI GOT IP");

  Serial.println("=== 3");

  // WiFi connection test.

  esp8266.println("AT+CIPMUX=1");
  awaitResponse("OK");

  Serial.println("=== 4");

  esp8266.println("AT+CIPSTART=\"TCP\",\"" + host + "\"," + port);
  awaitResponse("OK");

  Serial.println("=== 5");

  // String cmd = "GET /test.html HTTP/1.1";
  // esp8266.println("AT+CIPSEND=4," + String(cmd.length() + 4));
  // delay(1000);

  // Serial.println("=== 6");

  // esp8266.println(cmd);
  // delay(1000);
  // esp8266.println("");

  // Serial.println("=== 7");
}

void loop()
{
  // int in = digitalRead(2);

  // digitalWrite(LED_BUILTIN, in);

  // if (in == 1)
  // {
  //   Serial.write("detected");

  //   delay(5000);
  // }

  // if (Serial.available() > 0)
  // {
  //   String command = Serial.readStringUntil('\n');
  //   Serial.println("Command Sent: " + command);
  //   Serial.println();
  //   esp8266.println(command);
  // }

  // int responseCounter = 0;

  // if (esp8266.available() > 0)
  // {
  //   while (esp8266.available() > 0)
  //   {
  //     if (responseCounter == 0)
  //     {
  //       Serial.println("Response Received:");
  //     }

  //     String response = esp8266.readStringUntil('\n');
  //     Serial.println(response);
  //     responseCounter++;
  //   }
  // }
}
