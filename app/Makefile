
# Default constants
aws_region ?= eu-central-1
tag ?= latest

docker/login:
	aws ecr get-login-password --region $(aws_region) | docker login --username AWS --password-stdin $(ecr_url)

docker/image/build:
	docker build -t $(ecr_url):${tag} -f ./Dockerfile .

docker/image/push:
	docker push $(ecr_url):${tag}
