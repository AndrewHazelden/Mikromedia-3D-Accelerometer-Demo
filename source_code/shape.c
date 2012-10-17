// ------------------------------------------------------
// Shape File: axis.obj
// Date: 05/02/2012
// ------------------------------------------------------

//Don't forget to update the geometry definitions for face and vertex count:
#include "shape_def.h"

//------------------------
//                        
// Vertices from obj file.
//                        
//------------------------

float point_in[number_of_vertices][4]= {
{ 0.000000, 0.000000, 0.000000 },
{ 1.000000, 0.000000, 0.000000 },
{ 0.000000, 1.000000, 0.000000 },
{ 0.000000, 0.000000, 0.000000 },
{ 0.000000, 0.000000, 1.000000 },
{ 0.000000, 0.000000, 0.000000 },
};



//------------------------
//                        
//Faces from obj file.    
//                        
//------------------------

//note obj vertex faces are off by one
//ie. The .obj face vertex 1 is actually vertex 0 in c-code.
//unsigned short data type limits total polygon face count to 255

const unsigned short polygon_faces[number_of_faces][number_of_polgon_sides][3]= {
{ { 2, 2, 2 }, { 1, 1, 1 }, },
{ { 3, 3, 3 }, { 4, 4, 4 }, },
{ { 5, 5, 5 }, { 6, 6, 6 }, },
};

//array to define how many vertices are on the polygon face
const unsigned short vertex_face_count[number_of_faces]={
2,2,2
};


//------------------------
//                        
//Faces Colors 
//                   
//------------------------
 
// with an 8 bit RGB color per polygon face  

unsigned short face_color[number_of_faces][3]={
{ 255, 0, 0 }, { 0, 255, 0 }, { 0, 0, 255 },{ 0, 0, 255 },
};

