CHROMIUM_VERSION = 130.0.0
CHROMIUM_ZIP_FILE = chromium-v$(CHROMIUM_VERSION)-layer.zip

.PHONY: apply
apply: $(CHROMIUM_ZIP_FILE) .terraform
	./check_update.sh
	terraform apply

$(CHROMIUM_ZIP_FILE):
	curl -LO https://github.com/Sparticuz/chromium/releases/download/v$(CHROMIUM_VERSION)/$(CHROMIUM_ZIP_FILE)

.terraform:
	terraform init
