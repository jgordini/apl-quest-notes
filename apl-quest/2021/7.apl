⍝ Write a function to test whether an array is a magic square. The function must:
⍝   have a right argument that is a square matrix of integers (not necessarily all positive integers)
⍝   return 1 if the array represents a magic square, otherwise return 0

s←(⍪1)(3 3⍴4 9 2 3 5 7 8 1 6)(2 2⍴1 2 3 4)(3 3⍴⍳9)

s
⍝ ┌─┬─────┬───┬─────┐
⍝ │1│4 9 2│1 2│1 2 3│
⍝ │ │3 5 7│3 4│4 5 6│
⍝ │ │8 1 6│   │7 8 9│
⍝ └─┴─────┴───┴─────┘
{⍵}¨s
⍝ ┌─┬─────┬───┬─────┐
⍝ │1│4 9 2│1 2│1 2 3│
⍝ │ │3 5 7│3 4│4 5 6│
⍝ │ │8 1 6│   │7 8 9│
⍝ └─┴─────┴───┴─────┘
{⍵,(1 1⍉⍵)}¨s
⍝ ┌───┬───────┬─────┬───────┐
⍝ │1 1│4 9 2 4│1 2 1│1 2 3 1│
⍝ │   │3 5 7 5│3 4 4│4 5 6 5│
⍝ │   │8 1 6 6│     │7 8 9 9│
⍝ └───┴───────┴─────┴───────┘
{⍵,(1 1⍉⍵),(⍉⍵)}¨s
⍝ ┌─────┬─────────────┬─────────┬─────────────┐
⍝ │1 1 1│4 9 2 4 4 3 8│1 2 1 1 3│1 2 3 1 1 4 7│
⍝ │     │3 5 7 5 9 5 1│3 4 4 2 4│4 5 6 5 2 5 8│
⍝ │     │8 1 6 6 2 7 6│         │7 8 9 9 3 6 9│
⍝ └─────┴─────────────┴─────────┴─────────────┘
{⍵,(1 1⍉⍵),(⍉⍵),⌽⍵}¨s
⍝ ┌───────┬───────────────────┬─────────────┬───────────────────┐
⍝ │1 1 1 1│4 9 2 4 4 3 8 2 9 4│1 2 1 1 3 2 1│1 2 3 1 1 4 7 3 2 1│
⍝ │       │3 5 7 5 9 5 1 7 5 3│3 4 4 2 4 4 3│4 5 6 5 2 5 8 6 5 4│
⍝ │       │8 1 6 6 2 7 6 6 1 8│             │7 8 9 9 3 6 9 9 8 7│
⍝ └───────┴───────────────────┴─────────────┴───────────────────┘
{⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
⍝ ┌───────┬───────────────┬───────────┬───────────────┐
⍝ │1 1 1 1│4 9 2 4 4 3 8 2│1 2 1 1 3 2│1 2 3 1 1 4 7 3│
⍝ │       │3 5 7 5 9 5 1 5│3 4 4 2 4 3│4 5 6 5 2 5 8 5│
⍝ │       │8 1 6 6 2 7 6 8│           │7 8 9 9 3 6 9 7│
⍝ └───────┴───────────────┴───────────┴───────────────┘
{+⌿⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
⍝ ┌───────┬───────────────────────┬───────────┬──────────────────────┐
⍝ │1 1 1 1│15 15 15 15 15 15 15 15│4 6 5 3 7 5│12 15 18 15 6 15 24 15│
⍝ └───────┴───────────────────────┴───────────┴──────────────────────┘
{∪+⌿⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
⍝ ┌─┬──┬─────────┬─────────────┐
⍝ │1│15│4 6 5 3 7│12 15 18 6 24│
⍝ └─┴──┴─────────┴─────────────┘
{≢∪+⌿⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
⍝ 1 1 5 5
{1=≢∪+⌿⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
⍝ 1 1 0 0

(⍉∪⍥{∪+⌿⍵,1 1⍉⍵}⌽)¨s
⍝ ┌─┬──┬─────────┬─────────────┐
⍝ │1│15│3 7 5 6 4│6 15 24 18 12│
⍝ └─┴──┴─────────┴─────────────┘
(1=∘≢⍉∪⍥{∪+⌿⍵,1 1⍉⍵}⌽)¨s
⍝ 1 1 0 0
