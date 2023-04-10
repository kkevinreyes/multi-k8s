docker build -t krstncreyes/multi-client:latest -t krstncreyes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t krstncreyes/multi-server:latest -t krstncreyes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t krstncreyes/multi-worker:latest -t krstncreyes/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push krstncreyes/multi-client:latest
docker push krstncreyes/multi-server:latest
docker push krstncreyes/multi-worker:latest

docker push krstncreyes/multi-client:$SHA
docker push krstncreyes/multi-server:$SHA
docker push krstncreyes/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=krstncreyes/multi-server:$SHA
kubectl set image deployments/client-deployment client=krstncreyes/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=krstncreyes/multi-worker:$SHA
