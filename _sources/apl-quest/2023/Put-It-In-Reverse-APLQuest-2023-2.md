
# Finding End Points of One Array in Another

In this article, we will explore how to find the end points of one array in another using APL (A Programming Language). APL has a built-in primitive function that identifies the beginning points, but our goal is to find the end points instead.

## Visualizing the Problem

Let's visualize the issue. We have two arrays, and we want to discover where one array starts and ends within another. By using a primitive function in APL, we can easily locate the beginning points. 

For demonstration, we will stack an example—let’s say "Mississippi" on top of another array. By spreading out the letters, we can observe the locations where our target substring (e.g., "issi") begins.

```apl
'issi' ⍷ 'Mississippi'
⍝ 0 1 0 0 1 0 0 0 0 0 0
```

As we analyze our data, we can see two beginning points in "Mississippi". This means we need to determine where these sections end.

## Two Methods to Find End Points

There are primarily two approaches to locate the end points. One method involves adjusting the positions of the matched results based on their lengths.

1. **Adjusting Results**: We can identify that our ones (which represent the starting points) are simply offset from where they should align. We need to shift them to the right, which correlates to the length of the match. Once we've determined the number of steps (length of match), we need to account for this by adjusting it by one less than the total.

Here are several examples demonstrating how we can accomplish this:

```apl
↑'Mississippi'('issi' ⍷ 'Mississippi')
⍝ M i s s i s s i p p i
⍝ 0 1 0 0 1 0 0 0 0 0 0

↑'Mississippi'('issi' {1⌽⍺⍷⍵} 'Mississippi')
⍝ M i s s i s s i p p i
⍝ 1 0 0 1 0 0 0 0 0 0 0

↑'Mississippi'('issi' {¯1⌽⍺⍷⍵} 'Mississippi')
⍝ M i s s i s s i p p i
⍝ 0 0 1 0 0 1 0 0 0 0 0
```

2. **Using a Lambda Function**: We can wrap our primitive function in a lambda to enhance flexibility. The `rotate` function can be used, and by using negative numbers, we will shift results towards the right effectively. 

For example, if we want to make adjustments based on the length of the match, we can consider:

```apl
↑'Mississippi'('issi' {(≢⍺)⌽⍺⍷⍵} 'Mississippi')
⍝ M i s s i s s i p p i
⍝ 1 0 0 0 0 0 0 0 1 0 0

↑'Mississippi'('issi' {(-≢⍺)⌽⍺⍷⍵} 'Mississippi')
⍝ M i s s i s s i p p i
⍝ 0 0 0 0 0 1 0 0 1 0 0
```

### Simplifying the Code

We can simplify our solution further. By observing that we have a "fork construct," we can transition our formula from curly braces to parentheses. This helps eliminate the need for explicit arguments since we can nest functions.

By applying a small lambda function that captures the essential elements—only using the left argument to return the adjusted length—we refine our code.

Finally, we can encapsulate the entire function and give it an appropriate name:

```apl
F←{1-≢⍺}⌽⍷
'issi' F 'Mississippi'
⍝ 0 0 0 0 1 0 0 1 0 0 0
```

## An Alternative Method

Alternatively, we can view the problem from a different perspective. While the `find` function gives us the start points, reading from the right instead allows us to isolate the end points. Therefore, by reversing both arrays, we can locate the start points of the reversed data. 

To facilitate this, we can apply the operator that reverses both arguments, aligning our comparison. Lastly, we will need to reverse the final result to accurately extract the end points.

Here's how we can achieve this:

```apl
↑(⌽'Mississippi')('issi' (⍷⍥⌽) 'Mississippi')
⍝ i p p i s s i s s i M
⍝ 0 0 0 1 0 0 1 0 0 0 0

G←⌽⍷⍥⌽
'issi' G 'Mississippi'
⍝ 0 0 0 0 1 0 0 1 0 0 0
```

By doing this, we can achieve the desired result effectively and succinctly.

## Conclusion

In summary, we have explored two methods to find the end points of one array within another array using APL. Whether adjusting the starting points based on their match lengths or utilizing reversals for better clarity, we have laid out simple yet effective strategies to tackle this common programming challenge.

Thank you for watching!
