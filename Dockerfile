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
    zlib-devel \
    devtoolset-8-gcc*
    
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
    pip install fitsio && \
    pip install google-cloud-bigquery && \
    pip install healpy && \
    pip install https://bitbucket.org/yymao/helpers/get/v0.3.2.tar.gz && \
    pip install holoviews && \
    pip install pyarrow==0.13.0 && \
    pip install ipykernel jupyter_console && \
    pip install ipympl && \
    pip install ipywidgets && \
    pip install markupsafe nose && \
    pip install scikit-image && \
    pip install seaborn && \
    pip install git+https://github.com/msimet/Stile && \
    pip install tables && \
    pip install TreeCorr==4.0.8


   #               pip install -c $LSST_STACK_DIR/require.txt fast3tree; \
   #               export PYMSSQL_BUILD_WITH_BUNDLED_FREEETDS=1; \
   #               pip install -c $LSST_STACK_DIR/require.txt pymssql; \
   #               pip install -c $LSST_STACK_DIR/require.txt psycopg2-binary; \
   #               conda install -y --no-update-dependencies swig; \
   #               setup fftw; \
   #               setup gsl; \
   #               pip install -c $LSST_STACK_DIR/require.txt pyccl==2.0.1; \
                  

