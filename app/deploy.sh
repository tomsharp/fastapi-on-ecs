#!/bin/bash
echo "Logging in to ECR"
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

echo "Building image"
docker build --no-cache --platform=linux/amd64 -t $REGISTRY_NAME .

echo "Tagging image"
docker tag $REGISTRY_NAME:$TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REGISTRY_NAME:$TAG

echo "Pushing image to ECR"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REGISTRY_NAME:$TAG