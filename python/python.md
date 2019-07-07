python
================

  - [Links](#links)
  - [Background](#background)
  - [Installation](#installation)
  - [Objects](#objects)
      - [Variables](#variables)
          - [str](#str)
          - [int](#int)
          - [float](#float)
      - [Collections](#collections)
          - [list](#list)
          - [tuple](#tuple)
          - [set](#set)
          - [dict](#dict)
  - [Operators](#operators)
      - [Arithmetic Operators](#arithmetic-operators)
      - [Logical Operators](#logical-operators)
      - [Identity Operators](#identity-operators)
      - [Membership Operators](#membership-operators)
      - [Bitwise Operators](#bitwise-operators)
      - [Assignment Operators](#assignment-operators)
  - [Functions](#functions)
  - [Dates and times](#dates-and-times)
  - [Files](#files)
  - [Databases](#databases)
  - [OOP](#oop)
  - [numpy](#numpy)
  - [pandas](#pandas)
  - [scipy](#scipy)
  - [sklearn](#sklearn)
  - [random](#random)
  - [matplotlib](#matplotlib)
  - [Cython](#cython)
  - [IDEs](#ides)
      - [Pycharm](#pycharm)
      - [Thonny](#thonny)
      - [Netbeans](#netbeans)

-----

## Links

<https://www.w3schools.com/python/default.asp>

-----

## Background

  - created by Guido van Rossum
  - released in 1991

-----

## Installation

``` sh
which python
python --version
## /usr/bin/python
## Python 2.7.10
```

``` sh
conda activate dev3
which python
python --version
## sh: conda: command not found
## /usr/bin/python
## Python 2.7.10
```

``` r
knitr::opts_chunk$get("engine.path")$python
## [1] "/usr/local/Cellar/python/3.7.3/bin/python3"
```

-----

## Objects

### Variables

``` python
x, y, z = "a", 1, 2.2
print(type(x))
## <class 'str'>
print(type(y))
## <class 'int'>
print(type(z))
## <class 'float'>
```

#### str

Concatenate with `+`

``` python
print("Orange" + "Banana")
## OrangeBanana
```

Coerce/cast with `str()`

``` python
print(str(x))
## a
print(str(y))
## 1
print(str(z))
## 2.2
```

Create with `str()`

``` python
print(str(1))
## 1
print(str(2.8))
## 2.8
print(str("3"))
## 3
```

Use `"""` or `'''` for multiline strings

``` python
a = """Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."""
print(a)
## Lorem ipsum dolor sit amet,
## consectetur adipiscing elit,
## sed do eiusmod tempor incididunt
## ut labore et dolore magna aliqua.
```

Index with `[`

``` python
a = "Hello, World!"
print(a[0])
## H
print(a[0:5])
## Hello
print(a[-1])
## !
print(a[-6:])
## World!
```

Built-in functions

``` python
a = "    Hello, World!    "
print(len(a))
## 21
```

Methods

``` python
a = "    Hello, World!    "
print(a.lower())
##     hello, world!
print(a.upper())
##     HELLO, WORLD!
print(a.strip())
## Hello, World!
print(a.replace("H", "J"))
##     Jello, World!
print(a.split(","))
## ['    Hello', ' World!    ']
```

``` python
name = "Darren"
age = "41"
txt = "Hello, my name is {} and I am {}"
txt.format(name, age)
## 'Hello, my name is Darren and I am 41'
```

#### int

Coerce/cast with `int()`

``` python
# print(int(x)) # throws and error
print(int(y))
## 1
print(int(z))
## 2
```

Create with `int()`

``` python
print(int(1))
## 1
print(int(2.8))
## 2
print(int("3"))
## 3
```

#### float

Coerce/cast with `float()`

``` python
# print(float(x)) # throws and error
print(float(y))
## 1.0
print(float(z))
## 2.2
```

Create with `float()`

``` python
print(float(1))
## 1.0
print(float(2.8))
## 2.8
print(float("3"))
## 3.0
```

### Collections

| List          | Tuple            | Set               | Dictionary        |
| ------------- | ---------------- | ----------------- | ----------------- |
| ordered       | ordered          | **unordered**     | **unordered**     |
| changeable    | **unchangeable** | changeable        | changeable        |
| indexed       | indexed          | **unindexed**     | indexed           |
| duplicates ok | duplicates ok    | **no duplicates** | **no duplicates** |

#### list

``` python
x = ["apple", "banana", "cherry"]
print(type(x))
## <class 'list'>
print(x)
## ['apple', 'banana', 'cherry']
```

Indexing

``` python
print(x[0])
## apple
x[0] = "blackcurrant"
print(x)
## ['blackcurrant', 'banana', 'cherry']
```

Loops

``` python
for i in x:
  print(i)
## blackcurrant
## banana
## cherry
```

Querying

``` python
if "banana" in x: 
  print("I love bananas")
## I love bananas
```

Built-in functions

``` python
print(len(x))
## 3
```

Methods

``` python
x.append("orange")
print(x)
## ['blackcurrant', 'banana', 'cherry', 'orange']
```

``` python
x.insert(1, "pear")
print(x)
## ['blackcurrant', 'pear', 'banana', 'cherry', 'orange']
```

``` python
x.remove("banana")
print(x)
## ['blackcurrant', 'pear', 'cherry', 'orange']
```

``` python
x.pop()
## 'orange'
print(x)
## ['blackcurrant', 'pear', 'cherry']
```

``` python
print(x.count("cherry"))
## 1
```

``` python
x.extend(["plum"])
print(x)
## ['blackcurrant', 'pear', 'cherry', 'plum']
```

``` python
print(x.index("plum"))
## 3
```

``` python
x.reverse()
print(x)
## ['plum', 'cherry', 'pear', 'blackcurrant']
```

``` python
x.sort()
print(x)
## ['blackcurrant', 'cherry', 'pear', 'plum']
```

``` python
a = x # shallow copy
b = x.copy() # deep copy
c = list(x) # deep copy
x.clear()
print(x)
## []
print(a)
## []
print(b)
## ['blackcurrant', 'cherry', 'pear', 'plum']
print(c)
## ['blackcurrant', 'cherry', 'pear', 'plum']
```

Keywords

``` python
x = ["apple", "banana", "cherry"]
del x[0]
print(x)
## ['banana', 'cherry']
del x
# print(x) # throws an error
```

#### tuple

``` python
x = ("apple", "banana", "cherry")
print(type(x))
## <class 'tuple'>
print(x)
## ('apple', 'banana', 'cherry')
```

#### set

``` python
x = {"apple", "banana", "cherry"}
print(type(x))
## <class 'set'>
print(x)
## {'cherry', 'banana', 'apple'}
```

#### dict

``` python
x = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
print(type(x))
## <class 'dict'>
print(x)
## {'brand': 'Ford', 'model': 'Mustang', 'year': 1964}
```

-----

## Operators

### Arithmetic Operators

`%` - modulus  
`**` - exponentiation `//` - floor division

### Logical Operators

`x < 5 and x < 10`  
`x < 5 or x < 4`  
`not(x < 5 and x < 10)`

### Identity Operators

`x is y`  
`x is not y`

### Membership Operators

`x in y`  
`x not in y`

### Bitwise Operators

`&` : binary AND  
`|` : binary OR  
`^` : binary XOR  
`~` : binary flip bits `<<` : binary left shift  
`>>` : binary right shift

``` python
a = 60 # 60 = 0011 1100 
b = 13 # 13 = 0000 1101 
print(a & b)  #  12 = 0000 1100 
## 12
print(a | b)  #  61 = 0011 1101
## 61
print(a ^ b)  #  49 = 0011 0001
## 49
print(~a)     # -61 = 1100 0011
## -61
print(a << 2) # 240 = 1111 0000
## 240
print(a >> 2) #  15 = 0000 1111
## 15
```

### Assignment Operators

`x += 3` is the same as `x = x + 3`  
`x -= 3` is the same as `x = x - 3`  
`x *= 3` is the same as `x = x * 3`  
`x /= 3` is the same as `x = x / 3`  
`x %= 3` is the same as `x = x % 3`  
`x //= 3` is the same as `x = x // 3`  
`x **= 3` is the same as `x = x ** 3`  
`x ^= 3` is the same as `x = x ^ 3`  
`x &= 3` is the same as `x = x & 3`  
`x |= 3` is the same as `x = x | 3`

-----

## Functions

-----

## Dates and times

-----

## Files

-----

## Databases

-----

## OOP

-----

## numpy

``` python
import numpy as np
np.__version__
## '1.15.0'
```

-----

## pandas

``` python
import pandas as pd
pd.__version__
## '0.23.4'
```

-----

## scipy

``` python
import scipy
scipy.__version__
## '1.1.0'
```

-----

## sklearn

``` python
import sklearn
sklearn.__version__
## '0.19.2'
```

-----

## random

``` python
import random
print(random.randrange(1,10))
## 4
```

-----

## matplotlib

``` python
# import matplotlib
# matplotlib.__version__
```

-----

## Cython

-----

## IDEs

### Pycharm

### Thonny

### Netbeans

-----
