#!/bin/bash

alias ll='ls -lAGF'
alias ost='open -a "Sublime Text 2" $1'

home=/Users/guest/
p=$home/Documents/Projects/
node=$p/node/
http=$p/node/node-http-server/
test=$p/test/
tests=$p/tests/
tools=$home/Documents/Tools/

function cc () {
    cd "$1" && ll
}

function cl () {
	lessc "$1.less" "$1.css" 
}

function js () {
	if [ "$1" = "-backbone"  ]; then
		# copy over template dir
		cp -rf $tools/backbone_app/* $PWD && 
		# copy over node http server template
		cp $tools/server.js $PWD &&
		curl -o js/libs/jquery-latest.min.js http://code.jquery.com/jquery-latest.min.js &&
		curl -o js/libs/underscore.min.js http://underscorejs.org/underscore-min.js &&
		curl -o js/libs/backbone.min.js http://backbonejs.org/backbone-min.js
	else 
		cp -rf $tools/html5_app/* $PWD && 
		cp $tools/server.js $PWD &&
		curl -o js/libs/jquery-latest.min.js http://code.jquery.com/jquery-latest.min.js 
	fi
}

function css () {
	# use the -bootstrap flag to setup bootstrap css and 
	if [ "$1" = "-bootstrap" ]; then
		# check for css directory dependencies
		# this is setup to my personal project structuring
		if [ !  -d css ]; then
			mkdir css 
		elif [ ! -d css/libs ]; then
			mkdir css/libs
		elif [ ! -f public/css/libs/bootstrap* ]; then	
			curl -O http://getbootstrap.com/2.3.2/assets/bootstrap.zip &&
			unzip bootstrap.zip &&
			# copy over the dependencies that need unzipping
			cp bootstrap/css/bootstrap.min.css css/libs/bootstrap.min.css &&
			cp bootstrap/css/bootstrap.css css/libs/bootstrap.css &&
			cp bootstrap/css/bootstrap-responsive.min.css css/libs/bootstrap-responsive.min.css &&
			cp bootstrap/css/bootstrap-responsive.css css/libs/bootstrap-responsive.css &&
			# cleanup
			rm -rf bootstrap &&
			rm bootstrap.zip
		fi
	else
		# basic css command
		if [ ! -d css ]; then
			mkdir css
		fi &&
		if [ ! -d css/main.css ]; then
			cp $tools/base.css css/main.css
		fi
	fi
}

function pub_setup () {
	# check for and setup dir dependencies
	if [ ! -d public ]; then
		mkdir public
	elif [ ! -d public/css ]; then
		mkdir public/css
	elif [ ! -d public/css/libs ]; then
		mkdir public/css/libs
	elif [ ! -d public/js ]; then
		mkdir public/js
	elif [ ! -d public/js/libs ]; then
		mkdir public/js/libs
	elif [ ! -d public/assets ]; then
		mkdir public/assets
	elif [ ! -d public/assets/img ]; then
		mkdir public/assets/img
	elif [ ! -f public/js/main.js ]; then
		touch public/js/main.js
	elif [ ! -f public/js/app.js ]; then
		touch public/js/app.js
	# copy over css and index.html templates
	elif [ ! -f public/css/main.css ]; then
		cp $tools/base.css public/css/main.css
	elif [ ! -f public/index.html ]; then
		cp $tools/base.html public/index.html
	# grab the latest libraries and unzip if necessary
	elif [ ! -f public/js/libs/jquery-latest.min.js  ]; then
		curl -o public/js/libs/jquery-latest.min.js http://code.jquery.com/jquery-latest.min.js
	elif [ ! -f public/css/libs/bootstrap* ]; then	
		curl -O http://getbootstrap.com/2.3.2/assets/bootstrap.zip &&
		unzip bootstrap.zip &&
		# copy over the dependencies that need unzipping
		cp bootstrap/css/bootstrap.min.css public/css/libs/bootstrap.min.css &&
		cp bootstrap/css/bootstrap.css public/css/libs/bootstrap.css &&
		cp bootstrap/css/bootstrap-responsive.min.css public/css/libs/bootstrap-responsive.min.css &&
		cp bootstrap/css/bootstrap-responsive.css public/css/libs/bootstrap-responsive.css &&
		cp bootstrap/img/glyphicons-halflings.png public/assets/img/glyphicons-halflings.png &&
		cp bootstrap/img/glyphicons-halflings-white.png public/assets/img/glyphicons-halflings-white.png &&
		# cleanup
		rm -rf bootstrap &&
		rm bootstrap.zip
	fi
}

function glyphicon () {
	# check for img directory dependencies
	if [ ! -d assets ]; then
		mkdir assets
	elif [ ! -d assets/img ]; then
		mkdir assets/img
	fi && 
	curl -O http://getbootstrap.com/2.3.2/assets/bootstrap.zip &&
	unzip bootstrap.zip &&
	# copy the glyphicons
	cp bootstrap/img/glyphicons-halflings.png assets/img/glyphicons-halflings.png &&
	cp bootstrap/img/glyphicons-halflings-white.png assets/img/glyphicons-halflings-white.png &&
	# cleanup
	rm -rf bootstrap &&
	rm bootstrap.zip
}

# Adds Color to terminal
export CLICOLOR=1

# Node and NPM
export PATH="/usr/local/share/npm/bin:$PATH"

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add Depot Tools to the path
export PATH="$PATH:$tools/depot_tools"
