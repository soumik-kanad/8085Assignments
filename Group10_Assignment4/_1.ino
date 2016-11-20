/*
  1. Playing with Arduino ADC: Input two different analog inputs to the ADC
module of Arduino, perform the mentioned operations and display the output
on a CRO. The first input should be from function generator and the second
input should be from any other input of your choice (e.g. potentiometer,
analog sensor, etc.). The operations are:
(i) Simple addition of the two input signals.
(ii) Subtract Signal 2 from Signal 1.
 
*/

int positiveInputPin = A0;
int negInputPin      = A1;
int potenPin         = A6;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  
  // read the input from function generator
  // from analog input pins A0,A1
  int negValue = analogRead(positiveInputPin);
  int posVal = analogRead(negInputPin);
  int valA =  posVal - negValue;

  // read input from potentiometer from
  // analog pin A6
  int potenVal = analogRead(potenPin);

  int resultVal = valA - potenVal;

  // Print resultant output on serial monitor
  Serial.println(resultVal);
 
  delay(1);        // delay in between reads for stability
}
