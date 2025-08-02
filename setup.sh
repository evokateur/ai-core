#!/bin/bash

if ! command -v pyenv >/dev/null; then
    echo "pyenv not found, exiting.."
    exit 1
fi

pyenv shell 3.11

PYTHON_VERSION=$(python --version 2>&1)
if ! echo "$PYTHON_VERSION" | grep -q "^Python 3\.11"; then
    echo "Setup requires python 3.11, exiting.."
    exit 1
fi

echo "[Re]creating virtual environment and installing dependencies.."
python -m venv llms --clear
source llms/bin/activate
pip install -r requirements.txt

echo "Installing Jupyter kernel spec for $(pwd)/llms.."
python -m ipykernel install --user --env VIRTUAL_ENV "$(pwd)/llms" --name=llm_engineering --display-name "LLM Engineering"

echo "Use kernel 'llm_engineering' in Jupyter notebooks."
