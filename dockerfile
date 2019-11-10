  
# Container image that runs your code
FROM python:3.6-alpine

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
