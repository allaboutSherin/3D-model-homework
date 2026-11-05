public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */

    int ix1 = (round(x1));
    int iy1 = (round(y1));
    int ix2 = (round(x2));
    int iy2 = (round(y2));

    int dx = abs(ix2 - ix1);
    int dy = abs(iy2 - iy1);
    int sx = (ix1 < ix2) ? 1 : -1;
    int sy = (iy1 < iy2) ? 1 : -1;
    int err = dx - dy;

    while (true) {
      
        drawPoint(ix1, iy1,g.strokeColor);

        if (ix1 == ix2 && iy1 == iy2) break;

        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            ix1 += sx;
        }
        if (e2 < dx) {
            err += dx;
            iy1 += sy;
        }
    }
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
    int xc = round(x);
    int yc = round(y);
    int radius = round(r);

    int cx = 0;
    int cy = radius;
    int p = 1 - radius;


    drawCirclePoints(xc, yc, cx, cy);

    while (cx < cy) {
        cx++;
        if (p < 0) {
            p += 2 * cx + 1;
        } else {
            cy--;
            p += 2 * (cx - cy) + 1;
        }
        drawCirclePoints(xc, yc, cx, cy);
    }
}


void drawCirclePoints(int xc, int yc, int x, int y) {
    drawPoint(xc + x, yc + y, g.strokeColor);
    drawPoint(xc - x, yc + y, g.strokeColor);
    drawPoint(xc + x, yc - y, g.strokeColor);
    drawPoint(xc - x, yc - y, g.strokeColor);
    drawPoint(xc + y, yc + x, g.strokeColor);
    drawPoint(xc - y, yc + x, g.strokeColor);
    drawPoint(xc + y, yc - x, g.strokeColor);
    drawPoint(xc - y, yc - x, g.strokeColor);
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
    
    int xc = round(x);
    int yc = round(y);
    int rx = round(r1);
    int ry = round(r2);

   int x_coord = 0;
    int y_coord = ry;
    
    long rx2 = (long)rx * rx;
    long ry2 = (long)ry * ry;
    long twoRx2 = 2 * rx2;
    long twoRy2 = 2 * ry2;
    
    long p;
    long px = 0;
    long py = twoRx2 * y_coord;

    drawEllipsePoints(xc, yc, x_coord, y_coord);


    p = round(ry2 - (rx2 * ry) + (0.25f * rx2));
    while (px < py) {
        x_coord++;
        px += twoRy2;
        if (p < 0) {
            p += ry2 + px;
        } else {
            y_coord--;
            py -= twoRx2;
            p += ry2 + px - py;
        }
        drawEllipsePoints(xc, yc, x_coord, y_coord);
    }


    p = round(ry2 * (x_coord + 0.5f) * (x_coord + 0.5f) + rx2 * (y_coord - 1) * (y_coord - 1) - rx2 * ry2);
    while (y_coord > 0) {
        y_coord--;
        py -= twoRx2;
        if (p > 0) {
            p += rx2 - py;
        } else {
            x_coord++;
            px += twoRy2;
            p += rx2 - py + px;
        }
        drawEllipsePoints(xc, yc, x_coord, y_coord);
    }
}


void drawEllipsePoints(int xc, int yc, int x, int y) {
    drawPoint(xc + x, yc + y, g.strokeColor);
    drawPoint(xc - x, yc + y, g.strokeColor);
    drawPoint(xc + x, yc - y, g.strokeColor);
    drawPoint(xc - x, yc - y, g.strokeColor);
}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
    
    int steps = 1000;
    
    for (int i = 0; i <= steps; i++) {
        float t = (float) i / steps;
        

        float u = 1.0f - t;
        float tt = t * t;
        float uu = u * u;
        float uuu = uu * u;
        float ttt = tt * t;
        
        float x = uuu * p1.x + 3 * uu * t * p2.x + 3 * u * tt * p3.x + ttt * p4.x;
        float y = uuu * p1.y + 3 * uu * t * p2.y + 3 * u * tt * p3.y + ttt * p4.y;
        

        drawPoint(round(x), round(y), g.strokeColor);
    }
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    int minX = round(min(p1.x, p2.x));
    int maxX = round(max(p1.x, p2.x));
    int minY = round(min(p1.y, p2.y));
    int maxY = round(max(p1.y, p2.y));


    int eraserColor = color(250);


    for (int x = minX; x <= maxX; x++) {
        for (int y = minY; y <= maxY; y++) {
            drawPoint(x, y, eraserColor);
        }
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
