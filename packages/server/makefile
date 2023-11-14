.PHONY: clean

FUNCTION_TARGET = function
PORT = 8080

build:
	dart run build_runner build --delete-conflicting-outputs

build.docker: build
	docker build -t hello .

test: clean build
	dart test

clean:
	dart run build_runner clean
	rm -rf bin/server.dart

run: build
	dart run bin/server.dart --port=$(PORT) --target=$(FUNCTION_TARGET)
