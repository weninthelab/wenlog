+++
title = "Asynchronous Chaos in JavaScript"
description = "Navigate the confusing world of JavaScript's asynchronous behavior with examples of event loops, promises, and timing issues"
date = 2025-06-11
draft = false

[taxonomies]
categories = ["JavaScript", "Web Development"]
tags = ["JavaScript", "Async", "Promises", "JS Weird Behaviors", "Programming"]

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

JavaScript's asynchronous nature can create execution orders that seem to defy logic.

## The Event Loop Surprise

```javascript
console.log('1');

setTimeout(() => console.log('2'), 0);

Promise.resolve().then(() => console.log('3'));

console.log('4');

// Output: 1, 4, 3, 2
```

Even with a 0ms timeout, the Promise resolves first due to the microtask queue having higher priority.

## The Promise Constructor Trap

```javascript
const promise = new Promise((resolve, reject) => {
  console.log('Inside Promise constructor'); // This runs immediately!
  resolve('done');
});

console.log('After Promise creation');

promise.then(result => console.log(result));

// Output:
// Inside Promise constructor
// After Promise creation
// done
```

The Promise constructor function runs synchronously, not asynchronously.

## The Async/Await Confusion

```javascript
async function asyncFunction() {
  console.log('1');
  await Promise.resolve();
  console.log('2');
}

console.log('3');
asyncFunction();
console.log('4');

// Output: 3, 1, 4, 2
```

The `await` keyword makes the function pause, allowing other synchronous code to run.

## The Promise.all Pitfall

```javascript
const promises = [
  Promise.resolve(1),
  Promise.reject('error'),
  Promise.resolve(3)
];

Promise.all(promises)
  .then(results => console.log('Success:', results))
  .catch(error => console.log('Error:', error));

// Even though two promises succeed, the entire operation fails
// Output: Error: error
```

`Promise.all` fails fast—if any promise rejects, the entire operation fails.

## The setTimeout vs setImmediate Confusion

```javascript
setTimeout(() => console.log('setTimeout'), 0);
setImmediate(() => console.log('setImmediate'));

// In Node.js, the order can vary!
// Sometimes: setTimeout, setImmediate
// Sometimes: setImmediate, setTimeout
```

The execution order between `setTimeout(0)` and `setImmediate` is not guaranteed in Node.js.

---