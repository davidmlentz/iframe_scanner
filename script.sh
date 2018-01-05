#!/bin/bash

URL=$1

	sleep 2 
	echo "testing $URL..."
	/usr/local/bin/wget -qO- $URL | grep '<iframe' > tempfile
        result=$?

        if [[ $result -eq 0 ]]; then
		src=`sed 's/\(.*\)iframe\(.*\)src="\([^"]*\)".*/\3/' tempfile`

                grep 'feature=oembed' tempfile > /dev/null
                isOembed=$?
                grep 'player.vimeo.com' tempfile > /dev/null
                isVimeo=$?
                grep 'soundcloud.com' tempfile > /dev/null
                isSoundcloud=$?

		grep 'class=' tempfile > /dev/null
		hasClass=$?
		if [[ $hasClass -eq 0 ]]; then
			class=`sed 's/\(.*\)iframe\([^>]*\)class="\([^"]*\)".*/\3/' tempfile`
		else
			class=' '
		fi
		grep 'title=' tempfile > /dev/null
		hasTitle=$?
		if [[ $hasTitle -eq 0 ]]; then
			title=`sed 's/\(.*\)iframe\(.*\)title="\([^"]*\)".*/\3/' tempfile`
		else
			title=' '
		fi

		if [[ "$class" != *"hoops"* ]] && # if class=hoops, it's an S&S shortcode--OK.
			[[ "$class" != "gde-frame" ]] && # Google Doc Embedder--OK.
			[[ "$class" != "wp-embedded-content" ]] && # oEmbed from another WP site--OK.
			[[ "$src" != *"googletagmanager.com"* ]] && # We're just ingoring these, for now.
			[[ $isOembed -ne 0 ]] && # It's a properly embedded youtube vid--OK.
                        [[ $isVimeo -ne 0 ]] && # All these media types are OK per webguide.
                        [[ $isSoundcloud -ne 0 ]]; # OK!

		then
			echo $URL,$class,$title,$src >> pagesWithIframes.csv
		fi
	fi
