#!/bin/bash
######################################################################################
#
#     PROGRAM       : pull-all.sh
#     DESCRIPTION   : This script will perform a "git pull" operation on the master
#                     branch for all local git repositories on a developer's machine.
#
#     CREATED BY    : Kevin Custer
#     CREATION DATE : 02-APR-2014
#
#     INSTRUCTIONS  : Change START_HERE to match the path to the folder containing
#                     your Git repositories.  Note the syntax of this path uses
#                     forward slashes.  Place this script on your machine (the path
#                     used for START_HERE is an ideal location), make sure the script
#                     is executable, and run it from the Git Bash command prompt.
#
######################################################################################

START_HERE="/c/git/";

cd $START_HERE;

echo -e "\nPulling down the latest work for $START_HERE\n";

for d in $(find . -maxdepth 1 -mindepth 1 -type d); do
	echo -e "$d";
	cd $d;

      # If master is not checked out, store the currently checked out branch
      # to return to it later
      CURRENT_BRANCH=$(git symbolic-ref HEAD | awk -F'/' '{print $3}')

      if [ "$CURRENT_BRANCH" != "master" ]; then
            git checkout master;
      fi

	git remote -v | grep fetch;
	git pull;

      # Return to the previously checked out branch
      if [ "$CURRENT_BRANCH" != "master" ]; then
            git checkout "$CURRENT_BRANCH";
      fi

	cd $START_HERE;
	echo -e "\n";
done

echo -e "\nAll local repositories have been updated.\n";
