## crontab

```sh
# see a list of scheduled jobs for current user
crontab -l

# edit the list of cron jobs (opens default editor)
# e.g. in vim pres i to insert then esc :wq, or :qa! to abandon all changes
crontab -e

#  ___________  minute (0 - 59)
# |  _________  hour (0 - 23)
# | |  _______  day of month (1 - 31)
# | | |  _____  month (1 - 12)
# | | | |  ___  day of week (0 - 6, Sunday - Saturday)
# | | | | | 
# * * * * * command to exectute

# asterisk matches all values
# e.g. daily at midnight
# 0 0 * * * echo 'hello' >> ~/test.txt
# e.g. every minute of every day
* * * * * echo 'hello' >> ~/test.txt

cat ~/test.txt

# to view the actual crontab file
sudo cat /var/at/tabs/darrenkidney
```

`-l` list the current crontabs  
`-u` specify the name of the user whose crontab is to be changed  
`-r` remove the current crontab  
`-e` edit the current crontab

