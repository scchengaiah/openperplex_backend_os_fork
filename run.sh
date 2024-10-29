#!/bin/bash

ENV_NAME="open-perplex"
REQUIREMENTS_FILE="requirements.txt"
APP_COMMAND="uvicorn main:app --port 8000"

# Function to handle termination
function cleanup {
    echo "Terminating script..."
    exit 0
}

# Trap ctrl-c and call cleanup
trap cleanup SIGINT

# Check if the conda environment exists
if conda info --envs | grep -q "$ENV_NAME"; then
    echo "Conda environment '$ENV_NAME' already exists."
else
    echo "Creating conda environment '$ENV_NAME'."
    conda create -n "$ENV_NAME" python=3.11 -y
fi

# Activate the conda environment
source activate "$ENV_NAME"

# Install requirements
pip install -r "$REQUIREMENTS_FILE"

# Launch the app
$APP_COMMAND
