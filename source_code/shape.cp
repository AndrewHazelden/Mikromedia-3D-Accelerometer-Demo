#line 1 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/shape.c"
#line 1 "c:/documents and settings/pc/desktop/mini3d/mikroc source code/shape_def.h"
#line 15 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/shape.c"
float point_in[ 6 ][4]= {
{ 0.000000, 0.000000, 0.000000 },
{ 1.000000, 0.000000, 0.000000 },
{ 0.000000, 1.000000, 0.000000 },
{ 0.000000, 0.000000, 0.000000 },
{ 0.000000, 0.000000, 1.000000 },
{ 0.000000, 0.000000, 0.000000 },
};
#line 36 "C:/Documents and Settings/PC/Desktop/mini3D/mikroC source code/shape.c"
const unsigned short polygon_faces[ 4 ][ 4 ][3]= {
{ { 2, 2, 2 }, { 1, 1, 1 }, },
{ { 3, 3, 3 }, { 4, 4, 4 }, },
{ { 5, 5, 5 }, { 6, 6, 6 }, },
};


const unsigned short vertex_face_count[ 4 ]={
2,2,2
};










unsigned short face_color[ 4 ][3]={
{ 255, 0, 0 }, { 0, 255, 0 }, { 0, 0, 255 },{ 0, 0, 255 },
};
