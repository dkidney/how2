
cd
pwd
touch \
2017-log-tmp-44.txt \
2017-log-tmp-45.txt \
2017-log-tmp-46.txt \
2017-log-3312.txt \
2017-log-3313.txt \
2017-log-3314.txt

mkdir tempfiles
mv *-tmp-* tempfiles
ls -al tempfiles


touch states.txt
egrep "[AEIUO]" states.txt
egrep "^[AEIUO]" states.txt
egrep "^M.*a$" states.txt

touch iago.txt
egrep "\W\sA" iago.txt
egrep "\w{3}\s\w{3}$" iago.txt
egrep "[a-g]\s{1,3}good" iago.txt
egrep "[a-g]\s{1,3}good" iago.txt

cat states.txt states.txt > states2.txt
cat states.txt
cat states2.txt
md5 states.txt
md5 states2.txt
shasum states2.txt

# 8d7dd71ff51614e69339b03bd1cb86ac # no
34a49d8cf25f28afca798561eaa8a623
f9030deb7670294c44cfd46557ee819d
77f7ca8608f7c204143a0238bbbfb759
