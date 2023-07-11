#!/bin/bash
WORKINGDIR="/var/www/"
# Site to clone, can be production-site or demo-site
SITE="production-site"

function main {
	echo "Updating status page..."
	cd "$WORKINGDIR"
	if [[ ! -d "$WORKINGDIR/$SITE" ]]; then
		install
	fi
	updateAndBuild
	updateLink
	cd -
	echo "Should be updated, exiting..."
	exit 0
}

function install {
	echo "Installing site from Github"
	git clone --recursive "https://github.com/myDid-Status/$SITE"
	if [[ ! $? -eq 0 ]]; then
		error "Cannot update from Github... :("
	fi
}

function updateAndBuild {
	cd "$SITE"
	git pull
	if [[ ! $? -eq 0 ]]; then
		error "Cannot update from Github... :("
	fi
	hugo
	if [[ ! $? -eq 0 ]]; then
		error "Hugo failed... :("
	fi
	cd -
}

function updateLink {
	rm "$WORKINGDIR/web-active"
	ln -s "$WORKINGDIR/$SITE/public" "$WORKINGDIR/web-active"
}

function error {
	echo $1
	exit 1
}

main $@
