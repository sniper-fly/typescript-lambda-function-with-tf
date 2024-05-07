locals {
  src_path       = "${path.module}/lambda"
  build_path     = "${local.src_path}/dist"
  package_path   = "${local.src_path}/index.zip"
  package_s3_key = "index.zip"
}
