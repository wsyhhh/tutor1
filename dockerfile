  
# Container image that runs your code
FROM python:3.6-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh jq && \
    apk add --update nodejs nodejs-npm

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
