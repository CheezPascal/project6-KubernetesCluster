# project6-KubernetesCluster
Decided to make my Kubernetes cluster in AWS

Terraform Configuration for 4 Linux Servers

This Terraform configuration creates 4 Ubuntu Linux servers on AWS within the same subnet. The servers are accessible via SSH on port 22 and use the free tier of Ubuntu 20.04 LTS. Follow the steps below to deploy the infrastructure.

Prerequisites

Terraform Installed:

Install Terraform from the official website.

AWS Account:

Set up an AWS account.

Ensure you have the AWS CLI installed and configured with the appropriate credentials.

aws configure

Key Pair:

Create an AWS key pair or use an existing one. Ensure the private key (.pem file) is stored securely on your local machine.

Replace my-key in the Terraform configuration with your key pair name.

Configuration Overview

The configuration performs the following tasks:

Creates a VPC with a CIDR block of 10.0.0.0/16.

Sets up a public subnet with a CIDR block of 10.0.1.0/24.

Configures a security group to allow SSH (port 22) access from anywhere.

Launches 4 t2.micro instances using the Ubuntu 20.04 LTS AMI (free tier eligible).

Files

main.tf: Contains the Terraform configuration.

Steps to Deploy

Clone or Create the Configuration:
Save the Terraform configuration file (main.tf) in a directory on your local machine.

Initialize Terraform:
Open a terminal in the directory where main.tf is located and run:

terraform init

Validate the Configuration:
Ensure the configuration is error-free:

terraform validate

Apply the Configuration:
Deploy the resources to AWS:

terraform apply

Review the plan and type yes to confirm.

Output:
After the deployment, Terraform will output the public IP addresses of the 4 servers. Use these IPs to SSH into the instances.

Example:

ssh -i "/path/to/private-key.pem" ubuntu@<public-ip>

Clean Up

To destroy the resources and avoid incurring costs, run:

terraform destroy

Type yes to confirm the destruction of all resources.

Notes

Ensure your AWS credentials are properly configured before applying the configuration.

Replace the AMI ID in the configuration file (ami-0c02fb55956c7d316) if you are deploying to a region other than us-east-1. You can find the correct AMI ID for Ubuntu 20.04 LTS in your region on the Ubuntu AMI locator.

For security, consider restricting the SSH access CIDR block to your IP address instead of allowing access from anywhere (0.0.0.0/0).

Troubleshooting

Error: Invalid AWS Key Pair:
Ensure the key pair name in the configuration matches an existing key pair in your AWS account.

Permission Denied (SSH):
Verify that the correct private key is used when connecting to the servers and that it has appropriate permissions (chmod 400).