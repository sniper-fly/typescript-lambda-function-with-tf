resource "aws_lambda_function" "helloworld" {
  function_name = "typescript-sample-helloworld"

  s3_bucket = aws_s3_bucket.lambda_assets.bucket
  s3_key    = aws_s3_object.package.key

  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  handler          = "index.handler"

  role    = aws_iam_role.iam_for_lambda.arn
  runtime = "nodejs20.x"
  timeout = "10"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "role-for-sample-ts-lambda"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  ]
}

resource "null_resource" "lambda_build" {
  triggers = {
    code_diff = join("", [
      for file in fileset(local.src_path, "{*.ts, package*.json}")
      : filebase64("${local.src_path}/${file}")
    ])
  }

  provisioner "local-exec" {
    command = "cd ${local.src_path} && npm install"
  }
  provisioner "local-exec" {
    command = "cd ${local.src_path} && npm run build"
  }
}

resource "aws_s3_bucket" "lambda_assets" {}

resource "aws_s3_object" "package" {
  bucket = aws_s3_bucket.lambda_assets.bucket
  key    = local.package_s3_key
  source = data.archive_file.lambda_package.output_path
}

data "archive_file" "lambda_package" {
  depends_on = [null_resource.lambda_build]

  type        = "zip"
  source_dir  = local.build_path
  output_path = local.package_path
}
