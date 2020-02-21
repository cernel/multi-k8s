docker build -t cernel/multi-client:latest -t cernel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cernel/multi-server:latest -t cernel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cernel/multi-worker:latest -t cernel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cernel/multi-client:latest
docker push cernel/multi-server:latest
docker push cernel/multi-worker:latest

docker push cernel/multi-client:$SHA
docker push cernel/multi-server:$SHA
docker push cernel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cernel/multi-server:$SHA
kubectl set image deployments/client-deployment client=cernel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cernel/multi-worker:$SHA