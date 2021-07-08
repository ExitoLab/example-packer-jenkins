# Example Packer jenkins

This repository contains templates for building jenkins AMI on AWS.

The AMI installs the following softwares 
1. Jenkins 
2. Minikube 
3. Nagios 
4. Docker

## Files

| Folder | Description 
| --- | --- 
| `ami` | The directory where the packer template and var file reside.
| `packer.yaml` | The GitHub Actions for building packer AMI on AWS

## Usage 
1. Update your `vpc_id` and `subnet_id` in ami > variables.json file
2. Add the secrets using github secrets. Under your repository name, click Settings. In the left sidebar, click Secrets.
3. Add secrets AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for authenticating to AWS 
4. Run the GitHub Actions