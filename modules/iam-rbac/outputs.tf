output "user_arns" {
  value = {
    for k, v in aws_iam_user.users :
    k => v.arn
  }
}


output "group_names" {
  value = keys(aws_iam_group.groups)
}

output "policy_arns" {
  value = {
    for k, v in aws_iam_policy.policies :
    k => v.arn
  }
}

output "role_arns" {
  value = {
    for k, v in aws_iam_role.roles :
    k => v.arn
  }
}