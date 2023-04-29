#### 4/29
* Avoid pasting root IAM credentials
    * [backlog] IAM Identity Center w/SSO provider 
        * User logs into sso provider, which then make the correct credentials available to the terraform aws provider 
        * (pasting environmental variables for now)
    * What's the terraform aws provider credential process
        * https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration
* Basic account infrastructure:
    * ~~1 VPC, 1 public, 1 private subnet~~
    * ~~1 internet gateway, 1 NAT gateway~~
    * ~~key infrastructure~~
    * ~~bastion instance~~
    * ~~1 beefy ec2 instance~~

### ToDo:
* Avoid pasting root IAM credentials
* Move to spot instance on private subnet for cheaper compute
* Create ssh bastion autoscalling group for higher availablity
* Create cost monitoring so users can track spending