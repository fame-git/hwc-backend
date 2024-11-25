#!/bin/bash

echo "====================="
echo "start migrate to remote"
echo "====================="

terraform init -migrate-state

echo "====================="
echo "migrate remote finish"
echo "====================="

echo "====================="
echo "Start Purge Local"
echo "====================="
rm -r ../local-state/network/*

echo "====================="
echo "Purge Local Done"
echo "====================="

