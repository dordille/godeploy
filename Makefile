OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

.PHONY: all

all: clean format deps build archive

build:
	$(eval SHA := $(shell git rev-parse HEAD))
	@echo "$(OK_COLOR)==> Compiling binary$(NO_COLOR)"
	go build -ldflags "-X main.gitversion '$(SHA)'" -o bin/godeploy

archive:
	@echo "$(OK_COLOR)==> Building Tarball...$(NO_COLOR)"
	tar -cvzf dist/godeploy.tar.gz config/production.ini config/staging.ini bin/godeploy

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