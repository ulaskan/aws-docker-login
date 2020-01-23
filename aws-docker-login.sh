#! /usr/bin/env bash
#
# This script:
# 1. retrieves a login to AWS;
# 2. automatically logs you in to AWS Container Registry;
# 3. and lists the available repositories in the registry.
#

if [ $# != 2 ]; then
    echo -e "\n\e[0;31mPlease input AWS PROFILE and AWS REGION in this format:\e\n"
    echo -e "\t\e[1;33m./$(basename "$0") default eu-central-1\e\n"
    exit 1
fi

### Variables:
AWS_PROFILE=$1
AWS_REGION=$2

aws ecr get-login --region $AWS_REGION --no-include-email --profile $AWS_PROFILE | . /dev/stdin

echo -e "\n\e[0;32mThese are the Available repositories in $AWS_PROFILE:\e\n"
aws ecr describe-repositories --region $AWS_REGION --profile $AWS_PROFILE --query 'repositories[*].repositoryName'


echo -e "\n\e[0;44mUse the following command to list the available images:\e\n"
echo -e "aws ecr list-images --repository-name <repository/image> --region $AWS_REGION --profile $AWS_PROFILE\n"
