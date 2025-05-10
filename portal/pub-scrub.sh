
# Deletes everything in ../pub

# Runs the publication pipeline


pushd ../pub

# List files that have not been replaced with updates, and use git rm to remove them
git ls-files --deleted -z | xargs -0 git rm
# Make a commit
git commit -m "Removing deleted files from repository"

echo "Okay to push now"

popd