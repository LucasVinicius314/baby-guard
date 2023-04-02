// #include <SoftwareSerial.h>

// SoftwareSerial esp8266(0, 1);

void setup()
{
  Serial.begin(9600);
  // esp8266.begin(9600);

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(2, INPUT);
}

void loop()
{
  int in = digitalRead(2);

  digitalWrite(LED_BUILTIN, in);

  // if (in == 1)
  // {
  //   Serial.write("detected");

  //   delay(5000);
  // }

  // if (esp8266.available())
  // {
  //   while (esp8266.available())
  //   {
  //     char c = esp8266.read();

  //     Serial.write(c);
  //   }
  // }

  delay(100);
}