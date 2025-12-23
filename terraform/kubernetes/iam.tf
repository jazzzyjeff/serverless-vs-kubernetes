resource "aws_identitystore_user" "default" {
  identity_store_id = local.sso_instance_id

  display_name = var.service
  user_name    = var.service

  name {
    given_name  = var.service
    family_name = var.service
  }
}

resource "aws_identitystore_group" "default" {
  display_name      = var.service
  description       = var.service
  identity_store_id = local.sso_instance_id
}

resource "aws_identitystore_group_membership" "default" {
  identity_store_id = local.sso_instance_id
  group_id          = aws_identitystore_group.default.group_id
  member_id         = aws_identitystore_user.default.user_id
}

module "argocd" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role"

  name            = "AmazonEKSCapabilityArgoCDRole"
  use_name_prefix = false

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
        "sts:TagSession",
      ]
      principals = [{
        type = "Service"
        identifiers = [
          "capabilities.eks.amazonaws.com"
        ]
      }]
    }
  }

  policies = {
    AWSSecretsManagerClientReadOnlyAccess = "arn:aws:iam::aws:policy/AWSSecretsManagerClientReadOnlyAccess"
  }

  tags = local.default_tags
}
