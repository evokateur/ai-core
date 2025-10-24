#!/bin/bash

echo "Making sure you have the latest version of uv.."
uv self update

echo "Running uv sync to install dependencies.."
uv sync

echo "Installing Jupyter kernel spec for $(pwd)/.venv.."
python -m ipykernel install --user --env VIRTUAL_ENV $(pwd)/.venv --name=llm_engineering --display-name "LLM Engineering"
echo
echo "To launch Jupyter Lab in the uv environment:"
echo " uv run --with jupyter jupyter lab"
echo
echo "To launch nvim in the uv environment (for molten.nvim):"
echo " uv run nvim"
echo
echo "Select the 'llm_engineering' kernel when working with notebooks in the web UI or when running :MoltenInit"
