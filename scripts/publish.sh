#!/bin/bash

##############################################
##      CONTINUOUS INTEGRATION SCRIPT
##############################################

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
# The -v flag makes the shell print all lines in the script before executing them, which helps identify which steps failed.
set -ev

# Do nothing if we are in a PR
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

repo_ssh="git@github.com:${TRAVIS_REPO_SLUG}.git"
repo_name=$(basename ${TRAVIS_REPO_SLUG})

# Configure ssh
openssl aes-256-cbc -K $encrypted_6dd81de13fcf_key -iv $encrypted_6dd81de13fcf_iv -in publish-key.enc -out ~/.ssh/publish-key -d
chmod 600 ~/.ssh/publish-key
eval `ssh-agent -s`
ssh-add ~/.ssh/publish-key

# testing ssh connection with github
# WARNING this makes the script exit just after
# ssh -T git@github.com

# preparing new generated site files for publication
git clone --branch=${PUB_BRANCH} ${repo_ssh}
cd $repo_name
pwd
echo "git email : ${GIT_EMAIL} - git name : ${GIT_NAME}"
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME

# delete existing files in publishing branch
# and replace them with last build
rsync -az --delete --exclude '.git*' ../_site/ .

# as we push already generated files, we don't need gh-pages
# to run jekyll. Creating an empty .nojekyll file
touch .nojekyll

# If there are no changes to the compiled out (e.g. this is a README update) then just exit.
if [ -z `git diff --exit-code` ]; then
    echo "No changes to the generated site; exiting."
    exit 0
fi

git add -A .
git commit -m "Generated Jekyll Site by Travis CI - ${TRAVIS_BUILD_NUMBER}"

git push $repo_ssh $PUB_BRANCH

echo "SUCCESS : Site published\n"
