1. docker build . -t anokhadocker/aspire-jenkins:1

2. docker run --name aspire-jenkins -d -p 8080:8080 anokhadocker/aspire-jenkins:1

3. docker push anokhadocker/aspire-jenkins:1  

4. kubectl apply -f jenkins.yaml

5. kubectl delete -f jenkins.yaml

6. minikube service jenkins