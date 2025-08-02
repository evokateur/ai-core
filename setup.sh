#!/bin/bash

if command -v python3.11 >/dev/null 2>&1; then
    PYTHON=python3.11
else
    echo "Setup requires python 3.11, exiting.."
    exit 1
fi

echo "[Re]creating virtual environment and installing dependencies.."
$PYTHON -m venv llms --clear
source llms/bin/activate
pip install -r requirements.txt

echo "Installing Jupyter kernel spec for $(pwd)/llms.."
python -m ipykernel install --user --env VIRTUAL_ENV "$(pwd)/llms" --name=llm_engineering --display-name "LLM Engineering"

echo "Use kernel 'llm_engineering' in Jupyter notebooks."
