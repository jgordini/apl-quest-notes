
# Chess Setup Challenge

This challenge involves taking a variation of a normal chess setup and checking two specific conditions:

1. The King must be positioned between the Rooks.
2. The Bishops must consist of one white and one black piece.

## Examples of Setups

Here are some examples of chess setups with their evaluations:

### Valid Setup
- A standard chess setup with the King and Queen in the middle, Rooks at the ends, and Bishops next to them. This configuration is valid.

```apl
{⍵∩'KR'}¨'RNBQKBNR' 'RBBNQNRK' 'BRBKRNQN' 
```
Output:
```
1 0 1
```
This shows the setup 'RNBQKBNR' is valid since the King (K) is between the Rooks (R), while the others are not.

### Invalid Setups
- In one configuration, the King is placed outside the Rooks. 
- Another configuration has the King between the Rooks, but both Bishops occupy squares of the same color.

## Step-by-Step Breakdown

To validate the setups, we can approach it step by step by creating a Lambda function that refers to the argument as Omega. We need to evaluate the two conditions:

1. **Rook-King-Rook Arrangement**:
   We should check the order of the pieces to ensure they follow the Rook-King-Rook pattern. This means we're only interested in the letters K (for King) and R (for Rook). We can find the intersection of the argument with K and R and check if it matches the Rook-King-Rook order.

   - The first example is valid because the King is in the middle.
   - The second setup is invalid due to the positioning of the King.
   - The third setup is valid with respect to the King’s positioning, but there may be another reason for it to be invalid.

   To check if the King is indeed between the Rooks, we can use the following APL code:
   
```apl
{'RKR'≡⍵∩'KR'}¨'RNBQKBNR' 'RBBNQNRK' 'BRBKRNQN' 
```
Output:
```
1 0 1
```

2. **Bishop Color Parity**:
   The other condition focuses on the Bishops having opposite color squares. To assess this, we can create a mask for the Bishops' positions and transform it into a list of indices. We then determine the parity (even or odd) of their positions by taking the remainder when divided by two.

   We can identify the positions of the Bishops as follows:
   
```apl
{('B'=⍵)⊣'RKR'≡⍵∩'KR'}¨'RNBQKBNR' 'RBBNQNRK' 'BRBKRNQN' 
```
Output:
```
0 0 1 0 0 1 0 0 │0 1 1 0 0 0 0 0│1 0 1 0 0 0 0 0
```

This indicates the positions of Bishops in the chess setups.

Now, we need to check if bishops occupy one odd and one even position:
```apl
{(2|⍸'B'=⍵)⊣'RKR'≡⍵∩'KR'}¨'RNBQKBNR' 'RBBNQNRK' 'BRBKRNQN' 
```
Output:
```
1 0│0 1│1 1
```
Indicating whether the bishops' positions meet the parity conditions.

Finally, we can verify the condition of having one Bishop on an odd position and another on an even position using:
```apl
{(≠/2|⍸'B'=⍵)⊣'RKR'≡⍵∩'KR'}¨'RNBQKBNR' 'RBBNQNRK' 'BRBKRNQN' 
```
Output:
```
1 1 0
```

Combining both conditions will allow us to draw conclusions about the overall validity of each setup. For instance, although the first setup may be valid, others may be invalid.

Thank you for watching!
