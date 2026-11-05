# 3D-model-homework
正在做了TVT

# Computer Graphics - Lab 1

## Completed Tasks
- **`CGLine`**: Implemented Bresenham's line algorithm.
- **`CGCircle`**: Implemented Midpoint circle algorithm with 8-way symmetry.
- **`CGEllipse`**: Implemented Midpoint ellipse algorithm with Region 1/2 and 4-way symmetry.
- **`CGCurve`**: Implemented Cubic Bézier curve via parametric interpolation ($t \in [0, 1]$).
- **`CGEraser`**: Implemented rectangular area clearing to background color `color(250)`.

## Implementation Summary
- Used integer-based incremental error updates for lines and midpoint algorithms to ensure precision and performance.
- Leveraged symmetry properties for circles and ellipses to optimize pixel plotting.
- Evaluated $1,000$ discrete steps for smooth Bézier curve rendering.
