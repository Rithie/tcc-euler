const int ananlogIn = A0;
int analogVal = 0;

void setup(){
  Serial.begin(19200);
}

void loop(){
  analogVal = analogRead(ananlogIn);
  Serial.println(analogVal);
//  Serial.println(analogVal/2+10);
  delay(100);
}
