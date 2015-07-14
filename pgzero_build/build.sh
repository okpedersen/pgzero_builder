# linux

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get build-dep python-pygame
    pip install git+https://github.com/okpedersen/pygame.git@master
    python setup.py install
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # TODO: OSX
    echo "OSX not implemented"
else
    echo "Unsupported operating system"
    exit 1
fi
