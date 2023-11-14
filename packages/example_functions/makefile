.PHONY: clean

FUNCTION_TARGET = function
PORT = 8080

build:
	dart run build_runner build --delete-conflicting-outputs

build.docker: build
	docker build -t hello .

start: build
	dart run bin/server.dart --port=$(PORT) --target=$(FUNCTION_TARGET)

start.docker: build.docker
	docker rm -f app
	docker run -it -p 8080:8080 --name app hello
	# docker run -it -p $(PORT):$(PORT) --name app hello

test: clean build
	dart test

clean:
	dart run build_runner clean
	rm -rf bin/server.dart
