+++
title = "JavaScript Equality and Comparison Weirdness: When Equal Doesn't Mean Equal"
description = "Discover the bizarre world of JavaScript equality operators and comparison logic that can make experienced developers question reality"
date = 2025-06-13
draft = false

[taxonomies]
categories = ["JavaScript"]
tags = ["JavaScript", "Operators", "JS Weird Behaviors", "Programming"]

[extra]
lang = "en"
toc = true
comment = false
copy = true
outdate_alert = false
outdate_alert_days = 120
math = false
mermaid = false
featured = false
reaction = false
+++

JavaScript's equality and comparison operators can produce results that seem to defy logic.

## The Triple Equality That Isn't

```javascript
NaN === NaN // false
Number.NaN === Number.NaN // false

// But...
Object.is(NaN, NaN) // true
```

`NaN` is the only value in JavaScript that is not equal to itself!

## The Transitive Property Violation

```javascript
const a = {};
const b = {};
const c = {};

a == b // false
b == c // false
a == c // false

// But with type coercion...
"0" == 0 // true
0 == [] // true
"0" == [] // false (violates transitivity!)
```

The `==` operator can violate the transitive property of equality.

## The Array Comparison Madness

```javascript
[] == [] // false (different objects)
[] == ![] // true (type coercion madness)
[] == 0 // true
[] == "0" // false
[] == "" // true

[1] == 1 // true
[1, 2] == "1,2" // true
```

Arrays compare by reference, but when coerced, they become strings.

## The Object.is Peculiarities

```javascript
Object.is(+0, -0) // false
+0 === -0 // true

Object.is(NaN, NaN) // true
NaN === NaN // false
```

`Object.is` treats positive and negative zero as different but considers `NaN` equal to itself.

## The typeof Operator Lies

```javascript
typeof [] // "object" (arrays are objects)
typeof null // "object" (historical bug)
typeof function() {} // "function" (functions are objects too)

// But...
Array.isArray([]) // true
```

The `typeof` operator doesn't always tell the whole truth about data types.

## The Comparison Operator Confusion

```javascript
"10" > "9" // false (string comparison is lexicographical)
"10" > 9 // true (string converts to number)

null > 0 // false
null == 0 // false
null >= 0 // true (null converts to 0 in comparisons)
```

Comparison and equality operators handle type conversion differently.

---