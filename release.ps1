docker build -t yourRegistry/repo:tag .
docker push yourRegistry/repo:tag
kubectl apply -f .\k8s
