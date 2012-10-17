_main:
;mini3d_main.c,117 :: 		void main() {
;mini3d_main.c,119 :: 		Start_TP();
JAL	_Start_TP+0
NOP	
;mini3d_main.c,122 :: 		initVariables();
JAL	_initVariables+0
NOP	
;mini3d_main.c,126 :: 		scale.x = 95.0;  //x scale
LUI	R2, 17086
ORI	R2, R2, 0
SW	R2, Offset(_scale+0)(GP)
;mini3d_main.c,127 :: 		scale.y = 95.0;  //y scale
LUI	R2, 17086
ORI	R2, R2, 0
SW	R2, Offset(_scale+4)(GP)
;mini3d_main.c,128 :: 		scale.z = 95.0;  //z scale
LUI	R2, 17086
ORI	R2, R2, 0
SW	R2, Offset(_scale+8)(GP)
;mini3d_main.c,131 :: 		bg_color = TFT_RGBToColor16bit(92, 92, 92);
ORI	R27, R0, 92
ORI	R26, R0, 92
ORI	R25, R0, 92
JAL	_TFT_RGBToColor16bit+0
NOP	
SH	R2, Offset(_bg_color+0)(GP)
;mini3d_main.c,135 :: 		TFT_Fill_Screen(bg_color);
ANDI	R25, R2, 65535
JAL	_TFT_Fill_Screen+0
NOP	
;mini3d_main.c,138 :: 		ACCEL_Start(&cACCEL_test_status);
LUI	R25, #hi_addr(_cACCEL_test_status+0)
ORI	R25, R25, #lo_addr(_cACCEL_test_status+0)
JAL	_ACCEL_Start+0
NOP	
;mini3d_main.c,139 :: 		while (1){
L_main0:
;mini3d_main.c,142 :: 		ACCEL_Test();
JAL	_ACCEL_Test+0
NOP	
;mini3d_main.c,145 :: 		GetInput();
JAL	_GetInput+0
NOP	
;mini3d_main.c,151 :: 		RenderScreen();
JAL	mini3d_main_RenderScreen+0
NOP	
;mini3d_main.c,153 :: 		frame_counter++;
LH	R2, Offset(_frame_counter+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_frame_counter+0)(GP)
;mini3d_main.c,155 :: 		}
J	L_main0
NOP	
;mini3d_main.c,157 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
_GetInput:
;mini3d_main.c,162 :: 		void GetInput(){
;mini3d_main.c,165 :: 		}
L_end_GetInput:
JR	RA
NOP	
; end of _GetInput
_AnimateFrame:
;mini3d_main.c,169 :: 		void AnimateFrame(){
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mini3d_main.c,171 :: 		rotate.x = -22.5;
LUI	R2, 49588
ORI	R2, R2, 0
SW	R2, Offset(_rotate+0)(GP)
;mini3d_main.c,173 :: 		rotate.y += 3.0;  //y rotate
LW	R6, Offset(_rotate+4)(GP)
LUI	R4, 16448
ORI	R4, R4, 0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_rotate+4)(GP)
;mini3d_main.c,176 :: 		}
L_end_AnimateFrame:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _AnimateFrame
mini3d_main_RenderScreen:
;mini3d_main.c,185 :: 		static void RenderScreen(){
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;mini3d_main.c,187 :: 		TFT_Fill_Screen(bg_color);
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
LHU	R25, Offset(_bg_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;mini3d_main.c,189 :: 		computeXform();    //calculate translation matrix
JAL	_computeXform+0
NOP	
;mini3d_main.c,191 :: 		drawModel();     //render polygons to LCD
JAL	_drawModel+0
NOP	
;mini3d_main.c,194 :: 		TFT_Write_Text(rotationString, 10, 240-25);   //write the rotation values
ORI	R27, R0, 215
ORI	R26, R0, 10
LUI	R25, #hi_addr(_rotationString+0)
ORI	R25, R25, #lo_addr(_rotationString+0)
JAL	_TFT_Write_Text+0
NOP	
;mini3d_main.c,196 :: 		Delay_ms(50);
LUI	R24, 20
ORI	R24, R24, 22612
L_mini3d_main_RenderScreen2:
ADDIU	R24, R24, -1
BNE	R24, R0, L_mini3d_main_RenderScreen2
NOP	
NOP	
NOP	
;mini3d_main.c,199 :: 		frame_counter++;
LH	R2, Offset(_frame_counter+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_frame_counter+0)(GP)
;mini3d_main.c,202 :: 		SavePrevious();
JAL	_SavePrevious+0
NOP	
;mini3d_main.c,203 :: 		}
L_end_RenderScreen:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of mini3d_main_RenderScreen
_SavePrevious:
;mini3d_main.c,207 :: 		void SavePrevious(){
;mini3d_main.c,210 :: 		}
L_end_SavePrevious:
JR	RA
NOP	
; end of _SavePrevious
_UART2_Write_Line:
;mini3d_main.c,213 :: 		void UART2_Write_Line(char *uart_text) {
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mini3d_main.c,214 :: 		UART2_Write_Text(uart_text);
SW	R25, 4(SP)
JAL	_UART2_Write_Text+0
NOP	
;mini3d_main.c,215 :: 		UART2_Write(13);
ORI	R25, R0, 13
JAL	_UART2_Write+0
NOP	
;mini3d_main.c,216 :: 		UART2_Write(10);
ORI	R25, R0, 10
JAL	_UART2_Write+0
NOP	
;mini3d_main.c,217 :: 		}
L_end_UART2_Write_Line:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _UART2_Write_Line
_Accel_Average:
;mini3d_main.c,235 :: 		void Accel_Average(void)
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mini3d_main.c,240 :: 		sx = sy = sz = 0;
SH	R0, 10(SP)
SH	R0, 8(SP)
SH	R0, 6(SP)
;mini3d_main.c,243 :: 		for (i=0; i<16; i++)
SH	R0, 4(SP)
L_Accel_Average4:
LH	R2, 4(SP)
SLTI	R2, R2, 16
BNE	R2, R0, L__Accel_Average21
NOP	
J	L_Accel_Average5
NOP	
L__Accel_Average21:
;mini3d_main.c,245 :: 		sx += Accel_ReadX();
JAL	_Accel_ReadX+0
NOP	
LH	R3, 6(SP)
ADDU	R2, R3, R2
SH	R2, 6(SP)
;mini3d_main.c,246 :: 		sy += Accel_ReadY();
JAL	_Accel_ReadY+0
NOP	
LH	R3, 8(SP)
ADDU	R2, R3, R2
SH	R2, 8(SP)
;mini3d_main.c,247 :: 		sz += Accel_ReadZ();
JAL	_Accel_ReadZ+0
NOP	
LH	R3, 10(SP)
ADDU	R2, R3, R2
SH	R2, 10(SP)
;mini3d_main.c,243 :: 		for (i=0; i<16; i++)
LH	R2, 4(SP)
ADDIU	R2, R2, 1
SH	R2, 4(SP)
;mini3d_main.c,248 :: 		}
J	L_Accel_Average4
NOP	
L_Accel_Average5:
;mini3d_main.c,250 :: 		readings[0] = sx >> 4;
LH	R2, 6(SP)
SRA	R2, R2, 4
SH	R2, Offset(_readings+0)(GP)
;mini3d_main.c,251 :: 		readings[1] = sy >> 4;
LH	R2, 8(SP)
SRA	R2, R2, 4
SH	R2, Offset(_readings+2)(GP)
;mini3d_main.c,252 :: 		readings[2] = sz >> 4;
LH	R2, 10(SP)
SRA	R2, R2, 4
SH	R2, Offset(_readings+4)(GP)
;mini3d_main.c,253 :: 		}
L_end_Accel_Average:
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _Accel_Average
_ACCEL_Start:
;mini3d_main.c,263 :: 		void ACCEL_Start(char *test)
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;mini3d_main.c,266 :: 		*test = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
SB	R0, 0(R25)
;mini3d_main.c,269 :: 		I2C2_Init(250000);
SW	R25, 20(SP)
LUI	R25, 3
ORI	R25, R25, 53392
JAL	_I2C2_Init+0
NOP	
;mini3d_main.c,271 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVZ	R27, R0, R0
ORI	R26, R0, 65535
LUI	R25, #hi_addr(_TFT_defaultFont+0)
ORI	R25, R25, #lo_addr(_TFT_defaultFont+0)
JAL	_TFT_Set_Font+0
NOP	
;mini3d_main.c,272 :: 		TFT_Set_Pen(bg_color, 1);
ORI	R26, R0, 1
LHU	R25, Offset(_bg_color+0)(GP)
JAL	_TFT_Set_Pen+0
NOP	
;mini3d_main.c,273 :: 		TFT_Set_Brush(1, bg_color, 0, 0, 0, 0);
MOVZ	R28, R0, R0
MOVZ	R27, R0, R0
LHU	R26, Offset(_bg_color+0)(GP)
ORI	R25, R0, 1
ADDIU	SP, SP, -4
SH	R0, 2(SP)
SH	R0, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
;mini3d_main.c,275 :: 		TFT_Write_Text("Starting Accel test...", 90, 100);
ORI	R27, R0, 100
ORI	R26, R0, 90
LUI	R25, #hi_addr(?lstr1_mini3d_main+0)
ORI	R25, R25, #lo_addr(?lstr1_mini3d_main+0)
JAL	_TFT_Write_Text+0
NOP	
;mini3d_main.c,276 :: 		Delay_ms(2000);
LUI	R24, 813
ORI	R24, R24, 52564
L_ACCEL_Start7:
ADDIU	R24, R24, -1
BNE	R24, R0, L_ACCEL_Start7
NOP	
NOP	
NOP	
;mini3d_main.c,277 :: 		TFT_Rectangle(70, 70, 250, 130);
ORI	R28, R0, 130
ORI	R27, R0, 250
ORI	R26, R0, 70
ORI	R25, R0, 70
JAL	_TFT_Rectangle+0
NOP	
;mini3d_main.c,280 :: 		if (ADXL345_Init() == 0)
JAL	_ADXL345_Init+0
NOP	
LW	R25, 20(SP)
ANDI	R2, R2, 255
BEQ	R2, R0, L__ACCEL_Start23
NOP	
J	L_ACCEL_Start9
NOP	
L__ACCEL_Start23:
;mini3d_main.c,282 :: 		TFT_Write_Text("Accel module initialized.", 90, 100);
SW	R25, 20(SP)
ORI	R27, R0, 100
ORI	R26, R0, 90
LUI	R25, #hi_addr(?lstr2_mini3d_main+0)
ORI	R25, R25, #lo_addr(?lstr2_mini3d_main+0)
JAL	_TFT_Write_Text+0
NOP	
LW	R25, 20(SP)
;mini3d_main.c,283 :: 		*test = 1;
ORI	R2, R0, 1
SB	R2, 0(R25)
;mini3d_main.c,284 :: 		Delay_ms(2000);
LUI	R24, 813
ORI	R24, R24, 52564
L_ACCEL_Start10:
ADDIU	R24, R24, -1
BNE	R24, R0, L_ACCEL_Start10
NOP	
NOP	
NOP	
;mini3d_main.c,285 :: 		}
J	L_ACCEL_Start12
NOP	
L_ACCEL_Start9:
;mini3d_main.c,288 :: 		TFT_Write_Text("Error during Accel module initialization.", 90, 100);
SW	R25, 20(SP)
ORI	R27, R0, 100
ORI	R26, R0, 90
LUI	R25, #hi_addr(?lstr3_mini3d_main+0)
ORI	R25, R25, #lo_addr(?lstr3_mini3d_main+0)
JAL	_TFT_Write_Text+0
NOP	
LW	R25, 20(SP)
;mini3d_main.c,289 :: 		*test = 2;
ORI	R2, R0, 2
SB	R2, 0(R25)
;mini3d_main.c,290 :: 		}
L_ACCEL_Start12:
;mini3d_main.c,292 :: 		TFT_Rectangle(70, 70, 250, 130);
ORI	R28, R0, 130
ORI	R27, R0, 250
ORI	R26, R0, 70
ORI	R25, R0, 70
JAL	_TFT_Rectangle+0
NOP	
;mini3d_main.c,293 :: 		}
L_end_ACCEL_Start:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _ACCEL_Start
_ACCEL_Test:
;mini3d_main.c,302 :: 		void ACCEL_Test(void)
ADDIU	SP, SP, -48
SW	RA, 0(SP)
;mini3d_main.c,310 :: 		Accel_Average();               // Calculate average X, Y and Z reads
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_Accel_Average+0
NOP	
;mini3d_main.c,314 :: 		rotate.y = (float)readings[0] * 0.35;
LH	R4, Offset(_readings+0)(GP)
JAL	__SignedIntegralToFLoat+0
NOP	
LUI	R4, 16051
ORI	R4, R4, 13107
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
SW	R2, Offset(_rotate+4)(GP)
;mini3d_main.c,316 :: 		rotate.x = ((float)readings[1] * 0.35);
LH	R4, Offset(_readings+2)(GP)
JAL	__SignedIntegralToFLoat+0
NOP	
LUI	R4, 16051
ORI	R4, R4, 13107
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
SW	R2, Offset(_rotate+0)(GP)
;mini3d_main.c,320 :: 		IntToStr((int)rotate.x, x_out);
ADDIU	R3, SP, 12
SW	R3, 44(SP)
MOVZ	R4, R2, R0
JAL	__FloatToSignedIntegral+0
NOP	
LW	R3, 44(SP)
MOVZ	R26, R3, R0
SEH	R25, R2
JAL	_IntToStr+0
NOP	
;mini3d_main.c,321 :: 		IntToStr((int)rotate.y, y_out);
ADDIU	R2, SP, 27
SW	R2, 44(SP)
LW	R4, Offset(_rotate+4)(GP)
JAL	__FloatToSignedIntegral+0
NOP	
LW	R3, 44(SP)
MOVZ	R26, R3, R0
SEH	R25, R2
JAL	_IntToStr+0
NOP	
;mini3d_main.c,325 :: 		strcpy(rotationString, "Rotate    X: ");
LUI	R26, #hi_addr(?lstr4_mini3d_main+0)
ORI	R26, R26, #lo_addr(?lstr4_mini3d_main+0)
LUI	R25, #hi_addr(_rotationString+0)
ORI	R25, R25, #lo_addr(_rotationString+0)
JAL	_strcpy+0
NOP	
;mini3d_main.c,326 :: 		strcat(rotationString, x_out);
ADDIU	R2, SP, 12
MOVZ	R26, R2, R0
LUI	R25, #hi_addr(_rotationString+0)
ORI	R25, R25, #lo_addr(_rotationString+0)
JAL	_strcat+0
NOP	
;mini3d_main.c,328 :: 		strcat(rotationString, "     Y: ");
LUI	R26, #hi_addr(?lstr5_mini3d_main+0)
ORI	R26, R26, #lo_addr(?lstr5_mini3d_main+0)
LUI	R25, #hi_addr(_rotationString+0)
ORI	R25, R25, #lo_addr(_rotationString+0)
JAL	_strcat+0
NOP	
;mini3d_main.c,329 :: 		strcat(rotationString, y_out);
ADDIU	R2, SP, 27
MOVZ	R26, R2, R0
LUI	R25, #hi_addr(_rotationString+0)
ORI	R25, R25, #lo_addr(_rotationString+0)
JAL	_strcat+0
NOP	
;mini3d_main.c,335 :: 		}
L_end_ACCEL_Test:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 48
JR	RA
NOP	
; end of _ACCEL_Test
