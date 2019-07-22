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
  - [Operators](#operators)
  - [Functions](#functions)
  - [Dates and times](#dates-and-times)
  - [Files](#files)
  - [Databases](#databases)
  - [Classes](#classes)
  - [scipy](#scipy)
  - [numpy](#numpy)
      - [arrays](#arrays)
          - [attributes](#attributes)
          - [indexing](#indexing)
          - [methods](#methods)
          - [constructors](#constructors)
          - [other functions](#other-functions)
  - [pandas](#pandas)
  - [sklearn](#sklearn)
  - [statsmodels](#statsmodels)
  - [random](#random)
  - [matplotlib](#matplotlib)
  - [Cython](#cython)
  - [IDEs](#ides)
      - [Pycharm](#pycharm)
      - [Spyder](#spyder)
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
## [1] "~/anaconda3/envs/dev3/bin/python"
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

| property                      | list     | tuple     | set     | dict     |
| :---------------------------- | -------- | --------- | ------- | -------- |
| ordered                       | yes      | yes       |         |          |
| changeable                    | yes      |           | yes     | yes      |
| indexed                       | yes      | yes       |         | yes      |
| duplicates allowed            | yes      | yes       |         |          |
| constructor                   | `[]`     | `()`      | `{}`    | `{}`     |
|                               |          |           |         |          |
| **method**                    | **list** | **tuple** | **set** | **dict** |
| `add`                         |          |           | yes     |          |
| `append`                      | yes      |           |         |          |
| `clear`                       | yes      |           | yes     | yes      |
| `copy`                        | yes      |           | yes     | yes      |
| `count`                       | yes      | yes       |         |          |
| `difference`                  |          |           | yes     |          |
| `difference_update`           |          |           | yes     |          |
| `discard`                     |          |           | yes     |          |
| `extend`                      | yes      |           |         |          |
| `fromkeys`                    |          |           |         | yes      |
| `get`                         |          |           |         | yes      |
| `index`                       | yes      | yes       |         |          |
| `insert`                      | yes      |           |         |          |
| `intersection`                |          |           | yes     |          |
| `intersection_update`         |          |           | yes     |          |
| `isdispoint`                  |          |           | yes     |          |
| `issubset`                    |          |           | yes     |          |
| `issuperset`                  |          |           | yes     |          |
| `items`                       |          |           |         | yes      |
| `keys`                        |          |           |         | yes      |
| `pop`                         | yes      |           | yes     | yes      |
| `popitems`                    |          |           |         | yes      |
| `remove`                      | yes      |           | yes     |          |
| `reverse`                     | yes      |           |         |          |
| `setdefault`                  |          |           |         | yes      |
| `sort`                        | yes      |           |         |          |
| `symmetric_difference`        |          |           | yes     |          |
| `symmetric_difference_update` |          |           | yes     |          |
| `union`                       |          |           | yes     |          |
| `update`                      |          |           | yes     | yes      |
| `values`                      |          |           |         | yes      |

Constructors:

``` python
l = ["apple", "banana", "cherry"]
t = ("apple", "banana", "cherry")
s = {"apple", "banana", "cherry"}
d = {"apple" : "green", "banana" : "yellow", "cherry" : "red"}
```

Alternative constructors:

``` python
l = list(("apple", "banana", "cherry"))
t = tuple(("apple", "banana", "cherry"))
s = set(("apple", "banana", "cherry"))
d = dict(apple = "green", banana = "yellow", cherry = "red")
```

Class:

``` python
type(l)
## <class 'list'>
type(t)
## <class 'tuple'>
type(s)
## <class 'set'>
type(d)
## <class 'dict'>
```

Built-in functions:

``` python
len(l)
## 3
len(t)
## 3
len(s)
## 3
len(d)
## 3
```

Indexing:

``` python
l[0]
## 'apple'
t[0]
# s[0] # throws an error
# d[0] # throws an error
## 'apple'
d["apple"]
## 'green'
```

Loops:

``` python
for element in l: print(element)
## apple
## banana
## cherry
for element in t: print(element)
## apple
## banana
## cherry
for element in s: print(element)
## apple
## cherry
## banana
for key in d: print(key) # print keys
## apple
## banana
## cherry
for key in d: print(d[key]) # print values
## green
## yellow
## red
for value in d.values(): print(value)  # print values
## green
## yellow
## red
for key, value in d.items(): print(key, value) # print keys and values
## apple green
## banana yellow
## cherry red
```

Querying:

``` python
if "banana" in l: print("I love bananas")
## I love bananas
if "banana" in t: print("I love bananas")
## I love bananas
if "banana" in s: print("I love bananas")
## I love bananas
if "banana" in d: print("I love bananas")
## I love bananas
```

Set methods:

``` python
s.add("orange")
s.update(["mango", "grapes"])
print(s)
## {'apple', 'banana', 'grapes', 'cherry', 'orange', 'mango'}
s.discard("pear") # no error
# s.remove("pear") # error
```

Dict methods:

``` python
d["apple"]
## 'green'
d.get("model")
d["apple"] = "red"
d["pear"] = "green"
print(d)
## {'apple': 'red', 'banana': 'yellow', 'cherry': 'red', 'pear': 'green'}
d.popitem()
## ('pear', 'green')
print(d)
## {'apple': 'red', 'banana': 'yellow', 'cherry': 'red'}
```

Keywords:

``` python
del l[0]
print(l)
# del t[0] # throws an error
# del s[0] # throws an error
# del d[0] # throws an error
## ['banana', 'cherry']
del d["cherry"]
print(d)
## {'apple': 'red', 'banana': 'yellow'}
```

``` python
del l
del t
del s
del d
```

-----

## Operators

**Arithmetic**

`%` - modulus  
`**` - exponentiation  
`//` - floor division

**Logical**

`x < 5 and x < 10`  
`x < 5 or x < 4`  
`not(x < 5 and x < 10)`

**Identity**

`x is y`  
`x is not y`

**Membership**

`x in y`  
`x not in y`

**Bitwise**

`&` : binary AND  
`|` : binary OR  
`^` : binary XOR  
`~` : binary flip bits  
`<<` : binary left shift  
`>>` : binary right shift

``` python
a = 60        #  60 = 0011 1100 
b = 13        #  13 = 0000 1101 
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

**Assignment**

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

Loops: range (X), Iterators Error handling Scripting - passing args via
command line Modules - write your own Modules built in datetime json Sys
Os Re Oop File paths Database connections Numpy Pandas Scipy Sklearn
Matplotlib Boto3

-----

## Dates and times

-----

## Files

-----

## Databases

-----

## Classes

-----

## scipy

<https://scipy.org/>

``` python
import scipy
scipy.__version__
## '1.3.0'
```

-----

## numpy

<https://www.numpy.org/>

  - numerical python
  - the core library for scientific computing in Python  
  - provides a high-performance multidimensional array object and tools
    for working with these arrays (base python arrays are only
    1-dimensional)

### arrays

  - NumPy’s array class is called `ndarray`
  - all elements must be the same type

<!-- end list -->

``` python
import numpy as np
np.__version__
## '1.14.3'
```

``` python
# create an array from a regular Python list 
myarray = np.array([[ 1., 2., 3.],  
                    [ 4., 5., 6.]])
print(myarray)
## [[1. 2. 3.]
##  [4. 5. 6.]]
```

#### attributes

``` python
myarray.ndim
## 2
myarray.shape
## (2, 3)
myarray.dtype
## dtype('float64')
myarray.size
## 6
myarray.itemsize
## 8
myarray.data
## <memory at 0x10b7bb120>
```

#### indexing

``` python
# first row, first column
myarray[0,0]
## 1.0
myarray[1,1]
## 5.0
myarray[:2, 1:3]
## array([[2., 3.],
##        [5., 6.]])
```

#### methods

``` python
myarray.reshape((3,2))
## array([[1., 2.],
##        [3., 4.],
##        [5., 6.]])
myarray.ravel() 
# myarray.view() # shallow copy
# myarray.copy() # deep copy
## array([1., 2., 3., 4., 5., 6.])
```

#### constructors

``` python
np.empty((3,4))
## array([[1.72723371e-077, 2.00390361e+000, 2.96439388e-323,
##         5.53036517e+228],
##        [4.94065646e-322, 0.00000000e+000, 1.11997636e+093,
##         4.15015143e-322],
##        [0.00000000e+000, 4.89584003e-085, 4.89209922e-085,
##         8.97628402e-309]])
np.zeros((3,4))
## array([[0., 0., 0., 0.],
##        [0., 0., 0., 0.],
##        [0., 0., 0., 0.]])
np.ones((3,4))
## array([[1., 1., 1., 1.],
##        [1., 1., 1., 1.],
##        [1., 1., 1., 1.]])
np.arange(12).reshape((3,4))
## array([[ 0,  1,  2,  3],
##        [ 4,  5,  6,  7],
##        [ 8,  9, 10, 11]])
np.linspace(0, 1, 12).reshape((3,4)) 
## array([[0.        , 0.09090909, 0.18181818, 0.27272727],
##        [0.36363636, 0.45454545, 0.54545455, 0.63636364],
##        [0.72727273, 0.81818182, 0.90909091, 1.        ]])
```

#### other functions

``` python
np.random.random((2,3))
# np.add
# np.hstack
# np.vstack
# np.hsplit
# np.vsplit
## array([[0.79429689, 0.36872961, 0.37337635],
##        [0.18483094, 0.49205573, 0.37447407]])
```

-----

## pandas

<https://pandas.pydata.org/>

``` python
import pandas as pd
pd.__version__
## '0.24.2'
```

-----

## sklearn

``` python
import sklearn
sklearn.__version__
## '0.21.2'
```

-----

## statsmodels

<http://www.statsmodels.org/stable/index.html>

-----

## random

``` python
import random
print(random.randrange(1,10))
## 5
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

Set interpreter as conda env:

`PyCharm > Preferences > Project: [my project] > Project Interpreter >
Project Interpreter... > [Settings wheel] > Add... > Conda Environment >
Existing Environment > Interpreter`

### Spyder

### Thonny

### Netbeans

-----

Attribute Data that is associated with an instance Accessed using
object.attribute A variable Can have class attributes or instance
attributes accessed in the same way via a ‘dot’ If same name used for
both class and instance attribute then instance attribute is accessed
first = attribute lookup order print dir(x)

Augmented assignment E.g. replace x = x + 1, with x += 1

Class A blueprint for an instance - an ‘instance factory’ Class
constructor functions conventionally start with a capital letter Classes
are also objects

Decorators A processor that modifies a function Start with @ E.g for
modifying the default binding that instance methods provide:
@classmethod takes the class as input not the instance @staticmethod
requires no args and does not work with the class or the instance

Encapsulation One of the three pillars of OOP Refers to the safe storage
of data (as attributes) in an instance E.g. setter methods to safely
set/modify instance attributes

Getter method A method that gets attribute values from the instance

Inheritance One of the three pillars of OOP

**init** Special constructor method that allows us to initialise
attributes at the time an instance is constructed Called automatically
whenever a new instance is constructed Optional - you don’t have to use
it if you don’t need it (an example of a ‘magic’ function) (Underscores
signify private method, intended for use internally)

Instance a constructed object of a given class

**main** refers to the namespace of the script currently being executed

Method a callable attribute defined in the class allows you to change
the state of the instance A method on an instance always implicitly
passes the instance as the first argument to the method When the
function is defined in the class, the instance argument is represented
by ‘self’ ‘self’ is the instance upon which the method was called
Instance methods are known as ‘bound’ methods- i.e. they are bound to
the instance upon which they are called

Method resolution order (MRO) The order of lookup when an object
inherits from multiple classes Depth first

None When a function doesn’t return anything it actually returns the
None value

Object a unit of data (i.e. attributes) of a particular type (i.e. an
instance of a class) with associated functionality (i.e. methods)

Object-Oriented Programming (OOP) A paradigm for code organization and
design Data organised into objects Functionality organised into methods
Helps manage complexity Primary paradigm for software design

Polymorphism One of the three pillars of OOP Use the same interface for
different classes - e.g. use len() on a string or a list. E.g. call
dir(obj) and you may see things like **len**, which means you can access
the obj.\_\_len\_\_() method via the built-in function len -
i.e. len(obj)

Setter method A method that sets attribute values of the instance

State the values of the attributes of an instance

Type indicates the class the instance belongs to
