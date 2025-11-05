#!/bin/bash

echo "Container is running!!!"
echo "Architecture: $(uname -m)"
echo "Python version: $(python --version)"
echo "UV version: $(uv --version)"

export GCS_BUCKET_NAME="ac215-homework2"
export GCP_PROJECT="ac215-homeworks" 
export GCP_ZONE="us-central1-a" 

gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
mkdir -p /mnt/gcs_bucket
gcsfuse --key-file=$GOOGLE_APPLICATION_CREDENTIALS $GCS_BUCKET_NAME /mnt/gcs_data
echo 'GCS bucket mounted at /mnt/gcs_data'
mkdir -p /app/cheese_dataset
mount --bind /mnt/gcs_data/images /app/cheese_dataset

# Activate virtual environment
echo "Activating virtual environment..."
source /.venv/bin/activate

# Keep a shell open
exec /bin/bash
