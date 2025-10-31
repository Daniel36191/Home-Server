#!/usr/bin/env bash

while true; do
    git fetch
    if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
        git pull
        sudonix
    fi
    sleep 30
done