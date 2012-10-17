_ADXL345_Write:
;mini3d_driver.c,82 :: 		void ADXL345_Write(unsigned short address, unsigned short data1)
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mini3d_driver.c,84 :: 		I2C2_Start();                      // issue I2C start signal
SW	R25, 4(SP)
JAL	_I2C2_Start+0
NOP	
;mini3d_driver.c,85 :: 		I2C2_Write(0x3A);                  // send byte via I2C  (device address + W)
SB	R25, 8(SP)
ORI	R25, R0, 58
JAL	_I2C2_Write+0
NOP	
LBU	R25, 8(SP)
;mini3d_driver.c,86 :: 		I2C2_Write(address);               // send byte (address of the location)
JAL	_I2C2_Write+0
NOP	
;mini3d_driver.c,87 :: 		I2C2_Write(data1);                 // send data (data to be written)
ANDI	R25, R26, 255
JAL	_I2C2_Write+0
NOP	
;mini3d_driver.c,88 :: 		I2C2_Stop();                       // issue I2C stop signal
JAL	_I2C2_Stop+0
NOP	
;mini3d_driver.c,89 :: 		}
L_end_ADXL345_Write:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _ADXL345_Write
_ADXL345_Read:
;mini3d_driver.c,98 :: 		unsigned short ADXL345_Read(unsigned short address)
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mini3d_driver.c,100 :: 		unsigned short tmp = 0;
SW	R25, 4(SP)
;mini3d_driver.c,102 :: 		I2C2_Start();                      // issue I2C start signal
JAL	_I2C2_Start+0
NOP	
;mini3d_driver.c,103 :: 		I2C2_Write(0x3A);                  // send byte via I2C (device address + W)
SB	R25, 8(SP)
ORI	R25, R0, 58
JAL	_I2C2_Write+0
NOP	
LBU	R25, 8(SP)
;mini3d_driver.c,104 :: 		I2C2_Write(address);               // send byte (data address)
JAL	_I2C2_Write+0
NOP	
;mini3d_driver.c,106 :: 		I2C2_Start();                      // issue I2C signal repeated start
JAL	_I2C2_Start+0
NOP	
;mini3d_driver.c,107 :: 		I2C2_Write(0x3B);                  // send byte (device address + R)
ORI	R25, R0, 59
JAL	_I2C2_Write+0
NOP	
;mini3d_driver.c,108 :: 		tmp = I2C2_Read(1);                // Read the data (NO acknowledge)
ORI	R25, R0, 1
JAL	_I2C2_Read+0
NOP	
; tmp start address is: 16 (R4)
ANDI	R4, R2, 255
;mini3d_driver.c,109 :: 		I2C2_Stop();                       // issue I2C stop signal
JAL	_I2C2_Stop+0
NOP	
;mini3d_driver.c,111 :: 		return tmp;
ANDI	R2, R4, 255
; tmp end address is: 16 (R4)
;mini3d_driver.c,112 :: 		}
;mini3d_driver.c,111 :: 		return tmp;
;mini3d_driver.c,112 :: 		}
L_end_ADXL345_Read:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _ADXL345_Read
_ADXL345_Init:
;mini3d_driver.c,121 :: 		char ADXL345_Init(void)
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mini3d_driver.c,123 :: 		char id = 0x00;
SW	R25, 4(SP)
SW	R26, 8(SP)
;mini3d_driver.c,126 :: 		ADXL345_Write(0x2D, 0x00);
MOVZ	R26, R0, R0
ORI	R25, R0, 45
JAL	_ADXL345_Write+0
NOP	
;mini3d_driver.c,128 :: 		id = ADXL345_Read(0x00);
MOVZ	R25, R0, R0
JAL	_ADXL345_Read+0
NOP	
;mini3d_driver.c,130 :: 		if (id != 0xE5)
ANDI	R3, R2, 255
ORI	R2, R0, 229
BNE	R3, R2, L__ADXL345_Init8
NOP	
J	L_ADXL345_Init0
NOP	
L__ADXL345_Init8:
;mini3d_driver.c,132 :: 		return _ACCEL_ERROR;
ORI	R2, R0, 2
J	L_end_ADXL345_Init
NOP	
;mini3d_driver.c,133 :: 		}
L_ADXL345_Init0:
;mini3d_driver.c,136 :: 		ADXL345_Write(_DATA_FORMAT, 0x08);       // Full resolution, +/-2g, 4mg/LSB, right justified
ORI	R26, R0, 8
ORI	R25, R0, 49
JAL	_ADXL345_Write+0
NOP	
;mini3d_driver.c,137 :: 		ADXL345_Write(_BW_RATE, 0x0A);           // Set 100 Hz data rate
ORI	R26, R0, 10
ORI	R25, R0, 44
JAL	_ADXL345_Write+0
NOP	
;mini3d_driver.c,138 :: 		ADXL345_Write(_FIFO_CTL, 0x80);          // stream mode
ORI	R26, R0, 128
ORI	R25, R0, 56
JAL	_ADXL345_Write+0
NOP	
;mini3d_driver.c,139 :: 		ADXL345_Write(_POWER_CTL, 0x08);         // POWER_CTL reg: measurement mode
ORI	R26, R0, 8
ORI	R25, R0, 45
JAL	_ADXL345_Write+0
NOP	
;mini3d_driver.c,140 :: 		return 0x00;
MOVZ	R2, R0, R0
;mini3d_driver.c,142 :: 		}
;mini3d_driver.c,140 :: 		return 0x00;
;mini3d_driver.c,142 :: 		}
L_end_ADXL345_Init:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _ADXL345_Init
_Accel_ReadX:
;mini3d_driver.c,151 :: 		int Accel_ReadX(void)
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mini3d_driver.c,156 :: 		Out_x = ADXL345_Read(_DATAX1);
SW	R25, 4(SP)
ORI	R25, R0, 51
JAL	_ADXL345_Read+0
NOP	
; Out_x start address is: 20 (R5)
ANDI	R5, R2, 255
;mini3d_driver.c,157 :: 		low_byte = ADXL345_Read(_DATAX0);
ORI	R25, R0, 50
JAL	_ADXL345_Read+0
NOP	
;mini3d_driver.c,159 :: 		Out_x = (Out_x << 8);
SEH	R3, R5
; Out_x end address is: 20 (R5)
SLL	R3, R3, 8
;mini3d_driver.c,160 :: 		Out_x = (Out_x | low_byte);
ANDI	R2, R2, 255
OR	R2, R3, R2
;mini3d_driver.c,162 :: 		return Out_x;
;mini3d_driver.c,163 :: 		}
;mini3d_driver.c,162 :: 		return Out_x;
;mini3d_driver.c,163 :: 		}
L_end_Accel_ReadX:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _Accel_ReadX
_Accel_ReadY:
;mini3d_driver.c,172 :: 		int Accel_ReadY(void)
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mini3d_driver.c,177 :: 		Out_y = ADXL345_Read(_DATAY1);
SW	R25, 4(SP)
ORI	R25, R0, 53
JAL	_ADXL345_Read+0
NOP	
; Out_y start address is: 20 (R5)
ANDI	R5, R2, 255
;mini3d_driver.c,178 :: 		low_byte = ADXL345_Read(_DATAY0);
ORI	R25, R0, 52
JAL	_ADXL345_Read+0
NOP	
;mini3d_driver.c,180 :: 		Out_y = (Out_y << 8);
SEH	R3, R5
; Out_y end address is: 20 (R5)
SLL	R3, R3, 8
;mini3d_driver.c,181 :: 		Out_y = (Out_y | low_byte);
ANDI	R2, R2, 255
OR	R2, R3, R2
;mini3d_driver.c,183 :: 		return Out_y;
;mini3d_driver.c,184 :: 		}
;mini3d_driver.c,183 :: 		return Out_y;
;mini3d_driver.c,184 :: 		}
L_end_Accel_ReadY:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _Accel_ReadY
_Accel_ReadZ:
;mini3d_driver.c,193 :: 		int Accel_ReadZ(void)
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mini3d_driver.c,198 :: 		Out_z = ADXL345_Read(_DATAZ1);
SW	R25, 4(SP)
ORI	R25, R0, 55
JAL	_ADXL345_Read+0
NOP	
; Out_z start address is: 20 (R5)
ANDI	R5, R2, 255
;mini3d_driver.c,199 :: 		low_byte = ADXL345_Read(_DATAZ0);
ORI	R25, R0, 54
JAL	_ADXL345_Read+0
NOP	
;mini3d_driver.c,201 :: 		Out_z = (Out_z << 8);
SEH	R3, R5
; Out_z end address is: 20 (R5)
SLL	R3, R3, 8
;mini3d_driver.c,202 :: 		Out_z = (Out_z | low_byte);
ANDI	R2, R2, 255
OR	R2, R3, R2
;mini3d_driver.c,204 :: 		return Out_z;
;mini3d_driver.c,205 :: 		}
;mini3d_driver.c,204 :: 		return Out_z;
;mini3d_driver.c,205 :: 		}
L_end_Accel_ReadZ:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _Accel_ReadZ
_PMPWaitBusy:
;mini3d_driver.c,214 :: 		void PMPWaitBusy() {
;mini3d_driver.c,215 :: 		while(PMMODEbits.BUSY);
L_PMPWaitBusy2:
LBU	R2, Offset(PMMODEbits+1)(GP)
EXT	R2, R2, 7, 1
BNE	R2, R0, L__PMPWaitBusy14
NOP	
J	L_PMPWaitBusy3
NOP	
L__PMPWaitBusy14:
J	L_PMPWaitBusy2
NOP	
L_PMPWaitBusy3:
;mini3d_driver.c,216 :: 		}
L_end_PMPWaitBusy:
JR	RA
NOP	
; end of _PMPWaitBusy
_Set_Index:
;mini3d_driver.c,218 :: 		void Set_Index(unsigned short index) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mini3d_driver.c,219 :: 		TFT_RS = 0;
LBU	R2, Offset(LATB15_bit+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATB15_bit+1)(GP)
;mini3d_driver.c,220 :: 		PMDIN = index;
ANDI	R2, R25, 255
SW	R2, Offset(PMDIN+0)(GP)
;mini3d_driver.c,221 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;mini3d_driver.c,222 :: 		}
L_end_Set_Index:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Set_Index
_Write_Command:
;mini3d_driver.c,224 :: 		void Write_Command( unsigned short cmd ) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mini3d_driver.c,225 :: 		TFT_RS = 1;
LBU	R2, Offset(LATB15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATB15_bit+1)(GP)
;mini3d_driver.c,226 :: 		PMDIN = cmd;
ANDI	R2, R25, 255
SW	R2, Offset(PMDIN+0)(GP)
;mini3d_driver.c,227 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;mini3d_driver.c,228 :: 		}
L_end_Write_Command:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Write_Command
_Write_Data:
;mini3d_driver.c,230 :: 		void Write_Data(unsigned int _data) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mini3d_driver.c,231 :: 		TFT_RS = 1;
LBU	R2, Offset(LATB15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATB15_bit+1)(GP)
;mini3d_driver.c,232 :: 		PMDIN = _data;
ANDI	R2, R25, 65535
SW	R2, Offset(PMDIN+0)(GP)
;mini3d_driver.c,233 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;mini3d_driver.c,234 :: 		}
L_end_Write_Data:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Write_Data
_Init_ADC:
;mini3d_driver.c,237 :: 		void Init_ADC() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mini3d_driver.c,238 :: 		AD1PCFG = 0xFFFF;
ORI	R2, R0, 65535
SW	R2, Offset(AD1PCFG+0)(GP)
;mini3d_driver.c,239 :: 		PCFG12_bit = 0;
LBU	R2, Offset(PCFG12_bit+1)(GP)
INS	R2, R0, 4, 1
SB	R2, Offset(PCFG12_bit+1)(GP)
;mini3d_driver.c,240 :: 		PCFG13_bit = 0;
LBU	R2, Offset(PCFG13_bit+1)(GP)
INS	R2, R0, 5, 1
SB	R2, Offset(PCFG13_bit+1)(GP)
;mini3d_driver.c,242 :: 		ADC1_Init();
JAL	_ADC1_Init+0
NOP	
;mini3d_driver.c,243 :: 		}
L_end_Init_ADC:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Init_ADC
mini3d_driver_InitializeTouchPanel:
;mini3d_driver.c,244 :: 		static void InitializeTouchPanel() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mini3d_driver.c,245 :: 		Init_ADC();
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
JAL	_Init_ADC+0
NOP	
;mini3d_driver.c,246 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;mini3d_driver.c,247 :: 		TFT_Init(320, 240);
ORI	R26, R0, 240
ORI	R25, R0, 320
JAL	_TFT_Init+0
NOP	
;mini3d_driver.c,249 :: 		TP_TFT_Init(320, 240, 13, 12);                                  // Initialize touch panel
ORI	R28, R0, 12
ORI	R27, R0, 13
ORI	R26, R0, 240
ORI	R25, R0, 320
JAL	_TP_TFT_Init+0
NOP	
;mini3d_driver.c,250 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
ORI	R25, R0, 1000
JAL	_TP_TFT_Set_ADC_Threshold+0
NOP	
;mini3d_driver.c,252 :: 		}
L_end_InitializeTouchPanel:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of mini3d_driver_InitializeTouchPanel
_Init_MCU:
;mini3d_driver.c,255 :: 		void Init_MCU() {
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;mini3d_driver.c,257 :: 		CM1CON  = 0;                    // Turn off comparators
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R0, Offset(CM1CON+0)(GP)
;mini3d_driver.c,258 :: 		CM2CON  = 0;
SW	R0, Offset(CM2CON+0)(GP)
;mini3d_driver.c,259 :: 		AD1PCFG = 0xff;                 // Make all inputs digital
ORI	R2, R0, 255
SW	R2, Offset(AD1PCFG+0)(GP)
;mini3d_driver.c,261 :: 		PMMODE = 0;
SW	R0, Offset(PMMODE+0)(GP)
;mini3d_driver.c,262 :: 		PMAEN  = 0;
SW	R0, Offset(PMAEN+0)(GP)
;mini3d_driver.c,263 :: 		PMCON  = 0;  // WRSP: Write Strobe Polarity bit
SW	R0, Offset(PMCON+0)(GP)
;mini3d_driver.c,264 :: 		PMMODEbits.MODE = 2;     // Master 2
ORI	R3, R0, 2
LHU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R3, 8, 2
SH	R2, Offset(PMMODEbits+0)(GP)
;mini3d_driver.c,265 :: 		PMMODEbits.WAITB = 0;
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R0, 6, 2
SB	R2, Offset(PMMODEbits+0)(GP)
;mini3d_driver.c,266 :: 		PMMODEbits.WAITM = 1;
ORI	R3, R0, 1
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R3, 2, 4
SB	R2, Offset(PMMODEbits+0)(GP)
;mini3d_driver.c,267 :: 		PMMODEbits.WAITE = 0;
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R0, 0, 2
SB	R2, Offset(PMMODEbits+0)(GP)
;mini3d_driver.c,268 :: 		PMMODEbits.MODE16 = 1;   // 16 bit mode
LBU	R2, Offset(PMMODEbits+1)(GP)
ORI	R2, R2, 4
SB	R2, Offset(PMMODEbits+1)(GP)
;mini3d_driver.c,269 :: 		PMCONbits.CSF = 0;
LBU	R2, Offset(PMCONbits+0)(GP)
INS	R2, R0, 6, 2
SB	R2, Offset(PMCONbits+0)(GP)
;mini3d_driver.c,270 :: 		PMCONbits.PTRDEN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(PMCONbits+1)(GP)
;mini3d_driver.c,271 :: 		PMCONbits.PTWREN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 2
SB	R2, Offset(PMCONbits+1)(GP)
;mini3d_driver.c,272 :: 		PMCONbits.PMPEN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(PMCONbits+1)(GP)
;mini3d_driver.c,273 :: 		TP_TFT_Rotate_180(0);
MOVZ	R25, R0, R0
JAL	_TP_TFT_Rotate_180+0
NOP	
;mini3d_driver.c,274 :: 		TFT_Set_Active(Set_Index,Write_Command,Write_Data);
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;mini3d_driver.c,280 :: 		}
L_end_Init_MCU:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _Init_MCU
_Start_TP:
;mini3d_driver.c,282 :: 		void Start_TP() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mini3d_driver.c,283 :: 		Init_MCU();
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
JAL	_Init_MCU+0
NOP	
;mini3d_driver.c,285 :: 		InitializeTouchPanel();
JAL	mini3d_driver_InitializeTouchPanel+0
NOP	
;mini3d_driver.c,288 :: 		TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);    // Set calibration constants
ORI	R28, R0, 915
ORI	R27, R0, 77
ORI	R26, R0, 907
ORI	R25, R0, 76
JAL	_TP_TFT_Set_Calibration_Consts+0
NOP	
;mini3d_driver.c,290 :: 		}                         //initalize variables on startup
L_end_Start_TP:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _Start_TP
