## sed

> stream editor

https://www.gnu.org/software/sed/manual/sed.html

### examples

```sh
sed 's/pattern/replacement/' input_file > output_file

# modify input_file inplace
sed -i 's/pattern/replacement/' input_file

# suppress output
sed -n 's/pattern/replacement/' input_file
```

```sh
my_var="    hello    "
echo x${my_var}x

# remove leading spaces
my_var2=$(echo ${my_var} | sed "s/^[ ]*//")
echo x${my_var2}x

# remove trailing spaces
my_var3=$(echo ${my_var2} | sed "s/[ ]*$//")
echo x${my_var3}x
```

### args

```
```
