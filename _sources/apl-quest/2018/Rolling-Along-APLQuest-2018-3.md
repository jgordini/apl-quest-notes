# Simulating Dice Rolls and Analyzing Outcomes

In this article, we will explore the fascinating world of simulating dice rolls, calculating the different ways to achieve each total result, and finally, visualizing the frequency of these outcomes.

## Introduction

We will start by simulating the casting of dice. This process is interesting because we can think of each dice throw as representing independent dimensions in the full set of possible outcomes. When we roll multiple dice, each die contributes its own dimension, creating a multi-dimensional space of possible results.

## Simulating Dice Throws

Let's begin with a practical approach to throwing the dice and analyzing the outcomes. For instance, when we roll three dice, each die can land on a number from 1 to 6, creating various combinations. By visualizing these combinations as vectors, we can represent the results in a multi-dimensional array. 

For two six-sided dice, we can create a collection that forms a 6x6 array of two-element vectors representing the outcomes:

```apl
⍳6 6
```

This produces:

```
  1 1  1 2  1 3  1 4  1 5  1 6
  2 1  2 2  2 3  2 4  2 5  2 6
  3 1  3 2  3 3  3 4  3 5  3 6
  4 1  4 2  4 3  4 4  4 5  4 6
  5 1  5 2  5 3  5 4  5 5  5 6
  6 1  6 2  6 3  6 4  6 5  6 6
```

Next, we can sum these vectors to create a two-dimensional array containing all possible combinations of results:

```apl
+/¨⍳6 6
```

The resulting sums yield:

```
2 3 4  5  6  7
3 4 5  6  7  8
4 5 6  7  8  9
5 6 7  8  9 10
6 7 8  9 10 11
7 8 9 10 11 12
```

This process can be extended to more dice, generating many different total results.

### Exploring Different Types of Dice

To further our exploration, we can change the types of dice we roll. For example, we can simulate outcomes with:

- A **two-sided die** (coin flip)
- A **three-sided die** (which can be constructed in creative ways)
- A **standard six-sided die**

This approach leads us to a three-dimensional array (2x3x6) of possible outcomes, which we can further analyze:

```apl
+/¨⍳2 3 6
```

This yields a similar output for other configurations:

```
3 4 5 6  7  8
4 5 6 7  8  9
5 6 7 8  9 10
```

## Analyzing Outcomes

Once we have our array of outcomes, we can flatten it into a single list, resulting in a sorted order of possible results. By using the `key` operator, a higher-order function, we can map through the unique outcomes to gather their indices:

```apl
{⍺ ⍵}⌸,+/¨⍳2 3 6
```

The output will show the frequency of each total:

```
  3  1
  4  2 7 19
  5  3 8 13 20 25
  6  4 9 14 21 26 31
  7  5 10 15 22 27 32
  8  6 11 16 23 28 33
  9  12 17 24 29 34
 10  18 30 35
 11  36
```

To represent the frequency of each outcome, we can transform these indices into asterisks, indicating the count of each unique total rolled:

```apl
{⍺ ('*'⍨¨⍵)}⌸,+/¨⍳2 3 6
```

We can visualize the results as follows:

```
  3  *
  4  ***
  5  *****
  6  ******
  7  ******
  8  ******
  9  *****
 10  ***
 11  *
```

### Handling Dimensional Limitations

In APL (A Programming Language), there is a limitation on the number of dimensions allowed in an array, capped at 15. If we attempt to simulate, for example, 16 coin flips, we run into issues because this creates an array with too many dimensions.

To address this, we can represent the results using a mixed base system. For instance, trying to roll many dice can be visualized with:

```apl
{⍺ ('*'⍨¨⍵)}⌸,+/¨⍳ 16⍴2
```

This will lead to a **LIMIT ERROR** because of exceeding rank limits:

```
⍝ LIMIT ERROR: Rank of resultant array would exceed maximum permitted
```

## Implementation of a Function

Implementing our findings into a reusable function enables us to generate frequency distributions without hitting rank errors or dimensional limits. After wrapping our computations in a function, we can successfully handle large simulations, such as flipping multiple coins or rolling more dice types.

Here’s a simplified breakdown of the steps:

1. **Roll the Dice**: Simulate the outcomes based on the number of sides and dice.
2. **Flatten Outcomes**: Use a method to summarize results into a simpler format.
3. **Count Frequencies**: Utilize higher-order functions to map over unique outcomes and count their occurrences.
4. **Visualize**: Create clear representations of the data to show frequency distributions.

Through this exploration, we gain insights into probability distributions and the behavior of random outcomes in a straightforward and visual manner.

## Conclusion

The simulation of dice rolls offers an engaging way to explore combinatorial outcomes and understand frequency distributions. By leveraging programming techniques and mathematical concepts, we can streamline the process of analyzing and visualizing the results of our simulations.

Thank you for following along in this exploration of dice rolling simulations!