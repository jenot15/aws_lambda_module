# aws_lambda_module

```hcl
module "lambda_function" {
  source = "./aws_lambda_module"
  code_bucket = "statebucketkjndfk"
  function_name = "hello-world"
  lambda_code_path = "${path.root}/aws_lambda_module/example"
  s3_key = "aws_lambda_module/example/hello-world.zip"
  handler       = "hello.handler"
  runtime       = "nodejs12.x"
  env_vars = var.env_vars
}


variable "env_vars" {
    type = map(string)
    default = {
        KEY = VALUE
    }
}
```