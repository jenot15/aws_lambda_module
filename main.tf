


resource "aws_s3_bucket" "code_bucket" {
  count = var.code_bucket == "" ? 0 : 1

  bucket = var.code_bucket

}


resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


data "archive_file" "lambda_files" {
  type = "zip"

  source_dir  = "${var.lambda_code_path}/${var.function_name}"
  output_path = "${var.lambda_code_path}/${var.function_name}.zip"
}

resource "aws_s3_bucket_object" "lambda_files" {
  bucket = aws_s3_bucket.code_bucket[0].id

  key    = "${var.lambda_code_path}/${var.function_name}.zip"
  source = data.archive_file.lambda_files.output_path

  etag = filemd5(data.archive_file.lambda_files.output_path)
}



resource "aws_lambda_function" "function" {
  function_name = var.function_name
  s3_bucket = aws_s3_bucket.code_bucket[0].id
  s3_key    = var.s3_key

  runtime = var.runtime
  handler = var.handler

  source_code_hash = data.archive_file.lambda_files.output_base64sha256

  role = aws_iam_role.lambda_exec.arn

  dynamic "environment" {
      for_each = length(keys(var.env_vars)) == 0 ? [] : [true]
      content {
          variables = var.env_vars
      }
  }
}
