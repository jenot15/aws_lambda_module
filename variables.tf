

variable "code_bucket" {
  description = "s3 bucket for code"

}

variable "function_name" {
  description = "Function name"

}

variable "lambda_code_path" {
  description = "lambda_code_path"

}

variable "runtime" {
  description = "Runtime"

}

variable "handler" {
  description = "Function handler"

}

variable "s3_key" {


}

output "function_arn" {
    value = aws_lambda_function.function.arn
}

