+++
title = "JavaScript Hoisting and the Temporal Dead Zone: When Variables Exist But Don't"
description = "Understand the confusing behavior of variable hoisting and why let/const variables can exist but be inaccessible"
date = 2025-06-20
draft = false

[taxonomies]
categories = ["JavaScript", "Web Development"]
tags = ["JavaScript", "Temporal Dead Zone", "JS Weird Behaviors", "Programming"]

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

JavaScript's hoisting behavior can make code behave in unexpected ways, especially with the introduction of `let` and `const`.

## The Classic `var` Hoisting

```javascript
console.log(x); // undefined (not an error!)
var x = 5;

// This is effectively interpreted as:
var x;
console.log(x); // undefined
x = 5;
```

Variables declared with `var` are hoisted and initialized with `undefined`.

## Function Hoisting Surprise

```javascript
// This works!
sayHello(); // "Hello!"

function sayHello() {
  console.log("Hello!");
}

// But this doesn't!
sayHi(); // TypeError: sayHi is not a function

var sayHi = function() {
  console.log("Hi!");
};
```

Function declarations are fully hoisted, but function expressions aren't.

## The Temporal Dead Zone

```javascript
console.log(typeof x); // "undefined"
console.log(typeof y); // ReferenceError: Cannot access 'y' before initialization

let y = 5;
```

Variables declared with `let` and `const` are hoisted but remain in a "temporal dead zone" until their declaration is reached.

## The Loop Variable Trap

```javascript
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 100); // Prints 3, 3, 3
}

for (let j = 0; j < 3; j++) {
  setTimeout(() => console.log(j), 100); // Prints 0, 1, 2
}
```

The `var` version creates only one variable that's shared across all iterations, while `let` creates a new binding for each iteration.

## Class Hoisting Confusion

```javascript
const instance = new MyClass(); // ReferenceError

class MyClass {
  constructor() {
    this.name = "class";
  }
}
```

Unlike function declarations, class declarations are not hoisted in a way that allows them to be used before definition.

---