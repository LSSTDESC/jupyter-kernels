FROM centos:7
MAINTAINER Heather Kelly <heather@slac.stanford.edu>

RUN yum update -y && \
    yum install -y bash \
    bison \
    blas \
    bzip2 \
    bzip2-devel \
    centos-release-scl \
    cmake \
    curl \
    flex \
    fontconfig \
    freetype-devel \
    gawk \
    gcc-c++ \
    gcc-gfortran \
    gettext \
    git \
    glib2-devel \
    java-1.8.0-openjdk \
    libcurl-devel \
    libffi-devel \
    libuuid-devel \
    libXext \
    libXrender \
    libXt-devel \
    make \
    mesa-libGL \
    ncurses-devel \
    openssl-devel \
    patch  \
    perl \
    perl-ExtUtils-MakeMaker \
    readline-devel \
    sed \
    tar \
    which \
    zlib-devel 
    
RUN yum install -y devtoolset-8
    
RUN yum clean -y all && \
    rm -rf /var/cache/yum && \
    groupadd -g 1000 -r lsst && useradd -u 1000 --no-log-init -m -r -g lsst lsst
    
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp /usr/local/ && \
    rm -rf /tmp/miniconda.sh && \
    conda install -y python=3 && \
    conda update conda && \
    conda clean --all --yes 
    
RUN source scl_source enable devtoolset-8 && \
    pip install astropy==3.2.3 && \
    pip install bokeh && \ 
    pip install camb  && \
    pip install https://github.com/yymao/FoFCatalogMatching/archive/v0.1.0.tar.gz && \
    pip install corner && \
    pip install dask && \
    pip install datashader && \
    pip install https://github.com/LSSTDESC/descqa/archive/v2.0.0-0.7.0.tar.gz && \
    pip install https://github.com/LSSTDESC/desc-dc2-dm-data/archive/v0.3.0.tar.gz && \
    pip install distributed && \
    pip install emcee && \
    pip install extinction && \
    pip install fastparquet && \
    pip install fast3tree && \
    pip install fits2hdf && \
    pip install fitsio && \
    pip install google-cloud-bigquery && \
    pip install healpy && \
    pip install https://bitbucket.org/yymao/helpers/get/v0.3.2.tar.gz && \
    pip install holoviews && \
    pip install ipykernel jupyter_console && \
    pip install ipympl && \
    pip install ipywidgets && \
    pip install markupsafe && \
    pip install matplotlib && \
    pip install nose && \
    pip install numpy && \
    pip install pandas && \
    pip install psycopg2-binary && \
    pip install pyarrow==0.13.0 && \
    export PYMSSQL_BUILD_WITH_BUNDLED_FREEETDS=1 && \
    pip install pymssql && \
    pip install pytest && \
    pip install pyyaml && \
    pip install scikit-image && \
    pip install scikit-learn && \
    pip install scipy && \
    pip install seaborn && \
    pip install git+https://github.com/msimet/Stile && \
    pip install tables && \
    pip install TreeCorr==4.0.8

RUN echo "Finish Installing fast3tree" && \
    /bin/bash -c 'source scl_source enable devtoolset-8; \
                 echo -e "from fast3tree.make_lib import make_lib\nmake_lib(3, True)\nmake_lib(3, False)\nmake_lib(2, True)\nmake_lib(2, False)" >> /tmp/install_fast3tree.py; \
                 python /tmp/install_fast3tree.py'

RUN echo "Installing CatalogMatcher" && \
    /bin/bash -c 'source scl_source enable devtoolset-8; \
                 git clone https://github.com/LSSTDESC/CatalogMatcher.git /tmp/CatalogMatcher; \
                 cd /tmp/CatalogMatcher; \
                 python setup.py install'

RUN echo "Installing GCR packages" && \
    /bin/bash -c 'source scl_source enable devtoolset-8; \
                  pip install GCR==0.8.8; \
                  pip install https://github.com/LSSTDESC/gcr-catalogs/archive/v0.14.5.tar.gz' 

ENV HDF5_USE_FILE_LOCKING FALSE
  
   #               conda install -y --no-update-dependencies swig; \
   #               setup fftw; \
   #               setup gsl; \
   #               pip install -c $LSST_STACK_DIR/require.txt pyccl==2.0.1; \
                  

