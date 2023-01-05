.PHONY: build push

build:
	docker build -t levidurfee/cgit:latest .

push:
	docker push levidurfee/cgit:latest
