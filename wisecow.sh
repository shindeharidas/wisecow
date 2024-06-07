FROM python:3.9

WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 4499
CMD ["./start.sh"]




//Kubernetes Deployment

apiVersion: apps/v1
kind: Deployment
metadata:
  name: wisecow-deployment
  labels:
    app: wisecow
spec:
  replicas: 1
  selector:
    matchLabels:
      app: wisecow
  template:
    metadata:
      labels:
        app: wisecow
    spec:
      containers:
      - name: wisecow
        image: your-docker-image:tag
        ports:
        - containerPort: 4499


apiVersion: v1
kind: Service
metadata:
  name: wisecow-service
spec:
  selector:
    app: wisecow
  ports:
    - protocol: TCP
      port: 4499
      targetPort: 4499
  type: LoadBalancer


//Continuous Integration and Deployment (CI/CD)

name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Build Docker image
      run: |
        docker build -t your-docker-image:latest .
        docker login -u ${{ secrets.DOCKER_Hari}} -p ${{ secrets.DOCKER_Pass@123 }}
        docker push your-docker-image:latest

    - name: Deploy to Kubernetes
      run: kubectl apply -f kubernetes/
