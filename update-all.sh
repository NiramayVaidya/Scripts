# FIND_ASF="$(find -iname tnc -execdir ls -a {} \; -type d)"
# FIND_ASF="$(find -name tnc -type d)"
# echo "${FIND_ASF}"
find -name tnc -type d | while read -r line; do
	if echo "$line" | grep -v ".git";
	then
		cd $line
		# ls
		IS_GIT_REPO="$(git rev-parse --is-inside-work-tree)"
		if echo "$IS_GIT_REPO" | grep "true";
		then
			# git --work-tree=../ --gir-dir=../.git pull --commit
			git pull --commit
			git submodule foreach git checkout master
			git submodule foreach git pull
			# git submodule foreach git pull | while read -r subline; do
				# if echo "$subline" | grep "Stopping at";
				# then
					# echo "$subline"
					# DIR="$(echo "$subline" | grep -e "'.*'" | tr -d \')"
					# cd $DIR
					# ls
					# cd -
				# fi
			# done
			if [ -z "$(git status --porcelain)" ];
			then
				echo "nothing to commit, working directory clean"
			else
				git add .
				git commit -m "updated submodules"
				git push
			fi
		fi
		cd -
	fi
done

