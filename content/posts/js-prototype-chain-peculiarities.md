+++
title = "JavaScript Prototype Chain Peculiarities: When Objects Behave Unexpectedly"
description = "Explore the strange world of JavaScript prototypes and inheritance with examples that showcase unexpected behaviors"
date = 2025-06-20
draft = false

[taxonomies]
categories = ["JavaScript", "Web Development"]
tags = ["JavaScript", "Prototypes", "OOP", "JS Weird Behaviors", "Programming"]

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

JavaScript's prototype-based inheritance can lead to some very confusing behavior.

## The Array Length Mystery

```javascript
const arr = [1, 2, 3];
arr[100] = 'hello';
console.log(arr.length); // 101
console.log(arr[50]); // undefined
```

Setting an element at a high index immediately changes the array's length, creating "holes" filled with `undefined`.

## Prototype Pollution

```javascript
Array.prototype.extra = 'I should not be here';

const arr = [1, 2, 3];
for (const key in arr) {
  console.log(key); // 0, 1, 2, extra
}

// But...
for (const item of arr) {
  console.log(item); // 1, 2, 3 (no 'extra')
}
```

Modifying built-in prototypes affects all instances, but different iteration methods handle this differently.

## The Constructor Property Lie

```javascript
function Dog(name) {
  this.name = name;
}

const myDog = new Dog('Buddy');
console.log(myDog.constructor === Dog); // true

// But then...
Dog.prototype = {
  bark: function() {
    console.log('Woof!');
  }
};

const newDog = new Dog('Max');
console.log(newDog.constructor === Dog); // false!
console.log(newDog.constructor === Object); // true
```

Replacing the prototype object breaks the constructor reference.

## The instanceof Confusion

```javascript
function Parent() {}
function Child() {}

Child.prototype = Object.create(Parent.prototype);

const child = new Child();
console.log(child instanceof Child); // true
console.log(child instanceof Parent); // true

// But then...
Child.prototype = {};
console.log(child instanceof Child); // false!
```

Changing the prototype after creating instances can break `instanceof` checks.

## The Prototype Chain Loop

```javascript
const obj1 = {};
const obj2 = {};

obj1.__proto__ = obj2;
obj2.__proto__ = obj1; // Creates a cycle!

// This would cause infinite recursion in property lookup
try {
  console.log(obj1.someProperty);
} catch (e) {
  console.log("Cyclic prototype chain detected");
}
```

Creating cycles in the prototype chain can cause errors or infinite loops.

---