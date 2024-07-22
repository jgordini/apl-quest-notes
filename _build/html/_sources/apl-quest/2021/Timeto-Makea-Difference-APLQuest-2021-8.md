# Calculating Absolute Time Difference in Minutes

In this article, we will explore how to find the absolute difference between two specifications of time. The interesting twist here is that these specifications may not be consistent; they can represent various formats such as minutes, hours and minutes, or even days, hours, and minutes. Therefore, we must normalize these specifications in order to determine the total difference in minutes.

## Example Problem

Let's take an example where we have two times:

- **Time 1**: 2:30 (which translates to 2 hours and 30 minutes)
- **Time 2**: 5:15 (which translates to 5 hours and 15 minutes)

Our objective is to find the absolute difference in minutes between these two times. Before calculating the difference, we need to convert both time specifications into a uniform format (minutes).

## Normalization of Time Specifications

The first step is to preprocess the time specifications. We will refer to these arguments as "Omega" during our calculations. The key aspects of preprocessing include:

1. **Padding the Time**: Ensure that each time has three components: days, hours, and minutes. If any component is missing, we will pad it with zeros on the left.

   For instance, the time "2:30" would be padded to "0:2:30" (0 days, 2 hours, and 30 minutes).

2. **Concatenating the Values**: After padding, we can concatenate the elements together for better visualization. 

   For the example above, the padded values for Time 1 (2:30) and Time 2 (5:15) could look like this:
   - Time 1: `0:2:30`
   - Time 2: `0:5:15`

   In APL, the concatenation of these values can be represented as follows:

   ```apl
   2 30  ,⍥{¯3↑⍵}  5 15
   ```

   This translates to:
   ```
   0 2 30 0 5 15
   ```

## Converting to Minutes

Next, we need to convert both time specifications to total minutes. In APL, we can use mixed radix number systems for this conversion:

- **Minutes in an Hour**: 60
- **Hours in a Day**: 24

Using these bases, we can represent the total minutes as:

- **Total minutes from Time 1** = `0*24*60 + 2*60 + 30`
- **Total minutes from Time 2** = `0*24*60 + 5*60 + 15`

In APL, we can perform this conversion as follows:

```apl
2 30  ,⍥{0 24 60⊥¯3↑⍵}  5 15
```
This would yield:
```
150 315
```

## Calculating the Absolute Difference

Once we have the total minutes calculated for both times, we can find the absolute difference. If the subtraction yields a negative result, we take the absolute value:

1. **Calculate Difference**: 
   - Difference = Total Minutes (Time 2) - Total Minutes (Time 1)

   We can perform the calculation as follows in APL:

   ```apl
   2 30  -⍥{0 24 60⊥¯3↑⍵}  5 15
   ```

   This operation results in:
   ```
   ¯165
   ```

2. **Take Absolute Value**:
   To obtain the absolute value, we can use the absolute value operator `|` in APL:

   ```apl
   2 30  |⍤-⍥{0 24 60⊥¯3↑⍵}  5 15
   ```

   The result will be:
   ```
   165
   ```

Thus, the absolute difference in minutes between the two times is 165 minutes.

## Conclusion

By following this method, we can effectively find the absolute difference between two time specifications, regardless of their initial formats. We hope this article has provided clarity on how to approach such problems. Thank you for reading!