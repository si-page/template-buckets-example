locals {
  bucket_names = [
    "bucket1",
    "bucket2"
  ]

  bucket_arns = flatten([
    for bucket_name in local.bucket_names : [
      "aws:arn:aws:s3:::${bucket_name}",
      "aws:arn:aws:s3:::${bucket_name}/*",
    ]
  ])
}

output "policy" {
  value = templatefile(
    "example.json.tmpl",
    {
      bucket_arns_json = jsonencode(local.bucket_arns)
    }
  )
}
