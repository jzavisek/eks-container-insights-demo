SHELL	:= sh

# Namespaces

apply-namespaces:
	kubectl apply -f ./namespaces/dev.yaml && \
	kubectl apply -f ./namespaces/prod.yaml

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

# Fluentd

apply-fluentd:
	kubectl apply -k ./fluentd/overlays/dev

delete-fluentd:
	kubectl delete -k ./fluentd/overlays/dev

# Container insights

kustomize-dev-container-insights: 
	kustomize build ./container-insights/overlays/dev

apply-dev-container-insights:
	kustomize build ./container-insights/overlays/dev | kubectl apply -f -

delete-dev-container-insights:
	kustomize build ./container-insights/overlays/dev | kubectl delete -f -
