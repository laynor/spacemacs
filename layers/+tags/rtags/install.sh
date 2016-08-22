SRCDIR=`mktemp -d`

cd SRCDIR
git clone --recursive https://github.com/Andersbakken/rtags.git
cd rtags
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$RTAGS_INSTALL_DIR -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DRTAGS_NO_BUILD_CLANG=1 ..

make clean all install
