#https://stackoverflow.com/questions/58269375/how-to-install-packages-with-miniconda-in-dockerfile
FROM ubuntu:18.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

# cmake, build-essential, libboost-all-dev are FAST dependencies
RUN apt-get update && apt-get install -y \
  git \
  vim \
  wget \
  jq \
  cmake \
  build-essential \
  libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
#RUN conda --version

COPY environment.yml /
RUN conda env create -f environment.yml -n eq_fast \
    && conda clean -afy
RUN echo "source activate eq_fast" > ~/.bashrc

