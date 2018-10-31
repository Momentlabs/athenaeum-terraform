# Install the ingress and cert manager copmonents into a cluster.
# also install a Let's Encrypt Issuer into the cluster to issue certs.

default: nginx-ingress prod-issuer

nginx-ingress:
	helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true

cert-manager:
	helm install --name cert-manager --namespace kube-system  stable/cert-manager

prod-issuer: cert-manager
	kubectl create -f CertManager/issuer-le-prodction.yaml
