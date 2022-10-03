#!/bin/sh

cd frontend
docker build -t nlpf_frontend .

cd ../backend
docker build -t nlpf_backend .

cd ..
docker-compose up -d