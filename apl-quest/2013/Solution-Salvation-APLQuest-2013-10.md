
# APL Quest: Solving Linear Equations

Hello and welcome to this APL quest! In today's episode, we're tackling the last problem from the 2013 round of the APL problem-solving competition. The objective is straightforward: we are given a set of linear equations and their corresponding results, and we need to find the values of the variables.

## Setting Up the Equation System

Let's start by creating a simple example of a system of equations with three variables:

- \(4x + 1y + 1z = 2\)
- \(2x + 2y + 2z = 6\)
- \(6x + 3y + 1z = 4\)

A potential solution for this system could be:
- \(x = -1\)
- \(y = 3\)
- \(z = 1\)

We can verify this by substituting the values back into the equations and calculating the results. 

The equations simplify to:
- \(4 \times (-1) + 1 \times 3 + 1 \times 1 = 2\)
- \(2 \times (-1) + 2 \times 3 + 2 \times 1 = 6\)
- \(6 \times (-1) + 3 \times 3 + 1 \times 1 = 4\)

Indeed, these yield the correct outcomes.

## Finding the Missing Values

The next step is to compute the values of \(x, y,\) and \(z\) without knowing them a priori. We know the results \(2, 6,\) and \(4\), and we can express our goal as finding a vector \(v\) such that:

$[ M \cdot v = R ]$

Where \(M\) represents the matrix of coefficients and \(R\) represents our results.

In APL, we can represent the system of equations and the results as follows:

```apl
M ← 3 3⍴ 4 1 3 2 2 2 6 3 1  ⍝ Coefficient matrix
r ← 2 6 4                  ⍝ Results vector
v ← ¯1 3 1                  ⍝ Initial guess for the solution
```

We can also check if \(v\) satisfies the equation with the following expressions:

```apl
v ≡ r +.×⍣¯1⍨ M           ⍝ Iteratively solve for v
v ≡ r +.×⍨∘⌹ M           ⍝ Check if v satisfies the system
v ≡ r ⌹ M                  ⍝ Another method to verify
```

These commands utilize APL's powerful array manipulation capabilities to find \(v\).

## Iterative Techniques

While APL makes solving this problem elegant, we can also explore iterative methods to approximate the inverse of a matrix. One such technique is known as the **Hotelling-Bodewig Scheme**. The iterative relationship looks like this:

$[ v_{n+1} = v_n \cdot (2I - M \cdot v_n) ]$

Where:
- \(I\) is the identity matrix
- \(M\) is our original matrix of coefficients

Here is how we can define the Hotelling-Bodewig scheme in APL:

```apl
⍝ Hotelling-Bodewig iterations
vᵢ₊₁ = vᵢ(2I−M vᵢ)
vᵢ₊₁ = 2vᵢ−vᵢ A vᵢ
vᵢ₊₁ = vᵢ + vᵢ − vᵢ A vᵢ
```

To implement this in APL, we would set up a function that computes the next estimate until we reach a stable solution, using something like the following notation:

```apl
v ← {r +.×⍨ ∘(⊢(⊢ + ⊢ - ⊢ +.× +.×)⍣≡ ⍉ ÷,+.×,) M}⍤0 ⍳ 11   ⍝ show steps
```

## Finding an Initial Guess

An important aspect of the iterative method is selecting a good initial guess for the values of \(x, y,\) and \(z\). Recently, a method proposed by Solemani suggests that the initial guess can be obtained using:

\[ \frac{M^T}{\text{trace}(M \cdot M^T)} \]

In APL, we can calculate this with the following code:

```apl
+/1 1⍉+.×∘⍉⍨ M          ⍝ Calculate the trace of MMᵀ
```

This gives us a systematic approach to finding a starting point that can be utilized within our iterative procedure.

## Conclusion

Through APL's powerful capabilities and mathematical techniques, we explored various methods to solve systems of linear equations. We verified results through substitution, applied matrix inverses, and iterated toward solutions with the following Gauss-Jordan elimination function:

```apl
GaussJordan ← {⎕IO ⎕ML←0 1              ⍝ Gauss-Jordan elimination
    Elim ← {                           ⍝ elimination of row/col ⍺
        p ← ⍺ + {⍵⍳⌈/⍵}|⍺↓⍵[;⍺]       ⍝ index of pivot row
        swap ← ⊖@⍺ p⊢⍵                 ⍝ swap ⍺th and pth rows
        mat ← swap[⍺;⍺]÷⍨@⍺⊢swap      ⍝ col diag red to 1
        mat - (mat[;⍺]×⍺≠⍳≢⍵)∘.×mat[⍺;] ⍝ col off-diag red to 0
    }
    (⍴⍺)⍴(0 1×⍴⍵)↓↑Elim/(⌽⍳⌊/⍴⍵),⊂⍵,⍺ ⍝ Elim/ … 2 1 0 (⍵,⍺)
}
```

This concludes the first year of APL problem-solving competitions. We look forward to tackling the problems from 2014 in upcoming episodes. Thank you for joining us!
