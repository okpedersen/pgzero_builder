#!/bin/bash

# Miniconda installation
# Source: conda.pydata.org/docs/help/silent.html
MINICONDA_OPTIONS=" -b -p $HOME/miniconda"
MINICONDA_DOWNLOAD=''
MINICONDA_LOCAL=""
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    MINICONDA_LOCAL="./Miniconda3-latest-Linux-x86_64.sh"
    MINICONDA_DOWNLOAD='/usr/bin/wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # TODO: OSX
    echo "OSX not implemented"
else
    echo "Unsupported operating system"
    exit 1
fi
if [ ! -f $MINICONDA_LOCAL ]; then
    echo "Miniconda install script not found... Trying to download."
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        `$MINICONDA_DOWNLOAD`
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # TODO: OSX / curl
        echo "OSX not implemented"
    fi
    if [ ! -f ./miniconda.sh ]; then
        echo "Download failed"
	echo $MINICONDA_DOWNLOAD
        exit 1
    fi
    bash ./miniconda.sh ${MINICONDA_OPTIONS}
else
    bash `$MINICONDA_LOCAL` ${MINICONDA_OPTIONS}
fi
echo $'\n\nexport PATH="$HOME/miniconda/bin:$PATH"' >> $HOME/.bashrc
# End miniconda installation

# Install pgzero
CONDA_LOC=$HOME/miniconda/bin/conda
if [ -f ./*pgzero*.tar.bz2 ]; then
    $CONDA_LOC install ./*pgzero*.tar.bz2
else
    $CONDA_LOC install -c https://conda.binstar.org/okpedersen pgzero
fi
# End install pgzero
