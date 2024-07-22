⍝ Write a function that takes as its right argument a vector of simple arrays of rank 2 or less (scalar, vector, or matrix). Each simple array will consist of either non-negative integers or printable ASCII characters. The function must return a simple character array that displays identically to what {⎕←⍵}¨ displays when applied to the right argument.
d←(3 3⍴⍳9)(↑'Adam' 'Michael')(⍳10) '*'(5 5⍴⍳25)
d
⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
⍝ │7 8 9│       │                    │ │11 12 13 14 15│
⍝ │     │       │                    │ │16 17 18 19 20│
⍝ │     │       │                    │ │21 22 23 24 25│
⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
{⎕←⍵}¨d
⍝ 1 2 3
⍝ 4 5 6
⍝ 7 8 9
⍝ Adam   
⍝ Michael
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *
⍝  1  2  3  4  5
⍝  6  7  8  9 10
⍝ 11 12 13 14 15
⍝ 16 17 18 19 20
⍝ 21 22 23 24 25

⍝ Split into rows and combine:
{⍕¨⍵}d
⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
⍝ │7 8 9│       │                    │ │11 12 13 14 15│
⍝ │     │       │                    │ │16 17 18 19 20│
⍝ │     │       │                    │ │21 22 23 24 25│
⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
{↓¨⍕¨⍵}d
⍝ ┌───────────────────┬─────────────────┬──────────────────────┬─┬────────────────────────────────────────────────────────────────────────────┐
⍝ │┌─────┬─────┬─────┐│┌───────┬───────┐│┌────────────────────┐│*│┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐│
⍝ ││1 2 3│4 5 6│7 8 9│││Adam   │Michael│││1 2 3 4 5 6 7 8 9 10││ ││ 1  2  3  4  5│ 6  7  8  9 10│11 12 13 14 15│16 17 18 19 20│21 22 23 24 25││
⍝ │└─────┴─────┴─────┘│└───────┴───────┘│└────────────────────┘│ │└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘│
⍝ └───────────────────┴─────────────────┴──────────────────────┴─┴────────────────────────────────────────────────────────────────────────────┘
{,/↓¨⍕¨⍵}d
⍝ ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
⍝ │┌─────┬─────┬─────┬───────┬───────┬────────────────────┬─┬──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐│
⍝ ││1 2 3│4 5 6│7 8 9│Adam   │Michael│1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│ 6  7  8  9 10│11 12 13 14 15│16 17 18 19 20│21 22 23 24 25││
⍝ │└─────┴─────┴─────┴───────┴───────┴────────────────────┴─┴──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘│
⍝ └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
{⊃,/↓¨⍕¨⍵}d
⍝ ┌─────┬─────┬─────┬───────┬───────┬────────────────────┬─┬──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
⍝ │1 2 3│4 5 6│7 8 9│Adam   │Michael│1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│ 6  7  8  9 10│11 12 13 14 15│16 17 18 19 20│21 22 23 24 25│
⍝ └─────┴─────┴─────┴───────┴───────┴────────────────────┴─┴──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
{↑⊃,/↓¨⍕¨⍵}d
⍝ 1 2 3               
⍝ 4 5 6               
⍝ 7 8 9               
⍝ Adam                
⍝ Michael             
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *                   
⍝  1  2  3  4  5      
⍝  6  7  8  9 10      
⍝ 11 12 13 14 15      
⍝ 16 17 18 19 20      
⍝ 21 22 23 24 25      
{↑⊃,/↓⍤⍕¨⍵}'abcd'  ⍝ simple scalar characters are problematic
⍝ abcd
{⎕←⍵}¨'abcd'
⍝ a
⍝ b
⍝ c
⍝ d
3/'abc'
⍝ aaabbbccc
1/'abc'
⍝ abc
⍴1/'abc'
⍝ 3
⍴'a'
⍝ 
⍴1/'a'
⍝ 1
{↑⊃,/↓⍤⍕¨1/¨⍵}'abcd'
⍝ a
⍝ b
⍝ c
⍝ d
{↑⊃,/↓⍤⍕¨1/¨⍵}d
⍝ 1 2 3               
⍝ 4 5 6               
⍝ 7 8 9               
⍝ Adam                
⍝ Michael             
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *                   
⍝  1  2  3  4  5      
⍝  6  7  8  9 10      
⍝ 11 12 13 14 15      
⍝ 16 17 18 19 20      
⍝ 21 22 23 24 25      

⍝ Stack, format, trim:
{⍪1/¨⍵}d
⍝ ┌────────────────────┐
⍝ │1 2 3               │
⍝ │4 5 6               │
⍝ │7 8 9               │
⍝ ├────────────────────┤
⍝ │Adam                │
⍝ │Michael             │
⍝ ├────────────────────┤
⍝ │1 2 3 4 5 6 7 8 9 10│
⍝ ├────────────────────┤
⍝ │*                   │
⍝ ├────────────────────┤
⍝ │ 1  2  3  4  5      │
⍝ │ 6  7  8  9 10      │
⍝ │11 12 13 14 15      │
⍝ │16 17 18 19 20      │
⍝ │21 22 23 24 25      │
⍝ └────────────────────┘
{⍕⍪1/¨⍵}d
⍝  1 2 3                
⍝  4 5 6                
⍝  7 8 9                
⍝  Adam                 
⍝  Michael              
⍝  1 2 3 4 5 6 7 8 9 10 
⍝  *                    
⍝   1  2  3  4  5       
⍝   6  7  8  9 10       
⍝  11 12 13 14 15       
⍝  16 17 18 19 20       
⍝  21 22 23 24 25       
{⍉⍕⍪1/¨⍵}d  ⍝ the output here is hard to read…
      
⍝ 147AM1*  112
⍝    di  16161
⍝ 258ac2      
⍝    mh    112
⍝ 369 a3 27272
⍝     e       
⍝     l4   112
 38383
⍝      5      
   112
⍝      6 49494
      
⍝      7  1122
 50505
⍝      8      
      
⍝      9      
      
⍝      1      
⍝      0      
      
{⍉¯1↓1↓⍉⍕⍪1/¨⍵}d  ⍝ … so we proceed to after we've transposed back
⍝ 1 2 3               
⍝ 4 5 6               
⍝ 7 8 9               
⍝ Adam                
⍝ Michael             
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *                   
⍝  1  2  3  4  5      
⍝  6  7  8  9 10      
⍝ 11 12 13 14 15      
⍝ 16 17 18 19 20      
⍝ 21 22 23 24 25      
{(¯1↓1↓⊢)⍤1⍕⍪1/¨⍵}d
⍝ 1 2 3               
⍝ 4 5 6               
⍝ 7 8 9               
⍝ Adam                
⍝ Michael             
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *                   
⍝  1  2  3  4  5      
⍝  6  7  8  9 10      
⍝ 11 12 13 14 15      
⍝ 16 17 18 19 20      
⍝ 21 22 23 24 25      

⍝ Put line break after each line/row, then flatten:
(⍕¨)d
⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
⍝ │7 8 9│       │                    │ │11 12 13 14 15│
⍝ │     │       │                    │ │16 17 18 19 20│
⍝ │     │       │                    │ │21 22 23 24 25│
⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
(⍕¨,¨(⎕UCS 10)⍨)d
⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
⍝ │     │       │                    │ │              │
⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
⍝ │     │       │                    │ │              │
⍝ │7 8 9│       │                    │ │11 12 13 14 15│
⍝ │     │       │                    │ │              │
⍝ │     │       │                    │ │16 17 18 19 20│
⍝ │     │       │                    │ │              │
⍝ │     │       │                    │ │21 22 23 24 25│
⍝ │     │       │                    │ │              │
⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
(⍕¨ ,¨∘⎕UCS 10⍨)d
⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
⍝ │     │       │                    │ │              │
⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
⍝ │     │       │                    │ │              │
⍝ │7 8 9│       │                    │ │11 12 13 14 15│
⍝ │     │       │                    │ │              │
⍝ │     │       │                    │ │16 17 18 19 20│
⍝ │     │       │                    │ │              │
⍝ │     │       │                    │ │21 22 23 24 25│
⍝ │     │       │                    │ │              │
⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
(∊⍕¨,¨∘⎕UCS 10⍨)d
⍝ 1 2 3
⍝ 4 5 6
⍝ 7 8 9
⍝ Adam   
⍝ Michael
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *
⍝  1  2  3  4  5
⍝  6  7  8  9 10
⍝ 11 12 13 14 15
⍝ 16 17 18 19 20
⍝ 21 22 23 24 25
⍝ 
(¯1↓∘∊⍕¨,¨∘⎕UCS 10⍨)d
⍝ 1 2 3
⍝ 4 5 6
⍝ 7 8 9
⍝ Adam   
⍝ Michael
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *
⍝  1  2  3  4  5
⍝  6  7  8  9 10
⍝ 11 12 13 14 15
⍝ 16 17 18 19 20
⍝ 21 22 23 24 25
