FROM ubuntu:latest
RUN cat /etc/os-release
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --yes -y --no-install-recommends dirmngr apt-transport-https ca-certificates software-properties-common gnupg2 \
    build-essential curl git \ 
    g++ gcc gfortran make autoconf automake libtool \
    zlib1g-dev liblzma-dev libbz2-dev lbzip2 libgsl-dev \
    libblas-dev libx11-dev \
    libreadline-dev libxt-dev libpcre2-dev libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*
ENV NB_USER container_user
# RUN apt-get install wget
ENV HOME /home/${NB_USER}
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
# RUN which R && R --version
RUN apt-get install wget
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && chmod +x  /tmp/miniconda.sh && bash /tmp/miniconda.sh -b -p ${HOME}/conda
# RUN bash Miniconda3-latest-Linux-x86_64.sh
ENV PATH ${HOME}/conda/bin:$PATH

# set up the user directory structure
RUN mkdir ${HOME}/tmp2 && \
    mkdir ${HOME}/analysis
    
WORKDIR ${HOME}

# COPY environment.yml ${HOME}/environment.yml
RUN git clone https://github.com/uzh-dqbm-cmi/PRIDICT.git
RUN ls -lh ${HOME}
COPY enviroment.yml ${HOME}/PRIDICT/enviroment.yml
RUN cd PRIDICT && conda env create -f pridict_linux.yml
RUN cd PRIDICT && conda config --set always_yes yes --set changeps1 no && \
        conda env update -v --file enviroment.yml
    
SHELL ["conda", "run", "-n", "pridict", "/bin/bash", "-c"]
RUN conda install conda-forge::tensorflow
# 
RUN echo '24 feb build' > ${HOME}/test.tmp
SHELL ["/bin/bash", "--login", "-c"]
COPY entrypoint.sh ${HOME}/
RUN ls ${HOME}/
RUN chmod +x "${HOME}/entrypoint.sh"
# ENTRYPOINT ["/home/container_user/entrypoint.sh"]
RUN mv /etc/bash.bashrc /etc/bash.bashrc_old
COPY .bashrc /home/container_user/
RUN echo "conda activate pridict" >> ~/.bashrc
RUN cp /home/container_user/.bashrc /etc/bash.bashrc
RUN apt update && apt install --yes libgconf-2-4
RUN apt install libcurl4-gnutls-dev --yes
RUN which pip
SHELL ["conda", "run", "-n", "pridict", "/bin/bash", "-c"]
RUN pip install tensorflow --upgrade --force-reinstall
RUN chmod +x ${HOME}/PRIDICT/pridict_pegRNA_design.py
RUN echo '#!/usr/bin/env python' > /home/container_user/PRIDICT/pridict_pegRNA_design2.py
RUN echo -e '\n' >> /home/container_user/PRIDICT/pridict_pegRNA_design2.py
RUN cat /home/container_user/PRIDICT/pridict_pegRNA_design.py >> /home/container_user/PRIDICT/pridict_pegRNA_design2.py
RUN rm /home/container_user/PRIDICT/pridict_pegRNA_design.py
RUN mv /home/container_user/PRIDICT/pridict_pegRNA_design2.py /home/container_user/PRIDICT/pridict_pegRNA_design.py
RUN head /home/container_user/PRIDICT/pridict_pegRNA_design.py
RUN chmod +x /home/container_user/PRIDICT/pridict_pegRNA_design.py
# RUN echo -e "\nalias pridict='/home/container_user/PRIDICT/pridict_pegRNA_design.py'" >> /etc/bash.bashrc
RUN ln -s /home/container_user/PRIDICT/pridict_pegRNA_design.py /usr/bin/pridict
RUN cat /etc/bash.bashrc
ENTRYPOINT ["/bin/bash", "-c","bash","/home/container_user/entrypoint.sh"]
CMD ["/bin/bash", "-c","bash","/home/container_user/entrypoint.sh"]