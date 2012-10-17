_initVariables:
;render.c,150 :: 		void initVariables(void){
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;render.c,153 :: 		translate.x = 0.0;
SW	R0, Offset(_translate+0)(GP)
;render.c,154 :: 		translate.y = 0.0;
SW	R0, Offset(_translate+4)(GP)
;render.c,155 :: 		translate.z = 0.0;
SW	R0, Offset(_translate+8)(GP)
;render.c,158 :: 		rotate.x = 0.0;
SW	R0, Offset(_rotate+0)(GP)
;render.c,159 :: 		rotate.y = 45.0;
LUI	R2, 16948
ORI	R2, R2, 0
SW	R2, Offset(_rotate+4)(GP)
;render.c,160 :: 		rotate.z = 0.0;
SW	R0, Offset(_rotate+8)(GP)
;render.c,164 :: 		scale.x = 30.0;
LUI	R2, 16880
ORI	R2, R2, 0
SW	R2, Offset(_scale+0)(GP)
;render.c,165 :: 		scale.y = 30.0;
LUI	R2, 16880
ORI	R2, R2, 0
SW	R2, Offset(_scale+4)(GP)
;render.c,166 :: 		scale.z = 30.0;
LUI	R2, 16880
ORI	R2, R2, 0
SW	R2, Offset(_scale+8)(GP)
;render.c,171 :: 		horizontal_field_of_view =  50 * (pi / 180);
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LUI	R4, 16968
ORI	R4, R4, 0
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
SW	R2, Offset(_horizontal_field_of_view+0)(GP)
;render.c,172 :: 		vertical_field_of_view = 50 * (pi / 180);
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LUI	R4, 16968
ORI	R4, R4, 0
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
SW	R2, Offset(_vertical_field_of_view+0)(GP)
;render.c,175 :: 		horizontal_perspective_compensation = (window_width / 2) / 1000;
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LUI	R6, 17530
ORI	R6, R6, 0
MOVZ	R4, R2, R0
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_horizontal_perspective_compensation+0)(GP)
;render.c,176 :: 		vertical_perspective_compensation = (window_height / 2) / 1000;
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LUI	R6, 17530
ORI	R6, R6, 0
MOVZ	R4, R2, R0
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_vertical_perspective_compensation+0)(GP)
;render.c,181 :: 		}  //end intVariables
L_end_initVariables:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _initVariables
_computeXform:
;render.c,191 :: 		void computeXform(void){
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;render.c,194 :: 		int product_column = 0;
SW	R25, 4(SP)
;render.c,195 :: 		int product_row = 0;
;render.c,196 :: 		int shift = 0;
;render.c,197 :: 		int increment=0;
;render.c,198 :: 		int vtx = 0;
;render.c,199 :: 		int row = 0;
;render.c,203 :: 		for(vtx=0;vtx<=number_of_vertices-1;vtx++){
; vtx start address is: 16 (R4)
MOVZ	R4, R0, R0
; vtx end address is: 16 (R4)
L_computeXform0:
; vtx start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 6
BNE	R2, R0, L__computeXform153
NOP	
J	L_computeXform1
NOP	
L__computeXform153:
;render.c,204 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; vtx end address is: 16 (R4)
; row end address is: 20 (R5)
L_computeXform3:
; row start address is: 20 (R5)
; vtx start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform154
NOP	
J	L_computeXform4
NOP	
L__computeXform154:
;render.c,205 :: 		point_out[vtx][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,204 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,206 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform3
NOP	
L_computeXform4:
;render.c,203 :: 		for(vtx=0;vtx<=number_of_vertices-1;vtx++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,207 :: 		} //for vtx
; vtx end address is: 16 (R4)
J	L_computeXform0
NOP	
L_computeXform1:
;render.c,212 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform6:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform155
NOP	
J	L_computeXform7
NOP	
L__computeXform155:
;render.c,213 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform9:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform156
NOP	
J	L_computeXform10
NOP	
L__computeXform156:
;render.c,214 :: 		scale_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_scale_matrix+0)
ORI	R2, R2, #lo_addr(_scale_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,213 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,215 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform9
NOP	
L_computeXform10:
;render.c,212 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,216 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform6
NOP	
L_computeXform7:
;render.c,218 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform12:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform157
NOP	
J	L_computeXform13
NOP	
L__computeXform157:
;render.c,219 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform15:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform158
NOP	
J	L_computeXform16
NOP	
L__computeXform158:
;render.c,220 :: 		scale_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_scale_matrix+0)
ORI	R2, R2, #lo_addr(_scale_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,219 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,221 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform15
NOP	
L_computeXform16:
;render.c,218 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,222 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform12
NOP	
L_computeXform13:
;render.c,224 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform18:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform159
NOP	
J	L_computeXform19
NOP	
L__computeXform159:
;render.c,225 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform21:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform160
NOP	
J	L_computeXform22
NOP	
L__computeXform160:
;render.c,226 :: 		rotate_x_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_x_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_x_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,225 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,227 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform21
NOP	
L_computeXform22:
;render.c,224 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,228 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform18
NOP	
L_computeXform19:
;render.c,230 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform24:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform161
NOP	
J	L_computeXform25
NOP	
L__computeXform161:
;render.c,231 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform27:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform162
NOP	
J	L_computeXform28
NOP	
L__computeXform162:
;render.c,232 :: 		rotate_y_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_y_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_y_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,231 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,233 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform27
NOP	
L_computeXform28:
;render.c,230 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,234 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform24
NOP	
L_computeXform25:
;render.c,236 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform30:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform163
NOP	
J	L_computeXform31
NOP	
L__computeXform163:
;render.c,237 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform33:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform164
NOP	
J	L_computeXform34
NOP	
L__computeXform164:
;render.c,238 :: 		rotate_z_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_z_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_z_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,237 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,239 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform33
NOP	
L_computeXform34:
;render.c,236 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,240 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform30
NOP	
L_computeXform31:
;render.c,242 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform36:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform165
NOP	
J	L_computeXform37
NOP	
L__computeXform165:
;render.c,243 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform39:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform166
NOP	
J	L_computeXform40
NOP	
L__computeXform166:
;render.c,244 :: 		translation_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_translation_matrix+0)
ORI	R2, R2, #lo_addr(_translation_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,243 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,245 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform39
NOP	
L_computeXform40:
;render.c,242 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,246 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform36
NOP	
L_computeXform37:
;render.c,248 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform42:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform167
NOP	
J	L_computeXform43
NOP	
L__computeXform167:
;render.c,249 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform45:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform168
NOP	
J	L_computeXform46
NOP	
L__computeXform168:
;render.c,250 :: 		scale_product_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_scale_product_matrix+0)
ORI	R2, R2, #lo_addr(_scale_product_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,249 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,251 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform45
NOP	
L_computeXform46:
;render.c,248 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,252 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform42
NOP	
L_computeXform43:
;render.c,254 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform48:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform169
NOP	
J	L_computeXform49
NOP	
L__computeXform169:
;render.c,255 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform51:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform170
NOP	
J	L_computeXform52
NOP	
L__computeXform170:
;render.c,256 :: 		rotate_x_product_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_x_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_x_product_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,255 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,257 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform51
NOP	
L_computeXform52:
;render.c,254 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,258 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform48
NOP	
L_computeXform49:
;render.c,260 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform54:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform171
NOP	
J	L_computeXform55
NOP	
L__computeXform171:
;render.c,261 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform57:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform172
NOP	
J	L_computeXform58
NOP	
L__computeXform172:
;render.c,262 :: 		rotate_y_product_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_y_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_y_product_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,261 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,263 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform57
NOP	
L_computeXform58:
;render.c,260 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,264 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform54
NOP	
L_computeXform55:
;render.c,267 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform60:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform173
NOP	
J	L_computeXform61
NOP	
L__computeXform173:
;render.c,268 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform63:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform174
NOP	
J	L_computeXform64
NOP	
L__computeXform174:
;render.c,269 :: 		rotate_z_product_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_z_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_z_product_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,268 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,270 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform63
NOP	
L_computeXform64:
;render.c,267 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,271 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform60
NOP	
L_computeXform61:
;render.c,273 :: 		for(column=0;column<=3;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform66:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform175
NOP	
J	L_computeXform67
NOP	
L__computeXform175:
;render.c,274 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform69:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform176
NOP	
J	L_computeXform70
NOP	
L__computeXform176:
;render.c,275 :: 		perspective_matrix[column][row] = 0;
SEH	R2, R4
SLL	R3, R2, 4
LUI	R2, #hi_addr(_perspective_matrix+0)
ORI	R2, R2, #lo_addr(_perspective_matrix+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 2
ADDU	R2, R3, R2
SW	R0, 0(R2)
;render.c,274 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,276 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform69
NOP	
L_computeXform70:
;render.c,273 :: 		for(column=0;column<=3;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,277 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform66
NOP	
L_computeXform67:
;render.c,282 :: 		for(column=0;column<=number_of_polgon_sides-1;column++){
; column start address is: 16 (R4)
MOVZ	R4, R0, R0
; column end address is: 16 (R4)
L_computeXform72:
; column start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform177
NOP	
J	L_computeXform73
NOP	
L__computeXform177:
;render.c,283 :: 		for(row=0;row<=3;row++){
; row start address is: 20 (R5)
MOVZ	R5, R0, R0
; row end address is: 20 (R5)
; column end address is: 16 (R4)
L_computeXform75:
; row start address is: 20 (R5)
; column start address is: 16 (R4)
SEH	R2, R5
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform178
NOP	
J	L_computeXform76
NOP	
L__computeXform178:
;render.c,284 :: 		current_polygon_vertices[column][row] = 0;
SEH	R3, R4
ORI	R2, R0, 6
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_current_polygon_vertices+0)
ORI	R2, R2, #lo_addr(_current_polygon_vertices+0)
ADDU	R3, R2, R3
SEH	R2, R5
SLL	R2, R2, 1
ADDU	R2, R3, R2
SH	R0, 0(R2)
;render.c,283 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R5, 1
SEH	R5, R2
;render.c,285 :: 		}//for row
; row end address is: 20 (R5)
J	L_computeXform75
NOP	
L_computeXform76:
;render.c,282 :: 		for(column=0;column<=number_of_polgon_sides-1;column++){
ADDIU	R2, R4, 1
SEH	R4, R2
;render.c,286 :: 		} //for column
; column end address is: 16 (R4)
J	L_computeXform72
NOP	
L_computeXform73:
;render.c,291 :: 		scale_matrix[0][0] = scale.x; //scale X
LW	R2, Offset(_scale+0)(GP)
SW	R2, Offset(_scale_matrix+0)(GP)
;render.c,292 :: 		scale_matrix[1][0] = 0;
SW	R0, Offset(_scale_matrix+16)(GP)
;render.c,293 :: 		scale_matrix[2][0] = 0;
SW	R0, Offset(_scale_matrix+32)(GP)
;render.c,294 :: 		scale_matrix[3][0] = 0;
SW	R0, Offset(_scale_matrix+48)(GP)
;render.c,296 :: 		scale_matrix[0][1] = 0;
SW	R0, Offset(_scale_matrix+4)(GP)
;render.c,297 :: 		scale_matrix[1][1] = scale.y; //scale y
LW	R2, Offset(_scale+4)(GP)
SW	R2, Offset(_scale_matrix+20)(GP)
;render.c,298 :: 		scale_matrix[2][1] = 0;
SW	R0, Offset(_scale_matrix+36)(GP)
;render.c,299 :: 		scale_matrix[3][1] = 0;
SW	R0, Offset(_scale_matrix+52)(GP)
;render.c,301 :: 		scale_matrix[0][2] = 0;
SW	R0, Offset(_scale_matrix+8)(GP)
;render.c,302 :: 		scale_matrix[1][2] = 0;
SW	R0, Offset(_scale_matrix+24)(GP)
;render.c,303 :: 		scale_matrix[2][2] = scale.z; //scale z
LW	R2, Offset(_scale+8)(GP)
SW	R2, Offset(_scale_matrix+40)(GP)
;render.c,304 :: 		scale_matrix[3][2] = 0;
SW	R0, Offset(_scale_matrix+56)(GP)
;render.c,306 :: 		scale_matrix[0][3] = 0;
SW	R0, Offset(_scale_matrix+12)(GP)
;render.c,307 :: 		scale_matrix[1][3] = 0;
SW	R0, Offset(_scale_matrix+28)(GP)
;render.c,308 :: 		scale_matrix[2][3] = 0;
SW	R0, Offset(_scale_matrix+44)(GP)
;render.c,309 :: 		scale_matrix[3][3] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_scale_matrix+60)(GP)
;render.c,314 :: 		rotate_z_matrix[0][0] = cos( rotate.z * (pi / 180) );  //rotate.z is rotate z
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+8)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_cos+0
NOP	
SW	R2, Offset(_rotate_z_matrix+0)(GP)
;render.c,315 :: 		rotate_z_matrix[1][0] = sin( rotate.z * (pi / 180) );  //rotate.z is rotate z
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+8)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sin+0
NOP	
SW	R2, Offset(_rotate_z_matrix+16)(GP)
;render.c,316 :: 		rotate_z_matrix[2][0] = 0;
SW	R0, Offset(_rotate_z_matrix+32)(GP)
;render.c,317 :: 		rotate_z_matrix[3][0] = 0;
SW	R0, Offset(_rotate_z_matrix+48)(GP)
;render.c,319 :: 		rotate_z_matrix[0][1] = -sin( rotate.z * (pi / 180) ); //rotate.z is rotate z
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+8)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sin+0
NOP	
LUI	R3, 32768
XOR	R2, R2, R3
SW	R2, Offset(_rotate_z_matrix+4)(GP)
;render.c,320 :: 		rotate_z_matrix[1][1] = cos( rotate.z * (pi / 180) );  //rotate.z is rotate z
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+8)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_cos+0
NOP	
SW	R2, Offset(_rotate_z_matrix+20)(GP)
;render.c,321 :: 		rotate_z_matrix[2][1] = 0;
SW	R0, Offset(_rotate_z_matrix+36)(GP)
;render.c,322 :: 		rotate_z_matrix[3][1] = 0;
SW	R0, Offset(_rotate_z_matrix+52)(GP)
;render.c,324 :: 		rotate_z_matrix[0][2] = 0;
SW	R0, Offset(_rotate_z_matrix+8)(GP)
;render.c,325 :: 		rotate_z_matrix[1][2] = 0;
SW	R0, Offset(_rotate_z_matrix+24)(GP)
;render.c,326 :: 		rotate_z_matrix[2][2] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_rotate_z_matrix+40)(GP)
;render.c,327 :: 		rotate_z_matrix[3][2] = 0;
SW	R0, Offset(_rotate_z_matrix+56)(GP)
;render.c,329 :: 		rotate_z_matrix[0][3] = 0;
SW	R0, Offset(_rotate_z_matrix+12)(GP)
;render.c,330 :: 		rotate_z_matrix[1][3] = 0;
SW	R0, Offset(_rotate_z_matrix+28)(GP)
;render.c,331 :: 		rotate_z_matrix[2][3] = 0;
SW	R0, Offset(_rotate_z_matrix+44)(GP)
;render.c,332 :: 		rotate_z_matrix[3][3] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_rotate_z_matrix+60)(GP)
;render.c,335 :: 		rotate_y_matrix[0][0] = cos( rotate.y * (pi / 180) );  //rotate.y is rotate y
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+4)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_cos+0
NOP	
SW	R2, Offset(_rotate_y_matrix+0)(GP)
;render.c,336 :: 		rotate_y_matrix[1][0] = 0;
SW	R0, Offset(_rotate_y_matrix+16)(GP)
;render.c,337 :: 		rotate_y_matrix[2][0] = -sin( rotate.y * (pi / 180) ); //rotate.y is rotate y
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+4)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sin+0
NOP	
LUI	R3, 32768
XOR	R2, R2, R3
SW	R2, Offset(_rotate_y_matrix+32)(GP)
;render.c,338 :: 		rotate_y_matrix[3][0] = 0;
SW	R0, Offset(_rotate_y_matrix+48)(GP)
;render.c,340 :: 		rotate_y_matrix[0][1] = 0;
SW	R0, Offset(_rotate_y_matrix+4)(GP)
;render.c,341 :: 		rotate_y_matrix[1][1] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_rotate_y_matrix+20)(GP)
;render.c,342 :: 		rotate_y_matrix[2][1] = 0;
SW	R0, Offset(_rotate_y_matrix+36)(GP)
;render.c,343 :: 		rotate_y_matrix[3][1] = 0;
SW	R0, Offset(_rotate_y_matrix+52)(GP)
;render.c,345 :: 		rotate_y_matrix[0][2] = sin( rotate.y * (pi / 180) ); //rotate.y is rotate y
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+4)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sin+0
NOP	
SW	R2, Offset(_rotate_y_matrix+8)(GP)
;render.c,346 :: 		rotate_y_matrix[1][2] = 0;
SW	R0, Offset(_rotate_y_matrix+24)(GP)
;render.c,347 :: 		rotate_y_matrix[2][2] = cos( rotate.y * (pi / 180) ); //rotate.y is rotate y
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+4)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_cos+0
NOP	
SW	R2, Offset(_rotate_y_matrix+40)(GP)
;render.c,348 :: 		rotate_y_matrix[3][2] = 0;
SW	R0, Offset(_rotate_y_matrix+56)(GP)
;render.c,350 :: 		rotate_y_matrix[0][3] = 0;
SW	R0, Offset(_rotate_y_matrix+12)(GP)
;render.c,351 :: 		rotate_y_matrix[1][3] = 0;
SW	R0, Offset(_rotate_y_matrix+28)(GP)
;render.c,352 :: 		rotate_y_matrix[2][3] = 0;
SW	R0, Offset(_rotate_y_matrix+44)(GP)
;render.c,353 :: 		rotate_y_matrix[3][3] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_rotate_y_matrix+60)(GP)
;render.c,356 :: 		rotate_x_matrix[0][0] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_rotate_x_matrix+0)(GP)
;render.c,357 :: 		rotate_x_matrix[1][0] = 0;
SW	R0, Offset(_rotate_x_matrix+16)(GP)
;render.c,358 :: 		rotate_x_matrix[2][0] = 0;
SW	R0, Offset(_rotate_x_matrix+32)(GP)
;render.c,359 :: 		rotate_x_matrix[3][0] = 0;
SW	R0, Offset(_rotate_x_matrix+48)(GP)
;render.c,361 :: 		rotate_x_matrix[0][1] = 0;
SW	R0, Offset(_rotate_x_matrix+4)(GP)
;render.c,362 :: 		rotate_x_matrix[1][1] = cos( rotate.x * (pi / 180) );  //rotate.x is rotate x
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+0)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_cos+0
NOP	
SW	R2, Offset(_rotate_x_matrix+20)(GP)
;render.c,363 :: 		rotate_x_matrix[2][1] = sin( rotate.x * (pi / 180) );  //rotate.x is rotate x
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+0)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sin+0
NOP	
SW	R2, Offset(_rotate_x_matrix+36)(GP)
;render.c,364 :: 		rotate_x_matrix[3][1] = 0;
SW	R0, Offset(_rotate_x_matrix+52)(GP)
;render.c,366 :: 		rotate_x_matrix[0][2] = 0;
SW	R0, Offset(_rotate_x_matrix+8)(GP)
;render.c,367 :: 		rotate_x_matrix[1][2] = -sin( rotate.x * (pi / 180)  ); //rotate.x is rotate x
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+0)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sin+0
NOP	
LUI	R3, 32768
XOR	R2, R2, R3
SW	R2, Offset(_rotate_x_matrix+24)(GP)
;render.c,368 :: 		rotate_x_matrix[2][2] = cos( rotate.x * (pi / 180) );  //rotate.x is rotate x
LW	R4, Offset(_pi+0)(GP)
LUI	R6, 17204
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, Offset(_rotate+0)(GP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_cos+0
NOP	
SW	R2, Offset(_rotate_x_matrix+40)(GP)
;render.c,369 :: 		rotate_x_matrix[3][2] = 0;
SW	R0, Offset(_rotate_x_matrix+56)(GP)
;render.c,371 :: 		rotate_x_matrix[0][3] = 0;
SW	R0, Offset(_rotate_x_matrix+12)(GP)
;render.c,372 :: 		rotate_x_matrix[1][3] = 0;
SW	R0, Offset(_rotate_x_matrix+28)(GP)
;render.c,373 :: 		rotate_x_matrix[2][3] = 0;
SW	R0, Offset(_rotate_x_matrix+44)(GP)
;render.c,374 :: 		rotate_x_matrix[3][3] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_rotate_x_matrix+60)(GP)
;render.c,377 :: 		translation_matrix[0][0] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_translation_matrix+0)(GP)
;render.c,378 :: 		translation_matrix[1][0] = 0;
SW	R0, Offset(_translation_matrix+16)(GP)
;render.c,379 :: 		translation_matrix[2][0] = 0;
SW	R0, Offset(_translation_matrix+32)(GP)
;render.c,380 :: 		translation_matrix[3][0] = 0;
SW	R0, Offset(_translation_matrix+48)(GP)
;render.c,382 :: 		translation_matrix[0][1] = 0;
SW	R0, Offset(_translation_matrix+4)(GP)
;render.c,383 :: 		translation_matrix[1][1] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_translation_matrix+20)(GP)
;render.c,384 :: 		translation_matrix[2][1] = 0;
SW	R0, Offset(_translation_matrix+36)(GP)
;render.c,385 :: 		translation_matrix[3][1] = 0;
SW	R0, Offset(_translation_matrix+52)(GP)
;render.c,387 :: 		translation_matrix[0][2] = 0;
SW	R0, Offset(_translation_matrix+8)(GP)
;render.c,388 :: 		translation_matrix[1][2] = 0;
SW	R0, Offset(_translation_matrix+24)(GP)
;render.c,389 :: 		translation_matrix[2][2] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_translation_matrix+40)(GP)
;render.c,390 :: 		translation_matrix[3][2] = 0;
SW	R0, Offset(_translation_matrix+56)(GP)
;render.c,392 :: 		translation_matrix[0][3] = translate.x;    //translate.x is translate x
LW	R2, Offset(_translate+0)(GP)
SW	R2, Offset(_translation_matrix+12)(GP)
;render.c,393 :: 		translation_matrix[1][3] = translate.y;    //translate.y is translate y
LW	R2, Offset(_translate+4)(GP)
SW	R2, Offset(_translation_matrix+28)(GP)
;render.c,394 :: 		translation_matrix[2][3] = translate.z;    //translate.z is translate z
LW	R2, Offset(_translate+8)(GP)
SW	R2, Offset(_translation_matrix+44)(GP)
;render.c,395 :: 		translation_matrix[3][3] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_translation_matrix+60)(GP)
;render.c,399 :: 		perspective_matrix[0][0] = horizontal_field_of_view;
LW	R2, Offset(_horizontal_field_of_view+0)(GP)
SW	R2, Offset(_perspective_matrix+0)(GP)
;render.c,400 :: 		perspective_matrix[1][0] = 0;
SW	R0, Offset(_perspective_matrix+16)(GP)
;render.c,401 :: 		perspective_matrix[2][0] = 0;
SW	R0, Offset(_perspective_matrix+32)(GP)
;render.c,402 :: 		perspective_matrix[3][0] = 0;
SW	R0, Offset(_perspective_matrix+48)(GP)
;render.c,404 :: 		perspective_matrix[0][1] = 0;
SW	R0, Offset(_perspective_matrix+4)(GP)
;render.c,405 :: 		perspective_matrix[1][1] = vertical_field_of_view;
LW	R2, Offset(_vertical_field_of_view+0)(GP)
SW	R2, Offset(_perspective_matrix+20)(GP)
;render.c,406 :: 		perspective_matrix[2][1] = 0;
SW	R0, Offset(_perspective_matrix+36)(GP)
;render.c,407 :: 		perspective_matrix[3][1] = 0;
SW	R0, Offset(_perspective_matrix+52)(GP)
;render.c,409 :: 		perspective_matrix[0][2] = 0;
SW	R0, Offset(_perspective_matrix+8)(GP)
;render.c,410 :: 		perspective_matrix[1][2] = 0;
SW	R0, Offset(_perspective_matrix+24)(GP)
;render.c,411 :: 		perspective_matrix[2][2] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_perspective_matrix+40)(GP)
;render.c,412 :: 		perspective_matrix[3][2] = 1;
LUI	R2, 16256
ORI	R2, R2, 0
SW	R2, Offset(_perspective_matrix+56)(GP)
;render.c,414 :: 		perspective_matrix[0][3] = 0;
SW	R0, Offset(_perspective_matrix+12)(GP)
;render.c,415 :: 		perspective_matrix[1][3] = 0;
SW	R0, Offset(_perspective_matrix+28)(GP)
;render.c,416 :: 		perspective_matrix[2][3] = 0;
SW	R0, Offset(_perspective_matrix+44)(GP)
;render.c,417 :: 		perspective_matrix[3][3] = 0;
SW	R0, Offset(_perspective_matrix+60)(GP)
;render.c,421 :: 		for (product_column = 0;product_column<=3;product_column++){
; product_column start address is: 64 (R16)
MOVZ	R16, R0, R0
; product_column end address is: 64 (R16)
L_computeXform78:
; product_column start address is: 64 (R16)
SEH	R2, R16
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform179
NOP	
J	L_computeXform79
NOP	
L__computeXform179:
;render.c,422 :: 		for (product_row = 0;product_row<=3;product_row++){
; product_row start address is: 68 (R17)
MOVZ	R17, R0, R0
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform81:
; product_row start address is: 68 (R17)
; product_column start address is: 64 (R16)
SEH	R2, R17
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform180
NOP	
J	L_computeXform82
NOP	
L__computeXform180:
;render.c,423 :: 		for (shift = 0;shift<=3;shift++){
; shift start address is: 72 (R18)
MOVZ	R18, R0, R0
; shift end address is: 72 (R18)
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform84:
; shift start address is: 72 (R18)
; product_column start address is: 64 (R16)
; product_row start address is: 68 (R17)
SEH	R2, R18
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform181
NOP	
J	L_computeXform85
NOP	
L__computeXform181:
;render.c,424 :: 		rotate_x_product_matrix[product_column][product_row] = rotate_x_product_matrix[product_column][product_row] + ( translation_matrix[shift][product_row] * rotate_x_matrix[product_column][shift] );
SEH	R2, R16
SLL	R5, R2, 4
LUI	R2, #hi_addr(_rotate_x_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_x_product_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R17
SLL	R4, R2, 2
ADDU	R2, R3, R4
SW	R2, 12(SP)
LW	R2, 0(R2)
SW	R2, 8(SP)
SEH	R2, R18
SLL	R3, R2, 4
LUI	R2, #hi_addr(_translation_matrix+0)
ORI	R2, R2, #lo_addr(_translation_matrix+0)
ADDU	R2, R2, R3
ADDU	R2, R2, R4
LW	R6, 0(R2)
LUI	R2, #hi_addr(_rotate_x_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_x_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R18
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R4, 0(R2)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 0(R3)
;render.c,423 :: 		for (shift = 0;shift<=3;shift++){
ADDIU	R2, R18, 1
SEH	R18, R2
;render.c,425 :: 		}// shift
; shift end address is: 72 (R18)
J	L_computeXform84
NOP	
L_computeXform85:
;render.c,422 :: 		for (product_row = 0;product_row<=3;product_row++){
ADDIU	R2, R17, 1
SEH	R17, R2
;render.c,426 :: 		}// product_row
; product_row end address is: 68 (R17)
J	L_computeXform81
NOP	
L_computeXform82:
;render.c,421 :: 		for (product_column = 0;product_column<=3;product_column++){
ADDIU	R2, R16, 1
SEH	R16, R2
;render.c,427 :: 		} // product_column
; product_column end address is: 64 (R16)
J	L_computeXform78
NOP	
L_computeXform79:
;render.c,430 :: 		for (product_column = 0;product_column<=3;product_column++){
; product_column start address is: 64 (R16)
MOVZ	R16, R0, R0
; product_column end address is: 64 (R16)
L_computeXform87:
; product_column start address is: 64 (R16)
SEH	R2, R16
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform182
NOP	
J	L_computeXform88
NOP	
L__computeXform182:
;render.c,431 :: 		for (product_row = 0;product_row<=3;product_row++){
; product_row start address is: 68 (R17)
MOVZ	R17, R0, R0
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform90:
; product_row start address is: 68 (R17)
; product_column start address is: 64 (R16)
SEH	R2, R17
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform183
NOP	
J	L_computeXform91
NOP	
L__computeXform183:
;render.c,432 :: 		for (shift = 0;shift<=3;shift++){
; shift start address is: 72 (R18)
MOVZ	R18, R0, R0
; shift end address is: 72 (R18)
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform93:
; shift start address is: 72 (R18)
; product_column start address is: 64 (R16)
; product_row start address is: 68 (R17)
SEH	R2, R18
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform184
NOP	
J	L_computeXform94
NOP	
L__computeXform184:
;render.c,433 :: 		rotate_y_product_matrix[product_column][product_row] = rotate_y_product_matrix[product_column][product_row] + (rotate_x_product_matrix[shift][product_row] * rotate_y_matrix[product_column][shift] );
SEH	R2, R16
SLL	R5, R2, 4
LUI	R2, #hi_addr(_rotate_y_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_y_product_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R17
SLL	R4, R2, 2
ADDU	R2, R3, R4
SW	R2, 12(SP)
LW	R2, 0(R2)
SW	R2, 8(SP)
SEH	R2, R18
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_x_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_x_product_matrix+0)
ADDU	R2, R2, R3
ADDU	R2, R2, R4
LW	R6, 0(R2)
LUI	R2, #hi_addr(_rotate_y_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_y_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R18
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R4, 0(R2)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 0(R3)
;render.c,432 :: 		for (shift = 0;shift<=3;shift++){
ADDIU	R2, R18, 1
SEH	R18, R2
;render.c,434 :: 		}// shift
; shift end address is: 72 (R18)
J	L_computeXform93
NOP	
L_computeXform94:
;render.c,431 :: 		for (product_row = 0;product_row<=3;product_row++){
ADDIU	R2, R17, 1
SEH	R17, R2
;render.c,435 :: 		}// product_row
; product_row end address is: 68 (R17)
J	L_computeXform90
NOP	
L_computeXform91:
;render.c,430 :: 		for (product_column = 0;product_column<=3;product_column++){
ADDIU	R2, R16, 1
SEH	R16, R2
;render.c,436 :: 		} // product_column
; product_column end address is: 64 (R16)
J	L_computeXform87
NOP	
L_computeXform88:
;render.c,439 :: 		for (product_column = 0;product_column<=3;product_column++){
; product_column start address is: 64 (R16)
MOVZ	R16, R0, R0
; product_column end address is: 64 (R16)
L_computeXform96:
; product_column start address is: 64 (R16)
SEH	R2, R16
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform185
NOP	
J	L_computeXform97
NOP	
L__computeXform185:
;render.c,440 :: 		for (product_row = 0;product_row<=3;product_row++){
; product_row start address is: 68 (R17)
MOVZ	R17, R0, R0
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform99:
; product_row start address is: 68 (R17)
; product_column start address is: 64 (R16)
SEH	R2, R17
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform186
NOP	
J	L_computeXform100
NOP	
L__computeXform186:
;render.c,441 :: 		for (shift = 0;shift<=3;shift++){
; shift start address is: 72 (R18)
MOVZ	R18, R0, R0
; shift end address is: 72 (R18)
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform102:
; shift start address is: 72 (R18)
; product_column start address is: 64 (R16)
; product_row start address is: 68 (R17)
SEH	R2, R18
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform187
NOP	
J	L_computeXform103
NOP	
L__computeXform187:
;render.c,442 :: 		rotate_z_product_matrix[product_column][product_row] = rotate_z_product_matrix[product_column][product_row] + (rotate_y_product_matrix[shift][product_row] * rotate_z_matrix[product_column][shift] );
SEH	R2, R16
SLL	R5, R2, 4
LUI	R2, #hi_addr(_rotate_z_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_z_product_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R17
SLL	R4, R2, 2
ADDU	R2, R3, R4
SW	R2, 12(SP)
LW	R2, 0(R2)
SW	R2, 8(SP)
SEH	R2, R18
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_y_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_y_product_matrix+0)
ADDU	R2, R2, R3
ADDU	R2, R2, R4
LW	R6, 0(R2)
LUI	R2, #hi_addr(_rotate_z_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_z_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R18
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R4, 0(R2)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 0(R3)
;render.c,441 :: 		for (shift = 0;shift<=3;shift++){
ADDIU	R2, R18, 1
SEH	R18, R2
;render.c,443 :: 		}// shift
; shift end address is: 72 (R18)
J	L_computeXform102
NOP	
L_computeXform103:
;render.c,440 :: 		for (product_row = 0;product_row<=3;product_row++){
ADDIU	R2, R17, 1
SEH	R17, R2
;render.c,444 :: 		}// product_row
; product_row end address is: 68 (R17)
J	L_computeXform99
NOP	
L_computeXform100:
;render.c,439 :: 		for (product_column = 0;product_column<=3;product_column++){
ADDIU	R2, R16, 1
SEH	R16, R2
;render.c,445 :: 		} // product_column
; product_column end address is: 64 (R16)
J	L_computeXform96
NOP	
L_computeXform97:
;render.c,448 :: 		for (product_column = 0;product_column<=3;product_column++){
; product_column start address is: 64 (R16)
MOVZ	R16, R0, R0
; product_column end address is: 64 (R16)
L_computeXform105:
; product_column start address is: 64 (R16)
SEH	R2, R16
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform188
NOP	
J	L_computeXform106
NOP	
L__computeXform188:
;render.c,449 :: 		for (product_row = 0;product_row<=3;product_row++){
; product_row start address is: 68 (R17)
MOVZ	R17, R0, R0
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform108:
; product_row start address is: 68 (R17)
; product_column start address is: 64 (R16)
SEH	R2, R17
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform189
NOP	
J	L_computeXform109
NOP	
L__computeXform189:
;render.c,450 :: 		for (shift = 0;shift<=3;shift++){
; shift start address is: 72 (R18)
MOVZ	R18, R0, R0
; shift end address is: 72 (R18)
; product_row end address is: 68 (R17)
; product_column end address is: 64 (R16)
L_computeXform111:
; shift start address is: 72 (R18)
; product_column start address is: 64 (R16)
; product_row start address is: 68 (R17)
SEH	R2, R18
SLTI	R2, R2, 4
BNE	R2, R0, L__computeXform190
NOP	
J	L_computeXform112
NOP	
L__computeXform190:
;render.c,451 :: 		scale_product_matrix[product_column][product_row] =  scale_product_matrix[product_column][product_row] + (rotate_z_product_matrix[shift][product_row] * scale_matrix[product_column][shift] );
SEH	R2, R16
SLL	R5, R2, 4
LUI	R2, #hi_addr(_scale_product_matrix+0)
ORI	R2, R2, #lo_addr(_scale_product_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R17
SLL	R4, R2, 2
ADDU	R2, R3, R4
SW	R2, 12(SP)
LW	R2, 0(R2)
SW	R2, 8(SP)
SEH	R2, R18
SLL	R3, R2, 4
LUI	R2, #hi_addr(_rotate_z_product_matrix+0)
ORI	R2, R2, #lo_addr(_rotate_z_product_matrix+0)
ADDU	R2, R2, R3
ADDU	R2, R2, R4
LW	R6, 0(R2)
LUI	R2, #hi_addr(_scale_matrix+0)
ORI	R2, R2, #lo_addr(_scale_matrix+0)
ADDU	R3, R2, R5
SEH	R2, R18
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R4, 0(R2)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 0(R3)
;render.c,450 :: 		for (shift = 0;shift<=3;shift++){
ADDIU	R2, R18, 1
SEH	R18, R2
;render.c,452 :: 		}// shift
; shift end address is: 72 (R18)
J	L_computeXform111
NOP	
L_computeXform112:
;render.c,449 :: 		for (product_row = 0;product_row<=3;product_row++){
ADDIU	R2, R17, 1
SEH	R17, R2
;render.c,453 :: 		}// product_row
; product_row end address is: 68 (R17)
J	L_computeXform108
NOP	
L_computeXform109:
;render.c,448 :: 		for (product_column = 0;product_column<=3;product_column++){
ADDIU	R2, R16, 1
SEH	R16, R2
;render.c,454 :: 		} // product_column
; product_column end address is: 64 (R16)
J	L_computeXform105
NOP	
L_computeXform106:
;render.c,463 :: 		for(vertex=0;vertex<=number_of_vertices-1;vertex++){
SH	R0, Offset(_vertex+0)(GP)
L_computeXform114:
LH	R2, Offset(_vertex+0)(GP)
SLTI	R2, R2, 6
BNE	R2, R0, L__computeXform191
NOP	
J	L_computeXform115
NOP	
L__computeXform191:
;render.c,471 :: 		point_out[vertex][0] = (  scale_product_matrix[0][0] * point_in[vertex][0] ) + (  scale_product_matrix[0][1] * point_in[vertex][1] ) + (  scale_product_matrix[0][2] * point_in[vertex][2] ) + (  scale_product_matrix[0][3] * point_in[vertex][3] );
LH	R2, Offset(_vertex+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 16(SP)
LUI	R2, #hi_addr(_point_in+0)
ORI	R2, R2, #lo_addr(_point_in+0)
ADDU	R2, R2, R3
SW	R2, 12(SP)
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+0)(GP)
JAL	__Mul_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 4
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+4)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 8
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+8)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 12
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+12)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 16(SP)
SW	R2, 0(R3)
;render.c,472 :: 		point_out[vertex][1] = (  scale_product_matrix[1][0] * point_in[vertex][0] ) + (  scale_product_matrix[1][1] * point_in[vertex][1] ) + (  scale_product_matrix[1][2] * point_in[vertex][2] ) + (  scale_product_matrix[1][3] * point_in[vertex][3] );
LH	R2, Offset(_vertex+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 4
SW	R2, 16(SP)
LUI	R2, #hi_addr(_point_in+0)
ORI	R2, R2, #lo_addr(_point_in+0)
ADDU	R2, R2, R3
SW	R2, 12(SP)
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+16)(GP)
JAL	__Mul_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 4
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+20)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 8
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+24)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 12
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+28)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 16(SP)
SW	R2, 0(R3)
;render.c,473 :: 		point_out[vertex][2] = (  scale_product_matrix[2][0] * point_in[vertex][0] ) + (  scale_product_matrix[2][1] * point_in[vertex][1] ) + (  scale_product_matrix[2][2] * point_in[vertex][2] ) + (  scale_product_matrix[2][3] * point_in[vertex][3] );
LH	R2, Offset(_vertex+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 8
SW	R2, 16(SP)
LUI	R2, #hi_addr(_point_in+0)
ORI	R2, R2, #lo_addr(_point_in+0)
ADDU	R2, R2, R3
SW	R2, 12(SP)
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+32)(GP)
JAL	__Mul_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 4
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+36)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 8
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+40)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 12
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+44)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 16(SP)
SW	R2, 0(R3)
;render.c,474 :: 		point_out[vertex][3] = (  scale_product_matrix[3][0] * point_in[vertex][0] ) + (  scale_product_matrix[3][1] * point_in[vertex][1] ) + (  scale_product_matrix[3][2] * point_in[vertex][2] ) + (  scale_product_matrix[3][3] * point_in[vertex][3] );
LH	R2, Offset(_vertex+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 12
SW	R2, 16(SP)
LUI	R2, #hi_addr(_point_in+0)
ORI	R2, R2, #lo_addr(_point_in+0)
ADDU	R2, R2, R3
SW	R2, 12(SP)
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+48)(GP)
JAL	__Mul_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 4
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+52)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 8
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+56)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 12(SP)
SW	R2, 8(SP)
ADDIU	R2, R3, 12
LW	R6, 0(R2)
LW	R4, Offset(_scale_product_matrix+60)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 8(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
LW	R3, 16(SP)
SW	R2, 0(R3)
;render.c,463 :: 		for(vertex=0;vertex<=number_of_vertices-1;vertex++){
LH	R2, Offset(_vertex+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_vertex+0)(GP)
;render.c,478 :: 		} //end for vertex
J	L_computeXform114
NOP	
L_computeXform115:
;render.c,481 :: 		} //end compute transform matrix
L_end_computeXform:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _computeXform
_drawModel:
;render.c,490 :: 		void drawModel(){
ADDIU	SP, SP, -48
SW	RA, 0(SP)
;render.c,494 :: 		int product_column = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;render.c,495 :: 		int product_row = 0;
;render.c,496 :: 		int shift = 0;
;render.c,497 :: 		int increment=0;
;render.c,498 :: 		int vtx = 0;
;render.c,499 :: 		int row = 0;
;render.c,503 :: 		for(face=0;face<number_of_faces-1;face++){
SH	R0, Offset(_face+0)(GP)
L_drawModel117:
LH	R2, Offset(_face+0)(GP)
SLTI	R2, R2, 3
BNE	R2, R0, L__drawModel193
NOP	
J	L_drawModel118
NOP	
L__drawModel193:
;render.c,506 :: 		for(column=0;column<=number_of_polgon_sides-1;column++){
; column start address is: 24 (R6)
MOVZ	R6, R0, R0
; column end address is: 24 (R6)
L_drawModel120:
; column start address is: 24 (R6)
SEH	R2, R6
SLTI	R2, R2, 4
BNE	R2, R0, L__drawModel194
NOP	
J	L_drawModel121
NOP	
L__drawModel194:
;render.c,507 :: 		for(row=0;row<=3;row++){
; row start address is: 28 (R7)
MOVZ	R7, R0, R0
; row end address is: 28 (R7)
; column end address is: 24 (R6)
L_drawModel123:
; row start address is: 28 (R7)
; column start address is: 24 (R6)
SEH	R2, R7
SLTI	R2, R2, 4
BNE	R2, R0, L__drawModel195
NOP	
J	L_drawModel124
NOP	
L__drawModel195:
;render.c,512 :: 		current_polygon_vertices[column][row] = polygon_faces[face][column][row]-1;
SEH	R3, R6
ORI	R2, R0, 6
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_current_polygon_vertices+0)
ORI	R2, R2, #lo_addr(_current_polygon_vertices+0)
ADDU	R3, R2, R3
SEH	R2, R7
SLL	R2, R2, 1
ADDU	R5, R3, R2
LUI	R4, #hi_addr(_polygon_faces+0)
ORI	R4, R4, #lo_addr(_polygon_faces+0)
LH	R3, Offset(_face+0)(GP)
ORI	R2, R0, 12
MULTU	R2, R3
MFLO	R2
ADDU	R2, R4, R2
MOVZ	R4, R2, R0
SEH	R3, R6
ORI	R2, R0, 3
MULTU	R2, R3
MFLO	R2
ADDU	R3, R4, R2
SEH	R2, R7
ADDU	R2, R3, R2
LBU	R2, 0(R2)
ANDI	R2, R2, 255
ADDIU	R2, R2, -1
SH	R2, 0(R5)
;render.c,507 :: 		for(row=0;row<=3;row++){
ADDIU	R2, R7, 1
SEH	R7, R2
;render.c,514 :: 		}//for row
; row end address is: 28 (R7)
J	L_drawModel123
NOP	
L_drawModel124:
;render.c,506 :: 		for(column=0;column<=number_of_polgon_sides-1;column++){
ADDIU	R2, R6, 1
SEH	R6, R2
;render.c,515 :: 		} //for column
; column end address is: 24 (R6)
J	L_drawModel120
NOP	
L_drawModel121:
;render.c,521 :: 		cull_x[0] = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_cull_x+0)(GP)
;render.c,522 :: 		cull_y[0] = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_cull_y+0)(GP)
;render.c,523 :: 		cull_z[0] = (-point_out[ current_polygon_vertices[0][0] ][2] );
LW	R2, 40(SP)
ADDIU	R2, R2, 8
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, Offset(_cull_z+0)(GP)
;render.c,527 :: 		cull_x[1] = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+6)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_cull_x+4)(GP)
;render.c,528 :: 		cull_y[1] = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_cull_y+4)(GP)
;render.c,529 :: 		cull_z[1] = (-point_out[ current_polygon_vertices[1][0] ][2]);
LW	R2, 40(SP)
ADDIU	R2, R2, 8
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, Offset(_cull_z+4)(GP)
;render.c,532 :: 		cull_x[2] = (point_out[ current_polygon_vertices[2][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+12)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_cull_x+8)(GP)
;render.c,533 :: 		cull_y[2] = (-point_out[ current_polygon_vertices[2][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 44(SP)
SW	R2, Offset(_cull_y+8)(GP)
;render.c,534 :: 		cull_z[2] = (-point_out[ current_polygon_vertices[2][0] ][2] );
LW	R2, 40(SP)
ADDIU	R2, R2, 8
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 40(SP)
SW	R2, Offset(_cull_z+8)(GP)
;render.c,541 :: 		side_one[0] = cull_x[1] - cull_x[0];
LW	R6, Offset(_cull_x+0)(GP)
LW	R4, Offset(_cull_x+4)(GP)
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_side_one+0)(GP)
;render.c,542 :: 		side_one[1] = cull_y[1] - cull_y[0];
LW	R6, Offset(_cull_y+0)(GP)
LW	R4, Offset(_cull_y+4)(GP)
JAL	__Sub_FP+0
NOP	
SW	R2, 36(SP)
SW	R2, Offset(_side_one+4)(GP)
;render.c,543 :: 		side_one[2] = cull_z[1] - cull_z[0];
LW	R6, Offset(_cull_z+0)(GP)
LW	R4, Offset(_cull_z+4)(GP)
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_side_one+8)(GP)
;render.c,545 :: 		side_two[0] = cull_x[2] - cull_x[1];
LW	R6, Offset(_cull_x+4)(GP)
LW	R4, Offset(_cull_x+8)(GP)
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_side_two+0)(GP)
;render.c,546 :: 		side_two[1] = cull_y[2] - cull_y[1];
LW	R6, Offset(_cull_y+4)(GP)
LW	R4, 44(SP)
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_side_two+4)(GP)
;render.c,547 :: 		side_two[2] = cull_z[2] - cull_z[1];
LW	R6, Offset(_cull_z+4)(GP)
LW	R4, 40(SP)
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_side_two+8)(GP)
;render.c,553 :: 		surface_normal[0] = (  ( side_one[1] * side_two[2] ) - ( side_one[2] * side_two[1] ) );
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_side_two+4)(GP)
LW	R4, Offset(_side_one+8)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_surface_normal+0)(GP)
;render.c,554 :: 		surface_normal[1] = (  ( side_one[2] * side_two[0] ) - ( side_one[0] * side_two[2] ) );
LW	R6, Offset(_side_two+0)(GP)
LW	R4, Offset(_side_one+8)(GP)
JAL	__Mul_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_side_two+8)(GP)
LW	R4, Offset(_side_one+0)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_surface_normal+4)(GP)
;render.c,555 :: 		surface_normal[2] = (  ( side_one[0] * side_two[1] ) - ( side_one[1] * side_two[0] ) );
LW	R6, Offset(_side_two+4)(GP)
LW	R4, Offset(_side_one+0)(GP)
JAL	__Mul_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_side_two+0)(GP)
LW	R4, Offset(_side_one+4)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_surface_normal+8)(GP)
;render.c,559 :: 		normal_length = sqrt( (surface_normal[0] * surface_normal[0]) + (surface_normal[1] * surface_normal[1]) + (surface_normal[2] * surface_normal[2]) );
LW	R6, Offset(_surface_normal+0)(GP)
LW	R4, Offset(_surface_normal+0)(GP)
JAL	__Mul_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_surface_normal+4)(GP)
LW	R4, Offset(_surface_normal+4)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_surface_normal+8)(GP)
LW	R4, Offset(_surface_normal+8)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
MOVZ	R25, R2, R0
JAL	_sqrt+0
NOP	
SW	R2, Offset(_normal_length+0)(GP)
;render.c,563 :: 		surface_normal[0] = surface_normal[0] / normal_length;
LW	R4, Offset(_surface_normal+0)(GP)
MOVZ	R6, R2, R0
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_surface_normal+0)(GP)
;render.c,564 :: 		surface_normal[1] = surface_normal[1] / normal_length;
LW	R6, Offset(_normal_length+0)(GP)
LW	R4, Offset(_surface_normal+4)(GP)
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_surface_normal+4)(GP)
;render.c,565 :: 		surface_normal[2] = surface_normal[2] / normal_length;
LW	R6, Offset(_normal_length+0)(GP)
LW	R4, Offset(_surface_normal+8)(GP)
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_surface_normal+8)(GP)
;render.c,569 :: 		viewer_position[0] = (window_width / 2);
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_viewer_position+0)(GP)
;render.c,570 :: 		viewer_position[1] = (window_height / 2);
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_viewer_position+4)(GP)
;render.c,571 :: 		viewer_position[2] = (window_width / 2);
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
SW	R2, Offset(_viewer_position+8)(GP)
;render.c,576 :: 		plane_constant = ( surface_normal[0]*viewer_position[0] ) + ( surface_normal[1]*viewer_position[1] ) + ( surface_normal[2]*viewer_position[2] );
LW	R6, Offset(_viewer_position+0)(GP)
LW	R4, Offset(_surface_normal+0)(GP)
JAL	__Mul_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_viewer_position+4)(GP)
LW	R4, Offset(_surface_normal+4)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 36(SP)
LW	R6, Offset(_viewer_position+8)(GP)
LW	R4, Offset(_surface_normal+8)(GP)
JAL	__Mul_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, Offset(_plane_constant+0)(GP)
;render.c,579 :: 		plane_constant = plane_constant - (plane_constant * 2);
LUI	R4, 16384
ORI	R4, R4, 0
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
LW	R4, Offset(_plane_constant+0)(GP)
MOVZ	R6, R2, R0
JAL	__Sub_FP+0
NOP	
SW	R2, Offset(_plane_constant+0)(GP)
;render.c,585 :: 		culled = 0;
SH	R0, Offset(_culled+0)(GP)
;render.c,603 :: 		vertex_color.r = face_color[face][0];
LUI	R4, #hi_addr(_face_color+0)
ORI	R4, R4, #lo_addr(_face_color+0)
LH	R3, Offset(_face+0)(GP)
ORI	R2, R0, 3
MULTU	R2, R3
MFLO	R2
ADDU	R3, R4, R2
LBU	R2, 0(R3)
SB	R2, Offset(_vertex_color+0)(GP)
;render.c,604 :: 		vertex_color.g = face_color[face][1];
ADDIU	R2, R3, 1
LBU	R2, 0(R2)
SB	R2, Offset(_vertex_color+1)(GP)
;render.c,605 :: 		vertex_color.b = face_color[face][2];
ADDIU	R2, R3, 2
LBU	R2, 0(R2)
SB	R2, Offset(_vertex_color+2)(GP)
;render.c,609 :: 		if(face == 0){
LH	R2, Offset(_face+0)(GP)
BEQ	R2, R0, L__drawModel196
NOP	
J	L_drawModel127
NOP	
L__drawModel196:
;render.c,610 :: 		draw_color = TFT_RGBToColor16bit(255, 0, 0);
MOVZ	R27, R0, R0
MOVZ	R26, R0, R0
ORI	R25, R0, 255
JAL	_TFT_RGBToColor16bit+0
NOP	
SH	R2, Offset(_draw_color+0)(GP)
;render.c,611 :: 		}
J	L_drawModel128
NOP	
L_drawModel127:
;render.c,612 :: 		else if(face == 1){
LH	R3, Offset(_face+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__drawModel197
NOP	
J	L_drawModel129
NOP	
L__drawModel197:
;render.c,613 :: 		draw_color = TFT_RGBToColor16bit(0, 255, 0);
MOVZ	R27, R0, R0
ORI	R26, R0, 255
MOVZ	R25, R0, R0
JAL	_TFT_RGBToColor16bit+0
NOP	
SH	R2, Offset(_draw_color+0)(GP)
;render.c,614 :: 		}
J	L_drawModel130
NOP	
L_drawModel129:
;render.c,615 :: 		else if(face == 2){
LH	R3, Offset(_face+0)(GP)
ORI	R2, R0, 2
BEQ	R3, R2, L__drawModel198
NOP	
J	L_drawModel131
NOP	
L__drawModel198:
;render.c,616 :: 		draw_color = TFT_RGBToColor16bit(0, 0, 255);
ORI	R27, R0, 255
MOVZ	R26, R0, R0
MOVZ	R25, R0, R0
JAL	_TFT_RGBToColor16bit+0
NOP	
SH	R2, Offset(_draw_color+0)(GP)
;render.c,617 :: 		}
J	L_drawModel132
NOP	
L_drawModel131:
;render.c,619 :: 		draw_color = TFT_RGBToColor16bit(128, 128, 128);
ORI	R27, R0, 128
ORI	R26, R0, 128
ORI	R25, R0, 128
JAL	_TFT_RGBToColor16bit+0
NOP	
SH	R2, Offset(_draw_color+0)(GP)
;render.c,620 :: 		}
L_drawModel132:
L_drawModel130:
L_drawModel128:
;render.c,623 :: 		if( vertex_face_count[face] == 2){
LUI	R3, #hi_addr(_vertex_face_count+0)
ORI	R3, R3, #lo_addr(_vertex_face_count+0)
LH	R2, Offset(_face+0)(GP)
ADDU	R2, R3, R2
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 2
BEQ	R3, R2, L__drawModel199
NOP	
J	L_drawModel133
NOP	
L__drawModel199:
;render.c,627 :: 		x1 = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 20(SP)
;render.c,628 :: 		y1 = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 24(SP)
;render.c,630 :: 		x2 = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+6)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 28(SP)
;render.c,631 :: 		y2 = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 32(SP)
;render.c,644 :: 		if(  ( ((int)x1 + x_offset) > 5 ) && ( ((int)y1 + y_offset) > 5 ) ){
LW	R4, 20(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_x_offset+0)(GP)
ADDU	R2, R2, R3
ANDI	R2, R2, 65535
SLTIU	R2, R2, 6
BEQ	R2, R0, L__drawModel200
NOP	
J	L__drawModel150
NOP	
L__drawModel200:
LW	R4, 24(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_y_offset+0)(GP)
ADDU	R2, R2, R3
ANDI	R2, R2, 65535
SLTIU	R2, R2, 6
BEQ	R2, R0, L__drawModel201
NOP	
J	L__drawModel149
NOP	
L__drawModel201:
L__drawModel148:
;render.c,645 :: 		TFT_Set_Brush(1, draw_color, 0, LEFT_TO_RIGHT, draw_color, draw_color);
ORI	R28, R0, 1
MOVZ	R27, R0, R0
LHU	R26, Offset(_draw_color+0)(GP)
ORI	R25, R0, 1
LHU	R2, Offset(_draw_color+0)(GP)
ADDIU	SP, SP, -4
SH	R2, 2(SP)
LHU	R2, Offset(_draw_color+0)(GP)
SH	R2, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
;render.c,646 :: 		TFT_Set_Pen(draw_color, 2);
ORI	R26, R0, 2
LHU	R25, Offset(_draw_color+0)(GP)
JAL	_TFT_Set_Pen+0
NOP	
;render.c,650 :: 		TFT_Line((int)x1 + x_offset, (int)y1 + y_offset, (int)x2 + x_offset, (int)y2 + y_offset);
LW	R4, 32(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_y_offset+0)(GP)
ADDU	R2, R2, R3
SH	R2, 44(SP)
LW	R4, 28(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_x_offset+0)(GP)
ADDU	R2, R2, R3
SH	R2, 40(SP)
LW	R4, 24(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_y_offset+0)(GP)
ADDU	R2, R2, R3
SH	R2, 36(SP)
LW	R4, 20(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_x_offset+0)(GP)
ADDU	R3, R2, R3
LHU	R2, 44(SP)
ANDI	R28, R2, 65535
LHU	R2, 40(SP)
ANDI	R27, R2, 65535
LHU	R2, 36(SP)
ANDI	R26, R2, 65535
ANDI	R25, R3, 65535
JAL	_TFT_Line+0
NOP	
;render.c,651 :: 		TFT_Circle((int)x1 + x_offset, (int)y1 + y_offset, 5);  //default circle size 5
LW	R4, 24(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_y_offset+0)(GP)
ADDU	R2, R2, R3
SH	R2, 36(SP)
LW	R4, 20(SP)
JAL	__FloatToSignedIntegral+0
NOP	
LHU	R3, Offset(_x_offset+0)(GP)
ADDU	R3, R2, R3
ORI	R27, R0, 5
LHU	R2, 36(SP)
ANDI	R26, R2, 65535
ANDI	R25, R3, 65535
JAL	_TFT_Circle+0
NOP	
;render.c,653 :: 		}
J	L_drawModel137
NOP	
;render.c,644 :: 		if(  ( ((int)x1 + x_offset) > 5 ) && ( ((int)y1 + y_offset) > 5 ) ){
L__drawModel150:
L__drawModel149:
;render.c,656 :: 		TFT_Fill_Screen(CL_RED);
ORI	R25, R0, 63488
JAL	_TFT_Fill_Screen+0
NOP	
;render.c,657 :: 		Delay_ms(1000);
LUI	R24, 406
ORI	R24, R24, 59050
L_drawModel138:
ADDIU	R24, R24, -1
BNE	R24, R0, L_drawModel138
NOP	
;render.c,658 :: 		}
L_drawModel137:
;render.c,663 :: 		}
J	L_drawModel140
NOP	
L_drawModel133:
;render.c,664 :: 		else if( vertex_face_count[face] == 3){
LUI	R3, #hi_addr(_vertex_face_count+0)
ORI	R3, R3, #lo_addr(_vertex_face_count+0)
LH	R2, Offset(_face+0)(GP)
ADDU	R2, R3, R2
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 3
BEQ	R3, R2, L__drawModel202
NOP	
J	L_drawModel141
NOP	
L__drawModel202:
;render.c,668 :: 		x1 = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 20(SP)
;render.c,669 :: 		y1 = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 24(SP)
;render.c,671 :: 		x2 = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+6)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 28(SP)
;render.c,672 :: 		y2 = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 32(SP)
;render.c,692 :: 		}
J	L_drawModel142
NOP	
L_drawModel141:
;render.c,693 :: 		else if( vertex_face_count[face] == 4){
LUI	R3, #hi_addr(_vertex_face_count+0)
ORI	R3, R3, #lo_addr(_vertex_face_count+0)
LH	R2, Offset(_face+0)(GP)
ADDU	R2, R3, R2
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 4
BEQ	R3, R2, L__drawModel203
NOP	
J	L_drawModel143
NOP	
L__drawModel203:
;render.c,695 :: 		x1 = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+0)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 20(SP)
;render.c,696 :: 		y1 = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 24(SP)
;render.c,698 :: 		x2 = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
LH	R2, Offset(_current_polygon_vertices+6)(GP)
SLL	R3, R2, 4
LUI	R2, #hi_addr(_point_out+0)
ORI	R2, R2, #lo_addr(_point_out+0)
ADDU	R2, R2, R3
SW	R2, 40(SP)
LW	R2, 0(R2)
SW	R2, 36(SP)
LW	R4, Offset(_window_width+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 28(SP)
;render.c,699 :: 		y2 = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));
LW	R2, 40(SP)
ADDIU	R2, R2, 4
LW	R3, 0(R2)
LUI	R2, 32768
XOR	R2, R3, R2
SW	R2, 36(SP)
LW	R4, Offset(_window_height+0)(GP)
LUI	R6, 16384
ORI	R6, R6, 0
JAL	__Div_FP+0
NOP	
LW	R4, 36(SP)
MOVZ	R6, R2, R0
JAL	__Add_FP+0
NOP	
SW	R2, 32(SP)
;render.c,723 :: 		}
L_drawModel143:
L_drawModel142:
L_drawModel140:
;render.c,726 :: 		} //end if culled
;render.c,503 :: 		for(face=0;face<number_of_faces-1;face++){
LH	R2, Offset(_face+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_face+0)(GP)
;render.c,729 :: 		}//face
J	L_drawModel117
NOP	
L_drawModel118:
;render.c,731 :: 		} //end drawModel function
L_end_drawModel:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 48
JR	RA
NOP	
; end of _drawModel
_sgn:
;render.c,735 :: 		int sgn( float value){
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;render.c,737 :: 		if (value > 0) return 1;
MOVZ	R4, R0, R0
MOVZ	R6, R25, R0
JAL	__Compare_FP+0
NOP	
SLTI	R2, R2, 0
BNE	R2, R0, L__sgn207
NOP	
J	L_sgn144
NOP	
L__sgn207:
ORI	R2, R0, 1
J	L_end_sgn
NOP	
L_sgn144:
;render.c,738 :: 		else if (value < 0) return -1;
MOVZ	R4, R0, R0
MOVZ	R6, R25, R0
JAL	__Compare_FP+0
NOP	
SLT	R2, R0, R2
BNE	R2, R0, L__sgn210
NOP	
J	L_sgn146
NOP	
L__sgn210:
ORI	R2, R0, 65535
J	L_end_sgn
NOP	
L_sgn146:
;render.c,739 :: 		else return 0;
MOVZ	R2, R0, R0
;render.c,741 :: 		}
L_end_sgn:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _sgn
