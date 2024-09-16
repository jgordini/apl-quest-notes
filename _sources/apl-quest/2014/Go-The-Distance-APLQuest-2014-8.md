
# Go The Distance 2014-8 

Today's quest is the eighth from the 2014 round of the APL problems of solving competition, where we are tasked with computing the distance between two points in n-dimensional space. 

This is really a very simple problem. The distance is calculated as the square root (specifically, raising the sum of the squares of the differences along each dimension to the power of half). 

### Testing in Different Dimensions

To illustrate this, we can start with a case in 2D space, and then try it in 4D space as well. We could consider points defined as \( u_1 \), \( v_1 \), and \( u_2 \), \( v_2 \). This really solves the problem, and there's not much variation one would want to make here. 

In APL, we can define a function to calculate the distance as follows:

```apl
A←{0.5*⍨+/2*⍨⍺-⍵}
```

Now we can test this function with points in 2D space:

```apl
u1←2 2 ⋄ v1←5 6
u1 A v1  ⍝ distance between u1 and v1
```

And points in 4D space:

```apl
u2←2 2 3 4 ⋄ v2←3 7 10 9
u2 A v2  ⍝ distance between u2 and v2
```

We can also compute the distance between vectors combined along their respective dimensions:

```apl
(↑u1 u2)(↑v1 v2) ⍝ combine u1, u2 and v1, v2
(↑u1 u2)A(↑v1 v2)  ⍝ calculate distance for combined points
```

### Handling Points with Different Dimensions

Suppose we have a collection of points, but not all points have the same number of dimensions. When we attempt to mix them into a flat matrix, padding with zeros on the right occurs. However, this isn't a problem because when we compute the square of zero for any dimension, it doesn't contribute to the final result. This means we can upgrade all points to the dimensionality of the point with the highest number of dimensions.

We can define a function to handle this case as follows:

```apl
B←0.5*⍨1⊥2*⍨-
```

Testing points in this way:

```apl
u1 B v1 ⍝ calculate distance using B
(↑u1 u2)B(↑v1 v2)  ⍝ distance calculation for combined dimensions
```

### Code Golfing

Let's add some excitement by attempting some code golf. Here, we can reduce the unnecessary zero from our exponentiation, which decreases readability but saves a character. Furthermore, summing squares can be recognized as summing self-multiplications.

We might express this as summing self-multiplications but need to ensure proper syntax when applying magnetic functions on static functions. Placing it on top typically maintains performance equivalence. 

In our last attempt, we’ll direct subtract twice, which, while wasteful, is technically feasible:

```apl
C←.5*⍨-+.×-  ⍝ code golf (doesn't work on higher rank args)
u1 C v1  ⍝ distance using C
```

### Final Thoughts

As we subtract, square, sum, and take the square root, we should note the relationship of operations. The square root is the inverse of squaring, leading us to consider the under operator, which allows computations to take place under the influence of another operation.

Currently, we don't have this as a primitive, but it is available in certain frameworks. By using the under operator with the inverse, we can define a formula that provides clean and efficient distance calculations. 

Let's define it:

```apl
]aplcart ⍣¯1 under operator
_U_←{⍺←{⍵ ⋄ ⍺⍺} ⋄ ⍵⍵⍣¯1⊢(⍵⍵ ⍺)⍺⍺(⍵⍵ ⍵)}
U←+/_U_(×⍨)-  ⍝ +/⍢(×⍨)-
```

When we perform this on higher dimensional inputs, we get:

```apl
(↑u1 u2)U(↑v1 v2)  ⍝ distance using U operator
```

When comparing our code golf version with one that uses the under operator, we realize that while one expression may be marginally longer, a true primitive under operator would yield an even shorter and more aesthetically pleasing expression.

Thank you for watching!
