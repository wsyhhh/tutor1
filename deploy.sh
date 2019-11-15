#!/bin/bash

# sam build
sam package --output-template-file \
    packaged.yaml --s3-bucket "${BUCKET_NAME}"
echo "${GIT_AUTHOR_NAME}.github.io/tutor1/"
sam  deploy --template-file packaged.yaml \
    --parameter-overrides "GIT_PAGE=${GIT_AUTHOR_NAME}.github.io/tutor1/"\
    --region us-east-1 --capabilities \
    CAPABILITY_IAM --stack-name samR4
    
