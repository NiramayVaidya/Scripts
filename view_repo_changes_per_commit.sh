mapfile -t commitIDs < <( git log --oneline | awk '{ print $1 }' )
numCommits=$(git log --oneline | awk '{ print $1 }' | wc -l)

git show --name-status ${commitIDs[0]} > stored_repo_changes_per_commit.txt
echo "" >> stored_repo_changes_per_commit.txt

for i in $(seq 1 1 $(expr $numCommits - 2))
do
	git show --name-status ${commitIDs[i]} >> stored_repo_changes_per_commit.txt
	echo "" >> stored_repo_changes_per_commit.txt
done

git show --name-status ${commitIDs[$(expr $numCommits - 1)]} >> stored_repo_changes_per_commit.txt

cat stored_repo_changes_per_commit.txt
