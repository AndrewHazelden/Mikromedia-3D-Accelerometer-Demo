#line 1 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
#line 1 "c:/program files/mikroelektronika/mikroc pro for pic32/include/built_in.h"
#line 5 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
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



sbit DriveX_Left at LATB13_bit;
sbit DriveX_Right at LATB11_bit;
sbit DriveY_Up at LATB12_bit;
sbit DriveY_Down at LATB10_bit;
sbit DriveX_Left_Direction at TRISB13_bit;
sbit DriveX_Right_Direction at TRISB11_bit;
sbit DriveY_Up_Direction at TRISB12_bit;
sbit DriveY_Down_Direction at TRISB10_bit;
#line 52 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 1000;





void ADXL345_Write(unsigned short address, unsigned short data1);
unsigned short ADXL345_Read(unsigned short address);
char ADXL345_Init(void);


int Accel_ReadX(void);


int Accel_ReadY(void);


int Accel_ReadZ(void);
#line 82 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
void ADXL345_Write(unsigned short address, unsigned short data1)
{
 I2C2_Start();
 I2C2_Write(0x3A);
 I2C2_Write(address);
 I2C2_Write(data1);
 I2C2_Stop();
}
#line 98 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
unsigned short ADXL345_Read(unsigned short address)
{
 unsigned short tmp = 0;

 I2C2_Start();
 I2C2_Write(0x3A);
 I2C2_Write(address);

 I2C2_Start();
 I2C2_Write(0x3B);
 tmp = I2C2_Read(1);
 I2C2_Stop();

 return tmp;
}
#line 121 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
char ADXL345_Init(void)
{
 char id = 0x00;


 ADXL345_Write(0x2D, 0x00);

 id = ADXL345_Read(0x00);

 if (id != 0xE5)
 {
 return  0x02 ;
 }
 else
 {
 ADXL345_Write( 0x31 , 0x08);
 ADXL345_Write( 0x2C , 0x0A);
 ADXL345_Write( 0x38 , 0x80);
 ADXL345_Write( 0x2D , 0x08);
 return 0x00;
 }
}
#line 151 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
int Accel_ReadX(void)
{
 char low_byte;
 int Out_x;

 Out_x = ADXL345_Read( 0x33 );
 low_byte = ADXL345_Read( 0x32 );

 Out_x = (Out_x << 8);
 Out_x = (Out_x | low_byte);

 return Out_x;
}
#line 172 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
int Accel_ReadY(void)
{
 char low_byte;
 int Out_y;

 Out_y = ADXL345_Read( 0x35 );
 low_byte = ADXL345_Read( 0x34 );

 Out_y = (Out_y << 8);
 Out_y = (Out_y | low_byte);

 return Out_y;
}
#line 193 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/mini3d_driver.c"
int Accel_ReadZ(void)
{
 char low_byte;
 int Out_z;

 Out_z = ADXL345_Read( 0x37 );
 low_byte = ADXL345_Read( 0x36 );

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

 ADC1_Init();
}
static void InitializeTouchPanel() {
 Init_ADC();
 TFT_Set_Active(Set_Index, Write_Command, Write_Data);
 TFT_Init(320, 240);

 TP_TFT_Init(320, 240, 13, 12);
 TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);

}


void Init_MCU() {

 CM1CON = 0;
 CM2CON = 0;
 AD1PCFG = 0xff;

 PMMODE = 0;
 PMAEN = 0;
 PMCON = 0;
 PMMODEbits.MODE = 2;
 PMMODEbits.WAITB = 0;
 PMMODEbits.WAITM = 1;
 PMMODEbits.WAITE = 0;
 PMMODEbits.MODE16 = 1;
 PMCONbits.CSF = 0;
 PMCONbits.PTRDEN = 1;
 PMCONbits.PTWREN = 1;
 PMCONbits.PMPEN = 1;
 TP_TFT_Rotate_180(0);
 TFT_Set_Active(Set_Index,Write_Command,Write_Data);





}

void Start_TP() {
 Init_MCU();

 InitializeTouchPanel();


 TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);

}
