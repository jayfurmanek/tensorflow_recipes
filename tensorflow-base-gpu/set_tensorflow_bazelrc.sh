#!/bin/bash
set -ex
BAZEL_RC_DIR=$1
LIBCUDNN_PATH=$PREFIX/

cat > $BAZEL_RC_DIR/tensorflow.bazelrc << EOF
build --action_env PYTHON_BIN_PATH="$PYTHON"
build --action_env PYTHON_LIB_PATH="$SP_DIR"
build --python_path="$PYTHON"
build --action_env OMP_NUM_THREADS="1"
build:xla --define with_xla_support=false
build --config=xla
build --action_env TF_NEED_OPENCL_SYCL="0"
build --action_env TF_NEED_ROCM="0"
build --action_env TF_NEED_CUDA="1"
build --action_env CUDA_TOOLKIT_PATH="/usr/local/cuda"
build --action_env TF_CUDA_VERSION="10.1"
build --action_env CUDNN_INSTALL_PATH="/usr/lib64"
build --action_env TF_CUDNN_VERSION="7"
build --action_env TF_NCCL_VERSION=""
build --action_env TF_CUDA_COMPUTE_CAPABILITIES="3.5,7.0"
build --action_env TF_CUDA_CLANG="0"
build --action_env GCC_HOST_COMPILER_PATH="${CC}"
build --config=cuda
test --config=cuda
build:opt --copt=-mcpu=native
build:opt --define with_default_optimizations=true
EOF
