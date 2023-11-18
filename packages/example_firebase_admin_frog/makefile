dev:
	dart_frog dev

build.dart:
	dart_frog build

build.docker: build.dart
	docker-compose build
run.docker: build.docker
	docker-compose up frog

deploy: build.docker
	# # 初回で必要？
	# gcloud config set project template-dev-d032et
	# gcloud auth application-default login
	# gcloud artifacts repositories create helloworld --repository-format=docker --location=asia-northeast1 --project=template-dev-d032e
	# gcloud auth configure-docker asia-northeast1-docker.pkg.dev
	gcloud builds submit
