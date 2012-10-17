#include "built_in.h"


// TFT module connections
char TFT_DataPort at LATE;
sbit TFT_RST at LATC1_bit;
sbit TFT_BLED at LATA9_bit;
sbit TFT_RS at LATB15_bit;
sbit TFT_CS at LATF12_bit;
sbit TFT_RD at LATD5_bit;
sbit TFT_WR at LATD4_bit;
char TFT_DataPort_Direction at TRISE;
sbit TFT_RST_Direction at TRISC1_bit;
sbit TFT_BLED_Direction at TRISA9_bit;
sbit TFT_RS_Direction at TRISB15_bit;
sbit TFT_CS_Direction at TRISF12_bit;
sbit TFT_RD_Direction at TRISD5_bit;
sbit TFT_WR_Direction at TRISD4_bit;
// End TFT module connections

// Touch Panel module connections
sbit DriveX_Left at LATB13_bit;
sbit DriveX_Right at LATB11_bit;
sbit DriveY_Up at LATB12_bit;
sbit DriveY_Down at LATB10_bit;
sbit DriveX_Left_Direction at TRISB13_bit;
sbit DriveX_Right_Direction at TRISB11_bit;
sbit DriveY_Up_Direction at TRISB12_bit;
sbit DriveY_Down_Direction at TRISB10_bit;
// End Touch Panel module connections



// ADXL345 Register Definition
#define _POWER_CTL      0x2D
#define _DATA_FORMAT    0x31
#define _BW_RATE        0x2C
#define _DATAX0         0x32
#define _DATAX1         0x33
#define _DATAY0         0x34
#define _DATAY1         0x35
#define _DATAZ0         0x36
#define _DATAZ1         0x37
#define _FIFO_CTL       0x38
#define _SPEED          0x0F          // Buffer Speed - 3200Hz

#define _ACCEL_ERROR    0x02



// Global variables
unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 1000;




// Accel Functions
void ADXL345_Write(unsigned short address, unsigned short data1);
unsigned short ADXL345_Read(unsigned short address);
char ADXL345_Init(void);

// Read X Axis
int Accel_ReadX(void);

// Read Y Axis
int Accel_ReadY(void);

// Read Z Axis
int Accel_ReadZ(void);




/**************************************************************************************************
* Function ADXL345_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function write byte of data to ADXL345
* Input: register address, data
* Output: Nothing
**************************************************************************************************/
void ADXL345_Write(unsigned short address, unsigned short data1)
{
  I2C2_Start();                      // issue I2C start signal
  I2C2_Write(0x3A);                  // send byte via I2C  (device address + W)
  I2C2_Write(address);               // send byte (address of the location)
  I2C2_Write(data1);                 // send data (data to be written)
  I2C2_Stop();                       // issue I2C stop signal
}

/**************************************************************************************************
* Function ADXL345_Read()
* -------------------------------------------------------------------------------------------------
* Overview: Function read byte of data from ADXL345
* Input: register address
* Output: data from addressed register in ADXL345
**************************************************************************************************/
unsigned short ADXL345_Read(unsigned short address)
{
  unsigned short tmp = 0;

  I2C2_Start();                      // issue I2C start signal
  I2C2_Write(0x3A);                  // send byte via I2C (device address + W)
  I2C2_Write(address);               // send byte (data address)
  
  I2C2_Start();                      // issue I2C signal repeated start
  I2C2_Write(0x3B);                  // send byte (device address + R)
  tmp = I2C2_Read(1);                // Read the data (NO acknowledge)
  I2C2_Stop();                       // issue I2C stop signal

  return tmp;
}

/**************************************************************************************************
* Function ADXL345_Init()
* -------------------------------------------------------------------------------------------------
* Overview: Function that initializes ADXL345
* Input: Nothing
* Output: return 0 for OK; return _ACCEL_ERROR for ERROR
**************************************************************************************************/
char ADXL345_Init(void)
{
  char id = 0x00;

  // Go into standby mode to configure the device.
  ADXL345_Write(0x2D, 0x00);

  id = ADXL345_Read(0x00);

  if (id != 0xE5)
  {
    return _ACCEL_ERROR;
  }
  else
  {
    ADXL345_Write(_DATA_FORMAT, 0x08);       // Full resolution, +/-2g, 4mg/LSB, right justified
    ADXL345_Write(_BW_RATE, 0x0A);           // Set 100 Hz data rate
    ADXL345_Write(_FIFO_CTL, 0x80);          // stream mode
    ADXL345_Write(_POWER_CTL, 0x08);         // POWER_CTL reg: measurement mode
    return 0x00;
  }
}

/**************************************************************************************************
* Function Accel_ReadX()
* -------------------------------------------------------------------------------------------------
* Overview: Function read X axis from accel.
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
int Accel_ReadX(void)
{
  char low_byte;
  int Out_x;

  Out_x = ADXL345_Read(_DATAX1);
  low_byte = ADXL345_Read(_DATAX0);

  Out_x = (Out_x << 8);
  Out_x = (Out_x | low_byte);

  return Out_x;
}

/**************************************************************************************************
* Function Accel_ReadY()
* -------------------------------------------------------------------------------------------------
* Overview: Function read Y axis from accel.
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
int Accel_ReadY(void)
{
  char low_byte;
  int Out_y;

  Out_y = ADXL345_Read(_DATAY1);
  low_byte = ADXL345_Read(_DATAY0);

  Out_y = (Out_y << 8);
  Out_y = (Out_y | low_byte);

  return Out_y;
}

/**************************************************************************************************
* Function Accel_ReadZ()
* -------------------------------------------------------------------------------------------------
* Overview: Function read Z axis from accel.
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
int Accel_ReadZ(void)
{
  char low_byte;
  int Out_z;

  Out_z = ADXL345_Read(_DATAZ1);
  low_byte = ADXL345_Read(_DATAZ0);

  Out_z = (Out_z << 8);
  Out_z = (Out_z | low_byte);

  return Out_z;
}








void PMPWaitBusy() {
  while(PMMODEbits.BUSY);
}

void Set_Index(unsigned short index) {
  TFT_RS = 0;
  PMDIN = index;
  PMPWaitBusy();
}

void Write_Command( unsigned short cmd ) {
  TFT_RS = 1;
  PMDIN = cmd;
  PMPWaitBusy();
}

void Write_Data(unsigned int _data) {
  TFT_RS = 1;
  PMDIN = _data;
  PMPWaitBusy();
}


void Init_ADC() {
  AD1PCFG = 0xFFFF;
  PCFG12_bit = 0;
  PCFG13_bit = 0;
  // PMP setup
  ADC1_Init();
}
static void InitializeTouchPanel() {
  Init_ADC();
  TFT_Set_Active(Set_Index, Write_Command, Write_Data);
  TFT_Init(320, 240);

  TP_TFT_Init(320, 240, 13, 12);                                  // Initialize touch panel
  TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold

}


void Init_MCU() {

  CM1CON  = 0;                    // Turn off comparators
  CM2CON  = 0;
  AD1PCFG = 0xff;                 // Make all inputs digital

  PMMODE = 0;
  PMAEN  = 0;
  PMCON  = 0;  // WRSP: Write Strobe Polarity bit
  PMMODEbits.MODE = 2;     // Master 2
  PMMODEbits.WAITB = 0;
  PMMODEbits.WAITM = 1;
  PMMODEbits.WAITE = 0;
  PMMODEbits.MODE16 = 1;   // 16 bit mode
  PMCONbits.CSF = 0;
  PMCONbits.PTRDEN = 1;
  PMCONbits.PTWREN = 1;
  PMCONbits.PMPEN = 1;
  TP_TFT_Rotate_180(0);
  TFT_Set_Active(Set_Index,Write_Command,Write_Data);
        
  //UART2_INIT(256000);               // INITIALIZE UART MODULE AT 256000 BAUD
  //UART_Set_Active(&UART2_Read, &UART2_Write, &UART2_Data_Ready, &UART2_Tx_Idle);
  //DELAY_MS(100);                  // WAIT FOR UART MODULE TO STABILIZE
  
}

void Start_TP() {
  Init_MCU();

  InitializeTouchPanel();

  // You can get calibration constants using touch panel calibration example
  TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);    // Set calibration constants

}                         //initalize variables on startup



