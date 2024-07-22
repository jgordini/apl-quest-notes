# Understanding Dice Mechanics in Risk

This article explores the mechanics of dice throws in the board game Risk. If you are not familiar with Risk, we recommend pausing the video and reading through the rules before proceeding.

## Overview of the Mechanics

In Risk, two players engage in battle: the attacker and the defender. The outcomes of their engagements are determined by rolling dice, and our goal here is to generalize the rules surrounding these dice throws. 

### The Players

- **Attacker**: represented by an integer vector on the left.
- **Defender**: represented by an integer vector on the right.

To illustrate, we will analyze a scenario where the attacker uses five armies (as per the game's rules) and throws five dice. In response, the defender utilizes three dice.

#### Example Dice Throws

1. **Attacker's Rolls**: 6, 6, 4, 2, 1
2. **Defender's Rolls**: 6, 5, 5

### Determining Losses

To calculate how many armies each player loses, we compare the corresponding rolls of the attacker and defender. 

1. **First Roll**: 6 (Attacker) vs. 6 (Defender) - Attacker loses.
2. **Second Roll**: 6 (Attacker) vs. 5 (Defender) - Defender loses.
3. **Third Roll**: 4 (Attacker) vs. 5 (Defender) - Attacker loses.
4. **Fourth Roll**: 2 (Attacker) vs. 0 (Defender) - No loss.
5. **Fifth Roll**: 1 (Attacker) vs. 0 (Defender) - No loss.

By analyzing the rolls:
- The attacker loses 2 armies.
- The defender loses 1 army.

#### APL Calculation

Using APL, we can represent the comparison of the rolls as follows:

```apl
6 6 4 2 1 ∘.> 6 5 5
⍝ This results in:
⍝ 0 1 1
```

The output indicates that for each roll, the first number shows the number of armies lost by the attacker, the second by the defender.

### Dice Comparison Rules

The attacker wins if the attacking die shows a higher number than the defending die. Our calculations assume that the rolls are sorted, which simplifies the process. 

We also need to account for the potential discrepancy in the lengths of the two vectors. While this may lead to inefficiencies, we can elegantly compare all values to produce a comparison table.

### Comparison Table

|          | Defender Die Rolls |
|----------|---------------------|
| Attacker | 6 | 5 | 5 |
| Rolls    |---|---|---|
| **6**    | 0 | 0 | 0 |
| **6**    | 0 | 1 | 1 |
| **4**    | 1 | 1 | 0 |
| **2**    | 0 | 0 | 0 |
| **1**    | 0 | 0 | 0 |

In this table:
- `1` indicates the attacker lost.
- `0` indicates the defender lost.

#### APL Comparison Table

The comparisons can also be evaluated with APL's transpose functionality to create a comparison matrix:

```apl
6 6 4 2 1 (⍉∘.>) 6 5 5
⍝ This results in:
⍝ 0 0 0 0 0
⍝ 1 1 0 0 0
```

### Extracting the Diagonal

To analyze the results accurately, we can manipulate the matrix to extract the diagonal of the comparison table. This method will help us focus on the relevant comparisons:

- **Transpose Function**: Manipulates the matrix to fit our needs, allowing us to travel through both axes and extract the necessary data.

### Counting Losses

To find out how many armies each player lost, we must count the occurrences of `1`s and `0`s in the comparison results. A `1` signifies the attacker lost an army, while a `0` signifies the defender lost an army.

We can achieve this list manipulation in APL:

```apl
F ← (+⌿⍪,~)1 1 ⍉ ∘.≤ 6 5 5
```

This function counts the losses based on the comparison.

### Summing the Losses

Finally, we sum the columns using a reduction technique. The resulting value gives the total number of armies lost. For our example, we get a total of 2 lost armies for the attacker and 1 lost army for the defender, calculated by running:

```apl
6 6 4 2 1 F 6 5 5
⍝ This results in:
⍝ 2 1
```

### Conclusion

Through these steps, we've illustrated the mechanics of determining losses in Risk involving dice throws. By structuring the approach and methodologies, we can effectively analyze game scenarios and outcomes. 

Thank you for reading! For further discussions and variations on this topic, feel free to check the description for additional resources.