# APL Quest: Problem Six Overview

Welcome to the APL Quest! Today, we will delve into problem six from the 2015 round of the APL Problem Solving Competition. The task involves checking if two rectangles overlap based on their coordinate pairs. 

## Problem Definition

Given two rectangles defined by coordinate pairs, we need to determine if they overlap. This concept can be challenging to visualize merely through words, so let's illustrate it.

### Coordinate Representation

We have two rectangles which we will label for clarity:

- **Rectangle XY** defined by coordinates \( (x_1, y_1) \) and \( (x_2, y_2) \)
- **Rectangle AB** defined by coordinates \( (a_1, b_1) \) and \( (a_2, b_2) \)

To avoid confusion, instead of using just the traditional \( x \) and \( y \), we will represent one rectangle with a different coordinate system, using \( a \) for the horizontal axis and \( b \) for the vertical axis.

### Visualization

Here is a breakdown of the edges of both rectangles:

- The **left edge** of the XY rectangle is defined by \( x_1 \)
- The **bottom edge** of the XY rectangle is defined by \( y_1 \)
- The **left edge** of the AB rectangle is defined by \( a_1 \)
- The **bottom edge** of the AB rectangle is defined by \( b_1 \)

![Rectangles Illustration](#) *(Illustration of rectangles would go here)*

### Checking Overlaps

To determine if the rectangles overlap, we analyze their edges. For an overlap to occur:

1. The edges \( x_1 \) and \( x_2 \) of rectangle XY must fall between \( a_1 \) and \( a_2 \).
2. Similarly, the edges \( b_1 \) and \( b_2 \) must fall between \( y_1 \) and \( y_2 \).

### Cases of Containment

There could also be a case of containment, where one rectangle is entirely within the boundaries of the other. 

For example:

- If \( a_1 \) is between \( x_1 \) and \( x_2 \) and both \( b_1 \) and \( b_2 \) are between \( y_1 \) and \( y_2 \), the rectangles still overlap.
- Conversely, if you alter the position of rectangle XY so that it no longer intersects rectangle AB, it would indicate no overlap.

### Coding Implementation

Now that we understand the geometric relationships and conditions for overlap, we will translate this into code. 

```apl
    a = (0, 2), (5, 9)
    xy1 = (4, 0), (11, 3)
    xy0 = (0, 13), (3)
```

### Building The Function

We'll create a function that tests for overlaps. The basic structure involves checking both the horizontal and vertical conditions independently. Here's a simplified version:

```apl
function overlap(a, b) {
    # Check if horizontal edges overlap
    horizontal_overlap = (max(a1) > min(x1)) and (min(a2) < max(x2))
    vertical_overlap = (max(b1) > min(y1)) and (min(b2) < max(y2))
    
    return horizontal_overlap and vertical_overlap
}
```

This function checks both conditions, ensuring that at least one edge of each rectangle is within the bounds of the other.

### Optimization and Performance

Through various methods of solution implementation, we can see performance can vary significantly. We aim to produce an efficient function that manages to do this check with minimal computational overhead.

In conclusion, while our initial implementation based on direct rectangle comparisons may be slower, alternative approaches focusing on matrix operations and logical reductions provide promising results.

Thank you for following along with our analysis of this problem in the APL Quest CAPL Wiki! Happy coding!