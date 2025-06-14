name: Launch EC2 Instance

on:
  workflow_dispatch:  # allows manual triggering

permissions:
  id-token: write       # required for OIDC
  contents: read        # needed for repo access

jobs:
  launch-ec2:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repo
      uses: actions/checkout@v3

    - name: Configure AWS credentials via OIDC
      uses: aws-actions/configure-aws-credentials@v2
      with:
        role-to-assume: arn:aws:iam::721689331129:role/github-action
        role-session-name: github-action
        aws-region: us-east-1

    - name: Launch EC2 instance
      run: |
        echo "Launching EC2..."
        aws ec2 run-instances \
          --image-id ami-0c94855ba95c71c99 \
          --count 1 \
          --instance-type t2.micro \
          --key-name Jenkins \
          --security-groups default
