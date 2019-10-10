#!/bin/bash

docker stop $(docker ps -a | grep QA | cut -d" " -f1)
docker rm $(docker ps -a | grep QA | cut -d" " -f1)
