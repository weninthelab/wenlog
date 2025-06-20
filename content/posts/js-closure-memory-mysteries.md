+++
title = "Closures & Memory Mysteries"
description = "Dive deep into JavaScript closures and discover how they can create unexpected behavior and memory issues"
date = 2025-06-07
draft = false

[taxonomies]
categories = ["JavaScript", "Web Development"]
tags = ["JavaScript", "Closures", "JS Weird Behaviors", "Programming"]

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

Closures are powerful but can lead to confusing behavior and memory leaks if not understood properly.

## The Counter Dilemma

```javascript
function createCounters() {
  const counters = [];
  for (var i = 0; i < 3; i++) {
    counters.push(function() {
      return i; // All functions return 3!
    });
  }
  return counters;
}

const counters = createCounters();
console.log(counters[0]()); // 3
console.log(counters[1]()); // 3
console.log(counters[2]()); // 3
```

All closures share the same variable `i`, which has the value 3 after the loop completes.

## The IIFE Solution

```javascript
function createCounters() {
  const counters = [];
  for (var i = 0; i < 3; i++) {
    counters.push((function(index) {
      return function() {
        return index;
      };
    })(i));
  }
  return counters;
}

const counters = createCounters();
console.log(counters[0]()); // 0
console.log(counters[1]()); // 1
console.log(counters[2]()); // 2
```

Using an IIFE (Immediately Invoked Function Expression) creates a new scope for each iteration.

## Memory Leak Through Closures

```javascript
function createHandler() {
  const bigData = new Array(1000000).fill('data');
  
  return function() {
    console.log('Handler called');
    // bigData is still referenced and can't be garbage collected!
  };
}

const handler = createHandler();
// The bigData array remains in memory as long as handler exists
```

Even if you don't use variables in a closure, they might still be kept in memory.

## The Module Pattern Confusion

```javascript
const module = (function() {
  let privateVar = 0;
  
  return {
    increment: function() {
      privateVar++;
    },
    getCount: function() {
      return privateVar;
    },
    // This creates a problem!
    reset: () => {
      privateVar = 0; // Arrow function doesn't have access to privateVar!
    }
  };
})();
```

Mixing regular functions and arrow functions in the module pattern can create scope issues.

---