locals {
  bucket_permission_maps = {
    list_bucket = {
      actions   = ["s3:ListBucket*"]
      resources = ["bucket1", "bucket2"]
    },
    list_get_put_archive = {
      actions   = ["s3:ListBucket*", "s3:GetObject*", "s3:PutObject*"]
      resources = ["archive"]
    }
  }
}

data "aws_iam_policy_document" "policies" {
  for_each = local.bucket_permission_maps

  statement {
    effect = "Allow"
    resources = flatten([
      for bucket_name in each.value.resources : [
        "aws:arn:aws:s3:::${bucket_name}",
        "aws:arn:aws:s3:::${bucket_name}/*",
      ]
    ])
    actions = each.value.actions

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

output "policy_from_iam_policy_document" {
  value = [for policy in data.aws_iam_policy_document.policies : policy]
}
