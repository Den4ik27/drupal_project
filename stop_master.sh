#!/bin/bash

docker stop $(docker ps -a | grep master | cut -d" " -f1)
docker rm $(docker ps -a | grep master | cut -d" " -f1)
