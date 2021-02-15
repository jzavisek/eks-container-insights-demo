SHELL	:= sh

# Default constants

aws_region ?= eu-central-1
tag ?= latest
ecr_url ?= 805382315593.dkr.ecr.$(aws_region).amazonaws.com/jz-demo-web

#  Docker commands

docker/login: force
	aws ecr get-login-password --region $(aws_region) | docker login --username AWS --password-stdin $(ecr_url)

docker/image/build: force
	docker build -t $(ecr_url):${tag} -f ./Dockerfile .

docker/image/push: force
	docker push $(ecr_url):${tag}

.PHONY: force
