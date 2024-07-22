
# Translating Telephone Numbers from Digits and Letters to Plain Numbers

In this article, we will explore how to translate telephone numbers written with both digits and letters into their corresponding plain numbers. 

## Understanding the Telephone Keypad

First, let’s consider the telephone keypad. The letters are arranged sequentially on the keys, essentially splitting the alphabet into groups or sub-alphabets. This allows us to view the alphabet as a range with cutoff points, defined by the first letter of each key.

### Creating Cutoff Points

To establish these cutoff points, we recognize that each key correlates with a specific set of letters. We can utilize this to create an interval index that maps each letter to its corresponding number on the keypad.

```apl
t←↑¨⍕¨¨4 3⍴(''1)('ABC'2)('DEF'3)('GHI'4)('JKL'5)('MNO'6)('PQRS'7)('TUV '8)('WXYZ'9)('' '*')(''0)('' '#')
```

### Flattening the Matrix

Instead of maintaining a matrix for the keypad, we can flatten it to simplify our representation. This means we will directly list the letters along with their corresponding digits without the extra structure of a matrix.

```apl
⊃¨t
```

### Identifying Relevant Letters

By taking the intersection of the alphabet and the letters from the keypad, we obtain only the letters we are interested in. We can give these letters a name, like "cutoffs".

```apl
c←⎕A∩,⊃¨t
```

## Mapping Letters and Digits to Numbers

Having established the letters, we can index them to find their numeric values. The offsets allow us to determine the correct digit for each letter, but we need to adjust by adding a placeholder character, like the `@` symbol. This character appears before `A` in the Unicode table and helps maintain our intended order.

### Handling Digits

For the digits, we can directly refer to the numerical values. However, we need to account for an off-by-one error. By altering the interval index, we can drop one from the alphabet and retrieve the correct values.

```apl
@ADGJMPTW⍸⎕A
```

### Compiling Everything Together

Now that we have our letters and digits, we can combine them. We will concatenate the digits and drop one before mapping them through our established key system. It is essential to note that inserting appropriate symbols, for instance, another `@`, ensures our mapping remains accurate.

```apl
(1↓⎕D,'@ADGJMPTW')
```

## Final Adjustments

Once we have all the letters and digits, we notice that they are off by 10. We can resolve this by applying a modulus operation, which allows us to keep our values within the 0-9 range.

## Implementing the Solution

To formalize our mapping into a function, we create a static function with a constant left argument and bind it to the interval index function. By assigning this to a variable `F`, we ensure the telephone numbers get mapped correctly.

```apl
F←10|(1↓⎕D,'@@ADGJMPTW')∘⍸
F 'ABC'
```

## Performance Considerations

Although the implemented method works, it is not the fastest option. We can achieve better performance by utilizing a mapping function that directly looks up values instead of performing computations on the input.

### Generating Values

We’ll generate all possible values for the digits and letters and call this collection `n`. This setup will allow us to look up any input in this list.

```apl
n←F¨⎕D,⎕A
```

### Defining a Lookup Function

By defining a simple lookup function, we can retrieve the corresponding indices for our input characters and use them to index into our generated values `n`. This approach will yield the same results but more efficiently since we are solely performing lookups.

```apl
G←{n[(⎕D,⎕A)⍳⍵]}
G 'UR2CUTE'
```

## Conclusion

By employing these techniques, we effectively convert telephone numbers from their alphanumeric representations into plain numeric formats. This guide highlights both the computational aspects and the optimizations necessary to implement this solution in an efficient manner.

Thank you for reading!
