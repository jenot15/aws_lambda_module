


resource "aws_s3_bucket" "code_bucket" {
  count = var.code_bucket ? 1 : 0

  bucket = var.code_bucket

}