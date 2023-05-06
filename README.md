# The GDub Special

### Goals:
* Provide structure and instructions for user to go from a new AWS account to a fresh ec2 instance they can access for ML experimentation
* must use best practices
* must be easy for user to access the ec2 instance

### MacOs Setup:
* Install brew if needed:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
* Install git if needed:
```
brew install git
```
* Install terraform if needed
```
brew install terrafrom
```
* Download this project into a project directory
```
git clone https://github.com/adgressus/The-GDub-Special.git
```
* Initalize a terraform project:
```
terrafrom init
```
* Paste your aws key into your terminal:
```
export AWS_ACCESS_KEY_ID=<your access key here>
export AWS_SECRET_ACCESS_KEY=<your secret key here>
export AWS_SESSION_TOKEN=<optional, your session token here>
```
* Build AWS infrastructure in your account:
```
terraform apply
```
* Respond with `yes` to any prompts
* Access your ec2 instance:
```
ssh-add ./$(terraform output -raw public_key); ssh -A -J ec2-user@$(terraform output -raw bastion_dns) ec2-user@$(terraform output -raw instance_dns)
```
* You'll need to approve ssh connections to new hosts with `yes`

### Cleaning up
* To insure you're not being charged for resources you're not using, you can delete everything in the project with:
```
`ssh-add -D; rm ./$(terraform output -raw public_key); terraform destroy
````
* Confirm you want to permanently delete these resources with `yes` when prompted


### Making changes
If you want to deploy different types of ec2 instances play with, make changes in the ec2.tf file