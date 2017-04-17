//-----------------------------------------------------------------------------
// Torque Game Engine
// Copyright (C) GarageGames.com, Inc.
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Ray to triangle intersection test code originally by Tomas Akenine-Möller
// and Ben Trumbore.
// http://www.cs.lth.se/home/Tomas_Akenine_Moller/code/
// Ported to TGE by DAW, 2005-7-15
//-----------------------------------------------------------------------------

#ifndef _TRIRAYCHECK_H_
#define _TRIRAYCHECK_H_

#include "math/mPoint.h"

bool intersect_triangle(Point3F orig, Point3F dir,
                   Point3F vert0, Point3F vert1, Point3F vert2,
                   F32& t, F32& u, F32& v);

//*** Taken from TSE, but based on the above
bool castRayTriangle(Point3F orig, Point3F dir, Point3F vert0, Point3F vert1, Point3F vert2, F32 &t, Point2F &bary);

#endif // _TRIRAYCHECK_H_
