#!/bin/bash

echo "Checking for Terraform state bucket ${AWS_TF_STATE_BUCKET}..."
aws s3api head-bucket --bucket ${AWS_TF_STATE_BUCKET}
head_bucket_response_code=$?
if [ $head_bucket_response_code -eq 0 ]
then
    echo "Terraform state bucket ${AWS_TF_STATE_BUCKET} found."
else
    echo "Terraform state bucket ${AWS_TF_STATE_BUCKET} not found, creating..."
    aws s3 mb s3://${AWS_TF_STATE_BUCKET}
    create_bucket_response_code=$?
    if [ $create_bucket_response_code -eq 0 ]
    then
        echo "Terraform state bucket ${AWS_TF_STATE_BUCKET} created successfully."
    else
        echo "Terraform state bucket ${AWS_TF_STATE_BUCKET} could not be created! Aborting."
        exit 1
    fi
fi
