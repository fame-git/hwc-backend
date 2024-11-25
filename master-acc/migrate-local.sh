#!/bin/bash

# Please Comment Remote Backend
# Uncomment the local backend

terraform init -migrate-state

echo "====================="
echo "migrate remote finish"
echo "====================="