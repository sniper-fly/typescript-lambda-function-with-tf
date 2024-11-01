# Deploy Playwright on Lambda and Chromium Layer, not Docker image with Terraform

## Usage
Enter `make` command on the root of the repo.

## Requirements
Able to exec:
- Terraform (and access AWS)
- make
- npm

## Want to Change Chromium Version?
Change `chromium_version` var value of `locals.tf` and `makefile`.
Also you can change `@sparticuz/chromium` version of package.json.

You can check available versions below.
https://github.com/Sparticuz/chromium/releases

Also check the version compatibility.
https://github.com/microsoft/playwright/releases
