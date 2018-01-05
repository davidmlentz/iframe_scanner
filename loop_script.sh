#!/bin/bash

if [[ -e "pagesWithIframes.csv" ]]; then
	mv pagesWithIframes.csv pagesWithIframes$(date +%Y%m%d%H%M%s).csv
fi

echo "URL,class,title,src" > pagesWithIframes.csv

count=0
maxpages=3000

for site in sites/*; do
	sitestring=`echo $site | cut -d'/' -f2`
	teststring=`echo $sitestring | cut -d'_' -f1` # dirnames with underscores should be skipped
	if [[ $teststring == $sitestring ]]; # i.e. it does not have a _ in it
	then

	        URLcount=`cat $site | wc -l`
	        countafterthis=$((URLcount + count))
	        if [[ "$countafterthis" -gt "$maxpages" ]]; then
	                echo "count=$count"
	                echo "URLcount=$URLcount"
	                echo "countafterthis=$countafterthis"
	                break
	        fi

		echo $sitestring >> tempsitesscanned
		while read -r URL
		do
			count=$((count+1))
			./script.sh $URL
		done < sites/$sitestring
		rm sites/$sitestring
	fi
done

echo "pages scanned: $count"
echo "sites scanned:"
echo `cat tempsitesscanned`

if [[ -e "tempsitesscanned" ]]; then
	mv tempsitesscanned tempsitesscanned$(date +%Y%m%d%H%M%s)
fi
