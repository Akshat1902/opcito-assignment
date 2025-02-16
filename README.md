This repo is for opcito assignment  
To test run a curl command in for loop
```
 for i in {1..20}; do curl -s -H "Host: opcito-assignment.com" http://$(minikube ip)/; echo; done
```
