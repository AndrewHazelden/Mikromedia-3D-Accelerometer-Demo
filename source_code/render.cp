#line 1 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
#line 1 "c:/documents and settings/pc/desktop/mini3d/mikroc source code/shape_def.h"
#line 1 "c:/documents and settings/pc/desktop/mini3d/mikroc source code/shape.h"
#line 1 "c:/documents and settings/pc/desktop/mini3d/mikroc source code/shape_def.h"
#line 3 "c:/documents and settings/pc/desktop/mini3d/mikroc source code/shape.h"
extern float point_in[ 6 ][4];
extern const unsigned short polygon_faces[ 4 ][ 4 ][3];
extern const unsigned short vertex_face_count[ 4 ];
extern const unsigned short face_color[ 4 ][3];
#line 15 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
int current_polygon_vertices[ 4 ][3];

int face=0;
int vertex_point=0;
int xyz_point=0;



float point_out[ 6 ][4];



float screen_point[2];




unsigned int x_offset= 0;
unsigned int y_offset= 10;


float scale_matrix[4][4];

float rotate_x_matrix[4][4];
float rotate_y_matrix[4][4];
float rotate_z_matrix[4][4];

float translation_matrix[4][4];

float scale_product_matrix[4][4];
float rotate_x_product_matrix[4][4];
float rotate_y_product_matrix[4][4];
float rotate_z_product_matrix[4][4];

float perspective_matrix[4][4];


float pi = 3.141592654;


struct object_color{
 char r;
 char g;
 char b;
 } vertex_color;

unsigned int draw_color = 0;






struct trans_xform{
 float x;
 float y;
 float z;
 } translate;

struct rot_xform{
 float x;
 float y;
 float z;
 } rotate;


struct scl_xform{
 float x;
 float y;
 float z;
 }scale;



float horizontal_field_of_view;
float vertical_field_of_view;

float horizontal_perspective_compensation;
float vertical_perspective_compensation;


int vertex = 0;



float side_one[2];
float side_two[2];

float surface_normal[3];
float viewer_position[3];

float plane_constant = 0;
float normal_length = 0;


float cull_x[3];
float cull_y[3];
float cull_z[3];


int culled = 0;








float window_width = 320;
float window_height = 240;
#line 137 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
void initVariables(void);
void computeXform(void);
void drawModel(void);
int sgn( float value);









 void initVariables(void){


translate.x = 0.0;
translate.y = 0.0;
translate.z = 0.0;


rotate.x = 0.0;
rotate.y = 45.0;
rotate.z = 0.0;



scale.x = 30.0;
scale.y = 30.0;
scale.z = 30.0;




horizontal_field_of_view = 50 * (pi / 180);
vertical_field_of_view = 50 * (pi / 180);


horizontal_perspective_compensation = (window_width / 2) / 1000;
vertical_perspective_compensation = (window_height / 2) / 1000;




 }









void computeXform(void){


int product_column = 0;
int product_row = 0;
int shift = 0;
int increment=0;
int vtx = 0;
int row = 0;
int column;


for(vtx=0;vtx<= 6 -1;vtx++){
for(row=0;row<=3;row++){
point_out[vtx][row] = 0;
}
}




for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
scale_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
scale_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
rotate_x_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
rotate_y_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
rotate_z_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
translation_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
scale_product_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
rotate_x_product_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
rotate_y_product_matrix[column][row] = 0;
}
}


for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
rotate_z_product_matrix[column][row] = 0;
}
}

for(column=0;column<=3;column++){
for(row=0;row<=3;row++){
perspective_matrix[column][row] = 0;
}
}




for(column=0;column<= 4 -1;column++){
for(row=0;row<=3;row++){
current_polygon_vertices[column][row] = 0;
}
}




 scale_matrix[0][0] = scale.x;
 scale_matrix[1][0] = 0;
 scale_matrix[2][0] = 0;
 scale_matrix[3][0] = 0;

 scale_matrix[0][1] = 0;
 scale_matrix[1][1] = scale.y;
 scale_matrix[2][1] = 0;
 scale_matrix[3][1] = 0;

 scale_matrix[0][2] = 0;
 scale_matrix[1][2] = 0;
 scale_matrix[2][2] = scale.z;
 scale_matrix[3][2] = 0;

 scale_matrix[0][3] = 0;
 scale_matrix[1][3] = 0;
 scale_matrix[2][3] = 0;
 scale_matrix[3][3] = 1;




 rotate_z_matrix[0][0] = cos( rotate.z * (pi / 180) );
 rotate_z_matrix[1][0] = sin( rotate.z * (pi / 180) );
 rotate_z_matrix[2][0] = 0;
 rotate_z_matrix[3][0] = 0;

 rotate_z_matrix[0][1] = -sin( rotate.z * (pi / 180) );
 rotate_z_matrix[1][1] = cos( rotate.z * (pi / 180) );
 rotate_z_matrix[2][1] = 0;
 rotate_z_matrix[3][1] = 0;

 rotate_z_matrix[0][2] = 0;
 rotate_z_matrix[1][2] = 0;
 rotate_z_matrix[2][2] = 1;
 rotate_z_matrix[3][2] = 0;

 rotate_z_matrix[0][3] = 0;
 rotate_z_matrix[1][3] = 0;
 rotate_z_matrix[2][3] = 0;
 rotate_z_matrix[3][3] = 1;


 rotate_y_matrix[0][0] = cos( rotate.y * (pi / 180) );
 rotate_y_matrix[1][0] = 0;
 rotate_y_matrix[2][0] = -sin( rotate.y * (pi / 180) );
 rotate_y_matrix[3][0] = 0;

 rotate_y_matrix[0][1] = 0;
 rotate_y_matrix[1][1] = 1;
 rotate_y_matrix[2][1] = 0;
 rotate_y_matrix[3][1] = 0;

 rotate_y_matrix[0][2] = sin( rotate.y * (pi / 180) );
 rotate_y_matrix[1][2] = 0;
 rotate_y_matrix[2][2] = cos( rotate.y * (pi / 180) );
 rotate_y_matrix[3][2] = 0;

 rotate_y_matrix[0][3] = 0;
 rotate_y_matrix[1][3] = 0;
 rotate_y_matrix[2][3] = 0;
 rotate_y_matrix[3][3] = 1;


 rotate_x_matrix[0][0] = 1;
 rotate_x_matrix[1][0] = 0;
 rotate_x_matrix[2][0] = 0;
 rotate_x_matrix[3][0] = 0;

 rotate_x_matrix[0][1] = 0;
 rotate_x_matrix[1][1] = cos( rotate.x * (pi / 180) );
 rotate_x_matrix[2][1] = sin( rotate.x * (pi / 180) );
 rotate_x_matrix[3][1] = 0;

 rotate_x_matrix[0][2] = 0;
 rotate_x_matrix[1][2] = -sin( rotate.x * (pi / 180) );
 rotate_x_matrix[2][2] = cos( rotate.x * (pi / 180) );
 rotate_x_matrix[3][2] = 0;

 rotate_x_matrix[0][3] = 0;
 rotate_x_matrix[1][3] = 0;
 rotate_x_matrix[2][3] = 0;
 rotate_x_matrix[3][3] = 1;


 translation_matrix[0][0] = 1;
 translation_matrix[1][0] = 0;
 translation_matrix[2][0] = 0;
 translation_matrix[3][0] = 0;

 translation_matrix[0][1] = 0;
 translation_matrix[1][1] = 1;
 translation_matrix[2][1] = 0;
 translation_matrix[3][1] = 0;

 translation_matrix[0][2] = 0;
 translation_matrix[1][2] = 0;
 translation_matrix[2][2] = 1;
 translation_matrix[3][2] = 0;

 translation_matrix[0][3] = translate.x;
 translation_matrix[1][3] = translate.y;
 translation_matrix[2][3] = translate.z;
 translation_matrix[3][3] = 1;



 perspective_matrix[0][0] = horizontal_field_of_view;
 perspective_matrix[1][0] = 0;
 perspective_matrix[2][0] = 0;
 perspective_matrix[3][0] = 0;

 perspective_matrix[0][1] = 0;
 perspective_matrix[1][1] = vertical_field_of_view;
 perspective_matrix[2][1] = 0;
 perspective_matrix[3][1] = 0;

 perspective_matrix[0][2] = 0;
 perspective_matrix[1][2] = 0;
 perspective_matrix[2][2] = 1;
 perspective_matrix[3][2] = 1;

 perspective_matrix[0][3] = 0;
 perspective_matrix[1][3] = 0;
 perspective_matrix[2][3] = 0;
 perspective_matrix[3][3] = 0;



 for (product_column = 0;product_column<=3;product_column++){
 for (product_row = 0;product_row<=3;product_row++){
 for (shift = 0;shift<=3;shift++){
 rotate_x_product_matrix[product_column][product_row] = rotate_x_product_matrix[product_column][product_row] + ( translation_matrix[shift][product_row] * rotate_x_matrix[product_column][shift] );
 }
 }
}


 for (product_column = 0;product_column<=3;product_column++){
 for (product_row = 0;product_row<=3;product_row++){
 for (shift = 0;shift<=3;shift++){
 rotate_y_product_matrix[product_column][product_row] = rotate_y_product_matrix[product_column][product_row] + (rotate_x_product_matrix[shift][product_row] * rotate_y_matrix[product_column][shift] );
 }
 }
}


 for (product_column = 0;product_column<=3;product_column++){
 for (product_row = 0;product_row<=3;product_row++){
 for (shift = 0;shift<=3;shift++){
 rotate_z_product_matrix[product_column][product_row] = rotate_z_product_matrix[product_column][product_row] + (rotate_y_product_matrix[shift][product_row] * rotate_z_matrix[product_column][shift] );
 }
 }
}


 for (product_column = 0;product_column<=3;product_column++){
 for (product_row = 0;product_row<=3;product_row++){
 for (shift = 0;shift<=3;shift++){
 scale_product_matrix[product_column][product_row] = scale_product_matrix[product_column][product_row] + (rotate_z_product_matrix[shift][product_row] * scale_matrix[product_column][shift] );
 }
 }
}








for(vertex=0;vertex<= 6 -1;vertex++){







point_out[vertex][0] = ( scale_product_matrix[0][0] * point_in[vertex][0] ) + ( scale_product_matrix[0][1] * point_in[vertex][1] ) + ( scale_product_matrix[0][2] * point_in[vertex][2] ) + ( scale_product_matrix[0][3] * point_in[vertex][3] );
point_out[vertex][1] = ( scale_product_matrix[1][0] * point_in[vertex][0] ) + ( scale_product_matrix[1][1] * point_in[vertex][1] ) + ( scale_product_matrix[1][2] * point_in[vertex][2] ) + ( scale_product_matrix[1][3] * point_in[vertex][3] );
point_out[vertex][2] = ( scale_product_matrix[2][0] * point_in[vertex][0] ) + ( scale_product_matrix[2][1] * point_in[vertex][1] ) + ( scale_product_matrix[2][2] * point_in[vertex][2] ) + ( scale_product_matrix[2][3] * point_in[vertex][3] );
point_out[vertex][3] = ( scale_product_matrix[3][0] * point_in[vertex][0] ) + ( scale_product_matrix[3][1] * point_in[vertex][1] ) + ( scale_product_matrix[3][2] * point_in[vertex][2] ) + ( scale_product_matrix[3][3] * point_in[vertex][3] );



}


}








void drawModel(){
float x1,y1,x2,y2,x3,y3,x4,y4;


int product_column = 0;
int product_row = 0;
int shift = 0;
int increment=0;
int vtx = 0;
int row = 0;
int column;


for(face=0;face< 4 -1;face++){


for(column=0;column<= 4 -1;column++){
for(row=0;row<=3;row++){




current_polygon_vertices[column][row] = polygon_faces[face][column][row]-1;

}
}





 cull_x[0] = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
 cull_y[0] = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));
 cull_z[0] = (-point_out[ current_polygon_vertices[0][0] ][2] );



 cull_x[1] = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
 cull_y[1] = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));
 cull_z[1] = (-point_out[ current_polygon_vertices[1][0] ][2]);


 cull_x[2] = (point_out[ current_polygon_vertices[2][0] ][0] + (window_width / 2));
 cull_y[2] = (-point_out[ current_polygon_vertices[2][0] ][1] + (window_height / 2));
 cull_z[2] = (-point_out[ current_polygon_vertices[2][0] ][2] );






 side_one[0] = cull_x[1] - cull_x[0];
 side_one[1] = cull_y[1] - cull_y[0];
 side_one[2] = cull_z[1] - cull_z[0];

 side_two[0] = cull_x[2] - cull_x[1];
 side_two[1] = cull_y[2] - cull_y[1];
 side_two[2] = cull_z[2] - cull_z[1];





 surface_normal[0] = ( ( side_one[1] * side_two[2] ) - ( side_one[2] * side_two[1] ) );
 surface_normal[1] = ( ( side_one[2] * side_two[0] ) - ( side_one[0] * side_two[2] ) );
 surface_normal[2] = ( ( side_one[0] * side_two[1] ) - ( side_one[1] * side_two[0] ) );



 normal_length = sqrt( (surface_normal[0] * surface_normal[0]) + (surface_normal[1] * surface_normal[1]) + (surface_normal[2] * surface_normal[2]) );



 surface_normal[0] = surface_normal[0] / normal_length;
 surface_normal[1] = surface_normal[1] / normal_length;
 surface_normal[2] = surface_normal[2] / normal_length;



 viewer_position[0] = (window_width / 2);
 viewer_position[1] = (window_height / 2);
 viewer_position[2] = (window_width / 2);




 plane_constant = ( surface_normal[0]*viewer_position[0] ) + ( surface_normal[1]*viewer_position[1] ) + ( surface_normal[2]*viewer_position[2] );


 plane_constant = plane_constant - (plane_constant * 2);





 culled = 0;
#line 599 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
 if(culled == 0){



 vertex_color.r = face_color[face][0];
 vertex_color.g = face_color[face][1];
 vertex_color.b = face_color[face][2];



 if(face == 0){
 draw_color = TFT_RGBToColor16bit(255, 0, 0);
 }
 else if(face == 1){
 draw_color = TFT_RGBToColor16bit(0, 255, 0);
 }
 else if(face == 2){
 draw_color = TFT_RGBToColor16bit(0, 0, 255);
 }
 else{
 draw_color = TFT_RGBToColor16bit(128, 128, 128);
 }


 if( vertex_face_count[face] == 2){



 x1 = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
 y1 = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));

 x2 = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
 y2 = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));
#line 644 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
 if( ( ((int)x1 + x_offset) > 5 ) && ( ((int)y1 + y_offset) > 5 ) ){
 TFT_Set_Brush(1, draw_color, 0, LEFT_TO_RIGHT, draw_color, draw_color);
 TFT_Set_Pen(draw_color, 2);



 TFT_Line((int)x1 + x_offset, (int)y1 + y_offset, (int)x2 + x_offset, (int)y2 + y_offset);
 TFT_Circle((int)x1 + x_offset, (int)y1 + y_offset, 5);

 }
 else{

 TFT_Fill_Screen(CL_RED);
 Delay_ms(1000);
 }




 }
 else if( vertex_face_count[face] == 3){



 x1 = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
 y1 = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));

 x2 = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
 y2 = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));

 x3 = (point_out[ current_polygon_vertices[2][0] ][0] + (window_width / 2));
 y3 = (-point_out[ current_polygon_vertices[2][0] ][1] + (window_height / 2));
#line 692 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
 }
 else if( vertex_face_count[face] == 4){

 x1 = (point_out[ current_polygon_vertices[0][0] ][0] + (window_width / 2));
 y1 = (-point_out[ current_polygon_vertices[0][0] ][1] + (window_height / 2));

 x2 = (point_out[ current_polygon_vertices[1][0] ][0] + (window_width / 2));
 y2 = (-point_out[ current_polygon_vertices[1][0] ][1] + (window_height / 2));

 x3 = (point_out[ current_polygon_vertices[2][0] ][0] + (window_width / 2));
 y3 = (-point_out[ current_polygon_vertices[2][0] ][1] + (window_height / 2));

 x4 = (point_out[ current_polygon_vertices[3][0] ][0] + (window_width / 2));
 y4 = (-point_out[ current_polygon_vertices[3][0] ][1] + (window_height / 2));
#line 723 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/render.c"
 }


 }


}

 }



int sgn( float value){

 if (value > 0) return 1;
 else if (value < 0) return -1;
 else return 0;

}
