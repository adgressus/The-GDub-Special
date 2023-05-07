# sso instances are created when IAM identity center is enabled in the console 
# for the region. Haven't found a way to automate their creation yet
data "aws_ssoadmin_instances" "myidentitystore" {} # gathers data on existing sso identity stores

# We could define an identity store group resource instead of a data source, but
# I don't want to be recreating these groups a bunch as I test. 
data "aws_identitystore_group" "myusergroup" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.myidentitystore.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "GDub user"
    }
  }
}

resource "aws_ssoadmin_permission_set" "myadminpermssions" {
  name = "Admin"
  description = "Admin access permission set"
  instance_arn     = tolist(data.aws_ssoadmin_instances.myidentitystore.arns)[0]
  session_duration = "PT4H" # ISO-8601 time standard, 4 hour interval

  tags = var.default_tags
}

resource "aws_ssoadmin_managed_policy_attachment" "mymanagedadminpolicy" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.myidentitystore.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.myadminpermssions.arn
}

resource "aws_ssoadmin_account_assignment" "myaccountassignment" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.myidentitystore.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.myadminpermssions.arn

  principal_id   = data.aws_identitystore_group.myusergroup.group_id
  principal_type = "GROUP"

  target_id   = "938794095544"
  target_type = "AWS_ACCOUNT"
}