locals {
  src_path                = "${path.module}/lambda"
  build_path              = "${local.src_path}/dist"
  package_path            = "${local.src_path}/index.zip"
  package_s3_key          = "index.zip"
  chromium_zip            = "chromium-v130.0.0-layer.zip"
  chromium_layer_zip_path = "${path.module}/${local.chromium_zip}"
}
