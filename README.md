# `brackets`

A lightweight Dart package for building and rendering markup (HTML/XML).

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Markup](#basic-markup)
  - [Working with HTML](#working-with-html)
  - [Working with XML](#working-with-xml)
  - [Attributes](#attributes)

## Overview

`brackets` offers a concise way to create markup structures in Dart using a unique approach based on Dart's extension methods and operators. Instead of providing a fluent API, it leverages extensions to create a terse, yet powerful markup generation system.

The resulting structure is an Abstract Syntax Tree (AST), which is represented using Algebraic Data Types (ADTs). This allows for easy manipulation and transformation of the markup structure.

## Installation

Add to your pubspec.yaml:

```yaml
dependencies:
  brackets: ^1.0.0
```

## Usage

### Basic Markup

Create simple markup nodes:

```dart
final node = 'div'(['Hello'.$]);
print(node.render());
```

Output:

```html
<div>Hello</div>
```

### Working with HTML

Build complete HTML documents:

```dart
final document = html([
  'head'([
    'title'(['My Page'.$]),
  ]),
  'body'([
    'h1'(['Welcome'.$]),
    'p'(['Content here'.$]),
  ]),
]);

print(document.render());
```

Output:

```html
<!DOCTYPE html><html><head><title>My Page</title></head><body><h1>Welcome</h1><p>Content here</p></body></html>
```

### Working with XML

Create XML documents:

```dart
final xmlDoc = xml([
  'root'([
    'child'(['data'.$]),
  ]),
]);

print(xmlDoc.render());
```

Output:

```html
<?xml version="1.0" encoding="UTF-8"?><root><child>data</child></root>
```

### Attributes

Add attributes to tags:

```dart
final element = 'div'(
  ['Content'.$],
  attrs: {'class': 'container', 'id': 'main'},
);

print(element.render());
```

Output:

```html
<div class="container" id="main">Content</div>
```

For more examples, check the example file.