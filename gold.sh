#!/bin/bash

dates=( `cat gold.txt | grep '8grams' | grep -v grep | awk -F ' ' '{print $9}' | awk '{printf "%s ",$0} END {print ""}'` )
price_1g=( `cat gold.txt | grep 'per gram' | grep -v grep | awk -F ' ' '{print $11}' | paste -sd ' ' -` )
price_8g=( `cat gold.txt | grep '8grams' | grep -v grep | awk -F ' ' '{print $11}' | paste -sd ' ' -` )

mailId="saran.3668@gmail.com arunkumar.feb@gmail.com geetha.mar62@gmail.com"

if [ -f ~/saran/gold/goldRate.html ]
then
rm ~/saran/gold/goldRate.html
cp ~/saran/gold/goldRate.html_bk ~/saran/gold/goldRate.html
else
sleep 1s
fi


for (( i = 0 ; i < ${#dates[@]} ; i++ ))
do
{

sed -i -- 's/date'$i'/'${dates[$i]}'/g' ~/saran/gold/goldRate.html
sed -i -- 's/1gprice'$i'/'${price_1g[$i]}'/g' ~/saran/gold/goldRate.html
sed -i -- 's/8gprice'$i'/'${price_8g[$i]}'/g' ~/saran/gold/goldRate.html

}
done

mail -a "Content-type: text/html" -s "Gold Rate Today in Bangalore" $mailId < ~/saran/gold/goldRate.html
