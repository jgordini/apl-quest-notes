⍝ Write an APL function that given a right argument Y of any array and a numeric scalar or vector left argument X returns a Boolean indicating if the left argument is a valid argument for X⍉Y, like the result of {0::0 ⋄ 1⊣⍺⍉⍵} but does not use ⍉ (to test the arguments).
X←2 5⍴(3 1 2)(2 1 2)(1 1)1⍬(2 3 2)(1 2)  (1.2 2 3)1⍬
Y←2 5⍴(2 3 4)(2 3 4)(3 4)0⍬(2 3 4)(2 3 4)(  2 3 4)⍬0⍴¨⊂⍳24

X{0::0 ⋄ 1⊣⍺⍉⍵}¨Y
⍝ 1 1 1 1 1
⍝ 0 0 0 0 0
X (⍴Y)
⍝ ┌────────────────────────┬───┐
⍝ │┌─────┬─────┬───────┬─┬┐│2 5│
⍝ ││3 1 2│2 1 2│1 1    │1│││   │
⍝ │├─────┼─────┼───────┼─┼┤│   │
⍝ ││2 3 2│1 2  │1.2 2 3│1│││   │
⍝ │└─────┴─────┴───────┴─┴┘│   │
⍝ └────────────────────────┴───┘
X (⍴¨Y)
⍝ ┌────────────────────────┬───────────────────────┐
⍝ │┌─────┬─────┬───────┬─┬┐│┌─────┬─────┬─────┬─┬─┐│
⍝ ││3 1 2│2 1 2│1 1    │1││││2 3 4│2 3 4│3 4  │0│ ││
⍝ │├─────┼─────┼───────┼─┼┤│├─────┼─────┼─────┼─┼─┤│
⍝ ││2 3 2│1 2  │1.2 2 3│1││││2 3 4│2 3 4│2 3 4│ │0││
⍝ │└─────┴─────┴───────┴─┴┘│└─────┴─────┴─────┴─┴─┘│
⍝ └────────────────────────┴───────────────────────┘
X (≢∘⍴¨Y)
⍝ ┌────────────────────────┬─────────┐
⍝ │┌─────┬─────┬───────┬─┬┐│3 3 2 1 0│
⍝ ││3 1 2│2 1 2│1 1    │1│││3 3 3 0 1│
⍝ │├─────┼─────┼───────┼─┼┤│         │
⍝ ││2 3 2│1 2  │1.2 2 3│1│││         │
⍝ │└─────┴─────┴───────┴─┴┘│         │
⍝ └────────────────────────┴─────────┘
X
⍝ ┌─────┬─────┬───────┬─┬┐
⍝ │3 1 2│2 1 2│1 1    │1││
⍝ ├─────┼─────┼───────┼─┼┤
⍝ │2 3 2│1 2  │1.2 2 3│1││
⍝ └─────┴─────┴───────┴─┴┘
{∪⍵}¨X
⍝ ┌─────┬───┬───────┬─┬┐
⍝ │3 1 2│2 1│1      │1││
⍝ ├─────┼───┼───────┼─┼┤
⍝ │2 3  │1 2│1.2 2 3│1││
⍝ └─────┴───┴───────┴─┴┘
⍋2 7 1 8
⍝ 3 1 2 4
⍋⍋2 7 1 8
⍝ 2 3 1 4
⍋3 1 4 2
⍝ 2 4 1 3
⍋⍋3 1 4 2
⍝ 3 1 4 2
{⍵≡⍋⍋⍵}3 1 4 2
⍝ 1
{⍵≡⍋⍋⍵}2 7 1 8
⍝ 0
{⍵≡⍋⍋⍵}¨X
⍝ RANK ERROR
{⍵≡⍋⍋⍵}¨X
    ∧
{(,⍵)≡⍋⍋,⍵}¨X
⍝ 1 0 0 1 1
⍝ 0 1 0 1 1
X
⍝ ┌─────┬─────┬───────┬─┬┐
⍝ │3 1 2│2 1 2│1 1    │1││
⍝ ├─────┼─────┼───────┼─┼┤
⍝ │2 3 2│1 2  │1.2 2 3│1││
⍝ └─────┴─────┴───────┴─┴┘
{(∪⍵)≡⍋⍋∪⍵}¨X
⍝ 1 1 1 1 1
⍝ 0 1 0 1 1
{u≡⍋⍋u←∪⍵}¨X
⍝ 1 1 1 1 1
⍝ 0 1 0 1 1
X{(≢⍺)=≢⍴⍵}¨Y
⍝ 1 1 1 1 1
⍝ 1 0 1 0 0
X{⍺=⍥≢⍴⍵}¨Y
⍝ 1 1 1 1 1
⍝ 1 0 1 0 0
X{⍺=⍥≢∘⍴⍵}¨Y
⍝ 1 1 1 1 1
⍝ 1 0 1 0 0
X=⍥≢∘⍴¨Y
⍝ 1 1 1 1 1
⍝ 1 0 1 0 0
X(=⍥≢∘⍴∧{u≡⍋⍋u←∪⍺})¨Y
⍝ 1 1 1 1 1
⍝ 0 0 0 0 0
F←=⍥≢∘⍴∧{u≡⍋⍋u←∪⍺}
X F¨Y
⍝ 1 1 1 1 1
⍝ 0 0 0 0 0