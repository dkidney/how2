import pandas as pd

# .describe_option()
# .get_option()
# .set_option()
# .reset_option()

# examples
pd.describe_option() # describe all registered options
pd.describe_option('display.max_columns') # describe listed option(s)
pd.get_option('display.max_columns')
pd.set_option('display.max_columns', 100)
pd.set_option('display.max_columns', None) # don't hide any columns
pd.reset_option('display.max_columns') # resets to default value

# set_option
pd.set_option('display.max_rows', 1000)
pd.set_option('display.max_columns', 1000)
pd.set_option('display.max_colwidth', 1000)
pd.set_option('display.width', 1000)
pd.set_option('display.float_format', '{:2f}'.format)

# context manager
with pd.option_context(
    'display.max_rows', 1000, 
    'display.max_columns', 1000,
    'display.max_colwidth', 1000,
    'display.width', 1000,
    'display.float_format', '{:2f}'.format
):
    print(df)
