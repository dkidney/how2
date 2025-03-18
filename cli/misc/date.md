## date

```sh
date
# Tue Mar 18 09:20:29 GMT 2025

date -u
# Tue Mar 18 09:20:41 UTC 2025

date -u -I
# 2025-03-18

date -u "+%Y%m%d"  
# 20250318

date -u  "+%Y-%m-%d"
# 2025-03-18

date -u  "+%D"
# 03/18/25

date -u  "+%D %T"
# 03/18/25 09:23:00
```

```sh
yyyymmdd=$(date -u "+%Y%m%d") && echo ${yyyymmdd}
```