# Understanding the Movement of a Chess Knight

In this article, we will explore the possible movements a chess knight can make from a given starting position on the board. We will discuss two main approaches to tackling this problem and delve into a logical solution.

## Approaches to the Problem

There are essentially two methods to approach this issue:

1. **Calculate Available Moves from a Starting Position:** We could begin with a specific starting position and compute all potential locations the knight can move to.

   Here's an example where we compute the squares a knight can move to from the starting position (5, 4):

   ```apl
   {⍳8 8} 5 4
   ```

   The board representation will be generated as follows:

   ```
   ┌───┬───┬───┬───┬───┬───┬───┬───┐
   │1 1│1 2│1 3│1 4│1 5│1 6│1 7│1 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │2 1│2 2│2 3│2 4│2 5│2 6│2 7│2 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │3 1│3 2│3 3│3 4│3 5│3 6│3 7│3 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │4 1│4 2│4 3│4 4│4 5│4 6│4 7│4 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │5 1│5 2│5 3│5 4│5 5│5 6│5 7│5 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │6 1│6 2│6 3│6 4│6 5│6 6│6 7│6 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │7 1│7 2│7 3│7 4│7 5│7 6│7 7│7 8│
   ├───┼───┼───┼───┼───┼───┼───┼───┤
   │8 1│8 2│8 3│8 4│8 5│8 6│8 7│8 8│
   └───┴───┴───┴───┴───┴───┴───┴───┘
   ```

2. **Evaluate Every Position on the Board:** Alternatively, we could consider all possible positions on the chessboard and determine if the knight can move to each of them. We will focus on the second method, as it often leads to a simpler solution.

## Setting Up the Chessboard

Let's use an example, although we won't fixate on a specific position such as (5, 4) for now. We will generate an 8x8 chessboard using a lambda function that creates an array to denote the indices of each element. Each index will be represented as a vector with two elements corresponding to the row and column positions.

As we generate this chessboard, we can compute the distance between each element and the designated starting position by subtracting the starting position from every element's coordinates. The result will give us the vertical and horizontal distances from the starting point. The starting position itself will naturally have a difference of (0, 0).

To visualize the distance computation, we can use the following APL code:

```apl
{(⍳8 8)-⊂⍵} 5 4
```

This will yield a representation of the distances from position (5, 4):

```
┌─────┬─────┬─────┬────┬────┬────┬────┬────┐
│¯4 ¯3│¯4 ¯2│¯4 ¯1│¯4 0│¯4 1│¯4 2│¯4 3│¯4 4│
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│¯3 ¯3│¯3 ¯2│¯3 ¯1│¯3 0│¯3 1│¯3 2│¯3 3│¯3 4│
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│¯2 ¯3│¯2 ¯2│¯2 ¯1│¯2 0│¯2 1│¯2 2│¯2 3│¯2 4│
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│¯1 ¯3│¯1 ¯2│¯1 ¯1│¯1 0│¯1 1│¯1 2│¯1 3│¯1 4│
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│0 ¯3 │0 ¯2 │0 ¯1 │0 0 │0 1 │0 2 │0 3 │0 4 │
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│1 ¯3 │1 ¯2 │1 ¯1 │1 0 │1 1 │1 2 │1 3 │1 4 │
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│2 ¯3 │2 ¯2 │2 ¯1 │2 0 │2 1 │2 2 │2 3 │2 4 │
├─────┼─────┼─────┼────┼────┼────┼────┼────┤
│3 ¯3 │3 ¯2 │3 ¯1 │3 0 │3 1 │3 2 │3 3 │3 4 │
└─────┴─────┴─────┴────┴────┴────┴────┴────┘
```

## Identifying Valid Moves

The knight moves in an L-shape: either two steps in one direction and one in another, or vice versa. This yields several possible movements:

- One step right and two steps up.
- Two steps up and one step right.
- One step up and two steps right.
- Two steps right and one step down.

From our analysis, we notice that the differences for valid knight movements include combinations of (2, 1) or (1, 2), irrespective of their signs. We can therefore generate a list of all valid movements based on these differences.

To visualize this step mathematically, we can use the following function in APL:

```apl
{|(⍳8 8)-⊂⍵} 5 4
```

This will provide us the distances suggesting which moves are possible:

```
┌───┬───┬───┬───┬───┬───┬───┬───┐
│4 3│4 2│4 1│4 0│4 1│4 2│4 3│4 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│3 3│3 2│3 1│3 0│3 1│3 2│3 3│3 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│2 3│2 2│2 1│2 0│2 1│2 2│2 3│2 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│1 3│1 2│1 1│1 0│1 1│1 2│1 3│1 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│0 3│0 2│0 1│0 0│0 1│0 2│0 3│0 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│1 3│1 2│1 1│1 0│1 1│1 2│1 3│1 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│2 3│2 2│2 1│2 0│2 1│2 2│2 3│2 4│
├───┼───┼───┼───┼───┼───┼───┼───┤
│3 3│3 2│3 1│3 0│3 1│3 2│3 3│3 4│
└───┴───┴───┴───┴───┴───┴───┴───┘
```

To streamline our approach, we look at only the absolute values since whether it's positive or negative doesn't affect movement.

## Creating the Boolean Array

Using the valid movements we identified (which include (1, 2) and (2, 1)), we can determine if each absolute distance is a valid move. By applying a membership function to these values, we create a Boolean array indicating the positions the knight can move to.

Here's how we can obtain a Boolean mask for valid moves:

```apl
{(1 2)(2 1)∊⍨|(⍳8 8)-⊂⍵} 5 4
```

The output will represent valid moves on the board, as such:

```
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 0 1 0 0 0
0 1 0 0 0 1 0 0
0 0 0 0 0 0 0 0
0 1 0 0 0 1 0 0
0 0 1 0 1 0 0 0
0 0 0 0 0 0 0 0
```

The ultimate goal is not the Boolean array itself but to extract the indices (positions) where the knight can legally move. We can utilize a function, such as `where`, to obtain the indices corresponding to `True` values in our Boolean array.

This solution is not only elegant but also effective. However, there is another mathematical approach we can explore.

## Utilizing the Pythagorean Theorem

Returning to our distance table, we can leverage the Pythagorean theorem to facilitate our calculations. According to the theorem, if we have a right triangle, the sum of the squares of the two shorter sides equates to the square of the hypotenuse.

While our scenario may not seem to involve triangles, knight moves can be visualized geometrically in this way. The movements consist of pairs of distances, which we can square.

Using self-multiplication, where we multiply each element by itself, we can compute the squares of our distances. Now, we will look for all instances where the squared values yield a total of 5.

Here is an APL function that applies this concept:

```apl
{(⍳8 8)-⊂⍵} 5 4
```

This generates an array of distances we can further analyze. Next, we compute the squares:

```apl
{×⍨(⍳8 8)-⊂⍵} 5 4
```

The output will look like this, representing the squared distances:

```
┌────┬────┬────┬────┬────┬────┬────┬─────┐
│16 9│16 4│16 1│16 0│16 1│16 4│16 9│16 16│
├────┼────┼────┼────┼────┼────┼────┼─────┤
│9 9 │9 4 │9 1 │9 0 │9 1 │9 4 │9 9 │9 16 │
├────┼────┼────┼────┼────┼────┼────┼─────┤
│4 9 │4 4 │4 1 │4 0 │4 1 │4 4 │4 9 │4 16 │
├────┼────┼────┼────┼────┼────┼────┼─────┤
│1 9 │1 4 │1 1 │1 0 │1 1 │1 4 │1 9 │1 16 │
├────┼────┼────┼────┼────┼────┼────┼─────┤
│0 9 │0 4 │0 1 │0 0 │0 1 │0 4 │0 9 │0 16 │
├────┼────┼────┼────┼────┼────┼────┼─────┤
│1 9 │1 4 │1 1 │1 0 │1 1 │1 4 │1 9 │1 16 │
├────┼────┼────┼────┼────┼────┼────┼─────┤
│4 9 │4 4 │4 1 │4 0 │4 1 │4 4 │4 9 │4 16 │
├────┼────┼────┼────┼────┼────┼────┼─────┤
│9 9 │9 4 │9 1 │9 0 │9 1 │9 4 │9 9 │9 16 │
└────┴────┴────┴────┴────┴────┴────┴─────┘
```

By summing the squared values in each case, we can compare the resulting sums to 5, creating a Boolean mask for valid moves:

```apl
{+/¨×⍨(⍳8 8)-⊂⍵} 5 4
```

The final output will represent the valid knight moves based on this method.

## Conclusion

By employing these methods, we can effectively determine where a knight can move from any starting position on a chessboard. Chess puzzles like this highlight the intersection of logic and mathematics within the realm of gaming. Thank you for exploring this concept with us!