public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
    int x = Math.round(x1);
    int y = Math.round(y1);
    int endX = Math.round(x2);
    int endY = Math.round(y2);

    int dx = Math.abs(endX - x);
    int dy = Math.abs(endY - y);
    int sx = (x < endX) ? 1 : -1;
    int sy = (y < endY) ? 1 : -1;
    int err = dx - dy;

    while (true) {
        drawPoint(x, y, color(0));
        if (x == endX && y == endY) break;
        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x += sx;
        }
        if (e2 < dx) {
            err += dx;
            y += sy;
        }
    }
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.
    boolean inside = false;
    int j = vertexes.length - 1;

    for (int i = 0; i < vertexes.length; i++) {
        float xi = vertexes[i].x;
        float yi = vertexes[i].y;
        float xj = vertexes[j].x;
        float yj = vertexes[j].y;

        if ((yi > y) != (yj > y)) {
            float intersectX = (xj - xi) * (y - yi) / (yj - yi) + xi;
            if (x < intersectX) {
                inside = !inside;
            }
        }
        j = i;
    }

    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2
    if (v == null || v.length == 0) {
        return new Vector3[]{ new Vector3(0, 0, 0), new Vector3(-1, -1, 0) };
    }

    Vector3 recordminV = new Vector3(v[0].x, v[0].y, 0);
    Vector3 recordmaxV = new Vector3(v[0].x, v[0].y, 0);

    for (int i = 1; i < v.length; i++) {
        if (v[i].x < recordminV.x) recordminV.x = v[i].x;
        if (v[i].y < recordminV.y) recordminV.y = v[i].y;
        if (v[i].x > recordmaxV.x) recordmaxV.x = v[i].x;
        if (v[i].y > recordmaxV.y) recordmaxV.y = v[i].y;
    }

    Vector3[] result = { recordminV, recordmaxV };
    return result;
}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.
    for (int i = 0; i < boundary.length; i++) {
        output.clear();
        if (input.size() == 0) break;

        Vector3 a = boundary[i];
        Vector3 b = boundary[(i + 1) % boundary.length];

        Vector3 S = input.get(input.size() - 1);
        for (int j = 0; j < input.size(); j++) {
            Vector3 E = input.get(j);

            if (isInside(E, a, b)) {
                if (!isInside(S, a, b)) {
                    output.add(getIntersection(S, E, a, b));
                }
                output.add(E);
            } else if (isInside(S, a, b)) {
                output.add(getIntersection(S, E, a, b));
            }
            S = E;
        }

        // 把這一輪裁切完的結果，當作下一條邊裁切的輸入
        input = new ArrayList<Vector3>(output);
    }

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

// 輔助函式 1：用外積判斷點 p 是否在裁切邊 a->b 的內側（順時針邊界用 <= 0）
public boolean isInside(Vector3 p, Vector3 a, Vector3 b) {
    float cross = (b.x - a.x) * (p.y - a.y) - (b.y - a.y) * (p.x - a.x);
    return cross <= 0;
}

// 輔助函式 2：求線段 SE 與裁切邊 AB 的交點
public Vector3 getIntersection(Vector3 s, Vector3 e, Vector3 a, Vector3 b) {
    float A1 = e.y - s.y;
    float B1 = s.x - e.x;
    float C1 = A1 * s.x + B1 * s.y;

    float A2 = b.y - a.y;
    float B2 = a.x - b.x;
    float C2 = A2 * a.x + B2 * a.y;

    float det = A1 * B2 - A2 * B1;
    float x = (B2 * C1 - B1 * C2) / det;
    float y = (A1 * C2 - A2 * C1) / det;
    return new Vector3(x, y, 0);
}
