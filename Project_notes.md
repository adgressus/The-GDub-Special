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

#### 5/6
* Set up federated identies for console access using AWS SSO
    * Switch to federated identies for console access
    * AWS cognito for SSO, and then assume roles using a federated identity??
    * https://alsmola.medium.com/identity-federation-with-multiple-aws-accounts-61065d00e461
    * https://github.com/salrashid123/gcpcompat-aws
    * https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html
    * https://archive.ph/npvoW
    * https://github.com/common-fate/granted
    * AWS SSO’s identity store
        * Identity Center directory
    * https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-sso.html
    * [Create Permission Set](https://docs.aws.amazon.com/singlesignon/latest/userguide/get-started-create-an-administrative-permission-set.html)
       * SSO instance ID is required to create one
       * SSO instances are created automatically when you enable IAM Identity Center in the console
    * finals steps were:
       * enable IAM Identity Center in the region which creates an SSO instance
       * Create Permission Set for the instance
       * Attach managed policy to permission set
       * Manual create group so it lasts
       * Assign group and permission set to that instance

### ToDo:
* ~~Avoid pasting root IAM credentials~~
* Move SSO federation to a different repository for independent deployment
* Create status webpage that displays
* Move to spot instance on private subnet for cheaper compute
* Create ssh bastion autoscalling group for higher availablity
* Create cost monitoring so users can track spending