/*****************************************************************
LSM9DS1_Basic_I2C.ino
SFE_LSM9DS1 Library Simple Example Code - I2C Interface
Jim Lindblom @ SparkFun Electronics
Original Creation Date: April 30, 2015
https://github.com/sparkfun/SparkFun_LSM9DS1_Particle_Library

The LSM9DS1 is a versatile 9DOF sensor. It has a built-in
accelerometer, gyroscope, and magnetometer. Very cool! Plus it
functions over either SPI or I2C.

This Photon sketch is a demo of the simple side of the
SFE_LSM9DS1 library. It'll demo the following:
* How to create a LSM9DS1 object, using a constructor (global
  variables section).
* How to use the begin() function of the LSM9DS1 class.
* How to read the gyroscope, accelerometer, and magnetometer
  using the readGryo(), readAccel(), readMag() functions and
  the gx, gy, gz, ax, ay, az, mx, my, and mz variables.
* How to calculate actual acceleration, rotation speed,
  magnetic field strength using the calcAccel(), calcGyro()
  and calcMag() functions.
* How to use the data from the LSM9DS1 to calculate
  orientation and heading.

Hardware setup: This library supports communicating with the
LSM9DS1 over either I2C or SPI. This example demonstrates how
to use I2C.

If you have the Photon IMU shield, no extra wiring is required.
If you're using a breakout, the pin-out is as follows:
    LSM9DS1 --------- Photon
     SCL -------------- D1 (SCL)
     SDA -------------- D0 (SDA)
     VDD ------------- 3.3V
     GND ------------- GND
(CSG, CSXM, SDOG, and SDOXM should all be pulled high.
Jumpers on the breakout board will do this for you.)

Development environment specifics:
    IDE: Particle Build
    Hardware Platform: Particle Photon
                       SparkFun Photon IMU Shield

This code is released under the MIT license.

Distributed as-is; no warranty is given.
*****************************************************************/
#include "SparkFunLSM9DS1.h"
#include "math.h"
#include "neopixel.h"



//////////////////////////
// LSM9DS1 Library Init //
//////////////////////////
// Use the LSM9DS1 class to create an object. [imu] can be
// named anything, we'll refer to that throught the sketch.
LSM9DS1 imu;

///////////////////////
// Example I2C Setup //
///////////////////////
// SDO_XM and SDO_G are both pulled high, so our addresses are:
#define LSM9DS1_M   0x1E // Would be 0x1C if SDO_M is LOW
#define LSM9DS1_AG  0x6B // Would be 0x6A if SDO_AG is LOW

////////////////////////////
// Sketch Output Settings //
////////////////////////////
#define PRINT_CALCULATED
//#define PRINT_RAW
#define PRINT_SPEED 50 // 50 ms poll intervals

#define SERVO_PIN A5
#define SERVO_CLOSE 80
#define SERVO_OPEN 105
#define PIXEL_PIN D2
#define PIXEL_COUNT 60
#define PIXEL_TYPE WS2812B

#define RED 1
#define GREEN 2
#define BLUE 3
#define NONE 4

// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel ledStrip = Adafruit_NeoPixel(PIXEL_COUNT, PIXEL_PIN, PIXEL_TYPE);

// This will release a spring-loaded nose cone (i hope)
Servo releaseServo;

int previousColor = NONE;

// This application does not need network...
SYSTEM_MODE(SEMI_AUTOMATIC);

void setup()
{
  Serial.begin(115200);

  ledStrip.begin();

  // Set reference position for servo.
  releaseServo.attach(SERVO_PIN);
  releaseServo.write(SERVO_CLOSE);

  // Before initializing the IMU, there are a few settings
  // we may need to adjust. Use the settings struct to set
  // the device's communication mode and addresses:
  imu.settings.device.commInterface = IMU_MODE_I2C;
  imu.settings.device.mAddress = LSM9DS1_M;
  imu.settings.device.agAddress = LSM9DS1_AG;
  // The above lines will only take effect AFTER calling
  // imu.begin(), which verifies communication with the IMU
  // and turns it on.
  if (!imu.begin())
  {
    Serial.println("Failed to communicate with LSM9DS1.");
    Serial.println("Double-check wiring.");
    Serial.println("Default settings in this sketch will " \
                  "work for an out of the box LSM9DS1 " \
                  "Breakout, but may need to be modified " \
                  "if the board jumpers are.");
    while (1)
      ;
  }
}

void loop() {

  imu.readAccel();

  float accRawX = imu.calcAccel(imu.ax);
  float accRawY = imu.calcAccel(imu.ay);
  float accRawZ = imu.calcAccel(imu.az);
  Serial.print(String("X: ") + String(accRawX) + String(", Y: ") + String(accRawY) + String(", Z: ") + String(accRawZ));
  Serial.println();

  // When sitting on the tabletop, these should sum to
  // almost 1 (not everywhere on Earth is exactly same).
  // expected values are from 0 - 2...
  // Our color strip likes values from 0 to 200;
  float brightnessRawX = fabs(accRawX);
  float brightnessRawY = fabs(accRawY);
  float brightnessRawZ = fabs(accRawZ);

  float brightnessRaw = brightnessRawX + brightnessRawY + brightnessRawZ;

  int brightness = (int)(brightnessRaw * 100.0);

  Serial.print(String("brightness(X): ") + String(brightness));
  Serial.println();

  int currentColor;
  if (brightness < 40) {
      currentColor = BLUE;
      updateColorStrip(0, 0, brightness); // weightless

      if (previousColor != currentColor) {
          deployNoseCone();
      }
  } else
  if (brightness > 40 && brightness < 175) {
      currentColor = GREEN;
      updateColorStrip(0, brightness, 0);  // normal G
  } else
  if (brightness > 175) {
      currentColor = RED;
      updateColorStrip(brightness, 0, 0); // higher G
  }

  previousColor = currentColor;

  delay(PRINT_SPEED);
}

void deployNoseCone() {
    Serial.print("Deploying nose cone!");
    Serial.println();

    releaseServo.write(SERVO_OPEN);
    delay(1000);
    releaseServo.write(SERVO_CLOSE);
}

void updateColorStrip(int red, int green, int blue) {
    for(int i=0 ; i<PIXEL_COUNT ; i++){
        // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
        ledStrip.setPixelColor(i, ledStrip.Color(red,green,blue)); // Moderately bright green color.
        ledStrip.show(); // This sends the updated pixel color to the hardware.
    }
}
