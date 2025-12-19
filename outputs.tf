# IAM周り

# ロール
output "ssm_role_id" {
    value = aws_iam_role.ssm_role.id
}
output "app_role_id" {
    value = aws_iam_role.app_role.id
}

# インスタンスプロファイル
output "ssm_instance_profile_id" {
    value = aws_iam_instance_profile.ssm_instance_profile.id
}
output "app_instance_profile_id" {
    value = aws_iam_instance_profile.app_instance_profile.id
}