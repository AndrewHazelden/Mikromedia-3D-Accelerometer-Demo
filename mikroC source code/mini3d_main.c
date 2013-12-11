/*
 * Project name:
   mikroMMB 3D Accelerometer Demo
     
 * Created by Andrew Hazelden

 * email: andrewhazelden@gmail.com
 * web: www.andrewhazelden.com/blog

 * Date of creation
     2/6/2012
 * Version 1.1 Update
     12/7/2013
 * Test configuration:
     MCU:             P32MX460F512L
     Dev.Board:       MikroMMB_for_PIC32_hw_rev_1.10
                      http://www.mikroe.com/mikromedia/pic32/
     Oscillator:      80000000 Hz
     SW:              mikroC PRO for PIC32
                      http://www.pic32compilers.com/
                      
    Note: The accelerometer code is based upon the MikroE Accel example
 */
 
#include "setup.h"

//Load 3D Rendering library
#include "render.h"

//-------------------------
//
//Transformation structs
//
//-------------------------
extern struct trans_xform{
       float x;
       float y;
       float z;
       } translate;

extern struct rot_xform{
       float x;
       float y;
       float z;
       } rotate;


extern struct scl_xform{
       float x;
       float y;
       float z;
       }scale;


//--------------------
//
//function prototypes
//
//--------------------

extern void initVariables(void);
extern void computeXform(void);
extern void drawModel(void);

extern void Start_TP(void);

extern struct object_color{
        char r;
        char g;
        char b;
        } vertex_color;
        

                                
                                
// Accelerometer Functions
char out[16];
int readings[3] = {0, 0, 0}; // X, Y and Z buffer

// Calculate the average values of the X, Y and Z axis reads
void Accel_Average(void);
// Display average X-axis read value on TFT
void Display_X_Value(void);
// Display average Y-axis read value on TFT
void Display_Y_Value(void);
// Display average z-axis read value on TFT
void Display_Z_Value(void);
// Start using ACCEL
void ACCEL_Start(char *test);
// Test Accel
void ACCEL_Test(void);

//- Imported from ACCEL_DRIVER.H ------------------------------------------------------------------
extern void ADXL345_Write(unsigned short address, unsigned short data1);
extern unsigned short ADXL345_Read(unsigned short address);
extern char ADXL345_Init(void);

extern int Accel_ReadX(void);
extern int Accel_ReadY(void);
extern int Accel_ReadZ(void);

                                
//--------------------
//
//Global variables
//
//--------------------                                
                                
char cACCEL_test_status;                                
                                
unsigned int bg_color = 0;

char rotationString[120];


        
void main() {

Start_TP();

//initalize variables on startup
initVariables();

//translate.z = 10.0;

scale.x = 95.0;  //x scale
scale.y = 95.0;  //y scale
scale.z = 95.0;  //z scale


bg_color = TFT_RGBToColor16bit(92, 92, 92);

//Clear the screen
//TFT_Fill_Screen(CL_BLACK);
TFT_Fill_Screen(bg_color);


  ACCEL_Start(&cACCEL_test_status);
  while (1){

  //read the accelerometer
  ACCEL_Test();

  //Check for user input
  GetInput();

  //animate the objects in the frame
  //AnimateFrame();

  //Draw the graphics
  RenderScreen();

  frame_counter++;
  
  }

}



//Check for user input
void GetInput(){


}


//update the character and ball motions
void AnimateFrame(){
              
 rotate.x = -22.5;
 //rotate.x += 1.0;  //x rotate
 rotate.y += 3.0;  //y rotate
 //rotate.z += 2.0;  //z rotate
 
}







// This function draws to the screen
static void RenderScreen(){

        TFT_Fill_Screen(bg_color);

        computeXform();    //calculate translation matrix

        drawModel();     //render polygons to LCD


        TFT_Write_Text(rotationString, 10, 240-25);   //write the rotation values

        Delay_ms(50);

        //increment the current frame number
        frame_counter++;

        //Save the settings from the previous frame
        SavePrevious(); 
}


//Save the settings from the previous frame
void SavePrevious(){
         
                 
}

//UART2 write text and new line (carriage return + line feed)
void UART2_Write_Line(char *uart_text) {
  UART2_Write_Text(uart_text);
  UART2_Write(13);
  UART2_Write(10);
}




//----------------------------------------
//
// Accelerometer code
//
//-----------------------------------------


/* Function Accel_Average()
* -------------------------------------------------------------------------------------------------
* Overview: Function calculate the average values of the X, Y and Z axis reads
* Input: Nothing
* Output: X,Y and Z values are stored in readings[] buffer
*************************************************************************************************/
void Accel_Average(void)
{
  int i, sx, sy, sz;

  // sum
  sx = sy = sz = 0;
  
  // average accelerometer reading over last 16 samples
  for (i=0; i<16; i++)
  {
    sx += Accel_ReadX();
    sy += Accel_ReadY();
    sz += Accel_ReadZ();
  }
  // average
  readings[0] = sx >> 4;
  readings[1] = sy >> 4;
  readings[2] = sz >> 4;
}


/**************************************************************************************************
* Function ACCEL_Start()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize I2C bus and accel module
* Input: Nothing
* Output: test status: 0 - skiped; 1 - pass; 2 - fail
**************************************************************************************************/
void ACCEL_Start(char *test)
{
  // Reset error flag
  *test = 0;
  
  // Initialize I2C communication
  I2C2_Init(250000);

  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Set_Pen(bg_color, 1);
  TFT_Set_Brush(1, bg_color, 0, 0, 0, 0);

  TFT_Write_Text("Starting Accel test...", 90, 100);
  Delay_ms(2000);
  TFT_Rectangle(70, 70, 250, 130);
  
  // Initialize ADXL345 accelerometer
  if (ADXL345_Init() == 0)
  {
    TFT_Write_Text("Accel module initialized.", 90, 100);
    *test = 1;
    Delay_ms(2000);
  }
  else
  {
    TFT_Write_Text("Error during Accel module initialization.", 90, 100);
    *test = 2;
  }
    
  TFT_Rectangle(70, 70, 250, 130);
}

/**************************************************************************************************
* Function ACCEL_Test()
* -------------------------------------------------------------------------------------------------
* Overview: Function run the accel test
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void ACCEL_Test(void)
{

  char x_out[15];
  char y_out[15];
  char z_out[15];
  
  //TFT_Write_Text("Reading axis values :", 90, 70);
  Accel_Average();               // Calculate average X, Y and Z reads
  
  //testing
  //y
  rotate.y = (float)readings[0] * 0.35;
  //x
  rotate.x = ((float)readings[1] * 0.35);
  //z
  //rotate.z = (float)-readings[2] * 0.35;
  
  IntToStr((int)rotate.x, x_out);
  IntToStr((int)rotate.y, y_out);
  //IntToStr((int)rotate.z, z_out);
  
  
  strcpy(rotationString, "Rotate    X: ");
  strcat(rotationString, x_out);
  
  strcat(rotationString, "     Y: ");
  strcat(rotationString, y_out);
  
  //strcat(rotationString, "     Z: ");
  //strcat(rotationString, z_out);
  
  
}