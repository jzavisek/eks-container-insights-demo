SHELL	:= sh

# Nginx ingress

apply-nginx:
	kubectl apply -f ./nginx-ingress/deploy.yaml

delete-nginx:
	kubectl delete -f ./nginx-ingress/deploy.yaml

# Web app

kustomize-web:
	kubectl kustomize ./app/overlays/dev

apply-web:
	kubectl apply -k ./app/overlays/dev

delete-web:
	kubectl delete -k ./app/overlays/dev
