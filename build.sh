#!/bin/sh

for dir in $(find . -type f -name Dockerfile | xargs -n1 dirname); do
    echo "~~~ Building $dir ~~~";
    name="$(basename "$dir" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]' | tr -d -c '[:alnum:]')";
    docker build -t "${CI_REGISTRY_IMAGE}/${name}" "$dir" || echo "Error building $dir";
    docker push "${CI_REGISTRY_IMAGE}/${name}" || echo "Error pushing ${name}"
done
