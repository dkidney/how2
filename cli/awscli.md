# awscli

```sh
# sync only .txt and .csv files
aws s3 sync src_dir tgt_dir \
  --recursive \
  --exclude "*" \
  --include "*.txt" \
  --include "*.csv"
```