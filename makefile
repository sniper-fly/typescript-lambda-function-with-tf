.PHONY: apply
apply: chromium-v130.0.0-layer.zip
	./check_update.sh
	terraform apply

chromium-v130.0.0-layer.zip:
	curl -LO https://github.com/Sparticuz/chromium/releases/download/v130.0.0/chromium-v130.0.0-layer.zip
