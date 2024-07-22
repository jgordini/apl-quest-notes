
# Inserting Separators in Large Integers

In this article, we discuss how to insert separators between groups of three digits in an integer that is passed as a character vector. We will cover three different approaches to achieve this task, though there are many other methods available. For more information, you can refer to the link to the chat event in the video description.

## Generating Test Data

First, let's generate some test data. We can create an integer by raising 10 to the powers of 0 through 9, making each of these numbers into a character vector. The output will be boxed like this, which we will call `t`. 

```apl
10*0,⍳9
⍝ 1 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000
```

To view the character representations of these numbers, we can apply the formatting function:

```apl
⍕¨10*0,⍳9
⍝ ┌─┬──┬───┬────┬─────┬──────┬───────┬────────┬─────────┬──────────┐
⍝ │1│10│100│1000│10000│100000│1000000│10000000│100000000│1000000000│
⍝ └─┴──┴───┴────┴─────┴──────┴───────┴────────┴─────────┴──────────┘
```

Any character can be used as a separator; in this example, we'll use a comma.

## Approach 1: Using Partitioning

To insert separators, we start from the right and find groups of three digits. By applying an anonymous lambda function to each element in `t` with `s` as a left argument, we reverse the argument. Reversing allows us to work from the left.

We create a mask with a pattern of 1s and 0s, indicating the start of each new section. Then we generate our groups while appending the separator:

```apl
s←','
s{⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬────────┬─────────┬──────────┬────────────┐
⍝ │1│01│001│0001│00001│000001│0000001│00000001│000000001│0000000001│
⍝ └─┴──┴───┴─────┴──────┴───────┴────────┴─────────┴──────────┘
```

Once we have our groups, we prepend a separator to every group in the list. After adding a separator, we need to remove one separator from the end, as it creates an undesired extra separator. The final step is to reverse the result again:

```apl
s{(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌───┬────┬─────┬───────┬────────┬─────────┬───────────┬────────────┬─────────────┬───────────────┐
⍝ │┌─┐│┌──┐│┌───┐│┌───┬─┐│┌───┬──┐│┌───┬───┐│┌───┬───┬─┐│┌───┬───┬──┐│┌───┬───┬───┐│┌───┬───┬───┬─┐│
⍝ ││1│││01│││001│││000│1│││000│01│││000│001│││000│000│1│││000│000│01│││000│000│001│││000│000│000│1││
⍝ │└─┘│└──┘│└───┘│└───┴─┘│└───┴──┘│└───┴───┘│└───┴───┴─┘│└───┴───┴──┘│└───┴───┴───┘│└───┴───┴───┴─┘│
⍝ └───┴────┴─────┴───────┴────────┴─────────┴───────────┴────────────┴─────────────┴───────────────┘
```

We'll call this method `F`.

## Approach 2: Using Regular Expressions

Another approach involves using the regex sublanguage. This method also works from the rear. While it's possible to utilize lookaheads and lookbehinds with regex, it's much more straightforward to reverse the string first.

We aim to replace any sequence of three characters (digits) that is not followed by the end of the string with the match followed by the separator. After performing this replacement, we reverse the string back to its original order. We will label this method `G`.

```apl
s{'...(?!$)'⎕R'&'⍺⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│01│001│000,1│000,01│000,001│000,000,1│000,000,01│000,000,001│000,000,000,1│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
```

## Approach 3: Using a Matrix-Based Method

Finally, we can explore a matrix-based approach. Again, we need to work from the reverse, but we will split the digits into groups while keeping them flat. This method resembles the partitioning approach but uses matrix reshaping.

We set up a matrix with three columns. After reshaping, we append separators to the right of the matrix for each group of digits:

```apl
s{(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌────┬─────┬──────┬─────────┬──────────┬───────────┬──────────────┬───────────────┬────────────────┬───────────────────┐
⍝ │┌──┐│┌───┐│┌────┐│┌────┬──┐│┌────┬───┐│┌────┬────┐│┌────┬────┬──┐│┌────┬────┬───┐│┌────┬────┬────┐│┌────┬────┬────┬──┐│
⍝ ││,1│││,01│││,001│││,000│,1│││,000│,01│││,000│,001│││,000│,000│,1│││,000│,000│,01│││,000│,000│,001│││,000│,000│,000│,1││
⍝ │└──┘│└───┘│└────┘│└────┴──┘│└────┴───┘│└────┴────┘│└────┴────┴──┘│└────┴────┴───┘│└────┴────┴────┘│└────┴────┴────┴──┘│
⍝ └────┴─────┴──────┴─────────┴──────────┴───────────┴──────────────┴───────────────┴────────────────┴───────────────────┘
```

### Calculating Characters to Remove

To determine how many characters to remove, we analyze the length and apply a formula reflecting periods of three. 

To finalize our matrix method, we need to flatten the structure and remove trailing characters. The number of characters to be removed will vary depending on the length of the output.

## Performance Comparison

So, which method is the best? The performance of each method can vary based on implementation. If brevity or clarity is your goal, you may prefer simpler approaches. If performance is crucial, you might opt for array-based methods.

To compare performance, we copy in the `cmpx` facility from the development workspace and create a large number of digits (up to a million). 

```apl
'cmpx'⎕CY'dfns'
10↑n←1e6⍴⎕D
⍝ 0123456789
```

We can then compare the execution time of `separator F`, `separator G`, and `separator H`:

```apl
cmpx's F n' 's G n' 's H n'
⍝   s F n → 4.3E¯2 |    0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       
⍝   s G n → 1.0E¯1 | +141% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝   s H n → 2.6E¯3 |  -95% ⎕                                       
```

In practice, the flat array-based approach tends to be the fastest, while nested arrays may come next, and regex should be used as a last resort if no other method is feasible.

Thank you for reading!
