resource "aws_iam_user" "users" {
  for_each = var.users

  name = each.key
  path = each.value.path

  tags = var.tags
}

resource "aws_iam_group" "groups" {
  for_each = var.groups

  name = each.key
}

locals {
  group_memberships = flatten([
    for group_name, group in var.groups : [
      for user in group.users : {
        group = group_name
        user  = user
      }
    ]
  ])
}

resource "aws_iam_user_group_membership" "membership" {

  for_each = {
    for membership in local.group_memberships :
    "${membership.user}-${membership.group}" => membership
  }

  user = each.value.user

  groups = [
    each.value.group
  ]
}

resource "aws_iam_policy" "policies" {
  for_each = var.policies

  name        = each.key
  description = each.value.description

  policy = each.value.document
}

resource "aws_iam_role" "roles" {
  for_each = var.roles

  name = each.key

  assume_role_policy = each.value.assume_role_policy

  tags = var.tags
}

locals {

  group_policy_pairs = flatten([
    for group, policies in var.group_policy_attachments : [
      for policy in policies : {
        group  = group
        policy = policy
      }
    ]
  ])
}

resource "aws_iam_group_policy_attachment" "attachments" {

  for_each = {
    for pair in local.group_policy_pairs :
    "${pair.group}-${pair.policy}" => pair
  }

  group = each.value.group

  policy_arn = aws_iam_policy.policies[
    each.value.policy
  ].arn
}

locals {

  role_policy_pairs = flatten([
    for role, policies in var.role_policy_attachments : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])
}
resource "aws_iam_role_policy_attachment" "attachments" {

  for_each = {
    for pair in local.role_policy_pairs :
    "${pair.role}-${pair.policy}" => pair
  }

  role = each.value.role

  policy_arn = aws_iam_policy.policies[
    each.value.policy
  ].arn
}

