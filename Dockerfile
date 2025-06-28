FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu20.04
ENV SHELL=/bin/bash
RUN apt-get -qq update && apt-get -qq -y install curl bzip2 git \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH
WORKDIR /workspace
RUN git clone https://github.com/VITA-Group/Q-GaLore.git
WORKDIR /workspace/Q-GaLore
RUN conda env create -f environment.yml
