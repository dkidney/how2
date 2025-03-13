## sed

```sh
my_var="    hello    "
echo x${my_var}x

# remove leading spaces
my_var2=$(echo ${my_var} | sed "s/^[ ]*//")
echo x${my_var2}x
```
