void setup()
{
  Serial.begin(9600);

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(2, INPUT);
}

void loop()
{
  int in = digitalRead(2);

  digitalWrite(LED_BUILTIN, in);

  if (in == 1)
  {
    Serial.write("detected");

    delay(5000);
  }

  delay(100);
}