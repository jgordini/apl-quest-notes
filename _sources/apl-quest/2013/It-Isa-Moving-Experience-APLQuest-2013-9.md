
# APL Quest: Average Calculation Over Sub-Periods

Hi and welcome to the APL Quest see the APL wiki for details! Today, we're looking at the ninth problem from the 2013 round of the APL Problem Solving Competition. The task is to find the average over a selected sub-period of a year's worth of data.

## Problem Overview

We start with some data represented as cells. The obvious approach here is to use n-wise reduction, and one of the simplest ways to visualize this is through additive reduction using concatenation.

### Visualizing n-wise Reduction

Suppose we have sales data. We can perform a three-wise reduction of the sales by concatenating groups of three elements, which provides us with small windows. Our goal is to calculate the average of each window. The idiomatic APL expression for an average is the sum divided by the length:

```apl
avgSales ← { (+/⍵) ÷ (≢⍵) }
```

However, we can also consider a naive solution to generate moving averages for a month of data:

```apl
naiveAvg ← (÷⌿÷≢)¨,/
```

Here, although this provides the basic functionality, it is not the most efficient.

## Improving the Approach

The initial solution computes the average by summing three elements and dividing by three repeatedly. A better approach is:

```apl
improvedAvg ← { (+/⍵) ÷ 3 }
```

We can express the moving average using a tacit equivalent:

```apl
tacitAvg ← +⌿÷⊣
```

We also need to ensure that our function can handle varying input sizes properly.

### Clamping Input Size

An interesting edge case to consider is when the window size exceeds the data size, such as window sizes greater than twelve months. For instance, using a window size of thirteen gives us no averages, while a window size of fourteen generates an error.

To handle this, we can clamp the left argument (the window size) to ensure it never exceeds the length of the sales data (thirteen):

```apl
clampedAvg ← {((⍺⌊13)+⌿⍵)÷⍺⌊13}
```

### Generalized Solutions

We might also prefer a more generalized solution that dynamically adjusts based on the length of the input. By adding one to the length of the sales data, we can create a more universal approach that handles varying element counts effectively:

```apl
generalizedAvg ← {((⍺⌊1+≢⍵)+⌿⍵)÷⍺}
```

Another method could involve error handling. In this scenario, we compute the average as before, but if the window size fails due to being too large, we catch the error and return an empty vector:

```apl
errorHandledAvg ← { 5::⍬ ⋄ ⍺÷⍨⍺+/⍵ }
```

## Advanced Error Handling

For those who prefer an explicit approach, we can test our inputs by asserting conditions before performing operations. This method checks if the left argument exceeds the length of the right argument:

```apl
safeAvg ← { 
    ⍺>≢⍵:⍬ ⋄ ⍺÷⍨⍺+/⍵
}
```

This solution eliminates reliance on catching errors and simplifies maintenance and understanding.

### Maintaining Data Shape

When handling cases where the input size is too large, it is essential to keep the shape of the output consistent. If we encounter a situation where the left argument is too large, we should return a zero-row table instead of an empty vector:

```apl
shapePreservingAvg ← { 
    ⍺>≢⍵:0⌿⍵ ⋄ ⍺÷⍨⍺+/⍵
}
```

This ultimate solution ensures that our averages are calculated accurately while maintaining the intended structure of the data.

## Conclusion

In this article, we've explored various strategies to compute the average over a sub-period effectively in APL. From basic methods to refined solutions that handle edge cases efficiently, there are multiple ways to approach this problem. Thank you for reading, and happy coding!
