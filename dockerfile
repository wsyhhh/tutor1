  
# Container image that runs your code
FROM python:3.6-alpine

# install awscli and aws-sam-cli
RUN apk add --no-cache --virtual .build-deps gcc musl-dev python3-dev\
    && pip install cython awscli aws-sam-cli\
    && apk del .build-deps 

# install zip
RUN apk add zip

# install git openssh jp and git-subtree and npm
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh jq git-subtree && \
    apk add --update nodejs nodejs-npm

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
