//-----------------------
//Set up the defines
//-----------------------


//-----------------------
//Set up the functions
//-----------------------

void GetInput();
void ResetGame();
void ResetLevel();
static void RenderScreen();
void AnimateFrame();
void SavePrevious();
void UART2_Write_Line(char *uart_text);
char IsCollision (unsigned int Shape_X, unsigned int Shape_Y,  unsigned int                  Shape_Width, unsigned int Shape_Height,
                  unsigned int Player_Left, unsigned int Player_Top, unsigned int Player_Width, unsigned int Player_Height);


									
						

//-----------------------
//Set up the variables
//----------------

//Screen redraw flag
int screen_dirty = 0;

//Frame counter
int frame_counter = 0;



