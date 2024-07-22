
# Welcome to the APL Quest

## Today's Quest

Today’s quest invites us to imagine two circles touching each other. One of these circles remains stationary while the other rolls along the surface of the stationary circle until it returns to its starting point. The challenge is to determine the number of turns the rolling circle must complete around itself to return to the initial orientation, depending on the sizes of the two circles. 

This problem comes from the seventh challenge of the 2014 round of the APL problems discussed on *The Conversation*.

## Understanding the Problem

As the rolling circle moves, it may not return to the same orientation as its original position, which depends on the specific sizes of the two circles. The task is to find out how many times the rolling circle must turn around itself in order to both roll around the stationary circle and align in the same direction as it started.

### Simulation Approach

To tackle this problem, we can simulate the rolling motion. Our inputs are the diameters (or circumferences) of the stationary and moving circles. For clarity, we can disregard the fact that they are given in diameters since the circumference is consistently related to the diameter.

To solve the problem, we can track the number of revolutions made by the mobile circle, comparing its total distance traveled with the circumference of the stationary circle. We are aiming to determine when this total distance divided by the stationary circle's circumference results in no remainder, indicating a successful alignment.

### Recursive Solution

To implement this recursively, we can follow these steps:
1. Define a function that takes the two circle sizes as parameters.
2. Initialize a counter for the number of revolutions.
3. If the rolling circle has made enough revolutions to evenly divide the stationary circle’s circumference, return the counter.
4. Otherwise, increment the counter and call the function again.

The following APL code demonstrates a recursive approach to solve the problem:

```apl
R←1{0=⍺|⍺⍺×⍵:⍺⍺ ⋄ ⍺((⍺⍺+1)∇∇)⍵} ⍝ Recursive
```

For example, if we have a stationary circle with a circumference of 10 and a mobile one with a circumference of 5, the rolling circle will complete two revolutions to align correctly. To simulate this for circles with diameters from 1 to 10, we can compute:

```apl
∘.R⍨⍳10
```

### Handling Edge Cases with Zero

An interesting edge case arises with a mobile circle that has a diameter of zero. In that case, it does not physically exist since its point-like nature prevents movement, making it impossible to calculate revolutions. Therefore, if either circle's diameter is zero, we can return zero as our result. 

This can be addressed by modifying our recursive function:

```apl
R←1{0=⍺:0 ⋄ 0=⍺|⍺⍺×⍵:⍺⍺ ⋄ ⍺((⍺⍺+1)∇∇)⍵}
```

### Iterative Solution

An iterative version could also be used, incrementing a counter until our conditions are met. This method is shorter, but slightly more complex because we still need to handle cases where one or both circles have a zero diameter. 

The APL implementation of the iterative version is as follows:

```apl
I←{0=⍺:0 ⋄ 1+⍣(0=⍺|⍵×⊣)0} ⍝ Iterative
```

### Performance Comparison

To compare the performance of the recursive and iterative versions, we can create test cases using different diameters. We should find that the iterative version is faster since it does not involve entering new function contexts repeatedly.

You can compare the performance of the two methods as shown below:

```apl
'cmpx'⎕CY'dfns'
s←0,⍳100
m←⍳100
cmpx's∘.R m' 's∘.I m'
```

### Leveraging Number Theory

We can enhance our solution using number theory. By identifying the greatest common divisor (GCD) or least common multiple (LCM) of the two circles, we can determine how many revolutions are needed more efficiently.

In APL, the implementation for GCD and LCM is:

```apl
G←{⍺÷⍺∨⍵}   ⍝ GCD
L←{(⍺×⍵)÷⍵} ⍝ LCM
```

We can also write them in tacit form:

```apl
G←⊣÷∨
L←∧÷⊢
```

Using these definitions, we can have a performance comparison with the iterative implementation:

```apl
cmpx's∘.I m' 's∘.G m' 's∘.L m'
```

### Final Thoughts

Ultimately, the different approaches yield similar results, although using GCD and LCM calculations is generally more efficient. This exploration not only highlights the beauty of mathematical relationships but also exemplifies the power of different programming paradigms, from recursion to iteration and number theory.

Thank you for joining today’s quest!
