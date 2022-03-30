#!/bin/sh

ECR_REGISTRY=393364682658.dkr.ecr.ap-northeast-2.amazonaws.com
STAGE=stg
ECR_REPOSITORY=hello

aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 393364682658.dkr.ecr.ap-northeast-2.amazonaws.com
docker build --platform linux/amd64 -t $STAGE/$ECR_REPOSITORY .
docker tag stg/hello:latest $ECR_REGISTRY/$STAGE/$ECR_REPOSITORY:latest
docker push $ECR_REGISTRY/$STAGE/$ECR_REPOSITORY:latest
