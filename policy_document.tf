data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    resources = local.bucket_arns
    actions   = ["s3:ListBucket*"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}
