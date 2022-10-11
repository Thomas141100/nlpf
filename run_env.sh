#!/bin/sh

cd frontend
docker build -t registry.cri.epita.fr/thomas.saury/nlpf/frontend .

cd ../backend
docker build -t registry.cri.epita.fr/thomas.saury/nlpf/backend .

cd ..
docker-compose up -d
