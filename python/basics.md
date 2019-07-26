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
```

    ## /usr/bin/python
    ## Python 2.7.10

``` sh
conda activate dev3
which python
python --version
```

    ## sh: conda: command not found
    ## /usr/bin/python
    ## Python 2.7.10

``` r
knitr::opts_chunk$get("engine.path")$python
```

    ## NULL

-----

## Objects

### Variables

``` python
x, y, z = "a", 1, 2.2
print(type(x))
```

    ## <type 'str'>

``` python
print(type(y))
```

    ## <type 'int'>

``` python
print(type(z))
```

    ## <type 'float'>

#### str

Concatenate with `+`

``` python
print("Orange" + "Banana")
```

    ## OrangeBanana

Coerce/cast with `str()`

``` python
print(str(x))
```

    ## a

``` python
print(str(y))
```

    ## 1

``` python
print(str(z))
```

    ## 2.2

Create with `str()`

``` python
print(str(1))
```

    ## 1

``` python
print(str(2.8))
```

    ## 2.8

``` python
print(str("3"))
```

    ## 3

Use `"""` or `'''` for multiline strings

``` python
a = """Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."""
print(a)
```

    ## Lorem ipsum dolor sit amet,
    ## consectetur adipiscing elit,
    ## sed do eiusmod tempor incididunt
    ## ut labore et dolore magna aliqua.

Index with `[`

``` python
a = "Hello, World!"
print(a[0])
```

    ## H

``` python
print(a[0:5])
```

    ## Hello

``` python
print(a[-1])
```

    ## !

``` python
print(a[-6:])
```

    ## World!

Built-in functions

``` python
a = "    Hello, World!    "
print(len(a))
```

    ## 21

Methods

``` python
a = "    Hello, World!    "
print(a.lower())
```

    ##     hello, world!

``` python
print(a.upper())
```

    ##     HELLO, WORLD!

``` python
print(a.strip())
```

    ## Hello, World!

``` python
print(a.replace("H", "J"))
```

    ##     Jello, World!

``` python
print(a.split(","))
```

    ## ['    Hello', ' World!    ']

``` python
name = "Darren"
age = "41"
txt = "Hello, my name is {} and I am {}"
txt.format(name, age)
```

    ## 'Hello, my name is Darren and I am 41'

#### int

Coerce/cast with `int()`

``` python
# print(int(x)) # throws and error
print(int(y))
```

    ## 1

``` python
print(int(z))
```

    ## 2

Create with `int()`

``` python
print(int(1))
```

    ## 1

``` python
print(int(2.8))
```

    ## 2

``` python
print(int("3"))
```

    ## 3

#### float

Coerce/cast with `float()`

``` python
# print(float(x)) # throws and error
print(float(y))
```

    ## 1.0

``` python
print(float(z))
```

    ## 2.2

Create with `float()`

``` python
print(float(1))
```

    ## 1.0

``` python
print(float(2.8))
```

    ## 2.8

``` python
print(float("3"))
```

    ## 3.0

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
```

    ## <type 'list'>

``` python
type(t)
```

    ## <type 'tuple'>

``` python
type(s)
```

    ## <type 'set'>

``` python
type(d)
```

    ## <type 'dict'>

Built-in functions:

``` python
len(l)
```

    ## 3

``` python
len(t)
```

    ## 3

``` python
len(s)
```

    ## 3

``` python
len(d)
```

    ## 3

Indexing:

``` python
l[0]
```

    ## 'apple'

``` python
t[0]
# s[0] # throws an error
# d[0] # throws an error
```

    ## 'apple'

``` python
d["apple"]
```

    ## 'green'

Loops:

``` python
for element in l: print(element)
```

    ## apple
    ## banana
    ## cherry

``` python
for element in t: print(element)
```

    ## apple
    ## banana
    ## cherry

``` python
for element in s: print(element)
```

    ## cherry
    ## apple
    ## banana

``` python
for key in d: print(key) # print keys
```

    ## cherry
    ## banana
    ## apple

``` python
for key in d: print(d[key]) # print values
```

    ## red
    ## yellow
    ## green

``` python
for value in d.values(): print(value)  # print values
```

    ## red
    ## yellow
    ## green

``` python
for key, value in d.items(): print(key, value) # print keys and values
```

    ## ('cherry', 'red')
    ## ('banana', 'yellow')
    ## ('apple', 'green')

Querying:

``` python
if "banana" in l: print("I love bananas")
```

    ## I love bananas

``` python
if "banana" in t: print("I love bananas")
```

    ## I love bananas

``` python
if "banana" in s: print("I love bananas")
```

    ## I love bananas

``` python
if "banana" in d: print("I love bananas")
```

    ## I love bananas

Set methods:

``` python
s.add("orange")
s.update(["mango", "grapes"])
print(s)
```

    ## set(['apple', 'cherry', 'mango', 'grapes', 'orange', 'banana'])

``` python
s.discard("pear") # no error
# s.remove("pear") # error
```

Dict methods:

``` python
d["apple"]
```

    ## 'green'

``` python
d.get("model")
d["apple"] = "red"
d["pear"] = "green"
print(d)
```

    ## {'cherry': 'red', 'pear': 'green', 'banana': 'yellow', 'apple': 'red'}

``` python
d.popitem()
```

    ## ('cherry', 'red')

``` python
print(d)
```

    ## {'pear': 'green', 'banana': 'yellow', 'apple': 'red'}

Keywords:

``` python
del l[0]
print(l)
# del t[0] # throws an error
# del s[0] # throws an error
# del d[0] # throws an error
#del d["cherry"]
#print(d)
```

    ## ['banana', 'cherry']

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
```

    ## 12

``` python
print(a | b)  #  61 = 0011 1101
```

    ## 61

``` python
print(a ^ b)  #  49 = 0011 0001
```

    ## 49

``` python
print(~a)     # -61 = 1100 0011
```

    ## -61

``` python
print(a << 2) # 240 = 1111 0000
```

    ## 240

``` python
print(a >> 2) #  15 = 0000 1111
```

    ## 15

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
