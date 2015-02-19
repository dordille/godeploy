OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

.PHONY: all

all: clean format deps build

build:
	$(eval SHA := $(shell git rev-parse HEAD))
	@echo "$(OK_COLOR)==> Compiling binary$(NO_COLOR)"
	go build -ldflags "-X main.gitversion '$(SHA)'" -o bin/godeploy

archive:
	@echo "$(OK_COLOR)==> Building Tarball...$(NO_COLOR)"
	tar -cvzf dist/godeploy.tar.gz config/production.ini config/staging.ini bin/godeploy

upload:
	$(eval SHA := $(shell git rev-parse HEAD))
	$(eval BRANCH := $(shell git rev-parse --abbrev-ref HEAD))
	aws s3api put-object \
	--bucket godeploy \
	--key builds/godeploy_${SHA}.tar.gz \
	--body dist/godeploy.tar.gz  \
	--metadata branch=${BRANCH},sha=${SHA}

publish: all archive upload

clean:
	@rm -rf bin/

deps:
	@echo "$(OK_COLOR)==> Installing dependencies$(NO_COLOR)"
	@go get -d -v ./...
	@go list -f '{{range .TestImports}}{{.}} {{end}}' ./... | xargs -n1 go get -d

format:
	go fmt ./...

test:
	@go test -cover ./...
