#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Starting Single-Cell RNA-Seq Environment Setup ---"

# --- 1. Update system packages and install build essentials ---
echo "1. Updating system packages and installing build-essential..."
sudo apt-get update
sudo apt-get install -y build-essential dialog
echo "System packages updated and build-essential installed."

# --- 2. Create and activate a Python Virtual Environment ---
echo "2. Creating and activating Python virtual environment (.venv)..."
python3 -m venv .venv
source .venv/bin/activate
echo "Virtual environment activated. You should see '(.venv)' in your prompt."

# Ensure pip is up-to-date within the virtual environment
echo "3. Upgrading pip within the virtual environment..."
pip install --upgrade pip
echo "pip upgraded."

# --- 4. Install Core Single-Cell RNA-Seq Packages ---
echo "4. Installing core single-cell RNA-seq packages (scanpy, anndata, etc.)..."
# We specify a range for scanpy and anndata for better compatibility
# and include common dependencies for plotting, clustering, and integration.
pip install \
    "anndata>=0.10.0,<0.11" \
    "scanpy>=1.9.0,<1.10" \
    pandas \
    numpy \
    scipy \
    scikit-learn \
    matplotlib \
    seaborn \
    louvain \
    leidenalg \
    umap-learn \
    harmonypy \
    python-igraph \
    h5py \
    # Optional: If you plan to use scvi-tools, uncomment the line below.
    # Be aware that scvi-tools is a large package and might take a while.
    # scvi-tools

echo "Core single-cell RNA-seq packages installed."

# --- 5. Install and configure ipykernel for Jupyter Notebooks ---
echo "5. Installing ipykernel and registering it for Jupyter Notebooks..."
pip install ipykernel
python3 -m ipykernel install --user --name=.venv --display-name "Python (.venv) for scRNAseq"
echo "ipykernel configured. Your virtual environment is now available as a Jupyter kernel."

echo "--- Environment Setup Complete! ---"
echo ""
echo "NEXT STEPS:"
echo "1. For new terminal sessions, always run 'source .venv/bin/activate' to activate your environment."
echo "2. If you open a Jupyter Notebook (either in VS Code or Jupyter Lab), ensure you select the kernel named 'Python (.venv) for scRNAseq'."
echo "3. You can now proceed with merging your AnnData files and downstream analysis."
echo ""
echo "If you encounter any errors during this script, please copy the exact error message and share it."
