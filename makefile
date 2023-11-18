start:
	docker-compose up --build


exec:
	docker exec -it dart_firebase_admin-frog-1 sh


deploy:
	# # いらないかも
	# gcloud config set project template-dev-d032et
	# gcloud auth application-default login
	# # 毎回はいらない
	# gcloud artifacts repositories create helloworld --repository-format=docker --location=asia-northeast1 --project=template-dev-d032e
	# gcloud auth configure-docker asia-northeast1-docker.pkg.dev
	gcloud builds submit
