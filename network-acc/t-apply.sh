#!/bin/bash

terraform init

echo "-----------"
echo "Finish INIT"
echo "-----------"

terraform apply -refresh=false

echo "------------"
echo "Applied Done"
echo "------------"