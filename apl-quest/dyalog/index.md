# [Jupyter](http://jupyter.org/) notebooks for [Dyalog APL](https://www.dyalog.com/)

## What is this and how do I use it?

Please see [our wiki](https://github.com/Dyalog/dyalog-jupyter-kernel/wiki).

## Where is the language kernel?

A kernel for using these notebooks is available [here](https://github.com/Dyalog/dyalog-jupyter-kernel).

## Contributing

Feel free to contribute additional notebooks to our collection through emailing notebooks@dyalog.com or submitting [pull requests](https://help.github.com/articles/about-pull-requests/).

## AOC 2024

AOC1

```APL
n←,⎕CSV'/Users/jeremy/Desktop/aoc-1.txt'⍬4
aoc1←{(⊣/,⊢/)¨(∊∘⎕D¨⍵)/¨⍵}
```

1. **Nested Arrays**

Summary: Nested arrays allow APL to handle more complex data structures by permitting arrays to contain other arrays as elements, rather than just simple scalar values.

Example:
```apl
      words ← 'apple' 'banana' 'cherry' 'date' 'elderberry'
      nested ← ⊂¨words
      nested
┌─────┬──────┬──────┬────┬──────────┐
│apple│banana│cherry│date│elderberry│
└─────┴──────┴──────┴────┴──────────┘
      ≢¨nested
5 6 6 4 10
```

2. **Dfns (Direct Functions)**

Summary: Dfns provide a concise way to define functions using curly braces, with ⍵ representing the right argument and ⍺ the left argument.

Example:
```apl
      splitOnComma ← {⍵⊂⍨1,1↓0=⍵∊','}
      splitOnComma 'apple,banana,cherry'
┌─────┬──────┬──────┐
│apple│banana│cherry│
└─────┴──────┴──────┘
```

3. **Trains**

Summary: Trains allow the composition of functions without explicit argument passing, creating more readable and concise code.

Example (Fork):
```apl
      average ← {(+⌿⍵)÷≢⍵}  ⍝ Dfn version
      average 1 2 3 4 5
3
      averageTrain ← +⌿ ÷ ≢  ⍝ Train version
      averageTrain 1 2 3 4 5
3
```

Example (Atop):
```apl
      countUnique ← ≢∘∪
      countUnique 1 2 2 3 3 3 4 4 4 4
4
```

4. **Leading Axis Theory**

Summary: Leading Axis Theory involves working along the first (leading) axis of arrays and using the rank operator to apply functions to specific sub-arrays.

Example:
```apl
      matrix ← 3 3 ⍴ ⍳9
      matrix
1 2 3
4 5 6
7 8 9
      +⌿matrix  ⍝ Sum along the leading axis
12 15 18
      averageTrain⌿⍤1 matrix  ⍝ Average of each column
4 5 6
```



