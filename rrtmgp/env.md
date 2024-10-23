# Conda environment

Briefly describes the installation of the Conda environment used in Notebooks.

Conda install:

```bash
$ wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
$ bash ./Miniforge3.sh -b -p "${HOME}/conda"
$ source ~/conda/bin/activate
```

Create new environment :

```bash
$ conda create -yn tf2 pip python=3.12 ipykernel
$ conda activate tf2
$ ipython kernel install --user --name tf2
$ conda env config vars set PYTHONNOUSERSITE=1 TF_CPP_MIN_LOG_LEVEL=3
$ conda deactivate && conda activate tf2
```

JupyterLab:

```bash
$ conda install jupyterlab jupyterlab_code_formatter black yapf
```

Cuda & others:

```bash
$ conda install -c nvidia cuda-nvcc cuda-nvrtc numba tbb netcdf4 pillow pandas xarray matplotlib seaborn scipy scikit-learn sympy hdf5 pydoe openpyxl time numpy=1 "cuda-version=12.4"
```

TensorFlow:

```bash
$ pip install --upgrade pip wheel nvidia-pyindex nvidia-tensorrt tensorflow[and-cuda] tensorflow-probability tf-keras split-folders
```

tensorrt bug workaround:

```bash
$ PYT=python3.12
$ BASE=$HOME/conda/envs/tf2/lib
$ LIS=10
$ LID=8.6.1
$ ln -s \
    $BASE/$PYT/site-packages/tensorrt_libs/libnvinfer.so.$LIS \
    $BASE/libnvinfer.so.$LID
$ ln -s \
    $BASE/$PYT/site-packages/tensorrt_libs/libnvinfer_plugin.so.$LIS \
    $BASE/libnvinfer_plugin.so.$LID
```

Conda env config:

```bash
$ conda env config vars set LD_LIBRARY_PATH="'$CONDA_PREFIX/lib:$CONDA_PREFIX/lib/python3.12/site-packages/nvidia/cudnn/lib:$CONDA_PREFIX/lib/python3.12/site-packages/tensorrt_libs'"  XLA_FLAGS="'--xla_gpu_cuda_data_dir=$CONDA_PREFIX/lib/'"
$ conda deactivate && conda activate tf2
```

Test

```bash
$ TF_CPP_MIN_LOG_LEVEL=0 python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU')); from tensorflow.python.client import device_lib; print(device_lib.list_local_devices())"
```

Jupyter config

```bash
$ nano ~/.local/share/jupyter/kernels/tf2/kernel.json
```

```json
,
"env": {
"LD_LIBRARY_PATH": "/home/x/conda/lib:/home/x/conda/envs/tf2/lib:/home/x/conda/envs/tf2/lib/python3.12/site-packages/nvidia/cudnn/lib:/home/x/conda/envs/tf2/lib/python3.12/site-packages/tensorrt_libs",
"XLA_FLAGS": "--xla_gpu_cuda_data_dir=/home/x/conda/envs/tf2/lib",
}
```

JupyterLab start

```bash
$ jupyter-lab --notebook-dir=/home/x/jlab
```

## Machine specs

- [Intel Xeon Processor E52680 v4](https://ark.intel.com/content/www/br/pt/ark/products/91754/intel-xeon-processor-e5-2680-v4-35m-cache-2-40-ghz.html) 14 cores 35 MB cache 2.40 GHz AVX2 Broadwell
- 128GB RAM 2x Samsung DDR4 2400 MT/s M386A8K40BM1-CRC
- MSI Geforce RTX 3050 VENTUS 2X 6GB OC
- NVME 1TB KINGSTON NV2 PCIE GEN X4 read/write 3500/2100 MB/s
- MB HUANANZHI X99-PD4 Intel P55/H55
- Kubuntu 22.04 LTS


