#line 1 "C:/Users/hazelden/Desktop/mikroMMB 3D Accelerometer Demo/mikroC source code/mini3d_main.c"
#line 1 "c:/users/hazelden/desktop/mikrommb 3d accelerometer demo/mikroc source code/setup.h"









void GetInput();
void ResetGame();
void ResetLevel();
static void RenderScreen();
void AnimateFrame();
void SavePrevious();
void UART2_Write_Line(char *uart_text);
char IsCollision (unsigned int Shape_X, unsigned int Shape_Y, unsigned int Shape_Width, unsigned int Shape_Height,
 unsigned int Player_Left, unsigned int Player_Top, unsigned int Player_Width, unsigned int Player_Height);










int screen_dirty = 0;


int frame_counter = 0;
#line 1 "c:/users/hazelden/desktop/mikrommb 3d accelerometer demo/mikroc source code/render.h"
#line 1 "c:/users/hazelden/desktop/mikrommb 3d accelerometer demo/mikroc source code/shape_def.h"
#line 9 "c:/users/hazelden/desktop/mikrommb 3d accelerometer demo/mikroc source code/render.h"
void initVariables(void);

void computeXform(void);

void drawPolygon(void);
#line 35 "C:/Users/hazelden/Desktop/mikroMMB 3D Accelerometer Demo/mikroC source code/mini3d_main.c"
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








extern void initVariables(void);
extern void computeXform(void);
extern void drawModel(void);

extern void Start_TP(void);

extern struct object_color{
 char r;
 char g;
 char b;
 } vertex_color;





char out[16];
int readings[3] = {0, 0, 0};


void Accel_Average(void);

void Display_X_Value(void);

void Display_Y_Value(void);

void Display_Z_Value(void);

void ACCEL_Start(char *test);

void ACCEL_Test(void);


extern void ADXL345_Write(unsigned short address, unsigned short data1);
extern unsigned short ADXL345_Read(unsigned short address);
extern char ADXL345_Init(void);

extern int Accel_ReadX(void);
extern int Accel_ReadY(void);
extern int Accel_ReadZ(void);








char cACCEL_test_status;

unsigned int bg_color = 0;

char rotationString[120];



void main() {

Start_TP();


initVariables();



scale.x = 95.0;
scale.y = 95.0;
scale.z = 95.0;


bg_color = TFT_RGBToColor16bit(92, 92, 92);



TFT_Fill_Screen(bg_color);


 ACCEL_Start(&cACCEL_test_status);
 while (1){


 ACCEL_Test();


 GetInput();





 RenderScreen();

 frame_counter++;

 }

}




void GetInput(){


}



void AnimateFrame(){

 rotate.x = -22.5;

 rotate.y += 3.0;


}








static void RenderScreen(){

 TFT_Fill_Screen(bg_color);

 computeXform();

 drawModel();


 TFT_Write_Text(rotationString, 10, 240-25);

 Delay_ms(50);


 frame_counter++;


 SavePrevious();
}



void SavePrevious(){


}


void UART2_Write_Line(char *uart_text) {
 UART2_Write_Text(uart_text);
 UART2_Write(13);
 UART2_Write(10);
}
#line 235 "C:/Users/hazelden/Desktop/mikroMMB 3D Accelerometer Demo/mikroC source code/mini3d_main.c"
void Accel_Average(void)
{
 int i, sx, sy, sz;


 sx = sy = sz = 0;


 for (i=0; i<16; i++)
 {
 sx += Accel_ReadX();
 sy += Accel_ReadY();
 sz += Accel_ReadZ();
 }

 readings[0] = sx >> 4;
 readings[1] = sy >> 4;
 readings[2] = sz >> 4;
}
#line 263 "C:/Users/hazelden/Desktop/mikroMMB 3D Accelerometer Demo/mikroC source code/mini3d_main.c"
void ACCEL_Start(char *test)
{

 *test = 0;


 I2C2_Init(250000);

 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Set_Pen(bg_color, 1);
 TFT_Set_Brush(1, bg_color, 0, 0, 0, 0);

 TFT_Write_Text("Starting Accel test...", 90, 100);
 Delay_ms(2000);
 TFT_Rectangle(70, 70, 250, 130);


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
#line 302 "C:/Users/hazelden/Desktop/mikroMMB 3D Accelerometer Demo/mikroC source code/mini3d_main.c"
void ACCEL_Test(void)
{

 char x_out[15];
 char y_out[15];
 char z_out[15];


 Accel_Average();



 rotate.y = (float)readings[0] * 0.35;

 rotate.x = ((float)readings[1] * 0.35);



 IntToStr((int)rotate.x, x_out);
 IntToStr((int)rotate.y, y_out);



 strcpy(rotationString, "Rotate    X: ");
 strcat(rotationString, x_out);

 strcat(rotationString, "     Y: ");
 strcat(rotationString, y_out);





}
