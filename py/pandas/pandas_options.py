import pandas as pd

pd.describe_option() # describe all registered options

pd.describe_option("display.max_rows") # describe listed option(s)
pd.get_option("display.max_rows")
pd.set_option("display.max_rows", 100)
pd.reset_option("display.max_rows") # resets to default value

# other settings
pd.set_option("display.max_columns", None) # don't hide any columns
pd.set_option("display.max_colwidth", 1000)
pd.set_option("display.width", 1000)

# context manager
with pd.option_context(
    'display.max_rows', 10, 
    'display.max_columns', 5,
):
    print(df)
