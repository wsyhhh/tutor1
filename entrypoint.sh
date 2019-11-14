#!/bin/sh -l

set -e

if [ -z "$ACCESS_TOKEN" ] && [ -z "$GITHUB_TOKEN" ]
then
  echo "You must provide the action with either a Personal Access Token or the GitHub Token secret in order to deploy."
  exit 1
fi

if [ -z "$BRANCH" ]
then
  echo "You must provide the action with a branch name it should deploy to, for example gh-pages or docs."
  exit 1
fi

if [ -z "$FOLDER" ]
then
  echo "You must provide the action with the folder name in the repository where your compiled page lives."
  exit 1
fi

case "$FOLDER" in /*|./*)
  echo "The deployment folder cannot be prefixed with '/' or './'. Instead reference the folder name directly."
  exit 1
esac

# Installs Git and jq.
# apt-get update && \
# apt-get install -y git && \
# apt-get install -y jq && \

# Gets the commit email/name if it exists in the push event payload.
COMMIT_EMAIL=`jq '.pusher.email' ${GITHUB_EVENT_PATH}`
COMMIT_NAME=`jq '.pusher.name' ${GITHUB_EVENT_PATH}`

# If the commit email/name is not found in the event payload then it falls back to the actor.
if [ -z "$COMMIT_EMAIL" ]
then
  COMMIT_EMAIL="${GITHUB_ACTOR:-github-pages-deploy-action}@users.noreply.github.com"
fi

if [ -z "$COMMIT_NAME" ]
then
  COMMIT_NAME="${GITHUB_ACTOR:-GitHub Pages Deploy Action}"
fi

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE && \

# Configures Git.
git init && \
git config --global user.email "${COMMIT_EMAIL}" && \
git config --global user.name "${COMMIT_NAME}" && \

## Initializes the repository path using the access token.
REPOSITORY_PATH="https://${ACCESS_TOKEN:-"x-access-token:$GITHUB_TOKEN"}@github.com/${GITHUB_REPOSITORY}.git" && \

# Checks to see if the remote exists prior to deploying.
# If the branch doesn't exist it gets created here as an orphan.
if [ "$(git ls-remote --heads "$REPOSITORY_PATH" "$BRANCH" | wc -l)" -eq 0 ];
then
  echo "Creating remote branch ${BRANCH} as it doesn't exist..."
  git checkout "${BASE_BRANCH:-master}" && \
  git checkout --orphan $BRANCH && \
  git rm -rf . && \
  touch README.md && \
  git add README.md && \
  git commit -m "Initial ${BRANCH} commit" && \
  git push $REPOSITORY_PATH $BRANCH
fi

# Checks out the base branch to begin the deploy process.
git checkout "${BASE_BRANCH:-master}" && \

# Builds the project if a build script is provided.
echo "Running build scripts... $BUILD_SCRIPT" && \
eval "$BUILD_SCRIPT" && \

if [ "$CNAME" ]; then
  echo "Generating a CNAME file in in the $FOLDER directory..."
  echo $CNAME > $FOLDER/CNAME
fi

# Commits the data to Github.
echo "Deploying to GitHub..." && \

git add -f $FOLDER && \
git commit -m "Deploying to ${BRANCH} from ${BASE_BRANCH:-master} ${GITHUB_SHA}" --quiet && \
git push $REPOSITORY_PATH `git subtree split --prefix $FOLDER ${BASE_BRANCH:-master}`:$BRANCH --force && \


echo "Deployment succesful!"

# start deploying to aws

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
export APINAME="$LAMBDA_FUNC_NAME-API"

rm -f lambda-deploy.zip
zip -r ./lambda-deploy.zip ./lambda/*
pwd
ls -ls .

if sh deploy.sh
    then 
        exit 0
    else
        exit 1
fi
    
exit 0
