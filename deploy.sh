docker build -t skaldat/multi-client:latest -t skaldat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skaldat/multi-worker:latest -t skaldat/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t skaldat/multi-server:latest -t skaldat/multi-server:$SHA -f ./server/Dockerfile ./server

docker push skaldat/multi-client:latest
docker push skaldat/multi-worker:latest
docker push skaldat/multi-server:latest

docker push skaldat/multi-client:$SHA
docker push skaldat/multi-worker:$SHA
docker push skaldat/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skaldat/multi-server:$SHA
kubectl set image deployments/client-deployment client=skaldat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skaldat/multi-worker:$SHA
