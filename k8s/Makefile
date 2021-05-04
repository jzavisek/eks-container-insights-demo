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
	kustomize build ./app/overlays/dev

apply-web:
	kustomize build ./app/overlays/dev | kubectl apply -f -

delete-web:
	kustomize build ./app/overlays/dev | kubectl delete -f -

# Fluentd

apply-fluentd:
	kustomize build ./fluentd/overlays/dev | kubectl apply -f - 

delete-fluentd:
	kustomize build ./fluentd/overlays/dev | kubectl delete -f -

# Container insights

kustomize-dev-container-insights: 
	kustomize build ./container-insights/overlays/dev

apply-dev-container-insights:
	kustomize build ./container-insights/overlays/dev | kubectl apply -f -

delete-dev-container-insights:
	kustomize build ./container-insights/overlays/dev | kubectl delete -f -
