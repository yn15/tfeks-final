test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || "echo AWS_REGION is not set && exit"
test -n "$ACCOUNT_ID" && echo ACCOUNT_ID is "$ACCOUNT_ID" || "echo ACCOUNT_ID is not set && exit"
#docker pull alexwhen/docker-2048
#docker tag docker-2048 aws_account_id.dkr.ecr.region.amazonaws.com/docker-2048


docker pull 2214yj/3-tier-application-frontend:nolb
docker pull 2214yj/3-tier-application-backend:nolb
docker pull mariadb:10.9

docker tag 2214yj/3-tier-application-backend:nolb $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/backend:nolb
docker tag 2214yj/3-tier-application-frontend:nolb $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/frontend:nolb
docker tag mariadb:10.9 $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/mariadb:10.9

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/backend:nolb

docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/frontend:nolb

docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/mariadb:10.9
