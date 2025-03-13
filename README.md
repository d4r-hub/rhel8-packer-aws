rhel8-packer-aws

Overview

This project automates the creation of Red Hat Enterprise Linux (RHEL) 8 AMIs in AWS using Packer and GitLab CI/CD.

Features

Uses Red Hat UBI 8 as the base for a Docker image with Packer and AWS CLI installed.

Builds a RHEL 8 AWS AMI using Packer’s amazon-ebs builder.

Validates the Packer template before running the build.

Automates the pipeline using GitLab CI/CD.

Project Structure

.
├── Dockerfile          # Builds a container with Packer & AWS CLI (UBI 8)
├── packer.pkr.hcl      # Packer template for building the RHEL 8 AMI
├── .gitlab-ci.yml      # GitLab CI pipeline for validation & AMI creation
├── README.md           # Project documentation

Prerequisites

AWS Account with IAM permissions to create AMIs.

GitLab CI/CD with configured variables for AWS credentials.

Packer installed (if running locally).

Installation & Setup

1. Build Docker Image (Locally)

docker build -t rhel8-packer-aws .

2. Validate Packer Template

packer init packer.pkr.hcl
packer validate packer.pkr.hcl

3. Run Packer to Build the AMI

packer build packer.pkr.hcl

GitLab CI/CD Pipeline

The pipeline automates the validation and AMI creation process.

Stages

Validate - Ensures the Packer template is correct.

Build - Runs packer build to create the AMI.

Environment Variables Required

Set these in GitLab CI/CD > Settings > CI/CD > Variables:

Variable Name

Description

AWS_ACCESS_KEY_ID

Your AWS Access Key

AWS_SECRET_ACCESS_KEY

Your AWS Secret Key

AWS_REGION

AWS region to deploy in

Running the Pipeline

Every push validates the Packer template.

A push to main or a tag triggers the AMI build.

License

This project is open-source. Modify and use it as needed!


