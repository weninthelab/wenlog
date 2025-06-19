+++
title = "JavaScript's Type Coercion Madness: When Numbers Become Strings and Logic Goes Wild"
description = "Explore the bizarre world of JavaScript type coercion with mind-bending examples that will make you question everything you know about data types"
date = 2025-06-20
draft = false

[taxonomies]
categories = ["JavaScript", "Web Development"]
tags = ["JavaScript", "Type Coercion", "JS Weird Behaviors", "Programming"]

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

JavaScript's type coercion is one of the most confusing aspects of the language. Let's dive into some examples that will blow your mind.

## The Classic `[] + []` Mystery

```javascript
[] + [] // ""
[] + {} // "[object Object]"
{} + [] // 0
{} + {} // "[object Object][object Object]" or NaN (depending on context)
```

Wait, what? How can adding two empty arrays result in an empty string? And why does the order matter with objects?

The answer lies in how JavaScript converts values during the addition operation:
- When using `+`, JavaScript tries to convert operands to primitives
- Arrays convert to strings by joining their elements
- Empty arrays become empty strings
- Objects convert to `"[object Object]"`

## The Infamous `0.1 + 0.2 !== 0.3`

```javascript
0.1 + 0.2 // 0.30000000000000004
0.1 + 0.2 === 0.3 // false
```

This isn't actually JavaScript's fault—it's how floating-point arithmetic works in binary. But it sure is confusing!

## Truthiness Gone Wrong

```javascript
"" == false // true
0 == false // true
[] == false // true
[] == ![] // true (this one is particularly mind-bending)
```

The last example is especially wild: an empty array equals its own negation!

## The `typeof null` Anomaly

```javascript
typeof null // "object"
typeof undefined // "undefined"
```

This is actually a bug that became part of the specification. `null` should logically return `"null"`, but for historical reasons, it returns `"object"`.

## Converting Everything to Numbers

```javascript
+[] // 0
+{} // NaN
+"" // 0
+"hello" // NaN
+true // 1
+false // 0
```

The unary `+` operator attempts to convert anything to a number, often with surprising results.

---