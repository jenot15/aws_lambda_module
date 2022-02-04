


resource "aws_s3_bucket" "code_bucket" {
  count = var.code_bucket == "" ? 0 : 1

  bucket = var.code_bucket

}