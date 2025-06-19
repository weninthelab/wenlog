+++
title = "The Mysterious World of JavaScript's `this` Keyword"
description = "Unravel the complexities of JavaScript's `this` binding with examples that demonstrate its unpredictable behavior in different contexts"
date = 2025-06-20
draft = false

[taxonomies]
categories = ["JavaScript", "Web Development"]
tags = ["JavaScript", "Keyword 'this'", "JS Weird Behaviors", "Programming"]

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

The `this` keyword in JavaScript is notoriously confusing. Its value depends on how a function is called, not where it's defined.

## Method vs Function Call Confusion

```javascript
const obj = {
  name: "Object",
  getName: function() {
    return this.name;
  }
};

obj.getName(); // "Object" - works as expected

const getName = obj.getName;
getName(); // undefined (or throws error in strict mode)
```

When you extract a method from an object, it loses its context!

## The Arrow Function Exception

```javascript
const obj = {
  name: "Object",
  regularFunction: function() {
    console.log(this.name); // "Object"
    
    const arrowFunction = () => {
      console.log(this.name); // "Object" - inherits from parent
    };
    
    function normalFunction() {
      console.log(this.name); // undefined
    }
    
    arrowFunction();
    normalFunction();
  }
};

obj.regularFunction();
```

Arrow functions don't have their own `this`—they inherit it from the enclosing scope.

## The Event Handler Surprise

```javascript
const button = document.querySelector('button');
const obj = {
  name: "Object",
  handleClick: function() {
    console.log(this.name); // undefined - `this` is the button element!
  }
};

button.addEventListener('click', obj.handleClick);
```

In event handlers, `this` refers to the element that triggered the event, not the object containing the method.

## Constructor Function Weirdness

```javascript
function Person(name) {
  this.name = name;
  return {differentObject: true}; // This overrides the instance!
}

const person1 = new Person("John");
console.log(person1.name); // undefined
console.log(person1.differentObject); // true
```

If a constructor explicitly returns an object, that object is returned instead of the new instance.

---